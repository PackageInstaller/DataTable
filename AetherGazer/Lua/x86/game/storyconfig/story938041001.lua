return {
	Play938041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 938041001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play938041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.STblack

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2.024999999999

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0
			local var_4_25 = 0.633333333333333

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_28 = 1.999999999999
			local var_4_29 = 0.325

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_31 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_32 = arg_1_1:GetWordFromCfg(938041001)
				local var_4_33 = arg_1_1:FormatText(var_4_32.content)

				arg_1_1.text_.text = var_4_33

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_34 = 13
				local var_4_35 = utf8.len(var_4_33)
				local var_4_36 = var_4_34 <= 0 and var_4_29 or var_4_29 * (var_4_35 / var_4_34)

				if var_4_36 > 0 and var_4_29 < var_4_36 then
					arg_1_1.talkMaxDuration = var_4_36
					var_4_28 = var_4_28 + 0.3

					if var_4_36 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_36 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_33
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_37 = var_4_28 + 0.3
			local var_4_38 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_37) / var_4_38

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play938041002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 938041002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play938041003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 0.6

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_2 = arg_7_1:FormatText(StoryNameCfg[7].name)

				arg_7_1.leftNameTxt_.text = var_10_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, true)
				arg_7_1.iconController_:SetSelectedState("hero")

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_3 = arg_7_1:GetWordFromCfg(938041002)
				local var_10_4 = arg_7_1:FormatText(var_10_3.content)

				arg_7_1.text_.text = var_10_4

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 24
				local var_10_6 = utf8.len(var_10_4)
				local var_10_7 = var_10_5 <= 0 and var_10_1 or var_10_1 * (var_10_6 / var_10_5)

				if var_10_7 > 0 and var_10_1 < var_10_7 then
					arg_7_1.talkMaxDuration = var_10_7

					if var_10_7 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_7 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_4
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_8 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_8 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_8

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_8 and arg_7_1.time_ < var_10_0 + var_10_8 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play938041003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 938041003
		arg_11_1.duration_ = 2.23

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play938041004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 1
			local var_14_1 = 1

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				local var_14_2 = "play"
				local var_14_3 = "effect"

				arg_11_1:AudioAction(var_14_2, var_14_3, "se_story_side_1033", "se_story_1033_knock", "")
			end

			local var_14_4 = 0

			if var_14_4 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.cswbg_:SetActive(true)

				local var_14_5 = arg_11_1.cswt_:GetComponent("RectTransform")

				arg_11_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_14_5.offsetMin = Vector2.New(400, 200)
				var_14_5.offsetMax = Vector2.New(-400, -200)

				local var_14_6 = arg_11_1:GetWordFromCfg(419195)
				local var_14_7 = arg_11_1:FormatText(var_14_6.content)

				arg_11_1.cswt_.text = var_14_7

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.cswt_)

				arg_11_1.cswt_.fontSize = 90
				arg_11_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_11_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_11_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_14_8 = manager.ui.mainCamera.transform
			local var_14_9 = 0

			if var_14_9 < arg_11_1.time_ and arg_11_1.time_ <= var_14_9 + arg_14_0 then
				local var_14_10 = arg_11_1.var_.effectjinrushuimian1
				local var_14_11
				local var_14_12 = var_14_8

				if not var_14_10 then
					var_14_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_14_12)
					var_14_10.name = "jinrushuimian1"
					arg_11_1.var_.effectjinrushuimian1 = var_14_10
				else
					var_14_10.transform:SetParent(var_14_12)
				end

				var_14_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_14_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_14_13 = manager.ui.mainCamera.transform
			local var_14_14 = 2

			if var_14_14 < arg_11_1.time_ and arg_11_1.time_ <= var_14_14 + arg_14_0 then
				local var_14_15 = arg_11_1.var_.effectjinrushuimian1

				if var_14_15 then
					Object.Destroy(var_14_15)

					arg_11_1.var_.effectjinrushuimian1 = nil
				end
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play938041004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 938041004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play938041005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.175

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_2 = arg_15_1:FormatText(StoryNameCfg[562].name)

				arg_15_1.leftNameTxt_.text = var_18_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_104902_split_2")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_3 = arg_15_1:GetWordFromCfg(938041004)
				local var_18_4 = arg_15_1:FormatText(var_18_3.content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 7
				local var_18_6 = utf8.len(var_18_4)
				local var_18_7 = var_18_5 <= 0 and var_18_1 or var_18_1 * (var_18_6 / var_18_5)

				if var_18_7 > 0 and var_18_1 < var_18_7 then
					arg_15_1.talkMaxDuration = var_18_7

					if var_18_7 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_7 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_8 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_8 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_8

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_8 and arg_15_1.time_ < var_18_0 + var_18_8 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play938041005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 938041005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play938041006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 1.075

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_2 = arg_19_1:FormatText(StoryNameCfg[1332].name)

				arg_19_1.leftNameTxt_.text = var_22_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_108301_split_3")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_3 = arg_19_1:GetWordFromCfg(938041005)
				local var_22_4 = arg_19_1:FormatText(var_22_3.content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 43
				local var_22_6 = utf8.len(var_22_4)
				local var_22_7 = var_22_5 <= 0 and var_22_1 or var_22_1 * (var_22_6 / var_22_5)

				if var_22_7 > 0 and var_22_1 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_0
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_8 = math.max(var_22_1, arg_19_1.talkMaxDuration)

			if var_22_0 <= arg_19_1.time_ and arg_19_1.time_ < var_22_0 + var_22_8 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_0) / var_22_8

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_0 + var_22_8 and arg_19_1.time_ < var_22_0 + var_22_8 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play938041006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 938041006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play938041007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 0.425

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_2 = arg_23_1:FormatText(StoryNameCfg[32].name)

				arg_23_1.leftNameTxt_.text = var_26_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_106603_split_1")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_3 = arg_23_1:GetWordFromCfg(938041006)
				local var_26_4 = arg_23_1:FormatText(var_26_3.content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_5 = 17
				local var_26_6 = utf8.len(var_26_4)
				local var_26_7 = var_26_5 <= 0 and var_26_1 or var_26_1 * (var_26_6 / var_26_5)

				if var_26_7 > 0 and var_26_1 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_4
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_8 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_8 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_8

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_8 and arg_23_1.time_ < var_26_0 + var_26_8 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play938041007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 938041007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play938041008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 1

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[7].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_3 = arg_27_1:GetWordFromCfg(938041007)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 40
				local var_30_6 = utf8.len(var_30_4)
				local var_30_7 = var_30_5 <= 0 and var_30_1 or var_30_1 * (var_30_6 / var_30_5)

				if var_30_7 > 0 and var_30_1 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_8 and arg_27_1.time_ < var_30_0 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play938041008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 938041008
		arg_31_1.duration_ = 6.5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play938041009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_1 = 4

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_1 then
				local var_34_2 = (arg_31_1.time_ - var_34_0) / var_34_1
				local var_34_3 = Color.New(0.009433985, 0.009433985, 0.009433985)

				var_34_3.a = Mathf.Lerp(0, 1, var_34_2)
				arg_31_1.mask_.color = var_34_3
			end

			if arg_31_1.time_ >= var_34_0 + var_34_1 and arg_31_1.time_ < var_34_0 + var_34_1 + arg_34_0 then
				local var_34_4 = Color.New(0.009433985, 0.009433985, 0.009433985)

				var_34_4.a = 1
				arg_31_1.mask_.color = var_34_4
			end

			local var_34_5 = 4.5

			if var_34_5 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_6 = 2

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_6 then
				local var_34_7 = (arg_31_1.time_ - var_34_5) / var_34_6
				local var_34_8 = Color.New(0.009433985, 0.009433985, 0.009433985)

				var_34_8.a = Mathf.Lerp(1, 0, var_34_7)
				arg_31_1.mask_.color = var_34_8
			end

			if arg_31_1.time_ >= var_34_5 + var_34_6 and arg_31_1.time_ < var_34_5 + var_34_6 + arg_34_0 then
				local var_34_9 = Color.New(0.009433985, 0.009433985, 0.009433985)
				local var_34_10 = 0

				arg_31_1.mask_.enabled = false
				var_34_9.a = var_34_10
				arg_31_1.mask_.color = var_34_9
			end

			local var_34_11 = 4

			if var_34_11 < arg_31_1.time_ and arg_31_1.time_ <= var_34_11 + arg_34_0 then
				arg_31_1.cswbg_:SetActive(false)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play938041009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 938041009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play938041010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = "108301"

			if arg_35_1.actors_[var_38_0] == nil then
				local var_38_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

				if not isNil(var_38_1) then
					local var_38_2 = Object.Instantiate(var_38_1, arg_35_1.canvasGo_.transform)

					var_38_2.transform:SetSiblingIndex(1)

					var_38_2.name = var_38_0
					var_38_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_35_1.actors_[var_38_0] = var_38_2

					local var_38_3 = var_38_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_35_1.isInRecall_ then
						for iter_38_0, iter_38_1 in ipairs(var_38_3) do
							iter_38_1.color = arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_38_4 = arg_35_1.actors_["108301"]
			local var_38_5 = 0

			if var_38_5 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.actorSpriteComps108301 == nil then
				arg_35_1.var_.actorSpriteComps108301 = var_38_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_6 = 0.2

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_6 and not isNil(var_38_4) then
				local var_38_7 = (arg_35_1.time_ - var_38_5) / var_38_6

				if arg_35_1.var_.actorSpriteComps108301 then
					for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_38_3 then
							if arg_35_1.isInRecall_ then
								local var_38_8 = Mathf.Lerp(iter_38_3.color.r, arg_35_1.hightColor1.r, var_38_7)
								local var_38_9 = Mathf.Lerp(iter_38_3.color.g, arg_35_1.hightColor1.g, var_38_7)
								local var_38_10 = Mathf.Lerp(iter_38_3.color.b, arg_35_1.hightColor1.b, var_38_7)

								iter_38_3.color = Color.New(var_38_8, var_38_9, var_38_10)
							else
								local var_38_11 = Mathf.Lerp(iter_38_3.color.r, 1, var_38_7)

								iter_38_3.color = Color.New(var_38_11, var_38_11, var_38_11)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= var_38_5 + var_38_6 and arg_35_1.time_ < var_38_5 + var_38_6 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.actorSpriteComps108301 then
				for iter_38_4, iter_38_5 in pairs(arg_35_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_38_5 then
						if arg_35_1.isInRecall_ then
							iter_38_5.color = arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_38_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_35_1.var_.actorSpriteComps108301 = nil
			end

			local var_38_12 = arg_35_1.actors_["108301"].transform
			local var_38_13 = 0

			if var_38_13 < arg_35_1.time_ and arg_35_1.time_ <= var_38_13 + arg_38_0 then
				arg_35_1.var_.moveOldPos108301 = var_38_12.localPosition
				var_38_12.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("108301", 3)

				local var_38_14 = var_38_12.childCount

				for iter_38_6 = 0, var_38_14 - 1 do
					local var_38_15 = var_38_12:GetChild(iter_38_6)

					if var_38_15.name == "split_5" or not string.find(var_38_15.name, "split") then
						var_38_15.gameObject:SetActive(true)
					else
						var_38_15.gameObject:SetActive(false)
					end
				end
			end

			local var_38_16 = 0.001

			if var_38_13 <= arg_35_1.time_ and arg_35_1.time_ < var_38_13 + var_38_16 then
				local var_38_17 = (arg_35_1.time_ - var_38_13) / var_38_16
				local var_38_18 = Vector3.New(0, -360, -195)

				var_38_12.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos108301, var_38_18, var_38_17)
			end

			if arg_35_1.time_ >= var_38_13 + var_38_16 and arg_35_1.time_ < var_38_13 + var_38_16 + arg_38_0 then
				var_38_12.localPosition = Vector3.New(0, -360, -195)
			end

			local var_38_19 = arg_35_1.actors_["108301"]
			local var_38_20 = 0

			if var_38_20 < arg_35_1.time_ and arg_35_1.time_ <= var_38_20 + arg_38_0 then
				local var_38_21 = var_38_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_38_21 then
					arg_35_1.var_.alphaOldValue108301 = var_38_21.alpha
					arg_35_1.var_.characterEffect108301 = var_38_21
				end

				arg_35_1.var_.alphaOldValue108301 = 0
			end

			local var_38_22 = 0.5

			if var_38_20 <= arg_35_1.time_ and arg_35_1.time_ < var_38_20 + var_38_22 then
				local var_38_23 = (arg_35_1.time_ - var_38_20) / var_38_22
				local var_38_24 = Mathf.Lerp(arg_35_1.var_.alphaOldValue108301, 1, var_38_23)

				if arg_35_1.var_.characterEffect108301 then
					arg_35_1.var_.characterEffect108301.alpha = var_38_24
				end
			end

			if arg_35_1.time_ >= var_38_20 + var_38_22 and arg_35_1.time_ < var_38_20 + var_38_22 + arg_38_0 and arg_35_1.var_.characterEffect108301 then
				arg_35_1.var_.characterEffect108301.alpha = 1
			end

			local var_38_25 = 0
			local var_38_26 = 0.85

			if var_38_25 < arg_35_1.time_ and arg_35_1.time_ <= var_38_25 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_27 = arg_35_1:FormatText(StoryNameCfg[1332].name)

				arg_35_1.leftNameTxt_.text = var_38_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_28 = arg_35_1:GetWordFromCfg(938041009)
				local var_38_29 = arg_35_1:FormatText(var_38_28.content)

				arg_35_1.text_.text = var_38_29

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_30 = 34
				local var_38_31 = utf8.len(var_38_29)
				local var_38_32 = var_38_30 <= 0 and var_38_26 or var_38_26 * (var_38_31 / var_38_30)

				if var_38_32 > 0 and var_38_26 < var_38_32 then
					arg_35_1.talkMaxDuration = var_38_32

					if var_38_32 + var_38_25 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_32 + var_38_25
					end
				end

				arg_35_1.text_.text = var_38_29
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_33 = math.max(var_38_26, arg_35_1.talkMaxDuration)

			if var_38_25 <= arg_35_1.time_ and arg_35_1.time_ < var_38_25 + var_38_33 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_25) / var_38_33

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_25 + var_38_33 and arg_35_1.time_ < var_38_25 + var_38_33 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
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
	Play938041010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 938041010
		arg_39_1.duration_ = 9

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play938041011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = "ST0114"

			if arg_39_1.bgs_[var_42_0] == nil then
				local var_42_1 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_42_0)
				var_42_1.name = var_42_0
				var_42_1.transform.parent = arg_39_1.stage_.transform
				var_42_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_[var_42_0] = var_42_1
			end

			local var_42_2 = 2

			if var_42_2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 then
				local var_42_3 = manager.ui.mainCamera.transform.localPosition
				local var_42_4 = Vector3.New(0, 0, 10) + Vector3.New(var_42_3.x, var_42_3.y, 0)
				local var_42_5 = arg_39_1.bgs_.ST0114

				var_42_5.transform.localPosition = var_42_4
				var_42_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_6 = var_42_5:GetComponent("SpriteRenderer")

				if var_42_6 and var_42_6.sprite then
					local var_42_7 = (var_42_5.transform.localPosition - var_42_3).z
					local var_42_8 = manager.ui.mainCameraCom_
					local var_42_9 = 2 * var_42_7 * Mathf.Tan(var_42_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_42_10 = var_42_9 * var_42_8.aspect
					local var_42_11 = var_42_6.sprite.bounds.size.x
					local var_42_12 = var_42_6.sprite.bounds.size.y
					local var_42_13 = var_42_10 / var_42_11
					local var_42_14 = var_42_9 / var_42_12
					local var_42_15 = var_42_14 < var_42_13 and var_42_13 or var_42_14

					var_42_5.transform.localScale = Vector3.New(var_42_15, var_42_15, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "ST0114" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_16 = 3.999999999999

			if var_42_16 < arg_39_1.time_ and arg_39_1.time_ <= var_42_16 + arg_42_0 then
				arg_39_1.allBtn_.enabled = false
			end

			local var_42_17 = 0.3

			if arg_39_1.time_ >= var_42_16 + var_42_17 and arg_39_1.time_ < var_42_16 + var_42_17 + arg_42_0 then
				arg_39_1.allBtn_.enabled = true
			end

			local var_42_18 = 0

			if var_42_18 < arg_39_1.time_ and arg_39_1.time_ <= var_42_18 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_19 = 2

			if var_42_18 <= arg_39_1.time_ and arg_39_1.time_ < var_42_18 + var_42_19 then
				local var_42_20 = (arg_39_1.time_ - var_42_18) / var_42_19
				local var_42_21 = Color.New(0, 0, 0)

				var_42_21.a = Mathf.Lerp(0, 1, var_42_20)
				arg_39_1.mask_.color = var_42_21
			end

			if arg_39_1.time_ >= var_42_18 + var_42_19 and arg_39_1.time_ < var_42_18 + var_42_19 + arg_42_0 then
				local var_42_22 = Color.New(0, 0, 0)

				var_42_22.a = 1
				arg_39_1.mask_.color = var_42_22
			end

			local var_42_23 = 2

			if var_42_23 < arg_39_1.time_ and arg_39_1.time_ <= var_42_23 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_24 = 2

			if var_42_23 <= arg_39_1.time_ and arg_39_1.time_ < var_42_23 + var_42_24 then
				local var_42_25 = (arg_39_1.time_ - var_42_23) / var_42_24
				local var_42_26 = Color.New(0, 0, 0)

				var_42_26.a = Mathf.Lerp(1, 0, var_42_25)
				arg_39_1.mask_.color = var_42_26
			end

			if arg_39_1.time_ >= var_42_23 + var_42_24 and arg_39_1.time_ < var_42_23 + var_42_24 + arg_42_0 then
				local var_42_27 = Color.New(0, 0, 0)
				local var_42_28 = 0

				arg_39_1.mask_.enabled = false
				var_42_27.a = var_42_28
				arg_39_1.mask_.color = var_42_27
			end

			local var_42_29 = arg_39_1.actors_["108301"]
			local var_42_30 = 1.966

			if var_42_30 < arg_39_1.time_ and arg_39_1.time_ <= var_42_30 + arg_42_0 and not isNil(var_42_29) and arg_39_1.var_.actorSpriteComps108301 == nil then
				arg_39_1.var_.actorSpriteComps108301 = var_42_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_31 = 0.034

			if var_42_30 <= arg_39_1.time_ and arg_39_1.time_ < var_42_30 + var_42_31 and not isNil(var_42_29) then
				local var_42_32 = (arg_39_1.time_ - var_42_30) / var_42_31

				if arg_39_1.var_.actorSpriteComps108301 then
					for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_42_3 then
							if arg_39_1.isInRecall_ then
								local var_42_33 = Mathf.Lerp(iter_42_3.color.r, arg_39_1.hightColor2.r, var_42_32)
								local var_42_34 = Mathf.Lerp(iter_42_3.color.g, arg_39_1.hightColor2.g, var_42_32)
								local var_42_35 = Mathf.Lerp(iter_42_3.color.b, arg_39_1.hightColor2.b, var_42_32)

								iter_42_3.color = Color.New(var_42_33, var_42_34, var_42_35)
							else
								local var_42_36 = Mathf.Lerp(iter_42_3.color.r, 0.5, var_42_32)

								iter_42_3.color = Color.New(var_42_36, var_42_36, var_42_36)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_30 + var_42_31 and arg_39_1.time_ < var_42_30 + var_42_31 + arg_42_0 and not isNil(var_42_29) and arg_39_1.var_.actorSpriteComps108301 then
				for iter_42_4, iter_42_5 in pairs(arg_39_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_42_5 then
						if arg_39_1.isInRecall_ then
							iter_42_5.color = arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_42_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps108301 = nil
			end

			local var_42_37 = arg_39_1.actors_["108301"].transform
			local var_42_38 = 1.966

			if var_42_38 < arg_39_1.time_ and arg_39_1.time_ <= var_42_38 + arg_42_0 then
				arg_39_1.var_.moveOldPos108301 = var_42_37.localPosition
				var_42_37.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("108301", 7)

				local var_42_39 = var_42_37.childCount

				for iter_42_6 = 0, var_42_39 - 1 do
					local var_42_40 = var_42_37:GetChild(iter_42_6)

					if var_42_40.name == "" or not string.find(var_42_40.name, "split") then
						var_42_40.gameObject:SetActive(true)
					else
						var_42_40.gameObject:SetActive(false)
					end
				end
			end

			local var_42_41 = 0.001

			if var_42_38 <= arg_39_1.time_ and arg_39_1.time_ < var_42_38 + var_42_41 then
				local var_42_42 = (arg_39_1.time_ - var_42_38) / var_42_41
				local var_42_43 = Vector3.New(0, -2000, 0)

				var_42_37.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos108301, var_42_43, var_42_42)
			end

			if arg_39_1.time_ >= var_42_38 + var_42_41 and arg_39_1.time_ < var_42_38 + var_42_41 + arg_42_0 then
				var_42_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_42_44 = 2.43333333333333
			local var_42_45 = 1

			if var_42_44 < arg_39_1.time_ and arg_39_1.time_ <= var_42_44 + arg_42_0 then
				local var_42_46 = "play"
				local var_42_47 = "effect"

				arg_39_1:AudioAction(var_42_46, var_42_47, "se_story_143", "se_story_143_amb_bar", "")
			end

			local var_42_48 = 2.43333333333333
			local var_42_49 = 1

			if var_42_48 < arg_39_1.time_ and arg_39_1.time_ <= var_42_48 + arg_42_0 then
				local var_42_50 = "play"
				local var_42_51 = "music"

				arg_39_1:AudioAction(var_42_50, var_42_51, "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")

				local var_42_52 = ""
				local var_42_53 = manager.audio:GetAudioName("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern")

				if var_42_53 ~= "" then
					if arg_39_1.bgmTxt_.text ~= var_42_53 and arg_39_1.bgmTxt_.text ~= "" then
						if arg_39_1.bgmTxt2_.text ~= "" then
							arg_39_1.bgmTxt_.text = arg_39_1.bgmTxt2_.text
						end

						arg_39_1.bgmTxt2_.text = var_42_53

						arg_39_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_39_1.bgmTxt_.text = var_42_53
						arg_39_1.bgmTxt2_.text = var_42_53
					end

					if arg_39_1.bgmTimer then
						arg_39_1.bgmTimer:Stop()

						arg_39_1.bgmTimer = nil
					end

					if arg_39_1.settingData.show_music_name == 1 then
						arg_39_1.musicController:SetSelectedState("show")
						arg_39_1.musicAnimator_:Play("open", 0, 0)

						if arg_39_1.settingData.music_time ~= 0 then
							arg_39_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_39_1.settingData.music_time), function()
								if arg_39_1 == nil or isNil(arg_39_1.bgmTxt_) then
									return
								end

								arg_39_1.musicController:SetSelectedState("hide")
								arg_39_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_54 = 3.999999999999
			local var_42_55 = 1

			if var_42_54 < arg_39_1.time_ and arg_39_1.time_ <= var_42_54 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_56 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_56:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_39_1.dialogCg_.alpha = arg_44_0
				end))
				var_42_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_57 = arg_39_1:GetWordFromCfg(938041010)
				local var_42_58 = arg_39_1:FormatText(var_42_57.content)

				arg_39_1.text_.text = var_42_58

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_59 = 40
				local var_42_60 = utf8.len(var_42_58)
				local var_42_61 = var_42_59 <= 0 and var_42_55 or var_42_55 * (var_42_60 / var_42_59)

				if var_42_61 > 0 and var_42_55 < var_42_61 then
					arg_39_1.talkMaxDuration = var_42_61
					var_42_54 = var_42_54 + 0.3

					if var_42_61 + var_42_54 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_61 + var_42_54
					end
				end

				arg_39_1.text_.text = var_42_58
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_62 = var_42_54 + 0.3
			local var_42_63 = math.max(var_42_55, arg_39_1.talkMaxDuration)

			if var_42_62 <= arg_39_1.time_ and arg_39_1.time_ < var_42_62 + var_42_63 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_62) / var_42_63

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_62 + var_42_63 and arg_39_1.time_ < var_42_62 + var_42_63 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play938041011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 938041011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play938041012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = "106603"

			if arg_46_1.actors_[var_49_0] == nil then
				local var_49_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_49_1) then
					local var_49_2 = Object.Instantiate(var_49_1, arg_46_1.canvasGo_.transform)

					var_49_2.transform:SetSiblingIndex(1)

					var_49_2.name = var_49_0
					var_49_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_46_1.actors_[var_49_0] = var_49_2

					local var_49_3 = var_49_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_46_1.isInRecall_ then
						for iter_49_0, iter_49_1 in ipairs(var_49_3) do
							iter_49_1.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_49_4 = arg_46_1.actors_["106603"]
			local var_49_5 = 0

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 and not isNil(var_49_4) and arg_46_1.var_.actorSpriteComps106603 == nil then
				arg_46_1.var_.actorSpriteComps106603 = var_49_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_6 = 0.2

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_6 and not isNil(var_49_4) then
				local var_49_7 = (arg_46_1.time_ - var_49_5) / var_49_6

				if arg_46_1.var_.actorSpriteComps106603 then
					for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_49_3 then
							if arg_46_1.isInRecall_ then
								local var_49_8 = Mathf.Lerp(iter_49_3.color.r, arg_46_1.hightColor1.r, var_49_7)
								local var_49_9 = Mathf.Lerp(iter_49_3.color.g, arg_46_1.hightColor1.g, var_49_7)
								local var_49_10 = Mathf.Lerp(iter_49_3.color.b, arg_46_1.hightColor1.b, var_49_7)

								iter_49_3.color = Color.New(var_49_8, var_49_9, var_49_10)
							else
								local var_49_11 = Mathf.Lerp(iter_49_3.color.r, 1, var_49_7)

								iter_49_3.color = Color.New(var_49_11, var_49_11, var_49_11)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= var_49_5 + var_49_6 and arg_46_1.time_ < var_49_5 + var_49_6 + arg_49_0 and not isNil(var_49_4) and arg_46_1.var_.actorSpriteComps106603 then
				for iter_49_4, iter_49_5 in pairs(arg_46_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_49_5 then
						if arg_46_1.isInRecall_ then
							iter_49_5.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_49_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_46_1.var_.actorSpriteComps106603 = nil
			end

			local var_49_12 = arg_46_1.actors_["106603"].transform
			local var_49_13 = 0

			if var_49_13 < arg_46_1.time_ and arg_46_1.time_ <= var_49_13 + arg_49_0 then
				arg_46_1.var_.moveOldPos106603 = var_49_12.localPosition
				var_49_12.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("106603", 3)

				local var_49_14 = var_49_12.childCount

				for iter_49_6 = 0, var_49_14 - 1 do
					local var_49_15 = var_49_12:GetChild(iter_49_6)

					if var_49_15.name == "" or not string.find(var_49_15.name, "split") then
						var_49_15.gameObject:SetActive(true)
					else
						var_49_15.gameObject:SetActive(false)
					end
				end
			end

			local var_49_16 = 0.001

			if var_49_13 <= arg_46_1.time_ and arg_46_1.time_ < var_49_13 + var_49_16 then
				local var_49_17 = (arg_46_1.time_ - var_49_13) / var_49_16
				local var_49_18 = Vector3.New(-77.5, -399.1, -303.3)

				var_49_12.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos106603, var_49_18, var_49_17)
			end

			if arg_46_1.time_ >= var_49_13 + var_49_16 and arg_46_1.time_ < var_49_13 + var_49_16 + arg_49_0 then
				var_49_12.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_49_19 = 0
			local var_49_20 = 0.325

			if var_49_19 < arg_46_1.time_ and arg_46_1.time_ <= var_49_19 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_21 = arg_46_1:FormatText(StoryNameCfg[32].name)

				arg_46_1.leftNameTxt_.text = var_49_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_22 = arg_46_1:GetWordFromCfg(938041011)
				local var_49_23 = arg_46_1:FormatText(var_49_22.content)

				arg_46_1.text_.text = var_49_23

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_24 = 13
				local var_49_25 = utf8.len(var_49_23)
				local var_49_26 = var_49_24 <= 0 and var_49_20 or var_49_20 * (var_49_25 / var_49_24)

				if var_49_26 > 0 and var_49_20 < var_49_26 then
					arg_46_1.talkMaxDuration = var_49_26

					if var_49_26 + var_49_19 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_26 + var_49_19
					end
				end

				arg_46_1.text_.text = var_49_23
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_27 = math.max(var_49_20, arg_46_1.talkMaxDuration)

			if var_49_19 <= arg_46_1.time_ and arg_46_1.time_ < var_49_19 + var_49_27 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_19) / var_49_27

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_19 + var_49_27 and arg_46_1.time_ < var_49_19 + var_49_27 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
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

		arg_46_1:InitPlayNodeList()
	end,
	Play938041012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 938041012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play938041013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["106603"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps106603 == nil then
				arg_50_1.var_.actorSpriteComps106603 = var_53_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.actorSpriteComps106603 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_53_1 then
							if arg_50_1.isInRecall_ then
								local var_53_4 = Mathf.Lerp(iter_53_1.color.r, arg_50_1.hightColor2.r, var_53_3)
								local var_53_5 = Mathf.Lerp(iter_53_1.color.g, arg_50_1.hightColor2.g, var_53_3)
								local var_53_6 = Mathf.Lerp(iter_53_1.color.b, arg_50_1.hightColor2.b, var_53_3)

								iter_53_1.color = Color.New(var_53_4, var_53_5, var_53_6)
							else
								local var_53_7 = Mathf.Lerp(iter_53_1.color.r, 0.5, var_53_3)

								iter_53_1.color = Color.New(var_53_7, var_53_7, var_53_7)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.actorSpriteComps106603 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_53_3 then
						if arg_50_1.isInRecall_ then
							iter_53_3.color = arg_50_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_53_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_50_1.var_.actorSpriteComps106603 = nil
			end

			local var_53_8 = 0
			local var_53_9 = 0.55

			if var_53_8 < arg_50_1.time_ and arg_50_1.time_ <= var_53_8 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_10 = arg_50_1:FormatText(StoryNameCfg[7].name)

				arg_50_1.leftNameTxt_.text = var_53_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_11 = arg_50_1:GetWordFromCfg(938041012)
				local var_53_12 = arg_50_1:FormatText(var_53_11.content)

				arg_50_1.text_.text = var_53_12

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_13 = 22
				local var_53_14 = utf8.len(var_53_12)
				local var_53_15 = var_53_13 <= 0 and var_53_9 or var_53_9 * (var_53_14 / var_53_13)

				if var_53_15 > 0 and var_53_9 < var_53_15 then
					arg_50_1.talkMaxDuration = var_53_15

					if var_53_15 + var_53_8 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_15 + var_53_8
					end
				end

				arg_50_1.text_.text = var_53_12
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_9, arg_50_1.talkMaxDuration)

			if var_53_8 <= arg_50_1.time_ and arg_50_1.time_ < var_53_8 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_8) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_8 + var_53_16 and arg_50_1.time_ < var_53_8 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play938041013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 938041013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play938041014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = "128404"

			if arg_54_1.actors_[var_57_0] == nil then
				local var_57_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_57_1) then
					local var_57_2 = Object.Instantiate(var_57_1, arg_54_1.canvasGo_.transform)

					var_57_2.transform:SetSiblingIndex(1)

					var_57_2.name = var_57_0
					var_57_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_54_1.actors_[var_57_0] = var_57_2

					local var_57_3 = var_57_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_54_1.isInRecall_ then
						for iter_57_0, iter_57_1 in ipairs(var_57_3) do
							iter_57_1.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_57_4 = arg_54_1.actors_["128404"]
			local var_57_5 = 0

			if var_57_5 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.actorSpriteComps128404 == nil then
				arg_54_1.var_.actorSpriteComps128404 = var_57_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_6 = 0.2

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_6 and not isNil(var_57_4) then
				local var_57_7 = (arg_54_1.time_ - var_57_5) / var_57_6

				if arg_54_1.var_.actorSpriteComps128404 then
					for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_57_3 then
							if arg_54_1.isInRecall_ then
								local var_57_8 = Mathf.Lerp(iter_57_3.color.r, arg_54_1.hightColor1.r, var_57_7)
								local var_57_9 = Mathf.Lerp(iter_57_3.color.g, arg_54_1.hightColor1.g, var_57_7)
								local var_57_10 = Mathf.Lerp(iter_57_3.color.b, arg_54_1.hightColor1.b, var_57_7)

								iter_57_3.color = Color.New(var_57_8, var_57_9, var_57_10)
							else
								local var_57_11 = Mathf.Lerp(iter_57_3.color.r, 1, var_57_7)

								iter_57_3.color = Color.New(var_57_11, var_57_11, var_57_11)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= var_57_5 + var_57_6 and arg_54_1.time_ < var_57_5 + var_57_6 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.actorSpriteComps128404 then
				for iter_57_4, iter_57_5 in pairs(arg_54_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_57_5 then
						if arg_54_1.isInRecall_ then
							iter_57_5.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_57_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_54_1.var_.actorSpriteComps128404 = nil
			end

			local var_57_12 = arg_54_1.actors_["128404"].transform
			local var_57_13 = 0

			if var_57_13 < arg_54_1.time_ and arg_54_1.time_ <= var_57_13 + arg_57_0 then
				arg_54_1.var_.moveOldPos128404 = var_57_12.localPosition
				var_57_12.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("128404", 2)

				local var_57_14 = var_57_12.childCount

				for iter_57_6 = 0, var_57_14 - 1 do
					local var_57_15 = var_57_12:GetChild(iter_57_6)

					if var_57_15.name == "split_4" or not string.find(var_57_15.name, "split") then
						var_57_15.gameObject:SetActive(true)
					else
						var_57_15.gameObject:SetActive(false)
					end
				end
			end

			local var_57_16 = 0.001

			if var_57_13 <= arg_54_1.time_ and arg_54_1.time_ < var_57_13 + var_57_16 then
				local var_57_17 = (arg_54_1.time_ - var_57_13) / var_57_16
				local var_57_18 = Vector3.New(-428.5, -356, -362.3)

				var_57_12.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos128404, var_57_18, var_57_17)
			end

			if arg_54_1.time_ >= var_57_13 + var_57_16 and arg_54_1.time_ < var_57_13 + var_57_16 + arg_57_0 then
				var_57_12.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_57_19 = arg_54_1.actors_["106603"].transform
			local var_57_20 = 0

			if var_57_20 < arg_54_1.time_ and arg_54_1.time_ <= var_57_20 + arg_57_0 then
				arg_54_1.var_.moveOldPos106603 = var_57_19.localPosition
				var_57_19.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("106603", 7)

				local var_57_21 = var_57_19.childCount

				for iter_57_7 = 0, var_57_21 - 1 do
					local var_57_22 = var_57_19:GetChild(iter_57_7)

					if var_57_22.name == "" or not string.find(var_57_22.name, "split") then
						var_57_22.gameObject:SetActive(true)
					else
						var_57_22.gameObject:SetActive(false)
					end
				end
			end

			local var_57_23 = 0.001

			if var_57_20 <= arg_54_1.time_ and arg_54_1.time_ < var_57_20 + var_57_23 then
				local var_57_24 = (arg_54_1.time_ - var_57_20) / var_57_23
				local var_57_25 = Vector3.New(0, -2000, 0)

				var_57_19.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos106603, var_57_25, var_57_24)
			end

			if arg_54_1.time_ >= var_57_20 + var_57_23 and arg_54_1.time_ < var_57_20 + var_57_23 + arg_57_0 then
				var_57_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_57_26 = 0
			local var_57_27 = 0.175

			if var_57_26 < arg_54_1.time_ and arg_54_1.time_ <= var_57_26 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_28 = arg_54_1:FormatText(StoryNameCfg[6].name)

				arg_54_1.leftNameTxt_.text = var_57_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_29 = arg_54_1:GetWordFromCfg(938041013)
				local var_57_30 = arg_54_1:FormatText(var_57_29.content)

				arg_54_1.text_.text = var_57_30

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_31 = 7
				local var_57_32 = utf8.len(var_57_30)
				local var_57_33 = var_57_31 <= 0 and var_57_27 or var_57_27 * (var_57_32 / var_57_31)

				if var_57_33 > 0 and var_57_27 < var_57_33 then
					arg_54_1.talkMaxDuration = var_57_33

					if var_57_33 + var_57_26 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_33 + var_57_26
					end
				end

				arg_54_1.text_.text = var_57_30
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_34 = math.max(var_57_27, arg_54_1.talkMaxDuration)

			if var_57_26 <= arg_54_1.time_ and arg_54_1.time_ < var_57_26 + var_57_34 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_26) / var_57_34

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_26 + var_57_34 and arg_54_1.time_ < var_57_26 + var_57_34 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
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

		arg_54_1:InitPlayNodeList()
	end,
	Play938041014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 938041014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play938041015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = "104902"

			if arg_58_1.actors_[var_61_0] == nil then
				local var_61_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_61_1) then
					local var_61_2 = Object.Instantiate(var_61_1, arg_58_1.canvasGo_.transform)

					var_61_2.transform:SetSiblingIndex(1)

					var_61_2.name = var_61_0
					var_61_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_58_1.actors_[var_61_0] = var_61_2

					local var_61_3 = var_61_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_58_1.isInRecall_ then
						for iter_61_0, iter_61_1 in ipairs(var_61_3) do
							iter_61_1.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_61_4 = arg_58_1.actors_["104902"]
			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.actorSpriteComps104902 == nil then
				arg_58_1.var_.actorSpriteComps104902 = var_61_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_6 = 0.2

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 and not isNil(var_61_4) then
				local var_61_7 = (arg_58_1.time_ - var_61_5) / var_61_6

				if arg_58_1.var_.actorSpriteComps104902 then
					for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_61_3 then
							if arg_58_1.isInRecall_ then
								local var_61_8 = Mathf.Lerp(iter_61_3.color.r, arg_58_1.hightColor1.r, var_61_7)
								local var_61_9 = Mathf.Lerp(iter_61_3.color.g, arg_58_1.hightColor1.g, var_61_7)
								local var_61_10 = Mathf.Lerp(iter_61_3.color.b, arg_58_1.hightColor1.b, var_61_7)

								iter_61_3.color = Color.New(var_61_8, var_61_9, var_61_10)
							else
								local var_61_11 = Mathf.Lerp(iter_61_3.color.r, 1, var_61_7)

								iter_61_3.color = Color.New(var_61_11, var_61_11, var_61_11)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.actorSpriteComps104902 then
				for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_61_5 then
						if arg_58_1.isInRecall_ then
							iter_61_5.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_61_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps104902 = nil
			end

			local var_61_12 = arg_58_1.actors_["128404"]
			local var_61_13 = 0

			if var_61_13 < arg_58_1.time_ and arg_58_1.time_ <= var_61_13 + arg_61_0 and not isNil(var_61_12) and arg_58_1.var_.actorSpriteComps128404 == nil then
				arg_58_1.var_.actorSpriteComps128404 = var_61_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_14 = 0.2

			if var_61_13 <= arg_58_1.time_ and arg_58_1.time_ < var_61_13 + var_61_14 and not isNil(var_61_12) then
				local var_61_15 = (arg_58_1.time_ - var_61_13) / var_61_14

				if arg_58_1.var_.actorSpriteComps128404 then
					for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_61_7 then
							if arg_58_1.isInRecall_ then
								local var_61_16 = Mathf.Lerp(iter_61_7.color.r, arg_58_1.hightColor2.r, var_61_15)
								local var_61_17 = Mathf.Lerp(iter_61_7.color.g, arg_58_1.hightColor2.g, var_61_15)
								local var_61_18 = Mathf.Lerp(iter_61_7.color.b, arg_58_1.hightColor2.b, var_61_15)

								iter_61_7.color = Color.New(var_61_16, var_61_17, var_61_18)
							else
								local var_61_19 = Mathf.Lerp(iter_61_7.color.r, 0.5, var_61_15)

								iter_61_7.color = Color.New(var_61_19, var_61_19, var_61_19)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= var_61_13 + var_61_14 and arg_58_1.time_ < var_61_13 + var_61_14 + arg_61_0 and not isNil(var_61_12) and arg_58_1.var_.actorSpriteComps128404 then
				for iter_61_8, iter_61_9 in pairs(arg_58_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_61_9 then
						if arg_58_1.isInRecall_ then
							iter_61_9.color = arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_61_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_58_1.var_.actorSpriteComps128404 = nil
			end

			local var_61_20 = arg_58_1.actors_["104902"].transform
			local var_61_21 = 0

			if var_61_21 < arg_58_1.time_ and arg_58_1.time_ <= var_61_21 + arg_61_0 then
				arg_58_1.var_.moveOldPos104902 = var_61_20.localPosition
				var_61_20.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("104902", 4)

				local var_61_22 = var_61_20.childCount

				for iter_61_10 = 0, var_61_22 - 1 do
					local var_61_23 = var_61_20:GetChild(iter_61_10)

					if var_61_23.name == "split_2" or not string.find(var_61_23.name, "split") then
						var_61_23.gameObject:SetActive(true)
					else
						var_61_23.gameObject:SetActive(false)
					end
				end
			end

			local var_61_24 = 0.001

			if var_61_21 <= arg_58_1.time_ and arg_58_1.time_ < var_61_21 + var_61_24 then
				local var_61_25 = (arg_58_1.time_ - var_61_21) / var_61_24
				local var_61_26 = Vector3.New(390, -335, -360)

				var_61_20.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos104902, var_61_26, var_61_25)
			end

			if arg_58_1.time_ >= var_61_21 + var_61_24 and arg_58_1.time_ < var_61_21 + var_61_24 + arg_61_0 then
				var_61_20.localPosition = Vector3.New(390, -335, -360)
			end

			local var_61_27 = 0
			local var_61_28 = 0.475

			if var_61_27 < arg_58_1.time_ and arg_58_1.time_ <= var_61_27 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_29 = arg_58_1:FormatText(StoryNameCfg[562].name)

				arg_58_1.leftNameTxt_.text = var_61_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_30 = arg_58_1:GetWordFromCfg(938041014)
				local var_61_31 = arg_58_1:FormatText(var_61_30.content)

				arg_58_1.text_.text = var_61_31

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_32 = 19
				local var_61_33 = utf8.len(var_61_31)
				local var_61_34 = var_61_32 <= 0 and var_61_28 or var_61_28 * (var_61_33 / var_61_32)

				if var_61_34 > 0 and var_61_28 < var_61_34 then
					arg_58_1.talkMaxDuration = var_61_34

					if var_61_34 + var_61_27 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_34 + var_61_27
					end
				end

				arg_58_1.text_.text = var_61_31
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_35 = math.max(var_61_28, arg_58_1.talkMaxDuration)

			if var_61_27 <= arg_58_1.time_ and arg_58_1.time_ < var_61_27 + var_61_35 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_27) / var_61_35

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_27 + var_61_35 and arg_58_1.time_ < var_61_27 + var_61_35 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play938041015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 938041015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play938041016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 1.15

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[562].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_3 = arg_62_1:GetWordFromCfg(938041015)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 46
				local var_65_6 = utf8.len(var_65_4)
				local var_65_7 = var_65_5 <= 0 and var_65_1 or var_65_1 * (var_65_6 / var_65_5)

				if var_65_7 > 0 and var_65_1 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_8 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_8 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_8

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_8 and arg_62_1.time_ < var_65_0 + var_65_8 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play938041016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 938041016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play938041017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["104902"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps104902 == nil then
				arg_66_1.var_.actorSpriteComps104902 = var_69_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_2 = 0.2

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.actorSpriteComps104902 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								local var_69_4 = Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor2.r, var_69_3)
								local var_69_5 = Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor2.g, var_69_3)
								local var_69_6 = Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor2.b, var_69_3)

								iter_69_1.color = Color.New(var_69_4, var_69_5, var_69_6)
							else
								local var_69_7 = Mathf.Lerp(iter_69_1.color.r, 0.5, var_69_3)

								iter_69_1.color = Color.New(var_69_7, var_69_7, var_69_7)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.actorSpriteComps104902 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_69_3 then
						if arg_66_1.isInRecall_ then
							iter_69_3.color = arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_69_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_66_1.var_.actorSpriteComps104902 = nil
			end

			local var_69_8 = 0
			local var_69_9 = 0.225

			if var_69_8 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_10 = arg_66_1:FormatText(StoryNameCfg[7].name)

				arg_66_1.leftNameTxt_.text = var_69_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_11 = arg_66_1:GetWordFromCfg(938041016)
				local var_69_12 = arg_66_1:FormatText(var_69_11.content)

				arg_66_1.text_.text = var_69_12

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_13 = 9
				local var_69_14 = utf8.len(var_69_12)
				local var_69_15 = var_69_13 <= 0 and var_69_9 or var_69_9 * (var_69_14 / var_69_13)

				if var_69_15 > 0 and var_69_9 < var_69_15 then
					arg_66_1.talkMaxDuration = var_69_15

					if var_69_15 + var_69_8 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_15 + var_69_8
					end
				end

				arg_66_1.text_.text = var_69_12
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_9, arg_66_1.talkMaxDuration)

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_8) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_8 + var_69_16 and arg_66_1.time_ < var_69_8 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play938041017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 938041017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play938041018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["108301"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps108301 == nil then
				arg_70_1.var_.actorSpriteComps108301 = var_73_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_2 = 0.2

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.actorSpriteComps108301 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								local var_73_4 = Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor1.r, var_73_3)
								local var_73_5 = Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor1.g, var_73_3)
								local var_73_6 = Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor1.b, var_73_3)

								iter_73_1.color = Color.New(var_73_4, var_73_5, var_73_6)
							else
								local var_73_7 = Mathf.Lerp(iter_73_1.color.r, 1, var_73_3)

								iter_73_1.color = Color.New(var_73_7, var_73_7, var_73_7)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.actorSpriteComps108301 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_73_3 then
						if arg_70_1.isInRecall_ then
							iter_73_3.color = arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_73_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_70_1.var_.actorSpriteComps108301 = nil
			end

			local var_73_8 = arg_70_1.actors_["108301"].transform
			local var_73_9 = 0

			if var_73_9 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 then
				arg_70_1.var_.moveOldPos108301 = var_73_8.localPosition
				var_73_8.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("108301", 3)

				local var_73_10 = var_73_8.childCount

				for iter_73_4 = 0, var_73_10 - 1 do
					local var_73_11 = var_73_8:GetChild(iter_73_4)

					if var_73_11.name == "split_2" or not string.find(var_73_11.name, "split") then
						var_73_11.gameObject:SetActive(true)
					else
						var_73_11.gameObject:SetActive(false)
					end
				end
			end

			local var_73_12 = 0.001

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_12 then
				local var_73_13 = (arg_70_1.time_ - var_73_9) / var_73_12
				local var_73_14 = Vector3.New(0, -360, -195)

				var_73_8.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos108301, var_73_14, var_73_13)
			end

			if arg_70_1.time_ >= var_73_9 + var_73_12 and arg_70_1.time_ < var_73_9 + var_73_12 + arg_73_0 then
				var_73_8.localPosition = Vector3.New(0, -360, -195)
			end

			local var_73_15 = arg_70_1.actors_["104902"].transform
			local var_73_16 = 0

			if var_73_16 < arg_70_1.time_ and arg_70_1.time_ <= var_73_16 + arg_73_0 then
				arg_70_1.var_.moveOldPos104902 = var_73_15.localPosition
				var_73_15.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("104902", 7)

				local var_73_17 = var_73_15.childCount

				for iter_73_5 = 0, var_73_17 - 1 do
					local var_73_18 = var_73_15:GetChild(iter_73_5)

					if var_73_18.name == "" or not string.find(var_73_18.name, "split") then
						var_73_18.gameObject:SetActive(true)
					else
						var_73_18.gameObject:SetActive(false)
					end
				end
			end

			local var_73_19 = 0.001

			if var_73_16 <= arg_70_1.time_ and arg_70_1.time_ < var_73_16 + var_73_19 then
				local var_73_20 = (arg_70_1.time_ - var_73_16) / var_73_19
				local var_73_21 = Vector3.New(0, -2000, -360)

				var_73_15.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos104902, var_73_21, var_73_20)
			end

			if arg_70_1.time_ >= var_73_16 + var_73_19 and arg_70_1.time_ < var_73_16 + var_73_19 + arg_73_0 then
				var_73_15.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_73_22 = arg_70_1.actors_["128404"].transform
			local var_73_23 = 0

			if var_73_23 < arg_70_1.time_ and arg_70_1.time_ <= var_73_23 + arg_73_0 then
				arg_70_1.var_.moveOldPos128404 = var_73_22.localPosition
				var_73_22.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("128404", 7)

				local var_73_24 = var_73_22.childCount

				for iter_73_6 = 0, var_73_24 - 1 do
					local var_73_25 = var_73_22:GetChild(iter_73_6)

					if var_73_25.name == "" or not string.find(var_73_25.name, "split") then
						var_73_25.gameObject:SetActive(true)
					else
						var_73_25.gameObject:SetActive(false)
					end
				end
			end

			local var_73_26 = 0.001

			if var_73_23 <= arg_70_1.time_ and arg_70_1.time_ < var_73_23 + var_73_26 then
				local var_73_27 = (arg_70_1.time_ - var_73_23) / var_73_26
				local var_73_28 = Vector3.New(0, -2000, 0)

				var_73_22.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos128404, var_73_28, var_73_27)
			end

			if arg_70_1.time_ >= var_73_23 + var_73_26 and arg_70_1.time_ < var_73_23 + var_73_26 + arg_73_0 then
				var_73_22.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_73_29 = 0
			local var_73_30 = 0.55

			if var_73_29 < arg_70_1.time_ and arg_70_1.time_ <= var_73_29 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_31 = arg_70_1:FormatText(StoryNameCfg[1332].name)

				arg_70_1.leftNameTxt_.text = var_73_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_32 = arg_70_1:GetWordFromCfg(938041017)
				local var_73_33 = arg_70_1:FormatText(var_73_32.content)

				arg_70_1.text_.text = var_73_33

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_34 = 22
				local var_73_35 = utf8.len(var_73_33)
				local var_73_36 = var_73_34 <= 0 and var_73_30 or var_73_30 * (var_73_35 / var_73_34)

				if var_73_36 > 0 and var_73_30 < var_73_36 then
					arg_70_1.talkMaxDuration = var_73_36

					if var_73_36 + var_73_29 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_36 + var_73_29
					end
				end

				arg_70_1.text_.text = var_73_33
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_37 = math.max(var_73_30, arg_70_1.talkMaxDuration)

			if var_73_29 <= arg_70_1.time_ and arg_70_1.time_ < var_73_29 + var_73_37 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_29) / var_73_37

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_29 + var_73_37 and arg_70_1.time_ < var_73_29 + var_73_37 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
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

		arg_70_1:InitPlayNodeList()
	end,
	Play938041018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 938041018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play938041019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["108301"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps108301 == nil then
				arg_74_1.var_.actorSpriteComps108301 = var_77_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_2 = 0.2

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.actorSpriteComps108301 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								local var_77_4 = Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor2.r, var_77_3)
								local var_77_5 = Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor2.g, var_77_3)
								local var_77_6 = Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor2.b, var_77_3)

								iter_77_1.color = Color.New(var_77_4, var_77_5, var_77_6)
							else
								local var_77_7 = Mathf.Lerp(iter_77_1.color.r, 0.5, var_77_3)

								iter_77_1.color = Color.New(var_77_7, var_77_7, var_77_7)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.actorSpriteComps108301 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_77_3 then
						if arg_74_1.isInRecall_ then
							iter_77_3.color = arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_77_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_74_1.var_.actorSpriteComps108301 = nil
			end

			local var_77_8 = 0
			local var_77_9 = 0.5

			if var_77_8 < arg_74_1.time_ and arg_74_1.time_ <= var_77_8 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_10 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_11 = arg_74_1:GetWordFromCfg(938041018)
				local var_77_12 = arg_74_1:FormatText(var_77_11.content)

				arg_74_1.text_.text = var_77_12

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_13 = 20
				local var_77_14 = utf8.len(var_77_12)
				local var_77_15 = var_77_13 <= 0 and var_77_9 or var_77_9 * (var_77_14 / var_77_13)

				if var_77_15 > 0 and var_77_9 < var_77_15 then
					arg_74_1.talkMaxDuration = var_77_15

					if var_77_15 + var_77_8 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_15 + var_77_8
					end
				end

				arg_74_1.text_.text = var_77_12
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_16 = math.max(var_77_9, arg_74_1.talkMaxDuration)

			if var_77_8 <= arg_74_1.time_ and arg_74_1.time_ < var_77_8 + var_77_16 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_8) / var_77_16

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_8 + var_77_16 and arg_74_1.time_ < var_77_8 + var_77_16 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play938041019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 938041019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play938041020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["108301"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos108301 = var_81_0.localPosition
				var_81_0.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("108301", 7)

				local var_81_2 = var_81_0.childCount

				for iter_81_0 = 0, var_81_2 - 1 do
					local var_81_3 = var_81_0:GetChild(iter_81_0)

					if var_81_3.name == "" or not string.find(var_81_3.name, "split") then
						var_81_3.gameObject:SetActive(true)
					else
						var_81_3.gameObject:SetActive(false)
					end
				end
			end

			local var_81_4 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_4 then
				local var_81_5 = (arg_78_1.time_ - var_81_1) / var_81_4
				local var_81_6 = Vector3.New(0, -2000, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos108301, var_81_6, var_81_5)
			end

			if arg_78_1.time_ >= var_81_1 + var_81_4 and arg_78_1.time_ < var_81_1 + var_81_4 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_81_7 = 1
			local var_81_8 = 1

			if var_81_7 < arg_78_1.time_ and arg_78_1.time_ <= var_81_7 + arg_81_0 then
				local var_81_9 = "play"
				local var_81_10 = "effect"

				arg_78_1:AudioAction(var_81_9, var_81_10, "se_story_side_1026", "se_story_1026_wood", "")
			end

			local var_81_11 = 0
			local var_81_12 = 0.975

			if var_81_11 < arg_78_1.time_ and arg_78_1.time_ <= var_81_11 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_13 = arg_78_1:GetWordFromCfg(938041019)
				local var_81_14 = arg_78_1:FormatText(var_81_13.content)

				arg_78_1.text_.text = var_81_14

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_15 = 39
				local var_81_16 = utf8.len(var_81_14)
				local var_81_17 = var_81_15 <= 0 and var_81_12 or var_81_12 * (var_81_16 / var_81_15)

				if var_81_17 > 0 and var_81_12 < var_81_17 then
					arg_78_1.talkMaxDuration = var_81_17

					if var_81_17 + var_81_11 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_17 + var_81_11
					end
				end

				arg_78_1.text_.text = var_81_14
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_18 = math.max(var_81_12, arg_78_1.talkMaxDuration)

			if var_81_11 <= arg_78_1.time_ and arg_78_1.time_ < var_81_11 + var_81_18 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_11) / var_81_18

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_11 + var_81_18 and arg_78_1.time_ < var_81_11 + var_81_18 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play938041020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 938041020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play938041021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = "10183"

			if arg_82_1.actors_[var_85_0] == nil then
				local var_85_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10183")

				if not isNil(var_85_1) then
					local var_85_2 = Object.Instantiate(var_85_1, arg_82_1.canvasGo_.transform)

					var_85_2.transform:SetSiblingIndex(1)

					var_85_2.name = var_85_0
					var_85_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_82_1.actors_[var_85_0] = var_85_2

					local var_85_3 = var_85_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_82_1.isInRecall_ then
						for iter_85_0, iter_85_1 in ipairs(var_85_3) do
							iter_85_1.color = arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_85_4 = arg_82_1.actors_["10183"]
			local var_85_5 = 0

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.actorSpriteComps10183 == nil then
				arg_82_1.var_.actorSpriteComps10183 = var_85_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_6 = 0.2

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_6 and not isNil(var_85_4) then
				local var_85_7 = (arg_82_1.time_ - var_85_5) / var_85_6

				if arg_82_1.var_.actorSpriteComps10183 then
					for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_85_3 then
							if arg_82_1.isInRecall_ then
								local var_85_8 = Mathf.Lerp(iter_85_3.color.r, arg_82_1.hightColor1.r, var_85_7)
								local var_85_9 = Mathf.Lerp(iter_85_3.color.g, arg_82_1.hightColor1.g, var_85_7)
								local var_85_10 = Mathf.Lerp(iter_85_3.color.b, arg_82_1.hightColor1.b, var_85_7)

								iter_85_3.color = Color.New(var_85_8, var_85_9, var_85_10)
							else
								local var_85_11 = Mathf.Lerp(iter_85_3.color.r, 1, var_85_7)

								iter_85_3.color = Color.New(var_85_11, var_85_11, var_85_11)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= var_85_5 + var_85_6 and arg_82_1.time_ < var_85_5 + var_85_6 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.actorSpriteComps10183 then
				for iter_85_4, iter_85_5 in pairs(arg_82_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_85_5 then
						if arg_82_1.isInRecall_ then
							iter_85_5.color = arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_85_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_82_1.var_.actorSpriteComps10183 = nil
			end

			local var_85_12 = arg_82_1.actors_["10183"].transform
			local var_85_13 = 0

			if var_85_13 < arg_82_1.time_ and arg_82_1.time_ <= var_85_13 + arg_85_0 then
				arg_82_1.var_.moveOldPos10183 = var_85_12.localPosition
				var_85_12.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("10183", 3)

				local var_85_14 = var_85_12.childCount

				for iter_85_6 = 0, var_85_14 - 1 do
					local var_85_15 = var_85_12:GetChild(iter_85_6)

					if var_85_15.name == "" or not string.find(var_85_15.name, "split") then
						var_85_15.gameObject:SetActive(true)
					else
						var_85_15.gameObject:SetActive(false)
					end
				end
			end

			local var_85_16 = 0.001

			if var_85_13 <= arg_82_1.time_ and arg_82_1.time_ < var_85_13 + var_85_16 then
				local var_85_17 = (arg_82_1.time_ - var_85_13) / var_85_16
				local var_85_18 = Vector3.New(0, -475, -325)

				var_85_12.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10183, var_85_18, var_85_17)
			end

			if arg_82_1.time_ >= var_85_13 + var_85_16 and arg_82_1.time_ < var_85_13 + var_85_16 + arg_85_0 then
				var_85_12.localPosition = Vector3.New(0, -475, -325)
			end

			local var_85_19 = arg_82_1.actors_["10183"]
			local var_85_20 = 0

			if var_85_20 < arg_82_1.time_ and arg_82_1.time_ <= var_85_20 + arg_85_0 then
				local var_85_21 = var_85_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_85_21 then
					arg_82_1.var_.alphaOldValue10183 = var_85_21.alpha
					arg_82_1.var_.characterEffect10183 = var_85_21
				end

				arg_82_1.var_.alphaOldValue10183 = 0
			end

			local var_85_22 = 0.5

			if var_85_20 <= arg_82_1.time_ and arg_82_1.time_ < var_85_20 + var_85_22 then
				local var_85_23 = (arg_82_1.time_ - var_85_20) / var_85_22
				local var_85_24 = Mathf.Lerp(arg_82_1.var_.alphaOldValue10183, 1, var_85_23)

				if arg_82_1.var_.characterEffect10183 then
					arg_82_1.var_.characterEffect10183.alpha = var_85_24
				end
			end

			if arg_82_1.time_ >= var_85_20 + var_85_22 and arg_82_1.time_ < var_85_20 + var_85_22 + arg_85_0 and arg_82_1.var_.characterEffect10183 then
				arg_82_1.var_.characterEffect10183.alpha = 1
			end

			local var_85_25 = 0
			local var_85_26 = 0.475

			if var_85_25 < arg_82_1.time_ and arg_82_1.time_ <= var_85_25 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_27 = arg_82_1:FormatText(StoryNameCfg[1562].name)

				arg_82_1.leftNameTxt_.text = var_85_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_28 = arg_82_1:GetWordFromCfg(938041020)
				local var_85_29 = arg_82_1:FormatText(var_85_28.content)

				arg_82_1.text_.text = var_85_29

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_30 = 19
				local var_85_31 = utf8.len(var_85_29)
				local var_85_32 = var_85_30 <= 0 and var_85_26 or var_85_26 * (var_85_31 / var_85_30)

				if var_85_32 > 0 and var_85_26 < var_85_32 then
					arg_82_1.talkMaxDuration = var_85_32

					if var_85_32 + var_85_25 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_32 + var_85_25
					end
				end

				arg_82_1.text_.text = var_85_29
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_33 = math.max(var_85_26, arg_82_1.talkMaxDuration)

			if var_85_25 <= arg_82_1.time_ and arg_82_1.time_ < var_85_25 + var_85_33 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_25) / var_85_33

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_25 + var_85_33 and arg_82_1.time_ < var_85_25 + var_85_33 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play938041021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 938041021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play938041022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10183"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10183 == nil then
				arg_86_1.var_.actorSpriteComps10183 = var_89_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.actorSpriteComps10183 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								local var_89_4 = Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor2.r, var_89_3)
								local var_89_5 = Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor2.g, var_89_3)
								local var_89_6 = Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor2.b, var_89_3)

								iter_89_1.color = Color.New(var_89_4, var_89_5, var_89_6)
							else
								local var_89_7 = Mathf.Lerp(iter_89_1.color.r, 0.5, var_89_3)

								iter_89_1.color = Color.New(var_89_7, var_89_7, var_89_7)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.actorSpriteComps10183 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_89_3 then
						if arg_86_1.isInRecall_ then
							iter_89_3.color = arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_89_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_86_1.var_.actorSpriteComps10183 = nil
			end

			local var_89_8 = arg_86_1.actors_["10183"].transform
			local var_89_9 = 0

			if var_89_9 < arg_86_1.time_ and arg_86_1.time_ <= var_89_9 + arg_89_0 then
				arg_86_1.var_.moveOldPos10183 = var_89_8.localPosition
				var_89_8.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10183", 7)

				local var_89_10 = var_89_8.childCount

				for iter_89_4 = 0, var_89_10 - 1 do
					local var_89_11 = var_89_8:GetChild(iter_89_4)

					if var_89_11.name == "" or not string.find(var_89_11.name, "split") then
						var_89_11.gameObject:SetActive(true)
					else
						var_89_11.gameObject:SetActive(false)
					end
				end
			end

			local var_89_12 = 0.001

			if var_89_9 <= arg_86_1.time_ and arg_86_1.time_ < var_89_9 + var_89_12 then
				local var_89_13 = (arg_86_1.time_ - var_89_9) / var_89_12
				local var_89_14 = Vector3.New(0, -2000, 0)

				var_89_8.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10183, var_89_14, var_89_13)
			end

			if arg_86_1.time_ >= var_89_9 + var_89_12 and arg_86_1.time_ < var_89_9 + var_89_12 + arg_89_0 then
				var_89_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_89_15 = 0
			local var_89_16 = 1.5

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_17 = arg_86_1:GetWordFromCfg(938041021)
				local var_89_18 = arg_86_1:FormatText(var_89_17.content)

				arg_86_1.text_.text = var_89_18

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_19 = 60
				local var_89_20 = utf8.len(var_89_18)
				local var_89_21 = var_89_19 <= 0 and var_89_16 or var_89_16 * (var_89_20 / var_89_19)

				if var_89_21 > 0 and var_89_16 < var_89_21 then
					arg_86_1.talkMaxDuration = var_89_21

					if var_89_21 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_21 + var_89_15
					end
				end

				arg_86_1.text_.text = var_89_18
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_22 = math.max(var_89_16, arg_86_1.talkMaxDuration)

			if var_89_15 <= arg_86_1.time_ and arg_86_1.time_ < var_89_15 + var_89_22 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_15) / var_89_22

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_15 + var_89_22 and arg_86_1.time_ < var_89_15 + var_89_22 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play938041022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 938041022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play938041023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["128404"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps128404 == nil then
				arg_90_1.var_.actorSpriteComps128404 = var_93_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_2 = 0.2

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.actorSpriteComps128404 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								local var_93_4 = Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, var_93_3)
								local var_93_5 = Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, var_93_3)
								local var_93_6 = Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, var_93_3)

								iter_93_1.color = Color.New(var_93_4, var_93_5, var_93_6)
							else
								local var_93_7 = Mathf.Lerp(iter_93_1.color.r, 1, var_93_3)

								iter_93_1.color = Color.New(var_93_7, var_93_7, var_93_7)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.actorSpriteComps128404 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_93_3 then
						if arg_90_1.isInRecall_ then
							iter_93_3.color = arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_93_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_90_1.var_.actorSpriteComps128404 = nil
			end

			local var_93_8 = arg_90_1.actors_["128404"].transform
			local var_93_9 = 0

			if var_93_9 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 then
				arg_90_1.var_.moveOldPos128404 = var_93_8.localPosition
				var_93_8.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("128404", 3)

				local var_93_10 = var_93_8.childCount

				for iter_93_4 = 0, var_93_10 - 1 do
					local var_93_11 = var_93_8:GetChild(iter_93_4)

					if var_93_11.name == "split_4" or not string.find(var_93_11.name, "split") then
						var_93_11.gameObject:SetActive(true)
					else
						var_93_11.gameObject:SetActive(false)
					end
				end
			end

			local var_93_12 = 0.001

			if var_93_9 <= arg_90_1.time_ and arg_90_1.time_ < var_93_9 + var_93_12 then
				local var_93_13 = (arg_90_1.time_ - var_93_9) / var_93_12
				local var_93_14 = Vector3.New(-16.1, -362, -375)

				var_93_8.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos128404, var_93_14, var_93_13)
			end

			if arg_90_1.time_ >= var_93_9 + var_93_12 and arg_90_1.time_ < var_93_9 + var_93_12 + arg_93_0 then
				var_93_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_93_15 = 0
			local var_93_16 = 0.5

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_17 = arg_90_1:FormatText(StoryNameCfg[6].name)

				arg_90_1.leftNameTxt_.text = var_93_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_18 = arg_90_1:GetWordFromCfg(938041022)
				local var_93_19 = arg_90_1:FormatText(var_93_18.content)

				arg_90_1.text_.text = var_93_19

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_20 = 20
				local var_93_21 = utf8.len(var_93_19)
				local var_93_22 = var_93_20 <= 0 and var_93_16 or var_93_16 * (var_93_21 / var_93_20)

				if var_93_22 > 0 and var_93_16 < var_93_22 then
					arg_90_1.talkMaxDuration = var_93_22

					if var_93_22 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_22 + var_93_15
					end
				end

				arg_90_1.text_.text = var_93_19
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_23 = math.max(var_93_16, arg_90_1.talkMaxDuration)

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_23 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_15) / var_93_23

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_15 + var_93_23 and arg_90_1.time_ < var_93_15 + var_93_23 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play938041023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 938041023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play938041024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["128404"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps128404 == nil then
				arg_94_1.var_.actorSpriteComps128404 = var_97_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_2 = 0.2

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.actorSpriteComps128404 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								local var_97_4 = Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor2.r, var_97_3)
								local var_97_5 = Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor2.g, var_97_3)
								local var_97_6 = Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor2.b, var_97_3)

								iter_97_1.color = Color.New(var_97_4, var_97_5, var_97_6)
							else
								local var_97_7 = Mathf.Lerp(iter_97_1.color.r, 0.5, var_97_3)

								iter_97_1.color = Color.New(var_97_7, var_97_7, var_97_7)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.actorSpriteComps128404 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_97_3 then
						if arg_94_1.isInRecall_ then
							iter_97_3.color = arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_97_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_94_1.var_.actorSpriteComps128404 = nil
			end

			local var_97_8 = 0
			local var_97_9 = 0.7

			if var_97_8 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_10 = arg_94_1:FormatText(StoryNameCfg[7].name)

				arg_94_1.leftNameTxt_.text = var_97_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_11 = arg_94_1:GetWordFromCfg(938041023)
				local var_97_12 = arg_94_1:FormatText(var_97_11.content)

				arg_94_1.text_.text = var_97_12

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 28
				local var_97_14 = utf8.len(var_97_12)
				local var_97_15 = var_97_13 <= 0 and var_97_9 or var_97_9 * (var_97_14 / var_97_13)

				if var_97_15 > 0 and var_97_9 < var_97_15 then
					arg_94_1.talkMaxDuration = var_97_15

					if var_97_15 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_15 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_12
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_16 and arg_94_1.time_ < var_97_8 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play938041024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 938041024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play938041025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["128404"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps128404 == nil then
				arg_98_1.var_.actorSpriteComps128404 = var_101_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_2 = 0.2

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.actorSpriteComps128404 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_101_1 then
							if arg_98_1.isInRecall_ then
								local var_101_4 = Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor1.r, var_101_3)
								local var_101_5 = Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor1.g, var_101_3)
								local var_101_6 = Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor1.b, var_101_3)

								iter_101_1.color = Color.New(var_101_4, var_101_5, var_101_6)
							else
								local var_101_7 = Mathf.Lerp(iter_101_1.color.r, 1, var_101_3)

								iter_101_1.color = Color.New(var_101_7, var_101_7, var_101_7)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.actorSpriteComps128404 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_101_3 then
						if arg_98_1.isInRecall_ then
							iter_101_3.color = arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_101_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_98_1.var_.actorSpriteComps128404 = nil
			end

			local var_101_8 = arg_98_1.actors_["128404"].transform
			local var_101_9 = 0

			if var_101_9 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 then
				arg_98_1.var_.moveOldPos128404 = var_101_8.localPosition
				var_101_8.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("128404", 3)

				local var_101_10 = var_101_8.childCount

				for iter_101_4 = 0, var_101_10 - 1 do
					local var_101_11 = var_101_8:GetChild(iter_101_4)

					if var_101_11.name == "split_5" or not string.find(var_101_11.name, "split") then
						var_101_11.gameObject:SetActive(true)
					else
						var_101_11.gameObject:SetActive(false)
					end
				end
			end

			local var_101_12 = 0.001

			if var_101_9 <= arg_98_1.time_ and arg_98_1.time_ < var_101_9 + var_101_12 then
				local var_101_13 = (arg_98_1.time_ - var_101_9) / var_101_12
				local var_101_14 = Vector3.New(-16.1, -362, -375)

				var_101_8.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos128404, var_101_14, var_101_13)
			end

			if arg_98_1.time_ >= var_101_9 + var_101_12 and arg_98_1.time_ < var_101_9 + var_101_12 + arg_101_0 then
				var_101_8.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_101_15 = 0
			local var_101_16 = 0.575

			if var_101_15 < arg_98_1.time_ and arg_98_1.time_ <= var_101_15 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_17 = arg_98_1:FormatText(StoryNameCfg[6].name)

				arg_98_1.leftNameTxt_.text = var_101_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_18 = arg_98_1:GetWordFromCfg(938041024)
				local var_101_19 = arg_98_1:FormatText(var_101_18.content)

				arg_98_1.text_.text = var_101_19

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_20 = 23
				local var_101_21 = utf8.len(var_101_19)
				local var_101_22 = var_101_20 <= 0 and var_101_16 or var_101_16 * (var_101_21 / var_101_20)

				if var_101_22 > 0 and var_101_16 < var_101_22 then
					arg_98_1.talkMaxDuration = var_101_22

					if var_101_22 + var_101_15 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_22 + var_101_15
					end
				end

				arg_98_1.text_.text = var_101_19
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_23 = math.max(var_101_16, arg_98_1.talkMaxDuration)

			if var_101_15 <= arg_98_1.time_ and arg_98_1.time_ < var_101_15 + var_101_23 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_15) / var_101_23

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_15 + var_101_23 and arg_98_1.time_ < var_101_15 + var_101_23 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play938041025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 938041025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play938041026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["106603"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps106603 == nil then
				arg_102_1.var_.actorSpriteComps106603 = var_105_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_2 = 0.2

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.actorSpriteComps106603 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								local var_105_4 = Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor1.r, var_105_3)
								local var_105_5 = Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor1.g, var_105_3)
								local var_105_6 = Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor1.b, var_105_3)

								iter_105_1.color = Color.New(var_105_4, var_105_5, var_105_6)
							else
								local var_105_7 = Mathf.Lerp(iter_105_1.color.r, 1, var_105_3)

								iter_105_1.color = Color.New(var_105_7, var_105_7, var_105_7)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.actorSpriteComps106603 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_105_3 then
						if arg_102_1.isInRecall_ then
							iter_105_3.color = arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_105_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps106603 = nil
			end

			local var_105_8 = arg_102_1.actors_["128404"]
			local var_105_9 = 0

			if var_105_9 < arg_102_1.time_ and arg_102_1.time_ <= var_105_9 + arg_105_0 and not isNil(var_105_8) and arg_102_1.var_.actorSpriteComps128404 == nil then
				arg_102_1.var_.actorSpriteComps128404 = var_105_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_10 = 0.2

			if var_105_9 <= arg_102_1.time_ and arg_102_1.time_ < var_105_9 + var_105_10 and not isNil(var_105_8) then
				local var_105_11 = (arg_102_1.time_ - var_105_9) / var_105_10

				if arg_102_1.var_.actorSpriteComps128404 then
					for iter_105_4, iter_105_5 in pairs(arg_102_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_105_5 then
							if arg_102_1.isInRecall_ then
								local var_105_12 = Mathf.Lerp(iter_105_5.color.r, arg_102_1.hightColor2.r, var_105_11)
								local var_105_13 = Mathf.Lerp(iter_105_5.color.g, arg_102_1.hightColor2.g, var_105_11)
								local var_105_14 = Mathf.Lerp(iter_105_5.color.b, arg_102_1.hightColor2.b, var_105_11)

								iter_105_5.color = Color.New(var_105_12, var_105_13, var_105_14)
							else
								local var_105_15 = Mathf.Lerp(iter_105_5.color.r, 0.5, var_105_11)

								iter_105_5.color = Color.New(var_105_15, var_105_15, var_105_15)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= var_105_9 + var_105_10 and arg_102_1.time_ < var_105_9 + var_105_10 + arg_105_0 and not isNil(var_105_8) and arg_102_1.var_.actorSpriteComps128404 then
				for iter_105_6, iter_105_7 in pairs(arg_102_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_105_7 then
						if arg_102_1.isInRecall_ then
							iter_105_7.color = arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_105_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_102_1.var_.actorSpriteComps128404 = nil
			end

			local var_105_16 = arg_102_1.actors_["106603"].transform
			local var_105_17 = 0

			if var_105_17 < arg_102_1.time_ and arg_102_1.time_ <= var_105_17 + arg_105_0 then
				arg_102_1.var_.moveOldPos106603 = var_105_16.localPosition
				var_105_16.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("106603", 2)

				local var_105_18 = var_105_16.childCount

				for iter_105_8 = 0, var_105_18 - 1 do
					local var_105_19 = var_105_16:GetChild(iter_105_8)

					if var_105_19.name == "" or not string.find(var_105_19.name, "split") then
						var_105_19.gameObject:SetActive(true)
					else
						var_105_19.gameObject:SetActive(false)
					end
				end
			end

			local var_105_20 = 0.001

			if var_105_17 <= arg_102_1.time_ and arg_102_1.time_ < var_105_17 + var_105_20 then
				local var_105_21 = (arg_102_1.time_ - var_105_17) / var_105_20
				local var_105_22 = Vector3.New(-510.9, -399.1, -303.3)

				var_105_16.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos106603, var_105_22, var_105_21)
			end

			if arg_102_1.time_ >= var_105_17 + var_105_20 and arg_102_1.time_ < var_105_17 + var_105_20 + arg_105_0 then
				var_105_16.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_105_23 = arg_102_1.actors_["128404"].transform
			local var_105_24 = 0

			if var_105_24 < arg_102_1.time_ and arg_102_1.time_ <= var_105_24 + arg_105_0 then
				arg_102_1.var_.moveOldPos128404 = var_105_23.localPosition
				var_105_23.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("128404", 7)

				local var_105_25 = var_105_23.childCount

				for iter_105_9 = 0, var_105_25 - 1 do
					local var_105_26 = var_105_23:GetChild(iter_105_9)

					if var_105_26.name == "" or not string.find(var_105_26.name, "split") then
						var_105_26.gameObject:SetActive(true)
					else
						var_105_26.gameObject:SetActive(false)
					end
				end
			end

			local var_105_27 = 0.001

			if var_105_24 <= arg_102_1.time_ and arg_102_1.time_ < var_105_24 + var_105_27 then
				local var_105_28 = (arg_102_1.time_ - var_105_24) / var_105_27
				local var_105_29 = Vector3.New(0, -2000, 0)

				var_105_23.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos128404, var_105_29, var_105_28)
			end

			if arg_102_1.time_ >= var_105_24 + var_105_27 and arg_102_1.time_ < var_105_24 + var_105_27 + arg_105_0 then
				var_105_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_105_30 = 0
			local var_105_31 = 0.325

			if var_105_30 < arg_102_1.time_ and arg_102_1.time_ <= var_105_30 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_32 = arg_102_1:FormatText(StoryNameCfg[32].name)

				arg_102_1.leftNameTxt_.text = var_105_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_33 = arg_102_1:GetWordFromCfg(938041025)
				local var_105_34 = arg_102_1:FormatText(var_105_33.content)

				arg_102_1.text_.text = var_105_34

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_35 = 13
				local var_105_36 = utf8.len(var_105_34)
				local var_105_37 = var_105_35 <= 0 and var_105_31 or var_105_31 * (var_105_36 / var_105_35)

				if var_105_37 > 0 and var_105_31 < var_105_37 then
					arg_102_1.talkMaxDuration = var_105_37

					if var_105_37 + var_105_30 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_37 + var_105_30
					end
				end

				arg_102_1.text_.text = var_105_34
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_38 = math.max(var_105_31, arg_102_1.talkMaxDuration)

			if var_105_30 <= arg_102_1.time_ and arg_102_1.time_ < var_105_30 + var_105_38 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_30) / var_105_38

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_30 + var_105_38 and arg_102_1.time_ < var_105_30 + var_105_38 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play938041026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 938041026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play938041027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["108301"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps108301 == nil then
				arg_106_1.var_.actorSpriteComps108301 = var_109_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_2 = 0.2

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.actorSpriteComps108301 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								local var_109_4 = Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, var_109_3)
								local var_109_5 = Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, var_109_3)
								local var_109_6 = Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, var_109_3)

								iter_109_1.color = Color.New(var_109_4, var_109_5, var_109_6)
							else
								local var_109_7 = Mathf.Lerp(iter_109_1.color.r, 1, var_109_3)

								iter_109_1.color = Color.New(var_109_7, var_109_7, var_109_7)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.actorSpriteComps108301 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_109_3 then
						if arg_106_1.isInRecall_ then
							iter_109_3.color = arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_109_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps108301 = nil
			end

			local var_109_8 = arg_106_1.actors_["106603"]
			local var_109_9 = 0

			if var_109_9 < arg_106_1.time_ and arg_106_1.time_ <= var_109_9 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.actorSpriteComps106603 == nil then
				arg_106_1.var_.actorSpriteComps106603 = var_109_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_10 = 0.2

			if var_109_9 <= arg_106_1.time_ and arg_106_1.time_ < var_109_9 + var_109_10 and not isNil(var_109_8) then
				local var_109_11 = (arg_106_1.time_ - var_109_9) / var_109_10

				if arg_106_1.var_.actorSpriteComps106603 then
					for iter_109_4, iter_109_5 in pairs(arg_106_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_109_5 then
							if arg_106_1.isInRecall_ then
								local var_109_12 = Mathf.Lerp(iter_109_5.color.r, arg_106_1.hightColor2.r, var_109_11)
								local var_109_13 = Mathf.Lerp(iter_109_5.color.g, arg_106_1.hightColor2.g, var_109_11)
								local var_109_14 = Mathf.Lerp(iter_109_5.color.b, arg_106_1.hightColor2.b, var_109_11)

								iter_109_5.color = Color.New(var_109_12, var_109_13, var_109_14)
							else
								local var_109_15 = Mathf.Lerp(iter_109_5.color.r, 0.5, var_109_11)

								iter_109_5.color = Color.New(var_109_15, var_109_15, var_109_15)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= var_109_9 + var_109_10 and arg_106_1.time_ < var_109_9 + var_109_10 + arg_109_0 and not isNil(var_109_8) and arg_106_1.var_.actorSpriteComps106603 then
				for iter_109_6, iter_109_7 in pairs(arg_106_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_109_7 then
						if arg_106_1.isInRecall_ then
							iter_109_7.color = arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_109_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_106_1.var_.actorSpriteComps106603 = nil
			end

			local var_109_16 = arg_106_1.actors_["108301"].transform
			local var_109_17 = 0

			if var_109_17 < arg_106_1.time_ and arg_106_1.time_ <= var_109_17 + arg_109_0 then
				arg_106_1.var_.moveOldPos108301 = var_109_16.localPosition
				var_109_16.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("108301", 4)

				local var_109_18 = var_109_16.childCount

				for iter_109_8 = 0, var_109_18 - 1 do
					local var_109_19 = var_109_16:GetChild(iter_109_8)

					if var_109_19.name == "split_5" or not string.find(var_109_19.name, "split") then
						var_109_19.gameObject:SetActive(true)
					else
						var_109_19.gameObject:SetActive(false)
					end
				end
			end

			local var_109_20 = 0.001

			if var_109_17 <= arg_106_1.time_ and arg_106_1.time_ < var_109_17 + var_109_20 then
				local var_109_21 = (arg_106_1.time_ - var_109_17) / var_109_20
				local var_109_22 = Vector3.New(460, -360, -195)

				var_109_16.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos108301, var_109_22, var_109_21)
			end

			if arg_106_1.time_ >= var_109_17 + var_109_20 and arg_106_1.time_ < var_109_17 + var_109_20 + arg_109_0 then
				var_109_16.localPosition = Vector3.New(460, -360, -195)
			end

			local var_109_23 = 0
			local var_109_24 = 0.675

			if var_109_23 < arg_106_1.time_ and arg_106_1.time_ <= var_109_23 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_25 = arg_106_1:FormatText(StoryNameCfg[1332].name)

				arg_106_1.leftNameTxt_.text = var_109_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_26 = arg_106_1:GetWordFromCfg(938041026)
				local var_109_27 = arg_106_1:FormatText(var_109_26.content)

				arg_106_1.text_.text = var_109_27

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_28 = 27
				local var_109_29 = utf8.len(var_109_27)
				local var_109_30 = var_109_28 <= 0 and var_109_24 or var_109_24 * (var_109_29 / var_109_28)

				if var_109_30 > 0 and var_109_24 < var_109_30 then
					arg_106_1.talkMaxDuration = var_109_30

					if var_109_30 + var_109_23 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_30 + var_109_23
					end
				end

				arg_106_1.text_.text = var_109_27
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_31 = math.max(var_109_24, arg_106_1.talkMaxDuration)

			if var_109_23 <= arg_106_1.time_ and arg_106_1.time_ < var_109_23 + var_109_31 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_23) / var_109_31

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_23 + var_109_31 and arg_106_1.time_ < var_109_23 + var_109_31 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play938041027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 938041027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play938041028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["108301"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps108301 == nil then
				arg_110_1.var_.actorSpriteComps108301 = var_113_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_2 = 0.2

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.actorSpriteComps108301 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								local var_113_4 = Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor2.r, var_113_3)
								local var_113_5 = Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor2.g, var_113_3)
								local var_113_6 = Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor2.b, var_113_3)

								iter_113_1.color = Color.New(var_113_4, var_113_5, var_113_6)
							else
								local var_113_7 = Mathf.Lerp(iter_113_1.color.r, 0.5, var_113_3)

								iter_113_1.color = Color.New(var_113_7, var_113_7, var_113_7)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.actorSpriteComps108301 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_113_3 then
						if arg_110_1.isInRecall_ then
							iter_113_3.color = arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_113_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_110_1.var_.actorSpriteComps108301 = nil
			end

			local var_113_8 = 0
			local var_113_9 = 0.5

			if var_113_8 < arg_110_1.time_ and arg_110_1.time_ <= var_113_8 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_10 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_11 = arg_110_1:GetWordFromCfg(938041027)
				local var_113_12 = arg_110_1:FormatText(var_113_11.content)

				arg_110_1.text_.text = var_113_12

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_13 = 20
				local var_113_14 = utf8.len(var_113_12)
				local var_113_15 = var_113_13 <= 0 and var_113_9 or var_113_9 * (var_113_14 / var_113_13)

				if var_113_15 > 0 and var_113_9 < var_113_15 then
					arg_110_1.talkMaxDuration = var_113_15

					if var_113_15 + var_113_8 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_15 + var_113_8
					end
				end

				arg_110_1.text_.text = var_113_12
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_16 = math.max(var_113_9, arg_110_1.talkMaxDuration)

			if var_113_8 <= arg_110_1.time_ and arg_110_1.time_ < var_113_8 + var_113_16 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_8) / var_113_16

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_8 + var_113_16 and arg_110_1.time_ < var_113_8 + var_113_16 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play938041028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 938041028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play938041029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["104902"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps104902 == nil then
				arg_114_1.var_.actorSpriteComps104902 = var_117_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.actorSpriteComps104902 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								local var_117_4 = Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor1.r, var_117_3)
								local var_117_5 = Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor1.g, var_117_3)
								local var_117_6 = Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor1.b, var_117_3)

								iter_117_1.color = Color.New(var_117_4, var_117_5, var_117_6)
							else
								local var_117_7 = Mathf.Lerp(iter_117_1.color.r, 1, var_117_3)

								iter_117_1.color = Color.New(var_117_7, var_117_7, var_117_7)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.actorSpriteComps104902 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_117_3 then
						if arg_114_1.isInRecall_ then
							iter_117_3.color = arg_114_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_117_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_114_1.var_.actorSpriteComps104902 = nil
			end

			local var_117_8 = arg_114_1.actors_["108301"].transform
			local var_117_9 = 0

			if var_117_9 < arg_114_1.time_ and arg_114_1.time_ <= var_117_9 + arg_117_0 then
				arg_114_1.var_.moveOldPos108301 = var_117_8.localPosition
				var_117_8.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("108301", 7)

				local var_117_10 = var_117_8.childCount

				for iter_117_4 = 0, var_117_10 - 1 do
					local var_117_11 = var_117_8:GetChild(iter_117_4)

					if var_117_11.name == "" or not string.find(var_117_11.name, "split") then
						var_117_11.gameObject:SetActive(true)
					else
						var_117_11.gameObject:SetActive(false)
					end
				end
			end

			local var_117_12 = 0.001

			if var_117_9 <= arg_114_1.time_ and arg_114_1.time_ < var_117_9 + var_117_12 then
				local var_117_13 = (arg_114_1.time_ - var_117_9) / var_117_12
				local var_117_14 = Vector3.New(0, -2000, 0)

				var_117_8.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos108301, var_117_14, var_117_13)
			end

			if arg_114_1.time_ >= var_117_9 + var_117_12 and arg_114_1.time_ < var_117_9 + var_117_12 + arg_117_0 then
				var_117_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_15 = arg_114_1.actors_["106603"].transform
			local var_117_16 = 0

			if var_117_16 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.var_.moveOldPos106603 = var_117_15.localPosition
				var_117_15.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("106603", 7)

				local var_117_17 = var_117_15.childCount

				for iter_117_5 = 0, var_117_17 - 1 do
					local var_117_18 = var_117_15:GetChild(iter_117_5)

					if var_117_18.name == "" or not string.find(var_117_18.name, "split") then
						var_117_18.gameObject:SetActive(true)
					else
						var_117_18.gameObject:SetActive(false)
					end
				end
			end

			local var_117_19 = 0.001

			if var_117_16 <= arg_114_1.time_ and arg_114_1.time_ < var_117_16 + var_117_19 then
				local var_117_20 = (arg_114_1.time_ - var_117_16) / var_117_19
				local var_117_21 = Vector3.New(0, -2000, 0)

				var_117_15.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos106603, var_117_21, var_117_20)
			end

			if arg_114_1.time_ >= var_117_16 + var_117_19 and arg_114_1.time_ < var_117_16 + var_117_19 + arg_117_0 then
				var_117_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_22 = arg_114_1.actors_["104902"].transform
			local var_117_23 = 0

			if var_117_23 < arg_114_1.time_ and arg_114_1.time_ <= var_117_23 + arg_117_0 then
				arg_114_1.var_.moveOldPos104902 = var_117_22.localPosition
				var_117_22.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("104902", 2)

				local var_117_24 = var_117_22.childCount

				for iter_117_6 = 0, var_117_24 - 1 do
					local var_117_25 = var_117_22:GetChild(iter_117_6)

					if var_117_25.name == "" or not string.find(var_117_25.name, "split") then
						var_117_25.gameObject:SetActive(true)
					else
						var_117_25.gameObject:SetActive(false)
					end
				end
			end

			local var_117_26 = 0.001

			if var_117_23 <= arg_114_1.time_ and arg_114_1.time_ < var_117_23 + var_117_26 then
				local var_117_27 = (arg_114_1.time_ - var_117_23) / var_117_26
				local var_117_28 = Vector3.New(-390, -335, -360)

				var_117_22.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos104902, var_117_28, var_117_27)
			end

			if arg_114_1.time_ >= var_117_23 + var_117_26 and arg_114_1.time_ < var_117_23 + var_117_26 + arg_117_0 then
				var_117_22.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_117_29 = 0
			local var_117_30 = 0.875

			if var_117_29 < arg_114_1.time_ and arg_114_1.time_ <= var_117_29 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_31 = arg_114_1:FormatText(StoryNameCfg[562].name)

				arg_114_1.leftNameTxt_.text = var_117_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_32 = arg_114_1:GetWordFromCfg(938041028)
				local var_117_33 = arg_114_1:FormatText(var_117_32.content)

				arg_114_1.text_.text = var_117_33

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_34 = 35
				local var_117_35 = utf8.len(var_117_33)
				local var_117_36 = var_117_34 <= 0 and var_117_30 or var_117_30 * (var_117_35 / var_117_34)

				if var_117_36 > 0 and var_117_30 < var_117_36 then
					arg_114_1.talkMaxDuration = var_117_36

					if var_117_36 + var_117_29 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_36 + var_117_29
					end
				end

				arg_114_1.text_.text = var_117_33
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_37 = math.max(var_117_30, arg_114_1.talkMaxDuration)

			if var_117_29 <= arg_114_1.time_ and arg_114_1.time_ < var_117_29 + var_117_37 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_29) / var_117_37

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_29 + var_117_37 and arg_114_1.time_ < var_117_29 + var_117_37 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
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
			},
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play938041029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 938041029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play938041030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["104902"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps104902 == nil then
				arg_118_1.var_.actorSpriteComps104902 = var_121_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_2 = 0.2

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.actorSpriteComps104902 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								local var_121_4 = Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor2.r, var_121_3)
								local var_121_5 = Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor2.g, var_121_3)
								local var_121_6 = Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor2.b, var_121_3)

								iter_121_1.color = Color.New(var_121_4, var_121_5, var_121_6)
							else
								local var_121_7 = Mathf.Lerp(iter_121_1.color.r, 0.5, var_121_3)

								iter_121_1.color = Color.New(var_121_7, var_121_7, var_121_7)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.actorSpriteComps104902 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_121_3 then
						if arg_118_1.isInRecall_ then
							iter_121_3.color = arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_121_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_118_1.var_.actorSpriteComps104902 = nil
			end

			local var_121_8 = 0
			local var_121_9 = 0.425

			if var_121_8 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_10 = arg_118_1:FormatText(StoryNameCfg[7].name)

				arg_118_1.leftNameTxt_.text = var_121_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_11 = arg_118_1:GetWordFromCfg(938041029)
				local var_121_12 = arg_118_1:FormatText(var_121_11.content)

				arg_118_1.text_.text = var_121_12

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_13 = 17
				local var_121_14 = utf8.len(var_121_12)
				local var_121_15 = var_121_13 <= 0 and var_121_9 or var_121_9 * (var_121_14 / var_121_13)

				if var_121_15 > 0 and var_121_9 < var_121_15 then
					arg_118_1.talkMaxDuration = var_121_15

					if var_121_15 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_15 + var_121_8
					end
				end

				arg_118_1.text_.text = var_121_12
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_16 = math.max(var_121_9, arg_118_1.talkMaxDuration)

			if var_121_8 <= arg_118_1.time_ and arg_118_1.time_ < var_121_8 + var_121_16 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_8) / var_121_16

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_8 + var_121_16 and arg_118_1.time_ < var_121_8 + var_121_16 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play938041030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 938041030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play938041031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["128404"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps128404 == nil then
				arg_122_1.var_.actorSpriteComps128404 = var_125_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.actorSpriteComps128404 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								local var_125_4 = Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor1.r, var_125_3)
								local var_125_5 = Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor1.g, var_125_3)
								local var_125_6 = Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor1.b, var_125_3)

								iter_125_1.color = Color.New(var_125_4, var_125_5, var_125_6)
							else
								local var_125_7 = Mathf.Lerp(iter_125_1.color.r, 1, var_125_3)

								iter_125_1.color = Color.New(var_125_7, var_125_7, var_125_7)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.actorSpriteComps128404 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_125_3 then
						if arg_122_1.isInRecall_ then
							iter_125_3.color = arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_125_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_122_1.var_.actorSpriteComps128404 = nil
			end

			local var_125_8 = arg_122_1.actors_["128404"].transform
			local var_125_9 = 0

			if var_125_9 < arg_122_1.time_ and arg_122_1.time_ <= var_125_9 + arg_125_0 then
				arg_122_1.var_.moveOldPos128404 = var_125_8.localPosition
				var_125_8.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("128404", 4)

				local var_125_10 = var_125_8.childCount

				for iter_125_4 = 0, var_125_10 - 1 do
					local var_125_11 = var_125_8:GetChild(iter_125_4)

					if var_125_11.name == "split_5" or not string.find(var_125_11.name, "split") then
						var_125_11.gameObject:SetActive(true)
					else
						var_125_11.gameObject:SetActive(false)
					end
				end
			end

			local var_125_12 = 0.001

			if var_125_9 <= arg_122_1.time_ and arg_122_1.time_ < var_125_9 + var_125_12 then
				local var_125_13 = (arg_122_1.time_ - var_125_9) / var_125_12
				local var_125_14 = Vector3.New(390.2, -356, -362.3)

				var_125_8.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos128404, var_125_14, var_125_13)
			end

			if arg_122_1.time_ >= var_125_9 + var_125_12 and arg_122_1.time_ < var_125_9 + var_125_12 + arg_125_0 then
				var_125_8.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_125_15 = 0
			local var_125_16 = 0.25

			if var_125_15 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_17 = arg_122_1:FormatText(StoryNameCfg[6].name)

				arg_122_1.leftNameTxt_.text = var_125_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_18 = arg_122_1:GetWordFromCfg(938041030)
				local var_125_19 = arg_122_1:FormatText(var_125_18.content)

				arg_122_1.text_.text = var_125_19

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_20 = 10
				local var_125_21 = utf8.len(var_125_19)
				local var_125_22 = var_125_20 <= 0 and var_125_16 or var_125_16 * (var_125_21 / var_125_20)

				if var_125_22 > 0 and var_125_16 < var_125_22 then
					arg_122_1.talkMaxDuration = var_125_22

					if var_125_22 + var_125_15 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_22 + var_125_15
					end
				end

				arg_122_1.text_.text = var_125_19
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_23 = math.max(var_125_16, arg_122_1.talkMaxDuration)

			if var_125_15 <= arg_122_1.time_ and arg_122_1.time_ < var_125_15 + var_125_23 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_15) / var_125_23

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_15 + var_125_23 and arg_122_1.time_ < var_125_15 + var_125_23 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
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

		arg_122_1:InitPlayNodeList()
	end,
	Play938041031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 938041031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play938041032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["128404"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps128404 == nil then
				arg_126_1.var_.actorSpriteComps128404 = var_129_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_2 = 0.2

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.actorSpriteComps128404 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_129_1 then
							if arg_126_1.isInRecall_ then
								local var_129_4 = Mathf.Lerp(iter_129_1.color.r, arg_126_1.hightColor2.r, var_129_3)
								local var_129_5 = Mathf.Lerp(iter_129_1.color.g, arg_126_1.hightColor2.g, var_129_3)
								local var_129_6 = Mathf.Lerp(iter_129_1.color.b, arg_126_1.hightColor2.b, var_129_3)

								iter_129_1.color = Color.New(var_129_4, var_129_5, var_129_6)
							else
								local var_129_7 = Mathf.Lerp(iter_129_1.color.r, 0.5, var_129_3)

								iter_129_1.color = Color.New(var_129_7, var_129_7, var_129_7)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.actorSpriteComps128404 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_129_3 then
						if arg_126_1.isInRecall_ then
							iter_129_3.color = arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_129_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_126_1.var_.actorSpriteComps128404 = nil
			end

			local var_129_8 = 0
			local var_129_9 = 0.85

			if var_129_8 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_10 = arg_126_1:FormatText(StoryNameCfg[7].name)

				arg_126_1.leftNameTxt_.text = var_129_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_11 = arg_126_1:GetWordFromCfg(938041031)
				local var_129_12 = arg_126_1:FormatText(var_129_11.content)

				arg_126_1.text_.text = var_129_12

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_13 = 34
				local var_129_14 = utf8.len(var_129_12)
				local var_129_15 = var_129_13 <= 0 and var_129_9 or var_129_9 * (var_129_14 / var_129_13)

				if var_129_15 > 0 and var_129_9 < var_129_15 then
					arg_126_1.talkMaxDuration = var_129_15

					if var_129_15 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_15 + var_129_8
					end
				end

				arg_126_1.text_.text = var_129_12
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_9, arg_126_1.talkMaxDuration)

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_8) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_8 + var_129_16 and arg_126_1.time_ < var_129_8 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play938041032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 938041032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play938041033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["128404"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos128404 = var_133_0.localPosition
				var_133_0.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("128404", 7)

				local var_133_2 = var_133_0.childCount

				for iter_133_0 = 0, var_133_2 - 1 do
					local var_133_3 = var_133_0:GetChild(iter_133_0)

					if var_133_3.name == "" or not string.find(var_133_3.name, "split") then
						var_133_3.gameObject:SetActive(true)
					else
						var_133_3.gameObject:SetActive(false)
					end
				end
			end

			local var_133_4 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_4 then
				local var_133_5 = (arg_130_1.time_ - var_133_1) / var_133_4
				local var_133_6 = Vector3.New(0, -2000, 0)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos128404, var_133_6, var_133_5)
			end

			if arg_130_1.time_ >= var_133_1 + var_133_4 and arg_130_1.time_ < var_133_1 + var_133_4 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_133_7 = arg_130_1.actors_["104902"].transform
			local var_133_8 = 0

			if var_133_8 < arg_130_1.time_ and arg_130_1.time_ <= var_133_8 + arg_133_0 then
				arg_130_1.var_.moveOldPos104902 = var_133_7.localPosition
				var_133_7.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("104902", 7)

				local var_133_9 = var_133_7.childCount

				for iter_133_1 = 0, var_133_9 - 1 do
					local var_133_10 = var_133_7:GetChild(iter_133_1)

					if var_133_10.name == "" or not string.find(var_133_10.name, "split") then
						var_133_10.gameObject:SetActive(true)
					else
						var_133_10.gameObject:SetActive(false)
					end
				end
			end

			local var_133_11 = 0.001

			if var_133_8 <= arg_130_1.time_ and arg_130_1.time_ < var_133_8 + var_133_11 then
				local var_133_12 = (arg_130_1.time_ - var_133_8) / var_133_11
				local var_133_13 = Vector3.New(0, -2000, -360)

				var_133_7.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos104902, var_133_13, var_133_12)
			end

			if arg_130_1.time_ >= var_133_8 + var_133_11 and arg_130_1.time_ < var_133_8 + var_133_11 + arg_133_0 then
				var_133_7.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_133_14 = 0
			local var_133_15 = 1.475

			if var_133_14 < arg_130_1.time_ and arg_130_1.time_ <= var_133_14 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_16 = arg_130_1:GetWordFromCfg(938041032)
				local var_133_17 = arg_130_1:FormatText(var_133_16.content)

				arg_130_1.text_.text = var_133_17

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_18 = 59
				local var_133_19 = utf8.len(var_133_17)
				local var_133_20 = var_133_18 <= 0 and var_133_15 or var_133_15 * (var_133_19 / var_133_18)

				if var_133_20 > 0 and var_133_15 < var_133_20 then
					arg_130_1.talkMaxDuration = var_133_20

					if var_133_20 + var_133_14 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_20 + var_133_14
					end
				end

				arg_130_1.text_.text = var_133_17
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_21 = math.max(var_133_15, arg_130_1.talkMaxDuration)

			if var_133_14 <= arg_130_1.time_ and arg_130_1.time_ < var_133_14 + var_133_21 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_14) / var_133_21

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_14 + var_133_21 and arg_130_1.time_ < var_133_14 + var_133_21 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play938041033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 938041033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play938041034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 0.15

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_2 = arg_134_1:FormatText(StoryNameCfg[7].name)

				arg_134_1.leftNameTxt_.text = var_137_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:GetWordFromCfg(938041033)
				local var_137_4 = arg_134_1:FormatText(var_137_3.content)

				arg_134_1.text_.text = var_137_4

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 6
				local var_137_6 = utf8.len(var_137_4)
				local var_137_7 = var_137_5 <= 0 and var_137_1 or var_137_1 * (var_137_6 / var_137_5)

				if var_137_7 > 0 and var_137_1 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_4
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_8 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_8 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_8

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_8 and arg_134_1.time_ < var_137_0 + var_137_8 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play938041034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 938041034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play938041035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["10183"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps10183 == nil then
				arg_138_1.var_.actorSpriteComps10183 = var_141_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_2 = 0.2

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.actorSpriteComps10183 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								local var_141_4 = Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor1.r, var_141_3)
								local var_141_5 = Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor1.g, var_141_3)
								local var_141_6 = Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor1.b, var_141_3)

								iter_141_1.color = Color.New(var_141_4, var_141_5, var_141_6)
							else
								local var_141_7 = Mathf.Lerp(iter_141_1.color.r, 1, var_141_3)

								iter_141_1.color = Color.New(var_141_7, var_141_7, var_141_7)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.actorSpriteComps10183 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_141_3 then
						if arg_138_1.isInRecall_ then
							iter_141_3.color = arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_141_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_138_1.var_.actorSpriteComps10183 = nil
			end

			local var_141_8 = arg_138_1.actors_["10183"].transform
			local var_141_9 = 0

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 then
				arg_138_1.var_.moveOldPos10183 = var_141_8.localPosition
				var_141_8.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("10183", 3)

				local var_141_10 = var_141_8.childCount

				for iter_141_4 = 0, var_141_10 - 1 do
					local var_141_11 = var_141_8:GetChild(iter_141_4)

					if var_141_11.name == "split_5" or not string.find(var_141_11.name, "split") then
						var_141_11.gameObject:SetActive(true)
					else
						var_141_11.gameObject:SetActive(false)
					end
				end
			end

			local var_141_12 = 0.001

			if var_141_9 <= arg_138_1.time_ and arg_138_1.time_ < var_141_9 + var_141_12 then
				local var_141_13 = (arg_138_1.time_ - var_141_9) / var_141_12
				local var_141_14 = Vector3.New(0, -475, -325)

				var_141_8.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10183, var_141_14, var_141_13)
			end

			if arg_138_1.time_ >= var_141_9 + var_141_12 and arg_138_1.time_ < var_141_9 + var_141_12 + arg_141_0 then
				var_141_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_141_15 = 0
			local var_141_16 = 0.325

			if var_141_15 < arg_138_1.time_ and arg_138_1.time_ <= var_141_15 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_17 = arg_138_1:FormatText(StoryNameCfg[1562].name)

				arg_138_1.leftNameTxt_.text = var_141_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_18 = arg_138_1:GetWordFromCfg(938041034)
				local var_141_19 = arg_138_1:FormatText(var_141_18.content)

				arg_138_1.text_.text = var_141_19

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_20 = 13
				local var_141_21 = utf8.len(var_141_19)
				local var_141_22 = var_141_20 <= 0 and var_141_16 or var_141_16 * (var_141_21 / var_141_20)

				if var_141_22 > 0 and var_141_16 < var_141_22 then
					arg_138_1.talkMaxDuration = var_141_22

					if var_141_22 + var_141_15 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_22 + var_141_15
					end
				end

				arg_138_1.text_.text = var_141_19
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_23 = math.max(var_141_16, arg_138_1.talkMaxDuration)

			if var_141_15 <= arg_138_1.time_ and arg_138_1.time_ < var_141_15 + var_141_23 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_15) / var_141_23

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_15 + var_141_23 and arg_138_1.time_ < var_141_15 + var_141_23 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play938041035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 938041035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play938041036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["10183"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.actorSpriteComps10183 == nil then
				arg_142_1.var_.actorSpriteComps10183 = var_145_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_2 = 0.2

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.actorSpriteComps10183 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_145_1 then
							if arg_142_1.isInRecall_ then
								local var_145_4 = Mathf.Lerp(iter_145_1.color.r, arg_142_1.hightColor2.r, var_145_3)
								local var_145_5 = Mathf.Lerp(iter_145_1.color.g, arg_142_1.hightColor2.g, var_145_3)
								local var_145_6 = Mathf.Lerp(iter_145_1.color.b, arg_142_1.hightColor2.b, var_145_3)

								iter_145_1.color = Color.New(var_145_4, var_145_5, var_145_6)
							else
								local var_145_7 = Mathf.Lerp(iter_145_1.color.r, 0.5, var_145_3)

								iter_145_1.color = Color.New(var_145_7, var_145_7, var_145_7)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.actorSpriteComps10183 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_145_3 then
						if arg_142_1.isInRecall_ then
							iter_145_3.color = arg_142_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_145_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_142_1.var_.actorSpriteComps10183 = nil
			end

			local var_145_8 = 0
			local var_145_9 = 0.3

			if var_145_8 < arg_142_1.time_ and arg_142_1.time_ <= var_145_8 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_10 = arg_142_1:FormatText(StoryNameCfg[7].name)

				arg_142_1.leftNameTxt_.text = var_145_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_11 = arg_142_1:GetWordFromCfg(938041035)
				local var_145_12 = arg_142_1:FormatText(var_145_11.content)

				arg_142_1.text_.text = var_145_12

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_13 = 12
				local var_145_14 = utf8.len(var_145_12)
				local var_145_15 = var_145_13 <= 0 and var_145_9 or var_145_9 * (var_145_14 / var_145_13)

				if var_145_15 > 0 and var_145_9 < var_145_15 then
					arg_142_1.talkMaxDuration = var_145_15

					if var_145_15 + var_145_8 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_15 + var_145_8
					end
				end

				arg_142_1.text_.text = var_145_12
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_16 = math.max(var_145_9, arg_142_1.talkMaxDuration)

			if var_145_8 <= arg_142_1.time_ and arg_142_1.time_ < var_145_8 + var_145_16 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_8) / var_145_16

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_8 + var_145_16 and arg_142_1.time_ < var_145_8 + var_145_16 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play938041036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 938041036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play938041037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["10183"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps10183 == nil then
				arg_146_1.var_.actorSpriteComps10183 = var_149_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_2 = 0.2

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.actorSpriteComps10183 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_149_1 then
							if arg_146_1.isInRecall_ then
								local var_149_4 = Mathf.Lerp(iter_149_1.color.r, arg_146_1.hightColor1.r, var_149_3)
								local var_149_5 = Mathf.Lerp(iter_149_1.color.g, arg_146_1.hightColor1.g, var_149_3)
								local var_149_6 = Mathf.Lerp(iter_149_1.color.b, arg_146_1.hightColor1.b, var_149_3)

								iter_149_1.color = Color.New(var_149_4, var_149_5, var_149_6)
							else
								local var_149_7 = Mathf.Lerp(iter_149_1.color.r, 1, var_149_3)

								iter_149_1.color = Color.New(var_149_7, var_149_7, var_149_7)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.actorSpriteComps10183 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_149_3 then
						if arg_146_1.isInRecall_ then
							iter_149_3.color = arg_146_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_149_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_146_1.var_.actorSpriteComps10183 = nil
			end

			local var_149_8 = arg_146_1.actors_["10183"].transform
			local var_149_9 = 0

			if var_149_9 < arg_146_1.time_ and arg_146_1.time_ <= var_149_9 + arg_149_0 then
				arg_146_1.var_.moveOldPos10183 = var_149_8.localPosition
				var_149_8.localScale = Vector3.New(1, 1, 1)

				arg_146_1:CheckSpriteTmpPos("10183", 3)

				local var_149_10 = var_149_8.childCount

				for iter_149_4 = 0, var_149_10 - 1 do
					local var_149_11 = var_149_8:GetChild(iter_149_4)

					if var_149_11.name == "split_1" then
						var_149_11:SetAsLastSibling()
						var_149_11.gameObject:SetActive(true)

						arg_146_1.var_.actorSpriteSplit10183 = var_149_11.gameObject:GetComponent(typeof(Image))

						arg_146_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_149_12 = 0.5

			if var_149_9 <= arg_146_1.time_ and arg_146_1.time_ < var_149_9 + var_149_12 then
				local var_149_13 = (arg_146_1.time_ - var_149_9) / var_149_12
				local var_149_14 = Vector3.New(0, -475, -325)

				var_149_8.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10183, var_149_14, var_149_13)

				if arg_146_1.var_.actorSpriteSplit10183 ~= nil then
					arg_146_1.var_.actorSpriteSplit10183:SetAlpha(var_149_13)
				end
			end

			if arg_146_1.time_ >= var_149_9 + var_149_12 and arg_146_1.time_ < var_149_9 + var_149_12 + arg_149_0 then
				var_149_8.localPosition = Vector3.New(0, -475, -325)

				if arg_146_1.var_.actorSpriteSplit10183 ~= nil then
					arg_146_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_149_15 = 0
			local var_149_16 = 1.225

			if var_149_15 < arg_146_1.time_ and arg_146_1.time_ <= var_149_15 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_17 = arg_146_1:FormatText(StoryNameCfg[1562].name)

				arg_146_1.leftNameTxt_.text = var_149_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_18 = arg_146_1:GetWordFromCfg(938041036)
				local var_149_19 = arg_146_1:FormatText(var_149_18.content)

				arg_146_1.text_.text = var_149_19

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_20 = 49
				local var_149_21 = utf8.len(var_149_19)
				local var_149_22 = var_149_20 <= 0 and var_149_16 or var_149_16 * (var_149_21 / var_149_20)

				if var_149_22 > 0 and var_149_16 < var_149_22 then
					arg_146_1.talkMaxDuration = var_149_22

					if var_149_22 + var_149_15 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_22 + var_149_15
					end
				end

				arg_146_1.text_.text = var_149_19
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_23 = math.max(var_149_16, arg_146_1.talkMaxDuration)

			if var_149_15 <= arg_146_1.time_ and arg_146_1.time_ < var_149_15 + var_149_23 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_15) / var_149_23

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_15 + var_149_23 and arg_146_1.time_ < var_149_15 + var_149_23 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play938041037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 938041037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play938041038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10183"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps10183 == nil then
				arg_150_1.var_.actorSpriteComps10183 = var_153_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_2 = 0.2

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.actorSpriteComps10183 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								local var_153_4 = Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor2.r, var_153_3)
								local var_153_5 = Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor2.g, var_153_3)
								local var_153_6 = Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor2.b, var_153_3)

								iter_153_1.color = Color.New(var_153_4, var_153_5, var_153_6)
							else
								local var_153_7 = Mathf.Lerp(iter_153_1.color.r, 0.5, var_153_3)

								iter_153_1.color = Color.New(var_153_7, var_153_7, var_153_7)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.actorSpriteComps10183 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_153_3 then
						if arg_150_1.isInRecall_ then
							iter_153_3.color = arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_153_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_150_1.var_.actorSpriteComps10183 = nil
			end

			local var_153_8 = 0
			local var_153_9 = 0.4

			if var_153_8 < arg_150_1.time_ and arg_150_1.time_ <= var_153_8 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_10 = arg_150_1:FormatText(StoryNameCfg[7].name)

				arg_150_1.leftNameTxt_.text = var_153_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_11 = arg_150_1:GetWordFromCfg(938041037)
				local var_153_12 = arg_150_1:FormatText(var_153_11.content)

				arg_150_1.text_.text = var_153_12

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_13 = 16
				local var_153_14 = utf8.len(var_153_12)
				local var_153_15 = var_153_13 <= 0 and var_153_9 or var_153_9 * (var_153_14 / var_153_13)

				if var_153_15 > 0 and var_153_9 < var_153_15 then
					arg_150_1.talkMaxDuration = var_153_15

					if var_153_15 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_15 + var_153_8
					end
				end

				arg_150_1.text_.text = var_153_12
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_16 = math.max(var_153_9, arg_150_1.talkMaxDuration)

			if var_153_8 <= arg_150_1.time_ and arg_150_1.time_ < var_153_8 + var_153_16 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_8) / var_153_16

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_8 + var_153_16 and arg_150_1.time_ < var_153_8 + var_153_16 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play938041038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 938041038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play938041039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["10183"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps10183 == nil then
				arg_154_1.var_.actorSpriteComps10183 = var_157_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_2 = 0.2

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.actorSpriteComps10183 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								local var_157_4 = Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor1.r, var_157_3)
								local var_157_5 = Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor1.g, var_157_3)
								local var_157_6 = Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor1.b, var_157_3)

								iter_157_1.color = Color.New(var_157_4, var_157_5, var_157_6)
							else
								local var_157_7 = Mathf.Lerp(iter_157_1.color.r, 1, var_157_3)

								iter_157_1.color = Color.New(var_157_7, var_157_7, var_157_7)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.actorSpriteComps10183 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_157_3 then
						if arg_154_1.isInRecall_ then
							iter_157_3.color = arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_157_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_154_1.var_.actorSpriteComps10183 = nil
			end

			local var_157_8 = arg_154_1.actors_["10183"].transform
			local var_157_9 = 0

			if var_157_9 < arg_154_1.time_ and arg_154_1.time_ <= var_157_9 + arg_157_0 then
				arg_154_1.var_.moveOldPos10183 = var_157_8.localPosition
				var_157_8.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("10183", 3)

				local var_157_10 = var_157_8.childCount

				for iter_157_4 = 0, var_157_10 - 1 do
					local var_157_11 = var_157_8:GetChild(iter_157_4)

					if var_157_11.name == "split_2" then
						var_157_11:SetAsLastSibling()
						var_157_11.gameObject:SetActive(true)

						arg_154_1.var_.actorSpriteSplit10183 = var_157_11.gameObject:GetComponent(typeof(Image))

						arg_154_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_157_12 = 0.5

			if var_157_9 <= arg_154_1.time_ and arg_154_1.time_ < var_157_9 + var_157_12 then
				local var_157_13 = (arg_154_1.time_ - var_157_9) / var_157_12
				local var_157_14 = Vector3.New(0, -475, -325)

				var_157_8.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10183, var_157_14, var_157_13)

				if arg_154_1.var_.actorSpriteSplit10183 ~= nil then
					arg_154_1.var_.actorSpriteSplit10183:SetAlpha(var_157_13)
				end
			end

			if arg_154_1.time_ >= var_157_9 + var_157_12 and arg_154_1.time_ < var_157_9 + var_157_12 + arg_157_0 then
				var_157_8.localPosition = Vector3.New(0, -475, -325)

				if arg_154_1.var_.actorSpriteSplit10183 ~= nil then
					arg_154_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_157_15 = 0
			local var_157_16 = 0.825

			if var_157_15 < arg_154_1.time_ and arg_154_1.time_ <= var_157_15 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_17 = arg_154_1:FormatText(StoryNameCfg[1562].name)

				arg_154_1.leftNameTxt_.text = var_157_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_18 = arg_154_1:GetWordFromCfg(938041038)
				local var_157_19 = arg_154_1:FormatText(var_157_18.content)

				arg_154_1.text_.text = var_157_19

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_20 = 33
				local var_157_21 = utf8.len(var_157_19)
				local var_157_22 = var_157_20 <= 0 and var_157_16 or var_157_16 * (var_157_21 / var_157_20)

				if var_157_22 > 0 and var_157_16 < var_157_22 then
					arg_154_1.talkMaxDuration = var_157_22

					if var_157_22 + var_157_15 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_22 + var_157_15
					end
				end

				arg_154_1.text_.text = var_157_19
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_23 = math.max(var_157_16, arg_154_1.talkMaxDuration)

			if var_157_15 <= arg_154_1.time_ and arg_154_1.time_ < var_157_15 + var_157_23 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_15) / var_157_23

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_15 + var_157_23 and arg_154_1.time_ < var_157_15 + var_157_23 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play938041039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 938041039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play938041040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["10183"]
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps10183 == nil then
				arg_158_1.var_.actorSpriteComps10183 = var_161_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_2 = 0.2

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 and not isNil(var_161_0) then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2

				if arg_158_1.var_.actorSpriteComps10183 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_161_1 then
							if arg_158_1.isInRecall_ then
								local var_161_4 = Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor2.r, var_161_3)
								local var_161_5 = Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor2.g, var_161_3)
								local var_161_6 = Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor2.b, var_161_3)

								iter_161_1.color = Color.New(var_161_4, var_161_5, var_161_6)
							else
								local var_161_7 = Mathf.Lerp(iter_161_1.color.r, 0.5, var_161_3)

								iter_161_1.color = Color.New(var_161_7, var_161_7, var_161_7)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 and not isNil(var_161_0) and arg_158_1.var_.actorSpriteComps10183 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_161_3 then
						if arg_158_1.isInRecall_ then
							iter_161_3.color = arg_158_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_161_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_158_1.var_.actorSpriteComps10183 = nil
			end

			local var_161_8 = 0
			local var_161_9 = 0.35

			if var_161_8 < arg_158_1.time_ and arg_158_1.time_ <= var_161_8 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_10 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_11 = arg_158_1:GetWordFromCfg(938041039)
				local var_161_12 = arg_158_1:FormatText(var_161_11.content)

				arg_158_1.text_.text = var_161_12

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_13 = 14
				local var_161_14 = utf8.len(var_161_12)
				local var_161_15 = var_161_13 <= 0 and var_161_9 or var_161_9 * (var_161_14 / var_161_13)

				if var_161_15 > 0 and var_161_9 < var_161_15 then
					arg_158_1.talkMaxDuration = var_161_15

					if var_161_15 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_15 + var_161_8
					end
				end

				arg_158_1.text_.text = var_161_12
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_9, arg_158_1.talkMaxDuration)

			if var_161_8 <= arg_158_1.time_ and arg_158_1.time_ < var_161_8 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_8) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_8 + var_161_16 and arg_158_1.time_ < var_161_8 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play938041040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 938041040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play938041041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["10183"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.actorSpriteComps10183 == nil then
				arg_162_1.var_.actorSpriteComps10183 = var_165_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_2 = 0.2

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.actorSpriteComps10183 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								local var_165_4 = Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor1.r, var_165_3)
								local var_165_5 = Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor1.g, var_165_3)
								local var_165_6 = Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor1.b, var_165_3)

								iter_165_1.color = Color.New(var_165_4, var_165_5, var_165_6)
							else
								local var_165_7 = Mathf.Lerp(iter_165_1.color.r, 1, var_165_3)

								iter_165_1.color = Color.New(var_165_7, var_165_7, var_165_7)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.actorSpriteComps10183 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_165_3 then
						if arg_162_1.isInRecall_ then
							iter_165_3.color = arg_162_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_165_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_162_1.var_.actorSpriteComps10183 = nil
			end

			local var_165_8 = arg_162_1.actors_["10183"].transform
			local var_165_9 = 0

			if var_165_9 < arg_162_1.time_ and arg_162_1.time_ <= var_165_9 + arg_165_0 then
				arg_162_1.var_.moveOldPos10183 = var_165_8.localPosition
				var_165_8.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("10183", 3)

				local var_165_10 = var_165_8.childCount

				for iter_165_4 = 0, var_165_10 - 1 do
					local var_165_11 = var_165_8:GetChild(iter_165_4)

					if var_165_11.name == "split_1" then
						var_165_11:SetAsLastSibling()
						var_165_11.gameObject:SetActive(true)

						arg_162_1.var_.actorSpriteSplit10183 = var_165_11.gameObject:GetComponent(typeof(Image))

						arg_162_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_165_12 = 0.5

			if var_165_9 <= arg_162_1.time_ and arg_162_1.time_ < var_165_9 + var_165_12 then
				local var_165_13 = (arg_162_1.time_ - var_165_9) / var_165_12
				local var_165_14 = Vector3.New(0, -475, -325)

				var_165_8.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10183, var_165_14, var_165_13)

				if arg_162_1.var_.actorSpriteSplit10183 ~= nil then
					arg_162_1.var_.actorSpriteSplit10183:SetAlpha(var_165_13)
				end
			end

			if arg_162_1.time_ >= var_165_9 + var_165_12 and arg_162_1.time_ < var_165_9 + var_165_12 + arg_165_0 then
				var_165_8.localPosition = Vector3.New(0, -475, -325)

				if arg_162_1.var_.actorSpriteSplit10183 ~= nil then
					arg_162_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_165_15 = 0
			local var_165_16 = 0.825

			if var_165_15 < arg_162_1.time_ and arg_162_1.time_ <= var_165_15 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_17 = arg_162_1:FormatText(StoryNameCfg[1562].name)

				arg_162_1.leftNameTxt_.text = var_165_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_18 = arg_162_1:GetWordFromCfg(938041040)
				local var_165_19 = arg_162_1:FormatText(var_165_18.content)

				arg_162_1.text_.text = var_165_19

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_20 = 33
				local var_165_21 = utf8.len(var_165_19)
				local var_165_22 = var_165_20 <= 0 and var_165_16 or var_165_16 * (var_165_21 / var_165_20)

				if var_165_22 > 0 and var_165_16 < var_165_22 then
					arg_162_1.talkMaxDuration = var_165_22

					if var_165_22 + var_165_15 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_22 + var_165_15
					end
				end

				arg_162_1.text_.text = var_165_19
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_23 = math.max(var_165_16, arg_162_1.talkMaxDuration)

			if var_165_15 <= arg_162_1.time_ and arg_162_1.time_ < var_165_15 + var_165_23 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_15) / var_165_23

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_15 + var_165_23 and arg_162_1.time_ < var_165_15 + var_165_23 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play938041041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 938041041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play938041042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["10183"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10183 == nil then
				arg_166_1.var_.actorSpriteComps10183 = var_169_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_2 = 0.2

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.actorSpriteComps10183 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								local var_169_4 = Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor2.r, var_169_3)
								local var_169_5 = Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor2.g, var_169_3)
								local var_169_6 = Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor2.b, var_169_3)

								iter_169_1.color = Color.New(var_169_4, var_169_5, var_169_6)
							else
								local var_169_7 = Mathf.Lerp(iter_169_1.color.r, 0.5, var_169_3)

								iter_169_1.color = Color.New(var_169_7, var_169_7, var_169_7)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.actorSpriteComps10183 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_169_3 then
						if arg_166_1.isInRecall_ then
							iter_169_3.color = arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_169_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_166_1.var_.actorSpriteComps10183 = nil
			end

			local var_169_8 = 0
			local var_169_9 = 0.525

			if var_169_8 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_10 = arg_166_1:FormatText(StoryNameCfg[7].name)

				arg_166_1.leftNameTxt_.text = var_169_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_11 = arg_166_1:GetWordFromCfg(938041041)
				local var_169_12 = arg_166_1:FormatText(var_169_11.content)

				arg_166_1.text_.text = var_169_12

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_13 = 21
				local var_169_14 = utf8.len(var_169_12)
				local var_169_15 = var_169_13 <= 0 and var_169_9 or var_169_9 * (var_169_14 / var_169_13)

				if var_169_15 > 0 and var_169_9 < var_169_15 then
					arg_166_1.talkMaxDuration = var_169_15

					if var_169_15 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_15 + var_169_8
					end
				end

				arg_166_1.text_.text = var_169_12
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_16 = math.max(var_169_9, arg_166_1.talkMaxDuration)

			if var_169_8 <= arg_166_1.time_ and arg_166_1.time_ < var_169_8 + var_169_16 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_8) / var_169_16

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_8 + var_169_16 and arg_166_1.time_ < var_169_8 + var_169_16 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play938041042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 938041042
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play938041043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10183"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps10183 == nil then
				arg_170_1.var_.actorSpriteComps10183 = var_173_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_2 = 0.2

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.actorSpriteComps10183 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								local var_173_4 = Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, var_173_3)
								local var_173_5 = Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, var_173_3)
								local var_173_6 = Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, var_173_3)

								iter_173_1.color = Color.New(var_173_4, var_173_5, var_173_6)
							else
								local var_173_7 = Mathf.Lerp(iter_173_1.color.r, 1, var_173_3)

								iter_173_1.color = Color.New(var_173_7, var_173_7, var_173_7)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.actorSpriteComps10183 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_173_3 then
						if arg_170_1.isInRecall_ then
							iter_173_3.color = arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_173_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_170_1.var_.actorSpriteComps10183 = nil
			end

			local var_173_8 = arg_170_1.actors_["10183"].transform
			local var_173_9 = 0

			if var_173_9 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 then
				arg_170_1.var_.moveOldPos10183 = var_173_8.localPosition
				var_173_8.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("10183", 3)

				local var_173_10 = var_173_8.childCount

				for iter_173_4 = 0, var_173_10 - 1 do
					local var_173_11 = var_173_8:GetChild(iter_173_4)

					if var_173_11.name == "" or not string.find(var_173_11.name, "split") then
						var_173_11.gameObject:SetActive(true)
					else
						var_173_11.gameObject:SetActive(false)
					end
				end
			end

			local var_173_12 = 0.001

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_12 then
				local var_173_13 = (arg_170_1.time_ - var_173_9) / var_173_12
				local var_173_14 = Vector3.New(0, -475, -325)

				var_173_8.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10183, var_173_14, var_173_13)
			end

			if arg_170_1.time_ >= var_173_9 + var_173_12 and arg_170_1.time_ < var_173_9 + var_173_12 + arg_173_0 then
				var_173_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_173_15 = 0
			local var_173_16 = 1.35

			if var_173_15 < arg_170_1.time_ and arg_170_1.time_ <= var_173_15 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_17 = arg_170_1:FormatText(StoryNameCfg[1562].name)

				arg_170_1.leftNameTxt_.text = var_173_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_18 = arg_170_1:GetWordFromCfg(938041042)
				local var_173_19 = arg_170_1:FormatText(var_173_18.content)

				arg_170_1.text_.text = var_173_19

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_20 = 54
				local var_173_21 = utf8.len(var_173_19)
				local var_173_22 = var_173_20 <= 0 and var_173_16 or var_173_16 * (var_173_21 / var_173_20)

				if var_173_22 > 0 and var_173_16 < var_173_22 then
					arg_170_1.talkMaxDuration = var_173_22

					if var_173_22 + var_173_15 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_22 + var_173_15
					end
				end

				arg_170_1.text_.text = var_173_19
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_23 = math.max(var_173_16, arg_170_1.talkMaxDuration)

			if var_173_15 <= arg_170_1.time_ and arg_170_1.time_ < var_173_15 + var_173_23 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_15) / var_173_23

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_15 + var_173_23 and arg_170_1.time_ < var_173_15 + var_173_23 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play938041043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 938041043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play938041044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["10183"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps10183 == nil then
				arg_174_1.var_.actorSpriteComps10183 = var_177_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_2 = 0.2

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.actorSpriteComps10183 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								local var_177_4 = Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor2.r, var_177_3)
								local var_177_5 = Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor2.g, var_177_3)
								local var_177_6 = Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor2.b, var_177_3)

								iter_177_1.color = Color.New(var_177_4, var_177_5, var_177_6)
							else
								local var_177_7 = Mathf.Lerp(iter_177_1.color.r, 0.5, var_177_3)

								iter_177_1.color = Color.New(var_177_7, var_177_7, var_177_7)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.actorSpriteComps10183 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_177_3 then
						if arg_174_1.isInRecall_ then
							iter_177_3.color = arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_177_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_174_1.var_.actorSpriteComps10183 = nil
			end

			local var_177_8 = arg_174_1.actors_["10183"].transform
			local var_177_9 = 0

			if var_177_9 < arg_174_1.time_ and arg_174_1.time_ <= var_177_9 + arg_177_0 then
				arg_174_1.var_.moveOldPos10183 = var_177_8.localPosition
				var_177_8.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10183", 7)

				local var_177_10 = var_177_8.childCount

				for iter_177_4 = 0, var_177_10 - 1 do
					local var_177_11 = var_177_8:GetChild(iter_177_4)

					if var_177_11.name == "" or not string.find(var_177_11.name, "split") then
						var_177_11.gameObject:SetActive(true)
					else
						var_177_11.gameObject:SetActive(false)
					end
				end
			end

			local var_177_12 = 0.001

			if var_177_9 <= arg_174_1.time_ and arg_174_1.time_ < var_177_9 + var_177_12 then
				local var_177_13 = (arg_174_1.time_ - var_177_9) / var_177_12
				local var_177_14 = Vector3.New(0, -2000, 0)

				var_177_8.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10183, var_177_14, var_177_13)
			end

			if arg_174_1.time_ >= var_177_9 + var_177_12 and arg_174_1.time_ < var_177_9 + var_177_12 + arg_177_0 then
				var_177_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_177_15 = 0
			local var_177_16 = 1.425

			if var_177_15 < arg_174_1.time_ and arg_174_1.time_ <= var_177_15 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_17 = arg_174_1:GetWordFromCfg(938041043)
				local var_177_18 = arg_174_1:FormatText(var_177_17.content)

				arg_174_1.text_.text = var_177_18

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_19 = 57
				local var_177_20 = utf8.len(var_177_18)
				local var_177_21 = var_177_19 <= 0 and var_177_16 or var_177_16 * (var_177_20 / var_177_19)

				if var_177_21 > 0 and var_177_16 < var_177_21 then
					arg_174_1.talkMaxDuration = var_177_21

					if var_177_21 + var_177_15 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_21 + var_177_15
					end
				end

				arg_174_1.text_.text = var_177_18
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_22 = math.max(var_177_16, arg_174_1.talkMaxDuration)

			if var_177_15 <= arg_174_1.time_ and arg_174_1.time_ < var_177_15 + var_177_22 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_15) / var_177_22

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_15 + var_177_22 and arg_174_1.time_ < var_177_15 + var_177_22 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play938041044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 938041044
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play938041045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 1.625

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_2 = arg_178_1:GetWordFromCfg(938041044)
				local var_181_3 = arg_178_1:FormatText(var_181_2.content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 65
				local var_181_5 = utf8.len(var_181_3)
				local var_181_6 = var_181_4 <= 0 and var_181_1 or var_181_1 * (var_181_5 / var_181_4)

				if var_181_6 > 0 and var_181_1 < var_181_6 then
					arg_178_1.talkMaxDuration = var_181_6

					if var_181_6 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_7 and arg_178_1.time_ < var_181_0 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play938041045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 938041045
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play938041046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["10183"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps10183 == nil then
				arg_182_1.var_.actorSpriteComps10183 = var_185_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_2 = 0.2

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.actorSpriteComps10183 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								local var_185_4 = Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, var_185_3)
								local var_185_5 = Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, var_185_3)
								local var_185_6 = Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, var_185_3)

								iter_185_1.color = Color.New(var_185_4, var_185_5, var_185_6)
							else
								local var_185_7 = Mathf.Lerp(iter_185_1.color.r, 1, var_185_3)

								iter_185_1.color = Color.New(var_185_7, var_185_7, var_185_7)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.actorSpriteComps10183 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_185_3 then
						if arg_182_1.isInRecall_ then
							iter_185_3.color = arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_185_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_182_1.var_.actorSpriteComps10183 = nil
			end

			local var_185_8 = arg_182_1.actors_["10183"].transform
			local var_185_9 = 0

			if var_185_9 < arg_182_1.time_ and arg_182_1.time_ <= var_185_9 + arg_185_0 then
				arg_182_1.var_.moveOldPos10183 = var_185_8.localPosition
				var_185_8.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("10183", 3)

				local var_185_10 = var_185_8.childCount

				for iter_185_4 = 0, var_185_10 - 1 do
					local var_185_11 = var_185_8:GetChild(iter_185_4)

					if var_185_11.name == "split_8" or not string.find(var_185_11.name, "split") then
						var_185_11.gameObject:SetActive(true)
					else
						var_185_11.gameObject:SetActive(false)
					end
				end
			end

			local var_185_12 = 0.001

			if var_185_9 <= arg_182_1.time_ and arg_182_1.time_ < var_185_9 + var_185_12 then
				local var_185_13 = (arg_182_1.time_ - var_185_9) / var_185_12
				local var_185_14 = Vector3.New(0, -475, -325)

				var_185_8.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10183, var_185_14, var_185_13)
			end

			if arg_182_1.time_ >= var_185_9 + var_185_12 and arg_182_1.time_ < var_185_9 + var_185_12 + arg_185_0 then
				var_185_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_185_15 = 0
			local var_185_16 = 0.95

			if var_185_15 < arg_182_1.time_ and arg_182_1.time_ <= var_185_15 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_17 = arg_182_1:FormatText(StoryNameCfg[1562].name)

				arg_182_1.leftNameTxt_.text = var_185_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_18 = arg_182_1:GetWordFromCfg(938041045)
				local var_185_19 = arg_182_1:FormatText(var_185_18.content)

				arg_182_1.text_.text = var_185_19

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_20 = 38
				local var_185_21 = utf8.len(var_185_19)
				local var_185_22 = var_185_20 <= 0 and var_185_16 or var_185_16 * (var_185_21 / var_185_20)

				if var_185_22 > 0 and var_185_16 < var_185_22 then
					arg_182_1.talkMaxDuration = var_185_22

					if var_185_22 + var_185_15 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_22 + var_185_15
					end
				end

				arg_182_1.text_.text = var_185_19
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_23 = math.max(var_185_16, arg_182_1.talkMaxDuration)

			if var_185_15 <= arg_182_1.time_ and arg_182_1.time_ < var_185_15 + var_185_23 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_15) / var_185_23

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_15 + var_185_23 and arg_182_1.time_ < var_185_15 + var_185_23 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play938041046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 938041046
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play938041047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["10183"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10183 == nil then
				arg_186_1.var_.actorSpriteComps10183 = var_189_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_2 = 0.2

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.actorSpriteComps10183 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								local var_189_4 = Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor2.r, var_189_3)
								local var_189_5 = Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor2.g, var_189_3)
								local var_189_6 = Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor2.b, var_189_3)

								iter_189_1.color = Color.New(var_189_4, var_189_5, var_189_6)
							else
								local var_189_7 = Mathf.Lerp(iter_189_1.color.r, 0.5, var_189_3)

								iter_189_1.color = Color.New(var_189_7, var_189_7, var_189_7)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.actorSpriteComps10183 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_189_3 then
						if arg_186_1.isInRecall_ then
							iter_189_3.color = arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_189_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_186_1.var_.actorSpriteComps10183 = nil
			end

			local var_189_8 = 0
			local var_189_9 = 0.05

			if var_189_8 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_10 = arg_186_1:FormatText(StoryNameCfg[1563].name)

				arg_186_1.leftNameTxt_.text = var_189_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10188")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_11 = arg_186_1:GetWordFromCfg(938041046)
				local var_189_12 = arg_186_1:FormatText(var_189_11.content)

				arg_186_1.text_.text = var_189_12

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_13 = 2
				local var_189_14 = utf8.len(var_189_12)
				local var_189_15 = var_189_13 <= 0 and var_189_9 or var_189_9 * (var_189_14 / var_189_13)

				if var_189_15 > 0 and var_189_9 < var_189_15 then
					arg_186_1.talkMaxDuration = var_189_15

					if var_189_15 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_15 + var_189_8
					end
				end

				arg_186_1.text_.text = var_189_12
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = math.max(var_189_9, arg_186_1.talkMaxDuration)

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_16 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_8) / var_189_16

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_8 + var_189_16 and arg_186_1.time_ < var_189_8 + var_189_16 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play938041047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 938041047
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play938041048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0
			local var_193_1 = 0.05

			if var_193_0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_2 = arg_190_1:FormatText(StoryNameCfg[1564].name)

				arg_190_1.leftNameTxt_.text = var_193_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10188_a")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:GetWordFromCfg(938041047)
				local var_193_4 = arg_190_1:FormatText(var_193_3.content)

				arg_190_1.text_.text = var_193_4

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 2
				local var_193_6 = utf8.len(var_193_4)
				local var_193_7 = var_193_5 <= 0 and var_193_1 or var_193_1 * (var_193_6 / var_193_5)

				if var_193_7 > 0 and var_193_1 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_4
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_8 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_8 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_8

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_8 and arg_190_1.time_ < var_193_0 + var_193_8 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play938041048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 938041048
		arg_194_1.duration_ = 1

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"

			SetActive(arg_194_1.choicesGo_, true)

			for iter_195_0, iter_195_1 in ipairs(arg_194_1.choices_) do
				local var_195_0 = iter_195_0 <= 1

				SetActive(iter_195_1.go, var_195_0)
			end

			arg_194_1.choices_[1].txt.text = arg_194_1:FormatText(StoryChoiceCfg[1783].name)
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play938041049(arg_194_1)
			end

			arg_194_1:RecordChoiceLog(938041048, 1783)
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.allBtn_.enabled = false
			end

			local var_197_1 = 0.5

			if arg_194_1.time_ >= var_197_0 + var_197_1 and arg_194_1.time_ < var_197_0 + var_197_1 + arg_197_0 then
				arg_194_1.allBtn_.enabled = true
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play938041049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 938041049
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play938041050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0
			local var_201_1 = 0.625

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_2 = arg_198_1:FormatText(StoryNameCfg[7].name)

				arg_198_1.leftNameTxt_.text = var_201_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:GetWordFromCfg(938041049)
				local var_201_4 = arg_198_1:FormatText(var_201_3.content)

				arg_198_1.text_.text = var_201_4

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 25
				local var_201_6 = utf8.len(var_201_4)
				local var_201_7 = var_201_5 <= 0 and var_201_1 or var_201_1 * (var_201_6 / var_201_5)

				if var_201_7 > 0 and var_201_1 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7

					if var_201_7 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_4
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_8 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_8 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_8

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_8 and arg_198_1.time_ < var_201_0 + var_201_8 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play938041050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 938041050
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play938041051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["10183"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps10183 == nil then
				arg_202_1.var_.actorSpriteComps10183 = var_205_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_2 = 0.2

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.actorSpriteComps10183 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								local var_205_4 = Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor1.r, var_205_3)
								local var_205_5 = Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor1.g, var_205_3)
								local var_205_6 = Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor1.b, var_205_3)

								iter_205_1.color = Color.New(var_205_4, var_205_5, var_205_6)
							else
								local var_205_7 = Mathf.Lerp(iter_205_1.color.r, 1, var_205_3)

								iter_205_1.color = Color.New(var_205_7, var_205_7, var_205_7)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.actorSpriteComps10183 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_205_3 then
						if arg_202_1.isInRecall_ then
							iter_205_3.color = arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_205_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_202_1.var_.actorSpriteComps10183 = nil
			end

			local var_205_8 = arg_202_1.actors_["10183"].transform
			local var_205_9 = 0

			if var_205_9 < arg_202_1.time_ and arg_202_1.time_ <= var_205_9 + arg_205_0 then
				arg_202_1.var_.moveOldPos10183 = var_205_8.localPosition
				var_205_8.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("10183", 3)

				local var_205_10 = var_205_8.childCount

				for iter_205_4 = 0, var_205_10 - 1 do
					local var_205_11 = var_205_8:GetChild(iter_205_4)

					if var_205_11.name == "split_7" then
						var_205_11:SetAsLastSibling()
						var_205_11.gameObject:SetActive(true)

						arg_202_1.var_.actorSpriteSplit10183 = var_205_11.gameObject:GetComponent(typeof(Image))

						arg_202_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_205_12 = 0.5

			if var_205_9 <= arg_202_1.time_ and arg_202_1.time_ < var_205_9 + var_205_12 then
				local var_205_13 = (arg_202_1.time_ - var_205_9) / var_205_12
				local var_205_14 = Vector3.New(0, -475, -325)

				var_205_8.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10183, var_205_14, var_205_13)

				if arg_202_1.var_.actorSpriteSplit10183 ~= nil then
					arg_202_1.var_.actorSpriteSplit10183:SetAlpha(var_205_13)
				end
			end

			if arg_202_1.time_ >= var_205_9 + var_205_12 and arg_202_1.time_ < var_205_9 + var_205_12 + arg_205_0 then
				var_205_8.localPosition = Vector3.New(0, -475, -325)

				if arg_202_1.var_.actorSpriteSplit10183 ~= nil then
					arg_202_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_205_15 = 0
			local var_205_16 = 0.875

			if var_205_15 < arg_202_1.time_ and arg_202_1.time_ <= var_205_15 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_17 = arg_202_1:FormatText(StoryNameCfg[1562].name)

				arg_202_1.leftNameTxt_.text = var_205_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_18 = arg_202_1:GetWordFromCfg(938041050)
				local var_205_19 = arg_202_1:FormatText(var_205_18.content)

				arg_202_1.text_.text = var_205_19

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_20 = 35
				local var_205_21 = utf8.len(var_205_19)
				local var_205_22 = var_205_20 <= 0 and var_205_16 or var_205_16 * (var_205_21 / var_205_20)

				if var_205_22 > 0 and var_205_16 < var_205_22 then
					arg_202_1.talkMaxDuration = var_205_22

					if var_205_22 + var_205_15 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_22 + var_205_15
					end
				end

				arg_202_1.text_.text = var_205_19
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_23 = math.max(var_205_16, arg_202_1.talkMaxDuration)

			if var_205_15 <= arg_202_1.time_ and arg_202_1.time_ < var_205_15 + var_205_23 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_15) / var_205_23

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_15 + var_205_23 and arg_202_1.time_ < var_205_15 + var_205_23 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play938041051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 938041051
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play938041052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["10183"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps10183 == nil then
				arg_206_1.var_.actorSpriteComps10183 = var_209_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_2 = 0.2

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.actorSpriteComps10183 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								local var_209_4 = Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor2.r, var_209_3)
								local var_209_5 = Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor2.g, var_209_3)
								local var_209_6 = Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor2.b, var_209_3)

								iter_209_1.color = Color.New(var_209_4, var_209_5, var_209_6)
							else
								local var_209_7 = Mathf.Lerp(iter_209_1.color.r, 0.5, var_209_3)

								iter_209_1.color = Color.New(var_209_7, var_209_7, var_209_7)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.actorSpriteComps10183 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_209_3 then
						if arg_206_1.isInRecall_ then
							iter_209_3.color = arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_209_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_206_1.var_.actorSpriteComps10183 = nil
			end

			local var_209_8 = 0
			local var_209_9 = 0.275

			if var_209_8 < arg_206_1.time_ and arg_206_1.time_ <= var_209_8 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_10 = arg_206_1:FormatText(StoryNameCfg[7].name)

				arg_206_1.leftNameTxt_.text = var_209_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_11 = arg_206_1:GetWordFromCfg(938041051)
				local var_209_12 = arg_206_1:FormatText(var_209_11.content)

				arg_206_1.text_.text = var_209_12

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_13 = 11
				local var_209_14 = utf8.len(var_209_12)
				local var_209_15 = var_209_13 <= 0 and var_209_9 or var_209_9 * (var_209_14 / var_209_13)

				if var_209_15 > 0 and var_209_9 < var_209_15 then
					arg_206_1.talkMaxDuration = var_209_15

					if var_209_15 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_15 + var_209_8
					end
				end

				arg_206_1.text_.text = var_209_12
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_16 = math.max(var_209_9, arg_206_1.talkMaxDuration)

			if var_209_8 <= arg_206_1.time_ and arg_206_1.time_ < var_209_8 + var_209_16 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_8) / var_209_16

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_8 + var_209_16 and arg_206_1.time_ < var_209_8 + var_209_16 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play938041052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 938041052
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play938041053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10183"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps10183 == nil then
				arg_210_1.var_.actorSpriteComps10183 = var_213_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.actorSpriteComps10183 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								local var_213_4 = Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor1.r, var_213_3)
								local var_213_5 = Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor1.g, var_213_3)
								local var_213_6 = Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor1.b, var_213_3)

								iter_213_1.color = Color.New(var_213_4, var_213_5, var_213_6)
							else
								local var_213_7 = Mathf.Lerp(iter_213_1.color.r, 1, var_213_3)

								iter_213_1.color = Color.New(var_213_7, var_213_7, var_213_7)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.actorSpriteComps10183 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_213_3 then
						if arg_210_1.isInRecall_ then
							iter_213_3.color = arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_213_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_210_1.var_.actorSpriteComps10183 = nil
			end

			local var_213_8 = arg_210_1.actors_["10183"].transform
			local var_213_9 = 0

			if var_213_9 < arg_210_1.time_ and arg_210_1.time_ <= var_213_9 + arg_213_0 then
				arg_210_1.var_.moveOldPos10183 = var_213_8.localPosition
				var_213_8.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("10183", 3)

				local var_213_10 = var_213_8.childCount

				for iter_213_4 = 0, var_213_10 - 1 do
					local var_213_11 = var_213_8:GetChild(iter_213_4)

					if var_213_11.name == "split_4" then
						var_213_11:SetAsLastSibling()
						var_213_11.gameObject:SetActive(true)

						arg_210_1.var_.actorSpriteSplit10183 = var_213_11.gameObject:GetComponent(typeof(Image))

						arg_210_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_213_12 = 0.5

			if var_213_9 <= arg_210_1.time_ and arg_210_1.time_ < var_213_9 + var_213_12 then
				local var_213_13 = (arg_210_1.time_ - var_213_9) / var_213_12
				local var_213_14 = Vector3.New(0, -475, -325)

				var_213_8.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10183, var_213_14, var_213_13)

				if arg_210_1.var_.actorSpriteSplit10183 ~= nil then
					arg_210_1.var_.actorSpriteSplit10183:SetAlpha(var_213_13)
				end
			end

			if arg_210_1.time_ >= var_213_9 + var_213_12 and arg_210_1.time_ < var_213_9 + var_213_12 + arg_213_0 then
				var_213_8.localPosition = Vector3.New(0, -475, -325)

				if arg_210_1.var_.actorSpriteSplit10183 ~= nil then
					arg_210_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_213_15 = 0
			local var_213_16 = 0.5

			if var_213_15 < arg_210_1.time_ and arg_210_1.time_ <= var_213_15 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_17 = arg_210_1:FormatText(StoryNameCfg[1562].name)

				arg_210_1.leftNameTxt_.text = var_213_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_18 = arg_210_1:GetWordFromCfg(938041052)
				local var_213_19 = arg_210_1:FormatText(var_213_18.content)

				arg_210_1.text_.text = var_213_19

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_20 = 20
				local var_213_21 = utf8.len(var_213_19)
				local var_213_22 = var_213_20 <= 0 and var_213_16 or var_213_16 * (var_213_21 / var_213_20)

				if var_213_22 > 0 and var_213_16 < var_213_22 then
					arg_210_1.talkMaxDuration = var_213_22

					if var_213_22 + var_213_15 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_22 + var_213_15
					end
				end

				arg_210_1.text_.text = var_213_19
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_23 = math.max(var_213_16, arg_210_1.talkMaxDuration)

			if var_213_15 <= arg_210_1.time_ and arg_210_1.time_ < var_213_15 + var_213_23 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_15) / var_213_23

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_15 + var_213_23 and arg_210_1.time_ < var_213_15 + var_213_23 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play938041053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 938041053
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play938041054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10183"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.actorSpriteComps10183 == nil then
				arg_214_1.var_.actorSpriteComps10183 = var_217_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_2 = 0.2

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.actorSpriteComps10183 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								local var_217_4 = Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor2.r, var_217_3)
								local var_217_5 = Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor2.g, var_217_3)
								local var_217_6 = Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor2.b, var_217_3)

								iter_217_1.color = Color.New(var_217_4, var_217_5, var_217_6)
							else
								local var_217_7 = Mathf.Lerp(iter_217_1.color.r, 0.5, var_217_3)

								iter_217_1.color = Color.New(var_217_7, var_217_7, var_217_7)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.actorSpriteComps10183 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_217_3 then
						if arg_214_1.isInRecall_ then
							iter_217_3.color = arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_217_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_214_1.var_.actorSpriteComps10183 = nil
			end

			local var_217_8 = arg_214_1.actors_["10183"].transform
			local var_217_9 = 0

			if var_217_9 < arg_214_1.time_ and arg_214_1.time_ <= var_217_9 + arg_217_0 then
				arg_214_1.var_.moveOldPos10183 = var_217_8.localPosition
				var_217_8.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("10183", 7)

				local var_217_10 = var_217_8.childCount

				for iter_217_4 = 0, var_217_10 - 1 do
					local var_217_11 = var_217_8:GetChild(iter_217_4)

					if var_217_11.name == "" or not string.find(var_217_11.name, "split") then
						var_217_11.gameObject:SetActive(true)
					else
						var_217_11.gameObject:SetActive(false)
					end
				end
			end

			local var_217_12 = 0.001

			if var_217_9 <= arg_214_1.time_ and arg_214_1.time_ < var_217_9 + var_217_12 then
				local var_217_13 = (arg_214_1.time_ - var_217_9) / var_217_12
				local var_217_14 = Vector3.New(0, -2000, 0)

				var_217_8.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10183, var_217_14, var_217_13)
			end

			if arg_214_1.time_ >= var_217_9 + var_217_12 and arg_214_1.time_ < var_217_9 + var_217_12 + arg_217_0 then
				var_217_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_217_15 = 0
			local var_217_16 = 1.075

			if var_217_15 < arg_214_1.time_ and arg_214_1.time_ <= var_217_15 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_17 = arg_214_1:GetWordFromCfg(938041053)
				local var_217_18 = arg_214_1:FormatText(var_217_17.content)

				arg_214_1.text_.text = var_217_18

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_19 = 43
				local var_217_20 = utf8.len(var_217_18)
				local var_217_21 = var_217_19 <= 0 and var_217_16 or var_217_16 * (var_217_20 / var_217_19)

				if var_217_21 > 0 and var_217_16 < var_217_21 then
					arg_214_1.talkMaxDuration = var_217_21

					if var_217_21 + var_217_15 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_21 + var_217_15
					end
				end

				arg_214_1.text_.text = var_217_18
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_22 = math.max(var_217_16, arg_214_1.talkMaxDuration)

			if var_217_15 <= arg_214_1.time_ and arg_214_1.time_ < var_217_15 + var_217_22 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_15) / var_217_22

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_15 + var_217_22 and arg_214_1.time_ < var_217_15 + var_217_22 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play938041054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 938041054
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play938041055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0
			local var_221_1 = 0.425

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_2 = arg_218_1:FormatText(StoryNameCfg[7].name)

				arg_218_1.leftNameTxt_.text = var_221_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_3 = arg_218_1:GetWordFromCfg(938041054)
				local var_221_4 = arg_218_1:FormatText(var_221_3.content)

				arg_218_1.text_.text = var_221_4

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 17
				local var_221_6 = utf8.len(var_221_4)
				local var_221_7 = var_221_5 <= 0 and var_221_1 or var_221_1 * (var_221_6 / var_221_5)

				if var_221_7 > 0 and var_221_1 < var_221_7 then
					arg_218_1.talkMaxDuration = var_221_7

					if var_221_7 + var_221_0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_7 + var_221_0
					end
				end

				arg_218_1.text_.text = var_221_4
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_8 = math.max(var_221_1, arg_218_1.talkMaxDuration)

			if var_221_0 <= arg_218_1.time_ and arg_218_1.time_ < var_221_0 + var_221_8 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_0) / var_221_8

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_0 + var_221_8 and arg_218_1.time_ < var_221_0 + var_221_8 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play938041055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 938041055
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play938041056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10183"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps10183 == nil then
				arg_222_1.var_.actorSpriteComps10183 = var_225_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.actorSpriteComps10183 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								local var_225_4 = Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, var_225_3)
								local var_225_5 = Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, var_225_3)
								local var_225_6 = Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, var_225_3)

								iter_225_1.color = Color.New(var_225_4, var_225_5, var_225_6)
							else
								local var_225_7 = Mathf.Lerp(iter_225_1.color.r, 1, var_225_3)

								iter_225_1.color = Color.New(var_225_7, var_225_7, var_225_7)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.actorSpriteComps10183 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_225_3 then
						if arg_222_1.isInRecall_ then
							iter_225_3.color = arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_225_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_222_1.var_.actorSpriteComps10183 = nil
			end

			local var_225_8 = arg_222_1.actors_["10183"].transform
			local var_225_9 = 0

			if var_225_9 < arg_222_1.time_ and arg_222_1.time_ <= var_225_9 + arg_225_0 then
				arg_222_1.var_.moveOldPos10183 = var_225_8.localPosition
				var_225_8.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("10183", 3)

				local var_225_10 = var_225_8.childCount

				for iter_225_4 = 0, var_225_10 - 1 do
					local var_225_11 = var_225_8:GetChild(iter_225_4)

					if var_225_11.name == "split_1" or not string.find(var_225_11.name, "split") then
						var_225_11.gameObject:SetActive(true)
					else
						var_225_11.gameObject:SetActive(false)
					end
				end
			end

			local var_225_12 = 0.001

			if var_225_9 <= arg_222_1.time_ and arg_222_1.time_ < var_225_9 + var_225_12 then
				local var_225_13 = (arg_222_1.time_ - var_225_9) / var_225_12
				local var_225_14 = Vector3.New(0, -475, -325)

				var_225_8.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10183, var_225_14, var_225_13)
			end

			if arg_222_1.time_ >= var_225_9 + var_225_12 and arg_222_1.time_ < var_225_9 + var_225_12 + arg_225_0 then
				var_225_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_225_15 = 0
			local var_225_16 = 1.125

			if var_225_15 < arg_222_1.time_ and arg_222_1.time_ <= var_225_15 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_17 = arg_222_1:FormatText(StoryNameCfg[1562].name)

				arg_222_1.leftNameTxt_.text = var_225_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_18 = arg_222_1:GetWordFromCfg(938041055)
				local var_225_19 = arg_222_1:FormatText(var_225_18.content)

				arg_222_1.text_.text = var_225_19

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_20 = 45
				local var_225_21 = utf8.len(var_225_19)
				local var_225_22 = var_225_20 <= 0 and var_225_16 or var_225_16 * (var_225_21 / var_225_20)

				if var_225_22 > 0 and var_225_16 < var_225_22 then
					arg_222_1.talkMaxDuration = var_225_22

					if var_225_22 + var_225_15 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_22 + var_225_15
					end
				end

				arg_222_1.text_.text = var_225_19
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_23 = math.max(var_225_16, arg_222_1.talkMaxDuration)

			if var_225_15 <= arg_222_1.time_ and arg_222_1.time_ < var_225_15 + var_225_23 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_15) / var_225_23

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_15 + var_225_23 and arg_222_1.time_ < var_225_15 + var_225_23 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0329999998211861,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play938041056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 938041056
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play938041057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["10183"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos10183 = var_229_0.localPosition
				var_229_0.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10183", 3)

				local var_229_2 = var_229_0.childCount

				for iter_229_0 = 0, var_229_2 - 1 do
					local var_229_3 = var_229_0:GetChild(iter_229_0)

					if var_229_3.name == "" or not string.find(var_229_3.name, "split") then
						var_229_3.gameObject:SetActive(true)
					else
						var_229_3.gameObject:SetActive(false)
					end
				end
			end

			local var_229_4 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_4 then
				local var_229_5 = (arg_226_1.time_ - var_229_1) / var_229_4
				local var_229_6 = Vector3.New(0, -475, -325)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10183, var_229_6, var_229_5)
			end

			if arg_226_1.time_ >= var_229_1 + var_229_4 and arg_226_1.time_ < var_229_1 + var_229_4 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(0, -475, -325)
			end

			local var_229_7 = 0
			local var_229_8 = 0.25

			if var_229_7 < arg_226_1.time_ and arg_226_1.time_ <= var_229_7 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_9 = arg_226_1:FormatText(StoryNameCfg[1562].name)

				arg_226_1.leftNameTxt_.text = var_229_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_10 = arg_226_1:GetWordFromCfg(938041056)
				local var_229_11 = arg_226_1:FormatText(var_229_10.content)

				arg_226_1.text_.text = var_229_11

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_12 = 10
				local var_229_13 = utf8.len(var_229_11)
				local var_229_14 = var_229_12 <= 0 and var_229_8 or var_229_8 * (var_229_13 / var_229_12)

				if var_229_14 > 0 and var_229_8 < var_229_14 then
					arg_226_1.talkMaxDuration = var_229_14

					if var_229_14 + var_229_7 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_14 + var_229_7
					end
				end

				arg_226_1.text_.text = var_229_11
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_15 = math.max(var_229_8, arg_226_1.talkMaxDuration)

			if var_229_7 <= arg_226_1.time_ and arg_226_1.time_ < var_229_7 + var_229_15 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_7) / var_229_15

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_7 + var_229_15 and arg_226_1.time_ < var_229_7 + var_229_15 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play938041057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 938041057
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play938041058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10183"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps10183 == nil then
				arg_230_1.var_.actorSpriteComps10183 = var_233_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_2 = 0.2

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.actorSpriteComps10183 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								local var_233_4 = Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor2.r, var_233_3)
								local var_233_5 = Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor2.g, var_233_3)
								local var_233_6 = Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor2.b, var_233_3)

								iter_233_1.color = Color.New(var_233_4, var_233_5, var_233_6)
							else
								local var_233_7 = Mathf.Lerp(iter_233_1.color.r, 0.5, var_233_3)

								iter_233_1.color = Color.New(var_233_7, var_233_7, var_233_7)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.actorSpriteComps10183 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_233_3 then
						if arg_230_1.isInRecall_ then
							iter_233_3.color = arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_233_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_230_1.var_.actorSpriteComps10183 = nil
			end

			local var_233_8 = 0
			local var_233_9 = 0.425

			if var_233_8 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_10 = arg_230_1:FormatText(StoryNameCfg[7].name)

				arg_230_1.leftNameTxt_.text = var_233_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_11 = arg_230_1:GetWordFromCfg(938041057)
				local var_233_12 = arg_230_1:FormatText(var_233_11.content)

				arg_230_1.text_.text = var_233_12

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_13 = 17
				local var_233_14 = utf8.len(var_233_12)
				local var_233_15 = var_233_13 <= 0 and var_233_9 or var_233_9 * (var_233_14 / var_233_13)

				if var_233_15 > 0 and var_233_9 < var_233_15 then
					arg_230_1.talkMaxDuration = var_233_15

					if var_233_15 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_15 + var_233_8
					end
				end

				arg_230_1.text_.text = var_233_12
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = math.max(var_233_9, arg_230_1.talkMaxDuration)

			if var_233_8 <= arg_230_1.time_ and arg_230_1.time_ < var_233_8 + var_233_16 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_8) / var_233_16

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_8 + var_233_16 and arg_230_1.time_ < var_233_8 + var_233_16 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play938041058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 938041058
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play938041059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["10183"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.actorSpriteComps10183 == nil then
				arg_234_1.var_.actorSpriteComps10183 = var_237_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_2 = 0.2

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.actorSpriteComps10183 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								local var_237_4 = Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor1.r, var_237_3)
								local var_237_5 = Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor1.g, var_237_3)
								local var_237_6 = Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor1.b, var_237_3)

								iter_237_1.color = Color.New(var_237_4, var_237_5, var_237_6)
							else
								local var_237_7 = Mathf.Lerp(iter_237_1.color.r, 1, var_237_3)

								iter_237_1.color = Color.New(var_237_7, var_237_7, var_237_7)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.actorSpriteComps10183 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_237_3 then
						if arg_234_1.isInRecall_ then
							iter_237_3.color = arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_237_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_234_1.var_.actorSpriteComps10183 = nil
			end

			local var_237_8 = arg_234_1.actors_["10183"].transform
			local var_237_9 = 0

			if var_237_9 < arg_234_1.time_ and arg_234_1.time_ <= var_237_9 + arg_237_0 then
				arg_234_1.var_.moveOldPos10183 = var_237_8.localPosition
				var_237_8.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10183", 3)

				local var_237_10 = var_237_8.childCount

				for iter_237_4 = 0, var_237_10 - 1 do
					local var_237_11 = var_237_8:GetChild(iter_237_4)

					if var_237_11.name == "split_7" then
						var_237_11:SetAsLastSibling()
						var_237_11.gameObject:SetActive(true)

						arg_234_1.var_.actorSpriteSplit10183 = var_237_11.gameObject:GetComponent(typeof(Image))

						arg_234_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_237_12 = 0.5

			if var_237_9 <= arg_234_1.time_ and arg_234_1.time_ < var_237_9 + var_237_12 then
				local var_237_13 = (arg_234_1.time_ - var_237_9) / var_237_12
				local var_237_14 = Vector3.New(0, -475, -325)

				var_237_8.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10183, var_237_14, var_237_13)

				if arg_234_1.var_.actorSpriteSplit10183 ~= nil then
					arg_234_1.var_.actorSpriteSplit10183:SetAlpha(var_237_13)
				end
			end

			if arg_234_1.time_ >= var_237_9 + var_237_12 and arg_234_1.time_ < var_237_9 + var_237_12 + arg_237_0 then
				var_237_8.localPosition = Vector3.New(0, -475, -325)

				if arg_234_1.var_.actorSpriteSplit10183 ~= nil then
					arg_234_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_237_15 = 0
			local var_237_16 = 0.525

			if var_237_15 < arg_234_1.time_ and arg_234_1.time_ <= var_237_15 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_17 = arg_234_1:FormatText(StoryNameCfg[1562].name)

				arg_234_1.leftNameTxt_.text = var_237_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_18 = arg_234_1:GetWordFromCfg(938041058)
				local var_237_19 = arg_234_1:FormatText(var_237_18.content)

				arg_234_1.text_.text = var_237_19

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_20 = 21
				local var_237_21 = utf8.len(var_237_19)
				local var_237_22 = var_237_20 <= 0 and var_237_16 or var_237_16 * (var_237_21 / var_237_20)

				if var_237_22 > 0 and var_237_16 < var_237_22 then
					arg_234_1.talkMaxDuration = var_237_22

					if var_237_22 + var_237_15 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_22 + var_237_15
					end
				end

				arg_234_1.text_.text = var_237_19
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_23 = math.max(var_237_16, arg_234_1.talkMaxDuration)

			if var_237_15 <= arg_234_1.time_ and arg_234_1.time_ < var_237_15 + var_237_23 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_15) / var_237_23

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_15 + var_237_23 and arg_234_1.time_ < var_237_15 + var_237_23 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play938041059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 938041059
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play938041060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["10183"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.actorSpriteComps10183 == nil then
				arg_238_1.var_.actorSpriteComps10183 = var_241_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_2 = 0.2

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.actorSpriteComps10183 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_241_1 then
							if arg_238_1.isInRecall_ then
								local var_241_4 = Mathf.Lerp(iter_241_1.color.r, arg_238_1.hightColor2.r, var_241_3)
								local var_241_5 = Mathf.Lerp(iter_241_1.color.g, arg_238_1.hightColor2.g, var_241_3)
								local var_241_6 = Mathf.Lerp(iter_241_1.color.b, arg_238_1.hightColor2.b, var_241_3)

								iter_241_1.color = Color.New(var_241_4, var_241_5, var_241_6)
							else
								local var_241_7 = Mathf.Lerp(iter_241_1.color.r, 0.5, var_241_3)

								iter_241_1.color = Color.New(var_241_7, var_241_7, var_241_7)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.actorSpriteComps10183 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_241_3 then
						if arg_238_1.isInRecall_ then
							iter_241_3.color = arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_241_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_238_1.var_.actorSpriteComps10183 = nil
			end

			local var_241_8 = 0
			local var_241_9 = 0.45

			if var_241_8 < arg_238_1.time_ and arg_238_1.time_ <= var_241_8 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_10 = arg_238_1:FormatText(StoryNameCfg[7].name)

				arg_238_1.leftNameTxt_.text = var_241_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_11 = arg_238_1:GetWordFromCfg(938041059)
				local var_241_12 = arg_238_1:FormatText(var_241_11.content)

				arg_238_1.text_.text = var_241_12

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_13 = 18
				local var_241_14 = utf8.len(var_241_12)
				local var_241_15 = var_241_13 <= 0 and var_241_9 or var_241_9 * (var_241_14 / var_241_13)

				if var_241_15 > 0 and var_241_9 < var_241_15 then
					arg_238_1.talkMaxDuration = var_241_15

					if var_241_15 + var_241_8 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_15 + var_241_8
					end
				end

				arg_238_1.text_.text = var_241_12
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_16 = math.max(var_241_9, arg_238_1.talkMaxDuration)

			if var_241_8 <= arg_238_1.time_ and arg_238_1.time_ < var_241_8 + var_241_16 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_8) / var_241_16

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_8 + var_241_16 and arg_238_1.time_ < var_241_8 + var_241_16 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play938041060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 938041060
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play938041061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["10183"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.actorSpriteComps10183 == nil then
				arg_242_1.var_.actorSpriteComps10183 = var_245_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_2 = 0.2

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.actorSpriteComps10183 then
					for iter_245_0, iter_245_1 in pairs(arg_242_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_245_1 then
							if arg_242_1.isInRecall_ then
								local var_245_4 = Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor1.r, var_245_3)
								local var_245_5 = Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor1.g, var_245_3)
								local var_245_6 = Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor1.b, var_245_3)

								iter_245_1.color = Color.New(var_245_4, var_245_5, var_245_6)
							else
								local var_245_7 = Mathf.Lerp(iter_245_1.color.r, 1, var_245_3)

								iter_245_1.color = Color.New(var_245_7, var_245_7, var_245_7)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.actorSpriteComps10183 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_245_3 then
						if arg_242_1.isInRecall_ then
							iter_245_3.color = arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_245_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_242_1.var_.actorSpriteComps10183 = nil
			end

			local var_245_8 = arg_242_1.actors_["10183"].transform
			local var_245_9 = 0

			if var_245_9 < arg_242_1.time_ and arg_242_1.time_ <= var_245_9 + arg_245_0 then
				arg_242_1.var_.moveOldPos10183 = var_245_8.localPosition
				var_245_8.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10183", 3)

				local var_245_10 = var_245_8.childCount

				for iter_245_4 = 0, var_245_10 - 1 do
					local var_245_11 = var_245_8:GetChild(iter_245_4)

					if var_245_11.name == "split_1" then
						var_245_11:SetAsLastSibling()
						var_245_11.gameObject:SetActive(true)

						arg_242_1.var_.actorSpriteSplit10183 = var_245_11.gameObject:GetComponent(typeof(Image))

						arg_242_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_245_12 = 0.5

			if var_245_9 <= arg_242_1.time_ and arg_242_1.time_ < var_245_9 + var_245_12 then
				local var_245_13 = (arg_242_1.time_ - var_245_9) / var_245_12
				local var_245_14 = Vector3.New(0, -475, -325)

				var_245_8.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10183, var_245_14, var_245_13)

				if arg_242_1.var_.actorSpriteSplit10183 ~= nil then
					arg_242_1.var_.actorSpriteSplit10183:SetAlpha(var_245_13)
				end
			end

			if arg_242_1.time_ >= var_245_9 + var_245_12 and arg_242_1.time_ < var_245_9 + var_245_12 + arg_245_0 then
				var_245_8.localPosition = Vector3.New(0, -475, -325)

				if arg_242_1.var_.actorSpriteSplit10183 ~= nil then
					arg_242_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_245_15 = 0
			local var_245_16 = 0.825

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_17 = arg_242_1:FormatText(StoryNameCfg[1562].name)

				arg_242_1.leftNameTxt_.text = var_245_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_18 = arg_242_1:GetWordFromCfg(938041060)
				local var_245_19 = arg_242_1:FormatText(var_245_18.content)

				arg_242_1.text_.text = var_245_19

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_20 = 33
				local var_245_21 = utf8.len(var_245_19)
				local var_245_22 = var_245_20 <= 0 and var_245_16 or var_245_16 * (var_245_21 / var_245_20)

				if var_245_22 > 0 and var_245_16 < var_245_22 then
					arg_242_1.talkMaxDuration = var_245_22

					if var_245_22 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_22 + var_245_15
					end
				end

				arg_242_1.text_.text = var_245_19
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_23 = math.max(var_245_16, arg_242_1.talkMaxDuration)

			if var_245_15 <= arg_242_1.time_ and arg_242_1.time_ < var_245_15 + var_245_23 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_15) / var_245_23

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_15 + var_245_23 and arg_242_1.time_ < var_245_15 + var_245_23 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play938041061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 938041061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play938041062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["10183"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos10183 = var_249_0.localPosition
				var_249_0.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("10183", 3)

				local var_249_2 = var_249_0.childCount

				for iter_249_0 = 0, var_249_2 - 1 do
					local var_249_3 = var_249_0:GetChild(iter_249_0)

					if var_249_3.name == "split_7" then
						var_249_3:SetAsLastSibling()
						var_249_3.gameObject:SetActive(true)

						arg_246_1.var_.actorSpriteSplit10183 = var_249_3.gameObject:GetComponent(typeof(Image))

						arg_246_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_249_4 = 0.5

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_4 then
				local var_249_5 = (arg_246_1.time_ - var_249_1) / var_249_4
				local var_249_6 = Vector3.New(0, -475, -325)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos10183, var_249_6, var_249_5)

				if arg_246_1.var_.actorSpriteSplit10183 ~= nil then
					arg_246_1.var_.actorSpriteSplit10183:SetAlpha(var_249_5)
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_4 and arg_246_1.time_ < var_249_1 + var_249_4 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0, -475, -325)

				if arg_246_1.var_.actorSpriteSplit10183 ~= nil then
					arg_246_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_249_7 = 0
			local var_249_8 = 0.95

			if var_249_7 < arg_246_1.time_ and arg_246_1.time_ <= var_249_7 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_9 = arg_246_1:FormatText(StoryNameCfg[1562].name)

				arg_246_1.leftNameTxt_.text = var_249_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_10 = arg_246_1:GetWordFromCfg(938041061)
				local var_249_11 = arg_246_1:FormatText(var_249_10.content)

				arg_246_1.text_.text = var_249_11

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_12 = 38
				local var_249_13 = utf8.len(var_249_11)
				local var_249_14 = var_249_12 <= 0 and var_249_8 or var_249_8 * (var_249_13 / var_249_12)

				if var_249_14 > 0 and var_249_8 < var_249_14 then
					arg_246_1.talkMaxDuration = var_249_14

					if var_249_14 + var_249_7 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_14 + var_249_7
					end
				end

				arg_246_1.text_.text = var_249_11
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_15 = math.max(var_249_8, arg_246_1.talkMaxDuration)

			if var_249_7 <= arg_246_1.time_ and arg_246_1.time_ < var_249_7 + var_249_15 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_7) / var_249_15

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_7 + var_249_15 and arg_246_1.time_ < var_249_7 + var_249_15 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play938041062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 938041062
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play938041063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["10183"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps10183 == nil then
				arg_250_1.var_.actorSpriteComps10183 = var_253_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_2 = 0.2

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.actorSpriteComps10183 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								local var_253_4 = Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor2.r, var_253_3)
								local var_253_5 = Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor2.g, var_253_3)
								local var_253_6 = Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor2.b, var_253_3)

								iter_253_1.color = Color.New(var_253_4, var_253_5, var_253_6)
							else
								local var_253_7 = Mathf.Lerp(iter_253_1.color.r, 0.5, var_253_3)

								iter_253_1.color = Color.New(var_253_7, var_253_7, var_253_7)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.actorSpriteComps10183 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_253_3 then
						if arg_250_1.isInRecall_ then
							iter_253_3.color = arg_250_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_253_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_250_1.var_.actorSpriteComps10183 = nil
			end

			local var_253_8 = 0
			local var_253_9 = 0.625

			if var_253_8 < arg_250_1.time_ and arg_250_1.time_ <= var_253_8 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_10 = arg_250_1:FormatText(StoryNameCfg[7].name)

				arg_250_1.leftNameTxt_.text = var_253_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_11 = arg_250_1:GetWordFromCfg(938041062)
				local var_253_12 = arg_250_1:FormatText(var_253_11.content)

				arg_250_1.text_.text = var_253_12

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_13 = 25
				local var_253_14 = utf8.len(var_253_12)
				local var_253_15 = var_253_13 <= 0 and var_253_9 or var_253_9 * (var_253_14 / var_253_13)

				if var_253_15 > 0 and var_253_9 < var_253_15 then
					arg_250_1.talkMaxDuration = var_253_15

					if var_253_15 + var_253_8 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_15 + var_253_8
					end
				end

				arg_250_1.text_.text = var_253_12
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_16 = math.max(var_253_9, arg_250_1.talkMaxDuration)

			if var_253_8 <= arg_250_1.time_ and arg_250_1.time_ < var_253_8 + var_253_16 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_8) / var_253_16

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_8 + var_253_16 and arg_250_1.time_ < var_253_8 + var_253_16 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play938041063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 938041063
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play938041064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["10183"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps10183 == nil then
				arg_254_1.var_.actorSpriteComps10183 = var_257_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_2 = 0.2

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.actorSpriteComps10183 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								local var_257_4 = Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor1.r, var_257_3)
								local var_257_5 = Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor1.g, var_257_3)
								local var_257_6 = Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor1.b, var_257_3)

								iter_257_1.color = Color.New(var_257_4, var_257_5, var_257_6)
							else
								local var_257_7 = Mathf.Lerp(iter_257_1.color.r, 1, var_257_3)

								iter_257_1.color = Color.New(var_257_7, var_257_7, var_257_7)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.actorSpriteComps10183 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_257_3 then
						if arg_254_1.isInRecall_ then
							iter_257_3.color = arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_257_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_254_1.var_.actorSpriteComps10183 = nil
			end

			local var_257_8 = arg_254_1.actors_["10183"].transform
			local var_257_9 = 0

			if var_257_9 < arg_254_1.time_ and arg_254_1.time_ <= var_257_9 + arg_257_0 then
				arg_254_1.var_.moveOldPos10183 = var_257_8.localPosition
				var_257_8.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("10183", 3)

				local var_257_10 = var_257_8.childCount

				for iter_257_4 = 0, var_257_10 - 1 do
					local var_257_11 = var_257_8:GetChild(iter_257_4)

					if var_257_11.name == "split_1" then
						var_257_11:SetAsLastSibling()
						var_257_11.gameObject:SetActive(true)

						arg_254_1.var_.actorSpriteSplit10183 = var_257_11.gameObject:GetComponent(typeof(Image))

						arg_254_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_257_12 = 0.5

			if var_257_9 <= arg_254_1.time_ and arg_254_1.time_ < var_257_9 + var_257_12 then
				local var_257_13 = (arg_254_1.time_ - var_257_9) / var_257_12
				local var_257_14 = Vector3.New(0, -475, -325)

				var_257_8.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10183, var_257_14, var_257_13)

				if arg_254_1.var_.actorSpriteSplit10183 ~= nil then
					arg_254_1.var_.actorSpriteSplit10183:SetAlpha(var_257_13)
				end
			end

			if arg_254_1.time_ >= var_257_9 + var_257_12 and arg_254_1.time_ < var_257_9 + var_257_12 + arg_257_0 then
				var_257_8.localPosition = Vector3.New(0, -475, -325)

				if arg_254_1.var_.actorSpriteSplit10183 ~= nil then
					arg_254_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_257_15 = 0
			local var_257_16 = 0.175

			if var_257_15 < arg_254_1.time_ and arg_254_1.time_ <= var_257_15 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_17 = arg_254_1:FormatText(StoryNameCfg[1562].name)

				arg_254_1.leftNameTxt_.text = var_257_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_18 = arg_254_1:GetWordFromCfg(938041063)
				local var_257_19 = arg_254_1:FormatText(var_257_18.content)

				arg_254_1.text_.text = var_257_19

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_20 = 7
				local var_257_21 = utf8.len(var_257_19)
				local var_257_22 = var_257_20 <= 0 and var_257_16 or var_257_16 * (var_257_21 / var_257_20)

				if var_257_22 > 0 and var_257_16 < var_257_22 then
					arg_254_1.talkMaxDuration = var_257_22

					if var_257_22 + var_257_15 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_22 + var_257_15
					end
				end

				arg_254_1.text_.text = var_257_19
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_23 = math.max(var_257_16, arg_254_1.talkMaxDuration)

			if var_257_15 <= arg_254_1.time_ and arg_254_1.time_ < var_257_15 + var_257_23 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_15) / var_257_23

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_15 + var_257_23 and arg_254_1.time_ < var_257_15 + var_257_23 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play938041064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 938041064
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play938041065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["10183"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps10183 == nil then
				arg_258_1.var_.actorSpriteComps10183 = var_261_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_2 = 0.2

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.actorSpriteComps10183 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_261_1 then
							if arg_258_1.isInRecall_ then
								local var_261_4 = Mathf.Lerp(iter_261_1.color.r, arg_258_1.hightColor2.r, var_261_3)
								local var_261_5 = Mathf.Lerp(iter_261_1.color.g, arg_258_1.hightColor2.g, var_261_3)
								local var_261_6 = Mathf.Lerp(iter_261_1.color.b, arg_258_1.hightColor2.b, var_261_3)

								iter_261_1.color = Color.New(var_261_4, var_261_5, var_261_6)
							else
								local var_261_7 = Mathf.Lerp(iter_261_1.color.r, 0.5, var_261_3)

								iter_261_1.color = Color.New(var_261_7, var_261_7, var_261_7)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.actorSpriteComps10183 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_261_3 then
						if arg_258_1.isInRecall_ then
							iter_261_3.color = arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_261_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_258_1.var_.actorSpriteComps10183 = nil
			end

			local var_261_8 = 0
			local var_261_9 = 0.3

			if var_261_8 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_10 = arg_258_1:FormatText(StoryNameCfg[7].name)

				arg_258_1.leftNameTxt_.text = var_261_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_11 = arg_258_1:GetWordFromCfg(938041064)
				local var_261_12 = arg_258_1:FormatText(var_261_11.content)

				arg_258_1.text_.text = var_261_12

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_13 = 12
				local var_261_14 = utf8.len(var_261_12)
				local var_261_15 = var_261_13 <= 0 and var_261_9 or var_261_9 * (var_261_14 / var_261_13)

				if var_261_15 > 0 and var_261_9 < var_261_15 then
					arg_258_1.talkMaxDuration = var_261_15

					if var_261_15 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_15 + var_261_8
					end
				end

				arg_258_1.text_.text = var_261_12
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_16 = math.max(var_261_9, arg_258_1.talkMaxDuration)

			if var_261_8 <= arg_258_1.time_ and arg_258_1.time_ < var_261_8 + var_261_16 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_8) / var_261_16

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_8 + var_261_16 and arg_258_1.time_ < var_261_8 + var_261_16 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play938041065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 938041065
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play938041066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["10183"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.actorSpriteComps10183 == nil then
				arg_262_1.var_.actorSpriteComps10183 = var_265_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_2 = 0.2

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.actorSpriteComps10183 then
					for iter_265_0, iter_265_1 in pairs(arg_262_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_265_1 then
							if arg_262_1.isInRecall_ then
								local var_265_4 = Mathf.Lerp(iter_265_1.color.r, arg_262_1.hightColor1.r, var_265_3)
								local var_265_5 = Mathf.Lerp(iter_265_1.color.g, arg_262_1.hightColor1.g, var_265_3)
								local var_265_6 = Mathf.Lerp(iter_265_1.color.b, arg_262_1.hightColor1.b, var_265_3)

								iter_265_1.color = Color.New(var_265_4, var_265_5, var_265_6)
							else
								local var_265_7 = Mathf.Lerp(iter_265_1.color.r, 1, var_265_3)

								iter_265_1.color = Color.New(var_265_7, var_265_7, var_265_7)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.actorSpriteComps10183 then
				for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_265_3 then
						if arg_262_1.isInRecall_ then
							iter_265_3.color = arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_265_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_262_1.var_.actorSpriteComps10183 = nil
			end

			local var_265_8 = arg_262_1.actors_["10183"].transform
			local var_265_9 = 0

			if var_265_9 < arg_262_1.time_ and arg_262_1.time_ <= var_265_9 + arg_265_0 then
				arg_262_1.var_.moveOldPos10183 = var_265_8.localPosition
				var_265_8.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("10183", 3)

				local var_265_10 = var_265_8.childCount

				for iter_265_4 = 0, var_265_10 - 1 do
					local var_265_11 = var_265_8:GetChild(iter_265_4)

					if var_265_11.name == "" or not string.find(var_265_11.name, "split") then
						var_265_11.gameObject:SetActive(true)
					else
						var_265_11.gameObject:SetActive(false)
					end
				end
			end

			local var_265_12 = 0.001

			if var_265_9 <= arg_262_1.time_ and arg_262_1.time_ < var_265_9 + var_265_12 then
				local var_265_13 = (arg_262_1.time_ - var_265_9) / var_265_12
				local var_265_14 = Vector3.New(0, -475, -325)

				var_265_8.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos10183, var_265_14, var_265_13)
			end

			if arg_262_1.time_ >= var_265_9 + var_265_12 and arg_262_1.time_ < var_265_9 + var_265_12 + arg_265_0 then
				var_265_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_265_15 = 0
			local var_265_16 = 0.7

			if var_265_15 < arg_262_1.time_ and arg_262_1.time_ <= var_265_15 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_17 = arg_262_1:FormatText(StoryNameCfg[1562].name)

				arg_262_1.leftNameTxt_.text = var_265_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_18 = arg_262_1:GetWordFromCfg(938041065)
				local var_265_19 = arg_262_1:FormatText(var_265_18.content)

				arg_262_1.text_.text = var_265_19

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_20 = 28
				local var_265_21 = utf8.len(var_265_19)
				local var_265_22 = var_265_20 <= 0 and var_265_16 or var_265_16 * (var_265_21 / var_265_20)

				if var_265_22 > 0 and var_265_16 < var_265_22 then
					arg_262_1.talkMaxDuration = var_265_22

					if var_265_22 + var_265_15 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_22 + var_265_15
					end
				end

				arg_262_1.text_.text = var_265_19
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_23 = math.max(var_265_16, arg_262_1.talkMaxDuration)

			if var_265_15 <= arg_262_1.time_ and arg_262_1.time_ < var_265_15 + var_265_23 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_15) / var_265_23

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_15 + var_265_23 and arg_262_1.time_ < var_265_15 + var_265_23 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play938041066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 938041066
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play938041067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["10183"]
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.actorSpriteComps10183 == nil then
				arg_266_1.var_.actorSpriteComps10183 = var_269_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_2 = 0.2

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 and not isNil(var_269_0) then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2

				if arg_266_1.var_.actorSpriteComps10183 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_269_1 then
							if arg_266_1.isInRecall_ then
								local var_269_4 = Mathf.Lerp(iter_269_1.color.r, arg_266_1.hightColor2.r, var_269_3)
								local var_269_5 = Mathf.Lerp(iter_269_1.color.g, arg_266_1.hightColor2.g, var_269_3)
								local var_269_6 = Mathf.Lerp(iter_269_1.color.b, arg_266_1.hightColor2.b, var_269_3)

								iter_269_1.color = Color.New(var_269_4, var_269_5, var_269_6)
							else
								local var_269_7 = Mathf.Lerp(iter_269_1.color.r, 0.5, var_269_3)

								iter_269_1.color = Color.New(var_269_7, var_269_7, var_269_7)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 and not isNil(var_269_0) and arg_266_1.var_.actorSpriteComps10183 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_269_3 then
						if arg_266_1.isInRecall_ then
							iter_269_3.color = arg_266_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_269_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_266_1.var_.actorSpriteComps10183 = nil
			end

			local var_269_8 = arg_266_1.actors_["10183"].transform
			local var_269_9 = 0

			if var_269_9 < arg_266_1.time_ and arg_266_1.time_ <= var_269_9 + arg_269_0 then
				arg_266_1.var_.moveOldPos10183 = var_269_8.localPosition
				var_269_8.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("10183", 7)

				local var_269_10 = var_269_8.childCount

				for iter_269_4 = 0, var_269_10 - 1 do
					local var_269_11 = var_269_8:GetChild(iter_269_4)

					if var_269_11.name == "" or not string.find(var_269_11.name, "split") then
						var_269_11.gameObject:SetActive(true)
					else
						var_269_11.gameObject:SetActive(false)
					end
				end
			end

			local var_269_12 = 0.001

			if var_269_9 <= arg_266_1.time_ and arg_266_1.time_ < var_269_9 + var_269_12 then
				local var_269_13 = (arg_266_1.time_ - var_269_9) / var_269_12
				local var_269_14 = Vector3.New(0, -2000, 0)

				var_269_8.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10183, var_269_14, var_269_13)
			end

			if arg_266_1.time_ >= var_269_9 + var_269_12 and arg_266_1.time_ < var_269_9 + var_269_12 + arg_269_0 then
				var_269_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_269_15 = 0
			local var_269_16 = 0.925

			if var_269_15 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_17 = arg_266_1:GetWordFromCfg(938041066)
				local var_269_18 = arg_266_1:FormatText(var_269_17.content)

				arg_266_1.text_.text = var_269_18

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_19 = 37
				local var_269_20 = utf8.len(var_269_18)
				local var_269_21 = var_269_19 <= 0 and var_269_16 or var_269_16 * (var_269_20 / var_269_19)

				if var_269_21 > 0 and var_269_16 < var_269_21 then
					arg_266_1.talkMaxDuration = var_269_21

					if var_269_21 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_21 + var_269_15
					end
				end

				arg_266_1.text_.text = var_269_18
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_22 = math.max(var_269_16, arg_266_1.talkMaxDuration)

			if var_269_15 <= arg_266_1.time_ and arg_266_1.time_ < var_269_15 + var_269_22 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_15) / var_269_22

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_15 + var_269_22 and arg_266_1.time_ < var_269_15 + var_269_22 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play938041067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 938041067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play938041068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.475

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(938041067)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 19
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_8 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_8 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_8

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_8 and arg_270_1.time_ < var_273_0 + var_273_8 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play938041068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 938041068
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play938041069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.425

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[7].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:GetWordFromCfg(938041068)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 17
				local var_277_6 = utf8.len(var_277_4)
				local var_277_7 = var_277_5 <= 0 and var_277_1 or var_277_1 * (var_277_6 / var_277_5)

				if var_277_7 > 0 and var_277_1 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_8 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_8 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_8

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_8 and arg_274_1.time_ < var_277_0 + var_277_8 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play938041069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 938041069
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play938041070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["10183"]
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.actorSpriteComps10183 == nil then
				arg_278_1.var_.actorSpriteComps10183 = var_281_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_2 = 0.2

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 and not isNil(var_281_0) then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2

				if arg_278_1.var_.actorSpriteComps10183 then
					for iter_281_0, iter_281_1 in pairs(arg_278_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_281_1 then
							if arg_278_1.isInRecall_ then
								local var_281_4 = Mathf.Lerp(iter_281_1.color.r, arg_278_1.hightColor1.r, var_281_3)
								local var_281_5 = Mathf.Lerp(iter_281_1.color.g, arg_278_1.hightColor1.g, var_281_3)
								local var_281_6 = Mathf.Lerp(iter_281_1.color.b, arg_278_1.hightColor1.b, var_281_3)

								iter_281_1.color = Color.New(var_281_4, var_281_5, var_281_6)
							else
								local var_281_7 = Mathf.Lerp(iter_281_1.color.r, 1, var_281_3)

								iter_281_1.color = Color.New(var_281_7, var_281_7, var_281_7)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 and not isNil(var_281_0) and arg_278_1.var_.actorSpriteComps10183 then
				for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_281_3 then
						if arg_278_1.isInRecall_ then
							iter_281_3.color = arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_281_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_278_1.var_.actorSpriteComps10183 = nil
			end

			local var_281_8 = arg_278_1.actors_["10183"].transform
			local var_281_9 = 0

			if var_281_9 < arg_278_1.time_ and arg_278_1.time_ <= var_281_9 + arg_281_0 then
				arg_278_1.var_.moveOldPos10183 = var_281_8.localPosition
				var_281_8.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("10183", 3)

				local var_281_10 = var_281_8.childCount

				for iter_281_4 = 0, var_281_10 - 1 do
					local var_281_11 = var_281_8:GetChild(iter_281_4)

					if var_281_11.name == "split_4" or not string.find(var_281_11.name, "split") then
						var_281_11.gameObject:SetActive(true)
					else
						var_281_11.gameObject:SetActive(false)
					end
				end
			end

			local var_281_12 = 0.001

			if var_281_9 <= arg_278_1.time_ and arg_278_1.time_ < var_281_9 + var_281_12 then
				local var_281_13 = (arg_278_1.time_ - var_281_9) / var_281_12
				local var_281_14 = Vector3.New(0, -475, -325)

				var_281_8.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10183, var_281_14, var_281_13)
			end

			if arg_278_1.time_ >= var_281_9 + var_281_12 and arg_278_1.time_ < var_281_9 + var_281_12 + arg_281_0 then
				var_281_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_281_15 = 0
			local var_281_16 = 0.275

			if var_281_15 < arg_278_1.time_ and arg_278_1.time_ <= var_281_15 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_17 = arg_278_1:FormatText(StoryNameCfg[1562].name)

				arg_278_1.leftNameTxt_.text = var_281_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_18 = arg_278_1:GetWordFromCfg(938041069)
				local var_281_19 = arg_278_1:FormatText(var_281_18.content)

				arg_278_1.text_.text = var_281_19

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_20 = 11
				local var_281_21 = utf8.len(var_281_19)
				local var_281_22 = var_281_20 <= 0 and var_281_16 or var_281_16 * (var_281_21 / var_281_20)

				if var_281_22 > 0 and var_281_16 < var_281_22 then
					arg_278_1.talkMaxDuration = var_281_22

					if var_281_22 + var_281_15 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_22 + var_281_15
					end
				end

				arg_278_1.text_.text = var_281_19
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_23 = math.max(var_281_16, arg_278_1.talkMaxDuration)

			if var_281_15 <= arg_278_1.time_ and arg_278_1.time_ < var_281_15 + var_281_23 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_15) / var_281_23

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_15 + var_281_23 and arg_278_1.time_ < var_281_15 + var_281_23 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play938041070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 938041070
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play938041071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["10183"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps10183 == nil then
				arg_282_1.var_.actorSpriteComps10183 = var_285_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_2 = 0.2

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.actorSpriteComps10183 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_285_1 then
							if arg_282_1.isInRecall_ then
								local var_285_4 = Mathf.Lerp(iter_285_1.color.r, arg_282_1.hightColor2.r, var_285_3)
								local var_285_5 = Mathf.Lerp(iter_285_1.color.g, arg_282_1.hightColor2.g, var_285_3)
								local var_285_6 = Mathf.Lerp(iter_285_1.color.b, arg_282_1.hightColor2.b, var_285_3)

								iter_285_1.color = Color.New(var_285_4, var_285_5, var_285_6)
							else
								local var_285_7 = Mathf.Lerp(iter_285_1.color.r, 0.5, var_285_3)

								iter_285_1.color = Color.New(var_285_7, var_285_7, var_285_7)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.actorSpriteComps10183 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_285_3 then
						if arg_282_1.isInRecall_ then
							iter_285_3.color = arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_285_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_282_1.var_.actorSpriteComps10183 = nil
			end

			local var_285_8 = 0
			local var_285_9 = 0.425

			if var_285_8 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_10 = arg_282_1:FormatText(StoryNameCfg[7].name)

				arg_282_1.leftNameTxt_.text = var_285_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_11 = arg_282_1:GetWordFromCfg(938041070)
				local var_285_12 = arg_282_1:FormatText(var_285_11.content)

				arg_282_1.text_.text = var_285_12

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_13 = 17
				local var_285_14 = utf8.len(var_285_12)
				local var_285_15 = var_285_13 <= 0 and var_285_9 or var_285_9 * (var_285_14 / var_285_13)

				if var_285_15 > 0 and var_285_9 < var_285_15 then
					arg_282_1.talkMaxDuration = var_285_15

					if var_285_15 + var_285_8 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_15 + var_285_8
					end
				end

				arg_282_1.text_.text = var_285_12
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_16 = math.max(var_285_9, arg_282_1.talkMaxDuration)

			if var_285_8 <= arg_282_1.time_ and arg_282_1.time_ < var_285_8 + var_285_16 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_8) / var_285_16

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_8 + var_285_16 and arg_282_1.time_ < var_285_8 + var_285_16 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play938041071 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 938041071
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play938041072(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = arg_286_1.actors_["10183"]
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.actorSpriteComps10183 == nil then
				arg_286_1.var_.actorSpriteComps10183 = var_289_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_2 = 0.2

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 and not isNil(var_289_0) then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / var_289_2

				if arg_286_1.var_.actorSpriteComps10183 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_289_1 then
							if arg_286_1.isInRecall_ then
								local var_289_4 = Mathf.Lerp(iter_289_1.color.r, arg_286_1.hightColor1.r, var_289_3)
								local var_289_5 = Mathf.Lerp(iter_289_1.color.g, arg_286_1.hightColor1.g, var_289_3)
								local var_289_6 = Mathf.Lerp(iter_289_1.color.b, arg_286_1.hightColor1.b, var_289_3)

								iter_289_1.color = Color.New(var_289_4, var_289_5, var_289_6)
							else
								local var_289_7 = Mathf.Lerp(iter_289_1.color.r, 1, var_289_3)

								iter_289_1.color = Color.New(var_289_7, var_289_7, var_289_7)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 and not isNil(var_289_0) and arg_286_1.var_.actorSpriteComps10183 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_289_3 then
						if arg_286_1.isInRecall_ then
							iter_289_3.color = arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_289_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_286_1.var_.actorSpriteComps10183 = nil
			end

			local var_289_8 = arg_286_1.actors_["10183"].transform
			local var_289_9 = 0

			if var_289_9 < arg_286_1.time_ and arg_286_1.time_ <= var_289_9 + arg_289_0 then
				arg_286_1.var_.moveOldPos10183 = var_289_8.localPosition
				var_289_8.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("10183", 3)

				local var_289_10 = var_289_8.childCount

				for iter_289_4 = 0, var_289_10 - 1 do
					local var_289_11 = var_289_8:GetChild(iter_289_4)

					if var_289_11.name == "" then
						var_289_11:SetAsLastSibling()
						var_289_11.gameObject:SetActive(true)

						arg_286_1.var_.actorSpriteSplit10183 = var_289_11.gameObject:GetComponent(typeof(Image))

						arg_286_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_289_12 = 0.5

			if var_289_9 <= arg_286_1.time_ and arg_286_1.time_ < var_289_9 + var_289_12 then
				local var_289_13 = (arg_286_1.time_ - var_289_9) / var_289_12
				local var_289_14 = Vector3.New(0, -475, -325)

				var_289_8.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10183, var_289_14, var_289_13)

				if arg_286_1.var_.actorSpriteSplit10183 ~= nil then
					arg_286_1.var_.actorSpriteSplit10183:SetAlpha(var_289_13)
				end
			end

			if arg_286_1.time_ >= var_289_9 + var_289_12 and arg_286_1.time_ < var_289_9 + var_289_12 + arg_289_0 then
				var_289_8.localPosition = Vector3.New(0, -475, -325)

				if arg_286_1.var_.actorSpriteSplit10183 ~= nil then
					arg_286_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_289_15 = 0
			local var_289_16 = 0.175

			if var_289_15 < arg_286_1.time_ and arg_286_1.time_ <= var_289_15 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_17 = arg_286_1:FormatText(StoryNameCfg[1562].name)

				arg_286_1.leftNameTxt_.text = var_289_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_18 = arg_286_1:GetWordFromCfg(938041071)
				local var_289_19 = arg_286_1:FormatText(var_289_18.content)

				arg_286_1.text_.text = var_289_19

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_20 = 7
				local var_289_21 = utf8.len(var_289_19)
				local var_289_22 = var_289_20 <= 0 and var_289_16 or var_289_16 * (var_289_21 / var_289_20)

				if var_289_22 > 0 and var_289_16 < var_289_22 then
					arg_286_1.talkMaxDuration = var_289_22

					if var_289_22 + var_289_15 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_22 + var_289_15
					end
				end

				arg_286_1.text_.text = var_289_19
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_23 = math.max(var_289_16, arg_286_1.talkMaxDuration)

			if var_289_15 <= arg_286_1.time_ and arg_286_1.time_ < var_289_15 + var_289_23 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_15) / var_289_23

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_15 + var_289_23 and arg_286_1.time_ < var_289_15 + var_289_23 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play938041072 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 938041072
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play938041073(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["10183"]
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps10183 == nil then
				arg_290_1.var_.actorSpriteComps10183 = var_293_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_2 = 0.2

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 and not isNil(var_293_0) then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2

				if arg_290_1.var_.actorSpriteComps10183 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								local var_293_4 = Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor2.r, var_293_3)
								local var_293_5 = Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor2.g, var_293_3)
								local var_293_6 = Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor2.b, var_293_3)

								iter_293_1.color = Color.New(var_293_4, var_293_5, var_293_6)
							else
								local var_293_7 = Mathf.Lerp(iter_293_1.color.r, 0.5, var_293_3)

								iter_293_1.color = Color.New(var_293_7, var_293_7, var_293_7)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 and not isNil(var_293_0) and arg_290_1.var_.actorSpriteComps10183 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_293_3 then
						if arg_290_1.isInRecall_ then
							iter_293_3.color = arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_293_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_290_1.var_.actorSpriteComps10183 = nil
			end

			local var_293_8 = 0
			local var_293_9 = 0.4

			if var_293_8 < arg_290_1.time_ and arg_290_1.time_ <= var_293_8 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_10 = arg_290_1:FormatText(StoryNameCfg[7].name)

				arg_290_1.leftNameTxt_.text = var_293_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_11 = arg_290_1:GetWordFromCfg(938041072)
				local var_293_12 = arg_290_1:FormatText(var_293_11.content)

				arg_290_1.text_.text = var_293_12

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_13 = 16
				local var_293_14 = utf8.len(var_293_12)
				local var_293_15 = var_293_13 <= 0 and var_293_9 or var_293_9 * (var_293_14 / var_293_13)

				if var_293_15 > 0 and var_293_9 < var_293_15 then
					arg_290_1.talkMaxDuration = var_293_15

					if var_293_15 + var_293_8 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_15 + var_293_8
					end
				end

				arg_290_1.text_.text = var_293_12
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_16 = math.max(var_293_9, arg_290_1.talkMaxDuration)

			if var_293_8 <= arg_290_1.time_ and arg_290_1.time_ < var_293_8 + var_293_16 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_8) / var_293_16

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_8 + var_293_16 and arg_290_1.time_ < var_293_8 + var_293_16 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play938041073 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 938041073
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play938041074(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["10183"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.actorSpriteComps10183 == nil then
				arg_294_1.var_.actorSpriteComps10183 = var_297_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_2 = 0.2

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.actorSpriteComps10183 then
					for iter_297_0, iter_297_1 in pairs(arg_294_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_297_1 then
							if arg_294_1.isInRecall_ then
								local var_297_4 = Mathf.Lerp(iter_297_1.color.r, arg_294_1.hightColor1.r, var_297_3)
								local var_297_5 = Mathf.Lerp(iter_297_1.color.g, arg_294_1.hightColor1.g, var_297_3)
								local var_297_6 = Mathf.Lerp(iter_297_1.color.b, arg_294_1.hightColor1.b, var_297_3)

								iter_297_1.color = Color.New(var_297_4, var_297_5, var_297_6)
							else
								local var_297_7 = Mathf.Lerp(iter_297_1.color.r, 1, var_297_3)

								iter_297_1.color = Color.New(var_297_7, var_297_7, var_297_7)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.actorSpriteComps10183 then
				for iter_297_2, iter_297_3 in pairs(arg_294_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_297_3 then
						if arg_294_1.isInRecall_ then
							iter_297_3.color = arg_294_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_297_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_294_1.var_.actorSpriteComps10183 = nil
			end

			local var_297_8 = arg_294_1.actors_["10183"].transform
			local var_297_9 = 0

			if var_297_9 < arg_294_1.time_ and arg_294_1.time_ <= var_297_9 + arg_297_0 then
				arg_294_1.var_.moveOldPos10183 = var_297_8.localPosition
				var_297_8.localScale = Vector3.New(1, 1, 1)

				arg_294_1:CheckSpriteTmpPos("10183", 3)

				local var_297_10 = var_297_8.childCount

				for iter_297_4 = 0, var_297_10 - 1 do
					local var_297_11 = var_297_8:GetChild(iter_297_4)

					if var_297_11.name == "" or not string.find(var_297_11.name, "split") then
						var_297_11.gameObject:SetActive(true)
					else
						var_297_11.gameObject:SetActive(false)
					end
				end
			end

			local var_297_12 = 0.001

			if var_297_9 <= arg_294_1.time_ and arg_294_1.time_ < var_297_9 + var_297_12 then
				local var_297_13 = (arg_294_1.time_ - var_297_9) / var_297_12
				local var_297_14 = Vector3.New(0, -475, -325)

				var_297_8.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10183, var_297_14, var_297_13)
			end

			if arg_294_1.time_ >= var_297_9 + var_297_12 and arg_294_1.time_ < var_297_9 + var_297_12 + arg_297_0 then
				var_297_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_297_15 = 0
			local var_297_16 = 0.45

			if var_297_15 < arg_294_1.time_ and arg_294_1.time_ <= var_297_15 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_17 = arg_294_1:FormatText(StoryNameCfg[1562].name)

				arg_294_1.leftNameTxt_.text = var_297_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_18 = arg_294_1:GetWordFromCfg(938041073)
				local var_297_19 = arg_294_1:FormatText(var_297_18.content)

				arg_294_1.text_.text = var_297_19

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_20 = 18
				local var_297_21 = utf8.len(var_297_19)
				local var_297_22 = var_297_20 <= 0 and var_297_16 or var_297_16 * (var_297_21 / var_297_20)

				if var_297_22 > 0 and var_297_16 < var_297_22 then
					arg_294_1.talkMaxDuration = var_297_22

					if var_297_22 + var_297_15 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_22 + var_297_15
					end
				end

				arg_294_1.text_.text = var_297_19
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_23 = math.max(var_297_16, arg_294_1.talkMaxDuration)

			if var_297_15 <= arg_294_1.time_ and arg_294_1.time_ < var_297_15 + var_297_23 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_15) / var_297_23

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_15 + var_297_23 and arg_294_1.time_ < var_297_15 + var_297_23 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play938041074 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 938041074
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play938041075(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = arg_298_1.actors_["10183"]
			local var_301_1 = 0

			if var_301_1 < arg_298_1.time_ and arg_298_1.time_ <= var_301_1 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps10183 == nil then
				arg_298_1.var_.actorSpriteComps10183 = var_301_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_2 = 0.2

			if var_301_1 <= arg_298_1.time_ and arg_298_1.time_ < var_301_1 + var_301_2 and not isNil(var_301_0) then
				local var_301_3 = (arg_298_1.time_ - var_301_1) / var_301_2

				if arg_298_1.var_.actorSpriteComps10183 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								local var_301_4 = Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor2.r, var_301_3)
								local var_301_5 = Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor2.g, var_301_3)
								local var_301_6 = Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor2.b, var_301_3)

								iter_301_1.color = Color.New(var_301_4, var_301_5, var_301_6)
							else
								local var_301_7 = Mathf.Lerp(iter_301_1.color.r, 0.5, var_301_3)

								iter_301_1.color = Color.New(var_301_7, var_301_7, var_301_7)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= var_301_1 + var_301_2 and arg_298_1.time_ < var_301_1 + var_301_2 + arg_301_0 and not isNil(var_301_0) and arg_298_1.var_.actorSpriteComps10183 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_301_3 then
						if arg_298_1.isInRecall_ then
							iter_301_3.color = arg_298_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_301_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_298_1.var_.actorSpriteComps10183 = nil
			end

			local var_301_8 = 0
			local var_301_9 = 0.35

			if var_301_8 < arg_298_1.time_ and arg_298_1.time_ <= var_301_8 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_10 = arg_298_1:FormatText(StoryNameCfg[7].name)

				arg_298_1.leftNameTxt_.text = var_301_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_11 = arg_298_1:GetWordFromCfg(938041074)
				local var_301_12 = arg_298_1:FormatText(var_301_11.content)

				arg_298_1.text_.text = var_301_12

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_13 = 14
				local var_301_14 = utf8.len(var_301_12)
				local var_301_15 = var_301_13 <= 0 and var_301_9 or var_301_9 * (var_301_14 / var_301_13)

				if var_301_15 > 0 and var_301_9 < var_301_15 then
					arg_298_1.talkMaxDuration = var_301_15

					if var_301_15 + var_301_8 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_15 + var_301_8
					end
				end

				arg_298_1.text_.text = var_301_12
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_16 = math.max(var_301_9, arg_298_1.talkMaxDuration)

			if var_301_8 <= arg_298_1.time_ and arg_298_1.time_ < var_301_8 + var_301_16 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_8) / var_301_16

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_8 + var_301_16 and arg_298_1.time_ < var_301_8 + var_301_16 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play938041075 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 938041075
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play938041076(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = arg_302_1.actors_["10183"]
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.actorSpriteComps10183 == nil then
				arg_302_1.var_.actorSpriteComps10183 = var_305_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_2 = 0.2

			if var_305_1 <= arg_302_1.time_ and arg_302_1.time_ < var_305_1 + var_305_2 and not isNil(var_305_0) then
				local var_305_3 = (arg_302_1.time_ - var_305_1) / var_305_2

				if arg_302_1.var_.actorSpriteComps10183 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								local var_305_4 = Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor1.r, var_305_3)
								local var_305_5 = Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor1.g, var_305_3)
								local var_305_6 = Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor1.b, var_305_3)

								iter_305_1.color = Color.New(var_305_4, var_305_5, var_305_6)
							else
								local var_305_7 = Mathf.Lerp(iter_305_1.color.r, 1, var_305_3)

								iter_305_1.color = Color.New(var_305_7, var_305_7, var_305_7)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= var_305_1 + var_305_2 and arg_302_1.time_ < var_305_1 + var_305_2 + arg_305_0 and not isNil(var_305_0) and arg_302_1.var_.actorSpriteComps10183 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_305_3 then
						if arg_302_1.isInRecall_ then
							iter_305_3.color = arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_305_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_302_1.var_.actorSpriteComps10183 = nil
			end

			local var_305_8 = arg_302_1.actors_["10183"].transform
			local var_305_9 = 0

			if var_305_9 < arg_302_1.time_ and arg_302_1.time_ <= var_305_9 + arg_305_0 then
				arg_302_1.var_.moveOldPos10183 = var_305_8.localPosition
				var_305_8.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("10183", 3)

				local var_305_10 = var_305_8.childCount

				for iter_305_4 = 0, var_305_10 - 1 do
					local var_305_11 = var_305_8:GetChild(iter_305_4)

					if var_305_11.name == "split_8" then
						var_305_11:SetAsLastSibling()
						var_305_11.gameObject:SetActive(true)

						arg_302_1.var_.actorSpriteSplit10183 = var_305_11.gameObject:GetComponent(typeof(Image))

						arg_302_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_305_12 = 0.5

			if var_305_9 <= arg_302_1.time_ and arg_302_1.time_ < var_305_9 + var_305_12 then
				local var_305_13 = (arg_302_1.time_ - var_305_9) / var_305_12
				local var_305_14 = Vector3.New(0, -475, -325)

				var_305_8.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos10183, var_305_14, var_305_13)

				if arg_302_1.var_.actorSpriteSplit10183 ~= nil then
					arg_302_1.var_.actorSpriteSplit10183:SetAlpha(var_305_13)
				end
			end

			if arg_302_1.time_ >= var_305_9 + var_305_12 and arg_302_1.time_ < var_305_9 + var_305_12 + arg_305_0 then
				var_305_8.localPosition = Vector3.New(0, -475, -325)

				if arg_302_1.var_.actorSpriteSplit10183 ~= nil then
					arg_302_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_305_15 = 0
			local var_305_16 = 1.575

			if var_305_15 < arg_302_1.time_ and arg_302_1.time_ <= var_305_15 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_17 = arg_302_1:FormatText(StoryNameCfg[1562].name)

				arg_302_1.leftNameTxt_.text = var_305_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_18 = arg_302_1:GetWordFromCfg(938041075)
				local var_305_19 = arg_302_1:FormatText(var_305_18.content)

				arg_302_1.text_.text = var_305_19

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_20 = 63
				local var_305_21 = utf8.len(var_305_19)
				local var_305_22 = var_305_20 <= 0 and var_305_16 or var_305_16 * (var_305_21 / var_305_20)

				if var_305_22 > 0 and var_305_16 < var_305_22 then
					arg_302_1.talkMaxDuration = var_305_22

					if var_305_22 + var_305_15 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_22 + var_305_15
					end
				end

				arg_302_1.text_.text = var_305_19
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_23 = math.max(var_305_16, arg_302_1.talkMaxDuration)

			if var_305_15 <= arg_302_1.time_ and arg_302_1.time_ < var_305_15 + var_305_23 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_15) / var_305_23

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_15 + var_305_23 and arg_302_1.time_ < var_305_15 + var_305_23 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play938041076 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 938041076
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play938041077(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["10183"].transform
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.var_.moveOldPos10183 = var_309_0.localPosition
				var_309_0.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("10183", 3)

				local var_309_2 = var_309_0.childCount

				for iter_309_0 = 0, var_309_2 - 1 do
					local var_309_3 = var_309_0:GetChild(iter_309_0)

					if var_309_3.name == "" or not string.find(var_309_3.name, "split") then
						var_309_3.gameObject:SetActive(true)
					else
						var_309_3.gameObject:SetActive(false)
					end
				end
			end

			local var_309_4 = 0.001

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_4 then
				local var_309_5 = (arg_306_1.time_ - var_309_1) / var_309_4
				local var_309_6 = Vector3.New(0, -475, -325)

				var_309_0.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos10183, var_309_6, var_309_5)
			end

			if arg_306_1.time_ >= var_309_1 + var_309_4 and arg_306_1.time_ < var_309_1 + var_309_4 + arg_309_0 then
				var_309_0.localPosition = Vector3.New(0, -475, -325)
			end

			local var_309_7 = 0
			local var_309_8 = 1.1

			if var_309_7 < arg_306_1.time_ and arg_306_1.time_ <= var_309_7 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_9 = arg_306_1:FormatText(StoryNameCfg[1562].name)

				arg_306_1.leftNameTxt_.text = var_309_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_10 = arg_306_1:GetWordFromCfg(938041076)
				local var_309_11 = arg_306_1:FormatText(var_309_10.content)

				arg_306_1.text_.text = var_309_11

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_12 = 44
				local var_309_13 = utf8.len(var_309_11)
				local var_309_14 = var_309_12 <= 0 and var_309_8 or var_309_8 * (var_309_13 / var_309_12)

				if var_309_14 > 0 and var_309_8 < var_309_14 then
					arg_306_1.talkMaxDuration = var_309_14

					if var_309_14 + var_309_7 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_14 + var_309_7
					end
				end

				arg_306_1.text_.text = var_309_11
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_15 = math.max(var_309_8, arg_306_1.talkMaxDuration)

			if var_309_7 <= arg_306_1.time_ and arg_306_1.time_ < var_309_7 + var_309_15 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_7) / var_309_15

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_7 + var_309_15 and arg_306_1.time_ < var_309_7 + var_309_15 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play938041077 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 938041077
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play938041078(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["10183"]
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps10183 == nil then
				arg_310_1.var_.actorSpriteComps10183 = var_313_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_2 = 0.2

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 and not isNil(var_313_0) then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2

				if arg_310_1.var_.actorSpriteComps10183 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								local var_313_4 = Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor2.r, var_313_3)
								local var_313_5 = Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor2.g, var_313_3)
								local var_313_6 = Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor2.b, var_313_3)

								iter_313_1.color = Color.New(var_313_4, var_313_5, var_313_6)
							else
								local var_313_7 = Mathf.Lerp(iter_313_1.color.r, 0.5, var_313_3)

								iter_313_1.color = Color.New(var_313_7, var_313_7, var_313_7)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 and not isNil(var_313_0) and arg_310_1.var_.actorSpriteComps10183 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_313_3 then
						if arg_310_1.isInRecall_ then
							iter_313_3.color = arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_313_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_310_1.var_.actorSpriteComps10183 = nil
			end

			local var_313_8 = 0
			local var_313_9 = 0.475

			if var_313_8 < arg_310_1.time_ and arg_310_1.time_ <= var_313_8 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_10 = arg_310_1:FormatText(StoryNameCfg[7].name)

				arg_310_1.leftNameTxt_.text = var_313_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_11 = arg_310_1:GetWordFromCfg(938041077)
				local var_313_12 = arg_310_1:FormatText(var_313_11.content)

				arg_310_1.text_.text = var_313_12

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_13 = 19
				local var_313_14 = utf8.len(var_313_12)
				local var_313_15 = var_313_13 <= 0 and var_313_9 or var_313_9 * (var_313_14 / var_313_13)

				if var_313_15 > 0 and var_313_9 < var_313_15 then
					arg_310_1.talkMaxDuration = var_313_15

					if var_313_15 + var_313_8 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_15 + var_313_8
					end
				end

				arg_310_1.text_.text = var_313_12
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_16 = math.max(var_313_9, arg_310_1.talkMaxDuration)

			if var_313_8 <= arg_310_1.time_ and arg_310_1.time_ < var_313_8 + var_313_16 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_8) / var_313_16

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_8 + var_313_16 and arg_310_1.time_ < var_313_8 + var_313_16 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play938041078 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 938041078
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play938041079(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["10183"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps10183 == nil then
				arg_314_1.var_.actorSpriteComps10183 = var_317_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_2 = 0.2

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.actorSpriteComps10183 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								local var_317_4 = Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor1.r, var_317_3)
								local var_317_5 = Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor1.g, var_317_3)
								local var_317_6 = Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor1.b, var_317_3)

								iter_317_1.color = Color.New(var_317_4, var_317_5, var_317_6)
							else
								local var_317_7 = Mathf.Lerp(iter_317_1.color.r, 1, var_317_3)

								iter_317_1.color = Color.New(var_317_7, var_317_7, var_317_7)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.actorSpriteComps10183 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_317_3 then
						if arg_314_1.isInRecall_ then
							iter_317_3.color = arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_317_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_314_1.var_.actorSpriteComps10183 = nil
			end

			local var_317_8 = arg_314_1.actors_["10183"].transform
			local var_317_9 = 0

			if var_317_9 < arg_314_1.time_ and arg_314_1.time_ <= var_317_9 + arg_317_0 then
				arg_314_1.var_.moveOldPos10183 = var_317_8.localPosition
				var_317_8.localScale = Vector3.New(1, 1, 1)

				arg_314_1:CheckSpriteTmpPos("10183", 3)

				local var_317_10 = var_317_8.childCount

				for iter_317_4 = 0, var_317_10 - 1 do
					local var_317_11 = var_317_8:GetChild(iter_317_4)

					if var_317_11.name == "split_2" then
						var_317_11:SetAsLastSibling()
						var_317_11.gameObject:SetActive(true)

						arg_314_1.var_.actorSpriteSplit10183 = var_317_11.gameObject:GetComponent(typeof(Image))

						arg_314_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_317_12 = 0.5

			if var_317_9 <= arg_314_1.time_ and arg_314_1.time_ < var_317_9 + var_317_12 then
				local var_317_13 = (arg_314_1.time_ - var_317_9) / var_317_12
				local var_317_14 = Vector3.New(0, -475, -325)

				var_317_8.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10183, var_317_14, var_317_13)

				if arg_314_1.var_.actorSpriteSplit10183 ~= nil then
					arg_314_1.var_.actorSpriteSplit10183:SetAlpha(var_317_13)
				end
			end

			if arg_314_1.time_ >= var_317_9 + var_317_12 and arg_314_1.time_ < var_317_9 + var_317_12 + arg_317_0 then
				var_317_8.localPosition = Vector3.New(0, -475, -325)

				if arg_314_1.var_.actorSpriteSplit10183 ~= nil then
					arg_314_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_317_15 = 0
			local var_317_16 = 0.225

			if var_317_15 < arg_314_1.time_ and arg_314_1.time_ <= var_317_15 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_17 = arg_314_1:FormatText(StoryNameCfg[1562].name)

				arg_314_1.leftNameTxt_.text = var_317_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_18 = arg_314_1:GetWordFromCfg(938041078)
				local var_317_19 = arg_314_1:FormatText(var_317_18.content)

				arg_314_1.text_.text = var_317_19

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_20 = 9
				local var_317_21 = utf8.len(var_317_19)
				local var_317_22 = var_317_20 <= 0 and var_317_16 or var_317_16 * (var_317_21 / var_317_20)

				if var_317_22 > 0 and var_317_16 < var_317_22 then
					arg_314_1.talkMaxDuration = var_317_22

					if var_317_22 + var_317_15 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_22 + var_317_15
					end
				end

				arg_314_1.text_.text = var_317_19
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_23 = math.max(var_317_16, arg_314_1.talkMaxDuration)

			if var_317_15 <= arg_314_1.time_ and arg_314_1.time_ < var_317_15 + var_317_23 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_15) / var_317_23

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_15 + var_317_23 and arg_314_1.time_ < var_317_15 + var_317_23 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play938041079 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 938041079
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play938041080(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 1.075

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[1297].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10144_split_1")

				arg_318_1.callingController_:SetSelectedState("calling")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_3 = arg_318_1:GetWordFromCfg(938041079)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 43
				local var_321_6 = utf8.len(var_321_4)
				local var_321_7 = var_321_5 <= 0 and var_321_1 or var_321_1 * (var_321_6 / var_321_5)

				if var_321_7 > 0 and var_321_1 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_8 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_8 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_8

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_8 and arg_318_1.time_ < var_321_0 + var_321_8 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play938041080 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 938041080
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play938041081(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = "10144"

			if arg_322_1.actors_[var_325_0] == nil then
				local var_325_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_325_1) then
					local var_325_2 = Object.Instantiate(var_325_1, arg_322_1.canvasGo_.transform)

					var_325_2.transform:SetSiblingIndex(1)

					var_325_2.name = var_325_0
					var_325_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_322_1.actors_[var_325_0] = var_325_2

					local var_325_3 = var_325_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_322_1.isInRecall_ then
						for iter_325_0, iter_325_1 in ipairs(var_325_3) do
							iter_325_1.color = arg_322_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_325_4 = arg_322_1.actors_["10144"]
			local var_325_5 = 0

			if var_325_5 < arg_322_1.time_ and arg_322_1.time_ <= var_325_5 + arg_325_0 and not isNil(var_325_4) and arg_322_1.var_.actorSpriteComps10144 == nil then
				arg_322_1.var_.actorSpriteComps10144 = var_325_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_6 = 0.2

			if var_325_5 <= arg_322_1.time_ and arg_322_1.time_ < var_325_5 + var_325_6 and not isNil(var_325_4) then
				local var_325_7 = (arg_322_1.time_ - var_325_5) / var_325_6

				if arg_322_1.var_.actorSpriteComps10144 then
					for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_325_3 then
							if arg_322_1.isInRecall_ then
								local var_325_8 = Mathf.Lerp(iter_325_3.color.r, arg_322_1.hightColor2.r, var_325_7)
								local var_325_9 = Mathf.Lerp(iter_325_3.color.g, arg_322_1.hightColor2.g, var_325_7)
								local var_325_10 = Mathf.Lerp(iter_325_3.color.b, arg_322_1.hightColor2.b, var_325_7)

								iter_325_3.color = Color.New(var_325_8, var_325_9, var_325_10)
							else
								local var_325_11 = Mathf.Lerp(iter_325_3.color.r, 0.5, var_325_7)

								iter_325_3.color = Color.New(var_325_11, var_325_11, var_325_11)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= var_325_5 + var_325_6 and arg_322_1.time_ < var_325_5 + var_325_6 + arg_325_0 and not isNil(var_325_4) and arg_322_1.var_.actorSpriteComps10144 then
				for iter_325_4, iter_325_5 in pairs(arg_322_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_325_5 then
						if arg_322_1.isInRecall_ then
							iter_325_5.color = arg_322_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_325_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_322_1.var_.actorSpriteComps10144 = nil
			end

			local var_325_12 = arg_322_1.actors_["10183"].transform
			local var_325_13 = 0

			if var_325_13 < arg_322_1.time_ and arg_322_1.time_ <= var_325_13 + arg_325_0 then
				arg_322_1.var_.moveOldPos10183 = var_325_12.localPosition
				var_325_12.localScale = Vector3.New(1, 1, 1)

				arg_322_1:CheckSpriteTmpPos("10183", 7)

				local var_325_14 = var_325_12.childCount

				for iter_325_6 = 0, var_325_14 - 1 do
					local var_325_15 = var_325_12:GetChild(iter_325_6)

					if var_325_15.name == "" or not string.find(var_325_15.name, "split") then
						var_325_15.gameObject:SetActive(true)
					else
						var_325_15.gameObject:SetActive(false)
					end
				end
			end

			local var_325_16 = 0.001

			if var_325_13 <= arg_322_1.time_ and arg_322_1.time_ < var_325_13 + var_325_16 then
				local var_325_17 = (arg_322_1.time_ - var_325_13) / var_325_16
				local var_325_18 = Vector3.New(0, -2000, 0)

				var_325_12.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10183, var_325_18, var_325_17)
			end

			if arg_322_1.time_ >= var_325_13 + var_325_16 and arg_322_1.time_ < var_325_13 + var_325_16 + arg_325_0 then
				var_325_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_325_19 = arg_322_1.actors_["10144"].transform
			local var_325_20 = 0

			if var_325_20 < arg_322_1.time_ and arg_322_1.time_ <= var_325_20 + arg_325_0 then
				arg_322_1.var_.moveOldPos10144 = var_325_19.localPosition
				var_325_19.localScale = Vector3.New(1, 1, 1)

				arg_322_1:CheckSpriteTmpPos("10144", 7)

				local var_325_21 = var_325_19.childCount

				for iter_325_7 = 0, var_325_21 - 1 do
					local var_325_22 = var_325_19:GetChild(iter_325_7)

					if var_325_22.name == "" or not string.find(var_325_22.name, "split") then
						var_325_22.gameObject:SetActive(true)
					else
						var_325_22.gameObject:SetActive(false)
					end
				end
			end

			local var_325_23 = 0.001

			if var_325_20 <= arg_322_1.time_ and arg_322_1.time_ < var_325_20 + var_325_23 then
				local var_325_24 = (arg_322_1.time_ - var_325_20) / var_325_23
				local var_325_25 = Vector3.New(0, -2000, 0)

				var_325_19.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10144, var_325_25, var_325_24)
			end

			if arg_322_1.time_ >= var_325_20 + var_325_23 and arg_322_1.time_ < var_325_20 + var_325_23 + arg_325_0 then
				var_325_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_325_26 = 0
			local var_325_27 = 0.85

			if var_325_26 < arg_322_1.time_ and arg_322_1.time_ <= var_325_26 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_28 = arg_322_1:GetWordFromCfg(938041080)
				local var_325_29 = arg_322_1:FormatText(var_325_28.content)

				arg_322_1.text_.text = var_325_29

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_30 = 34
				local var_325_31 = utf8.len(var_325_29)
				local var_325_32 = var_325_30 <= 0 and var_325_27 or var_325_27 * (var_325_31 / var_325_30)

				if var_325_32 > 0 and var_325_27 < var_325_32 then
					arg_322_1.talkMaxDuration = var_325_32

					if var_325_32 + var_325_26 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_32 + var_325_26
					end
				end

				arg_322_1.text_.text = var_325_29
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_33 = math.max(var_325_27, arg_322_1.talkMaxDuration)

			if var_325_26 <= arg_322_1.time_ and arg_322_1.time_ < var_325_26 + var_325_33 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_26) / var_325_33

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_26 + var_325_33 and arg_322_1.time_ < var_325_26 + var_325_33 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
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

		arg_322_1:InitPlayNodeList()
	end,
	Play938041081 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 938041081
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play938041082(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0
			local var_329_1 = 0.375

			if var_329_0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_2 = arg_326_1:FormatText(StoryNameCfg[7].name)

				arg_326_1.leftNameTxt_.text = var_329_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_3 = arg_326_1:GetWordFromCfg(938041081)
				local var_329_4 = arg_326_1:FormatText(var_329_3.content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_5 = 15
				local var_329_6 = utf8.len(var_329_4)
				local var_329_7 = var_329_5 <= 0 and var_329_1 or var_329_1 * (var_329_6 / var_329_5)

				if var_329_7 > 0 and var_329_1 < var_329_7 then
					arg_326_1.talkMaxDuration = var_329_7

					if var_329_7 + var_329_0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_7 + var_329_0
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_8 = math.max(var_329_1, arg_326_1.talkMaxDuration)

			if var_329_0 <= arg_326_1.time_ and arg_326_1.time_ < var_329_0 + var_329_8 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_0) / var_329_8

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_0 + var_329_8 and arg_326_1.time_ < var_329_0 + var_329_8 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play938041082 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 938041082
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play938041083(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["10183"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps10183 == nil then
				arg_330_1.var_.actorSpriteComps10183 = var_333_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_2 = 0.2

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.actorSpriteComps10183 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								local var_333_4 = Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor1.r, var_333_3)
								local var_333_5 = Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor1.g, var_333_3)
								local var_333_6 = Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor1.b, var_333_3)

								iter_333_1.color = Color.New(var_333_4, var_333_5, var_333_6)
							else
								local var_333_7 = Mathf.Lerp(iter_333_1.color.r, 1, var_333_3)

								iter_333_1.color = Color.New(var_333_7, var_333_7, var_333_7)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.actorSpriteComps10183 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_333_3 then
						if arg_330_1.isInRecall_ then
							iter_333_3.color = arg_330_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_333_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_330_1.var_.actorSpriteComps10183 = nil
			end

			local var_333_8 = arg_330_1.actors_["10183"].transform
			local var_333_9 = 0

			if var_333_9 < arg_330_1.time_ and arg_330_1.time_ <= var_333_9 + arg_333_0 then
				arg_330_1.var_.moveOldPos10183 = var_333_8.localPosition
				var_333_8.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("10183", 3)

				local var_333_10 = var_333_8.childCount

				for iter_333_4 = 0, var_333_10 - 1 do
					local var_333_11 = var_333_8:GetChild(iter_333_4)

					if var_333_11.name == "split_7" or not string.find(var_333_11.name, "split") then
						var_333_11.gameObject:SetActive(true)
					else
						var_333_11.gameObject:SetActive(false)
					end
				end
			end

			local var_333_12 = 0.001

			if var_333_9 <= arg_330_1.time_ and arg_330_1.time_ < var_333_9 + var_333_12 then
				local var_333_13 = (arg_330_1.time_ - var_333_9) / var_333_12
				local var_333_14 = Vector3.New(0, -475, -325)

				var_333_8.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10183, var_333_14, var_333_13)
			end

			if arg_330_1.time_ >= var_333_9 + var_333_12 and arg_330_1.time_ < var_333_9 + var_333_12 + arg_333_0 then
				var_333_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_333_15 = 0
			local var_333_16 = 0.65

			if var_333_15 < arg_330_1.time_ and arg_330_1.time_ <= var_333_15 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				local var_333_17 = arg_330_1:FormatText(StoryNameCfg[1562].name)

				arg_330_1.leftNameTxt_.text = var_333_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_18 = arg_330_1:GetWordFromCfg(938041082)
				local var_333_19 = arg_330_1:FormatText(var_333_18.content)

				arg_330_1.text_.text = var_333_19

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_20 = 26
				local var_333_21 = utf8.len(var_333_19)
				local var_333_22 = var_333_20 <= 0 and var_333_16 or var_333_16 * (var_333_21 / var_333_20)

				if var_333_22 > 0 and var_333_16 < var_333_22 then
					arg_330_1.talkMaxDuration = var_333_22

					if var_333_22 + var_333_15 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_22 + var_333_15
					end
				end

				arg_330_1.text_.text = var_333_19
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_23 = math.max(var_333_16, arg_330_1.talkMaxDuration)

			if var_333_15 <= arg_330_1.time_ and arg_330_1.time_ < var_333_15 + var_333_23 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_15) / var_333_23

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_15 + var_333_23 and arg_330_1.time_ < var_333_15 + var_333_23 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play938041083 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 938041083
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play938041084(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["10183"].transform
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.var_.moveOldPos10183 = var_337_0.localPosition
				var_337_0.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("10183", 3)

				local var_337_2 = var_337_0.childCount

				for iter_337_0 = 0, var_337_2 - 1 do
					local var_337_3 = var_337_0:GetChild(iter_337_0)

					if var_337_3.name == "split_1" then
						var_337_3:SetAsLastSibling()
						var_337_3.gameObject:SetActive(true)

						arg_334_1.var_.actorSpriteSplit10183 = var_337_3.gameObject:GetComponent(typeof(Image))

						arg_334_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_337_4 = 0.5

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_4 then
				local var_337_5 = (arg_334_1.time_ - var_337_1) / var_337_4
				local var_337_6 = Vector3.New(0, -475, -325)

				var_337_0.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10183, var_337_6, var_337_5)

				if arg_334_1.var_.actorSpriteSplit10183 ~= nil then
					arg_334_1.var_.actorSpriteSplit10183:SetAlpha(var_337_5)
				end
			end

			if arg_334_1.time_ >= var_337_1 + var_337_4 and arg_334_1.time_ < var_337_1 + var_337_4 + arg_337_0 then
				var_337_0.localPosition = Vector3.New(0, -475, -325)

				if arg_334_1.var_.actorSpriteSplit10183 ~= nil then
					arg_334_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_337_7 = 0
			local var_337_8 = 1.375

			if var_337_7 < arg_334_1.time_ and arg_334_1.time_ <= var_337_7 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_9 = arg_334_1:FormatText(StoryNameCfg[1562].name)

				arg_334_1.leftNameTxt_.text = var_337_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_10 = arg_334_1:GetWordFromCfg(938041083)
				local var_337_11 = arg_334_1:FormatText(var_337_10.content)

				arg_334_1.text_.text = var_337_11

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_12 = 55
				local var_337_13 = utf8.len(var_337_11)
				local var_337_14 = var_337_12 <= 0 and var_337_8 or var_337_8 * (var_337_13 / var_337_12)

				if var_337_14 > 0 and var_337_8 < var_337_14 then
					arg_334_1.talkMaxDuration = var_337_14

					if var_337_14 + var_337_7 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_14 + var_337_7
					end
				end

				arg_334_1.text_.text = var_337_11
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_15 = math.max(var_337_8, arg_334_1.talkMaxDuration)

			if var_337_7 <= arg_334_1.time_ and arg_334_1.time_ < var_337_7 + var_337_15 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_7) / var_337_15

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_7 + var_337_15 and arg_334_1.time_ < var_337_7 + var_337_15 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play938041084 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 938041084
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play938041085(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["10183"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps10183 == nil then
				arg_338_1.var_.actorSpriteComps10183 = var_341_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_2 = 0.2

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.actorSpriteComps10183 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								local var_341_4 = Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor2.r, var_341_3)
								local var_341_5 = Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor2.g, var_341_3)
								local var_341_6 = Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor2.b, var_341_3)

								iter_341_1.color = Color.New(var_341_4, var_341_5, var_341_6)
							else
								local var_341_7 = Mathf.Lerp(iter_341_1.color.r, 0.5, var_341_3)

								iter_341_1.color = Color.New(var_341_7, var_341_7, var_341_7)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.actorSpriteComps10183 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_341_3 then
						if arg_338_1.isInRecall_ then
							iter_341_3.color = arg_338_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_341_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_338_1.var_.actorSpriteComps10183 = nil
			end

			local var_341_8 = arg_338_1.actors_["10183"].transform
			local var_341_9 = 0

			if var_341_9 < arg_338_1.time_ and arg_338_1.time_ <= var_341_9 + arg_341_0 then
				arg_338_1.var_.moveOldPos10183 = var_341_8.localPosition
				var_341_8.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("10183", 7)

				local var_341_10 = var_341_8.childCount

				for iter_341_4 = 0, var_341_10 - 1 do
					local var_341_11 = var_341_8:GetChild(iter_341_4)

					if var_341_11.name == "split_1" or not string.find(var_341_11.name, "split") then
						var_341_11.gameObject:SetActive(true)
					else
						var_341_11.gameObject:SetActive(false)
					end
				end
			end

			local var_341_12 = 0.001

			if var_341_9 <= arg_338_1.time_ and arg_338_1.time_ < var_341_9 + var_341_12 then
				local var_341_13 = (arg_338_1.time_ - var_341_9) / var_341_12
				local var_341_14 = Vector3.New(0, -2000, 0)

				var_341_8.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10183, var_341_14, var_341_13)
			end

			if arg_338_1.time_ >= var_341_9 + var_341_12 and arg_338_1.time_ < var_341_9 + var_341_12 + arg_341_0 then
				var_341_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_341_15 = 0
			local var_341_16 = 1.2

			if var_341_15 < arg_338_1.time_ and arg_338_1.time_ <= var_341_15 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_17 = arg_338_1:GetWordFromCfg(938041084)
				local var_341_18 = arg_338_1:FormatText(var_341_17.content)

				arg_338_1.text_.text = var_341_18

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_19 = 48
				local var_341_20 = utf8.len(var_341_18)
				local var_341_21 = var_341_19 <= 0 and var_341_16 or var_341_16 * (var_341_20 / var_341_19)

				if var_341_21 > 0 and var_341_16 < var_341_21 then
					arg_338_1.talkMaxDuration = var_341_21

					if var_341_21 + var_341_15 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_21 + var_341_15
					end
				end

				arg_338_1.text_.text = var_341_18
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_22 = math.max(var_341_16, arg_338_1.talkMaxDuration)

			if var_341_15 <= arg_338_1.time_ and arg_338_1.time_ < var_341_15 + var_341_22 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_15) / var_341_22

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_15 + var_341_22 and arg_338_1.time_ < var_341_15 + var_341_22 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play938041085 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 938041085
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play938041086(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0
			local var_345_1 = 1.05

			if var_345_0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_2 = arg_342_1:GetWordFromCfg(938041085)
				local var_345_3 = arg_342_1:FormatText(var_345_2.content)

				arg_342_1.text_.text = var_345_3

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_4 = 42
				local var_345_5 = utf8.len(var_345_3)
				local var_345_6 = var_345_4 <= 0 and var_345_1 or var_345_1 * (var_345_5 / var_345_4)

				if var_345_6 > 0 and var_345_1 < var_345_6 then
					arg_342_1.talkMaxDuration = var_345_6

					if var_345_6 + var_345_0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_6 + var_345_0
					end
				end

				arg_342_1.text_.text = var_345_3
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_7 = math.max(var_345_1, arg_342_1.talkMaxDuration)

			if var_345_0 <= arg_342_1.time_ and arg_342_1.time_ < var_345_0 + var_345_7 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_0) / var_345_7

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_0 + var_345_7 and arg_342_1.time_ < var_345_0 + var_345_7 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play938041086 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 938041086
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play938041087(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["10183"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.actorSpriteComps10183 == nil then
				arg_346_1.var_.actorSpriteComps10183 = var_349_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_2 = 0.2

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.actorSpriteComps10183 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								local var_349_4 = Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor1.r, var_349_3)
								local var_349_5 = Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor1.g, var_349_3)
								local var_349_6 = Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor1.b, var_349_3)

								iter_349_1.color = Color.New(var_349_4, var_349_5, var_349_6)
							else
								local var_349_7 = Mathf.Lerp(iter_349_1.color.r, 1, var_349_3)

								iter_349_1.color = Color.New(var_349_7, var_349_7, var_349_7)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.actorSpriteComps10183 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_349_3 then
						if arg_346_1.isInRecall_ then
							iter_349_3.color = arg_346_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_349_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_346_1.var_.actorSpriteComps10183 = nil
			end

			local var_349_8 = arg_346_1.actors_["10183"].transform
			local var_349_9 = 0

			if var_349_9 < arg_346_1.time_ and arg_346_1.time_ <= var_349_9 + arg_349_0 then
				arg_346_1.var_.moveOldPos10183 = var_349_8.localPosition
				var_349_8.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("10183", 3)

				local var_349_10 = var_349_8.childCount

				for iter_349_4 = 0, var_349_10 - 1 do
					local var_349_11 = var_349_8:GetChild(iter_349_4)

					if var_349_11.name == "split_2" or not string.find(var_349_11.name, "split") then
						var_349_11.gameObject:SetActive(true)
					else
						var_349_11.gameObject:SetActive(false)
					end
				end
			end

			local var_349_12 = 0.001

			if var_349_9 <= arg_346_1.time_ and arg_346_1.time_ < var_349_9 + var_349_12 then
				local var_349_13 = (arg_346_1.time_ - var_349_9) / var_349_12
				local var_349_14 = Vector3.New(0, -475, -325)

				var_349_8.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10183, var_349_14, var_349_13)
			end

			if arg_346_1.time_ >= var_349_9 + var_349_12 and arg_346_1.time_ < var_349_9 + var_349_12 + arg_349_0 then
				var_349_8.localPosition = Vector3.New(0, -475, -325)
			end

			local var_349_15 = 0
			local var_349_16 = 0.35

			if var_349_15 < arg_346_1.time_ and arg_346_1.time_ <= var_349_15 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_17 = arg_346_1:FormatText(StoryNameCfg[1562].name)

				arg_346_1.leftNameTxt_.text = var_349_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_18 = arg_346_1:GetWordFromCfg(938041086)
				local var_349_19 = arg_346_1:FormatText(var_349_18.content)

				arg_346_1.text_.text = var_349_19

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_20 = 14
				local var_349_21 = utf8.len(var_349_19)
				local var_349_22 = var_349_20 <= 0 and var_349_16 or var_349_16 * (var_349_21 / var_349_20)

				if var_349_22 > 0 and var_349_16 < var_349_22 then
					arg_346_1.talkMaxDuration = var_349_22

					if var_349_22 + var_349_15 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_22 + var_349_15
					end
				end

				arg_346_1.text_.text = var_349_19
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_23 = math.max(var_349_16, arg_346_1.talkMaxDuration)

			if var_349_15 <= arg_346_1.time_ and arg_346_1.time_ < var_349_15 + var_349_23 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_15) / var_349_23

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_15 + var_349_23 and arg_346_1.time_ < var_349_15 + var_349_23 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play938041087 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 938041087
		arg_350_1.duration_ = 1

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"

			SetActive(arg_350_1.choicesGo_, true)

			for iter_351_0, iter_351_1 in ipairs(arg_350_1.choices_) do
				local var_351_0 = iter_351_0 <= 1

				SetActive(iter_351_1.go, var_351_0)
			end

			arg_350_1.choices_[1].txt.text = arg_350_1:FormatText(StoryChoiceCfg[1784].name)
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play938041088(arg_350_1)
			end

			arg_350_1:RecordChoiceLog(938041087, 1784)
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["10183"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps10183 == nil then
				arg_350_1.var_.actorSpriteComps10183 = var_353_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_2 = 0.2

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.actorSpriteComps10183 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								local var_353_4 = Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor2.r, var_353_3)
								local var_353_5 = Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor2.g, var_353_3)
								local var_353_6 = Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor2.b, var_353_3)

								iter_353_1.color = Color.New(var_353_4, var_353_5, var_353_6)
							else
								local var_353_7 = Mathf.Lerp(iter_353_1.color.r, 0.5, var_353_3)

								iter_353_1.color = Color.New(var_353_7, var_353_7, var_353_7)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.actorSpriteComps10183 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_353_3 then
						if arg_350_1.isInRecall_ then
							iter_353_3.color = arg_350_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_353_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_350_1.var_.actorSpriteComps10183 = nil
			end

			local var_353_8 = 0

			if var_353_8 < arg_350_1.time_ and arg_350_1.time_ <= var_353_8 + arg_353_0 then
				arg_350_1.allBtn_.enabled = false
			end

			local var_353_9 = 0.5

			if arg_350_1.time_ >= var_353_8 + var_353_9 and arg_350_1.time_ < var_353_8 + var_353_9 + arg_353_0 then
				arg_350_1.allBtn_.enabled = true
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play938041088 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 938041088
		arg_354_1.duration_ = 9

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play938041089(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = "ST0119"

			if arg_354_1.bgs_[var_357_0] == nil then
				local var_357_1 = Object.Instantiate(arg_354_1.paintGo_)

				var_357_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_357_0)
				var_357_1.name = var_357_0
				var_357_1.transform.parent = arg_354_1.stage_.transform
				var_357_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_354_1.bgs_[var_357_0] = var_357_1
			end

			local var_357_2 = 2

			if var_357_2 < arg_354_1.time_ and arg_354_1.time_ <= var_357_2 + arg_357_0 then
				local var_357_3 = manager.ui.mainCamera.transform.localPosition
				local var_357_4 = Vector3.New(0, 0, 10) + Vector3.New(var_357_3.x, var_357_3.y, 0)
				local var_357_5 = arg_354_1.bgs_.ST0119

				var_357_5.transform.localPosition = var_357_4
				var_357_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_357_6 = var_357_5:GetComponent("SpriteRenderer")

				if var_357_6 and var_357_6.sprite then
					local var_357_7 = (var_357_5.transform.localPosition - var_357_3).z
					local var_357_8 = manager.ui.mainCameraCom_
					local var_357_9 = 2 * var_357_7 * Mathf.Tan(var_357_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_357_10 = var_357_9 * var_357_8.aspect
					local var_357_11 = var_357_6.sprite.bounds.size.x
					local var_357_12 = var_357_6.sprite.bounds.size.y
					local var_357_13 = var_357_10 / var_357_11
					local var_357_14 = var_357_9 / var_357_12
					local var_357_15 = var_357_14 < var_357_13 and var_357_13 or var_357_14

					var_357_5.transform.localScale = Vector3.New(var_357_15, var_357_15, 0)
				end

				for iter_357_0, iter_357_1 in pairs(arg_354_1.bgs_) do
					if iter_357_0 ~= "ST0119" then
						iter_357_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_357_16 = 4

			if var_357_16 < arg_354_1.time_ and arg_354_1.time_ <= var_357_16 + arg_357_0 then
				arg_354_1.allBtn_.enabled = false
			end

			local var_357_17 = 0.3

			if arg_354_1.time_ >= var_357_16 + var_357_17 and arg_354_1.time_ < var_357_16 + var_357_17 + arg_357_0 then
				arg_354_1.allBtn_.enabled = true
			end

			local var_357_18 = 0

			if var_357_18 < arg_354_1.time_ and arg_354_1.time_ <= var_357_18 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_19 = 2

			if var_357_18 <= arg_354_1.time_ and arg_354_1.time_ < var_357_18 + var_357_19 then
				local var_357_20 = (arg_354_1.time_ - var_357_18) / var_357_19
				local var_357_21 = Color.New(0, 0, 0)

				var_357_21.a = Mathf.Lerp(0, 1, var_357_20)
				arg_354_1.mask_.color = var_357_21
			end

			if arg_354_1.time_ >= var_357_18 + var_357_19 and arg_354_1.time_ < var_357_18 + var_357_19 + arg_357_0 then
				local var_357_22 = Color.New(0, 0, 0)

				var_357_22.a = 1
				arg_354_1.mask_.color = var_357_22
			end

			local var_357_23 = 2

			if var_357_23 < arg_354_1.time_ and arg_354_1.time_ <= var_357_23 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_24 = 2

			if var_357_23 <= arg_354_1.time_ and arg_354_1.time_ < var_357_23 + var_357_24 then
				local var_357_25 = (arg_354_1.time_ - var_357_23) / var_357_24
				local var_357_26 = Color.New(0, 0, 0)

				var_357_26.a = Mathf.Lerp(1, 0, var_357_25)
				arg_354_1.mask_.color = var_357_26
			end

			if arg_354_1.time_ >= var_357_23 + var_357_24 and arg_354_1.time_ < var_357_23 + var_357_24 + arg_357_0 then
				local var_357_27 = Color.New(0, 0, 0)
				local var_357_28 = 0

				arg_354_1.mask_.enabled = false
				var_357_27.a = var_357_28
				arg_354_1.mask_.color = var_357_27
			end

			local var_357_29 = arg_354_1.actors_["10183"].transform
			local var_357_30 = 1.966

			if var_357_30 < arg_354_1.time_ and arg_354_1.time_ <= var_357_30 + arg_357_0 then
				arg_354_1.var_.moveOldPos10183 = var_357_29.localPosition
				var_357_29.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("10183", 7)

				local var_357_31 = var_357_29.childCount

				for iter_357_2 = 0, var_357_31 - 1 do
					local var_357_32 = var_357_29:GetChild(iter_357_2)

					if var_357_32.name == "" or not string.find(var_357_32.name, "split") then
						var_357_32.gameObject:SetActive(true)
					else
						var_357_32.gameObject:SetActive(false)
					end
				end
			end

			local var_357_33 = 0.001

			if var_357_30 <= arg_354_1.time_ and arg_354_1.time_ < var_357_30 + var_357_33 then
				local var_357_34 = (arg_354_1.time_ - var_357_30) / var_357_33
				local var_357_35 = Vector3.New(0, -2000, 0)

				var_357_29.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10183, var_357_35, var_357_34)
			end

			if arg_354_1.time_ >= var_357_30 + var_357_33 and arg_354_1.time_ < var_357_30 + var_357_33 + arg_357_0 then
				var_357_29.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_357_36 = 1
			local var_357_37 = 1

			if var_357_36 < arg_354_1.time_ and arg_354_1.time_ <= var_357_36 + arg_357_0 then
				local var_357_38 = "play"
				local var_357_39 = "effect"

				arg_354_1:AudioAction(var_357_38, var_357_39, "se_story_140", "se_story_140_amb_boxing", "")
			end

			local var_357_40 = 0.3
			local var_357_41 = 1

			if var_357_40 < arg_354_1.time_ and arg_354_1.time_ <= var_357_40 + arg_357_0 then
				local var_357_42 = "stop"
				local var_357_43 = "effect"

				arg_354_1:AudioAction(var_357_42, var_357_43, "se_story_143", "se_story_143_amb_bar", "")
			end

			local var_357_44 = 1
			local var_357_45 = 1

			if var_357_44 < arg_354_1.time_ and arg_354_1.time_ <= var_357_44 + arg_357_0 then
				local var_357_46 = "play"
				local var_357_47 = "music"

				arg_354_1:AudioAction(var_357_46, var_357_47, "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack.awb")

				local var_357_48 = ""
				local var_357_49 = manager.audio:GetAudioName("bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack")

				if var_357_49 ~= "" then
					if arg_354_1.bgmTxt_.text ~= var_357_49 and arg_354_1.bgmTxt_.text ~= "" then
						if arg_354_1.bgmTxt2_.text ~= "" then
							arg_354_1.bgmTxt_.text = arg_354_1.bgmTxt2_.text
						end

						arg_354_1.bgmTxt2_.text = var_357_49

						arg_354_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_354_1.bgmTxt_.text = var_357_49
						arg_354_1.bgmTxt2_.text = var_357_49
					end

					if arg_354_1.bgmTimer then
						arg_354_1.bgmTimer:Stop()

						arg_354_1.bgmTimer = nil
					end

					if arg_354_1.settingData.show_music_name == 1 then
						arg_354_1.musicController:SetSelectedState("show")
						arg_354_1.musicAnimator_:Play("open", 0, 0)

						if arg_354_1.settingData.music_time ~= 0 then
							arg_354_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_354_1.settingData.music_time), function()
								if arg_354_1 == nil or isNil(arg_354_1.bgmTxt_) then
									return
								end

								arg_354_1.musicController:SetSelectedState("hide")
								arg_354_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_354_1.frameCnt_ <= 1 then
				arg_354_1.dialog_:SetActive(false)
			end

			local var_357_50 = 4
			local var_357_51 = 0.375

			if var_357_50 < arg_354_1.time_ and arg_354_1.time_ <= var_357_50 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0

				arg_354_1.dialog_:SetActive(true)

				arg_354_1.dialogCg_.alpha = 0

				local var_357_52 = LeanTween.value(arg_354_1.dialog_, 0, 1, 0.3)

				var_357_52:setOnUpdate(LuaHelper.FloatAction(function(arg_359_0)
					arg_354_1.dialogCg_.alpha = arg_359_0
				end))
				var_357_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_354_1.dialog_)
					var_357_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_354_1.duration_ = arg_354_1.duration_ + 0.3

				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_53 = arg_354_1:GetWordFromCfg(938041088)
				local var_357_54 = arg_354_1:FormatText(var_357_53.content)

				arg_354_1.text_.text = var_357_54

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_55 = 15
				local var_357_56 = utf8.len(var_357_54)
				local var_357_57 = var_357_55 <= 0 and var_357_51 or var_357_51 * (var_357_56 / var_357_55)

				if var_357_57 > 0 and var_357_51 < var_357_57 then
					arg_354_1.talkMaxDuration = var_357_57
					var_357_50 = var_357_50 + 0.3

					if var_357_57 + var_357_50 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_57 + var_357_50
					end
				end

				arg_354_1.text_.text = var_357_54
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_58 = var_357_50 + 0.3
			local var_357_59 = math.max(var_357_51, arg_354_1.talkMaxDuration)

			if var_357_58 <= arg_354_1.time_ and arg_354_1.time_ < var_357_58 + var_357_59 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_58) / var_357_59

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_58 + var_357_59 and arg_354_1.time_ < var_357_58 + var_357_59 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10183",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play938041089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 938041089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play938041090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = arg_361_1.actors_["128404"]
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.actorSpriteComps128404 == nil then
				arg_361_1.var_.actorSpriteComps128404 = var_364_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_2 = 0.2

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 and not isNil(var_364_0) then
				local var_364_3 = (arg_361_1.time_ - var_364_1) / var_364_2

				if arg_361_1.var_.actorSpriteComps128404 then
					for iter_364_0, iter_364_1 in pairs(arg_361_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_364_1 then
							if arg_361_1.isInRecall_ then
								local var_364_4 = Mathf.Lerp(iter_364_1.color.r, arg_361_1.hightColor1.r, var_364_3)
								local var_364_5 = Mathf.Lerp(iter_364_1.color.g, arg_361_1.hightColor1.g, var_364_3)
								local var_364_6 = Mathf.Lerp(iter_364_1.color.b, arg_361_1.hightColor1.b, var_364_3)

								iter_364_1.color = Color.New(var_364_4, var_364_5, var_364_6)
							else
								local var_364_7 = Mathf.Lerp(iter_364_1.color.r, 1, var_364_3)

								iter_364_1.color = Color.New(var_364_7, var_364_7, var_364_7)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 and not isNil(var_364_0) and arg_361_1.var_.actorSpriteComps128404 then
				for iter_364_2, iter_364_3 in pairs(arg_361_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_364_3 then
						if arg_361_1.isInRecall_ then
							iter_364_3.color = arg_361_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_364_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_361_1.var_.actorSpriteComps128404 = nil
			end

			local var_364_8 = arg_361_1.actors_["128404"].transform
			local var_364_9 = 0

			if var_364_9 < arg_361_1.time_ and arg_361_1.time_ <= var_364_9 + arg_364_0 then
				arg_361_1.var_.moveOldPos128404 = var_364_8.localPosition
				var_364_8.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("128404", 2)

				local var_364_10 = var_364_8.childCount

				for iter_364_4 = 0, var_364_10 - 1 do
					local var_364_11 = var_364_8:GetChild(iter_364_4)

					if var_364_11.name == "split_1" or not string.find(var_364_11.name, "split") then
						var_364_11.gameObject:SetActive(true)
					else
						var_364_11.gameObject:SetActive(false)
					end
				end
			end

			local var_364_12 = 0.001

			if var_364_9 <= arg_361_1.time_ and arg_361_1.time_ < var_364_9 + var_364_12 then
				local var_364_13 = (arg_361_1.time_ - var_364_9) / var_364_12
				local var_364_14 = Vector3.New(-428.5, -356, -362.3)

				var_364_8.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos128404, var_364_14, var_364_13)
			end

			if arg_361_1.time_ >= var_364_9 + var_364_12 and arg_361_1.time_ < var_364_9 + var_364_12 + arg_364_0 then
				var_364_8.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_364_15 = 0
			local var_364_16 = 0.425

			if var_364_15 < arg_361_1.time_ and arg_361_1.time_ <= var_364_15 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_17 = arg_361_1:FormatText(StoryNameCfg[6].name)

				arg_361_1.leftNameTxt_.text = var_364_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_18 = arg_361_1:GetWordFromCfg(938041089)
				local var_364_19 = arg_361_1:FormatText(var_364_18.content)

				arg_361_1.text_.text = var_364_19

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_20 = 17
				local var_364_21 = utf8.len(var_364_19)
				local var_364_22 = var_364_20 <= 0 and var_364_16 or var_364_16 * (var_364_21 / var_364_20)

				if var_364_22 > 0 and var_364_16 < var_364_22 then
					arg_361_1.talkMaxDuration = var_364_22

					if var_364_22 + var_364_15 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_22 + var_364_15
					end
				end

				arg_361_1.text_.text = var_364_19
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_23 = math.max(var_364_16, arg_361_1.talkMaxDuration)

			if var_364_15 <= arg_361_1.time_ and arg_361_1.time_ < var_364_15 + var_364_23 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_15) / var_364_23

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_15 + var_364_23 and arg_361_1.time_ < var_364_15 + var_364_23 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
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

		arg_361_1:InitPlayNodeList()
	end,
	Play938041090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 938041090
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play938041091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["104902"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.actorSpriteComps104902 == nil then
				arg_365_1.var_.actorSpriteComps104902 = var_368_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_2 = 0.2

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.actorSpriteComps104902 then
					for iter_368_0, iter_368_1 in pairs(arg_365_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_368_1 then
							if arg_365_1.isInRecall_ then
								local var_368_4 = Mathf.Lerp(iter_368_1.color.r, arg_365_1.hightColor1.r, var_368_3)
								local var_368_5 = Mathf.Lerp(iter_368_1.color.g, arg_365_1.hightColor1.g, var_368_3)
								local var_368_6 = Mathf.Lerp(iter_368_1.color.b, arg_365_1.hightColor1.b, var_368_3)

								iter_368_1.color = Color.New(var_368_4, var_368_5, var_368_6)
							else
								local var_368_7 = Mathf.Lerp(iter_368_1.color.r, 1, var_368_3)

								iter_368_1.color = Color.New(var_368_7, var_368_7, var_368_7)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.actorSpriteComps104902 then
				for iter_368_2, iter_368_3 in pairs(arg_365_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_368_3 then
						if arg_365_1.isInRecall_ then
							iter_368_3.color = arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_368_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps104902 = nil
			end

			local var_368_8 = arg_365_1.actors_["128404"]
			local var_368_9 = 0

			if var_368_9 < arg_365_1.time_ and arg_365_1.time_ <= var_368_9 + arg_368_0 and not isNil(var_368_8) and arg_365_1.var_.actorSpriteComps128404 == nil then
				arg_365_1.var_.actorSpriteComps128404 = var_368_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_10 = 0.2

			if var_368_9 <= arg_365_1.time_ and arg_365_1.time_ < var_368_9 + var_368_10 and not isNil(var_368_8) then
				local var_368_11 = (arg_365_1.time_ - var_368_9) / var_368_10

				if arg_365_1.var_.actorSpriteComps128404 then
					for iter_368_4, iter_368_5 in pairs(arg_365_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_368_5 then
							if arg_365_1.isInRecall_ then
								local var_368_12 = Mathf.Lerp(iter_368_5.color.r, arg_365_1.hightColor2.r, var_368_11)
								local var_368_13 = Mathf.Lerp(iter_368_5.color.g, arg_365_1.hightColor2.g, var_368_11)
								local var_368_14 = Mathf.Lerp(iter_368_5.color.b, arg_365_1.hightColor2.b, var_368_11)

								iter_368_5.color = Color.New(var_368_12, var_368_13, var_368_14)
							else
								local var_368_15 = Mathf.Lerp(iter_368_5.color.r, 0.5, var_368_11)

								iter_368_5.color = Color.New(var_368_15, var_368_15, var_368_15)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_9 + var_368_10 and arg_365_1.time_ < var_368_9 + var_368_10 + arg_368_0 and not isNil(var_368_8) and arg_365_1.var_.actorSpriteComps128404 then
				for iter_368_6, iter_368_7 in pairs(arg_365_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_368_7 then
						if arg_365_1.isInRecall_ then
							iter_368_7.color = arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_368_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps128404 = nil
			end

			local var_368_16 = arg_365_1.actors_["104902"].transform
			local var_368_17 = 0

			if var_368_17 < arg_365_1.time_ and arg_365_1.time_ <= var_368_17 + arg_368_0 then
				arg_365_1.var_.moveOldPos104902 = var_368_16.localPosition
				var_368_16.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("104902", 4)

				local var_368_18 = var_368_16.childCount

				for iter_368_8 = 0, var_368_18 - 1 do
					local var_368_19 = var_368_16:GetChild(iter_368_8)

					if var_368_19.name == "" or not string.find(var_368_19.name, "split") then
						var_368_19.gameObject:SetActive(true)
					else
						var_368_19.gameObject:SetActive(false)
					end
				end
			end

			local var_368_20 = 0.001

			if var_368_17 <= arg_365_1.time_ and arg_365_1.time_ < var_368_17 + var_368_20 then
				local var_368_21 = (arg_365_1.time_ - var_368_17) / var_368_20
				local var_368_22 = Vector3.New(390, -335, -360)

				var_368_16.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos104902, var_368_22, var_368_21)
			end

			if arg_365_1.time_ >= var_368_17 + var_368_20 and arg_365_1.time_ < var_368_17 + var_368_20 + arg_368_0 then
				var_368_16.localPosition = Vector3.New(390, -335, -360)
			end

			local var_368_23 = 0
			local var_368_24 = 0.475

			if var_368_23 < arg_365_1.time_ and arg_365_1.time_ <= var_368_23 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_25 = arg_365_1:FormatText(StoryNameCfg[562].name)

				arg_365_1.leftNameTxt_.text = var_368_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_26 = arg_365_1:GetWordFromCfg(938041090)
				local var_368_27 = arg_365_1:FormatText(var_368_26.content)

				arg_365_1.text_.text = var_368_27

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_28 = 19
				local var_368_29 = utf8.len(var_368_27)
				local var_368_30 = var_368_28 <= 0 and var_368_24 or var_368_24 * (var_368_29 / var_368_28)

				if var_368_30 > 0 and var_368_24 < var_368_30 then
					arg_365_1.talkMaxDuration = var_368_30

					if var_368_30 + var_368_23 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_30 + var_368_23
					end
				end

				arg_365_1.text_.text = var_368_27
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_31 = math.max(var_368_24, arg_365_1.talkMaxDuration)

			if var_368_23 <= arg_365_1.time_ and arg_365_1.time_ < var_368_23 + var_368_31 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_23) / var_368_31

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_23 + var_368_31 and arg_365_1.time_ < var_368_23 + var_368_31 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104902",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play938041091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 938041091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play938041092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["106603"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps106603 == nil then
				arg_369_1.var_.actorSpriteComps106603 = var_372_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_2 = 0.2

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.actorSpriteComps106603 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_372_1 then
							if arg_369_1.isInRecall_ then
								local var_372_4 = Mathf.Lerp(iter_372_1.color.r, arg_369_1.hightColor1.r, var_372_3)
								local var_372_5 = Mathf.Lerp(iter_372_1.color.g, arg_369_1.hightColor1.g, var_372_3)
								local var_372_6 = Mathf.Lerp(iter_372_1.color.b, arg_369_1.hightColor1.b, var_372_3)

								iter_372_1.color = Color.New(var_372_4, var_372_5, var_372_6)
							else
								local var_372_7 = Mathf.Lerp(iter_372_1.color.r, 1, var_372_3)

								iter_372_1.color = Color.New(var_372_7, var_372_7, var_372_7)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps106603 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_372_3 then
						if arg_369_1.isInRecall_ then
							iter_372_3.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_372_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps106603 = nil
			end

			local var_372_8 = arg_369_1.actors_["104902"]
			local var_372_9 = 0

			if var_372_9 < arg_369_1.time_ and arg_369_1.time_ <= var_372_9 + arg_372_0 and not isNil(var_372_8) and arg_369_1.var_.actorSpriteComps104902 == nil then
				arg_369_1.var_.actorSpriteComps104902 = var_372_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_10 = 0.2

			if var_372_9 <= arg_369_1.time_ and arg_369_1.time_ < var_372_9 + var_372_10 and not isNil(var_372_8) then
				local var_372_11 = (arg_369_1.time_ - var_372_9) / var_372_10

				if arg_369_1.var_.actorSpriteComps104902 then
					for iter_372_4, iter_372_5 in pairs(arg_369_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_372_5 then
							if arg_369_1.isInRecall_ then
								local var_372_12 = Mathf.Lerp(iter_372_5.color.r, arg_369_1.hightColor2.r, var_372_11)
								local var_372_13 = Mathf.Lerp(iter_372_5.color.g, arg_369_1.hightColor2.g, var_372_11)
								local var_372_14 = Mathf.Lerp(iter_372_5.color.b, arg_369_1.hightColor2.b, var_372_11)

								iter_372_5.color = Color.New(var_372_12, var_372_13, var_372_14)
							else
								local var_372_15 = Mathf.Lerp(iter_372_5.color.r, 0.5, var_372_11)

								iter_372_5.color = Color.New(var_372_15, var_372_15, var_372_15)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_9 + var_372_10 and arg_369_1.time_ < var_372_9 + var_372_10 + arg_372_0 and not isNil(var_372_8) and arg_369_1.var_.actorSpriteComps104902 then
				for iter_372_6, iter_372_7 in pairs(arg_369_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_372_7 then
						if arg_369_1.isInRecall_ then
							iter_372_7.color = arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_372_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps104902 = nil
			end

			local var_372_16 = arg_369_1.actors_["106603"].transform
			local var_372_17 = 0

			if var_372_17 < arg_369_1.time_ and arg_369_1.time_ <= var_372_17 + arg_372_0 then
				arg_369_1.var_.moveOldPos106603 = var_372_16.localPosition
				var_372_16.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("106603", 2)

				local var_372_18 = var_372_16.childCount

				for iter_372_8 = 0, var_372_18 - 1 do
					local var_372_19 = var_372_16:GetChild(iter_372_8)

					if var_372_19.name == "" or not string.find(var_372_19.name, "split") then
						var_372_19.gameObject:SetActive(true)
					else
						var_372_19.gameObject:SetActive(false)
					end
				end
			end

			local var_372_20 = 0.001

			if var_372_17 <= arg_369_1.time_ and arg_369_1.time_ < var_372_17 + var_372_20 then
				local var_372_21 = (arg_369_1.time_ - var_372_17) / var_372_20
				local var_372_22 = Vector3.New(-510.9, -399.1, -303.3)

				var_372_16.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos106603, var_372_22, var_372_21)
			end

			if arg_369_1.time_ >= var_372_17 + var_372_20 and arg_369_1.time_ < var_372_17 + var_372_20 + arg_372_0 then
				var_372_16.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_372_23 = arg_369_1.actors_["128404"].transform
			local var_372_24 = 0

			if var_372_24 < arg_369_1.time_ and arg_369_1.time_ <= var_372_24 + arg_372_0 then
				arg_369_1.var_.moveOldPos128404 = var_372_23.localPosition
				var_372_23.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("128404", 7)

				local var_372_25 = var_372_23.childCount

				for iter_372_9 = 0, var_372_25 - 1 do
					local var_372_26 = var_372_23:GetChild(iter_372_9)

					if var_372_26.name == "" or not string.find(var_372_26.name, "split") then
						var_372_26.gameObject:SetActive(true)
					else
						var_372_26.gameObject:SetActive(false)
					end
				end
			end

			local var_372_27 = 0.001

			if var_372_24 <= arg_369_1.time_ and arg_369_1.time_ < var_372_24 + var_372_27 then
				local var_372_28 = (arg_369_1.time_ - var_372_24) / var_372_27
				local var_372_29 = Vector3.New(0, -2000, 0)

				var_372_23.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos128404, var_372_29, var_372_28)
			end

			if arg_369_1.time_ >= var_372_24 + var_372_27 and arg_369_1.time_ < var_372_24 + var_372_27 + arg_372_0 then
				var_372_23.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_372_30 = 0
			local var_372_31 = 0.375

			if var_372_30 < arg_369_1.time_ and arg_369_1.time_ <= var_372_30 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_32 = arg_369_1:FormatText(StoryNameCfg[32].name)

				arg_369_1.leftNameTxt_.text = var_372_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_33 = arg_369_1:GetWordFromCfg(938041091)
				local var_372_34 = arg_369_1:FormatText(var_372_33.content)

				arg_369_1.text_.text = var_372_34

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_35 = 15
				local var_372_36 = utf8.len(var_372_34)
				local var_372_37 = var_372_35 <= 0 and var_372_31 or var_372_31 * (var_372_36 / var_372_35)

				if var_372_37 > 0 and var_372_31 < var_372_37 then
					arg_369_1.talkMaxDuration = var_372_37

					if var_372_37 + var_372_30 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_37 + var_372_30
					end
				end

				arg_369_1.text_.text = var_372_34
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_38 = math.max(var_372_31, arg_369_1.talkMaxDuration)

			if var_372_30 <= arg_369_1.time_ and arg_369_1.time_ < var_372_30 + var_372_38 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_30) / var_372_38

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_30 + var_372_38 and arg_369_1.time_ < var_372_30 + var_372_38 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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
				actorName = "128404",
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
	Play938041092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 938041092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play938041093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["108301"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.actorSpriteComps108301 == nil then
				arg_373_1.var_.actorSpriteComps108301 = var_376_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_2 = 0.2

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.actorSpriteComps108301 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								local var_376_4 = Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor1.r, var_376_3)
								local var_376_5 = Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor1.g, var_376_3)
								local var_376_6 = Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor1.b, var_376_3)

								iter_376_1.color = Color.New(var_376_4, var_376_5, var_376_6)
							else
								local var_376_7 = Mathf.Lerp(iter_376_1.color.r, 1, var_376_3)

								iter_376_1.color = Color.New(var_376_7, var_376_7, var_376_7)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.actorSpriteComps108301 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_376_3 then
						if arg_373_1.isInRecall_ then
							iter_376_3.color = arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_376_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps108301 = nil
			end

			local var_376_8 = arg_373_1.actors_["106603"]
			local var_376_9 = 0

			if var_376_9 < arg_373_1.time_ and arg_373_1.time_ <= var_376_9 + arg_376_0 and not isNil(var_376_8) and arg_373_1.var_.actorSpriteComps106603 == nil then
				arg_373_1.var_.actorSpriteComps106603 = var_376_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_10 = 0.2

			if var_376_9 <= arg_373_1.time_ and arg_373_1.time_ < var_376_9 + var_376_10 and not isNil(var_376_8) then
				local var_376_11 = (arg_373_1.time_ - var_376_9) / var_376_10

				if arg_373_1.var_.actorSpriteComps106603 then
					for iter_376_4, iter_376_5 in pairs(arg_373_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_376_5 then
							if arg_373_1.isInRecall_ then
								local var_376_12 = Mathf.Lerp(iter_376_5.color.r, arg_373_1.hightColor2.r, var_376_11)
								local var_376_13 = Mathf.Lerp(iter_376_5.color.g, arg_373_1.hightColor2.g, var_376_11)
								local var_376_14 = Mathf.Lerp(iter_376_5.color.b, arg_373_1.hightColor2.b, var_376_11)

								iter_376_5.color = Color.New(var_376_12, var_376_13, var_376_14)
							else
								local var_376_15 = Mathf.Lerp(iter_376_5.color.r, 0.5, var_376_11)

								iter_376_5.color = Color.New(var_376_15, var_376_15, var_376_15)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_9 + var_376_10 and arg_373_1.time_ < var_376_9 + var_376_10 + arg_376_0 and not isNil(var_376_8) and arg_373_1.var_.actorSpriteComps106603 then
				for iter_376_6, iter_376_7 in pairs(arg_373_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_376_7 then
						if arg_373_1.isInRecall_ then
							iter_376_7.color = arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_376_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps106603 = nil
			end

			local var_376_16 = arg_373_1.actors_["108301"].transform
			local var_376_17 = 0

			if var_376_17 < arg_373_1.time_ and arg_373_1.time_ <= var_376_17 + arg_376_0 then
				arg_373_1.var_.moveOldPos108301 = var_376_16.localPosition
				var_376_16.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("108301", 4)

				local var_376_18 = var_376_16.childCount

				for iter_376_8 = 0, var_376_18 - 1 do
					local var_376_19 = var_376_16:GetChild(iter_376_8)

					if var_376_19.name == "" or not string.find(var_376_19.name, "split") then
						var_376_19.gameObject:SetActive(true)
					else
						var_376_19.gameObject:SetActive(false)
					end
				end
			end

			local var_376_20 = 0.001

			if var_376_17 <= arg_373_1.time_ and arg_373_1.time_ < var_376_17 + var_376_20 then
				local var_376_21 = (arg_373_1.time_ - var_376_17) / var_376_20
				local var_376_22 = Vector3.New(460, -360, -195)

				var_376_16.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos108301, var_376_22, var_376_21)
			end

			if arg_373_1.time_ >= var_376_17 + var_376_20 and arg_373_1.time_ < var_376_17 + var_376_20 + arg_376_0 then
				var_376_16.localPosition = Vector3.New(460, -360, -195)
			end

			local var_376_23 = arg_373_1.actors_["104902"].transform
			local var_376_24 = 0

			if var_376_24 < arg_373_1.time_ and arg_373_1.time_ <= var_376_24 + arg_376_0 then
				arg_373_1.var_.moveOldPos104902 = var_376_23.localPosition
				var_376_23.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("104902", 7)

				local var_376_25 = var_376_23.childCount

				for iter_376_9 = 0, var_376_25 - 1 do
					local var_376_26 = var_376_23:GetChild(iter_376_9)

					if var_376_26.name == "" or not string.find(var_376_26.name, "split") then
						var_376_26.gameObject:SetActive(true)
					else
						var_376_26.gameObject:SetActive(false)
					end
				end
			end

			local var_376_27 = 0.001

			if var_376_24 <= arg_373_1.time_ and arg_373_1.time_ < var_376_24 + var_376_27 then
				local var_376_28 = (arg_373_1.time_ - var_376_24) / var_376_27
				local var_376_29 = Vector3.New(0, -2000, -360)

				var_376_23.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos104902, var_376_29, var_376_28)
			end

			if arg_373_1.time_ >= var_376_24 + var_376_27 and arg_373_1.time_ < var_376_24 + var_376_27 + arg_376_0 then
				var_376_23.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_376_30 = 0
			local var_376_31 = 0.3

			if var_376_30 < arg_373_1.time_ and arg_373_1.time_ <= var_376_30 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_32 = arg_373_1:FormatText(StoryNameCfg[1332].name)

				arg_373_1.leftNameTxt_.text = var_376_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_33 = arg_373_1:GetWordFromCfg(938041092)
				local var_376_34 = arg_373_1:FormatText(var_376_33.content)

				arg_373_1.text_.text = var_376_34

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_35 = 12
				local var_376_36 = utf8.len(var_376_34)
				local var_376_37 = var_376_35 <= 0 and var_376_31 or var_376_31 * (var_376_36 / var_376_35)

				if var_376_37 > 0 and var_376_31 < var_376_37 then
					arg_373_1.talkMaxDuration = var_376_37

					if var_376_37 + var_376_30 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_37 + var_376_30
					end
				end

				arg_373_1.text_.text = var_376_34
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_38 = math.max(var_376_31, arg_373_1.talkMaxDuration)

			if var_376_30 <= arg_373_1.time_ and arg_373_1.time_ < var_376_30 + var_376_38 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_30) / var_376_38

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_30 + var_376_38 and arg_373_1.time_ < var_376_30 + var_376_38 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104902",
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
	Play938041093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 938041093
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play938041094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["108301"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.actorSpriteComps108301 == nil then
				arg_377_1.var_.actorSpriteComps108301 = var_380_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_2 = 0.2

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.actorSpriteComps108301 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_380_1 then
							if arg_377_1.isInRecall_ then
								local var_380_4 = Mathf.Lerp(iter_380_1.color.r, arg_377_1.hightColor2.r, var_380_3)
								local var_380_5 = Mathf.Lerp(iter_380_1.color.g, arg_377_1.hightColor2.g, var_380_3)
								local var_380_6 = Mathf.Lerp(iter_380_1.color.b, arg_377_1.hightColor2.b, var_380_3)

								iter_380_1.color = Color.New(var_380_4, var_380_5, var_380_6)
							else
								local var_380_7 = Mathf.Lerp(iter_380_1.color.r, 0.5, var_380_3)

								iter_380_1.color = Color.New(var_380_7, var_380_7, var_380_7)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.actorSpriteComps108301 then
				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_380_3 then
						if arg_377_1.isInRecall_ then
							iter_380_3.color = arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_380_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_377_1.var_.actorSpriteComps108301 = nil
			end

			local var_380_8 = arg_377_1.actors_["108301"].transform
			local var_380_9 = 0

			if var_380_9 < arg_377_1.time_ and arg_377_1.time_ <= var_380_9 + arg_380_0 then
				arg_377_1.var_.moveOldPos108301 = var_380_8.localPosition
				var_380_8.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("108301", 7)

				local var_380_10 = var_380_8.childCount

				for iter_380_4 = 0, var_380_10 - 1 do
					local var_380_11 = var_380_8:GetChild(iter_380_4)

					if var_380_11.name == "" or not string.find(var_380_11.name, "split") then
						var_380_11.gameObject:SetActive(true)
					else
						var_380_11.gameObject:SetActive(false)
					end
				end
			end

			local var_380_12 = 0.001

			if var_380_9 <= arg_377_1.time_ and arg_377_1.time_ < var_380_9 + var_380_12 then
				local var_380_13 = (arg_377_1.time_ - var_380_9) / var_380_12
				local var_380_14 = Vector3.New(0, -2000, 0)

				var_380_8.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos108301, var_380_14, var_380_13)
			end

			if arg_377_1.time_ >= var_380_9 + var_380_12 and arg_377_1.time_ < var_380_9 + var_380_12 + arg_380_0 then
				var_380_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_380_15 = arg_377_1.actors_["106603"].transform
			local var_380_16 = 0

			if var_380_16 < arg_377_1.time_ and arg_377_1.time_ <= var_380_16 + arg_380_0 then
				arg_377_1.var_.moveOldPos106603 = var_380_15.localPosition
				var_380_15.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("106603", 7)

				local var_380_17 = var_380_15.childCount

				for iter_380_5 = 0, var_380_17 - 1 do
					local var_380_18 = var_380_15:GetChild(iter_380_5)

					if var_380_18.name == "" or not string.find(var_380_18.name, "split") then
						var_380_18.gameObject:SetActive(true)
					else
						var_380_18.gameObject:SetActive(false)
					end
				end
			end

			local var_380_19 = 0.001

			if var_380_16 <= arg_377_1.time_ and arg_377_1.time_ < var_380_16 + var_380_19 then
				local var_380_20 = (arg_377_1.time_ - var_380_16) / var_380_19
				local var_380_21 = Vector3.New(0, -2000, 0)

				var_380_15.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos106603, var_380_21, var_380_20)
			end

			if arg_377_1.time_ >= var_380_16 + var_380_19 and arg_377_1.time_ < var_380_16 + var_380_19 + arg_380_0 then
				var_380_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_380_22 = 0
			local var_380_23 = 1.325

			if var_380_22 < arg_377_1.time_ and arg_377_1.time_ <= var_380_22 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_24 = arg_377_1:GetWordFromCfg(938041093)
				local var_380_25 = arg_377_1:FormatText(var_380_24.content)

				arg_377_1.text_.text = var_380_25

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_26 = 53
				local var_380_27 = utf8.len(var_380_25)
				local var_380_28 = var_380_26 <= 0 and var_380_23 or var_380_23 * (var_380_27 / var_380_26)

				if var_380_28 > 0 and var_380_23 < var_380_28 then
					arg_377_1.talkMaxDuration = var_380_28

					if var_380_28 + var_380_22 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_28 + var_380_22
					end
				end

				arg_377_1.text_.text = var_380_25
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_29 = math.max(var_380_23, arg_377_1.talkMaxDuration)

			if var_380_22 <= arg_377_1.time_ and arg_377_1.time_ < var_380_22 + var_380_29 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_22) / var_380_29

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_22 + var_380_29 and arg_377_1.time_ < var_380_22 + var_380_29 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "108301",
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

		arg_377_1:InitPlayNodeList()
	end,
	Play938041094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 938041094
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play938041095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0
			local var_384_1 = 0.7

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_2 = arg_381_1:FormatText(StoryNameCfg[7].name)

				arg_381_1.leftNameTxt_.text = var_384_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, true)
				arg_381_1.iconController_:SetSelectedState("hero")

				arg_381_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_381_1.callingController_:SetSelectedState("normal")

				arg_381_1.keyicon_.color = Color.New(1, 1, 1)
				arg_381_1.icon_.color = Color.New(1, 1, 1)

				local var_384_3 = arg_381_1:GetWordFromCfg(938041094)
				local var_384_4 = arg_381_1:FormatText(var_384_3.content)

				arg_381_1.text_.text = var_384_4

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_5 = 28
				local var_384_6 = utf8.len(var_384_4)
				local var_384_7 = var_384_5 <= 0 and var_384_1 or var_384_1 * (var_384_6 / var_384_5)

				if var_384_7 > 0 and var_384_1 < var_384_7 then
					arg_381_1.talkMaxDuration = var_384_7

					if var_384_7 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_7 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_4
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_8 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_8 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_8

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_8 and arg_381_1.time_ < var_384_0 + var_384_8 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play938041095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 938041095
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play938041096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["10144"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.actorSpriteComps10144 == nil then
				arg_385_1.var_.actorSpriteComps10144 = var_388_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_2 = 0.2

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.actorSpriteComps10144 then
					for iter_388_0, iter_388_1 in pairs(arg_385_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_388_1 then
							if arg_385_1.isInRecall_ then
								local var_388_4 = Mathf.Lerp(iter_388_1.color.r, arg_385_1.hightColor1.r, var_388_3)
								local var_388_5 = Mathf.Lerp(iter_388_1.color.g, arg_385_1.hightColor1.g, var_388_3)
								local var_388_6 = Mathf.Lerp(iter_388_1.color.b, arg_385_1.hightColor1.b, var_388_3)

								iter_388_1.color = Color.New(var_388_4, var_388_5, var_388_6)
							else
								local var_388_7 = Mathf.Lerp(iter_388_1.color.r, 1, var_388_3)

								iter_388_1.color = Color.New(var_388_7, var_388_7, var_388_7)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.actorSpriteComps10144 then
				for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_388_3 then
						if arg_385_1.isInRecall_ then
							iter_388_3.color = arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_388_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_385_1.var_.actorSpriteComps10144 = nil
			end

			local var_388_8 = arg_385_1.actors_["10144"].transform
			local var_388_9 = 0

			if var_388_9 < arg_385_1.time_ and arg_385_1.time_ <= var_388_9 + arg_388_0 then
				arg_385_1.var_.moveOldPos10144 = var_388_8.localPosition
				var_388_8.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("10144", 3)

				local var_388_10 = var_388_8.childCount

				for iter_388_4 = 0, var_388_10 - 1 do
					local var_388_11 = var_388_8:GetChild(iter_388_4)

					if var_388_11.name == "split_2" or not string.find(var_388_11.name, "split") then
						var_388_11.gameObject:SetActive(true)
					else
						var_388_11.gameObject:SetActive(false)
					end
				end
			end

			local var_388_12 = 0.001

			if var_388_9 <= arg_385_1.time_ and arg_385_1.time_ < var_388_9 + var_388_12 then
				local var_388_13 = (arg_385_1.time_ - var_388_9) / var_388_12
				local var_388_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_388_8.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10144, var_388_14, var_388_13)
			end

			if arg_385_1.time_ >= var_388_9 + var_388_12 and arg_385_1.time_ < var_388_9 + var_388_12 + arg_388_0 then
				var_388_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_388_15 = 0
			local var_388_16 = 0.65

			if var_388_15 < arg_385_1.time_ and arg_385_1.time_ <= var_388_15 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_17 = arg_385_1:FormatText(StoryNameCfg[1297].name)

				arg_385_1.leftNameTxt_.text = var_388_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_18 = arg_385_1:GetWordFromCfg(938041095)
				local var_388_19 = arg_385_1:FormatText(var_388_18.content)

				arg_385_1.text_.text = var_388_19

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_20 = 26
				local var_388_21 = utf8.len(var_388_19)
				local var_388_22 = var_388_20 <= 0 and var_388_16 or var_388_16 * (var_388_21 / var_388_20)

				if var_388_22 > 0 and var_388_16 < var_388_22 then
					arg_385_1.talkMaxDuration = var_388_22

					if var_388_22 + var_388_15 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_22 + var_388_15
					end
				end

				arg_385_1.text_.text = var_388_19
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_23 = math.max(var_388_16, arg_385_1.talkMaxDuration)

			if var_388_15 <= arg_385_1.time_ and arg_385_1.time_ < var_388_15 + var_388_23 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_15) / var_388_23

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_15 + var_388_23 and arg_385_1.time_ < var_388_15 + var_388_23 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
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

		arg_385_1:InitPlayNodeList()
	end,
	Play938041096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 938041096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play938041097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["10144"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.actorSpriteComps10144 == nil then
				arg_389_1.var_.actorSpriteComps10144 = var_392_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_2 = 0.2

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.actorSpriteComps10144 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								local var_392_4 = Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor2.r, var_392_3)
								local var_392_5 = Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor2.g, var_392_3)
								local var_392_6 = Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor2.b, var_392_3)

								iter_392_1.color = Color.New(var_392_4, var_392_5, var_392_6)
							else
								local var_392_7 = Mathf.Lerp(iter_392_1.color.r, 0.5, var_392_3)

								iter_392_1.color = Color.New(var_392_7, var_392_7, var_392_7)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.actorSpriteComps10144 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_392_3 then
						if arg_389_1.isInRecall_ then
							iter_392_3.color = arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_392_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_389_1.var_.actorSpriteComps10144 = nil
			end

			local var_392_8 = 0
			local var_392_9 = 0.725

			if var_392_8 < arg_389_1.time_ and arg_389_1.time_ <= var_392_8 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_10 = arg_389_1:GetWordFromCfg(938041096)
				local var_392_11 = arg_389_1:FormatText(var_392_10.content)

				arg_389_1.text_.text = var_392_11

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_12 = 29
				local var_392_13 = utf8.len(var_392_11)
				local var_392_14 = var_392_12 <= 0 and var_392_9 or var_392_9 * (var_392_13 / var_392_12)

				if var_392_14 > 0 and var_392_9 < var_392_14 then
					arg_389_1.talkMaxDuration = var_392_14

					if var_392_14 + var_392_8 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_14 + var_392_8
					end
				end

				arg_389_1.text_.text = var_392_11
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_15 = math.max(var_392_9, arg_389_1.talkMaxDuration)

			if var_392_8 <= arg_389_1.time_ and arg_389_1.time_ < var_392_8 + var_392_15 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_8) / var_392_15

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_8 + var_392_15 and arg_389_1.time_ < var_392_8 + var_392_15 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play938041097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 938041097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play938041098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0
			local var_396_1 = 0.375

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_2 = arg_393_1:FormatText(StoryNameCfg[7].name)

				arg_393_1.leftNameTxt_.text = var_396_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_3 = arg_393_1:GetWordFromCfg(938041097)
				local var_396_4 = arg_393_1:FormatText(var_396_3.content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 15
				local var_396_6 = utf8.len(var_396_4)
				local var_396_7 = var_396_5 <= 0 and var_396_1 or var_396_1 * (var_396_6 / var_396_5)

				if var_396_7 > 0 and var_396_1 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_0
					end
				end

				arg_393_1.text_.text = var_396_4
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_8 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_8 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_8

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_8 and arg_393_1.time_ < var_396_0 + var_396_8 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play938041098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 938041098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play938041099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["10144"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.actorSpriteComps10144 == nil then
				arg_397_1.var_.actorSpriteComps10144 = var_400_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_2 = 0.2

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.actorSpriteComps10144 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_400_1 then
							if arg_397_1.isInRecall_ then
								local var_400_4 = Mathf.Lerp(iter_400_1.color.r, arg_397_1.hightColor1.r, var_400_3)
								local var_400_5 = Mathf.Lerp(iter_400_1.color.g, arg_397_1.hightColor1.g, var_400_3)
								local var_400_6 = Mathf.Lerp(iter_400_1.color.b, arg_397_1.hightColor1.b, var_400_3)

								iter_400_1.color = Color.New(var_400_4, var_400_5, var_400_6)
							else
								local var_400_7 = Mathf.Lerp(iter_400_1.color.r, 1, var_400_3)

								iter_400_1.color = Color.New(var_400_7, var_400_7, var_400_7)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.actorSpriteComps10144 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_400_3 then
						if arg_397_1.isInRecall_ then
							iter_400_3.color = arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_400_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_397_1.var_.actorSpriteComps10144 = nil
			end

			local var_400_8 = arg_397_1.actors_["10144"].transform
			local var_400_9 = 0

			if var_400_9 < arg_397_1.time_ and arg_397_1.time_ <= var_400_9 + arg_400_0 then
				arg_397_1.var_.moveOldPos10144 = var_400_8.localPosition
				var_400_8.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("10144", 3)

				local var_400_10 = var_400_8.childCount

				for iter_400_4 = 0, var_400_10 - 1 do
					local var_400_11 = var_400_8:GetChild(iter_400_4)

					if var_400_11.name == "split_1" then
						var_400_11:SetAsLastSibling()
						var_400_11.gameObject:SetActive(true)

						arg_397_1.var_.actorSpriteSplit10144 = var_400_11.gameObject:GetComponent(typeof(Image))

						arg_397_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_400_12 = 0.5

			if var_400_9 <= arg_397_1.time_ and arg_397_1.time_ < var_400_9 + var_400_12 then
				local var_400_13 = (arg_397_1.time_ - var_400_9) / var_400_12
				local var_400_14 = Vector3.New(-31.5, -381.1, -285.9)

				var_400_8.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10144, var_400_14, var_400_13)

				if arg_397_1.var_.actorSpriteSplit10144 ~= nil then
					arg_397_1.var_.actorSpriteSplit10144:SetAlpha(var_400_13)
				end
			end

			if arg_397_1.time_ >= var_400_9 + var_400_12 and arg_397_1.time_ < var_400_9 + var_400_12 + arg_400_0 then
				var_400_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_397_1.var_.actorSpriteSplit10144 ~= nil then
					arg_397_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_400_15 = 0
			local var_400_16 = 1.1

			if var_400_15 < arg_397_1.time_ and arg_397_1.time_ <= var_400_15 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_17 = arg_397_1:FormatText(StoryNameCfg[1297].name)

				arg_397_1.leftNameTxt_.text = var_400_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_18 = arg_397_1:GetWordFromCfg(938041098)
				local var_400_19 = arg_397_1:FormatText(var_400_18.content)

				arg_397_1.text_.text = var_400_19

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_20 = 44
				local var_400_21 = utf8.len(var_400_19)
				local var_400_22 = var_400_20 <= 0 and var_400_16 or var_400_16 * (var_400_21 / var_400_20)

				if var_400_22 > 0 and var_400_16 < var_400_22 then
					arg_397_1.talkMaxDuration = var_400_22

					if var_400_22 + var_400_15 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_22 + var_400_15
					end
				end

				arg_397_1.text_.text = var_400_19
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_23 = math.max(var_400_16, arg_397_1.talkMaxDuration)

			if var_400_15 <= arg_397_1.time_ and arg_397_1.time_ < var_400_15 + var_400_23 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_15) / var_400_23

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_15 + var_400_23 and arg_397_1.time_ < var_400_15 + var_400_23 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play938041099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 938041099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play938041100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["10144"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.actorSpriteComps10144 == nil then
				arg_401_1.var_.actorSpriteComps10144 = var_404_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_2 = 0.2

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.actorSpriteComps10144 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_404_1 then
							if arg_401_1.isInRecall_ then
								local var_404_4 = Mathf.Lerp(iter_404_1.color.r, arg_401_1.hightColor2.r, var_404_3)
								local var_404_5 = Mathf.Lerp(iter_404_1.color.g, arg_401_1.hightColor2.g, var_404_3)
								local var_404_6 = Mathf.Lerp(iter_404_1.color.b, arg_401_1.hightColor2.b, var_404_3)

								iter_404_1.color = Color.New(var_404_4, var_404_5, var_404_6)
							else
								local var_404_7 = Mathf.Lerp(iter_404_1.color.r, 0.5, var_404_3)

								iter_404_1.color = Color.New(var_404_7, var_404_7, var_404_7)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.actorSpriteComps10144 then
				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_404_3 then
						if arg_401_1.isInRecall_ then
							iter_404_3.color = arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_404_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_401_1.var_.actorSpriteComps10144 = nil
			end

			local var_404_8 = 0
			local var_404_9 = 0.6

			if var_404_8 < arg_401_1.time_ and arg_401_1.time_ <= var_404_8 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_10 = arg_401_1:FormatText(StoryNameCfg[7].name)

				arg_401_1.leftNameTxt_.text = var_404_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_11 = arg_401_1:GetWordFromCfg(938041099)
				local var_404_12 = arg_401_1:FormatText(var_404_11.content)

				arg_401_1.text_.text = var_404_12

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_13 = 24
				local var_404_14 = utf8.len(var_404_12)
				local var_404_15 = var_404_13 <= 0 and var_404_9 or var_404_9 * (var_404_14 / var_404_13)

				if var_404_15 > 0 and var_404_9 < var_404_15 then
					arg_401_1.talkMaxDuration = var_404_15

					if var_404_15 + var_404_8 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_15 + var_404_8
					end
				end

				arg_401_1.text_.text = var_404_12
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_16 = math.max(var_404_9, arg_401_1.talkMaxDuration)

			if var_404_8 <= arg_401_1.time_ and arg_401_1.time_ < var_404_8 + var_404_16 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_8) / var_404_16

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_8 + var_404_16 and arg_401_1.time_ < var_404_8 + var_404_16 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play938041100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 938041100
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
			arg_405_1.auto_ = false
		end

		function arg_405_1.playNext_(arg_407_0)
			arg_405_1.onStoryFinished_()
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["10144"].transform
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 then
				arg_405_1.var_.moveOldPos10144 = var_408_0.localPosition
				var_408_0.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("10144", 7)

				local var_408_2 = var_408_0.childCount

				for iter_408_0 = 0, var_408_2 - 1 do
					local var_408_3 = var_408_0:GetChild(iter_408_0)

					if var_408_3.name == "" or not string.find(var_408_3.name, "split") then
						var_408_3.gameObject:SetActive(true)
					else
						var_408_3.gameObject:SetActive(false)
					end
				end
			end

			local var_408_4 = 0.001

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_4 then
				local var_408_5 = (arg_405_1.time_ - var_408_1) / var_408_4
				local var_408_6 = Vector3.New(0, -2000, 0)

				var_408_0.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10144, var_408_6, var_408_5)
			end

			if arg_405_1.time_ >= var_408_1 + var_408_4 and arg_405_1.time_ < var_408_1 + var_408_4 + arg_408_0 then
				var_408_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_408_7 = 0
			local var_408_8 = 0.65

			if var_408_7 < arg_405_1.time_ and arg_405_1.time_ <= var_408_7 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_9 = arg_405_1:GetWordFromCfg(938041100)
				local var_408_10 = arg_405_1:FormatText(var_408_9.content)

				arg_405_1.text_.text = var_408_10

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_11 = 26
				local var_408_12 = utf8.len(var_408_10)
				local var_408_13 = var_408_11 <= 0 and var_408_8 or var_408_8 * (var_408_12 / var_408_11)

				if var_408_13 > 0 and var_408_8 < var_408_13 then
					arg_405_1.talkMaxDuration = var_408_13

					if var_408_13 + var_408_7 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_13 + var_408_7
					end
				end

				arg_405_1.text_.text = var_408_10
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_14 = math.max(var_408_8, arg_405_1.talkMaxDuration)

			if var_408_7 <= arg_405_1.time_ and arg_405_1.time_ < var_408_7 + var_408_14 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_7) / var_408_14

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_7 + var_408_14 and arg_405_1.time_ < var_408_7 + var_408_14 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
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

		arg_405_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST0114",
		"TextureConfig/Background/ST0119"
	},
	voices = {}
}
