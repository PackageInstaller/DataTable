return {
	Play1101102004 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1101102004
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1101102005(arg_1_1)
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
			local var_4_9 = 0.825

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_11 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1101102004).content)

				arg_1_1.text_.text = var_4_11

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_13 = 33 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 33)

				if (33 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 33)) > 0 and var_4_9 < var_4_13 then
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
	Play1101102005 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 1101102005
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play1101102006(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0.775

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(1101102005).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 33 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 33)

				if (33 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 33)) > 0 and var_10_0 < var_10_3 then
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
	Play1101102006 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 1101102006
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play1101102007(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0.675

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(1101102006).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 27 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 27)

				if (27 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 27)) > 0 and var_14_0 < var_14_3 then
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
	Play1101102007 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 1101102007
		arg_15_1.duration_ = 7

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play1101102008(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if arg_15_1.bgs_.ST12 == nil then
				local var_18_0 = Object.Instantiate(arg_15_1.paintGo_)

				var_18_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_18_0.name = "ST12"
				var_18_0.transform.parent = arg_15_1.stage_.transform
				var_18_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.bgs_.ST12 = var_18_0
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				local var_18_1 = arg_15_1.bgs_.ST12

				arg_15_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_18_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_18_2 = var_18_1:GetComponent("SpriteRenderer")

				if var_18_2 and var_18_2.sprite then
					local var_18_3 = 2 * (var_18_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_18_1.transform.localScale = Vector3.New(var_18_3 / var_18_2.sprite.bounds.size.y < var_18_3 * manager.ui.mainCameraCom_.aspect / var_18_2.sprite.bounds.size.x and var_18_3 * manager.ui.mainCameraCom_.aspect / var_18_2.sprite.bounds.size.x or var_18_3 / var_18_2.sprite.bounds.size.y, var_18_3 / var_18_2.sprite.bounds.size.y < var_18_3 * manager.ui.mainCameraCom_.aspect / var_18_2.sprite.bounds.size.x and var_18_3 * manager.ui.mainCameraCom_.aspect / var_18_2.sprite.bounds.size.x or var_18_3 / var_18_2.sprite.bounds.size.y, 0)
				end

				for iter_18_0, iter_18_1 in pairs(arg_15_1.bgs_) do
					if iter_18_0 ~= "ST12" then
						iter_18_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_18_4 = 0

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_4 + arg_18_0 then
				arg_15_1.mask_.enabled = true
				arg_15_1.mask_.raycastTarget = true

				arg_15_1:SetGaussion(false)
			end

			local var_18_5 = 2

			if var_18_4 <= arg_15_1.time_ and arg_15_1.time_ < var_18_4 + var_18_5 then
				local var_18_6 = Color.New(0, 0, 0)

				var_18_6.a = Mathf.Lerp(1, 0, (arg_15_1.time_ - var_18_4) / var_18_5)
				arg_15_1.mask_.color = var_18_6
			end

			if arg_15_1.time_ >= var_18_4 + var_18_5 and arg_15_1.time_ < var_18_4 + var_18_5 + arg_18_0 then
				local var_18_7 = Color.New(0, 0, 0)

				arg_15_1.mask_.enabled = false
				var_18_7.a = 0
				arg_15_1.mask_.color = var_18_7
			end

			if arg_15_1.frameCnt_ <= 1 then
				arg_15_1.dialog_:SetActive(false)
			end

			local var_18_8 = 2
			local var_18_9 = 0.675

			if 2 < arg_15_1.time_ and arg_15_1.time_ <= var_18_8 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0

				arg_15_1.dialog_:SetActive(true)

				arg_15_1.dialogCg_.alpha = 0

				local var_18_10 = LeanTween.value(arg_15_1.dialog_, 0, 1, 0.3)

				var_18_10:setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
					arg_15_1.dialogCg_.alpha = arg_19_0
				end))
				var_18_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_15_1.dialog_)
					var_18_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_15_1.duration_ = arg_15_1.duration_ + 0.3

				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_11 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(1101102007).content)

				arg_15_1.text_.text = var_18_11

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_13 = 27 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 27)

				if (27 <= 0 and var_18_9 or var_18_9 * (utf8.len(var_18_11) / 27)) > 0 and var_18_9 < var_18_13 then
					arg_15_1.talkMaxDuration = var_18_13
					var_18_8 = var_18_8 + 0.3

					if var_18_13 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_13 + var_18_8
					end
				end

				arg_15_1.text_.text = var_18_11
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_14 = var_18_8 + 0.3
			local var_18_15 = math.max(var_18_9, arg_15_1.talkMaxDuration)

			if var_18_8 + 0.3 <= arg_15_1.time_ and arg_15_1.time_ < var_18_14 + var_18_15 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_14) / var_18_15

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_14 + var_18_15 and arg_15_1.time_ < var_18_14 + var_18_15 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play1101102008 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1101102008
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1101102009(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.425

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(1101102008).content)

				arg_21_1.text_.text = var_24_1

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_3 = 17 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 17)

				if (17 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_1) / 17)) > 0 and var_24_0 < var_24_3 then
					arg_21_1.talkMaxDuration = var_24_3

					if var_24_3 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_3 + 0
					end
				end

				arg_21_1.text_.text = var_24_1
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_4 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_4

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1101102009 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1101102009
		arg_25_1.duration_ = 4.9

		local var_25_0 = {
			zh = 2.466,
			ja = 4.9
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
				arg_25_0:Play1101102010(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.2

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(1101102009)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 8 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 8)

				if (8 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 8)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102009", "story_v_side_new_1101102.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102009", "story_v_side_new_1101102.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_side_new_1101102", "1101102009", "story_v_side_new_1101102.awb")

						arg_25_1:RecordAudio("1101102009", var_28_6)
						arg_25_1:RecordAudio("1101102009", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102009", "story_v_side_new_1101102.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102009", "story_v_side_new_1101102.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1101102010 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1101102010
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1101102011(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_32_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_29_1.bgmTxt_.text ~= var_32_2 and arg_29_1.bgmTxt_.text ~= "" then
						if arg_29_1.bgmTxt2_.text ~= "" then
							arg_29_1.bgmTxt_.text = arg_29_1.bgmTxt2_.text
						end

						arg_29_1.bgmTxt2_.text = var_32_2

						arg_29_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_29_1.bgmTxt_.text = var_32_2
						arg_29_1.bgmTxt2_.text = var_32_2
					end

					if arg_29_1.bgmTimer then
						arg_29_1.bgmTimer:Stop()

						arg_29_1.bgmTimer = nil
					end

					if arg_29_1.settingData.show_music_name == 1 then
						arg_29_1.musicController:SetSelectedState("show")
						arg_29_1.musicAnimator_:Play("open", 0, 0)

						if arg_29_1.settingData.music_time ~= 0 then
							arg_29_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_29_1.settingData.music_time), function()
								if arg_29_1 == nil or isNil(arg_29_1.bgmTxt_) then
									return
								end

								arg_29_1.musicController:SetSelectedState("hide")
								arg_29_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.533333333333333 < arg_29_1.time_ and arg_29_1.time_ <= 0.533333333333333 + arg_32_0 then
				arg_29_1:AudioAction("play", "music", "bgm_side_daily06", "bgm_side_daily06", "bgm_side_daily06.awb")

				local var_32_5 = manager.audio:GetAudioName("bgm_side_daily06", "bgm_side_daily06")

				if "" ~= "" then
					if arg_29_1.bgmTxt_.text ~= var_32_5 and arg_29_1.bgmTxt_.text ~= "" then
						if arg_29_1.bgmTxt2_.text ~= "" then
							arg_29_1.bgmTxt_.text = arg_29_1.bgmTxt2_.text
						end

						arg_29_1.bgmTxt2_.text = var_32_5

						arg_29_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_29_1.bgmTxt_.text = var_32_5
						arg_29_1.bgmTxt2_.text = var_32_5
					end

					if arg_29_1.bgmTimer then
						arg_29_1.bgmTimer:Stop()

						arg_29_1.bgmTimer = nil
					end

					if arg_29_1.settingData.show_music_name == 1 then
						arg_29_1.musicController:SetSelectedState("show")
						arg_29_1.musicAnimator_:Play("open", 0, 0)

						if arg_29_1.settingData.music_time ~= 0 then
							arg_29_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_29_1.settingData.music_time), function()
								if arg_29_1 == nil or isNil(arg_29_1.bgmTxt_) then
									return
								end

								arg_29_1.musicController:SetSelectedState("hide")
								arg_29_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "warchess_general", "warchess_6000_land", "")
			end

			if 0.266666666666667 < arg_29_1.time_ and arg_29_1.time_ <= 0.266666666666667 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "warchess_general", "warchess_6000_land", "")
			end

			local var_32_8 = 0
			local var_32_9 = 0.925

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_10 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(1101102010).content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_12 = 37 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_10) / 37)

				if (37 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_10) / 37)) > 0 and var_32_9 < var_32_12 then
					arg_29_1.talkMaxDuration = var_32_12

					if var_32_12 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_13 and arg_29_1.time_ < var_32_8 + var_32_13 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1101102011 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 1101102011
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play1101102012(arg_35_1)
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

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(1101102011).content)

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
	Play1101102012 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 1101102012
		arg_39_1.duration_ = 4.47

		local var_39_0 = {
			zh = 4.466,
			ja = 3.9
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play1101102013(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.55

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:GetWordFromCfg(1101102012)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 22 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 22)

				if (22 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 22)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102012", "story_v_side_new_1101102.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102012", "story_v_side_new_1101102.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_side_new_1101102", "1101102012", "story_v_side_new_1101102.awb")

						arg_39_1:RecordAudio("1101102012", var_42_6)
						arg_39_1:RecordAudio("1101102012", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102012", "story_v_side_new_1101102.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102012", "story_v_side_new_1101102.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play1101102013 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 1101102013
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play1101102014(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 1.25

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

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(1101102013).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 50 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 50)

				if (50 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 50)) > 0 and var_46_0 < var_46_3 then
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
	Play1101102014 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1101102014
		arg_47_1.duration_ = 7.2

		local var_47_0 = {
			zh = 7.2,
			ja = 4.133
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1101102015(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_50_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_47_1.stage_.transform)

				var_50_0.name = "1011ui_story"
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["1011ui_story"] = var_50_0

				local var_50_1 = var_50_0:GetComponentInChildren(typeof(CharacterEffect))

				var_50_1.enabled = true

				local var_50_2 = GameObjectTools.GetOrAddComponent(var_50_0, typeof(DynamicBoneHelper))

				if var_50_2 then
					var_50_2:EnableDynamicBone(false)
				end

				arg_47_1:ShowWeapon(var_50_1.transform, false)

				arg_47_1.var_["1011ui_story" .. "Animator"] = var_50_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_47_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_47_1.var_["1011ui_story" .. "LipSync"] = var_50_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_50_3 = arg_47_1.actors_["1011ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1011ui_story = var_50_3.localPosition
			end

			local var_50_4 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				var_50_3.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_47_1.time_ - 0) / var_50_4)
				var_50_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_3.position).x, (manager.ui.mainCamera.transform.position - var_50_3.position).y, (manager.ui.mainCamera.transform.position - var_50_3.position).z)
				var_50_3.localEulerAngles.z = 0
				var_50_3.localEulerAngles.x = 0
				var_50_3.localEulerAngles = var_50_3.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				var_50_3.localPosition = Vector3.New(0, -0.71, -6)
				var_50_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_3.position).x, (manager.ui.mainCamera.transform.position - var_50_3.position).y, (manager.ui.mainCamera.transform.position - var_50_3.position).z)
				var_50_3.localEulerAngles.z = 0
				var_50_3.localEulerAngles.x = 0
				var_50_3.localEulerAngles = var_50_3.localEulerAngles
			end

			local var_50_5 = arg_47_1.actors_["1011ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.characterEffect1011ui_story == nil then
				arg_47_1.var_.characterEffect1011ui_story = var_50_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_6 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_6 and not isNil(var_50_5) then
				if arg_47_1.var_.characterEffect1011ui_story and not isNil(var_50_5) then
					arg_47_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_6 and arg_47_1.time_ < 0 + var_50_6 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.characterEffect1011ui_story then
				arg_47_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_50_8 = 0
			local var_50_9 = 0.375

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(1101102014)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 15 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 15)

				if (15 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 15)) > 0 and var_50_9 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102014", "story_v_side_new_1101102.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102014", "story_v_side_new_1101102.awb") / 1000

					if var_50_14 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_8
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_side_new_1101102", "1101102014", "story_v_side_new_1101102.awb")

						arg_47_1:RecordAudio("1101102014", var_50_15)
						arg_47_1:RecordAudio("1101102014", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102014", "story_v_side_new_1101102.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102014", "story_v_side_new_1101102.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play1101102015 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 1101102015
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play1101102016(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1011ui_story"]) and arg_51_1.var_.characterEffect1011ui_story == nil then
				arg_51_1.var_.characterEffect1011ui_story = arg_51_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1011ui_story"]) then
				if arg_51_1.var_.characterEffect1011ui_story and not isNil(arg_51_1.actors_["1011ui_story"]) then
					arg_51_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1011ui_story"]) and arg_51_1.var_.characterEffect1011ui_story then
				arg_51_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.65

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
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

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(1101102015).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 26 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 26)

				if (26 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 26)) > 0 and var_54_2 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_6 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_6 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_6

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_6 and arg_51_1.time_ < var_54_1 + var_54_6 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play1101102016 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 1101102016
		arg_55_1.duration_ = 6.53

		local var_55_0 = {
			zh = 4.3,
			ja = 6.533
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
				arg_55_0:Play1101102017(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_2")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_58_0 = 0
			local var_58_1 = 0.525

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_2 = arg_55_1:GetWordFromCfg(1101102016)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 21 <= 0 and var_58_1 or var_58_1 * (utf8.len(var_58_3) / 21)

				if (21 <= 0 and var_58_1 or var_58_1 * (utf8.len(var_58_3) / 21)) > 0 and var_58_1 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102016", "story_v_side_new_1101102.awb") ~= 0 then
					local var_58_6 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102016", "story_v_side_new_1101102.awb") / 1000

					if var_58_6 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_0
					end

					if var_58_2.prefab_name ~= "" and arg_55_1.actors_[var_58_2.prefab_name] ~= nil then
						local var_58_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_2.prefab_name].transform, "story_v_side_new_1101102", "1101102016", "story_v_side_new_1101102.awb")

						arg_55_1:RecordAudio("1101102016", var_58_7)
						arg_55_1:RecordAudio("1101102016", var_58_7)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102016", "story_v_side_new_1101102.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102016", "story_v_side_new_1101102.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_8 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_8 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_8

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_8 and arg_55_1.time_ < var_58_0 + var_58_8 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play1101102017 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 1101102017
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play1101102018(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.65

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(1101102017).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 26 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 26)

				if (26 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 26)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play1101102018 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 1101102018
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play1101102019(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			if arg_63_1.time_ >= 0 + 0.5 and arg_63_1.time_ < 0 + 0.5 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			local var_66_0 = 0
			local var_66_1 = 0.175

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(1101102018).content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 7 <= 0 and var_66_1 or var_66_1 * (utf8.len(var_66_2) / 7)

				if (7 <= 0 and var_66_1 or var_66_1 * (utf8.len(var_66_2) / 7)) > 0 and var_66_1 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_5 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_5 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_5

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_5 and arg_63_1.time_ < var_66_0 + var_66_5 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play1101102019 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 1101102019
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play1101102020(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.35

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(1101102019).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 14 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 14)

				if (14 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 14)) > 0 and var_70_0 < var_70_3 then
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
	Play1101102020 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1101102020
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1101102021(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.675

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
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

				local var_74_1 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(1101102020).content)

				arg_71_1.text_.text = var_74_1

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_3 = 27 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 27)

				if (27 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_1) / 27)) > 0 and var_74_0 < var_74_3 then
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
	Play1101102021 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1101102021
		arg_75_1.duration_ = 8.5

		local var_75_0 = {
			zh = 4.933,
			ja = 8.5
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
				arg_75_0:Play1101102022(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.6

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_1 = arg_75_1:GetWordFromCfg(1101102021)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 24 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 24)

				if (24 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 24)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102021", "story_v_side_new_1101102.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102021", "story_v_side_new_1101102.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_side_new_1101102", "1101102021", "story_v_side_new_1101102.awb")

						arg_75_1:RecordAudio("1101102021", var_78_6)
						arg_75_1:RecordAudio("1101102021", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102021", "story_v_side_new_1101102.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102021", "story_v_side_new_1101102.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play1101102022 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 1101102022
		arg_79_1.duration_ = 6.23

		local var_79_0 = {
			zh = 6.233,
			ja = 2.633
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play1101102023(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1011ui_story = arg_79_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1011ui_story"].transform.position).z)
				arg_79_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1011ui_story"].transform.localEulerAngles = arg_79_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_79_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1011ui_story"].transform.position).z)
				arg_79_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1011ui_story"].transform.localEulerAngles = arg_79_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1011ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1011ui_story == nil then
				arg_79_1.var_.characterEffect1011ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1011ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1011ui_story then
				arg_79_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_82_4 = 0
			local var_82_5 = 0.525

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(1101102022)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 21 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 21)

				if (21 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 21)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102022", "story_v_side_new_1101102.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102022", "story_v_side_new_1101102.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_side_new_1101102", "1101102022", "story_v_side_new_1101102.awb")

						arg_79_1:RecordAudio("1101102022", var_82_11)
						arg_79_1:RecordAudio("1101102022", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102022", "story_v_side_new_1101102.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102022", "story_v_side_new_1101102.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play1101102023 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 1101102023
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play1101102024(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1011ui_story"]) and arg_83_1.var_.characterEffect1011ui_story == nil then
				arg_83_1.var_.characterEffect1011ui_story = arg_83_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1011ui_story"]) then
				if arg_83_1.var_.characterEffect1011ui_story and not isNil(arg_83_1.actors_["1011ui_story"]) then
					arg_83_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1011ui_story"]) and arg_83_1.var_.characterEffect1011ui_story then
				arg_83_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.675

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(1101102023).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 27 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 27)

				if (27 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 27)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play1101102024 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 1101102024
		arg_87_1.duration_ = 6.53

		local var_87_0 = {
			zh = 6.533,
			ja = 4.1
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play1101102025(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.575

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_1 = arg_87_1:GetWordFromCfg(1101102024)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 23 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 23)

				if (23 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 23)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102024", "story_v_side_new_1101102.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102024", "story_v_side_new_1101102.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_side_new_1101102", "1101102024", "story_v_side_new_1101102.awb")

						arg_87_1:RecordAudio("1101102024", var_90_6)
						arg_87_1:RecordAudio("1101102024", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102024", "story_v_side_new_1101102.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102024", "story_v_side_new_1101102.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play1101102025 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 1101102025
		arg_91_1.duration_ = 3.6

		local var_91_0 = {
			zh = 3.5,
			ja = 3.6
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play1101102026(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.175

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:GetWordFromCfg(1101102025)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 7 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 7)

				if (7 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 7)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102025", "story_v_side_new_1101102.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102025", "story_v_side_new_1101102.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_side_new_1101102", "1101102025", "story_v_side_new_1101102.awb")

						arg_91_1:RecordAudio("1101102025", var_94_6)
						arg_91_1:RecordAudio("1101102025", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102025", "story_v_side_new_1101102.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102025", "story_v_side_new_1101102.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_7 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_7

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play1101102026 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 1101102026
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play1101102027(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1011ui_story = arg_95_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1011ui_story"].transform.position).z)
				arg_95_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1011ui_story"].transform.localEulerAngles = arg_95_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1011ui_story"].transform.position).z)
				arg_95_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1011ui_story"].transform.localEulerAngles = arg_95_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1011ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1011ui_story == nil then
				arg_95_1.var_.characterEffect1011ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1011ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_95_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_95_1.time_ - 0) / var_98_2)
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1011ui_story then
				arg_95_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_95_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_98_3 = 0
			local var_98_4 = 0.825

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_5 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(1101102026).content)

				arg_95_1.text_.text = var_98_5

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_7 = 33 <= 0 and var_98_4 or var_98_4 * (utf8.len(var_98_5) / 33)

				if (33 <= 0 and var_98_4 or var_98_4 * (utf8.len(var_98_5) / 33)) > 0 and var_98_4 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_3
					end
				end

				arg_95_1.text_.text = var_98_5
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_8 = math.max(var_98_4, arg_95_1.talkMaxDuration)

			if var_98_3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_3 + var_98_8 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_3) / var_98_8

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_3 + var_98_8 and arg_95_1.time_ < var_98_3 + var_98_8 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play1101102027 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1101102027
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1101102028(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.55

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(1101102027).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 22 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 22)

				if (22 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 22)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1101102028 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1101102028
		arg_103_1.duration_ = 7.23

		local var_103_0 = {
			zh = 5.8,
			ja = 7.233
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1101102029(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.625

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_1 = arg_103_1:GetWordFromCfg(1101102028)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 25 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 25)

				if (25 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 25)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102028", "story_v_side_new_1101102.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102028", "story_v_side_new_1101102.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_side_new_1101102", "1101102028", "story_v_side_new_1101102.awb")

						arg_103_1:RecordAudio("1101102028", var_106_6)
						arg_103_1:RecordAudio("1101102028", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102028", "story_v_side_new_1101102.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102028", "story_v_side_new_1101102.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play1101102029 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1101102029
		arg_107_1.duration_ = 8.03

		local var_107_0 = {
			zh = 5.9,
			ja = 8.033
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1101102030(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1011ui_story = arg_107_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1011ui_story"].transform.position).z)
				arg_107_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1011ui_story"].transform.localEulerAngles = arg_107_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_107_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1011ui_story"].transform.position).z)
				arg_107_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1011ui_story"].transform.localEulerAngles = arg_107_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["1011ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1011ui_story == nil then
				arg_107_1.var_.characterEffect1011ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect1011ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1011ui_story then
				arg_107_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_4 = 0
			local var_110_5 = 0.7

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(1101102029)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 28 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 28)

				if (28 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 28)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102029", "story_v_side_new_1101102.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102029", "story_v_side_new_1101102.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_side_new_1101102", "1101102029", "story_v_side_new_1101102.awb")

						arg_107_1:RecordAudio("1101102029", var_110_11)
						arg_107_1:RecordAudio("1101102029", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102029", "story_v_side_new_1101102.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102029", "story_v_side_new_1101102.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play1101102030 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1101102030
		arg_111_1.duration_ = 11.9

		local var_111_0 = {
			zh = 6.866,
			ja = 11.9
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
				arg_111_0:Play1101102031(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1011ui_story"]) and arg_111_1.var_.characterEffect1011ui_story == nil then
				arg_111_1.var_.characterEffect1011ui_story = arg_111_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1011ui_story"]) then
				if arg_111_1.var_.characterEffect1011ui_story and not isNil(arg_111_1.actors_["1011ui_story"]) then
					arg_111_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1011ui_story"]) and arg_111_1.var_.characterEffect1011ui_story then
				arg_111_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.85

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:GetWordFromCfg(1101102030)
				local var_114_4 = arg_111_1:FormatText(var_114_3.content)

				arg_111_1.text_.text = var_114_4

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_6 = 34 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_4) / 34)

				if (34 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_4) / 34)) > 0 and var_114_2 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_4
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102030", "story_v_side_new_1101102.awb") ~= 0 then
					local var_114_7 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102030", "story_v_side_new_1101102.awb") / 1000

					if var_114_7 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_1
					end

					if var_114_3.prefab_name ~= "" and arg_111_1.actors_[var_114_3.prefab_name] ~= nil then
						local var_114_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_3.prefab_name].transform, "story_v_side_new_1101102", "1101102030", "story_v_side_new_1101102.awb")

						arg_111_1:RecordAudio("1101102030", var_114_8)
						arg_111_1:RecordAudio("1101102030", var_114_8)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102030", "story_v_side_new_1101102.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102030", "story_v_side_new_1101102.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_9 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_9 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_9

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_9 and arg_111_1.time_ < var_114_1 + var_114_9 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1101102031 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1101102031
		arg_115_1.duration_ = 12.5

		local var_115_0 = {
			zh = 12.5,
			ja = 11.2
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
				arg_115_0:Play1101102032(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 1.4

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:GetWordFromCfg(1101102031)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 56 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 56)

				if (56 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 56)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102031", "story_v_side_new_1101102.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102031", "story_v_side_new_1101102.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_side_new_1101102", "1101102031", "story_v_side_new_1101102.awb")

						arg_115_1:RecordAudio("1101102031", var_118_6)
						arg_115_1:RecordAudio("1101102031", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102031", "story_v_side_new_1101102.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102031", "story_v_side_new_1101102.awb")
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
	Play1101102032 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1101102032
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1101102033(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.825

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(1101102032).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 33 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 33)

				if (33 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 33)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1101102033 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1101102033
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1101102034(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.625

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(1101102033).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 25 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 25)

				if (25 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 25)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1101102034 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1101102034
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1101102035(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = false

				arg_127_1:SetGaussion(false)
			end

			local var_130_0 = 0.975

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				local var_130_1 = Color.New(1, 1, 1)

				var_130_1.a = Mathf.Lerp(1, 0, (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.mask_.color = var_130_1
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				local var_130_2 = Color.New(1, 1, 1)

				arg_127_1.mask_.enabled = false
				var_130_2.a = 0
				arg_127_1.mask_.color = var_130_2
			end

			if 0.975 < arg_127_1.time_ and arg_127_1.time_ <= 0.975 + arg_130_0 then
				arg_127_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_130_3 = 0
			local var_130_4 = 0.975

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_3 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_5 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_5:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(1101102034).content)

				arg_127_1.text_.text = var_130_6

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_8 = 39 <= 0 and var_130_4 or var_130_4 * (utf8.len(var_130_6) / 39)

				if (39 <= 0 and var_130_4 or var_130_4 * (utf8.len(var_130_6) / 39)) > 0 and var_130_4 < var_130_8 then
					arg_127_1.talkMaxDuration = var_130_8
					var_130_3 = var_130_3 + 0.3

					if var_130_8 + var_130_3 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_3
					end
				end

				arg_127_1.text_.text = var_130_6
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_9 = var_130_3 + 0.3
			local var_130_10 = math.max(var_130_4, arg_127_1.talkMaxDuration)

			if var_130_3 + 0.3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_9) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_9 + var_130_10 and arg_127_1.time_ < var_130_9 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1101102035 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1101102035
		arg_133_1.duration_ = 4.9

		local var_133_0 = {
			zh = 2.5,
			ja = 4.9
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
				arg_133_0:Play1101102036(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1011ui_story = arg_133_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1011ui_story"].transform.position).z)
				arg_133_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1011ui_story"].transform.localEulerAngles = arg_133_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_133_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1011ui_story"].transform.position).z)
				arg_133_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1011ui_story"].transform.localEulerAngles = arg_133_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1011ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1011ui_story == nil then
				arg_133_1.var_.characterEffect1011ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1011ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1011ui_story then
				arg_133_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_136_4 = manager.ui.mainCamera.transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.shakeOldPos = var_136_4.localPosition
			end

			local var_136_5 = 0.5

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_5 then
				local var_136_6, var_136_7 = math.modf((arg_133_1.time_ - 0) / 0.066)

				var_136_4.localPosition = Vector3.New(var_136_7 * 0.13, var_136_7 * 0.13, var_136_7 * 0.13) + arg_133_1.var_.shakeOldPos
			end

			if arg_133_1.time_ >= 0 + var_136_5 and arg_133_1.time_ < 0 + var_136_5 + arg_136_0 then
				var_136_4.localPosition = arg_133_1.var_.shakeOldPos
			end

			local var_136_8 = 0
			local var_136_9 = 0.25

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:GetWordFromCfg(1101102035)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 10 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 10)

				if (10 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 10)) > 0 and var_136_9 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102035", "story_v_side_new_1101102.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102035", "story_v_side_new_1101102.awb") / 1000

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end

					if var_136_10.prefab_name ~= "" and arg_133_1.actors_[var_136_10.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_10.prefab_name].transform, "story_v_side_new_1101102", "1101102035", "story_v_side_new_1101102.awb")

						arg_133_1:RecordAudio("1101102035", var_136_15)
						arg_133_1:RecordAudio("1101102035", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102035", "story_v_side_new_1101102.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102035", "story_v_side_new_1101102.awb")
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play1101102036 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1101102036
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play1101102037(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1011ui_story = arg_137_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1011ui_story"].transform.position).z)
				arg_137_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1011ui_story"].transform.localEulerAngles = arg_137_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1011ui_story"].transform.position).z)
				arg_137_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1011ui_story"].transform.localEulerAngles = arg_137_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["1011ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1011ui_story == nil then
				arg_137_1.var_.characterEffect1011ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1011ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_2)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1011ui_story then
				arg_137_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_140_3 = 0
			local var_140_4 = 0.9

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_5 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(1101102036).content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_7 = 36 <= 0 and var_140_4 or var_140_4 * (utf8.len(var_140_5) / 36)

				if (36 <= 0 and var_140_4 or var_140_4 * (utf8.len(var_140_5) / 36)) > 0 and var_140_4 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_3 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_3
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_4, arg_137_1.talkMaxDuration)

			if var_140_3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_3 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_3) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_3 + var_140_8 and arg_137_1.time_ < var_140_3 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play1101102037 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1101102037
		arg_141_1.duration_ = 13.9

		local var_141_0 = {
			zh = 8.866,
			ja = 13.9
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play1101102038(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 1 < arg_141_1.time_ and arg_141_1.time_ <= 1 + arg_144_0 then
				local var_144_0 = arg_141_1.bgs_.ST12

				arg_141_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_144_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_1 = var_144_0:GetComponent("SpriteRenderer")

				if var_144_1 and var_144_1.sprite then
					local var_144_2 = 2 * (var_144_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_144_0.transform.localScale = Vector3.New(var_144_2 / var_144_1.sprite.bounds.size.y < var_144_2 * manager.ui.mainCameraCom_.aspect / var_144_1.sprite.bounds.size.x and var_144_2 * manager.ui.mainCameraCom_.aspect / var_144_1.sprite.bounds.size.x or var_144_2 / var_144_1.sprite.bounds.size.y, var_144_2 / var_144_1.sprite.bounds.size.y < var_144_2 * manager.ui.mainCameraCom_.aspect / var_144_1.sprite.bounds.size.x and var_144_2 * manager.ui.mainCameraCom_.aspect / var_144_1.sprite.bounds.size.x or var_144_2 / var_144_1.sprite.bounds.size.y, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "ST12" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_144_3 = 0

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_3 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_4 = 1

			if var_144_3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_3 + var_144_4 then
				local var_144_5 = Color.New(0, 0, 0)

				var_144_5.a = Mathf.Lerp(0, 1, (arg_141_1.time_ - var_144_3) / var_144_4)
				arg_141_1.mask_.color = var_144_5
			end

			if arg_141_1.time_ >= var_144_3 + var_144_4 and arg_141_1.time_ < var_144_3 + var_144_4 + arg_144_0 then
				local var_144_6 = Color.New(0, 0, 0)

				var_144_6.a = 1
				arg_141_1.mask_.color = var_144_6
			end

			local var_144_7 = 1

			if 1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_7 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_8 = 1

			if var_144_7 <= arg_141_1.time_ and arg_141_1.time_ < var_144_7 + var_144_8 then
				local var_144_9 = Color.New(0, 0, 0)

				var_144_9.a = Mathf.Lerp(1, 0, (arg_141_1.time_ - var_144_7) / var_144_8)
				arg_141_1.mask_.color = var_144_9
			end

			if arg_141_1.time_ >= var_144_7 + var_144_8 and arg_141_1.time_ < var_144_7 + var_144_8 + arg_144_0 then
				local var_144_10 = Color.New(0, 0, 0)

				arg_141_1.mask_.enabled = false
				var_144_10.a = 0
				arg_141_1.mask_.color = var_144_10
			end

			local var_144_11 = 1

			arg_141_1.isInRecall_ = false

			if var_144_11 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 then
				arg_141_1.screenFilterGo_:SetActive(true)

				arg_141_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_144_2, iter_144_3 in pairs(arg_141_1.actors_) do
					for iter_144_4, iter_144_5 in ipairs((iter_144_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_144_5.color = iter_144_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_144_12 = 0.0166666666666667

			if var_144_11 <= arg_141_1.time_ and arg_141_1.time_ < var_144_11 + var_144_12 then
				arg_141_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_141_1.time_ - var_144_11) / var_144_12)
			end

			if arg_141_1.time_ >= var_144_11 + var_144_12 and arg_141_1.time_ < var_144_11 + var_144_12 + arg_144_0 then
				arg_141_1.screenFilterEffect_.weight = 1
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_13 = 2
			local var_144_14 = 0.85

			if 2 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_15 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_15:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_16 = arg_141_1:GetWordFromCfg(1101102037)
				local var_144_17 = arg_141_1:FormatText(var_144_16.content)

				arg_141_1.text_.text = var_144_17

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_19 = 34 <= 0 and var_144_14 or var_144_14 * (utf8.len(var_144_17) / 34)

				if (34 <= 0 and var_144_14 or var_144_14 * (utf8.len(var_144_17) / 34)) > 0 and var_144_14 < var_144_19 then
					arg_141_1.talkMaxDuration = var_144_19
					var_144_13 = var_144_13 + 0.3

					if var_144_19 + var_144_13 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_19 + var_144_13
					end
				end

				arg_141_1.text_.text = var_144_17
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102037", "story_v_side_new_1101102.awb") ~= 0 then
					local var_144_20 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102037", "story_v_side_new_1101102.awb") / 1000

					if var_144_20 + var_144_13 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_20 + var_144_13
					end

					if var_144_16.prefab_name ~= "" and arg_141_1.actors_[var_144_16.prefab_name] ~= nil then
						local var_144_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_16.prefab_name].transform, "story_v_side_new_1101102", "1101102037", "story_v_side_new_1101102.awb")

						arg_141_1:RecordAudio("1101102037", var_144_21)
						arg_141_1:RecordAudio("1101102037", var_144_21)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102037", "story_v_side_new_1101102.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102037", "story_v_side_new_1101102.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_22 = var_144_13 + 0.3
			local var_144_23 = math.max(var_144_14, arg_141_1.talkMaxDuration)

			if var_144_13 + 0.3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_22 + var_144_23 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_22) / var_144_23

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_22 + var_144_23 and arg_141_1.time_ < var_144_22 + var_144_23 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play1101102038 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1101102038
		arg_147_1.duration_ = 7

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1101102039(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 1 < arg_147_1.time_ and arg_147_1.time_ <= 1 + arg_150_0 then
				local var_150_0 = arg_147_1.bgs_.ST12

				arg_147_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_1 = var_150_0:GetComponent("SpriteRenderer")

				if var_150_1 and var_150_1.sprite then
					local var_150_2 = 2 * (var_150_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_0.transform.localScale = Vector3.New(var_150_2 / var_150_1.sprite.bounds.size.y < var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x and var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x or var_150_2 / var_150_1.sprite.bounds.size.y, var_150_2 / var_150_1.sprite.bounds.size.y < var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x and var_150_2 * manager.ui.mainCameraCom_.aspect / var_150_1.sprite.bounds.size.x or var_150_2 / var_150_1.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "ST12" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_3 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_3 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_4 = 1

			if var_150_3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_3 + var_150_4 then
				local var_150_5 = Color.New(0, 0, 0)

				var_150_5.a = Mathf.Lerp(0, 1, (arg_147_1.time_ - var_150_3) / var_150_4)
				arg_147_1.mask_.color = var_150_5
			end

			if arg_147_1.time_ >= var_150_3 + var_150_4 and arg_147_1.time_ < var_150_3 + var_150_4 + arg_150_0 then
				local var_150_6 = Color.New(0, 0, 0)

				var_150_6.a = 1
				arg_147_1.mask_.color = var_150_6
			end

			local var_150_7 = 1

			if 1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_7 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_8 = 1

			if var_150_7 <= arg_147_1.time_ and arg_147_1.time_ < var_150_7 + var_150_8 then
				local var_150_9 = Color.New(0, 0, 0)

				var_150_9.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_7) / var_150_8)
				arg_147_1.mask_.color = var_150_9
			end

			if arg_147_1.time_ >= var_150_7 + var_150_8 and arg_147_1.time_ < var_150_7 + var_150_8 + arg_150_0 then
				local var_150_10 = Color.New(0, 0, 0)

				arg_147_1.mask_.enabled = false
				var_150_10.a = 0
				arg_147_1.mask_.color = var_150_10
			end

			local var_150_11 = arg_147_1.actors_["1011ui_story"].transform

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= 2 + arg_150_0 then
				arg_147_1.var_.moveOldPos1011ui_story = var_150_11.localPosition
			end

			local var_150_12 = 0.001

			if 2 <= arg_147_1.time_ and arg_147_1.time_ < 2 + var_150_12 then
				var_150_11.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_147_1.time_ - 2) / var_150_12)
				var_150_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_11.position).x, (manager.ui.mainCamera.transform.position - var_150_11.position).y, (manager.ui.mainCamera.transform.position - var_150_11.position).z)
				var_150_11.localEulerAngles.z = 0
				var_150_11.localEulerAngles.x = 0
				var_150_11.localEulerAngles = var_150_11.localEulerAngles
			end

			if arg_147_1.time_ >= 2 + var_150_12 and arg_147_1.time_ < 2 + var_150_12 + arg_150_0 then
				var_150_11.localPosition = Vector3.New(0, -0.71, -6)
				var_150_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_11.position).x, (manager.ui.mainCamera.transform.position - var_150_11.position).y, (manager.ui.mainCamera.transform.position - var_150_11.position).z)
				var_150_11.localEulerAngles.z = 0
				var_150_11.localEulerAngles.x = 0
				var_150_11.localEulerAngles = var_150_11.localEulerAngles
			end

			local var_150_13 = arg_147_1.actors_["1011ui_story"]

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= 2 + arg_150_0 and not isNil(var_150_13) and arg_147_1.var_.characterEffect1011ui_story == nil then
				arg_147_1.var_.characterEffect1011ui_story = var_150_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_14 = 0.200000002980232

			if 2 <= arg_147_1.time_ and arg_147_1.time_ < 2 + var_150_14 and not isNil(var_150_13) then
				if arg_147_1.var_.characterEffect1011ui_story and not isNil(var_150_13) then
					arg_147_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 2 + var_150_14 and arg_147_1.time_ < 2 + var_150_14 + arg_150_0 and not isNil(var_150_13) and arg_147_1.var_.characterEffect1011ui_story then
				arg_147_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= 2 + arg_150_0 then
				arg_147_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_150_16 = 1

			arg_147_1.isInRecall_ = false

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.screenFilterGo_:SetActive(false)

				for iter_150_2, iter_150_3 in pairs(arg_147_1.actors_) do
					for iter_150_4, iter_150_5 in ipairs((iter_150_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_150_5.color = iter_150_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_150_17 = 0.0166666666666667

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 then
				arg_147_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_16) / var_150_17)
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 then
				arg_147_1.screenFilterEffect_.weight = 0
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_18 = 2
			local var_150_19 = 0.85

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_18 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_20 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_20:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_21 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(1101102038).content)

				arg_147_1.text_.text = var_150_21

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_23 = 34 <= 0 and var_150_19 or var_150_19 * (utf8.len(var_150_21) / 34)

				if (34 <= 0 and var_150_19 or var_150_19 * (utf8.len(var_150_21) / 34)) > 0 and var_150_19 < var_150_23 then
					arg_147_1.talkMaxDuration = var_150_23
					var_150_18 = var_150_18 + 0.3

					if var_150_23 + var_150_18 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_23 + var_150_18
					end
				end

				arg_147_1.text_.text = var_150_21
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_24 = var_150_18 + 0.3
			local var_150_25 = math.max(var_150_19, arg_147_1.talkMaxDuration)

			if var_150_18 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_24 + var_150_25 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_24) / var_150_25

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_24 + var_150_25 and arg_147_1.time_ < var_150_24 + var_150_25 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play1101102039 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1101102039
		arg_153_1.duration_ = 13

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play1101102040(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 4 < arg_153_1.time_ and arg_153_1.time_ <= 4 + arg_156_0 then
				local var_156_0 = arg_153_1.bgs_.ST12

				arg_153_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_156_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_156_1 = var_156_0:GetComponent("SpriteRenderer")

				if var_156_1 and var_156_1.sprite then
					local var_156_2 = 2 * (var_156_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_156_0.transform.localScale = Vector3.New(var_156_2 / var_156_1.sprite.bounds.size.y < var_156_2 * manager.ui.mainCameraCom_.aspect / var_156_1.sprite.bounds.size.x and var_156_2 * manager.ui.mainCameraCom_.aspect / var_156_1.sprite.bounds.size.x or var_156_2 / var_156_1.sprite.bounds.size.y, var_156_2 / var_156_1.sprite.bounds.size.y < var_156_2 * manager.ui.mainCameraCom_.aspect / var_156_1.sprite.bounds.size.x and var_156_2 * manager.ui.mainCameraCom_.aspect / var_156_1.sprite.bounds.size.x or var_156_2 / var_156_1.sprite.bounds.size.y, 0)
				end

				for iter_156_0, iter_156_1 in pairs(arg_153_1.bgs_) do
					if iter_156_0 ~= "ST12" then
						iter_156_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_156_3 = 0

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_3 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_4 = 4

			if var_156_3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_3 + var_156_4 then
				local var_156_5 = Color.New(0, 0, 0)

				var_156_5.a = Mathf.Lerp(0, 1, (arg_153_1.time_ - var_156_3) / var_156_4)
				arg_153_1.mask_.color = var_156_5
			end

			if arg_153_1.time_ >= var_156_3 + var_156_4 and arg_153_1.time_ < var_156_3 + var_156_4 + arg_156_0 then
				local var_156_6 = Color.New(0, 0, 0)

				var_156_6.a = 1
				arg_153_1.mask_.color = var_156_6
			end

			local var_156_7 = 4

			if 4 < arg_153_1.time_ and arg_153_1.time_ <= var_156_7 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_8 = 4

			if var_156_7 <= arg_153_1.time_ and arg_153_1.time_ < var_156_7 + var_156_8 then
				local var_156_9 = Color.New(0, 0, 0)

				var_156_9.a = Mathf.Lerp(1, 0, (arg_153_1.time_ - var_156_7) / var_156_8)
				arg_153_1.mask_.color = var_156_9
			end

			if arg_153_1.time_ >= var_156_7 + var_156_8 and arg_153_1.time_ < var_156_7 + var_156_8 + arg_156_0 then
				local var_156_10 = Color.New(0, 0, 0)

				arg_153_1.mask_.enabled = false
				var_156_10.a = 0
				arg_153_1.mask_.color = var_156_10
			end

			local var_156_11 = arg_153_1.actors_["1011ui_story"].transform

			if 4 < arg_153_1.time_ and arg_153_1.time_ <= 4 + arg_156_0 then
				arg_153_1.var_.moveOldPos1011ui_story = var_156_11.localPosition
			end

			local var_156_12 = 0.001

			if 4 <= arg_153_1.time_ and arg_153_1.time_ < 4 + var_156_12 then
				var_156_11.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_153_1.time_ - 4) / var_156_12)
				var_156_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_11.position).x, (manager.ui.mainCamera.transform.position - var_156_11.position).y, (manager.ui.mainCamera.transform.position - var_156_11.position).z)
				var_156_11.localEulerAngles.z = 0
				var_156_11.localEulerAngles.x = 0
				var_156_11.localEulerAngles = var_156_11.localEulerAngles
			end

			if arg_153_1.time_ >= 4 + var_156_12 and arg_153_1.time_ < 4 + var_156_12 + arg_156_0 then
				var_156_11.localPosition = Vector3.New(0, 100, 0)
				var_156_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_11.position).x, (manager.ui.mainCamera.transform.position - var_156_11.position).y, (manager.ui.mainCamera.transform.position - var_156_11.position).z)
				var_156_11.localEulerAngles.z = 0
				var_156_11.localEulerAngles.x = 0
				var_156_11.localEulerAngles = var_156_11.localEulerAngles
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_13 = 8
			local var_156_14 = 0.725

			if 8 < arg_153_1.time_ and arg_153_1.time_ <= var_156_13 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_15 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_15:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_16 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(1101102039).content)

				arg_153_1.text_.text = var_156_16

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_18 = 29 <= 0 and var_156_14 or var_156_14 * (utf8.len(var_156_16) / 29)

				if (29 <= 0 and var_156_14 or var_156_14 * (utf8.len(var_156_16) / 29)) > 0 and var_156_14 < var_156_18 then
					arg_153_1.talkMaxDuration = var_156_18
					var_156_13 = var_156_13 + 0.3

					if var_156_18 + var_156_13 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_13
					end
				end

				arg_153_1.text_.text = var_156_16
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_19 = var_156_13 + 0.3
			local var_156_20 = math.max(var_156_14, arg_153_1.talkMaxDuration)

			if var_156_13 + 0.3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_19 + var_156_20 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_19) / var_156_20

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_19 + var_156_20 and arg_153_1.time_ < var_156_19 + var_156_20 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play1101102040 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1101102040
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1101102041(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.6

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(1101102040).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 24 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 24)

				if (24 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 24)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1101102041 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1101102041
		arg_163_1.duration_ = 7.57

		local var_163_0 = {
			zh = 7.566,
			ja = 3.1
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1101102042(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1011ui_story = arg_163_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1011ui_story"].transform.position).z)
				arg_163_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1011ui_story"].transform.localEulerAngles = arg_163_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_163_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1011ui_story"].transform.position).z)
				arg_163_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1011ui_story"].transform.localEulerAngles = arg_163_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["1011ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1011ui_story == nil then
				arg_163_1.var_.characterEffect1011ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect1011ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1011ui_story then
				arg_163_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_166_4 = 0
			local var_166_5 = 0.375

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(1101102041)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 15 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 15)

				if (15 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 15)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102041", "story_v_side_new_1101102.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102041", "story_v_side_new_1101102.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_side_new_1101102", "1101102041", "story_v_side_new_1101102.awb")

						arg_163_1:RecordAudio("1101102041", var_166_11)
						arg_163_1:RecordAudio("1101102041", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102041", "story_v_side_new_1101102.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102041", "story_v_side_new_1101102.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play1101102042 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1101102042
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1101102043(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1011ui_story"]) and arg_167_1.var_.characterEffect1011ui_story == nil then
				arg_167_1.var_.characterEffect1011ui_story = arg_167_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1011ui_story"]) then
				if arg_167_1.var_.characterEffect1011ui_story and not isNil(arg_167_1.actors_["1011ui_story"]) then
					arg_167_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_167_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_0)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1011ui_story"]) and arg_167_1.var_.characterEffect1011ui_story then
				arg_167_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_167_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_170_1 = 0
			local var_170_2 = 0.925

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(1101102042).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 37 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 37)

				if (37 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 37)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1101102043 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1101102043
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1101102044(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.275

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(1101102043).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 11 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 11)

				if (11 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 11)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1101102044 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1101102044
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1101102045(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1011ui_story = arg_175_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1011ui_story"].transform.position).z)
				arg_175_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1011ui_story"].transform.localEulerAngles = arg_175_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_175_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1011ui_story"].transform.position).z)
				arg_175_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1011ui_story"].transform.localEulerAngles = arg_175_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_178_1 = 0
			local var_178_2 = 0.5

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(1101102044).content)

				arg_175_1.text_.text = var_178_3

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 20 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 20)

				if (20 <= 0 and var_178_2 or var_178_2 * (utf8.len(var_178_3) / 20)) > 0 and var_178_2 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_1 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_1
					end
				end

				arg_175_1.text_.text = var_178_3
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_6 = math.max(var_178_2, arg_175_1.talkMaxDuration)

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_6 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_1) / var_178_6

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_1 + var_178_6 and arg_175_1.time_ < var_178_1 + var_178_6 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play1101102045 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1101102045
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1101102046(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.7

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(1101102045).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 28 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 28)

				if (28 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 28)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1101102046 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1101102046
		arg_183_1.duration_ = 4.7

		local var_183_0 = {
			zh = 4.7,
			ja = 4.4
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
				arg_183_0:Play1101102047(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1011ui_story = arg_183_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1011ui_story"].transform.position).z)
				arg_183_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1011ui_story"].transform.localEulerAngles = arg_183_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_183_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["1011ui_story"].transform.position).z)
				arg_183_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["1011ui_story"].transform.localEulerAngles = arg_183_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["1011ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1011ui_story == nil then
				arg_183_1.var_.characterEffect1011ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect1011ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect1011ui_story then
				arg_183_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_186_4 = 0
			local var_186_5 = 0.3

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(1101102046)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 12 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 12)

				if (12 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 12)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102046", "story_v_side_new_1101102.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102046", "story_v_side_new_1101102.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_side_new_1101102", "1101102046", "story_v_side_new_1101102.awb")

						arg_183_1:RecordAudio("1101102046", var_186_11)
						arg_183_1:RecordAudio("1101102046", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102046", "story_v_side_new_1101102.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102046", "story_v_side_new_1101102.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play1101102047 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1101102047
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1101102048(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1011ui_story"]) and arg_187_1.var_.characterEffect1011ui_story == nil then
				arg_187_1.var_.characterEffect1011ui_story = arg_187_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1011ui_story"]) then
				if arg_187_1.var_.characterEffect1011ui_story and not isNil(arg_187_1.actors_["1011ui_story"]) then
					arg_187_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1011ui_story"]) and arg_187_1.var_.characterEffect1011ui_story then
				arg_187_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.65

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(1101102047).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 26 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 26)

				if (26 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 26)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1101102048 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1101102048
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1101102049(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.65

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(1101102048).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 26 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 26)

				if (26 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 26)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1101102049 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1101102049
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1101102050(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.125

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(1101102049).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 5 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 5)

				if (5 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 5)) > 0 and var_198_0 < var_198_3 then
					arg_195_1.talkMaxDuration = var_198_3

					if var_198_3 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_3 + 0
					end
				end

				arg_195_1.text_.text = var_198_1
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_4 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_4

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1101102050 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1101102050
		arg_199_1.duration_ = 6.07

		local var_199_0 = {
			zh = 5.2,
			ja = 6.066
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1101102051(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1011ui_story = arg_199_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1011ui_story"].transform.position).z)
				arg_199_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1011ui_story"].transform.localEulerAngles = arg_199_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_199_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1011ui_story"].transform.position).z)
				arg_199_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1011ui_story"].transform.localEulerAngles = arg_199_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1011ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1011ui_story == nil then
				arg_199_1.var_.characterEffect1011ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect1011ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1011ui_story then
				arg_199_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_2")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:AudioAction("play", "effect", "se_story_side_1011", "se_story_side_1011_hit", "")
			end

			local var_202_5 = manager.ui.mainCamera.transform

			if 0.200000002980232 < arg_199_1.time_ and arg_199_1.time_ <= 0.200000002980232 + arg_202_0 then
				arg_199_1.var_.shakeOldPos = var_202_5.localPosition
			end

			local var_202_6 = 0.349999997019768

			if 0.200000002980232 <= arg_199_1.time_ and arg_199_1.time_ < 0.200000002980232 + var_202_6 then
				local var_202_7, var_202_8 = math.modf((arg_199_1.time_ - 0.200000002980232) / 0.132)

				var_202_5.localPosition = Vector3.New(var_202_8 * 0.13, var_202_8 * 0.13, var_202_8 * 0.13) + arg_199_1.var_.shakeOldPos
			end

			if arg_199_1.time_ >= 0.200000002980232 + var_202_6 and arg_199_1.time_ < 0.200000002980232 + var_202_6 + arg_202_0 then
				var_202_5.localPosition = arg_199_1.var_.shakeOldPos
			end

			local var_202_9 = 0

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_9 + arg_202_0 then
				arg_199_1.allBtn_.enabled = false
			end

			if arg_199_1.time_ >= var_202_9 + 2 and arg_199_1.time_ < var_202_9 + 2 + arg_202_0 then
				arg_199_1.allBtn_.enabled = true
			end

			local var_202_10 = 0
			local var_202_11 = 0.55

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_12 = arg_199_1:GetWordFromCfg(1101102050)
				local var_202_13 = arg_199_1:FormatText(var_202_12.content)

				arg_199_1.text_.text = var_202_13

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_15 = 22 <= 0 and var_202_11 or var_202_11 * (utf8.len(var_202_13) / 22)

				if (22 <= 0 and var_202_11 or var_202_11 * (utf8.len(var_202_13) / 22)) > 0 and var_202_11 < var_202_15 then
					arg_199_1.talkMaxDuration = var_202_15

					if var_202_15 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_15 + var_202_10
					end
				end

				arg_199_1.text_.text = var_202_13
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102050", "story_v_side_new_1101102.awb") ~= 0 then
					local var_202_16 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102050", "story_v_side_new_1101102.awb") / 1000

					if var_202_16 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_16 + var_202_10
					end

					if var_202_12.prefab_name ~= "" and arg_199_1.actors_[var_202_12.prefab_name] ~= nil then
						local var_202_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_12.prefab_name].transform, "story_v_side_new_1101102", "1101102050", "story_v_side_new_1101102.awb")

						arg_199_1:RecordAudio("1101102050", var_202_17)
						arg_199_1:RecordAudio("1101102050", var_202_17)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102050", "story_v_side_new_1101102.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102050", "story_v_side_new_1101102.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_18 = math.max(var_202_11, arg_199_1.talkMaxDuration)

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_18 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_10) / var_202_18

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_10 + var_202_18 and arg_199_1.time_ < var_202_10 + var_202_18 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play1101102051 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1101102051
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1101102052(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1011ui_story"]) and arg_203_1.var_.characterEffect1011ui_story == nil then
				arg_203_1.var_.characterEffect1011ui_story = arg_203_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1011ui_story"]) then
				if arg_203_1.var_.characterEffect1011ui_story and not isNil(arg_203_1.actors_["1011ui_story"]) then
					arg_203_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_0)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1011ui_story"]) and arg_203_1.var_.characterEffect1011ui_story then
				arg_203_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_206_1 = 0
			local var_206_2 = 0.625

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(1101102051).content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 25 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 25)

				if (25 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 25)) > 0 and var_206_2 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_6 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_6 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_6

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_6 and arg_203_1.time_ < var_206_1 + var_206_6 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1101102052 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1101102052
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1101102053(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.3

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(1101102052).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 12 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 12)

				if (12 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 12)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1101102053 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1101102053
		arg_211_1.duration_ = 3.17

		local var_211_0 = {
			zh = 3.166,
			ja = 2.833
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1101102054(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1011ui_story = arg_211_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1011ui_story"].transform.position).z)
				arg_211_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1011ui_story"].transform.localEulerAngles = arg_211_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_211_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1011ui_story"].transform.position).z)
				arg_211_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1011ui_story"].transform.localEulerAngles = arg_211_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1011ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1011ui_story == nil then
				arg_211_1.var_.characterEffect1011ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect1011ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect1011ui_story then
				arg_211_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_214_4 = 0
			local var_214_5 = 0.175

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_4 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_6 = arg_211_1:GetWordFromCfg(1101102053)
				local var_214_7 = arg_211_1:FormatText(var_214_6.content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 7 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 7)

				if (7 <= 0 and var_214_5 or var_214_5 * (utf8.len(var_214_7) / 7)) > 0 and var_214_5 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_4
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102053", "story_v_side_new_1101102.awb") ~= 0 then
					local var_214_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102053", "story_v_side_new_1101102.awb") / 1000

					if var_214_10 + var_214_4 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_4
					end

					if var_214_6.prefab_name ~= "" and arg_211_1.actors_[var_214_6.prefab_name] ~= nil then
						local var_214_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_6.prefab_name].transform, "story_v_side_new_1101102", "1101102053", "story_v_side_new_1101102.awb")

						arg_211_1:RecordAudio("1101102053", var_214_11)
						arg_211_1:RecordAudio("1101102053", var_214_11)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102053", "story_v_side_new_1101102.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102053", "story_v_side_new_1101102.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_12 = math.max(var_214_5, arg_211_1.talkMaxDuration)

			if var_214_4 <= arg_211_1.time_ and arg_211_1.time_ < var_214_4 + var_214_12 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_4) / var_214_12

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_4 + var_214_12 and arg_211_1.time_ < var_214_4 + var_214_12 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play1101102054 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1101102054
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1101102055(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1011ui_story"]) and arg_215_1.var_.characterEffect1011ui_story == nil then
				arg_215_1.var_.characterEffect1011ui_story = arg_215_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1011ui_story"]) then
				if arg_215_1.var_.characterEffect1011ui_story and not isNil(arg_215_1.actors_["1011ui_story"]) then
					arg_215_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1011ui_story"]) and arg_215_1.var_.characterEffect1011ui_story then
				arg_215_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_218_1 = 0
			local var_218_2 = 0.25

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_3 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(1101102054).content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 10 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 10)

				if (10 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 10)) > 0 and var_218_2 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_6 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_6 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_6

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_6 and arg_215_1.time_ < var_218_1 + var_218_6 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1101102055 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1101102055
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1101102056(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.9

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(1101102055).content)

				arg_219_1.text_.text = var_222_1

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_3 = 36 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 36)

				if (36 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_1) / 36)) > 0 and var_222_0 < var_222_3 then
					arg_219_1.talkMaxDuration = var_222_3

					if var_222_3 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_3 + 0
					end
				end

				arg_219_1.text_.text = var_222_1
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_4 = math.max(var_222_0, arg_219_1.talkMaxDuration)

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - 0) / var_222_4

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1101102056 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1101102056
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1101102057(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:AudioAction("play", "effect", "se_story_128", "se_story_128_knock", "")
			end

			local var_226_1 = 0
			local var_226_2 = 0.65

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(1101102056).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 26 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 26)

				if (26 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 26)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1101102057 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1101102057
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1101102058(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.525

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(1101102057).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 21 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 21)

				if (21 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 21)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1101102058 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1101102058
		arg_231_1.duration_ = 9

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1101102059(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 2 < arg_231_1.time_ and arg_231_1.time_ <= 2 + arg_234_0 then
				arg_231_1.var_.moveOldPos1011ui_story = arg_231_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 2 <= arg_231_1.time_ and arg_231_1.time_ < 2 + var_234_0 then
				arg_231_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 2) / var_234_0)
				arg_231_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1011ui_story"].transform.position).z)
				arg_231_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1011ui_story"].transform.localEulerAngles = arg_231_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 2 + var_234_0 and arg_231_1.time_ < 2 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1011ui_story"].transform.position).z)
				arg_231_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1011ui_story"].transform.localEulerAngles = arg_231_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_234_1 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_2 = 2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = Color.New(0, 0, 0)

				var_234_3.a = Mathf.Lerp(0, 1, (arg_231_1.time_ - var_234_1) / var_234_2)
				arg_231_1.mask_.color = var_234_3
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				local var_234_4 = Color.New(0, 0, 0)

				var_234_4.a = 1
				arg_231_1.mask_.color = var_234_4
			end

			local var_234_5 = 2

			if 2 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.mask_.enabled = true
				arg_231_1.mask_.raycastTarget = true

				arg_231_1:SetGaussion(false)
			end

			local var_234_6 = 2

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 then
				local var_234_7 = Color.New(0, 0, 0)

				var_234_7.a = Mathf.Lerp(1, 0, (arg_231_1.time_ - var_234_5) / var_234_6)
				arg_231_1.mask_.color = var_234_7
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 then
				local var_234_8 = Color.New(0, 0, 0)

				arg_231_1.mask_.enabled = false
				var_234_8.a = 0
				arg_231_1.mask_.color = var_234_8
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:AudioAction("play", "effect", "se_story_16", "se_story_16_foot03", "")
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_10 = 4
			local var_234_11 = 0.4

			if 4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_12 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_12:setOnUpdate(LuaHelper.FloatAction(function(arg_235_0)
					arg_231_1.dialogCg_.alpha = arg_235_0
				end))
				var_234_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_13 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(1101102058).content)

				arg_231_1.text_.text = var_234_13

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_15 = 16 <= 0 and var_234_11 or var_234_11 * (utf8.len(var_234_13) / 16)

				if (16 <= 0 and var_234_11 or var_234_11 * (utf8.len(var_234_13) / 16)) > 0 and var_234_11 < var_234_15 then
					arg_231_1.talkMaxDuration = var_234_15
					var_234_10 = var_234_10 + 0.3

					if var_234_15 + var_234_10 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_15 + var_234_10
					end
				end

				arg_231_1.text_.text = var_234_13
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_16 = var_234_10 + 0.3
			local var_234_17 = math.max(var_234_11, arg_231_1.talkMaxDuration)

			if var_234_10 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_16 + var_234_17 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_16) / var_234_17

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_16 + var_234_17 and arg_231_1.time_ < var_234_16 + var_234_17 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play1101102059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1101102059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1101102060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1011ui_story = arg_237_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1011ui_story"].transform.position).z)
				arg_237_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1011ui_story"].transform.localEulerAngles = arg_237_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_237_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1011ui_story"].transform.position).z)
				arg_237_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1011ui_story"].transform.localEulerAngles = arg_237_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1011ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1011ui_story == nil then
				arg_237_1.var_.characterEffect1011ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1011ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1011ui_story then
				arg_237_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_240_4 = 0
			local var_240_5 = 0.575

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(1101102059).content)

				arg_237_1.text_.text = var_240_6

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_8 = 23 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_6) / 23)

				if (23 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_6) / 23)) > 0 and var_240_5 < var_240_8 then
					arg_237_1.talkMaxDuration = var_240_8

					if var_240_8 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_6
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_9 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_9 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_9

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_9 and arg_237_1.time_ < var_240_4 + var_240_9 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play1101102060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1101102060
		arg_241_1.duration_ = 7

		local var_241_0 = {
			zh = 5.2,
			ja = 7
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1101102061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1011ui_story = arg_241_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1011ui_story"].transform.position).z)
				arg_241_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1011ui_story"].transform.localEulerAngles = arg_241_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1011ui_story"].transform.position).z)
				arg_241_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1011ui_story"].transform.localEulerAngles = arg_241_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_244_1 = 0
			local var_244_2 = 0.5

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011_split_9")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(1101102060)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_6 = 20 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_4) / 20)

				if (20 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_4) / 20)) > 0 and var_244_2 < var_244_6 then
					arg_241_1.talkMaxDuration = var_244_6

					if var_244_6 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102060", "story_v_side_new_1101102.awb") ~= 0 then
					local var_244_7 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102060", "story_v_side_new_1101102.awb") / 1000

					if var_244_7 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_1
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_side_new_1101102", "1101102060", "story_v_side_new_1101102.awb")

						arg_241_1:RecordAudio("1101102060", var_244_8)
						arg_241_1:RecordAudio("1101102060", var_244_8)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102060", "story_v_side_new_1101102.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102060", "story_v_side_new_1101102.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_9 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_9 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_9

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_9 and arg_241_1.time_ < var_244_1 + var_244_9 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play1101102061 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1101102061
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1101102062(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 1.075

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(1101102061).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 43 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 43)

				if (43 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 43)) > 0 and var_248_0 < var_248_3 then
					arg_245_1.talkMaxDuration = var_248_3

					if var_248_3 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_3 + 0
					end
				end

				arg_245_1.text_.text = var_248_1
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_4 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_4

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play1101102062 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1101102062
		arg_249_1.duration_ = 11

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1101102063(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if arg_249_1.bgs_.ST01 == nil then
				local var_252_0 = Object.Instantiate(arg_249_1.paintGo_)

				var_252_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01")
				var_252_0.name = "ST01"
				var_252_0.transform.parent = arg_249_1.stage_.transform
				var_252_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_249_1.bgs_.ST01 = var_252_0
			end

			if 3 < arg_249_1.time_ and arg_249_1.time_ <= 3 + arg_252_0 then
				local var_252_1 = arg_249_1.bgs_.ST01

				arg_249_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_252_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_252_2 = var_252_1:GetComponent("SpriteRenderer")

				if var_252_2 and var_252_2.sprite then
					local var_252_3 = 2 * (var_252_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_252_1.transform.localScale = Vector3.New(var_252_3 / var_252_2.sprite.bounds.size.y < var_252_3 * manager.ui.mainCameraCom_.aspect / var_252_2.sprite.bounds.size.x and var_252_3 * manager.ui.mainCameraCom_.aspect / var_252_2.sprite.bounds.size.x or var_252_3 / var_252_2.sprite.bounds.size.y, var_252_3 / var_252_2.sprite.bounds.size.y < var_252_3 * manager.ui.mainCameraCom_.aspect / var_252_2.sprite.bounds.size.x and var_252_3 * manager.ui.mainCameraCom_.aspect / var_252_2.sprite.bounds.size.x or var_252_3 / var_252_2.sprite.bounds.size.y, 0)
				end

				for iter_252_0, iter_252_1 in pairs(arg_249_1.bgs_) do
					if iter_252_0 ~= "ST01" then
						iter_252_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_252_4 = 0

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.mask_.enabled = true
				arg_249_1.mask_.raycastTarget = true

				arg_249_1:SetGaussion(false)
			end

			local var_252_5 = 3

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_5 then
				local var_252_6 = Color.New(0, 0, 0)

				var_252_6.a = Mathf.Lerp(0, 1, (arg_249_1.time_ - var_252_4) / var_252_5)
				arg_249_1.mask_.color = var_252_6
			end

			if arg_249_1.time_ >= var_252_4 + var_252_5 and arg_249_1.time_ < var_252_4 + var_252_5 + arg_252_0 then
				local var_252_7 = Color.New(0, 0, 0)

				var_252_7.a = 1
				arg_249_1.mask_.color = var_252_7
			end

			local var_252_8 = 3

			if 3 < arg_249_1.time_ and arg_249_1.time_ <= var_252_8 + arg_252_0 then
				arg_249_1.mask_.enabled = true
				arg_249_1.mask_.raycastTarget = true

				arg_249_1:SetGaussion(false)
			end

			local var_252_9 = 3

			if var_252_8 <= arg_249_1.time_ and arg_249_1.time_ < var_252_8 + var_252_9 then
				local var_252_10 = Color.New(0, 0, 0)

				var_252_10.a = Mathf.Lerp(1, 0, (arg_249_1.time_ - var_252_8) / var_252_9)
				arg_249_1.mask_.color = var_252_10
			end

			if arg_249_1.time_ >= var_252_8 + var_252_9 and arg_249_1.time_ < var_252_8 + var_252_9 + arg_252_0 then
				local var_252_11 = Color.New(0, 0, 0)

				arg_249_1.mask_.enabled = false
				var_252_11.a = 0
				arg_249_1.mask_.color = var_252_11
			end

			local var_252_12 = arg_249_1.actors_["1011ui_story"].transform

			if 3 < arg_249_1.time_ and arg_249_1.time_ <= 3 + arg_252_0 then
				arg_249_1.var_.moveOldPos1011ui_story = var_252_12.localPosition
			end

			local var_252_13 = 0.001

			if 3 <= arg_249_1.time_ and arg_249_1.time_ < 3 + var_252_13 then
				var_252_12.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_249_1.time_ - 3) / var_252_13)
				var_252_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_12.position).x, (manager.ui.mainCamera.transform.position - var_252_12.position).y, (manager.ui.mainCamera.transform.position - var_252_12.position).z)
				var_252_12.localEulerAngles.z = 0
				var_252_12.localEulerAngles.x = 0
				var_252_12.localEulerAngles = var_252_12.localEulerAngles
			end

			if arg_249_1.time_ >= 3 + var_252_13 and arg_249_1.time_ < 3 + var_252_13 + arg_252_0 then
				var_252_12.localPosition = Vector3.New(0, 100, 0)
				var_252_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_12.position).x, (manager.ui.mainCamera.transform.position - var_252_12.position).y, (manager.ui.mainCamera.transform.position - var_252_12.position).z)
				var_252_12.localEulerAngles.z = 0
				var_252_12.localEulerAngles.x = 0
				var_252_12.localEulerAngles = var_252_12.localEulerAngles
			end

			if arg_249_1.frameCnt_ <= 1 then
				arg_249_1.dialog_:SetActive(false)
			end

			local var_252_14 = 6
			local var_252_15 = 0.65

			if 6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_14 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0

				arg_249_1.dialog_:SetActive(true)

				arg_249_1.dialogCg_.alpha = 0

				local var_252_16 = LeanTween.value(arg_249_1.dialog_, 0, 1, 0.3)

				var_252_16:setOnUpdate(LuaHelper.FloatAction(function(arg_253_0)
					arg_249_1.dialogCg_.alpha = arg_253_0
				end))
				var_252_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_249_1.dialog_)
					var_252_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_249_1.duration_ = arg_249_1.duration_ + 0.3

				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_17 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(1101102062).content)

				arg_249_1.text_.text = var_252_17

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_19 = 26 <= 0 and var_252_15 or var_252_15 * (utf8.len(var_252_17) / 26)

				if (26 <= 0 and var_252_15 or var_252_15 * (utf8.len(var_252_17) / 26)) > 0 and var_252_15 < var_252_19 then
					arg_249_1.talkMaxDuration = var_252_19
					var_252_14 = var_252_14 + 0.3

					if var_252_19 + var_252_14 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_19 + var_252_14
					end
				end

				arg_249_1.text_.text = var_252_17
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_20 = var_252_14 + 0.3
			local var_252_21 = math.max(var_252_15, arg_249_1.talkMaxDuration)

			if var_252_14 + 0.3 <= arg_249_1.time_ and arg_249_1.time_ < var_252_20 + var_252_21 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_20) / var_252_21

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_20 + var_252_21 and arg_249_1.time_ < var_252_20 + var_252_21 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play1101102063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1101102063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1101102064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.825

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(1101102063).content)

				arg_255_1.text_.text = var_258_1

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_3 = 33 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_1) / 33)

				if (33 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_1) / 33)) > 0 and var_258_0 < var_258_3 then
					arg_255_1.talkMaxDuration = var_258_3

					if var_258_3 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_3 + 0
					end
				end

				arg_255_1.text_.text = var_258_1
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_4 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_4

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1101102064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1101102064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1101102065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.425

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(1101102064).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 17 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 17)

				if (17 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 17)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1101102065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1101102065
		arg_263_1.duration_ = 3.37

		local var_263_0 = {
			zh = 3.366,
			ja = 2.066
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1101102066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1011ui_story = arg_263_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1011ui_story"].transform.position).z)
				arg_263_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1011ui_story"].transform.localEulerAngles = arg_263_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_263_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1011ui_story"].transform.position).z)
				arg_263_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1011ui_story"].transform.localEulerAngles = arg_263_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1011ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1011ui_story == nil then
				arg_263_1.var_.characterEffect1011ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1011ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1011ui_story then
				arg_263_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0.034000001847744 < arg_263_1.time_ and arg_263_1.time_ <= 0.034000001847744 + arg_266_0 then
				arg_263_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_266_4 = 0
			local var_266_5 = 0.275

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_6 = arg_263_1:GetWordFromCfg(1101102065)
				local var_266_7 = arg_263_1:FormatText(var_266_6.content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 11 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 11)

				if (11 <= 0 and var_266_5 or var_266_5 * (utf8.len(var_266_7) / 11)) > 0 and var_266_5 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_4
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102065", "story_v_side_new_1101102.awb") ~= 0 then
					local var_266_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102065", "story_v_side_new_1101102.awb") / 1000

					if var_266_10 + var_266_4 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_4
					end

					if var_266_6.prefab_name ~= "" and arg_263_1.actors_[var_266_6.prefab_name] ~= nil then
						local var_266_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_6.prefab_name].transform, "story_v_side_new_1101102", "1101102065", "story_v_side_new_1101102.awb")

						arg_263_1:RecordAudio("1101102065", var_266_11)
						arg_263_1:RecordAudio("1101102065", var_266_11)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102065", "story_v_side_new_1101102.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102065", "story_v_side_new_1101102.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_12 = math.max(var_266_5, arg_263_1.talkMaxDuration)

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_12 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_4) / var_266_12

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_4 + var_266_12 and arg_263_1.time_ < var_266_4 + var_266_12 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play1101102066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1101102066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1101102067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1011ui_story"]) and arg_267_1.var_.characterEffect1011ui_story == nil then
				arg_267_1.var_.characterEffect1011ui_story = arg_267_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1011ui_story"]) then
				if arg_267_1.var_.characterEffect1011ui_story and not isNil(arg_267_1.actors_["1011ui_story"]) then
					arg_267_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1011ui_story"]) and arg_267_1.var_.characterEffect1011ui_story then
				arg_267_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0
			local var_270_2 = 0.25

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(1101102066).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 10 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 10)

				if (10 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 10)) > 0 and var_270_2 < var_270_5 then
					arg_267_1.talkMaxDuration = var_270_5

					if var_270_5 + var_270_1 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + var_270_1
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_6 = math.max(var_270_2, arg_267_1.talkMaxDuration)

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_6 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_1) / var_270_6

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_1 + var_270_6 and arg_267_1.time_ < var_270_1 + var_270_6 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play1101102067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1101102067
		arg_271_1.duration_ = 2.4

		local var_271_0 = {
			zh = 2.4,
			ja = 1.999999999999
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1101102068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1011ui_story"]) and arg_271_1.var_.characterEffect1011ui_story == nil then
				arg_271_1.var_.characterEffect1011ui_story = arg_271_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1011ui_story"]) then
				if arg_271_1.var_.characterEffect1011ui_story and not isNil(arg_271_1.actors_["1011ui_story"]) then
					arg_271_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1011ui_story"]) and arg_271_1.var_.characterEffect1011ui_story then
				arg_271_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_2 = 0
			local var_274_3 = 0.2

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_4 = arg_271_1:GetWordFromCfg(1101102067)
				local var_274_5 = arg_271_1:FormatText(var_274_4.content)

				arg_271_1.text_.text = var_274_5

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_7 = 8 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 8)

				if (8 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 8)) > 0 and var_274_3 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_2
					end
				end

				arg_271_1.text_.text = var_274_5
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102067", "story_v_side_new_1101102.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102067", "story_v_side_new_1101102.awb") / 1000

					if var_274_8 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_2
					end

					if var_274_4.prefab_name ~= "" and arg_271_1.actors_[var_274_4.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_4.prefab_name].transform, "story_v_side_new_1101102", "1101102067", "story_v_side_new_1101102.awb")

						arg_271_1:RecordAudio("1101102067", var_274_9)
						arg_271_1:RecordAudio("1101102067", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102067", "story_v_side_new_1101102.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102067", "story_v_side_new_1101102.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_3, arg_271_1.talkMaxDuration)

			if var_274_2 <= arg_271_1.time_ and arg_271_1.time_ < var_274_2 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_2) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_2 + var_274_10 and arg_271_1.time_ < var_274_2 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1101102068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1101102068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1101102069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["1011ui_story"]) and arg_275_1.var_.characterEffect1011ui_story == nil then
				arg_275_1.var_.characterEffect1011ui_story = arg_275_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["1011ui_story"]) then
				if arg_275_1.var_.characterEffect1011ui_story and not isNil(arg_275_1.actors_["1011ui_story"]) then
					arg_275_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_0)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["1011ui_story"]) and arg_275_1.var_.characterEffect1011ui_story then
				arg_275_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_278_1 = 0
			local var_278_2 = 1.1

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_3 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(1101102068).content)

				arg_275_1.text_.text = var_278_3

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 44 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 44)

				if (44 <= 0 and var_278_2 or var_278_2 * (utf8.len(var_278_3) / 44)) > 0 and var_278_2 < var_278_5 then
					arg_275_1.talkMaxDuration = var_278_5

					if var_278_5 + var_278_1 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + var_278_1
					end
				end

				arg_275_1.text_.text = var_278_3
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_6 = math.max(var_278_2, arg_275_1.talkMaxDuration)

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_6 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_1) / var_278_6

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_1 + var_278_6 and arg_275_1.time_ < var_278_1 + var_278_6 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1101102069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1101102069
		arg_279_1.duration_ = 5.97

		local var_279_0 = {
			zh = 5.966,
			ja = 5.466
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1101102070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1011ui_story = arg_279_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1011ui_story"].transform.position).z)
				arg_279_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1011ui_story"].transform.localEulerAngles = arg_279_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_279_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["1011ui_story"].transform.position).z)
				arg_279_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["1011ui_story"].transform.localEulerAngles = arg_279_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["1011ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1011ui_story == nil then
				arg_279_1.var_.characterEffect1011ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect1011ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect1011ui_story then
				arg_279_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action438")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_282_4 = 0
			local var_282_5 = 0.325

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_6 = arg_279_1:GetWordFromCfg(1101102069)
				local var_282_7 = arg_279_1:FormatText(var_282_6.content)

				arg_279_1.text_.text = var_282_7

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 13 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 13)

				if (13 <= 0 and var_282_5 or var_282_5 * (utf8.len(var_282_7) / 13)) > 0 and var_282_5 < var_282_9 then
					arg_279_1.talkMaxDuration = var_282_9

					if var_282_9 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_9 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_7
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102069", "story_v_side_new_1101102.awb") ~= 0 then
					local var_282_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102069", "story_v_side_new_1101102.awb") / 1000

					if var_282_10 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_4
					end

					if var_282_6.prefab_name ~= "" and arg_279_1.actors_[var_282_6.prefab_name] ~= nil then
						local var_282_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_6.prefab_name].transform, "story_v_side_new_1101102", "1101102069", "story_v_side_new_1101102.awb")

						arg_279_1:RecordAudio("1101102069", var_282_11)
						arg_279_1:RecordAudio("1101102069", var_282_11)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102069", "story_v_side_new_1101102.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102069", "story_v_side_new_1101102.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_12 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_12 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_12

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_12 and arg_279_1.time_ < var_282_4 + var_282_12 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play1101102070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1101102070
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1101102071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1011ui_story"]) and arg_283_1.var_.characterEffect1011ui_story == nil then
				arg_283_1.var_.characterEffect1011ui_story = arg_283_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1011ui_story"]) then
				if arg_283_1.var_.characterEffect1011ui_story and not isNil(arg_283_1.actors_["1011ui_story"]) then
					arg_283_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_0)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1011ui_story"]) and arg_283_1.var_.characterEffect1011ui_story then
				arg_283_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_286_1 = 0
			local var_286_2 = 0.9

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_3 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(1101102070).content)

				arg_283_1.text_.text = var_286_3

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 36 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 36)

				if (36 <= 0 and var_286_2 or var_286_2 * (utf8.len(var_286_3) / 36)) > 0 and var_286_2 < var_286_5 then
					arg_283_1.talkMaxDuration = var_286_5

					if var_286_5 + var_286_1 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + var_286_1
					end
				end

				arg_283_1.text_.text = var_286_3
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_6 = math.max(var_286_2, arg_283_1.talkMaxDuration)

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_6 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_1) / var_286_6

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_1 + var_286_6 and arg_283_1.time_ < var_286_1 + var_286_6 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1101102071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1101102071
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1101102072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.4

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_1 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(1101102071).content)

				arg_287_1.text_.text = var_290_1

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_3 = 16 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 16)

				if (16 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_1) / 16)) > 0 and var_290_0 < var_290_3 then
					arg_287_1.talkMaxDuration = var_290_3

					if var_290_3 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_3 + 0
					end
				end

				arg_287_1.text_.text = var_290_1
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_4 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_4

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1101102072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 1101102072
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play1101102073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.575

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(1101102072).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 23 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 23)

				if (23 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 23)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play1101102073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 1101102073
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play1101102074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.625

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(1101102073).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 25 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 25)

				if (25 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 25)) > 0 and var_298_0 < var_298_3 then
					arg_295_1.talkMaxDuration = var_298_3

					if var_298_3 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_3 + 0
					end
				end

				arg_295_1.text_.text = var_298_1
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_4 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_4

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play1101102074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 1101102074
		arg_299_1.duration_ = 5.4

		local var_299_0 = {
			zh = 5.4,
			ja = 4.2
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play1101102075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1011ui_story = arg_299_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1011ui_story"].transform.position).z)
				arg_299_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1011ui_story"].transform.localEulerAngles = arg_299_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_299_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["1011ui_story"].transform.position).z)
				arg_299_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["1011ui_story"].transform.localEulerAngles = arg_299_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["1011ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1011ui_story == nil then
				arg_299_1.var_.characterEffect1011ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect1011ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect1011ui_story then
				arg_299_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action483")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_302_4 = 0
			local var_302_5 = 0.1

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_4 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_6 = arg_299_1:GetWordFromCfg(1101102074)
				local var_302_7 = arg_299_1:FormatText(var_302_6.content)

				arg_299_1.text_.text = var_302_7

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_9 = 4 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 4)

				if (4 <= 0 and var_302_5 or var_302_5 * (utf8.len(var_302_7) / 4)) > 0 and var_302_5 < var_302_9 then
					arg_299_1.talkMaxDuration = var_302_9

					if var_302_9 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_9 + var_302_4
					end
				end

				arg_299_1.text_.text = var_302_7
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102074", "story_v_side_new_1101102.awb") ~= 0 then
					local var_302_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102074", "story_v_side_new_1101102.awb") / 1000

					if var_302_10 + var_302_4 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_4
					end

					if var_302_6.prefab_name ~= "" and arg_299_1.actors_[var_302_6.prefab_name] ~= nil then
						local var_302_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_6.prefab_name].transform, "story_v_side_new_1101102", "1101102074", "story_v_side_new_1101102.awb")

						arg_299_1:RecordAudio("1101102074", var_302_11)
						arg_299_1:RecordAudio("1101102074", var_302_11)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102074", "story_v_side_new_1101102.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102074", "story_v_side_new_1101102.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_12 = math.max(var_302_5, arg_299_1.talkMaxDuration)

			if var_302_4 <= arg_299_1.time_ and arg_299_1.time_ < var_302_4 + var_302_12 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_4) / var_302_12

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_4 + var_302_12 and arg_299_1.time_ < var_302_4 + var_302_12 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play1101102075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 1101102075
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play1101102076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1011ui_story"]) and arg_303_1.var_.characterEffect1011ui_story == nil then
				arg_303_1.var_.characterEffect1011ui_story = arg_303_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1011ui_story"]) then
				if arg_303_1.var_.characterEffect1011ui_story and not isNil(arg_303_1.actors_["1011ui_story"]) then
					arg_303_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1011ui_story"]) and arg_303_1.var_.characterEffect1011ui_story then
				arg_303_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_306_1 = 0
			local var_306_2 = 0.475

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(1101102075).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 19 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 19)

				if (19 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 19)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play1101102076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1101102076
		arg_307_1.duration_ = 8.47

		local var_307_0 = {
			zh = 8.466,
			ja = 7.166
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1101102077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1011ui_story = arg_307_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1011ui_story"].transform.position).z)
				arg_307_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1011ui_story"].transform.localEulerAngles = arg_307_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_307_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["1011ui_story"].transform.position).z)
				arg_307_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["1011ui_story"].transform.localEulerAngles = arg_307_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["1011ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1011ui_story == nil then
				arg_307_1.var_.characterEffect1011ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect1011ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect1011ui_story then
				arg_307_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_310_4 = 0

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.allBtn_.enabled = false
			end

			if arg_307_1.time_ >= var_310_4 + 4 and arg_307_1.time_ < var_310_4 + 4 + arg_310_0 then
				arg_307_1.allBtn_.enabled = true
			end

			local var_310_5 = 0
			local var_310_6 = 1.2

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_7 = arg_307_1:GetWordFromCfg(1101102076)
				local var_310_8 = arg_307_1:FormatText(var_310_7.content)

				arg_307_1.text_.text = var_310_8

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_10 = 48 <= 0 and var_310_6 or var_310_6 * (utf8.len(var_310_8) / 48)

				if (48 <= 0 and var_310_6 or var_310_6 * (utf8.len(var_310_8) / 48)) > 0 and var_310_6 < var_310_10 then
					arg_307_1.talkMaxDuration = var_310_10

					if var_310_10 + var_310_5 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_5
					end
				end

				arg_307_1.text_.text = var_310_8
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102076", "story_v_side_new_1101102.awb") ~= 0 then
					local var_310_11 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102076", "story_v_side_new_1101102.awb") / 1000

					if var_310_11 + var_310_5 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_11 + var_310_5
					end

					if var_310_7.prefab_name ~= "" and arg_307_1.actors_[var_310_7.prefab_name] ~= nil then
						local var_310_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_7.prefab_name].transform, "story_v_side_new_1101102", "1101102076", "story_v_side_new_1101102.awb")

						arg_307_1:RecordAudio("1101102076", var_310_12)
						arg_307_1:RecordAudio("1101102076", var_310_12)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102076", "story_v_side_new_1101102.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102076", "story_v_side_new_1101102.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_13 = math.max(var_310_6, arg_307_1.talkMaxDuration)

			if var_310_5 <= arg_307_1.time_ and arg_307_1.time_ < var_310_5 + var_310_13 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_5) / var_310_13

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_5 + var_310_13 and arg_307_1.time_ < var_310_5 + var_310_13 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play1101102077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1101102077
		arg_311_1.duration_ = 5.2

		local var_311_0 = {
			zh = 5.133,
			ja = 5.2
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1101102078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1011ui_story = arg_311_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1011ui_story"].transform.position).z)
				arg_311_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1011ui_story"].transform.localEulerAngles = arg_311_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_311_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1011ui_story"].transform.position).z)
				arg_311_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1011ui_story"].transform.localEulerAngles = arg_311_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["1011ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1011ui_story == nil then
				arg_311_1.var_.characterEffect1011ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect1011ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1011ui_story then
				arg_311_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action435")
			end

			local var_314_4 = 0

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.allBtn_.enabled = false
			end

			if arg_311_1.time_ >= var_314_4 + 2 and arg_311_1.time_ < var_314_4 + 2 + arg_314_0 then
				arg_311_1.allBtn_.enabled = true
			end

			local var_314_5 = 0
			local var_314_6 = 0.575

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_7 = arg_311_1:GetWordFromCfg(1101102077)
				local var_314_8 = arg_311_1:FormatText(var_314_7.content)

				arg_311_1.text_.text = var_314_8

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_10 = 23 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 23)

				if (23 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 23)) > 0 and var_314_6 < var_314_10 then
					arg_311_1.talkMaxDuration = var_314_10

					if var_314_10 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_5
					end
				end

				arg_311_1.text_.text = var_314_8
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102077", "story_v_side_new_1101102.awb") ~= 0 then
					local var_314_11 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102077", "story_v_side_new_1101102.awb") / 1000

					if var_314_11 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_11 + var_314_5
					end

					if var_314_7.prefab_name ~= "" and arg_311_1.actors_[var_314_7.prefab_name] ~= nil then
						local var_314_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_7.prefab_name].transform, "story_v_side_new_1101102", "1101102077", "story_v_side_new_1101102.awb")

						arg_311_1:RecordAudio("1101102077", var_314_12)
						arg_311_1:RecordAudio("1101102077", var_314_12)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102077", "story_v_side_new_1101102.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102077", "story_v_side_new_1101102.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_13 = math.max(var_314_6, arg_311_1.talkMaxDuration)

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_13 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_5) / var_314_13

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_5 + var_314_13 and arg_311_1.time_ < var_314_5 + var_314_13 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play1101102078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1101102078
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play1101102079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1011ui_story"]) and arg_315_1.var_.characterEffect1011ui_story == nil then
				arg_315_1.var_.characterEffect1011ui_story = arg_315_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1011ui_story"]) then
				if arg_315_1.var_.characterEffect1011ui_story and not isNil(arg_315_1.actors_["1011ui_story"]) then
					arg_315_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_315_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1011ui_story"]) and arg_315_1.var_.characterEffect1011ui_story then
				arg_315_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_315_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_318_1 = 0
			local var_318_2 = 1.05

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(1101102078).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 42 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 42)

				if (42 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 42)) > 0 and var_318_2 < var_318_5 then
					arg_315_1.talkMaxDuration = var_318_5

					if var_318_5 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + var_318_1
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_6 = math.max(var_318_2, arg_315_1.talkMaxDuration)

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_6 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_1) / var_318_6

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_1 + var_318_6 and arg_315_1.time_ < var_318_1 + var_318_6 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play1101102079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1101102079
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1101102080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.35

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_1 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(1101102079).content)

				arg_319_1.text_.text = var_322_1

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_3 = 14 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 14)

				if (14 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 14)) > 0 and var_322_0 < var_322_3 then
					arg_319_1.talkMaxDuration = var_322_3

					if var_322_3 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_3 + 0
					end
				end

				arg_319_1.text_.text = var_322_1
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_4 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_4

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1101102080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1101102080
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1101102081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.mask_.enabled = true
				arg_323_1.mask_.raycastTarget = false

				arg_323_1:SetGaussion(false)
			end

			local var_326_0 = 0.433333333333333

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				local var_326_1 = Color.New(1, 0, 0)

				var_326_1.a = Mathf.Lerp(1, 0, (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.mask_.color = var_326_1
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				local var_326_2 = Color.New(1, 0, 0)

				arg_323_1.mask_.enabled = false
				var_326_2.a = 0
				arg_323_1.mask_.color = var_326_2
			end

			local var_326_3 = arg_323_1.actors_["1011ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1011ui_story = var_326_3.localPosition
			end

			local var_326_4 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				var_326_3.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_4)
				var_326_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_3.position).x, (manager.ui.mainCamera.transform.position - var_326_3.position).y, (manager.ui.mainCamera.transform.position - var_326_3.position).z)
				var_326_3.localEulerAngles.z = 0
				var_326_3.localEulerAngles.x = 0
				var_326_3.localEulerAngles = var_326_3.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				var_326_3.localPosition = Vector3.New(0, 100, 0)
				var_326_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_3.position).x, (manager.ui.mainCamera.transform.position - var_326_3.position).y, (manager.ui.mainCamera.transform.position - var_326_3.position).z)
				var_326_3.localEulerAngles.z = 0
				var_326_3.localEulerAngles.x = 0
				var_326_3.localEulerAngles = var_326_3.localEulerAngles
			end

			local var_326_5 = 0
			local var_326_6 = 0.8

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0

				arg_323_1.dialog_:SetActive(true)

				arg_323_1.dialogCg_.alpha = 0

				local var_326_7 = LeanTween.value(arg_323_1.dialog_, 0, 1, 0.3)

				var_326_7:setOnUpdate(LuaHelper.FloatAction(function(arg_327_0)
					arg_323_1.dialogCg_.alpha = arg_327_0
				end))
				var_326_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_323_1.dialog_)
					var_326_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_323_1.duration_ = arg_323_1.duration_ + 0.3

				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_8 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(1101102080).content)

				arg_323_1.text_.text = var_326_8

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_10 = 32 <= 0 and var_326_6 or var_326_6 * (utf8.len(var_326_8) / 32)

				if (32 <= 0 and var_326_6 or var_326_6 * (utf8.len(var_326_8) / 32)) > 0 and var_326_6 < var_326_10 then
					arg_323_1.talkMaxDuration = var_326_10
					var_326_5 = var_326_5 + 0.3

					if var_326_10 + var_326_5 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_5
					end
				end

				arg_323_1.text_.text = var_326_8
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_11 = var_326_5 + 0.3
			local var_326_12 = math.max(var_326_6, arg_323_1.talkMaxDuration)

			if var_326_5 + 0.3 <= arg_323_1.time_ and arg_323_1.time_ < var_326_11 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_11) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_11 + var_326_12 and arg_323_1.time_ < var_326_11 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play1101102081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1101102081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1101102082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.65

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(1101102081).content)

				arg_329_1.text_.text = var_332_1

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_3 = 35 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 35)

				if (35 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 35)) > 0 and var_332_0 < var_332_3 then
					arg_329_1.talkMaxDuration = var_332_3

					if var_332_3 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_3 + 0
					end
				end

				arg_329_1.text_.text = var_332_1
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_4 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_4

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1101102082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1101102082
		arg_333_1.duration_ = 3.07

		local var_333_0 = {
			zh = 3.066,
			ja = 2.166
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1101102083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.15

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011_split_9")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_1 = arg_333_1:GetWordFromCfg(1101102082)
				local var_336_2 = arg_333_1:FormatText(var_336_1.content)

				arg_333_1.text_.text = var_336_2

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 6 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 6)

				if (6 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 6)) > 0 and var_336_0 < var_336_4 then
					arg_333_1.talkMaxDuration = var_336_4

					if var_336_4 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_4 + 0
					end
				end

				arg_333_1.text_.text = var_336_2
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102082", "story_v_side_new_1101102.awb") ~= 0 then
					local var_336_5 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102082", "story_v_side_new_1101102.awb") / 1000

					if var_336_5 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + 0
					end

					if var_336_1.prefab_name ~= "" and arg_333_1.actors_[var_336_1.prefab_name] ~= nil then
						local var_336_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_1.prefab_name].transform, "story_v_side_new_1101102", "1101102082", "story_v_side_new_1101102.awb")

						arg_333_1:RecordAudio("1101102082", var_336_6)
						arg_333_1:RecordAudio("1101102082", var_336_6)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102082", "story_v_side_new_1101102.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102082", "story_v_side_new_1101102.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1101102083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1101102083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1101102084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1011ui_story = arg_337_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1011ui_story"].transform.position).z)
				arg_337_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1011ui_story"].transform.localEulerAngles = arg_337_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_337_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1011ui_story"].transform.position).z)
				arg_337_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1011ui_story"].transform.localEulerAngles = arg_337_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_340_1 = 0
			local var_340_2 = 0.95

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(1101102083).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 38 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 38)

				if (38 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 38)) > 0 and var_340_2 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5

					if var_340_5 + var_340_1 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_1
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_6 = math.max(var_340_2, arg_337_1.talkMaxDuration)

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_6 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_1) / var_340_6

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_1 + var_340_6 and arg_337_1.time_ < var_340_1 + var_340_6 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play1101102084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1101102084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1101102085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1011ui_story = arg_341_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1011ui_story"].transform.position).z)
				arg_341_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1011ui_story"].transform.localEulerAngles = arg_341_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_341_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1011ui_story"].transform.position).z)
				arg_341_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1011ui_story"].transform.localEulerAngles = arg_341_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1011ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1011ui_story == nil then
				arg_341_1.var_.characterEffect1011ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1011ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_2)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1011ui_story then
				arg_341_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_2")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_344_3 = 0
			local var_344_4 = 0.45

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_3 + arg_344_0 then
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

				local var_344_5 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(1101102084).content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 18 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_5) / 18)

				if (18 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_5) / 18)) > 0 and var_344_4 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_3 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_3
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_8 = math.max(var_344_4, arg_341_1.talkMaxDuration)

			if var_344_3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_3 + var_344_8 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_3) / var_344_8

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_3 + var_344_8 and arg_341_1.time_ < var_344_3 + var_344_8 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play1101102085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1101102085
		arg_345_1.duration_ = 4.5

		local var_345_0 = {
			zh = 3.833,
			ja = 4.5
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1101102086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1011ui_story = arg_345_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1011ui_story"].transform.position).z)
				arg_345_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1011ui_story"].transform.localEulerAngles = arg_345_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_345_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1011ui_story"].transform.position).z)
				arg_345_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1011ui_story"].transform.localEulerAngles = arg_345_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["1011ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1011ui_story == nil then
				arg_345_1.var_.characterEffect1011ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect1011ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1011ui_story then
				arg_345_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_348_4 = 0
			local var_348_5 = 0.275

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_6 = arg_345_1:GetWordFromCfg(1101102085)
				local var_348_7 = arg_345_1:FormatText(var_348_6.content)

				arg_345_1.text_.text = var_348_7

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_9 = 11 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 11)

				if (11 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 11)) > 0 and var_348_5 < var_348_9 then
					arg_345_1.talkMaxDuration = var_348_9

					if var_348_9 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_9 + var_348_4
					end
				end

				arg_345_1.text_.text = var_348_7
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102085", "story_v_side_new_1101102.awb") ~= 0 then
					local var_348_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102085", "story_v_side_new_1101102.awb") / 1000

					if var_348_10 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_4
					end

					if var_348_6.prefab_name ~= "" and arg_345_1.actors_[var_348_6.prefab_name] ~= nil then
						local var_348_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_6.prefab_name].transform, "story_v_side_new_1101102", "1101102085", "story_v_side_new_1101102.awb")

						arg_345_1:RecordAudio("1101102085", var_348_11)
						arg_345_1:RecordAudio("1101102085", var_348_11)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102085", "story_v_side_new_1101102.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102085", "story_v_side_new_1101102.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_12 = math.max(var_348_5, arg_345_1.talkMaxDuration)

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_12 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_4) / var_348_12

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_4 + var_348_12 and arg_345_1.time_ < var_348_4 + var_348_12 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play1101102086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1101102086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1101102087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1011ui_story"]) and arg_349_1.var_.characterEffect1011ui_story == nil then
				arg_349_1.var_.characterEffect1011ui_story = arg_349_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1011ui_story"]) then
				if arg_349_1.var_.characterEffect1011ui_story and not isNil(arg_349_1.actors_["1011ui_story"]) then
					arg_349_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_0)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1011ui_story"]) and arg_349_1.var_.characterEffect1011ui_story then
				arg_349_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_352_1 = 0
			local var_352_2 = 0.55

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_3 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(1101102086).content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 22 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 22)

				if (22 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 22)) > 0 and var_352_2 < var_352_5 then
					arg_349_1.talkMaxDuration = var_352_5

					if var_352_5 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + var_352_1
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_6 = math.max(var_352_2, arg_349_1.talkMaxDuration)

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_6 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_1) / var_352_6

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_1 + var_352_6 and arg_349_1.time_ < var_352_1 + var_352_6 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play1101102087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1101102087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1101102088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 1.225

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
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

				local var_356_1 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(1101102087).content)

				arg_353_1.text_.text = var_356_1

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_3 = 49 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 49)

				if (49 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 49)) > 0 and var_356_0 < var_356_3 then
					arg_353_1.talkMaxDuration = var_356_3

					if var_356_3 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_3 + 0
					end
				end

				arg_353_1.text_.text = var_356_1
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_4 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_4

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1101102088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1101102088
		arg_357_1.duration_ = 8.03

		local var_357_0 = {
			zh = 4.9,
			ja = 8.033
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1101102089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1011ui_story = arg_357_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).z)
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles = arg_357_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_357_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).z)
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles = arg_357_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["1011ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1011ui_story == nil then
				arg_357_1.var_.characterEffect1011ui_story = var_360_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 and not isNil(var_360_1) then
				if arg_357_1.var_.characterEffect1011ui_story and not isNil(var_360_1) then
					arg_357_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1011ui_story then
				arg_357_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_360_4 = 0
			local var_360_5 = 0.625

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:GetWordFromCfg(1101102088)
				local var_360_7 = arg_357_1:FormatText(var_360_6.content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 25 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 25)

				if (25 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 25)) > 0 and var_360_5 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102088", "story_v_side_new_1101102.awb") ~= 0 then
					local var_360_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102088", "story_v_side_new_1101102.awb") / 1000

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end

					if var_360_6.prefab_name ~= "" and arg_357_1.actors_[var_360_6.prefab_name] ~= nil then
						local var_360_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_6.prefab_name].transform, "story_v_side_new_1101102", "1101102088", "story_v_side_new_1101102.awb")

						arg_357_1:RecordAudio("1101102088", var_360_11)
						arg_357_1:RecordAudio("1101102088", var_360_11)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102088", "story_v_side_new_1101102.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102088", "story_v_side_new_1101102.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_12 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_12 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_12

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_12 and arg_357_1.time_ < var_360_4 + var_360_12 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play1101102089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1101102089
		arg_361_1.duration_ = 9

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1101102090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 2 < arg_361_1.time_ and arg_361_1.time_ <= 2 + arg_364_0 then
				local var_364_0 = arg_361_1.bgs_.ST01

				arg_361_1.bgs_.ST01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_364_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_364_1 = var_364_0:GetComponent("SpriteRenderer")

				if var_364_1 and var_364_1.sprite then
					local var_364_2 = 2 * (var_364_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_364_0.transform.localScale = Vector3.New(var_364_2 / var_364_1.sprite.bounds.size.y < var_364_2 * manager.ui.mainCameraCom_.aspect / var_364_1.sprite.bounds.size.x and var_364_2 * manager.ui.mainCameraCom_.aspect / var_364_1.sprite.bounds.size.x or var_364_2 / var_364_1.sprite.bounds.size.y, var_364_2 / var_364_1.sprite.bounds.size.y < var_364_2 * manager.ui.mainCameraCom_.aspect / var_364_1.sprite.bounds.size.x and var_364_2 * manager.ui.mainCameraCom_.aspect / var_364_1.sprite.bounds.size.x or var_364_2 / var_364_1.sprite.bounds.size.y, 0)
				end

				for iter_364_0, iter_364_1 in pairs(arg_361_1.bgs_) do
					if iter_364_0 ~= "ST01" then
						iter_364_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_364_3 = 0

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_3 + arg_364_0 then
				arg_361_1.mask_.enabled = true
				arg_361_1.mask_.raycastTarget = true

				arg_361_1:SetGaussion(false)
			end

			local var_364_4 = 2

			if var_364_3 <= arg_361_1.time_ and arg_361_1.time_ < var_364_3 + var_364_4 then
				local var_364_5 = Color.New(0, 0, 0)

				var_364_5.a = Mathf.Lerp(0, 1, (arg_361_1.time_ - var_364_3) / var_364_4)
				arg_361_1.mask_.color = var_364_5
			end

			if arg_361_1.time_ >= var_364_3 + var_364_4 and arg_361_1.time_ < var_364_3 + var_364_4 + arg_364_0 then
				local var_364_6 = Color.New(0, 0, 0)

				var_364_6.a = 1
				arg_361_1.mask_.color = var_364_6
			end

			local var_364_7 = 2

			if 2 < arg_361_1.time_ and arg_361_1.time_ <= var_364_7 + arg_364_0 then
				arg_361_1.mask_.enabled = true
				arg_361_1.mask_.raycastTarget = true

				arg_361_1:SetGaussion(false)
			end

			local var_364_8 = 2

			if var_364_7 <= arg_361_1.time_ and arg_361_1.time_ < var_364_7 + var_364_8 then
				local var_364_9 = Color.New(0, 0, 0)

				var_364_9.a = Mathf.Lerp(1, 0, (arg_361_1.time_ - var_364_7) / var_364_8)
				arg_361_1.mask_.color = var_364_9
			end

			if arg_361_1.time_ >= var_364_7 + var_364_8 and arg_361_1.time_ < var_364_7 + var_364_8 + arg_364_0 then
				local var_364_10 = Color.New(0, 0, 0)

				arg_361_1.mask_.enabled = false
				var_364_10.a = 0
				arg_361_1.mask_.color = var_364_10
			end

			local var_364_11 = arg_361_1.actors_["1011ui_story"].transform

			if 2 < arg_361_1.time_ and arg_361_1.time_ <= 2 + arg_364_0 then
				arg_361_1.var_.moveOldPos1011ui_story = var_364_11.localPosition
			end

			local var_364_12 = 0.001

			if 2 <= arg_361_1.time_ and arg_361_1.time_ < 2 + var_364_12 then
				var_364_11.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_361_1.time_ - 2) / var_364_12)
				var_364_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_11.position).x, (manager.ui.mainCamera.transform.position - var_364_11.position).y, (manager.ui.mainCamera.transform.position - var_364_11.position).z)
				var_364_11.localEulerAngles.z = 0
				var_364_11.localEulerAngles.x = 0
				var_364_11.localEulerAngles = var_364_11.localEulerAngles
			end

			if arg_361_1.time_ >= 2 + var_364_12 and arg_361_1.time_ < 2 + var_364_12 + arg_364_0 then
				var_364_11.localPosition = Vector3.New(0, 100, 0)
				var_364_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_11.position).x, (manager.ui.mainCamera.transform.position - var_364_11.position).y, (manager.ui.mainCamera.transform.position - var_364_11.position).z)
				var_364_11.localEulerAngles.z = 0
				var_364_11.localEulerAngles.x = 0
				var_364_11.localEulerAngles = var_364_11.localEulerAngles
			end

			if arg_361_1.frameCnt_ <= 1 then
				arg_361_1.dialog_:SetActive(false)
			end

			local var_364_13 = 4
			local var_364_14 = 0.8

			if 4 < arg_361_1.time_ and arg_361_1.time_ <= var_364_13 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0

				arg_361_1.dialog_:SetActive(true)

				arg_361_1.dialogCg_.alpha = 0

				local var_364_15 = LeanTween.value(arg_361_1.dialog_, 0, 1, 0.3)

				var_364_15:setOnUpdate(LuaHelper.FloatAction(function(arg_365_0)
					arg_361_1.dialogCg_.alpha = arg_365_0
				end))
				var_364_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_361_1.dialog_)
					var_364_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_361_1.duration_ = arg_361_1.duration_ + 0.3

				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_16 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1101102089).content)

				arg_361_1.text_.text = var_364_16

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_18 = 32 <= 0 and var_364_14 or var_364_14 * (utf8.len(var_364_16) / 32)

				if (32 <= 0 and var_364_14 or var_364_14 * (utf8.len(var_364_16) / 32)) > 0 and var_364_14 < var_364_18 then
					arg_361_1.talkMaxDuration = var_364_18
					var_364_13 = var_364_13 + 0.3

					if var_364_18 + var_364_13 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_18 + var_364_13
					end
				end

				arg_361_1.text_.text = var_364_16
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_19 = var_364_13 + 0.3
			local var_364_20 = math.max(var_364_14, arg_361_1.talkMaxDuration)

			if var_364_13 + 0.3 <= arg_361_1.time_ and arg_361_1.time_ < var_364_19 + var_364_20 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_19) / var_364_20

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_19 + var_364_20 and arg_361_1.time_ < var_364_19 + var_364_20 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play1101102090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1101102090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1101102091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 1.75

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(1101102090).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 70 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 70)

				if (70 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 70)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1101102091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1101102091
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1101102092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.8

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(1101102091).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 32 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 32)

				if (32 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 32)) > 0 and var_374_0 < var_374_3 then
					arg_371_1.talkMaxDuration = var_374_3

					if var_374_3 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_3 + 0
					end
				end

				arg_371_1.text_.text = var_374_1
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_4 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_4

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1101102092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1101102092
		arg_375_1.duration_ = 7.87

		local var_375_0 = {
			zh = 6.9,
			ja = 7.866
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1101102093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1011ui_story = arg_375_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1011ui_story"].transform.position).z)
				arg_375_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1011ui_story"].transform.localEulerAngles = arg_375_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_375_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1011ui_story"].transform.position).z)
				arg_375_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1011ui_story"].transform.localEulerAngles = arg_375_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["1011ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1011ui_story == nil then
				arg_375_1.var_.characterEffect1011ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1011ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1011ui_story then
				arg_375_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_378_4 = 0
			local var_378_5 = 0.65

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0

				arg_375_1.dialog_:SetActive(true)

				arg_375_1.dialogCg_.alpha = 0

				local var_378_6 = LeanTween.value(arg_375_1.dialog_, 0, 1, 0.3)

				var_378_6:setOnUpdate(LuaHelper.FloatAction(function(arg_379_0)
					arg_375_1.dialogCg_.alpha = arg_379_0
				end))
				var_378_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_375_1.dialog_)
					var_378_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_375_1.duration_ = arg_375_1.duration_ + 0.3

				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_7 = arg_375_1:GetWordFromCfg(1101102092)
				local var_378_8 = arg_375_1:FormatText(var_378_7.content)

				arg_375_1.text_.text = var_378_8

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_10 = 26 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_8) / 26)

				if (26 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_8) / 26)) > 0 and var_378_5 < var_378_10 then
					arg_375_1.talkMaxDuration = var_378_10
					var_378_4 = var_378_4 + 0.3

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_8
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102092", "story_v_side_new_1101102.awb") ~= 0 then
					local var_378_11 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102092", "story_v_side_new_1101102.awb") / 1000

					if var_378_11 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_11 + var_378_4
					end

					if var_378_7.prefab_name ~= "" and arg_375_1.actors_[var_378_7.prefab_name] ~= nil then
						local var_378_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_7.prefab_name].transform, "story_v_side_new_1101102", "1101102092", "story_v_side_new_1101102.awb")

						arg_375_1:RecordAudio("1101102092", var_378_12)
						arg_375_1:RecordAudio("1101102092", var_378_12)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102092", "story_v_side_new_1101102.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102092", "story_v_side_new_1101102.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_13 = var_378_4 + 0.3
			local var_378_14 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 + 0.3 <= arg_375_1.time_ and arg_375_1.time_ < var_378_13 + var_378_14 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_13) / var_378_14

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_13 + var_378_14 and arg_375_1.time_ < var_378_13 + var_378_14 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play1101102093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1101102093
		arg_381_1.duration_ = 8.87

		local var_381_0 = {
			zh = 8.866,
			ja = 6.766
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1101102094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.875

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_1 = arg_381_1:GetWordFromCfg(1101102093)
				local var_384_2 = arg_381_1:FormatText(var_384_1.content)

				arg_381_1.text_.text = var_384_2

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 35 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 35)

				if (35 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 35)) > 0 and var_384_0 < var_384_4 then
					arg_381_1.talkMaxDuration = var_384_4

					if var_384_4 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_4 + 0
					end
				end

				arg_381_1.text_.text = var_384_2
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102093", "story_v_side_new_1101102.awb") ~= 0 then
					local var_384_5 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102093", "story_v_side_new_1101102.awb") / 1000

					if var_384_5 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + 0
					end

					if var_384_1.prefab_name ~= "" and arg_381_1.actors_[var_384_1.prefab_name] ~= nil then
						local var_384_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_1.prefab_name].transform, "story_v_side_new_1101102", "1101102093", "story_v_side_new_1101102.awb")

						arg_381_1:RecordAudio("1101102093", var_384_6)
						arg_381_1:RecordAudio("1101102093", var_384_6)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102093", "story_v_side_new_1101102.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102093", "story_v_side_new_1101102.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play1101102094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1101102094
		arg_385_1.duration_ = 11.83

		local var_385_0 = {
			zh = 8.566,
			ja = 11.833
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1101102095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.725

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:GetWordFromCfg(1101102094)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 29 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 29)

				if (29 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 29)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102094", "story_v_side_new_1101102.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102094", "story_v_side_new_1101102.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_side_new_1101102", "1101102094", "story_v_side_new_1101102.awb")

						arg_385_1:RecordAudio("1101102094", var_388_6)
						arg_385_1:RecordAudio("1101102094", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102094", "story_v_side_new_1101102.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102094", "story_v_side_new_1101102.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1101102095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1101102095
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1101102096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1011ui_story = arg_389_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1011ui_story"].transform.position).z)
				arg_389_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1011ui_story"].transform.localEulerAngles = arg_389_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_389_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1011ui_story"].transform.position).z)
				arg_389_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1011ui_story"].transform.localEulerAngles = arg_389_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_392_1 = 0
			local var_392_2 = 0.05

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_3 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(1101102095).content)

				arg_389_1.text_.text = var_392_3

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_5 = 2 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 2)

				if (2 <= 0 and var_392_2 or var_392_2 * (utf8.len(var_392_3) / 2)) > 0 and var_392_2 < var_392_5 then
					arg_389_1.talkMaxDuration = var_392_5

					if var_392_5 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + var_392_1
					end
				end

				arg_389_1.text_.text = var_392_3
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_6 = math.max(var_392_2, arg_389_1.talkMaxDuration)

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_6 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_1) / var_392_6

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_1 + var_392_6 and arg_389_1.time_ < var_392_1 + var_392_6 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play1101102096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1101102096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1101102097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0.8

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(1101102096).content)

				arg_393_1.text_.text = var_396_1

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_3 = 32 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 32)

				if (32 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 32)) > 0 and var_396_0 < var_396_3 then
					arg_393_1.talkMaxDuration = var_396_3

					if var_396_3 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_3 + 0
					end
				end

				arg_393_1.text_.text = var_396_1
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_4 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_4

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play1101102097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1101102097
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1101102098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0.075

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(1101102097).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 3 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 3)

				if (3 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 3)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1101102098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1101102098
		arg_401_1.duration_ = 7.6

		local var_401_0 = {
			zh = 5.333,
			ja = 7.6
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1101102099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos1011ui_story = arg_401_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_404_0 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 then
				arg_401_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_401_1.time_ - 0) / var_404_0)
				arg_401_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1011ui_story"].transform.position).z)
				arg_401_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1011ui_story"].transform.localEulerAngles = arg_401_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 then
				arg_401_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_401_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1011ui_story"].transform.position).z)
				arg_401_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1011ui_story"].transform.localEulerAngles = arg_401_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_404_1 = arg_401_1.actors_["1011ui_story"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect1011ui_story == nil then
				arg_401_1.var_.characterEffect1011ui_story = var_404_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_2 and not isNil(var_404_1) then
				if arg_401_1.var_.characterEffect1011ui_story and not isNil(var_404_1) then
					arg_401_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= 0 + var_404_2 and arg_401_1.time_ < 0 + var_404_2 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect1011ui_story then
				arg_401_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_404_4 = 0
			local var_404_5 = 0.55

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_4 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_6 = arg_401_1:GetWordFromCfg(1101102098)
				local var_404_7 = arg_401_1:FormatText(var_404_6.content)

				arg_401_1.text_.text = var_404_7

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_9 = 22 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_7) / 22)

				if (22 <= 0 and var_404_5 or var_404_5 * (utf8.len(var_404_7) / 22)) > 0 and var_404_5 < var_404_9 then
					arg_401_1.talkMaxDuration = var_404_9

					if var_404_9 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_9 + var_404_4
					end
				end

				arg_401_1.text_.text = var_404_7
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102098", "story_v_side_new_1101102.awb") ~= 0 then
					local var_404_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102098", "story_v_side_new_1101102.awb") / 1000

					if var_404_10 + var_404_4 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_10 + var_404_4
					end

					if var_404_6.prefab_name ~= "" and arg_401_1.actors_[var_404_6.prefab_name] ~= nil then
						local var_404_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_6.prefab_name].transform, "story_v_side_new_1101102", "1101102098", "story_v_side_new_1101102.awb")

						arg_401_1:RecordAudio("1101102098", var_404_11)
						arg_401_1:RecordAudio("1101102098", var_404_11)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102098", "story_v_side_new_1101102.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102098", "story_v_side_new_1101102.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_12 = math.max(var_404_5, arg_401_1.talkMaxDuration)

			if var_404_4 <= arg_401_1.time_ and arg_401_1.time_ < var_404_4 + var_404_12 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_4) / var_404_12

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_4 + var_404_12 and arg_401_1.time_ < var_404_4 + var_404_12 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play1101102099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1101102099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1101102100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["1011ui_story"]) and arg_405_1.var_.characterEffect1011ui_story == nil then
				arg_405_1.var_.characterEffect1011ui_story = arg_405_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_0 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["1011ui_story"]) then
				if arg_405_1.var_.characterEffect1011ui_story and not isNil(arg_405_1.actors_["1011ui_story"]) then
					arg_405_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_405_1.time_ - 0) / var_408_0)
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["1011ui_story"]) and arg_405_1.var_.characterEffect1011ui_story then
				arg_405_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_408_1 = 0
			local var_408_2 = 0.55

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_3 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(1101102099).content)

				arg_405_1.text_.text = var_408_3

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_5 = 22 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 22)

				if (22 <= 0 and var_408_2 or var_408_2 * (utf8.len(var_408_3) / 22)) > 0 and var_408_2 < var_408_5 then
					arg_405_1.talkMaxDuration = var_408_5

					if var_408_5 + var_408_1 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + var_408_1
					end
				end

				arg_405_1.text_.text = var_408_3
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_6 = math.max(var_408_2, arg_405_1.talkMaxDuration)

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_6 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_1) / var_408_6

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_1 + var_408_6 and arg_405_1.time_ < var_408_1 + var_408_6 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1101102100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1101102100
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1101102101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0.175

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_1 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(1101102100).content)

				arg_409_1.text_.text = var_412_1

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_3 = 7 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 7)

				if (7 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_1) / 7)) > 0 and var_412_0 < var_412_3 then
					arg_409_1.talkMaxDuration = var_412_3

					if var_412_3 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_3 + 0
					end
				end

				arg_409_1.text_.text = var_412_1
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_4 = math.max(var_412_0, arg_409_1.talkMaxDuration)

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_4 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - 0) / var_412_4

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= 0 + var_412_4 and arg_409_1.time_ < 0 + var_412_4 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1101102101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1101102101
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1101102102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:AudioAction("play", "effect", "se_story_221_00", "se_story_221_00_cat", "")
			end

			local var_416_1 = 0
			local var_416_2 = 0.05

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[581].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_catb")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_3 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(1101102101).content)

				arg_413_1.text_.text = var_416_3

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 2 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 2)

				if (2 <= 0 and var_416_2 or var_416_2 * (utf8.len(var_416_3) / 2)) > 0 and var_416_2 < var_416_5 then
					arg_413_1.talkMaxDuration = var_416_5

					if var_416_5 + var_416_1 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_5 + var_416_1
					end
				end

				arg_413_1.text_.text = var_416_3
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_6 = math.max(var_416_2, arg_413_1.talkMaxDuration)

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_6 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_1) / var_416_6

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_1 + var_416_6 and arg_413_1.time_ < var_416_1 + var_416_6 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1101102102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1101102102
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1101102103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0.975

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, false)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_1 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(1101102102).content)

				arg_417_1.text_.text = var_420_1

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_3 = 39 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 39)

				if (39 <= 0 and var_420_0 or var_420_0 * (utf8.len(var_420_1) / 39)) > 0 and var_420_0 < var_420_3 then
					arg_417_1.talkMaxDuration = var_420_3

					if var_420_3 + 0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_3 + 0
					end
				end

				arg_417_1.text_.text = var_420_1
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_4 = math.max(var_420_0, arg_417_1.talkMaxDuration)

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_4 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - 0) / var_420_4

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= 0 + var_420_4 and arg_417_1.time_ < 0 + var_420_4 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1101102103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1101102103
		arg_421_1.duration_ = 5.93

		local var_421_0 = {
			zh = 5.933,
			ja = 4.433
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1101102104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1011ui_story = arg_421_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_424_0 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 then
				arg_421_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_421_1.time_ - 0) / var_424_0)
				arg_421_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1011ui_story"].transform.position).z)
				arg_421_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1011ui_story"].transform.localEulerAngles = arg_421_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 then
				arg_421_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_421_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_421_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_421_1.actors_["1011ui_story"].transform.position).z)
				arg_421_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_421_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_421_1.actors_["1011ui_story"].transform.localEulerAngles = arg_421_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_424_1 = arg_421_1.actors_["1011ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1011ui_story == nil then
				arg_421_1.var_.characterEffect1011ui_story = var_424_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_2 and not isNil(var_424_1) then
				if arg_421_1.var_.characterEffect1011ui_story and not isNil(var_424_1) then
					arg_421_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_2 and arg_421_1.time_ < 0 + var_424_2 + arg_424_0 and not isNil(var_424_1) and arg_421_1.var_.characterEffect1011ui_story then
				arg_421_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_424_4 = 0
			local var_424_5 = 0.8

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_4 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_6 = arg_421_1:GetWordFromCfg(1101102103)
				local var_424_7 = arg_421_1:FormatText(var_424_6.content)

				arg_421_1.text_.text = var_424_7

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_9 = 32 <= 0 and var_424_5 or var_424_5 * (utf8.len(var_424_7) / 32)

				if (32 <= 0 and var_424_5 or var_424_5 * (utf8.len(var_424_7) / 32)) > 0 and var_424_5 < var_424_9 then
					arg_421_1.talkMaxDuration = var_424_9

					if var_424_9 + var_424_4 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_9 + var_424_4
					end
				end

				arg_421_1.text_.text = var_424_7
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102103", "story_v_side_new_1101102.awb") ~= 0 then
					local var_424_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102103", "story_v_side_new_1101102.awb") / 1000

					if var_424_10 + var_424_4 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_10 + var_424_4
					end

					if var_424_6.prefab_name ~= "" and arg_421_1.actors_[var_424_6.prefab_name] ~= nil then
						local var_424_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_6.prefab_name].transform, "story_v_side_new_1101102", "1101102103", "story_v_side_new_1101102.awb")

						arg_421_1:RecordAudio("1101102103", var_424_11)
						arg_421_1:RecordAudio("1101102103", var_424_11)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102103", "story_v_side_new_1101102.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102103", "story_v_side_new_1101102.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_12 = math.max(var_424_5, arg_421_1.talkMaxDuration)

			if var_424_4 <= arg_421_1.time_ and arg_421_1.time_ < var_424_4 + var_424_12 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_4) / var_424_12

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_4 + var_424_12 and arg_421_1.time_ < var_424_4 + var_424_12 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play1101102104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1101102104
		arg_425_1.duration_ = 4.5

		local var_425_0 = {
			zh = 4.5,
			ja = 3.766
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1101102105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_428_0 = 0
			local var_428_1 = 0.55

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_2 = arg_425_1:GetWordFromCfg(1101102104)
				local var_428_3 = arg_425_1:FormatText(var_428_2.content)

				arg_425_1.text_.text = var_428_3

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_5 = 22 <= 0 and var_428_1 or var_428_1 * (utf8.len(var_428_3) / 22)

				if (22 <= 0 and var_428_1 or var_428_1 * (utf8.len(var_428_3) / 22)) > 0 and var_428_1 < var_428_5 then
					arg_425_1.talkMaxDuration = var_428_5

					if var_428_5 + var_428_0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + var_428_0
					end
				end

				arg_425_1.text_.text = var_428_3
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102104", "story_v_side_new_1101102.awb") ~= 0 then
					local var_428_6 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102104", "story_v_side_new_1101102.awb") / 1000

					if var_428_6 + var_428_0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_6 + var_428_0
					end

					if var_428_2.prefab_name ~= "" and arg_425_1.actors_[var_428_2.prefab_name] ~= nil then
						local var_428_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_2.prefab_name].transform, "story_v_side_new_1101102", "1101102104", "story_v_side_new_1101102.awb")

						arg_425_1:RecordAudio("1101102104", var_428_7)
						arg_425_1:RecordAudio("1101102104", var_428_7)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102104", "story_v_side_new_1101102.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102104", "story_v_side_new_1101102.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_8 = math.max(var_428_1, arg_425_1.talkMaxDuration)

			if var_428_0 <= arg_425_1.time_ and arg_425_1.time_ < var_428_0 + var_428_8 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_0) / var_428_8

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_0 + var_428_8 and arg_425_1.time_ < var_428_0 + var_428_8 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1101102105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1101102105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1101102106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["1011ui_story"]) and arg_429_1.var_.characterEffect1011ui_story == nil then
				arg_429_1.var_.characterEffect1011ui_story = arg_429_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_0 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["1011ui_story"]) then
				if arg_429_1.var_.characterEffect1011ui_story and not isNil(arg_429_1.actors_["1011ui_story"]) then
					arg_429_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_429_1.time_ - 0) / var_432_0)
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["1011ui_story"]) and arg_429_1.var_.characterEffect1011ui_story then
				arg_429_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_432_1 = 0
			local var_432_2 = 0.825

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, false)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_3 = arg_429_1:FormatText(arg_429_1:GetWordFromCfg(1101102105).content)

				arg_429_1.text_.text = var_432_3

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_5 = 33 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 33)

				if (33 <= 0 and var_432_2 or var_432_2 * (utf8.len(var_432_3) / 33)) > 0 and var_432_2 < var_432_5 then
					arg_429_1.talkMaxDuration = var_432_5

					if var_432_5 + var_432_1 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + var_432_1
					end
				end

				arg_429_1.text_.text = var_432_3
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_6 = math.max(var_432_2, arg_429_1.talkMaxDuration)

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_6 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_1) / var_432_6

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_1 + var_432_6 and arg_429_1.time_ < var_432_1 + var_432_6 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1101102106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1101102106
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1101102107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = 0.575

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_1 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(1101102106).content)

				arg_433_1.text_.text = var_436_1

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_3 = 23 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 23)

				if (23 <= 0 and var_436_0 or var_436_0 * (utf8.len(var_436_1) / 23)) > 0 and var_436_0 < var_436_3 then
					arg_433_1.talkMaxDuration = var_436_3

					if var_436_3 + 0 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_3 + 0
					end
				end

				arg_433_1.text_.text = var_436_1
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_4 = math.max(var_436_0, arg_433_1.talkMaxDuration)

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - 0) / var_436_4

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1101102107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1101102107
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1101102108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = 0.7

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_1 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(1101102107).content)

				arg_437_1.text_.text = var_440_1

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_3 = 28 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_1) / 28)

				if (28 <= 0 and var_440_0 or var_440_0 * (utf8.len(var_440_1) / 28)) > 0 and var_440_0 < var_440_3 then
					arg_437_1.talkMaxDuration = var_440_3

					if var_440_3 + 0 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_3 + 0
					end
				end

				arg_437_1.text_.text = var_440_1
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_4 = math.max(var_440_0, arg_437_1.talkMaxDuration)

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_4 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - 0) / var_440_4

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= 0 + var_440_4 and arg_437_1.time_ < 0 + var_440_4 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play1101102108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1101102108
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1101102109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_444_0 = 0
			local var_444_1 = 0.725

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, false)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_2 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(1101102108).content)

				arg_441_1.text_.text = var_444_2

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_4 = 29 <= 0 and var_444_1 or var_444_1 * (utf8.len(var_444_2) / 29)

				if (29 <= 0 and var_444_1 or var_444_1 * (utf8.len(var_444_2) / 29)) > 0 and var_444_1 < var_444_4 then
					arg_441_1.talkMaxDuration = var_444_4

					if var_444_4 + var_444_0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_4 + var_444_0
					end
				end

				arg_441_1.text_.text = var_444_2
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_5 = math.max(var_444_1, arg_441_1.talkMaxDuration)

			if var_444_0 <= arg_441_1.time_ and arg_441_1.time_ < var_444_0 + var_444_5 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_0) / var_444_5

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_0 + var_444_5 and arg_441_1.time_ < var_444_0 + var_444_5 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1101102109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1101102109
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1101102110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 0.6

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_1 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(1101102109).content)

				arg_445_1.text_.text = var_448_1

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_3 = 24 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 24)

				if (24 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_1) / 24)) > 0 and var_448_0 < var_448_3 then
					arg_445_1.talkMaxDuration = var_448_3

					if var_448_3 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_3 + 0
					end
				end

				arg_445_1.text_.text = var_448_1
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_4 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_4 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_4

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_4 and arg_445_1.time_ < 0 + var_448_4 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play1101102110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1101102110
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1101102111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0.3

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_1 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(1101102110).content)

				arg_449_1.text_.text = var_452_1

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_3 = 12 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 12)

				if (12 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_1) / 12)) > 0 and var_452_0 < var_452_3 then
					arg_449_1.talkMaxDuration = var_452_3

					if var_452_3 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_3 + 0
					end
				end

				arg_449_1.text_.text = var_452_1
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_4 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_4

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1101102111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1101102111
		arg_453_1.duration_ = 5.5

		local var_453_0 = {
			zh = 2.166,
			ja = 5.5
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1101102112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1011ui_story = arg_453_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1011ui_story"].transform.position).z)
				arg_453_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1011ui_story"].transform.localEulerAngles = arg_453_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_453_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1011ui_story"].transform.position).z)
				arg_453_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1011ui_story"].transform.localEulerAngles = arg_453_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_456_1 = arg_453_1.actors_["1011ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1011ui_story == nil then
				arg_453_1.var_.characterEffect1011ui_story = var_456_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 and not isNil(var_456_1) then
				if arg_453_1.var_.characterEffect1011ui_story and not isNil(var_456_1) then
					arg_453_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1011ui_story then
				arg_453_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_456_4 = 0
			local var_456_5 = 0.15

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_4 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_6 = arg_453_1:GetWordFromCfg(1101102111)
				local var_456_7 = arg_453_1:FormatText(var_456_6.content)

				arg_453_1.text_.text = var_456_7

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_9 = 6 <= 0 and var_456_5 or var_456_5 * (utf8.len(var_456_7) / 6)

				if (6 <= 0 and var_456_5 or var_456_5 * (utf8.len(var_456_7) / 6)) > 0 and var_456_5 < var_456_9 then
					arg_453_1.talkMaxDuration = var_456_9

					if var_456_9 + var_456_4 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_9 + var_456_4
					end
				end

				arg_453_1.text_.text = var_456_7
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102111", "story_v_side_new_1101102.awb") ~= 0 then
					local var_456_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102111", "story_v_side_new_1101102.awb") / 1000

					if var_456_10 + var_456_4 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_10 + var_456_4
					end

					if var_456_6.prefab_name ~= "" and arg_453_1.actors_[var_456_6.prefab_name] ~= nil then
						local var_456_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_6.prefab_name].transform, "story_v_side_new_1101102", "1101102111", "story_v_side_new_1101102.awb")

						arg_453_1:RecordAudio("1101102111", var_456_11)
						arg_453_1:RecordAudio("1101102111", var_456_11)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102111", "story_v_side_new_1101102.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102111", "story_v_side_new_1101102.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_12 = math.max(var_456_5, arg_453_1.talkMaxDuration)

			if var_456_4 <= arg_453_1.time_ and arg_453_1.time_ < var_456_4 + var_456_12 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_4) / var_456_12

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_4 + var_456_12 and arg_453_1.time_ < var_456_4 + var_456_12 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play1101102112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1101102112
		arg_457_1.duration_ = 9

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1101102113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if arg_457_1.bgs_.ST18 == nil then
				local var_460_0 = Object.Instantiate(arg_457_1.paintGo_)

				var_460_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST18")
				var_460_0.name = "ST18"
				var_460_0.transform.parent = arg_457_1.stage_.transform
				var_460_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_457_1.bgs_.ST18 = var_460_0
			end

			if 2 < arg_457_1.time_ and arg_457_1.time_ <= 2 + arg_460_0 then
				local var_460_1 = arg_457_1.bgs_.ST18

				arg_457_1.bgs_.ST18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_460_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_460_2 = var_460_1:GetComponent("SpriteRenderer")

				if var_460_2 and var_460_2.sprite then
					local var_460_3 = 2 * (var_460_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_460_1.transform.localScale = Vector3.New(var_460_3 / var_460_2.sprite.bounds.size.y < var_460_3 * manager.ui.mainCameraCom_.aspect / var_460_2.sprite.bounds.size.x and var_460_3 * manager.ui.mainCameraCom_.aspect / var_460_2.sprite.bounds.size.x or var_460_3 / var_460_2.sprite.bounds.size.y, var_460_3 / var_460_2.sprite.bounds.size.y < var_460_3 * manager.ui.mainCameraCom_.aspect / var_460_2.sprite.bounds.size.x and var_460_3 * manager.ui.mainCameraCom_.aspect / var_460_2.sprite.bounds.size.x or var_460_3 / var_460_2.sprite.bounds.size.y, 0)
				end

				for iter_460_0, iter_460_1 in pairs(arg_457_1.bgs_) do
					if iter_460_0 ~= "ST18" then
						iter_460_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_460_4 = 0

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_4 + arg_460_0 then
				arg_457_1.mask_.enabled = true
				arg_457_1.mask_.raycastTarget = true

				arg_457_1:SetGaussion(false)
			end

			local var_460_5 = 2

			if var_460_4 <= arg_457_1.time_ and arg_457_1.time_ < var_460_4 + var_460_5 then
				local var_460_6 = Color.New(0, 0, 0)

				var_460_6.a = Mathf.Lerp(0, 1, (arg_457_1.time_ - var_460_4) / var_460_5)
				arg_457_1.mask_.color = var_460_6
			end

			if arg_457_1.time_ >= var_460_4 + var_460_5 and arg_457_1.time_ < var_460_4 + var_460_5 + arg_460_0 then
				local var_460_7 = Color.New(0, 0, 0)

				var_460_7.a = 1
				arg_457_1.mask_.color = var_460_7
			end

			local var_460_8 = 2

			if 2 < arg_457_1.time_ and arg_457_1.time_ <= var_460_8 + arg_460_0 then
				arg_457_1.mask_.enabled = true
				arg_457_1.mask_.raycastTarget = true

				arg_457_1:SetGaussion(false)
			end

			local var_460_9 = 2

			if var_460_8 <= arg_457_1.time_ and arg_457_1.time_ < var_460_8 + var_460_9 then
				local var_460_10 = Color.New(0, 0, 0)

				var_460_10.a = Mathf.Lerp(1, 0, (arg_457_1.time_ - var_460_8) / var_460_9)
				arg_457_1.mask_.color = var_460_10
			end

			if arg_457_1.time_ >= var_460_8 + var_460_9 and arg_457_1.time_ < var_460_8 + var_460_9 + arg_460_0 then
				local var_460_11 = Color.New(0, 0, 0)

				arg_457_1.mask_.enabled = false
				var_460_11.a = 0
				arg_457_1.mask_.color = var_460_11
			end

			local var_460_12 = arg_457_1.actors_["1011ui_story"].transform

			if 2 < arg_457_1.time_ and arg_457_1.time_ <= 2 + arg_460_0 then
				arg_457_1.var_.moveOldPos1011ui_story = var_460_12.localPosition
			end

			local var_460_13 = 0.001

			if 2 <= arg_457_1.time_ and arg_457_1.time_ < 2 + var_460_13 then
				var_460_12.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_457_1.time_ - 2) / var_460_13)
				var_460_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_12.position).x, (manager.ui.mainCamera.transform.position - var_460_12.position).y, (manager.ui.mainCamera.transform.position - var_460_12.position).z)
				var_460_12.localEulerAngles.z = 0
				var_460_12.localEulerAngles.x = 0
				var_460_12.localEulerAngles = var_460_12.localEulerAngles
			end

			if arg_457_1.time_ >= 2 + var_460_13 and arg_457_1.time_ < 2 + var_460_13 + arg_460_0 then
				var_460_12.localPosition = Vector3.New(0, 100, 0)
				var_460_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_12.position).x, (manager.ui.mainCamera.transform.position - var_460_12.position).y, (manager.ui.mainCamera.transform.position - var_460_12.position).z)
				var_460_12.localEulerAngles.z = 0
				var_460_12.localEulerAngles.x = 0
				var_460_12.localEulerAngles = var_460_12.localEulerAngles
			end

			if 4 < arg_457_1.time_ and arg_457_1.time_ <= 4 + arg_460_0 then
				arg_457_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 4 < arg_457_1.time_ and arg_457_1.time_ <= 4 + arg_460_0 then
				arg_457_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_460_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_457_1.bgmTxt_.text ~= var_460_16 and arg_457_1.bgmTxt_.text ~= "" then
						if arg_457_1.bgmTxt2_.text ~= "" then
							arg_457_1.bgmTxt_.text = arg_457_1.bgmTxt2_.text
						end

						arg_457_1.bgmTxt2_.text = var_460_16

						arg_457_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_457_1.bgmTxt_.text = var_460_16
						arg_457_1.bgmTxt2_.text = var_460_16
					end

					if arg_457_1.bgmTimer then
						arg_457_1.bgmTimer:Stop()

						arg_457_1.bgmTimer = nil
					end

					if arg_457_1.settingData.show_music_name == 1 then
						arg_457_1.musicController:SetSelectedState("show")
						arg_457_1.musicAnimator_:Play("open", 0, 0)

						if arg_457_1.settingData.music_time ~= 0 then
							arg_457_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_457_1.settingData.music_time), function()
								if arg_457_1 == nil or isNil(arg_457_1.bgmTxt_) then
									return
								end

								arg_457_1.musicController:SetSelectedState("hide")
								arg_457_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.533333333333333 < arg_457_1.time_ and arg_457_1.time_ <= 0.533333333333333 + arg_460_0 then
				arg_457_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_460_19 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_457_1.bgmTxt_.text ~= var_460_19 and arg_457_1.bgmTxt_.text ~= "" then
						if arg_457_1.bgmTxt2_.text ~= "" then
							arg_457_1.bgmTxt_.text = arg_457_1.bgmTxt2_.text
						end

						arg_457_1.bgmTxt2_.text = var_460_19

						arg_457_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_457_1.bgmTxt_.text = var_460_19
						arg_457_1.bgmTxt2_.text = var_460_19
					end

					if arg_457_1.bgmTimer then
						arg_457_1.bgmTimer:Stop()

						arg_457_1.bgmTimer = nil
					end

					if arg_457_1.settingData.show_music_name == 1 then
						arg_457_1.musicController:SetSelectedState("show")
						arg_457_1.musicAnimator_:Play("open", 0, 0)

						if arg_457_1.settingData.music_time ~= 0 then
							arg_457_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_457_1.settingData.music_time), function()
								if arg_457_1 == nil or isNil(arg_457_1.bgmTxt_) then
									return
								end

								arg_457_1.musicController:SetSelectedState("hide")
								arg_457_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_457_1.frameCnt_ <= 1 then
				arg_457_1.dialog_:SetActive(false)
			end

			local var_460_20 = 4
			local var_460_21 = 0.6

			if 4 < arg_457_1.time_ and arg_457_1.time_ <= var_460_20 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0

				arg_457_1.dialog_:SetActive(true)

				arg_457_1.dialogCg_.alpha = 0

				local var_460_22 = LeanTween.value(arg_457_1.dialog_, 0, 1, 0.3)

				var_460_22:setOnUpdate(LuaHelper.FloatAction(function(arg_463_0)
					arg_457_1.dialogCg_.alpha = arg_463_0
				end))
				var_460_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_457_1.dialog_)
					var_460_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_457_1.duration_ = arg_457_1.duration_ + 0.3

				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_23 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(1101102112).content)

				arg_457_1.text_.text = var_460_23

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_25 = 24 <= 0 and var_460_21 or var_460_21 * (utf8.len(var_460_23) / 24)

				if (24 <= 0 and var_460_21 or var_460_21 * (utf8.len(var_460_23) / 24)) > 0 and var_460_21 < var_460_25 then
					arg_457_1.talkMaxDuration = var_460_25
					var_460_20 = var_460_20 + 0.3

					if var_460_25 + var_460_20 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_25 + var_460_20
					end
				end

				arg_457_1.text_.text = var_460_23
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_26 = var_460_20 + 0.3
			local var_460_27 = math.max(var_460_21, arg_457_1.talkMaxDuration)

			if var_460_20 + 0.3 <= arg_457_1.time_ and arg_457_1.time_ < var_460_26 + var_460_27 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_26) / var_460_27

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_26 + var_460_27 and arg_457_1.time_ < var_460_26 + var_460_27 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play1101102113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1101102113
		arg_465_1.duration_ = 4.63

		local var_465_0 = {
			zh = 3.866,
			ja = 4.633
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1101102114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if arg_465_1.actors_["1048ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1048ui_story"))) then
				local var_468_0 = Object.Instantiate(Asset.Load("Char/" .. "1048ui_story"), arg_465_1.stage_.transform)

				var_468_0.name = "1048ui_story"
				var_468_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_465_1.actors_["1048ui_story"] = var_468_0

				local var_468_1 = var_468_0:GetComponentInChildren(typeof(CharacterEffect))

				var_468_1.enabled = true

				local var_468_2 = GameObjectTools.GetOrAddComponent(var_468_0, typeof(DynamicBoneHelper))

				if var_468_2 then
					var_468_2:EnableDynamicBone(false)
				end

				arg_465_1:ShowWeapon(var_468_1.transform, false)

				arg_465_1.var_["1048ui_story" .. "Animator"] = var_468_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_465_1.var_["1048ui_story" .. "Animator"].applyRootMotion = true
				arg_465_1.var_["1048ui_story" .. "LipSync"] = var_468_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_468_3 = arg_465_1.actors_["1048ui_story"].transform

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1048ui_story = var_468_3.localPosition
			end

			local var_468_4 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				var_468_3.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1048ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_465_1.time_ - 0) / var_468_4)
				var_468_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_468_3.position).x, (manager.ui.mainCamera.transform.position - var_468_3.position).y, (manager.ui.mainCamera.transform.position - var_468_3.position).z)
				var_468_3.localEulerAngles.z = 0
				var_468_3.localEulerAngles.x = 0
				var_468_3.localEulerAngles = var_468_3.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				var_468_3.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_468_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_468_3.position).x, (manager.ui.mainCamera.transform.position - var_468_3.position).y, (manager.ui.mainCamera.transform.position - var_468_3.position).z)
				var_468_3.localEulerAngles.z = 0
				var_468_3.localEulerAngles.x = 0
				var_468_3.localEulerAngles = var_468_3.localEulerAngles
			end

			local var_468_5 = arg_465_1.actors_["1048ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_5) and arg_465_1.var_.characterEffect1048ui_story == nil then
				arg_465_1.var_.characterEffect1048ui_story = var_468_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_6 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_6 and not isNil(var_468_5) then
				if arg_465_1.var_.characterEffect1048ui_story and not isNil(var_468_5) then
					arg_465_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_6 and arg_465_1.time_ < 0 + var_468_6 + arg_468_0 and not isNil(var_468_5) and arg_465_1.var_.characterEffect1048ui_story then
				arg_465_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action5_1")
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_468_8 = "1027ui_story"

			if arg_465_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_468_9 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_465_1.stage_.transform)

				var_468_9.name = var_468_8
				var_468_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_465_1.actors_[var_468_8] = var_468_9

				local var_468_10 = var_468_9:GetComponentInChildren(typeof(CharacterEffect))

				var_468_10.enabled = true

				local var_468_11 = GameObjectTools.GetOrAddComponent(var_468_9, typeof(DynamicBoneHelper))

				if var_468_11 then
					var_468_11:EnableDynamicBone(false)
				end

				arg_465_1:ShowWeapon(var_468_10.transform, false)

				arg_465_1.var_[var_468_8 .. "Animator"] = var_468_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_465_1.var_[var_468_8 .. "Animator"].applyRootMotion = true
				arg_465_1.var_[var_468_8 .. "LipSync"] = var_468_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_468_12 = arg_465_1.actors_["1027ui_story"].transform

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1027ui_story = var_468_12.localPosition
			end

			local var_468_13 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_13 then
				var_468_12.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_465_1.time_ - 0) / var_468_13)
				var_468_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_468_12.position).x, (manager.ui.mainCamera.transform.position - var_468_12.position).y, (manager.ui.mainCamera.transform.position - var_468_12.position).z)
				var_468_12.localEulerAngles.z = 0
				var_468_12.localEulerAngles.x = 0
				var_468_12.localEulerAngles = var_468_12.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_13 and arg_465_1.time_ < 0 + var_468_13 + arg_468_0 then
				var_468_12.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_468_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_468_12.position).x, (manager.ui.mainCamera.transform.position - var_468_12.position).y, (manager.ui.mainCamera.transform.position - var_468_12.position).z)
				var_468_12.localEulerAngles.z = 0
				var_468_12.localEulerAngles.x = 0
				var_468_12.localEulerAngles = var_468_12.localEulerAngles
			end

			local var_468_14 = arg_465_1.actors_["1027ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_14) and arg_465_1.var_.characterEffect1027ui_story == nil then
				arg_465_1.var_.characterEffect1027ui_story = var_468_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_15 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_15 and not isNil(var_468_14) then
				if arg_465_1.var_.characterEffect1027ui_story and not isNil(var_468_14) then
					arg_465_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_465_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_465_1.time_ - 0) / var_468_15)
				end
			end

			if arg_465_1.time_ >= 0 + var_468_15 and arg_465_1.time_ < 0 + var_468_15 + arg_468_0 and not isNil(var_468_14) and arg_465_1.var_.characterEffect1027ui_story then
				arg_465_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_465_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action1_1")
			end

			local var_468_16 = 0
			local var_468_17 = 0.375

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_16 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_18 = arg_465_1:GetWordFromCfg(1101102113)
				local var_468_19 = arg_465_1:FormatText(var_468_18.content)

				arg_465_1.text_.text = var_468_19

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_21 = 15 <= 0 and var_468_17 or var_468_17 * (utf8.len(var_468_19) / 15)

				if (15 <= 0 and var_468_17 or var_468_17 * (utf8.len(var_468_19) / 15)) > 0 and var_468_17 < var_468_21 then
					arg_465_1.talkMaxDuration = var_468_21

					if var_468_21 + var_468_16 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_21 + var_468_16
					end
				end

				arg_465_1.text_.text = var_468_19
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102113", "story_v_side_new_1101102.awb") ~= 0 then
					local var_468_22 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102113", "story_v_side_new_1101102.awb") / 1000

					if var_468_22 + var_468_16 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_22 + var_468_16
					end

					if var_468_18.prefab_name ~= "" and arg_465_1.actors_[var_468_18.prefab_name] ~= nil then
						local var_468_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_18.prefab_name].transform, "story_v_side_new_1101102", "1101102113", "story_v_side_new_1101102.awb")

						arg_465_1:RecordAudio("1101102113", var_468_23)
						arg_465_1:RecordAudio("1101102113", var_468_23)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102113", "story_v_side_new_1101102.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102113", "story_v_side_new_1101102.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_24 = math.max(var_468_17, arg_465_1.talkMaxDuration)

			if var_468_16 <= arg_465_1.time_ and arg_465_1.time_ < var_468_16 + var_468_24 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_16) / var_468_24

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_16 + var_468_24 and arg_465_1.time_ < var_468_16 + var_468_24 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play1101102114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1101102114
		arg_469_1.duration_ = 5.13

		local var_469_0 = {
			zh = 5.133,
			ja = 2.966
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1101102115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos1027ui_story = arg_469_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_472_0 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 then
				arg_469_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_469_1.time_ - 0) / var_472_0)
				arg_469_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1027ui_story"].transform.position).z)
				arg_469_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["1027ui_story"].transform.localEulerAngles = arg_469_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 then
				arg_469_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_469_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["1027ui_story"].transform.position).z)
				arg_469_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["1027ui_story"].transform.localEulerAngles = arg_469_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_472_1 = arg_469_1.actors_["1027ui_story"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_1) and arg_469_1.var_.characterEffect1027ui_story == nil then
				arg_469_1.var_.characterEffect1027ui_story = var_472_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_2 and not isNil(var_472_1) then
				if arg_469_1.var_.characterEffect1027ui_story and not isNil(var_472_1) then
					arg_469_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= 0 + var_472_2 and arg_469_1.time_ < 0 + var_472_2 + arg_472_0 and not isNil(var_472_1) and arg_469_1.var_.characterEffect1027ui_story then
				arg_469_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_472_4 = arg_469_1.actors_["1048ui_story"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_4) and arg_469_1.var_.characterEffect1048ui_story == nil then
				arg_469_1.var_.characterEffect1048ui_story = var_472_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_5 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_5 and not isNil(var_472_4) then
				if arg_469_1.var_.characterEffect1048ui_story and not isNil(var_472_4) then
					arg_469_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_5)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_5 and arg_469_1.time_ < 0 + var_472_5 + arg_472_0 and not isNil(var_472_4) and arg_469_1.var_.characterEffect1048ui_story then
				arg_469_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_472_6 = 0
			local var_472_7 = 0.475

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_6 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_8 = arg_469_1:GetWordFromCfg(1101102114)
				local var_472_9 = arg_469_1:FormatText(var_472_8.content)

				arg_469_1.text_.text = var_472_9

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_11 = 19 <= 0 and var_472_7 or var_472_7 * (utf8.len(var_472_9) / 19)

				if (19 <= 0 and var_472_7 or var_472_7 * (utf8.len(var_472_9) / 19)) > 0 and var_472_7 < var_472_11 then
					arg_469_1.talkMaxDuration = var_472_11

					if var_472_11 + var_472_6 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_11 + var_472_6
					end
				end

				arg_469_1.text_.text = var_472_9
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102114", "story_v_side_new_1101102.awb") ~= 0 then
					local var_472_12 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102114", "story_v_side_new_1101102.awb") / 1000

					if var_472_12 + var_472_6 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_12 + var_472_6
					end

					if var_472_8.prefab_name ~= "" and arg_469_1.actors_[var_472_8.prefab_name] ~= nil then
						local var_472_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_8.prefab_name].transform, "story_v_side_new_1101102", "1101102114", "story_v_side_new_1101102.awb")

						arg_469_1:RecordAudio("1101102114", var_472_13)
						arg_469_1:RecordAudio("1101102114", var_472_13)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102114", "story_v_side_new_1101102.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102114", "story_v_side_new_1101102.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_14 = math.max(var_472_7, arg_469_1.talkMaxDuration)

			if var_472_6 <= arg_469_1.time_ and arg_469_1.time_ < var_472_6 + var_472_14 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_6) / var_472_14

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_6 + var_472_14 and arg_469_1.time_ < var_472_6 + var_472_14 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play1101102115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1101102115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1101102116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["1027ui_story"]) and arg_473_1.var_.characterEffect1027ui_story == nil then
				arg_473_1.var_.characterEffect1027ui_story = arg_473_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["1027ui_story"]) then
				if arg_473_1.var_.characterEffect1027ui_story and not isNil(arg_473_1.actors_["1027ui_story"]) then
					arg_473_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_473_1.time_ - 0) / var_476_0)
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["1027ui_story"]) and arg_473_1.var_.characterEffect1027ui_story then
				arg_473_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_476_1 = 0
			local var_476_2 = 0.55

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_3 = arg_473_1:FormatText(arg_473_1:GetWordFromCfg(1101102115).content)

				arg_473_1.text_.text = var_476_3

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 22 <= 0 and var_476_2 or var_476_2 * (utf8.len(var_476_3) / 22)

				if (22 <= 0 and var_476_2 or var_476_2 * (utf8.len(var_476_3) / 22)) > 0 and var_476_2 < var_476_5 then
					arg_473_1.talkMaxDuration = var_476_5

					if var_476_5 + var_476_1 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + var_476_1
					end
				end

				arg_473_1.text_.text = var_476_3
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_6 = math.max(var_476_2, arg_473_1.talkMaxDuration)

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_6 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_1) / var_476_6

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_1 + var_476_6 and arg_473_1.time_ < var_476_1 + var_476_6 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1101102116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1101102116
		arg_477_1.duration_ = 6.07

		local var_477_0 = {
			zh = 4.233,
			ja = 6.066
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1101102117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos1027ui_story = arg_477_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_480_0 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 then
				arg_477_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1027ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_477_1.time_ - 0) / var_480_0)
				arg_477_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1027ui_story"].transform.position).z)
				arg_477_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1027ui_story"].transform.localEulerAngles = arg_477_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 then
				arg_477_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0.7, -0.81, -5.8)
				arg_477_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["1027ui_story"].transform.position).z)
				arg_477_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["1027ui_story"].transform.localEulerAngles = arg_477_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_480_1 = arg_477_1.actors_["1027ui_story"]

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1027ui_story == nil then
				arg_477_1.var_.characterEffect1027ui_story = var_480_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_2 and not isNil(var_480_1) then
				if arg_477_1.var_.characterEffect1027ui_story and not isNil(var_480_1) then
					arg_477_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_2 and arg_477_1.time_ < 0 + var_480_2 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1027ui_story then
				arg_477_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action425")
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_480_4 = 0
			local var_480_5 = 0.35

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_6 = arg_477_1:GetWordFromCfg(1101102116)
				local var_480_7 = arg_477_1:FormatText(var_480_6.content)

				arg_477_1.text_.text = var_480_7

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_9 = 14 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_7) / 14)

				if (14 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_7) / 14)) > 0 and var_480_5 < var_480_9 then
					arg_477_1.talkMaxDuration = var_480_9

					if var_480_9 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_9 + var_480_4
					end
				end

				arg_477_1.text_.text = var_480_7
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102116", "story_v_side_new_1101102.awb") ~= 0 then
					local var_480_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102116", "story_v_side_new_1101102.awb") / 1000

					if var_480_10 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_10 + var_480_4
					end

					if var_480_6.prefab_name ~= "" and arg_477_1.actors_[var_480_6.prefab_name] ~= nil then
						local var_480_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_6.prefab_name].transform, "story_v_side_new_1101102", "1101102116", "story_v_side_new_1101102.awb")

						arg_477_1:RecordAudio("1101102116", var_480_11)
						arg_477_1:RecordAudio("1101102116", var_480_11)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102116", "story_v_side_new_1101102.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102116", "story_v_side_new_1101102.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_12 = math.max(var_480_5, arg_477_1.talkMaxDuration)

			if var_480_4 <= arg_477_1.time_ and arg_477_1.time_ < var_480_4 + var_480_12 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_4) / var_480_12

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_4 + var_480_12 and arg_477_1.time_ < var_480_4 + var_480_12 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play1101102117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1101102117
		arg_481_1.duration_ = 5.1

		local var_481_0 = {
			zh = 4.3,
			ja = 5.1
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1101102118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1011ui_story = arg_481_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_484_0 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 then
				arg_481_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_481_1.time_ - 0) / var_484_0)
				arg_481_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).z)
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles = arg_481_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 then
				arg_481_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_481_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1011ui_story"].transform.position).z)
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1011ui_story"].transform.localEulerAngles = arg_481_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_484_1 = arg_481_1.actors_["1011ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1011ui_story == nil then
				arg_481_1.var_.characterEffect1011ui_story = var_484_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_2 and not isNil(var_484_1) then
				if arg_481_1.var_.characterEffect1011ui_story and not isNil(var_484_1) then
					arg_481_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_2 and arg_481_1.time_ < 0 + var_484_2 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1011ui_story then
				arg_481_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action7_1")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_484_4 = arg_481_1.actors_["1027ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_4) and arg_481_1.var_.characterEffect1027ui_story == nil then
				arg_481_1.var_.characterEffect1027ui_story = var_484_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_5 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_5 and not isNil(var_484_4) then
				if arg_481_1.var_.characterEffect1027ui_story and not isNil(var_484_4) then
					arg_481_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_481_1.time_ - 0) / var_484_5)
				end
			end

			if arg_481_1.time_ >= 0 + var_484_5 and arg_481_1.time_ < 0 + var_484_5 + arg_484_0 and not isNil(var_484_4) and arg_481_1.var_.characterEffect1027ui_story then
				arg_481_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_484_6 = arg_481_1.actors_["1027ui_story"].transform

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1027ui_story = var_484_6.localPosition
			end

			local var_484_7 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_7 then
				var_484_6.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_481_1.time_ - 0) / var_484_7)
				var_484_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_6.position).x, (manager.ui.mainCamera.transform.position - var_484_6.position).y, (manager.ui.mainCamera.transform.position - var_484_6.position).z)
				var_484_6.localEulerAngles.z = 0
				var_484_6.localEulerAngles.x = 0
				var_484_6.localEulerAngles = var_484_6.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_7 and arg_481_1.time_ < 0 + var_484_7 + arg_484_0 then
				var_484_6.localPosition = Vector3.New(0, 100, 0)
				var_484_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_6.position).x, (manager.ui.mainCamera.transform.position - var_484_6.position).y, (manager.ui.mainCamera.transform.position - var_484_6.position).z)
				var_484_6.localEulerAngles.z = 0
				var_484_6.localEulerAngles.x = 0
				var_484_6.localEulerAngles = var_484_6.localEulerAngles
			end

			local var_484_8 = arg_481_1.actors_["1048ui_story"].transform

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1048ui_story = var_484_8.localPosition
			end

			local var_484_9 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_9 then
				var_484_8.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_481_1.time_ - 0) / var_484_9)
				var_484_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_8.position).x, (manager.ui.mainCamera.transform.position - var_484_8.position).y, (manager.ui.mainCamera.transform.position - var_484_8.position).z)
				var_484_8.localEulerAngles.z = 0
				var_484_8.localEulerAngles.x = 0
				var_484_8.localEulerAngles = var_484_8.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_9 and arg_481_1.time_ < 0 + var_484_9 + arg_484_0 then
				var_484_8.localPosition = Vector3.New(0, 100, 0)
				var_484_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_8.position).x, (manager.ui.mainCamera.transform.position - var_484_8.position).y, (manager.ui.mainCamera.transform.position - var_484_8.position).z)
				var_484_8.localEulerAngles.z = 0
				var_484_8.localEulerAngles.x = 0
				var_484_8.localEulerAngles = var_484_8.localEulerAngles
			end

			local var_484_10 = 0
			local var_484_11 = 0.4

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_10 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_12 = arg_481_1:GetWordFromCfg(1101102117)
				local var_484_13 = arg_481_1:FormatText(var_484_12.content)

				arg_481_1.text_.text = var_484_13

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_15 = 16 <= 0 and var_484_11 or var_484_11 * (utf8.len(var_484_13) / 16)

				if (16 <= 0 and var_484_11 or var_484_11 * (utf8.len(var_484_13) / 16)) > 0 and var_484_11 < var_484_15 then
					arg_481_1.talkMaxDuration = var_484_15

					if var_484_15 + var_484_10 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_15 + var_484_10
					end
				end

				arg_481_1.text_.text = var_484_13
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102117", "story_v_side_new_1101102.awb") ~= 0 then
					local var_484_16 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102117", "story_v_side_new_1101102.awb") / 1000

					if var_484_16 + var_484_10 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_16 + var_484_10
					end

					if var_484_12.prefab_name ~= "" and arg_481_1.actors_[var_484_12.prefab_name] ~= nil then
						local var_484_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_12.prefab_name].transform, "story_v_side_new_1101102", "1101102117", "story_v_side_new_1101102.awb")

						arg_481_1:RecordAudio("1101102117", var_484_17)
						arg_481_1:RecordAudio("1101102117", var_484_17)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102117", "story_v_side_new_1101102.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102117", "story_v_side_new_1101102.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_18 = math.max(var_484_11, arg_481_1.talkMaxDuration)

			if var_484_10 <= arg_481_1.time_ and arg_481_1.time_ < var_484_10 + var_484_18 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_10) / var_484_18

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_10 + var_484_18 and arg_481_1.time_ < var_484_10 + var_484_18 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play1101102118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1101102118
		arg_485_1.duration_ = 4.4

		local var_485_0 = {
			zh = 4.4,
			ja = 3.1
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1101102119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos1027ui_story = arg_485_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_488_0 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 then
				arg_485_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_485_1.time_ - 0) / var_488_0)
				arg_485_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1027ui_story"].transform.position).z)
				arg_485_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["1027ui_story"].transform.localEulerAngles = arg_485_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 then
				arg_485_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_485_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1027ui_story"].transform.position).z)
				arg_485_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["1027ui_story"].transform.localEulerAngles = arg_485_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_488_1 = arg_485_1.actors_["1027ui_story"]

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(var_488_1) and arg_485_1.var_.characterEffect1027ui_story == nil then
				arg_485_1.var_.characterEffect1027ui_story = var_488_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_2 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_2 and not isNil(var_488_1) then
				if arg_485_1.var_.characterEffect1027ui_story and not isNil(var_488_1) then
					arg_485_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_2 and arg_485_1.time_ < 0 + var_488_2 + arg_488_0 and not isNil(var_488_1) and arg_485_1.var_.characterEffect1027ui_story then
				arg_485_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action456")
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_488_4 = arg_485_1.actors_["1011ui_story"]

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(var_488_4) and arg_485_1.var_.characterEffect1011ui_story == nil then
				arg_485_1.var_.characterEffect1011ui_story = var_488_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_5 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_5 and not isNil(var_488_4) then
				if arg_485_1.var_.characterEffect1011ui_story and not isNil(var_488_4) then
					arg_485_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_485_1.time_ - 0) / var_488_5)
				end
			end

			if arg_485_1.time_ >= 0 + var_488_5 and arg_485_1.time_ < 0 + var_488_5 + arg_488_0 and not isNil(var_488_4) and arg_485_1.var_.characterEffect1011ui_story then
				arg_485_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_488_6 = arg_485_1.actors_["1011ui_story"].transform

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos1011ui_story = var_488_6.localPosition
			end

			local var_488_7 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_7 then
				var_488_6.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_485_1.time_ - 0) / var_488_7)
				var_488_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_488_6.position).x, (manager.ui.mainCamera.transform.position - var_488_6.position).y, (manager.ui.mainCamera.transform.position - var_488_6.position).z)
				var_488_6.localEulerAngles.z = 0
				var_488_6.localEulerAngles.x = 0
				var_488_6.localEulerAngles = var_488_6.localEulerAngles
			end

			if arg_485_1.time_ >= 0 + var_488_7 and arg_485_1.time_ < 0 + var_488_7 + arg_488_0 then
				var_488_6.localPosition = Vector3.New(0, 100, 0)
				var_488_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_488_6.position).x, (manager.ui.mainCamera.transform.position - var_488_6.position).y, (manager.ui.mainCamera.transform.position - var_488_6.position).z)
				var_488_6.localEulerAngles.z = 0
				var_488_6.localEulerAngles.x = 0
				var_488_6.localEulerAngles = var_488_6.localEulerAngles
			end

			local var_488_8 = 0
			local var_488_9 = 0.525

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_8 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_10 = arg_485_1:GetWordFromCfg(1101102118)
				local var_488_11 = arg_485_1:FormatText(var_488_10.content)

				arg_485_1.text_.text = var_488_11

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_13 = 12 <= 0 and var_488_9 or var_488_9 * (utf8.len(var_488_11) / 12)

				if (12 <= 0 and var_488_9 or var_488_9 * (utf8.len(var_488_11) / 12)) > 0 and var_488_9 < var_488_13 then
					arg_485_1.talkMaxDuration = var_488_13

					if var_488_13 + var_488_8 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_13 + var_488_8
					end
				end

				arg_485_1.text_.text = var_488_11
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102118", "story_v_side_new_1101102.awb") ~= 0 then
					local var_488_14 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102118", "story_v_side_new_1101102.awb") / 1000

					if var_488_14 + var_488_8 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_14 + var_488_8
					end

					if var_488_10.prefab_name ~= "" and arg_485_1.actors_[var_488_10.prefab_name] ~= nil then
						local var_488_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_10.prefab_name].transform, "story_v_side_new_1101102", "1101102118", "story_v_side_new_1101102.awb")

						arg_485_1:RecordAudio("1101102118", var_488_15)
						arg_485_1:RecordAudio("1101102118", var_488_15)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102118", "story_v_side_new_1101102.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102118", "story_v_side_new_1101102.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_16 = math.max(var_488_9, arg_485_1.talkMaxDuration)

			if var_488_8 <= arg_485_1.time_ and arg_485_1.time_ < var_488_8 + var_488_16 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_8) / var_488_16

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_8 + var_488_16 and arg_485_1.time_ < var_488_8 + var_488_16 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play1101102119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1101102119
		arg_489_1.duration_ = 9.77

		local var_489_0 = {
			zh = 4.433,
			ja = 9.766
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1101102120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPos1048ui_story = arg_489_1.actors_["1048ui_story"].transform.localPosition
			end

			local var_492_0 = 0.001

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 then
				arg_489_1.actors_["1048ui_story"].transform.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1048ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_489_1.time_ - 0) / var_492_0)
				arg_489_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_489_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["1048ui_story"].transform.position).z)
				arg_489_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_489_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_489_1.actors_["1048ui_story"].transform.localEulerAngles = arg_489_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 then
				arg_489_1.actors_["1048ui_story"].transform.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				arg_489_1.actors_["1048ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_489_1.actors_["1048ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["1048ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["1048ui_story"].transform.position).z)
				arg_489_1.actors_["1048ui_story"].transform.localEulerAngles.z = 0
				arg_489_1.actors_["1048ui_story"].transform.localEulerAngles.x = 0
				arg_489_1.actors_["1048ui_story"].transform.localEulerAngles = arg_489_1.actors_["1048ui_story"].transform.localEulerAngles
			end

			local var_492_1 = arg_489_1.actors_["1048ui_story"]

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(var_492_1) and arg_489_1.var_.characterEffect1048ui_story == nil then
				arg_489_1.var_.characterEffect1048ui_story = var_492_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_2 = 0.200000002980232

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_2 and not isNil(var_492_1) then
				if arg_489_1.var_.characterEffect1048ui_story and not isNil(var_492_1) then
					arg_489_1.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if arg_489_1.time_ >= 0 + var_492_2 and arg_489_1.time_ < 0 + var_492_2 + arg_492_0 and not isNil(var_492_1) and arg_489_1.var_.characterEffect1048ui_story then
				arg_489_1.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action2_1")
			end

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_492_4 = arg_489_1.actors_["1027ui_story"]

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(var_492_4) and arg_489_1.var_.characterEffect1027ui_story == nil then
				arg_489_1.var_.characterEffect1027ui_story = var_492_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_5 = 0.200000002980232

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_5 and not isNil(var_492_4) then
				if arg_489_1.var_.characterEffect1027ui_story and not isNil(var_492_4) then
					arg_489_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 0) / var_492_5)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_5 and arg_489_1.time_ < 0 + var_492_5 + arg_492_0 and not isNil(var_492_4) and arg_489_1.var_.characterEffect1027ui_story then
				arg_489_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_492_6 = arg_489_1.actors_["1027ui_story"].transform

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPos1027ui_story = var_492_6.localPosition
			end

			local var_492_7 = 0.001

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				var_492_6.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_489_1.time_ - 0) / var_492_7)
				var_492_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_6.position).x, (manager.ui.mainCamera.transform.position - var_492_6.position).y, (manager.ui.mainCamera.transform.position - var_492_6.position).z)
				var_492_6.localEulerAngles.z = 0
				var_492_6.localEulerAngles.x = 0
				var_492_6.localEulerAngles = var_492_6.localEulerAngles
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				var_492_6.localPosition = Vector3.New(0, 100, 0)
				var_492_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_6.position).x, (manager.ui.mainCamera.transform.position - var_492_6.position).y, (manager.ui.mainCamera.transform.position - var_492_6.position).z)
				var_492_6.localEulerAngles.z = 0
				var_492_6.localEulerAngles.x = 0
				var_492_6.localEulerAngles = var_492_6.localEulerAngles
			end

			local var_492_8 = arg_489_1.actors_["1011ui_story"].transform

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPos1011ui_story = var_492_8.localPosition
			end

			local var_492_9 = 0.001

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_9 then
				var_492_8.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_489_1.time_ - 0) / var_492_9)
				var_492_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_8.position).x, (manager.ui.mainCamera.transform.position - var_492_8.position).y, (manager.ui.mainCamera.transform.position - var_492_8.position).z)
				var_492_8.localEulerAngles.z = 0
				var_492_8.localEulerAngles.x = 0
				var_492_8.localEulerAngles = var_492_8.localEulerAngles
			end

			if arg_489_1.time_ >= 0 + var_492_9 and arg_489_1.time_ < 0 + var_492_9 + arg_492_0 then
				var_492_8.localPosition = Vector3.New(0.7, -0.71, -6)
				var_492_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_492_8.position).x, (manager.ui.mainCamera.transform.position - var_492_8.position).y, (manager.ui.mainCamera.transform.position - var_492_8.position).z)
				var_492_8.localEulerAngles.z = 0
				var_492_8.localEulerAngles.x = 0
				var_492_8.localEulerAngles = var_492_8.localEulerAngles
			end

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_492_10 = 0
			local var_492_11 = 0.5

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_10 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_12 = arg_489_1:GetWordFromCfg(1101102119)
				local var_492_13 = arg_489_1:FormatText(var_492_12.content)

				arg_489_1.text_.text = var_492_13

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_15 = 20 <= 0 and var_492_11 or var_492_11 * (utf8.len(var_492_13) / 20)

				if (20 <= 0 and var_492_11 or var_492_11 * (utf8.len(var_492_13) / 20)) > 0 and var_492_11 < var_492_15 then
					arg_489_1.talkMaxDuration = var_492_15

					if var_492_15 + var_492_10 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_15 + var_492_10
					end
				end

				arg_489_1.text_.text = var_492_13
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102119", "story_v_side_new_1101102.awb") ~= 0 then
					local var_492_16 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102119", "story_v_side_new_1101102.awb") / 1000

					if var_492_16 + var_492_10 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_16 + var_492_10
					end

					if var_492_12.prefab_name ~= "" and arg_489_1.actors_[var_492_12.prefab_name] ~= nil then
						local var_492_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_12.prefab_name].transform, "story_v_side_new_1101102", "1101102119", "story_v_side_new_1101102.awb")

						arg_489_1:RecordAudio("1101102119", var_492_17)
						arg_489_1:RecordAudio("1101102119", var_492_17)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102119", "story_v_side_new_1101102.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102119", "story_v_side_new_1101102.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_18 = math.max(var_492_11, arg_489_1.talkMaxDuration)

			if var_492_10 <= arg_489_1.time_ and arg_489_1.time_ < var_492_10 + var_492_18 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_10) / var_492_18

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_10 + var_492_18 and arg_489_1.time_ < var_492_10 + var_492_18 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play1101102120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1101102120
		arg_493_1.duration_ = 2

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1101102121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1011ui_story = arg_493_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1011ui_story"].transform.position).z)
				arg_493_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1011ui_story"].transform.localEulerAngles = arg_493_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_493_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1011ui_story"].transform.position).z)
				arg_493_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1011ui_story"].transform.localEulerAngles = arg_493_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_496_1 = arg_493_1.actors_["1011ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1011ui_story == nil then
				arg_493_1.var_.characterEffect1011ui_story = var_496_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_2 and not isNil(var_496_1) then
				if arg_493_1.var_.characterEffect1011ui_story and not isNil(var_496_1) then
					arg_493_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_2 and arg_493_1.time_ < 0 + var_496_2 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1011ui_story then
				arg_493_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_496_4 = arg_493_1.actors_["1048ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_4) and arg_493_1.var_.characterEffect1048ui_story == nil then
				arg_493_1.var_.characterEffect1048ui_story = var_496_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_5 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_5 and not isNil(var_496_4) then
				if arg_493_1.var_.characterEffect1048ui_story and not isNil(var_496_4) then
					arg_493_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_493_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_493_1.time_ - 0) / var_496_5)
				end
			end

			if arg_493_1.time_ >= 0 + var_496_5 and arg_493_1.time_ < 0 + var_496_5 + arg_496_0 and not isNil(var_496_4) and arg_493_1.var_.characterEffect1048ui_story then
				arg_493_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_493_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_496_6 = 0
			local var_496_7 = 0.05

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_6 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_8 = arg_493_1:GetWordFromCfg(1101102120)
				local var_496_9 = arg_493_1:FormatText(var_496_8.content)

				arg_493_1.text_.text = var_496_9

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_11 = 2 <= 0 and var_496_7 or var_496_7 * (utf8.len(var_496_9) / 2)

				if (2 <= 0 and var_496_7 or var_496_7 * (utf8.len(var_496_9) / 2)) > 0 and var_496_7 < var_496_11 then
					arg_493_1.talkMaxDuration = var_496_11

					if var_496_11 + var_496_6 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_11 + var_496_6
					end
				end

				arg_493_1.text_.text = var_496_9
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102120", "story_v_side_new_1101102.awb") ~= 0 then
					local var_496_12 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102120", "story_v_side_new_1101102.awb") / 1000

					if var_496_12 + var_496_6 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_12 + var_496_6
					end

					if var_496_8.prefab_name ~= "" and arg_493_1.actors_[var_496_8.prefab_name] ~= nil then
						local var_496_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_8.prefab_name].transform, "story_v_side_new_1101102", "1101102120", "story_v_side_new_1101102.awb")

						arg_493_1:RecordAudio("1101102120", var_496_13)
						arg_493_1:RecordAudio("1101102120", var_496_13)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102120", "story_v_side_new_1101102.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102120", "story_v_side_new_1101102.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_14 = math.max(var_496_7, arg_493_1.talkMaxDuration)

			if var_496_6 <= arg_493_1.time_ and arg_493_1.time_ < var_496_6 + var_496_14 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_6) / var_496_14

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_6 + var_496_14 and arg_493_1.time_ < var_496_6 + var_496_14 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play1101102121 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1101102121
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1101102122(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(arg_497_1.actors_["1011ui_story"]) and arg_497_1.var_.characterEffect1011ui_story == nil then
				arg_497_1.var_.characterEffect1011ui_story = arg_497_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_0 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 and not isNil(arg_497_1.actors_["1011ui_story"]) then
				if arg_497_1.var_.characterEffect1011ui_story and not isNil(arg_497_1.actors_["1011ui_story"]) then
					arg_497_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_497_1.time_ - 0) / var_500_0)
				end
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 and not isNil(arg_497_1.actors_["1011ui_story"]) and arg_497_1.var_.characterEffect1011ui_story then
				arg_497_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_500_1 = 0
			local var_500_2 = 0.35

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, true)
				arg_497_1.iconController_:SetSelectedState("hero")

				arg_497_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_497_1.callingController_:SetSelectedState("normal")

				arg_497_1.keyicon_.color = Color.New(1, 1, 1)
				arg_497_1.icon_.color = Color.New(1, 1, 1)

				local var_500_3 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(1101102121).content)

				arg_497_1.text_.text = var_500_3

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_5 = 14 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 14)

				if (14 <= 0 and var_500_2 or var_500_2 * (utf8.len(var_500_3) / 14)) > 0 and var_500_2 < var_500_5 then
					arg_497_1.talkMaxDuration = var_500_5

					if var_500_5 + var_500_1 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_5 + var_500_1
					end
				end

				arg_497_1.text_.text = var_500_3
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_6 = math.max(var_500_2, arg_497_1.talkMaxDuration)

			if var_500_1 <= arg_497_1.time_ and arg_497_1.time_ < var_500_1 + var_500_6 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_1) / var_500_6

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_1 + var_500_6 and arg_497_1.time_ < var_500_1 + var_500_6 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1101102122 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 1101102122
		arg_501_1.duration_ = 3.67

		local var_501_0 = {
			zh = 3.666,
			ja = 3.433
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play1101102123(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos1027ui_story = arg_501_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_504_0 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 then
				arg_501_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_501_1.time_ - 0) / var_504_0)
				arg_501_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1027ui_story"].transform.position).z)
				arg_501_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1027ui_story"].transform.localEulerAngles = arg_501_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 then
				arg_501_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_501_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1027ui_story"].transform.position).z)
				arg_501_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1027ui_story"].transform.localEulerAngles = arg_501_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_504_1 = arg_501_1.actors_["1027ui_story"]

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(var_504_1) and arg_501_1.var_.characterEffect1027ui_story == nil then
				arg_501_1.var_.characterEffect1027ui_story = var_504_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_2 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_2 and not isNil(var_504_1) then
				if arg_501_1.var_.characterEffect1027ui_story and not isNil(var_504_1) then
					arg_501_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= 0 + var_504_2 and arg_501_1.time_ < 0 + var_504_2 + arg_504_0 and not isNil(var_504_1) and arg_501_1.var_.characterEffect1027ui_story then
				arg_501_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_504_4 = arg_501_1.actors_["1011ui_story"].transform

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos1011ui_story = var_504_4.localPosition
			end

			local var_504_5 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_5 then
				var_504_4.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_501_1.time_ - 0) / var_504_5)
				var_504_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_504_4.position).x, (manager.ui.mainCamera.transform.position - var_504_4.position).y, (manager.ui.mainCamera.transform.position - var_504_4.position).z)
				var_504_4.localEulerAngles.z = 0
				var_504_4.localEulerAngles.x = 0
				var_504_4.localEulerAngles = var_504_4.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_5 and arg_501_1.time_ < 0 + var_504_5 + arg_504_0 then
				var_504_4.localPosition = Vector3.New(0, 100, 0)
				var_504_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_504_4.position).x, (manager.ui.mainCamera.transform.position - var_504_4.position).y, (manager.ui.mainCamera.transform.position - var_504_4.position).z)
				var_504_4.localEulerAngles.z = 0
				var_504_4.localEulerAngles.x = 0
				var_504_4.localEulerAngles = var_504_4.localEulerAngles
			end

			local var_504_6 = arg_501_1.actors_["1048ui_story"].transform

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos1048ui_story = var_504_6.localPosition
			end

			local var_504_7 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_7 then
				var_504_6.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_501_1.time_ - 0) / var_504_7)
				var_504_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_504_6.position).x, (manager.ui.mainCamera.transform.position - var_504_6.position).y, (manager.ui.mainCamera.transform.position - var_504_6.position).z)
				var_504_6.localEulerAngles.z = 0
				var_504_6.localEulerAngles.x = 0
				var_504_6.localEulerAngles = var_504_6.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_7 and arg_501_1.time_ < 0 + var_504_7 + arg_504_0 then
				var_504_6.localPosition = Vector3.New(0, 100, 0)
				var_504_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_504_6.position).x, (manager.ui.mainCamera.transform.position - var_504_6.position).y, (manager.ui.mainCamera.transform.position - var_504_6.position).z)
				var_504_6.localEulerAngles.z = 0
				var_504_6.localEulerAngles.x = 0
				var_504_6.localEulerAngles = var_504_6.localEulerAngles
			end

			local var_504_8 = 0
			local var_504_9 = 0.4

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_8 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_10 = arg_501_1:GetWordFromCfg(1101102122)
				local var_504_11 = arg_501_1:FormatText(var_504_10.content)

				arg_501_1.text_.text = var_504_11

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_13 = 16 <= 0 and var_504_9 or var_504_9 * (utf8.len(var_504_11) / 16)

				if (16 <= 0 and var_504_9 or var_504_9 * (utf8.len(var_504_11) / 16)) > 0 and var_504_9 < var_504_13 then
					arg_501_1.talkMaxDuration = var_504_13

					if var_504_13 + var_504_8 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_13 + var_504_8
					end
				end

				arg_501_1.text_.text = var_504_11
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102122", "story_v_side_new_1101102.awb") ~= 0 then
					local var_504_14 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102122", "story_v_side_new_1101102.awb") / 1000

					if var_504_14 + var_504_8 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_14 + var_504_8
					end

					if var_504_10.prefab_name ~= "" and arg_501_1.actors_[var_504_10.prefab_name] ~= nil then
						local var_504_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_10.prefab_name].transform, "story_v_side_new_1101102", "1101102122", "story_v_side_new_1101102.awb")

						arg_501_1:RecordAudio("1101102122", var_504_15)
						arg_501_1:RecordAudio("1101102122", var_504_15)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102122", "story_v_side_new_1101102.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102122", "story_v_side_new_1101102.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_16 = math.max(var_504_9, arg_501_1.talkMaxDuration)

			if var_504_8 <= arg_501_1.time_ and arg_501_1.time_ < var_504_8 + var_504_16 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_8) / var_504_16

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_8 + var_504_16 and arg_501_1.time_ < var_504_8 + var_504_16 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	Play1101102123 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 1101102123
		arg_505_1.duration_ = 2.17

		local var_505_0 = {
			zh = 2.166,
			ja = 1.999999999999
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play1101102124(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if arg_505_1.actors_["1094ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1094ui_story"))) then
				local var_508_0 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_505_1.stage_.transform)

				var_508_0.name = "1094ui_story"
				var_508_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_505_1.actors_["1094ui_story"] = var_508_0

				local var_508_1 = var_508_0:GetComponentInChildren(typeof(CharacterEffect))

				var_508_1.enabled = true

				local var_508_2 = GameObjectTools.GetOrAddComponent(var_508_0, typeof(DynamicBoneHelper))

				if var_508_2 then
					var_508_2:EnableDynamicBone(false)
				end

				arg_505_1:ShowWeapon(var_508_1.transform, false)

				arg_505_1.var_["1094ui_story" .. "Animator"] = var_508_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_505_1.var_["1094ui_story" .. "Animator"].applyRootMotion = true
				arg_505_1.var_["1094ui_story" .. "LipSync"] = var_508_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_508_3 = arg_505_1.actors_["1094ui_story"].transform

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.var_.moveOldPos1094ui_story = var_508_3.localPosition
			end

			local var_508_4 = 0.001

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_4 then
				var_508_3.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos1094ui_story, Vector3.New(0.7, -0.84, -6.1), (arg_505_1.time_ - 0) / var_508_4)
				var_508_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_508_3.position).x, (manager.ui.mainCamera.transform.position - var_508_3.position).y, (manager.ui.mainCamera.transform.position - var_508_3.position).z)
				var_508_3.localEulerAngles.z = 0
				var_508_3.localEulerAngles.x = 0
				var_508_3.localEulerAngles = var_508_3.localEulerAngles
			end

			if arg_505_1.time_ >= 0 + var_508_4 and arg_505_1.time_ < 0 + var_508_4 + arg_508_0 then
				var_508_3.localPosition = Vector3.New(0.7, -0.84, -6.1)
				var_508_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_508_3.position).x, (manager.ui.mainCamera.transform.position - var_508_3.position).y, (manager.ui.mainCamera.transform.position - var_508_3.position).z)
				var_508_3.localEulerAngles.z = 0
				var_508_3.localEulerAngles.x = 0
				var_508_3.localEulerAngles = var_508_3.localEulerAngles
			end

			local var_508_5 = arg_505_1.actors_["1094ui_story"]

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(var_508_5) and arg_505_1.var_.characterEffect1094ui_story == nil then
				arg_505_1.var_.characterEffect1094ui_story = var_508_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_6 = 0.200000002980232

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_6 and not isNil(var_508_5) then
				if arg_505_1.var_.characterEffect1094ui_story and not isNil(var_508_5) then
					arg_505_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= 0 + var_508_6 and arg_505_1.time_ < 0 + var_508_6 + arg_508_0 and not isNil(var_508_5) and arg_505_1.var_.characterEffect1094ui_story then
				arg_505_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_508_8 = arg_505_1.actors_["1027ui_story"].transform

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.var_.moveOldPos1027ui_story = var_508_8.localPosition
			end

			local var_508_9 = 0.001

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_9 then
				var_508_8.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_505_1.time_ - 0) / var_508_9)
				var_508_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_508_8.position).x, (manager.ui.mainCamera.transform.position - var_508_8.position).y, (manager.ui.mainCamera.transform.position - var_508_8.position).z)
				var_508_8.localEulerAngles.z = 0
				var_508_8.localEulerAngles.x = 0
				var_508_8.localEulerAngles = var_508_8.localEulerAngles
			end

			if arg_505_1.time_ >= 0 + var_508_9 and arg_505_1.time_ < 0 + var_508_9 + arg_508_0 then
				var_508_8.localPosition = Vector3.New(0, 100, 0)
				var_508_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_508_8.position).x, (manager.ui.mainCamera.transform.position - var_508_8.position).y, (manager.ui.mainCamera.transform.position - var_508_8.position).z)
				var_508_8.localEulerAngles.z = 0
				var_508_8.localEulerAngles.x = 0
				var_508_8.localEulerAngles = var_508_8.localEulerAngles
			end

			local var_508_10 = arg_505_1.actors_["1011ui_story"].transform

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.var_.moveOldPos1011ui_story = var_508_10.localPosition
			end

			local var_508_11 = 0.001

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_11 then
				var_508_10.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_505_1.time_ - 0) / var_508_11)
				var_508_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_508_10.position).x, (manager.ui.mainCamera.transform.position - var_508_10.position).y, (manager.ui.mainCamera.transform.position - var_508_10.position).z)
				var_508_10.localEulerAngles.z = 0
				var_508_10.localEulerAngles.x = 0
				var_508_10.localEulerAngles = var_508_10.localEulerAngles
			end

			if arg_505_1.time_ >= 0 + var_508_11 and arg_505_1.time_ < 0 + var_508_11 + arg_508_0 then
				var_508_10.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_508_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_508_10.position).x, (manager.ui.mainCamera.transform.position - var_508_10.position).y, (manager.ui.mainCamera.transform.position - var_508_10.position).z)
				var_508_10.localEulerAngles.z = 0
				var_508_10.localEulerAngles.x = 0
				var_508_10.localEulerAngles = var_508_10.localEulerAngles
			end

			local var_508_12 = arg_505_1.actors_["1011ui_story"]

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(var_508_12) and arg_505_1.var_.characterEffect1011ui_story == nil then
				arg_505_1.var_.characterEffect1011ui_story = var_508_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_13 = 0.200000002980232

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_13 and not isNil(var_508_12) then
				if arg_505_1.var_.characterEffect1011ui_story and not isNil(var_508_12) then
					arg_505_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_505_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_505_1.time_ - 0) / var_508_13)
				end
			end

			if arg_505_1.time_ >= 0 + var_508_13 and arg_505_1.time_ < 0 + var_508_13 + arg_508_0 and not isNil(var_508_12) and arg_505_1.var_.characterEffect1011ui_story then
				arg_505_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_505_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_508_14 = 0
			local var_508_15 = 0.15

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_14 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0

				arg_505_1.dialog_:SetActive(true)

				arg_505_1.dialogCg_.alpha = 0

				local var_508_16 = LeanTween.value(arg_505_1.dialog_, 0, 1, 0.3)

				var_508_16:setOnUpdate(LuaHelper.FloatAction(function(arg_509_0)
					arg_505_1.dialogCg_.alpha = arg_509_0
				end))
				var_508_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_505_1.dialog_)
					var_508_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_505_1.duration_ = arg_505_1.duration_ + 0.3

				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_17 = arg_505_1:GetWordFromCfg(1101102123)
				local var_508_18 = arg_505_1:FormatText(var_508_17.content)

				arg_505_1.text_.text = var_508_18

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_20 = 6 <= 0 and var_508_15 or var_508_15 * (utf8.len(var_508_18) / 6)

				if (6 <= 0 and var_508_15 or var_508_15 * (utf8.len(var_508_18) / 6)) > 0 and var_508_15 < var_508_20 then
					arg_505_1.talkMaxDuration = var_508_20
					var_508_14 = var_508_14 + 0.3

					if var_508_20 + var_508_14 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_20 + var_508_14
					end
				end

				arg_505_1.text_.text = var_508_18
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102123", "story_v_side_new_1101102.awb") ~= 0 then
					local var_508_21 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102123", "story_v_side_new_1101102.awb") / 1000

					if var_508_21 + var_508_14 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_21 + var_508_14
					end

					if var_508_17.prefab_name ~= "" and arg_505_1.actors_[var_508_17.prefab_name] ~= nil then
						local var_508_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_17.prefab_name].transform, "story_v_side_new_1101102", "1101102123", "story_v_side_new_1101102.awb")

						arg_505_1:RecordAudio("1101102123", var_508_22)
						arg_505_1:RecordAudio("1101102123", var_508_22)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102123", "story_v_side_new_1101102.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102123", "story_v_side_new_1101102.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_23 = var_508_14 + 0.3
			local var_508_24 = math.max(var_508_15, arg_505_1.talkMaxDuration)

			if var_508_14 + 0.3 <= arg_505_1.time_ and arg_505_1.time_ < var_508_23 + var_508_24 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_23) / var_508_24

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_23 + var_508_24 and arg_505_1.time_ < var_508_23 + var_508_24 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_505_1:InitPlayNodeList()
	end,
	Play1101102124 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1101102124
		arg_511_1.duration_ = 5.63

		local var_511_0 = {
			zh = 5.2,
			ja = 5.633
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1101102125(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action4_1")
			end

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_514_0 = 0
			local var_514_1 = 0.55

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_2 = arg_511_1:GetWordFromCfg(1101102124)
				local var_514_3 = arg_511_1:FormatText(var_514_2.content)

				arg_511_1.text_.text = var_514_3

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 22 <= 0 and var_514_1 or var_514_1 * (utf8.len(var_514_3) / 22)

				if (22 <= 0 and var_514_1 or var_514_1 * (utf8.len(var_514_3) / 22)) > 0 and var_514_1 < var_514_5 then
					arg_511_1.talkMaxDuration = var_514_5

					if var_514_5 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_5 + var_514_0
					end
				end

				arg_511_1.text_.text = var_514_3
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102124", "story_v_side_new_1101102.awb") ~= 0 then
					local var_514_6 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102124", "story_v_side_new_1101102.awb") / 1000

					if var_514_6 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_6 + var_514_0
					end

					if var_514_2.prefab_name ~= "" and arg_511_1.actors_[var_514_2.prefab_name] ~= nil then
						local var_514_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_2.prefab_name].transform, "story_v_side_new_1101102", "1101102124", "story_v_side_new_1101102.awb")

						arg_511_1:RecordAudio("1101102124", var_514_7)
						arg_511_1:RecordAudio("1101102124", var_514_7)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102124", "story_v_side_new_1101102.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102124", "story_v_side_new_1101102.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_8 = math.max(var_514_1, arg_511_1.talkMaxDuration)

			if var_514_0 <= arg_511_1.time_ and arg_511_1.time_ < var_514_0 + var_514_8 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_0) / var_514_8

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_0 + var_514_8 and arg_511_1.time_ < var_514_0 + var_514_8 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1101102125 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1101102125
		arg_515_1.duration_ = 8.77

		local var_515_0 = {
			zh = 5.766,
			ja = 8.766
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1101102126(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos1011ui_story = arg_515_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_518_0 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 then
				arg_515_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_515_1.time_ - 0) / var_518_0)
				arg_515_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1011ui_story"].transform.position).z)
				arg_515_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1011ui_story"].transform.localEulerAngles = arg_515_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 then
				arg_515_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_515_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_515_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_515_1.actors_["1011ui_story"].transform.position).z)
				arg_515_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_515_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_515_1.actors_["1011ui_story"].transform.localEulerAngles = arg_515_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_518_1 = arg_515_1.actors_["1011ui_story"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_1) and arg_515_1.var_.characterEffect1011ui_story == nil then
				arg_515_1.var_.characterEffect1011ui_story = var_518_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_2 and not isNil(var_518_1) then
				if arg_515_1.var_.characterEffect1011ui_story and not isNil(var_518_1) then
					arg_515_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= 0 + var_518_2 and arg_515_1.time_ < 0 + var_518_2 + arg_518_0 and not isNil(var_518_1) and arg_515_1.var_.characterEffect1011ui_story then
				arg_515_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_518_4 = arg_515_1.actors_["1094ui_story"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_4) and arg_515_1.var_.characterEffect1094ui_story == nil then
				arg_515_1.var_.characterEffect1094ui_story = var_518_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_5 = 0.200000002980232

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_5 and not isNil(var_518_4) then
				if arg_515_1.var_.characterEffect1094ui_story and not isNil(var_518_4) then
					arg_515_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_515_1.time_ - 0) / var_518_5)
				end
			end

			if arg_515_1.time_ >= 0 + var_518_5 and arg_515_1.time_ < 0 + var_518_5 + arg_518_0 and not isNil(var_518_4) and arg_515_1.var_.characterEffect1094ui_story then
				arg_515_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_518_6 = 0
			local var_518_7 = 0.625

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_6 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_8 = arg_515_1:GetWordFromCfg(1101102125)
				local var_518_9 = arg_515_1:FormatText(var_518_8.content)

				arg_515_1.text_.text = var_518_9

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_11 = 25 <= 0 and var_518_7 or var_518_7 * (utf8.len(var_518_9) / 25)

				if (25 <= 0 and var_518_7 or var_518_7 * (utf8.len(var_518_9) / 25)) > 0 and var_518_7 < var_518_11 then
					arg_515_1.talkMaxDuration = var_518_11

					if var_518_11 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_11 + var_518_6
					end
				end

				arg_515_1.text_.text = var_518_9
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102125", "story_v_side_new_1101102.awb") ~= 0 then
					local var_518_12 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102125", "story_v_side_new_1101102.awb") / 1000

					if var_518_12 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_12 + var_518_6
					end

					if var_518_8.prefab_name ~= "" and arg_515_1.actors_[var_518_8.prefab_name] ~= nil then
						local var_518_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_8.prefab_name].transform, "story_v_side_new_1101102", "1101102125", "story_v_side_new_1101102.awb")

						arg_515_1:RecordAudio("1101102125", var_518_13)
						arg_515_1:RecordAudio("1101102125", var_518_13)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102125", "story_v_side_new_1101102.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102125", "story_v_side_new_1101102.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_14 = math.max(var_518_7, arg_515_1.talkMaxDuration)

			if var_518_6 <= arg_515_1.time_ and arg_515_1.time_ < var_518_6 + var_518_14 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_6) / var_518_14

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_6 + var_518_14 and arg_515_1.time_ < var_518_6 + var_518_14 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play1101102126 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1101102126
		arg_519_1.duration_ = 2

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1101102127(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos1094ui_story = arg_519_1.actors_["1094ui_story"].transform.localPosition
			end

			local var_522_0 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 then
				arg_519_1.actors_["1094ui_story"].transform.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos1094ui_story, Vector3.New(0.7, -0.84, -6.1), (arg_519_1.time_ - 0) / var_522_0)
				arg_519_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1094ui_story"].transform.position).z)
				arg_519_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["1094ui_story"].transform.localEulerAngles = arg_519_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 then
				arg_519_1.actors_["1094ui_story"].transform.localPosition = Vector3.New(0.7, -0.84, -6.1)
				arg_519_1.actors_["1094ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_519_1.actors_["1094ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1094ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_519_1.actors_["1094ui_story"].transform.position).z)
				arg_519_1.actors_["1094ui_story"].transform.localEulerAngles.z = 0
				arg_519_1.actors_["1094ui_story"].transform.localEulerAngles.x = 0
				arg_519_1.actors_["1094ui_story"].transform.localEulerAngles = arg_519_1.actors_["1094ui_story"].transform.localEulerAngles
			end

			local var_522_1 = arg_519_1.actors_["1094ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect1094ui_story == nil then
				arg_519_1.var_.characterEffect1094ui_story = var_522_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_2 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_2 and not isNil(var_522_1) then
				if arg_519_1.var_.characterEffect1094ui_story and not isNil(var_522_1) then
					arg_519_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_519_1.time_ >= 0 + var_522_2 and arg_519_1.time_ < 0 + var_522_2 + arg_522_0 and not isNil(var_522_1) and arg_519_1.var_.characterEffect1094ui_story then
				arg_519_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_522_4 = arg_519_1.actors_["1011ui_story"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_4) and arg_519_1.var_.characterEffect1011ui_story == nil then
				arg_519_1.var_.characterEffect1011ui_story = var_522_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_522_5 = 0.200000002980232

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_5 and not isNil(var_522_4) then
				if arg_519_1.var_.characterEffect1011ui_story and not isNil(var_522_4) then
					arg_519_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_519_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_519_1.time_ - 0) / var_522_5)
				end
			end

			if arg_519_1.time_ >= 0 + var_522_5 and arg_519_1.time_ < 0 + var_522_5 + arg_522_0 and not isNil(var_522_4) and arg_519_1.var_.characterEffect1011ui_story then
				arg_519_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_519_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_522_6 = 0
			local var_522_7 = 0.075

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_6 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_8 = arg_519_1:GetWordFromCfg(1101102126)
				local var_522_9 = arg_519_1:FormatText(var_522_8.content)

				arg_519_1.text_.text = var_522_9

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_11 = 3 <= 0 and var_522_7 or var_522_7 * (utf8.len(var_522_9) / 3)

				if (3 <= 0 and var_522_7 or var_522_7 * (utf8.len(var_522_9) / 3)) > 0 and var_522_7 < var_522_11 then
					arg_519_1.talkMaxDuration = var_522_11

					if var_522_11 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_11 + var_522_6
					end
				end

				arg_519_1.text_.text = var_522_9
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102126", "story_v_side_new_1101102.awb") ~= 0 then
					local var_522_12 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102126", "story_v_side_new_1101102.awb") / 1000

					if var_522_12 + var_522_6 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_12 + var_522_6
					end

					if var_522_8.prefab_name ~= "" and arg_519_1.actors_[var_522_8.prefab_name] ~= nil then
						local var_522_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_8.prefab_name].transform, "story_v_side_new_1101102", "1101102126", "story_v_side_new_1101102.awb")

						arg_519_1:RecordAudio("1101102126", var_522_13)
						arg_519_1:RecordAudio("1101102126", var_522_13)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102126", "story_v_side_new_1101102.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102126", "story_v_side_new_1101102.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_14 = math.max(var_522_7, arg_519_1.talkMaxDuration)

			if var_522_6 <= arg_519_1.time_ and arg_519_1.time_ < var_522_6 + var_522_14 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_6) / var_522_14

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_6 + var_522_14 and arg_519_1.time_ < var_522_6 + var_522_14 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play1101102127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1101102127
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1101102128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["1094ui_story"]) and arg_523_1.var_.characterEffect1094ui_story == nil then
				arg_523_1.var_.characterEffect1094ui_story = arg_523_1.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_0 = 0.200000002980232

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["1094ui_story"]) then
				if arg_523_1.var_.characterEffect1094ui_story and not isNil(arg_523_1.actors_["1094ui_story"]) then
					arg_523_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_523_1.time_ - 0) / var_526_0)
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["1094ui_story"]) and arg_523_1.var_.characterEffect1094ui_story then
				arg_523_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_526_1 = arg_523_1.actors_["1094ui_story"].transform

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos1094ui_story = var_526_1.localPosition
			end

			local var_526_2 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_2 then
				var_526_1.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_523_1.time_ - 0) / var_526_2)
				var_526_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_1.position).x, (manager.ui.mainCamera.transform.position - var_526_1.position).y, (manager.ui.mainCamera.transform.position - var_526_1.position).z)
				var_526_1.localEulerAngles.z = 0
				var_526_1.localEulerAngles.x = 0
				var_526_1.localEulerAngles = var_526_1.localEulerAngles
			end

			if arg_523_1.time_ >= 0 + var_526_2 and arg_523_1.time_ < 0 + var_526_2 + arg_526_0 then
				var_526_1.localPosition = Vector3.New(0, 100, 0)
				var_526_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_1.position).x, (manager.ui.mainCamera.transform.position - var_526_1.position).y, (manager.ui.mainCamera.transform.position - var_526_1.position).z)
				var_526_1.localEulerAngles.z = 0
				var_526_1.localEulerAngles.x = 0
				var_526_1.localEulerAngles = var_526_1.localEulerAngles
			end

			local var_526_3 = arg_523_1.actors_["1011ui_story"].transform

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos1011ui_story = var_526_3.localPosition
			end

			local var_526_4 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				var_526_3.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_523_1.time_ - 0) / var_526_4)
				var_526_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_3.position).x, (manager.ui.mainCamera.transform.position - var_526_3.position).y, (manager.ui.mainCamera.transform.position - var_526_3.position).z)
				var_526_3.localEulerAngles.z = 0
				var_526_3.localEulerAngles.x = 0
				var_526_3.localEulerAngles = var_526_3.localEulerAngles
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				var_526_3.localPosition = Vector3.New(0, 100, 0)
				var_526_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_526_3.position).x, (manager.ui.mainCamera.transform.position - var_526_3.position).y, (manager.ui.mainCamera.transform.position - var_526_3.position).z)
				var_526_3.localEulerAngles.z = 0
				var_526_3.localEulerAngles.x = 0
				var_526_3.localEulerAngles = var_526_3.localEulerAngles
			end

			local var_526_5 = 0
			local var_526_6 = 0.525

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_5 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_7 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(1101102127).content)

				arg_523_1.text_.text = var_526_7

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_9 = 21 <= 0 and var_526_6 or var_526_6 * (utf8.len(var_526_7) / 21)

				if (21 <= 0 and var_526_6 or var_526_6 * (utf8.len(var_526_7) / 21)) > 0 and var_526_6 < var_526_9 then
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
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play1101102128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1101102128
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1101102129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos1011ui_story = arg_527_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_530_0 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 then
				arg_527_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_527_1.time_ - 0) / var_530_0)
				arg_527_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_527_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1011ui_story"].transform.position).z)
				arg_527_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_527_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_527_1.actors_["1011ui_story"].transform.localEulerAngles = arg_527_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 then
				arg_527_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_527_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_527_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_527_1.actors_["1011ui_story"].transform.position).z)
				arg_527_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_527_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_527_1.actors_["1011ui_story"].transform.localEulerAngles = arg_527_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_530_1 = arg_527_1.actors_["1011ui_story"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_1) and arg_527_1.var_.characterEffect1011ui_story == nil then
				arg_527_1.var_.characterEffect1011ui_story = var_530_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_2 = 0.200000002980232

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_2 and not isNil(var_530_1) then
				if arg_527_1.var_.characterEffect1011ui_story and not isNil(var_530_1) then
					arg_527_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_527_1.time_ >= 0 + var_530_2 and arg_527_1.time_ < 0 + var_530_2 + arg_530_0 and not isNil(var_530_1) and arg_527_1.var_.characterEffect1011ui_story then
				arg_527_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_530_4 = arg_527_1.actors_["1094ui_story"].transform

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos1094ui_story = var_530_4.localPosition
			end

			local var_530_5 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_5 then
				var_530_4.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1094ui_story, Vector3.New(0.7, -0.84, -6.1), (arg_527_1.time_ - 0) / var_530_5)
				var_530_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_4.position).x, (manager.ui.mainCamera.transform.position - var_530_4.position).y, (manager.ui.mainCamera.transform.position - var_530_4.position).z)
				var_530_4.localEulerAngles.z = 0
				var_530_4.localEulerAngles.x = 0
				var_530_4.localEulerAngles = var_530_4.localEulerAngles
			end

			if arg_527_1.time_ >= 0 + var_530_5 and arg_527_1.time_ < 0 + var_530_5 + arg_530_0 then
				var_530_4.localPosition = Vector3.New(0.7, -0.84, -6.1)
				var_530_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_4.position).x, (manager.ui.mainCamera.transform.position - var_530_4.position).y, (manager.ui.mainCamera.transform.position - var_530_4.position).z)
				var_530_4.localEulerAngles.z = 0
				var_530_4.localEulerAngles.x = 0
				var_530_4.localEulerAngles = var_530_4.localEulerAngles
			end

			local var_530_6 = arg_527_1.actors_["1094ui_story"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_6) and arg_527_1.var_.characterEffect1094ui_story == nil then
				arg_527_1.var_.characterEffect1094ui_story = var_530_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_7 = 0.034000001847744

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_7 and not isNil(var_530_6) then
				if arg_527_1.var_.characterEffect1094ui_story and not isNil(var_530_6) then
					arg_527_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_527_1.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_527_1.time_ - 0) / var_530_7)
				end
			end

			if arg_527_1.time_ >= 0 + var_530_7 and arg_527_1.time_ < 0 + var_530_7 + arg_530_0 and not isNil(var_530_6) and arg_527_1.var_.characterEffect1094ui_story then
				arg_527_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_527_1.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			local var_530_8 = arg_527_1.actors_["1048ui_story"].transform

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos1048ui_story = var_530_8.localPosition
			end

			local var_530_9 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_9 then
				var_530_8.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1048ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_527_1.time_ - 0) / var_530_9)
				var_530_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_8.position).x, (manager.ui.mainCamera.transform.position - var_530_8.position).y, (manager.ui.mainCamera.transform.position - var_530_8.position).z)
				var_530_8.localEulerAngles.z = 0
				var_530_8.localEulerAngles.x = 0
				var_530_8.localEulerAngles = var_530_8.localEulerAngles
			end

			if arg_527_1.time_ >= 0 + var_530_9 and arg_527_1.time_ < 0 + var_530_9 + arg_530_0 then
				var_530_8.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_530_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_530_8.position).x, (manager.ui.mainCamera.transform.position - var_530_8.position).y, (manager.ui.mainCamera.transform.position - var_530_8.position).z)
				var_530_8.localEulerAngles.z = 0
				var_530_8.localEulerAngles.x = 0
				var_530_8.localEulerAngles = var_530_8.localEulerAngles
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/story1048/story1048action/1048action6_1")
			end

			local var_530_10 = arg_527_1.actors_["1048ui_story"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_10) and arg_527_1.var_.characterEffect1048ui_story == nil then
				arg_527_1.var_.characterEffect1048ui_story = var_530_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_11 = 0.0166666666666667

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_11 and not isNil(var_530_10) then
				if arg_527_1.var_.characterEffect1048ui_story and not isNil(var_530_10) then
					arg_527_1.var_.characterEffect1048ui_story.fillFlat = true
					arg_527_1.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_527_1.time_ - 0) / var_530_11)
				end
			end

			if arg_527_1.time_ >= 0 + var_530_11 and arg_527_1.time_ < 0 + var_530_11 + arg_530_0 and not isNil(var_530_10) and arg_527_1.var_.characterEffect1048ui_story then
				arg_527_1.var_.characterEffect1048ui_story.fillFlat = true
				arg_527_1.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			local var_530_12 = 0
			local var_530_13 = 0.3

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_12 + arg_530_0 then
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

				local var_530_14 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(1101102128).content)

				arg_527_1.text_.text = var_530_14

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_16 = 12 <= 0 and var_530_13 or var_530_13 * (utf8.len(var_530_14) / 12)

				if (12 <= 0 and var_530_13 or var_530_13 * (utf8.len(var_530_14) / 12)) > 0 and var_530_13 < var_530_16 then
					arg_527_1.talkMaxDuration = var_530_16

					if var_530_16 + var_530_12 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_16 + var_530_12
					end
				end

				arg_527_1.text_.text = var_530_14
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_17 = math.max(var_530_13, arg_527_1.talkMaxDuration)

			if var_530_12 <= arg_527_1.time_ and arg_527_1.time_ < var_530_12 + var_530_17 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_12) / var_530_17

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_12 + var_530_17 and arg_527_1.time_ < var_530_12 + var_530_17 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_527_1:InitPlayNodeList()
	end,
	Play1101102129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1101102129
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1101102130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0.575

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_1 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(1101102129).content)

				arg_531_1.text_.text = var_534_1

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_3 = 23 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_1) / 23)

				if (23 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_1) / 23)) > 0 and var_534_0 < var_534_3 then
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
	Play1101102130 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1101102130
		arg_535_1.duration_ = 9

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1101102131(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 2 < arg_535_1.time_ and arg_535_1.time_ <= 2 + arg_538_0 then
				local var_538_0 = arg_535_1.bgs_.ST12

				arg_535_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_538_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_538_1 = var_538_0:GetComponent("SpriteRenderer")

				if var_538_1 and var_538_1.sprite then
					local var_538_2 = 2 * (var_538_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_538_0.transform.localScale = Vector3.New(var_538_2 / var_538_1.sprite.bounds.size.y < var_538_2 * manager.ui.mainCameraCom_.aspect / var_538_1.sprite.bounds.size.x and var_538_2 * manager.ui.mainCameraCom_.aspect / var_538_1.sprite.bounds.size.x or var_538_2 / var_538_1.sprite.bounds.size.y, var_538_2 / var_538_1.sprite.bounds.size.y < var_538_2 * manager.ui.mainCameraCom_.aspect / var_538_1.sprite.bounds.size.x and var_538_2 * manager.ui.mainCameraCom_.aspect / var_538_1.sprite.bounds.size.x or var_538_2 / var_538_1.sprite.bounds.size.y, 0)
				end

				for iter_538_0, iter_538_1 in pairs(arg_535_1.bgs_) do
					if iter_538_0 ~= "ST12" then
						iter_538_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_538_3 = 0

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_3 + arg_538_0 then
				arg_535_1.mask_.enabled = true
				arg_535_1.mask_.raycastTarget = true

				arg_535_1:SetGaussion(false)
			end

			local var_538_4 = 2

			if var_538_3 <= arg_535_1.time_ and arg_535_1.time_ < var_538_3 + var_538_4 then
				local var_538_5 = Color.New(0, 0, 0)

				var_538_5.a = Mathf.Lerp(0, 1, (arg_535_1.time_ - var_538_3) / var_538_4)
				arg_535_1.mask_.color = var_538_5
			end

			if arg_535_1.time_ >= var_538_3 + var_538_4 and arg_535_1.time_ < var_538_3 + var_538_4 + arg_538_0 then
				local var_538_6 = Color.New(0, 0, 0)

				var_538_6.a = 1
				arg_535_1.mask_.color = var_538_6
			end

			local var_538_7 = 2

			if 2 < arg_535_1.time_ and arg_535_1.time_ <= var_538_7 + arg_538_0 then
				arg_535_1.mask_.enabled = true
				arg_535_1.mask_.raycastTarget = true

				arg_535_1:SetGaussion(false)
			end

			local var_538_8 = 2

			if var_538_7 <= arg_535_1.time_ and arg_535_1.time_ < var_538_7 + var_538_8 then
				local var_538_9 = Color.New(0, 0, 0)

				var_538_9.a = Mathf.Lerp(1, 0, (arg_535_1.time_ - var_538_7) / var_538_8)
				arg_535_1.mask_.color = var_538_9
			end

			if arg_535_1.time_ >= var_538_7 + var_538_8 and arg_535_1.time_ < var_538_7 + var_538_8 + arg_538_0 then
				local var_538_10 = Color.New(0, 0, 0)

				arg_535_1.mask_.enabled = false
				var_538_10.a = 0
				arg_535_1.mask_.color = var_538_10
			end

			local var_538_11 = arg_535_1.actors_["1011ui_story"].transform

			if 2 < arg_535_1.time_ and arg_535_1.time_ <= 2 + arg_538_0 then
				arg_535_1.var_.moveOldPos1011ui_story = var_538_11.localPosition
			end

			local var_538_12 = 0.001

			if 2 <= arg_535_1.time_ and arg_535_1.time_ < 2 + var_538_12 then
				var_538_11.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_535_1.time_ - 2) / var_538_12)
				var_538_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_11.position).x, (manager.ui.mainCamera.transform.position - var_538_11.position).y, (manager.ui.mainCamera.transform.position - var_538_11.position).z)
				var_538_11.localEulerAngles.z = 0
				var_538_11.localEulerAngles.x = 0
				var_538_11.localEulerAngles = var_538_11.localEulerAngles
			end

			if arg_535_1.time_ >= 2 + var_538_12 and arg_535_1.time_ < 2 + var_538_12 + arg_538_0 then
				var_538_11.localPosition = Vector3.New(0, 100, 0)
				var_538_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_11.position).x, (manager.ui.mainCamera.transform.position - var_538_11.position).y, (manager.ui.mainCamera.transform.position - var_538_11.position).z)
				var_538_11.localEulerAngles.z = 0
				var_538_11.localEulerAngles.x = 0
				var_538_11.localEulerAngles = var_538_11.localEulerAngles
			end

			local var_538_13 = arg_535_1.actors_["1094ui_story"].transform

			if 2 < arg_535_1.time_ and arg_535_1.time_ <= 2 + arg_538_0 then
				arg_535_1.var_.moveOldPos1094ui_story = var_538_13.localPosition
			end

			local var_538_14 = 0.001

			if 2 <= arg_535_1.time_ and arg_535_1.time_ < 2 + var_538_14 then
				var_538_13.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (arg_535_1.time_ - 2) / var_538_14)
				var_538_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_13.position).x, (manager.ui.mainCamera.transform.position - var_538_13.position).y, (manager.ui.mainCamera.transform.position - var_538_13.position).z)
				var_538_13.localEulerAngles.z = 0
				var_538_13.localEulerAngles.x = 0
				var_538_13.localEulerAngles = var_538_13.localEulerAngles
			end

			if arg_535_1.time_ >= 2 + var_538_14 and arg_535_1.time_ < 2 + var_538_14 + arg_538_0 then
				var_538_13.localPosition = Vector3.New(0, 100, 0)
				var_538_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_13.position).x, (manager.ui.mainCamera.transform.position - var_538_13.position).y, (manager.ui.mainCamera.transform.position - var_538_13.position).z)
				var_538_13.localEulerAngles.z = 0
				var_538_13.localEulerAngles.x = 0
				var_538_13.localEulerAngles = var_538_13.localEulerAngles
			end

			local var_538_15 = arg_535_1.actors_["1048ui_story"].transform

			if 2 < arg_535_1.time_ and arg_535_1.time_ <= 2 + arg_538_0 then
				arg_535_1.var_.moveOldPos1048ui_story = var_538_15.localPosition
			end

			local var_538_16 = 0.001

			if 2 <= arg_535_1.time_ and arg_535_1.time_ < 2 + var_538_16 then
				var_538_15.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (arg_535_1.time_ - 2) / var_538_16)
				var_538_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_15.position).x, (manager.ui.mainCamera.transform.position - var_538_15.position).y, (manager.ui.mainCamera.transform.position - var_538_15.position).z)
				var_538_15.localEulerAngles.z = 0
				var_538_15.localEulerAngles.x = 0
				var_538_15.localEulerAngles = var_538_15.localEulerAngles
			end

			if arg_535_1.time_ >= 2 + var_538_16 and arg_535_1.time_ < 2 + var_538_16 + arg_538_0 then
				var_538_15.localPosition = Vector3.New(0, 100, 0)
				var_538_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_15.position).x, (manager.ui.mainCamera.transform.position - var_538_15.position).y, (manager.ui.mainCamera.transform.position - var_538_15.position).z)
				var_538_15.localEulerAngles.z = 0
				var_538_15.localEulerAngles.x = 0
				var_538_15.localEulerAngles = var_538_15.localEulerAngles
			end

			if arg_535_1.frameCnt_ <= 1 then
				arg_535_1.dialog_:SetActive(false)
			end

			local var_538_17 = 4
			local var_538_18 = 1.25

			if 4 < arg_535_1.time_ and arg_535_1.time_ <= var_538_17 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0

				arg_535_1.dialog_:SetActive(true)

				arg_535_1.dialogCg_.alpha = 0

				local var_538_19 = LeanTween.value(arg_535_1.dialog_, 0, 1, 0.3)

				var_538_19:setOnUpdate(LuaHelper.FloatAction(function(arg_539_0)
					arg_535_1.dialogCg_.alpha = arg_539_0
				end))
				var_538_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_535_1.dialog_)
					var_538_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_535_1.duration_ = arg_535_1.duration_ + 0.3

				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_20 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(1101102130).content)

				arg_535_1.text_.text = var_538_20

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_22 = 50 <= 0 and var_538_18 or var_538_18 * (utf8.len(var_538_20) / 50)

				if (50 <= 0 and var_538_18 or var_538_18 * (utf8.len(var_538_20) / 50)) > 0 and var_538_18 < var_538_22 then
					arg_535_1.talkMaxDuration = var_538_22
					var_538_17 = var_538_17 + 0.3

					if var_538_22 + var_538_17 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_22 + var_538_17
					end
				end

				arg_535_1.text_.text = var_538_20
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_23 = var_538_17 + 0.3
			local var_538_24 = math.max(var_538_18, arg_535_1.talkMaxDuration)

			if var_538_17 + 0.3 <= arg_535_1.time_ and arg_535_1.time_ < var_538_23 + var_538_24 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_23) / var_538_24

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_23 + var_538_24 and arg_535_1.time_ < var_538_23 + var_538_24 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1048ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play1101102131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1101102131
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1101102132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0.35

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_1 = arg_541_1:FormatText(arg_541_1:GetWordFromCfg(1101102131).content)

				arg_541_1.text_.text = var_544_1

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_3 = 14 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_1) / 14)

				if (14 <= 0 and var_544_0 or var_544_0 * (utf8.len(var_544_1) / 14)) > 0 and var_544_0 < var_544_3 then
					arg_541_1.talkMaxDuration = var_544_3

					if var_544_3 + 0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_3 + 0
					end
				end

				arg_541_1.text_.text = var_544_1
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_4 = math.max(var_544_0, arg_541_1.talkMaxDuration)

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_4 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - 0) / var_544_4

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= 0 + var_544_4 and arg_541_1.time_ < 0 + var_544_4 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1101102132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1101102132
		arg_545_1.duration_ = 2

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1101102133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos1011ui_story = arg_545_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_548_0 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 then
				arg_545_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_545_1.time_ - 0) / var_548_0)
				arg_545_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1011ui_story"].transform.position).z)
				arg_545_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1011ui_story"].transform.localEulerAngles = arg_545_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 then
				arg_545_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_545_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_545_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_545_1.actors_["1011ui_story"].transform.position).z)
				arg_545_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_545_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_545_1.actors_["1011ui_story"].transform.localEulerAngles = arg_545_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_548_1 = arg_545_1.actors_["1011ui_story"]

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1011ui_story == nil then
				arg_545_1.var_.characterEffect1011ui_story = var_548_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_2 = 0.200000002980232

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_2 and not isNil(var_548_1) then
				if arg_545_1.var_.characterEffect1011ui_story and not isNil(var_548_1) then
					arg_545_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= 0 + var_548_2 and arg_545_1.time_ < 0 + var_548_2 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1011ui_story then
				arg_545_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_548_4 = 0
			local var_548_5 = 0.05

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_4 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_6 = arg_545_1:GetWordFromCfg(1101102132)
				local var_548_7 = arg_545_1:FormatText(var_548_6.content)

				arg_545_1.text_.text = var_548_7

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_9 = 2 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 2)

				if (2 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 2)) > 0 and var_548_5 < var_548_9 then
					arg_545_1.talkMaxDuration = var_548_9

					if var_548_9 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_9 + var_548_4
					end
				end

				arg_545_1.text_.text = var_548_7
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102132", "story_v_side_new_1101102.awb") ~= 0 then
					local var_548_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102132", "story_v_side_new_1101102.awb") / 1000

					if var_548_10 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_10 + var_548_4
					end

					if var_548_6.prefab_name ~= "" and arg_545_1.actors_[var_548_6.prefab_name] ~= nil then
						local var_548_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_6.prefab_name].transform, "story_v_side_new_1101102", "1101102132", "story_v_side_new_1101102.awb")

						arg_545_1:RecordAudio("1101102132", var_548_11)
						arg_545_1:RecordAudio("1101102132", var_548_11)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102132", "story_v_side_new_1101102.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102132", "story_v_side_new_1101102.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_12 = math.max(var_548_5, arg_545_1.talkMaxDuration)

			if var_548_4 <= arg_545_1.time_ and arg_545_1.time_ < var_548_4 + var_548_12 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_4) / var_548_12

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_4 + var_548_12 and arg_545_1.time_ < var_548_4 + var_548_12 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play1101102133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1101102133
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1101102134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(arg_549_1.actors_["1011ui_story"]) and arg_549_1.var_.characterEffect1011ui_story == nil then
				arg_549_1.var_.characterEffect1011ui_story = arg_549_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_0 = 0.200000002980232

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_0 and not isNil(arg_549_1.actors_["1011ui_story"]) then
				if arg_549_1.var_.characterEffect1011ui_story and not isNil(arg_549_1.actors_["1011ui_story"]) then
					arg_549_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_549_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_549_1.time_ - 0) / var_552_0)
				end
			end

			if arg_549_1.time_ >= 0 + var_552_0 and arg_549_1.time_ < 0 + var_552_0 + arg_552_0 and not isNil(arg_549_1.actors_["1011ui_story"]) and arg_549_1.var_.characterEffect1011ui_story then
				arg_549_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_549_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_552_1 = 0
			local var_552_2 = 0.425

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_1 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, true)
				arg_549_1.iconController_:SetSelectedState("hero")

				arg_549_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_549_1.callingController_:SetSelectedState("normal")

				arg_549_1.keyicon_.color = Color.New(1, 1, 1)
				arg_549_1.icon_.color = Color.New(1, 1, 1)

				local var_552_3 = arg_549_1:FormatText(arg_549_1:GetWordFromCfg(1101102133).content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 17 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_3) / 17)

				if (17 <= 0 and var_552_2 or var_552_2 * (utf8.len(var_552_3) / 17)) > 0 and var_552_2 < var_552_5 then
					arg_549_1.talkMaxDuration = var_552_5

					if var_552_5 + var_552_1 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_5 + var_552_1
					end
				end

				arg_549_1.text_.text = var_552_3
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_6 = math.max(var_552_2, arg_549_1.talkMaxDuration)

			if var_552_1 <= arg_549_1.time_ and arg_549_1.time_ < var_552_1 + var_552_6 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_1) / var_552_6

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_1 + var_552_6 and arg_549_1.time_ < var_552_1 + var_552_6 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1101102134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1101102134
		arg_553_1.duration_ = 7.33

		local var_553_0 = {
			zh = 6.233,
			ja = 7.333
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1101102135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos1011ui_story = arg_553_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_556_0 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 then
				arg_553_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_553_1.time_ - 0) / var_556_0)
				arg_553_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_553_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1011ui_story"].transform.position).z)
				arg_553_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_553_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_553_1.actors_["1011ui_story"].transform.localEulerAngles = arg_553_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 then
				arg_553_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_553_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_553_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_553_1.actors_["1011ui_story"].transform.position).z)
				arg_553_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_553_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_553_1.actors_["1011ui_story"].transform.localEulerAngles = arg_553_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_556_1 = arg_553_1.actors_["1011ui_story"]

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect1011ui_story == nil then
				arg_553_1.var_.characterEffect1011ui_story = var_556_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_2 and not isNil(var_556_1) then
				if arg_553_1.var_.characterEffect1011ui_story and not isNil(var_556_1) then
					arg_553_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= 0 + var_556_2 and arg_553_1.time_ < 0 + var_556_2 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect1011ui_story then
				arg_553_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_556_4 = 0
			local var_556_5 = 0.675

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_4 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_6 = arg_553_1:GetWordFromCfg(1101102134)
				local var_556_7 = arg_553_1:FormatText(var_556_6.content)

				arg_553_1.text_.text = var_556_7

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_9 = 27 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 27)

				if (27 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 27)) > 0 and var_556_5 < var_556_9 then
					arg_553_1.talkMaxDuration = var_556_9

					if var_556_9 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_9 + var_556_4
					end
				end

				arg_553_1.text_.text = var_556_7
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102134", "story_v_side_new_1101102.awb") ~= 0 then
					local var_556_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102134", "story_v_side_new_1101102.awb") / 1000

					if var_556_10 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_10 + var_556_4
					end

					if var_556_6.prefab_name ~= "" and arg_553_1.actors_[var_556_6.prefab_name] ~= nil then
						local var_556_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_6.prefab_name].transform, "story_v_side_new_1101102", "1101102134", "story_v_side_new_1101102.awb")

						arg_553_1:RecordAudio("1101102134", var_556_11)
						arg_553_1:RecordAudio("1101102134", var_556_11)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102134", "story_v_side_new_1101102.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102134", "story_v_side_new_1101102.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_12 = math.max(var_556_5, arg_553_1.talkMaxDuration)

			if var_556_4 <= arg_553_1.time_ and arg_553_1.time_ < var_556_4 + var_556_12 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_4) / var_556_12

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_4 + var_556_12 and arg_553_1.time_ < var_556_4 + var_556_12 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_553_1:InitPlayNodeList()
	end,
	Play1101102135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1101102135
		arg_557_1.duration_ = 8.23

		local var_557_0 = {
			zh = 8.233,
			ja = 4.4
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1101102136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0.925

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_1 = arg_557_1:GetWordFromCfg(1101102135)
				local var_560_2 = arg_557_1:FormatText(var_560_1.content)

				arg_557_1.text_.text = var_560_2

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_4 = 37 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 37)

				if (37 <= 0 and var_560_0 or var_560_0 * (utf8.len(var_560_2) / 37)) > 0 and var_560_0 < var_560_4 then
					arg_557_1.talkMaxDuration = var_560_4

					if var_560_4 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_4 + 0
					end
				end

				arg_557_1.text_.text = var_560_2
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102135", "story_v_side_new_1101102.awb") ~= 0 then
					local var_560_5 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102135", "story_v_side_new_1101102.awb") / 1000

					if var_560_5 + 0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_5 + 0
					end

					if var_560_1.prefab_name ~= "" and arg_557_1.actors_[var_560_1.prefab_name] ~= nil then
						local var_560_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_1.prefab_name].transform, "story_v_side_new_1101102", "1101102135", "story_v_side_new_1101102.awb")

						arg_557_1:RecordAudio("1101102135", var_560_6)
						arg_557_1:RecordAudio("1101102135", var_560_6)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102135", "story_v_side_new_1101102.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102135", "story_v_side_new_1101102.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_7 = math.max(var_560_0, arg_557_1.talkMaxDuration)

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_7 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - 0) / var_560_7

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= 0 + var_560_7 and arg_557_1.time_ < 0 + var_560_7 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1101102136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1101102136
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1101102137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(arg_561_1.actors_["1011ui_story"]) and arg_561_1.var_.characterEffect1011ui_story == nil then
				arg_561_1.var_.characterEffect1011ui_story = arg_561_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_0 = 0.200000002980232

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 and not isNil(arg_561_1.actors_["1011ui_story"]) then
				if arg_561_1.var_.characterEffect1011ui_story and not isNil(arg_561_1.actors_["1011ui_story"]) then
					arg_561_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_561_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_561_1.time_ - 0) / var_564_0)
				end
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 and not isNil(arg_561_1.actors_["1011ui_story"]) and arg_561_1.var_.characterEffect1011ui_story then
				arg_561_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_561_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_564_1 = 0
			local var_564_2 = 0.425

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_3 = arg_561_1:FormatText(arg_561_1:GetWordFromCfg(1101102136).content)

				arg_561_1.text_.text = var_564_3

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_5 = 17 <= 0 and var_564_2 or var_564_2 * (utf8.len(var_564_3) / 17)

				if (17 <= 0 and var_564_2 or var_564_2 * (utf8.len(var_564_3) / 17)) > 0 and var_564_2 < var_564_5 then
					arg_561_1.talkMaxDuration = var_564_5

					if var_564_5 + var_564_1 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_5 + var_564_1
					end
				end

				arg_561_1.text_.text = var_564_3
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_6 = math.max(var_564_2, arg_561_1.talkMaxDuration)

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_6 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_1) / var_564_6

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_1 + var_564_6 and arg_561_1.time_ < var_564_1 + var_564_6 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1101102137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1101102137
		arg_565_1.duration_ = 11.8

		local var_565_0 = {
			zh = 10.5,
			ja = 11.8
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1101102138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if arg_565_1.bgs_.ST19 == nil then
				local var_568_0 = Object.Instantiate(arg_565_1.paintGo_)

				var_568_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST19")
				var_568_0.name = "ST19"
				var_568_0.transform.parent = arg_565_1.stage_.transform
				var_568_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_565_1.bgs_.ST19 = var_568_0
			end

			if 3 < arg_565_1.time_ and arg_565_1.time_ <= 3 + arg_568_0 then
				local var_568_1 = arg_565_1.bgs_.ST19

				arg_565_1.bgs_.ST19.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_568_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_568_2 = var_568_1:GetComponent("SpriteRenderer")

				if var_568_2 and var_568_2.sprite then
					local var_568_3 = 2 * (var_568_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_568_1.transform.localScale = Vector3.New(var_568_3 / var_568_2.sprite.bounds.size.y < var_568_3 * manager.ui.mainCameraCom_.aspect / var_568_2.sprite.bounds.size.x and var_568_3 * manager.ui.mainCameraCom_.aspect / var_568_2.sprite.bounds.size.x or var_568_3 / var_568_2.sprite.bounds.size.y, var_568_3 / var_568_2.sprite.bounds.size.y < var_568_3 * manager.ui.mainCameraCom_.aspect / var_568_2.sprite.bounds.size.x and var_568_3 * manager.ui.mainCameraCom_.aspect / var_568_2.sprite.bounds.size.x or var_568_3 / var_568_2.sprite.bounds.size.y, 0)
				end

				for iter_568_0, iter_568_1 in pairs(arg_565_1.bgs_) do
					if iter_568_0 ~= "ST19" then
						iter_568_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_568_4 = 0

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_4 + arg_568_0 then
				arg_565_1.mask_.enabled = true
				arg_565_1.mask_.raycastTarget = true

				arg_565_1:SetGaussion(false)
			end

			local var_568_5 = 3

			if var_568_4 <= arg_565_1.time_ and arg_565_1.time_ < var_568_4 + var_568_5 then
				local var_568_6 = Color.New(0, 0, 0)

				var_568_6.a = Mathf.Lerp(0, 1, (arg_565_1.time_ - var_568_4) / var_568_5)
				arg_565_1.mask_.color = var_568_6
			end

			if arg_565_1.time_ >= var_568_4 + var_568_5 and arg_565_1.time_ < var_568_4 + var_568_5 + arg_568_0 then
				local var_568_7 = Color.New(0, 0, 0)

				var_568_7.a = 1
				arg_565_1.mask_.color = var_568_7
			end

			local var_568_8 = 3

			if 3 < arg_565_1.time_ and arg_565_1.time_ <= var_568_8 + arg_568_0 then
				arg_565_1.mask_.enabled = true
				arg_565_1.mask_.raycastTarget = true

				arg_565_1:SetGaussion(false)
			end

			local var_568_9 = 3

			if var_568_8 <= arg_565_1.time_ and arg_565_1.time_ < var_568_8 + var_568_9 then
				local var_568_10 = Color.New(0, 0, 0)

				var_568_10.a = Mathf.Lerp(1, 0, (arg_565_1.time_ - var_568_8) / var_568_9)
				arg_565_1.mask_.color = var_568_10
			end

			if arg_565_1.time_ >= var_568_8 + var_568_9 and arg_565_1.time_ < var_568_8 + var_568_9 + arg_568_0 then
				local var_568_11 = Color.New(0, 0, 0)

				arg_565_1.mask_.enabled = false
				var_568_11.a = 0
				arg_565_1.mask_.color = var_568_11
			end

			local var_568_12 = "1111ui_story"

			if arg_565_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_568_13 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_565_1.stage_.transform)

				var_568_13.name = var_568_12
				var_568_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_565_1.actors_[var_568_12] = var_568_13

				local var_568_14 = var_568_13:GetComponentInChildren(typeof(CharacterEffect))

				var_568_14.enabled = true

				local var_568_15 = GameObjectTools.GetOrAddComponent(var_568_13, typeof(DynamicBoneHelper))

				if var_568_15 then
					var_568_15:EnableDynamicBone(false)
				end

				arg_565_1:ShowWeapon(var_568_14.transform, false)

				arg_565_1.var_[var_568_12 .. "Animator"] = var_568_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_565_1.var_[var_568_12 .. "Animator"].applyRootMotion = true
				arg_565_1.var_[var_568_12 .. "LipSync"] = var_568_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_568_16 = arg_565_1.actors_["1111ui_story"].transform

			if 6 < arg_565_1.time_ and arg_565_1.time_ <= 6 + arg_568_0 then
				arg_565_1.var_.moveOldPos1111ui_story = var_568_16.localPosition
			end

			local var_568_17 = 0.001

			if 6 <= arg_565_1.time_ and arg_565_1.time_ < 6 + var_568_17 then
				var_568_16.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_565_1.time_ - 6) / var_568_17)
				var_568_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_568_16.position).x, (manager.ui.mainCamera.transform.position - var_568_16.position).y, (manager.ui.mainCamera.transform.position - var_568_16.position).z)
				var_568_16.localEulerAngles.z = 0
				var_568_16.localEulerAngles.x = 0
				var_568_16.localEulerAngles = var_568_16.localEulerAngles
			end

			if arg_565_1.time_ >= 6 + var_568_17 and arg_565_1.time_ < 6 + var_568_17 + arg_568_0 then
				var_568_16.localPosition = Vector3.New(0, -0.87, -5.7)
				var_568_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_568_16.position).x, (manager.ui.mainCamera.transform.position - var_568_16.position).y, (manager.ui.mainCamera.transform.position - var_568_16.position).z)
				var_568_16.localEulerAngles.z = 0
				var_568_16.localEulerAngles.x = 0
				var_568_16.localEulerAngles = var_568_16.localEulerAngles
			end

			local var_568_18 = arg_565_1.actors_["1111ui_story"]

			if 6 < arg_565_1.time_ and arg_565_1.time_ <= 6 + arg_568_0 and not isNil(var_568_18) and arg_565_1.var_.characterEffect1111ui_story == nil then
				arg_565_1.var_.characterEffect1111ui_story = var_568_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_19 = 0.200000002980232

			if 6 <= arg_565_1.time_ and arg_565_1.time_ < 6 + var_568_19 and not isNil(var_568_18) then
				if arg_565_1.var_.characterEffect1111ui_story and not isNil(var_568_18) then
					arg_565_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_565_1.time_ - 6) / var_568_19)
				end
			end

			if arg_565_1.time_ >= 6 + var_568_19 and arg_565_1.time_ < 6 + var_568_19 + arg_568_0 and not isNil(var_568_18) and arg_565_1.var_.characterEffect1111ui_story then
				arg_565_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_568_20 = arg_565_1.actors_["1011ui_story"].transform

			if 3 < arg_565_1.time_ and arg_565_1.time_ <= 3 + arg_568_0 then
				arg_565_1.var_.moveOldPos1011ui_story = var_568_20.localPosition
			end

			local var_568_21 = 0.001

			if 3 <= arg_565_1.time_ and arg_565_1.time_ < 3 + var_568_21 then
				var_568_20.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_565_1.time_ - 3) / var_568_21)
				var_568_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_568_20.position).x, (manager.ui.mainCamera.transform.position - var_568_20.position).y, (manager.ui.mainCamera.transform.position - var_568_20.position).z)
				var_568_20.localEulerAngles.z = 0
				var_568_20.localEulerAngles.x = 0
				var_568_20.localEulerAngles = var_568_20.localEulerAngles
			end

			if arg_565_1.time_ >= 3 + var_568_21 and arg_565_1.time_ < 3 + var_568_21 + arg_568_0 then
				var_568_20.localPosition = Vector3.New(0, 100, 0)
				var_568_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_568_20.position).x, (manager.ui.mainCamera.transform.position - var_568_20.position).y, (manager.ui.mainCamera.transform.position - var_568_20.position).z)
				var_568_20.localEulerAngles.z = 0
				var_568_20.localEulerAngles.x = 0
				var_568_20.localEulerAngles = var_568_20.localEulerAngles
			end

			if 6 < arg_565_1.time_ and arg_565_1.time_ <= 6 + arg_568_0 then
				arg_565_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 6 < arg_565_1.time_ and arg_565_1.time_ <= 6 + arg_568_0 then
				arg_565_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if arg_565_1.frameCnt_ <= 1 then
				arg_565_1.dialog_:SetActive(false)
			end

			local var_568_22 = 6
			local var_568_23 = 0.425

			if 6 < arg_565_1.time_ and arg_565_1.time_ <= var_568_22 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0

				arg_565_1.dialog_:SetActive(true)

				arg_565_1.dialogCg_.alpha = 0

				local var_568_24 = LeanTween.value(arg_565_1.dialog_, 0, 1, 0.3)

				var_568_24:setOnUpdate(LuaHelper.FloatAction(function(arg_569_0)
					arg_565_1.dialogCg_.alpha = arg_569_0
				end))
				var_568_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_565_1.dialog_)
					var_568_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_565_1.duration_ = arg_565_1.duration_ + 0.3

				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, true)
				arg_565_1.iconController_:SetSelectedState("hero")

				arg_565_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_565_1.callingController_:SetSelectedState("normal")

				arg_565_1.keyicon_.color = Color.New(1, 1, 1)
				arg_565_1.icon_.color = Color.New(1, 1, 1)

				local var_568_25 = arg_565_1:GetWordFromCfg(1101102137)
				local var_568_26 = arg_565_1:FormatText(var_568_25.content)

				arg_565_1.text_.text = var_568_26

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_28 = 17 <= 0 and var_568_23 or var_568_23 * (utf8.len(var_568_26) / 17)

				if (17 <= 0 and var_568_23 or var_568_23 * (utf8.len(var_568_26) / 17)) > 0 and var_568_23 < var_568_28 then
					arg_565_1.talkMaxDuration = var_568_28
					var_568_22 = var_568_22 + 0.3

					if var_568_28 + var_568_22 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_28 + var_568_22
					end
				end

				arg_565_1.text_.text = var_568_26
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102137", "story_v_side_new_1101102.awb") ~= 0 then
					local var_568_29 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102137", "story_v_side_new_1101102.awb") / 1000

					if var_568_29 + var_568_22 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_29 + var_568_22
					end

					if var_568_25.prefab_name ~= "" and arg_565_1.actors_[var_568_25.prefab_name] ~= nil then
						local var_568_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_25.prefab_name].transform, "story_v_side_new_1101102", "1101102137", "story_v_side_new_1101102.awb")

						arg_565_1:RecordAudio("1101102137", var_568_30)
						arg_565_1:RecordAudio("1101102137", var_568_30)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102137", "story_v_side_new_1101102.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102137", "story_v_side_new_1101102.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_31 = var_568_22 + 0.3
			local var_568_32 = math.max(var_568_23, arg_565_1.talkMaxDuration)

			if var_568_22 + 0.3 <= arg_565_1.time_ and arg_565_1.time_ < var_568_31 + var_568_32 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_31) / var_568_32

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_31 + var_568_32 and arg_565_1.time_ < var_568_31 + var_568_32 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 6,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_565_1:InitPlayNodeList()
	end,
	Play1101102138 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 1101102138
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play1101102139(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(arg_571_1.actors_["1111ui_story"]) and arg_571_1.var_.characterEffect1111ui_story == nil then
				arg_571_1.var_.characterEffect1111ui_story = arg_571_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_574_0 = 0.200000002980232

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 and not isNil(arg_571_1.actors_["1111ui_story"]) then
				if arg_571_1.var_.characterEffect1111ui_story and not isNil(arg_571_1.actors_["1111ui_story"]) then
					arg_571_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 and not isNil(arg_571_1.actors_["1111ui_story"]) and arg_571_1.var_.characterEffect1111ui_story then
				arg_571_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_574_2 = 0
			local var_574_3 = 0.175

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_2 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_4 = arg_571_1:FormatText(arg_571_1:GetWordFromCfg(1101102138).content)

				arg_571_1.text_.text = var_574_4

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_6 = 7 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_4) / 7)

				if (7 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_4) / 7)) > 0 and var_574_3 < var_574_6 then
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

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play1101102139 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 1101102139
		arg_575_1.duration_ = 4.03

		local var_575_0 = {
			zh = 3.1,
			ja = 4.033
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play1101102140(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.var_.moveOldPos1111ui_story = arg_575_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_578_0 = 0.001

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 then
				arg_575_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_575_1.time_ - 0) / var_578_0)
				arg_575_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["1111ui_story"].transform.position).z)
				arg_575_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["1111ui_story"].transform.localEulerAngles = arg_575_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 then
				arg_575_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_575_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_575_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_575_1.actors_["1111ui_story"].transform.position).z)
				arg_575_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_575_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_575_1.actors_["1111ui_story"].transform.localEulerAngles = arg_575_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_578_1 = arg_575_1.actors_["1111ui_story"]

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(var_578_1) and arg_575_1.var_.characterEffect1111ui_story == nil then
				arg_575_1.var_.characterEffect1111ui_story = var_578_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_578_2 = 0.200000002980232

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_2 and not isNil(var_578_1) then
				if arg_575_1.var_.characterEffect1111ui_story and not isNil(var_578_1) then
					arg_575_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_575_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_575_1.time_ - 0) / var_578_2)
				end
			end

			if arg_575_1.time_ >= 0 + var_578_2 and arg_575_1.time_ < 0 + var_578_2 + arg_578_0 and not isNil(var_578_1) and arg_575_1.var_.characterEffect1111ui_story then
				arg_575_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_575_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_578_3 = 0
			local var_578_4 = 0.3

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_3 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, true)
				arg_575_1.iconController_:SetSelectedState("hero")

				arg_575_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_575_1.callingController_:SetSelectedState("normal")

				arg_575_1.keyicon_.color = Color.New(1, 1, 1)
				arg_575_1.icon_.color = Color.New(1, 1, 1)

				local var_578_5 = arg_575_1:GetWordFromCfg(1101102139)
				local var_578_6 = arg_575_1:FormatText(var_578_5.content)

				arg_575_1.text_.text = var_578_6

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_8 = 12 <= 0 and var_578_4 or var_578_4 * (utf8.len(var_578_6) / 12)

				if (12 <= 0 and var_578_4 or var_578_4 * (utf8.len(var_578_6) / 12)) > 0 and var_578_4 < var_578_8 then
					arg_575_1.talkMaxDuration = var_578_8

					if var_578_8 + var_578_3 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_8 + var_578_3
					end
				end

				arg_575_1.text_.text = var_578_6
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102139", "story_v_side_new_1101102.awb") ~= 0 then
					local var_578_9 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102139", "story_v_side_new_1101102.awb") / 1000

					if var_578_9 + var_578_3 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_9 + var_578_3
					end

					if var_578_5.prefab_name ~= "" and arg_575_1.actors_[var_578_5.prefab_name] ~= nil then
						local var_578_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_5.prefab_name].transform, "story_v_side_new_1101102", "1101102139", "story_v_side_new_1101102.awb")

						arg_575_1:RecordAudio("1101102139", var_578_10)
						arg_575_1:RecordAudio("1101102139", var_578_10)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102139", "story_v_side_new_1101102.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102139", "story_v_side_new_1101102.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_11 = math.max(var_578_4, arg_575_1.talkMaxDuration)

			if var_578_3 <= arg_575_1.time_ and arg_575_1.time_ < var_578_3 + var_578_11 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_3) / var_578_11

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_3 + var_578_11 and arg_575_1.time_ < var_578_3 + var_578_11 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_575_1:InitPlayNodeList()
	end,
	Play1101102140 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 1101102140
		arg_579_1.duration_ = 1

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"

			SetActive(arg_579_1.choicesGo_, true)

			for iter_580_0, iter_580_1 in ipairs(arg_579_1.choices_) do
				SetActive(iter_580_1.go, iter_580_0 <= 1)
			end

			arg_579_1.choices_[1].txt.text = arg_579_1:FormatText(StoryChoiceCfg[609].name)
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play1101102141(arg_579_1)
			end

			arg_579_1:RecordChoiceLog(1101102140, 609)
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 then
				arg_579_1.allBtn_.enabled = false
			end

			if arg_579_1.time_ >= 0 + 0.5 and arg_579_1.time_ < 0 + 0.5 + arg_582_0 then
				arg_579_1.allBtn_.enabled = true
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play1101102141 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 1101102141
		arg_583_1.duration_ = 4.23

		local var_583_0 = {
			zh = 3.999999999999,
			ja = 4.23400000184774
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play1101102142(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 1 < arg_583_1.time_ and arg_583_1.time_ <= 1 + arg_586_0 then
				local var_586_0 = arg_583_1.bgs_.ST12

				arg_583_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_586_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_586_1 = var_586_0:GetComponent("SpriteRenderer")

				if var_586_1 and var_586_1.sprite then
					local var_586_2 = 2 * (var_586_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_586_0.transform.localScale = Vector3.New(var_586_2 / var_586_1.sprite.bounds.size.y < var_586_2 * manager.ui.mainCameraCom_.aspect / var_586_1.sprite.bounds.size.x and var_586_2 * manager.ui.mainCameraCom_.aspect / var_586_1.sprite.bounds.size.x or var_586_2 / var_586_1.sprite.bounds.size.y, var_586_2 / var_586_1.sprite.bounds.size.y < var_586_2 * manager.ui.mainCameraCom_.aspect / var_586_1.sprite.bounds.size.x and var_586_2 * manager.ui.mainCameraCom_.aspect / var_586_1.sprite.bounds.size.x or var_586_2 / var_586_1.sprite.bounds.size.y, 0)
				end

				for iter_586_0, iter_586_1 in pairs(arg_583_1.bgs_) do
					if iter_586_0 ~= "ST12" then
						iter_586_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_586_3 = 0

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_3 + arg_586_0 then
				arg_583_1.mask_.enabled = true
				arg_583_1.mask_.raycastTarget = true

				arg_583_1:SetGaussion(false)
			end

			local var_586_4 = 1

			if var_586_3 <= arg_583_1.time_ and arg_583_1.time_ < var_586_3 + var_586_4 then
				local var_586_5 = Color.New(0, 0, 0)

				var_586_5.a = Mathf.Lerp(0, 1, (arg_583_1.time_ - var_586_3) / var_586_4)
				arg_583_1.mask_.color = var_586_5
			end

			if arg_583_1.time_ >= var_586_3 + var_586_4 and arg_583_1.time_ < var_586_3 + var_586_4 + arg_586_0 then
				local var_586_6 = Color.New(0, 0, 0)

				var_586_6.a = 1
				arg_583_1.mask_.color = var_586_6
			end

			local var_586_7 = 1

			if 1 < arg_583_1.time_ and arg_583_1.time_ <= var_586_7 + arg_586_0 then
				arg_583_1.mask_.enabled = true
				arg_583_1.mask_.raycastTarget = true

				arg_583_1:SetGaussion(false)
			end

			local var_586_8 = 1

			if var_586_7 <= arg_583_1.time_ and arg_583_1.time_ < var_586_7 + var_586_8 then
				local var_586_9 = Color.New(0, 0, 0)

				var_586_9.a = Mathf.Lerp(1, 0, (arg_583_1.time_ - var_586_7) / var_586_8)
				arg_583_1.mask_.color = var_586_9
			end

			if arg_583_1.time_ >= var_586_7 + var_586_8 and arg_583_1.time_ < var_586_7 + var_586_8 + arg_586_0 then
				local var_586_10 = Color.New(0, 0, 0)

				arg_583_1.mask_.enabled = false
				var_586_10.a = 0
				arg_583_1.mask_.color = var_586_10
			end

			local var_586_11 = arg_583_1.actors_["1111ui_story"].transform

			if 1 < arg_583_1.time_ and arg_583_1.time_ <= 1 + arg_586_0 then
				arg_583_1.var_.moveOldPos1111ui_story = var_586_11.localPosition
			end

			local var_586_12 = 0.001

			if 1 <= arg_583_1.time_ and arg_583_1.time_ < 1 + var_586_12 then
				var_586_11.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_583_1.time_ - 1) / var_586_12)
				var_586_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_586_11.position).x, (manager.ui.mainCamera.transform.position - var_586_11.position).y, (manager.ui.mainCamera.transform.position - var_586_11.position).z)
				var_586_11.localEulerAngles.z = 0
				var_586_11.localEulerAngles.x = 0
				var_586_11.localEulerAngles = var_586_11.localEulerAngles
			end

			if arg_583_1.time_ >= 1 + var_586_12 and arg_583_1.time_ < 1 + var_586_12 + arg_586_0 then
				var_586_11.localPosition = Vector3.New(0, 100, 0)
				var_586_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_586_11.position).x, (manager.ui.mainCamera.transform.position - var_586_11.position).y, (manager.ui.mainCamera.transform.position - var_586_11.position).z)
				var_586_11.localEulerAngles.z = 0
				var_586_11.localEulerAngles.x = 0
				var_586_11.localEulerAngles = var_586_11.localEulerAngles
			end

			local var_586_13 = arg_583_1.actors_["1011ui_story"].transform

			if 2 < arg_583_1.time_ and arg_583_1.time_ <= 2 + arg_586_0 then
				arg_583_1.var_.moveOldPos1011ui_story = var_586_13.localPosition
			end

			local var_586_14 = 0.001

			if 2 <= arg_583_1.time_ and arg_583_1.time_ < 2 + var_586_14 then
				var_586_13.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_583_1.time_ - 2) / var_586_14)
				var_586_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_586_13.position).x, (manager.ui.mainCamera.transform.position - var_586_13.position).y, (manager.ui.mainCamera.transform.position - var_586_13.position).z)
				var_586_13.localEulerAngles.z = 0
				var_586_13.localEulerAngles.x = 0
				var_586_13.localEulerAngles = var_586_13.localEulerAngles
			end

			if arg_583_1.time_ >= 2 + var_586_14 and arg_583_1.time_ < 2 + var_586_14 + arg_586_0 then
				var_586_13.localPosition = Vector3.New(0, -0.71, -6)
				var_586_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_586_13.position).x, (manager.ui.mainCamera.transform.position - var_586_13.position).y, (manager.ui.mainCamera.transform.position - var_586_13.position).z)
				var_586_13.localEulerAngles.z = 0
				var_586_13.localEulerAngles.x = 0
				var_586_13.localEulerAngles = var_586_13.localEulerAngles
			end

			local var_586_15 = arg_583_1.actors_["1011ui_story"]

			if 2 < arg_583_1.time_ and arg_583_1.time_ <= 2 + arg_586_0 and not isNil(var_586_15) and arg_583_1.var_.characterEffect1011ui_story == nil then
				arg_583_1.var_.characterEffect1011ui_story = var_586_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_586_16 = 0.200000002980232

			if 2 <= arg_583_1.time_ and arg_583_1.time_ < 2 + var_586_16 and not isNil(var_586_15) then
				if arg_583_1.var_.characterEffect1011ui_story and not isNil(var_586_15) then
					arg_583_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_583_1.time_ >= 2 + var_586_16 and arg_583_1.time_ < 2 + var_586_16 + arg_586_0 and not isNil(var_586_15) and arg_583_1.var_.characterEffect1011ui_story then
				arg_583_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 2 < arg_583_1.time_ and arg_583_1.time_ <= 2 + arg_586_0 then
				arg_583_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_1")
			end

			if 2 < arg_583_1.time_ and arg_583_1.time_ <= 2 + arg_586_0 then
				arg_583_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if arg_583_1.frameCnt_ <= 1 then
				arg_583_1.dialog_:SetActive(false)
			end

			local var_586_18 = 2.03400000184774
			local var_586_19 = 0.1

			if 2.03400000184774 < arg_583_1.time_ and arg_583_1.time_ <= var_586_18 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0

				arg_583_1.dialog_:SetActive(true)

				arg_583_1.dialogCg_.alpha = 0

				local var_586_20 = LeanTween.value(arg_583_1.dialog_, 0, 1, 0.3)

				var_586_20:setOnUpdate(LuaHelper.FloatAction(function(arg_587_0)
					arg_583_1.dialogCg_.alpha = arg_587_0
				end))
				var_586_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_583_1.dialog_)
					var_586_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_583_1.duration_ = arg_583_1.duration_ + 0.3

				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_21 = arg_583_1:GetWordFromCfg(1101102141)
				local var_586_22 = arg_583_1:FormatText(var_586_21.content)

				arg_583_1.text_.text = var_586_22

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_24 = 4 <= 0 and var_586_19 or var_586_19 * (utf8.len(var_586_22) / 4)

				if (4 <= 0 and var_586_19 or var_586_19 * (utf8.len(var_586_22) / 4)) > 0 and var_586_19 < var_586_24 then
					arg_583_1.talkMaxDuration = var_586_24
					var_586_18 = var_586_18 + 0.3

					if var_586_24 + var_586_18 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_24 + var_586_18
					end
				end

				arg_583_1.text_.text = var_586_22
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102141", "story_v_side_new_1101102.awb") ~= 0 then
					local var_586_25 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102141", "story_v_side_new_1101102.awb") / 1000

					if var_586_25 + var_586_18 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_25 + var_586_18
					end

					if var_586_21.prefab_name ~= "" and arg_583_1.actors_[var_586_21.prefab_name] ~= nil then
						local var_586_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_21.prefab_name].transform, "story_v_side_new_1101102", "1101102141", "story_v_side_new_1101102.awb")

						arg_583_1:RecordAudio("1101102141", var_586_26)
						arg_583_1:RecordAudio("1101102141", var_586_26)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102141", "story_v_side_new_1101102.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102141", "story_v_side_new_1101102.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_27 = var_586_18 + 0.3
			local var_586_28 = math.max(var_586_19, arg_583_1.talkMaxDuration)

			if var_586_18 + 0.3 <= arg_583_1.time_ and arg_583_1.time_ < var_586_27 + var_586_28 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_27) / var_586_28

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_27 + var_586_28 and arg_583_1.time_ < var_586_27 + var_586_28 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_583_1:InitPlayNodeList()
	end,
	Play1101102142 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1101102142
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1101102143(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 and not isNil(arg_589_1.actors_["1011ui_story"]) and arg_589_1.var_.characterEffect1011ui_story == nil then
				arg_589_1.var_.characterEffect1011ui_story = arg_589_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_0 = 0.200000002980232

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_0 and not isNil(arg_589_1.actors_["1011ui_story"]) then
				if arg_589_1.var_.characterEffect1011ui_story and not isNil(arg_589_1.actors_["1011ui_story"]) then
					arg_589_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_589_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_589_1.time_ - 0) / var_592_0)
				end
			end

			if arg_589_1.time_ >= 0 + var_592_0 and arg_589_1.time_ < 0 + var_592_0 + arg_592_0 and not isNil(arg_589_1.actors_["1011ui_story"]) and arg_589_1.var_.characterEffect1011ui_story then
				arg_589_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_589_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_592_1 = 0
			local var_592_2 = 0.5

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, true)
				arg_589_1.iconController_:SetSelectedState("hero")

				arg_589_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_589_1.callingController_:SetSelectedState("normal")

				arg_589_1.keyicon_.color = Color.New(1, 1, 1)
				arg_589_1.icon_.color = Color.New(1, 1, 1)

				local var_592_3 = arg_589_1:FormatText(arg_589_1:GetWordFromCfg(1101102142).content)

				arg_589_1.text_.text = var_592_3

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_5 = 20 <= 0 and var_592_2 or var_592_2 * (utf8.len(var_592_3) / 20)

				if (20 <= 0 and var_592_2 or var_592_2 * (utf8.len(var_592_3) / 20)) > 0 and var_592_2 < var_592_5 then
					arg_589_1.talkMaxDuration = var_592_5

					if var_592_5 + var_592_1 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_5 + var_592_1
					end
				end

				arg_589_1.text_.text = var_592_3
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_6 = math.max(var_592_2, arg_589_1.talkMaxDuration)

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_6 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_1) / var_592_6

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_1 + var_592_6 and arg_589_1.time_ < var_592_1 + var_592_6 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1101102143 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1101102143
		arg_593_1.duration_ = 7.53

		local var_593_0 = {
			zh = 5.066,
			ja = 7.533
		}
		local var_593_1 = manager.audio:GetLocalizationFlag()

		if var_593_0[var_593_1] ~= nil then
			arg_593_1.duration_ = var_593_0[var_593_1]
		end

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1101102144(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.var_.moveOldPos1011ui_story = arg_593_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_596_0 = 0.001

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_0 then
				arg_593_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_593_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_593_1.time_ - 0) / var_596_0)
				arg_593_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_593_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_593_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_593_1.actors_["1011ui_story"].transform.position).z)
				arg_593_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_593_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_593_1.actors_["1011ui_story"].transform.localEulerAngles = arg_593_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_593_1.time_ >= 0 + var_596_0 and arg_593_1.time_ < 0 + var_596_0 + arg_596_0 then
				arg_593_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_593_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_593_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_593_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_593_1.actors_["1011ui_story"].transform.position).z)
				arg_593_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_593_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_593_1.actors_["1011ui_story"].transform.localEulerAngles = arg_593_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_596_1 = arg_593_1.actors_["1011ui_story"]

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 and not isNil(var_596_1) and arg_593_1.var_.characterEffect1011ui_story == nil then
				arg_593_1.var_.characterEffect1011ui_story = var_596_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_596_2 = 0.200000002980232

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_2 and not isNil(var_596_1) then
				if arg_593_1.var_.characterEffect1011ui_story and not isNil(var_596_1) then
					arg_593_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_593_1.time_ >= 0 + var_596_2 and arg_593_1.time_ < 0 + var_596_2 + arg_596_0 and not isNil(var_596_1) and arg_593_1.var_.characterEffect1011ui_story then
				arg_593_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_596_4 = 0
			local var_596_5 = 0.475

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_4 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_6 = arg_593_1:GetWordFromCfg(1101102143)
				local var_596_7 = arg_593_1:FormatText(var_596_6.content)

				arg_593_1.text_.text = var_596_7

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_9 = 19 <= 0 and var_596_5 or var_596_5 * (utf8.len(var_596_7) / 19)

				if (19 <= 0 and var_596_5 or var_596_5 * (utf8.len(var_596_7) / 19)) > 0 and var_596_5 < var_596_9 then
					arg_593_1.talkMaxDuration = var_596_9

					if var_596_9 + var_596_4 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_9 + var_596_4
					end
				end

				arg_593_1.text_.text = var_596_7
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102143", "story_v_side_new_1101102.awb") ~= 0 then
					local var_596_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102143", "story_v_side_new_1101102.awb") / 1000

					if var_596_10 + var_596_4 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_10 + var_596_4
					end

					if var_596_6.prefab_name ~= "" and arg_593_1.actors_[var_596_6.prefab_name] ~= nil then
						local var_596_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_6.prefab_name].transform, "story_v_side_new_1101102", "1101102143", "story_v_side_new_1101102.awb")

						arg_593_1:RecordAudio("1101102143", var_596_11)
						arg_593_1:RecordAudio("1101102143", var_596_11)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102143", "story_v_side_new_1101102.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102143", "story_v_side_new_1101102.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_12 = math.max(var_596_5, arg_593_1.talkMaxDuration)

			if var_596_4 <= arg_593_1.time_ and arg_593_1.time_ < var_596_4 + var_596_12 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_4) / var_596_12

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_4 + var_596_12 and arg_593_1.time_ < var_596_4 + var_596_12 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_593_1:InitPlayNodeList()
	end,
	Play1101102144 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1101102144
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1101102145(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 and not isNil(arg_597_1.actors_["1011ui_story"]) and arg_597_1.var_.characterEffect1011ui_story == nil then
				arg_597_1.var_.characterEffect1011ui_story = arg_597_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_0 = 0.200000002980232

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_0 and not isNil(arg_597_1.actors_["1011ui_story"]) then
				if arg_597_1.var_.characterEffect1011ui_story and not isNil(arg_597_1.actors_["1011ui_story"]) then
					arg_597_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_597_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_597_1.time_ - 0) / var_600_0)
				end
			end

			if arg_597_1.time_ >= 0 + var_600_0 and arg_597_1.time_ < 0 + var_600_0 + arg_600_0 and not isNil(arg_597_1.actors_["1011ui_story"]) and arg_597_1.var_.characterEffect1011ui_story then
				arg_597_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_597_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_600_1 = 0
			local var_600_2 = 0.325

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, true)
				arg_597_1.iconController_:SetSelectedState("hero")

				arg_597_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_597_1.callingController_:SetSelectedState("normal")

				arg_597_1.keyicon_.color = Color.New(1, 1, 1)
				arg_597_1.icon_.color = Color.New(1, 1, 1)

				local var_600_3 = arg_597_1:FormatText(arg_597_1:GetWordFromCfg(1101102144).content)

				arg_597_1.text_.text = var_600_3

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_5 = 13 <= 0 and var_600_2 or var_600_2 * (utf8.len(var_600_3) / 13)

				if (13 <= 0 and var_600_2 or var_600_2 * (utf8.len(var_600_3) / 13)) > 0 and var_600_2 < var_600_5 then
					arg_597_1.talkMaxDuration = var_600_5

					if var_600_5 + var_600_1 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_5 + var_600_1
					end
				end

				arg_597_1.text_.text = var_600_3
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_6 = math.max(var_600_2, arg_597_1.talkMaxDuration)

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_6 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_1) / var_600_6

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_1 + var_600_6 and arg_597_1.time_ < var_600_1 + var_600_6 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play1101102145 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1101102145
		arg_601_1.duration_ = 4.7

		local var_601_0 = {
			zh = 4.366,
			ja = 4.7
		}
		local var_601_1 = manager.audio:GetLocalizationFlag()

		if var_601_0[var_601_1] ~= nil then
			arg_601_1.duration_ = var_601_0[var_601_1]
		end

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1101102146(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.var_.moveOldPos1011ui_story = arg_601_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_604_0 = 0.001

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 then
				arg_601_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_601_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_601_1.time_ - 0) / var_604_0)
				arg_601_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_601_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1011ui_story"].transform.position).z)
				arg_601_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_601_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_601_1.actors_["1011ui_story"].transform.localEulerAngles = arg_601_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 then
				arg_601_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_601_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_601_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_601_1.actors_["1011ui_story"].transform.position).z)
				arg_601_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_601_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_601_1.actors_["1011ui_story"].transform.localEulerAngles = arg_601_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_604_1 = arg_601_1.actors_["1011ui_story"]

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 and not isNil(var_604_1) and arg_601_1.var_.characterEffect1011ui_story == nil then
				arg_601_1.var_.characterEffect1011ui_story = var_604_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_2 = 0.200000002980232

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_2 and not isNil(var_604_1) then
				if arg_601_1.var_.characterEffect1011ui_story and not isNil(var_604_1) then
					arg_601_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_601_1.time_ >= 0 + var_604_2 and arg_601_1.time_ < 0 + var_604_2 + arg_604_0 and not isNil(var_604_1) and arg_601_1.var_.characterEffect1011ui_story then
				arg_601_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_2")
			end

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_604_4 = 0
			local var_604_5 = 0.5

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_4 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_6 = arg_601_1:GetWordFromCfg(1101102145)
				local var_604_7 = arg_601_1:FormatText(var_604_6.content)

				arg_601_1.text_.text = var_604_7

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_9 = 20 <= 0 and var_604_5 or var_604_5 * (utf8.len(var_604_7) / 20)

				if (20 <= 0 and var_604_5 or var_604_5 * (utf8.len(var_604_7) / 20)) > 0 and var_604_5 < var_604_9 then
					arg_601_1.talkMaxDuration = var_604_9

					if var_604_9 + var_604_4 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_9 + var_604_4
					end
				end

				arg_601_1.text_.text = var_604_7
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102145", "story_v_side_new_1101102.awb") ~= 0 then
					local var_604_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102145", "story_v_side_new_1101102.awb") / 1000

					if var_604_10 + var_604_4 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_10 + var_604_4
					end

					if var_604_6.prefab_name ~= "" and arg_601_1.actors_[var_604_6.prefab_name] ~= nil then
						local var_604_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_6.prefab_name].transform, "story_v_side_new_1101102", "1101102145", "story_v_side_new_1101102.awb")

						arg_601_1:RecordAudio("1101102145", var_604_11)
						arg_601_1:RecordAudio("1101102145", var_604_11)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102145", "story_v_side_new_1101102.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102145", "story_v_side_new_1101102.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_12 = math.max(var_604_5, arg_601_1.talkMaxDuration)

			if var_604_4 <= arg_601_1.time_ and arg_601_1.time_ < var_604_4 + var_604_12 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_4) / var_604_12

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_4 + var_604_12 and arg_601_1.time_ < var_604_4 + var_604_12 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_601_1:InitPlayNodeList()
	end,
	Play1101102146 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 1101102146
		arg_605_1.duration_ = 8.6

		local var_605_0 = {
			zh = 8.6,
			ja = 8.466
		}
		local var_605_1 = manager.audio:GetLocalizationFlag()

		if var_605_0[var_605_1] ~= nil then
			arg_605_1.duration_ = var_605_0[var_605_1]
		end

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play1101102147(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_608_0 = 0
			local var_608_1 = 1

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_2 = arg_605_1:GetWordFromCfg(1101102146)
				local var_608_3 = arg_605_1:FormatText(var_608_2.content)

				arg_605_1.text_.text = var_608_3

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_5 = 40 <= 0 and var_608_1 or var_608_1 * (utf8.len(var_608_3) / 40)

				if (40 <= 0 and var_608_1 or var_608_1 * (utf8.len(var_608_3) / 40)) > 0 and var_608_1 < var_608_5 then
					arg_605_1.talkMaxDuration = var_608_5

					if var_608_5 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_5 + var_608_0
					end
				end

				arg_605_1.text_.text = var_608_3
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102146", "story_v_side_new_1101102.awb") ~= 0 then
					local var_608_6 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102146", "story_v_side_new_1101102.awb") / 1000

					if var_608_6 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_6 + var_608_0
					end

					if var_608_2.prefab_name ~= "" and arg_605_1.actors_[var_608_2.prefab_name] ~= nil then
						local var_608_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_2.prefab_name].transform, "story_v_side_new_1101102", "1101102146", "story_v_side_new_1101102.awb")

						arg_605_1:RecordAudio("1101102146", var_608_7)
						arg_605_1:RecordAudio("1101102146", var_608_7)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102146", "story_v_side_new_1101102.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102146", "story_v_side_new_1101102.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_8 = math.max(var_608_1, arg_605_1.talkMaxDuration)

			if var_608_0 <= arg_605_1.time_ and arg_605_1.time_ < var_608_0 + var_608_8 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_0) / var_608_8

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_0 + var_608_8 and arg_605_1.time_ < var_608_0 + var_608_8 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play1101102147 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1101102147
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1101102148(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 and not isNil(arg_609_1.actors_["1011ui_story"]) and arg_609_1.var_.characterEffect1011ui_story == nil then
				arg_609_1.var_.characterEffect1011ui_story = arg_609_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_612_0 = 0.200000002980232

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_0 and not isNil(arg_609_1.actors_["1011ui_story"]) then
				if arg_609_1.var_.characterEffect1011ui_story and not isNil(arg_609_1.actors_["1011ui_story"]) then
					arg_609_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_609_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_609_1.time_ - 0) / var_612_0)
				end
			end

			if arg_609_1.time_ >= 0 + var_612_0 and arg_609_1.time_ < 0 + var_612_0 + arg_612_0 and not isNil(arg_609_1.actors_["1011ui_story"]) and arg_609_1.var_.characterEffect1011ui_story then
				arg_609_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_609_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_612_1 = 0
			local var_612_2 = 0.25

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_1 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				arg_609_1.leftNameTxt_.text = arg_609_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, true)
				arg_609_1.iconController_:SetSelectedState("hero")

				arg_609_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_609_1.callingController_:SetSelectedState("normal")

				arg_609_1.keyicon_.color = Color.New(1, 1, 1)
				arg_609_1.icon_.color = Color.New(1, 1, 1)

				local var_612_3 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(1101102147).content)

				arg_609_1.text_.text = var_612_3

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_5 = 10 <= 0 and var_612_2 or var_612_2 * (utf8.len(var_612_3) / 10)

				if (10 <= 0 and var_612_2 or var_612_2 * (utf8.len(var_612_3) / 10)) > 0 and var_612_2 < var_612_5 then
					arg_609_1.talkMaxDuration = var_612_5

					if var_612_5 + var_612_1 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_5 + var_612_1
					end
				end

				arg_609_1.text_.text = var_612_3
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_6 = math.max(var_612_2, arg_609_1.talkMaxDuration)

			if var_612_1 <= arg_609_1.time_ and arg_609_1.time_ < var_612_1 + var_612_6 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_1) / var_612_6

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_1 + var_612_6 and arg_609_1.time_ < var_612_1 + var_612_6 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play1101102148 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1101102148
		arg_613_1.duration_ = 17.03

		local var_613_0 = {
			zh = 7.3,
			ja = 17.033
		}
		local var_613_1 = manager.audio:GetLocalizationFlag()

		if var_613_0[var_613_1] ~= nil then
			arg_613_1.duration_ = var_613_0[var_613_1]
		end

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1101102149(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1.var_.moveOldPos1011ui_story = arg_613_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_616_0 = 0.001

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_0 then
				arg_613_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_613_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_613_1.time_ - 0) / var_616_0)
				arg_613_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_613_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_613_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_613_1.actors_["1011ui_story"].transform.position).z)
				arg_613_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_613_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_613_1.actors_["1011ui_story"].transform.localEulerAngles = arg_613_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_613_1.time_ >= 0 + var_616_0 and arg_613_1.time_ < 0 + var_616_0 + arg_616_0 then
				arg_613_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_613_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_613_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_613_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_613_1.actors_["1011ui_story"].transform.position).z)
				arg_613_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_613_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_613_1.actors_["1011ui_story"].transform.localEulerAngles = arg_613_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_616_1 = arg_613_1.actors_["1011ui_story"]

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 and not isNil(var_616_1) and arg_613_1.var_.characterEffect1011ui_story == nil then
				arg_613_1.var_.characterEffect1011ui_story = var_616_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_2 = 0.200000002980232

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_2 and not isNil(var_616_1) then
				if arg_613_1.var_.characterEffect1011ui_story and not isNil(var_616_1) then
					arg_613_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_613_1.time_ >= 0 + var_616_2 and arg_613_1.time_ < 0 + var_616_2 + arg_616_0 and not isNil(var_616_1) and arg_613_1.var_.characterEffect1011ui_story then
				arg_613_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_616_4 = 0
			local var_616_5 = 0.85

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= var_616_4 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_6 = arg_613_1:GetWordFromCfg(1101102148)
				local var_616_7 = arg_613_1:FormatText(var_616_6.content)

				arg_613_1.text_.text = var_616_7

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_9 = 34 <= 0 and var_616_5 or var_616_5 * (utf8.len(var_616_7) / 34)

				if (34 <= 0 and var_616_5 or var_616_5 * (utf8.len(var_616_7) / 34)) > 0 and var_616_5 < var_616_9 then
					arg_613_1.talkMaxDuration = var_616_9

					if var_616_9 + var_616_4 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_9 + var_616_4
					end
				end

				arg_613_1.text_.text = var_616_7
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102148", "story_v_side_new_1101102.awb") ~= 0 then
					local var_616_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102148", "story_v_side_new_1101102.awb") / 1000

					if var_616_10 + var_616_4 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_10 + var_616_4
					end

					if var_616_6.prefab_name ~= "" and arg_613_1.actors_[var_616_6.prefab_name] ~= nil then
						local var_616_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_6.prefab_name].transform, "story_v_side_new_1101102", "1101102148", "story_v_side_new_1101102.awb")

						arg_613_1:RecordAudio("1101102148", var_616_11)
						arg_613_1:RecordAudio("1101102148", var_616_11)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102148", "story_v_side_new_1101102.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102148", "story_v_side_new_1101102.awb")
				end

				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_12 = math.max(var_616_5, arg_613_1.talkMaxDuration)

			if var_616_4 <= arg_613_1.time_ and arg_613_1.time_ < var_616_4 + var_616_12 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_4) / var_616_12

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_4 + var_616_12 and arg_613_1.time_ < var_616_4 + var_616_12 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_613_1:InitPlayNodeList()
	end,
	Play1101102149 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1101102149
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1101102150(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 and not isNil(arg_617_1.actors_["1011ui_story"]) and arg_617_1.var_.characterEffect1011ui_story == nil then
				arg_617_1.var_.characterEffect1011ui_story = arg_617_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_0 = 0.200000002980232

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_0 and not isNil(arg_617_1.actors_["1011ui_story"]) then
				if arg_617_1.var_.characterEffect1011ui_story and not isNil(arg_617_1.actors_["1011ui_story"]) then
					arg_617_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_617_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_617_1.time_ - 0) / var_620_0)
				end
			end

			if arg_617_1.time_ >= 0 + var_620_0 and arg_617_1.time_ < 0 + var_620_0 + arg_620_0 and not isNil(arg_617_1.actors_["1011ui_story"]) and arg_617_1.var_.characterEffect1011ui_story then
				arg_617_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_617_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_620_1 = 0
			local var_620_2 = 0.45

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= var_620_1 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, true)
				arg_617_1.iconController_:SetSelectedState("hero")

				arg_617_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_617_1.callingController_:SetSelectedState("normal")

				arg_617_1.keyicon_.color = Color.New(1, 1, 1)
				arg_617_1.icon_.color = Color.New(1, 1, 1)

				local var_620_3 = arg_617_1:FormatText(arg_617_1:GetWordFromCfg(1101102149).content)

				arg_617_1.text_.text = var_620_3

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_5 = 18 <= 0 and var_620_2 or var_620_2 * (utf8.len(var_620_3) / 18)

				if (18 <= 0 and var_620_2 or var_620_2 * (utf8.len(var_620_3) / 18)) > 0 and var_620_2 < var_620_5 then
					arg_617_1.talkMaxDuration = var_620_5

					if var_620_5 + var_620_1 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_5 + var_620_1
					end
				end

				arg_617_1.text_.text = var_620_3
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_6 = math.max(var_620_2, arg_617_1.talkMaxDuration)

			if var_620_1 <= arg_617_1.time_ and arg_617_1.time_ < var_620_1 + var_620_6 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_1) / var_620_6

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_1 + var_620_6 and arg_617_1.time_ < var_620_1 + var_620_6 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play1101102150 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1101102150
		arg_621_1.duration_ = 5

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play1101102151(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0.775

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, true)
				arg_621_1.iconController_:SetSelectedState("hero")

				arg_621_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_621_1.callingController_:SetSelectedState("normal")

				arg_621_1.keyicon_.color = Color.New(1, 1, 1)
				arg_621_1.icon_.color = Color.New(1, 1, 1)

				local var_624_1 = arg_621_1:FormatText(arg_621_1:GetWordFromCfg(1101102150).content)

				arg_621_1.text_.text = var_624_1

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_3 = 31 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_1) / 31)

				if (31 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_1) / 31)) > 0 and var_624_0 < var_624_3 then
					arg_621_1.talkMaxDuration = var_624_3

					if var_624_3 + 0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_3 + 0
					end
				end

				arg_621_1.text_.text = var_624_1
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)
				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_4 = math.max(var_624_0, arg_621_1.talkMaxDuration)

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_4 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - 0) / var_624_4

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= 0 + var_624_4 and arg_621_1.time_ < 0 + var_624_4 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play1101102151 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1101102151
		arg_625_1.duration_ = 4.37

		local var_625_0 = {
			zh = 3,
			ja = 4.366
		}
		local var_625_1 = manager.audio:GetLocalizationFlag()

		if var_625_0[var_625_1] ~= nil then
			arg_625_1.duration_ = var_625_0[var_625_1]
		end

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1101102152(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.var_.moveOldPos1011ui_story = arg_625_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_628_0 = 0.001

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_0 then
				arg_625_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_625_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_625_1.time_ - 0) / var_628_0)
				arg_625_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_625_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_625_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_625_1.actors_["1011ui_story"].transform.position).z)
				arg_625_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_625_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_625_1.actors_["1011ui_story"].transform.localEulerAngles = arg_625_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_625_1.time_ >= 0 + var_628_0 and arg_625_1.time_ < 0 + var_628_0 + arg_628_0 then
				arg_625_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_625_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_625_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_625_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_625_1.actors_["1011ui_story"].transform.position).z)
				arg_625_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_625_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_625_1.actors_["1011ui_story"].transform.localEulerAngles = arg_625_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_628_1 = arg_625_1.actors_["1011ui_story"]

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 and not isNil(var_628_1) and arg_625_1.var_.characterEffect1011ui_story == nil then
				arg_625_1.var_.characterEffect1011ui_story = var_628_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_2 = 0.200000002980232

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_2 and not isNil(var_628_1) then
				if arg_625_1.var_.characterEffect1011ui_story and not isNil(var_628_1) then
					arg_625_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_625_1.time_ >= 0 + var_628_2 and arg_625_1.time_ < 0 + var_628_2 + arg_628_0 and not isNil(var_628_1) and arg_625_1.var_.characterEffect1011ui_story then
				arg_625_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_2")
			end

			local var_628_4 = 0
			local var_628_5 = 0.25

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= var_628_4 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_6 = arg_625_1:GetWordFromCfg(1101102151)
				local var_628_7 = arg_625_1:FormatText(var_628_6.content)

				arg_625_1.text_.text = var_628_7

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_9 = 10 <= 0 and var_628_5 or var_628_5 * (utf8.len(var_628_7) / 10)

				if (10 <= 0 and var_628_5 or var_628_5 * (utf8.len(var_628_7) / 10)) > 0 and var_628_5 < var_628_9 then
					arg_625_1.talkMaxDuration = var_628_9

					if var_628_9 + var_628_4 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_9 + var_628_4
					end
				end

				arg_625_1.text_.text = var_628_7
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102151", "story_v_side_new_1101102.awb") ~= 0 then
					local var_628_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102151", "story_v_side_new_1101102.awb") / 1000

					if var_628_10 + var_628_4 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_10 + var_628_4
					end

					if var_628_6.prefab_name ~= "" and arg_625_1.actors_[var_628_6.prefab_name] ~= nil then
						local var_628_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_625_1.actors_[var_628_6.prefab_name].transform, "story_v_side_new_1101102", "1101102151", "story_v_side_new_1101102.awb")

						arg_625_1:RecordAudio("1101102151", var_628_11)
						arg_625_1:RecordAudio("1101102151", var_628_11)
					else
						arg_625_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102151", "story_v_side_new_1101102.awb")
					end

					arg_625_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102151", "story_v_side_new_1101102.awb")
				end

				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_12 = math.max(var_628_5, arg_625_1.talkMaxDuration)

			if var_628_4 <= arg_625_1.time_ and arg_625_1.time_ < var_628_4 + var_628_12 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_4) / var_628_12

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_4 + var_628_12 and arg_625_1.time_ < var_628_4 + var_628_12 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_625_1:InitPlayNodeList()
	end,
	Play1101102152 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1101102152
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1101102153(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			if 0 < arg_629_1.time_ and arg_629_1.time_ <= 0 + arg_632_0 and not isNil(arg_629_1.actors_["1011ui_story"]) and arg_629_1.var_.characterEffect1011ui_story == nil then
				arg_629_1.var_.characterEffect1011ui_story = arg_629_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_632_0 = 0.200000002980232

			if 0 <= arg_629_1.time_ and arg_629_1.time_ < 0 + var_632_0 and not isNil(arg_629_1.actors_["1011ui_story"]) then
				if arg_629_1.var_.characterEffect1011ui_story and not isNil(arg_629_1.actors_["1011ui_story"]) then
					arg_629_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_629_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_629_1.time_ - 0) / var_632_0)
				end
			end

			if arg_629_1.time_ >= 0 + var_632_0 and arg_629_1.time_ < 0 + var_632_0 + arg_632_0 and not isNil(arg_629_1.actors_["1011ui_story"]) and arg_629_1.var_.characterEffect1011ui_story then
				arg_629_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_629_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_632_1 = 0
			local var_632_2 = 0.75

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_1 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, false)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_3 = arg_629_1:FormatText(arg_629_1:GetWordFromCfg(1101102152).content)

				arg_629_1.text_.text = var_632_3

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_5 = 30 <= 0 and var_632_2 or var_632_2 * (utf8.len(var_632_3) / 30)

				if (30 <= 0 and var_632_2 or var_632_2 * (utf8.len(var_632_3) / 30)) > 0 and var_632_2 < var_632_5 then
					arg_629_1.talkMaxDuration = var_632_5

					if var_632_5 + var_632_1 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_5 + var_632_1
					end
				end

				arg_629_1.text_.text = var_632_3
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_6 = math.max(var_632_2, arg_629_1.talkMaxDuration)

			if var_632_1 <= arg_629_1.time_ and arg_629_1.time_ < var_632_1 + var_632_6 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_1) / var_632_6

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_1 + var_632_6 and arg_629_1.time_ < var_632_1 + var_632_6 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play1101102153 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 1101102153
		arg_633_1.duration_ = 11.97

		local var_633_0 = {
			zh = 9.6,
			ja = 11.966
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play1101102154(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1.var_.moveOldPos1011ui_story = arg_633_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_636_0 = 0.001

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_0 then
				arg_633_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_633_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_633_1.time_ - 0) / var_636_0)
				arg_633_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_633_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["1011ui_story"].transform.position).z)
				arg_633_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_633_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_633_1.actors_["1011ui_story"].transform.localEulerAngles = arg_633_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_633_1.time_ >= 0 + var_636_0 and arg_633_1.time_ < 0 + var_636_0 + arg_636_0 then
				arg_633_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_633_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_633_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_633_1.actors_["1011ui_story"].transform.position).z)
				arg_633_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_633_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_633_1.actors_["1011ui_story"].transform.localEulerAngles = arg_633_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_636_1 = arg_633_1.actors_["1011ui_story"]

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 and not isNil(var_636_1) and arg_633_1.var_.characterEffect1011ui_story == nil then
				arg_633_1.var_.characterEffect1011ui_story = var_636_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_2 = 0.200000002980232

			if 0 <= arg_633_1.time_ and arg_633_1.time_ < 0 + var_636_2 and not isNil(var_636_1) then
				if arg_633_1.var_.characterEffect1011ui_story and not isNil(var_636_1) then
					arg_633_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= 0 + var_636_2 and arg_633_1.time_ < 0 + var_636_2 + arg_636_0 and not isNil(var_636_1) and arg_633_1.var_.characterEffect1011ui_story then
				arg_633_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= 0 + arg_636_0 then
				arg_633_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_636_4 = 0
			local var_636_5 = 1.025

			if 0 < arg_633_1.time_ and arg_633_1.time_ <= var_636_4 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				arg_633_1.leftNameTxt_.text = arg_633_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_6 = arg_633_1:GetWordFromCfg(1101102153)
				local var_636_7 = arg_633_1:FormatText(var_636_6.content)

				arg_633_1.text_.text = var_636_7

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_9 = 41 <= 0 and var_636_5 or var_636_5 * (utf8.len(var_636_7) / 41)

				if (41 <= 0 and var_636_5 or var_636_5 * (utf8.len(var_636_7) / 41)) > 0 and var_636_5 < var_636_9 then
					arg_633_1.talkMaxDuration = var_636_9

					if var_636_9 + var_636_4 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_9 + var_636_4
					end
				end

				arg_633_1.text_.text = var_636_7
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102153", "story_v_side_new_1101102.awb") ~= 0 then
					local var_636_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102153", "story_v_side_new_1101102.awb") / 1000

					if var_636_10 + var_636_4 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_10 + var_636_4
					end

					if var_636_6.prefab_name ~= "" and arg_633_1.actors_[var_636_6.prefab_name] ~= nil then
						local var_636_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_6.prefab_name].transform, "story_v_side_new_1101102", "1101102153", "story_v_side_new_1101102.awb")

						arg_633_1:RecordAudio("1101102153", var_636_11)
						arg_633_1:RecordAudio("1101102153", var_636_11)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102153", "story_v_side_new_1101102.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102153", "story_v_side_new_1101102.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_12 = math.max(var_636_5, arg_633_1.talkMaxDuration)

			if var_636_4 <= arg_633_1.time_ and arg_633_1.time_ < var_636_4 + var_636_12 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_4) / var_636_12

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_4 + var_636_12 and arg_633_1.time_ < var_636_4 + var_636_12 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_633_1:InitPlayNodeList()
	end,
	Play1101102154 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1101102154
		arg_637_1.duration_ = 5

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1101102155(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			if 0 < arg_637_1.time_ and arg_637_1.time_ <= 0 + arg_640_0 and not isNil(arg_637_1.actors_["1011ui_story"]) and arg_637_1.var_.characterEffect1011ui_story == nil then
				arg_637_1.var_.characterEffect1011ui_story = arg_637_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_0 = 0.200000002980232

			if 0 <= arg_637_1.time_ and arg_637_1.time_ < 0 + var_640_0 and not isNil(arg_637_1.actors_["1011ui_story"]) then
				if arg_637_1.var_.characterEffect1011ui_story and not isNil(arg_637_1.actors_["1011ui_story"]) then
					arg_637_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_637_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_637_1.time_ - 0) / var_640_0)
				end
			end

			if arg_637_1.time_ >= 0 + var_640_0 and arg_637_1.time_ < 0 + var_640_0 + arg_640_0 and not isNil(arg_637_1.actors_["1011ui_story"]) and arg_637_1.var_.characterEffect1011ui_story then
				arg_637_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_637_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_640_1 = 0
			local var_640_2 = 0.625

			if 0 < arg_637_1.time_ and arg_637_1.time_ <= var_640_1 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				arg_637_1.leftNameTxt_.text = arg_637_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, true)
				arg_637_1.iconController_:SetSelectedState("hero")

				arg_637_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_637_1.callingController_:SetSelectedState("normal")

				arg_637_1.keyicon_.color = Color.New(1, 1, 1)
				arg_637_1.icon_.color = Color.New(1, 1, 1)

				local var_640_3 = arg_637_1:FormatText(arg_637_1:GetWordFromCfg(1101102154).content)

				arg_637_1.text_.text = var_640_3

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_5 = 25 <= 0 and var_640_2 or var_640_2 * (utf8.len(var_640_3) / 25)

				if (25 <= 0 and var_640_2 or var_640_2 * (utf8.len(var_640_3) / 25)) > 0 and var_640_2 < var_640_5 then
					arg_637_1.talkMaxDuration = var_640_5

					if var_640_5 + var_640_1 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_5 + var_640_1
					end
				end

				arg_637_1.text_.text = var_640_3
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)
				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_6 = math.max(var_640_2, arg_637_1.talkMaxDuration)

			if var_640_1 <= arg_637_1.time_ and arg_637_1.time_ < var_640_1 + var_640_6 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_1) / var_640_6

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_1 + var_640_6 and arg_637_1.time_ < var_640_1 + var_640_6 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play1101102155 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 1101102155
		arg_641_1.duration_ = 9.47

		local var_641_0 = {
			zh = 4.333,
			ja = 9.466
		}
		local var_641_1 = manager.audio:GetLocalizationFlag()

		if var_641_0[var_641_1] ~= nil then
			arg_641_1.duration_ = var_641_0[var_641_1]
		end

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play1101102156(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1.var_.moveOldPos1011ui_story = arg_641_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_644_0 = 0.001

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_0 then
				arg_641_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_641_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_641_1.time_ - 0) / var_644_0)
				arg_641_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_641_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["1011ui_story"].transform.position).z)
				arg_641_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_641_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_641_1.actors_["1011ui_story"].transform.localEulerAngles = arg_641_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_641_1.time_ >= 0 + var_644_0 and arg_641_1.time_ < 0 + var_644_0 + arg_644_0 then
				arg_641_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_641_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_641_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_641_1.actors_["1011ui_story"].transform.position).z)
				arg_641_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_641_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_641_1.actors_["1011ui_story"].transform.localEulerAngles = arg_641_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_644_1 = arg_641_1.actors_["1011ui_story"]

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 and not isNil(var_644_1) and arg_641_1.var_.characterEffect1011ui_story == nil then
				arg_641_1.var_.characterEffect1011ui_story = var_644_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_644_2 = 0.200000002980232

			if 0 <= arg_641_1.time_ and arg_641_1.time_ < 0 + var_644_2 and not isNil(var_644_1) then
				if arg_641_1.var_.characterEffect1011ui_story and not isNil(var_644_1) then
					arg_641_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_641_1.time_ >= 0 + var_644_2 and arg_641_1.time_ < 0 + var_644_2 + arg_644_0 and not isNil(var_644_1) and arg_641_1.var_.characterEffect1011ui_story then
				arg_641_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= 0 + arg_644_0 then
				arg_641_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_644_4 = 0
			local var_644_5 = 0.425

			if 0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_4 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				arg_641_1.leftNameTxt_.text = arg_641_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, false)
				arg_641_1.callingController_:SetSelectedState("normal")

				local var_644_6 = arg_641_1:GetWordFromCfg(1101102155)
				local var_644_7 = arg_641_1:FormatText(var_644_6.content)

				arg_641_1.text_.text = var_644_7

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_9 = 17 <= 0 and var_644_5 or var_644_5 * (utf8.len(var_644_7) / 17)

				if (17 <= 0 and var_644_5 or var_644_5 * (utf8.len(var_644_7) / 17)) > 0 and var_644_5 < var_644_9 then
					arg_641_1.talkMaxDuration = var_644_9

					if var_644_9 + var_644_4 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_9 + var_644_4
					end
				end

				arg_641_1.text_.text = var_644_7
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102155", "story_v_side_new_1101102.awb") ~= 0 then
					local var_644_10 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102155", "story_v_side_new_1101102.awb") / 1000

					if var_644_10 + var_644_4 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_10 + var_644_4
					end

					if var_644_6.prefab_name ~= "" and arg_641_1.actors_[var_644_6.prefab_name] ~= nil then
						local var_644_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_641_1.actors_[var_644_6.prefab_name].transform, "story_v_side_new_1101102", "1101102155", "story_v_side_new_1101102.awb")

						arg_641_1:RecordAudio("1101102155", var_644_11)
						arg_641_1:RecordAudio("1101102155", var_644_11)
					else
						arg_641_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102155", "story_v_side_new_1101102.awb")
					end

					arg_641_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102155", "story_v_side_new_1101102.awb")
				end

				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_12 = math.max(var_644_5, arg_641_1.talkMaxDuration)

			if var_644_4 <= arg_641_1.time_ and arg_641_1.time_ < var_644_4 + var_644_12 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_4) / var_644_12

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_4 + var_644_12 and arg_641_1.time_ < var_644_4 + var_644_12 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_641_1:InitPlayNodeList()
	end,
	Play1101102156 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1101102156
		arg_645_1.duration_ = 10.7

		local var_645_0 = {
			zh = 4.4,
			ja = 10.7
		}
		local var_645_1 = manager.audio:GetLocalizationFlag()

		if var_645_0[var_645_1] ~= nil then
			arg_645_1.duration_ = var_645_0[var_645_1]
		end

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
			arg_645_1.auto_ = false
		end

		function arg_645_1.playNext_(arg_647_0)
			arg_645_1.onStoryFinished_()
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_648_0 = 0
			local var_648_1 = 0.525

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				arg_645_1.leftNameTxt_.text = arg_645_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_2 = arg_645_1:GetWordFromCfg(1101102156)
				local var_648_3 = arg_645_1:FormatText(var_648_2.content)

				arg_645_1.text_.text = var_648_3

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_5 = 21 <= 0 and var_648_1 or var_648_1 * (utf8.len(var_648_3) / 21)

				if (21 <= 0 and var_648_1 or var_648_1 * (utf8.len(var_648_3) / 21)) > 0 and var_648_1 < var_648_5 then
					arg_645_1.talkMaxDuration = var_648_5

					if var_648_5 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_5 + var_648_0
					end
				end

				arg_645_1.text_.text = var_648_3
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102156", "story_v_side_new_1101102.awb") ~= 0 then
					local var_648_6 = manager.audio:GetVoiceLength("story_v_side_new_1101102", "1101102156", "story_v_side_new_1101102.awb") / 1000

					if var_648_6 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_6 + var_648_0
					end

					if var_648_2.prefab_name ~= "" and arg_645_1.actors_[var_648_2.prefab_name] ~= nil then
						local var_648_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_645_1.actors_[var_648_2.prefab_name].transform, "story_v_side_new_1101102", "1101102156", "story_v_side_new_1101102.awb")

						arg_645_1:RecordAudio("1101102156", var_648_7)
						arg_645_1:RecordAudio("1101102156", var_648_7)
					else
						arg_645_1:AudioAction("play", "voice", "story_v_side_new_1101102", "1101102156", "story_v_side_new_1101102.awb")
					end

					arg_645_1:RecordHistoryTalkVoice("story_v_side_new_1101102", "1101102156", "story_v_side_new_1101102.awb")
				end

				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_8 = math.max(var_648_1, arg_645_1.talkMaxDuration)

			if var_648_0 <= arg_645_1.time_ and arg_645_1.time_ < var_648_0 + var_648_8 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_0) / var_648_8

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_0 + var_648_8 and arg_645_1.time_ < var_648_0 + var_648_8 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST01",
		"TextureConfig/Background/ST18",
		"TextureConfig/Background/ST19"
	},
	voices = {
		"story_v_side_new_1101102.awb"
	}
}
