return {
	Play910115001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910115001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910115002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST31 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31")
				var_4_0.name = "ST31"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST31 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST31

				arg_1_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST31" then
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
			local var_4_9 = 1.25

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

				local var_4_11 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(910115001).content)

				arg_1_1.text_.text = var_4_11

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_13 = 50 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 50)

				if (50 <= 0 and var_4_9 or var_4_9 * (utf8.len(var_4_11) / 50)) > 0 and var_4_9 < var_4_13 then
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
	Play910115002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 910115002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play910115003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0.625

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

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(910115002).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 25 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 25)

				if (25 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 25)) > 0 and var_10_0 < var_10_3 then
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
	Play910115003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 910115003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play910115004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 1.7

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

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(910115003).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 68 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 68)

				if (68 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 68)) > 0 and var_14_0 < var_14_3 then
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
	Play910115004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 910115004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play910115005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 1.725

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_1 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(910115004).content)

				arg_15_1.text_.text = var_18_1

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_3 = 69 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 69)

				if (69 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 69)) > 0 and var_18_0 < var_18_3 then
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
	Play910115005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 910115005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play910115006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.4

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

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(910115005).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 16 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 16)

				if (16 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 16)) > 0 and var_22_0 < var_22_3 then
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
	Play910115006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 910115006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play910115007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_26_0 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_23_1.stage_.transform)

				var_26_0.name = "1070ui_story"
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1070ui_story"] = var_26_0

				local var_26_1 = var_26_0:GetComponentInChildren(typeof(CharacterEffect))

				var_26_1.enabled = true

				local var_26_2 = GameObjectTools.GetOrAddComponent(var_26_0, typeof(DynamicBoneHelper))

				if var_26_2 then
					var_26_2:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_1.transform, false)

				arg_23_1.var_["1070ui_story" .. "Animator"] = var_26_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_["1070ui_story" .. "Animator"].applyRootMotion = true
				arg_23_1.var_["1070ui_story" .. "LipSync"] = var_26_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_3 = arg_23_1.actors_["1070ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1070ui_story = var_26_3.localPosition
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_3.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_23_1.time_ - 0) / var_26_4)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_3.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			local var_26_5 = arg_23_1.actors_["1070ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1070ui_story == nil then
				arg_23_1.var_.characterEffect1070ui_story = var_26_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 and not isNil(var_26_5) then
				if arg_23_1.var_.characterEffect1070ui_story and not isNil(var_26_5) then
					arg_23_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1070ui_story then
				arg_23_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_26_8 = "1074ui_story"

			if arg_23_1.actors_["1074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1074ui_story"))) then
				local var_26_9 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_23_1.stage_.transform)

				var_26_9.name = var_26_8
				var_26_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_[var_26_8] = var_26_9

				local var_26_10 = var_26_9:GetComponentInChildren(typeof(CharacterEffect))

				var_26_10.enabled = true

				local var_26_11 = GameObjectTools.GetOrAddComponent(var_26_9, typeof(DynamicBoneHelper))

				if var_26_11 then
					var_26_11:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_10.transform, false)

				arg_23_1.var_[var_26_8 .. "Animator"] = var_26_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_[var_26_8 .. "Animator"].applyRootMotion = true
				arg_23_1.var_[var_26_8 .. "LipSync"] = var_26_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_12 = arg_23_1.actors_["1074ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1074ui_story = var_26_12.localPosition
			end

			local var_26_13 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_13 then
				var_26_12.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_23_1.time_ - 0) / var_26_13)
				var_26_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_12.position).x, (manager.ui.mainCamera.transform.position - var_26_12.position).y, (manager.ui.mainCamera.transform.position - var_26_12.position).z)
				var_26_12.localEulerAngles.z = 0
				var_26_12.localEulerAngles.x = 0
				var_26_12.localEulerAngles = var_26_12.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_13 and arg_23_1.time_ < 0 + var_26_13 + arg_26_0 then
				var_26_12.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_26_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_12.position).x, (manager.ui.mainCamera.transform.position - var_26_12.position).y, (manager.ui.mainCamera.transform.position - var_26_12.position).z)
				var_26_12.localEulerAngles.z = 0
				var_26_12.localEulerAngles.x = 0
				var_26_12.localEulerAngles = var_26_12.localEulerAngles
			end

			local var_26_14 = arg_23_1.actors_["1074ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_14) and arg_23_1.var_.characterEffect1074ui_story == nil then
				arg_23_1.var_.characterEffect1074ui_story = var_26_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_15 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_15 and not isNil(var_26_14) then
				if arg_23_1.var_.characterEffect1074ui_story and not isNil(var_26_14) then
					arg_23_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_15)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_15 and arg_23_1.time_ < 0 + var_26_15 + arg_26_0 and not isNil(var_26_14) and arg_23_1.var_.characterEffect1074ui_story then
				arg_23_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_26_16 = 0
			local var_26_17 = 0.375

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_16 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_18 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(910115006).content)

				arg_23_1.text_.text = var_26_18

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_20 = 15 <= 0 and var_26_17 or var_26_17 * (utf8.len(var_26_18) / 15)

				if (15 <= 0 and var_26_17 or var_26_17 * (utf8.len(var_26_18) / 15)) > 0 and var_26_17 < var_26_20 then
					arg_23_1.talkMaxDuration = var_26_20

					if var_26_20 + var_26_16 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_20 + var_26_16
					end
				end

				arg_23_1.text_.text = var_26_18
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_21 = math.max(var_26_17, arg_23_1.talkMaxDuration)

			if var_26_16 <= arg_23_1.time_ and arg_23_1.time_ < var_26_16 + var_26_21 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_16) / var_26_21

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_16 + var_26_21 and arg_23_1.time_ < var_26_16 + var_26_21 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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

		arg_23_1:InitPlayNodeList()
	end,
	Play910115007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 910115007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play910115008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1074ui_story = arg_27_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1074ui_story"].transform.position).z)
				arg_27_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1074ui_story"].transform.localEulerAngles = arg_27_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_27_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1074ui_story"].transform.position).z)
				arg_27_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1074ui_story"].transform.localEulerAngles = arg_27_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1074ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1074ui_story == nil then
				arg_27_1.var_.characterEffect1074ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1074ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1074ui_story then
				arg_27_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_30_4 = arg_27_1.actors_["1070ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1070ui_story == nil then
				arg_27_1.var_.characterEffect1070ui_story = var_30_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_5 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_5 and not isNil(var_30_4) then
				if arg_27_1.var_.characterEffect1070ui_story and not isNil(var_30_4) then
					arg_27_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_5)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_5 and arg_27_1.time_ < 0 + var_30_5 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1070ui_story then
				arg_27_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_30_6 = 0
			local var_30_7 = 0.45

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_8 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(910115007).content)

				arg_27_1.text_.text = var_30_8

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_10 = 18 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_8) / 18)

				if (18 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_8) / 18)) > 0 and var_30_7 < var_30_10 then
					arg_27_1.talkMaxDuration = var_30_10

					if var_30_10 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_6
					end
				end

				arg_27_1.text_.text = var_30_8
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_11 = math.max(var_30_7, arg_27_1.talkMaxDuration)

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_11 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_6) / var_30_11

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_6 + var_30_11 and arg_27_1.time_ < var_30_6 + var_30_11 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play910115008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 910115008
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play910115009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1070ui_story = arg_31_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1070ui_story"].transform.position).z)
				arg_31_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1070ui_story"].transform.localEulerAngles = arg_31_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_31_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1070ui_story"].transform.position).z)
				arg_31_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1070ui_story"].transform.localEulerAngles = arg_31_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1070ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1070ui_story == nil then
				arg_31_1.var_.characterEffect1070ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1070ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1070ui_story then
				arg_31_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_34_4 = arg_31_1.actors_["1074ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect1074ui_story == nil then
				arg_31_1.var_.characterEffect1074ui_story = var_34_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_5 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_5 and not isNil(var_34_4) then
				if arg_31_1.var_.characterEffect1074ui_story and not isNil(var_34_4) then
					arg_31_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_5)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_5 and arg_31_1.time_ < 0 + var_34_5 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.characterEffect1074ui_story then
				arg_31_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_34_6 = 0
			local var_34_7 = 0.725

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_8 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(910115008).content)

				arg_31_1.text_.text = var_34_8

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_10 = 29 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_8) / 29)

				if (29 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_8) / 29)) > 0 and var_34_7 < var_34_10 then
					arg_31_1.talkMaxDuration = var_34_10

					if var_34_10 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_8
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_11 = math.max(var_34_7, arg_31_1.talkMaxDuration)

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_11 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_6) / var_34_11

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_6 + var_34_11 and arg_31_1.time_ < var_34_6 + var_34_11 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play910115009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 910115009
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play910115010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1074ui_story = arg_35_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1074ui_story"].transform.position).z)
				arg_35_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1074ui_story"].transform.localEulerAngles = arg_35_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_35_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1074ui_story"].transform.position).z)
				arg_35_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1074ui_story"].transform.localEulerAngles = arg_35_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1074ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1074ui_story == nil then
				arg_35_1.var_.characterEffect1074ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1074ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1074ui_story then
				arg_35_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_38_4 = arg_35_1.actors_["1070ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect1070ui_story == nil then
				arg_35_1.var_.characterEffect1070ui_story = var_38_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_5 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_5 and not isNil(var_38_4) then
				if arg_35_1.var_.characterEffect1070ui_story and not isNil(var_38_4) then
					arg_35_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_5)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_5 and arg_35_1.time_ < 0 + var_38_5 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect1070ui_story then
				arg_35_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_38_6 = 0
			local var_38_7 = 0.45

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_8 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(910115009).content)

				arg_35_1.text_.text = var_38_8

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_10 = 18 <= 0 and var_38_7 or var_38_7 * (utf8.len(var_38_8) / 18)

				if (18 <= 0 and var_38_7 or var_38_7 * (utf8.len(var_38_8) / 18)) > 0 and var_38_7 < var_38_10 then
					arg_35_1.talkMaxDuration = var_38_10

					if var_38_10 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_8
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_11 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_11 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_11

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_11 and arg_35_1.time_ < var_38_6 + var_38_11 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play910115010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 910115010
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play910115011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1070ui_story = arg_39_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1070ui_story"].transform.position).z)
				arg_39_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1070ui_story"].transform.localEulerAngles = arg_39_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_39_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1070ui_story"].transform.position).z)
				arg_39_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1070ui_story"].transform.localEulerAngles = arg_39_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1070ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1070ui_story == nil then
				arg_39_1.var_.characterEffect1070ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1070ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1070ui_story then
				arg_39_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_42_4 = arg_39_1.actors_["1074ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_4) and arg_39_1.var_.characterEffect1074ui_story == nil then
				arg_39_1.var_.characterEffect1074ui_story = var_42_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_5 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 and not isNil(var_42_4) then
				if arg_39_1.var_.characterEffect1074ui_story and not isNil(var_42_4) then
					arg_39_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_5)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 and not isNil(var_42_4) and arg_39_1.var_.characterEffect1074ui_story then
				arg_39_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_42_6 = 0
			local var_42_7 = 0.3

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_8 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(910115010).content)

				arg_39_1.text_.text = var_42_8

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_10 = 12 <= 0 and var_42_7 or var_42_7 * (utf8.len(var_42_8) / 12)

				if (12 <= 0 and var_42_7 or var_42_7 * (utf8.len(var_42_8) / 12)) > 0 and var_42_7 < var_42_10 then
					arg_39_1.talkMaxDuration = var_42_10

					if var_42_10 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_8
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_11 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_11 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_11

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_11 and arg_39_1.time_ < var_42_6 + var_42_11 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play910115011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 910115011
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play910115012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1074ui_story = arg_43_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1074ui_story"].transform.position).z)
				arg_43_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1074ui_story"].transform.localEulerAngles = arg_43_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_43_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1074ui_story"].transform.position).z)
				arg_43_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1074ui_story"].transform.localEulerAngles = arg_43_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1074ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1074ui_story == nil then
				arg_43_1.var_.characterEffect1074ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1074ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1074ui_story then
				arg_43_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_4 = arg_43_1.actors_["1070ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_4) and arg_43_1.var_.characterEffect1070ui_story == nil then
				arg_43_1.var_.characterEffect1070ui_story = var_46_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_5 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_5 and not isNil(var_46_4) then
				if arg_43_1.var_.characterEffect1070ui_story and not isNil(var_46_4) then
					arg_43_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_5)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_5 and arg_43_1.time_ < 0 + var_46_5 + arg_46_0 and not isNil(var_46_4) and arg_43_1.var_.characterEffect1070ui_story then
				arg_43_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_46_6 = 0
			local var_46_7 = 0.425

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_8 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(910115011).content)

				arg_43_1.text_.text = var_46_8

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_10 = 17 <= 0 and var_46_7 or var_46_7 * (utf8.len(var_46_8) / 17)

				if (17 <= 0 and var_46_7 or var_46_7 * (utf8.len(var_46_8) / 17)) > 0 and var_46_7 < var_46_10 then
					arg_43_1.talkMaxDuration = var_46_10

					if var_46_10 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_6
					end
				end

				arg_43_1.text_.text = var_46_8
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_11 = math.max(var_46_7, arg_43_1.talkMaxDuration)

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_11 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_6) / var_46_11

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_6 + var_46_11 and arg_43_1.time_ < var_46_6 + var_46_11 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play910115012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 910115012
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play910115013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1070ui_story = arg_47_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1070ui_story"].transform.position).z)
				arg_47_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1070ui_story"].transform.localEulerAngles = arg_47_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["1070ui_story"].transform.position).z)
				arg_47_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["1070ui_story"].transform.localEulerAngles = arg_47_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["1070ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1070ui_story == nil then
				arg_47_1.var_.characterEffect1070ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect1070ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_2)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect1070ui_story then
				arg_47_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_50_3 = arg_47_1.actors_["1074ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1074ui_story = var_50_3.localPosition
			end

			local var_50_4 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				var_50_3.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_4)
				var_50_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_3.position).x, (manager.ui.mainCamera.transform.position - var_50_3.position).y, (manager.ui.mainCamera.transform.position - var_50_3.position).z)
				var_50_3.localEulerAngles.z = 0
				var_50_3.localEulerAngles.x = 0
				var_50_3.localEulerAngles = var_50_3.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				var_50_3.localPosition = Vector3.New(0, 100, 0)
				var_50_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_3.position).x, (manager.ui.mainCamera.transform.position - var_50_3.position).y, (manager.ui.mainCamera.transform.position - var_50_3.position).z)
				var_50_3.localEulerAngles.z = 0
				var_50_3.localEulerAngles.x = 0
				var_50_3.localEulerAngles = var_50_3.localEulerAngles
			end

			local var_50_5 = arg_47_1.actors_["1074ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.characterEffect1074ui_story == nil then
				arg_47_1.var_.characterEffect1074ui_story = var_50_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_6 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_6 and not isNil(var_50_5) then
				if arg_47_1.var_.characterEffect1074ui_story and not isNil(var_50_5) then
					arg_47_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_6)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_6 and arg_47_1.time_ < 0 + var_50_6 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.characterEffect1074ui_story then
				arg_47_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_50_7 = 0
			local var_50_8 = 0.8

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_7 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_9 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(910115012).content)

				arg_47_1.text_.text = var_50_9

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_11 = 33 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_9) / 33)

				if (33 <= 0 and var_50_8 or var_50_8 * (utf8.len(var_50_9) / 33)) > 0 and var_50_8 < var_50_11 then
					arg_47_1.talkMaxDuration = var_50_11

					if var_50_11 + var_50_7 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_11 + var_50_7
					end
				end

				arg_47_1.text_.text = var_50_9
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_8, arg_47_1.talkMaxDuration)

			if var_50_7 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_7) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_7 + var_50_12 and arg_47_1.time_ < var_50_7 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
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

		arg_47_1:InitPlayNodeList()
	end,
	Play910115013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 910115013
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play910115014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.725

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(910115013).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 29 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 29)

				if (29 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 29)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play910115014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 910115014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play910115015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 1.35

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(910115014).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 54 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 54)

				if (54 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 54)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play910115015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 910115015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play910115016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1070ui_story = arg_59_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1070ui_story"].transform.position).z)
				arg_59_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1070ui_story"].transform.localEulerAngles = arg_59_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_59_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1070ui_story"].transform.position).z)
				arg_59_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1070ui_story"].transform.localEulerAngles = arg_59_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1070ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1070ui_story == nil then
				arg_59_1.var_.characterEffect1070ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1070ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1070ui_story then
				arg_59_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_62_4 = arg_59_1.actors_["1074ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1074ui_story = var_62_4.localPosition
			end

			local var_62_5 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 then
				var_62_4.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_59_1.time_ - 0) / var_62_5)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_5 and arg_59_1.time_ < 0 + var_62_5 + arg_62_0 then
				var_62_4.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			local var_62_6 = arg_59_1.actors_["1074ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect1074ui_story == nil then
				arg_59_1.var_.characterEffect1074ui_story = var_62_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_7 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 and not isNil(var_62_6) then
				if arg_59_1.var_.characterEffect1074ui_story and not isNil(var_62_6) then
					arg_59_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_7)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect1074ui_story then
				arg_59_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_62_8 = 0
			local var_62_9 = 0.275

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_10 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(910115015).content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_12 = 11 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_10) / 11)

				if (11 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_10) / 11)) > 0 and var_62_9 < var_62_12 then
					arg_59_1.talkMaxDuration = var_62_12

					if var_62_12 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_8
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_13 = math.max(var_62_9, arg_59_1.talkMaxDuration)

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_13 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_8) / var_62_13

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_8 + var_62_13 and arg_59_1.time_ < var_62_8 + var_62_13 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play910115016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 910115016
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play910115017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1074ui_story = arg_63_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1074ui_story"].transform.position).z)
				arg_63_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1074ui_story"].transform.localEulerAngles = arg_63_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_63_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1074ui_story"].transform.position).z)
				arg_63_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1074ui_story"].transform.localEulerAngles = arg_63_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["1074ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1074ui_story == nil then
				arg_63_1.var_.characterEffect1074ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect1074ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1074ui_story then
				arg_63_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_66_4 = arg_63_1.actors_["1070ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1070ui_story == nil then
				arg_63_1.var_.characterEffect1070ui_story = var_66_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_5 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_5 and not isNil(var_66_4) then
				if arg_63_1.var_.characterEffect1070ui_story and not isNil(var_66_4) then
					arg_63_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_5)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_5 and arg_63_1.time_ < 0 + var_66_5 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1070ui_story then
				arg_63_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_66_6 = 0
			local var_66_7 = 1.3

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_8 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(910115016).content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 52 <= 0 and var_66_7 or var_66_7 * (utf8.len(var_66_8) / 52)

				if (52 <= 0 and var_66_7 or var_66_7 * (utf8.len(var_66_8) / 52)) > 0 and var_66_7 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_11 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_11 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_11

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_11 and arg_63_1.time_ < var_66_6 + var_66_11 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play910115017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 910115017
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play910115018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1070ui_story = arg_67_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1070ui_story"].transform.position).z)
				arg_67_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1070ui_story"].transform.localEulerAngles = arg_67_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_67_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1070ui_story"].transform.position).z)
				arg_67_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1070ui_story"].transform.localEulerAngles = arg_67_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1070ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1070ui_story == nil then
				arg_67_1.var_.characterEffect1070ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1070ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1070ui_story then
				arg_67_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_70_4 = arg_67_1.actors_["1074ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect1074ui_story == nil then
				arg_67_1.var_.characterEffect1074ui_story = var_70_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_5 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_5 and not isNil(var_70_4) then
				if arg_67_1.var_.characterEffect1074ui_story and not isNil(var_70_4) then
					arg_67_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_5)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_5 and arg_67_1.time_ < 0 + var_70_5 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect1074ui_story then
				arg_67_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_70_6 = 0
			local var_70_7 = 0.225

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_8 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(910115017).content)

				arg_67_1.text_.text = var_70_8

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_10 = 9 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_8) / 9)

				if (9 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_8) / 9)) > 0 and var_70_7 < var_70_10 then
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
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play910115018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 910115018
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play910115019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1074ui_story = arg_71_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1074ui_story"].transform.position).z)
				arg_71_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1074ui_story"].transform.localEulerAngles = arg_71_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_71_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1074ui_story"].transform.position).z)
				arg_71_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1074ui_story"].transform.localEulerAngles = arg_71_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1074ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1074ui_story == nil then
				arg_71_1.var_.characterEffect1074ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1074ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1074ui_story then
				arg_71_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_74_4 = arg_71_1.actors_["1070ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1070ui_story == nil then
				arg_71_1.var_.characterEffect1070ui_story = var_74_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_5 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 and not isNil(var_74_4) then
				if arg_71_1.var_.characterEffect1070ui_story and not isNil(var_74_4) then
					arg_71_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_5)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1070ui_story then
				arg_71_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_74_6 = 0
			local var_74_7 = 0.375

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(910115018).content)

				arg_71_1.text_.text = var_74_8

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 15 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_8) / 15)

				if (15 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_8) / 15)) > 0 and var_74_7 < var_74_10 then
					arg_71_1.talkMaxDuration = var_74_10

					if var_74_10 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_8
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_11 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_11 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_11

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_11 and arg_71_1.time_ < var_74_6 + var_74_11 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play910115019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 910115019
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play910115020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1070ui_story = arg_75_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1070ui_story"].transform.position).z)
				arg_75_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1070ui_story"].transform.localEulerAngles = arg_75_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_75_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1070ui_story"].transform.position).z)
				arg_75_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1070ui_story"].transform.localEulerAngles = arg_75_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["1070ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1070ui_story == nil then
				arg_75_1.var_.characterEffect1070ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect1070ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1070ui_story then
				arg_75_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_78_4 = arg_75_1.actors_["1074ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect1074ui_story == nil then
				arg_75_1.var_.characterEffect1074ui_story = var_78_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_5 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 and not isNil(var_78_4) then
				if arg_75_1.var_.characterEffect1074ui_story and not isNil(var_78_4) then
					arg_75_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_5)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect1074ui_story then
				arg_75_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_78_6 = 0
			local var_78_7 = 0.775

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_8 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(910115019).content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 31 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_8) / 31)

				if (31 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_8) / 31)) > 0 and var_78_7 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_11 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_11 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_11

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_11 and arg_75_1.time_ < var_78_6 + var_78_11 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play910115020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 910115020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play910115021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1070ui_story = arg_79_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1070ui_story"].transform.position).z)
				arg_79_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1070ui_story"].transform.localEulerAngles = arg_79_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1070ui_story"].transform.position).z)
				arg_79_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1070ui_story"].transform.localEulerAngles = arg_79_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1070ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1070ui_story == nil then
				arg_79_1.var_.characterEffect1070ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect1070ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_2)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect1070ui_story then
				arg_79_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_82_3 = arg_79_1.actors_["1074ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1074ui_story = var_82_3.localPosition
			end

			local var_82_4 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				var_82_3.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 0) / var_82_4)
				var_82_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_3.position).x, (manager.ui.mainCamera.transform.position - var_82_3.position).y, (manager.ui.mainCamera.transform.position - var_82_3.position).z)
				var_82_3.localEulerAngles.z = 0
				var_82_3.localEulerAngles.x = 0
				var_82_3.localEulerAngles = var_82_3.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				var_82_3.localPosition = Vector3.New(0, 100, 0)
				var_82_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_3.position).x, (manager.ui.mainCamera.transform.position - var_82_3.position).y, (manager.ui.mainCamera.transform.position - var_82_3.position).z)
				var_82_3.localEulerAngles.z = 0
				var_82_3.localEulerAngles.x = 0
				var_82_3.localEulerAngles = var_82_3.localEulerAngles
			end

			local var_82_5 = arg_79_1.actors_["1074ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_5) and arg_79_1.var_.characterEffect1074ui_story == nil then
				arg_79_1.var_.characterEffect1074ui_story = var_82_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_6 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_6 and not isNil(var_82_5) then
				if arg_79_1.var_.characterEffect1074ui_story and not isNil(var_82_5) then
					arg_79_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_6)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_6 and arg_79_1.time_ < 0 + var_82_6 + arg_82_0 and not isNil(var_82_5) and arg_79_1.var_.characterEffect1074ui_story then
				arg_79_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_82_7 = 0
			local var_82_8 = 0.625

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_9 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(910115020).content)

				arg_79_1.text_.text = var_82_9

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 25 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_9) / 25)

				if (25 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_9) / 25)) > 0 and var_82_8 < var_82_11 then
					arg_79_1.talkMaxDuration = var_82_11

					if var_82_11 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_11 + var_82_7
					end
				end

				arg_79_1.text_.text = var_82_9
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_8, arg_79_1.talkMaxDuration)

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_7) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_7 + var_82_12 and arg_79_1.time_ < var_82_7 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play910115021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 910115021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play910115022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1074ui_story = arg_83_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1074ui_story"].transform.position).z)
				arg_83_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1074ui_story"].transform.localEulerAngles = arg_83_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.12)
				arg_83_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1074ui_story"].transform.position).z)
				arg_83_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1074ui_story"].transform.localEulerAngles = arg_83_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_86_1 = arg_83_1.actors_["1074ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1074ui_story == nil then
				arg_83_1.var_.characterEffect1074ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect1074ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect1074ui_story then
				arg_83_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_86_4 = 0
			local var_86_5 = 0.95

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_6 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(910115021).content)

				arg_83_1.text_.text = var_86_6

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_8 = 38 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_6) / 38)

				if (38 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_6) / 38)) > 0 and var_86_5 < var_86_8 then
					arg_83_1.talkMaxDuration = var_86_8

					if var_86_8 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_6
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 <= arg_83_1.time_ and arg_83_1.time_ < var_86_4 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_4) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_4 + var_86_9 and arg_83_1.time_ < var_86_4 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play910115022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 910115022
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play910115023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1074ui_story = arg_87_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1074ui_story"].transform.position).z)
				arg_87_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1074ui_story"].transform.localEulerAngles = arg_87_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1074ui_story"].transform.position).z)
				arg_87_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1074ui_story"].transform.localEulerAngles = arg_87_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1074ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1074ui_story == nil then
				arg_87_1.var_.characterEffect1074ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1074ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_2)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1074ui_story then
				arg_87_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_90_3 = 0
			local var_90_4 = 0.775

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_5 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(910115022).content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 32 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_5) / 32)

				if (32 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_5) / 32)) > 0 and var_90_4 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_3
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_4, arg_87_1.talkMaxDuration)

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_3) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_3 + var_90_8 and arg_87_1.time_ < var_90_3 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play910115023 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 910115023
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play910115024(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.8

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(910115023).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 32 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 32)

				if (32 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 32)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play910115024 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 910115024
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play910115025(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.225

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(910115024).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 9 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 9)

				if (9 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 9)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play910115025 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 910115025
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play910115026(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.725

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(910115025).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 29 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 29)

				if (29 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 29)) > 0 and var_102_0 < var_102_3 then
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
	Play910115026 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 910115026
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play910115027(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.575

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(910115026).content)

				arg_103_1.text_.text = var_106_1

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_3 = 23 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 23)

				if (23 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_1) / 23)) > 0 and var_106_0 < var_106_3 then
					arg_103_1.talkMaxDuration = var_106_3

					if var_106_3 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_3 + 0
					end
				end

				arg_103_1.text_.text = var_106_1
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_4 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_4

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play910115027 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 910115027
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play910115028(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1070ui_story = arg_107_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1070ui_story"].transform.position).z)
				arg_107_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1070ui_story"].transform.localEulerAngles = arg_107_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_107_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1070ui_story"].transform.position).z)
				arg_107_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1070ui_story"].transform.localEulerAngles = arg_107_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["1070ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1070ui_story == nil then
				arg_107_1.var_.characterEffect1070ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect1070ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1070ui_story then
				arg_107_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_110_4 = 0
			local var_110_5 = 0.35

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(910115027).content)

				arg_107_1.text_.text = var_110_6

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_8 = 14 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_6) / 14)

				if (14 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_6) / 14)) > 0 and var_110_5 < var_110_8 then
					arg_107_1.talkMaxDuration = var_110_8

					if var_110_8 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_6
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_9 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_9 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_9

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_9 and arg_107_1.time_ < var_110_4 + var_110_9 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play910115028 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 910115028
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play910115029(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1070ui_story = arg_111_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1070ui_story"].transform.position).z)
				arg_111_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1070ui_story"].transform.localEulerAngles = arg_111_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1070ui_story"].transform.position).z)
				arg_111_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1070ui_story"].transform.localEulerAngles = arg_111_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_114_1 = arg_111_1.actors_["1070ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1070ui_story == nil then
				arg_111_1.var_.characterEffect1070ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect1070ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_2)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1070ui_story then
				arg_111_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_114_3 = 0
			local var_114_4 = 0.95

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_3 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_5 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(910115028).content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 36 <= 0 and var_114_4 or var_114_4 * (utf8.len(var_114_5) / 36)

				if (36 <= 0 and var_114_4 or var_114_4 * (utf8.len(var_114_5) / 36)) > 0 and var_114_4 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_3 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_3
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_8 = math.max(var_114_4, arg_111_1.talkMaxDuration)

			if var_114_3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_3 + var_114_8 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_3) / var_114_8

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_3 + var_114_8 and arg_111_1.time_ < var_114_3 + var_114_8 + arg_114_0 then
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
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play910115029 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 910115029
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play910115030(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 1.075

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(910115029).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 43 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 43)

				if (43 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 43)) > 0 and var_118_0 < var_118_3 then
					arg_115_1.talkMaxDuration = var_118_3

					if var_118_3 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_3 + 0
					end
				end

				arg_115_1.text_.text = var_118_1
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_4 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_4

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play910115030 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 910115030
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play910115031(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if arg_119_1.actors_["1060ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1060ui_story"))) then
				local var_122_0 = Object.Instantiate(Asset.Load("Char/" .. "1060ui_story"), arg_119_1.stage_.transform)

				var_122_0.name = "1060ui_story"
				var_122_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.actors_["1060ui_story"] = var_122_0

				local var_122_1 = var_122_0:GetComponentInChildren(typeof(CharacterEffect))

				var_122_1.enabled = true

				local var_122_2 = GameObjectTools.GetOrAddComponent(var_122_0, typeof(DynamicBoneHelper))

				if var_122_2 then
					var_122_2:EnableDynamicBone(false)
				end

				arg_119_1:ShowWeapon(var_122_1.transform, false)

				arg_119_1.var_["1060ui_story" .. "Animator"] = var_122_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_119_1.var_["1060ui_story" .. "Animator"].applyRootMotion = true
				arg_119_1.var_["1060ui_story" .. "LipSync"] = var_122_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_122_3 = arg_119_1.actors_["1060ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1060ui_story = var_122_3.localPosition
			end

			local var_122_4 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				var_122_3.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1060ui_story, Vector3.New(-0.7, -1.14, -6.33), (arg_119_1.time_ - 0) / var_122_4)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				var_122_3.localPosition = Vector3.New(-0.7, -1.14, -6.33)
				var_122_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_3.position).x, (manager.ui.mainCamera.transform.position - var_122_3.position).y, (manager.ui.mainCamera.transform.position - var_122_3.position).z)
				var_122_3.localEulerAngles.z = 0
				var_122_3.localEulerAngles.x = 0
				var_122_3.localEulerAngles = var_122_3.localEulerAngles
			end

			local var_122_5 = arg_119_1.actors_["1060ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1060ui_story == nil then
				arg_119_1.var_.characterEffect1060ui_story = var_122_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_6 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_6 and not isNil(var_122_5) then
				if arg_119_1.var_.characterEffect1060ui_story and not isNil(var_122_5) then
					arg_119_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_6 and arg_119_1.time_ < 0 + var_122_6 + arg_122_0 and not isNil(var_122_5) and arg_119_1.var_.characterEffect1060ui_story then
				arg_119_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_1")
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_122_8 = arg_119_1.actors_["1074ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1074ui_story = var_122_8.localPosition
			end

			local var_122_9 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_9 then
				var_122_8.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_119_1.time_ - 0) / var_122_9)
				var_122_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_8.position).x, (manager.ui.mainCamera.transform.position - var_122_8.position).y, (manager.ui.mainCamera.transform.position - var_122_8.position).z)
				var_122_8.localEulerAngles.z = 0
				var_122_8.localEulerAngles.x = 0
				var_122_8.localEulerAngles = var_122_8.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_9 and arg_119_1.time_ < 0 + var_122_9 + arg_122_0 then
				var_122_8.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_122_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_8.position).x, (manager.ui.mainCamera.transform.position - var_122_8.position).y, (manager.ui.mainCamera.transform.position - var_122_8.position).z)
				var_122_8.localEulerAngles.z = 0
				var_122_8.localEulerAngles.x = 0
				var_122_8.localEulerAngles = var_122_8.localEulerAngles
			end

			local var_122_10 = arg_119_1.actors_["1074ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_10) and arg_119_1.var_.characterEffect1074ui_story == nil then
				arg_119_1.var_.characterEffect1074ui_story = var_122_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_11 and not isNil(var_122_10) then
				if arg_119_1.var_.characterEffect1074ui_story and not isNil(var_122_10) then
					arg_119_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_11)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_11 and arg_119_1.time_ < 0 + var_122_11 + arg_122_0 and not isNil(var_122_10) and arg_119_1.var_.characterEffect1074ui_story then
				arg_119_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_122_12 = 0
			local var_122_13 = 0.35

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_14 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(910115030).content)

				arg_119_1.text_.text = var_122_14

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_16 = 14 <= 0 and var_122_13 or var_122_13 * (utf8.len(var_122_14) / 14)

				if (14 <= 0 and var_122_13 or var_122_13 * (utf8.len(var_122_14) / 14)) > 0 and var_122_13 < var_122_16 then
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
				actorName = "1060ui_story",
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

		arg_119_1:InitPlayNodeList()
	end,
	Play910115031 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 910115031
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play910115032(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1060ui_story"]) and arg_123_1.var_.characterEffect1060ui_story == nil then
				arg_123_1.var_.characterEffect1060ui_story = arg_123_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_0 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1060ui_story"]) then
				if arg_123_1.var_.characterEffect1060ui_story and not isNil(arg_123_1.actors_["1060ui_story"]) then
					arg_123_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_0)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1060ui_story"]) and arg_123_1.var_.characterEffect1060ui_story then
				arg_123_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_126_1 = 0
			local var_126_2 = 0.65

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(910115031).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 26 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 26)

				if (26 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 26)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_6 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_6

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_6 and arg_123_1.time_ < var_126_1 + var_126_6 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play910115032 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 910115032
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play910115033(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1074ui_story = arg_127_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1074ui_story"].transform.position).z)
				arg_127_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1074ui_story"].transform.localEulerAngles = arg_127_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_127_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1074ui_story"].transform.position).z)
				arg_127_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1074ui_story"].transform.localEulerAngles = arg_127_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1074ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1074ui_story == nil then
				arg_127_1.var_.characterEffect1074ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1074ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1074ui_story then
				arg_127_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_4 = 0
			local var_130_5 = 0.375

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(910115032).content)

				arg_127_1.text_.text = var_130_6

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_8 = 15 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_6) / 15)

				if (15 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_6) / 15)) > 0 and var_130_5 < var_130_8 then
					arg_127_1.talkMaxDuration = var_130_8

					if var_130_8 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_6
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_9 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_9 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_9

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_9 and arg_127_1.time_ < var_130_4 + var_130_9 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play910115033 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 910115033
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play910115034(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1060ui_story = arg_131_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_134_0 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 then
				arg_131_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1060ui_story, Vector3.New(-0.7, -1.14, -6.33), (arg_131_1.time_ - 0) / var_134_0)
				arg_131_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1060ui_story"].transform.position).z)
				arg_131_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1060ui_story"].transform.localEulerAngles = arg_131_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 then
				arg_131_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(-0.7, -1.14, -6.33)
				arg_131_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_131_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_131_1.actors_["1060ui_story"].transform.position).z)
				arg_131_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_131_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_131_1.actors_["1060ui_story"].transform.localEulerAngles = arg_131_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_134_1 = arg_131_1.actors_["1060ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1060ui_story == nil then
				arg_131_1.var_.characterEffect1060ui_story = var_134_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_2 and not isNil(var_134_1) then
				if arg_131_1.var_.characterEffect1060ui_story and not isNil(var_134_1) then
					arg_131_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_2 and arg_131_1.time_ < 0 + var_134_2 + arg_134_0 and not isNil(var_134_1) and arg_131_1.var_.characterEffect1060ui_story then
				arg_131_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_2")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_134_4 = arg_131_1.actors_["1074ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1074ui_story == nil then
				arg_131_1.var_.characterEffect1074ui_story = var_134_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_5 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_5 and not isNil(var_134_4) then
				if arg_131_1.var_.characterEffect1074ui_story and not isNil(var_134_4) then
					arg_131_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_5)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_5 and arg_131_1.time_ < 0 + var_134_5 + arg_134_0 and not isNil(var_134_4) and arg_131_1.var_.characterEffect1074ui_story then
				arg_131_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_134_6 = 0
			local var_134_7 = 0.525

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_6 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_8 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(910115033).content)

				arg_131_1.text_.text = var_134_8

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 21 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_8) / 21)

				if (21 <= 0 and var_134_7 or var_134_7 * (utf8.len(var_134_8) / 21)) > 0 and var_134_7 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10

					if var_134_10 + var_134_6 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_6
					end
				end

				arg_131_1.text_.text = var_134_8
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_11 = math.max(var_134_7, arg_131_1.talkMaxDuration)

			if var_134_6 <= arg_131_1.time_ and arg_131_1.time_ < var_134_6 + var_134_11 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_6) / var_134_11

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_6 + var_134_11 and arg_131_1.time_ < var_134_6 + var_134_11 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play910115034 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 910115034
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play910115035(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1074ui_story = arg_135_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1074ui_story"].transform.position).z)
				arg_135_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1074ui_story"].transform.localEulerAngles = arg_135_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0.7, -1.055, -6.12)
				arg_135_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["1074ui_story"].transform.position).z)
				arg_135_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["1074ui_story"].transform.localEulerAngles = arg_135_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["1074ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1074ui_story == nil then
				arg_135_1.var_.characterEffect1074ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect1074ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect1074ui_story then
				arg_135_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action4_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_4 = arg_135_1.actors_["1060ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect1060ui_story == nil then
				arg_135_1.var_.characterEffect1060ui_story = var_138_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_5 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_5 and not isNil(var_138_4) then
				if arg_135_1.var_.characterEffect1060ui_story and not isNil(var_138_4) then
					arg_135_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_5)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_5 and arg_135_1.time_ < 0 + var_138_5 + arg_138_0 and not isNil(var_138_4) and arg_135_1.var_.characterEffect1060ui_story then
				arg_135_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_138_6 = 0
			local var_138_7 = 0.2

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_8 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(910115034).content)

				arg_135_1.text_.text = var_138_8

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 8 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_8) / 8)

				if (8 <= 0 and var_138_7 or var_138_7 * (utf8.len(var_138_8) / 8)) > 0 and var_138_7 < var_138_10 then
					arg_135_1.talkMaxDuration = var_138_10

					if var_138_10 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_8
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_11 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_11 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_11

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_11 and arg_135_1.time_ < var_138_6 + var_138_11 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play910115035 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 910115035
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play910115036(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1060ui_story = arg_139_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1060ui_story"].transform.position).z)
				arg_139_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1060ui_story"].transform.localEulerAngles = arg_139_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1060ui_story"].transform.position).z)
				arg_139_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1060ui_story"].transform.localEulerAngles = arg_139_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1074ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1074ui_story = var_142_1.localPosition
			end

			local var_142_2 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 then
				var_142_1.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_2)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 then
				var_142_1.localPosition = Vector3.New(0, 100, 0)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			local var_142_3 = 0
			local var_142_4 = 0.725

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_3 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_5 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(910115035).content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 29 <= 0 and var_142_4 or var_142_4 * (utf8.len(var_142_5) / 29)

				if (29 <= 0 and var_142_4 or var_142_4 * (utf8.len(var_142_5) / 29)) > 0 and var_142_4 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_3 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_3
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_4, arg_139_1.talkMaxDuration)

			if var_142_3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_3 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_3) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_3 + var_142_8 and arg_139_1.time_ < var_142_3 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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
	Play910115036 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 910115036
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play910115037(arg_143_1)
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
				arg_143_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_4 = 0
			local var_146_5 = 0.95

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
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

				local var_146_6 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(910115036).content)

				arg_143_1.text_.text = var_146_6

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_8 = 38 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_6) / 38)

				if (38 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_6) / 38)) > 0 and var_146_5 < var_146_8 then
					arg_143_1.talkMaxDuration = var_146_8

					if var_146_8 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_6
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_9 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_9 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_9

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_9 and arg_143_1.time_ < var_146_4 + var_146_9 + arg_146_0 then
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
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play910115037 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 910115037
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play910115038(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_0 = 0
			local var_150_1 = 0.8

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(910115037).content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 32 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_2) / 32)

				if (32 <= 0 and var_150_1 or var_150_1 * (utf8.len(var_150_2) / 32)) > 0 and var_150_1 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_5 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_5 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_5

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_5 and arg_147_1.time_ < var_150_0 + var_150_5 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play910115038 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 910115038
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play910115039(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1060ui_story = arg_151_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1060ui_story"].transform.position).z)
				arg_151_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1060ui_story"].transform.localEulerAngles = arg_151_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_151_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["1060ui_story"].transform.position).z)
				arg_151_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["1060ui_story"].transform.localEulerAngles = arg_151_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["1060ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1060ui_story == nil then
				arg_151_1.var_.characterEffect1060ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect1060ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect1060ui_story then
				arg_151_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action9_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_154_4 = arg_151_1.actors_["1070ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1070ui_story = var_154_4.localPosition
			end

			local var_154_5 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_5 then
				var_154_4.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_5)
				var_154_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_4.position).x, (manager.ui.mainCamera.transform.position - var_154_4.position).y, (manager.ui.mainCamera.transform.position - var_154_4.position).z)
				var_154_4.localEulerAngles.z = 0
				var_154_4.localEulerAngles.x = 0
				var_154_4.localEulerAngles = var_154_4.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_5 and arg_151_1.time_ < 0 + var_154_5 + arg_154_0 then
				var_154_4.localPosition = Vector3.New(0, 100, 0)
				var_154_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_4.position).x, (manager.ui.mainCamera.transform.position - var_154_4.position).y, (manager.ui.mainCamera.transform.position - var_154_4.position).z)
				var_154_4.localEulerAngles.z = 0
				var_154_4.localEulerAngles.x = 0
				var_154_4.localEulerAngles = var_154_4.localEulerAngles
			end

			local var_154_6 = arg_151_1.actors_["1070ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect1070ui_story == nil then
				arg_151_1.var_.characterEffect1070ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_7 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 and not isNil(var_154_6) then
				if arg_151_1.var_.characterEffect1070ui_story and not isNil(var_154_6) then
					arg_151_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_7)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 and not isNil(var_154_6) and arg_151_1.var_.characterEffect1070ui_story then
				arg_151_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_154_8 = 0
			local var_154_9 = 0.375

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_10 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(910115038).content)

				arg_151_1.text_.text = var_154_10

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_12 = 15 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_10) / 15)

				if (15 <= 0 and var_154_9 or var_154_9 * (utf8.len(var_154_10) / 15)) > 0 and var_154_9 < var_154_12 then
					arg_151_1.talkMaxDuration = var_154_12

					if var_154_12 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_12 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_10
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_13 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_13 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_13

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_13 and arg_151_1.time_ < var_154_8 + var_154_13 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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

		arg_151_1:InitPlayNodeList()
	end,
	Play910115039 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 910115039
		arg_155_1.duration_ = 9

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play910115040(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 2 < arg_155_1.time_ and arg_155_1.time_ <= 2 + arg_158_0 then
				local var_158_0 = arg_155_1.bgs_.ST31

				arg_155_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_158_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_1 = var_158_0:GetComponent("SpriteRenderer")

				if var_158_1 and var_158_1.sprite then
					local var_158_2 = 2 * (var_158_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_158_0.transform.localScale = Vector3.New(var_158_2 / var_158_1.sprite.bounds.size.y < var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x and var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x or var_158_2 / var_158_1.sprite.bounds.size.y, var_158_2 / var_158_1.sprite.bounds.size.y < var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x and var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x or var_158_2 / var_158_1.sprite.bounds.size.y, 0)
				end

				for iter_158_0, iter_158_1 in pairs(arg_155_1.bgs_) do
					if iter_158_0 ~= "ST31" then
						iter_158_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_3 = 0

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_4 = 2

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_4 then
				local var_158_5 = Color.New(0, 0, 0)

				var_158_5.a = Mathf.Lerp(0, 1, (arg_155_1.time_ - var_158_3) / var_158_4)
				arg_155_1.mask_.color = var_158_5
			end

			if arg_155_1.time_ >= var_158_3 + var_158_4 and arg_155_1.time_ < var_158_3 + var_158_4 + arg_158_0 then
				local var_158_6 = Color.New(0, 0, 0)

				var_158_6.a = 1
				arg_155_1.mask_.color = var_158_6
			end

			local var_158_7 = 2

			if 2 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_8 = 2

			if var_158_7 <= arg_155_1.time_ and arg_155_1.time_ < var_158_7 + var_158_8 then
				local var_158_9 = Color.New(0, 0, 0)

				var_158_9.a = Mathf.Lerp(1, 0, (arg_155_1.time_ - var_158_7) / var_158_8)
				arg_155_1.mask_.color = var_158_9
			end

			if arg_155_1.time_ >= var_158_7 + var_158_8 and arg_155_1.time_ < var_158_7 + var_158_8 + arg_158_0 then
				local var_158_10 = Color.New(0, 0, 0)

				arg_155_1.mask_.enabled = false
				var_158_10.a = 0
				arg_155_1.mask_.color = var_158_10
			end

			local var_158_11 = arg_155_1.actors_["1060ui_story"].transform

			if 4 < arg_155_1.time_ and arg_155_1.time_ <= 4 + arg_158_0 then
				arg_155_1.var_.moveOldPos1060ui_story = var_158_11.localPosition
			end

			local var_158_12 = 0.001

			if 4 <= arg_155_1.time_ and arg_155_1.time_ < 4 + var_158_12 then
				var_158_11.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_155_1.time_ - 4) / var_158_12)
				var_158_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_11.position).x, (manager.ui.mainCamera.transform.position - var_158_11.position).y, (manager.ui.mainCamera.transform.position - var_158_11.position).z)
				var_158_11.localEulerAngles.z = 0
				var_158_11.localEulerAngles.x = 0
				var_158_11.localEulerAngles = var_158_11.localEulerAngles
			end

			if arg_155_1.time_ >= 4 + var_158_12 and arg_155_1.time_ < 4 + var_158_12 + arg_158_0 then
				var_158_11.localPosition = Vector3.New(0, -1.14, -6.33)
				var_158_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_11.position).x, (manager.ui.mainCamera.transform.position - var_158_11.position).y, (manager.ui.mainCamera.transform.position - var_158_11.position).z)
				var_158_11.localEulerAngles.z = 0
				var_158_11.localEulerAngles.x = 0
				var_158_11.localEulerAngles = var_158_11.localEulerAngles
			end

			local var_158_13 = arg_155_1.actors_["1060ui_story"]

			if 4 < arg_155_1.time_ and arg_155_1.time_ <= 4 + arg_158_0 and not isNil(var_158_13) and arg_155_1.var_.characterEffect1060ui_story == nil then
				arg_155_1.var_.characterEffect1060ui_story = var_158_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_14 = 0.200000002980232

			if 4 <= arg_155_1.time_ and arg_155_1.time_ < 4 + var_158_14 and not isNil(var_158_13) then
				if arg_155_1.var_.characterEffect1060ui_story and not isNil(var_158_13) then
					arg_155_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 4 + var_158_14 and arg_155_1.time_ < 4 + var_158_14 + arg_158_0 and not isNil(var_158_13) and arg_155_1.var_.characterEffect1060ui_story then
				arg_155_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 4 < arg_155_1.time_ and arg_155_1.time_ <= 4 + arg_158_0 then
				arg_155_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			if 4 < arg_155_1.time_ and arg_155_1.time_ <= 4 + arg_158_0 then
				arg_155_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_16 = arg_155_1.actors_["1060ui_story"].transform

			if 2 < arg_155_1.time_ and arg_155_1.time_ <= 2 + arg_158_0 then
				arg_155_1.var_.moveOldPos1060ui_story = var_158_16.localPosition
			end

			local var_158_17 = 0.001

			if 2 <= arg_155_1.time_ and arg_155_1.time_ < 2 + var_158_17 then
				var_158_16.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 2) / var_158_17)
				var_158_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_16.position).x, (manager.ui.mainCamera.transform.position - var_158_16.position).y, (manager.ui.mainCamera.transform.position - var_158_16.position).z)
				var_158_16.localEulerAngles.z = 0
				var_158_16.localEulerAngles.x = 0
				var_158_16.localEulerAngles = var_158_16.localEulerAngles
			end

			if arg_155_1.time_ >= 2 + var_158_17 and arg_155_1.time_ < 2 + var_158_17 + arg_158_0 then
				var_158_16.localPosition = Vector3.New(0, 100, 0)
				var_158_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_16.position).x, (manager.ui.mainCamera.transform.position - var_158_16.position).y, (manager.ui.mainCamera.transform.position - var_158_16.position).z)
				var_158_16.localEulerAngles.z = 0
				var_158_16.localEulerAngles.x = 0
				var_158_16.localEulerAngles = var_158_16.localEulerAngles
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_18 = 4
			local var_158_19 = 0.5

			if 4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_18 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_20 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_20:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_21 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(910115039).content)

				arg_155_1.text_.text = var_158_21

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_23 = 20 <= 0 and var_158_19 or var_158_19 * (utf8.len(var_158_21) / 20)

				if (20 <= 0 and var_158_19 or var_158_19 * (utf8.len(var_158_21) / 20)) > 0 and var_158_19 < var_158_23 then
					arg_155_1.talkMaxDuration = var_158_23
					var_158_18 = var_158_18 + 0.3

					if var_158_23 + var_158_18 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_23 + var_158_18
					end
				end

				arg_155_1.text_.text = var_158_21
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_24 = var_158_18 + 0.3
			local var_158_25 = math.max(var_158_19, arg_155_1.talkMaxDuration)

			if var_158_18 + 0.3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_24 + var_158_25 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_24) / var_158_25

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_24 + var_158_25 and arg_155_1.time_ < var_158_24 + var_158_25 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play910115040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 910115040
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play910115041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.9

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(910115040).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 36 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 36)

				if (36 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 36)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play910115041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 910115041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play910115042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_0 = 0
			local var_168_1 = 0.375

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_2 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(910115041).content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 15 <= 0 and var_168_1 or var_168_1 * (utf8.len(var_168_2) / 15)

				if (15 <= 0 and var_168_1 or var_168_1 * (utf8.len(var_168_2) / 15)) > 0 and var_168_1 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_5 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_5 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_5

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_5 and arg_165_1.time_ < var_168_0 + var_168_5 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play910115042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 910115042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play910115043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(arg_169_1.actors_["1060ui_story"]) and arg_169_1.var_.characterEffect1060ui_story == nil then
				arg_169_1.var_.characterEffect1060ui_story = arg_169_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_0 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 and not isNil(arg_169_1.actors_["1060ui_story"]) then
				if arg_169_1.var_.characterEffect1060ui_story and not isNil(arg_169_1.actors_["1060ui_story"]) then
					arg_169_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_0)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 and not isNil(arg_169_1.actors_["1060ui_story"]) and arg_169_1.var_.characterEffect1060ui_story then
				arg_169_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_172_1 = 0
			local var_172_2 = 0.45

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(910115042).content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 18 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 18)

				if (18 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 18)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_6 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_6 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_6

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_6 and arg_169_1.time_ < var_172_1 + var_172_6 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play910115043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 910115043
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play910115044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1060ui_story = arg_173_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1060ui_story"].transform.position).z)
				arg_173_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1060ui_story"].transform.localEulerAngles = arg_173_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_173_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1060ui_story"].transform.position).z)
				arg_173_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1060ui_story"].transform.localEulerAngles = arg_173_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1060ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1060ui_story == nil then
				arg_173_1.var_.characterEffect1060ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1060ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1060ui_story then
				arg_173_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_2")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_4 = 0
			local var_176_5 = 0.125

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(910115043).content)

				arg_173_1.text_.text = var_176_6

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_8 = 5 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_6) / 5)

				if (5 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_6) / 5)) > 0 and var_176_5 < var_176_8 then
					arg_173_1.talkMaxDuration = var_176_8

					if var_176_8 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_6
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_9 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_9 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_9

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_9 and arg_173_1.time_ < var_176_4 + var_176_9 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play910115044 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 910115044
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play910115045(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.375

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(910115044).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 15 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 15)

				if (15 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 15)) > 0 and var_180_0 < var_180_3 then
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
	Play910115045 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 910115045
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play910115046(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1060ui_story = arg_181_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1060ui_story"].transform.position).z)
				arg_181_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1060ui_story"].transform.localEulerAngles = arg_181_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1060ui_story"].transform.position).z)
				arg_181_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1060ui_story"].transform.localEulerAngles = arg_181_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1060ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1060ui_story == nil then
				arg_181_1.var_.characterEffect1060ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1060ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_2)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1060ui_story then
				arg_181_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_184_3 = 0
			local var_184_4 = 1.45

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_5 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(910115045).content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 58 <= 0 and var_184_4 or var_184_4 * (utf8.len(var_184_5) / 58)

				if (58 <= 0 and var_184_4 or var_184_4 * (utf8.len(var_184_5) / 58)) > 0 and var_184_4 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_3 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_3
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_4, arg_181_1.talkMaxDuration)

			if var_184_3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_3 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_3) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_3 + var_184_8 and arg_181_1.time_ < var_184_3 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play910115046 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 910115046
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play910115047(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.875

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(910115046).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 32 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 32)

				if (32 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 32)) > 0 and var_188_0 < var_188_3 then
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
	Play910115047 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 910115047
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play910115048(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1060ui_story = arg_189_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1060ui_story"].transform.position).z)
				arg_189_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1060ui_story"].transform.localEulerAngles = arg_189_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_189_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1060ui_story"].transform.position).z)
				arg_189_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1060ui_story"].transform.localEulerAngles = arg_189_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1060ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1060ui_story == nil then
				arg_189_1.var_.characterEffect1060ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1060ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1060ui_story then
				arg_189_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_192_4 = 0
			local var_192_5 = 0.15

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(910115047).content)

				arg_189_1.text_.text = var_192_6

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_8 = 6 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_6) / 6)

				if (6 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_6) / 6)) > 0 and var_192_5 < var_192_8 then
					arg_189_1.talkMaxDuration = var_192_8

					if var_192_8 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_6
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_9 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_9 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_9

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_9 and arg_189_1.time_ < var_192_4 + var_192_9 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play910115048 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 910115048
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play910115049(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1060ui_story"]) and arg_193_1.var_.characterEffect1060ui_story == nil then
				arg_193_1.var_.characterEffect1060ui_story = arg_193_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1060ui_story"]) then
				if arg_193_1.var_.characterEffect1060ui_story and not isNil(arg_193_1.actors_["1060ui_story"]) then
					arg_193_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_0)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1060ui_story"]) and arg_193_1.var_.characterEffect1060ui_story then
				arg_193_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_196_1 = 0
			local var_196_2 = 0.725

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_3 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(910115048).content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 29 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 29)

				if (29 <= 0 and var_196_2 or var_196_2 * (utf8.len(var_196_3) / 29)) > 0 and var_196_2 < var_196_5 then
					arg_193_1.talkMaxDuration = var_196_5

					if var_196_5 + var_196_1 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + var_196_1
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_6 = math.max(var_196_2, arg_193_1.talkMaxDuration)

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_6 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_1) / var_196_6

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_1 + var_196_6 and arg_193_1.time_ < var_196_1 + var_196_6 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play910115049 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 910115049
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play910115050(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1060ui_story = arg_197_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1060ui_story"].transform.position).z)
				arg_197_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1060ui_story"].transform.localEulerAngles = arg_197_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_197_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1060ui_story"].transform.position).z)
				arg_197_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1060ui_story"].transform.localEulerAngles = arg_197_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["1060ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1060ui_story == nil then
				arg_197_1.var_.characterEffect1060ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1060ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1060ui_story then
				arg_197_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_200_4 = 0
			local var_200_5 = 0.575

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(910115049).content)

				arg_197_1.text_.text = var_200_6

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_8 = 23 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_6) / 23)

				if (23 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_6) / 23)) > 0 and var_200_5 < var_200_8 then
					arg_197_1.talkMaxDuration = var_200_8

					if var_200_8 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_6
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_9 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_9 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_9

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_9 and arg_197_1.time_ < var_200_4 + var_200_9 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play910115050 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 910115050
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play910115051(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.125

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(910115050).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 46 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 46)

				if (46 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 46)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play910115051 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 910115051
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play910115052(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1060ui_story"]) and arg_205_1.var_.characterEffect1060ui_story == nil then
				arg_205_1.var_.characterEffect1060ui_story = arg_205_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1060ui_story"]) then
				if arg_205_1.var_.characterEffect1060ui_story and not isNil(arg_205_1.actors_["1060ui_story"]) then
					arg_205_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_0)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1060ui_story"]) and arg_205_1.var_.characterEffect1060ui_story then
				arg_205_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_208_1 = 0
			local var_208_2 = 0.4

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(910115051).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 16 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 16)

				if (16 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 16)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_6 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_6 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_6

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_6 and arg_205_1.time_ < var_208_1 + var_208_6 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play910115052 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 910115052
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play910115053(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1060ui_story = arg_209_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1060ui_story"].transform.position).z)
				arg_209_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1060ui_story"].transform.localEulerAngles = arg_209_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_209_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1060ui_story"].transform.position).z)
				arg_209_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1060ui_story"].transform.localEulerAngles = arg_209_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1060ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1060ui_story == nil then
				arg_209_1.var_.characterEffect1060ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1060ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1060ui_story then
				arg_209_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_212_4 = 0
			local var_212_5 = 0.275

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(910115052).content)

				arg_209_1.text_.text = var_212_6

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_8 = 11 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_6) / 11)

				if (11 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_6) / 11)) > 0 and var_212_5 < var_212_8 then
					arg_209_1.talkMaxDuration = var_212_8

					if var_212_8 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_6
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_9 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_9 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_9

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_9 and arg_209_1.time_ < var_212_4 + var_212_9 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play910115053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 910115053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play910115054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1060ui_story"]) and arg_213_1.var_.characterEffect1060ui_story == nil then
				arg_213_1.var_.characterEffect1060ui_story = arg_213_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1060ui_story"]) then
				if arg_213_1.var_.characterEffect1060ui_story and not isNil(arg_213_1.actors_["1060ui_story"]) then
					arg_213_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1060ui_story"]) and arg_213_1.var_.characterEffect1060ui_story then
				arg_213_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_216_1 = 0
			local var_216_2 = 0.95

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(910115053).content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 38 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 38)

				if (38 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 38)) > 0 and var_216_2 < var_216_5 then
					arg_213_1.talkMaxDuration = var_216_5

					if var_216_5 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_6 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_6 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_6

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_6 and arg_213_1.time_ < var_216_1 + var_216_6 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play910115054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 910115054
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play910115055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.25

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(910115054).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 10 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 10)

				if (10 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 10)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play910115055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 910115055
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play910115056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1060ui_story = arg_221_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1060ui_story"].transform.position).z)
				arg_221_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1060ui_story"].transform.localEulerAngles = arg_221_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_221_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1060ui_story"].transform.position).z)
				arg_221_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1060ui_story"].transform.localEulerAngles = arg_221_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1060ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1060ui_story == nil then
				arg_221_1.var_.characterEffect1060ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1060ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1060ui_story then
				arg_221_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_224_4 = 0
			local var_224_5 = 0.225

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(910115055).content)

				arg_221_1.text_.text = var_224_6

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_8 = 9 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_6) / 9)

				if (9 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_6) / 9)) > 0 and var_224_5 < var_224_8 then
					arg_221_1.talkMaxDuration = var_224_8

					if var_224_8 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_6
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_9 = math.max(var_224_5, arg_221_1.talkMaxDuration)

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_9 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_4) / var_224_9

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_4 + var_224_9 and arg_221_1.time_ < var_224_4 + var_224_9 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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
	Play910115056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 910115056
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play910115057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.9

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(910115056).content)

				arg_225_1.text_.text = var_228_1

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_3 = 36 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 36)

				if (36 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_1) / 36)) > 0 and var_228_0 < var_228_3 then
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
	Play910115057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 910115057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play910115058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1060ui_story"]) and arg_229_1.var_.characterEffect1060ui_story == nil then
				arg_229_1.var_.characterEffect1060ui_story = arg_229_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1060ui_story"]) then
				if arg_229_1.var_.characterEffect1060ui_story and not isNil(arg_229_1.actors_["1060ui_story"]) then
					arg_229_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1060ui_story"]) and arg_229_1.var_.characterEffect1060ui_story then
				arg_229_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_232_1 = 0
			local var_232_2 = 0.9

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(910115057).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 36 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 36)

				if (36 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 36)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play910115058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 910115058
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play910115059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1060ui_story = arg_233_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1060ui_story"].transform.position).z)
				arg_233_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1060ui_story"].transform.localEulerAngles = arg_233_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_233_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1060ui_story"].transform.position).z)
				arg_233_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1060ui_story"].transform.localEulerAngles = arg_233_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["1060ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1060ui_story == nil then
				arg_233_1.var_.characterEffect1060ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect1060ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect1060ui_story then
				arg_233_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action5_1")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_4 = 0
			local var_236_5 = 0.55

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(910115058).content)

				arg_233_1.text_.text = var_236_6

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_8 = 22 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_6) / 22)

				if (22 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_6) / 22)) > 0 and var_236_5 < var_236_8 then
					arg_233_1.talkMaxDuration = var_236_8

					if var_236_8 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_6
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_9 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_9 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_9

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_9 and arg_233_1.time_ < var_236_4 + var_236_9 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play910115059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 910115059
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play910115060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0.125

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_1 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(910115059).content)

				arg_237_1.text_.text = var_240_1

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_3 = 5 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 5)

				if (5 <= 0 and var_240_0 or var_240_0 * (utf8.len(var_240_1) / 5)) > 0 and var_240_0 < var_240_3 then
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
	Play910115060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 910115060
		arg_241_1.duration_ = 9

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play910115061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 2 < arg_241_1.time_ and arg_241_1.time_ <= 2 + arg_244_0 then
				local var_244_0 = arg_241_1.bgs_.ST31

				arg_241_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_244_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_244_1 = var_244_0:GetComponent("SpriteRenderer")

				if var_244_1 and var_244_1.sprite then
					local var_244_2 = 2 * (var_244_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_244_0.transform.localScale = Vector3.New(var_244_2 / var_244_1.sprite.bounds.size.y < var_244_2 * manager.ui.mainCameraCom_.aspect / var_244_1.sprite.bounds.size.x and var_244_2 * manager.ui.mainCameraCom_.aspect / var_244_1.sprite.bounds.size.x or var_244_2 / var_244_1.sprite.bounds.size.y, var_244_2 / var_244_1.sprite.bounds.size.y < var_244_2 * manager.ui.mainCameraCom_.aspect / var_244_1.sprite.bounds.size.x and var_244_2 * manager.ui.mainCameraCom_.aspect / var_244_1.sprite.bounds.size.x or var_244_2 / var_244_1.sprite.bounds.size.y, 0)
				end

				for iter_244_0, iter_244_1 in pairs(arg_241_1.bgs_) do
					if iter_244_0 ~= "ST31" then
						iter_244_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_244_3 = 0

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_4 = 2

			if var_244_3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_3 + var_244_4 then
				local var_244_5 = Color.New(0, 0, 0)

				var_244_5.a = Mathf.Lerp(0, 1, (arg_241_1.time_ - var_244_3) / var_244_4)
				arg_241_1.mask_.color = var_244_5
			end

			if arg_241_1.time_ >= var_244_3 + var_244_4 and arg_241_1.time_ < var_244_3 + var_244_4 + arg_244_0 then
				local var_244_6 = Color.New(0, 0, 0)

				var_244_6.a = 1
				arg_241_1.mask_.color = var_244_6
			end

			local var_244_7 = 2

			if 2 < arg_241_1.time_ and arg_241_1.time_ <= var_244_7 + arg_244_0 then
				arg_241_1.mask_.enabled = true
				arg_241_1.mask_.raycastTarget = true

				arg_241_1:SetGaussion(false)
			end

			local var_244_8 = 2

			if var_244_7 <= arg_241_1.time_ and arg_241_1.time_ < var_244_7 + var_244_8 then
				local var_244_9 = Color.New(0, 0, 0)

				var_244_9.a = Mathf.Lerp(1, 0, (arg_241_1.time_ - var_244_7) / var_244_8)
				arg_241_1.mask_.color = var_244_9
			end

			if arg_241_1.time_ >= var_244_7 + var_244_8 and arg_241_1.time_ < var_244_7 + var_244_8 + arg_244_0 then
				local var_244_10 = Color.New(0, 0, 0)

				arg_241_1.mask_.enabled = false
				var_244_10.a = 0
				arg_241_1.mask_.color = var_244_10
			end

			local var_244_11 = arg_241_1.actors_["1060ui_story"].transform

			if 2 < arg_241_1.time_ and arg_241_1.time_ <= 2 + arg_244_0 then
				arg_241_1.var_.moveOldPos1060ui_story = var_244_11.localPosition
			end

			local var_244_12 = 0.001

			if 2 <= arg_241_1.time_ and arg_241_1.time_ < 2 + var_244_12 then
				var_244_11.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 2) / var_244_12)
				var_244_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_11.position).x, (manager.ui.mainCamera.transform.position - var_244_11.position).y, (manager.ui.mainCamera.transform.position - var_244_11.position).z)
				var_244_11.localEulerAngles.z = 0
				var_244_11.localEulerAngles.x = 0
				var_244_11.localEulerAngles = var_244_11.localEulerAngles
			end

			if arg_241_1.time_ >= 2 + var_244_12 and arg_241_1.time_ < 2 + var_244_12 + arg_244_0 then
				var_244_11.localPosition = Vector3.New(0, 100, 0)
				var_244_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_11.position).x, (manager.ui.mainCamera.transform.position - var_244_11.position).y, (manager.ui.mainCamera.transform.position - var_244_11.position).z)
				var_244_11.localEulerAngles.z = 0
				var_244_11.localEulerAngles.x = 0
				var_244_11.localEulerAngles = var_244_11.localEulerAngles
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_13 = 4
			local var_244_14 = 0.675

			if 4 < arg_241_1.time_ and arg_241_1.time_ <= var_244_13 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_15 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_15:setOnUpdate(LuaHelper.FloatAction(function(arg_245_0)
					arg_241_1.dialogCg_.alpha = arg_245_0
				end))
				var_244_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_16 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(910115060).content)

				arg_241_1.text_.text = var_244_16

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_18 = 27 <= 0 and var_244_14 or var_244_14 * (utf8.len(var_244_16) / 27)

				if (27 <= 0 and var_244_14 or var_244_14 * (utf8.len(var_244_16) / 27)) > 0 and var_244_14 < var_244_18 then
					arg_241_1.talkMaxDuration = var_244_18
					var_244_13 = var_244_13 + 0.3

					if var_244_18 + var_244_13 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_18 + var_244_13
					end
				end

				arg_241_1.text_.text = var_244_16
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_19 = var_244_13 + 0.3
			local var_244_20 = math.max(var_244_14, arg_241_1.talkMaxDuration)

			if var_244_13 + 0.3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_19 + var_244_20 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_19) / var_244_20

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_19 + var_244_20 and arg_241_1.time_ < var_244_19 + var_244_20 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play910115061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 910115061
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play910115062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1060ui_story = arg_247_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1060ui_story"].transform.position).z)
				arg_247_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1060ui_story"].transform.localEulerAngles = arg_247_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_247_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1060ui_story"].transform.position).z)
				arg_247_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1060ui_story"].transform.localEulerAngles = arg_247_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["1060ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1060ui_story == nil then
				arg_247_1.var_.characterEffect1060ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect1060ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1060ui_story then
				arg_247_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_250_4 = 0
			local var_250_5 = 0.425

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_6 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(910115061).content)

				arg_247_1.text_.text = var_250_6

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_8 = 17 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_6) / 17)

				if (17 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_6) / 17)) > 0 and var_250_5 < var_250_8 then
					arg_247_1.talkMaxDuration = var_250_8

					if var_250_8 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_8 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_6
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_9 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 <= arg_247_1.time_ and arg_247_1.time_ < var_250_4 + var_250_9 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_4) / var_250_9

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_4 + var_250_9 and arg_247_1.time_ < var_250_4 + var_250_9 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play910115062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 910115062
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play910115063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["1060ui_story"]) and arg_251_1.var_.characterEffect1060ui_story == nil then
				arg_251_1.var_.characterEffect1060ui_story = arg_251_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_0 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["1060ui_story"]) then
				if arg_251_1.var_.characterEffect1060ui_story and not isNil(arg_251_1.actors_["1060ui_story"]) then
					arg_251_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_0)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["1060ui_story"]) and arg_251_1.var_.characterEffect1060ui_story then
				arg_251_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_254_1 = 0
			local var_254_2 = 1.6

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(910115062).content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 64 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 64)

				if (64 <= 0 and var_254_2 or var_254_2 * (utf8.len(var_254_3) / 64)) > 0 and var_254_2 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_1 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_1
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_6 = math.max(var_254_2, arg_251_1.talkMaxDuration)

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_6 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_1) / var_254_6

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_1 + var_254_6 and arg_251_1.time_ < var_254_1 + var_254_6 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play910115063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 910115063
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play910115064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1060ui_story = arg_255_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1060ui_story"].transform.position).z)
				arg_255_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1060ui_story"].transform.localEulerAngles = arg_255_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_255_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1060ui_story"].transform.position).z)
				arg_255_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1060ui_story"].transform.localEulerAngles = arg_255_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["1060ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1060ui_story == nil then
				arg_255_1.var_.characterEffect1060ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect1060ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1060ui_story then
				arg_255_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			local var_258_4 = 0
			local var_258_5 = 0.45

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_6 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(910115063).content)

				arg_255_1.text_.text = var_258_6

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_8 = 18 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_6) / 18)

				if (18 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_6) / 18)) > 0 and var_258_5 < var_258_8 then
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
				actorName = "1060ui_story",
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
	Play910115064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 910115064
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play910115065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.85

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(910115064).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 34 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 34)

				if (34 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 34)) > 0 and var_262_0 < var_262_3 then
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
	Play910115065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 910115065
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play910115066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1060ui_story = arg_263_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1060ui_story"].transform.position).z)
				arg_263_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1060ui_story"].transform.localEulerAngles = arg_263_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_263_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1060ui_story"].transform.position).z)
				arg_263_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1060ui_story"].transform.localEulerAngles = arg_263_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1060ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1060ui_story == nil then
				arg_263_1.var_.characterEffect1060ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1060ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_263_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_2)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1060ui_story then
				arg_263_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_263_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_266_3 = arg_263_1.actors_["1070ui_story"].transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1070ui_story = var_266_3.localPosition
			end

			local var_266_4 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				var_266_3.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_263_1.time_ - 0) / var_266_4)
				var_266_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_3.position).x, (manager.ui.mainCamera.transform.position - var_266_3.position).y, (manager.ui.mainCamera.transform.position - var_266_3.position).z)
				var_266_3.localEulerAngles.z = 0
				var_266_3.localEulerAngles.x = 0
				var_266_3.localEulerAngles = var_266_3.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				var_266_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_266_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_266_3.position).x, (manager.ui.mainCamera.transform.position - var_266_3.position).y, (manager.ui.mainCamera.transform.position - var_266_3.position).z)
				var_266_3.localEulerAngles.z = 0
				var_266_3.localEulerAngles.x = 0
				var_266_3.localEulerAngles = var_266_3.localEulerAngles
			end

			local var_266_5 = arg_263_1.actors_["1070ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_5) and arg_263_1.var_.characterEffect1070ui_story == nil then
				arg_263_1.var_.characterEffect1070ui_story = var_266_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_6 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_6 and not isNil(var_266_5) then
				if arg_263_1.var_.characterEffect1070ui_story and not isNil(var_266_5) then
					arg_263_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_6 and arg_263_1.time_ < 0 + var_266_6 + arg_266_0 and not isNil(var_266_5) and arg_263_1.var_.characterEffect1070ui_story then
				arg_263_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_266_8 = 0
			local var_266_9 = 0.575

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_10 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(910115065).content)

				arg_263_1.text_.text = var_266_10

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_12 = 23 <= 0 and var_266_9 or var_266_9 * (utf8.len(var_266_10) / 23)

				if (23 <= 0 and var_266_9 or var_266_9 * (utf8.len(var_266_10) / 23)) > 0 and var_266_9 < var_266_12 then
					arg_263_1.talkMaxDuration = var_266_12

					if var_266_12 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_12 + var_266_8
					end
				end

				arg_263_1.text_.text = var_266_10
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_13 = math.max(var_266_9, arg_263_1.talkMaxDuration)

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_13 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_8) / var_266_13

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_8 + var_266_13 and arg_263_1.time_ < var_266_8 + var_266_13 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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

		arg_263_1:InitPlayNodeList()
	end,
	Play910115066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 910115066
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play910115067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1070ui_story"]) and arg_267_1.var_.characterEffect1070ui_story == nil then
				arg_267_1.var_.characterEffect1070ui_story = arg_267_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1070ui_story"]) then
				if arg_267_1.var_.characterEffect1070ui_story and not isNil(arg_267_1.actors_["1070ui_story"]) then
					arg_267_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1070ui_story"]) and arg_267_1.var_.characterEffect1070ui_story then
				arg_267_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0
			local var_270_2 = 0.3

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(910115066).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 12 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 12)

				if (12 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 12)) > 0 and var_270_2 < var_270_5 then
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
	Play910115067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 910115067
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play910115068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 1.125

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(910115067).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 45 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 45)

				if (45 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 45)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play910115068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 910115068
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play910115069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1060ui_story = arg_275_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1060ui_story"].transform.position).z)
				arg_275_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1060ui_story"].transform.localEulerAngles = arg_275_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_275_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1060ui_story"].transform.position).z)
				arg_275_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1060ui_story"].transform.localEulerAngles = arg_275_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1060ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1060ui_story == nil then
				arg_275_1.var_.characterEffect1060ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1060ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1060ui_story then
				arg_275_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_278_4 = arg_275_1.actors_["1070ui_story"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1070ui_story = var_278_4.localPosition
			end

			local var_278_5 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_5 then
				var_278_4.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_275_1.time_ - 0) / var_278_5)
				var_278_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_4.position).x, (manager.ui.mainCamera.transform.position - var_278_4.position).y, (manager.ui.mainCamera.transform.position - var_278_4.position).z)
				var_278_4.localEulerAngles.z = 0
				var_278_4.localEulerAngles.x = 0
				var_278_4.localEulerAngles = var_278_4.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_5 and arg_275_1.time_ < 0 + var_278_5 + arg_278_0 then
				var_278_4.localPosition = Vector3.New(0, 100, 0)
				var_278_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_278_4.position).x, (manager.ui.mainCamera.transform.position - var_278_4.position).y, (manager.ui.mainCamera.transform.position - var_278_4.position).z)
				var_278_4.localEulerAngles.z = 0
				var_278_4.localEulerAngles.x = 0
				var_278_4.localEulerAngles = var_278_4.localEulerAngles
			end

			local var_278_6 = arg_275_1.actors_["1070ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect1070ui_story == nil then
				arg_275_1.var_.characterEffect1070ui_story = var_278_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_7 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 and not isNil(var_278_6) then
				if arg_275_1.var_.characterEffect1070ui_story and not isNil(var_278_6) then
					arg_275_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_7)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 and not isNil(var_278_6) and arg_275_1.var_.characterEffect1070ui_story then
				arg_275_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_278_8 = 0
			local var_278_9 = 0.6

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_10 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(910115068).content)

				arg_275_1.text_.text = var_278_10

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_12 = 24 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_10) / 24)

				if (24 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_10) / 24)) > 0 and var_278_9 < var_278_12 then
					arg_275_1.talkMaxDuration = var_278_12

					if var_278_12 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_12 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_10
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_13 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_13 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_13

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_13 and arg_275_1.time_ < var_278_8 + var_278_13 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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

		arg_275_1:InitPlayNodeList()
	end,
	Play910115069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 910115069
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play910115070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["1060ui_story"]) and arg_279_1.var_.characterEffect1060ui_story == nil then
				arg_279_1.var_.characterEffect1060ui_story = arg_279_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["1060ui_story"]) then
				if arg_279_1.var_.characterEffect1060ui_story and not isNil(arg_279_1.actors_["1060ui_story"]) then
					arg_279_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["1060ui_story"]) and arg_279_1.var_.characterEffect1060ui_story then
				arg_279_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 0.55

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(910115069).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 22 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 22)

				if (22 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 22)) > 0 and var_282_2 < var_282_5 then
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
	Play910115070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 910115070
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play910115071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1074ui_story = arg_283_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1074ui_story"].transform.position).z)
				arg_283_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1074ui_story"].transform.localEulerAngles = arg_283_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.12)
				arg_283_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1074ui_story"].transform.position).z)
				arg_283_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1074ui_story"].transform.localEulerAngles = arg_283_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["1074ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1074ui_story == nil then
				arg_283_1.var_.characterEffect1074ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect1074ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect1074ui_story then
				arg_283_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_286_4 = arg_283_1.actors_["1060ui_story"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1060ui_story = var_286_4.localPosition
			end

			local var_286_5 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_5 then
				var_286_4.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_283_1.time_ - 0) / var_286_5)
				var_286_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_4.position).x, (manager.ui.mainCamera.transform.position - var_286_4.position).y, (manager.ui.mainCamera.transform.position - var_286_4.position).z)
				var_286_4.localEulerAngles.z = 0
				var_286_4.localEulerAngles.x = 0
				var_286_4.localEulerAngles = var_286_4.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_5 and arg_283_1.time_ < 0 + var_286_5 + arg_286_0 then
				var_286_4.localPosition = Vector3.New(0, 100, 0)
				var_286_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_4.position).x, (manager.ui.mainCamera.transform.position - var_286_4.position).y, (manager.ui.mainCamera.transform.position - var_286_4.position).z)
				var_286_4.localEulerAngles.z = 0
				var_286_4.localEulerAngles.x = 0
				var_286_4.localEulerAngles = var_286_4.localEulerAngles
			end

			local var_286_6 = arg_283_1.actors_["1060ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_6) and arg_283_1.var_.characterEffect1060ui_story == nil then
				arg_283_1.var_.characterEffect1060ui_story = var_286_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_7 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_7 and not isNil(var_286_6) then
				if arg_283_1.var_.characterEffect1060ui_story and not isNil(var_286_6) then
					arg_283_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_7)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_7 and arg_283_1.time_ < 0 + var_286_7 + arg_286_0 and not isNil(var_286_6) and arg_283_1.var_.characterEffect1060ui_story then
				arg_283_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_286_8 = 0
			local var_286_9 = 0.35

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_10 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(910115070).content)

				arg_283_1.text_.text = var_286_10

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_12 = 14 <= 0 and var_286_9 or var_286_9 * (utf8.len(var_286_10) / 14)

				if (14 <= 0 and var_286_9 or var_286_9 * (utf8.len(var_286_10) / 14)) > 0 and var_286_9 < var_286_12 then
					arg_283_1.talkMaxDuration = var_286_12

					if var_286_12 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_12 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_10
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_13 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_13 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_13

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_13 and arg_283_1.time_ < var_286_8 + var_286_13 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play910115071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 910115071
		arg_287_1.duration_ = 9

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play910115072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if arg_287_1.bgs_.ST37 == nil then
				local var_290_0 = Object.Instantiate(arg_287_1.paintGo_)

				var_290_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37")
				var_290_0.name = "ST37"
				var_290_0.transform.parent = arg_287_1.stage_.transform
				var_290_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_287_1.bgs_.ST37 = var_290_0
			end

			if 2 < arg_287_1.time_ and arg_287_1.time_ <= 2 + arg_290_0 then
				local var_290_1 = arg_287_1.bgs_.ST37

				arg_287_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_290_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_290_2 = var_290_1:GetComponent("SpriteRenderer")

				if var_290_2 and var_290_2.sprite then
					local var_290_3 = 2 * (var_290_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_290_1.transform.localScale = Vector3.New(var_290_3 / var_290_2.sprite.bounds.size.y < var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x and var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x or var_290_3 / var_290_2.sprite.bounds.size.y, var_290_3 / var_290_2.sprite.bounds.size.y < var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x and var_290_3 * manager.ui.mainCameraCom_.aspect / var_290_2.sprite.bounds.size.x or var_290_3 / var_290_2.sprite.bounds.size.y, 0)
				end

				for iter_290_0, iter_290_1 in pairs(arg_287_1.bgs_) do
					if iter_290_0 ~= "ST37" then
						iter_290_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_290_4 = 0

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_4 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_5 = 2

			if var_290_4 <= arg_287_1.time_ and arg_287_1.time_ < var_290_4 + var_290_5 then
				local var_290_6 = Color.New(0, 0, 0)

				var_290_6.a = Mathf.Lerp(0, 1, (arg_287_1.time_ - var_290_4) / var_290_5)
				arg_287_1.mask_.color = var_290_6
			end

			if arg_287_1.time_ >= var_290_4 + var_290_5 and arg_287_1.time_ < var_290_4 + var_290_5 + arg_290_0 then
				local var_290_7 = Color.New(0, 0, 0)

				var_290_7.a = 1
				arg_287_1.mask_.color = var_290_7
			end

			local var_290_8 = 2

			if 2 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_9 = 2

			if var_290_8 <= arg_287_1.time_ and arg_287_1.time_ < var_290_8 + var_290_9 then
				local var_290_10 = Color.New(0, 0, 0)

				var_290_10.a = Mathf.Lerp(1, 0, (arg_287_1.time_ - var_290_8) / var_290_9)
				arg_287_1.mask_.color = var_290_10
			end

			if arg_287_1.time_ >= var_290_8 + var_290_9 and arg_287_1.time_ < var_290_8 + var_290_9 + arg_290_0 then
				local var_290_11 = Color.New(0, 0, 0)

				arg_287_1.mask_.enabled = false
				var_290_11.a = 0
				arg_287_1.mask_.color = var_290_11
			end

			local var_290_12 = arg_287_1.actors_["1074ui_story"].transform

			if 2 < arg_287_1.time_ and arg_287_1.time_ <= 2 + arg_290_0 then
				arg_287_1.var_.moveOldPos1074ui_story = var_290_12.localPosition
			end

			local var_290_13 = 0.001

			if 2 <= arg_287_1.time_ and arg_287_1.time_ < 2 + var_290_13 then
				var_290_12.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_287_1.time_ - 2) / var_290_13)
				var_290_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_12.position).x, (manager.ui.mainCamera.transform.position - var_290_12.position).y, (manager.ui.mainCamera.transform.position - var_290_12.position).z)
				var_290_12.localEulerAngles.z = 0
				var_290_12.localEulerAngles.x = 0
				var_290_12.localEulerAngles = var_290_12.localEulerAngles
			end

			if arg_287_1.time_ >= 2 + var_290_13 and arg_287_1.time_ < 2 + var_290_13 + arg_290_0 then
				var_290_12.localPosition = Vector3.New(0, 100, 0)
				var_290_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_12.position).x, (manager.ui.mainCamera.transform.position - var_290_12.position).y, (manager.ui.mainCamera.transform.position - var_290_12.position).z)
				var_290_12.localEulerAngles.z = 0
				var_290_12.localEulerAngles.x = 0
				var_290_12.localEulerAngles = var_290_12.localEulerAngles
			end

			if arg_287_1.frameCnt_ <= 1 then
				arg_287_1.dialog_:SetActive(false)
			end

			local var_290_14 = 4
			local var_290_15 = 0.65

			if 4 < arg_287_1.time_ and arg_287_1.time_ <= var_290_14 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_16 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_16:setOnUpdate(LuaHelper.FloatAction(function(arg_291_0)
					arg_287_1.dialogCg_.alpha = arg_291_0
				end))
				var_290_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_17 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(910115071).content)

				arg_287_1.text_.text = var_290_17

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_19 = 26 <= 0 and var_290_15 or var_290_15 * (utf8.len(var_290_17) / 26)

				if (26 <= 0 and var_290_15 or var_290_15 * (utf8.len(var_290_17) / 26)) > 0 and var_290_15 < var_290_19 then
					arg_287_1.talkMaxDuration = var_290_19
					var_290_14 = var_290_14 + 0.3

					if var_290_19 + var_290_14 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_19 + var_290_14
					end
				end

				arg_287_1.text_.text = var_290_17
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_20 = var_290_14 + 0.3
			local var_290_21 = math.max(var_290_15, arg_287_1.talkMaxDuration)

			if var_290_14 + 0.3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_20 + var_290_21 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_20) / var_290_21

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_20 + var_290_21 and arg_287_1.time_ < var_290_20 + var_290_21 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play910115072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 910115072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play910115073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.6

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(910115072).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 24 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 24)

				if (24 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 24)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play910115073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 910115073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play910115074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.325

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(910115073).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 13 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 13)

				if (13 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 13)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play910115074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 910115074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play910115075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.9

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(910115074).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 36 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 36)

				if (36 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 36)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play910115075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 910115075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play910115076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.475

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[626].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_1 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(910115075).content)

				arg_305_1.text_.text = var_308_1

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_3 = 19 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 19)

				if (19 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_1) / 19)) > 0 and var_308_0 < var_308_3 then
					arg_305_1.talkMaxDuration = var_308_3

					if var_308_3 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_3 + 0
					end
				end

				arg_305_1.text_.text = var_308_1
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_4 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_4 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_4

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_4 and arg_305_1.time_ < 0 + var_308_4 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play910115076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 910115076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play910115077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos1060ui_story = arg_309_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos1060ui_story, Vector3.New(0, -1.14, -6.33), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1060ui_story"].transform.position).z)
				arg_309_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1060ui_story"].transform.localEulerAngles = arg_309_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, -1.14, -6.33)
				arg_309_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["1060ui_story"].transform.position).z)
				arg_309_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["1060ui_story"].transform.localEulerAngles = arg_309_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["1060ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1060ui_story == nil then
				arg_309_1.var_.characterEffect1060ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1060ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1060ui_story then
				arg_309_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_312_4 = 0
			local var_312_5 = 0.55

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(910115076).content)

				arg_309_1.text_.text = var_312_6

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_8 = 22 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_6) / 22)

				if (22 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_6) / 22)) > 0 and var_312_5 < var_312_8 then
					arg_309_1.talkMaxDuration = var_312_8

					if var_312_8 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_6
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_9 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_9 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_9

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_9 and arg_309_1.time_ < var_312_4 + var_312_9 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play910115077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 910115077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play910115078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1060ui_story"]) and arg_313_1.var_.characterEffect1060ui_story == nil then
				arg_313_1.var_.characterEffect1060ui_story = arg_313_1.actors_["1060ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1060ui_story"]) then
				if arg_313_1.var_.characterEffect1060ui_story and not isNil(arg_313_1.actors_["1060ui_story"]) then
					arg_313_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1060ui_story"]) and arg_313_1.var_.characterEffect1060ui_story then
				arg_313_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.625

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[626].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(910115077).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 25 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 25)

				if (25 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 25)) > 0 and var_316_2 < var_316_5 then
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
	Play910115078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 910115078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play910115079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos1060ui_story = arg_317_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1060ui_story"].transform.position).z)
				arg_317_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1060ui_story"].transform.localEulerAngles = arg_317_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_317_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["1060ui_story"].transform.position).z)
				arg_317_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["1060ui_story"].transform.localEulerAngles = arg_317_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["1060ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1060ui_story == nil then
				arg_317_1.var_.characterEffect1060ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1060ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_2)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1060ui_story then
				arg_317_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_320_3 = 0
			local var_320_4 = 0.45

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_3 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_5 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(910115078).content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 18 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 18)

				if (18 <= 0 and var_320_4 or var_320_4 * (utf8.len(var_320_5) / 18)) > 0 and var_320_4 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_3 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_3
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_8 = math.max(var_320_4, arg_317_1.talkMaxDuration)

			if var_320_3 <= arg_317_1.time_ and arg_317_1.time_ < var_320_3 + var_320_8 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_3) / var_320_8

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_3 + var_320_8 and arg_317_1.time_ < var_320_3 + var_320_8 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
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
	Play910115079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 910115079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play910115080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.925

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[625].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenwa")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_1 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(910115079).content)

				arg_321_1.text_.text = var_324_1

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_3 = 37 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 37)

				if (37 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_1) / 37)) > 0 and var_324_0 < var_324_3 then
					arg_321_1.talkMaxDuration = var_324_3

					if var_324_3 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_3 + 0
					end
				end

				arg_321_1.text_.text = var_324_1
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_4 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_4 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_4

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_4 and arg_321_1.time_ < 0 + var_324_4 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play910115080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 910115080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play910115081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.775

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[626].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_1 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(910115080).content)

				arg_325_1.text_.text = var_328_1

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_3 = 31 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 31)

				if (31 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_1) / 31)) > 0 and var_328_0 < var_328_3 then
					arg_325_1.talkMaxDuration = var_328_3

					if var_328_3 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_3 + 0
					end
				end

				arg_325_1.text_.text = var_328_1
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_4 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_4 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_4

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_4 and arg_325_1.time_ < 0 + var_328_4 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play910115081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 910115081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play910115082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.7

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[626].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_1 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(910115081).content)

				arg_329_1.text_.text = var_332_1

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_3 = 28 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 28)

				if (28 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 28)) > 0 and var_332_0 < var_332_3 then
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
	Play910115082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 910115082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play910115083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1074ui_story = arg_333_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1074ui_story"].transform.position).z)
				arg_333_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1074ui_story"].transform.localEulerAngles = arg_333_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.12)
				arg_333_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["1074ui_story"].transform.position).z)
				arg_333_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["1074ui_story"].transform.localEulerAngles = arg_333_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_336_1 = arg_333_1.actors_["1074ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1074ui_story == nil then
				arg_333_1.var_.characterEffect1074ui_story = var_336_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_2 and not isNil(var_336_1) then
				if arg_333_1.var_.characterEffect1074ui_story and not isNil(var_336_1) then
					arg_333_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_2 and arg_333_1.time_ < 0 + var_336_2 + arg_336_0 and not isNil(var_336_1) and arg_333_1.var_.characterEffect1074ui_story then
				arg_333_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_336_4 = 0
			local var_336_5 = 0.45

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(910115082).content)

				arg_333_1.text_.text = var_336_6

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_8 = 18 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_6) / 18)

				if (18 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_6) / 18)) > 0 and var_336_5 < var_336_8 then
					arg_333_1.talkMaxDuration = var_336_8

					if var_336_8 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_8 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_6
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_9 = math.max(var_336_5, arg_333_1.talkMaxDuration)

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_9 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_4) / var_336_9

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_4 + var_336_9 and arg_333_1.time_ < var_336_4 + var_336_9 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play910115083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 910115083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play910115084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1074ui_story"]) and arg_337_1.var_.characterEffect1074ui_story == nil then
				arg_337_1.var_.characterEffect1074ui_story = arg_337_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1074ui_story"]) then
				if arg_337_1.var_.characterEffect1074ui_story and not isNil(arg_337_1.actors_["1074ui_story"]) then
					arg_337_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_0)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1074ui_story"]) and arg_337_1.var_.characterEffect1074ui_story then
				arg_337_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_340_1 = 0
			local var_340_2 = 0.675

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[626].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(910115083).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 27 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 27)

				if (27 <= 0 and var_340_2 or var_340_2 * (utf8.len(var_340_3) / 27)) > 0 and var_340_2 < var_340_5 then
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

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play910115084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 910115084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play910115085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1074ui_story = arg_341_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1074ui_story"].transform.position).z)
				arg_341_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1074ui_story"].transform.localEulerAngles = arg_341_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_341_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1074ui_story"].transform.position).z)
				arg_341_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1074ui_story"].transform.localEulerAngles = arg_341_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1070ui_story"].transform

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1070ui_story = var_344_1.localPosition
			end

			local var_344_2 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 then
				var_344_1.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_341_1.time_ - 0) / var_344_2)
				var_344_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_1.position).x, (manager.ui.mainCamera.transform.position - var_344_1.position).y, (manager.ui.mainCamera.transform.position - var_344_1.position).z)
				var_344_1.localEulerAngles.z = 0
				var_344_1.localEulerAngles.x = 0
				var_344_1.localEulerAngles = var_344_1.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 then
				var_344_1.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_344_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_1.position).x, (manager.ui.mainCamera.transform.position - var_344_1.position).y, (manager.ui.mainCamera.transform.position - var_344_1.position).z)
				var_344_1.localEulerAngles.z = 0
				var_344_1.localEulerAngles.x = 0
				var_344_1.localEulerAngles = var_344_1.localEulerAngles
			end

			local var_344_3 = arg_341_1.actors_["1070ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_3) and arg_341_1.var_.characterEffect1070ui_story == nil then
				arg_341_1.var_.characterEffect1070ui_story = var_344_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_4 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 and not isNil(var_344_3) then
				if arg_341_1.var_.characterEffect1070ui_story and not isNil(var_344_3) then
					arg_341_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 and not isNil(var_344_3) and arg_341_1.var_.characterEffect1070ui_story then
				arg_341_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_344_6 = 0
			local var_344_7 = 0.575

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_6 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_8 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(910115084).content)

				arg_341_1.text_.text = var_344_8

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_10 = 23 <= 0 and var_344_7 or var_344_7 * (utf8.len(var_344_8) / 23)

				if (23 <= 0 and var_344_7 or var_344_7 * (utf8.len(var_344_8) / 23)) > 0 and var_344_7 < var_344_10 then
					arg_341_1.talkMaxDuration = var_344_10

					if var_344_10 + var_344_6 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_6
					end
				end

				arg_341_1.text_.text = var_344_8
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_11 = math.max(var_344_7, arg_341_1.talkMaxDuration)

			if var_344_6 <= arg_341_1.time_ and arg_341_1.time_ < var_344_6 + var_344_11 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_6) / var_344_11

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_6 + var_344_11 and arg_341_1.time_ < var_344_6 + var_344_11 + arg_344_0 then
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
	Play910115085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 910115085
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play910115086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1074ui_story = arg_345_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1074ui_story"].transform.position).z)
				arg_345_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1074ui_story"].transform.localEulerAngles = arg_345_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_345_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1074ui_story"].transform.position).z)
				arg_345_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1074ui_story"].transform.localEulerAngles = arg_345_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["1074ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1074ui_story == nil then
				arg_345_1.var_.characterEffect1074ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect1074ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect1074ui_story then
				arg_345_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_348_4 = arg_345_1.actors_["1070ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_4) and arg_345_1.var_.characterEffect1070ui_story == nil then
				arg_345_1.var_.characterEffect1070ui_story = var_348_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_5 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_5 and not isNil(var_348_4) then
				if arg_345_1.var_.characterEffect1070ui_story and not isNil(var_348_4) then
					arg_345_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_5)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_5 and arg_345_1.time_ < 0 + var_348_5 + arg_348_0 and not isNil(var_348_4) and arg_345_1.var_.characterEffect1070ui_story then
				arg_345_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_348_6 = 0
			local var_348_7 = 0.7

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_8 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(910115085).content)

				arg_345_1.text_.text = var_348_8

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_10 = 28 <= 0 and var_348_7 or var_348_7 * (utf8.len(var_348_8) / 28)

				if (28 <= 0 and var_348_7 or var_348_7 * (utf8.len(var_348_8) / 28)) > 0 and var_348_7 < var_348_10 then
					arg_345_1.talkMaxDuration = var_348_10

					if var_348_10 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_8
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_11 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_11 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_11

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_11 and arg_345_1.time_ < var_348_6 + var_348_11 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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
	Play910115086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 910115086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play910115087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1074ui_story = arg_349_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["1074ui_story"].transform.position).z)
				arg_349_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["1074ui_story"].transform.localEulerAngles = arg_349_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
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
					arg_349_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_2)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect1074ui_story then
				arg_349_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_352_3 = arg_349_1.actors_["1070ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_3) and arg_349_1.var_.characterEffect1070ui_story == nil then
				arg_349_1.var_.characterEffect1070ui_story = var_352_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_4 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_4 and not isNil(var_352_3) then
				if arg_349_1.var_.characterEffect1070ui_story and not isNil(var_352_3) then
					arg_349_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_4 and arg_349_1.time_ < 0 + var_352_4 + arg_352_0 and not isNil(var_352_3) and arg_349_1.var_.characterEffect1070ui_story then
				arg_349_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_352_6 = 0
			local var_352_7 = 0.325

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
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

				local var_352_8 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(910115086).content)

				arg_349_1.text_.text = var_352_8

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_10 = 13 <= 0 and var_352_7 or var_352_7 * (utf8.len(var_352_8) / 13)

				if (13 <= 0 and var_352_7 or var_352_7 * (utf8.len(var_352_8) / 13)) > 0 and var_352_7 < var_352_10 then
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
	Play910115087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 910115087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play910115088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1074ui_story = arg_353_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1074ui_story"].transform.position).z)
				arg_353_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1074ui_story"].transform.localEulerAngles = arg_353_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_353_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1074ui_story"].transform.position).z)
				arg_353_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1074ui_story"].transform.localEulerAngles = arg_353_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1074ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1074ui_story == nil then
				arg_353_1.var_.characterEffect1074ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1074ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1074ui_story then
				arg_353_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_356_4 = arg_353_1.actors_["1070ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_4) and arg_353_1.var_.characterEffect1070ui_story == nil then
				arg_353_1.var_.characterEffect1070ui_story = var_356_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_5 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_5 and not isNil(var_356_4) then
				if arg_353_1.var_.characterEffect1070ui_story and not isNil(var_356_4) then
					arg_353_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_5)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_5 and arg_353_1.time_ < 0 + var_356_5 + arg_356_0 and not isNil(var_356_4) and arg_353_1.var_.characterEffect1070ui_story then
				arg_353_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_356_6 = 0
			local var_356_7 = 0.15

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_6 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_8 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(910115087).content)

				arg_353_1.text_.text = var_356_8

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_10 = 6 <= 0 and var_356_7 or var_356_7 * (utf8.len(var_356_8) / 6)

				if (6 <= 0 and var_356_7 or var_356_7 * (utf8.len(var_356_8) / 6)) > 0 and var_356_7 < var_356_10 then
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
				actorName = "1074ui_story",
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
	Play910115088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 910115088
		arg_357_1.duration_ = 9

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play910115089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 2 < arg_357_1.time_ and arg_357_1.time_ <= 2 + arg_360_0 then
				local var_360_0 = arg_357_1.bgs_.ST31

				arg_357_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_360_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_360_1 = var_360_0:GetComponent("SpriteRenderer")

				if var_360_1 and var_360_1.sprite then
					local var_360_2 = 2 * (var_360_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_360_0.transform.localScale = Vector3.New(var_360_2 / var_360_1.sprite.bounds.size.y < var_360_2 * manager.ui.mainCameraCom_.aspect / var_360_1.sprite.bounds.size.x and var_360_2 * manager.ui.mainCameraCom_.aspect / var_360_1.sprite.bounds.size.x or var_360_2 / var_360_1.sprite.bounds.size.y, var_360_2 / var_360_1.sprite.bounds.size.y < var_360_2 * manager.ui.mainCameraCom_.aspect / var_360_1.sprite.bounds.size.x and var_360_2 * manager.ui.mainCameraCom_.aspect / var_360_1.sprite.bounds.size.x or var_360_2 / var_360_1.sprite.bounds.size.y, 0)
				end

				for iter_360_0, iter_360_1 in pairs(arg_357_1.bgs_) do
					if iter_360_0 ~= "ST31" then
						iter_360_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_360_3 = 0

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_3 + arg_360_0 then
				arg_357_1.mask_.enabled = true
				arg_357_1.mask_.raycastTarget = true

				arg_357_1:SetGaussion(false)
			end

			local var_360_4 = 2

			if var_360_3 <= arg_357_1.time_ and arg_357_1.time_ < var_360_3 + var_360_4 then
				local var_360_5 = Color.New(0, 0, 0)

				var_360_5.a = Mathf.Lerp(0, 1, (arg_357_1.time_ - var_360_3) / var_360_4)
				arg_357_1.mask_.color = var_360_5
			end

			if arg_357_1.time_ >= var_360_3 + var_360_4 and arg_357_1.time_ < var_360_3 + var_360_4 + arg_360_0 then
				local var_360_6 = Color.New(0, 0, 0)

				var_360_6.a = 1
				arg_357_1.mask_.color = var_360_6
			end

			local var_360_7 = 2

			if 2 < arg_357_1.time_ and arg_357_1.time_ <= var_360_7 + arg_360_0 then
				arg_357_1.mask_.enabled = true
				arg_357_1.mask_.raycastTarget = true

				arg_357_1:SetGaussion(false)
			end

			local var_360_8 = 2

			if var_360_7 <= arg_357_1.time_ and arg_357_1.time_ < var_360_7 + var_360_8 then
				local var_360_9 = Color.New(0, 0, 0)

				var_360_9.a = Mathf.Lerp(1, 0, (arg_357_1.time_ - var_360_7) / var_360_8)
				arg_357_1.mask_.color = var_360_9
			end

			if arg_357_1.time_ >= var_360_7 + var_360_8 and arg_357_1.time_ < var_360_7 + var_360_8 + arg_360_0 then
				local var_360_10 = Color.New(0, 0, 0)

				arg_357_1.mask_.enabled = false
				var_360_10.a = 0
				arg_357_1.mask_.color = var_360_10
			end

			local var_360_11 = arg_357_1.actors_["1074ui_story"].transform

			if 2 < arg_357_1.time_ and arg_357_1.time_ <= 2 + arg_360_0 then
				arg_357_1.var_.moveOldPos1074ui_story = var_360_11.localPosition
			end

			local var_360_12 = 0.001

			if 2 <= arg_357_1.time_ and arg_357_1.time_ < 2 + var_360_12 then
				var_360_11.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 2) / var_360_12)
				var_360_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_11.position).x, (manager.ui.mainCamera.transform.position - var_360_11.position).y, (manager.ui.mainCamera.transform.position - var_360_11.position).z)
				var_360_11.localEulerAngles.z = 0
				var_360_11.localEulerAngles.x = 0
				var_360_11.localEulerAngles = var_360_11.localEulerAngles
			end

			if arg_357_1.time_ >= 2 + var_360_12 and arg_357_1.time_ < 2 + var_360_12 + arg_360_0 then
				var_360_11.localPosition = Vector3.New(0, 100, 0)
				var_360_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_11.position).x, (manager.ui.mainCamera.transform.position - var_360_11.position).y, (manager.ui.mainCamera.transform.position - var_360_11.position).z)
				var_360_11.localEulerAngles.z = 0
				var_360_11.localEulerAngles.x = 0
				var_360_11.localEulerAngles = var_360_11.localEulerAngles
			end

			local var_360_13 = arg_357_1.actors_["1070ui_story"].transform

			if 2 < arg_357_1.time_ and arg_357_1.time_ <= 2 + arg_360_0 then
				arg_357_1.var_.moveOldPos1070ui_story = var_360_13.localPosition
			end

			local var_360_14 = 0.001

			if 2 <= arg_357_1.time_ and arg_357_1.time_ < 2 + var_360_14 then
				var_360_13.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 2) / var_360_14)
				var_360_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_13.position).x, (manager.ui.mainCamera.transform.position - var_360_13.position).y, (manager.ui.mainCamera.transform.position - var_360_13.position).z)
				var_360_13.localEulerAngles.z = 0
				var_360_13.localEulerAngles.x = 0
				var_360_13.localEulerAngles = var_360_13.localEulerAngles
			end

			if arg_357_1.time_ >= 2 + var_360_14 and arg_357_1.time_ < 2 + var_360_14 + arg_360_0 then
				var_360_13.localPosition = Vector3.New(0, 100, 0)
				var_360_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_13.position).x, (manager.ui.mainCamera.transform.position - var_360_13.position).y, (manager.ui.mainCamera.transform.position - var_360_13.position).z)
				var_360_13.localEulerAngles.z = 0
				var_360_13.localEulerAngles.x = 0
				var_360_13.localEulerAngles = var_360_13.localEulerAngles
			end

			if arg_357_1.frameCnt_ <= 1 then
				arg_357_1.dialog_:SetActive(false)
			end

			local var_360_15 = 4
			local var_360_16 = 0.225

			if 4 < arg_357_1.time_ and arg_357_1.time_ <= var_360_15 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0

				arg_357_1.dialog_:SetActive(true)

				arg_357_1.dialogCg_.alpha = 0

				local var_360_17 = LeanTween.value(arg_357_1.dialog_, 0, 1, 0.3)

				var_360_17:setOnUpdate(LuaHelper.FloatAction(function(arg_361_0)
					arg_357_1.dialogCg_.alpha = arg_361_0
				end))
				var_360_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_357_1.dialog_)
					var_360_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_357_1.duration_ = arg_357_1.duration_ + 0.3

				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[628].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_18 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(910115088).content)

				arg_357_1.text_.text = var_360_18

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_20 = 9 <= 0 and var_360_16 or var_360_16 * (utf8.len(var_360_18) / 9)

				if (9 <= 0 and var_360_16 or var_360_16 * (utf8.len(var_360_18) / 9)) > 0 and var_360_16 < var_360_20 then
					arg_357_1.talkMaxDuration = var_360_20
					var_360_15 = var_360_15 + 0.3

					if var_360_20 + var_360_15 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_20 + var_360_15
					end
				end

				arg_357_1.text_.text = var_360_18
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_21 = var_360_15 + 0.3
			local var_360_22 = math.max(var_360_16, arg_357_1.talkMaxDuration)

			if var_360_15 + 0.3 <= arg_357_1.time_ and arg_357_1.time_ < var_360_21 + var_360_22 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_21) / var_360_22

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_21 + var_360_22 and arg_357_1.time_ < var_360_21 + var_360_22 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play910115089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 910115089
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play910115090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.75

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_1 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(910115089).content)

				arg_363_1.text_.text = var_366_1

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_3 = 30 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 30)

				if (30 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_1) / 30)) > 0 and var_366_0 < var_366_3 then
					arg_363_1.talkMaxDuration = var_366_3

					if var_366_3 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_3 + 0
					end
				end

				arg_363_1.text_.text = var_366_1
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_4 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_4 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_4

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_4 and arg_363_1.time_ < 0 + var_366_4 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play910115090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 910115090
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play910115091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.825

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[629].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenmb")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(910115090).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 33 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 33)

				if (33 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 33)) > 0 and var_370_0 < var_370_3 then
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
	Play910115091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 910115091
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play910115092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.35

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[628].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(910115091).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 14 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 14)

				if (14 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 14)) > 0 and var_374_0 < var_374_3 then
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
	Play910115092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 910115092
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play910115093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1070ui_story = arg_375_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1070ui_story"].transform.position).z)
				arg_375_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1070ui_story"].transform.localEulerAngles = arg_375_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_375_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1070ui_story"].transform.position).z)
				arg_375_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1070ui_story"].transform.localEulerAngles = arg_375_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_378_1 = arg_375_1.actors_["1070ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1070ui_story == nil then
				arg_375_1.var_.characterEffect1070ui_story = var_378_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_2 and not isNil(var_378_1) then
				if arg_375_1.var_.characterEffect1070ui_story and not isNil(var_378_1) then
					arg_375_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_2 and arg_375_1.time_ < 0 + var_378_2 + arg_378_0 and not isNil(var_378_1) and arg_375_1.var_.characterEffect1070ui_story then
				arg_375_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_378_4 = arg_375_1.actors_["1060ui_story"].transform

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1060ui_story = var_378_4.localPosition
			end

			local var_378_5 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_5 then
				var_378_4.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1060ui_story, Vector3.New(0.7, -1.14, -6.33), (arg_375_1.time_ - 0) / var_378_5)
				var_378_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_4.position).x, (manager.ui.mainCamera.transform.position - var_378_4.position).y, (manager.ui.mainCamera.transform.position - var_378_4.position).z)
				var_378_4.localEulerAngles.z = 0
				var_378_4.localEulerAngles.x = 0
				var_378_4.localEulerAngles = var_378_4.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_5 and arg_375_1.time_ < 0 + var_378_5 + arg_378_0 then
				var_378_4.localPosition = Vector3.New(0.7, -1.14, -6.33)
				var_378_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_378_4.position).x, (manager.ui.mainCamera.transform.position - var_378_4.position).y, (manager.ui.mainCamera.transform.position - var_378_4.position).z)
				var_378_4.localEulerAngles.z = 0
				var_378_4.localEulerAngles.x = 0
				var_378_4.localEulerAngles = var_378_4.localEulerAngles
			end

			local var_378_6 = arg_375_1.actors_["1060ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_6) and arg_375_1.var_.characterEffect1060ui_story == nil then
				arg_375_1.var_.characterEffect1060ui_story = var_378_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_7 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_7 and not isNil(var_378_6) then
				if arg_375_1.var_.characterEffect1060ui_story and not isNil(var_378_6) then
					arg_375_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_375_1.time_ - 0) / var_378_7)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_7 and arg_375_1.time_ < 0 + var_378_7 + arg_378_0 and not isNil(var_378_6) and arg_375_1.var_.characterEffect1060ui_story then
				arg_375_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action1_1")
			end

			local var_378_8 = 0
			local var_378_9 = 0.4

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_8 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_10 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(910115092).content)

				arg_375_1.text_.text = var_378_10

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_12 = 16 <= 0 and var_378_9 or var_378_9 * (utf8.len(var_378_10) / 16)

				if (16 <= 0 and var_378_9 or var_378_9 * (utf8.len(var_378_10) / 16)) > 0 and var_378_9 < var_378_12 then
					arg_375_1.talkMaxDuration = var_378_12

					if var_378_12 + var_378_8 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_12 + var_378_8
					end
				end

				arg_375_1.text_.text = var_378_10
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_13 = math.max(var_378_9, arg_375_1.talkMaxDuration)

			if var_378_8 <= arg_375_1.time_ and arg_375_1.time_ < var_378_8 + var_378_13 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_8) / var_378_13

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_8 + var_378_13 and arg_375_1.time_ < var_378_8 + var_378_13 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
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
				actorName = "1060ui_story",
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
	Play910115093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 910115093
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play910115094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1060ui_story = arg_379_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_382_0 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 then
				arg_379_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1060ui_story, Vector3.New(0.7, -1.14, -6.33), (arg_379_1.time_ - 0) / var_382_0)
				arg_379_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1060ui_story"].transform.position).z)
				arg_379_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1060ui_story"].transform.localEulerAngles = arg_379_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 then
				arg_379_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0.7, -1.14, -6.33)
				arg_379_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_379_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_379_1.actors_["1060ui_story"].transform.position).z)
				arg_379_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_379_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_379_1.actors_["1060ui_story"].transform.localEulerAngles = arg_379_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_382_1 = arg_379_1.actors_["1060ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1060ui_story == nil then
				arg_379_1.var_.characterEffect1060ui_story = var_382_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 and not isNil(var_382_1) then
				if arg_379_1.var_.characterEffect1060ui_story and not isNil(var_382_1) then
					arg_379_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 and not isNil(var_382_1) and arg_379_1.var_.characterEffect1060ui_story then
				arg_379_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action3_1")
			end

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_382_4 = arg_379_1.actors_["1070ui_story"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_4) and arg_379_1.var_.characterEffect1070ui_story == nil then
				arg_379_1.var_.characterEffect1070ui_story = var_382_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_5 = 0.200000002980232

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_5 and not isNil(var_382_4) then
				if arg_379_1.var_.characterEffect1070ui_story and not isNil(var_382_4) then
					arg_379_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_379_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_379_1.time_ - 0) / var_382_5)
				end
			end

			if arg_379_1.time_ >= 0 + var_382_5 and arg_379_1.time_ < 0 + var_382_5 + arg_382_0 and not isNil(var_382_4) and arg_379_1.var_.characterEffect1070ui_story then
				arg_379_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_379_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_382_6 = 0
			local var_382_7 = 0.5

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_8 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(910115093).content)

				arg_379_1.text_.text = var_382_8

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_10 = 20 <= 0 and var_382_7 or var_382_7 * (utf8.len(var_382_8) / 20)

				if (20 <= 0 and var_382_7 or var_382_7 * (utf8.len(var_382_8) / 20)) > 0 and var_382_7 < var_382_10 then
					arg_379_1.talkMaxDuration = var_382_10

					if var_382_10 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_10 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_8
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_11 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_11 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_11

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_11 and arg_379_1.time_ < var_382_6 + var_382_11 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play910115094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 910115094
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play910115095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1074ui_story = arg_383_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_386_0 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 then
				arg_383_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_383_1.time_ - 0) / var_386_0)
				arg_383_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1074ui_story"].transform.position).z)
				arg_383_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1074ui_story"].transform.localEulerAngles = arg_383_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 then
				arg_383_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.12)
				arg_383_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_383_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_383_1.actors_["1074ui_story"].transform.position).z)
				arg_383_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_383_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_383_1.actors_["1074ui_story"].transform.localEulerAngles = arg_383_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_386_1 = arg_383_1.actors_["1074ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1074ui_story == nil then
				arg_383_1.var_.characterEffect1074ui_story = var_386_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_2 and not isNil(var_386_1) then
				if arg_383_1.var_.characterEffect1074ui_story and not isNil(var_386_1) then
					arg_383_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= 0 + var_386_2 and arg_383_1.time_ < 0 + var_386_2 + arg_386_0 and not isNil(var_386_1) and arg_383_1.var_.characterEffect1074ui_story then
				arg_383_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_386_4 = arg_383_1.actors_["1070ui_story"].transform

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1070ui_story = var_386_4.localPosition
			end

			local var_386_5 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_5 then
				var_386_4.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_383_1.time_ - 0) / var_386_5)
				var_386_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_386_4.position).x, (manager.ui.mainCamera.transform.position - var_386_4.position).y, (manager.ui.mainCamera.transform.position - var_386_4.position).z)
				var_386_4.localEulerAngles.z = 0
				var_386_4.localEulerAngles.x = 0
				var_386_4.localEulerAngles = var_386_4.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_5 and arg_383_1.time_ < 0 + var_386_5 + arg_386_0 then
				var_386_4.localPosition = Vector3.New(0, 100, 0)
				var_386_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_386_4.position).x, (manager.ui.mainCamera.transform.position - var_386_4.position).y, (manager.ui.mainCamera.transform.position - var_386_4.position).z)
				var_386_4.localEulerAngles.z = 0
				var_386_4.localEulerAngles.x = 0
				var_386_4.localEulerAngles = var_386_4.localEulerAngles
			end

			local var_386_6 = arg_383_1.actors_["1070ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_6) and arg_383_1.var_.characterEffect1070ui_story == nil then
				arg_383_1.var_.characterEffect1070ui_story = var_386_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_7 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 and not isNil(var_386_6) then
				if arg_383_1.var_.characterEffect1070ui_story and not isNil(var_386_6) then
					arg_383_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_7)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 and not isNil(var_386_6) and arg_383_1.var_.characterEffect1070ui_story then
				arg_383_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_386_8 = arg_383_1.actors_["1060ui_story"].transform

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1060ui_story = var_386_8.localPosition
			end

			local var_386_9 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_9 then
				var_386_8.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1060ui_story, Vector3.New(0, 100, 0), (arg_383_1.time_ - 0) / var_386_9)
				var_386_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_386_8.position).x, (manager.ui.mainCamera.transform.position - var_386_8.position).y, (manager.ui.mainCamera.transform.position - var_386_8.position).z)
				var_386_8.localEulerAngles.z = 0
				var_386_8.localEulerAngles.x = 0
				var_386_8.localEulerAngles = var_386_8.localEulerAngles
			end

			if arg_383_1.time_ >= 0 + var_386_9 and arg_383_1.time_ < 0 + var_386_9 + arg_386_0 then
				var_386_8.localPosition = Vector3.New(0, 100, 0)
				var_386_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_386_8.position).x, (manager.ui.mainCamera.transform.position - var_386_8.position).y, (manager.ui.mainCamera.transform.position - var_386_8.position).z)
				var_386_8.localEulerAngles.z = 0
				var_386_8.localEulerAngles.x = 0
				var_386_8.localEulerAngles = var_386_8.localEulerAngles
			end

			local var_386_10 = arg_383_1.actors_["1060ui_story"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_10) and arg_383_1.var_.characterEffect1060ui_story == nil then
				arg_383_1.var_.characterEffect1060ui_story = var_386_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_11 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_11 and not isNil(var_386_10) then
				if arg_383_1.var_.characterEffect1060ui_story and not isNil(var_386_10) then
					arg_383_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_11)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_11 and arg_383_1.time_ < 0 + var_386_11 + arg_386_0 and not isNil(var_386_10) and arg_383_1.var_.characterEffect1060ui_story then
				arg_383_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_386_12 = 0
			local var_386_13 = 0.55

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_12 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_14 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(910115094).content)

				arg_383_1.text_.text = var_386_14

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_16 = 22 <= 0 and var_386_13 or var_386_13 * (utf8.len(var_386_14) / 22)

				if (22 <= 0 and var_386_13 or var_386_13 * (utf8.len(var_386_14) / 22)) > 0 and var_386_13 < var_386_16 then
					arg_383_1.talkMaxDuration = var_386_16

					if var_386_16 + var_386_12 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_16 + var_386_12
					end
				end

				arg_383_1.text_.text = var_386_14
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_17 = math.max(var_386_13, arg_383_1.talkMaxDuration)

			if var_386_12 <= arg_383_1.time_ and arg_383_1.time_ < var_386_12 + var_386_17 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_12) / var_386_17

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_12 + var_386_17 and arg_383_1.time_ < var_386_12 + var_386_17 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play910115095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 910115095
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play910115096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.5

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(910115095).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 20 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 20)

				if (20 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 20)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play910115096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 910115096
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play910115097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1070ui_story = arg_391_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_394_0 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 then
				arg_391_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_391_1.time_ - 0) / var_394_0)
				arg_391_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1070ui_story"].transform.position).z)
				arg_391_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1070ui_story"].transform.localEulerAngles = arg_391_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 then
				arg_391_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_391_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_391_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_391_1.actors_["1070ui_story"].transform.position).z)
				arg_391_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_391_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_391_1.actors_["1070ui_story"].transform.localEulerAngles = arg_391_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_394_1 = arg_391_1.actors_["1070ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1070ui_story == nil then
				arg_391_1.var_.characterEffect1070ui_story = var_394_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_2 and not isNil(var_394_1) then
				if arg_391_1.var_.characterEffect1070ui_story and not isNil(var_394_1) then
					arg_391_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_391_1.time_ >= 0 + var_394_2 and arg_391_1.time_ < 0 + var_394_2 + arg_394_0 and not isNil(var_394_1) and arg_391_1.var_.characterEffect1070ui_story then
				arg_391_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_394_4 = arg_391_1.actors_["1060ui_story"].transform

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1060ui_story = var_394_4.localPosition
			end

			local var_394_5 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_5 then
				var_394_4.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1060ui_story, Vector3.New(0.7, -1.14, -6.33), (arg_391_1.time_ - 0) / var_394_5)
				var_394_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_4.position).x, (manager.ui.mainCamera.transform.position - var_394_4.position).y, (manager.ui.mainCamera.transform.position - var_394_4.position).z)
				var_394_4.localEulerAngles.z = 0
				var_394_4.localEulerAngles.x = 0
				var_394_4.localEulerAngles = var_394_4.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_5 and arg_391_1.time_ < 0 + var_394_5 + arg_394_0 then
				var_394_4.localPosition = Vector3.New(0.7, -1.14, -6.33)
				var_394_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_4.position).x, (manager.ui.mainCamera.transform.position - var_394_4.position).y, (manager.ui.mainCamera.transform.position - var_394_4.position).z)
				var_394_4.localEulerAngles.z = 0
				var_394_4.localEulerAngles.x = 0
				var_394_4.localEulerAngles = var_394_4.localEulerAngles
			end

			local var_394_6 = arg_391_1.actors_["1060ui_story"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_6) and arg_391_1.var_.characterEffect1060ui_story == nil then
				arg_391_1.var_.characterEffect1060ui_story = var_394_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_7 = 0.034000001847744

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 and not isNil(var_394_6) then
				if arg_391_1.var_.characterEffect1060ui_story and not isNil(var_394_6) then
					arg_391_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_7)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 and not isNil(var_394_6) and arg_391_1.var_.characterEffect1060ui_story then
				arg_391_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_394_8 = arg_391_1.actors_["1074ui_story"].transform

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1074ui_story = var_394_8.localPosition
			end

			local var_394_9 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_9 then
				var_394_8.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_391_1.time_ - 0) / var_394_9)
				var_394_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_8.position).x, (manager.ui.mainCamera.transform.position - var_394_8.position).y, (manager.ui.mainCamera.transform.position - var_394_8.position).z)
				var_394_8.localEulerAngles.z = 0
				var_394_8.localEulerAngles.x = 0
				var_394_8.localEulerAngles = var_394_8.localEulerAngles
			end

			if arg_391_1.time_ >= 0 + var_394_9 and arg_391_1.time_ < 0 + var_394_9 + arg_394_0 then
				var_394_8.localPosition = Vector3.New(0, 100, 0)
				var_394_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_394_8.position).x, (manager.ui.mainCamera.transform.position - var_394_8.position).y, (manager.ui.mainCamera.transform.position - var_394_8.position).z)
				var_394_8.localEulerAngles.z = 0
				var_394_8.localEulerAngles.x = 0
				var_394_8.localEulerAngles = var_394_8.localEulerAngles
			end

			local var_394_10 = 0
			local var_394_11 = 0.25

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_10 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_12 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(910115096).content)

				arg_391_1.text_.text = var_394_12

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_14 = 10 <= 0 and var_394_11 or var_394_11 * (utf8.len(var_394_12) / 10)

				if (10 <= 0 and var_394_11 or var_394_11 * (utf8.len(var_394_12) / 10)) > 0 and var_394_11 < var_394_14 then
					arg_391_1.talkMaxDuration = var_394_14

					if var_394_14 + var_394_10 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_14 + var_394_10
					end
				end

				arg_391_1.text_.text = var_394_12
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_15 = math.max(var_394_11, arg_391_1.talkMaxDuration)

			if var_394_10 <= arg_391_1.time_ and arg_391_1.time_ < var_394_10 + var_394_15 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_10) / var_394_15

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_10 + var_394_15 and arg_391_1.time_ < var_394_10 + var_394_15 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
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
				actorName = "1060ui_story",
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

		arg_391_1:InitPlayNodeList()
	end,
	Play910115097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 910115097
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play910115098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1060ui_story = arg_395_1.actors_["1060ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["1060ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1060ui_story, Vector3.New(0.7, -1.14, -6.33), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1060ui_story"].transform.position).z)
				arg_395_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1060ui_story"].transform.localEulerAngles = arg_395_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["1060ui_story"].transform.localPosition = Vector3.New(0.7, -1.14, -6.33)
				arg_395_1.actors_["1060ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1060ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1060ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1060ui_story"].transform.position).z)
				arg_395_1.actors_["1060ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1060ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1060ui_story"].transform.localEulerAngles = arg_395_1.actors_["1060ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["1060ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1060ui_story == nil then
				arg_395_1.var_.characterEffect1060ui_story = var_398_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 and not isNil(var_398_1) then
				if arg_395_1.var_.characterEffect1060ui_story and not isNil(var_398_1) then
					arg_395_1.var_.characterEffect1060ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1060ui_story then
				arg_395_1.var_.characterEffect1060ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/story1060/story1060action/1060action6_1")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1060ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_398_4 = arg_395_1.actors_["1070ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_4) and arg_395_1.var_.characterEffect1070ui_story == nil then
				arg_395_1.var_.characterEffect1070ui_story = var_398_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_5 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_5 and not isNil(var_398_4) then
				if arg_395_1.var_.characterEffect1070ui_story and not isNil(var_398_4) then
					arg_395_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_395_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_395_1.time_ - 0) / var_398_5)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_5 and arg_395_1.time_ < 0 + var_398_5 + arg_398_0 and not isNil(var_398_4) and arg_395_1.var_.characterEffect1070ui_story then
				arg_395_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_395_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_398_6 = 0
			local var_398_7 = 0.225

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_6 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_8 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(910115097).content)

				arg_395_1.text_.text = var_398_8

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_10 = 9 <= 0 and var_398_7 or var_398_7 * (utf8.len(var_398_8) / 9)

				if (9 <= 0 and var_398_7 or var_398_7 * (utf8.len(var_398_8) / 9)) > 0 and var_398_7 < var_398_10 then
					arg_395_1.talkMaxDuration = var_398_10

					if var_398_10 + var_398_6 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_6
					end
				end

				arg_395_1.text_.text = var_398_8
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_11 = math.max(var_398_7, arg_395_1.talkMaxDuration)

			if var_398_6 <= arg_395_1.time_ and arg_395_1.time_ < var_398_6 + var_398_11 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_6) / var_398_11

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_6 + var_398_11 and arg_395_1.time_ < var_398_6 + var_398_11 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play910115098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 910115098
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play910115099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos1070ui_story = arg_399_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_402_0 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 then
				arg_399_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_399_1.time_ - 0) / var_402_0)
				arg_399_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1070ui_story"].transform.position).z)
				arg_399_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1070ui_story"].transform.localEulerAngles = arg_399_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 then
				arg_399_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_399_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_399_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_399_1.actors_["1070ui_story"].transform.position).z)
				arg_399_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_399_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_399_1.actors_["1070ui_story"].transform.localEulerAngles = arg_399_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_402_1 = arg_399_1.actors_["1070ui_story"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_1) and arg_399_1.var_.characterEffect1070ui_story == nil then
				arg_399_1.var_.characterEffect1070ui_story = var_402_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_2 and not isNil(var_402_1) then
				if arg_399_1.var_.characterEffect1070ui_story and not isNil(var_402_1) then
					arg_399_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= 0 + var_402_2 and arg_399_1.time_ < 0 + var_402_2 + arg_402_0 and not isNil(var_402_1) and arg_399_1.var_.characterEffect1070ui_story then
				arg_399_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_402_4 = arg_399_1.actors_["1060ui_story"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_4) and arg_399_1.var_.characterEffect1060ui_story == nil then
				arg_399_1.var_.characterEffect1060ui_story = var_402_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_5 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_5 and not isNil(var_402_4) then
				if arg_399_1.var_.characterEffect1060ui_story and not isNil(var_402_4) then
					arg_399_1.var_.characterEffect1060ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1060ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_5)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_5 and arg_399_1.time_ < 0 + var_402_5 + arg_402_0 and not isNil(var_402_4) and arg_399_1.var_.characterEffect1060ui_story then
				arg_399_1.var_.characterEffect1060ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1060ui_story.fillRatio = 0.5
			end

			local var_402_6 = 0
			local var_402_7 = 0.55

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_6 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_8 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(910115098).content)

				arg_399_1.text_.text = var_402_8

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_10 = 22 <= 0 and var_402_7 or var_402_7 * (utf8.len(var_402_8) / 22)

				if (22 <= 0 and var_402_7 or var_402_7 * (utf8.len(var_402_8) / 22)) > 0 and var_402_7 < var_402_10 then
					arg_399_1.talkMaxDuration = var_402_10

					if var_402_10 + var_402_6 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_6
					end
				end

				arg_399_1.text_.text = var_402_8
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_11 = math.max(var_402_7, arg_399_1.talkMaxDuration)

			if var_402_6 <= arg_399_1.time_ and arg_399_1.time_ < var_402_6 + var_402_11 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_6) / var_402_11

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_6 + var_402_11 and arg_399_1.time_ < var_402_6 + var_402_11 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
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

		arg_399_1:InitPlayNodeList()
	end,
	Play910115099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 910115099
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
			local var_406_0 = 0.2

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
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

				local var_406_1 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(910115099).content)

				arg_403_1.text_.text = var_406_1

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_3 = 8 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 8)

				if (8 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 8)) > 0 and var_406_0 < var_406_3 then
					arg_403_1.talkMaxDuration = var_406_3

					if var_406_3 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_3 + 0
					end
				end

				arg_403_1.text_.text = var_406_1
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_4 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_4

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/ST37"
	},
	voices = {}
}
