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

			local var_4_4 = 2.024999999999

			if 2.024999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_10 = 1.999999999999
			local var_4_11 = 0.325

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_12:setOnUpdate(nil):setOnComplete(nil)
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

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_13 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(938041001).content)

				arg_1_1.text_.text = var_4_13

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_15 = 13 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 13)

				if (13 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_13) / 13)) > 0 and var_4_11 < var_4_15 then
					arg_1_1.talkMaxDuration = var_4_15
					var_4_10 = var_4_10 + 0.3

					if var_4_15 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_15 + var_4_10
					end
				end

				arg_1_1.text_.text = var_4_13
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_16 = var_4_10 + 0.3
			local var_4_17 = math.max(var_4_11, arg_1_1.talkMaxDuration)

			if var_4_10 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_16) / var_4_17

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
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
			local var_10_0 = 0.6

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
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

				arg_7_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_7_1.callingController_:SetSelectedState("normal")

				arg_7_1.keyicon_.color = Color.New(1, 1, 1)
				arg_7_1.icon_.color = Color.New(1, 1, 1)

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(938041002).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 24 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 24)

				if (24 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 24)) > 0 and var_10_0 < var_10_3 then
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
			local var_14_9000

			if 1 < arg_11_1.time_ and arg_11_1.time_ <= 1 + arg_14_0 then
				arg_11_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_knock", "")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.cswbg_:SetActive(true)

				local var_14_1 = arg_11_1.cswt_:GetComponent("RectTransform")

				arg_11_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_14_1.offsetMin = Vector2.New(400, 200)
				var_14_1.offsetMax = Vector2.New(-400, -200)
				arg_11_1.cswt_.text = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(419195).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.cswt_)

				arg_11_1.cswt_.fontSize = 90
				arg_11_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_11_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_11_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				local var_14_2 = arg_11_1.var_.effectjinrushuimian1

				if not arg_11_1.var_.effectjinrushuimian1 then
					var_14_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_14_2.name = "jinrushuimian1"
					arg_11_1.var_.effectjinrushuimian1 = var_14_2
				else
					var_14_2.transform:SetParent(var_14_9000)
				end

				var_14_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_14_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_11_1.time_ and arg_11_1.time_ <= 2 + arg_14_0 then
				if arg_11_1.var_.effectjinrushuimian1 then
					Object.Destroy(arg_11_1.var_.effectjinrushuimian1)

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
			local var_18_0 = 0.175

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[562].name)

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

				local var_18_1 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(938041004).content)

				arg_15_1.text_.text = var_18_1

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_3 = 7 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 7)

				if (7 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 7)) > 0 and var_18_0 < var_18_3 then
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
			local var_22_0 = 1.075

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[1332].name)

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

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(938041005).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 43 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 43)

				if (43 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 43)) > 0 and var_22_0 < var_22_3 then
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
			local var_26_0 = 0.425

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[32].name)

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

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(938041006).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 17 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 17)

				if (17 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 17)) > 0 and var_26_0 < var_26_3 then
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
			local var_30_0 = 1

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
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

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_1 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(938041007).content)

				arg_27_1.text_.text = var_30_1

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_3 = 40 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 40)

				if (40 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 40)) > 0 and var_30_0 < var_30_3 then
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
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_0 = 4

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				local var_34_1 = Color.New(0.009433985, 0.009433985, 0.009433985)

				var_34_1.a = Mathf.Lerp(0, 1, (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.mask_.color = var_34_1
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				local var_34_2 = Color.New(0.009433985, 0.009433985, 0.009433985)

				var_34_2.a = 1
				arg_31_1.mask_.color = var_34_2
			end

			local var_34_3 = 4.5

			if 4.5 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.mask_.enabled = true
				arg_31_1.mask_.raycastTarget = true

				arg_31_1:SetGaussion(false)
			end

			local var_34_4 = 2

			if var_34_3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_3 + var_34_4 then
				local var_34_5 = Color.New(0.009433985, 0.009433985, 0.009433985)

				var_34_5.a = Mathf.Lerp(1, 0, (arg_31_1.time_ - var_34_3) / var_34_4)
				arg_31_1.mask_.color = var_34_5
			end

			if arg_31_1.time_ >= var_34_3 + var_34_4 and arg_31_1.time_ < var_34_3 + var_34_4 + arg_34_0 then
				local var_34_6 = Color.New(0.009433985, 0.009433985, 0.009433985)

				arg_31_1.mask_.enabled = false
				var_34_6.a = 0
				arg_31_1.mask_.color = var_34_6
			end

			if 4 < arg_31_1.time_ and arg_31_1.time_ <= 4 + arg_34_0 then
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
			if arg_35_1.actors_["108301"] == nil then
				local var_38_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "108301")

				if not isNil(var_38_0) then
					local var_38_1 = Object.Instantiate(var_38_0, arg_35_1.canvasGo_.transform)

					var_38_1.transform:SetSiblingIndex(1)

					var_38_1.name = "108301"
					var_38_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_35_1.actors_["108301"] = var_38_1

					if arg_35_1.isInRecall_ then
						for iter_38_0, iter_38_1 in ipairs((var_38_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_38_1.color = arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_38_2 = arg_35_1.actors_["108301"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.actorSpriteComps108301 == nil then
				arg_35_1.var_.actorSpriteComps108301 = var_38_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_3 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_3 and not isNil(var_38_2) then
				if arg_35_1.var_.actorSpriteComps108301 then
					for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_38_3 then
							if arg_35_1.isInRecall_ then
								iter_38_3.color = Color.New(Mathf.Lerp(iter_38_3.color.r, arg_35_1.hightColor1.r, (arg_35_1.time_ - 0) / var_38_3), Mathf.Lerp(iter_38_3.color.g, arg_35_1.hightColor1.g, (arg_35_1.time_ - 0) / var_38_3), (Mathf.Lerp(iter_38_3.color.b, arg_35_1.hightColor1.b, (arg_35_1.time_ - 0) / var_38_3)))
							else
								local var_38_4 = Mathf.Lerp(iter_38_3.color.r, 1, (arg_35_1.time_ - 0) / var_38_3)

								iter_38_3.color = Color.New(var_38_4, var_38_4, var_38_4)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_3 and arg_35_1.time_ < 0 + var_38_3 + arg_38_0 and not isNil(var_38_2) and arg_35_1.var_.actorSpriteComps108301 then
				for iter_38_4, iter_38_5 in pairs(arg_35_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_38_5 then
						iter_38_5.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_35_1.var_.actorSpriteComps108301 = nil
			end

			local var_38_5 = arg_35_1.actors_["108301"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos108301 = var_38_5.localPosition
				var_38_5.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("108301", 3)

				for iter_38_6 = 0, var_38_5.childCount - 1 do
					local var_38_6 = var_38_5:GetChild(iter_38_6)

					if var_38_6.name == "split_5" or not string.find(var_38_6.name, "split") then
						var_38_6.gameObject:SetActive(true)
					else
						var_38_6.gameObject:SetActive(false)
					end
				end
			end

			local var_38_7 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				var_38_5.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_35_1.time_ - 0) / var_38_7)
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				var_38_5.localPosition = Vector3.New(0, -360, -195)
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				local var_38_8 = arg_35_1.actors_["108301"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_38_8 then
					arg_35_1.var_.alphaOldValue108301 = var_38_8.alpha
					arg_35_1.var_.characterEffect108301 = var_38_8
				end

				arg_35_1.var_.alphaOldValue108301 = 0
			end

			local var_38_9 = 0.5

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_9 then
				if arg_35_1.var_.characterEffect108301 then
					arg_35_1.var_.characterEffect108301.alpha = Mathf.Lerp(arg_35_1.var_.alphaOldValue108301, 1, (arg_35_1.time_ - 0) / var_38_9)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_9 and arg_35_1.time_ < 0 + var_38_9 + arg_38_0 and arg_35_1.var_.characterEffect108301 then
				arg_35_1.var_.characterEffect108301.alpha = 1
			end

			local var_38_10 = 0
			local var_38_11 = 0.85

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_12 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(938041009).content)

				arg_35_1.text_.text = var_38_12

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_14 = 34 <= 0 and var_38_11 or var_38_11 * (utf8.len(var_38_12) / 34)

				if (34 <= 0 and var_38_11 or var_38_11 * (utf8.len(var_38_12) / 34)) > 0 and var_38_11 < var_38_14 then
					arg_35_1.talkMaxDuration = var_38_14

					if var_38_14 + var_38_10 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_10
					end
				end

				arg_35_1.text_.text = var_38_12
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_15 = math.max(var_38_11, arg_35_1.talkMaxDuration)

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_15 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_10) / var_38_15

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_10 + var_38_15 and arg_35_1.time_ < var_38_10 + var_38_15 + arg_38_0 then
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
			if arg_39_1.bgs_.ST0114 == nil then
				local var_42_0 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0114")
				var_42_0.name = "ST0114"
				var_42_0.transform.parent = arg_39_1.stage_.transform
				var_42_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_.ST0114 = var_42_0
			end

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= 2 + arg_42_0 then
				local var_42_1 = arg_39_1.bgs_.ST0114

				arg_39_1.bgs_.ST0114.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_42_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_2 = var_42_1:GetComponent("SpriteRenderer")

				if var_42_2 and var_42_2.sprite then
					local var_42_3 = 2 * (var_42_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_42_1.transform.localScale = Vector3.New(var_42_3 / var_42_2.sprite.bounds.size.y < var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x and var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x or var_42_3 / var_42_2.sprite.bounds.size.y, var_42_3 / var_42_2.sprite.bounds.size.y < var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x and var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x or var_42_3 / var_42_2.sprite.bounds.size.y, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "ST0114" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_4 = 3.999999999999

			if 3.999999999999 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.allBtn_.enabled = false
			end

			if arg_39_1.time_ >= var_42_4 + 0.3 and arg_39_1.time_ < var_42_4 + 0.3 + arg_42_0 then
				arg_39_1.allBtn_.enabled = true
			end

			local var_42_5 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_6 = 2

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_6 then
				local var_42_7 = Color.New(0, 0, 0)

				var_42_7.a = Mathf.Lerp(0, 1, (arg_39_1.time_ - var_42_5) / var_42_6)
				arg_39_1.mask_.color = var_42_7
			end

			if arg_39_1.time_ >= var_42_5 + var_42_6 and arg_39_1.time_ < var_42_5 + var_42_6 + arg_42_0 then
				local var_42_8 = Color.New(0, 0, 0)

				var_42_8.a = 1
				arg_39_1.mask_.color = var_42_8
			end

			local var_42_9 = 2

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_10 = 2

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_10 then
				local var_42_11 = Color.New(0, 0, 0)

				var_42_11.a = Mathf.Lerp(1, 0, (arg_39_1.time_ - var_42_9) / var_42_10)
				arg_39_1.mask_.color = var_42_11
			end

			if arg_39_1.time_ >= var_42_9 + var_42_10 and arg_39_1.time_ < var_42_9 + var_42_10 + arg_42_0 then
				local var_42_12 = Color.New(0, 0, 0)

				arg_39_1.mask_.enabled = false
				var_42_12.a = 0
				arg_39_1.mask_.color = var_42_12
			end

			local var_42_13 = arg_39_1.actors_["108301"]

			if 1.966 < arg_39_1.time_ and arg_39_1.time_ <= 1.966 + arg_42_0 and not isNil(var_42_13) and arg_39_1.var_.actorSpriteComps108301 == nil then
				arg_39_1.var_.actorSpriteComps108301 = var_42_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_14 = 0.034

			if 1.966 <= arg_39_1.time_ and arg_39_1.time_ < 1.966 + var_42_14 and not isNil(var_42_13) then
				if arg_39_1.var_.actorSpriteComps108301 then
					for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_42_3 then
							if arg_39_1.isInRecall_ then
								iter_42_3.color = Color.New(Mathf.Lerp(iter_42_3.color.r, arg_39_1.hightColor2.r, (arg_39_1.time_ - 1.966) / var_42_14), Mathf.Lerp(iter_42_3.color.g, arg_39_1.hightColor2.g, (arg_39_1.time_ - 1.966) / var_42_14), (Mathf.Lerp(iter_42_3.color.b, arg_39_1.hightColor2.b, (arg_39_1.time_ - 1.966) / var_42_14)))
							else
								local var_42_15 = Mathf.Lerp(iter_42_3.color.r, 0.5, (arg_39_1.time_ - 1.966) / var_42_14)

								iter_42_3.color = Color.New(var_42_15, var_42_15, var_42_15)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 1.966 + var_42_14 and arg_39_1.time_ < 1.966 + var_42_14 + arg_42_0 and not isNil(var_42_13) and arg_39_1.var_.actorSpriteComps108301 then
				for iter_42_4, iter_42_5 in pairs(arg_39_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_42_5 then
						iter_42_5.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_39_1.var_.actorSpriteComps108301 = nil
			end

			local var_42_16 = arg_39_1.actors_["108301"].transform

			if 1.966 < arg_39_1.time_ and arg_39_1.time_ <= 1.966 + arg_42_0 then
				arg_39_1.var_.moveOldPos108301 = var_42_16.localPosition
				var_42_16.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("108301", 7)

				for iter_42_6 = 0, var_42_16.childCount - 1 do
					local var_42_17 = var_42_16:GetChild(iter_42_6)

					if var_42_17.name == "" or not string.find(var_42_17.name, "split") then
						var_42_17.gameObject:SetActive(true)
					else
						var_42_17.gameObject:SetActive(false)
					end
				end
			end

			local var_42_18 = 0.001

			if 1.966 <= arg_39_1.time_ and arg_39_1.time_ < 1.966 + var_42_18 then
				var_42_16.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_39_1.time_ - 1.966) / var_42_18)
			end

			if arg_39_1.time_ >= 1.966 + var_42_18 and arg_39_1.time_ < 1.966 + var_42_18 + arg_42_0 then
				var_42_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 2.43333333333333 < arg_39_1.time_ and arg_39_1.time_ <= 2.43333333333333 + arg_42_0 then
				arg_39_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if 2.43333333333333 < arg_39_1.time_ and arg_39_1.time_ <= 2.43333333333333 + arg_42_0 then
				arg_39_1:AudioAction("play", "music", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")

				local var_42_22 = manager.audio:GetAudioName("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern")

				if "" ~= "" then
					if arg_39_1.bgmTxt_.text ~= var_42_22 and arg_39_1.bgmTxt_.text ~= "" then
						if arg_39_1.bgmTxt2_.text ~= "" then
							arg_39_1.bgmTxt_.text = arg_39_1.bgmTxt2_.text
						end

						arg_39_1.bgmTxt2_.text = var_42_22

						arg_39_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_39_1.bgmTxt_.text = var_42_22
						arg_39_1.bgmTxt2_.text = var_42_22
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

			local var_42_23 = 3.999999999999
			local var_42_24 = 1

			if 3.999999999999 < arg_39_1.time_ and arg_39_1.time_ <= var_42_23 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_25 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_25:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_39_1.dialogCg_.alpha = arg_44_0
				end))
				var_42_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_26 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(938041010).content)

				arg_39_1.text_.text = var_42_26

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_28 = 40 <= 0 and var_42_24 or var_42_24 * (utf8.len(var_42_26) / 40)

				if (40 <= 0 and var_42_24 or var_42_24 * (utf8.len(var_42_26) / 40)) > 0 and var_42_24 < var_42_28 then
					arg_39_1.talkMaxDuration = var_42_28
					var_42_23 = var_42_23 + 0.3

					if var_42_28 + var_42_23 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_28 + var_42_23
					end
				end

				arg_39_1.text_.text = var_42_26
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_29 = var_42_23 + 0.3
			local var_42_30 = math.max(var_42_24, arg_39_1.talkMaxDuration)

			if var_42_23 + 0.3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_29 + var_42_30 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_29) / var_42_30

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_29 + var_42_30 and arg_39_1.time_ < var_42_29 + var_42_30 + arg_42_0 then
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
			if arg_46_1.actors_["106603"] == nil then
				local var_49_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_49_0) then
					local var_49_1 = Object.Instantiate(var_49_0, arg_46_1.canvasGo_.transform)

					var_49_1.transform:SetSiblingIndex(1)

					var_49_1.name = "106603"
					var_49_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_46_1.actors_["106603"] = var_49_1

					if arg_46_1.isInRecall_ then
						for iter_49_0, iter_49_1 in ipairs((var_49_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_49_1.color = arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_49_2 = arg_46_1.actors_["106603"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.actorSpriteComps106603 == nil then
				arg_46_1.var_.actorSpriteComps106603 = var_49_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_3 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_3 and not isNil(var_49_2) then
				if arg_46_1.var_.actorSpriteComps106603 then
					for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_49_3 then
							if arg_46_1.isInRecall_ then
								iter_49_3.color = Color.New(Mathf.Lerp(iter_49_3.color.r, arg_46_1.hightColor1.r, (arg_46_1.time_ - 0) / var_49_3), Mathf.Lerp(iter_49_3.color.g, arg_46_1.hightColor1.g, (arg_46_1.time_ - 0) / var_49_3), (Mathf.Lerp(iter_49_3.color.b, arg_46_1.hightColor1.b, (arg_46_1.time_ - 0) / var_49_3)))
							else
								local var_49_4 = Mathf.Lerp(iter_49_3.color.r, 1, (arg_46_1.time_ - 0) / var_49_3)

								iter_49_3.color = Color.New(var_49_4, var_49_4, var_49_4)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_3 and arg_46_1.time_ < 0 + var_49_3 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.actorSpriteComps106603 then
				for iter_49_4, iter_49_5 in pairs(arg_46_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_49_5 then
						iter_49_5.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_46_1.var_.actorSpriteComps106603 = nil
			end

			local var_49_5 = arg_46_1.actors_["106603"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos106603 = var_49_5.localPosition
				var_49_5.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("106603", 3)

				for iter_49_6 = 0, var_49_5.childCount - 1 do
					local var_49_6 = var_49_5:GetChild(iter_49_6)

					if var_49_6.name == "" or not string.find(var_49_6.name, "split") then
						var_49_6.gameObject:SetActive(true)
					else
						var_49_6.gameObject:SetActive(false)
					end
				end
			end

			local var_49_7 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				var_49_5.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_46_1.time_ - 0) / var_49_7)
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				var_49_5.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_49_8 = 0
			local var_49_9 = 0.325

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_8 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_10 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(938041011).content)

				arg_46_1.text_.text = var_49_10

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_12 = 13 <= 0 and var_49_9 or var_49_9 * (utf8.len(var_49_10) / 13)

				if (13 <= 0 and var_49_9 or var_49_9 * (utf8.len(var_49_10) / 13)) > 0 and var_49_9 < var_49_12 then
					arg_46_1.talkMaxDuration = var_49_12

					if var_49_12 + var_49_8 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_8
					end
				end

				arg_46_1.text_.text = var_49_10
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_13 = math.max(var_49_9, arg_46_1.talkMaxDuration)

			if var_49_8 <= arg_46_1.time_ and arg_46_1.time_ < var_49_8 + var_49_13 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_8) / var_49_13

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_8 + var_49_13 and arg_46_1.time_ < var_49_8 + var_49_13 + arg_49_0 then
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
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["106603"]) and arg_50_1.var_.actorSpriteComps106603 == nil then
				arg_50_1.var_.actorSpriteComps106603 = arg_50_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["106603"]) then
				if arg_50_1.var_.actorSpriteComps106603 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_53_1 then
							if arg_50_1.isInRecall_ then
								iter_53_1.color = Color.New(Mathf.Lerp(iter_53_1.color.r, arg_50_1.hightColor2.r, (arg_50_1.time_ - 0) / var_53_0), Mathf.Lerp(iter_53_1.color.g, arg_50_1.hightColor2.g, (arg_50_1.time_ - 0) / var_53_0), (Mathf.Lerp(iter_53_1.color.b, arg_50_1.hightColor2.b, (arg_50_1.time_ - 0) / var_53_0)))
							else
								local var_53_1 = Mathf.Lerp(iter_53_1.color.r, 0.5, (arg_50_1.time_ - 0) / var_53_0)

								iter_53_1.color = Color.New(var_53_1, var_53_1, var_53_1)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["106603"]) and arg_50_1.var_.actorSpriteComps106603 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_53_3 then
						iter_53_3.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_50_1.var_.actorSpriteComps106603 = nil
			end

			local var_53_2 = 0
			local var_53_3 = 0.55

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_2 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[7].name)

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

				local var_53_4 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(938041012).content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_6 = 22 <= 0 and var_53_3 or var_53_3 * (utf8.len(var_53_4) / 22)

				if (22 <= 0 and var_53_3 or var_53_3 * (utf8.len(var_53_4) / 22)) > 0 and var_53_3 < var_53_6 then
					arg_50_1.talkMaxDuration = var_53_6

					if var_53_6 + var_53_2 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_6 + var_53_2
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_7 = math.max(var_53_3, arg_50_1.talkMaxDuration)

			if var_53_2 <= arg_50_1.time_ and arg_50_1.time_ < var_53_2 + var_53_7 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_2) / var_53_7

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_2 + var_53_7 and arg_50_1.time_ < var_53_2 + var_53_7 + arg_53_0 then
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
			if arg_54_1.actors_["128404"] == nil then
				local var_57_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_57_0) then
					local var_57_1 = Object.Instantiate(var_57_0, arg_54_1.canvasGo_.transform)

					var_57_1.transform:SetSiblingIndex(1)

					var_57_1.name = "128404"
					var_57_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_54_1.actors_["128404"] = var_57_1

					if arg_54_1.isInRecall_ then
						for iter_57_0, iter_57_1 in ipairs((var_57_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_57_1.color = arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_57_2 = arg_54_1.actors_["128404"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.actorSpriteComps128404 == nil then
				arg_54_1.var_.actorSpriteComps128404 = var_57_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_3 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_3 and not isNil(var_57_2) then
				if arg_54_1.var_.actorSpriteComps128404 then
					for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_57_3 then
							if arg_54_1.isInRecall_ then
								iter_57_3.color = Color.New(Mathf.Lerp(iter_57_3.color.r, arg_54_1.hightColor1.r, (arg_54_1.time_ - 0) / var_57_3), Mathf.Lerp(iter_57_3.color.g, arg_54_1.hightColor1.g, (arg_54_1.time_ - 0) / var_57_3), (Mathf.Lerp(iter_57_3.color.b, arg_54_1.hightColor1.b, (arg_54_1.time_ - 0) / var_57_3)))
							else
								local var_57_4 = Mathf.Lerp(iter_57_3.color.r, 1, (arg_54_1.time_ - 0) / var_57_3)

								iter_57_3.color = Color.New(var_57_4, var_57_4, var_57_4)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= 0 + var_57_3 and arg_54_1.time_ < 0 + var_57_3 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.actorSpriteComps128404 then
				for iter_57_4, iter_57_5 in pairs(arg_54_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_57_5 then
						iter_57_5.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_54_1.var_.actorSpriteComps128404 = nil
			end

			local var_57_5 = arg_54_1.actors_["128404"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos128404 = var_57_5.localPosition
				var_57_5.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("128404", 2)

				for iter_57_6 = 0, var_57_5.childCount - 1 do
					local var_57_6 = var_57_5:GetChild(iter_57_6)

					if var_57_6.name == "split_4" or not string.find(var_57_6.name, "split") then
						var_57_6.gameObject:SetActive(true)
					else
						var_57_6.gameObject:SetActive(false)
					end
				end
			end

			local var_57_7 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				var_57_5.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_54_1.time_ - 0) / var_57_7)
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				var_57_5.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_57_8 = arg_54_1.actors_["106603"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos106603 = var_57_8.localPosition
				var_57_8.localScale = Vector3.New(1, 1, 1)

				arg_54_1:CheckSpriteTmpPos("106603", 7)

				for iter_57_7 = 0, var_57_8.childCount - 1 do
					local var_57_9 = var_57_8:GetChild(iter_57_7)

					if var_57_9.name == "" or not string.find(var_57_9.name, "split") then
						var_57_9.gameObject:SetActive(true)
					else
						var_57_9.gameObject:SetActive(false)
					end
				end
			end

			local var_57_10 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_10 then
				var_57_8.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_54_1.time_ - 0) / var_57_10)
			end

			if arg_54_1.time_ >= 0 + var_57_10 and arg_54_1.time_ < 0 + var_57_10 + arg_57_0 then
				var_57_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_57_11 = 0
			local var_57_12 = 0.175

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_11 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_13 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(938041013).content)

				arg_54_1.text_.text = var_57_13

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_15 = 7 <= 0 and var_57_12 or var_57_12 * (utf8.len(var_57_13) / 7)

				if (7 <= 0 and var_57_12 or var_57_12 * (utf8.len(var_57_13) / 7)) > 0 and var_57_12 < var_57_15 then
					arg_54_1.talkMaxDuration = var_57_15

					if var_57_15 + var_57_11 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_15 + var_57_11
					end
				end

				arg_54_1.text_.text = var_57_13
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_16 = math.max(var_57_12, arg_54_1.talkMaxDuration)

			if var_57_11 <= arg_54_1.time_ and arg_54_1.time_ < var_57_11 + var_57_16 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_11) / var_57_16

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_11 + var_57_16 and arg_54_1.time_ < var_57_11 + var_57_16 + arg_57_0 then
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
			if arg_58_1.actors_["104902"] == nil then
				local var_61_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104902")

				if not isNil(var_61_0) then
					local var_61_1 = Object.Instantiate(var_61_0, arg_58_1.canvasGo_.transform)

					var_61_1.transform:SetSiblingIndex(1)

					var_61_1.name = "104902"
					var_61_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_58_1.actors_["104902"] = var_61_1

					if arg_58_1.isInRecall_ then
						for iter_61_0, iter_61_1 in ipairs((var_61_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_61_1.color = arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_61_2 = arg_58_1.actors_["104902"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.actorSpriteComps104902 == nil then
				arg_58_1.var_.actorSpriteComps104902 = var_61_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_3 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_3 and not isNil(var_61_2) then
				if arg_58_1.var_.actorSpriteComps104902 then
					for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_61_3 then
							if arg_58_1.isInRecall_ then
								iter_61_3.color = Color.New(Mathf.Lerp(iter_61_3.color.r, arg_58_1.hightColor1.r, (arg_58_1.time_ - 0) / var_61_3), Mathf.Lerp(iter_61_3.color.g, arg_58_1.hightColor1.g, (arg_58_1.time_ - 0) / var_61_3), (Mathf.Lerp(iter_61_3.color.b, arg_58_1.hightColor1.b, (arg_58_1.time_ - 0) / var_61_3)))
							else
								local var_61_4 = Mathf.Lerp(iter_61_3.color.r, 1, (arg_58_1.time_ - 0) / var_61_3)

								iter_61_3.color = Color.New(var_61_4, var_61_4, var_61_4)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_3 and arg_58_1.time_ < 0 + var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.actorSpriteComps104902 then
				for iter_61_4, iter_61_5 in pairs(arg_58_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_61_5 then
						iter_61_5.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_58_1.var_.actorSpriteComps104902 = nil
			end

			local var_61_5 = arg_58_1.actors_["128404"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_5) and arg_58_1.var_.actorSpriteComps128404 == nil then
				arg_58_1.var_.actorSpriteComps128404 = var_61_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_6 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_6 and not isNil(var_61_5) then
				if arg_58_1.var_.actorSpriteComps128404 then
					for iter_61_6, iter_61_7 in pairs(arg_58_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_61_7 then
							if arg_58_1.isInRecall_ then
								iter_61_7.color = Color.New(Mathf.Lerp(iter_61_7.color.r, arg_58_1.hightColor2.r, (arg_58_1.time_ - 0) / var_61_6), Mathf.Lerp(iter_61_7.color.g, arg_58_1.hightColor2.g, (arg_58_1.time_ - 0) / var_61_6), (Mathf.Lerp(iter_61_7.color.b, arg_58_1.hightColor2.b, (arg_58_1.time_ - 0) / var_61_6)))
							else
								local var_61_7 = Mathf.Lerp(iter_61_7.color.r, 0.5, (arg_58_1.time_ - 0) / var_61_6)

								iter_61_7.color = Color.New(var_61_7, var_61_7, var_61_7)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_6 and arg_58_1.time_ < 0 + var_61_6 + arg_61_0 and not isNil(var_61_5) and arg_58_1.var_.actorSpriteComps128404 then
				for iter_61_8, iter_61_9 in pairs(arg_58_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_61_9 then
						iter_61_9.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_58_1.var_.actorSpriteComps128404 = nil
			end

			local var_61_8 = arg_58_1.actors_["104902"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos104902 = var_61_8.localPosition
				var_61_8.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("104902", 4)

				for iter_61_10 = 0, var_61_8.childCount - 1 do
					local var_61_9 = var_61_8:GetChild(iter_61_10)

					if var_61_9.name == "split_2" or not string.find(var_61_9.name, "split") then
						var_61_9.gameObject:SetActive(true)
					else
						var_61_9.gameObject:SetActive(false)
					end
				end
			end

			local var_61_10 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_10 then
				var_61_8.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos104902, Vector3.New(390, -335, -360), (arg_58_1.time_ - 0) / var_61_10)
			end

			if arg_58_1.time_ >= 0 + var_61_10 and arg_58_1.time_ < 0 + var_61_10 + arg_61_0 then
				var_61_8.localPosition = Vector3.New(390, -335, -360)
			end

			local var_61_11 = 0
			local var_61_12 = 0.475

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_11 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_13 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(938041014).content)

				arg_58_1.text_.text = var_61_13

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_15 = 19 <= 0 and var_61_12 or var_61_12 * (utf8.len(var_61_13) / 19)

				if (19 <= 0 and var_61_12 or var_61_12 * (utf8.len(var_61_13) / 19)) > 0 and var_61_12 < var_61_15 then
					arg_58_1.talkMaxDuration = var_61_15

					if var_61_15 + var_61_11 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_15 + var_61_11
					end
				end

				arg_58_1.text_.text = var_61_13
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_12, arg_58_1.talkMaxDuration)

			if var_61_11 <= arg_58_1.time_ and arg_58_1.time_ < var_61_11 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_11) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_11 + var_61_16 and arg_58_1.time_ < var_61_11 + var_61_16 + arg_61_0 then
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
			local var_65_0 = 1.15

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(938041015).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 46 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 46)

				if (46 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 46)) > 0 and var_65_0 < var_65_3 then
					arg_62_1.talkMaxDuration = var_65_3

					if var_65_3 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_3 + 0
					end
				end

				arg_62_1.text_.text = var_65_1
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_4 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_4

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
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
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["104902"]) and arg_66_1.var_.actorSpriteComps104902 == nil then
				arg_66_1.var_.actorSpriteComps104902 = arg_66_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["104902"]) then
				if arg_66_1.var_.actorSpriteComps104902 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								iter_69_1.color = Color.New(Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor2.r, (arg_66_1.time_ - 0) / var_69_0), Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor2.g, (arg_66_1.time_ - 0) / var_69_0), (Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor2.b, (arg_66_1.time_ - 0) / var_69_0)))
							else
								local var_69_1 = Mathf.Lerp(iter_69_1.color.r, 0.5, (arg_66_1.time_ - 0) / var_69_0)

								iter_69_1.color = Color.New(var_69_1, var_69_1, var_69_1)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["104902"]) and arg_66_1.var_.actorSpriteComps104902 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_69_3 then
						iter_69_3.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_66_1.var_.actorSpriteComps104902 = nil
			end

			local var_69_2 = 0
			local var_69_3 = 0.225

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_2 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[7].name)

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

				local var_69_4 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(938041016).content)

				arg_66_1.text_.text = var_69_4

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_6 = 9 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_4) / 9)

				if (9 <= 0 and var_69_3 or var_69_3 * (utf8.len(var_69_4) / 9)) > 0 and var_69_3 < var_69_6 then
					arg_66_1.talkMaxDuration = var_69_6

					if var_69_6 + var_69_2 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_2
					end
				end

				arg_66_1.text_.text = var_69_4
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_3, arg_66_1.talkMaxDuration)

			if var_69_2 <= arg_66_1.time_ and arg_66_1.time_ < var_69_2 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_2) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_2 + var_69_7 and arg_66_1.time_ < var_69_2 + var_69_7 + arg_69_0 then
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
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["108301"]) and arg_70_1.var_.actorSpriteComps108301 == nil then
				arg_70_1.var_.actorSpriteComps108301 = arg_70_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["108301"]) then
				if arg_70_1.var_.actorSpriteComps108301 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								iter_73_1.color = Color.New(Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor1.r, (arg_70_1.time_ - 0) / var_73_0), Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor1.g, (arg_70_1.time_ - 0) / var_73_0), (Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor1.b, (arg_70_1.time_ - 0) / var_73_0)))
							else
								local var_73_1 = Mathf.Lerp(iter_73_1.color.r, 1, (arg_70_1.time_ - 0) / var_73_0)

								iter_73_1.color = Color.New(var_73_1, var_73_1, var_73_1)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["108301"]) and arg_70_1.var_.actorSpriteComps108301 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_73_3 then
						iter_73_3.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_70_1.var_.actorSpriteComps108301 = nil
			end

			local var_73_2 = arg_70_1.actors_["108301"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos108301 = var_73_2.localPosition
				var_73_2.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("108301", 3)

				for iter_73_4 = 0, var_73_2.childCount - 1 do
					local var_73_3 = var_73_2:GetChild(iter_73_4)

					if var_73_3.name == "split_2" or not string.find(var_73_3.name, "split") then
						var_73_3.gameObject:SetActive(true)
					else
						var_73_3.gameObject:SetActive(false)
					end
				end
			end

			local var_73_4 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				var_73_2.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos108301, Vector3.New(0, -360, -195), (arg_70_1.time_ - 0) / var_73_4)
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				var_73_2.localPosition = Vector3.New(0, -360, -195)
			end

			local var_73_5 = arg_70_1.actors_["104902"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos104902 = var_73_5.localPosition
				var_73_5.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("104902", 7)

				for iter_73_5 = 0, var_73_5.childCount - 1 do
					local var_73_6 = var_73_5:GetChild(iter_73_5)

					if var_73_6.name == "" or not string.find(var_73_6.name, "split") then
						var_73_6.gameObject:SetActive(true)
					else
						var_73_6.gameObject:SetActive(false)
					end
				end
			end

			local var_73_7 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				var_73_5.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_70_1.time_ - 0) / var_73_7)
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				var_73_5.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_73_8 = arg_70_1.actors_["128404"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos128404 = var_73_8.localPosition
				var_73_8.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("128404", 7)

				for iter_73_6 = 0, var_73_8.childCount - 1 do
					local var_73_9 = var_73_8:GetChild(iter_73_6)

					if var_73_9.name == "" or not string.find(var_73_9.name, "split") then
						var_73_9.gameObject:SetActive(true)
					else
						var_73_9.gameObject:SetActive(false)
					end
				end
			end

			local var_73_10 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_10 then
				var_73_8.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_70_1.time_ - 0) / var_73_10)
			end

			if arg_70_1.time_ >= 0 + var_73_10 and arg_70_1.time_ < 0 + var_73_10 + arg_73_0 then
				var_73_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_73_11 = 0
			local var_73_12 = 0.55

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_13 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(938041017).content)

				arg_70_1.text_.text = var_73_13

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_15 = 22 <= 0 and var_73_12 or var_73_12 * (utf8.len(var_73_13) / 22)

				if (22 <= 0 and var_73_12 or var_73_12 * (utf8.len(var_73_13) / 22)) > 0 and var_73_12 < var_73_15 then
					arg_70_1.talkMaxDuration = var_73_15

					if var_73_15 + var_73_11 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_15 + var_73_11
					end
				end

				arg_70_1.text_.text = var_73_13
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_16 = math.max(var_73_12, arg_70_1.talkMaxDuration)

			if var_73_11 <= arg_70_1.time_ and arg_70_1.time_ < var_73_11 + var_73_16 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_11) / var_73_16

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_11 + var_73_16 and arg_70_1.time_ < var_73_11 + var_73_16 + arg_73_0 then
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
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["108301"]) and arg_74_1.var_.actorSpriteComps108301 == nil then
				arg_74_1.var_.actorSpriteComps108301 = arg_74_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_77_0 = 0.2

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["108301"]) then
				if arg_74_1.var_.actorSpriteComps108301 then
					for iter_77_0, iter_77_1 in pairs(arg_74_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_77_1 then
							if arg_74_1.isInRecall_ then
								iter_77_1.color = Color.New(Mathf.Lerp(iter_77_1.color.r, arg_74_1.hightColor2.r, (arg_74_1.time_ - 0) / var_77_0), Mathf.Lerp(iter_77_1.color.g, arg_74_1.hightColor2.g, (arg_74_1.time_ - 0) / var_77_0), (Mathf.Lerp(iter_77_1.color.b, arg_74_1.hightColor2.b, (arg_74_1.time_ - 0) / var_77_0)))
							else
								local var_77_1 = Mathf.Lerp(iter_77_1.color.r, 0.5, (arg_74_1.time_ - 0) / var_77_0)

								iter_77_1.color = Color.New(var_77_1, var_77_1, var_77_1)
							end
						end
					end
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["108301"]) and arg_74_1.var_.actorSpriteComps108301 then
				for iter_77_2, iter_77_3 in pairs(arg_74_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_77_3 then
						iter_77_3.color = arg_74_1.isInRecall_ and (arg_74_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_74_1.var_.actorSpriteComps108301 = nil
			end

			local var_77_2 = 0
			local var_77_3 = 0.5

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[7].name)

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

				local var_77_4 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(938041018).content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_6 = 20 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 20)

				if (20 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_4) / 20)) > 0 and var_77_3 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_7 and arg_74_1.time_ < var_77_2 + var_77_7 + arg_77_0 then
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
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos108301 = arg_78_1.actors_["108301"].transform.localPosition
				arg_78_1.actors_["108301"].transform.localScale = Vector3.New(1, 1, 1)

				arg_78_1:CheckSpriteTmpPos("108301", 7)

				for iter_81_0 = 0, arg_78_1.actors_["108301"].transform.childCount - 1 do
					local var_81_0 = arg_78_1.actors_["108301"].transform:GetChild(iter_81_0)

					if var_81_0.name == "" or not string.find(var_81_0.name, "split") then
						var_81_0.gameObject:SetActive(true)
					else
						var_81_0.gameObject:SetActive(false)
					end
				end
			end

			local var_81_1 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_1 then
				arg_78_1.actors_["108301"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_78_1.time_ - 0) / var_81_1)
			end

			if arg_78_1.time_ >= 0 + var_81_1 and arg_78_1.time_ < 0 + var_81_1 + arg_81_0 then
				arg_78_1.actors_["108301"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_78_1.time_ and arg_78_1.time_ <= 1 + arg_81_0 then
				arg_78_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_wood", "")
			end

			local var_81_3 = 0
			local var_81_4 = 0.975

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_3 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_5 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(938041019).content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 39 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 39)

				if (39 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 39)) > 0 and var_81_4 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_3 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_3
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_8 = math.max(var_81_4, arg_78_1.talkMaxDuration)

			if var_81_3 <= arg_78_1.time_ and arg_78_1.time_ < var_81_3 + var_81_8 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_3) / var_81_8

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_3 + var_81_8 and arg_78_1.time_ < var_81_3 + var_81_8 + arg_81_0 then
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
			if arg_82_1.actors_["10183"] == nil then
				local var_85_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10183")

				if not isNil(var_85_0) then
					local var_85_1 = Object.Instantiate(var_85_0, arg_82_1.canvasGo_.transform)

					var_85_1.transform:SetSiblingIndex(1)

					var_85_1.name = "10183"
					var_85_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_82_1.actors_["10183"] = var_85_1

					if arg_82_1.isInRecall_ then
						for iter_85_0, iter_85_1 in ipairs((var_85_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_85_1.color = arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_85_2 = arg_82_1.actors_["10183"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.actorSpriteComps10183 == nil then
				arg_82_1.var_.actorSpriteComps10183 = var_85_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_3 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_3 and not isNil(var_85_2) then
				if arg_82_1.var_.actorSpriteComps10183 then
					for iter_85_2, iter_85_3 in pairs(arg_82_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_85_3 then
							if arg_82_1.isInRecall_ then
								iter_85_3.color = Color.New(Mathf.Lerp(iter_85_3.color.r, arg_82_1.hightColor1.r, (arg_82_1.time_ - 0) / var_85_3), Mathf.Lerp(iter_85_3.color.g, arg_82_1.hightColor1.g, (arg_82_1.time_ - 0) / var_85_3), (Mathf.Lerp(iter_85_3.color.b, arg_82_1.hightColor1.b, (arg_82_1.time_ - 0) / var_85_3)))
							else
								local var_85_4 = Mathf.Lerp(iter_85_3.color.r, 1, (arg_82_1.time_ - 0) / var_85_3)

								iter_85_3.color = Color.New(var_85_4, var_85_4, var_85_4)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_3 and arg_82_1.time_ < 0 + var_85_3 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.actorSpriteComps10183 then
				for iter_85_4, iter_85_5 in pairs(arg_82_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_85_5 then
						iter_85_5.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_82_1.var_.actorSpriteComps10183 = nil
			end

			local var_85_5 = arg_82_1.actors_["10183"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos10183 = var_85_5.localPosition
				var_85_5.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("10183", 3)

				for iter_85_6 = 0, var_85_5.childCount - 1 do
					local var_85_6 = var_85_5:GetChild(iter_85_6)

					if var_85_6.name == "" or not string.find(var_85_6.name, "split") then
						var_85_6.gameObject:SetActive(true)
					else
						var_85_6.gameObject:SetActive(false)
					end
				end
			end

			local var_85_7 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				var_85_5.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_82_1.time_ - 0) / var_85_7)
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				var_85_5.localPosition = Vector3.New(0, -475, -325)
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				local var_85_8 = arg_82_1.actors_["10183"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_85_8 then
					arg_82_1.var_.alphaOldValue10183 = var_85_8.alpha
					arg_82_1.var_.characterEffect10183 = var_85_8
				end

				arg_82_1.var_.alphaOldValue10183 = 0
			end

			local var_85_9 = 0.5

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_9 then
				if arg_82_1.var_.characterEffect10183 then
					arg_82_1.var_.characterEffect10183.alpha = Mathf.Lerp(arg_82_1.var_.alphaOldValue10183, 1, (arg_82_1.time_ - 0) / var_85_9)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_9 and arg_82_1.time_ < 0 + var_85_9 + arg_85_0 and arg_82_1.var_.characterEffect10183 then
				arg_82_1.var_.characterEffect10183.alpha = 1
			end

			local var_85_10 = 0
			local var_85_11 = 0.475

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_12 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(938041020).content)

				arg_82_1.text_.text = var_85_12

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_14 = 19 <= 0 and var_85_11 or var_85_11 * (utf8.len(var_85_12) / 19)

				if (19 <= 0 and var_85_11 or var_85_11 * (utf8.len(var_85_12) / 19)) > 0 and var_85_11 < var_85_14 then
					arg_82_1.talkMaxDuration = var_85_14

					if var_85_14 + var_85_10 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_14 + var_85_10
					end
				end

				arg_82_1.text_.text = var_85_12
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_15 = math.max(var_85_11, arg_82_1.talkMaxDuration)

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_15 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_10) / var_85_15

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_10 + var_85_15 and arg_82_1.time_ < var_85_10 + var_85_15 + arg_85_0 then
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
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["10183"]) and arg_86_1.var_.actorSpriteComps10183 == nil then
				arg_86_1.var_.actorSpriteComps10183 = arg_86_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_0 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["10183"]) then
				if arg_86_1.var_.actorSpriteComps10183 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								iter_89_1.color = Color.New(Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor2.r, (arg_86_1.time_ - 0) / var_89_0), Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor2.g, (arg_86_1.time_ - 0) / var_89_0), (Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor2.b, (arg_86_1.time_ - 0) / var_89_0)))
							else
								local var_89_1 = Mathf.Lerp(iter_89_1.color.r, 0.5, (arg_86_1.time_ - 0) / var_89_0)

								iter_89_1.color = Color.New(var_89_1, var_89_1, var_89_1)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["10183"]) and arg_86_1.var_.actorSpriteComps10183 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_86_1.var_.actorSpriteComps10183 = nil
			end

			local var_89_2 = arg_86_1.actors_["10183"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10183 = var_89_2.localPosition
				var_89_2.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("10183", 7)

				for iter_89_4 = 0, var_89_2.childCount - 1 do
					local var_89_3 = var_89_2:GetChild(iter_89_4)

					if var_89_3.name == "" or not string.find(var_89_3.name, "split") then
						var_89_3.gameObject:SetActive(true)
					else
						var_89_3.gameObject:SetActive(false)
					end
				end
			end

			local var_89_4 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				var_89_2.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_86_1.time_ - 0) / var_89_4)
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				var_89_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_89_5 = 0
			local var_89_6 = 1.5

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_7 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(938041021).content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 60 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_7) / 60)

				if (60 <= 0 and var_89_6 or var_89_6 * (utf8.len(var_89_7) / 60)) > 0 and var_89_6 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_5 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_5
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_10 = math.max(var_89_6, arg_86_1.talkMaxDuration)

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_10 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_5) / var_89_10

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_5 + var_89_10 and arg_86_1.time_ < var_89_5 + var_89_10 + arg_89_0 then
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
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["128404"]) and arg_90_1.var_.actorSpriteComps128404 == nil then
				arg_90_1.var_.actorSpriteComps128404 = arg_90_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_0 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["128404"]) then
				if arg_90_1.var_.actorSpriteComps128404 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								iter_93_1.color = Color.New(Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, (arg_90_1.time_ - 0) / var_93_0), Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, (arg_90_1.time_ - 0) / var_93_0), (Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, (arg_90_1.time_ - 0) / var_93_0)))
							else
								local var_93_1 = Mathf.Lerp(iter_93_1.color.r, 1, (arg_90_1.time_ - 0) / var_93_0)

								iter_93_1.color = Color.New(var_93_1, var_93_1, var_93_1)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["128404"]) and arg_90_1.var_.actorSpriteComps128404 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_90_1.var_.actorSpriteComps128404 = nil
			end

			local var_93_2 = arg_90_1.actors_["128404"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos128404 = var_93_2.localPosition
				var_93_2.localScale = Vector3.New(1, 1, 1)

				arg_90_1:CheckSpriteTmpPos("128404", 3)

				for iter_93_4 = 0, var_93_2.childCount - 1 do
					local var_93_3 = var_93_2:GetChild(iter_93_4)

					if var_93_3.name == "split_4" or not string.find(var_93_3.name, "split") then
						var_93_3.gameObject:SetActive(true)
					else
						var_93_3.gameObject:SetActive(false)
					end
				end
			end

			local var_93_4 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				var_93_2.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_90_1.time_ - 0) / var_93_4)
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				var_93_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_93_5 = 0
			local var_93_6 = 0.5

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_7 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(938041022).content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 20 <= 0 and var_93_6 or var_93_6 * (utf8.len(var_93_7) / 20)

				if (20 <= 0 and var_93_6 or var_93_6 * (utf8.len(var_93_7) / 20)) > 0 and var_93_6 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_5 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_5
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_6, arg_90_1.talkMaxDuration)

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_5) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_5 + var_93_10 and arg_90_1.time_ < var_93_5 + var_93_10 + arg_93_0 then
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
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["128404"]) and arg_94_1.var_.actorSpriteComps128404 == nil then
				arg_94_1.var_.actorSpriteComps128404 = arg_94_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_0 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["128404"]) then
				if arg_94_1.var_.actorSpriteComps128404 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								iter_97_1.color = Color.New(Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor2.r, (arg_94_1.time_ - 0) / var_97_0), Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor2.g, (arg_94_1.time_ - 0) / var_97_0), (Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor2.b, (arg_94_1.time_ - 0) / var_97_0)))
							else
								local var_97_1 = Mathf.Lerp(iter_97_1.color.r, 0.5, (arg_94_1.time_ - 0) / var_97_0)

								iter_97_1.color = Color.New(var_97_1, var_97_1, var_97_1)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["128404"]) and arg_94_1.var_.actorSpriteComps128404 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_94_1.var_.actorSpriteComps128404 = nil
			end

			local var_97_2 = 0
			local var_97_3 = 0.7

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[7].name)

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

				local var_97_4 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(938041023).content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_6 = 28 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_4) / 28)

				if (28 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_4) / 28)) > 0 and var_97_3 < var_97_6 then
					arg_94_1.talkMaxDuration = var_97_6

					if var_97_6 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_2
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_3, arg_94_1.talkMaxDuration)

			if var_97_2 <= arg_94_1.time_ and arg_94_1.time_ < var_97_2 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_2) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_2 + var_97_7 and arg_94_1.time_ < var_97_2 + var_97_7 + arg_97_0 then
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
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["128404"]) and arg_98_1.var_.actorSpriteComps128404 == nil then
				arg_98_1.var_.actorSpriteComps128404 = arg_98_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_101_0 = 0.2

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["128404"]) then
				if arg_98_1.var_.actorSpriteComps128404 then
					for iter_101_0, iter_101_1 in pairs(arg_98_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_101_1 then
							if arg_98_1.isInRecall_ then
								iter_101_1.color = Color.New(Mathf.Lerp(iter_101_1.color.r, arg_98_1.hightColor1.r, (arg_98_1.time_ - 0) / var_101_0), Mathf.Lerp(iter_101_1.color.g, arg_98_1.hightColor1.g, (arg_98_1.time_ - 0) / var_101_0), (Mathf.Lerp(iter_101_1.color.b, arg_98_1.hightColor1.b, (arg_98_1.time_ - 0) / var_101_0)))
							else
								local var_101_1 = Mathf.Lerp(iter_101_1.color.r, 1, (arg_98_1.time_ - 0) / var_101_0)

								iter_101_1.color = Color.New(var_101_1, var_101_1, var_101_1)
							end
						end
					end
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["128404"]) and arg_98_1.var_.actorSpriteComps128404 then
				for iter_101_2, iter_101_3 in pairs(arg_98_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_101_3 then
						iter_101_3.color = arg_98_1.isInRecall_ and (arg_98_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_98_1.var_.actorSpriteComps128404 = nil
			end

			local var_101_2 = arg_98_1.actors_["128404"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos128404 = var_101_2.localPosition
				var_101_2.localScale = Vector3.New(1, 1, 1)

				arg_98_1:CheckSpriteTmpPos("128404", 3)

				for iter_101_4 = 0, var_101_2.childCount - 1 do
					local var_101_3 = var_101_2:GetChild(iter_101_4)

					if var_101_3.name == "split_5" or not string.find(var_101_3.name, "split") then
						var_101_3.gameObject:SetActive(true)
					else
						var_101_3.gameObject:SetActive(false)
					end
				end
			end

			local var_101_4 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				var_101_2.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_98_1.time_ - 0) / var_101_4)
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				var_101_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_101_5 = 0
			local var_101_6 = 0.575

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_7 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(938041024).content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 23 <= 0 and var_101_6 or var_101_6 * (utf8.len(var_101_7) / 23)

				if (23 <= 0 and var_101_6 or var_101_6 * (utf8.len(var_101_7) / 23)) > 0 and var_101_6 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_5
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_6, arg_98_1.talkMaxDuration)

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_5) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_5 + var_101_10 and arg_98_1.time_ < var_101_5 + var_101_10 + arg_101_0 then
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
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["106603"]) and arg_102_1.var_.actorSpriteComps106603 == nil then
				arg_102_1.var_.actorSpriteComps106603 = arg_102_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_0 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["106603"]) then
				if arg_102_1.var_.actorSpriteComps106603 then
					for iter_105_0, iter_105_1 in pairs(arg_102_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_105_1 then
							if arg_102_1.isInRecall_ then
								iter_105_1.color = Color.New(Mathf.Lerp(iter_105_1.color.r, arg_102_1.hightColor1.r, (arg_102_1.time_ - 0) / var_105_0), Mathf.Lerp(iter_105_1.color.g, arg_102_1.hightColor1.g, (arg_102_1.time_ - 0) / var_105_0), (Mathf.Lerp(iter_105_1.color.b, arg_102_1.hightColor1.b, (arg_102_1.time_ - 0) / var_105_0)))
							else
								local var_105_1 = Mathf.Lerp(iter_105_1.color.r, 1, (arg_102_1.time_ - 0) / var_105_0)

								iter_105_1.color = Color.New(var_105_1, var_105_1, var_105_1)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["106603"]) and arg_102_1.var_.actorSpriteComps106603 then
				for iter_105_2, iter_105_3 in pairs(arg_102_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_105_3 then
						iter_105_3.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_102_1.var_.actorSpriteComps106603 = nil
			end

			local var_105_2 = arg_102_1.actors_["128404"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.actorSpriteComps128404 == nil then
				arg_102_1.var_.actorSpriteComps128404 = var_105_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_105_3 = 0.2

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.actorSpriteComps128404 then
					for iter_105_4, iter_105_5 in pairs(arg_102_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_105_5 then
							if arg_102_1.isInRecall_ then
								iter_105_5.color = Color.New(Mathf.Lerp(iter_105_5.color.r, arg_102_1.hightColor2.r, (arg_102_1.time_ - 0) / var_105_3), Mathf.Lerp(iter_105_5.color.g, arg_102_1.hightColor2.g, (arg_102_1.time_ - 0) / var_105_3), (Mathf.Lerp(iter_105_5.color.b, arg_102_1.hightColor2.b, (arg_102_1.time_ - 0) / var_105_3)))
							else
								local var_105_4 = Mathf.Lerp(iter_105_5.color.r, 0.5, (arg_102_1.time_ - 0) / var_105_3)

								iter_105_5.color = Color.New(var_105_4, var_105_4, var_105_4)
							end
						end
					end
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.actorSpriteComps128404 then
				for iter_105_6, iter_105_7 in pairs(arg_102_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_105_7 then
						iter_105_7.color = arg_102_1.isInRecall_ and (arg_102_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_102_1.var_.actorSpriteComps128404 = nil
			end

			local var_105_5 = arg_102_1.actors_["106603"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos106603 = var_105_5.localPosition
				var_105_5.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("106603", 2)

				for iter_105_8 = 0, var_105_5.childCount - 1 do
					local var_105_6 = var_105_5:GetChild(iter_105_8)

					if var_105_6.name == "" or not string.find(var_105_6.name, "split") then
						var_105_6.gameObject:SetActive(true)
					else
						var_105_6.gameObject:SetActive(false)
					end
				end
			end

			local var_105_7 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				var_105_5.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_102_1.time_ - 0) / var_105_7)
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				var_105_5.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_105_8 = arg_102_1.actors_["128404"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos128404 = var_105_8.localPosition
				var_105_8.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("128404", 7)

				for iter_105_9 = 0, var_105_8.childCount - 1 do
					local var_105_9 = var_105_8:GetChild(iter_105_9)

					if var_105_9.name == "" or not string.find(var_105_9.name, "split") then
						var_105_9.gameObject:SetActive(true)
					else
						var_105_9.gameObject:SetActive(false)
					end
				end
			end

			local var_105_10 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_10 then
				var_105_8.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_102_1.time_ - 0) / var_105_10)
			end

			if arg_102_1.time_ >= 0 + var_105_10 and arg_102_1.time_ < 0 + var_105_10 + arg_105_0 then
				var_105_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_105_11 = 0
			local var_105_12 = 0.325

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_13 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(938041025).content)

				arg_102_1.text_.text = var_105_13

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_15 = 13 <= 0 and var_105_12 or var_105_12 * (utf8.len(var_105_13) / 13)

				if (13 <= 0 and var_105_12 or var_105_12 * (utf8.len(var_105_13) / 13)) > 0 and var_105_12 < var_105_15 then
					arg_102_1.talkMaxDuration = var_105_15

					if var_105_15 + var_105_11 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_15 + var_105_11
					end
				end

				arg_102_1.text_.text = var_105_13
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_12, arg_102_1.talkMaxDuration)

			if var_105_11 <= arg_102_1.time_ and arg_102_1.time_ < var_105_11 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_11) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_11 + var_105_16 and arg_102_1.time_ < var_105_11 + var_105_16 + arg_105_0 then
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
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["108301"]) and arg_106_1.var_.actorSpriteComps108301 == nil then
				arg_106_1.var_.actorSpriteComps108301 = arg_106_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_0 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["108301"]) then
				if arg_106_1.var_.actorSpriteComps108301 then
					for iter_109_0, iter_109_1 in pairs(arg_106_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_109_1 then
							if arg_106_1.isInRecall_ then
								iter_109_1.color = Color.New(Mathf.Lerp(iter_109_1.color.r, arg_106_1.hightColor1.r, (arg_106_1.time_ - 0) / var_109_0), Mathf.Lerp(iter_109_1.color.g, arg_106_1.hightColor1.g, (arg_106_1.time_ - 0) / var_109_0), (Mathf.Lerp(iter_109_1.color.b, arg_106_1.hightColor1.b, (arg_106_1.time_ - 0) / var_109_0)))
							else
								local var_109_1 = Mathf.Lerp(iter_109_1.color.r, 1, (arg_106_1.time_ - 0) / var_109_0)

								iter_109_1.color = Color.New(var_109_1, var_109_1, var_109_1)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["108301"]) and arg_106_1.var_.actorSpriteComps108301 then
				for iter_109_2, iter_109_3 in pairs(arg_106_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_109_3 then
						iter_109_3.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_106_1.var_.actorSpriteComps108301 = nil
			end

			local var_109_2 = arg_106_1.actors_["106603"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.actorSpriteComps106603 == nil then
				arg_106_1.var_.actorSpriteComps106603 = var_109_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_109_3 = 0.2

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.actorSpriteComps106603 then
					for iter_109_4, iter_109_5 in pairs(arg_106_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_109_5 then
							if arg_106_1.isInRecall_ then
								iter_109_5.color = Color.New(Mathf.Lerp(iter_109_5.color.r, arg_106_1.hightColor2.r, (arg_106_1.time_ - 0) / var_109_3), Mathf.Lerp(iter_109_5.color.g, arg_106_1.hightColor2.g, (arg_106_1.time_ - 0) / var_109_3), (Mathf.Lerp(iter_109_5.color.b, arg_106_1.hightColor2.b, (arg_106_1.time_ - 0) / var_109_3)))
							else
								local var_109_4 = Mathf.Lerp(iter_109_5.color.r, 0.5, (arg_106_1.time_ - 0) / var_109_3)

								iter_109_5.color = Color.New(var_109_4, var_109_4, var_109_4)
							end
						end
					end
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.actorSpriteComps106603 then
				for iter_109_6, iter_109_7 in pairs(arg_106_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_109_7 then
						iter_109_7.color = arg_106_1.isInRecall_ and (arg_106_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_106_1.var_.actorSpriteComps106603 = nil
			end

			local var_109_5 = arg_106_1.actors_["108301"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos108301 = var_109_5.localPosition
				var_109_5.localScale = Vector3.New(1, 1, 1)

				arg_106_1:CheckSpriteTmpPos("108301", 4)

				for iter_109_8 = 0, var_109_5.childCount - 1 do
					local var_109_6 = var_109_5:GetChild(iter_109_8)

					if var_109_6.name == "split_5" or not string.find(var_109_6.name, "split") then
						var_109_6.gameObject:SetActive(true)
					else
						var_109_6.gameObject:SetActive(false)
					end
				end
			end

			local var_109_7 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				var_109_5.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_106_1.time_ - 0) / var_109_7)
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				var_109_5.localPosition = Vector3.New(460, -360, -195)
			end

			local var_109_8 = 0
			local var_109_9 = 0.675

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_10 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(938041026).content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_12 = 27 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_10) / 27)

				if (27 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_10) / 27)) > 0 and var_109_9 < var_109_12 then
					arg_106_1.talkMaxDuration = var_109_12

					if var_109_12 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_8
					end
				end

				arg_106_1.text_.text = var_109_10
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_13 = math.max(var_109_9, arg_106_1.talkMaxDuration)

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_13 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_8) / var_109_13

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_8 + var_109_13 and arg_106_1.time_ < var_109_8 + var_109_13 + arg_109_0 then
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
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["108301"]) and arg_110_1.var_.actorSpriteComps108301 == nil then
				arg_110_1.var_.actorSpriteComps108301 = arg_110_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_113_0 = 0.2

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["108301"]) then
				if arg_110_1.var_.actorSpriteComps108301 then
					for iter_113_0, iter_113_1 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_113_1 then
							if arg_110_1.isInRecall_ then
								iter_113_1.color = Color.New(Mathf.Lerp(iter_113_1.color.r, arg_110_1.hightColor2.r, (arg_110_1.time_ - 0) / var_113_0), Mathf.Lerp(iter_113_1.color.g, arg_110_1.hightColor2.g, (arg_110_1.time_ - 0) / var_113_0), (Mathf.Lerp(iter_113_1.color.b, arg_110_1.hightColor2.b, (arg_110_1.time_ - 0) / var_113_0)))
							else
								local var_113_1 = Mathf.Lerp(iter_113_1.color.r, 0.5, (arg_110_1.time_ - 0) / var_113_0)

								iter_113_1.color = Color.New(var_113_1, var_113_1, var_113_1)
							end
						end
					end
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["108301"]) and arg_110_1.var_.actorSpriteComps108301 then
				for iter_113_2, iter_113_3 in pairs(arg_110_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_113_3 then
						iter_113_3.color = arg_110_1.isInRecall_ and (arg_110_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_110_1.var_.actorSpriteComps108301 = nil
			end

			local var_113_2 = 0
			local var_113_3 = 0.5

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

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

				local var_113_4 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(938041027).content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_6 = 20 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_4) / 20)

				if (20 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_4) / 20)) > 0 and var_113_3 < var_113_6 then
					arg_110_1.talkMaxDuration = var_113_6

					if var_113_6 + var_113_2 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_6 + var_113_2
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_3, arg_110_1.talkMaxDuration)

			if var_113_2 <= arg_110_1.time_ and arg_110_1.time_ < var_113_2 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_2) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_2 + var_113_7 and arg_110_1.time_ < var_113_2 + var_113_7 + arg_113_0 then
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
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["104902"]) and arg_114_1.var_.actorSpriteComps104902 == nil then
				arg_114_1.var_.actorSpriteComps104902 = arg_114_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_117_0 = 0.2

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["104902"]) then
				if arg_114_1.var_.actorSpriteComps104902 then
					for iter_117_0, iter_117_1 in pairs(arg_114_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_117_1 then
							if arg_114_1.isInRecall_ then
								iter_117_1.color = Color.New(Mathf.Lerp(iter_117_1.color.r, arg_114_1.hightColor1.r, (arg_114_1.time_ - 0) / var_117_0), Mathf.Lerp(iter_117_1.color.g, arg_114_1.hightColor1.g, (arg_114_1.time_ - 0) / var_117_0), (Mathf.Lerp(iter_117_1.color.b, arg_114_1.hightColor1.b, (arg_114_1.time_ - 0) / var_117_0)))
							else
								local var_117_1 = Mathf.Lerp(iter_117_1.color.r, 1, (arg_114_1.time_ - 0) / var_117_0)

								iter_117_1.color = Color.New(var_117_1, var_117_1, var_117_1)
							end
						end
					end
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["104902"]) and arg_114_1.var_.actorSpriteComps104902 then
				for iter_117_2, iter_117_3 in pairs(arg_114_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_117_3 then
						iter_117_3.color = arg_114_1.isInRecall_ and (arg_114_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_114_1.var_.actorSpriteComps104902 = nil
			end

			local var_117_2 = arg_114_1.actors_["108301"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos108301 = var_117_2.localPosition
				var_117_2.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("108301", 7)

				for iter_117_4 = 0, var_117_2.childCount - 1 do
					local var_117_3 = var_117_2:GetChild(iter_117_4)

					if var_117_3.name == "" or not string.find(var_117_3.name, "split") then
						var_117_3.gameObject:SetActive(true)
					else
						var_117_3.gameObject:SetActive(false)
					end
				end
			end

			local var_117_4 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				var_117_2.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_114_1.time_ - 0) / var_117_4)
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				var_117_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_5 = arg_114_1.actors_["106603"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos106603 = var_117_5.localPosition
				var_117_5.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("106603", 7)

				for iter_117_5 = 0, var_117_5.childCount - 1 do
					local var_117_6 = var_117_5:GetChild(iter_117_5)

					if var_117_6.name == "" or not string.find(var_117_6.name, "split") then
						var_117_6.gameObject:SetActive(true)
					else
						var_117_6.gameObject:SetActive(false)
					end
				end
			end

			local var_117_7 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				var_117_5.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_114_1.time_ - 0) / var_117_7)
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				var_117_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_117_8 = arg_114_1.actors_["104902"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos104902 = var_117_8.localPosition
				var_117_8.localScale = Vector3.New(1, 1, 1)

				arg_114_1:CheckSpriteTmpPos("104902", 2)

				for iter_117_6 = 0, var_117_8.childCount - 1 do
					local var_117_9 = var_117_8:GetChild(iter_117_6)

					if var_117_9.name == "" or not string.find(var_117_9.name, "split") then
						var_117_9.gameObject:SetActive(true)
					else
						var_117_9.gameObject:SetActive(false)
					end
				end
			end

			local var_117_10 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_10 then
				var_117_8.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos104902, Vector3.New(-390, -335, -360), (arg_114_1.time_ - 0) / var_117_10)
			end

			if arg_114_1.time_ >= 0 + var_117_10 and arg_114_1.time_ < 0 + var_117_10 + arg_117_0 then
				var_117_8.localPosition = Vector3.New(-390, -335, -360)
			end

			local var_117_11 = 0
			local var_117_12 = 0.875

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_13 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(938041028).content)

				arg_114_1.text_.text = var_117_13

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_15 = 35 <= 0 and var_117_12 or var_117_12 * (utf8.len(var_117_13) / 35)

				if (35 <= 0 and var_117_12 or var_117_12 * (utf8.len(var_117_13) / 35)) > 0 and var_117_12 < var_117_15 then
					arg_114_1.talkMaxDuration = var_117_15

					if var_117_15 + var_117_11 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_15 + var_117_11
					end
				end

				arg_114_1.text_.text = var_117_13
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_16 = math.max(var_117_12, arg_114_1.talkMaxDuration)

			if var_117_11 <= arg_114_1.time_ and arg_114_1.time_ < var_117_11 + var_117_16 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_11) / var_117_16

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_11 + var_117_16 and arg_114_1.time_ < var_117_11 + var_117_16 + arg_117_0 then
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
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["104902"]) and arg_118_1.var_.actorSpriteComps104902 == nil then
				arg_118_1.var_.actorSpriteComps104902 = arg_118_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_121_0 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["104902"]) then
				if arg_118_1.var_.actorSpriteComps104902 then
					for iter_121_0, iter_121_1 in pairs(arg_118_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_121_1 then
							if arg_118_1.isInRecall_ then
								iter_121_1.color = Color.New(Mathf.Lerp(iter_121_1.color.r, arg_118_1.hightColor2.r, (arg_118_1.time_ - 0) / var_121_0), Mathf.Lerp(iter_121_1.color.g, arg_118_1.hightColor2.g, (arg_118_1.time_ - 0) / var_121_0), (Mathf.Lerp(iter_121_1.color.b, arg_118_1.hightColor2.b, (arg_118_1.time_ - 0) / var_121_0)))
							else
								local var_121_1 = Mathf.Lerp(iter_121_1.color.r, 0.5, (arg_118_1.time_ - 0) / var_121_0)

								iter_121_1.color = Color.New(var_121_1, var_121_1, var_121_1)
							end
						end
					end
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["104902"]) and arg_118_1.var_.actorSpriteComps104902 then
				for iter_121_2, iter_121_3 in pairs(arg_118_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_121_3 then
						iter_121_3.color = arg_118_1.isInRecall_ and (arg_118_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_118_1.var_.actorSpriteComps104902 = nil
			end

			local var_121_2 = 0
			local var_121_3 = 0.425

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_2 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[7].name)

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

				local var_121_4 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(938041029).content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_6 = 17 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_4) / 17)

				if (17 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_4) / 17)) > 0 and var_121_3 < var_121_6 then
					arg_118_1.talkMaxDuration = var_121_6

					if var_121_6 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_6 + var_121_2
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_3, arg_118_1.talkMaxDuration)

			if var_121_2 <= arg_118_1.time_ and arg_118_1.time_ < var_121_2 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_2) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_2 + var_121_7 and arg_118_1.time_ < var_121_2 + var_121_7 + arg_121_0 then
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
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["128404"]) and arg_122_1.var_.actorSpriteComps128404 == nil then
				arg_122_1.var_.actorSpriteComps128404 = arg_122_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["128404"]) then
				if arg_122_1.var_.actorSpriteComps128404 then
					for iter_125_0, iter_125_1 in pairs(arg_122_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_125_1 then
							if arg_122_1.isInRecall_ then
								iter_125_1.color = Color.New(Mathf.Lerp(iter_125_1.color.r, arg_122_1.hightColor1.r, (arg_122_1.time_ - 0) / var_125_0), Mathf.Lerp(iter_125_1.color.g, arg_122_1.hightColor1.g, (arg_122_1.time_ - 0) / var_125_0), (Mathf.Lerp(iter_125_1.color.b, arg_122_1.hightColor1.b, (arg_122_1.time_ - 0) / var_125_0)))
							else
								local var_125_1 = Mathf.Lerp(iter_125_1.color.r, 1, (arg_122_1.time_ - 0) / var_125_0)

								iter_125_1.color = Color.New(var_125_1, var_125_1, var_125_1)
							end
						end
					end
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["128404"]) and arg_122_1.var_.actorSpriteComps128404 then
				for iter_125_2, iter_125_3 in pairs(arg_122_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_125_3 then
						iter_125_3.color = arg_122_1.isInRecall_ and (arg_122_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_122_1.var_.actorSpriteComps128404 = nil
			end

			local var_125_2 = arg_122_1.actors_["128404"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos128404 = var_125_2.localPosition
				var_125_2.localScale = Vector3.New(1, 1, 1)

				arg_122_1:CheckSpriteTmpPos("128404", 4)

				for iter_125_4 = 0, var_125_2.childCount - 1 do
					local var_125_3 = var_125_2:GetChild(iter_125_4)

					if var_125_3.name == "split_5" or not string.find(var_125_3.name, "split") then
						var_125_3.gameObject:SetActive(true)
					else
						var_125_3.gameObject:SetActive(false)
					end
				end
			end

			local var_125_4 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				var_125_2.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos128404, Vector3.New(390.2, -356, -362.3), (arg_122_1.time_ - 0) / var_125_4)
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				var_125_2.localPosition = Vector3.New(390.2, -356, -362.3)
			end

			local var_125_5 = 0
			local var_125_6 = 0.25

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_7 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(938041030).content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 10 <= 0 and var_125_6 or var_125_6 * (utf8.len(var_125_7) / 10)

				if (10 <= 0 and var_125_6 or var_125_6 * (utf8.len(var_125_7) / 10)) > 0 and var_125_6 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_5 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_5
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_6, arg_122_1.talkMaxDuration)

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_5) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_5 + var_125_10 and arg_122_1.time_ < var_125_5 + var_125_10 + arg_125_0 then
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
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["128404"]) and arg_126_1.var_.actorSpriteComps128404 == nil then
				arg_126_1.var_.actorSpriteComps128404 = arg_126_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_129_0 = 0.2

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["128404"]) then
				if arg_126_1.var_.actorSpriteComps128404 then
					for iter_129_0, iter_129_1 in pairs(arg_126_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_129_1 then
							if arg_126_1.isInRecall_ then
								iter_129_1.color = Color.New(Mathf.Lerp(iter_129_1.color.r, arg_126_1.hightColor2.r, (arg_126_1.time_ - 0) / var_129_0), Mathf.Lerp(iter_129_1.color.g, arg_126_1.hightColor2.g, (arg_126_1.time_ - 0) / var_129_0), (Mathf.Lerp(iter_129_1.color.b, arg_126_1.hightColor2.b, (arg_126_1.time_ - 0) / var_129_0)))
							else
								local var_129_1 = Mathf.Lerp(iter_129_1.color.r, 0.5, (arg_126_1.time_ - 0) / var_129_0)

								iter_129_1.color = Color.New(var_129_1, var_129_1, var_129_1)
							end
						end
					end
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["128404"]) and arg_126_1.var_.actorSpriteComps128404 then
				for iter_129_2, iter_129_3 in pairs(arg_126_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_129_3 then
						iter_129_3.color = arg_126_1.isInRecall_ and (arg_126_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_126_1.var_.actorSpriteComps128404 = nil
			end

			local var_129_2 = 0
			local var_129_3 = 0.85

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_2 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[7].name)

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

				local var_129_4 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(938041031).content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_6 = 34 <= 0 and var_129_3 or var_129_3 * (utf8.len(var_129_4) / 34)

				if (34 <= 0 and var_129_3 or var_129_3 * (utf8.len(var_129_4) / 34)) > 0 and var_129_3 < var_129_6 then
					arg_126_1.talkMaxDuration = var_129_6

					if var_129_6 + var_129_2 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_6 + var_129_2
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_3, arg_126_1.talkMaxDuration)

			if var_129_2 <= arg_126_1.time_ and arg_126_1.time_ < var_129_2 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_2) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_2 + var_129_7 and arg_126_1.time_ < var_129_2 + var_129_7 + arg_129_0 then
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
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos128404 = arg_130_1.actors_["128404"].transform.localPosition
				arg_130_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("128404", 7)

				for iter_133_0 = 0, arg_130_1.actors_["128404"].transform.childCount - 1 do
					local var_133_0 = arg_130_1.actors_["128404"].transform:GetChild(iter_133_0)

					if var_133_0.name == "" or not string.find(var_133_0.name, "split") then
						var_133_0.gameObject:SetActive(true)
					else
						var_133_0.gameObject:SetActive(false)
					end
				end
			end

			local var_133_1 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_1 then
				arg_130_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_130_1.time_ - 0) / var_133_1)
			end

			if arg_130_1.time_ >= 0 + var_133_1 and arg_130_1.time_ < 0 + var_133_1 + arg_133_0 then
				arg_130_1.actors_["128404"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_133_2 = arg_130_1.actors_["104902"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos104902 = var_133_2.localPosition
				var_133_2.localScale = Vector3.New(1, 1, 1)

				arg_130_1:CheckSpriteTmpPos("104902", 7)

				for iter_133_1 = 0, var_133_2.childCount - 1 do
					local var_133_3 = var_133_2:GetChild(iter_133_1)

					if var_133_3.name == "" or not string.find(var_133_3.name, "split") then
						var_133_3.gameObject:SetActive(true)
					else
						var_133_3.gameObject:SetActive(false)
					end
				end
			end

			local var_133_4 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				var_133_2.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_130_1.time_ - 0) / var_133_4)
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				var_133_2.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_133_5 = 0
			local var_133_6 = 1.475

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_7 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(938041032).content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 59 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_7) / 59)

				if (59 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_7) / 59)) > 0 and var_133_6 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_5
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_6, arg_130_1.talkMaxDuration)

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_5) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_5 + var_133_10 and arg_130_1.time_ < var_133_5 + var_133_10 + arg_133_0 then
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
			local var_137_0 = 0.15

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

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

				local var_137_1 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(938041033).content)

				arg_134_1.text_.text = var_137_1

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_3 = 6 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 6)

				if (6 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 6)) > 0 and var_137_0 < var_137_3 then
					arg_134_1.talkMaxDuration = var_137_3

					if var_137_3 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_3 + 0
					end
				end

				arg_134_1.text_.text = var_137_1
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_4 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_4

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 then
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
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["10183"]) and arg_138_1.var_.actorSpriteComps10183 == nil then
				arg_138_1.var_.actorSpriteComps10183 = arg_138_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_0 = 0.2

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["10183"]) then
				if arg_138_1.var_.actorSpriteComps10183 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								iter_141_1.color = Color.New(Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor1.r, (arg_138_1.time_ - 0) / var_141_0), Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor1.g, (arg_138_1.time_ - 0) / var_141_0), (Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor1.b, (arg_138_1.time_ - 0) / var_141_0)))
							else
								local var_141_1 = Mathf.Lerp(iter_141_1.color.r, 1, (arg_138_1.time_ - 0) / var_141_0)

								iter_141_1.color = Color.New(var_141_1, var_141_1, var_141_1)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["10183"]) and arg_138_1.var_.actorSpriteComps10183 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_141_3 then
						iter_141_3.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_138_1.var_.actorSpriteComps10183 = nil
			end

			local var_141_2 = arg_138_1.actors_["10183"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10183 = var_141_2.localPosition
				var_141_2.localScale = Vector3.New(1, 1, 1)

				arg_138_1:CheckSpriteTmpPos("10183", 3)

				for iter_141_4 = 0, var_141_2.childCount - 1 do
					local var_141_3 = var_141_2:GetChild(iter_141_4)

					if var_141_3.name == "split_5" or not string.find(var_141_3.name, "split") then
						var_141_3.gameObject:SetActive(true)
					else
						var_141_3.gameObject:SetActive(false)
					end
				end
			end

			local var_141_4 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 then
				var_141_2.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_138_1.time_ - 0) / var_141_4)
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				var_141_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_141_5 = 0
			local var_141_6 = 0.325

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_7 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(938041034).content)

				arg_138_1.text_.text = var_141_7

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_9 = 13 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_7) / 13)

				if (13 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_7) / 13)) > 0 and var_141_6 < var_141_9 then
					arg_138_1.talkMaxDuration = var_141_9

					if var_141_9 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_5
					end
				end

				arg_138_1.text_.text = var_141_7
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_6, arg_138_1.talkMaxDuration)

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_5) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_5 + var_141_10 and arg_138_1.time_ < var_141_5 + var_141_10 + arg_141_0 then
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
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["10183"]) and arg_142_1.var_.actorSpriteComps10183 == nil then
				arg_142_1.var_.actorSpriteComps10183 = arg_142_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_0 = 0.2

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["10183"]) then
				if arg_142_1.var_.actorSpriteComps10183 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_145_1 then
							if arg_142_1.isInRecall_ then
								iter_145_1.color = Color.New(Mathf.Lerp(iter_145_1.color.r, arg_142_1.hightColor2.r, (arg_142_1.time_ - 0) / var_145_0), Mathf.Lerp(iter_145_1.color.g, arg_142_1.hightColor2.g, (arg_142_1.time_ - 0) / var_145_0), (Mathf.Lerp(iter_145_1.color.b, arg_142_1.hightColor2.b, (arg_142_1.time_ - 0) / var_145_0)))
							else
								local var_145_1 = Mathf.Lerp(iter_145_1.color.r, 0.5, (arg_142_1.time_ - 0) / var_145_0)

								iter_145_1.color = Color.New(var_145_1, var_145_1, var_145_1)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["10183"]) and arg_142_1.var_.actorSpriteComps10183 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_145_3 then
						iter_145_3.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_142_1.var_.actorSpriteComps10183 = nil
			end

			local var_145_2 = 0
			local var_145_3 = 0.3

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[7].name)

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

				local var_145_4 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(938041035).content)

				arg_142_1.text_.text = var_145_4

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_6 = 12 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_4) / 12)

				if (12 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_4) / 12)) > 0 and var_145_3 < var_145_6 then
					arg_142_1.talkMaxDuration = var_145_6

					if var_145_6 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_2
					end
				end

				arg_142_1.text_.text = var_145_4
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_3, arg_142_1.talkMaxDuration)

			if var_145_2 <= arg_142_1.time_ and arg_142_1.time_ < var_145_2 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_2) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_2 + var_145_7 and arg_142_1.time_ < var_145_2 + var_145_7 + arg_145_0 then
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
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["10183"]) and arg_146_1.var_.actorSpriteComps10183 == nil then
				arg_146_1.var_.actorSpriteComps10183 = arg_146_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_0 = 0.2

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["10183"]) then
				if arg_146_1.var_.actorSpriteComps10183 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_149_1 then
							if arg_146_1.isInRecall_ then
								iter_149_1.color = Color.New(Mathf.Lerp(iter_149_1.color.r, arg_146_1.hightColor1.r, (arg_146_1.time_ - 0) / var_149_0), Mathf.Lerp(iter_149_1.color.g, arg_146_1.hightColor1.g, (arg_146_1.time_ - 0) / var_149_0), (Mathf.Lerp(iter_149_1.color.b, arg_146_1.hightColor1.b, (arg_146_1.time_ - 0) / var_149_0)))
							else
								local var_149_1 = Mathf.Lerp(iter_149_1.color.r, 1, (arg_146_1.time_ - 0) / var_149_0)

								iter_149_1.color = Color.New(var_149_1, var_149_1, var_149_1)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["10183"]) and arg_146_1.var_.actorSpriteComps10183 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_149_3 then
						iter_149_3.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_146_1.var_.actorSpriteComps10183 = nil
			end

			local var_149_2 = arg_146_1.actors_["10183"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos10183 = var_149_2.localPosition
				var_149_2.localScale = Vector3.New(1, 1, 1)

				arg_146_1:CheckSpriteTmpPos("10183", 3)

				for iter_149_4 = 0, var_149_2.childCount - 1 do
					local var_149_3 = var_149_2:GetChild(iter_149_4)

					if var_149_3.name == "split_1" then
						var_149_3:SetAsLastSibling()
						var_149_3.gameObject:SetActive(true)

						arg_146_1.var_.actorSpriteSplit10183 = var_149_3.gameObject:GetComponent(typeof(Image))

						arg_146_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_149_4 = 0.5

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 then
				var_149_2.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_146_1.time_ - 0) / var_149_4)

				if arg_146_1.var_.actorSpriteSplit10183 ~= nil then
					arg_146_1.var_.actorSpriteSplit10183:SetAlpha((arg_146_1.time_ - 0) / var_149_4)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 then
				var_149_2.localPosition = Vector3.New(0, -475, -325)

				if arg_146_1.var_.actorSpriteSplit10183 ~= nil then
					arg_146_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_149_5 = 0
			local var_149_6 = 1.225

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_7 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(938041036).content)

				arg_146_1.text_.text = var_149_7

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_9 = 49 <= 0 and var_149_6 or var_149_6 * (utf8.len(var_149_7) / 49)

				if (49 <= 0 and var_149_6 or var_149_6 * (utf8.len(var_149_7) / 49)) > 0 and var_149_6 < var_149_9 then
					arg_146_1.talkMaxDuration = var_149_9

					if var_149_9 + var_149_5 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_5
					end
				end

				arg_146_1.text_.text = var_149_7
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_10 = math.max(var_149_6, arg_146_1.talkMaxDuration)

			if var_149_5 <= arg_146_1.time_ and arg_146_1.time_ < var_149_5 + var_149_10 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_5) / var_149_10

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_5 + var_149_10 and arg_146_1.time_ < var_149_5 + var_149_10 + arg_149_0 then
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
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["10183"]) and arg_150_1.var_.actorSpriteComps10183 == nil then
				arg_150_1.var_.actorSpriteComps10183 = arg_150_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_0 = 0.2

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["10183"]) then
				if arg_150_1.var_.actorSpriteComps10183 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								iter_153_1.color = Color.New(Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor2.r, (arg_150_1.time_ - 0) / var_153_0), Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor2.g, (arg_150_1.time_ - 0) / var_153_0), (Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor2.b, (arg_150_1.time_ - 0) / var_153_0)))
							else
								local var_153_1 = Mathf.Lerp(iter_153_1.color.r, 0.5, (arg_150_1.time_ - 0) / var_153_0)

								iter_153_1.color = Color.New(var_153_1, var_153_1, var_153_1)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["10183"]) and arg_150_1.var_.actorSpriteComps10183 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_153_3 then
						iter_153_3.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_150_1.var_.actorSpriteComps10183 = nil
			end

			local var_153_2 = 0
			local var_153_3 = 0.4

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_2 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

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

				local var_153_4 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(938041037).content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_6 = 16 <= 0 and var_153_3 or var_153_3 * (utf8.len(var_153_4) / 16)

				if (16 <= 0 and var_153_3 or var_153_3 * (utf8.len(var_153_4) / 16)) > 0 and var_153_3 < var_153_6 then
					arg_150_1.talkMaxDuration = var_153_6

					if var_153_6 + var_153_2 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_2
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_3, arg_150_1.talkMaxDuration)

			if var_153_2 <= arg_150_1.time_ and arg_150_1.time_ < var_153_2 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_2) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_2 + var_153_7 and arg_150_1.time_ < var_153_2 + var_153_7 + arg_153_0 then
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
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["10183"]) and arg_154_1.var_.actorSpriteComps10183 == nil then
				arg_154_1.var_.actorSpriteComps10183 = arg_154_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_0 = 0.2

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["10183"]) then
				if arg_154_1.var_.actorSpriteComps10183 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								iter_157_1.color = Color.New(Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor1.r, (arg_154_1.time_ - 0) / var_157_0), Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor1.g, (arg_154_1.time_ - 0) / var_157_0), (Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor1.b, (arg_154_1.time_ - 0) / var_157_0)))
							else
								local var_157_1 = Mathf.Lerp(iter_157_1.color.r, 1, (arg_154_1.time_ - 0) / var_157_0)

								iter_157_1.color = Color.New(var_157_1, var_157_1, var_157_1)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["10183"]) and arg_154_1.var_.actorSpriteComps10183 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_157_3 then
						iter_157_3.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_154_1.var_.actorSpriteComps10183 = nil
			end

			local var_157_2 = arg_154_1.actors_["10183"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos10183 = var_157_2.localPosition
				var_157_2.localScale = Vector3.New(1, 1, 1)

				arg_154_1:CheckSpriteTmpPos("10183", 3)

				for iter_157_4 = 0, var_157_2.childCount - 1 do
					local var_157_3 = var_157_2:GetChild(iter_157_4)

					if var_157_3.name == "split_2" then
						var_157_3:SetAsLastSibling()
						var_157_3.gameObject:SetActive(true)

						arg_154_1.var_.actorSpriteSplit10183 = var_157_3.gameObject:GetComponent(typeof(Image))

						arg_154_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_157_4 = 0.5

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				var_157_2.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_154_1.time_ - 0) / var_157_4)

				if arg_154_1.var_.actorSpriteSplit10183 ~= nil then
					arg_154_1.var_.actorSpriteSplit10183:SetAlpha((arg_154_1.time_ - 0) / var_157_4)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				var_157_2.localPosition = Vector3.New(0, -475, -325)

				if arg_154_1.var_.actorSpriteSplit10183 ~= nil then
					arg_154_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_157_5 = 0
			local var_157_6 = 0.825

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_7 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(938041038).content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_9 = 33 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_7) / 33)

				if (33 <= 0 and var_157_6 or var_157_6 * (utf8.len(var_157_7) / 33)) > 0 and var_157_6 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_5 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_5
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_10 = math.max(var_157_6, arg_154_1.talkMaxDuration)

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_10 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_5) / var_157_10

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_5 + var_157_10 and arg_154_1.time_ < var_157_5 + var_157_10 + arg_157_0 then
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
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["10183"]) and arg_158_1.var_.actorSpriteComps10183 == nil then
				arg_158_1.var_.actorSpriteComps10183 = arg_158_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_161_0 = 0.2

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["10183"]) then
				if arg_158_1.var_.actorSpriteComps10183 then
					for iter_161_0, iter_161_1 in pairs(arg_158_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_161_1 then
							if arg_158_1.isInRecall_ then
								iter_161_1.color = Color.New(Mathf.Lerp(iter_161_1.color.r, arg_158_1.hightColor2.r, (arg_158_1.time_ - 0) / var_161_0), Mathf.Lerp(iter_161_1.color.g, arg_158_1.hightColor2.g, (arg_158_1.time_ - 0) / var_161_0), (Mathf.Lerp(iter_161_1.color.b, arg_158_1.hightColor2.b, (arg_158_1.time_ - 0) / var_161_0)))
							else
								local var_161_1 = Mathf.Lerp(iter_161_1.color.r, 0.5, (arg_158_1.time_ - 0) / var_161_0)

								iter_161_1.color = Color.New(var_161_1, var_161_1, var_161_1)
							end
						end
					end
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["10183"]) and arg_158_1.var_.actorSpriteComps10183 then
				for iter_161_2, iter_161_3 in pairs(arg_158_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_161_3 then
						iter_161_3.color = arg_158_1.isInRecall_ and (arg_158_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_158_1.var_.actorSpriteComps10183 = nil
			end

			local var_161_2 = 0
			local var_161_3 = 0.35

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[7].name)

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

				local var_161_4 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(938041039).content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_6 = 14 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_4) / 14)

				if (14 <= 0 and var_161_3 or var_161_3 * (utf8.len(var_161_4) / 14)) > 0 and var_161_3 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_2 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_2
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_3, arg_158_1.talkMaxDuration)

			if var_161_2 <= arg_158_1.time_ and arg_158_1.time_ < var_161_2 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_2) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_2 + var_161_7 and arg_158_1.time_ < var_161_2 + var_161_7 + arg_161_0 then
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
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["10183"]) and arg_162_1.var_.actorSpriteComps10183 == nil then
				arg_162_1.var_.actorSpriteComps10183 = arg_162_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_165_0 = 0.2

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["10183"]) then
				if arg_162_1.var_.actorSpriteComps10183 then
					for iter_165_0, iter_165_1 in pairs(arg_162_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_165_1 then
							if arg_162_1.isInRecall_ then
								iter_165_1.color = Color.New(Mathf.Lerp(iter_165_1.color.r, arg_162_1.hightColor1.r, (arg_162_1.time_ - 0) / var_165_0), Mathf.Lerp(iter_165_1.color.g, arg_162_1.hightColor1.g, (arg_162_1.time_ - 0) / var_165_0), (Mathf.Lerp(iter_165_1.color.b, arg_162_1.hightColor1.b, (arg_162_1.time_ - 0) / var_165_0)))
							else
								local var_165_1 = Mathf.Lerp(iter_165_1.color.r, 1, (arg_162_1.time_ - 0) / var_165_0)

								iter_165_1.color = Color.New(var_165_1, var_165_1, var_165_1)
							end
						end
					end
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["10183"]) and arg_162_1.var_.actorSpriteComps10183 then
				for iter_165_2, iter_165_3 in pairs(arg_162_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_165_3 then
						iter_165_3.color = arg_162_1.isInRecall_ and (arg_162_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_162_1.var_.actorSpriteComps10183 = nil
			end

			local var_165_2 = arg_162_1.actors_["10183"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos10183 = var_165_2.localPosition
				var_165_2.localScale = Vector3.New(1, 1, 1)

				arg_162_1:CheckSpriteTmpPos("10183", 3)

				for iter_165_4 = 0, var_165_2.childCount - 1 do
					local var_165_3 = var_165_2:GetChild(iter_165_4)

					if var_165_3.name == "split_1" then
						var_165_3:SetAsLastSibling()
						var_165_3.gameObject:SetActive(true)

						arg_162_1.var_.actorSpriteSplit10183 = var_165_3.gameObject:GetComponent(typeof(Image))

						arg_162_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_165_4 = 0.5

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				var_165_2.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_162_1.time_ - 0) / var_165_4)

				if arg_162_1.var_.actorSpriteSplit10183 ~= nil then
					arg_162_1.var_.actorSpriteSplit10183:SetAlpha((arg_162_1.time_ - 0) / var_165_4)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				var_165_2.localPosition = Vector3.New(0, -475, -325)

				if arg_162_1.var_.actorSpriteSplit10183 ~= nil then
					arg_162_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_165_5 = 0
			local var_165_6 = 0.825

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_7 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(938041040).content)

				arg_162_1.text_.text = var_165_7

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_9 = 33 <= 0 and var_165_6 or var_165_6 * (utf8.len(var_165_7) / 33)

				if (33 <= 0 and var_165_6 or var_165_6 * (utf8.len(var_165_7) / 33)) > 0 and var_165_6 < var_165_9 then
					arg_162_1.talkMaxDuration = var_165_9

					if var_165_9 + var_165_5 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_9 + var_165_5
					end
				end

				arg_162_1.text_.text = var_165_7
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_10 = math.max(var_165_6, arg_162_1.talkMaxDuration)

			if var_165_5 <= arg_162_1.time_ and arg_162_1.time_ < var_165_5 + var_165_10 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_5) / var_165_10

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_5 + var_165_10 and arg_162_1.time_ < var_165_5 + var_165_10 + arg_165_0 then
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
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["10183"]) and arg_166_1.var_.actorSpriteComps10183 == nil then
				arg_166_1.var_.actorSpriteComps10183 = arg_166_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_0 = 0.2

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["10183"]) then
				if arg_166_1.var_.actorSpriteComps10183 then
					for iter_169_0, iter_169_1 in pairs(arg_166_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_169_1 then
							if arg_166_1.isInRecall_ then
								iter_169_1.color = Color.New(Mathf.Lerp(iter_169_1.color.r, arg_166_1.hightColor2.r, (arg_166_1.time_ - 0) / var_169_0), Mathf.Lerp(iter_169_1.color.g, arg_166_1.hightColor2.g, (arg_166_1.time_ - 0) / var_169_0), (Mathf.Lerp(iter_169_1.color.b, arg_166_1.hightColor2.b, (arg_166_1.time_ - 0) / var_169_0)))
							else
								local var_169_1 = Mathf.Lerp(iter_169_1.color.r, 0.5, (arg_166_1.time_ - 0) / var_169_0)

								iter_169_1.color = Color.New(var_169_1, var_169_1, var_169_1)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["10183"]) and arg_166_1.var_.actorSpriteComps10183 then
				for iter_169_2, iter_169_3 in pairs(arg_166_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_169_3 then
						iter_169_3.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_166_1.var_.actorSpriteComps10183 = nil
			end

			local var_169_2 = 0
			local var_169_3 = 0.525

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_2 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[7].name)

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

				local var_169_4 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(938041041).content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_6 = 21 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_4) / 21)

				if (21 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_4) / 21)) > 0 and var_169_3 < var_169_6 then
					arg_166_1.talkMaxDuration = var_169_6

					if var_169_6 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_6 + var_169_2
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_7 = math.max(var_169_3, arg_166_1.talkMaxDuration)

			if var_169_2 <= arg_166_1.time_ and arg_166_1.time_ < var_169_2 + var_169_7 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_2) / var_169_7

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_2 + var_169_7 and arg_166_1.time_ < var_169_2 + var_169_7 + arg_169_0 then
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
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10183"]) and arg_170_1.var_.actorSpriteComps10183 == nil then
				arg_170_1.var_.actorSpriteComps10183 = arg_170_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_173_0 = 0.2

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10183"]) then
				if arg_170_1.var_.actorSpriteComps10183 then
					for iter_173_0, iter_173_1 in pairs(arg_170_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_173_1 then
							if arg_170_1.isInRecall_ then
								iter_173_1.color = Color.New(Mathf.Lerp(iter_173_1.color.r, arg_170_1.hightColor1.r, (arg_170_1.time_ - 0) / var_173_0), Mathf.Lerp(iter_173_1.color.g, arg_170_1.hightColor1.g, (arg_170_1.time_ - 0) / var_173_0), (Mathf.Lerp(iter_173_1.color.b, arg_170_1.hightColor1.b, (arg_170_1.time_ - 0) / var_173_0)))
							else
								local var_173_1 = Mathf.Lerp(iter_173_1.color.r, 1, (arg_170_1.time_ - 0) / var_173_0)

								iter_173_1.color = Color.New(var_173_1, var_173_1, var_173_1)
							end
						end
					end
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10183"]) and arg_170_1.var_.actorSpriteComps10183 then
				for iter_173_2, iter_173_3 in pairs(arg_170_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_173_3 then
						iter_173_3.color = arg_170_1.isInRecall_ and (arg_170_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_170_1.var_.actorSpriteComps10183 = nil
			end

			local var_173_2 = arg_170_1.actors_["10183"].transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos10183 = var_173_2.localPosition
				var_173_2.localScale = Vector3.New(1, 1, 1)

				arg_170_1:CheckSpriteTmpPos("10183", 3)

				for iter_173_4 = 0, var_173_2.childCount - 1 do
					local var_173_3 = var_173_2:GetChild(iter_173_4)

					if var_173_3.name == "" or not string.find(var_173_3.name, "split") then
						var_173_3.gameObject:SetActive(true)
					else
						var_173_3.gameObject:SetActive(false)
					end
				end
			end

			local var_173_4 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				var_173_2.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_170_1.time_ - 0) / var_173_4)
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				var_173_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_173_5 = 0
			local var_173_6 = 1.35

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_5 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_7 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(938041042).content)

				arg_170_1.text_.text = var_173_7

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_9 = 54 <= 0 and var_173_6 or var_173_6 * (utf8.len(var_173_7) / 54)

				if (54 <= 0 and var_173_6 or var_173_6 * (utf8.len(var_173_7) / 54)) > 0 and var_173_6 < var_173_9 then
					arg_170_1.talkMaxDuration = var_173_9

					if var_173_9 + var_173_5 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_9 + var_173_5
					end
				end

				arg_170_1.text_.text = var_173_7
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_6, arg_170_1.talkMaxDuration)

			if var_173_5 <= arg_170_1.time_ and arg_170_1.time_ < var_173_5 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_5) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_5 + var_173_10 and arg_170_1.time_ < var_173_5 + var_173_10 + arg_173_0 then
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
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["10183"]) and arg_174_1.var_.actorSpriteComps10183 == nil then
				arg_174_1.var_.actorSpriteComps10183 = arg_174_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_0 = 0.2

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["10183"]) then
				if arg_174_1.var_.actorSpriteComps10183 then
					for iter_177_0, iter_177_1 in pairs(arg_174_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_177_1 then
							if arg_174_1.isInRecall_ then
								iter_177_1.color = Color.New(Mathf.Lerp(iter_177_1.color.r, arg_174_1.hightColor2.r, (arg_174_1.time_ - 0) / var_177_0), Mathf.Lerp(iter_177_1.color.g, arg_174_1.hightColor2.g, (arg_174_1.time_ - 0) / var_177_0), (Mathf.Lerp(iter_177_1.color.b, arg_174_1.hightColor2.b, (arg_174_1.time_ - 0) / var_177_0)))
							else
								local var_177_1 = Mathf.Lerp(iter_177_1.color.r, 0.5, (arg_174_1.time_ - 0) / var_177_0)

								iter_177_1.color = Color.New(var_177_1, var_177_1, var_177_1)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["10183"]) and arg_174_1.var_.actorSpriteComps10183 then
				for iter_177_2, iter_177_3 in pairs(arg_174_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_177_3 then
						iter_177_3.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_174_1.var_.actorSpriteComps10183 = nil
			end

			local var_177_2 = arg_174_1.actors_["10183"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos10183 = var_177_2.localPosition
				var_177_2.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("10183", 7)

				for iter_177_4 = 0, var_177_2.childCount - 1 do
					local var_177_3 = var_177_2:GetChild(iter_177_4)

					if var_177_3.name == "" or not string.find(var_177_3.name, "split") then
						var_177_3.gameObject:SetActive(true)
					else
						var_177_3.gameObject:SetActive(false)
					end
				end
			end

			local var_177_4 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				var_177_2.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_174_1.time_ - 0) / var_177_4)
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				var_177_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_177_5 = 0
			local var_177_6 = 1.425

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_7 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(938041043).content)

				arg_174_1.text_.text = var_177_7

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_9 = 57 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_7) / 57)

				if (57 <= 0 and var_177_6 or var_177_6 * (utf8.len(var_177_7) / 57)) > 0 and var_177_6 < var_177_9 then
					arg_174_1.talkMaxDuration = var_177_9

					if var_177_9 + var_177_5 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_9 + var_177_5
					end
				end

				arg_174_1.text_.text = var_177_7
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_10 = math.max(var_177_6, arg_174_1.talkMaxDuration)

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_10 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_5) / var_177_10

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_5 + var_177_10 and arg_174_1.time_ < var_177_5 + var_177_10 + arg_177_0 then
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
			local var_181_0 = 1.625

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_1 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(938041044).content)

				arg_178_1.text_.text = var_181_1

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_3 = 65 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 65)

				if (65 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 65)) > 0 and var_181_0 < var_181_3 then
					arg_178_1.talkMaxDuration = var_181_3

					if var_181_3 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_3 + 0
					end
				end

				arg_178_1.text_.text = var_181_1
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_4 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_4

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
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
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["10183"]) and arg_182_1.var_.actorSpriteComps10183 == nil then
				arg_182_1.var_.actorSpriteComps10183 = arg_182_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_0 = 0.2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["10183"]) then
				if arg_182_1.var_.actorSpriteComps10183 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								iter_185_1.color = Color.New(Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, (arg_182_1.time_ - 0) / var_185_0), Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, (arg_182_1.time_ - 0) / var_185_0), (Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, (arg_182_1.time_ - 0) / var_185_0)))
							else
								local var_185_1 = Mathf.Lerp(iter_185_1.color.r, 1, (arg_182_1.time_ - 0) / var_185_0)

								iter_185_1.color = Color.New(var_185_1, var_185_1, var_185_1)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["10183"]) and arg_182_1.var_.actorSpriteComps10183 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_185_3 then
						iter_185_3.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_182_1.var_.actorSpriteComps10183 = nil
			end

			local var_185_2 = arg_182_1.actors_["10183"].transform

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos10183 = var_185_2.localPosition
				var_185_2.localScale = Vector3.New(1, 1, 1)

				arg_182_1:CheckSpriteTmpPos("10183", 3)

				for iter_185_4 = 0, var_185_2.childCount - 1 do
					local var_185_3 = var_185_2:GetChild(iter_185_4)

					if var_185_3.name == "split_8" or not string.find(var_185_3.name, "split") then
						var_185_3.gameObject:SetActive(true)
					else
						var_185_3.gameObject:SetActive(false)
					end
				end
			end

			local var_185_4 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				var_185_2.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_182_1.time_ - 0) / var_185_4)
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				var_185_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_185_5 = 0
			local var_185_6 = 0.95

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_7 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(938041045).content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 38 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_7) / 38)

				if (38 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_7) / 38)) > 0 and var_185_6 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_5
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_10 = math.max(var_185_6, arg_182_1.talkMaxDuration)

			if var_185_5 <= arg_182_1.time_ and arg_182_1.time_ < var_185_5 + var_185_10 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_5) / var_185_10

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_5 + var_185_10 and arg_182_1.time_ < var_185_5 + var_185_10 + arg_185_0 then
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
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["10183"]) and arg_186_1.var_.actorSpriteComps10183 == nil then
				arg_186_1.var_.actorSpriteComps10183 = arg_186_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_0 = 0.2

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["10183"]) then
				if arg_186_1.var_.actorSpriteComps10183 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								iter_189_1.color = Color.New(Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor2.r, (arg_186_1.time_ - 0) / var_189_0), Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor2.g, (arg_186_1.time_ - 0) / var_189_0), (Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor2.b, (arg_186_1.time_ - 0) / var_189_0)))
							else
								local var_189_1 = Mathf.Lerp(iter_189_1.color.r, 0.5, (arg_186_1.time_ - 0) / var_189_0)

								iter_189_1.color = Color.New(var_189_1, var_189_1, var_189_1)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["10183"]) and arg_186_1.var_.actorSpriteComps10183 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_189_3 then
						iter_189_3.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_186_1.var_.actorSpriteComps10183 = nil
			end

			local var_189_2 = 0
			local var_189_3 = 0.05

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_2 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1563].name)

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

				local var_189_4 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(938041046).content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_6 = 2 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_4) / 2)

				if (2 <= 0 and var_189_3 or var_189_3 * (utf8.len(var_189_4) / 2)) > 0 and var_189_3 < var_189_6 then
					arg_186_1.talkMaxDuration = var_189_6

					if var_189_6 + var_189_2 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_2
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_7 = math.max(var_189_3, arg_186_1.talkMaxDuration)

			if var_189_2 <= arg_186_1.time_ and arg_186_1.time_ < var_189_2 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_2) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_2 + var_189_7 and arg_186_1.time_ < var_189_2 + var_189_7 + arg_189_0 then
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
			local var_193_0 = 0.05

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1564].name)

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

				local var_193_1 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(938041047).content)

				arg_190_1.text_.text = var_193_1

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_3 = 2 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 2)

				if (2 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 2)) > 0 and var_193_0 < var_193_3 then
					arg_190_1.talkMaxDuration = var_193_3

					if var_193_3 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_3 + 0
					end
				end

				arg_190_1.text_.text = var_193_1
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_4 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_4

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 then
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
				SetActive(iter_195_1.go, iter_195_0 <= 1)
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
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.allBtn_.enabled = false
			end

			if arg_194_1.time_ >= 0 + 0.5 and arg_194_1.time_ < 0 + 0.5 + arg_197_0 then
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
			local var_201_0 = 0.625

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

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

				local var_201_1 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(938041049).content)

				arg_198_1.text_.text = var_201_1

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_3 = 25 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 25)

				if (25 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_1) / 25)) > 0 and var_201_0 < var_201_3 then
					arg_198_1.talkMaxDuration = var_201_3

					if var_201_3 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_3 + 0
					end
				end

				arg_198_1.text_.text = var_201_1
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_4 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_4

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 then
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
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["10183"]) and arg_202_1.var_.actorSpriteComps10183 == nil then
				arg_202_1.var_.actorSpriteComps10183 = arg_202_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_0 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["10183"]) then
				if arg_202_1.var_.actorSpriteComps10183 then
					for iter_205_0, iter_205_1 in pairs(arg_202_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_205_1 then
							if arg_202_1.isInRecall_ then
								iter_205_1.color = Color.New(Mathf.Lerp(iter_205_1.color.r, arg_202_1.hightColor1.r, (arg_202_1.time_ - 0) / var_205_0), Mathf.Lerp(iter_205_1.color.g, arg_202_1.hightColor1.g, (arg_202_1.time_ - 0) / var_205_0), (Mathf.Lerp(iter_205_1.color.b, arg_202_1.hightColor1.b, (arg_202_1.time_ - 0) / var_205_0)))
							else
								local var_205_1 = Mathf.Lerp(iter_205_1.color.r, 1, (arg_202_1.time_ - 0) / var_205_0)

								iter_205_1.color = Color.New(var_205_1, var_205_1, var_205_1)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["10183"]) and arg_202_1.var_.actorSpriteComps10183 then
				for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_205_3 then
						iter_205_3.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_202_1.var_.actorSpriteComps10183 = nil
			end

			local var_205_2 = arg_202_1.actors_["10183"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos10183 = var_205_2.localPosition
				var_205_2.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("10183", 3)

				for iter_205_4 = 0, var_205_2.childCount - 1 do
					local var_205_3 = var_205_2:GetChild(iter_205_4)

					if var_205_3.name == "split_7" then
						var_205_3:SetAsLastSibling()
						var_205_3.gameObject:SetActive(true)

						arg_202_1.var_.actorSpriteSplit10183 = var_205_3.gameObject:GetComponent(typeof(Image))

						arg_202_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_205_4 = 0.5

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				var_205_2.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_202_1.time_ - 0) / var_205_4)

				if arg_202_1.var_.actorSpriteSplit10183 ~= nil then
					arg_202_1.var_.actorSpriteSplit10183:SetAlpha((arg_202_1.time_ - 0) / var_205_4)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				var_205_2.localPosition = Vector3.New(0, -475, -325)

				if arg_202_1.var_.actorSpriteSplit10183 ~= nil then
					arg_202_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_205_5 = 0
			local var_205_6 = 0.875

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_5 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_7 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(938041050).content)

				arg_202_1.text_.text = var_205_7

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_9 = 35 <= 0 and var_205_6 or var_205_6 * (utf8.len(var_205_7) / 35)

				if (35 <= 0 and var_205_6 or var_205_6 * (utf8.len(var_205_7) / 35)) > 0 and var_205_6 < var_205_9 then
					arg_202_1.talkMaxDuration = var_205_9

					if var_205_9 + var_205_5 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_5
					end
				end

				arg_202_1.text_.text = var_205_7
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_6, arg_202_1.talkMaxDuration)

			if var_205_5 <= arg_202_1.time_ and arg_202_1.time_ < var_205_5 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_5) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_5 + var_205_10 and arg_202_1.time_ < var_205_5 + var_205_10 + arg_205_0 then
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
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["10183"]) and arg_206_1.var_.actorSpriteComps10183 == nil then
				arg_206_1.var_.actorSpriteComps10183 = arg_206_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_0 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["10183"]) then
				if arg_206_1.var_.actorSpriteComps10183 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								iter_209_1.color = Color.New(Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor2.r, (arg_206_1.time_ - 0) / var_209_0), Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor2.g, (arg_206_1.time_ - 0) / var_209_0), (Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor2.b, (arg_206_1.time_ - 0) / var_209_0)))
							else
								local var_209_1 = Mathf.Lerp(iter_209_1.color.r, 0.5, (arg_206_1.time_ - 0) / var_209_0)

								iter_209_1.color = Color.New(var_209_1, var_209_1, var_209_1)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["10183"]) and arg_206_1.var_.actorSpriteComps10183 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_209_3 then
						iter_209_3.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_206_1.var_.actorSpriteComps10183 = nil
			end

			local var_209_2 = 0
			local var_209_3 = 0.275

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[7].name)

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

				local var_209_4 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(938041051).content)

				arg_206_1.text_.text = var_209_4

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_6 = 11 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_4) / 11)

				if (11 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_4) / 11)) > 0 and var_209_3 < var_209_6 then
					arg_206_1.talkMaxDuration = var_209_6

					if var_209_6 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_6 + var_209_2
					end
				end

				arg_206_1.text_.text = var_209_4
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_3, arg_206_1.talkMaxDuration)

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_2) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_2 + var_209_7 and arg_206_1.time_ < var_209_2 + var_209_7 + arg_209_0 then
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
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["10183"]) and arg_210_1.var_.actorSpriteComps10183 == nil then
				arg_210_1.var_.actorSpriteComps10183 = arg_210_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["10183"]) then
				if arg_210_1.var_.actorSpriteComps10183 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								iter_213_1.color = Color.New(Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor1.r, (arg_210_1.time_ - 0) / var_213_0), Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor1.g, (arg_210_1.time_ - 0) / var_213_0), (Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor1.b, (arg_210_1.time_ - 0) / var_213_0)))
							else
								local var_213_1 = Mathf.Lerp(iter_213_1.color.r, 1, (arg_210_1.time_ - 0) / var_213_0)

								iter_213_1.color = Color.New(var_213_1, var_213_1, var_213_1)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["10183"]) and arg_210_1.var_.actorSpriteComps10183 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_210_1.var_.actorSpriteComps10183 = nil
			end

			local var_213_2 = arg_210_1.actors_["10183"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos10183 = var_213_2.localPosition
				var_213_2.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("10183", 3)

				for iter_213_4 = 0, var_213_2.childCount - 1 do
					local var_213_3 = var_213_2:GetChild(iter_213_4)

					if var_213_3.name == "split_4" then
						var_213_3:SetAsLastSibling()
						var_213_3.gameObject:SetActive(true)

						arg_210_1.var_.actorSpriteSplit10183 = var_213_3.gameObject:GetComponent(typeof(Image))

						arg_210_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_213_4 = 0.5

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 then
				var_213_2.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_210_1.time_ - 0) / var_213_4)

				if arg_210_1.var_.actorSpriteSplit10183 ~= nil then
					arg_210_1.var_.actorSpriteSplit10183:SetAlpha((arg_210_1.time_ - 0) / var_213_4)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 then
				var_213_2.localPosition = Vector3.New(0, -475, -325)

				if arg_210_1.var_.actorSpriteSplit10183 ~= nil then
					arg_210_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_213_5 = 0
			local var_213_6 = 0.5

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_7 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(938041052).content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 20 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_7) / 20)

				if (20 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_7) / 20)) > 0 and var_213_6 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_5
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_6, arg_210_1.talkMaxDuration)

			if var_213_5 <= arg_210_1.time_ and arg_210_1.time_ < var_213_5 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_5) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_5 + var_213_10 and arg_210_1.time_ < var_213_5 + var_213_10 + arg_213_0 then
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
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["10183"]) and arg_214_1.var_.actorSpriteComps10183 == nil then
				arg_214_1.var_.actorSpriteComps10183 = arg_214_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_0 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["10183"]) then
				if arg_214_1.var_.actorSpriteComps10183 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								iter_217_1.color = Color.New(Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor2.r, (arg_214_1.time_ - 0) / var_217_0), Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor2.g, (arg_214_1.time_ - 0) / var_217_0), (Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor2.b, (arg_214_1.time_ - 0) / var_217_0)))
							else
								local var_217_1 = Mathf.Lerp(iter_217_1.color.r, 0.5, (arg_214_1.time_ - 0) / var_217_0)

								iter_217_1.color = Color.New(var_217_1, var_217_1, var_217_1)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["10183"]) and arg_214_1.var_.actorSpriteComps10183 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_217_3 then
						iter_217_3.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_214_1.var_.actorSpriteComps10183 = nil
			end

			local var_217_2 = arg_214_1.actors_["10183"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos10183 = var_217_2.localPosition
				var_217_2.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("10183", 7)

				for iter_217_4 = 0, var_217_2.childCount - 1 do
					local var_217_3 = var_217_2:GetChild(iter_217_4)

					if var_217_3.name == "" or not string.find(var_217_3.name, "split") then
						var_217_3.gameObject:SetActive(true)
					else
						var_217_3.gameObject:SetActive(false)
					end
				end
			end

			local var_217_4 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				var_217_2.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_214_1.time_ - 0) / var_217_4)
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				var_217_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_217_5 = 0
			local var_217_6 = 1.075

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_7 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(938041053).content)

				arg_214_1.text_.text = var_217_7

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 43 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_7) / 43)

				if (43 <= 0 and var_217_6 or var_217_6 * (utf8.len(var_217_7) / 43)) > 0 and var_217_6 < var_217_9 then
					arg_214_1.talkMaxDuration = var_217_9

					if var_217_9 + var_217_5 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_5
					end
				end

				arg_214_1.text_.text = var_217_7
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_6, arg_214_1.talkMaxDuration)

			if var_217_5 <= arg_214_1.time_ and arg_214_1.time_ < var_217_5 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_5) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_5 + var_217_10 and arg_214_1.time_ < var_217_5 + var_217_10 + arg_217_0 then
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
			local var_221_0 = 0.425

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[7].name)

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

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(938041054).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 17 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 17)

				if (17 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 17)) > 0 and var_221_0 < var_221_3 then
					arg_218_1.talkMaxDuration = var_221_3

					if var_221_3 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_3 + 0
					end
				end

				arg_218_1.text_.text = var_221_1
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_4 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_4

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
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
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["10183"]) and arg_222_1.var_.actorSpriteComps10183 == nil then
				arg_222_1.var_.actorSpriteComps10183 = arg_222_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["10183"]) then
				if arg_222_1.var_.actorSpriteComps10183 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 1, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["10183"]) and arg_222_1.var_.actorSpriteComps10183 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps10183 = nil
			end

			local var_225_2 = arg_222_1.actors_["10183"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos10183 = var_225_2.localPosition
				var_225_2.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("10183", 3)

				for iter_225_4 = 0, var_225_2.childCount - 1 do
					local var_225_3 = var_225_2:GetChild(iter_225_4)

					if var_225_3.name == "split_1" or not string.find(var_225_3.name, "split") then
						var_225_3.gameObject:SetActive(true)
					else
						var_225_3.gameObject:SetActive(false)
					end
				end
			end

			local var_225_4 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				var_225_2.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_222_1.time_ - 0) / var_225_4)
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				var_225_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_225_5 = 0
			local var_225_6 = 1.125

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_7 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(938041055).content)

				arg_222_1.text_.text = var_225_7

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_9 = 45 <= 0 and var_225_6 or var_225_6 * (utf8.len(var_225_7) / 45)

				if (45 <= 0 and var_225_6 or var_225_6 * (utf8.len(var_225_7) / 45)) > 0 and var_225_6 < var_225_9 then
					arg_222_1.talkMaxDuration = var_225_9

					if var_225_9 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_9 + var_225_5
					end
				end

				arg_222_1.text_.text = var_225_7
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_6, arg_222_1.talkMaxDuration)

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_5) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_5 + var_225_10 and arg_222_1.time_ < var_225_5 + var_225_10 + arg_225_0 then
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
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos10183 = arg_226_1.actors_["10183"].transform.localPosition
				arg_226_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_226_1:CheckSpriteTmpPos("10183", 3)

				for iter_229_0 = 0, arg_226_1.actors_["10183"].transform.childCount - 1 do
					local var_229_0 = arg_226_1.actors_["10183"].transform:GetChild(iter_229_0)

					if var_229_0.name == "" or not string.find(var_229_0.name, "split") then
						var_229_0.gameObject:SetActive(true)
					else
						var_229_0.gameObject:SetActive(false)
					end
				end
			end

			local var_229_1 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_1 then
				arg_226_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_226_1.time_ - 0) / var_229_1)
			end

			if arg_226_1.time_ >= 0 + var_229_1 and arg_226_1.time_ < 0 + var_229_1 + arg_229_0 then
				arg_226_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)
			end

			local var_229_2 = 0
			local var_229_3 = 0.25

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_4 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(938041056).content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_6 = 10 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_4) / 10)

				if (10 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_4) / 10)) > 0 and var_229_3 < var_229_6 then
					arg_226_1.talkMaxDuration = var_229_6

					if var_229_6 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_6 + var_229_2
					end
				end

				arg_226_1.text_.text = var_229_4
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_3, arg_226_1.talkMaxDuration)

			if var_229_2 <= arg_226_1.time_ and arg_226_1.time_ < var_229_2 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_2) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_2 + var_229_7 and arg_226_1.time_ < var_229_2 + var_229_7 + arg_229_0 then
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
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["10183"]) and arg_230_1.var_.actorSpriteComps10183 == nil then
				arg_230_1.var_.actorSpriteComps10183 = arg_230_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["10183"]) then
				if arg_230_1.var_.actorSpriteComps10183 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								iter_233_1.color = Color.New(Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor2.r, (arg_230_1.time_ - 0) / var_233_0), Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor2.g, (arg_230_1.time_ - 0) / var_233_0), (Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor2.b, (arg_230_1.time_ - 0) / var_233_0)))
							else
								local var_233_1 = Mathf.Lerp(iter_233_1.color.r, 0.5, (arg_230_1.time_ - 0) / var_233_0)

								iter_233_1.color = Color.New(var_233_1, var_233_1, var_233_1)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["10183"]) and arg_230_1.var_.actorSpriteComps10183 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_230_1.var_.actorSpriteComps10183 = nil
			end

			local var_233_2 = 0
			local var_233_3 = 0.425

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

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

				local var_233_4 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(938041057).content)

				arg_230_1.text_.text = var_233_4

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_6 = 17 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_4) / 17)

				if (17 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_4) / 17)) > 0 and var_233_3 < var_233_6 then
					arg_230_1.talkMaxDuration = var_233_6

					if var_233_6 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_6 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_4
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_7 and arg_230_1.time_ < var_233_2 + var_233_7 + arg_233_0 then
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
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["10183"]) and arg_234_1.var_.actorSpriteComps10183 == nil then
				arg_234_1.var_.actorSpriteComps10183 = arg_234_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_0 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["10183"]) then
				if arg_234_1.var_.actorSpriteComps10183 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								iter_237_1.color = Color.New(Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor1.r, (arg_234_1.time_ - 0) / var_237_0), Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor1.g, (arg_234_1.time_ - 0) / var_237_0), (Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor1.b, (arg_234_1.time_ - 0) / var_237_0)))
							else
								local var_237_1 = Mathf.Lerp(iter_237_1.color.r, 1, (arg_234_1.time_ - 0) / var_237_0)

								iter_237_1.color = Color.New(var_237_1, var_237_1, var_237_1)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["10183"]) and arg_234_1.var_.actorSpriteComps10183 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_237_3 then
						iter_237_3.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_234_1.var_.actorSpriteComps10183 = nil
			end

			local var_237_2 = arg_234_1.actors_["10183"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10183 = var_237_2.localPosition
				var_237_2.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10183", 3)

				for iter_237_4 = 0, var_237_2.childCount - 1 do
					local var_237_3 = var_237_2:GetChild(iter_237_4)

					if var_237_3.name == "split_7" then
						var_237_3:SetAsLastSibling()
						var_237_3.gameObject:SetActive(true)

						arg_234_1.var_.actorSpriteSplit10183 = var_237_3.gameObject:GetComponent(typeof(Image))

						arg_234_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_237_4 = 0.5

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 then
				var_237_2.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_234_1.time_ - 0) / var_237_4)

				if arg_234_1.var_.actorSpriteSplit10183 ~= nil then
					arg_234_1.var_.actorSpriteSplit10183:SetAlpha((arg_234_1.time_ - 0) / var_237_4)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 then
				var_237_2.localPosition = Vector3.New(0, -475, -325)

				if arg_234_1.var_.actorSpriteSplit10183 ~= nil then
					arg_234_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_237_5 = 0
			local var_237_6 = 0.525

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_5 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_7 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(938041058).content)

				arg_234_1.text_.text = var_237_7

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 21 <= 0 and var_237_6 or var_237_6 * (utf8.len(var_237_7) / 21)

				if (21 <= 0 and var_237_6 or var_237_6 * (utf8.len(var_237_7) / 21)) > 0 and var_237_6 < var_237_9 then
					arg_234_1.talkMaxDuration = var_237_9

					if var_237_9 + var_237_5 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_9 + var_237_5
					end
				end

				arg_234_1.text_.text = var_237_7
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_6, arg_234_1.talkMaxDuration)

			if var_237_5 <= arg_234_1.time_ and arg_234_1.time_ < var_237_5 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_5) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_5 + var_237_10 and arg_234_1.time_ < var_237_5 + var_237_10 + arg_237_0 then
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
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["10183"]) and arg_238_1.var_.actorSpriteComps10183 == nil then
				arg_238_1.var_.actorSpriteComps10183 = arg_238_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_0 = 0.2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["10183"]) then
				if arg_238_1.var_.actorSpriteComps10183 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_241_1 then
							if arg_238_1.isInRecall_ then
								iter_241_1.color = Color.New(Mathf.Lerp(iter_241_1.color.r, arg_238_1.hightColor2.r, (arg_238_1.time_ - 0) / var_241_0), Mathf.Lerp(iter_241_1.color.g, arg_238_1.hightColor2.g, (arg_238_1.time_ - 0) / var_241_0), (Mathf.Lerp(iter_241_1.color.b, arg_238_1.hightColor2.b, (arg_238_1.time_ - 0) / var_241_0)))
							else
								local var_241_1 = Mathf.Lerp(iter_241_1.color.r, 0.5, (arg_238_1.time_ - 0) / var_241_0)

								iter_241_1.color = Color.New(var_241_1, var_241_1, var_241_1)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["10183"]) and arg_238_1.var_.actorSpriteComps10183 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_241_3 then
						iter_241_3.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_238_1.var_.actorSpriteComps10183 = nil
			end

			local var_241_2 = 0
			local var_241_3 = 0.45

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

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

				local var_241_4 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(938041059).content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_6 = 18 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_4) / 18)

				if (18 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_4) / 18)) > 0 and var_241_3 < var_241_6 then
					arg_238_1.talkMaxDuration = var_241_6

					if var_241_6 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_6 + var_241_2
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_3, arg_238_1.talkMaxDuration)

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_2) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_2 + var_241_7 and arg_238_1.time_ < var_241_2 + var_241_7 + arg_241_0 then
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
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["10183"]) and arg_242_1.var_.actorSpriteComps10183 == nil then
				arg_242_1.var_.actorSpriteComps10183 = arg_242_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_0 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["10183"]) then
				if arg_242_1.var_.actorSpriteComps10183 then
					for iter_245_0, iter_245_1 in pairs(arg_242_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_245_1 then
							if arg_242_1.isInRecall_ then
								iter_245_1.color = Color.New(Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor1.r, (arg_242_1.time_ - 0) / var_245_0), Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor1.g, (arg_242_1.time_ - 0) / var_245_0), (Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor1.b, (arg_242_1.time_ - 0) / var_245_0)))
							else
								local var_245_1 = Mathf.Lerp(iter_245_1.color.r, 1, (arg_242_1.time_ - 0) / var_245_0)

								iter_245_1.color = Color.New(var_245_1, var_245_1, var_245_1)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["10183"]) and arg_242_1.var_.actorSpriteComps10183 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_245_3 then
						iter_245_3.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_242_1.var_.actorSpriteComps10183 = nil
			end

			local var_245_2 = arg_242_1.actors_["10183"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos10183 = var_245_2.localPosition
				var_245_2.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10183", 3)

				for iter_245_4 = 0, var_245_2.childCount - 1 do
					local var_245_3 = var_245_2:GetChild(iter_245_4)

					if var_245_3.name == "split_1" then
						var_245_3:SetAsLastSibling()
						var_245_3.gameObject:SetActive(true)

						arg_242_1.var_.actorSpriteSplit10183 = var_245_3.gameObject:GetComponent(typeof(Image))

						arg_242_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_245_4 = 0.5

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 then
				var_245_2.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_242_1.time_ - 0) / var_245_4)

				if arg_242_1.var_.actorSpriteSplit10183 ~= nil then
					arg_242_1.var_.actorSpriteSplit10183:SetAlpha((arg_242_1.time_ - 0) / var_245_4)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 then
				var_245_2.localPosition = Vector3.New(0, -475, -325)

				if arg_242_1.var_.actorSpriteSplit10183 ~= nil then
					arg_242_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_245_5 = 0
			local var_245_6 = 0.825

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_7 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(938041060).content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 33 <= 0 and var_245_6 or var_245_6 * (utf8.len(var_245_7) / 33)

				if (33 <= 0 and var_245_6 or var_245_6 * (utf8.len(var_245_7) / 33)) > 0 and var_245_6 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_5 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_5
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_10 = math.max(var_245_6, arg_242_1.talkMaxDuration)

			if var_245_5 <= arg_242_1.time_ and arg_242_1.time_ < var_245_5 + var_245_10 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_5) / var_245_10

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_5 + var_245_10 and arg_242_1.time_ < var_245_5 + var_245_10 + arg_245_0 then
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
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos10183 = arg_246_1.actors_["10183"].transform.localPosition
				arg_246_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("10183", 3)

				for iter_249_0 = 0, arg_246_1.actors_["10183"].transform.childCount - 1 do
					local var_249_0 = arg_246_1.actors_["10183"].transform:GetChild(iter_249_0)

					if var_249_0.name == "split_7" then
						var_249_0:SetAsLastSibling()
						var_249_0.gameObject:SetActive(true)

						arg_246_1.var_.actorSpriteSplit10183 = var_249_0.gameObject:GetComponent(typeof(Image))

						arg_246_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_249_1 = 0.5

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_1 then
				arg_246_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_246_1.time_ - 0) / var_249_1)

				if arg_246_1.var_.actorSpriteSplit10183 ~= nil then
					arg_246_1.var_.actorSpriteSplit10183:SetAlpha((arg_246_1.time_ - 0) / var_249_1)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_1 and arg_246_1.time_ < 0 + var_249_1 + arg_249_0 then
				arg_246_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_246_1.var_.actorSpriteSplit10183 ~= nil then
					arg_246_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_249_2 = 0
			local var_249_3 = 0.95

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_2 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_4 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(938041061).content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_6 = 38 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_4) / 38)

				if (38 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_4) / 38)) > 0 and var_249_3 < var_249_6 then
					arg_246_1.talkMaxDuration = var_249_6

					if var_249_6 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_2
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_3, arg_246_1.talkMaxDuration)

			if var_249_2 <= arg_246_1.time_ and arg_246_1.time_ < var_249_2 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_2) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_2 + var_249_7 and arg_246_1.time_ < var_249_2 + var_249_7 + arg_249_0 then
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
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["10183"]) and arg_250_1.var_.actorSpriteComps10183 == nil then
				arg_250_1.var_.actorSpriteComps10183 = arg_250_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_0 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["10183"]) then
				if arg_250_1.var_.actorSpriteComps10183 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								iter_253_1.color = Color.New(Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor2.r, (arg_250_1.time_ - 0) / var_253_0), Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor2.g, (arg_250_1.time_ - 0) / var_253_0), (Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor2.b, (arg_250_1.time_ - 0) / var_253_0)))
							else
								local var_253_1 = Mathf.Lerp(iter_253_1.color.r, 0.5, (arg_250_1.time_ - 0) / var_253_0)

								iter_253_1.color = Color.New(var_253_1, var_253_1, var_253_1)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["10183"]) and arg_250_1.var_.actorSpriteComps10183 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_253_3 then
						iter_253_3.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_250_1.var_.actorSpriteComps10183 = nil
			end

			local var_253_2 = 0
			local var_253_3 = 0.625

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[7].name)

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

				local var_253_4 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(938041062).content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_6 = 25 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_4) / 25)

				if (25 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_4) / 25)) > 0 and var_253_3 < var_253_6 then
					arg_250_1.talkMaxDuration = var_253_6

					if var_253_6 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_2
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_3, arg_250_1.talkMaxDuration)

			if var_253_2 <= arg_250_1.time_ and arg_250_1.time_ < var_253_2 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_2) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_2 + var_253_7 and arg_250_1.time_ < var_253_2 + var_253_7 + arg_253_0 then
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
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["10183"]) and arg_254_1.var_.actorSpriteComps10183 == nil then
				arg_254_1.var_.actorSpriteComps10183 = arg_254_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_0 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["10183"]) then
				if arg_254_1.var_.actorSpriteComps10183 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								iter_257_1.color = Color.New(Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor1.r, (arg_254_1.time_ - 0) / var_257_0), Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor1.g, (arg_254_1.time_ - 0) / var_257_0), (Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor1.b, (arg_254_1.time_ - 0) / var_257_0)))
							else
								local var_257_1 = Mathf.Lerp(iter_257_1.color.r, 1, (arg_254_1.time_ - 0) / var_257_0)

								iter_257_1.color = Color.New(var_257_1, var_257_1, var_257_1)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["10183"]) and arg_254_1.var_.actorSpriteComps10183 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_257_3 then
						iter_257_3.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_254_1.var_.actorSpriteComps10183 = nil
			end

			local var_257_2 = arg_254_1.actors_["10183"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos10183 = var_257_2.localPosition
				var_257_2.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("10183", 3)

				for iter_257_4 = 0, var_257_2.childCount - 1 do
					local var_257_3 = var_257_2:GetChild(iter_257_4)

					if var_257_3.name == "split_1" then
						var_257_3:SetAsLastSibling()
						var_257_3.gameObject:SetActive(true)

						arg_254_1.var_.actorSpriteSplit10183 = var_257_3.gameObject:GetComponent(typeof(Image))

						arg_254_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_257_4 = 0.5

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				var_257_2.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_254_1.time_ - 0) / var_257_4)

				if arg_254_1.var_.actorSpriteSplit10183 ~= nil then
					arg_254_1.var_.actorSpriteSplit10183:SetAlpha((arg_254_1.time_ - 0) / var_257_4)
				end
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				var_257_2.localPosition = Vector3.New(0, -475, -325)

				if arg_254_1.var_.actorSpriteSplit10183 ~= nil then
					arg_254_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_257_5 = 0
			local var_257_6 = 0.175

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_5 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_7 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(938041063).content)

				arg_254_1.text_.text = var_257_7

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_9 = 7 <= 0 and var_257_6 or var_257_6 * (utf8.len(var_257_7) / 7)

				if (7 <= 0 and var_257_6 or var_257_6 * (utf8.len(var_257_7) / 7)) > 0 and var_257_6 < var_257_9 then
					arg_254_1.talkMaxDuration = var_257_9

					if var_257_9 + var_257_5 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_9 + var_257_5
					end
				end

				arg_254_1.text_.text = var_257_7
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_6, arg_254_1.talkMaxDuration)

			if var_257_5 <= arg_254_1.time_ and arg_254_1.time_ < var_257_5 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_5) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_5 + var_257_10 and arg_254_1.time_ < var_257_5 + var_257_10 + arg_257_0 then
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
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["10183"]) and arg_258_1.var_.actorSpriteComps10183 == nil then
				arg_258_1.var_.actorSpriteComps10183 = arg_258_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_0 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["10183"]) then
				if arg_258_1.var_.actorSpriteComps10183 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_261_1 then
							if arg_258_1.isInRecall_ then
								iter_261_1.color = Color.New(Mathf.Lerp(iter_261_1.color.r, arg_258_1.hightColor2.r, (arg_258_1.time_ - 0) / var_261_0), Mathf.Lerp(iter_261_1.color.g, arg_258_1.hightColor2.g, (arg_258_1.time_ - 0) / var_261_0), (Mathf.Lerp(iter_261_1.color.b, arg_258_1.hightColor2.b, (arg_258_1.time_ - 0) / var_261_0)))
							else
								local var_261_1 = Mathf.Lerp(iter_261_1.color.r, 0.5, (arg_258_1.time_ - 0) / var_261_0)

								iter_261_1.color = Color.New(var_261_1, var_261_1, var_261_1)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["10183"]) and arg_258_1.var_.actorSpriteComps10183 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_261_3 then
						iter_261_3.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_258_1.var_.actorSpriteComps10183 = nil
			end

			local var_261_2 = 0
			local var_261_3 = 0.3

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_2 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[7].name)

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

				local var_261_4 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(938041064).content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_6 = 12 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_4) / 12)

				if (12 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_4) / 12)) > 0 and var_261_3 < var_261_6 then
					arg_258_1.talkMaxDuration = var_261_6

					if var_261_6 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_6 + var_261_2
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_3, arg_258_1.talkMaxDuration)

			if var_261_2 <= arg_258_1.time_ and arg_258_1.time_ < var_261_2 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_2) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_2 + var_261_7 and arg_258_1.time_ < var_261_2 + var_261_7 + arg_261_0 then
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
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["10183"]) and arg_262_1.var_.actorSpriteComps10183 == nil then
				arg_262_1.var_.actorSpriteComps10183 = arg_262_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_265_0 = 0.2

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["10183"]) then
				if arg_262_1.var_.actorSpriteComps10183 then
					for iter_265_0, iter_265_1 in pairs(arg_262_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_265_1 then
							if arg_262_1.isInRecall_ then
								iter_265_1.color = Color.New(Mathf.Lerp(iter_265_1.color.r, arg_262_1.hightColor1.r, (arg_262_1.time_ - 0) / var_265_0), Mathf.Lerp(iter_265_1.color.g, arg_262_1.hightColor1.g, (arg_262_1.time_ - 0) / var_265_0), (Mathf.Lerp(iter_265_1.color.b, arg_262_1.hightColor1.b, (arg_262_1.time_ - 0) / var_265_0)))
							else
								local var_265_1 = Mathf.Lerp(iter_265_1.color.r, 1, (arg_262_1.time_ - 0) / var_265_0)

								iter_265_1.color = Color.New(var_265_1, var_265_1, var_265_1)
							end
						end
					end
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["10183"]) and arg_262_1.var_.actorSpriteComps10183 then
				for iter_265_2, iter_265_3 in pairs(arg_262_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_265_3 then
						iter_265_3.color = arg_262_1.isInRecall_ and (arg_262_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_262_1.var_.actorSpriteComps10183 = nil
			end

			local var_265_2 = arg_262_1.actors_["10183"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos10183 = var_265_2.localPosition
				var_265_2.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("10183", 3)

				for iter_265_4 = 0, var_265_2.childCount - 1 do
					local var_265_3 = var_265_2:GetChild(iter_265_4)

					if var_265_3.name == "" or not string.find(var_265_3.name, "split") then
						var_265_3.gameObject:SetActive(true)
					else
						var_265_3.gameObject:SetActive(false)
					end
				end
			end

			local var_265_4 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				var_265_2.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_262_1.time_ - 0) / var_265_4)
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				var_265_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_265_5 = 0
			local var_265_6 = 0.7

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_5 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_7 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(938041065).content)

				arg_262_1.text_.text = var_265_7

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_9 = 28 <= 0 and var_265_6 or var_265_6 * (utf8.len(var_265_7) / 28)

				if (28 <= 0 and var_265_6 or var_265_6 * (utf8.len(var_265_7) / 28)) > 0 and var_265_6 < var_265_9 then
					arg_262_1.talkMaxDuration = var_265_9

					if var_265_9 + var_265_5 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_9 + var_265_5
					end
				end

				arg_262_1.text_.text = var_265_7
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_10 = math.max(var_265_6, arg_262_1.talkMaxDuration)

			if var_265_5 <= arg_262_1.time_ and arg_262_1.time_ < var_265_5 + var_265_10 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_5) / var_265_10

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_5 + var_265_10 and arg_262_1.time_ < var_265_5 + var_265_10 + arg_265_0 then
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
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["10183"]) and arg_266_1.var_.actorSpriteComps10183 == nil then
				arg_266_1.var_.actorSpriteComps10183 = arg_266_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_0 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["10183"]) then
				if arg_266_1.var_.actorSpriteComps10183 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_269_1 then
							if arg_266_1.isInRecall_ then
								iter_269_1.color = Color.New(Mathf.Lerp(iter_269_1.color.r, arg_266_1.hightColor2.r, (arg_266_1.time_ - 0) / var_269_0), Mathf.Lerp(iter_269_1.color.g, arg_266_1.hightColor2.g, (arg_266_1.time_ - 0) / var_269_0), (Mathf.Lerp(iter_269_1.color.b, arg_266_1.hightColor2.b, (arg_266_1.time_ - 0) / var_269_0)))
							else
								local var_269_1 = Mathf.Lerp(iter_269_1.color.r, 0.5, (arg_266_1.time_ - 0) / var_269_0)

								iter_269_1.color = Color.New(var_269_1, var_269_1, var_269_1)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["10183"]) and arg_266_1.var_.actorSpriteComps10183 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_269_3 then
						iter_269_3.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_266_1.var_.actorSpriteComps10183 = nil
			end

			local var_269_2 = arg_266_1.actors_["10183"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos10183 = var_269_2.localPosition
				var_269_2.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("10183", 7)

				for iter_269_4 = 0, var_269_2.childCount - 1 do
					local var_269_3 = var_269_2:GetChild(iter_269_4)

					if var_269_3.name == "" or not string.find(var_269_3.name, "split") then
						var_269_3.gameObject:SetActive(true)
					else
						var_269_3.gameObject:SetActive(false)
					end
				end
			end

			local var_269_4 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 then
				var_269_2.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_266_1.time_ - 0) / var_269_4)
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 then
				var_269_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_269_5 = 0
			local var_269_6 = 0.925

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_7 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(938041066).content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 37 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_7) / 37)

				if (37 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_7) / 37)) > 0 and var_269_6 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_5 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_5
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_6, arg_266_1.talkMaxDuration)

			if var_269_5 <= arg_266_1.time_ and arg_266_1.time_ < var_269_5 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_5) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_5 + var_269_10 and arg_266_1.time_ < var_269_5 + var_269_10 + arg_269_0 then
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
			local var_273_0 = 0.475

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[7].name)

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

				local var_273_1 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(938041067).content)

				arg_270_1.text_.text = var_273_1

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_3 = 19 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 19)

				if (19 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 19)) > 0 and var_273_0 < var_273_3 then
					arg_270_1.talkMaxDuration = var_273_3

					if var_273_3 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_3 + 0
					end
				end

				arg_270_1.text_.text = var_273_1
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_4 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_4

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
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
			local var_277_0 = 0.425

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[7].name)

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

				local var_277_1 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(938041068).content)

				arg_274_1.text_.text = var_277_1

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_3 = 17 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 17)

				if (17 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 17)) > 0 and var_277_0 < var_277_3 then
					arg_274_1.talkMaxDuration = var_277_3

					if var_277_3 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_3 + 0
					end
				end

				arg_274_1.text_.text = var_277_1
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_4 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_4

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
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
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["10183"]) and arg_278_1.var_.actorSpriteComps10183 == nil then
				arg_278_1.var_.actorSpriteComps10183 = arg_278_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_0 = 0.2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["10183"]) then
				if arg_278_1.var_.actorSpriteComps10183 then
					for iter_281_0, iter_281_1 in pairs(arg_278_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_281_1 then
							if arg_278_1.isInRecall_ then
								iter_281_1.color = Color.New(Mathf.Lerp(iter_281_1.color.r, arg_278_1.hightColor1.r, (arg_278_1.time_ - 0) / var_281_0), Mathf.Lerp(iter_281_1.color.g, arg_278_1.hightColor1.g, (arg_278_1.time_ - 0) / var_281_0), (Mathf.Lerp(iter_281_1.color.b, arg_278_1.hightColor1.b, (arg_278_1.time_ - 0) / var_281_0)))
							else
								local var_281_1 = Mathf.Lerp(iter_281_1.color.r, 1, (arg_278_1.time_ - 0) / var_281_0)

								iter_281_1.color = Color.New(var_281_1, var_281_1, var_281_1)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["10183"]) and arg_278_1.var_.actorSpriteComps10183 then
				for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_281_3 then
						iter_281_3.color = arg_278_1.isInRecall_ and (arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_278_1.var_.actorSpriteComps10183 = nil
			end

			local var_281_2 = arg_278_1.actors_["10183"].transform

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos10183 = var_281_2.localPosition
				var_281_2.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("10183", 3)

				for iter_281_4 = 0, var_281_2.childCount - 1 do
					local var_281_3 = var_281_2:GetChild(iter_281_4)

					if var_281_3.name == "split_4" or not string.find(var_281_3.name, "split") then
						var_281_3.gameObject:SetActive(true)
					else
						var_281_3.gameObject:SetActive(false)
					end
				end
			end

			local var_281_4 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				var_281_2.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_278_1.time_ - 0) / var_281_4)
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				var_281_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_281_5 = 0
			local var_281_6 = 0.275

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_7 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(938041069).content)

				arg_278_1.text_.text = var_281_7

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_9 = 11 <= 0 and var_281_6 or var_281_6 * (utf8.len(var_281_7) / 11)

				if (11 <= 0 and var_281_6 or var_281_6 * (utf8.len(var_281_7) / 11)) > 0 and var_281_6 < var_281_9 then
					arg_278_1.talkMaxDuration = var_281_9

					if var_281_9 + var_281_5 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_5
					end
				end

				arg_278_1.text_.text = var_281_7
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_6, arg_278_1.talkMaxDuration)

			if var_281_5 <= arg_278_1.time_ and arg_278_1.time_ < var_281_5 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_5) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_5 + var_281_10 and arg_278_1.time_ < var_281_5 + var_281_10 + arg_281_0 then
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
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["10183"]) and arg_282_1.var_.actorSpriteComps10183 == nil then
				arg_282_1.var_.actorSpriteComps10183 = arg_282_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_0 = 0.2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["10183"]) then
				if arg_282_1.var_.actorSpriteComps10183 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_285_1 then
							if arg_282_1.isInRecall_ then
								iter_285_1.color = Color.New(Mathf.Lerp(iter_285_1.color.r, arg_282_1.hightColor2.r, (arg_282_1.time_ - 0) / var_285_0), Mathf.Lerp(iter_285_1.color.g, arg_282_1.hightColor2.g, (arg_282_1.time_ - 0) / var_285_0), (Mathf.Lerp(iter_285_1.color.b, arg_282_1.hightColor2.b, (arg_282_1.time_ - 0) / var_285_0)))
							else
								local var_285_1 = Mathf.Lerp(iter_285_1.color.r, 0.5, (arg_282_1.time_ - 0) / var_285_0)

								iter_285_1.color = Color.New(var_285_1, var_285_1, var_285_1)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["10183"]) and arg_282_1.var_.actorSpriteComps10183 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_285_3 then
						iter_285_3.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_282_1.var_.actorSpriteComps10183 = nil
			end

			local var_285_2 = 0
			local var_285_3 = 0.425

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_2 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[7].name)

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

				local var_285_4 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(938041070).content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_6 = 17 <= 0 and var_285_3 or var_285_3 * (utf8.len(var_285_4) / 17)

				if (17 <= 0 and var_285_3 or var_285_3 * (utf8.len(var_285_4) / 17)) > 0 and var_285_3 < var_285_6 then
					arg_282_1.talkMaxDuration = var_285_6

					if var_285_6 + var_285_2 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_2
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_3, arg_282_1.talkMaxDuration)

			if var_285_2 <= arg_282_1.time_ and arg_282_1.time_ < var_285_2 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_2) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_2 + var_285_7 and arg_282_1.time_ < var_285_2 + var_285_7 + arg_285_0 then
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
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["10183"]) and arg_286_1.var_.actorSpriteComps10183 == nil then
				arg_286_1.var_.actorSpriteComps10183 = arg_286_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_0 = 0.2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["10183"]) then
				if arg_286_1.var_.actorSpriteComps10183 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_289_1 then
							if arg_286_1.isInRecall_ then
								iter_289_1.color = Color.New(Mathf.Lerp(iter_289_1.color.r, arg_286_1.hightColor1.r, (arg_286_1.time_ - 0) / var_289_0), Mathf.Lerp(iter_289_1.color.g, arg_286_1.hightColor1.g, (arg_286_1.time_ - 0) / var_289_0), (Mathf.Lerp(iter_289_1.color.b, arg_286_1.hightColor1.b, (arg_286_1.time_ - 0) / var_289_0)))
							else
								local var_289_1 = Mathf.Lerp(iter_289_1.color.r, 1, (arg_286_1.time_ - 0) / var_289_0)

								iter_289_1.color = Color.New(var_289_1, var_289_1, var_289_1)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["10183"]) and arg_286_1.var_.actorSpriteComps10183 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_289_3 then
						iter_289_3.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_286_1.var_.actorSpriteComps10183 = nil
			end

			local var_289_2 = arg_286_1.actors_["10183"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos10183 = var_289_2.localPosition
				var_289_2.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("10183", 3)

				for iter_289_4 = 0, var_289_2.childCount - 1 do
					local var_289_3 = var_289_2:GetChild(iter_289_4)

					if var_289_3.name == "" then
						var_289_3:SetAsLastSibling()
						var_289_3.gameObject:SetActive(true)

						arg_286_1.var_.actorSpriteSplit10183 = var_289_3.gameObject:GetComponent(typeof(Image))

						arg_286_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_289_4 = 0.5

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				var_289_2.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_286_1.time_ - 0) / var_289_4)

				if arg_286_1.var_.actorSpriteSplit10183 ~= nil then
					arg_286_1.var_.actorSpriteSplit10183:SetAlpha((arg_286_1.time_ - 0) / var_289_4)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				var_289_2.localPosition = Vector3.New(0, -475, -325)

				if arg_286_1.var_.actorSpriteSplit10183 ~= nil then
					arg_286_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_289_5 = 0
			local var_289_6 = 0.175

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_5 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_7 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(938041071).content)

				arg_286_1.text_.text = var_289_7

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_9 = 7 <= 0 and var_289_6 or var_289_6 * (utf8.len(var_289_7) / 7)

				if (7 <= 0 and var_289_6 or var_289_6 * (utf8.len(var_289_7) / 7)) > 0 and var_289_6 < var_289_9 then
					arg_286_1.talkMaxDuration = var_289_9

					if var_289_9 + var_289_5 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_9 + var_289_5
					end
				end

				arg_286_1.text_.text = var_289_7
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_6, arg_286_1.talkMaxDuration)

			if var_289_5 <= arg_286_1.time_ and arg_286_1.time_ < var_289_5 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_5) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_5 + var_289_10 and arg_286_1.time_ < var_289_5 + var_289_10 + arg_289_0 then
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
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["10183"]) and arg_290_1.var_.actorSpriteComps10183 == nil then
				arg_290_1.var_.actorSpriteComps10183 = arg_290_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_0 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["10183"]) then
				if arg_290_1.var_.actorSpriteComps10183 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								iter_293_1.color = Color.New(Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor2.r, (arg_290_1.time_ - 0) / var_293_0), Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor2.g, (arg_290_1.time_ - 0) / var_293_0), (Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor2.b, (arg_290_1.time_ - 0) / var_293_0)))
							else
								local var_293_1 = Mathf.Lerp(iter_293_1.color.r, 0.5, (arg_290_1.time_ - 0) / var_293_0)

								iter_293_1.color = Color.New(var_293_1, var_293_1, var_293_1)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["10183"]) and arg_290_1.var_.actorSpriteComps10183 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_293_3 then
						iter_293_3.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_290_1.var_.actorSpriteComps10183 = nil
			end

			local var_293_2 = 0
			local var_293_3 = 0.4

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

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

				local var_293_4 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(938041072).content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_6 = 16 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_4) / 16)

				if (16 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_4) / 16)) > 0 and var_293_3 < var_293_6 then
					arg_290_1.talkMaxDuration = var_293_6

					if var_293_6 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_2
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_3, arg_290_1.talkMaxDuration)

			if var_293_2 <= arg_290_1.time_ and arg_290_1.time_ < var_293_2 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_2) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_2 + var_293_7 and arg_290_1.time_ < var_293_2 + var_293_7 + arg_293_0 then
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
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["10183"]) and arg_294_1.var_.actorSpriteComps10183 == nil then
				arg_294_1.var_.actorSpriteComps10183 = arg_294_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_0 = 0.2

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["10183"]) then
				if arg_294_1.var_.actorSpriteComps10183 then
					for iter_297_0, iter_297_1 in pairs(arg_294_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_297_1 then
							if arg_294_1.isInRecall_ then
								iter_297_1.color = Color.New(Mathf.Lerp(iter_297_1.color.r, arg_294_1.hightColor1.r, (arg_294_1.time_ - 0) / var_297_0), Mathf.Lerp(iter_297_1.color.g, arg_294_1.hightColor1.g, (arg_294_1.time_ - 0) / var_297_0), (Mathf.Lerp(iter_297_1.color.b, arg_294_1.hightColor1.b, (arg_294_1.time_ - 0) / var_297_0)))
							else
								local var_297_1 = Mathf.Lerp(iter_297_1.color.r, 1, (arg_294_1.time_ - 0) / var_297_0)

								iter_297_1.color = Color.New(var_297_1, var_297_1, var_297_1)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["10183"]) and arg_294_1.var_.actorSpriteComps10183 then
				for iter_297_2, iter_297_3 in pairs(arg_294_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_297_3 then
						iter_297_3.color = arg_294_1.isInRecall_ and (arg_294_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_294_1.var_.actorSpriteComps10183 = nil
			end

			local var_297_2 = arg_294_1.actors_["10183"].transform

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos10183 = var_297_2.localPosition
				var_297_2.localScale = Vector3.New(1, 1, 1)

				arg_294_1:CheckSpriteTmpPos("10183", 3)

				for iter_297_4 = 0, var_297_2.childCount - 1 do
					local var_297_3 = var_297_2:GetChild(iter_297_4)

					if var_297_3.name == "" or not string.find(var_297_3.name, "split") then
						var_297_3.gameObject:SetActive(true)
					else
						var_297_3.gameObject:SetActive(false)
					end
				end
			end

			local var_297_4 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_4 then
				var_297_2.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_294_1.time_ - 0) / var_297_4)
			end

			if arg_294_1.time_ >= 0 + var_297_4 and arg_294_1.time_ < 0 + var_297_4 + arg_297_0 then
				var_297_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_297_5 = 0
			local var_297_6 = 0.45

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_5 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_7 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(938041073).content)

				arg_294_1.text_.text = var_297_7

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_9 = 18 <= 0 and var_297_6 or var_297_6 * (utf8.len(var_297_7) / 18)

				if (18 <= 0 and var_297_6 or var_297_6 * (utf8.len(var_297_7) / 18)) > 0 and var_297_6 < var_297_9 then
					arg_294_1.talkMaxDuration = var_297_9

					if var_297_9 + var_297_5 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_9 + var_297_5
					end
				end

				arg_294_1.text_.text = var_297_7
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_6, arg_294_1.talkMaxDuration)

			if var_297_5 <= arg_294_1.time_ and arg_294_1.time_ < var_297_5 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_5) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_5 + var_297_10 and arg_294_1.time_ < var_297_5 + var_297_10 + arg_297_0 then
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
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["10183"]) and arg_298_1.var_.actorSpriteComps10183 == nil then
				arg_298_1.var_.actorSpriteComps10183 = arg_298_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_0 = 0.2

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["10183"]) then
				if arg_298_1.var_.actorSpriteComps10183 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								iter_301_1.color = Color.New(Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor2.r, (arg_298_1.time_ - 0) / var_301_0), Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor2.g, (arg_298_1.time_ - 0) / var_301_0), (Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor2.b, (arg_298_1.time_ - 0) / var_301_0)))
							else
								local var_301_1 = Mathf.Lerp(iter_301_1.color.r, 0.5, (arg_298_1.time_ - 0) / var_301_0)

								iter_301_1.color = Color.New(var_301_1, var_301_1, var_301_1)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["10183"]) and arg_298_1.var_.actorSpriteComps10183 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_301_3 then
						iter_301_3.color = arg_298_1.isInRecall_ and (arg_298_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_298_1.var_.actorSpriteComps10183 = nil
			end

			local var_301_2 = 0
			local var_301_3 = 0.35

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_2 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[7].name)

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

				local var_301_4 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(938041074).content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_6 = 14 <= 0 and var_301_3 or var_301_3 * (utf8.len(var_301_4) / 14)

				if (14 <= 0 and var_301_3 or var_301_3 * (utf8.len(var_301_4) / 14)) > 0 and var_301_3 < var_301_6 then
					arg_298_1.talkMaxDuration = var_301_6

					if var_301_6 + var_301_2 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_6 + var_301_2
					end
				end

				arg_298_1.text_.text = var_301_4
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_3, arg_298_1.talkMaxDuration)

			if var_301_2 <= arg_298_1.time_ and arg_298_1.time_ < var_301_2 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_2) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_2 + var_301_7 and arg_298_1.time_ < var_301_2 + var_301_7 + arg_301_0 then
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
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["10183"]) and arg_302_1.var_.actorSpriteComps10183 == nil then
				arg_302_1.var_.actorSpriteComps10183 = arg_302_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_0 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["10183"]) then
				if arg_302_1.var_.actorSpriteComps10183 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								iter_305_1.color = Color.New(Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor1.r, (arg_302_1.time_ - 0) / var_305_0), Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor1.g, (arg_302_1.time_ - 0) / var_305_0), (Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor1.b, (arg_302_1.time_ - 0) / var_305_0)))
							else
								local var_305_1 = Mathf.Lerp(iter_305_1.color.r, 1, (arg_302_1.time_ - 0) / var_305_0)

								iter_305_1.color = Color.New(var_305_1, var_305_1, var_305_1)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["10183"]) and arg_302_1.var_.actorSpriteComps10183 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_305_3 then
						iter_305_3.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_302_1.var_.actorSpriteComps10183 = nil
			end

			local var_305_2 = arg_302_1.actors_["10183"].transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos10183 = var_305_2.localPosition
				var_305_2.localScale = Vector3.New(1, 1, 1)

				arg_302_1:CheckSpriteTmpPos("10183", 3)

				for iter_305_4 = 0, var_305_2.childCount - 1 do
					local var_305_3 = var_305_2:GetChild(iter_305_4)

					if var_305_3.name == "split_8" then
						var_305_3:SetAsLastSibling()
						var_305_3.gameObject:SetActive(true)

						arg_302_1.var_.actorSpriteSplit10183 = var_305_3.gameObject:GetComponent(typeof(Image))

						arg_302_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_305_4 = 0.5

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				var_305_2.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_302_1.time_ - 0) / var_305_4)

				if arg_302_1.var_.actorSpriteSplit10183 ~= nil then
					arg_302_1.var_.actorSpriteSplit10183:SetAlpha((arg_302_1.time_ - 0) / var_305_4)
				end
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				var_305_2.localPosition = Vector3.New(0, -475, -325)

				if arg_302_1.var_.actorSpriteSplit10183 ~= nil then
					arg_302_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_305_5 = 0
			local var_305_6 = 1.575

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_7 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(938041075).content)

				arg_302_1.text_.text = var_305_7

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_9 = 63 <= 0 and var_305_6 or var_305_6 * (utf8.len(var_305_7) / 63)

				if (63 <= 0 and var_305_6 or var_305_6 * (utf8.len(var_305_7) / 63)) > 0 and var_305_6 < var_305_9 then
					arg_302_1.talkMaxDuration = var_305_9

					if var_305_9 + var_305_5 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_9 + var_305_5
					end
				end

				arg_302_1.text_.text = var_305_7
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_10 = math.max(var_305_6, arg_302_1.talkMaxDuration)

			if var_305_5 <= arg_302_1.time_ and arg_302_1.time_ < var_305_5 + var_305_10 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_5) / var_305_10

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_5 + var_305_10 and arg_302_1.time_ < var_305_5 + var_305_10 + arg_305_0 then
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
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.var_.moveOldPos10183 = arg_306_1.actors_["10183"].transform.localPosition
				arg_306_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("10183", 3)

				for iter_309_0 = 0, arg_306_1.actors_["10183"].transform.childCount - 1 do
					local var_309_0 = arg_306_1.actors_["10183"].transform:GetChild(iter_309_0)

					if var_309_0.name == "" or not string.find(var_309_0.name, "split") then
						var_309_0.gameObject:SetActive(true)
					else
						var_309_0.gameObject:SetActive(false)
					end
				end
			end

			local var_309_1 = 0.001

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_1 then
				arg_306_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_306_1.time_ - 0) / var_309_1)
			end

			if arg_306_1.time_ >= 0 + var_309_1 and arg_306_1.time_ < 0 + var_309_1 + arg_309_0 then
				arg_306_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)
			end

			local var_309_2 = 0
			local var_309_3 = 1.1

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_2 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_4 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(938041076).content)

				arg_306_1.text_.text = var_309_4

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_6 = 44 <= 0 and var_309_3 or var_309_3 * (utf8.len(var_309_4) / 44)

				if (44 <= 0 and var_309_3 or var_309_3 * (utf8.len(var_309_4) / 44)) > 0 and var_309_3 < var_309_6 then
					arg_306_1.talkMaxDuration = var_309_6

					if var_309_6 + var_309_2 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_6 + var_309_2
					end
				end

				arg_306_1.text_.text = var_309_4
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_3, arg_306_1.talkMaxDuration)

			if var_309_2 <= arg_306_1.time_ and arg_306_1.time_ < var_309_2 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_2) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_2 + var_309_7 and arg_306_1.time_ < var_309_2 + var_309_7 + arg_309_0 then
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
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["10183"]) and arg_310_1.var_.actorSpriteComps10183 == nil then
				arg_310_1.var_.actorSpriteComps10183 = arg_310_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_0 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["10183"]) then
				if arg_310_1.var_.actorSpriteComps10183 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								iter_313_1.color = Color.New(Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor2.r, (arg_310_1.time_ - 0) / var_313_0), Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor2.g, (arg_310_1.time_ - 0) / var_313_0), (Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor2.b, (arg_310_1.time_ - 0) / var_313_0)))
							else
								local var_313_1 = Mathf.Lerp(iter_313_1.color.r, 0.5, (arg_310_1.time_ - 0) / var_313_0)

								iter_313_1.color = Color.New(var_313_1, var_313_1, var_313_1)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["10183"]) and arg_310_1.var_.actorSpriteComps10183 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_313_3 then
						iter_313_3.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_310_1.var_.actorSpriteComps10183 = nil
			end

			local var_313_2 = 0
			local var_313_3 = 0.475

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[7].name)

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

				local var_313_4 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(938041077).content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_6 = 19 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_4) / 19)

				if (19 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_4) / 19)) > 0 and var_313_3 < var_313_6 then
					arg_310_1.talkMaxDuration = var_313_6

					if var_313_6 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_2
					end
				end

				arg_310_1.text_.text = var_313_4
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_3, arg_310_1.talkMaxDuration)

			if var_313_2 <= arg_310_1.time_ and arg_310_1.time_ < var_313_2 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_2) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_2 + var_313_7 and arg_310_1.time_ < var_313_2 + var_313_7 + arg_313_0 then
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
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["10183"]) and arg_314_1.var_.actorSpriteComps10183 == nil then
				arg_314_1.var_.actorSpriteComps10183 = arg_314_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_0 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["10183"]) then
				if arg_314_1.var_.actorSpriteComps10183 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								iter_317_1.color = Color.New(Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor1.r, (arg_314_1.time_ - 0) / var_317_0), Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor1.g, (arg_314_1.time_ - 0) / var_317_0), (Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor1.b, (arg_314_1.time_ - 0) / var_317_0)))
							else
								local var_317_1 = Mathf.Lerp(iter_317_1.color.r, 1, (arg_314_1.time_ - 0) / var_317_0)

								iter_317_1.color = Color.New(var_317_1, var_317_1, var_317_1)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["10183"]) and arg_314_1.var_.actorSpriteComps10183 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_317_3 then
						iter_317_3.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_314_1.var_.actorSpriteComps10183 = nil
			end

			local var_317_2 = arg_314_1.actors_["10183"].transform

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos10183 = var_317_2.localPosition
				var_317_2.localScale = Vector3.New(1, 1, 1)

				arg_314_1:CheckSpriteTmpPos("10183", 3)

				for iter_317_4 = 0, var_317_2.childCount - 1 do
					local var_317_3 = var_317_2:GetChild(iter_317_4)

					if var_317_3.name == "split_2" then
						var_317_3:SetAsLastSibling()
						var_317_3.gameObject:SetActive(true)

						arg_314_1.var_.actorSpriteSplit10183 = var_317_3.gameObject:GetComponent(typeof(Image))

						arg_314_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_317_4 = 0.5

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_4 then
				var_317_2.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_314_1.time_ - 0) / var_317_4)

				if arg_314_1.var_.actorSpriteSplit10183 ~= nil then
					arg_314_1.var_.actorSpriteSplit10183:SetAlpha((arg_314_1.time_ - 0) / var_317_4)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_4 and arg_314_1.time_ < 0 + var_317_4 + arg_317_0 then
				var_317_2.localPosition = Vector3.New(0, -475, -325)

				if arg_314_1.var_.actorSpriteSplit10183 ~= nil then
					arg_314_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_317_5 = 0
			local var_317_6 = 0.225

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_7 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(938041078).content)

				arg_314_1.text_.text = var_317_7

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_9 = 9 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_7) / 9)

				if (9 <= 0 and var_317_6 or var_317_6 * (utf8.len(var_317_7) / 9)) > 0 and var_317_6 < var_317_9 then
					arg_314_1.talkMaxDuration = var_317_9

					if var_317_9 + var_317_5 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_9 + var_317_5
					end
				end

				arg_314_1.text_.text = var_317_7
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_10 = math.max(var_317_6, arg_314_1.talkMaxDuration)

			if var_317_5 <= arg_314_1.time_ and arg_314_1.time_ < var_317_5 + var_317_10 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_5) / var_317_10

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_5 + var_317_10 and arg_314_1.time_ < var_317_5 + var_317_10 + arg_317_0 then
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
			local var_321_0 = 1.075

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[1297].name)

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

				local var_321_1 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(938041079).content)

				arg_318_1.text_.text = var_321_1

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_3 = 43 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 43)

				if (43 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 43)) > 0 and var_321_0 < var_321_3 then
					arg_318_1.talkMaxDuration = var_321_3

					if var_321_3 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_3 + 0
					end
				end

				arg_318_1.text_.text = var_321_1
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_4 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_4

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
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
			if arg_322_1.actors_["10144"] == nil then
				local var_325_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_325_0) then
					local var_325_1 = Object.Instantiate(var_325_0, arg_322_1.canvasGo_.transform)

					var_325_1.transform:SetSiblingIndex(1)

					var_325_1.name = "10144"
					var_325_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_322_1.actors_["10144"] = var_325_1

					if arg_322_1.isInRecall_ then
						for iter_325_0, iter_325_1 in ipairs((var_325_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_325_1.color = arg_322_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_325_2 = arg_322_1.actors_["10144"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_2) and arg_322_1.var_.actorSpriteComps10144 == nil then
				arg_322_1.var_.actorSpriteComps10144 = var_325_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_3 = 0.2

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_3 and not isNil(var_325_2) then
				if arg_322_1.var_.actorSpriteComps10144 then
					for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_325_3 then
							if arg_322_1.isInRecall_ then
								iter_325_3.color = Color.New(Mathf.Lerp(iter_325_3.color.r, arg_322_1.hightColor2.r, (arg_322_1.time_ - 0) / var_325_3), Mathf.Lerp(iter_325_3.color.g, arg_322_1.hightColor2.g, (arg_322_1.time_ - 0) / var_325_3), (Mathf.Lerp(iter_325_3.color.b, arg_322_1.hightColor2.b, (arg_322_1.time_ - 0) / var_325_3)))
							else
								local var_325_4 = Mathf.Lerp(iter_325_3.color.r, 0.5, (arg_322_1.time_ - 0) / var_325_3)

								iter_325_3.color = Color.New(var_325_4, var_325_4, var_325_4)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= 0 + var_325_3 and arg_322_1.time_ < 0 + var_325_3 + arg_325_0 and not isNil(var_325_2) and arg_322_1.var_.actorSpriteComps10144 then
				for iter_325_4, iter_325_5 in pairs(arg_322_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_325_5 then
						iter_325_5.color = arg_322_1.isInRecall_ and (arg_322_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_322_1.var_.actorSpriteComps10144 = nil
			end

			local var_325_5 = arg_322_1.actors_["10183"].transform

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos10183 = var_325_5.localPosition
				var_325_5.localScale = Vector3.New(1, 1, 1)

				arg_322_1:CheckSpriteTmpPos("10183", 7)

				for iter_325_6 = 0, var_325_5.childCount - 1 do
					local var_325_6 = var_325_5:GetChild(iter_325_6)

					if var_325_6.name == "" or not string.find(var_325_6.name, "split") then
						var_325_6.gameObject:SetActive(true)
					else
						var_325_6.gameObject:SetActive(false)
					end
				end
			end

			local var_325_7 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_7 then
				var_325_5.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_322_1.time_ - 0) / var_325_7)
			end

			if arg_322_1.time_ >= 0 + var_325_7 and arg_322_1.time_ < 0 + var_325_7 + arg_325_0 then
				var_325_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_325_8 = arg_322_1.actors_["10144"].transform

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos10144 = var_325_8.localPosition
				var_325_8.localScale = Vector3.New(1, 1, 1)

				arg_322_1:CheckSpriteTmpPos("10144", 7)

				for iter_325_7 = 0, var_325_8.childCount - 1 do
					local var_325_9 = var_325_8:GetChild(iter_325_7)

					if var_325_9.name == "" or not string.find(var_325_9.name, "split") then
						var_325_9.gameObject:SetActive(true)
					else
						var_325_9.gameObject:SetActive(false)
					end
				end
			end

			local var_325_10 = 0.001

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_10 then
				var_325_8.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_322_1.time_ - 0) / var_325_10)
			end

			if arg_322_1.time_ >= 0 + var_325_10 and arg_322_1.time_ < 0 + var_325_10 + arg_325_0 then
				var_325_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_325_11 = 0
			local var_325_12 = 0.85

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_11 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_13 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(938041080).content)

				arg_322_1.text_.text = var_325_13

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_15 = 34 <= 0 and var_325_12 or var_325_12 * (utf8.len(var_325_13) / 34)

				if (34 <= 0 and var_325_12 or var_325_12 * (utf8.len(var_325_13) / 34)) > 0 and var_325_12 < var_325_15 then
					arg_322_1.talkMaxDuration = var_325_15

					if var_325_15 + var_325_11 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_15 + var_325_11
					end
				end

				arg_322_1.text_.text = var_325_13
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_16 = math.max(var_325_12, arg_322_1.talkMaxDuration)

			if var_325_11 <= arg_322_1.time_ and arg_322_1.time_ < var_325_11 + var_325_16 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_11) / var_325_16

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_11 + var_325_16 and arg_322_1.time_ < var_325_11 + var_325_16 + arg_325_0 then
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
			local var_329_0 = 0.375

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[7].name)

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

				local var_329_1 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(938041081).content)

				arg_326_1.text_.text = var_329_1

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_3 = 15 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 15)

				if (15 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 15)) > 0 and var_329_0 < var_329_3 then
					arg_326_1.talkMaxDuration = var_329_3

					if var_329_3 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_3 + 0
					end
				end

				arg_326_1.text_.text = var_329_1
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_4 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_4

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
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
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["10183"]) and arg_330_1.var_.actorSpriteComps10183 == nil then
				arg_330_1.var_.actorSpriteComps10183 = arg_330_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_0 = 0.2

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["10183"]) then
				if arg_330_1.var_.actorSpriteComps10183 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								iter_333_1.color = Color.New(Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor1.r, (arg_330_1.time_ - 0) / var_333_0), Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor1.g, (arg_330_1.time_ - 0) / var_333_0), (Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor1.b, (arg_330_1.time_ - 0) / var_333_0)))
							else
								local var_333_1 = Mathf.Lerp(iter_333_1.color.r, 1, (arg_330_1.time_ - 0) / var_333_0)

								iter_333_1.color = Color.New(var_333_1, var_333_1, var_333_1)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["10183"]) and arg_330_1.var_.actorSpriteComps10183 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_333_3 then
						iter_333_3.color = arg_330_1.isInRecall_ and (arg_330_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_330_1.var_.actorSpriteComps10183 = nil
			end

			local var_333_2 = arg_330_1.actors_["10183"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos10183 = var_333_2.localPosition
				var_333_2.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("10183", 3)

				for iter_333_4 = 0, var_333_2.childCount - 1 do
					local var_333_3 = var_333_2:GetChild(iter_333_4)

					if var_333_3.name == "split_7" or not string.find(var_333_3.name, "split") then
						var_333_3.gameObject:SetActive(true)
					else
						var_333_3.gameObject:SetActive(false)
					end
				end
			end

			local var_333_4 = 0.001

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				var_333_2.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_330_1.time_ - 0) / var_333_4)
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				var_333_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_333_5 = 0
			local var_333_6 = 0.65

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_5 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_7 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(938041082).content)

				arg_330_1.text_.text = var_333_7

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_9 = 26 <= 0 and var_333_6 or var_333_6 * (utf8.len(var_333_7) / 26)

				if (26 <= 0 and var_333_6 or var_333_6 * (utf8.len(var_333_7) / 26)) > 0 and var_333_6 < var_333_9 then
					arg_330_1.talkMaxDuration = var_333_9

					if var_333_9 + var_333_5 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_9 + var_333_5
					end
				end

				arg_330_1.text_.text = var_333_7
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_10 = math.max(var_333_6, arg_330_1.talkMaxDuration)

			if var_333_5 <= arg_330_1.time_ and arg_330_1.time_ < var_333_5 + var_333_10 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_5) / var_333_10

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_5 + var_333_10 and arg_330_1.time_ < var_333_5 + var_333_10 + arg_333_0 then
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
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos10183 = arg_334_1.actors_["10183"].transform.localPosition
				arg_334_1.actors_["10183"].transform.localScale = Vector3.New(1, 1, 1)

				arg_334_1:CheckSpriteTmpPos("10183", 3)

				for iter_337_0 = 0, arg_334_1.actors_["10183"].transform.childCount - 1 do
					local var_337_0 = arg_334_1.actors_["10183"].transform:GetChild(iter_337_0)

					if var_337_0.name == "split_1" then
						var_337_0:SetAsLastSibling()
						var_337_0.gameObject:SetActive(true)

						arg_334_1.var_.actorSpriteSplit10183 = var_337_0.gameObject:GetComponent(typeof(Image))

						arg_334_1.var_.actorSpriteSplit10183:SetAlpha(0)
					end
				end
			end

			local var_337_1 = 0.5

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_1 then
				arg_334_1.actors_["10183"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_334_1.time_ - 0) / var_337_1)

				if arg_334_1.var_.actorSpriteSplit10183 ~= nil then
					arg_334_1.var_.actorSpriteSplit10183:SetAlpha((arg_334_1.time_ - 0) / var_337_1)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_1 and arg_334_1.time_ < 0 + var_337_1 + arg_337_0 then
				arg_334_1.actors_["10183"].transform.localPosition = Vector3.New(0, -475, -325)

				if arg_334_1.var_.actorSpriteSplit10183 ~= nil then
					arg_334_1.var_.actorSpriteSplit10183:SetAlpha(1)
				end
			end

			local var_337_2 = 0
			local var_337_3 = 1.375

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_4 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(938041083).content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_6 = 55 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_4) / 55)

				if (55 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_4) / 55)) > 0 and var_337_3 < var_337_6 then
					arg_334_1.talkMaxDuration = var_337_6

					if var_337_6 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_2
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_3, arg_334_1.talkMaxDuration)

			if var_337_2 <= arg_334_1.time_ and arg_334_1.time_ < var_337_2 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_2) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_2 + var_337_7 and arg_334_1.time_ < var_337_2 + var_337_7 + arg_337_0 then
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
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["10183"]) and arg_338_1.var_.actorSpriteComps10183 == nil then
				arg_338_1.var_.actorSpriteComps10183 = arg_338_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_0 = 0.2

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["10183"]) then
				if arg_338_1.var_.actorSpriteComps10183 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								iter_341_1.color = Color.New(Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor2.r, (arg_338_1.time_ - 0) / var_341_0), Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor2.g, (arg_338_1.time_ - 0) / var_341_0), (Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor2.b, (arg_338_1.time_ - 0) / var_341_0)))
							else
								local var_341_1 = Mathf.Lerp(iter_341_1.color.r, 0.5, (arg_338_1.time_ - 0) / var_341_0)

								iter_341_1.color = Color.New(var_341_1, var_341_1, var_341_1)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["10183"]) and arg_338_1.var_.actorSpriteComps10183 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_341_3 then
						iter_341_3.color = arg_338_1.isInRecall_ and (arg_338_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_338_1.var_.actorSpriteComps10183 = nil
			end

			local var_341_2 = arg_338_1.actors_["10183"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos10183 = var_341_2.localPosition
				var_341_2.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("10183", 7)

				for iter_341_4 = 0, var_341_2.childCount - 1 do
					local var_341_3 = var_341_2:GetChild(iter_341_4)

					if var_341_3.name == "split_1" or not string.find(var_341_3.name, "split") then
						var_341_3.gameObject:SetActive(true)
					else
						var_341_3.gameObject:SetActive(false)
					end
				end
			end

			local var_341_4 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				var_341_2.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_338_1.time_ - 0) / var_341_4)
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				var_341_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_341_5 = 0
			local var_341_6 = 1.2

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_5 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_7 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(938041084).content)

				arg_338_1.text_.text = var_341_7

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_9 = 48 <= 0 and var_341_6 or var_341_6 * (utf8.len(var_341_7) / 48)

				if (48 <= 0 and var_341_6 or var_341_6 * (utf8.len(var_341_7) / 48)) > 0 and var_341_6 < var_341_9 then
					arg_338_1.talkMaxDuration = var_341_9

					if var_341_9 + var_341_5 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_9 + var_341_5
					end
				end

				arg_338_1.text_.text = var_341_7
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_10 = math.max(var_341_6, arg_338_1.talkMaxDuration)

			if var_341_5 <= arg_338_1.time_ and arg_338_1.time_ < var_341_5 + var_341_10 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_5) / var_341_10

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_5 + var_341_10 and arg_338_1.time_ < var_341_5 + var_341_10 + arg_341_0 then
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
			local var_345_0 = 1.05

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, false)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_1 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(938041085).content)

				arg_342_1.text_.text = var_345_1

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_3 = 42 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 42)

				if (42 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 42)) > 0 and var_345_0 < var_345_3 then
					arg_342_1.talkMaxDuration = var_345_3

					if var_345_3 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_3 + 0
					end
				end

				arg_342_1.text_.text = var_345_1
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_4 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_4

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
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
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["10183"]) and arg_346_1.var_.actorSpriteComps10183 == nil then
				arg_346_1.var_.actorSpriteComps10183 = arg_346_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_0 = 0.2

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["10183"]) then
				if arg_346_1.var_.actorSpriteComps10183 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								iter_349_1.color = Color.New(Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor1.r, (arg_346_1.time_ - 0) / var_349_0), Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor1.g, (arg_346_1.time_ - 0) / var_349_0), (Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor1.b, (arg_346_1.time_ - 0) / var_349_0)))
							else
								local var_349_1 = Mathf.Lerp(iter_349_1.color.r, 1, (arg_346_1.time_ - 0) / var_349_0)

								iter_349_1.color = Color.New(var_349_1, var_349_1, var_349_1)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["10183"]) and arg_346_1.var_.actorSpriteComps10183 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_349_3 then
						iter_349_3.color = arg_346_1.isInRecall_ and (arg_346_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_346_1.var_.actorSpriteComps10183 = nil
			end

			local var_349_2 = arg_346_1.actors_["10183"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos10183 = var_349_2.localPosition
				var_349_2.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("10183", 3)

				for iter_349_4 = 0, var_349_2.childCount - 1 do
					local var_349_3 = var_349_2:GetChild(iter_349_4)

					if var_349_3.name == "split_2" or not string.find(var_349_3.name, "split") then
						var_349_3.gameObject:SetActive(true)
					else
						var_349_3.gameObject:SetActive(false)
					end
				end
			end

			local var_349_4 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 then
				var_349_2.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10183, Vector3.New(0, -475, -325), (arg_346_1.time_ - 0) / var_349_4)
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 then
				var_349_2.localPosition = Vector3.New(0, -475, -325)
			end

			local var_349_5 = 0
			local var_349_6 = 0.35

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_5 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[1562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_7 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(938041086).content)

				arg_346_1.text_.text = var_349_7

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_9 = 14 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_7) / 14)

				if (14 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_7) / 14)) > 0 and var_349_6 < var_349_9 then
					arg_346_1.talkMaxDuration = var_349_9

					if var_349_9 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_9 + var_349_5
					end
				end

				arg_346_1.text_.text = var_349_7
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_6, arg_346_1.talkMaxDuration)

			if var_349_5 <= arg_346_1.time_ and arg_346_1.time_ < var_349_5 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_5) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_5 + var_349_10 and arg_346_1.time_ < var_349_5 + var_349_10 + arg_349_0 then
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
				SetActive(iter_351_1.go, iter_351_0 <= 1)
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
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["10183"]) and arg_350_1.var_.actorSpriteComps10183 == nil then
				arg_350_1.var_.actorSpriteComps10183 = arg_350_1.actors_["10183"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_0 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["10183"]) then
				if arg_350_1.var_.actorSpriteComps10183 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps10183:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								iter_353_1.color = Color.New(Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor2.r, (arg_350_1.time_ - 0) / var_353_0), Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor2.g, (arg_350_1.time_ - 0) / var_353_0), (Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor2.b, (arg_350_1.time_ - 0) / var_353_0)))
							else
								local var_353_1 = Mathf.Lerp(iter_353_1.color.r, 0.5, (arg_350_1.time_ - 0) / var_353_0)

								iter_353_1.color = Color.New(var_353_1, var_353_1, var_353_1)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["10183"]) and arg_350_1.var_.actorSpriteComps10183 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps10183:ToTable()) do
					if iter_353_3 then
						iter_353_3.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_350_1.var_.actorSpriteComps10183 = nil
			end

			local var_353_2 = 0

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_2 + arg_353_0 then
				arg_350_1.allBtn_.enabled = false
			end

			if arg_350_1.time_ >= var_353_2 + 0.5 and arg_350_1.time_ < var_353_2 + 0.5 + arg_353_0 then
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
			if arg_354_1.bgs_.ST0119 == nil then
				local var_357_0 = Object.Instantiate(arg_354_1.paintGo_)

				var_357_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0119")
				var_357_0.name = "ST0119"
				var_357_0.transform.parent = arg_354_1.stage_.transform
				var_357_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_354_1.bgs_.ST0119 = var_357_0
			end

			if 2 < arg_354_1.time_ and arg_354_1.time_ <= 2 + arg_357_0 then
				local var_357_1 = arg_354_1.bgs_.ST0119

				arg_354_1.bgs_.ST0119.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_357_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_357_2 = var_357_1:GetComponent("SpriteRenderer")

				if var_357_2 and var_357_2.sprite then
					local var_357_3 = 2 * (var_357_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_357_1.transform.localScale = Vector3.New(var_357_3 / var_357_2.sprite.bounds.size.y < var_357_3 * manager.ui.mainCameraCom_.aspect / var_357_2.sprite.bounds.size.x and var_357_3 * manager.ui.mainCameraCom_.aspect / var_357_2.sprite.bounds.size.x or var_357_3 / var_357_2.sprite.bounds.size.y, var_357_3 / var_357_2.sprite.bounds.size.y < var_357_3 * manager.ui.mainCameraCom_.aspect / var_357_2.sprite.bounds.size.x and var_357_3 * manager.ui.mainCameraCom_.aspect / var_357_2.sprite.bounds.size.x or var_357_3 / var_357_2.sprite.bounds.size.y, 0)
				end

				for iter_357_0, iter_357_1 in pairs(arg_354_1.bgs_) do
					if iter_357_0 ~= "ST0119" then
						iter_357_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_357_4 = 4

			if 4 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1.allBtn_.enabled = false
			end

			if arg_354_1.time_ >= var_357_4 + 0.3 and arg_354_1.time_ < var_357_4 + 0.3 + arg_357_0 then
				arg_354_1.allBtn_.enabled = true
			end

			local var_357_5 = 0

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_5 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_6 = 2

			if var_357_5 <= arg_354_1.time_ and arg_354_1.time_ < var_357_5 + var_357_6 then
				local var_357_7 = Color.New(0, 0, 0)

				var_357_7.a = Mathf.Lerp(0, 1, (arg_354_1.time_ - var_357_5) / var_357_6)
				arg_354_1.mask_.color = var_357_7
			end

			if arg_354_1.time_ >= var_357_5 + var_357_6 and arg_354_1.time_ < var_357_5 + var_357_6 + arg_357_0 then
				local var_357_8 = Color.New(0, 0, 0)

				var_357_8.a = 1
				arg_354_1.mask_.color = var_357_8
			end

			local var_357_9 = 2

			if 2 < arg_354_1.time_ and arg_354_1.time_ <= var_357_9 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_10 = 2

			if var_357_9 <= arg_354_1.time_ and arg_354_1.time_ < var_357_9 + var_357_10 then
				local var_357_11 = Color.New(0, 0, 0)

				var_357_11.a = Mathf.Lerp(1, 0, (arg_354_1.time_ - var_357_9) / var_357_10)
				arg_354_1.mask_.color = var_357_11
			end

			if arg_354_1.time_ >= var_357_9 + var_357_10 and arg_354_1.time_ < var_357_9 + var_357_10 + arg_357_0 then
				local var_357_12 = Color.New(0, 0, 0)

				arg_354_1.mask_.enabled = false
				var_357_12.a = 0
				arg_354_1.mask_.color = var_357_12
			end

			local var_357_13 = arg_354_1.actors_["10183"].transform

			if 1.966 < arg_354_1.time_ and arg_354_1.time_ <= 1.966 + arg_357_0 then
				arg_354_1.var_.moveOldPos10183 = var_357_13.localPosition
				var_357_13.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("10183", 7)

				for iter_357_2 = 0, var_357_13.childCount - 1 do
					local var_357_14 = var_357_13:GetChild(iter_357_2)

					if var_357_14.name == "" or not string.find(var_357_14.name, "split") then
						var_357_14.gameObject:SetActive(true)
					else
						var_357_14.gameObject:SetActive(false)
					end
				end
			end

			local var_357_15 = 0.001

			if 1.966 <= arg_354_1.time_ and arg_354_1.time_ < 1.966 + var_357_15 then
				var_357_13.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10183, Vector3.New(0, -2000, 0), (arg_354_1.time_ - 1.966) / var_357_15)
			end

			if arg_354_1.time_ >= 1.966 + var_357_15 and arg_354_1.time_ < 1.966 + var_357_15 + arg_357_0 then
				var_357_13.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_354_1.time_ and arg_354_1.time_ <= 1 + arg_357_0 then
				arg_354_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_boxing", "")
			end

			if 0.3 < arg_354_1.time_ and arg_354_1.time_ <= 0.3 + arg_357_0 then
				arg_354_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if 1 < arg_354_1.time_ and arg_354_1.time_ <= 1 + arg_357_0 then
				arg_354_1:AudioAction("play", "music", "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack.awb")

				local var_357_20 = manager.audio:GetAudioName("bgm_activity_5_2_story_racetrack", "bgm_activity_5_2_story_racetrack")

				if "" ~= "" then
					if arg_354_1.bgmTxt_.text ~= var_357_20 and arg_354_1.bgmTxt_.text ~= "" then
						if arg_354_1.bgmTxt2_.text ~= "" then
							arg_354_1.bgmTxt_.text = arg_354_1.bgmTxt2_.text
						end

						arg_354_1.bgmTxt2_.text = var_357_20

						arg_354_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_354_1.bgmTxt_.text = var_357_20
						arg_354_1.bgmTxt2_.text = var_357_20
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

			local var_357_21 = 4
			local var_357_22 = 0.375

			if 4 < arg_354_1.time_ and arg_354_1.time_ <= var_357_21 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0

				arg_354_1.dialog_:SetActive(true)

				arg_354_1.dialogCg_.alpha = 0

				local var_357_23 = LeanTween.value(arg_354_1.dialog_, 0, 1, 0.3)

				var_357_23:setOnUpdate(LuaHelper.FloatAction(function(arg_359_0)
					arg_354_1.dialogCg_.alpha = arg_359_0
				end))
				var_357_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_354_1.dialog_)
					var_357_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_354_1.duration_ = arg_354_1.duration_ + 0.3

				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_24 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(938041088).content)

				arg_354_1.text_.text = var_357_24

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_26 = 15 <= 0 and var_357_22 or var_357_22 * (utf8.len(var_357_24) / 15)

				if (15 <= 0 and var_357_22 or var_357_22 * (utf8.len(var_357_24) / 15)) > 0 and var_357_22 < var_357_26 then
					arg_354_1.talkMaxDuration = var_357_26
					var_357_21 = var_357_21 + 0.3

					if var_357_26 + var_357_21 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_26 + var_357_21
					end
				end

				arg_354_1.text_.text = var_357_24
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_27 = var_357_21 + 0.3
			local var_357_28 = math.max(var_357_22, arg_354_1.talkMaxDuration)

			if var_357_21 + 0.3 <= arg_354_1.time_ and arg_354_1.time_ < var_357_27 + var_357_28 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_27) / var_357_28

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_27 + var_357_28 and arg_354_1.time_ < var_357_27 + var_357_28 + arg_357_0 then
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
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["128404"]) and arg_361_1.var_.actorSpriteComps128404 == nil then
				arg_361_1.var_.actorSpriteComps128404 = arg_361_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_0 = 0.2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["128404"]) then
				if arg_361_1.var_.actorSpriteComps128404 then
					for iter_364_0, iter_364_1 in pairs(arg_361_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_364_1 then
							if arg_361_1.isInRecall_ then
								iter_364_1.color = Color.New(Mathf.Lerp(iter_364_1.color.r, arg_361_1.hightColor1.r, (arg_361_1.time_ - 0) / var_364_0), Mathf.Lerp(iter_364_1.color.g, arg_361_1.hightColor1.g, (arg_361_1.time_ - 0) / var_364_0), (Mathf.Lerp(iter_364_1.color.b, arg_361_1.hightColor1.b, (arg_361_1.time_ - 0) / var_364_0)))
							else
								local var_364_1 = Mathf.Lerp(iter_364_1.color.r, 1, (arg_361_1.time_ - 0) / var_364_0)

								iter_364_1.color = Color.New(var_364_1, var_364_1, var_364_1)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["128404"]) and arg_361_1.var_.actorSpriteComps128404 then
				for iter_364_2, iter_364_3 in pairs(arg_361_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_364_3 then
						iter_364_3.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_361_1.var_.actorSpriteComps128404 = nil
			end

			local var_364_2 = arg_361_1.actors_["128404"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos128404 = var_364_2.localPosition
				var_364_2.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("128404", 2)

				for iter_364_4 = 0, var_364_2.childCount - 1 do
					local var_364_3 = var_364_2:GetChild(iter_364_4)

					if var_364_3.name == "split_1" or not string.find(var_364_3.name, "split") then
						var_364_3.gameObject:SetActive(true)
					else
						var_364_3.gameObject:SetActive(false)
					end
				end
			end

			local var_364_4 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				var_364_2.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_361_1.time_ - 0) / var_364_4)
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				var_364_2.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_364_5 = 0
			local var_364_6 = 0.425

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_5 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_7 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(938041089).content)

				arg_361_1.text_.text = var_364_7

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_9 = 17 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_7) / 17)

				if (17 <= 0 and var_364_6 or var_364_6 * (utf8.len(var_364_7) / 17)) > 0 and var_364_6 < var_364_9 then
					arg_361_1.talkMaxDuration = var_364_9

					if var_364_9 + var_364_5 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_9 + var_364_5
					end
				end

				arg_361_1.text_.text = var_364_7
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_10 = math.max(var_364_6, arg_361_1.talkMaxDuration)

			if var_364_5 <= arg_361_1.time_ and arg_361_1.time_ < var_364_5 + var_364_10 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_5) / var_364_10

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_5 + var_364_10 and arg_361_1.time_ < var_364_5 + var_364_10 + arg_364_0 then
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
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["104902"]) and arg_365_1.var_.actorSpriteComps104902 == nil then
				arg_365_1.var_.actorSpriteComps104902 = arg_365_1.actors_["104902"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_0 = 0.2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["104902"]) then
				if arg_365_1.var_.actorSpriteComps104902 then
					for iter_368_0, iter_368_1 in pairs(arg_365_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_368_1 then
							if arg_365_1.isInRecall_ then
								iter_368_1.color = Color.New(Mathf.Lerp(iter_368_1.color.r, arg_365_1.hightColor1.r, (arg_365_1.time_ - 0) / var_368_0), Mathf.Lerp(iter_368_1.color.g, arg_365_1.hightColor1.g, (arg_365_1.time_ - 0) / var_368_0), (Mathf.Lerp(iter_368_1.color.b, arg_365_1.hightColor1.b, (arg_365_1.time_ - 0) / var_368_0)))
							else
								local var_368_1 = Mathf.Lerp(iter_368_1.color.r, 1, (arg_365_1.time_ - 0) / var_368_0)

								iter_368_1.color = Color.New(var_368_1, var_368_1, var_368_1)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["104902"]) and arg_365_1.var_.actorSpriteComps104902 then
				for iter_368_2, iter_368_3 in pairs(arg_365_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_368_3 then
						iter_368_3.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_365_1.var_.actorSpriteComps104902 = nil
			end

			local var_368_2 = arg_365_1.actors_["128404"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps128404 == nil then
				arg_365_1.var_.actorSpriteComps128404 = var_368_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_3 = 0.2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_3 and not isNil(var_368_2) then
				if arg_365_1.var_.actorSpriteComps128404 then
					for iter_368_4, iter_368_5 in pairs(arg_365_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_368_5 then
							if arg_365_1.isInRecall_ then
								iter_368_5.color = Color.New(Mathf.Lerp(iter_368_5.color.r, arg_365_1.hightColor2.r, (arg_365_1.time_ - 0) / var_368_3), Mathf.Lerp(iter_368_5.color.g, arg_365_1.hightColor2.g, (arg_365_1.time_ - 0) / var_368_3), (Mathf.Lerp(iter_368_5.color.b, arg_365_1.hightColor2.b, (arg_365_1.time_ - 0) / var_368_3)))
							else
								local var_368_4 = Mathf.Lerp(iter_368_5.color.r, 0.5, (arg_365_1.time_ - 0) / var_368_3)

								iter_368_5.color = Color.New(var_368_4, var_368_4, var_368_4)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_3 and arg_365_1.time_ < 0 + var_368_3 + arg_368_0 and not isNil(var_368_2) and arg_365_1.var_.actorSpriteComps128404 then
				for iter_368_6, iter_368_7 in pairs(arg_365_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_368_7 then
						iter_368_7.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_365_1.var_.actorSpriteComps128404 = nil
			end

			local var_368_5 = arg_365_1.actors_["104902"].transform

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos104902 = var_368_5.localPosition
				var_368_5.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("104902", 4)

				for iter_368_8 = 0, var_368_5.childCount - 1 do
					local var_368_6 = var_368_5:GetChild(iter_368_8)

					if var_368_6.name == "" or not string.find(var_368_6.name, "split") then
						var_368_6.gameObject:SetActive(true)
					else
						var_368_6.gameObject:SetActive(false)
					end
				end
			end

			local var_368_7 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				var_368_5.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos104902, Vector3.New(390, -335, -360), (arg_365_1.time_ - 0) / var_368_7)
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				var_368_5.localPosition = Vector3.New(390, -335, -360)
			end

			local var_368_8 = 0
			local var_368_9 = 0.475

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[562].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_10 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(938041090).content)

				arg_365_1.text_.text = var_368_10

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_12 = 19 <= 0 and var_368_9 or var_368_9 * (utf8.len(var_368_10) / 19)

				if (19 <= 0 and var_368_9 or var_368_9 * (utf8.len(var_368_10) / 19)) > 0 and var_368_9 < var_368_12 then
					arg_365_1.talkMaxDuration = var_368_12

					if var_368_12 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_12 + var_368_8
					end
				end

				arg_365_1.text_.text = var_368_10
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_13 = math.max(var_368_9, arg_365_1.talkMaxDuration)

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_13 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_8) / var_368_13

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_8 + var_368_13 and arg_365_1.time_ < var_368_8 + var_368_13 + arg_368_0 then
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
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["106603"]) and arg_369_1.var_.actorSpriteComps106603 == nil then
				arg_369_1.var_.actorSpriteComps106603 = arg_369_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_0 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["106603"]) then
				if arg_369_1.var_.actorSpriteComps106603 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_372_1 then
							if arg_369_1.isInRecall_ then
								iter_372_1.color = Color.New(Mathf.Lerp(iter_372_1.color.r, arg_369_1.hightColor1.r, (arg_369_1.time_ - 0) / var_372_0), Mathf.Lerp(iter_372_1.color.g, arg_369_1.hightColor1.g, (arg_369_1.time_ - 0) / var_372_0), (Mathf.Lerp(iter_372_1.color.b, arg_369_1.hightColor1.b, (arg_369_1.time_ - 0) / var_372_0)))
							else
								local var_372_1 = Mathf.Lerp(iter_372_1.color.r, 1, (arg_369_1.time_ - 0) / var_372_0)

								iter_372_1.color = Color.New(var_372_1, var_372_1, var_372_1)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["106603"]) and arg_369_1.var_.actorSpriteComps106603 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_372_3 then
						iter_372_3.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps106603 = nil
			end

			local var_372_2 = arg_369_1.actors_["104902"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps104902 == nil then
				arg_369_1.var_.actorSpriteComps104902 = var_372_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_3 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_3 and not isNil(var_372_2) then
				if arg_369_1.var_.actorSpriteComps104902 then
					for iter_372_4, iter_372_5 in pairs(arg_369_1.var_.actorSpriteComps104902:ToTable()) do
						if iter_372_5 then
							if arg_369_1.isInRecall_ then
								iter_372_5.color = Color.New(Mathf.Lerp(iter_372_5.color.r, arg_369_1.hightColor2.r, (arg_369_1.time_ - 0) / var_372_3), Mathf.Lerp(iter_372_5.color.g, arg_369_1.hightColor2.g, (arg_369_1.time_ - 0) / var_372_3), (Mathf.Lerp(iter_372_5.color.b, arg_369_1.hightColor2.b, (arg_369_1.time_ - 0) / var_372_3)))
							else
								local var_372_4 = Mathf.Lerp(iter_372_5.color.r, 0.5, (arg_369_1.time_ - 0) / var_372_3)

								iter_372_5.color = Color.New(var_372_4, var_372_4, var_372_4)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_3 and arg_369_1.time_ < 0 + var_372_3 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps104902 then
				for iter_372_6, iter_372_7 in pairs(arg_369_1.var_.actorSpriteComps104902:ToTable()) do
					if iter_372_7 then
						iter_372_7.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_369_1.var_.actorSpriteComps104902 = nil
			end

			local var_372_5 = arg_369_1.actors_["106603"].transform

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos106603 = var_372_5.localPosition
				var_372_5.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("106603", 2)

				for iter_372_8 = 0, var_372_5.childCount - 1 do
					local var_372_6 = var_372_5:GetChild(iter_372_8)

					if var_372_6.name == "" or not string.find(var_372_6.name, "split") then
						var_372_6.gameObject:SetActive(true)
					else
						var_372_6.gameObject:SetActive(false)
					end
				end
			end

			local var_372_7 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_7 then
				var_372_5.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos106603, Vector3.New(-510.9, -399.1, -303.3), (arg_369_1.time_ - 0) / var_372_7)
			end

			if arg_369_1.time_ >= 0 + var_372_7 and arg_369_1.time_ < 0 + var_372_7 + arg_372_0 then
				var_372_5.localPosition = Vector3.New(-510.9, -399.1, -303.3)
			end

			local var_372_8 = arg_369_1.actors_["128404"].transform

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos128404 = var_372_8.localPosition
				var_372_8.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("128404", 7)

				for iter_372_9 = 0, var_372_8.childCount - 1 do
					local var_372_9 = var_372_8:GetChild(iter_372_9)

					if var_372_9.name == "" or not string.find(var_372_9.name, "split") then
						var_372_9.gameObject:SetActive(true)
					else
						var_372_9.gameObject:SetActive(false)
					end
				end
			end

			local var_372_10 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_10 then
				var_372_8.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_369_1.time_ - 0) / var_372_10)
			end

			if arg_369_1.time_ >= 0 + var_372_10 and arg_369_1.time_ < 0 + var_372_10 + arg_372_0 then
				var_372_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_372_11 = 0
			local var_372_12 = 0.375

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_11 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_13 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(938041091).content)

				arg_369_1.text_.text = var_372_13

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_15 = 15 <= 0 and var_372_12 or var_372_12 * (utf8.len(var_372_13) / 15)

				if (15 <= 0 and var_372_12 or var_372_12 * (utf8.len(var_372_13) / 15)) > 0 and var_372_12 < var_372_15 then
					arg_369_1.talkMaxDuration = var_372_15

					if var_372_15 + var_372_11 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_15 + var_372_11
					end
				end

				arg_369_1.text_.text = var_372_13
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_16 = math.max(var_372_12, arg_369_1.talkMaxDuration)

			if var_372_11 <= arg_369_1.time_ and arg_369_1.time_ < var_372_11 + var_372_16 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_11) / var_372_16

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_11 + var_372_16 and arg_369_1.time_ < var_372_11 + var_372_16 + arg_372_0 then
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
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["108301"]) and arg_373_1.var_.actorSpriteComps108301 == nil then
				arg_373_1.var_.actorSpriteComps108301 = arg_373_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_0 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["108301"]) then
				if arg_373_1.var_.actorSpriteComps108301 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps108301:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								iter_376_1.color = Color.New(Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor1.r, (arg_373_1.time_ - 0) / var_376_0), Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor1.g, (arg_373_1.time_ - 0) / var_376_0), (Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor1.b, (arg_373_1.time_ - 0) / var_376_0)))
							else
								local var_376_1 = Mathf.Lerp(iter_376_1.color.r, 1, (arg_373_1.time_ - 0) / var_376_0)

								iter_376_1.color = Color.New(var_376_1, var_376_1, var_376_1)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["108301"]) and arg_373_1.var_.actorSpriteComps108301 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_376_3 then
						iter_376_3.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_373_1.var_.actorSpriteComps108301 = nil
			end

			local var_376_2 = arg_373_1.actors_["106603"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps106603 == nil then
				arg_373_1.var_.actorSpriteComps106603 = var_376_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_3 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_3 and not isNil(var_376_2) then
				if arg_373_1.var_.actorSpriteComps106603 then
					for iter_376_4, iter_376_5 in pairs(arg_373_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_376_5 then
							if arg_373_1.isInRecall_ then
								iter_376_5.color = Color.New(Mathf.Lerp(iter_376_5.color.r, arg_373_1.hightColor2.r, (arg_373_1.time_ - 0) / var_376_3), Mathf.Lerp(iter_376_5.color.g, arg_373_1.hightColor2.g, (arg_373_1.time_ - 0) / var_376_3), (Mathf.Lerp(iter_376_5.color.b, arg_373_1.hightColor2.b, (arg_373_1.time_ - 0) / var_376_3)))
							else
								local var_376_4 = Mathf.Lerp(iter_376_5.color.r, 0.5, (arg_373_1.time_ - 0) / var_376_3)

								iter_376_5.color = Color.New(var_376_4, var_376_4, var_376_4)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_3 and arg_373_1.time_ < 0 + var_376_3 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps106603 then
				for iter_376_6, iter_376_7 in pairs(arg_373_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_376_7 then
						iter_376_7.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_373_1.var_.actorSpriteComps106603 = nil
			end

			local var_376_5 = arg_373_1.actors_["108301"].transform

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos108301 = var_376_5.localPosition
				var_376_5.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("108301", 4)

				for iter_376_8 = 0, var_376_5.childCount - 1 do
					local var_376_6 = var_376_5:GetChild(iter_376_8)

					if var_376_6.name == "" or not string.find(var_376_6.name, "split") then
						var_376_6.gameObject:SetActive(true)
					else
						var_376_6.gameObject:SetActive(false)
					end
				end
			end

			local var_376_7 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_7 then
				var_376_5.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos108301, Vector3.New(460, -360, -195), (arg_373_1.time_ - 0) / var_376_7)
			end

			if arg_373_1.time_ >= 0 + var_376_7 and arg_373_1.time_ < 0 + var_376_7 + arg_376_0 then
				var_376_5.localPosition = Vector3.New(460, -360, -195)
			end

			local var_376_8 = arg_373_1.actors_["104902"].transform

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos104902 = var_376_8.localPosition
				var_376_8.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("104902", 7)

				for iter_376_9 = 0, var_376_8.childCount - 1 do
					local var_376_9 = var_376_8:GetChild(iter_376_9)

					if var_376_9.name == "" or not string.find(var_376_9.name, "split") then
						var_376_9.gameObject:SetActive(true)
					else
						var_376_9.gameObject:SetActive(false)
					end
				end
			end

			local var_376_10 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_10 then
				var_376_8.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos104902, Vector3.New(0, -2000, -360), (arg_373_1.time_ - 0) / var_376_10)
			end

			if arg_373_1.time_ >= 0 + var_376_10 and arg_373_1.time_ < 0 + var_376_10 + arg_376_0 then
				var_376_8.localPosition = Vector3.New(0, -2000, -360)
			end

			local var_376_11 = 0
			local var_376_12 = 0.3

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_11 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_13 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(938041092).content)

				arg_373_1.text_.text = var_376_13

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_15 = 12 <= 0 and var_376_12 or var_376_12 * (utf8.len(var_376_13) / 12)

				if (12 <= 0 and var_376_12 or var_376_12 * (utf8.len(var_376_13) / 12)) > 0 and var_376_12 < var_376_15 then
					arg_373_1.talkMaxDuration = var_376_15

					if var_376_15 + var_376_11 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_15 + var_376_11
					end
				end

				arg_373_1.text_.text = var_376_13
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_16 = math.max(var_376_12, arg_373_1.talkMaxDuration)

			if var_376_11 <= arg_373_1.time_ and arg_373_1.time_ < var_376_11 + var_376_16 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_11) / var_376_16

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_11 + var_376_16 and arg_373_1.time_ < var_376_11 + var_376_16 + arg_376_0 then
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
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["108301"]) and arg_377_1.var_.actorSpriteComps108301 == nil then
				arg_377_1.var_.actorSpriteComps108301 = arg_377_1.actors_["108301"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_0 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["108301"]) then
				if arg_377_1.var_.actorSpriteComps108301 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps108301:ToTable()) do
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

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["108301"]) and arg_377_1.var_.actorSpriteComps108301 then
				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps108301:ToTable()) do
					if iter_380_3 then
						iter_380_3.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_377_1.var_.actorSpriteComps108301 = nil
			end

			local var_380_2 = arg_377_1.actors_["108301"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos108301 = var_380_2.localPosition
				var_380_2.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("108301", 7)

				for iter_380_4 = 0, var_380_2.childCount - 1 do
					local var_380_3 = var_380_2:GetChild(iter_380_4)

					if var_380_3.name == "" or not string.find(var_380_3.name, "split") then
						var_380_3.gameObject:SetActive(true)
					else
						var_380_3.gameObject:SetActive(false)
					end
				end
			end

			local var_380_4 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				var_380_2.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos108301, Vector3.New(0, -2000, 0), (arg_377_1.time_ - 0) / var_380_4)
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				var_380_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_380_5 = arg_377_1.actors_["106603"].transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPos106603 = var_380_5.localPosition
				var_380_5.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("106603", 7)

				for iter_380_5 = 0, var_380_5.childCount - 1 do
					local var_380_6 = var_380_5:GetChild(iter_380_5)

					if var_380_6.name == "" or not string.find(var_380_6.name, "split") then
						var_380_6.gameObject:SetActive(true)
					else
						var_380_6.gameObject:SetActive(false)
					end
				end
			end

			local var_380_7 = 0.001

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_7 then
				var_380_5.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_377_1.time_ - 0) / var_380_7)
			end

			if arg_377_1.time_ >= 0 + var_380_7 and arg_377_1.time_ < 0 + var_380_7 + arg_380_0 then
				var_380_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_380_8 = 0
			local var_380_9 = 1.325

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_8 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_10 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(938041093).content)

				arg_377_1.text_.text = var_380_10

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_12 = 53 <= 0 and var_380_9 or var_380_9 * (utf8.len(var_380_10) / 53)

				if (53 <= 0 and var_380_9 or var_380_9 * (utf8.len(var_380_10) / 53)) > 0 and var_380_9 < var_380_12 then
					arg_377_1.talkMaxDuration = var_380_12

					if var_380_12 + var_380_8 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_12 + var_380_8
					end
				end

				arg_377_1.text_.text = var_380_10
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_13 = math.max(var_380_9, arg_377_1.talkMaxDuration)

			if var_380_8 <= arg_377_1.time_ and arg_377_1.time_ < var_380_8 + var_380_13 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_8) / var_380_13

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_8 + var_380_13 and arg_377_1.time_ < var_380_8 + var_380_13 + arg_380_0 then
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
			local var_384_0 = 0.7

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[7].name)

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

				local var_384_1 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(938041094).content)

				arg_381_1.text_.text = var_384_1

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_3 = 28 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 28)

				if (28 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_1) / 28)) > 0 and var_384_0 < var_384_3 then
					arg_381_1.talkMaxDuration = var_384_3

					if var_384_3 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_3 + 0
					end
				end

				arg_381_1.text_.text = var_384_1
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_4 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_4

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
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
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["10144"]) and arg_385_1.var_.actorSpriteComps10144 == nil then
				arg_385_1.var_.actorSpriteComps10144 = arg_385_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_0 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["10144"]) then
				if arg_385_1.var_.actorSpriteComps10144 then
					for iter_388_0, iter_388_1 in pairs(arg_385_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["10144"]) and arg_385_1.var_.actorSpriteComps10144 then
				for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_388_3 then
						iter_388_3.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_385_1.var_.actorSpriteComps10144 = nil
			end

			local var_388_2 = arg_385_1.actors_["10144"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos10144 = var_388_2.localPosition
				var_388_2.localScale = Vector3.New(1, 1, 1)

				arg_385_1:CheckSpriteTmpPos("10144", 3)

				for iter_388_4 = 0, var_388_2.childCount - 1 do
					local var_388_3 = var_388_2:GetChild(iter_388_4)

					if var_388_3.name == "split_2" or not string.find(var_388_3.name, "split") then
						var_388_3.gameObject:SetActive(true)
					else
						var_388_3.gameObject:SetActive(false)
					end
				end
			end

			local var_388_4 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_4 then
				var_388_2.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_385_1.time_ - 0) / var_388_4)
			end

			if arg_385_1.time_ >= 0 + var_388_4 and arg_385_1.time_ < 0 + var_388_4 + arg_388_0 then
				var_388_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_388_5 = 0
			local var_388_6 = 0.65

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_7 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(938041095).content)

				arg_385_1.text_.text = var_388_7

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_9 = 26 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_7) / 26)

				if (26 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_7) / 26)) > 0 and var_388_6 < var_388_9 then
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
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["10144"]) and arg_389_1.var_.actorSpriteComps10144 == nil then
				arg_389_1.var_.actorSpriteComps10144 = arg_389_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_0 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["10144"]) then
				if arg_389_1.var_.actorSpriteComps10144 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["10144"]) and arg_389_1.var_.actorSpriteComps10144 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_392_3 then
						iter_392_3.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_389_1.var_.actorSpriteComps10144 = nil
			end

			local var_392_2 = 0
			local var_392_3 = 0.725

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_2 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_4 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(938041096).content)

				arg_389_1.text_.text = var_392_4

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_6 = 29 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_4) / 29)

				if (29 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_4) / 29)) > 0 and var_392_3 < var_392_6 then
					arg_389_1.talkMaxDuration = var_392_6

					if var_392_6 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_6 + var_392_2
					end
				end

				arg_389_1.text_.text = var_392_4
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_3, arg_389_1.talkMaxDuration)

			if var_392_2 <= arg_389_1.time_ and arg_389_1.time_ < var_392_2 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_2) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_2 + var_392_7 and arg_389_1.time_ < var_392_2 + var_392_7 + arg_392_0 then
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
			local var_396_0 = 0.375

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[7].name)

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

				local var_396_1 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(938041097).content)

				arg_393_1.text_.text = var_396_1

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_3 = 15 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 15)

				if (15 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_1) / 15)) > 0 and var_396_0 < var_396_3 then
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
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["10144"]) and arg_397_1.var_.actorSpriteComps10144 == nil then
				arg_397_1.var_.actorSpriteComps10144 = arg_397_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_0 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["10144"]) then
				if arg_397_1.var_.actorSpriteComps10144 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_400_1 then
							if arg_397_1.isInRecall_ then
								iter_400_1.color = Color.New(Mathf.Lerp(iter_400_1.color.r, arg_397_1.hightColor1.r, (arg_397_1.time_ - 0) / var_400_0), Mathf.Lerp(iter_400_1.color.g, arg_397_1.hightColor1.g, (arg_397_1.time_ - 0) / var_400_0), (Mathf.Lerp(iter_400_1.color.b, arg_397_1.hightColor1.b, (arg_397_1.time_ - 0) / var_400_0)))
							else
								local var_400_1 = Mathf.Lerp(iter_400_1.color.r, 1, (arg_397_1.time_ - 0) / var_400_0)

								iter_400_1.color = Color.New(var_400_1, var_400_1, var_400_1)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["10144"]) and arg_397_1.var_.actorSpriteComps10144 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_400_3 then
						iter_400_3.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_397_1.var_.actorSpriteComps10144 = nil
			end

			local var_400_2 = arg_397_1.actors_["10144"].transform

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos10144 = var_400_2.localPosition
				var_400_2.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("10144", 3)

				for iter_400_4 = 0, var_400_2.childCount - 1 do
					local var_400_3 = var_400_2:GetChild(iter_400_4)

					if var_400_3.name == "split_1" then
						var_400_3:SetAsLastSibling()
						var_400_3.gameObject:SetActive(true)

						arg_397_1.var_.actorSpriteSplit10144 = var_400_3.gameObject:GetComponent(typeof(Image))

						arg_397_1.var_.actorSpriteSplit10144:SetAlpha(0)
					end
				end
			end

			local var_400_4 = 0.5

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				var_400_2.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_397_1.time_ - 0) / var_400_4)

				if arg_397_1.var_.actorSpriteSplit10144 ~= nil then
					arg_397_1.var_.actorSpriteSplit10144:SetAlpha((arg_397_1.time_ - 0) / var_400_4)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				var_400_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)

				if arg_397_1.var_.actorSpriteSplit10144 ~= nil then
					arg_397_1.var_.actorSpriteSplit10144:SetAlpha(1)
				end
			end

			local var_400_5 = 0
			local var_400_6 = 1.1

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_5 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_7 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(938041098).content)

				arg_397_1.text_.text = var_400_7

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_9 = 44 <= 0 and var_400_6 or var_400_6 * (utf8.len(var_400_7) / 44)

				if (44 <= 0 and var_400_6 or var_400_6 * (utf8.len(var_400_7) / 44)) > 0 and var_400_6 < var_400_9 then
					arg_397_1.talkMaxDuration = var_400_9

					if var_400_9 + var_400_5 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_9 + var_400_5
					end
				end

				arg_397_1.text_.text = var_400_7
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_6, arg_397_1.talkMaxDuration)

			if var_400_5 <= arg_397_1.time_ and arg_397_1.time_ < var_400_5 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_5) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_5 + var_400_10 and arg_397_1.time_ < var_400_5 + var_400_10 + arg_400_0 then
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
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["10144"]) and arg_401_1.var_.actorSpriteComps10144 == nil then
				arg_401_1.var_.actorSpriteComps10144 = arg_401_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_0 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["10144"]) then
				if arg_401_1.var_.actorSpriteComps10144 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_404_1 then
							if arg_401_1.isInRecall_ then
								iter_404_1.color = Color.New(Mathf.Lerp(iter_404_1.color.r, arg_401_1.hightColor2.r, (arg_401_1.time_ - 0) / var_404_0), Mathf.Lerp(iter_404_1.color.g, arg_401_1.hightColor2.g, (arg_401_1.time_ - 0) / var_404_0), (Mathf.Lerp(iter_404_1.color.b, arg_401_1.hightColor2.b, (arg_401_1.time_ - 0) / var_404_0)))
							else
								local var_404_1 = Mathf.Lerp(iter_404_1.color.r, 0.5, (arg_401_1.time_ - 0) / var_404_0)

								iter_404_1.color = Color.New(var_404_1, var_404_1, var_404_1)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["10144"]) and arg_401_1.var_.actorSpriteComps10144 then
				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_404_3 then
						iter_404_3.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_401_1.var_.actorSpriteComps10144 = nil
			end

			local var_404_2 = 0
			local var_404_3 = 0.6

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_2 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[7].name)

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

				local var_404_4 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(938041099).content)

				arg_401_1.text_.text = var_404_4

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_6 = 24 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_4) / 24)

				if (24 <= 0 and var_404_3 or var_404_3 * (utf8.len(var_404_4) / 24)) > 0 and var_404_3 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_2 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_2
					end
				end

				arg_401_1.text_.text = var_404_4
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_3, arg_401_1.talkMaxDuration)

			if var_404_2 <= arg_401_1.time_ and arg_401_1.time_ < var_404_2 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_2) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_2 + var_404_7 and arg_401_1.time_ < var_404_2 + var_404_7 + arg_404_0 then
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
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos10144 = arg_405_1.actors_["10144"].transform.localPosition
				arg_405_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("10144", 7)

				for iter_408_0 = 0, arg_405_1.actors_["10144"].transform.childCount - 1 do
					local var_408_0 = arg_405_1.actors_["10144"].transform:GetChild(iter_408_0)

					if var_408_0.name == "" or not string.find(var_408_0.name, "split") then
						var_408_0.gameObject:SetActive(true)
					else
						var_408_0.gameObject:SetActive(false)
					end
				end
			end

			local var_408_1 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_1 then
				arg_405_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_405_1.time_ - 0) / var_408_1)
			end

			if arg_405_1.time_ >= 0 + var_408_1 and arg_405_1.time_ < 0 + var_408_1 + arg_408_0 then
				arg_405_1.actors_["10144"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_408_2 = 0
			local var_408_3 = 0.65

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_2 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_4 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(938041100).content)

				arg_405_1.text_.text = var_408_4

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_6 = 26 <= 0 and var_408_3 or var_408_3 * (utf8.len(var_408_4) / 26)

				if (26 <= 0 and var_408_3 or var_408_3 * (utf8.len(var_408_4) / 26)) > 0 and var_408_3 < var_408_6 then
					arg_405_1.talkMaxDuration = var_408_6

					if var_408_6 + var_408_2 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_6 + var_408_2
					end
				end

				arg_405_1.text_.text = var_408_4
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_3, arg_405_1.talkMaxDuration)

			if var_408_2 <= arg_405_1.time_ and arg_405_1.time_ < var_408_2 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_2) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_2 + var_408_7 and arg_405_1.time_ < var_408_2 + var_408_7 + arg_408_0 then
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
