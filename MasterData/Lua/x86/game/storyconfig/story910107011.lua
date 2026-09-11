return {
	Play910114001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910114001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910114002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST37 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37")
				var_4_0.name = "ST37"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST37 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST37

				arg_1_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST37" then
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
			local var_4_9 = 0.4

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_11 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(910114001).content)

				arg_1_1.text_.text = var_4_11

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_13 = 16 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 16)

				if (16 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 16)) > 0 and var_4_9 < var_4_13 then
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
	Play910114002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910114002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910114003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0.375

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(910114002).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 15 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 15)

				if (15 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 15)) > 0 and var_10_0 < var_10_3 then
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
	Play910114003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910114003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910114004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0.775

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, true)
				arg_11_1.iconController_:SetSelectedState("hero")

				arg_11_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_11_1.callingController_:SetSelectedState("normal")

				arg_11_1.keyicon_.color = Color.New(1, 1, 1)
				arg_11_1.icon_.color = Color.New(1, 1, 1)

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(910114003).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 31 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 31)

				if (31 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 31)) > 0 and var_14_0 < var_14_3 then
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
	Play910114004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910114004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910114005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.4

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_1 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(910114004).content)

				arg_15_1.text_.text = var_18_1

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_3 = 16 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 16)

				if (16 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 16)) > 0 and var_18_0 < var_18_3 then
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
	Play910114005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910114005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910114006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.9

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(910114005).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 36 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 36)

				if (36 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 36)) > 0 and var_22_0 < var_22_3 then
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
	Play910114006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910114006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910114007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.3

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(910114006).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 12 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 12)

				if (12 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 12)) > 0 and var_26_0 < var_26_3 then
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
	Play910114007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910114007
		arg_27_1.duration_ = 9

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910114008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if arg_27_1.bgs_.ST29 == nil then
				local var_30_0 = Object.Instantiate(arg_27_1.paintGo_)

				var_30_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST29")
				var_30_0.name = "ST29"
				var_30_0.transform.parent = arg_27_1.stage_.transform
				var_30_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.bgs_.ST29 = var_30_0
			end

			if 2 < arg_27_1.time_ and arg_27_1.time_ <= 2 + arg_30_0 then
				local var_30_1 = arg_27_1.bgs_.ST29

				arg_27_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_30_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_30_2 = var_30_1:GetComponent("SpriteRenderer")

				if var_30_2 and var_30_2.sprite then
					local var_30_3 = 2 * (var_30_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_30_1.transform.localScale = Vector3.New(var_30_3 / var_30_2.sprite.bounds.size.y < var_30_3 * manager.ui.mainCameraCom_.aspect / var_30_2.sprite.bounds.size.x and var_30_3 * manager.ui.mainCameraCom_.aspect / var_30_2.sprite.bounds.size.x or var_30_3 / var_30_2.sprite.bounds.size.y, var_30_3 / var_30_2.sprite.bounds.size.y < var_30_3 * manager.ui.mainCameraCom_.aspect / var_30_2.sprite.bounds.size.x and var_30_3 * manager.ui.mainCameraCom_.aspect / var_30_2.sprite.bounds.size.x or var_30_3 / var_30_2.sprite.bounds.size.y, 0)
				end

				for iter_30_0, iter_30_1 in pairs(arg_27_1.bgs_) do
					if iter_30_0 ~= "ST29" then
						iter_30_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_30_4 = 0

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1.mask_.enabled = true
				arg_27_1.mask_.raycastTarget = true

				arg_27_1:SetGaussion(false)
			end

			local var_30_5 = 2

			if var_30_4 <= arg_27_1.time_ and arg_27_1.time_ < var_30_4 + var_30_5 then
				local var_30_6 = Color.New(0, 0, 0)

				var_30_6.a = Mathf.Lerp(0, 1, (arg_27_1.time_ - var_30_4) / var_30_5)
				arg_27_1.mask_.color = var_30_6
			end

			if arg_27_1.time_ >= var_30_4 + var_30_5 and arg_27_1.time_ < var_30_4 + var_30_5 + arg_30_0 then
				local var_30_7 = Color.New(0, 0, 0)

				var_30_7.a = 1
				arg_27_1.mask_.color = var_30_7
			end

			local var_30_8 = 2

			if 2 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.mask_.enabled = true
				arg_27_1.mask_.raycastTarget = true

				arg_27_1:SetGaussion(false)
			end

			local var_30_9 = 2

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_9 then
				local var_30_10 = Color.New(0, 0, 0)

				var_30_10.a = Mathf.Lerp(1, 0, (arg_27_1.time_ - var_30_8) / var_30_9)
				arg_27_1.mask_.color = var_30_10
			end

			if arg_27_1.time_ >= var_30_8 + var_30_9 and arg_27_1.time_ < var_30_8 + var_30_9 + arg_30_0 then
				local var_30_11 = Color.New(0, 0, 0)

				arg_27_1.mask_.enabled = false
				var_30_11.a = 0
				arg_27_1.mask_.color = var_30_11
			end

			if arg_27_1.frameCnt_ <= 1 then
				arg_27_1.dialog_:SetActive(false)
			end

			local var_30_12 = 4
			local var_30_13 = 1.075

			if 4 < arg_27_1.time_ and arg_27_1.time_ <= var_30_12 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				arg_27_1.dialog_:SetActive(true)

				arg_27_1.dialogCg_.alpha = 0

				local var_30_14 = LeanTween.value(arg_27_1.dialog_, 0, 1, 0.3)

				var_30_14:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_27_1.dialogCg_.alpha = arg_31_0
				end))
				var_30_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_27_1.dialog_)
					var_30_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_27_1.duration_ = arg_27_1.duration_ + 0.3

				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_15 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(910114007).content)

				arg_27_1.text_.text = var_30_15

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_17 = 43 <= 0 and var_30_13 or var_30_13 * (utf8.len(var_30_15) / 43)

				if (43 <= 0 and var_30_13 or var_30_13 * (utf8.len(var_30_15) / 43)) > 0 and var_30_13 < var_30_17 then
					arg_27_1.talkMaxDuration = var_30_17
					var_30_12 = var_30_12 + 0.3

					if var_30_17 + var_30_12 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_17 + var_30_12
					end
				end

				arg_27_1.text_.text = var_30_15
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_18 = var_30_12 + 0.3
			local var_30_19 = math.max(var_30_13, arg_27_1.talkMaxDuration)

			if var_30_12 + 0.3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_18 + var_30_19 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_18) / var_30_19

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_18 + var_30_19 and arg_27_1.time_ < var_30_18 + var_30_19 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play910114008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 910114008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play910114009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["1074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1074ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "1074ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1074ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["1074ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["1074ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["1074ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["1074ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1074ui_story = var_36_3.localPosition
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_33_1.time_ - 0) / var_36_4)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			local var_36_5 = arg_33_1.actors_["1074ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1074ui_story == nil then
				arg_33_1.var_.characterEffect1074ui_story = var_36_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_6 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.characterEffect1074ui_story and not isNil(var_36_5) then
					arg_33_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.characterEffect1074ui_story then
				arg_33_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_8 = "1072ui_story"

			if arg_33_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_36_9 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_33_1.stage_.transform)

				var_36_9.name = var_36_8
				var_36_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_[var_36_8] = var_36_9

				local var_36_10 = var_36_9:GetComponentInChildren(typeof(CharacterEffect))

				var_36_10.enabled = true

				local var_36_11 = GameObjectTools.GetOrAddComponent(var_36_9, typeof(DynamicBoneHelper))

				if var_36_11 then
					var_36_11:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_10.transform, false)

				arg_33_1.var_[var_36_8 .. "Animator"] = var_36_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_[var_36_8 .. "Animator"].applyRootMotion = true
				arg_33_1.var_[var_36_8 .. "LipSync"] = var_36_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_12 = arg_33_1.actors_["1072ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1072ui_story = var_36_12.localPosition
			end

			local var_36_13 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_13 then
				var_36_12.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_33_1.time_ - 0) / var_36_13)
				var_36_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_12.position).x, (manager.ui.mainCamera.transform.position - var_36_12.position).y, (manager.ui.mainCamera.transform.position - var_36_12.position).z)
				var_36_12.localEulerAngles.z = 0
				var_36_12.localEulerAngles.x = 0
				var_36_12.localEulerAngles = var_36_12.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_13 and arg_33_1.time_ < 0 + var_36_13 + arg_36_0 then
				var_36_12.localPosition = Vector3.New(0.7, -0.71, -6)
				var_36_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_12.position).x, (manager.ui.mainCamera.transform.position - var_36_12.position).y, (manager.ui.mainCamera.transform.position - var_36_12.position).z)
				var_36_12.localEulerAngles.z = 0
				var_36_12.localEulerAngles.x = 0
				var_36_12.localEulerAngles = var_36_12.localEulerAngles
			end

			local var_36_14 = arg_33_1.actors_["1072ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect1072ui_story == nil then
				arg_33_1.var_.characterEffect1072ui_story = var_36_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_15 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_15 and not isNil(var_36_14) then
				if arg_33_1.var_.characterEffect1072ui_story and not isNil(var_36_14) then
					arg_33_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_15)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_15 and arg_33_1.time_ < 0 + var_36_15 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect1072ui_story then
				arg_33_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_36_16 = 0
			local var_36_17 = 0.8

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(910114008).content)

				arg_33_1.text_.text = var_36_18

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 32 <= 0 and var_36_17 or var_36_17 * (utf8.len(var_36_18) / 32)

				if (32 <= 0 and var_36_17 or var_36_17 * (utf8.len(var_36_18) / 32)) > 0 and var_36_17 < var_36_20 then
					arg_33_1.talkMaxDuration = var_36_20

					if var_36_20 + var_36_16 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_20 + var_36_16
					end
				end

				arg_33_1.text_.text = var_36_18
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_21 = math.max(var_36_17, arg_33_1.talkMaxDuration)

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_21 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_16) / var_36_21

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_16 + var_36_21 and arg_33_1.time_ < var_36_16 + var_36_21 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play910114009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 910114009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play910114010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_0 = 0
			local var_40_1 = 0.7

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(910114009).content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 28 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_2) / 28)

				if (28 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_2) / 28)) > 0 and var_40_1 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_5 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_5 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_5

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_5 and arg_37_1.time_ < var_40_0 + var_40_5 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play910114010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 910114010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play910114011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1072ui_story = arg_41_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).z)
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles = arg_41_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_41_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1072ui_story"].transform.position).z)
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1072ui_story"].transform.localEulerAngles = arg_41_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1072ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1072ui_story == nil then
				arg_41_1.var_.characterEffect1072ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1072ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1072ui_story then
				arg_41_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_4 = arg_41_1.actors_["1074ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1074ui_story == nil then
				arg_41_1.var_.characterEffect1074ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect1074ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1074ui_story then
				arg_41_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_44_6 = 0
			local var_44_7 = 0.525

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(910114010).content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 21 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_8) / 21)

				if (21 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_8) / 21)) > 0 and var_44_7 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_11 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_11 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_11

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_11 and arg_41_1.time_ < var_44_6 + var_44_11 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play910114011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 910114011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play910114012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_48_0 = 0
			local var_48_1 = 0.725

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(910114011).content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 29 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_2) / 29)

				if (29 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_2) / 29)) > 0 and var_48_1 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_5 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_5 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_5

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_5 and arg_45_1.time_ < var_48_0 + var_48_5 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play910114012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 910114012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play910114013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1072ui_story = arg_49_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).z)
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles = arg_49_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_49_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["1072ui_story"].transform.position).z)
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["1072ui_story"].transform.localEulerAngles = arg_49_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["1072ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1072ui_story == nil then
				arg_49_1.var_.characterEffect1072ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect1072ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect1072ui_story then
				arg_49_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action2_2")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_4 = 0
			local var_52_5 = 0.675

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(910114012).content)

				arg_49_1.text_.text = var_52_6

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_8 = 27 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_6) / 27)

				if (27 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_6) / 27)) > 0 and var_52_5 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_6
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_9 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_9 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_9

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_9 and arg_49_1.time_ < var_52_4 + var_52_9 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play910114013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 910114013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play910114014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1072ui_story = arg_53_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).z)
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles = arg_53_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_53_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["1072ui_story"].transform.position).z)
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["1072ui_story"].transform.localEulerAngles = arg_53_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["1072ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1072ui_story == nil then
				arg_53_1.var_.characterEffect1072ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect1072ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect1072ui_story then
				arg_53_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_4 = 0
			local var_56_5 = 0.75

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(910114013).content)

				arg_53_1.text_.text = var_56_6

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_8 = 30 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_6) / 30)

				if (30 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_6) / 30)) > 0 and var_56_5 < var_56_8 then
					arg_53_1.talkMaxDuration = var_56_8

					if var_56_8 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_6
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_9 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_9 and arg_53_1.time_ < var_56_4 + var_56_9 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play910114014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 910114014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play910114015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1074ui_story = arg_57_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1074ui_story"].transform.position).z)
				arg_57_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1074ui_story"].transform.localEulerAngles = arg_57_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1074ui_story"].transform.position).z)
				arg_57_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1074ui_story"].transform.localEulerAngles = arg_57_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1072ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1072ui_story = var_60_1.localPosition
			end

			local var_60_2 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 then
				var_60_1.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 0) / var_60_2)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 then
				var_60_1.localPosition = Vector3.New(0, 100, 0)
				var_60_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_1.position).x, (manager.ui.mainCamera.transform.position - var_60_1.position).y, (manager.ui.mainCamera.transform.position - var_60_1.position).z)
				var_60_1.localEulerAngles.z = 0
				var_60_1.localEulerAngles.x = 0
				var_60_1.localEulerAngles = var_60_1.localEulerAngles
			end

			local var_60_3 = 0
			local var_60_4 = 0.9

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(910114014).content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 36 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 36)

				if (36 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 36)) > 0 and var_60_4 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_3
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_4, arg_57_1.talkMaxDuration)

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_3) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_3 + var_60_8 and arg_57_1.time_ < var_60_3 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play910114015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 910114015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play910114016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1074ui_story = arg_61_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1074ui_story"].transform.position).z)
				arg_61_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1074ui_story"].transform.localEulerAngles = arg_61_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_61_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1074ui_story"].transform.position).z)
				arg_61_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1074ui_story"].transform.localEulerAngles = arg_61_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1074ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1074ui_story == nil then
				arg_61_1.var_.characterEffect1074ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1074ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1074ui_story then
				arg_61_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_4 = arg_61_1.actors_["1072ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1072ui_story = var_64_4.localPosition
			end

			local var_64_5 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 then
				var_64_4.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_61_1.time_ - 0) / var_64_5)
				var_64_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_4.position).x, (manager.ui.mainCamera.transform.position - var_64_4.position).y, (manager.ui.mainCamera.transform.position - var_64_4.position).z)
				var_64_4.localEulerAngles.z = 0
				var_64_4.localEulerAngles.x = 0
				var_64_4.localEulerAngles = var_64_4.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 then
				var_64_4.localPosition = Vector3.New(0.7, -0.71, -6)
				var_64_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_4.position).x, (manager.ui.mainCamera.transform.position - var_64_4.position).y, (manager.ui.mainCamera.transform.position - var_64_4.position).z)
				var_64_4.localEulerAngles.z = 0
				var_64_4.localEulerAngles.x = 0
				var_64_4.localEulerAngles = var_64_4.localEulerAngles
			end

			local var_64_6 = arg_61_1.actors_["1072ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1072ui_story == nil then
				arg_61_1.var_.characterEffect1072ui_story = var_64_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_7 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 and not isNil(var_64_6) then
				if arg_61_1.var_.characterEffect1072ui_story and not isNil(var_64_6) then
					arg_61_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_7)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1072ui_story then
				arg_61_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_64_8 = 0
			local var_64_9 = 0.775

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(910114015).content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_12 = 31 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_10) / 31)

				if (31 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_10) / 31)) > 0 and var_64_9 < var_64_12 then
					arg_61_1.talkMaxDuration = var_64_12

					if var_64_12 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_13 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_13

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_13 and arg_61_1.time_ < var_64_8 + var_64_13 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play910114016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 910114016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play910114017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1072ui_story = arg_65_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1072ui_story"].transform.position).z)
				arg_65_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1072ui_story"].transform.localEulerAngles = arg_65_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_65_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1072ui_story"].transform.position).z)
				arg_65_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1072ui_story"].transform.localEulerAngles = arg_65_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1072ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1072ui_story == nil then
				arg_65_1.var_.characterEffect1072ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1072ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1072ui_story then
				arg_65_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_2")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_4 = arg_65_1.actors_["1074ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1074ui_story == nil then
				arg_65_1.var_.characterEffect1074ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_5 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 and not isNil(var_68_4) then
				if arg_65_1.var_.characterEffect1074ui_story and not isNil(var_68_4) then
					arg_65_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_5)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1074ui_story then
				arg_65_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_68_6 = 0
			local var_68_7 = 0.375

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(910114016).content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 15 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_8) / 15)

				if (15 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_8) / 15)) > 0 and var_68_7 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_11 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_11 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_11

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_11 and arg_65_1.time_ < var_68_6 + var_68_11 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play910114017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 910114017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play910114018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1074ui_story = arg_69_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_72_0 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				arg_69_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1074ui_story"].transform.position).z)
				arg_69_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1074ui_story"].transform.localEulerAngles = arg_69_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				arg_69_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_69_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_69_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_69_1.actors_["1074ui_story"].transform.position).z)
				arg_69_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_69_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_69_1.actors_["1074ui_story"].transform.localEulerAngles = arg_69_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_72_1 = arg_69_1.actors_["1074ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1074ui_story == nil then
				arg_69_1.var_.characterEffect1074ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect1074ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect1074ui_story then
				arg_69_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_72_4 = arg_69_1.actors_["1072ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1072ui_story == nil then
				arg_69_1.var_.characterEffect1072ui_story = var_72_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_5 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_5 and not isNil(var_72_4) then
				if arg_69_1.var_.characterEffect1072ui_story and not isNil(var_72_4) then
					arg_69_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_5)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_5 and arg_69_1.time_ < 0 + var_72_5 + arg_72_0 and not isNil(var_72_4) and arg_69_1.var_.characterEffect1072ui_story then
				arg_69_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_72_6 = 0
			local var_72_7 = 1.1

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(910114017).content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 44 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_8) / 44)

				if (44 <= 0 and var_72_7 or var_72_7 * (utf8.len(var_72_8) / 44)) > 0 and var_72_7 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_11 and arg_69_1.time_ < var_72_6 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play910114018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 910114018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play910114019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1072ui_story = arg_73_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_76_0 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 then
				arg_73_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_73_1.time_ - 0) / var_76_0)
				arg_73_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).z)
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles = arg_73_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 then
				arg_73_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_73_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1072ui_story"].transform.position).z)
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1072ui_story"].transform.localEulerAngles = arg_73_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_76_1 = arg_73_1.actors_["1072ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1072ui_story == nil then
				arg_73_1.var_.characterEffect1072ui_story = var_76_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_2 and not isNil(var_76_1) then
				if arg_73_1.var_.characterEffect1072ui_story and not isNil(var_76_1) then
					arg_73_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_2 and arg_73_1.time_ < 0 + var_76_2 + arg_76_0 and not isNil(var_76_1) and arg_73_1.var_.characterEffect1072ui_story then
				arg_73_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_76_4 = arg_73_1.actors_["1074ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect1074ui_story == nil then
				arg_73_1.var_.characterEffect1074ui_story = var_76_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_5 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 and not isNil(var_76_4) then
				if arg_73_1.var_.characterEffect1074ui_story and not isNil(var_76_4) then
					arg_73_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_5)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 and not isNil(var_76_4) and arg_73_1.var_.characterEffect1074ui_story then
				arg_73_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_76_6 = 0
			local var_76_7 = 0.3

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(910114018).content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 12 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_8) / 12)

				if (12 <= 0 and var_76_7 or var_76_7 * (utf8.len(var_76_8) / 12)) > 0 and var_76_7 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_11 and arg_73_1.time_ < var_76_6 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play910114019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 910114019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play910114020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1074ui_story = arg_77_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1074ui_story"].transform.position).z)
				arg_77_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1074ui_story"].transform.localEulerAngles = arg_77_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_77_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1074ui_story"].transform.position).z)
				arg_77_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1074ui_story"].transform.localEulerAngles = arg_77_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1074ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1074ui_story == nil then
				arg_77_1.var_.characterEffect1074ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1074ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1074ui_story then
				arg_77_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action2_2")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_80_4 = arg_77_1.actors_["1072ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1072ui_story == nil then
				arg_77_1.var_.characterEffect1072ui_story = var_80_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_5 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_5 and not isNil(var_80_4) then
				if arg_77_1.var_.characterEffect1072ui_story and not isNil(var_80_4) then
					arg_77_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_5)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_5 and arg_77_1.time_ < 0 + var_80_5 + arg_80_0 and not isNil(var_80_4) and arg_77_1.var_.characterEffect1072ui_story then
				arg_77_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_80_6 = 0
			local var_80_7 = 1

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_6 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_8 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(910114019).content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 40 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_8) / 40)

				if (40 <= 0 and var_80_7 or var_80_7 * (utf8.len(var_80_8) / 40)) > 0 and var_80_7 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_6 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_6
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_11 = math.max(var_80_7, arg_77_1.talkMaxDuration)

			if var_80_6 <= arg_77_1.time_ and arg_77_1.time_ < var_80_6 + var_80_11 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_6) / var_80_11

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_6 + var_80_11 and arg_77_1.time_ < var_80_6 + var_80_11 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play910114020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 910114020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play910114021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1072ui_story = arg_81_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).z)
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles = arg_81_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_81_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1072ui_story"].transform.position).z)
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1072ui_story"].transform.localEulerAngles = arg_81_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1072ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1072ui_story == nil then
				arg_81_1.var_.characterEffect1072ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1072ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1072ui_story then
				arg_81_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action4_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_4 = arg_81_1.actors_["1074ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1074ui_story == nil then
				arg_81_1.var_.characterEffect1074ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_5 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 and not isNil(var_84_4) then
				if arg_81_1.var_.characterEffect1074ui_story and not isNil(var_84_4) then
					arg_81_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_5)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1074ui_story then
				arg_81_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_84_6 = 0
			local var_84_7 = 0.7

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(910114020).content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 28 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_8) / 28)

				if (28 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_8) / 28)) > 0 and var_84_7 < var_84_10 then
					arg_81_1.talkMaxDuration = var_84_10

					if var_84_10 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_11 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_11 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_11

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_11 and arg_81_1.time_ < var_84_6 + var_84_11 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play910114021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 910114021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play910114022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1072ui_story = arg_85_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).z)
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles = arg_85_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_85_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1072ui_story"].transform.position).z)
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1072ui_story"].transform.localEulerAngles = arg_85_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1072ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1072ui_story == nil then
				arg_85_1.var_.characterEffect1072ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1072ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1072ui_story then
				arg_85_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_4 = 0
			local var_88_5 = 0.425

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(910114021).content)

				arg_85_1.text_.text = var_88_6

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_8 = 17 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_6) / 17)

				if (17 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_6) / 17)) > 0 and var_88_5 < var_88_8 then
					arg_85_1.talkMaxDuration = var_88_8

					if var_88_8 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_6
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_9 and arg_85_1.time_ < var_88_4 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play910114022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 910114022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play910114023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1074ui_story = arg_89_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1074ui_story"].transform.position).z)
				arg_89_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1074ui_story"].transform.localEulerAngles = arg_89_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_89_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1074ui_story"].transform.position).z)
				arg_89_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1074ui_story"].transform.localEulerAngles = arg_89_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1074ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1074ui_story == nil then
				arg_89_1.var_.characterEffect1074ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect1074ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect1074ui_story then
				arg_89_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_92_4 = arg_89_1.actors_["1072ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1072ui_story == nil then
				arg_89_1.var_.characterEffect1072ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_5 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 and not isNil(var_92_4) then
				if arg_89_1.var_.characterEffect1072ui_story and not isNil(var_92_4) then
					arg_89_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_5)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1072ui_story then
				arg_89_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_92_6 = 0
			local var_92_7 = 0.275

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(910114022).content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 11 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_8) / 11)

				if (11 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_8) / 11)) > 0 and var_92_7 < var_92_10 then
					arg_89_1.talkMaxDuration = var_92_10

					if var_92_10 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_11 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_11 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_11

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_11 and arg_89_1.time_ < var_92_6 + var_92_11 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play910114023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 910114023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play910114024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1074ui_story"]) and arg_93_1.var_.characterEffect1074ui_story == nil then
				arg_93_1.var_.characterEffect1074ui_story = arg_93_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1074ui_story"]) then
				if arg_93_1.var_.characterEffect1074ui_story and not isNil(arg_93_1.actors_["1074ui_story"]) then
					arg_93_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1074ui_story"]) and arg_93_1.var_.characterEffect1074ui_story then
				arg_93_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.375

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(910114023).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 15 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 15)

				if (15 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 15)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play910114024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 910114024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play910114025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.625

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(910114024).content)

				arg_97_1.text_.text = var_100_1

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_3 = 25 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 25)

				if (25 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_1) / 25)) > 0 and var_100_0 < var_100_3 then
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
	Play910114025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 910114025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play910114026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.475

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(910114025).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 59 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 59)

				if (59 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 59)) > 0 and var_104_0 < var_104_3 then
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
	Play910114026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 910114026
		arg_105_1.duration_ = 9

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play910114027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.bgs_.ST32 == nil then
				local var_108_0 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST32")
				var_108_0.name = "ST32"
				var_108_0.transform.parent = arg_105_1.stage_.transform
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_.ST32 = var_108_0
			end

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= 2 + arg_108_0 then
				local var_108_1 = arg_105_1.bgs_.ST32

				arg_105_1.bgs_.ST32.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_108_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_2 = var_108_1:GetComponent("SpriteRenderer")

				if var_108_2 and var_108_2.sprite then
					local var_108_3 = 2 * (var_108_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_108_1.transform.localScale = Vector3.New(var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "ST32" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_108_8 = 2

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
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

			local var_108_12 = arg_105_1.actors_["1074ui_story"].transform

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= 2 + arg_108_0 then
				arg_105_1.var_.moveOldPos1074ui_story = var_108_12.localPosition
			end

			local var_108_13 = 0.001

			if 2 <= arg_105_1.time_ and arg_105_1.time_ < 2 + var_108_13 then
				var_108_12.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 2) / var_108_13)
				var_108_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_12.position).x, (manager.ui.mainCamera.transform.position - var_108_12.position).y, (manager.ui.mainCamera.transform.position - var_108_12.position).z)
				var_108_12.localEulerAngles.z = 0
				var_108_12.localEulerAngles.x = 0
				var_108_12.localEulerAngles = var_108_12.localEulerAngles
			end

			if arg_105_1.time_ >= 2 + var_108_13 and arg_105_1.time_ < 2 + var_108_13 + arg_108_0 then
				var_108_12.localPosition = Vector3.New(0, 100, 0)
				var_108_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_12.position).x, (manager.ui.mainCamera.transform.position - var_108_12.position).y, (manager.ui.mainCamera.transform.position - var_108_12.position).z)
				var_108_12.localEulerAngles.z = 0
				var_108_12.localEulerAngles.x = 0
				var_108_12.localEulerAngles = var_108_12.localEulerAngles
			end

			local var_108_14 = arg_105_1.actors_["1072ui_story"].transform

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= 2 + arg_108_0 then
				arg_105_1.var_.moveOldPos1072ui_story = var_108_14.localPosition
			end

			local var_108_15 = 0.001

			if 2 <= arg_105_1.time_ and arg_105_1.time_ < 2 + var_108_15 then
				var_108_14.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 2) / var_108_15)
				var_108_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_14.position).x, (manager.ui.mainCamera.transform.position - var_108_14.position).y, (manager.ui.mainCamera.transform.position - var_108_14.position).z)
				var_108_14.localEulerAngles.z = 0
				var_108_14.localEulerAngles.x = 0
				var_108_14.localEulerAngles = var_108_14.localEulerAngles
			end

			if arg_105_1.time_ >= 2 + var_108_15 and arg_105_1.time_ < 2 + var_108_15 + arg_108_0 then
				var_108_14.localPosition = Vector3.New(0, 100, 0)
				var_108_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_14.position).x, (manager.ui.mainCamera.transform.position - var_108_14.position).y, (manager.ui.mainCamera.transform.position - var_108_14.position).z)
				var_108_14.localEulerAngles.z = 0
				var_108_14.localEulerAngles.x = 0
				var_108_14.localEulerAngles = var_108_14.localEulerAngles
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_16 = 4
			local var_108_17 = 0.975

			if 4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_18 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_18:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_19 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(910114026).content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_21 = 39 <= 0 and var_108_17 or var_108_17 * (utf8.len(var_108_19) / 39)

				if (39 <= 0 and var_108_17 or var_108_17 * (utf8.len(var_108_19) / 39)) > 0 and var_108_17 < var_108_21 then
					arg_105_1.talkMaxDuration = var_108_21
					var_108_16 = var_108_16 + 0.3

					if var_108_21 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_21 + var_108_16
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_22 = var_108_16 + 0.3
			local var_108_23 = math.max(var_108_17, arg_105_1.talkMaxDuration)

			if var_108_16 + 0.3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_22 + var_108_23 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_22) / var_108_23

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_22 + var_108_23 and arg_105_1.time_ < var_108_22 + var_108_23 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play910114027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 910114027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play910114028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if arg_111_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_114_0 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_111_1.stage_.transform)

				var_114_0.name = "1070ui_story"
				var_114_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["1070ui_story"] = var_114_0

				local var_114_1 = var_114_0:GetComponentInChildren(typeof(CharacterEffect))

				var_114_1.enabled = true

				local var_114_2 = GameObjectTools.GetOrAddComponent(var_114_0, typeof(DynamicBoneHelper))

				if var_114_2 then
					var_114_2:EnableDynamicBone(false)
				end

				arg_111_1:ShowWeapon(var_114_1.transform, false)

				arg_111_1.var_["1070ui_story" .. "Animator"] = var_114_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_111_1.var_["1070ui_story" .. "Animator"].applyRootMotion = true
				arg_111_1.var_["1070ui_story" .. "LipSync"] = var_114_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_114_3 = arg_111_1.actors_["1070ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1070ui_story = var_114_3.localPosition
			end

			local var_114_4 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				var_114_3.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_111_1.time_ - 0) / var_114_4)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				var_114_3.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			local var_114_5 = arg_111_1.actors_["1070ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.characterEffect1070ui_story == nil then
				arg_111_1.var_.characterEffect1070ui_story = var_114_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_6 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 and not isNil(var_114_5) then
				if arg_111_1.var_.characterEffect1070ui_story and not isNil(var_114_5) then
					arg_111_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.characterEffect1070ui_story then
				arg_111_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_8 = arg_111_1.actors_["1074ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1074ui_story = var_114_8.localPosition
			end

			local var_114_9 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_9 then
				var_114_8.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_111_1.time_ - 0) / var_114_9)
				var_114_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_8.position).x, (manager.ui.mainCamera.transform.position - var_114_8.position).y, (manager.ui.mainCamera.transform.position - var_114_8.position).z)
				var_114_8.localEulerAngles.z = 0
				var_114_8.localEulerAngles.x = 0
				var_114_8.localEulerAngles = var_114_8.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_9 and arg_111_1.time_ < 0 + var_114_9 + arg_114_0 then
				var_114_8.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_114_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_8.position).x, (manager.ui.mainCamera.transform.position - var_114_8.position).y, (manager.ui.mainCamera.transform.position - var_114_8.position).z)
				var_114_8.localEulerAngles.z = 0
				var_114_8.localEulerAngles.x = 0
				var_114_8.localEulerAngles = var_114_8.localEulerAngles
			end

			local var_114_10 = arg_111_1.actors_["1074ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_10) and arg_111_1.var_.characterEffect1074ui_story == nil then
				arg_111_1.var_.characterEffect1074ui_story = var_114_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_11 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_11 and not isNil(var_114_10) then
				if arg_111_1.var_.characterEffect1074ui_story and not isNil(var_114_10) then
					arg_111_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_11)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_11 and arg_111_1.time_ < 0 + var_114_11 + arg_114_0 and not isNil(var_114_10) and arg_111_1.var_.characterEffect1074ui_story then
				arg_111_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_114_12 = 0
			local var_114_13 = 0.325

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_14 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(910114027).content)

				arg_111_1.text_.text = var_114_14

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_16 = 13 <= 0 and var_114_13 or var_114_13 * (utf8.len(var_114_14) / 13)

				if (13 <= 0 and var_114_13 or var_114_13 * (utf8.len(var_114_14) / 13)) > 0 and var_114_13 < var_114_16 then
					arg_111_1.talkMaxDuration = var_114_16

					if var_114_16 + var_114_12 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_16 + var_114_12
					end
				end

				arg_111_1.text_.text = var_114_14
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_17 = math.max(var_114_13, arg_111_1.talkMaxDuration)

			if var_114_12 <= arg_111_1.time_ and arg_111_1.time_ < var_114_12 + var_114_17 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_12) / var_114_17

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_12 + var_114_17 and arg_111_1.time_ < var_114_12 + var_114_17 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play910114028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 910114028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play910114029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1074ui_story = arg_115_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1074ui_story"].transform.position).z)
				arg_115_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1074ui_story"].transform.localEulerAngles = arg_115_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_115_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1074ui_story"].transform.position).z)
				arg_115_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1074ui_story"].transform.localEulerAngles = arg_115_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1074ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1074ui_story == nil then
				arg_115_1.var_.characterEffect1074ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1074ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1074ui_story then
				arg_115_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action3_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_4 = arg_115_1.actors_["1070ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_4) and arg_115_1.var_.characterEffect1070ui_story == nil then
				arg_115_1.var_.characterEffect1070ui_story = var_118_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_5 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_5 and not isNil(var_118_4) then
				if arg_115_1.var_.characterEffect1070ui_story and not isNil(var_118_4) then
					arg_115_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_5)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_5 and arg_115_1.time_ < 0 + var_118_5 + arg_118_0 and not isNil(var_118_4) and arg_115_1.var_.characterEffect1070ui_story then
				arg_115_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_118_6 = 0
			local var_118_7 = 0.925

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_8 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(910114028).content)

				arg_115_1.text_.text = var_118_8

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 37 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_8) / 37)

				if (37 <= 0 and var_118_7 or var_118_7 * (utf8.len(var_118_8) / 37)) > 0 and var_118_7 < var_118_10 then
					arg_115_1.talkMaxDuration = var_118_10

					if var_118_10 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_8
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_11 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_11 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_11

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_11 and arg_115_1.time_ < var_118_6 + var_118_11 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play910114029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 910114029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play910114030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1070ui_story = arg_119_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1070ui_story"].transform.position).z)
				arg_119_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1070ui_story"].transform.localEulerAngles = arg_119_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["1070ui_story"].transform.position).z)
				arg_119_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["1070ui_story"].transform.localEulerAngles = arg_119_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["1070ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1070ui_story == nil then
				arg_119_1.var_.characterEffect1070ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect1070ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_2)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect1070ui_story then
				arg_119_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_122_3 = arg_119_1.actors_["1074ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1074ui_story = var_122_3.localPosition
			end

			local var_122_4 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				var_122_3.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_4)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				var_122_3.localPosition = Vector3.New(0, 100, 0)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			local var_122_5 = arg_119_1.actors_["1074ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1074ui_story == nil then
				arg_119_1.var_.characterEffect1074ui_story = var_122_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_6 and not isNil(var_122_5) then
				if arg_119_1.var_.characterEffect1074ui_story and not isNil(var_122_5) then
					arg_119_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_6)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_6 and arg_119_1.time_ < 0 + var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1074ui_story then
				arg_119_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_122_7 = arg_119_1.actors_["1072ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1072ui_story = var_122_7.localPosition
			end

			local var_122_8 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_8 then
				var_122_7.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_119_1.time_ - 0) / var_122_8)
				var_122_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_7.position).x, (manager.ui.mainCamera.transform.position - var_122_7.position).y, (manager.ui.mainCamera.transform.position - var_122_7.position).z)
				var_122_7.localEulerAngles.z = 0
				var_122_7.localEulerAngles.x = 0
				var_122_7.localEulerAngles = var_122_7.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_8 and arg_119_1.time_ < 0 + var_122_8 + arg_122_0 then
				var_122_7.localPosition = Vector3.New(0, -0.71, -6)
				var_122_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_7.position).x, (manager.ui.mainCamera.transform.position - var_122_7.position).y, (manager.ui.mainCamera.transform.position - var_122_7.position).z)
				var_122_7.localEulerAngles.z = 0
				var_122_7.localEulerAngles.x = 0
				var_122_7.localEulerAngles = var_122_7.localEulerAngles
			end

			local var_122_9 = arg_119_1.actors_["1072ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1072ui_story == nil then
				arg_119_1.var_.characterEffect1072ui_story = var_122_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_10 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_10 and not isNil(var_122_9) then
				if arg_119_1.var_.characterEffect1072ui_story and not isNil(var_122_9) then
					arg_119_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_10 and arg_119_1.time_ < 0 + var_122_10 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect1072ui_story then
				arg_119_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_122_12 = 0
			local var_122_13 = 0.25

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_14 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(910114029).content)

				arg_119_1.text_.text = var_122_14

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_16 = 10 <= 0 and var_122_13 or var_122_13 * (utf8.len(var_122_14) / 10)

				if (10 <= 0 and var_122_13 or var_122_13 * (utf8.len(var_122_14) / 10)) > 0 and var_122_13 < var_122_16 then
					arg_119_1.talkMaxDuration = var_122_16

					if var_122_16 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_16 + var_122_12
					end
				end

				arg_119_1.text_.text = var_122_14
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_17 = math.max(var_122_13, arg_119_1.talkMaxDuration)

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_17 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_12) / var_122_17

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_12 + var_122_17 and arg_119_1.time_ < var_122_12 + var_122_17 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play910114030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 910114030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play910114031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1072ui_story = arg_123_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).z)
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles = arg_123_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_123_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1072ui_story"].transform.position).z)
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1072ui_story"].transform.localEulerAngles = arg_123_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1072ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1072ui_story == nil then
				arg_123_1.var_.characterEffect1072ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1072ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_2)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1072ui_story then
				arg_123_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_126_3 = arg_123_1.actors_["1070ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1070ui_story = var_126_3.localPosition
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_3.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_123_1.time_ - 0) / var_126_4)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_3.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			local var_126_5 = arg_123_1.actors_["1070ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect1070ui_story == nil then
				arg_123_1.var_.characterEffect1070ui_story = var_126_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_6 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.characterEffect1070ui_story and not isNil(var_126_5) then
					arg_123_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect1070ui_story then
				arg_123_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_8 = 0
			local var_126_9 = 0.4

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(910114030).content)

				arg_123_1.text_.text = var_126_10

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_12 = 16 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_10) / 16)

				if (16 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_10) / 16)) > 0 and var_126_9 < var_126_12 then
					arg_123_1.talkMaxDuration = var_126_12

					if var_126_12 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_12 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_10
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_13 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_13 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_13

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_13 and arg_123_1.time_ < var_126_8 + var_126_13 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_123_1:InitPlayNodeList()
	end,
	Play910114031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 910114031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play910114032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1070ui_story = arg_127_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1070ui_story"].transform.position).z)
				arg_127_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1070ui_story"].transform.localEulerAngles = arg_127_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_127_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1070ui_story"].transform.position).z)
				arg_127_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1070ui_story"].transform.localEulerAngles = arg_127_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1070ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1070ui_story == nil then
				arg_127_1.var_.characterEffect1070ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1070ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_2)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1070ui_story then
				arg_127_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_130_3 = arg_127_1.actors_["1072ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect1072ui_story == nil then
				arg_127_1.var_.characterEffect1072ui_story = var_130_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_4 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 and not isNil(var_130_3) then
				if arg_127_1.var_.characterEffect1072ui_story and not isNil(var_130_3) then
					arg_127_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect1072ui_story then
				arg_127_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_130_6 = 0
			local var_130_7 = 0.225

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_8 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(910114031).content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 9 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_8) / 9)

				if (9 <= 0 and var_130_7 or var_130_7 * (utf8.len(var_130_8) / 9)) > 0 and var_130_7 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_11 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_11 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_11

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_11 and arg_127_1.time_ < var_130_6 + var_130_11 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play910114032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 910114032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play910114033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.7

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(910114032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 28 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 28)

				if (28 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 28)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play910114033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 910114033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play910114034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1072ui_story"]) and arg_135_1.var_.characterEffect1072ui_story == nil then
				arg_135_1.var_.characterEffect1072ui_story = arg_135_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_0 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1072ui_story"]) then
				if arg_135_1.var_.characterEffect1072ui_story and not isNil(arg_135_1.actors_["1072ui_story"]) then
					arg_135_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_0)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1072ui_story"]) and arg_135_1.var_.characterEffect1072ui_story then
				arg_135_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_138_1 = arg_135_1.actors_["1070ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1070ui_story == nil then
				arg_135_1.var_.characterEffect1070ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1070ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1070ui_story then
				arg_135_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_138_4 = 0
			local var_138_5 = 0.625

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(910114033).content)

				arg_135_1.text_.text = var_138_6

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_8 = 25 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_6) / 25)

				if (25 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_6) / 25)) > 0 and var_138_5 < var_138_8 then
					arg_135_1.talkMaxDuration = var_138_8

					if var_138_8 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_6
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_9 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_9 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_9

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_9 and arg_135_1.time_ < var_138_4 + var_138_9 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play910114034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 910114034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play910114035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1072ui_story = arg_139_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1072ui_story"].transform.position).z)
				arg_139_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1072ui_story"].transform.localEulerAngles = arg_139_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1072ui_story"].transform.position).z)
				arg_139_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1072ui_story"].transform.localEulerAngles = arg_139_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1072ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1072ui_story == nil then
				arg_139_1.var_.characterEffect1072ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1072ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_2)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1072ui_story then
				arg_139_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_142_3 = arg_139_1.actors_["1070ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1070ui_story = var_142_3.localPosition
			end

			local var_142_4 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_3.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_4)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_3.localPosition = Vector3.New(0, 100, 0)
				var_142_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_3.position).x, (manager.ui.mainCamera.transform.position - var_142_3.position).y, (manager.ui.mainCamera.transform.position - var_142_3.position).z)
				var_142_3.localEulerAngles.z = 0
				var_142_3.localEulerAngles.x = 0
				var_142_3.localEulerAngles = var_142_3.localEulerAngles
			end

			local var_142_5 = arg_139_1.actors_["1070ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1070ui_story == nil then
				arg_139_1.var_.characterEffect1070ui_story = var_142_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_6 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 and not isNil(var_142_5) then
				if arg_139_1.var_.characterEffect1070ui_story and not isNil(var_142_5) then
					arg_139_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_6)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1070ui_story then
				arg_139_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_142_7 = arg_139_1.actors_["1074ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1074ui_story = var_142_7.localPosition
			end

			local var_142_8 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_8 then
				var_142_7.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_139_1.time_ - 0) / var_142_8)
				var_142_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_7.position).x, (manager.ui.mainCamera.transform.position - var_142_7.position).y, (manager.ui.mainCamera.transform.position - var_142_7.position).z)
				var_142_7.localEulerAngles.z = 0
				var_142_7.localEulerAngles.x = 0
				var_142_7.localEulerAngles = var_142_7.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_8 and arg_139_1.time_ < 0 + var_142_8 + arg_142_0 then
				var_142_7.localPosition = Vector3.New(0, -1.055, -6.12)
				var_142_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_7.position).x, (manager.ui.mainCamera.transform.position - var_142_7.position).y, (manager.ui.mainCamera.transform.position - var_142_7.position).z)
				var_142_7.localEulerAngles.z = 0
				var_142_7.localEulerAngles.x = 0
				var_142_7.localEulerAngles = var_142_7.localEulerAngles
			end

			local var_142_9 = arg_139_1.actors_["1074ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1074ui_story == nil then
				arg_139_1.var_.characterEffect1074ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_10 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_10 and not isNil(var_142_9) then
				if arg_139_1.var_.characterEffect1074ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_10 and arg_139_1.time_ < 0 + var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1074ui_story then
				arg_139_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_142_12 = 0
			local var_142_13 = 0.85

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_14 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(910114034).content)

				arg_139_1.text_.text = var_142_14

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_16 = 34 <= 0 and var_142_13 or var_142_13 * (utf8.len(var_142_14) / 34)

				if (34 <= 0 and var_142_13 or var_142_13 * (utf8.len(var_142_14) / 34)) > 0 and var_142_13 < var_142_16 then
					arg_139_1.talkMaxDuration = var_142_16

					if var_142_16 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_16 + var_142_12
					end
				end

				arg_139_1.text_.text = var_142_14
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_17 = math.max(var_142_13, arg_139_1.talkMaxDuration)

			if var_142_12 <= arg_139_1.time_ and arg_139_1.time_ < var_142_12 + var_142_17 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_12) / var_142_17

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_12 + var_142_17 and arg_139_1.time_ < var_142_12 + var_142_17 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play910114035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 910114035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play910114036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1070ui_story = arg_143_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1070ui_story"].transform.position).z)
				arg_143_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1070ui_story"].transform.localEulerAngles = arg_143_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_143_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1070ui_story"].transform.position).z)
				arg_143_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1070ui_story"].transform.localEulerAngles = arg_143_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["1070ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1070ui_story == nil then
				arg_143_1.var_.characterEffect1070ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1070ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1070ui_story then
				arg_143_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_146_4 = arg_143_1.actors_["1074ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1074ui_story = var_146_4.localPosition
			end

			local var_146_5 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 then
				var_146_4.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_5)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 then
				var_146_4.localPosition = Vector3.New(0, 100, 0)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			local var_146_6 = 0
			local var_146_7 = 0.35

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(910114035).content)

				arg_143_1.text_.text = var_146_8

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_10 = 14 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_8) / 14)

				if (14 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_8) / 14)) > 0 and var_146_7 < var_146_10 then
					arg_143_1.talkMaxDuration = var_146_10

					if var_146_10 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_8
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_11 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_11 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_11

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_11 and arg_143_1.time_ < var_146_6 + var_146_11 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play910114036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 910114036
		arg_147_1.duration_ = 9

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play910114037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if arg_147_1.bgs_.J13f == nil then
				local var_150_0 = Object.Instantiate(arg_147_1.paintGo_)

				var_150_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J13f")
				var_150_0.name = "J13f"
				var_150_0.transform.parent = arg_147_1.stage_.transform
				var_150_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.bgs_.J13f = var_150_0
			end

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= 2 + arg_150_0 then
				local var_150_1 = arg_147_1.bgs_.J13f

				arg_147_1.bgs_.J13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_150_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_2 = var_150_1:GetComponent("SpriteRenderer")

				if var_150_2 and var_150_2.sprite then
					local var_150_3 = 2 * (var_150_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_150_1.transform.localScale = Vector3.New(var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, var_150_3 / var_150_2.sprite.bounds.size.y < var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x and var_150_3 * manager.ui.mainCameraCom_.aspect / var_150_2.sprite.bounds.size.x or var_150_3 / var_150_2.sprite.bounds.size.y, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "J13f" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_4 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_5 = 2

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_5 then
				local var_150_6 = Color.New(0, 0, 0)

				var_150_6.a = Mathf.Lerp(0, 1, (arg_147_1.time_ - var_150_4) / var_150_5)
				arg_147_1.mask_.color = var_150_6
			end

			if arg_147_1.time_ >= var_150_4 + var_150_5 and arg_147_1.time_ < var_150_4 + var_150_5 + arg_150_0 then
				local var_150_7 = Color.New(0, 0, 0)

				var_150_7.a = 1
				arg_147_1.mask_.color = var_150_7
			end

			local var_150_8 = 2

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_9 = 2

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_9 then
				local var_150_10 = Color.New(0, 0, 0)

				var_150_10.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_8) / var_150_9)
				arg_147_1.mask_.color = var_150_10
			end

			if arg_147_1.time_ >= var_150_8 + var_150_9 and arg_147_1.time_ < var_150_8 + var_150_9 + arg_150_0 then
				local var_150_11 = Color.New(0, 0, 0)

				arg_147_1.mask_.enabled = false
				var_150_11.a = 0
				arg_147_1.mask_.color = var_150_11
			end

			local var_150_12 = arg_147_1.actors_["1070ui_story"].transform

			if 2 < arg_147_1.time_ and arg_147_1.time_ <= 2 + arg_150_0 then
				arg_147_1.var_.moveOldPos1070ui_story = var_150_12.localPosition
			end

			local var_150_13 = 0.001

			if 2 <= arg_147_1.time_ and arg_147_1.time_ < 2 + var_150_13 then
				var_150_12.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 2) / var_150_13)
				var_150_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_12.position).x, (manager.ui.mainCamera.transform.position - var_150_12.position).y, (manager.ui.mainCamera.transform.position - var_150_12.position).z)
				var_150_12.localEulerAngles.z = 0
				var_150_12.localEulerAngles.x = 0
				var_150_12.localEulerAngles = var_150_12.localEulerAngles
			end

			if arg_147_1.time_ >= 2 + var_150_13 and arg_147_1.time_ < 2 + var_150_13 + arg_150_0 then
				var_150_12.localPosition = Vector3.New(0, 100, 0)
				var_150_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_12.position).x, (manager.ui.mainCamera.transform.position - var_150_12.position).y, (manager.ui.mainCamera.transform.position - var_150_12.position).z)
				var_150_12.localEulerAngles.z = 0
				var_150_12.localEulerAngles.x = 0
				var_150_12.localEulerAngles = var_150_12.localEulerAngles
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_14 = 4
			local var_150_15 = 0.725

			if 4 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_16 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_16:setOnUpdate(LuaHelper.FloatAction(function(arg_151_0)
					arg_147_1.dialogCg_.alpha = arg_151_0
				end))
				var_150_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_17 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(910114036).content)

				arg_147_1.text_.text = var_150_17

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_19 = 29 <= 0 and var_150_15 or var_150_15 * (utf8.len(var_150_17) / 29)

				if (29 <= 0 and var_150_15 or var_150_15 * (utf8.len(var_150_17) / 29)) > 0 and var_150_15 < var_150_19 then
					arg_147_1.talkMaxDuration = var_150_19
					var_150_14 = var_150_14 + 0.3

					if var_150_19 + var_150_14 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_19 + var_150_14
					end
				end

				arg_147_1.text_.text = var_150_17
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_20 = var_150_14 + 0.3
			local var_150_21 = math.max(var_150_15, arg_147_1.talkMaxDuration)

			if var_150_14 + 0.3 <= arg_147_1.time_ and arg_147_1.time_ < var_150_20 + var_150_21 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_20) / var_150_21

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_20 + var_150_21 and arg_147_1.time_ < var_150_20 + var_150_21 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910114037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 910114037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play910114038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1070ui_story = arg_153_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1070ui_story"].transform.position).z)
				arg_153_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1070ui_story"].transform.localEulerAngles = arg_153_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_153_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1070ui_story"].transform.position).z)
				arg_153_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1070ui_story"].transform.localEulerAngles = arg_153_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1070ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1070ui_story == nil then
				arg_153_1.var_.characterEffect1070ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1070ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1070ui_story then
				arg_153_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_4 = 0
			local var_156_5 = 0.1

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
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

				local var_156_6 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(910114037).content)

				arg_153_1.text_.text = var_156_6

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_8 = 4 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_6) / 4)

				if (4 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_6) / 4)) > 0 and var_156_5 < var_156_8 then
					arg_153_1.talkMaxDuration = var_156_8

					if var_156_8 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_6
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_9 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_9 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_9

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_9 and arg_153_1.time_ < var_156_4 + var_156_9 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play910114038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 910114038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play910114039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_160_0 = 0
			local var_160_1 = 0.175

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
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

				local var_160_2 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(910114038).content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 7 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_2) / 7)

				if (7 <= 0 and var_160_1 or var_160_1 * (utf8.len(var_160_2) / 7)) > 0 and var_160_1 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_5 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_5 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_5

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_5 and arg_157_1.time_ < var_160_0 + var_160_5 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play910114039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 910114039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play910114040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1070ui_story = arg_161_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1070ui_story"].transform.position).z)
				arg_161_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1070ui_story"].transform.localEulerAngles = arg_161_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1070ui_story"].transform.position).z)
				arg_161_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1070ui_story"].transform.localEulerAngles = arg_161_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1070ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1070ui_story == nil then
				arg_161_1.var_.characterEffect1070ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1070ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_2)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1070ui_story then
				arg_161_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_164_3 = 0
			local var_164_4 = 0.875

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_5 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(910114039).content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 35 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 35)

				if (35 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 35)) > 0 and var_164_4 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_3
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_4, arg_161_1.talkMaxDuration)

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_3) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_3 + var_164_8 and arg_161_1.time_ < var_164_3 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play910114040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 910114040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play910114041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.225

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(910114040).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 48 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 48)

				if (48 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 48)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play910114041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 910114041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play910114042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.6

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(910114041).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 25 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 25)

				if (25 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 25)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play910114042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 910114042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play910114043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 1.525

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(910114042).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 61 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 61)

				if (61 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 61)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play910114043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 910114043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play910114044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.125

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(910114043).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 5 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 5)

				if (5 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 5)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play910114044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 910114044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play910114045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.825

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(910114044).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 33 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 33)

				if (33 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 33)) > 0 and var_184_0 < var_184_3 then
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
	Play910114045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 910114045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play910114046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1070ui_story = arg_185_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1070ui_story"].transform.position).z)
				arg_185_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1070ui_story"].transform.localEulerAngles = arg_185_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_185_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1070ui_story"].transform.position).z)
				arg_185_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1070ui_story"].transform.localEulerAngles = arg_185_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1070ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1070ui_story == nil then
				arg_185_1.var_.characterEffect1070ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1070ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1070ui_story then
				arg_185_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_188_4 = 0
			local var_188_5 = 0.125

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
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

				local var_188_6 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(910114045).content)

				arg_185_1.text_.text = var_188_6

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_8 = 5 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_6) / 5)

				if (5 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_6) / 5)) > 0 and var_188_5 < var_188_8 then
					arg_185_1.talkMaxDuration = var_188_8

					if var_188_8 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_6
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_9 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_9 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_9

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_9 and arg_185_1.time_ < var_188_4 + var_188_9 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play910114046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 910114046
		arg_189_1.duration_ = 9

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play910114047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if arg_189_1.bgs_.ST53 == nil then
				local var_192_0 = Object.Instantiate(arg_189_1.paintGo_)

				var_192_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST53")
				var_192_0.name = "ST53"
				var_192_0.transform.parent = arg_189_1.stage_.transform
				var_192_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.bgs_.ST53 = var_192_0
			end

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= 2 + arg_192_0 then
				local var_192_1 = arg_189_1.bgs_.ST53

				arg_189_1.bgs_.ST53.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_192_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_2 = var_192_1:GetComponent("SpriteRenderer")

				if var_192_2 and var_192_2.sprite then
					local var_192_3 = 2 * (var_192_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_192_1.transform.localScale = Vector3.New(var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, var_192_3 / var_192_2.sprite.bounds.size.y < var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x and var_192_3 * manager.ui.mainCameraCom_.aspect / var_192_2.sprite.bounds.size.x or var_192_3 / var_192_2.sprite.bounds.size.y, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "ST53" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_4 = 0

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_5 = 2

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_5 then
				local var_192_6 = Color.New(0, 0, 0)

				var_192_6.a = Mathf.Lerp(0, 1, (arg_189_1.time_ - var_192_4) / var_192_5)
				arg_189_1.mask_.color = var_192_6
			end

			if arg_189_1.time_ >= var_192_4 + var_192_5 and arg_189_1.time_ < var_192_4 + var_192_5 + arg_192_0 then
				local var_192_7 = Color.New(0, 0, 0)

				var_192_7.a = 1
				arg_189_1.mask_.color = var_192_7
			end

			local var_192_8 = 2

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_9 = 2

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 then
				local var_192_10 = Color.New(0, 0, 0)

				var_192_10.a = Mathf.Lerp(1, 0, (arg_189_1.time_ - var_192_8) / var_192_9)
				arg_189_1.mask_.color = var_192_10
			end

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 then
				local var_192_11 = Color.New(0, 0, 0)

				arg_189_1.mask_.enabled = false
				var_192_11.a = 0
				arg_189_1.mask_.color = var_192_11
			end

			local var_192_12 = arg_189_1.actors_["1070ui_story"].transform

			if 2 < arg_189_1.time_ and arg_189_1.time_ <= 2 + arg_192_0 then
				arg_189_1.var_.moveOldPos1070ui_story = var_192_12.localPosition
			end

			local var_192_13 = 0.001

			if 2 <= arg_189_1.time_ and arg_189_1.time_ < 2 + var_192_13 then
				var_192_12.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 2) / var_192_13)
				var_192_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_12.position).x, (manager.ui.mainCamera.transform.position - var_192_12.position).y, (manager.ui.mainCamera.transform.position - var_192_12.position).z)
				var_192_12.localEulerAngles.z = 0
				var_192_12.localEulerAngles.x = 0
				var_192_12.localEulerAngles = var_192_12.localEulerAngles
			end

			if arg_189_1.time_ >= 2 + var_192_13 and arg_189_1.time_ < 2 + var_192_13 + arg_192_0 then
				var_192_12.localPosition = Vector3.New(0, 100, 0)
				var_192_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_12.position).x, (manager.ui.mainCamera.transform.position - var_192_12.position).y, (manager.ui.mainCamera.transform.position - var_192_12.position).z)
				var_192_12.localEulerAngles.z = 0
				var_192_12.localEulerAngles.x = 0
				var_192_12.localEulerAngles = var_192_12.localEulerAngles
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_14 = 4
			local var_192_15 = 0.65

			if 4 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_16 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_16:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_17 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(910114046).content)

				arg_189_1.text_.text = var_192_17

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_19 = 26 <= 0 and var_192_15 or var_192_15 * (utf8.len(var_192_17) / 26)

				if (26 <= 0 and var_192_15 or var_192_15 * (utf8.len(var_192_17) / 26)) > 0 and var_192_15 < var_192_19 then
					arg_189_1.talkMaxDuration = var_192_19
					var_192_14 = var_192_14 + 0.3

					if var_192_19 + var_192_14 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_19 + var_192_14
					end
				end

				arg_189_1.text_.text = var_192_17
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_20 = var_192_14 + 0.3
			local var_192_21 = math.max(var_192_15, arg_189_1.talkMaxDuration)

			if var_192_14 + 0.3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_20 + var_192_21 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_20) / var_192_21

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_20 + var_192_21 and arg_189_1.time_ < var_192_20 + var_192_21 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play910114047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 910114047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play910114048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1070ui_story = arg_195_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1070ui_story"].transform.position).z)
				arg_195_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1070ui_story"].transform.localEulerAngles = arg_195_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_195_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1070ui_story"].transform.position).z)
				arg_195_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1070ui_story"].transform.localEulerAngles = arg_195_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["1070ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1070ui_story == nil then
				arg_195_1.var_.characterEffect1070ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1070ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1070ui_story then
				arg_195_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_4 = 0
			local var_198_5 = 0.625

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(910114047).content)

				arg_195_1.text_.text = var_198_6

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_8 = 25 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_6) / 25)

				if (25 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_6) / 25)) > 0 and var_198_5 < var_198_8 then
					arg_195_1.talkMaxDuration = var_198_8

					if var_198_8 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_6
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_9 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_9 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_9

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_9 and arg_195_1.time_ < var_198_4 + var_198_9 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play910114048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 910114048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play910114049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			local var_202_0 = 0
			local var_202_1 = 0.35

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_2 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(910114048).content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 14 <= 0 and var_202_1 or var_202_1 * (utf8.len(var_202_2) / 14)

				if (14 <= 0 and var_202_1 or var_202_1 * (utf8.len(var_202_2) / 14)) > 0 and var_202_1 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_5 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_5 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_5

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_5 and arg_199_1.time_ < var_202_0 + var_202_5 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play910114049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 910114049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play910114050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1070ui_story = arg_203_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1070ui_story"].transform.position).z)
				arg_203_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1070ui_story"].transform.localEulerAngles = arg_203_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["1070ui_story"].transform.position).z)
				arg_203_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["1070ui_story"].transform.localEulerAngles = arg_203_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["1070ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1070ui_story == nil then
				arg_203_1.var_.characterEffect1070ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect1070ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_2)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect1070ui_story then
				arg_203_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_206_3 = 0
			local var_206_4 = 0.475

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_3 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_5 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(910114049).content)

				arg_203_1.text_.text = var_206_5

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 19 <= 0 and var_206_4 or var_206_4 * (utf8.len(var_206_5) / 19)

				if (19 <= 0 and var_206_4 or var_206_4 * (utf8.len(var_206_5) / 19)) > 0 and var_206_4 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_3 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_3
					end
				end

				arg_203_1.text_.text = var_206_5
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_8 = math.max(var_206_4, arg_203_1.talkMaxDuration)

			if var_206_3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_3 + var_206_8 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_3) / var_206_8

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_3 + var_206_8 and arg_203_1.time_ < var_206_3 + var_206_8 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play910114050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 910114050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play910114051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_210_0 = 0.333333333333333

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				local var_210_1, var_210_2 = math.modf((arg_207_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_210_2 * 0.13, var_210_2 * 0.13, var_210_2 * 0.13) + arg_207_1.var_.shakeOldPos
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				manager.ui.mainCamera.transform.localPosition = arg_207_1.var_.shakeOldPos
			end

			local var_210_3 = 0
			local var_210_4 = 0.175

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_3 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_9")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_5 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(910114050).content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_7 = 7 <= 0 and var_210_4 or var_210_4 * (utf8.len(var_210_5) / 7)

				if (7 <= 0 and var_210_4 or var_210_4 * (utf8.len(var_210_5) / 7)) > 0 and var_210_4 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_3 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_3
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_8 = math.max(var_210_4, arg_207_1.talkMaxDuration)

			if var_210_3 <= arg_207_1.time_ and arg_207_1.time_ < var_210_3 + var_210_8 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_3) / var_210_8

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_3 + var_210_8 and arg_207_1.time_ < var_210_3 + var_210_8 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play910114051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 910114051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play910114052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 0.35

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(910114051).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 14 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 14)

				if (14 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 14)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play910114052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 910114052
		arg_215_1.duration_ = 9

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play910114053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 2 < arg_215_1.time_ and arg_215_1.time_ <= 2 + arg_218_0 then
				local var_218_0 = arg_215_1.bgs_.ST53

				arg_215_1.bgs_.ST53.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_218_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_1 = var_218_0:GetComponent("SpriteRenderer")

				if var_218_1 and var_218_1.sprite then
					local var_218_2 = 2 * (var_218_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_218_0.transform.localScale = Vector3.New(var_218_2 / var_218_1.sprite.bounds.size.y < var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x and var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x or var_218_2 / var_218_1.sprite.bounds.size.y, var_218_2 / var_218_1.sprite.bounds.size.y < var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x and var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x or var_218_2 / var_218_1.sprite.bounds.size.y, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "ST53" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_3 = 0

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_4 = 2

			if var_218_3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_3 + var_218_4 then
				local var_218_5 = Color.New(0, 0, 0)

				var_218_5.a = Mathf.Lerp(0, 1, (arg_215_1.time_ - var_218_3) / var_218_4)
				arg_215_1.mask_.color = var_218_5
			end

			if arg_215_1.time_ >= var_218_3 + var_218_4 and arg_215_1.time_ < var_218_3 + var_218_4 + arg_218_0 then
				local var_218_6 = Color.New(0, 0, 0)

				var_218_6.a = 1
				arg_215_1.mask_.color = var_218_6
			end

			local var_218_7 = 2

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= var_218_7 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_8 = 2

			if var_218_7 <= arg_215_1.time_ and arg_215_1.time_ < var_218_7 + var_218_8 then
				local var_218_9 = Color.New(0, 0, 0)

				var_218_9.a = Mathf.Lerp(1, 0, (arg_215_1.time_ - var_218_7) / var_218_8)
				arg_215_1.mask_.color = var_218_9
			end

			if arg_215_1.time_ >= var_218_7 + var_218_8 and arg_215_1.time_ < var_218_7 + var_218_8 + arg_218_0 then
				local var_218_10 = Color.New(0, 0, 0)

				arg_215_1.mask_.enabled = false
				var_218_10.a = 0
				arg_215_1.mask_.color = var_218_10
			end

			local var_218_11 = arg_215_1.actors_["1070ui_story"].transform

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= 4 + arg_218_0 then
				arg_215_1.var_.moveOldPos1070ui_story = var_218_11.localPosition
			end

			local var_218_12 = 0.001

			if 4 <= arg_215_1.time_ and arg_215_1.time_ < 4 + var_218_12 then
				var_218_11.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_215_1.time_ - 4) / var_218_12)
				var_218_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_11.position).x, (manager.ui.mainCamera.transform.position - var_218_11.position).y, (manager.ui.mainCamera.transform.position - var_218_11.position).z)
				var_218_11.localEulerAngles.z = 0
				var_218_11.localEulerAngles.x = 0
				var_218_11.localEulerAngles = var_218_11.localEulerAngles
			end

			if arg_215_1.time_ >= 4 + var_218_12 and arg_215_1.time_ < 4 + var_218_12 + arg_218_0 then
				var_218_11.localPosition = Vector3.New(0, -0.95, -6.05)
				var_218_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_11.position).x, (manager.ui.mainCamera.transform.position - var_218_11.position).y, (manager.ui.mainCamera.transform.position - var_218_11.position).z)
				var_218_11.localEulerAngles.z = 0
				var_218_11.localEulerAngles.x = 0
				var_218_11.localEulerAngles = var_218_11.localEulerAngles
			end

			local var_218_13 = arg_215_1.actors_["1070ui_story"]

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= 4 + arg_218_0 and not isNil(var_218_13) and arg_215_1.var_.characterEffect1070ui_story == nil then
				arg_215_1.var_.characterEffect1070ui_story = var_218_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_14 = 0.200000002980232

			if 4 <= arg_215_1.time_ and arg_215_1.time_ < 4 + var_218_14 and not isNil(var_218_13) then
				if arg_215_1.var_.characterEffect1070ui_story and not isNil(var_218_13) then
					arg_215_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 4 + var_218_14 and arg_215_1.time_ < 4 + var_218_14 + arg_218_0 and not isNil(var_218_13) and arg_215_1.var_.characterEffect1070ui_story then
				arg_215_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= 4 + arg_218_0 then
				arg_215_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= 4 + arg_218_0 then
				arg_215_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_16 = 4
			local var_218_17 = 0.75

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_16 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_18 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_18:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_19 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(910114052).content)

				arg_215_1.text_.text = var_218_19

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_21 = 30 <= 0 and var_218_17 or var_218_17 * (utf8.len(var_218_19) / 30)

				if (30 <= 0 and var_218_17 or var_218_17 * (utf8.len(var_218_19) / 30)) > 0 and var_218_17 < var_218_21 then
					arg_215_1.talkMaxDuration = var_218_21
					var_218_16 = var_218_16 + 0.3

					if var_218_21 + var_218_16 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_21 + var_218_16
					end
				end

				arg_215_1.text_.text = var_218_19
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_22 = var_218_16 + 0.3
			local var_218_23 = math.max(var_218_17, arg_215_1.talkMaxDuration)

			if var_218_16 + 0.3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_22 + var_218_23 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_22) / var_218_23

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_22 + var_218_23 and arg_215_1.time_ < var_218_22 + var_218_23 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play910114053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 910114053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play910114054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1070ui_story = arg_221_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1070ui_story"].transform.position).z)
				arg_221_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1070ui_story"].transform.localEulerAngles = arg_221_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1070ui_story"].transform.position).z)
				arg_221_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1070ui_story"].transform.localEulerAngles = arg_221_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_224_1 = 0
			local var_224_2 = 1.175

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(910114053).content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 47 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 47)

				if (47 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 47)) > 0 and var_224_2 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_1
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_6 = math.max(var_224_2, arg_221_1.talkMaxDuration)

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_6 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_1) / var_224_6

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_1 + var_224_6 and arg_221_1.time_ < var_224_1 + var_224_6 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play910114054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 910114054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play910114055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 1.075

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(910114054).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 43 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 43)

				if (43 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 43)) > 0 and var_228_0 < var_228_3 then
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
	Play910114055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 910114055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play910114056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1070ui_story = arg_229_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1070ui_story"].transform.position).z)
				arg_229_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1070ui_story"].transform.localEulerAngles = arg_229_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_229_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1070ui_story"].transform.position).z)
				arg_229_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1070ui_story"].transform.localEulerAngles = arg_229_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1070ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1070ui_story == nil then
				arg_229_1.var_.characterEffect1070ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1070ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1070ui_story then
				arg_229_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_232_4 = 0
			local var_232_5 = 0.925

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(910114055).content)

				arg_229_1.text_.text = var_232_6

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_8 = 37 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_6) / 37)

				if (37 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_6) / 37)) > 0 and var_232_5 < var_232_8 then
					arg_229_1.talkMaxDuration = var_232_8

					if var_232_8 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_6
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_9 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_9 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_9

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_9 and arg_229_1.time_ < var_232_4 + var_232_9 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play910114056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 910114056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play910114057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1070ui_story"]) and arg_233_1.var_.characterEffect1070ui_story == nil then
				arg_233_1.var_.characterEffect1070ui_story = arg_233_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1070ui_story"]) then
				if arg_233_1.var_.characterEffect1070ui_story and not isNil(arg_233_1.actors_["1070ui_story"]) then
					arg_233_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_0)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1070ui_story"]) and arg_233_1.var_.characterEffect1070ui_story then
				arg_233_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_236_1 = 0
			local var_236_2 = 0.1

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[627].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_3 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(910114056).content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 4 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 4)

				if (4 <= 0 and var_236_2 or var_236_2 * (utf8.len(var_236_3) / 4)) > 0 and var_236_2 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_1 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_1
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_6 = math.max(var_236_2, arg_233_1.talkMaxDuration)

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_6 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_1) / var_236_6

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_1 + var_236_6 and arg_233_1.time_ < var_236_1 + var_236_6 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play910114057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 910114057
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play910114058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 1.05

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, false)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(910114057).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 42 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 42)

				if (42 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 42)) > 0 and var_240_0 < var_240_3 then
					arg_237_1.talkMaxDuration = var_240_3

					if var_240_3 + 0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_3 + 0
					end
				end

				arg_237_1.text_.text = var_240_1
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_4 = math.max(var_240_0, arg_237_1.talkMaxDuration)

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - 0) / var_240_4

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play910114058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 910114058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play910114059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1070ui_story = arg_241_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1070ui_story"].transform.position).z)
				arg_241_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1070ui_story"].transform.localEulerAngles = arg_241_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_241_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1070ui_story"].transform.position).z)
				arg_241_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1070ui_story"].transform.localEulerAngles = arg_241_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1070ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1070ui_story == nil then
				arg_241_1.var_.characterEffect1070ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1070ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1070ui_story then
				arg_241_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_244_4 = 0
			local var_244_5 = 0.775

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
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

				local var_244_6 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(910114058).content)

				arg_241_1.text_.text = var_244_6

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_8 = 31 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_6) / 31)

				if (31 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_6) / 31)) > 0 and var_244_5 < var_244_8 then
					arg_241_1.talkMaxDuration = var_244_8

					if var_244_8 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_6
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_9 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_9 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_9

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_9 and arg_241_1.time_ < var_244_4 + var_244_9 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910114059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 910114059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play910114060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1070ui_story = arg_245_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1070ui_story"].transform.position).z)
				arg_245_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1070ui_story"].transform.localEulerAngles = arg_245_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1070ui_story"].transform.position).z)
				arg_245_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1070ui_story"].transform.localEulerAngles = arg_245_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_248_1 = 0
			local var_248_2 = 1.225

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(910114059).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 49 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 49)

				if (49 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 49)) > 0 and var_248_2 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_6 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_6 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_6

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_6 and arg_245_1.time_ < var_248_1 + var_248_6 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play910114060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 910114060
		arg_249_1.duration_ = 9

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play910114061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 2 < arg_249_1.time_ and arg_249_1.time_ <= 2 + arg_252_0 then
				local var_252_0 = arg_249_1.bgs_.ST53

				arg_249_1.bgs_.ST53.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_252_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_252_1 = var_252_0:GetComponent("SpriteRenderer")

				if var_252_1 and var_252_1.sprite then
					local var_252_2 = 2 * (var_252_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_252_0.transform.localScale = Vector3.New(var_252_2 / var_252_1.sprite.bounds.size.y < var_252_2 * manager.ui.mainCameraCom_.aspect / var_252_1.sprite.bounds.size.x and var_252_2 * manager.ui.mainCameraCom_.aspect / var_252_1.sprite.bounds.size.x or var_252_2 / var_252_1.sprite.bounds.size.y, var_252_2 / var_252_1.sprite.bounds.size.y < var_252_2 * manager.ui.mainCameraCom_.aspect / var_252_1.sprite.bounds.size.x and var_252_2 * manager.ui.mainCameraCom_.aspect / var_252_1.sprite.bounds.size.x or var_252_2 / var_252_1.sprite.bounds.size.y, 0)
				end

				for iter_252_0, iter_252_1 in pairs(arg_249_1.bgs_) do
					if iter_252_0 ~= "ST53" then
						iter_252_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_252_3 = 0

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_3 + arg_252_0 then
				arg_249_1.mask_.enabled = true
				arg_249_1.mask_.raycastTarget = true

				arg_249_1:SetGaussion(false)
			end

			local var_252_4 = 2

			if var_252_3 <= arg_249_1.time_ and arg_249_1.time_ < var_252_3 + var_252_4 then
				local var_252_5 = Color.New(0, 0, 0)

				var_252_5.a = Mathf.Lerp(0, 1, (arg_249_1.time_ - var_252_3) / var_252_4)
				arg_249_1.mask_.color = var_252_5
			end

			if arg_249_1.time_ >= var_252_3 + var_252_4 and arg_249_1.time_ < var_252_3 + var_252_4 + arg_252_0 then
				local var_252_6 = Color.New(0, 0, 0)

				var_252_6.a = 1
				arg_249_1.mask_.color = var_252_6
			end

			local var_252_7 = 2

			if 2 < arg_249_1.time_ and arg_249_1.time_ <= var_252_7 + arg_252_0 then
				arg_249_1.mask_.enabled = true
				arg_249_1.mask_.raycastTarget = true

				arg_249_1:SetGaussion(false)
			end

			local var_252_8 = 2

			if var_252_7 <= arg_249_1.time_ and arg_249_1.time_ < var_252_7 + var_252_8 then
				local var_252_9 = Color.New(0, 0, 0)

				var_252_9.a = Mathf.Lerp(1, 0, (arg_249_1.time_ - var_252_7) / var_252_8)
				arg_249_1.mask_.color = var_252_9
			end

			if arg_249_1.time_ >= var_252_7 + var_252_8 and arg_249_1.time_ < var_252_7 + var_252_8 + arg_252_0 then
				local var_252_10 = Color.New(0, 0, 0)

				arg_249_1.mask_.enabled = false
				var_252_10.a = 0
				arg_249_1.mask_.color = var_252_10
			end

			local var_252_11 = arg_249_1.actors_["1070ui_story"].transform

			if 2 < arg_249_1.time_ and arg_249_1.time_ <= 2 + arg_252_0 then
				arg_249_1.var_.moveOldPos1070ui_story = var_252_11.localPosition
			end

			local var_252_12 = 0.001

			if 2 <= arg_249_1.time_ and arg_249_1.time_ < 2 + var_252_12 then
				var_252_11.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_249_1.time_ - 2) / var_252_12)
				var_252_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_11.position).x, (manager.ui.mainCamera.transform.position - var_252_11.position).y, (manager.ui.mainCamera.transform.position - var_252_11.position).z)
				var_252_11.localEulerAngles.z = 0
				var_252_11.localEulerAngles.x = 0
				var_252_11.localEulerAngles = var_252_11.localEulerAngles
			end

			if arg_249_1.time_ >= 2 + var_252_12 and arg_249_1.time_ < 2 + var_252_12 + arg_252_0 then
				var_252_11.localPosition = Vector3.New(0, 100, 0)
				var_252_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_11.position).x, (manager.ui.mainCamera.transform.position - var_252_11.position).y, (manager.ui.mainCamera.transform.position - var_252_11.position).z)
				var_252_11.localEulerAngles.z = 0
				var_252_11.localEulerAngles.x = 0
				var_252_11.localEulerAngles = var_252_11.localEulerAngles
			end

			if arg_249_1.frameCnt_ <= 1 then
				arg_249_1.dialog_:SetActive(false)
			end

			local var_252_13 = 4
			local var_252_14 = 1.55

			if 4 < arg_249_1.time_ and arg_249_1.time_ <= var_252_13 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0

				arg_249_1.dialog_:SetActive(true)

				arg_249_1.dialogCg_.alpha = 0

				local var_252_15 = LeanTween.value(arg_249_1.dialog_, 0, 1, 0.3)

				var_252_15:setOnUpdate(LuaHelper.FloatAction(function(arg_253_0)
					arg_249_1.dialogCg_.alpha = arg_253_0
				end))
				var_252_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_249_1.dialog_)
					var_252_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_249_1.duration_ = arg_249_1.duration_ + 0.3

				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_16 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(910114060).content)

				arg_249_1.text_.text = var_252_16

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_18 = 62 <= 0 and var_252_14 or var_252_14 * (utf8.len(var_252_16) / 62)

				if (62 <= 0 and var_252_14 or var_252_14 * (utf8.len(var_252_16) / 62)) > 0 and var_252_14 < var_252_18 then
					arg_249_1.talkMaxDuration = var_252_18
					var_252_13 = var_252_13 + 0.3

					if var_252_18 + var_252_13 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_18 + var_252_13
					end
				end

				arg_249_1.text_.text = var_252_16
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_19 = var_252_13 + 0.3
			local var_252_20 = math.max(var_252_14, arg_249_1.talkMaxDuration)

			if var_252_13 + 0.3 <= arg_249_1.time_ and arg_249_1.time_ < var_252_19 + var_252_20 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_19) / var_252_20

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_19 + var_252_20 and arg_249_1.time_ < var_252_19 + var_252_20 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play910114061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 910114061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play910114062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1070ui_story = arg_255_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1070ui_story"].transform.position).z)
				arg_255_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1070ui_story"].transform.localEulerAngles = arg_255_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_255_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1070ui_story"].transform.position).z)
				arg_255_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1070ui_story"].transform.localEulerAngles = arg_255_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["1070ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1070ui_story == nil then
				arg_255_1.var_.characterEffect1070ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect1070ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1070ui_story then
				arg_255_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_258_4 = 0
			local var_258_5 = 0.825

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_6 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(910114061).content)

				arg_255_1.text_.text = var_258_6

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_8 = 33 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_6) / 33)

				if (33 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_6) / 33)) > 0 and var_258_5 < var_258_8 then
					arg_255_1.talkMaxDuration = var_258_8

					if var_258_8 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_4
					end
				end

				arg_255_1.text_.text = var_258_6
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_9 = math.max(var_258_5, arg_255_1.talkMaxDuration)

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_9 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_4) / var_258_9

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_4 + var_258_9 and arg_255_1.time_ < var_258_4 + var_258_9 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play910114062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 910114062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play910114063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["1070ui_story"]) and arg_259_1.var_.characterEffect1070ui_story == nil then
				arg_259_1.var_.characterEffect1070ui_story = arg_259_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_0 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["1070ui_story"]) then
				if arg_259_1.var_.characterEffect1070ui_story and not isNil(arg_259_1.actors_["1070ui_story"]) then
					arg_259_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_0)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["1070ui_story"]) and arg_259_1.var_.characterEffect1070ui_story then
				arg_259_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_262_1 = 0
			local var_262_2 = 0.075

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[627].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_3 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(910114062).content)

				arg_259_1.text_.text = var_262_3

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 3 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 3)

				if (3 <= 0 and var_262_2 or var_262_2 * (utf8.len(var_262_3) / 3)) > 0 and var_262_2 < var_262_5 then
					arg_259_1.talkMaxDuration = var_262_5

					if var_262_5 + var_262_1 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + var_262_1
					end
				end

				arg_259_1.text_.text = var_262_3
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_6 = math.max(var_262_2, arg_259_1.talkMaxDuration)

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_6 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_1) / var_262_6

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_1 + var_262_6 and arg_259_1.time_ < var_262_1 + var_262_6 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play910114063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 910114063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play910114064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.675

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(910114063).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 27 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 27)

				if (27 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 27)) > 0 and var_266_0 < var_266_3 then
					arg_263_1.talkMaxDuration = var_266_3

					if var_266_3 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_3 + 0
					end
				end

				arg_263_1.text_.text = var_266_1
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_4 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_4

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play910114064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 910114064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play910114065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1070ui_story = arg_267_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1070ui_story"].transform.position).z)
				arg_267_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1070ui_story"].transform.localEulerAngles = arg_267_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_267_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["1070ui_story"].transform.position).z)
				arg_267_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["1070ui_story"].transform.localEulerAngles = arg_267_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["1070ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1070ui_story == nil then
				arg_267_1.var_.characterEffect1070ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect1070ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect1070ui_story then
				arg_267_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_270_4 = 0
			local var_270_5 = 0.875

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_6 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(910114064).content)

				arg_267_1.text_.text = var_270_6

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_8 = 35 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_6) / 35)

				if (35 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_6) / 35)) > 0 and var_270_5 < var_270_8 then
					arg_267_1.talkMaxDuration = var_270_8

					if var_270_8 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_8 + var_270_4
					end
				end

				arg_267_1.text_.text = var_270_6
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_9 = math.max(var_270_5, arg_267_1.talkMaxDuration)

			if var_270_4 <= arg_267_1.time_ and arg_267_1.time_ < var_270_4 + var_270_9 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_4) / var_270_9

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_4 + var_270_9 and arg_267_1.time_ < var_270_4 + var_270_9 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play910114065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 910114065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play910114066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1070ui_story"]) and arg_271_1.var_.characterEffect1070ui_story == nil then
				arg_271_1.var_.characterEffect1070ui_story = arg_271_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_0 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1070ui_story"]) then
				if arg_271_1.var_.characterEffect1070ui_story and not isNil(arg_271_1.actors_["1070ui_story"]) then
					arg_271_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_0)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1070ui_story"]) and arg_271_1.var_.characterEffect1070ui_story then
				arg_271_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_274_1 = 0
			local var_274_2 = 0.1

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[627].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_3 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(910114065).content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 4 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 4)

				if (4 <= 0 and var_274_2 or var_274_2 * (utf8.len(var_274_3) / 4)) > 0 and var_274_2 < var_274_5 then
					arg_271_1.talkMaxDuration = var_274_5

					if var_274_5 + var_274_1 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + var_274_1
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_6 = math.max(var_274_2, arg_271_1.talkMaxDuration)

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_6 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_1) / var_274_6

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_1 + var_274_6 and arg_271_1.time_ < var_274_1 + var_274_6 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play910114066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 910114066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play910114067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1070ui_story = arg_275_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1070ui_story"].transform.position).z)
				arg_275_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1070ui_story"].transform.localEulerAngles = arg_275_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_275_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1070ui_story"].transform.position).z)
				arg_275_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1070ui_story"].transform.localEulerAngles = arg_275_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1070ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1070ui_story == nil then
				arg_275_1.var_.characterEffect1070ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1070ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1070ui_story then
				arg_275_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_278_4 = 0
			local var_278_5 = 0.15

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_6 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(910114066).content)

				arg_275_1.text_.text = var_278_6

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_8 = 6 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_6) / 6)

				if (6 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_6) / 6)) > 0 and var_278_5 < var_278_8 then
					arg_275_1.talkMaxDuration = var_278_8

					if var_278_8 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_6
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_9 = math.max(var_278_5, arg_275_1.talkMaxDuration)

			if var_278_4 <= arg_275_1.time_ and arg_275_1.time_ < var_278_4 + var_278_9 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_4) / var_278_9

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_4 + var_278_9 and arg_275_1.time_ < var_278_4 + var_278_9 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play910114067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 910114067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play910114068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1070ui_story"]) and arg_279_1.var_.characterEffect1070ui_story == nil then
				arg_279_1.var_.characterEffect1070ui_story = arg_279_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1070ui_story"]) then
				if arg_279_1.var_.characterEffect1070ui_story and not isNil(arg_279_1.actors_["1070ui_story"]) then
					arg_279_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1070ui_story"]) and arg_279_1.var_.characterEffect1070ui_story then
				arg_279_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 0.975

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(910114067).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 39 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 39)

				if (39 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 39)) > 0 and var_282_2 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_6 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_6 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_6

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_6 and arg_279_1.time_ < var_282_1 + var_282_6 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play910114068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 910114068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play910114069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["1070ui_story"]) and arg_283_1.var_.characterEffect1070ui_story == nil then
				arg_283_1.var_.characterEffect1070ui_story = arg_283_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_0 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["1070ui_story"]) then
				if arg_283_1.var_.characterEffect1070ui_story and not isNil(arg_283_1.actors_["1070ui_story"]) then
					arg_283_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["1070ui_story"]) and arg_283_1.var_.characterEffect1070ui_story then
				arg_283_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_286_2 = 0
			local var_286_3 = 0.9

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(910114068).content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_6 = 36 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 36)

				if (36 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_4) / 36)) > 0 and var_286_3 < var_286_6 then
					arg_283_1.talkMaxDuration = var_286_6

					if var_286_6 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_6 + var_286_2
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_3, arg_283_1.talkMaxDuration)

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_2) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_2 + var_286_7 and arg_283_1.time_ < var_286_2 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play910114069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 910114069
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play910114070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["1070ui_story"]) and arg_287_1.var_.characterEffect1070ui_story == nil then
				arg_287_1.var_.characterEffect1070ui_story = arg_287_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_0 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["1070ui_story"]) then
				if arg_287_1.var_.characterEffect1070ui_story and not isNil(arg_287_1.actors_["1070ui_story"]) then
					arg_287_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_0)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["1070ui_story"]) and arg_287_1.var_.characterEffect1070ui_story then
				arg_287_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_290_1 = 0
			local var_290_2 = 0.775

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_3 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(910114069).content)

				arg_287_1.text_.text = var_290_3

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 31 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 31)

				if (31 <= 0 and var_290_2 or var_290_2 * (utf8.len(var_290_3) / 31)) > 0 and var_290_2 < var_290_5 then
					arg_287_1.talkMaxDuration = var_290_5

					if var_290_5 + var_290_1 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + var_290_1
					end
				end

				arg_287_1.text_.text = var_290_3
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_6 = math.max(var_290_2, arg_287_1.talkMaxDuration)

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_6 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_1) / var_290_6

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_1 + var_290_6 and arg_287_1.time_ < var_290_1 + var_290_6 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play910114070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 910114070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play910114071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1070ui_story = arg_291_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1070ui_story"].transform.position).z)
				arg_291_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1070ui_story"].transform.localEulerAngles = arg_291_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_291_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1070ui_story"].transform.position).z)
				arg_291_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1070ui_story"].transform.localEulerAngles = arg_291_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_294_1 = arg_291_1.actors_["1070ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect1070ui_story == nil then
				arg_291_1.var_.characterEffect1070ui_story = var_294_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 and not isNil(var_294_1) then
				if arg_291_1.var_.characterEffect1070ui_story and not isNil(var_294_1) then
					arg_291_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect1070ui_story then
				arg_291_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_294_4 = 0
			local var_294_5 = 0.95

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_4 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_6 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(910114070).content)

				arg_291_1.text_.text = var_294_6

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_8 = 38 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_6) / 38)

				if (38 <= 0 and var_294_5 or var_294_5 * (utf8.len(var_294_6) / 38)) > 0 and var_294_5 < var_294_8 then
					arg_291_1.talkMaxDuration = var_294_8

					if var_294_8 + var_294_4 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_4
					end
				end

				arg_291_1.text_.text = var_294_6
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_9 = math.max(var_294_5, arg_291_1.talkMaxDuration)

			if var_294_4 <= arg_291_1.time_ and arg_291_1.time_ < var_294_4 + var_294_9 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_4) / var_294_9

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_4 + var_294_9 and arg_291_1.time_ < var_294_4 + var_294_9 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play910114071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 910114071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play910114072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.4

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(910114071).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 16 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 16)

				if (16 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 16)) > 0 and var_298_0 < var_298_3 then
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
	Play910114072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 910114072
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play910114073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1070ui_story"]) and arg_299_1.var_.characterEffect1070ui_story == nil then
				arg_299_1.var_.characterEffect1070ui_story = arg_299_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_0 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1070ui_story"]) then
				if arg_299_1.var_.characterEffect1070ui_story and not isNil(arg_299_1.actors_["1070ui_story"]) then
					arg_299_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_0)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1070ui_story"]) and arg_299_1.var_.characterEffect1070ui_story then
				arg_299_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_302_1 = 0
			local var_302_2 = 0.95

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_3 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(910114072).content)

				arg_299_1.text_.text = var_302_3

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 38 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 38)

				if (38 <= 0 and var_302_2 or var_302_2 * (utf8.len(var_302_3) / 38)) > 0 and var_302_2 < var_302_5 then
					arg_299_1.talkMaxDuration = var_302_5

					if var_302_5 + var_302_1 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + var_302_1
					end
				end

				arg_299_1.text_.text = var_302_3
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_6 = math.max(var_302_2, arg_299_1.talkMaxDuration)

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_6 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_1) / var_302_6

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_1 + var_302_6 and arg_299_1.time_ < var_302_1 + var_302_6 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play910114073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 910114073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play910114074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1070ui_story = arg_303_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1070ui_story"].transform.position).z)
				arg_303_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1070ui_story"].transform.localEulerAngles = arg_303_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_303_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1070ui_story"].transform.position).z)
				arg_303_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1070ui_story"].transform.localEulerAngles = arg_303_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["1070ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1070ui_story == nil then
				arg_303_1.var_.characterEffect1070ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect1070ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1070ui_story then
				arg_303_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_306_4 = 0
			local var_306_5 = 0.8

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_6 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(910114073).content)

				arg_303_1.text_.text = var_306_6

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_8 = 32 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_6) / 32)

				if (32 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_6) / 32)) > 0 and var_306_5 < var_306_8 then
					arg_303_1.talkMaxDuration = var_306_8

					if var_306_8 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_4
					end
				end

				arg_303_1.text_.text = var_306_6
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_9 = math.max(var_306_5, arg_303_1.talkMaxDuration)

			if var_306_4 <= arg_303_1.time_ and arg_303_1.time_ < var_306_4 + var_306_9 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_4) / var_306_9

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_4 + var_306_9 and arg_303_1.time_ < var_306_4 + var_306_9 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play910114074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 910114074
		arg_307_1.duration_ = 9

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play910114075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 2 < arg_307_1.time_ and arg_307_1.time_ <= 2 + arg_310_0 then
				local var_310_0 = arg_307_1.bgs_.ST32

				arg_307_1.bgs_.ST32.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_310_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_310_1 = var_310_0:GetComponent("SpriteRenderer")

				if var_310_1 and var_310_1.sprite then
					local var_310_2 = 2 * (var_310_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_310_0.transform.localScale = Vector3.New(var_310_2 / var_310_1.sprite.bounds.size.y < var_310_2 * manager.ui.mainCameraCom_.aspect / var_310_1.sprite.bounds.size.x and var_310_2 * manager.ui.mainCameraCom_.aspect / var_310_1.sprite.bounds.size.x or var_310_2 / var_310_1.sprite.bounds.size.y, var_310_2 / var_310_1.sprite.bounds.size.y < var_310_2 * manager.ui.mainCameraCom_.aspect / var_310_1.sprite.bounds.size.x and var_310_2 * manager.ui.mainCameraCom_.aspect / var_310_1.sprite.bounds.size.x or var_310_2 / var_310_1.sprite.bounds.size.y, 0)
				end

				for iter_310_0, iter_310_1 in pairs(arg_307_1.bgs_) do
					if iter_310_0 ~= "ST32" then
						iter_310_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_310_3 = 0

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_3 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_4 = 2

			if var_310_3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_3 + var_310_4 then
				local var_310_5 = Color.New(0, 0, 0)

				var_310_5.a = Mathf.Lerp(0, 1, (arg_307_1.time_ - var_310_3) / var_310_4)
				arg_307_1.mask_.color = var_310_5
			end

			if arg_307_1.time_ >= var_310_3 + var_310_4 and arg_307_1.time_ < var_310_3 + var_310_4 + arg_310_0 then
				local var_310_6 = Color.New(0, 0, 0)

				var_310_6.a = 1
				arg_307_1.mask_.color = var_310_6
			end

			local var_310_7 = 2

			if 2 < arg_307_1.time_ and arg_307_1.time_ <= var_310_7 + arg_310_0 then
				arg_307_1.mask_.enabled = true
				arg_307_1.mask_.raycastTarget = true

				arg_307_1:SetGaussion(false)
			end

			local var_310_8 = 2

			if var_310_7 <= arg_307_1.time_ and arg_307_1.time_ < var_310_7 + var_310_8 then
				local var_310_9 = Color.New(0, 0, 0)

				var_310_9.a = Mathf.Lerp(1, 0, (arg_307_1.time_ - var_310_7) / var_310_8)
				arg_307_1.mask_.color = var_310_9
			end

			if arg_307_1.time_ >= var_310_7 + var_310_8 and arg_307_1.time_ < var_310_7 + var_310_8 + arg_310_0 then
				local var_310_10 = Color.New(0, 0, 0)

				arg_307_1.mask_.enabled = false
				var_310_10.a = 0
				arg_307_1.mask_.color = var_310_10
			end

			local var_310_11 = arg_307_1.actors_["1070ui_story"].transform

			if 4 < arg_307_1.time_ and arg_307_1.time_ <= 4 + arg_310_0 then
				arg_307_1.var_.moveOldPos1070ui_story = var_310_11.localPosition
			end

			local var_310_12 = 0.001

			if 4 <= arg_307_1.time_ and arg_307_1.time_ < 4 + var_310_12 then
				var_310_11.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_307_1.time_ - 4) / var_310_12)
				var_310_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_11.position).x, (manager.ui.mainCamera.transform.position - var_310_11.position).y, (manager.ui.mainCamera.transform.position - var_310_11.position).z)
				var_310_11.localEulerAngles.z = 0
				var_310_11.localEulerAngles.x = 0
				var_310_11.localEulerAngles = var_310_11.localEulerAngles
			end

			if arg_307_1.time_ >= 4 + var_310_12 and arg_307_1.time_ < 4 + var_310_12 + arg_310_0 then
				var_310_11.localPosition = Vector3.New(0, -0.95, -6.05)
				var_310_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_11.position).x, (manager.ui.mainCamera.transform.position - var_310_11.position).y, (manager.ui.mainCamera.transform.position - var_310_11.position).z)
				var_310_11.localEulerAngles.z = 0
				var_310_11.localEulerAngles.x = 0
				var_310_11.localEulerAngles = var_310_11.localEulerAngles
			end

			local var_310_13 = arg_307_1.actors_["1070ui_story"]

			if 4 < arg_307_1.time_ and arg_307_1.time_ <= 4 + arg_310_0 and not isNil(var_310_13) and arg_307_1.var_.characterEffect1070ui_story == nil then
				arg_307_1.var_.characterEffect1070ui_story = var_310_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_14 = 0.200000002980232

			if 4 <= arg_307_1.time_ and arg_307_1.time_ < 4 + var_310_14 and not isNil(var_310_13) then
				if arg_307_1.var_.characterEffect1070ui_story and not isNil(var_310_13) then
					arg_307_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 4 + var_310_14 and arg_307_1.time_ < 4 + var_310_14 + arg_310_0 and not isNil(var_310_13) and arg_307_1.var_.characterEffect1070ui_story then
				arg_307_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 4 < arg_307_1.time_ and arg_307_1.time_ <= 4 + arg_310_0 then
				arg_307_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 4 < arg_307_1.time_ and arg_307_1.time_ <= 4 + arg_310_0 then
				arg_307_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_310_16 = arg_307_1.actors_["1070ui_story"].transform

			if 2 < arg_307_1.time_ and arg_307_1.time_ <= 2 + arg_310_0 then
				arg_307_1.var_.moveOldPos1070ui_story = var_310_16.localPosition
			end

			local var_310_17 = 0.001

			if 2 <= arg_307_1.time_ and arg_307_1.time_ < 2 + var_310_17 then
				var_310_16.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_307_1.time_ - 2) / var_310_17)
				var_310_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_16.position).x, (manager.ui.mainCamera.transform.position - var_310_16.position).y, (manager.ui.mainCamera.transform.position - var_310_16.position).z)
				var_310_16.localEulerAngles.z = 0
				var_310_16.localEulerAngles.x = 0
				var_310_16.localEulerAngles = var_310_16.localEulerAngles
			end

			if arg_307_1.time_ >= 2 + var_310_17 and arg_307_1.time_ < 2 + var_310_17 + arg_310_0 then
				var_310_16.localPosition = Vector3.New(0, 100, 0)
				var_310_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_16.position).x, (manager.ui.mainCamera.transform.position - var_310_16.position).y, (manager.ui.mainCamera.transform.position - var_310_16.position).z)
				var_310_16.localEulerAngles.z = 0
				var_310_16.localEulerAngles.x = 0
				var_310_16.localEulerAngles = var_310_16.localEulerAngles
			end

			if arg_307_1.frameCnt_ <= 1 then
				arg_307_1.dialog_:SetActive(false)
			end

			local var_310_18 = 4
			local var_310_19 = 1.025

			if 4 < arg_307_1.time_ and arg_307_1.time_ <= var_310_18 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0

				arg_307_1.dialog_:SetActive(true)

				arg_307_1.dialogCg_.alpha = 0

				local var_310_20 = LeanTween.value(arg_307_1.dialog_, 0, 1, 0.3)

				var_310_20:setOnUpdate(LuaHelper.FloatAction(function(arg_311_0)
					arg_307_1.dialogCg_.alpha = arg_311_0
				end))
				var_310_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_307_1.dialog_)
					var_310_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_307_1.duration_ = arg_307_1.duration_ + 0.3

				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_21 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(910114074).content)

				arg_307_1.text_.text = var_310_21

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_23 = 41 <= 0 and var_310_19 or var_310_19 * (utf8.len(var_310_21) / 41)

				if (41 <= 0 and var_310_19 or var_310_19 * (utf8.len(var_310_21) / 41)) > 0 and var_310_19 < var_310_23 then
					arg_307_1.talkMaxDuration = var_310_23
					var_310_18 = var_310_18 + 0.3

					if var_310_23 + var_310_18 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_23 + var_310_18
					end
				end

				arg_307_1.text_.text = var_310_21
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_24 = var_310_18 + 0.3
			local var_310_25 = math.max(var_310_19, arg_307_1.talkMaxDuration)

			if var_310_18 + 0.3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_24 + var_310_25 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_24) / var_310_25

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_24 + var_310_25 and arg_307_1.time_ < var_310_24 + var_310_25 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play910114075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 910114075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play910114076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1070ui_story"]) and arg_313_1.var_.characterEffect1070ui_story == nil then
				arg_313_1.var_.characterEffect1070ui_story = arg_313_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1070ui_story"]) then
				if arg_313_1.var_.characterEffect1070ui_story and not isNil(arg_313_1.actors_["1070ui_story"]) then
					arg_313_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1070ui_story"]) and arg_313_1.var_.characterEffect1070ui_story then
				arg_313_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.75

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(910114075).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 30 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 30)

				if (30 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 30)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play910114076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 910114076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play910114077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1070ui_story = arg_317_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1070ui_story"].transform.position).z)
				arg_317_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1070ui_story"].transform.localEulerAngles = arg_317_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_317_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1070ui_story"].transform.position).z)
				arg_317_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1070ui_story"].transform.localEulerAngles = arg_317_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1070ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1070ui_story == nil then
				arg_317_1.var_.characterEffect1070ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1070ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_2)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1070ui_story then
				arg_317_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_320_3 = arg_317_1.actors_["1074ui_story"].transform

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1074ui_story = var_320_3.localPosition
			end

			local var_320_4 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				var_320_3.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_317_1.time_ - 0) / var_320_4)
				var_320_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_3.position).x, (manager.ui.mainCamera.transform.position - var_320_3.position).y, (manager.ui.mainCamera.transform.position - var_320_3.position).z)
				var_320_3.localEulerAngles.z = 0
				var_320_3.localEulerAngles.x = 0
				var_320_3.localEulerAngles = var_320_3.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				var_320_3.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_320_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_320_3.position).x, (manager.ui.mainCamera.transform.position - var_320_3.position).y, (manager.ui.mainCamera.transform.position - var_320_3.position).z)
				var_320_3.localEulerAngles.z = 0
				var_320_3.localEulerAngles.x = 0
				var_320_3.localEulerAngles = var_320_3.localEulerAngles
			end

			local var_320_5 = arg_317_1.actors_["1074ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.characterEffect1074ui_story == nil then
				arg_317_1.var_.characterEffect1074ui_story = var_320_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_6 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_6 and not isNil(var_320_5) then
				if arg_317_1.var_.characterEffect1074ui_story and not isNil(var_320_5) then
					arg_317_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_6 and arg_317_1.time_ < 0 + var_320_6 + arg_320_0 and not isNil(var_320_5) and arg_317_1.var_.characterEffect1074ui_story then
				arg_317_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_320_8 = 0
			local var_320_9 = 0.05

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_8 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_10 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(910114076).content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_12 = 2 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_10) / 2)

				if (2 <= 0 and var_320_9 or var_320_9 * (utf8.len(var_320_10) / 2)) > 0 and var_320_9 < var_320_12 then
					arg_317_1.talkMaxDuration = var_320_12

					if var_320_12 + var_320_8 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_12 + var_320_8
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_13 = math.max(var_320_9, arg_317_1.talkMaxDuration)

			if var_320_8 <= arg_317_1.time_ and arg_317_1.time_ < var_320_8 + var_320_13 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_8) / var_320_13

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_8 + var_320_13 and arg_317_1.time_ < var_320_8 + var_320_13 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play910114077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 910114077
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play910114078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["1074ui_story"]) and arg_321_1.var_.characterEffect1074ui_story == nil then
				arg_321_1.var_.characterEffect1074ui_story = arg_321_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["1074ui_story"]) then
				if arg_321_1.var_.characterEffect1074ui_story and not isNil(arg_321_1.actors_["1074ui_story"]) then
					arg_321_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_0)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["1074ui_story"]) and arg_321_1.var_.characterEffect1074ui_story then
				arg_321_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_324_1 = 0
			local var_324_2 = 0.725

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(910114077).content)

				arg_321_1.text_.text = var_324_3

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 29 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 29)

				if (29 <= 0 and var_324_2 or var_324_2 * (utf8.len(var_324_3) / 29)) > 0 and var_324_2 < var_324_5 then
					arg_321_1.talkMaxDuration = var_324_5

					if var_324_5 + var_324_1 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + var_324_1
					end
				end

				arg_321_1.text_.text = var_324_3
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_6 = math.max(var_324_2, arg_321_1.talkMaxDuration)

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_6 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_1) / var_324_6

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_1 + var_324_6 and arg_321_1.time_ < var_324_1 + var_324_6 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play910114078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 910114078
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play910114079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1072ui_story = arg_325_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1072ui_story"].transform.position).z)
				arg_325_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1072ui_story"].transform.localEulerAngles = arg_325_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_325_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1072ui_story"].transform.position).z)
				arg_325_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1072ui_story"].transform.localEulerAngles = arg_325_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1072ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1072ui_story == nil then
				arg_325_1.var_.characterEffect1072ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1072ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1072ui_story then
				arg_325_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_328_4 = arg_325_1.actors_["1070ui_story"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1070ui_story = var_328_4.localPosition
			end

			local var_328_5 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_5 then
				var_328_4.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_325_1.time_ - 0) / var_328_5)
				var_328_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_4.position).x, (manager.ui.mainCamera.transform.position - var_328_4.position).y, (manager.ui.mainCamera.transform.position - var_328_4.position).z)
				var_328_4.localEulerAngles.z = 0
				var_328_4.localEulerAngles.x = 0
				var_328_4.localEulerAngles = var_328_4.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_5 and arg_325_1.time_ < 0 + var_328_5 + arg_328_0 then
				var_328_4.localPosition = Vector3.New(0, 100, 0)
				var_328_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_4.position).x, (manager.ui.mainCamera.transform.position - var_328_4.position).y, (manager.ui.mainCamera.transform.position - var_328_4.position).z)
				var_328_4.localEulerAngles.z = 0
				var_328_4.localEulerAngles.x = 0
				var_328_4.localEulerAngles = var_328_4.localEulerAngles
			end

			local var_328_6 = arg_325_1.actors_["1070ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_6) and arg_325_1.var_.characterEffect1070ui_story == nil then
				arg_325_1.var_.characterEffect1070ui_story = var_328_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_7 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 and not isNil(var_328_6) then
				if arg_325_1.var_.characterEffect1070ui_story and not isNil(var_328_6) then
					arg_325_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_7)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 and not isNil(var_328_6) and arg_325_1.var_.characterEffect1070ui_story then
				arg_325_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_328_8 = arg_325_1.actors_["1074ui_story"].transform

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1074ui_story = var_328_8.localPosition
			end

			local var_328_9 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_9 then
				var_328_8.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_325_1.time_ - 0) / var_328_9)
				var_328_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_8.position).x, (manager.ui.mainCamera.transform.position - var_328_8.position).y, (manager.ui.mainCamera.transform.position - var_328_8.position).z)
				var_328_8.localEulerAngles.z = 0
				var_328_8.localEulerAngles.x = 0
				var_328_8.localEulerAngles = var_328_8.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_9 and arg_325_1.time_ < 0 + var_328_9 + arg_328_0 then
				var_328_8.localPosition = Vector3.New(0, 100, 0)
				var_328_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_328_8.position).x, (manager.ui.mainCamera.transform.position - var_328_8.position).y, (manager.ui.mainCamera.transform.position - var_328_8.position).z)
				var_328_8.localEulerAngles.z = 0
				var_328_8.localEulerAngles.x = 0
				var_328_8.localEulerAngles = var_328_8.localEulerAngles
			end

			local var_328_10 = arg_325_1.actors_["1074ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_10) and arg_325_1.var_.characterEffect1074ui_story == nil then
				arg_325_1.var_.characterEffect1074ui_story = var_328_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_11 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_11 and not isNil(var_328_10) then
				if arg_325_1.var_.characterEffect1074ui_story and not isNil(var_328_10) then
					arg_325_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_11)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_11 and arg_325_1.time_ < 0 + var_328_11 + arg_328_0 and not isNil(var_328_10) and arg_325_1.var_.characterEffect1074ui_story then
				arg_325_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_328_12 = 0
			local var_328_13 = 0.5

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_12 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_14 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(910114078).content)

				arg_325_1.text_.text = var_328_14

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_16 = 20 <= 0 and var_328_13 or var_328_13 * (utf8.len(var_328_14) / 20)

				if (20 <= 0 and var_328_13 or var_328_13 * (utf8.len(var_328_14) / 20)) > 0 and var_328_13 < var_328_16 then
					arg_325_1.talkMaxDuration = var_328_16

					if var_328_16 + var_328_12 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_16 + var_328_12
					end
				end

				arg_325_1.text_.text = var_328_14
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_17 = math.max(var_328_13, arg_325_1.talkMaxDuration)

			if var_328_12 <= arg_325_1.time_ and arg_325_1.time_ < var_328_12 + var_328_17 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_12) / var_328_17

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_12 + var_328_17 and arg_325_1.time_ < var_328_12 + var_328_17 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play910114079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 910114079
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play910114080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1072ui_story = arg_329_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1072ui_story"].transform.position).z)
				arg_329_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1072ui_story"].transform.localEulerAngles = arg_329_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_329_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1072ui_story"].transform.position).z)
				arg_329_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1072ui_story"].transform.localEulerAngles = arg_329_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1072ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1072ui_story == nil then
				arg_329_1.var_.characterEffect1072ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect1072ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_2)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1072ui_story then
				arg_329_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_332_3 = arg_329_1.actors_["1074ui_story"].transform

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1074ui_story = var_332_3.localPosition
			end

			local var_332_4 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				var_332_3.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_329_1.time_ - 0) / var_332_4)
				var_332_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_3.position).x, (manager.ui.mainCamera.transform.position - var_332_3.position).y, (manager.ui.mainCamera.transform.position - var_332_3.position).z)
				var_332_3.localEulerAngles.z = 0
				var_332_3.localEulerAngles.x = 0
				var_332_3.localEulerAngles = var_332_3.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				var_332_3.localPosition = Vector3.New(0, -1.055, -6.12)
				var_332_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_332_3.position).x, (manager.ui.mainCamera.transform.position - var_332_3.position).y, (manager.ui.mainCamera.transform.position - var_332_3.position).z)
				var_332_3.localEulerAngles.z = 0
				var_332_3.localEulerAngles.x = 0
				var_332_3.localEulerAngles = var_332_3.localEulerAngles
			end

			local var_332_5 = arg_329_1.actors_["1074ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_5) and arg_329_1.var_.characterEffect1074ui_story == nil then
				arg_329_1.var_.characterEffect1074ui_story = var_332_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_6 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_6 and not isNil(var_332_5) then
				if arg_329_1.var_.characterEffect1074ui_story and not isNil(var_332_5) then
					arg_329_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_6 and arg_329_1.time_ < 0 + var_332_6 + arg_332_0 and not isNil(var_332_5) and arg_329_1.var_.characterEffect1074ui_story then
				arg_329_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_332_8 = 0
			local var_332_9 = 0.175

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_10 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(910114079).content)

				arg_329_1.text_.text = var_332_10

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_12 = 7 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_10) / 7)

				if (7 <= 0 and var_332_9 or var_332_9 * (utf8.len(var_332_10) / 7)) > 0 and var_332_9 < var_332_12 then
					arg_329_1.talkMaxDuration = var_332_12

					if var_332_12 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_12 + var_332_8
					end
				end

				arg_329_1.text_.text = var_332_10
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_13 = math.max(var_332_9, arg_329_1.talkMaxDuration)

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_13 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_8) / var_332_13

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_8 + var_332_13 and arg_329_1.time_ < var_332_8 + var_332_13 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play910114080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 910114080
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play910114081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1072ui_story = arg_333_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1072ui_story, Vector3.New(-0.7, -0.71, -6), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1072ui_story"].transform.position).z)
				arg_333_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1072ui_story"].transform.localEulerAngles = arg_333_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_333_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1072ui_story"].transform.position).z)
				arg_333_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1072ui_story"].transform.localEulerAngles = arg_333_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_336_1 = arg_333_1.actors_["1072ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1072ui_story == nil then
				arg_333_1.var_.characterEffect1072ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect1072ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1072ui_story then
				arg_333_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_336_4 = arg_333_1.actors_["1074ui_story"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1074ui_story = var_336_4.localPosition
			end

			local var_336_5 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_5 then
				var_336_4.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_333_1.time_ - 0) / var_336_5)
				var_336_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_4.position).x, (manager.ui.mainCamera.transform.position - var_336_4.position).y, (manager.ui.mainCamera.transform.position - var_336_4.position).z)
				var_336_4.localEulerAngles.z = 0
				var_336_4.localEulerAngles.x = 0
				var_336_4.localEulerAngles = var_336_4.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_5 and arg_333_1.time_ < 0 + var_336_5 + arg_336_0 then
				var_336_4.localPosition = Vector3.New(0, 100, 0)
				var_336_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_4.position).x, (manager.ui.mainCamera.transform.position - var_336_4.position).y, (manager.ui.mainCamera.transform.position - var_336_4.position).z)
				var_336_4.localEulerAngles.z = 0
				var_336_4.localEulerAngles.x = 0
				var_336_4.localEulerAngles = var_336_4.localEulerAngles
			end

			local var_336_6 = arg_333_1.actors_["1074ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_6) and arg_333_1.var_.characterEffect1074ui_story == nil then
				arg_333_1.var_.characterEffect1074ui_story = var_336_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_7 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 and not isNil(var_336_6) then
				if arg_333_1.var_.characterEffect1074ui_story and not isNil(var_336_6) then
					arg_333_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_7)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 and not isNil(var_336_6) and arg_333_1.var_.characterEffect1074ui_story then
				arg_333_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_336_8 = arg_333_1.actors_["1070ui_story"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1070ui_story = var_336_8.localPosition
			end

			local var_336_9 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_9 then
				var_336_8.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_333_1.time_ - 0) / var_336_9)
				var_336_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_8.position).x, (manager.ui.mainCamera.transform.position - var_336_8.position).y, (manager.ui.mainCamera.transform.position - var_336_8.position).z)
				var_336_8.localEulerAngles.z = 0
				var_336_8.localEulerAngles.x = 0
				var_336_8.localEulerAngles = var_336_8.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_9 and arg_333_1.time_ < 0 + var_336_9 + arg_336_0 then
				var_336_8.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_336_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_336_8.position).x, (manager.ui.mainCamera.transform.position - var_336_8.position).y, (manager.ui.mainCamera.transform.position - var_336_8.position).z)
				var_336_8.localEulerAngles.z = 0
				var_336_8.localEulerAngles.x = 0
				var_336_8.localEulerAngles = var_336_8.localEulerAngles
			end

			local var_336_10 = arg_333_1.actors_["1070ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_10) and arg_333_1.var_.characterEffect1070ui_story == nil then
				arg_333_1.var_.characterEffect1070ui_story = var_336_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_11 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_11 and not isNil(var_336_10) then
				if arg_333_1.var_.characterEffect1070ui_story and not isNil(var_336_10) then
					arg_333_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_11)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_11 and arg_333_1.time_ < 0 + var_336_11 + arg_336_0 and not isNil(var_336_10) and arg_333_1.var_.characterEffect1070ui_story then
				arg_333_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_336_12 = 0
			local var_336_13 = 0.45

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_12 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_14 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(910114080).content)

				arg_333_1.text_.text = var_336_14

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_16 = 18 <= 0 and var_336_13 or var_336_13 * (utf8.len(var_336_14) / 18)

				if (18 <= 0 and var_336_13 or var_336_13 * (utf8.len(var_336_14) / 18)) > 0 and var_336_13 < var_336_16 then
					arg_333_1.talkMaxDuration = var_336_16

					if var_336_16 + var_336_12 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_16 + var_336_12
					end
				end

				arg_333_1.text_.text = var_336_14
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_17 = math.max(var_336_13, arg_333_1.talkMaxDuration)

			if var_336_12 <= arg_333_1.time_ and arg_333_1.time_ < var_336_12 + var_336_17 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_12) / var_336_17

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_12 + var_336_17 and arg_333_1.time_ < var_336_12 + var_336_17 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play910114081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 910114081
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play910114082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos1070ui_story = arg_337_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_340_0 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 then
				arg_337_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_337_1.time_ - 0) / var_340_0)
				arg_337_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1070ui_story"].transform.position).z)
				arg_337_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1070ui_story"].transform.localEulerAngles = arg_337_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 then
				arg_337_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_337_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_337_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_337_1.actors_["1070ui_story"].transform.position).z)
				arg_337_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_337_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_337_1.actors_["1070ui_story"].transform.localEulerAngles = arg_337_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_340_1 = arg_337_1.actors_["1070ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1070ui_story == nil then
				arg_337_1.var_.characterEffect1070ui_story = var_340_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_2 and not isNil(var_340_1) then
				if arg_337_1.var_.characterEffect1070ui_story and not isNil(var_340_1) then
					arg_337_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_2 and arg_337_1.time_ < 0 + var_340_2 + arg_340_0 and not isNil(var_340_1) and arg_337_1.var_.characterEffect1070ui_story then
				arg_337_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_340_4 = arg_337_1.actors_["1072ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_4) and arg_337_1.var_.characterEffect1072ui_story == nil then
				arg_337_1.var_.characterEffect1072ui_story = var_340_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_5 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_5 and not isNil(var_340_4) then
				if arg_337_1.var_.characterEffect1072ui_story and not isNil(var_340_4) then
					arg_337_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_5)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_5 and arg_337_1.time_ < 0 + var_340_5 + arg_340_0 and not isNil(var_340_4) and arg_337_1.var_.characterEffect1072ui_story then
				arg_337_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_340_6 = 0
			local var_340_7 = 0.775

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
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

				local var_340_8 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(910114081).content)

				arg_337_1.text_.text = var_340_8

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_10 = 31 <= 0 and var_340_7 or var_340_7 * (utf8.len(var_340_8) / 31)

				if (31 <= 0 and var_340_7 or var_340_7 * (utf8.len(var_340_8) / 31)) > 0 and var_340_7 < var_340_10 then
					arg_337_1.talkMaxDuration = var_340_10

					if var_340_10 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_8
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_11 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_11 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_11

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_11 and arg_337_1.time_ < var_340_6 + var_340_11 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910114082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 910114082
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play910114083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1074ui_story = arg_341_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1074ui_story"].transform.position).z)
				arg_341_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1074ui_story"].transform.localEulerAngles = arg_341_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.12)
				arg_341_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1074ui_story"].transform.position).z)
				arg_341_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1074ui_story"].transform.localEulerAngles = arg_341_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1074ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1074ui_story == nil then
				arg_341_1.var_.characterEffect1074ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1074ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1074ui_story then
				arg_341_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_344_4 = arg_341_1.actors_["1072ui_story"].transform

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1072ui_story = var_344_4.localPosition
			end

			local var_344_5 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_5 then
				var_344_4.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_341_1.time_ - 0) / var_344_5)
				var_344_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_4.position).x, (manager.ui.mainCamera.transform.position - var_344_4.position).y, (manager.ui.mainCamera.transform.position - var_344_4.position).z)
				var_344_4.localEulerAngles.z = 0
				var_344_4.localEulerAngles.x = 0
				var_344_4.localEulerAngles = var_344_4.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_5 and arg_341_1.time_ < 0 + var_344_5 + arg_344_0 then
				var_344_4.localPosition = Vector3.New(0, 100, 0)
				var_344_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_4.position).x, (manager.ui.mainCamera.transform.position - var_344_4.position).y, (manager.ui.mainCamera.transform.position - var_344_4.position).z)
				var_344_4.localEulerAngles.z = 0
				var_344_4.localEulerAngles.x = 0
				var_344_4.localEulerAngles = var_344_4.localEulerAngles
			end

			local var_344_6 = arg_341_1.actors_["1072ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_6) and arg_341_1.var_.characterEffect1072ui_story == nil then
				arg_341_1.var_.characterEffect1072ui_story = var_344_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_7 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_7 and not isNil(var_344_6) then
				if arg_341_1.var_.characterEffect1072ui_story and not isNil(var_344_6) then
					arg_341_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_7)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_7 and arg_341_1.time_ < 0 + var_344_7 + arg_344_0 and not isNil(var_344_6) and arg_341_1.var_.characterEffect1072ui_story then
				arg_341_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_344_8 = arg_341_1.actors_["1070ui_story"].transform

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1070ui_story = var_344_8.localPosition
			end

			local var_344_9 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_9 then
				var_344_8.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_341_1.time_ - 0) / var_344_9)
				var_344_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_8.position).x, (manager.ui.mainCamera.transform.position - var_344_8.position).y, (manager.ui.mainCamera.transform.position - var_344_8.position).z)
				var_344_8.localEulerAngles.z = 0
				var_344_8.localEulerAngles.x = 0
				var_344_8.localEulerAngles = var_344_8.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_9 and arg_341_1.time_ < 0 + var_344_9 + arg_344_0 then
				var_344_8.localPosition = Vector3.New(0, 100, 0)
				var_344_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_8.position).x, (manager.ui.mainCamera.transform.position - var_344_8.position).y, (manager.ui.mainCamera.transform.position - var_344_8.position).z)
				var_344_8.localEulerAngles.z = 0
				var_344_8.localEulerAngles.x = 0
				var_344_8.localEulerAngles = var_344_8.localEulerAngles
			end

			local var_344_10 = arg_341_1.actors_["1070ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_10) and arg_341_1.var_.characterEffect1070ui_story == nil then
				arg_341_1.var_.characterEffect1070ui_story = var_344_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_11 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_11 and not isNil(var_344_10) then
				if arg_341_1.var_.characterEffect1070ui_story and not isNil(var_344_10) then
					arg_341_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_11)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_11 and arg_341_1.time_ < 0 + var_344_11 + arg_344_0 and not isNil(var_344_10) and arg_341_1.var_.characterEffect1070ui_story then
				arg_341_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_344_12 = 0
			local var_344_13 = 0.3

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_12 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_14 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(910114082).content)

				arg_341_1.text_.text = var_344_14

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_16 = 12 <= 0 and var_344_13 or var_344_13 * (utf8.len(var_344_14) / 12)

				if (12 <= 0 and var_344_13 or var_344_13 * (utf8.len(var_344_14) / 12)) > 0 and var_344_13 < var_344_16 then
					arg_341_1.talkMaxDuration = var_344_16

					if var_344_16 + var_344_12 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_16 + var_344_12
					end
				end

				arg_341_1.text_.text = var_344_14
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_17 = math.max(var_344_13, arg_341_1.talkMaxDuration)

			if var_344_12 <= arg_341_1.time_ and arg_341_1.time_ < var_344_12 + var_344_17 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_12) / var_344_17

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_12 + var_344_17 and arg_341_1.time_ < var_344_12 + var_344_17 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play910114083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 910114083
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play910114084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1070ui_story = arg_345_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1070ui_story"].transform.position).z)
				arg_345_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1070ui_story"].transform.localEulerAngles = arg_345_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_345_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1070ui_story"].transform.position).z)
				arg_345_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1070ui_story"].transform.localEulerAngles = arg_345_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["1070ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1070ui_story == nil then
				arg_345_1.var_.characterEffect1070ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect1070ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1070ui_story then
				arg_345_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_348_4 = arg_345_1.actors_["1074ui_story"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1074ui_story = var_348_4.localPosition
			end

			local var_348_5 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_5 then
				var_348_4.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_345_1.time_ - 0) / var_348_5)
				var_348_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_4.position).x, (manager.ui.mainCamera.transform.position - var_348_4.position).y, (manager.ui.mainCamera.transform.position - var_348_4.position).z)
				var_348_4.localEulerAngles.z = 0
				var_348_4.localEulerAngles.x = 0
				var_348_4.localEulerAngles = var_348_4.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_5 and arg_345_1.time_ < 0 + var_348_5 + arg_348_0 then
				var_348_4.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_348_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_348_4.position).x, (manager.ui.mainCamera.transform.position - var_348_4.position).y, (manager.ui.mainCamera.transform.position - var_348_4.position).z)
				var_348_4.localEulerAngles.z = 0
				var_348_4.localEulerAngles.x = 0
				var_348_4.localEulerAngles = var_348_4.localEulerAngles
			end

			local var_348_6 = arg_345_1.actors_["1074ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_6) and arg_345_1.var_.characterEffect1074ui_story == nil then
				arg_345_1.var_.characterEffect1074ui_story = var_348_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_7 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 and not isNil(var_348_6) then
				if arg_345_1.var_.characterEffect1074ui_story and not isNil(var_348_6) then
					arg_345_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_7)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 and not isNil(var_348_6) and arg_345_1.var_.characterEffect1074ui_story then
				arg_345_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_348_8 = 0
			local var_348_9 = 0.65

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
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

				local var_348_10 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(910114083).content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_12 = 26 <= 0 and var_348_9 or var_348_9 * (utf8.len(var_348_10) / 26)

				if (26 <= 0 and var_348_9 or var_348_9 * (utf8.len(var_348_10) / 26)) > 0 and var_348_9 < var_348_12 then
					arg_345_1.talkMaxDuration = var_348_12

					if var_348_12 + var_348_8 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_12 + var_348_8
					end
				end

				arg_345_1.text_.text = var_348_10
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_13 = math.max(var_348_9, arg_345_1.talkMaxDuration)

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_13 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_8) / var_348_13

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_8 + var_348_13 and arg_345_1.time_ < var_348_8 + var_348_13 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play910114084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 910114084
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play910114085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1074ui_story = arg_349_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1074ui_story"].transform.position).z)
				arg_349_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1074ui_story"].transform.localEulerAngles = arg_349_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_349_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1074ui_story"].transform.position).z)
				arg_349_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1074ui_story"].transform.localEulerAngles = arg_349_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["1074ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1074ui_story == nil then
				arg_349_1.var_.characterEffect1074ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect1074ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1074ui_story then
				arg_349_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_352_4 = arg_349_1.actors_["1070ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_4) and arg_349_1.var_.characterEffect1070ui_story == nil then
				arg_349_1.var_.characterEffect1070ui_story = var_352_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_5 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_5 and not isNil(var_352_4) then
				if arg_349_1.var_.characterEffect1070ui_story and not isNil(var_352_4) then
					arg_349_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_5)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_5 and arg_349_1.time_ < 0 + var_352_5 + arg_352_0 and not isNil(var_352_4) and arg_349_1.var_.characterEffect1070ui_story then
				arg_349_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_352_6 = 0
			local var_352_7 = 0.225

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_8 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(910114084).content)

				arg_349_1.text_.text = var_352_8

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_10 = 9 <= 0 and var_352_7 or var_352_7 * (utf8.len(var_352_8) / 9)

				if (9 <= 0 and var_352_7 or var_352_7 * (utf8.len(var_352_8) / 9)) > 0 and var_352_7 < var_352_10 then
					arg_349_1.talkMaxDuration = var_352_10

					if var_352_10 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_8
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_11 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_11 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_11

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_11 and arg_349_1.time_ < var_352_6 + var_352_11 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play910114085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 910114085
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play910114086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1070ui_story = arg_353_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1070ui_story"].transform.position).z)
				arg_353_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1070ui_story"].transform.localEulerAngles = arg_353_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_353_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1070ui_story"].transform.position).z)
				arg_353_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1070ui_story"].transform.localEulerAngles = arg_353_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1070ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1070ui_story == nil then
				arg_353_1.var_.characterEffect1070ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1070ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1070ui_story then
				arg_353_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_2")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_356_4 = arg_353_1.actors_["1074ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_4) and arg_353_1.var_.characterEffect1074ui_story == nil then
				arg_353_1.var_.characterEffect1074ui_story = var_356_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_5 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_5 and not isNil(var_356_4) then
				if arg_353_1.var_.characterEffect1074ui_story and not isNil(var_356_4) then
					arg_353_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_5)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_5 and arg_353_1.time_ < 0 + var_356_5 + arg_356_0 and not isNil(var_356_4) and arg_353_1.var_.characterEffect1074ui_story then
				arg_353_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_356_6 = 0
			local var_356_7 = 0.625

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_6 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_8 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(910114085).content)

				arg_353_1.text_.text = var_356_8

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_10 = 25 <= 0 and var_356_7 or var_356_7 * (utf8.len(var_356_8) / 25)

				if (25 <= 0 and var_356_7 or var_356_7 * (utf8.len(var_356_8) / 25)) > 0 and var_356_7 < var_356_10 then
					arg_353_1.talkMaxDuration = var_356_10

					if var_356_10 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_6
					end
				end

				arg_353_1.text_.text = var_356_8
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_11 = math.max(var_356_7, arg_353_1.talkMaxDuration)

			if var_356_6 <= arg_353_1.time_ and arg_353_1.time_ < var_356_6 + var_356_11 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_6) / var_356_11

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_6 + var_356_11 and arg_353_1.time_ < var_356_6 + var_356_11 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play910114086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 910114086
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play910114087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 1.075

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
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

				local var_360_1 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(910114086).content)

				arg_357_1.text_.text = var_360_1

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_3 = 43 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 43)

				if (43 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 43)) > 0 and var_360_0 < var_360_3 then
					arg_357_1.talkMaxDuration = var_360_3

					if var_360_3 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_3 + 0
					end
				end

				arg_357_1.text_.text = var_360_1
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_4 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_4

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play910114087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 910114087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play910114088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 1.05

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_1 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(910114087).content)

				arg_361_1.text_.text = var_364_1

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_3 = 42 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 42)

				if (42 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 42)) > 0 and var_364_0 < var_364_3 then
					arg_361_1.talkMaxDuration = var_364_3

					if var_364_3 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_3 + 0
					end
				end

				arg_361_1.text_.text = var_364_1
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_4 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_4

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play910114088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 910114088
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play910114089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1070ui_story = arg_365_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_368_0 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 then
				arg_365_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_365_1.time_ - 0) / var_368_0)
				arg_365_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1070ui_story"].transform.position).z)
				arg_365_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1070ui_story"].transform.localEulerAngles = arg_365_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 then
				arg_365_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_365_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1070ui_story"].transform.position).z)
				arg_365_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1070ui_story"].transform.localEulerAngles = arg_365_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_368_1 = arg_365_1.actors_["1070ui_story"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1070ui_story == nil then
				arg_365_1.var_.characterEffect1070ui_story = var_368_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_2 and not isNil(var_368_1) then
				if arg_365_1.var_.characterEffect1070ui_story and not isNil(var_368_1) then
					arg_365_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_365_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_365_1.time_ - 0) / var_368_2)
				end
			end

			if arg_365_1.time_ >= 0 + var_368_2 and arg_365_1.time_ < 0 + var_368_2 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1070ui_story then
				arg_365_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_365_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_368_3 = arg_365_1.actors_["1074ui_story"].transform

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1074ui_story = var_368_3.localPosition
			end

			local var_368_4 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				var_368_3.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_365_1.time_ - 0) / var_368_4)
				var_368_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_368_3.position).x, (manager.ui.mainCamera.transform.position - var_368_3.position).y, (manager.ui.mainCamera.transform.position - var_368_3.position).z)
				var_368_3.localEulerAngles.z = 0
				var_368_3.localEulerAngles.x = 0
				var_368_3.localEulerAngles = var_368_3.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				var_368_3.localPosition = Vector3.New(0, 100, 0)
				var_368_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_368_3.position).x, (manager.ui.mainCamera.transform.position - var_368_3.position).y, (manager.ui.mainCamera.transform.position - var_368_3.position).z)
				var_368_3.localEulerAngles.z = 0
				var_368_3.localEulerAngles.x = 0
				var_368_3.localEulerAngles = var_368_3.localEulerAngles
			end

			local var_368_5 = arg_365_1.actors_["1074ui_story"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_5) and arg_365_1.var_.characterEffect1074ui_story == nil then
				arg_365_1.var_.characterEffect1074ui_story = var_368_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_6 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_6 and not isNil(var_368_5) then
				if arg_365_1.var_.characterEffect1074ui_story and not isNil(var_368_5) then
					arg_365_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_365_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_365_1.time_ - 0) / var_368_6)
				end
			end

			if arg_365_1.time_ >= 0 + var_368_6 and arg_365_1.time_ < 0 + var_368_6 + arg_368_0 and not isNil(var_368_5) and arg_365_1.var_.characterEffect1074ui_story then
				arg_365_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_365_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_368_7 = 0
			local var_368_8 = 1.15

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_7 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_9 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(910114088).content)

				arg_365_1.text_.text = var_368_9

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_11 = 46 <= 0 and var_368_8 or var_368_8 * (utf8.len(var_368_9) / 46)

				if (46 <= 0 and var_368_8 or var_368_8 * (utf8.len(var_368_9) / 46)) > 0 and var_368_8 < var_368_11 then
					arg_365_1.talkMaxDuration = var_368_11

					if var_368_11 + var_368_7 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_11 + var_368_7
					end
				end

				arg_365_1.text_.text = var_368_9
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_12 = math.max(var_368_8, arg_365_1.talkMaxDuration)

			if var_368_7 <= arg_365_1.time_ and arg_365_1.time_ < var_368_7 + var_368_12 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_7) / var_368_12

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_7 + var_368_12 and arg_365_1.time_ < var_368_7 + var_368_12 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play910114089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 910114089
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play910114090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1074ui_story = arg_369_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1074ui_story"].transform.position).z)
				arg_369_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1074ui_story"].transform.localEulerAngles = arg_369_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_369_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1074ui_story"].transform.position).z)
				arg_369_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1074ui_story"].transform.localEulerAngles = arg_369_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_372_1 = arg_369_1.actors_["1074ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1074ui_story == nil then
				arg_369_1.var_.characterEffect1074ui_story = var_372_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_2 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_2 and not isNil(var_372_1) then
				if arg_369_1.var_.characterEffect1074ui_story and not isNil(var_372_1) then
					arg_369_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_2 and arg_369_1.time_ < 0 + var_372_2 + arg_372_0 and not isNil(var_372_1) and arg_369_1.var_.characterEffect1074ui_story then
				arg_369_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_372_4 = arg_369_1.actors_["1072ui_story"].transform

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1072ui_story = var_372_4.localPosition
			end

			local var_372_5 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_5 then
				var_372_4.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_369_1.time_ - 0) / var_372_5)
				var_372_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_372_4.position).x, (manager.ui.mainCamera.transform.position - var_372_4.position).y, (manager.ui.mainCamera.transform.position - var_372_4.position).z)
				var_372_4.localEulerAngles.z = 0
				var_372_4.localEulerAngles.x = 0
				var_372_4.localEulerAngles = var_372_4.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_5 and arg_369_1.time_ < 0 + var_372_5 + arg_372_0 then
				var_372_4.localPosition = Vector3.New(0.7, -0.71, -6)
				var_372_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_372_4.position).x, (manager.ui.mainCamera.transform.position - var_372_4.position).y, (manager.ui.mainCamera.transform.position - var_372_4.position).z)
				var_372_4.localEulerAngles.z = 0
				var_372_4.localEulerAngles.x = 0
				var_372_4.localEulerAngles = var_372_4.localEulerAngles
			end

			local var_372_6 = arg_369_1.actors_["1072ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_6) and arg_369_1.var_.characterEffect1072ui_story == nil then
				arg_369_1.var_.characterEffect1072ui_story = var_372_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_7 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_7 and not isNil(var_372_6) then
				if arg_369_1.var_.characterEffect1072ui_story and not isNil(var_372_6) then
					arg_369_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_7)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_7 and arg_369_1.time_ < 0 + var_372_7 + arg_372_0 and not isNil(var_372_6) and arg_369_1.var_.characterEffect1072ui_story then
				arg_369_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_372_8 = 0
			local var_372_9 = 0.075

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_10 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(910114089).content)

				arg_369_1.text_.text = var_372_10

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_12 = 3 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_10) / 3)

				if (3 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_10) / 3)) > 0 and var_372_9 < var_372_12 then
					arg_369_1.talkMaxDuration = var_372_12

					if var_372_12 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_12 + var_372_8
					end
				end

				arg_369_1.text_.text = var_372_10
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_13 = math.max(var_372_9, arg_369_1.talkMaxDuration)

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_13 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_8) / var_372_13

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_8 + var_372_13 and arg_369_1.time_ < var_372_8 + var_372_13 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play910114090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 910114090
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play910114091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1072ui_story = arg_373_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_376_0 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 then
				arg_373_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1072ui_story, Vector3.New(0.7, -0.71, -6), (arg_373_1.time_ - 0) / var_376_0)
				arg_373_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1072ui_story"].transform.position).z)
				arg_373_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1072ui_story"].transform.localEulerAngles = arg_373_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 then
				arg_373_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0.7, -0.71, -6)
				arg_373_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_373_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_373_1.actors_["1072ui_story"].transform.position).z)
				arg_373_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_373_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_373_1.actors_["1072ui_story"].transform.localEulerAngles = arg_373_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			local var_376_1 = arg_373_1.actors_["1072ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect1072ui_story == nil then
				arg_373_1.var_.characterEffect1072ui_story = var_376_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_2 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 and not isNil(var_376_1) then
				if arg_373_1.var_.characterEffect1072ui_story and not isNil(var_376_1) then
					arg_373_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 and not isNil(var_376_1) and arg_373_1.var_.characterEffect1072ui_story then
				arg_373_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_376_4 = arg_373_1.actors_["1074ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_4) and arg_373_1.var_.characterEffect1074ui_story == nil then
				arg_373_1.var_.characterEffect1074ui_story = var_376_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_5 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_5 and not isNil(var_376_4) then
				if arg_373_1.var_.characterEffect1074ui_story and not isNil(var_376_4) then
					arg_373_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_5)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_5 and arg_373_1.time_ < 0 + var_376_5 + arg_376_0 and not isNil(var_376_4) and arg_373_1.var_.characterEffect1074ui_story then
				arg_373_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_376_6 = 0
			local var_376_7 = 0.3

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_8 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(910114090).content)

				arg_373_1.text_.text = var_376_8

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_10 = 12 <= 0 and var_376_7 or var_376_7 * (utf8.len(var_376_8) / 12)

				if (12 <= 0 and var_376_7 or var_376_7 * (utf8.len(var_376_8) / 12)) > 0 and var_376_7 < var_376_10 then
					arg_373_1.talkMaxDuration = var_376_10

					if var_376_10 + var_376_6 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_10 + var_376_6
					end
				end

				arg_373_1.text_.text = var_376_8
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_11 = math.max(var_376_7, arg_373_1.talkMaxDuration)

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_11 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_6) / var_376_11

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_6 + var_376_11 and arg_373_1.time_ < var_376_6 + var_376_11 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play910114091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 910114091
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play910114092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.725

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_1 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(910114091).content)

				arg_377_1.text_.text = var_380_1

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_3 = 29 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 29)

				if (29 <= 0 and var_380_0 or var_380_0 * (utf8.len(var_380_1) / 29)) > 0 and var_380_0 < var_380_3 then
					arg_377_1.talkMaxDuration = var_380_3

					if var_380_3 + 0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_3 + 0
					end
				end

				arg_377_1.text_.text = var_380_1
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_4 = math.max(var_380_0, arg_377_1.talkMaxDuration)

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - 0) / var_380_4

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play910114092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 910114092
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play910114093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos1074ui_story = arg_381_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_384_0 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 then
				arg_381_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_381_1.time_ - 0) / var_384_0)
				arg_381_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1074ui_story"].transform.position).z)
				arg_381_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1074ui_story"].transform.localEulerAngles = arg_381_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 then
				arg_381_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_381_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_381_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_381_1.actors_["1074ui_story"].transform.position).z)
				arg_381_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_381_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_381_1.actors_["1074ui_story"].transform.localEulerAngles = arg_381_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_384_1 = arg_381_1.actors_["1074ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1074ui_story == nil then
				arg_381_1.var_.characterEffect1074ui_story = var_384_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_2 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_2 and not isNil(var_384_1) then
				if arg_381_1.var_.characterEffect1074ui_story and not isNil(var_384_1) then
					arg_381_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_2 and arg_381_1.time_ < 0 + var_384_2 + arg_384_0 and not isNil(var_384_1) and arg_381_1.var_.characterEffect1074ui_story then
				arg_381_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_384_4 = arg_381_1.actors_["1072ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_4) and arg_381_1.var_.characterEffect1072ui_story == nil then
				arg_381_1.var_.characterEffect1072ui_story = var_384_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_5 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_5 and not isNil(var_384_4) then
				if arg_381_1.var_.characterEffect1072ui_story and not isNil(var_384_4) then
					arg_381_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_5)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_5 and arg_381_1.time_ < 0 + var_384_5 + arg_384_0 and not isNil(var_384_4) and arg_381_1.var_.characterEffect1072ui_story then
				arg_381_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_384_6 = 0
			local var_384_7 = 0.35

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_6 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_8 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(910114092).content)

				arg_381_1.text_.text = var_384_8

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_10 = 14 <= 0 and var_384_7 or var_384_7 * (utf8.len(var_384_8) / 14)

				if (14 <= 0 and var_384_7 or var_384_7 * (utf8.len(var_384_8) / 14)) > 0 and var_384_7 < var_384_10 then
					arg_381_1.talkMaxDuration = var_384_10

					if var_384_10 + var_384_6 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_10 + var_384_6
					end
				end

				arg_381_1.text_.text = var_384_8
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_11 = math.max(var_384_7, arg_381_1.talkMaxDuration)

			if var_384_6 <= arg_381_1.time_ and arg_381_1.time_ < var_384_6 + var_384_11 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_6) / var_384_11

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_6 + var_384_11 and arg_381_1.time_ < var_384_6 + var_384_11 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play910114093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 910114093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play910114094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1070ui_story = arg_385_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_388_0 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 then
				arg_385_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_385_1.time_ - 0) / var_388_0)
				arg_385_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1070ui_story"].transform.position).z)
				arg_385_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1070ui_story"].transform.localEulerAngles = arg_385_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 then
				arg_385_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_385_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_385_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_385_1.actors_["1070ui_story"].transform.position).z)
				arg_385_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_385_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_385_1.actors_["1070ui_story"].transform.localEulerAngles = arg_385_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_388_1 = arg_385_1.actors_["1070ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1070ui_story == nil then
				arg_385_1.var_.characterEffect1070ui_story = var_388_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 and not isNil(var_388_1) then
				if arg_385_1.var_.characterEffect1070ui_story and not isNil(var_388_1) then
					arg_385_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 and not isNil(var_388_1) and arg_385_1.var_.characterEffect1070ui_story then
				arg_385_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_388_4 = arg_385_1.actors_["1074ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_4) and arg_385_1.var_.characterEffect1074ui_story == nil then
				arg_385_1.var_.characterEffect1074ui_story = var_388_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_5 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_5 and not isNil(var_388_4) then
				if arg_385_1.var_.characterEffect1074ui_story and not isNil(var_388_4) then
					arg_385_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_5)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_5 and arg_385_1.time_ < 0 + var_388_5 + arg_388_0 and not isNil(var_388_4) and arg_385_1.var_.characterEffect1074ui_story then
				arg_385_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_388_6 = arg_385_1.actors_["1074ui_story"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1074ui_story = var_388_6.localPosition
			end

			local var_388_7 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				var_388_6.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_385_1.time_ - 0) / var_388_7)
				var_388_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_6.position).x, (manager.ui.mainCamera.transform.position - var_388_6.position).y, (manager.ui.mainCamera.transform.position - var_388_6.position).z)
				var_388_6.localEulerAngles.z = 0
				var_388_6.localEulerAngles.x = 0
				var_388_6.localEulerAngles = var_388_6.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				var_388_6.localPosition = Vector3.New(0, 100, 0)
				var_388_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_6.position).x, (manager.ui.mainCamera.transform.position - var_388_6.position).y, (manager.ui.mainCamera.transform.position - var_388_6.position).z)
				var_388_6.localEulerAngles.z = 0
				var_388_6.localEulerAngles.x = 0
				var_388_6.localEulerAngles = var_388_6.localEulerAngles
			end

			local var_388_8 = arg_385_1.actors_["1072ui_story"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1072ui_story = var_388_8.localPosition
			end

			local var_388_9 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_9 then
				var_388_8.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_385_1.time_ - 0) / var_388_9)
				var_388_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_8.position).x, (manager.ui.mainCamera.transform.position - var_388_8.position).y, (manager.ui.mainCamera.transform.position - var_388_8.position).z)
				var_388_8.localEulerAngles.z = 0
				var_388_8.localEulerAngles.x = 0
				var_388_8.localEulerAngles = var_388_8.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_9 and arg_385_1.time_ < 0 + var_388_9 + arg_388_0 then
				var_388_8.localPosition = Vector3.New(0, 100, 0)
				var_388_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_8.position).x, (manager.ui.mainCamera.transform.position - var_388_8.position).y, (manager.ui.mainCamera.transform.position - var_388_8.position).z)
				var_388_8.localEulerAngles.z = 0
				var_388_8.localEulerAngles.x = 0
				var_388_8.localEulerAngles = var_388_8.localEulerAngles
			end

			local var_388_10 = 0
			local var_388_11 = 0.65

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_10 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_12 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(910114093).content)

				arg_385_1.text_.text = var_388_12

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_14 = 26 <= 0 and var_388_11 or var_388_11 * (utf8.len(var_388_12) / 26)

				if (26 <= 0 and var_388_11 or var_388_11 * (utf8.len(var_388_12) / 26)) > 0 and var_388_11 < var_388_14 then
					arg_385_1.talkMaxDuration = var_388_14

					if var_388_14 + var_388_10 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_14 + var_388_10
					end
				end

				arg_385_1.text_.text = var_388_12
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_15 = math.max(var_388_11, arg_385_1.talkMaxDuration)

			if var_388_10 <= arg_385_1.time_ and arg_385_1.time_ < var_388_10 + var_388_15 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_10) / var_388_15

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_10 + var_388_15 and arg_385_1.time_ < var_388_10 + var_388_15 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play910114094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 910114094
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play910114095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1070ui_story = arg_389_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1070ui_story"].transform.position).z)
				arg_389_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1070ui_story"].transform.localEulerAngles = arg_389_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_389_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1070ui_story"].transform.position).z)
				arg_389_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1070ui_story"].transform.localEulerAngles = arg_389_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_392_1 = arg_389_1.actors_["1070ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1070ui_story == nil then
				arg_389_1.var_.characterEffect1070ui_story = var_392_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_2 and not isNil(var_392_1) then
				if arg_389_1.var_.characterEffect1070ui_story and not isNil(var_392_1) then
					arg_389_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_2)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_2 and arg_389_1.time_ < 0 + var_392_2 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1070ui_story then
				arg_389_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_392_3 = arg_389_1.actors_["1074ui_story"].transform

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1074ui_story = var_392_3.localPosition
			end

			local var_392_4 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_4 then
				var_392_3.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_389_1.time_ - 0) / var_392_4)
				var_392_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_392_3.position).x, (manager.ui.mainCamera.transform.position - var_392_3.position).y, (manager.ui.mainCamera.transform.position - var_392_3.position).z)
				var_392_3.localEulerAngles.z = 0
				var_392_3.localEulerAngles.x = 0
				var_392_3.localEulerAngles = var_392_3.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_4 and arg_389_1.time_ < 0 + var_392_4 + arg_392_0 then
				var_392_3.localPosition = Vector3.New(0, -1.055, -6.12)
				var_392_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_392_3.position).x, (manager.ui.mainCamera.transform.position - var_392_3.position).y, (manager.ui.mainCamera.transform.position - var_392_3.position).z)
				var_392_3.localEulerAngles.z = 0
				var_392_3.localEulerAngles.x = 0
				var_392_3.localEulerAngles = var_392_3.localEulerAngles
			end

			local var_392_5 = arg_389_1.actors_["1074ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_5) and arg_389_1.var_.characterEffect1074ui_story == nil then
				arg_389_1.var_.characterEffect1074ui_story = var_392_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_6 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_6 and not isNil(var_392_5) then
				if arg_389_1.var_.characterEffect1074ui_story and not isNil(var_392_5) then
					arg_389_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_6 and arg_389_1.time_ < 0 + var_392_6 + arg_392_0 and not isNil(var_392_5) and arg_389_1.var_.characterEffect1074ui_story then
				arg_389_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_392_8 = 0
			local var_392_9 = 0.125

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_10 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(910114094).content)

				arg_389_1.text_.text = var_392_10

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_12 = 5 <= 0 and var_392_9 or var_392_9 * (utf8.len(var_392_10) / 5)

				if (5 <= 0 and var_392_9 or var_392_9 * (utf8.len(var_392_10) / 5)) > 0 and var_392_9 < var_392_12 then
					arg_389_1.talkMaxDuration = var_392_12

					if var_392_12 + var_392_8 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_12 + var_392_8
					end
				end

				arg_389_1.text_.text = var_392_10
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_13 = math.max(var_392_9, arg_389_1.talkMaxDuration)

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_13 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_8) / var_392_13

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_8 + var_392_13 and arg_389_1.time_ < var_392_8 + var_392_13 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play910114095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 910114095
		arg_393_1.duration_ = 9

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play910114096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 2 < arg_393_1.time_ and arg_393_1.time_ <= 2 + arg_396_0 then
				local var_396_0 = arg_393_1.bgs_.ST32

				arg_393_1.bgs_.ST32.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_396_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_396_1 = var_396_0:GetComponent("SpriteRenderer")

				if var_396_1 and var_396_1.sprite then
					local var_396_2 = 2 * (var_396_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_396_0.transform.localScale = Vector3.New(var_396_2 / var_396_1.sprite.bounds.size.y < var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x and var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x or var_396_2 / var_396_1.sprite.bounds.size.y, var_396_2 / var_396_1.sprite.bounds.size.y < var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x and var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x or var_396_2 / var_396_1.sprite.bounds.size.y, 0)
				end

				for iter_396_0, iter_396_1 in pairs(arg_393_1.bgs_) do
					if iter_396_0 ~= "ST32" then
						iter_396_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_396_3 = 0

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_4 = 2

			if var_396_3 <= arg_393_1.time_ and arg_393_1.time_ < var_396_3 + var_396_4 then
				local var_396_5 = Color.New(0, 0, 0)

				var_396_5.a = Mathf.Lerp(0, 1, (arg_393_1.time_ - var_396_3) / var_396_4)
				arg_393_1.mask_.color = var_396_5
			end

			if arg_393_1.time_ >= var_396_3 + var_396_4 and arg_393_1.time_ < var_396_3 + var_396_4 + arg_396_0 then
				local var_396_6 = Color.New(0, 0, 0)

				var_396_6.a = 1
				arg_393_1.mask_.color = var_396_6
			end

			local var_396_7 = 2

			if 2 < arg_393_1.time_ and arg_393_1.time_ <= var_396_7 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_8 = 2

			if var_396_7 <= arg_393_1.time_ and arg_393_1.time_ < var_396_7 + var_396_8 then
				local var_396_9 = Color.New(0, 0, 0)

				var_396_9.a = Mathf.Lerp(1, 0, (arg_393_1.time_ - var_396_7) / var_396_8)
				arg_393_1.mask_.color = var_396_9
			end

			if arg_393_1.time_ >= var_396_7 + var_396_8 and arg_393_1.time_ < var_396_7 + var_396_8 + arg_396_0 then
				local var_396_10 = Color.New(0, 0, 0)

				arg_393_1.mask_.enabled = false
				var_396_10.a = 0
				arg_393_1.mask_.color = var_396_10
			end

			local var_396_11 = arg_393_1.actors_["1074ui_story"].transform

			if 2 < arg_393_1.time_ and arg_393_1.time_ <= 2 + arg_396_0 then
				arg_393_1.var_.moveOldPos1074ui_story = var_396_11.localPosition
			end

			local var_396_12 = 0.001

			if 2 <= arg_393_1.time_ and arg_393_1.time_ < 2 + var_396_12 then
				var_396_11.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_393_1.time_ - 2) / var_396_12)
				var_396_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_396_11.position).x, (manager.ui.mainCamera.transform.position - var_396_11.position).y, (manager.ui.mainCamera.transform.position - var_396_11.position).z)
				var_396_11.localEulerAngles.z = 0
				var_396_11.localEulerAngles.x = 0
				var_396_11.localEulerAngles = var_396_11.localEulerAngles
			end

			if arg_393_1.time_ >= 2 + var_396_12 and arg_393_1.time_ < 2 + var_396_12 + arg_396_0 then
				var_396_11.localPosition = Vector3.New(0, 100, 0)
				var_396_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_396_11.position).x, (manager.ui.mainCamera.transform.position - var_396_11.position).y, (manager.ui.mainCamera.transform.position - var_396_11.position).z)
				var_396_11.localEulerAngles.z = 0
				var_396_11.localEulerAngles.x = 0
				var_396_11.localEulerAngles = var_396_11.localEulerAngles
			end

			if arg_393_1.frameCnt_ <= 1 then
				arg_393_1.dialog_:SetActive(false)
			end

			local var_396_13 = 4
			local var_396_14 = 1.225

			if 4 < arg_393_1.time_ and arg_393_1.time_ <= var_396_13 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				arg_393_1.dialog_:SetActive(true)

				arg_393_1.dialogCg_.alpha = 0

				local var_396_15 = LeanTween.value(arg_393_1.dialog_, 0, 1, 0.3)

				var_396_15:setOnUpdate(LuaHelper.FloatAction(function(arg_397_0)
					arg_393_1.dialogCg_.alpha = arg_397_0
				end))
				var_396_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_393_1.dialog_)
					var_396_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_393_1.duration_ = arg_393_1.duration_ + 0.3

				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_16 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(910114095).content)

				arg_393_1.text_.text = var_396_16

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_18 = 49 <= 0 and var_396_14 or var_396_14 * (utf8.len(var_396_16) / 49)

				if (49 <= 0 and var_396_14 or var_396_14 * (utf8.len(var_396_16) / 49)) > 0 and var_396_14 < var_396_18 then
					arg_393_1.talkMaxDuration = var_396_18
					var_396_13 = var_396_13 + 0.3

					if var_396_18 + var_396_13 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_18 + var_396_13
					end
				end

				arg_393_1.text_.text = var_396_16
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_19 = var_396_13 + 0.3
			local var_396_20 = math.max(var_396_14, arg_393_1.talkMaxDuration)

			if var_396_13 + 0.3 <= arg_393_1.time_ and arg_393_1.time_ < var_396_19 + var_396_20 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_19) / var_396_20

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_19 + var_396_20 and arg_393_1.time_ < var_396_19 + var_396_20 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play910114096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 910114096
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play910114097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.1

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(910114096).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 4 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 4)

				if (4 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 4)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play910114097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 910114097
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
			arg_403_1.auto_ = false
		end

		function arg_403_1.playNext_(arg_405_0)
			arg_403_1.onStoryFinished_()
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1070ui_story = arg_403_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_406_0 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 then
				arg_403_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_403_1.time_ - 0) / var_406_0)
				arg_403_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1070ui_story"].transform.position).z)
				arg_403_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1070ui_story"].transform.localEulerAngles = arg_403_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 then
				arg_403_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_403_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_403_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_403_1.actors_["1070ui_story"].transform.position).z)
				arg_403_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_403_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_403_1.actors_["1070ui_story"].transform.localEulerAngles = arg_403_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_406_1 = arg_403_1.actors_["1070ui_story"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1070ui_story == nil then
				arg_403_1.var_.characterEffect1070ui_story = var_406_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_2 and not isNil(var_406_1) then
				if arg_403_1.var_.characterEffect1070ui_story and not isNil(var_406_1) then
					arg_403_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 0 + var_406_2 and arg_403_1.time_ < 0 + var_406_2 + arg_406_0 and not isNil(var_406_1) and arg_403_1.var_.characterEffect1070ui_story then
				arg_403_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_406_4 = 0
			local var_406_5 = 0.45

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_6 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(910114097).content)

				arg_403_1.text_.text = var_406_6

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_8 = 18 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_6) / 18)

				if (18 <= 0 and var_406_5 or var_406_5 * (utf8.len(var_406_6) / 18)) > 0 and var_406_5 < var_406_8 then
					arg_403_1.talkMaxDuration = var_406_8

					if var_406_8 + var_406_4 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_4
					end
				end

				arg_403_1.text_.text = var_406_6
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_9 = math.max(var_406_5, arg_403_1.talkMaxDuration)

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_9 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_4) / var_406_9

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_4 + var_406_9 and arg_403_1.time_ < var_406_4 + var_406_9 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/ST29",
		"TextureConfig/Background/ST32",
		"TextureConfig/Background/J13f",
		"TextureConfig/Background/ST53"
	},
	voices = {}
}
