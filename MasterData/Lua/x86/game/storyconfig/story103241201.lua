return {
	Play324121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324121001
		arg_1_1.duration_ = 6.5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I17l == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I17l")
				var_4_0.name = "I17l"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I17l = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I17l

				arg_1_1.bgs_.I17l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I17l" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind02", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_11 = 1.5
			local var_4_12 = 1.4

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(324121001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 56 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 56)

				if (56 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 56)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_11 = var_4_11 + 0.3

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_11 + 0.3
			local var_4_18 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324121002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 324121002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play324121003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 1.25

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

				local var_10_1 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(324121002).content)

				arg_7_1.text_.text = var_10_1

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_3 = 50 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 50)

				if (50 <= 0 and var_10_0 or var_10_0 * (utf8.len(var_10_1) / 50)) > 0 and var_10_0 < var_10_3 then
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
	Play324121003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 324121003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play324121004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0.75

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

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(324121003).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 30 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 30)

				if (30 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 30)) > 0 and var_14_0 < var_14_3 then
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
	Play324121004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 324121004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play324121005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0.175

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_1 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(324121004).content)

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
	Play324121005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 324121005
		arg_19_1.duration_ = 2.6

		local var_19_0 = {
			zh = 1.566,
			ja = 2.6
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play324121006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_22_0 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_19_1.stage_.transform)

				var_22_0.name = "1070ui_story"
				var_22_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1070ui_story"] = var_22_0

				local var_22_1 = var_22_0:GetComponentInChildren(typeof(CharacterEffect))

				var_22_1.enabled = true

				local var_22_2 = GameObjectTools.GetOrAddComponent(var_22_0, typeof(DynamicBoneHelper))

				if var_22_2 then
					var_22_2:EnableDynamicBone(false)
				end

				arg_19_1:ShowWeapon(var_22_1.transform, false)

				arg_19_1.var_["1070ui_story" .. "Animator"] = var_22_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_19_1.var_["1070ui_story" .. "Animator"].applyRootMotion = true
				arg_19_1.var_["1070ui_story" .. "LipSync"] = var_22_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_22_3 = arg_19_1.actors_["1070ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_3) and arg_19_1.var_.characterEffect1070ui_story == nil then
				arg_19_1.var_.characterEffect1070ui_story = var_22_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_4 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 and not isNil(var_22_3) then
				if arg_19_1.var_.characterEffect1070ui_story and not isNil(var_22_3) then
					arg_19_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 and not isNil(var_22_3) and arg_19_1.var_.characterEffect1070ui_story then
				arg_19_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_22_6 = 0
			local var_22_7 = 0.15

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_8 = arg_19_1:GetWordFromCfg(324121005)
				local var_22_9 = arg_19_1:FormatText(var_22_8.content)

				arg_19_1.text_.text = var_22_9

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_11 = 6 <= 0 and var_22_7 or var_22_7 * (utf8.len(var_22_9) / 6)

				if (6 <= 0 and var_22_7 or var_22_7 * (utf8.len(var_22_9) / 6)) > 0 and var_22_7 < var_22_11 then
					arg_19_1.talkMaxDuration = var_22_11

					if var_22_11 + var_22_6 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_11 + var_22_6
					end
				end

				arg_19_1.text_.text = var_22_9
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121005", "story_v_out_324121.awb") ~= 0 then
					local var_22_12 = manager.audio:GetVoiceLength("story_v_out_324121", "324121005", "story_v_out_324121.awb") / 1000

					if var_22_12 + var_22_6 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_12 + var_22_6
					end

					if var_22_8.prefab_name ~= "" and arg_19_1.actors_[var_22_8.prefab_name] ~= nil then
						local var_22_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_8.prefab_name].transform, "story_v_out_324121", "324121005", "story_v_out_324121.awb")

						arg_19_1:RecordAudio("324121005", var_22_13)
						arg_19_1:RecordAudio("324121005", var_22_13)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_324121", "324121005", "story_v_out_324121.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_324121", "324121005", "story_v_out_324121.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_14 = math.max(var_22_7, arg_19_1.talkMaxDuration)

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_14 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_6) / var_22_14

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_6 + var_22_14 and arg_19_1.time_ < var_22_6 + var_22_14 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play324121006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 324121006
		arg_23_1.duration_ = 8.03

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play324121007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.bgs_.J24g == nil then
				local var_26_0 = Object.Instantiate(arg_23_1.paintGo_)

				var_26_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J24g")
				var_26_0.name = "J24g"
				var_26_0.transform.parent = arg_23_1.stage_.transform
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.bgs_.J24g = var_26_0
			end

			if 1.6 < arg_23_1.time_ and arg_23_1.time_ <= 1.6 + arg_26_0 then
				local var_26_1 = arg_23_1.bgs_.J24g

				arg_23_1.bgs_.J24g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_26_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_26_2 = var_26_1:GetComponent("SpriteRenderer")

				if var_26_2 and var_26_2.sprite then
					local var_26_3 = 2 * (var_26_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_26_1.transform.localScale = Vector3.New(var_26_3 / var_26_2.sprite.bounds.size.y < var_26_3 * manager.ui.mainCameraCom_.aspect / var_26_2.sprite.bounds.size.x and var_26_3 * manager.ui.mainCameraCom_.aspect / var_26_2.sprite.bounds.size.x or var_26_3 / var_26_2.sprite.bounds.size.y, var_26_3 / var_26_2.sprite.bounds.size.y < var_26_3 * manager.ui.mainCameraCom_.aspect / var_26_2.sprite.bounds.size.x and var_26_3 * manager.ui.mainCameraCom_.aspect / var_26_2.sprite.bounds.size.x or var_26_3 / var_26_2.sprite.bounds.size.y, 0)
				end

				for iter_26_0, iter_26_1 in pairs(arg_23_1.bgs_) do
					if iter_26_0 ~= "J24g" then
						iter_26_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_26_4 = 0

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1.allBtn_.enabled = false
			end

			if arg_23_1.time_ >= var_26_4 + 0.3 and arg_23_1.time_ < var_26_4 + 0.3 + arg_26_0 then
				arg_23_1.allBtn_.enabled = true
			end

			local var_26_5 = 0

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_5 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = true

				arg_23_1:SetGaussion(false)
			end

			local var_26_6 = 1.6

			if var_26_5 <= arg_23_1.time_ and arg_23_1.time_ < var_26_5 + var_26_6 then
				local var_26_7 = Color.New(0, 0, 0)

				var_26_7.a = Mathf.Lerp(0, 1, (arg_23_1.time_ - var_26_5) / var_26_6)
				arg_23_1.mask_.color = var_26_7
			end

			if arg_23_1.time_ >= var_26_5 + var_26_6 and arg_23_1.time_ < var_26_5 + var_26_6 + arg_26_0 then
				local var_26_8 = Color.New(0, 0, 0)

				var_26_8.a = 1
				arg_23_1.mask_.color = var_26_8
			end

			local var_26_9 = 1.6

			if 1.6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_9 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = true

				arg_23_1:SetGaussion(false)
			end

			local var_26_10 = 2

			if var_26_9 <= arg_23_1.time_ and arg_23_1.time_ < var_26_9 + var_26_10 then
				local var_26_11 = Color.New(0, 0, 0)

				var_26_11.a = Mathf.Lerp(1, 0, (arg_23_1.time_ - var_26_9) / var_26_10)
				arg_23_1.mask_.color = var_26_11
			end

			if arg_23_1.time_ >= var_26_9 + var_26_10 and arg_23_1.time_ < var_26_9 + var_26_10 + arg_26_0 then
				local var_26_12 = Color.New(0, 0, 0)

				arg_23_1.mask_.enabled = false
				var_26_12.a = 0
				arg_23_1.mask_.color = var_26_12
			end

			local var_26_13 = arg_23_1.actors_["1070ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_13) and arg_23_1.var_.characterEffect1070ui_story == nil then
				arg_23_1.var_.characterEffect1070ui_story = var_26_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_14 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_14 and not isNil(var_26_13) then
				if arg_23_1.var_.characterEffect1070ui_story and not isNil(var_26_13) then
					arg_23_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_14)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_14 and arg_23_1.time_ < 0 + var_26_14 + arg_26_0 and not isNil(var_26_13) and arg_23_1.var_.characterEffect1070ui_story then
				arg_23_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_23_1.time_ and arg_23_1.time_ <= 1.2 + arg_26_0 then
				arg_23_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0.1 < arg_23_1.time_ and arg_23_1.time_ <= 0.1 + arg_26_0 then
				arg_23_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_wind02", "")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:AudioAction("play", "music", "bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun.awb")

				local var_26_19 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun")

				if "" ~= "" then
					if arg_23_1.bgmTxt_.text ~= var_26_19 and arg_23_1.bgmTxt_.text ~= "" then
						if arg_23_1.bgmTxt2_.text ~= "" then
							arg_23_1.bgmTxt_.text = arg_23_1.bgmTxt2_.text
						end

						arg_23_1.bgmTxt2_.text = var_26_19

						arg_23_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_23_1.bgmTxt_.text = var_26_19
						arg_23_1.bgmTxt2_.text = var_26_19
					end

					if arg_23_1.bgmTimer then
						arg_23_1.bgmTimer:Stop()

						arg_23_1.bgmTimer = nil
					end

					if arg_23_1.settingData.show_music_name == 1 then
						arg_23_1.musicController:SetSelectedState("show")
						arg_23_1.musicAnimator_:Play("open", 0, 0)

						if arg_23_1.settingData.music_time ~= 0 then
							arg_23_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_23_1.settingData.music_time), function()
								if arg_23_1 == nil or isNil(arg_23_1.bgmTxt_) then
									return
								end

								arg_23_1.musicController:SetSelectedState("hide")
								arg_23_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_23_1.frameCnt_ <= 1 then
				arg_23_1.dialog_:SetActive(false)
			end

			local var_26_20 = 3.03333333333333
			local var_26_21 = 0.925

			if 3.03333333333333 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				arg_23_1.dialog_:SetActive(true)

				arg_23_1.dialogCg_.alpha = 0

				local var_26_22 = LeanTween.value(arg_23_1.dialog_, 0, 1, 0.3)

				var_26_22:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_23_1.dialogCg_.alpha = arg_28_0
				end))
				var_26_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_23_1.dialog_)
					var_26_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_23_1.duration_ = arg_23_1.duration_ + 0.3

				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_23 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(324121006).content)

				arg_23_1.text_.text = var_26_23

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_25 = 37 <= 0 and var_26_21 or var_26_21 * (utf8.len(var_26_23) / 37)

				if (37 <= 0 and var_26_21 or var_26_21 * (utf8.len(var_26_23) / 37)) > 0 and var_26_21 < var_26_25 then
					arg_23_1.talkMaxDuration = var_26_25
					var_26_20 = var_26_20 + 0.3

					if var_26_25 + var_26_20 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_25 + var_26_20
					end
				end

				arg_23_1.text_.text = var_26_23
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_26 = var_26_20 + 0.3
			local var_26_27 = math.max(var_26_21, arg_23_1.talkMaxDuration)

			if var_26_20 + 0.3 <= arg_23_1.time_ and arg_23_1.time_ < var_26_26 + var_26_27 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_26) / var_26_27

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_26 + var_26_27 and arg_23_1.time_ < var_26_26 + var_26_27 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play324121007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 324121007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play324121008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.1

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_1 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(324121007).content)

				arg_30_1.text_.text = var_33_1

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_3 = 4 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 4)

				if (4 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_1) / 4)) > 0 and var_33_0 < var_33_3 then
					arg_30_1.talkMaxDuration = var_33_3

					if var_33_3 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_3 + 0
					end
				end

				arg_30_1.text_.text = var_33_1
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_4 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_4

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play324121008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 324121008
		arg_34_1.duration_ = 3.33

		local var_34_0 = {
			zh = 2.233,
			ja = 3.333
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play324121009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1070ui_story = arg_34_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_37_0 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 then
				arg_34_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_34_1.time_ - 0) / var_37_0)
				arg_34_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["1070ui_story"].transform.position).z)
				arg_34_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["1070ui_story"].transform.localEulerAngles = arg_34_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 then
				arg_34_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_34_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_34_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_34_1.actors_["1070ui_story"].transform.position).z)
				arg_34_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_34_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_34_1.actors_["1070ui_story"].transform.localEulerAngles = arg_34_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_37_1 = arg_34_1.actors_["1070ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_1) and arg_34_1.var_.characterEffect1070ui_story == nil then
				arg_34_1.var_.characterEffect1070ui_story = var_37_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_2 and not isNil(var_37_1) then
				if arg_34_1.var_.characterEffect1070ui_story and not isNil(var_37_1) then
					arg_34_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_2 and arg_34_1.time_ < 0 + var_37_2 + arg_37_0 and not isNil(var_37_1) and arg_34_1.var_.characterEffect1070ui_story then
				arg_34_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_37_4 = 0
			local var_37_5 = 0.3

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_6 = arg_34_1:GetWordFromCfg(324121008)
				local var_37_7 = arg_34_1:FormatText(var_37_6.content)

				arg_34_1.text_.text = var_37_7

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_9 = 12 <= 0 and var_37_5 or var_37_5 * (utf8.len(var_37_7) / 12)

				if (12 <= 0 and var_37_5 or var_37_5 * (utf8.len(var_37_7) / 12)) > 0 and var_37_5 < var_37_9 then
					arg_34_1.talkMaxDuration = var_37_9

					if var_37_9 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_9 + var_37_4
					end
				end

				arg_34_1.text_.text = var_37_7
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121008", "story_v_out_324121.awb") ~= 0 then
					local var_37_10 = manager.audio:GetVoiceLength("story_v_out_324121", "324121008", "story_v_out_324121.awb") / 1000

					if var_37_10 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_10 + var_37_4
					end

					if var_37_6.prefab_name ~= "" and arg_34_1.actors_[var_37_6.prefab_name] ~= nil then
						local var_37_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_6.prefab_name].transform, "story_v_out_324121", "324121008", "story_v_out_324121.awb")

						arg_34_1:RecordAudio("324121008", var_37_11)
						arg_34_1:RecordAudio("324121008", var_37_11)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_324121", "324121008", "story_v_out_324121.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_324121", "324121008", "story_v_out_324121.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_12 = math.max(var_37_5, arg_34_1.talkMaxDuration)

			if var_37_4 <= arg_34_1.time_ and arg_34_1.time_ < var_37_4 + var_37_12 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_4) / var_37_12

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_4 + var_37_12 and arg_34_1.time_ < var_37_4 + var_37_12 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
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

		arg_34_1:InitPlayNodeList()
	end,
	Play324121009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 324121009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play324121010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1070ui_story"]) and arg_38_1.var_.characterEffect1070ui_story == nil then
				arg_38_1.var_.characterEffect1070ui_story = arg_38_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1070ui_story"]) then
				if arg_38_1.var_.characterEffect1070ui_story and not isNil(arg_38_1.actors_["1070ui_story"]) then
					arg_38_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_0)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1070ui_story"]) and arg_38_1.var_.characterEffect1070ui_story then
				arg_38_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_41_1 = 0
			local var_41_2 = 0.625

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_3 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(324121009).content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 25 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 25)

				if (25 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 25)) > 0 and var_41_2 < var_41_5 then
					arg_38_1.talkMaxDuration = var_41_5

					if var_41_5 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + var_41_1
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_6 = math.max(var_41_2, arg_38_1.talkMaxDuration)

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_6 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_1) / var_41_6

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_1 + var_41_6 and arg_38_1.time_ < var_41_1 + var_41_6 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play324121010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 324121010
		arg_42_1.duration_ = 6.33

		local var_42_0 = {
			zh = 4.266,
			ja = 6.333
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play324121011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1070ui_story"]) and arg_42_1.var_.characterEffect1070ui_story == nil then
				arg_42_1.var_.characterEffect1070ui_story = arg_42_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1070ui_story"]) then
				if arg_42_1.var_.characterEffect1070ui_story and not isNil(arg_42_1.actors_["1070ui_story"]) then
					arg_42_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1070ui_story"]) and arg_42_1.var_.characterEffect1070ui_story then
				arg_42_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_45_2 = 0
			local var_45_3 = 0.5

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_4 = arg_42_1:GetWordFromCfg(324121010)
				local var_45_5 = arg_42_1:FormatText(var_45_4.content)

				arg_42_1.text_.text = var_45_5

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_7 = 20 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 20)

				if (20 <= 0 and var_45_3 or var_45_3 * (utf8.len(var_45_5) / 20)) > 0 and var_45_3 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_5
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121010", "story_v_out_324121.awb") ~= 0 then
					local var_45_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121010", "story_v_out_324121.awb") / 1000

					if var_45_8 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_2
					end

					if var_45_4.prefab_name ~= "" and arg_42_1.actors_[var_45_4.prefab_name] ~= nil then
						local var_45_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_4.prefab_name].transform, "story_v_out_324121", "324121010", "story_v_out_324121.awb")

						arg_42_1:RecordAudio("324121010", var_45_9)
						arg_42_1:RecordAudio("324121010", var_45_9)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_324121", "324121010", "story_v_out_324121.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_324121", "324121010", "story_v_out_324121.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_10 = math.max(var_45_3, arg_42_1.talkMaxDuration)

			if var_45_2 <= arg_42_1.time_ and arg_42_1.time_ < var_45_2 + var_45_10 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_2) / var_45_10

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_2 + var_45_10 and arg_42_1.time_ < var_45_2 + var_45_10 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play324121011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 324121011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play324121012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1070ui_story"]) and arg_46_1.var_.characterEffect1070ui_story == nil then
				arg_46_1.var_.characterEffect1070ui_story = arg_46_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1070ui_story"]) then
				if arg_46_1.var_.characterEffect1070ui_story and not isNil(arg_46_1.actors_["1070ui_story"]) then
					arg_46_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_0)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1070ui_story"]) and arg_46_1.var_.characterEffect1070ui_story then
				arg_46_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_49_1 = 0
			local var_49_2 = 0.55

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_3 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(324121011).content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 22 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 22)

				if (22 <= 0 and var_49_2 or var_49_2 * (utf8.len(var_49_3) / 22)) > 0 and var_49_2 < var_49_5 then
					arg_46_1.talkMaxDuration = var_49_5

					if var_49_5 + var_49_1 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + var_49_1
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_6 = math.max(var_49_2, arg_46_1.talkMaxDuration)

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_6 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_1) / var_49_6

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_1 + var_49_6 and arg_46_1.time_ < var_49_1 + var_49_6 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play324121012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 324121012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play324121013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 1.15

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
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

				local var_53_1 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(324121012).content)

				arg_50_1.text_.text = var_53_1

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_3 = 46 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 46)

				if (46 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 46)) > 0 and var_53_0 < var_53_3 then
					arg_50_1.talkMaxDuration = var_53_3

					if var_53_3 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_3 + 0
					end
				end

				arg_50_1.text_.text = var_53_1
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_4 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_4

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play324121013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 324121013
		arg_54_1.duration_ = 3.27

		local var_54_0 = {
			zh = 1.999999999999,
			ja = 3.266
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play324121014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1070ui_story"]) and arg_54_1.var_.characterEffect1070ui_story == nil then
				arg_54_1.var_.characterEffect1070ui_story = arg_54_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1070ui_story"]) then
				if arg_54_1.var_.characterEffect1070ui_story and not isNil(arg_54_1.actors_["1070ui_story"]) then
					arg_54_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1070ui_story"]) and arg_54_1.var_.characterEffect1070ui_story then
				arg_54_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_57_2 = 0
			local var_57_3 = 0.1

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_4 = arg_54_1:GetWordFromCfg(324121013)
				local var_57_5 = arg_54_1:FormatText(var_57_4.content)

				arg_54_1.text_.text = var_57_5

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_7 = 4 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 4)

				if (4 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_5) / 4)) > 0 and var_57_3 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_2
					end
				end

				arg_54_1.text_.text = var_57_5
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121013", "story_v_out_324121.awb") ~= 0 then
					local var_57_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121013", "story_v_out_324121.awb") / 1000

					if var_57_8 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_8 + var_57_2
					end

					if var_57_4.prefab_name ~= "" and arg_54_1.actors_[var_57_4.prefab_name] ~= nil then
						local var_57_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_4.prefab_name].transform, "story_v_out_324121", "324121013", "story_v_out_324121.awb")

						arg_54_1:RecordAudio("324121013", var_57_9)
						arg_54_1:RecordAudio("324121013", var_57_9)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_324121", "324121013", "story_v_out_324121.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_324121", "324121013", "story_v_out_324121.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_10 = math.max(var_57_3, arg_54_1.talkMaxDuration)

			if var_57_2 <= arg_54_1.time_ and arg_54_1.time_ < var_57_2 + var_57_10 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_2) / var_57_10

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_2 + var_57_10 and arg_54_1.time_ < var_57_2 + var_57_10 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play324121014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324121014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play324121015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1070ui_story = arg_58_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_61_0 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				arg_58_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_58_1.time_ - 0) / var_61_0)
				arg_58_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1070ui_story"].transform.position).z)
				arg_58_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["1070ui_story"].transform.localEulerAngles = arg_58_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				arg_58_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1070ui_story"].transform.position).z)
				arg_58_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["1070ui_story"].transform.localEulerAngles = arg_58_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_61_1 = arg_58_1.actors_["1070ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1070ui_story == nil then
				arg_58_1.var_.characterEffect1070ui_story = var_61_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_2 and not isNil(var_61_1) then
				if arg_58_1.var_.characterEffect1070ui_story and not isNil(var_61_1) then
					arg_58_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_2)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_2 and arg_58_1.time_ < 0 + var_61_2 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1070ui_story then
				arg_58_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_61_3 = 0
			local var_61_4 = 0.9

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_3 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_5 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(324121014).content)

				arg_58_1.text_.text = var_61_5

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 36 <= 0 and var_61_4 or var_61_4 * (utf8.len(var_61_5) / 36)

				if (36 <= 0 and var_61_4 or var_61_4 * (utf8.len(var_61_5) / 36)) > 0 and var_61_4 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_3 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_3
					end
				end

				arg_58_1.text_.text = var_61_5
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_8 = math.max(var_61_4, arg_58_1.talkMaxDuration)

			if var_61_3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_3 + var_61_8 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_3) / var_61_8

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_3 + var_61_8 and arg_58_1.time_ < var_61_3 + var_61_8 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play324121015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324121015
		arg_62_1.duration_ = 9.6

		local var_62_0 = {
			zh = 7.6,
			ja = 9.6
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play324121016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if arg_62_1.bgs_.ST2005 == nil then
				local var_65_0 = Object.Instantiate(arg_62_1.paintGo_)

				var_65_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2005")
				var_65_0.name = "ST2005"
				var_65_0.transform.parent = arg_62_1.stage_.transform
				var_65_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.bgs_.ST2005 = var_65_0
			end

			if 1.6 < arg_62_1.time_ and arg_62_1.time_ <= 1.6 + arg_65_0 then
				local var_65_1 = arg_62_1.bgs_.ST2005

				arg_62_1.bgs_.ST2005.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_65_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_65_2 = var_65_1:GetComponent("SpriteRenderer")

				if var_65_2 and var_65_2.sprite then
					local var_65_3 = 2 * (var_65_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_65_1.transform.localScale = Vector3.New(var_65_3 / var_65_2.sprite.bounds.size.y < var_65_3 * manager.ui.mainCameraCom_.aspect / var_65_2.sprite.bounds.size.x and var_65_3 * manager.ui.mainCameraCom_.aspect / var_65_2.sprite.bounds.size.x or var_65_3 / var_65_2.sprite.bounds.size.y, var_65_3 / var_65_2.sprite.bounds.size.y < var_65_3 * manager.ui.mainCameraCom_.aspect / var_65_2.sprite.bounds.size.x and var_65_3 * manager.ui.mainCameraCom_.aspect / var_65_2.sprite.bounds.size.x or var_65_3 / var_65_2.sprite.bounds.size.y, 0)
				end

				for iter_65_0, iter_65_1 in pairs(arg_62_1.bgs_) do
					if iter_65_0 ~= "ST2005" then
						iter_65_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_65_4 = 1.6

			if 1.6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1.allBtn_.enabled = false
			end

			if arg_62_1.time_ >= var_65_4 + 0.3 and arg_62_1.time_ < var_65_4 + 0.3 + arg_65_0 then
				arg_62_1.allBtn_.enabled = true
			end

			local var_65_5 = 0

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1.mask_.enabled = true
				arg_62_1.mask_.raycastTarget = true

				arg_62_1:SetGaussion(false)
			end

			local var_65_6 = 1.6

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_6 then
				local var_65_7 = Color.New(0, 0, 0)

				var_65_7.a = Mathf.Lerp(0, 1, (arg_62_1.time_ - var_65_5) / var_65_6)
				arg_62_1.mask_.color = var_65_7
			end

			if arg_62_1.time_ >= var_65_5 + var_65_6 and arg_62_1.time_ < var_65_5 + var_65_6 + arg_65_0 then
				local var_65_8 = Color.New(0, 0, 0)

				var_65_8.a = 1
				arg_62_1.mask_.color = var_65_8
			end

			local var_65_9 = 1.6

			if 1.6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_9 + arg_65_0 then
				arg_62_1.mask_.enabled = true
				arg_62_1.mask_.raycastTarget = true

				arg_62_1:SetGaussion(false)
			end

			local var_65_10 = 2

			if var_65_9 <= arg_62_1.time_ and arg_62_1.time_ < var_65_9 + var_65_10 then
				local var_65_11 = Color.New(0, 0, 0)

				var_65_11.a = Mathf.Lerp(1, 0, (arg_62_1.time_ - var_65_9) / var_65_10)
				arg_62_1.mask_.color = var_65_11
			end

			if arg_62_1.time_ >= var_65_9 + var_65_10 and arg_62_1.time_ < var_65_9 + var_65_10 + arg_65_0 then
				local var_65_12 = Color.New(0, 0, 0)

				arg_62_1.mask_.enabled = false
				var_65_12.a = 0
				arg_62_1.mask_.color = var_65_12
			end

			local var_65_13 = arg_62_1.actors_["1070ui_story"]

			if 1.6 < arg_62_1.time_ and arg_62_1.time_ <= 1.6 + arg_65_0 and not isNil(var_65_13) and arg_62_1.var_.characterEffect1070ui_story == nil then
				arg_62_1.var_.characterEffect1070ui_story = var_65_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_14 = 0.200000002980232

			if 1.6 <= arg_62_1.time_ and arg_62_1.time_ < 1.6 + var_65_14 and not isNil(var_65_13) then
				if arg_62_1.var_.characterEffect1070ui_story and not isNil(var_65_13) then
					arg_62_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 1.6 + var_65_14 and arg_62_1.time_ < 1.6 + var_65_14 + arg_65_0 and not isNil(var_65_13) and arg_62_1.var_.characterEffect1070ui_story then
				arg_62_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 1.2 < arg_62_1.time_ and arg_62_1.time_ <= 1.2 + arg_65_0 then
				arg_62_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_ice_cave", "")
			end

			if 0.1 < arg_62_1.time_ and arg_62_1.time_ <= 0.1 + arg_65_0 then
				arg_62_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if arg_62_1.frameCnt_ <= 1 then
				arg_62_1.dialog_:SetActive(false)
			end

			local var_65_18 = 2.9
			local var_65_19 = 0.475

			if 2.9 < arg_62_1.time_ and arg_62_1.time_ <= var_65_18 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0

				arg_62_1.dialog_:SetActive(true)

				arg_62_1.dialogCg_.alpha = 0

				local var_65_20 = LeanTween.value(arg_62_1.dialog_, 0, 1, 0.3)

				var_65_20:setOnUpdate(LuaHelper.FloatAction(function(arg_66_0)
					arg_62_1.dialogCg_.alpha = arg_66_0
				end))
				var_65_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_62_1.dialog_)
					var_65_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_62_1.duration_ = arg_62_1.duration_ + 0.3

				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_21 = arg_62_1:GetWordFromCfg(324121015)
				local var_65_22 = arg_62_1:FormatText(var_65_21.content)

				arg_62_1.text_.text = var_65_22

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_24 = 19 <= 0 and var_65_19 or var_65_19 * (utf8.len(var_65_22) / 19)

				if (19 <= 0 and var_65_19 or var_65_19 * (utf8.len(var_65_22) / 19)) > 0 and var_65_19 < var_65_24 then
					arg_62_1.talkMaxDuration = var_65_24
					var_65_18 = var_65_18 + 0.3

					if var_65_24 + var_65_18 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_24 + var_65_18
					end
				end

				arg_62_1.text_.text = var_65_22
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121015", "story_v_out_324121.awb") ~= 0 then
					local var_65_25 = manager.audio:GetVoiceLength("story_v_out_324121", "324121015", "story_v_out_324121.awb") / 1000

					if var_65_25 + var_65_18 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_25 + var_65_18
					end

					if var_65_21.prefab_name ~= "" and arg_62_1.actors_[var_65_21.prefab_name] ~= nil then
						local var_65_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_21.prefab_name].transform, "story_v_out_324121", "324121015", "story_v_out_324121.awb")

						arg_62_1:RecordAudio("324121015", var_65_26)
						arg_62_1:RecordAudio("324121015", var_65_26)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_324121", "324121015", "story_v_out_324121.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_324121", "324121015", "story_v_out_324121.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_27 = var_65_18 + 0.3
			local var_65_28 = math.max(var_65_19, arg_62_1.talkMaxDuration)

			if var_65_18 + 0.3 <= arg_62_1.time_ and arg_62_1.time_ < var_65_27 + var_65_28 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_27) / var_65_28

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_27 + var_65_28 and arg_62_1.time_ < var_65_27 + var_65_28 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play324121016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 324121016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play324121017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1070ui_story"]) and arg_68_1.var_.characterEffect1070ui_story == nil then
				arg_68_1.var_.characterEffect1070ui_story = arg_68_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1070ui_story"]) then
				if arg_68_1.var_.characterEffect1070ui_story and not isNil(arg_68_1.actors_["1070ui_story"]) then
					arg_68_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1070ui_story"]) and arg_68_1.var_.characterEffect1070ui_story then
				arg_68_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_71_1 = 0
			local var_71_2 = 1.65

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(324121016).content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 66 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 66)

				if (66 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 66)) > 0 and var_71_2 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_6 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_6 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_6

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_6 and arg_68_1.time_ < var_71_1 + var_71_6 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play324121017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 324121017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play324121018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.15

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(324121017).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 6 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 6)

				if (6 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 6)) > 0 and var_75_0 < var_75_3 then
					arg_72_1.talkMaxDuration = var_75_3

					if var_75_3 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_3 + 0
					end
				end

				arg_72_1.text_.text = var_75_1
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_4 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_4

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play324121018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324121018
		arg_76_1.duration_ = 4.3

		local var_76_0 = {
			zh = 3.133,
			ja = 4.3
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play324121019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.225

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_1 = arg_76_1:GetWordFromCfg(324121018)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 9 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 9)

				if (9 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 9)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121018", "story_v_out_324121.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121018", "story_v_out_324121.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_324121", "324121018", "story_v_out_324121.awb")

						arg_76_1:RecordAudio("324121018", var_79_6)
						arg_76_1:RecordAudio("324121018", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_324121", "324121018", "story_v_out_324121.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_324121", "324121018", "story_v_out_324121.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play324121019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324121019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play324121020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.425

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(324121019).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 17 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 17)

				if (17 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 17)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play324121020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324121020
		arg_84_1.duration_ = 10.73

		local var_84_0 = {
			zh = 7.6,
			ja = 10.733
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play324121021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.7

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:GetWordFromCfg(324121020)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 28 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 28)

				if (28 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 28)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121020", "story_v_out_324121.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121020", "story_v_out_324121.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_324121", "324121020", "story_v_out_324121.awb")

						arg_84_1:RecordAudio("324121020", var_87_6)
						arg_84_1:RecordAudio("324121020", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_324121", "324121020", "story_v_out_324121.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_324121", "324121020", "story_v_out_324121.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play324121021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324121021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play324121022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.45

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(324121021).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 18 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 18)

				if (18 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 18)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play324121022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324121022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play324121023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0.1 < arg_92_1.time_ and arg_92_1.time_ <= 0.1 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story_148", "se_story_148_box02", "")
			end

			local var_95_1 = 0
			local var_95_2 = 1

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(324121022).content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 40 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 40)

				if (40 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 40)) > 0 and var_95_2 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_6 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_6 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_6

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_6 and arg_92_1.time_ < var_95_1 + var_95_6 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play324121023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324121023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play324121024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.9

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_1 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(324121023).content)

				arg_96_1.text_.text = var_99_1

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_3 = 36 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 36)

				if (36 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_1) / 36)) > 0 and var_99_0 < var_99_3 then
					arg_96_1.talkMaxDuration = var_99_3

					if var_99_3 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_3 + 0
					end
				end

				arg_96_1.text_.text = var_99_1
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_4 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_4

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play324121024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324121024
		arg_100_1.duration_ = 9.7

		local var_100_0 = {
			zh = 5.8,
			ja = 9.7
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play324121025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.6

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_1 = arg_100_1:GetWordFromCfg(324121024)
				local var_103_2 = arg_100_1:FormatText(var_103_1.content)

				arg_100_1.text_.text = var_103_2

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 24 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 24)

				if (24 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 24)) > 0 and var_103_0 < var_103_4 then
					arg_100_1.talkMaxDuration = var_103_4

					if var_103_4 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_4 + 0
					end
				end

				arg_100_1.text_.text = var_103_2
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121024", "story_v_out_324121.awb") ~= 0 then
					local var_103_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121024", "story_v_out_324121.awb") / 1000

					if var_103_5 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + 0
					end

					if var_103_1.prefab_name ~= "" and arg_100_1.actors_[var_103_1.prefab_name] ~= nil then
						local var_103_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_1.prefab_name].transform, "story_v_out_324121", "324121024", "story_v_out_324121.awb")

						arg_100_1:RecordAudio("324121024", var_103_6)
						arg_100_1:RecordAudio("324121024", var_103_6)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_324121", "324121024", "story_v_out_324121.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_324121", "324121024", "story_v_out_324121.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play324121025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324121025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play324121026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.55

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(324121025).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 22 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 22)

				if (22 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 22)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play324121026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324121026
		arg_108_1.duration_ = 10.23

		local var_108_0 = {
			zh = 5.366,
			ja = 10.233
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play324121027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1070ui_story = arg_108_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1070ui_story"].transform.position).z)
				arg_108_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1070ui_story"].transform.localEulerAngles = arg_108_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_108_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1070ui_story"].transform.position).z)
				arg_108_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1070ui_story"].transform.localEulerAngles = arg_108_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_111_1 = arg_108_1.actors_["1070ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1070ui_story == nil then
				arg_108_1.var_.characterEffect1070ui_story = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect1070ui_story and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1070ui_story then
				arg_108_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_111_4 = 0
			local var_111_5 = 0.5

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:GetWordFromCfg(324121026)
				local var_111_7 = arg_108_1:FormatText(var_111_6.content)

				arg_108_1.text_.text = var_111_7

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_9 = 20 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 20)

				if (20 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 20)) > 0 and var_111_5 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_4
					end
				end

				arg_108_1.text_.text = var_111_7
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121026", "story_v_out_324121.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_324121", "324121026", "story_v_out_324121.awb") / 1000

					if var_111_10 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_4
					end

					if var_111_6.prefab_name ~= "" and arg_108_1.actors_[var_111_6.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_6.prefab_name].transform, "story_v_out_324121", "324121026", "story_v_out_324121.awb")

						arg_108_1:RecordAudio("324121026", var_111_11)
						arg_108_1:RecordAudio("324121026", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_324121", "324121026", "story_v_out_324121.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_324121", "324121026", "story_v_out_324121.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_5, arg_108_1.talkMaxDuration)

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_4) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_4 + var_111_12 and arg_108_1.time_ < var_111_4 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play324121027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 324121027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play324121028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1070ui_story"]) and arg_112_1.var_.characterEffect1070ui_story == nil then
				arg_112_1.var_.characterEffect1070ui_story = arg_112_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1070ui_story"]) then
				if arg_112_1.var_.characterEffect1070ui_story and not isNil(arg_112_1.actors_["1070ui_story"]) then
					arg_112_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_0)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1070ui_story"]) and arg_112_1.var_.characterEffect1070ui_story then
				arg_112_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_115_1 = 0
			local var_115_2 = 0.075

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(324121027).content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 3 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_3) / 3)

				if (3 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_3) / 3)) > 0 and var_115_2 < var_115_5 then
					arg_112_1.talkMaxDuration = var_115_5

					if var_115_5 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_6 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_6 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_6

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_6 and arg_112_1.time_ < var_115_1 + var_115_6 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play324121028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 324121028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play324121029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1070ui_story = arg_116_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1070ui_story"].transform.position).z)
				arg_116_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1070ui_story"].transform.localEulerAngles = arg_116_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1070ui_story"].transform.position).z)
				arg_116_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1070ui_story"].transform.localEulerAngles = arg_116_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_119_1 = 0
			local var_119_2 = 0.975

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(324121028).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 39 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 39)

				if (39 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 39)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_6 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_6 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_6

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_6 and arg_116_1.time_ < var_119_1 + var_119_6 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play324121029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 324121029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play324121030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0.3 < arg_120_1.time_ and arg_120_1.time_ <= 0.3 + arg_123_0 then
				arg_120_1:AudioAction("play", "effect", "se_story_144", "se_story_144_beep", "")
			end

			local var_123_1 = 0
			local var_123_2 = 1.1

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_3 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(324121029).content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 44 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 44)

				if (44 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 44)) > 0 and var_123_2 < var_123_5 then
					arg_120_1.talkMaxDuration = var_123_5

					if var_123_5 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + var_123_1
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_6 = math.max(var_123_2, arg_120_1.talkMaxDuration)

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_6 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_1) / var_123_6

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_1 + var_123_6 and arg_120_1.time_ < var_123_1 + var_123_6 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play324121030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324121030
		arg_124_1.duration_ = 5.03

		local var_124_0 = {
			zh = 4.033,
			ja = 5.033
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play324121031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.375

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:GetWordFromCfg(324121030)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 15 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 15)

				if (15 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 15)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121030", "story_v_out_324121.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121030", "story_v_out_324121.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_324121", "324121030", "story_v_out_324121.awb")

						arg_124_1:RecordAudio("324121030", var_127_6)
						arg_124_1:RecordAudio("324121030", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_324121", "324121030", "story_v_out_324121.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_324121", "324121030", "story_v_out_324121.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play324121031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324121031
		arg_128_1.duration_ = 3.4

		local var_128_0 = {
			zh = 2.4,
			ja = 3.4
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play324121032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1070ui_story = arg_128_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1070ui_story"].transform.position).z)
				arg_128_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1070ui_story"].transform.localEulerAngles = arg_128_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_128_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1070ui_story"].transform.position).z)
				arg_128_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1070ui_story"].transform.localEulerAngles = arg_128_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_131_1 = arg_128_1.actors_["1070ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1070ui_story == nil then
				arg_128_1.var_.characterEffect1070ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect1070ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1070ui_story then
				arg_128_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_131_4 = 0
			local var_131_5 = 0.175

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(324121031)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 7 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 7)

				if (7 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 7)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121031", "story_v_out_324121.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_324121", "324121031", "story_v_out_324121.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_324121", "324121031", "story_v_out_324121.awb")

						arg_128_1:RecordAudio("324121031", var_131_11)
						arg_128_1:RecordAudio("324121031", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_324121", "324121031", "story_v_out_324121.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_324121", "324121031", "story_v_out_324121.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play324121032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324121032
		arg_132_1.duration_ = 14.4

		local var_132_0 = {
			zh = 10.7,
			ja = 14.4
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324121033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1070ui_story"]) and arg_132_1.var_.characterEffect1070ui_story == nil then
				arg_132_1.var_.characterEffect1070ui_story = arg_132_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1070ui_story"]) then
				if arg_132_1.var_.characterEffect1070ui_story and not isNil(arg_132_1.actors_["1070ui_story"]) then
					arg_132_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1070ui_story"]) and arg_132_1.var_.characterEffect1070ui_story then
				arg_132_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_135_1 = 0
			local var_135_2 = 0.925

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:GetWordFromCfg(324121032)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_6 = 37 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 37)

				if (37 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 37)) > 0 and var_135_2 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121032", "story_v_out_324121.awb") ~= 0 then
					local var_135_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121032", "story_v_out_324121.awb") / 1000

					if var_135_7 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_1
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_324121", "324121032", "story_v_out_324121.awb")

						arg_132_1:RecordAudio("324121032", var_135_8)
						arg_132_1:RecordAudio("324121032", var_135_8)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_324121", "324121032", "story_v_out_324121.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_324121", "324121032", "story_v_out_324121.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_9 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_9 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_9

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_9 and arg_132_1.time_ < var_135_1 + var_135_9 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play324121033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324121033
		arg_136_1.duration_ = 7.73

		local var_136_0 = {
			zh = 6.166,
			ja = 7.733
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play324121034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1070ui_story = arg_136_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1070ui_story"].transform.position).z)
				arg_136_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1070ui_story"].transform.localEulerAngles = arg_136_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_136_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1070ui_story"].transform.position).z)
				arg_136_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1070ui_story"].transform.localEulerAngles = arg_136_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_139_1 = arg_136_1.actors_["1070ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1070ui_story == nil then
				arg_136_1.var_.characterEffect1070ui_story = var_139_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 and not isNil(var_139_1) then
				if arg_136_1.var_.characterEffect1070ui_story and not isNil(var_139_1) then
					arg_136_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1070ui_story then
				arg_136_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_139_4 = 0
			local var_139_5 = 0.725

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(324121033)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 29 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 29)

				if (29 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 29)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121033", "story_v_out_324121.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_324121", "324121033", "story_v_out_324121.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_out_324121", "324121033", "story_v_out_324121.awb")

						arg_136_1:RecordAudio("324121033", var_139_11)
						arg_136_1:RecordAudio("324121033", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_324121", "324121033", "story_v_out_324121.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_324121", "324121033", "story_v_out_324121.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_12 and arg_136_1.time_ < var_139_4 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play324121034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324121034
		arg_140_1.duration_ = 4.4

		local var_140_0 = {
			zh = 1.966,
			ja = 4.4
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play324121035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.25

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_1 = arg_140_1:GetWordFromCfg(324121034)
				local var_143_2 = arg_140_1:FormatText(var_143_1.content)

				arg_140_1.text_.text = var_143_2

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 10 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 10)

				if (10 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 10)) > 0 and var_143_0 < var_143_4 then
					arg_140_1.talkMaxDuration = var_143_4

					if var_143_4 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_4 + 0
					end
				end

				arg_140_1.text_.text = var_143_2
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121034", "story_v_out_324121.awb") ~= 0 then
					local var_143_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121034", "story_v_out_324121.awb") / 1000

					if var_143_5 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + 0
					end

					if var_143_1.prefab_name ~= "" and arg_140_1.actors_[var_143_1.prefab_name] ~= nil then
						local var_143_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_1.prefab_name].transform, "story_v_out_324121", "324121034", "story_v_out_324121.awb")

						arg_140_1:RecordAudio("324121034", var_143_6)
						arg_140_1:RecordAudio("324121034", var_143_6)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_324121", "324121034", "story_v_out_324121.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_324121", "324121034", "story_v_out_324121.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play324121035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 324121035
		arg_144_1.duration_ = 14.17

		local var_144_0 = {
			zh = 9.533,
			ja = 14.166
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play324121036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1070ui_story"]) and arg_144_1.var_.characterEffect1070ui_story == nil then
				arg_144_1.var_.characterEffect1070ui_story = arg_144_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1070ui_story"]) then
				if arg_144_1.var_.characterEffect1070ui_story and not isNil(arg_144_1.actors_["1070ui_story"]) then
					arg_144_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1070ui_story"]) and arg_144_1.var_.characterEffect1070ui_story then
				arg_144_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_147_1 = 0
			local var_147_2 = 0.8

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(324121035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_6 = 32 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_4) / 32)

				if (32 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_4) / 32)) > 0 and var_147_2 < var_147_6 then
					arg_144_1.talkMaxDuration = var_147_6

					if var_147_6 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_6 + var_147_1
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121035", "story_v_out_324121.awb") ~= 0 then
					local var_147_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121035", "story_v_out_324121.awb") / 1000

					if var_147_7 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_1
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_324121", "324121035", "story_v_out_324121.awb")

						arg_144_1:RecordAudio("324121035", var_147_8)
						arg_144_1:RecordAudio("324121035", var_147_8)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_324121", "324121035", "story_v_out_324121.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_324121", "324121035", "story_v_out_324121.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_9 = math.max(var_147_2, arg_144_1.talkMaxDuration)

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_9 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_1) / var_147_9

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_1 + var_147_9 and arg_144_1.time_ < var_147_1 + var_147_9 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play324121036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 324121036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play324121037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1070ui_story = arg_148_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1070ui_story"].transform.position).z)
				arg_148_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1070ui_story"].transform.localEulerAngles = arg_148_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1070ui_story"].transform.position).z)
				arg_148_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1070ui_story"].transform.localEulerAngles = arg_148_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_151_1 = 0
			local var_151_2 = 0.925

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(324121036).content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 37 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 37)

				if (37 <= 0 and var_151_2 or var_151_2 * (utf8.len(var_151_3) / 37)) > 0 and var_151_2 < var_151_5 then
					arg_148_1.talkMaxDuration = var_151_5

					if var_151_5 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_6 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_6 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_6

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_6 and arg_148_1.time_ < var_151_1 + var_151_6 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play324121037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324121037
		arg_152_1.duration_ = 13

		local var_152_0 = {
			zh = 8.733,
			ja = 13
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play324121038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1070ui_story = arg_152_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1070ui_story"].transform.position).z)
				arg_152_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1070ui_story"].transform.localEulerAngles = arg_152_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_152_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1070ui_story"].transform.position).z)
				arg_152_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1070ui_story"].transform.localEulerAngles = arg_152_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_155_1 = arg_152_1.actors_["1070ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1070ui_story == nil then
				arg_152_1.var_.characterEffect1070ui_story = var_155_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 and not isNil(var_155_1) then
				if arg_152_1.var_.characterEffect1070ui_story and not isNil(var_155_1) then
					arg_152_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect1070ui_story then
				arg_152_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_155_4 = 0
			local var_155_5 = 0.975

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(324121037)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 39 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 39)

				if (39 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 39)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121037", "story_v_out_324121.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_324121", "324121037", "story_v_out_324121.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_324121", "324121037", "story_v_out_324121.awb")

						arg_152_1:RecordAudio("324121037", var_155_11)
						arg_152_1:RecordAudio("324121037", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_324121", "324121037", "story_v_out_324121.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_324121", "324121037", "story_v_out_324121.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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

		arg_152_1:InitPlayNodeList()
	end,
	Play324121038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324121038
		arg_156_1.duration_ = 5.53

		local var_156_0 = {
			zh = 3.033,
			ja = 5.533
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play324121039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1070ui_story"]) and arg_156_1.var_.characterEffect1070ui_story == nil then
				arg_156_1.var_.characterEffect1070ui_story = arg_156_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1070ui_story"]) then
				if arg_156_1.var_.characterEffect1070ui_story and not isNil(arg_156_1.actors_["1070ui_story"]) then
					arg_156_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1070ui_story"]) and arg_156_1.var_.characterEffect1070ui_story then
				arg_156_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_159_1 = 0
			local var_159_2 = 0.275

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:GetWordFromCfg(324121038)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_6 = 11 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_4) / 11)

				if (11 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_4) / 11)) > 0 and var_159_2 < var_159_6 then
					arg_156_1.talkMaxDuration = var_159_6

					if var_159_6 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121038", "story_v_out_324121.awb") ~= 0 then
					local var_159_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121038", "story_v_out_324121.awb") / 1000

					if var_159_7 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_1
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_out_324121", "324121038", "story_v_out_324121.awb")

						arg_156_1:RecordAudio("324121038", var_159_8)
						arg_156_1:RecordAudio("324121038", var_159_8)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_324121", "324121038", "story_v_out_324121.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_324121", "324121038", "story_v_out_324121.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_9 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_9 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_9

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_9 and arg_156_1.time_ < var_159_1 + var_159_9 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play324121039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324121039
		arg_160_1.duration_ = 10.4

		local var_160_0 = {
			zh = 9.6,
			ja = 10.4
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play324121040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1070ui_story"]) and arg_160_1.var_.characterEffect1070ui_story == nil then
				arg_160_1.var_.characterEffect1070ui_story = arg_160_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1070ui_story"]) then
				if arg_160_1.var_.characterEffect1070ui_story and not isNil(arg_160_1.actors_["1070ui_story"]) then
					arg_160_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1070ui_story"]) and arg_160_1.var_.characterEffect1070ui_story then
				arg_160_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_163_2 = 0
			local var_163_3 = 0.95

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_4 = arg_160_1:GetWordFromCfg(324121039)
				local var_163_5 = arg_160_1:FormatText(var_163_4.content)

				arg_160_1.text_.text = var_163_5

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 38 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 38)

				if (38 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_5) / 38)) > 0 and var_163_3 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_2
					end
				end

				arg_160_1.text_.text = var_163_5
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121039", "story_v_out_324121.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121039", "story_v_out_324121.awb") / 1000

					if var_163_8 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_2
					end

					if var_163_4.prefab_name ~= "" and arg_160_1.actors_[var_163_4.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_4.prefab_name].transform, "story_v_out_324121", "324121039", "story_v_out_324121.awb")

						arg_160_1:RecordAudio("324121039", var_163_9)
						arg_160_1:RecordAudio("324121039", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_324121", "324121039", "story_v_out_324121.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_324121", "324121039", "story_v_out_324121.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_3, arg_160_1.talkMaxDuration)

			if var_163_2 <= arg_160_1.time_ and arg_160_1.time_ < var_163_2 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_2) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_2 + var_163_10 and arg_160_1.time_ < var_163_2 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play324121040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324121040
		arg_164_1.duration_ = 4.6

		local var_164_0 = {
			zh = 3.7,
			ja = 4.6
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play324121041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1070ui_story"]) and arg_164_1.var_.characterEffect1070ui_story == nil then
				arg_164_1.var_.characterEffect1070ui_story = arg_164_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1070ui_story"]) then
				if arg_164_1.var_.characterEffect1070ui_story and not isNil(arg_164_1.actors_["1070ui_story"]) then
					arg_164_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_0)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1070ui_story"]) and arg_164_1.var_.characterEffect1070ui_story then
				arg_164_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_167_1 = 0
			local var_167_2 = 0.275

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:GetWordFromCfg(324121040)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_6 = 11 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_4) / 11)

				if (11 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_4) / 11)) > 0 and var_167_2 < var_167_6 then
					arg_164_1.talkMaxDuration = var_167_6

					if var_167_6 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_6 + var_167_1
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121040", "story_v_out_324121.awb") ~= 0 then
					local var_167_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121040", "story_v_out_324121.awb") / 1000

					if var_167_7 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_1
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_324121", "324121040", "story_v_out_324121.awb")

						arg_164_1:RecordAudio("324121040", var_167_8)
						arg_164_1:RecordAudio("324121040", var_167_8)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_324121", "324121040", "story_v_out_324121.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_324121", "324121040", "story_v_out_324121.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_9 = math.max(var_167_2, arg_164_1.talkMaxDuration)

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_9 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_1) / var_167_9

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_1 + var_167_9 and arg_164_1.time_ < var_167_1 + var_167_9 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play324121041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324121041
		arg_168_1.duration_ = 4.53

		local var_168_0 = {
			zh = 4.233,
			ja = 4.533
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play324121042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["1070ui_story"]) and arg_168_1.var_.characterEffect1070ui_story == nil then
				arg_168_1.var_.characterEffect1070ui_story = arg_168_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.200000002980232

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["1070ui_story"]) then
				if arg_168_1.var_.characterEffect1070ui_story and not isNil(arg_168_1.actors_["1070ui_story"]) then
					arg_168_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["1070ui_story"]) and arg_168_1.var_.characterEffect1070ui_story then
				arg_168_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_171_2 = 0
			local var_171_3 = 0.325

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_2 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_4 = arg_168_1:GetWordFromCfg(324121041)
				local var_171_5 = arg_168_1:FormatText(var_171_4.content)

				arg_168_1.text_.text = var_171_5

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_7 = 13 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 13)

				if (13 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 13)) > 0 and var_171_3 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_2
					end
				end

				arg_168_1.text_.text = var_171_5
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121041", "story_v_out_324121.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121041", "story_v_out_324121.awb") / 1000

					if var_171_8 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_2
					end

					if var_171_4.prefab_name ~= "" and arg_168_1.actors_[var_171_4.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_4.prefab_name].transform, "story_v_out_324121", "324121041", "story_v_out_324121.awb")

						arg_168_1:RecordAudio("324121041", var_171_9)
						arg_168_1:RecordAudio("324121041", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_324121", "324121041", "story_v_out_324121.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_324121", "324121041", "story_v_out_324121.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_3, arg_168_1.talkMaxDuration)

			if var_171_2 <= arg_168_1.time_ and arg_168_1.time_ < var_171_2 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_2) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_2 + var_171_10 and arg_168_1.time_ < var_171_2 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play324121042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324121042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play324121043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1070ui_story"]) and arg_172_1.var_.characterEffect1070ui_story == nil then
				arg_172_1.var_.characterEffect1070ui_story = arg_172_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1070ui_story"]) then
				if arg_172_1.var_.characterEffect1070ui_story and not isNil(arg_172_1.actors_["1070ui_story"]) then
					arg_172_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1070ui_story"]) and arg_172_1.var_.characterEffect1070ui_story then
				arg_172_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_175_1 = 0
			local var_175_2 = 1.25

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(324121042).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 50 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 50)

				if (50 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 50)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play324121043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 324121043
		arg_176_1.duration_ = 2.17

		local var_176_0 = {
			zh = 2.066,
			ja = 2.166
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play324121044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1070ui_story"]) and arg_176_1.var_.characterEffect1070ui_story == nil then
				arg_176_1.var_.characterEffect1070ui_story = arg_176_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1070ui_story"]) then
				if arg_176_1.var_.characterEffect1070ui_story and not isNil(arg_176_1.actors_["1070ui_story"]) then
					arg_176_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1070ui_story"]) and arg_176_1.var_.characterEffect1070ui_story then
				arg_176_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action443")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_179_2 = 0
			local var_179_3 = 0.15

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_4 = arg_176_1:GetWordFromCfg(324121043)
				local var_179_5 = arg_176_1:FormatText(var_179_4.content)

				arg_176_1.text_.text = var_179_5

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_7 = 6 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 6)

				if (6 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_5) / 6)) > 0 and var_179_3 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_2
					end
				end

				arg_176_1.text_.text = var_179_5
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121043", "story_v_out_324121.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121043", "story_v_out_324121.awb") / 1000

					if var_179_8 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_2
					end

					if var_179_4.prefab_name ~= "" and arg_176_1.actors_[var_179_4.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_4.prefab_name].transform, "story_v_out_324121", "324121043", "story_v_out_324121.awb")

						arg_176_1:RecordAudio("324121043", var_179_9)
						arg_176_1:RecordAudio("324121043", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_324121", "324121043", "story_v_out_324121.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_324121", "324121043", "story_v_out_324121.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_3, arg_176_1.talkMaxDuration)

			if var_179_2 <= arg_176_1.time_ and arg_176_1.time_ < var_179_2 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_2) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_2 + var_179_10 and arg_176_1.time_ < var_179_2 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play324121044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 324121044
		arg_180_1.duration_ = 5.88

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play324121045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_9000

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1070ui_story = arg_180_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_183_0 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 then
				arg_180_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_180_1.time_ - 0) / var_183_0)
				arg_180_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1070ui_story"].transform.position).z)
				arg_180_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1070ui_story"].transform.localEulerAngles = arg_180_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 then
				arg_180_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_180_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1070ui_story"].transform.position).z)
				arg_180_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1070ui_story"].transform.localEulerAngles = arg_180_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_183_1 = arg_180_1.actors_["1070ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect1070ui_story == nil then
				arg_180_1.var_.characterEffect1070ui_story = var_183_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_2 and not isNil(var_183_1) then
				if arg_180_1.var_.characterEffect1070ui_story and not isNil(var_183_1) then
					arg_180_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_2)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_2 and arg_180_1.time_ < 0 + var_183_2 + arg_183_0 and not isNil(var_183_1) and arg_180_1.var_.characterEffect1070ui_story then
				arg_180_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				local var_183_3 = arg_180_1.var_.effectwew

				if not arg_180_1.var_.effectwew then
					var_183_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_liefeng_keep"), manager.ui.mainCamera.transform)
					var_183_3.name = "wew"
					arg_180_1.var_.effectwew = var_183_3
				else
					var_183_3.transform:SetParent(var_183_9000)
				end

				var_183_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_183_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_183_3.transform.localScale = Vector3.New(var_183_3.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_183_3.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_183_3.transform.localScale.z)
			end

			local var_183_5 = 0

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 then
				arg_180_1.allBtn_.enabled = false
			end

			if arg_180_1.time_ >= var_183_5 + 1.26666666666667 and arg_180_1.time_ < var_183_5 + 1.26666666666667 + arg_183_0 then
				arg_180_1.allBtn_.enabled = true
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:AudioAction("play", "effect", "se_story_150", "se_story_150_open", "")
			end

			if arg_180_1.frameCnt_ <= 1 then
				arg_180_1.dialog_:SetActive(false)
			end

			local var_183_7 = 0.877564202714711
			local var_183_8 = 1.2

			if 0.877564202714711 < arg_180_1.time_ and arg_180_1.time_ <= var_183_7 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				arg_180_1.dialog_:SetActive(true)

				arg_180_1.dialogCg_.alpha = 0

				local var_183_9 = LeanTween.value(arg_180_1.dialog_, 0, 1, 0.3)

				var_183_9:setOnUpdate(LuaHelper.FloatAction(function(arg_184_0)
					arg_180_1.dialogCg_.alpha = arg_184_0
				end))
				var_183_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_180_1.dialog_)
					var_183_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_180_1.duration_ = arg_180_1.duration_ + 0.3

				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_10 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(324121044).content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_12 = 48 <= 0 and var_183_8 or var_183_8 * (utf8.len(var_183_10) / 48)

				if (48 <= 0 and var_183_8 or var_183_8 * (utf8.len(var_183_10) / 48)) > 0 and var_183_8 < var_183_12 then
					arg_180_1.talkMaxDuration = var_183_12
					var_183_7 = var_183_7 + 0.3

					if var_183_12 + var_183_7 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_12 + var_183_7
					end
				end

				arg_180_1.text_.text = var_183_10
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_13 = var_183_7 + 0.3
			local var_183_14 = math.max(var_183_8, arg_180_1.talkMaxDuration)

			if var_183_7 + 0.3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_13 + var_183_14 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_13) / var_183_14

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_13 + var_183_14 and arg_180_1.time_ < var_183_13 + var_183_14 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
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

		arg_180_1:InitPlayNodeList()
	end,
	Play324121045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 324121045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play324121046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.6

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_1 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(324121045).content)

				arg_186_1.text_.text = var_189_1

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_3 = 24 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 24)

				if (24 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 24)) > 0 and var_189_0 < var_189_3 then
					arg_186_1.talkMaxDuration = var_189_3

					if var_189_3 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_3 + 0
					end
				end

				arg_186_1.text_.text = var_189_1
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_4 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_4

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play324121046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 324121046
		arg_190_1.duration_ = 9.83

		local var_190_0 = {
			zh = 9.83333333333333,
			ja = 9.49933333333333
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play324121047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if arg_190_1.bgs_.ST37 == nil then
				local var_193_0 = Object.Instantiate(arg_190_1.paintGo_)

				var_193_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37")
				var_193_0.name = "ST37"
				var_193_0.transform.parent = arg_190_1.stage_.transform
				var_193_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_190_1.bgs_.ST37 = var_193_0
			end

			if 2.03400000184774 < arg_190_1.time_ and arg_190_1.time_ <= 2.03400000184774 + arg_193_0 then
				local var_193_1 = arg_190_1.bgs_.ST37

				arg_190_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_193_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_193_2 = var_193_1:GetComponent("SpriteRenderer")

				if var_193_2 and var_193_2.sprite then
					local var_193_3 = 2 * (var_193_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_193_1.transform.localScale = Vector3.New(var_193_3 / var_193_2.sprite.bounds.size.y < var_193_3 * manager.ui.mainCameraCom_.aspect / var_193_2.sprite.bounds.size.x and var_193_3 * manager.ui.mainCameraCom_.aspect / var_193_2.sprite.bounds.size.x or var_193_3 / var_193_2.sprite.bounds.size.y, var_193_3 / var_193_2.sprite.bounds.size.y < var_193_3 * manager.ui.mainCameraCom_.aspect / var_193_2.sprite.bounds.size.x and var_193_3 * manager.ui.mainCameraCom_.aspect / var_193_2.sprite.bounds.size.x or var_193_3 / var_193_2.sprite.bounds.size.y, 0)
				end

				for iter_193_0, iter_193_1 in pairs(arg_190_1.bgs_) do
					if iter_193_0 ~= "ST37" then
						iter_193_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_193_4 = 0

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.allBtn_.enabled = false
			end

			if arg_190_1.time_ >= var_193_4 + 0.3 and arg_190_1.time_ < var_193_4 + 0.3 + arg_193_0 then
				arg_190_1.allBtn_.enabled = true
			end

			local var_193_5 = 0

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_6 = 2

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_6 then
				local var_193_7 = Color.New(0, 0, 0)

				var_193_7.a = Mathf.Lerp(0, 1, (arg_190_1.time_ - var_193_5) / var_193_6)
				arg_190_1.mask_.color = var_193_7
			end

			if arg_190_1.time_ >= var_193_5 + var_193_6 and arg_190_1.time_ < var_193_5 + var_193_6 + arg_193_0 then
				local var_193_8 = Color.New(0, 0, 0)

				var_193_8.a = 1
				arg_190_1.mask_.color = var_193_8
			end

			local var_193_9 = 2

			if 2 < arg_190_1.time_ and arg_190_1.time_ <= var_193_9 + arg_193_0 then
				arg_190_1.mask_.enabled = true
				arg_190_1.mask_.raycastTarget = true

				arg_190_1:SetGaussion(false)
			end

			local var_193_10 = 2

			if var_193_9 <= arg_190_1.time_ and arg_190_1.time_ < var_193_9 + var_193_10 then
				local var_193_11 = Color.New(0, 0, 0)

				var_193_11.a = Mathf.Lerp(1, 0, (arg_190_1.time_ - var_193_9) / var_193_10)
				arg_190_1.mask_.color = var_193_11
			end

			if arg_190_1.time_ >= var_193_9 + var_193_10 and arg_190_1.time_ < var_193_9 + var_193_10 + arg_193_0 then
				local var_193_12 = Color.New(0, 0, 0)

				arg_190_1.mask_.enabled = false
				var_193_12.a = 0
				arg_190_1.mask_.color = var_193_12
			end

			local var_193_13 = "10170ui_story"

			if arg_190_1.actors_["10170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10170ui_story"))) then
				local var_193_14 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_190_1.stage_.transform)

				var_193_14.name = var_193_13
				var_193_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_190_1.actors_[var_193_13] = var_193_14

				local var_193_15 = var_193_14:GetComponentInChildren(typeof(CharacterEffect))

				var_193_15.enabled = true

				local var_193_16 = GameObjectTools.GetOrAddComponent(var_193_14, typeof(DynamicBoneHelper))

				if var_193_16 then
					var_193_16:EnableDynamicBone(false)
				end

				arg_190_1:ShowWeapon(var_193_15.transform, false)

				arg_190_1.var_[var_193_13 .. "Animator"] = var_193_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_190_1.var_[var_193_13 .. "Animator"].applyRootMotion = true
				arg_190_1.var_[var_193_13 .. "LipSync"] = var_193_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_193_17 = arg_190_1.actors_["10170ui_story"].transform

			if 3.83333333333333 < arg_190_1.time_ and arg_190_1.time_ <= 3.83333333333333 + arg_193_0 then
				arg_190_1.var_.moveOldPos10170ui_story = var_193_17.localPosition

				local var_193_18 = GameObjectTools.GetOrAddComponent(var_193_17.gameObject, typeof(DynamicBoneHelper))

				if var_193_18 then
					var_193_18:EnableDynamicBone(false)
				end
			end

			local var_193_19 = 0.001

			if 3.83333333333333 <= arg_190_1.time_ and arg_190_1.time_ < 3.83333333333333 + var_193_19 then
				var_193_17.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_190_1.time_ - 3.83333333333333) / var_193_19)
				var_193_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_193_17.position).x, (manager.ui.mainCamera.transform.position - var_193_17.position).y, (manager.ui.mainCamera.transform.position - var_193_17.position).z)
				var_193_17.localEulerAngles.z = 0
				var_193_17.localEulerAngles.x = 0
				var_193_17.localEulerAngles = var_193_17.localEulerAngles
			end

			if arg_190_1.time_ >= 3.83333333333333 + var_193_19 and arg_190_1.time_ < 3.83333333333333 + var_193_19 + arg_193_0 then
				var_193_17.localPosition = Vector3.New(0, -1.03, -6.05)
				var_193_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_193_17.position).x, (manager.ui.mainCamera.transform.position - var_193_17.position).y, (manager.ui.mainCamera.transform.position - var_193_17.position).z)
				var_193_17.localEulerAngles.z = 0
				var_193_17.localEulerAngles.x = 0
				var_193_17.localEulerAngles = var_193_17.localEulerAngles

				local var_193_20 = GameObjectTools.GetOrAddComponent(var_193_17.gameObject, typeof(DynamicBoneHelper))

				if var_193_20 then
					var_193_20:EnableDynamicBone(true)
				end
			end

			local var_193_21 = arg_190_1.actors_["10170ui_story"]

			if 3.83333333333333 < arg_190_1.time_ and arg_190_1.time_ <= 3.83333333333333 + arg_193_0 and not isNil(var_193_21) and arg_190_1.var_.characterEffect10170ui_story == nil then
				arg_190_1.var_.characterEffect10170ui_story = var_193_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_22 = 0.200000002980232

			if 3.83333333333333 <= arg_190_1.time_ and arg_190_1.time_ < 3.83333333333333 + var_193_22 and not isNil(var_193_21) then
				if arg_190_1.var_.characterEffect10170ui_story and not isNil(var_193_21) then
					arg_190_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 3.83333333333333 + var_193_22 and arg_190_1.time_ < 3.83333333333333 + var_193_22 + arg_193_0 and not isNil(var_193_21) and arg_190_1.var_.characterEffect10170ui_story then
				arg_190_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_190_1.time_ and arg_190_1.time_ <= 3.83333333333333 + arg_193_0 then
				arg_190_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			if 3.83333333333333 < arg_190_1.time_ and arg_190_1.time_ <= 3.83333333333333 + arg_193_0 then
				arg_190_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 2 < arg_190_1.time_ and arg_190_1.time_ <= 2 + arg_193_0 then
				if arg_190_1.var_.effectwew then
					Object.Destroy(arg_190_1.var_.effectwew)

					arg_190_1.var_.effectwew = nil
				end
			end

			local var_193_25 = 2

			arg_190_1.isInRecall_ = true

			if var_193_25 < arg_190_1.time_ and arg_190_1.time_ <= var_193_25 + arg_193_0 then
				arg_190_1.screenFilterGo_:SetActive(true)

				arg_190_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_190_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_190_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_193_2, iter_193_3 in pairs(arg_190_1.actors_) do
					for iter_193_4, iter_193_5 in ipairs((iter_193_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_193_5.color = iter_193_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_193_26 = 0.200666668514411

			if var_193_25 <= arg_190_1.time_ and arg_190_1.time_ < var_193_25 + var_193_26 then
				arg_190_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_190_1.time_ - var_193_25) / var_193_26)
			end

			if arg_190_1.time_ >= var_193_25 + var_193_26 and arg_190_1.time_ < var_193_25 + var_193_26 + arg_193_0 then
				arg_190_1.screenFilterEffect_.weight = 1
			end

			if 1.2 < arg_190_1.time_ and arg_190_1.time_ <= 1.2 + arg_193_0 then
				arg_190_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 0.1 < arg_190_1.time_ and arg_190_1.time_ <= 0.1 + arg_193_0 then
				arg_190_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_ice_caved", "")
			end

			if arg_190_1.frameCnt_ <= 1 then
				arg_190_1.dialog_:SetActive(false)
			end

			local var_193_29 = 3.83333333333333
			local var_193_30 = 0.725

			if 3.83333333333333 < arg_190_1.time_ and arg_190_1.time_ <= var_193_29 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0

				arg_190_1.dialog_:SetActive(true)

				arg_190_1.dialogCg_.alpha = 0

				local var_193_31 = LeanTween.value(arg_190_1.dialog_, 0, 1, 0.3)

				var_193_31:setOnUpdate(LuaHelper.FloatAction(function(arg_194_0)
					arg_190_1.dialogCg_.alpha = arg_194_0
				end))
				var_193_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_190_1.dialog_)
					var_193_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_190_1.duration_ = arg_190_1.duration_ + 0.3

				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_32 = arg_190_1:GetWordFromCfg(324121046)
				local var_193_33 = arg_190_1:FormatText(var_193_32.content)

				arg_190_1.text_.text = var_193_33

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_35 = 29 <= 0 and var_193_30 or var_193_30 * (utf8.len(var_193_33) / 29)

				if (29 <= 0 and var_193_30 or var_193_30 * (utf8.len(var_193_33) / 29)) > 0 and var_193_30 < var_193_35 then
					arg_190_1.talkMaxDuration = var_193_35
					var_193_29 = var_193_29 + 0.3

					if var_193_35 + var_193_29 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_35 + var_193_29
					end
				end

				arg_190_1.text_.text = var_193_33
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121046", "story_v_out_324121.awb") ~= 0 then
					local var_193_36 = manager.audio:GetVoiceLength("story_v_out_324121", "324121046", "story_v_out_324121.awb") / 1000

					if var_193_36 + var_193_29 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_36 + var_193_29
					end

					if var_193_32.prefab_name ~= "" and arg_190_1.actors_[var_193_32.prefab_name] ~= nil then
						local var_193_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_32.prefab_name].transform, "story_v_out_324121", "324121046", "story_v_out_324121.awb")

						arg_190_1:RecordAudio("324121046", var_193_37)
						arg_190_1:RecordAudio("324121046", var_193_37)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_324121", "324121046", "story_v_out_324121.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_324121", "324121046", "story_v_out_324121.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_38 = var_193_29 + 0.3
			local var_193_39 = math.max(var_193_30, arg_190_1.talkMaxDuration)

			if var_193_29 + 0.3 <= arg_190_1.time_ and arg_190_1.time_ < var_193_38 + var_193_39 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_38) / var_193_39

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_38 + var_193_39 and arg_190_1.time_ < var_193_38 + var_193_39 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play324121047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 324121047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play324121048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if arg_196_1.actors_["1012ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1012ui_story"))) then
				local var_199_0 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_196_1.stage_.transform)

				var_199_0.name = "1012ui_story"
				var_199_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_196_1.actors_["1012ui_story"] = var_199_0

				local var_199_1 = var_199_0:GetComponentInChildren(typeof(CharacterEffect))

				var_199_1.enabled = true

				local var_199_2 = GameObjectTools.GetOrAddComponent(var_199_0, typeof(DynamicBoneHelper))

				if var_199_2 then
					var_199_2:EnableDynamicBone(false)
				end

				arg_196_1:ShowWeapon(var_199_1.transform, false)

				arg_196_1.var_["1012ui_story" .. "Animator"] = var_199_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_196_1.var_["1012ui_story" .. "Animator"].applyRootMotion = true
				arg_196_1.var_["1012ui_story" .. "LipSync"] = var_199_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_199_3 = arg_196_1.actors_["1012ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_3) and arg_196_1.var_.characterEffect1012ui_story == nil then
				arg_196_1.var_.characterEffect1012ui_story = var_199_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_4 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_4 and not isNil(var_199_3) then
				if arg_196_1.var_.characterEffect1012ui_story and not isNil(var_199_3) then
					arg_196_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_4)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_4 and arg_196_1.time_ < 0 + var_199_4 + arg_199_0 and not isNil(var_199_3) and arg_196_1.var_.characterEffect1012ui_story then
				arg_196_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_199_5 = 0
			local var_199_6 = 0.7

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_196_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_199_7 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(324121047).content)

				arg_196_1.text_.text = var_199_7

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_9 = 28 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_7) / 28)

				if (28 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_7) / 28)) > 0 and var_199_6 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_5
					end
				end

				arg_196_1.text_.text = var_199_7
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_6, arg_196_1.talkMaxDuration)

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_5) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_5 + var_199_10 and arg_196_1.time_ < var_199_5 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play324121048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 324121048
		arg_200_1.duration_ = 8.63

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play324121049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 2 < arg_200_1.time_ and arg_200_1.time_ <= 2 + arg_203_0 then
				local var_203_0 = arg_200_1.bgs_.ST2005

				arg_200_1.bgs_.ST2005.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_203_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_203_1 = var_203_0:GetComponent("SpriteRenderer")

				if var_203_1 and var_203_1.sprite then
					local var_203_2 = 2 * (var_203_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_203_0.transform.localScale = Vector3.New(var_203_2 / var_203_1.sprite.bounds.size.y < var_203_2 * manager.ui.mainCameraCom_.aspect / var_203_1.sprite.bounds.size.x and var_203_2 * manager.ui.mainCameraCom_.aspect / var_203_1.sprite.bounds.size.x or var_203_2 / var_203_1.sprite.bounds.size.y, var_203_2 / var_203_1.sprite.bounds.size.y < var_203_2 * manager.ui.mainCameraCom_.aspect / var_203_1.sprite.bounds.size.x and var_203_2 * manager.ui.mainCameraCom_.aspect / var_203_1.sprite.bounds.size.x or var_203_2 / var_203_1.sprite.bounds.size.y, 0)
				end

				for iter_203_0, iter_203_1 in pairs(arg_200_1.bgs_) do
					if iter_203_0 ~= "ST2005" then
						iter_203_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_203_3 = 2

			if 2 < arg_200_1.time_ and arg_200_1.time_ <= var_203_3 + arg_203_0 then
				arg_200_1.allBtn_.enabled = false
			end

			if arg_200_1.time_ >= var_203_3 + 0.3 and arg_200_1.time_ < var_203_3 + 0.3 + arg_203_0 then
				arg_200_1.allBtn_.enabled = true
			end

			local var_203_4 = 0

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_5 = 2

			if var_203_4 <= arg_200_1.time_ and arg_200_1.time_ < var_203_4 + var_203_5 then
				local var_203_6 = Color.New(0, 0, 0)

				var_203_6.a = Mathf.Lerp(0, 1, (arg_200_1.time_ - var_203_4) / var_203_5)
				arg_200_1.mask_.color = var_203_6
			end

			if arg_200_1.time_ >= var_203_4 + var_203_5 and arg_200_1.time_ < var_203_4 + var_203_5 + arg_203_0 then
				local var_203_7 = Color.New(0, 0, 0)

				var_203_7.a = 1
				arg_200_1.mask_.color = var_203_7
			end

			local var_203_8 = 2

			if 2 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1.mask_.enabled = true
				arg_200_1.mask_.raycastTarget = true

				arg_200_1:SetGaussion(false)
			end

			local var_203_9 = 2

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_9 then
				local var_203_10 = Color.New(0, 0, 0)

				var_203_10.a = Mathf.Lerp(1, 0, (arg_200_1.time_ - var_203_8) / var_203_9)
				arg_200_1.mask_.color = var_203_10
			end

			if arg_200_1.time_ >= var_203_8 + var_203_9 and arg_200_1.time_ < var_203_8 + var_203_9 + arg_203_0 then
				local var_203_11 = Color.New(0, 0, 0)

				arg_200_1.mask_.enabled = false
				var_203_11.a = 0
				arg_200_1.mask_.color = var_203_11
			end

			local var_203_12 = arg_200_1.actors_["10170ui_story"].transform

			if 2 < arg_200_1.time_ and arg_200_1.time_ <= 2 + arg_203_0 then
				arg_200_1.var_.moveOldPos10170ui_story = var_203_12.localPosition

				local var_203_13 = GameObjectTools.GetOrAddComponent(var_203_12.gameObject, typeof(DynamicBoneHelper))

				if var_203_13 then
					var_203_13:EnableDynamicBone(false)
				end
			end

			local var_203_14 = 0.001

			if 2 <= arg_200_1.time_ and arg_200_1.time_ < 2 + var_203_14 then
				var_203_12.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_200_1.time_ - 2) / var_203_14)
				var_203_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_12.position).x, (manager.ui.mainCamera.transform.position - var_203_12.position).y, (manager.ui.mainCamera.transform.position - var_203_12.position).z)
				var_203_12.localEulerAngles.z = 0
				var_203_12.localEulerAngles.x = 0
				var_203_12.localEulerAngles = var_203_12.localEulerAngles
			end

			if arg_200_1.time_ >= 2 + var_203_14 and arg_200_1.time_ < 2 + var_203_14 + arg_203_0 then
				var_203_12.localPosition = Vector3.New(0, 100, 0)
				var_203_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_203_12.position).x, (manager.ui.mainCamera.transform.position - var_203_12.position).y, (manager.ui.mainCamera.transform.position - var_203_12.position).z)
				var_203_12.localEulerAngles.z = 0
				var_203_12.localEulerAngles.x = 0
				var_203_12.localEulerAngles = var_203_12.localEulerAngles

				local var_203_15 = GameObjectTools.GetOrAddComponent(var_203_12.gameObject, typeof(DynamicBoneHelper))

				if var_203_15 then
					var_203_15:EnableDynamicBone(true)
				end
			end

			local var_203_16 = 2

			arg_200_1.isInRecall_ = false

			if var_203_16 < arg_200_1.time_ and arg_200_1.time_ <= var_203_16 + arg_203_0 then
				arg_200_1.screenFilterGo_:SetActive(false)

				for iter_203_2, iter_203_3 in pairs(arg_200_1.actors_) do
					for iter_203_4, iter_203_5 in ipairs((iter_203_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_203_5.color = iter_203_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_203_17 = 0.0166666666666667

			if var_203_16 <= arg_200_1.time_ and arg_200_1.time_ < var_203_16 + var_203_17 then
				arg_200_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_200_1.time_ - var_203_16) / var_203_17)
			end

			if arg_200_1.time_ >= var_203_16 + var_203_17 and arg_200_1.time_ < var_203_16 + var_203_17 + arg_203_0 then
				arg_200_1.screenFilterEffect_.weight = 0
			end

			if 1.2 < arg_200_1.time_ and arg_200_1.time_ <= 1.2 + arg_203_0 then
				arg_200_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_ice_cave", "")
			end

			if 0.1 < arg_200_1.time_ and arg_200_1.time_ <= 0.1 + arg_203_0 then
				arg_200_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_200_1.frameCnt_ <= 1 then
				arg_200_1.dialog_:SetActive(false)
			end

			local var_203_20 = 3.63333333333333
			local var_203_21 = 0.125

			if 3.63333333333333 < arg_200_1.time_ and arg_200_1.time_ <= var_203_20 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				arg_200_1.dialog_:SetActive(true)

				arg_200_1.dialogCg_.alpha = 0

				local var_203_22 = LeanTween.value(arg_200_1.dialog_, 0, 1, 0.3)

				var_203_22:setOnUpdate(LuaHelper.FloatAction(function(arg_204_0)
					arg_200_1.dialogCg_.alpha = arg_204_0
				end))
				var_203_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_200_1.dialog_)
					var_203_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_200_1.duration_ = arg_200_1.duration_ + 0.3

				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_23 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(324121048).content)

				arg_200_1.text_.text = var_203_23

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_25 = 5 <= 0 and var_203_21 or var_203_21 * (utf8.len(var_203_23) / 5)

				if (5 <= 0 and var_203_21 or var_203_21 * (utf8.len(var_203_23) / 5)) > 0 and var_203_21 < var_203_25 then
					arg_200_1.talkMaxDuration = var_203_25
					var_203_20 = var_203_20 + 0.3

					if var_203_25 + var_203_20 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_25 + var_203_20
					end
				end

				arg_200_1.text_.text = var_203_23
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_26 = var_203_20 + 0.3
			local var_203_27 = math.max(var_203_21, arg_200_1.talkMaxDuration)

			if var_203_20 + 0.3 <= arg_200_1.time_ and arg_200_1.time_ < var_203_26 + var_203_27 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_26) / var_203_27

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_26 + var_203_27 and arg_200_1.time_ < var_203_26 + var_203_27 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play324121049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 324121049
		arg_206_1.duration_ = 1.73

		local var_206_0 = {
			zh = 1.7,
			ja = 1.733
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play324121050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.075

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_1 = arg_206_1:GetWordFromCfg(324121049)
				local var_209_2 = arg_206_1:FormatText(var_209_1.content)

				arg_206_1.text_.text = var_209_2

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 3 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 3)

				if (3 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_2) / 3)) > 0 and var_209_0 < var_209_4 then
					arg_206_1.talkMaxDuration = var_209_4

					if var_209_4 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_4 + 0
					end
				end

				arg_206_1.text_.text = var_209_2
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121049", "story_v_out_324121.awb") ~= 0 then
					local var_209_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121049", "story_v_out_324121.awb") / 1000

					if var_209_5 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + 0
					end

					if var_209_1.prefab_name ~= "" and arg_206_1.actors_[var_209_1.prefab_name] ~= nil then
						local var_209_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_1.prefab_name].transform, "story_v_out_324121", "324121049", "story_v_out_324121.awb")

						arg_206_1:RecordAudio("324121049", var_209_6)
						arg_206_1:RecordAudio("324121049", var_209_6)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_324121", "324121049", "story_v_out_324121.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_324121", "324121049", "story_v_out_324121.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play324121050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 324121050
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play324121051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 1.55

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_1 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(324121050).content)

				arg_210_1.text_.text = var_213_1

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_3 = 62 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 62)

				if (62 <= 0 and var_213_0 or var_213_0 * (utf8.len(var_213_1) / 62)) > 0 and var_213_0 < var_213_3 then
					arg_210_1.talkMaxDuration = var_213_3

					if var_213_3 + 0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_3 + 0
					end
				end

				arg_210_1.text_.text = var_213_1
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_4 = math.max(var_213_0, arg_210_1.talkMaxDuration)

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - 0) / var_213_4

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play324121051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 324121051
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play324121052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.675

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(324121051).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 27 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 27)

				if (27 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 27)) > 0 and var_217_0 < var_217_3 then
					arg_214_1.talkMaxDuration = var_217_3

					if var_217_3 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_3 + 0
					end
				end

				arg_214_1.text_.text = var_217_1
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_4 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_4

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play324121052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 324121052
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play324121053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.65

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(324121052).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 26 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 26)

				if (26 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 26)) > 0 and var_221_0 < var_221_3 then
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
	Play324121053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 324121053
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play324121054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.375

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_1 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(324121053).content)

				arg_222_1.text_.text = var_225_1

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_3 = 15 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 15)

				if (15 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 15)) > 0 and var_225_0 < var_225_3 then
					arg_222_1.talkMaxDuration = var_225_3

					if var_225_3 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_3 + 0
					end
				end

				arg_222_1.text_.text = var_225_1
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_4 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_4

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play324121054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 324121054
		arg_226_1.duration_ = 5.53

		local var_226_0 = {
			zh = 4.933,
			ja = 5.533
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play324121055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1070ui_story = arg_226_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_229_0 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 then
				arg_226_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_226_1.time_ - 0) / var_229_0)
				arg_226_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1070ui_story"].transform.position).z)
				arg_226_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1070ui_story"].transform.localEulerAngles = arg_226_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 then
				arg_226_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_226_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1070ui_story"].transform.position).z)
				arg_226_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1070ui_story"].transform.localEulerAngles = arg_226_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_229_1 = arg_226_1.actors_["1070ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1070ui_story == nil then
				arg_226_1.var_.characterEffect1070ui_story = var_229_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_2 and not isNil(var_229_1) then
				if arg_226_1.var_.characterEffect1070ui_story and not isNil(var_229_1) then
					arg_226_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_2 and arg_226_1.time_ < 0 + var_229_2 + arg_229_0 and not isNil(var_229_1) and arg_226_1.var_.characterEffect1070ui_story then
				arg_226_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_2")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_229_4 = 0
			local var_229_5 = 0.475

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_6 = arg_226_1:GetWordFromCfg(324121054)
				local var_229_7 = arg_226_1:FormatText(var_229_6.content)

				arg_226_1.text_.text = var_229_7

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_9 = 19 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 19)

				if (19 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_7) / 19)) > 0 and var_229_5 < var_229_9 then
					arg_226_1.talkMaxDuration = var_229_9

					if var_229_9 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_9 + var_229_4
					end
				end

				arg_226_1.text_.text = var_229_7
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121054", "story_v_out_324121.awb") ~= 0 then
					local var_229_10 = manager.audio:GetVoiceLength("story_v_out_324121", "324121054", "story_v_out_324121.awb") / 1000

					if var_229_10 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_10 + var_229_4
					end

					if var_229_6.prefab_name ~= "" and arg_226_1.actors_[var_229_6.prefab_name] ~= nil then
						local var_229_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_6.prefab_name].transform, "story_v_out_324121", "324121054", "story_v_out_324121.awb")

						arg_226_1:RecordAudio("324121054", var_229_11)
						arg_226_1:RecordAudio("324121054", var_229_11)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_324121", "324121054", "story_v_out_324121.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_324121", "324121054", "story_v_out_324121.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_12 = math.max(var_229_5, arg_226_1.talkMaxDuration)

			if var_229_4 <= arg_226_1.time_ and arg_226_1.time_ < var_229_4 + var_229_12 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_4) / var_229_12

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_4 + var_229_12 and arg_226_1.time_ < var_229_4 + var_229_12 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
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

		arg_226_1:InitPlayNodeList()
	end,
	Play324121055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 324121055
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play324121056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1070ui_story"]) and arg_230_1.var_.characterEffect1070ui_story == nil then
				arg_230_1.var_.characterEffect1070ui_story = arg_230_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1070ui_story"]) then
				if arg_230_1.var_.characterEffect1070ui_story and not isNil(arg_230_1.actors_["1070ui_story"]) then
					arg_230_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_0)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1070ui_story"]) and arg_230_1.var_.characterEffect1070ui_story then
				arg_230_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_233_1 = 0
			local var_233_2 = 1.025

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
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

				local var_233_3 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(324121055).content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 41 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 41)

				if (41 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 41)) > 0 and var_233_2 < var_233_5 then
					arg_230_1.talkMaxDuration = var_233_5

					if var_233_5 + var_233_1 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + var_233_1
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_6 = math.max(var_233_2, arg_230_1.talkMaxDuration)

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_6 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_1) / var_233_6

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_1 + var_233_6 and arg_230_1.time_ < var_233_1 + var_233_6 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play324121056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 324121056
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play324121057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 1.1

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_1 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(324121056).content)

				arg_234_1.text_.text = var_237_1

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_3 = 44 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 44)

				if (44 <= 0 and var_237_0 or var_237_0 * (utf8.len(var_237_1) / 44)) > 0 and var_237_0 < var_237_3 then
					arg_234_1.talkMaxDuration = var_237_3

					if var_237_3 + 0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_3 + 0
					end
				end

				arg_234_1.text_.text = var_237_1
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_4 = math.max(var_237_0, arg_234_1.talkMaxDuration)

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - 0) / var_237_4

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play324121057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 324121057
		arg_238_1.duration_ = 10.7

		local var_238_0 = {
			zh = 9.433,
			ja = 10.7
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play324121058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1070ui_story"]) and arg_238_1.var_.characterEffect1070ui_story == nil then
				arg_238_1.var_.characterEffect1070ui_story = arg_238_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1070ui_story"]) then
				if arg_238_1.var_.characterEffect1070ui_story and not isNil(arg_238_1.actors_["1070ui_story"]) then
					arg_238_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1070ui_story"]) and arg_238_1.var_.characterEffect1070ui_story then
				arg_238_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_241_2 = 0
			local var_241_3 = 0.825

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_4 = arg_238_1:GetWordFromCfg(324121057)
				local var_241_5 = arg_238_1:FormatText(var_241_4.content)

				arg_238_1.text_.text = var_241_5

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_7 = 33 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 33)

				if (33 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_5) / 33)) > 0 and var_241_3 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_2
					end
				end

				arg_238_1.text_.text = var_241_5
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121057", "story_v_out_324121.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121057", "story_v_out_324121.awb") / 1000

					if var_241_8 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_2
					end

					if var_241_4.prefab_name ~= "" and arg_238_1.actors_[var_241_4.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_4.prefab_name].transform, "story_v_out_324121", "324121057", "story_v_out_324121.awb")

						arg_238_1:RecordAudio("324121057", var_241_9)
						arg_238_1:RecordAudio("324121057", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_324121", "324121057", "story_v_out_324121.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_324121", "324121057", "story_v_out_324121.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_3, arg_238_1.talkMaxDuration)

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_2) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_2 + var_241_10 and arg_238_1.time_ < var_241_2 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play324121058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 324121058
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play324121059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1070ui_story"]) and arg_242_1.var_.characterEffect1070ui_story == nil then
				arg_242_1.var_.characterEffect1070ui_story = arg_242_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_0 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1070ui_story"]) then
				if arg_242_1.var_.characterEffect1070ui_story and not isNil(arg_242_1.actors_["1070ui_story"]) then
					arg_242_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_0)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1070ui_story"]) and arg_242_1.var_.characterEffect1070ui_story then
				arg_242_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_245_1 = 0
			local var_245_2 = 0.925

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, true)
				arg_242_1.iconController_:SetSelectedState("hero")

				arg_242_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_242_1.callingController_:SetSelectedState("normal")

				arg_242_1.keyicon_.color = Color.New(1, 1, 1)
				arg_242_1.icon_.color = Color.New(1, 1, 1)

				local var_245_3 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(324121058).content)

				arg_242_1.text_.text = var_245_3

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_5 = 37 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 37)

				if (37 <= 0 and var_245_2 or var_245_2 * (utf8.len(var_245_3) / 37)) > 0 and var_245_2 < var_245_5 then
					arg_242_1.talkMaxDuration = var_245_5

					if var_245_5 + var_245_1 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + var_245_1
					end
				end

				arg_242_1.text_.text = var_245_3
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_6 = math.max(var_245_2, arg_242_1.talkMaxDuration)

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_6 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_1) / var_245_6

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_1 + var_245_6 and arg_242_1.time_ < var_245_1 + var_245_6 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play324121059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 324121059
		arg_246_1.duration_ = 7.47

		local var_246_0 = {
			zh = 6.366,
			ja = 7.466
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play324121060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1070ui_story"]) and arg_246_1.var_.characterEffect1070ui_story == nil then
				arg_246_1.var_.characterEffect1070ui_story = arg_246_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1070ui_story"]) then
				if arg_246_1.var_.characterEffect1070ui_story and not isNil(arg_246_1.actors_["1070ui_story"]) then
					arg_246_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1070ui_story"]) and arg_246_1.var_.characterEffect1070ui_story then
				arg_246_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_249_2 = 0
			local var_249_3 = 0.425

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_2 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_4 = arg_246_1:GetWordFromCfg(324121059)
				local var_249_5 = arg_246_1:FormatText(var_249_4.content)

				arg_246_1.text_.text = var_249_5

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_7 = 17 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_5) / 17)

				if (17 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_5) / 17)) > 0 and var_249_3 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_2
					end
				end

				arg_246_1.text_.text = var_249_5
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121059", "story_v_out_324121.awb") ~= 0 then
					local var_249_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121059", "story_v_out_324121.awb") / 1000

					if var_249_8 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_8 + var_249_2
					end

					if var_249_4.prefab_name ~= "" and arg_246_1.actors_[var_249_4.prefab_name] ~= nil then
						local var_249_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_4.prefab_name].transform, "story_v_out_324121", "324121059", "story_v_out_324121.awb")

						arg_246_1:RecordAudio("324121059", var_249_9)
						arg_246_1:RecordAudio("324121059", var_249_9)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_324121", "324121059", "story_v_out_324121.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_324121", "324121059", "story_v_out_324121.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_10 = math.max(var_249_3, arg_246_1.talkMaxDuration)

			if var_249_2 <= arg_246_1.time_ and arg_246_1.time_ < var_249_2 + var_249_10 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_2) / var_249_10

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_2 + var_249_10 and arg_246_1.time_ < var_249_2 + var_249_10 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play324121060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 324121060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play324121061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1070ui_story = arg_250_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_253_0 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 then
				arg_250_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 0) / var_253_0)
				arg_250_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1070ui_story"].transform.position).z)
				arg_250_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1070ui_story"].transform.localEulerAngles = arg_250_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 then
				arg_250_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1070ui_story"].transform.position).z)
				arg_250_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1070ui_story"].transform.localEulerAngles = arg_250_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_253_1 = arg_250_1.actors_["1070ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1070ui_story == nil then
				arg_250_1.var_.characterEffect1070ui_story = var_253_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_2 and not isNil(var_253_1) then
				if arg_250_1.var_.characterEffect1070ui_story and not isNil(var_253_1) then
					arg_250_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_2)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_2 and arg_250_1.time_ < 0 + var_253_2 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1070ui_story then
				arg_250_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_250_1.time_ and arg_250_1.time_ <= 0.1 + arg_253_0 then
				arg_250_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_253_4 = 0
			local var_253_5 = 0.75

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_6 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(324121060).content)

				arg_250_1.text_.text = var_253_6

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_8 = 30 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_6) / 30)

				if (30 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_6) / 30)) > 0 and var_253_5 < var_253_8 then
					arg_250_1.talkMaxDuration = var_253_8

					if var_253_8 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_8 + var_253_4
					end
				end

				arg_250_1.text_.text = var_253_6
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_9 = math.max(var_253_5, arg_250_1.talkMaxDuration)

			if var_253_4 <= arg_250_1.time_ and arg_250_1.time_ < var_253_4 + var_253_9 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_4) / var_253_9

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_4 + var_253_9 and arg_250_1.time_ < var_253_4 + var_253_9 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
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

		arg_250_1:InitPlayNodeList()
	end,
	Play324121061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 324121061
		arg_254_1.duration_ = 2.8

		local var_254_0 = {
			zh = 2.5,
			ja = 2.8
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play324121062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1070ui_story = arg_254_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_257_0 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 then
				arg_254_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_254_1.time_ - 0) / var_257_0)
				arg_254_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1070ui_story"].transform.position).z)
				arg_254_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1070ui_story"].transform.localEulerAngles = arg_254_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 then
				arg_254_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_254_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1070ui_story"].transform.position).z)
				arg_254_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1070ui_story"].transform.localEulerAngles = arg_254_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_257_1 = arg_254_1.actors_["1070ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect1070ui_story == nil then
				arg_254_1.var_.characterEffect1070ui_story = var_257_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_2 and not isNil(var_257_1) then
				if arg_254_1.var_.characterEffect1070ui_story and not isNil(var_257_1) then
					arg_254_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_2 and arg_254_1.time_ < 0 + var_257_2 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect1070ui_story then
				arg_254_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_257_4 = 0
			local var_257_5 = 0.175

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_6 = arg_254_1:GetWordFromCfg(324121061)
				local var_257_7 = arg_254_1:FormatText(var_257_6.content)

				arg_254_1.text_.text = var_257_7

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_9 = 7 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 7)

				if (7 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_7) / 7)) > 0 and var_257_5 < var_257_9 then
					arg_254_1.talkMaxDuration = var_257_9

					if var_257_9 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_9 + var_257_4
					end
				end

				arg_254_1.text_.text = var_257_7
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121061", "story_v_out_324121.awb") ~= 0 then
					local var_257_10 = manager.audio:GetVoiceLength("story_v_out_324121", "324121061", "story_v_out_324121.awb") / 1000

					if var_257_10 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_10 + var_257_4
					end

					if var_257_6.prefab_name ~= "" and arg_254_1.actors_[var_257_6.prefab_name] ~= nil then
						local var_257_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_6.prefab_name].transform, "story_v_out_324121", "324121061", "story_v_out_324121.awb")

						arg_254_1:RecordAudio("324121061", var_257_11)
						arg_254_1:RecordAudio("324121061", var_257_11)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_324121", "324121061", "story_v_out_324121.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_324121", "324121061", "story_v_out_324121.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_12 = math.max(var_257_5, arg_254_1.talkMaxDuration)

			if var_257_4 <= arg_254_1.time_ and arg_254_1.time_ < var_257_4 + var_257_12 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_4) / var_257_12

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_4 + var_257_12 and arg_254_1.time_ < var_257_4 + var_257_12 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
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

		arg_254_1:InitPlayNodeList()
	end,
	Play324121062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 324121062
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play324121063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1070ui_story"]) and arg_258_1.var_.characterEffect1070ui_story == nil then
				arg_258_1.var_.characterEffect1070ui_story = arg_258_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1070ui_story"]) then
				if arg_258_1.var_.characterEffect1070ui_story and not isNil(arg_258_1.actors_["1070ui_story"]) then
					arg_258_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_0)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1070ui_story"]) and arg_258_1.var_.characterEffect1070ui_story then
				arg_258_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_261_1 = 0
			local var_261_2 = 1.55

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
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

				local var_261_3 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(324121062).content)

				arg_258_1.text_.text = var_261_3

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 62 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 62)

				if (62 <= 0 and var_261_2 or var_261_2 * (utf8.len(var_261_3) / 62)) > 0 and var_261_2 < var_261_5 then
					arg_258_1.talkMaxDuration = var_261_5

					if var_261_5 + var_261_1 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + var_261_1
					end
				end

				arg_258_1.text_.text = var_261_3
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_6 = math.max(var_261_2, arg_258_1.talkMaxDuration)

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_6 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_1) / var_261_6

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_1 + var_261_6 and arg_258_1.time_ < var_261_1 + var_261_6 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play324121063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 324121063
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play324121064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 1.5

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_1 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(324121063).content)

				arg_262_1.text_.text = var_265_1

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_3 = 60 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 60)

				if (60 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 60)) > 0 and var_265_0 < var_265_3 then
					arg_262_1.talkMaxDuration = var_265_3

					if var_265_3 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_3 + 0
					end
				end

				arg_262_1.text_.text = var_265_1
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_4 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_4

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play324121064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 324121064
		arg_266_1.duration_ = 6.97

		local var_266_0 = {
			zh = 4.833,
			ja = 6.966
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play324121065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["1070ui_story"]) and arg_266_1.var_.characterEffect1070ui_story == nil then
				arg_266_1.var_.characterEffect1070ui_story = arg_266_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["1070ui_story"]) then
				if arg_266_1.var_.characterEffect1070ui_story and not isNil(arg_266_1.actors_["1070ui_story"]) then
					arg_266_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["1070ui_story"]) and arg_266_1.var_.characterEffect1070ui_story then
				arg_266_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_269_2 = 0
			local var_269_3 = 0.55

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_2 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_4 = arg_266_1:GetWordFromCfg(324121064)
				local var_269_5 = arg_266_1:FormatText(var_269_4.content)

				arg_266_1.text_.text = var_269_5

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_7 = 22 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_5) / 22)

				if (22 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_5) / 22)) > 0 and var_269_3 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_2
					end
				end

				arg_266_1.text_.text = var_269_5
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121064", "story_v_out_324121.awb") ~= 0 then
					local var_269_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121064", "story_v_out_324121.awb") / 1000

					if var_269_8 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_2
					end

					if var_269_4.prefab_name ~= "" and arg_266_1.actors_[var_269_4.prefab_name] ~= nil then
						local var_269_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_4.prefab_name].transform, "story_v_out_324121", "324121064", "story_v_out_324121.awb")

						arg_266_1:RecordAudio("324121064", var_269_9)
						arg_266_1:RecordAudio("324121064", var_269_9)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_324121", "324121064", "story_v_out_324121.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_324121", "324121064", "story_v_out_324121.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_3, arg_266_1.talkMaxDuration)

			if var_269_2 <= arg_266_1.time_ and arg_266_1.time_ < var_269_2 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_2) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_2 + var_269_10 and arg_266_1.time_ < var_269_2 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play324121065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 324121065
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play324121066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1070ui_story"]) and arg_270_1.var_.characterEffect1070ui_story == nil then
				arg_270_1.var_.characterEffect1070ui_story = arg_270_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1070ui_story"]) then
				if arg_270_1.var_.characterEffect1070ui_story and not isNil(arg_270_1.actors_["1070ui_story"]) then
					arg_270_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_0)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1070ui_story"]) and arg_270_1.var_.characterEffect1070ui_story then
				arg_270_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_273_1 = 0
			local var_273_2 = 0.9

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
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

				local var_273_3 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(324121065).content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 36 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 36)

				if (36 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 36)) > 0 and var_273_2 < var_273_5 then
					arg_270_1.talkMaxDuration = var_273_5

					if var_273_5 + var_273_1 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + var_273_1
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_6 = math.max(var_273_2, arg_270_1.talkMaxDuration)

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_6 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_1) / var_273_6

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_1 + var_273_6 and arg_270_1.time_ < var_273_1 + var_273_6 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play324121066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 324121066
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play324121067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1070ui_story = arg_274_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_277_0 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 then
				arg_274_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0) / var_277_0)
				arg_274_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1070ui_story"].transform.position).z)
				arg_274_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1070ui_story"].transform.localEulerAngles = arg_274_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 then
				arg_274_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1070ui_story"].transform.position).z)
				arg_274_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1070ui_story"].transform.localEulerAngles = arg_274_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if 2 < arg_274_1.time_ and arg_274_1.time_ <= 2 + arg_277_0 then
				arg_274_1:AudioAction("play", "effect", "se_story_148", "se_story_148_footstep_snow04", "")
			end

			local var_277_2 = 0
			local var_277_3 = 1.475

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_4 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(324121066).content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_6 = 59 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_4) / 59)

				if (59 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_4) / 59)) > 0 and var_277_3 < var_277_6 then
					arg_274_1.talkMaxDuration = var_277_6

					if var_277_6 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_6 + var_277_2
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_3, arg_274_1.talkMaxDuration)

			if var_277_2 <= arg_274_1.time_ and arg_274_1.time_ < var_277_2 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_2) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_2 + var_277_7 and arg_274_1.time_ < var_277_2 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
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

		arg_274_1:InitPlayNodeList()
	end,
	Play324121067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 324121067
		arg_278_1.duration_ = 8.33

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play324121068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 2 < arg_278_1.time_ and arg_278_1.time_ <= 2 + arg_281_0 then
				local var_281_0 = arg_278_1.bgs_.ST2005

				arg_278_1.bgs_.ST2005.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_281_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_1 = var_281_0:GetComponent("SpriteRenderer")

				if var_281_1 and var_281_1.sprite then
					local var_281_2 = 2 * (var_281_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_281_0.transform.localScale = Vector3.New(var_281_2 / var_281_1.sprite.bounds.size.y < var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x and var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x or var_281_2 / var_281_1.sprite.bounds.size.y, var_281_2 / var_281_1.sprite.bounds.size.y < var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x and var_281_2 * manager.ui.mainCameraCom_.aspect / var_281_1.sprite.bounds.size.x or var_281_2 / var_281_1.sprite.bounds.size.y, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "ST2005" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_281_3 = 0

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_3 + arg_281_0 then
				arg_278_1.allBtn_.enabled = false
			end

			if arg_278_1.time_ >= var_281_3 + 0.3 and arg_278_1.time_ < var_281_3 + 0.3 + arg_281_0 then
				arg_278_1.allBtn_.enabled = true
			end

			local var_281_4 = 0

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_4 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_5 = 2

			if var_281_4 <= arg_278_1.time_ and arg_278_1.time_ < var_281_4 + var_281_5 then
				local var_281_6 = Color.New(0, 0, 0)

				var_281_6.a = Mathf.Lerp(0, 1, (arg_278_1.time_ - var_281_4) / var_281_5)
				arg_278_1.mask_.color = var_281_6
			end

			if arg_278_1.time_ >= var_281_4 + var_281_5 and arg_278_1.time_ < var_281_4 + var_281_5 + arg_281_0 then
				local var_281_7 = Color.New(0, 0, 0)

				var_281_7.a = 1
				arg_278_1.mask_.color = var_281_7
			end

			local var_281_8 = 2

			if 2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_8 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_9 = 2

			if var_281_8 <= arg_278_1.time_ and arg_278_1.time_ < var_281_8 + var_281_9 then
				local var_281_10 = Color.New(0, 0, 0)

				var_281_10.a = Mathf.Lerp(1, 0, (arg_278_1.time_ - var_281_8) / var_281_9)
				arg_278_1.mask_.color = var_281_10
			end

			if arg_278_1.time_ >= var_281_8 + var_281_9 and arg_278_1.time_ < var_281_8 + var_281_9 + arg_281_0 then
				local var_281_11 = Color.New(0, 0, 0)

				arg_278_1.mask_.enabled = false
				var_281_11.a = 0
				arg_278_1.mask_.color = var_281_11
			end

			if arg_278_1.frameCnt_ <= 1 then
				arg_278_1.dialog_:SetActive(false)
			end

			local var_281_12 = 3.33333333333333
			local var_281_13 = 1.15

			if 3.33333333333333 < arg_278_1.time_ and arg_278_1.time_ <= var_281_12 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0

				arg_278_1.dialog_:SetActive(true)

				arg_278_1.dialogCg_.alpha = 0

				local var_281_14 = LeanTween.value(arg_278_1.dialog_, 0, 1, 0.3)

				var_281_14:setOnUpdate(LuaHelper.FloatAction(function(arg_282_0)
					arg_278_1.dialogCg_.alpha = arg_282_0
				end))
				var_281_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_278_1.dialog_)
					var_281_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_278_1.duration_ = arg_278_1.duration_ + 0.3

				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_15 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(324121067).content)

				arg_278_1.text_.text = var_281_15

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_17 = 46 <= 0 and var_281_13 or var_281_13 * (utf8.len(var_281_15) / 46)

				if (46 <= 0 and var_281_13 or var_281_13 * (utf8.len(var_281_15) / 46)) > 0 and var_281_13 < var_281_17 then
					arg_278_1.talkMaxDuration = var_281_17
					var_281_12 = var_281_12 + 0.3

					if var_281_17 + var_281_12 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_17 + var_281_12
					end
				end

				arg_278_1.text_.text = var_281_15
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_18 = var_281_12 + 0.3
			local var_281_19 = math.max(var_281_13, arg_278_1.talkMaxDuration)

			if var_281_12 + 0.3 <= arg_278_1.time_ and arg_278_1.time_ < var_281_18 + var_281_19 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_18) / var_281_19

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_18 + var_281_19 and arg_278_1.time_ < var_281_18 + var_281_19 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play324121068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 324121068
		arg_284_1.duration_ = 3.33

		local var_284_0 = {
			zh = 2.066,
			ja = 3.333
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play324121069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.15

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_1 = arg_284_1:GetWordFromCfg(324121068)
				local var_287_2 = arg_284_1:FormatText(var_287_1.content)

				arg_284_1.text_.text = var_287_2

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 6 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 6)

				if (6 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 6)) > 0 and var_287_0 < var_287_4 then
					arg_284_1.talkMaxDuration = var_287_4

					if var_287_4 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_4 + 0
					end
				end

				arg_284_1.text_.text = var_287_2
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121068", "story_v_out_324121.awb") ~= 0 then
					local var_287_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121068", "story_v_out_324121.awb") / 1000

					if var_287_5 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + 0
					end

					if var_287_1.prefab_name ~= "" and arg_284_1.actors_[var_287_1.prefab_name] ~= nil then
						local var_287_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_1.prefab_name].transform, "story_v_out_324121", "324121068", "story_v_out_324121.awb")

						arg_284_1:RecordAudio("324121068", var_287_6)
						arg_284_1:RecordAudio("324121068", var_287_6)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_324121", "324121068", "story_v_out_324121.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_324121", "324121068", "story_v_out_324121.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_7 and arg_284_1.time_ < 0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play324121069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 324121069
		arg_288_1.duration_ = 13.9

		local var_288_0 = {
			zh = 8.466,
			ja = 13.9
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play324121070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos1070ui_story = arg_288_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_291_0 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 then
				arg_288_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_288_1.time_ - 0) / var_291_0)
				arg_288_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1070ui_story"].transform.position).z)
				arg_288_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1070ui_story"].transform.localEulerAngles = arg_288_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 then
				arg_288_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_288_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1070ui_story"].transform.position).z)
				arg_288_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1070ui_story"].transform.localEulerAngles = arg_288_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_291_1 = arg_288_1.actors_["1070ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_1) and arg_288_1.var_.characterEffect1070ui_story == nil then
				arg_288_1.var_.characterEffect1070ui_story = var_291_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_2 and not isNil(var_291_1) then
				if arg_288_1.var_.characterEffect1070ui_story and not isNil(var_291_1) then
					arg_288_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_2 and arg_288_1.time_ < 0 + var_291_2 + arg_291_0 and not isNil(var_291_1) and arg_288_1.var_.characterEffect1070ui_story then
				arg_288_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_291_4 = 0
			local var_291_5 = 0.925

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_6 = arg_288_1:GetWordFromCfg(324121069)
				local var_291_7 = arg_288_1:FormatText(var_291_6.content)

				arg_288_1.text_.text = var_291_7

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_9 = 37 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 37)

				if (37 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 37)) > 0 and var_291_5 < var_291_9 then
					arg_288_1.talkMaxDuration = var_291_9

					if var_291_9 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_9 + var_291_4
					end
				end

				arg_288_1.text_.text = var_291_7
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121069", "story_v_out_324121.awb") ~= 0 then
					local var_291_10 = manager.audio:GetVoiceLength("story_v_out_324121", "324121069", "story_v_out_324121.awb") / 1000

					if var_291_10 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_10 + var_291_4
					end

					if var_291_6.prefab_name ~= "" and arg_288_1.actors_[var_291_6.prefab_name] ~= nil then
						local var_291_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_6.prefab_name].transform, "story_v_out_324121", "324121069", "story_v_out_324121.awb")

						arg_288_1:RecordAudio("324121069", var_291_11)
						arg_288_1:RecordAudio("324121069", var_291_11)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_324121", "324121069", "story_v_out_324121.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_324121", "324121069", "story_v_out_324121.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_12 = math.max(var_291_5, arg_288_1.talkMaxDuration)

			if var_291_4 <= arg_288_1.time_ and arg_288_1.time_ < var_291_4 + var_291_12 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_4) / var_291_12

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_4 + var_291_12 and arg_288_1.time_ < var_291_4 + var_291_12 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
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

		arg_288_1:InitPlayNodeList()
	end,
	Play324121070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 324121070
		arg_292_1.duration_ = 18.6

		local var_292_0 = {
			zh = 11.366,
			ja = 18.6
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play324121071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1070ui_story"]) and arg_292_1.var_.characterEffect1070ui_story == nil then
				arg_292_1.var_.characterEffect1070ui_story = arg_292_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_0 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1070ui_story"]) then
				if arg_292_1.var_.characterEffect1070ui_story and not isNil(arg_292_1.actors_["1070ui_story"]) then
					arg_292_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_0)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1070ui_story"]) and arg_292_1.var_.characterEffect1070ui_story then
				arg_292_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_295_1 = 0
			local var_295_2 = 1.25

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, true)
				arg_292_1.iconController_:SetSelectedState("hero")

				arg_292_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_292_1.callingController_:SetSelectedState("normal")

				arg_292_1.keyicon_.color = Color.New(1, 1, 1)
				arg_292_1.icon_.color = Color.New(1, 1, 1)

				local var_295_3 = arg_292_1:GetWordFromCfg(324121070)
				local var_295_4 = arg_292_1:FormatText(var_295_3.content)

				arg_292_1.text_.text = var_295_4

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_6 = 50 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_4) / 50)

				if (50 <= 0 and var_295_2 or var_295_2 * (utf8.len(var_295_4) / 50)) > 0 and var_295_2 < var_295_6 then
					arg_292_1.talkMaxDuration = var_295_6

					if var_295_6 + var_295_1 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_6 + var_295_1
					end
				end

				arg_292_1.text_.text = var_295_4
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121070", "story_v_out_324121.awb") ~= 0 then
					local var_295_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121070", "story_v_out_324121.awb") / 1000

					if var_295_7 + var_295_1 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_7 + var_295_1
					end

					if var_295_3.prefab_name ~= "" and arg_292_1.actors_[var_295_3.prefab_name] ~= nil then
						local var_295_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_3.prefab_name].transform, "story_v_out_324121", "324121070", "story_v_out_324121.awb")

						arg_292_1:RecordAudio("324121070", var_295_8)
						arg_292_1:RecordAudio("324121070", var_295_8)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_324121", "324121070", "story_v_out_324121.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_324121", "324121070", "story_v_out_324121.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_9 = math.max(var_295_2, arg_292_1.talkMaxDuration)

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_9 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_1) / var_295_9

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_1 + var_295_9 and arg_292_1.time_ < var_295_1 + var_295_9 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play324121071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 324121071
		arg_296_1.duration_ = 2.5

		local var_296_0 = {
			zh = 2.5,
			ja = 1.999999999999
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play324121072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["1070ui_story"]) and arg_296_1.var_.characterEffect1070ui_story == nil then
				arg_296_1.var_.characterEffect1070ui_story = arg_296_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_0 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["1070ui_story"]) then
				if arg_296_1.var_.characterEffect1070ui_story and not isNil(arg_296_1.actors_["1070ui_story"]) then
					arg_296_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["1070ui_story"]) and arg_296_1.var_.characterEffect1070ui_story then
				arg_296_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_299_2 = 0
			local var_299_3 = 0.15

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_2 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_4 = arg_296_1:GetWordFromCfg(324121071)
				local var_299_5 = arg_296_1:FormatText(var_299_4.content)

				arg_296_1.text_.text = var_299_5

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_7 = 6 <= 0 and var_299_3 or var_299_3 * (utf8.len(var_299_5) / 6)

				if (6 <= 0 and var_299_3 or var_299_3 * (utf8.len(var_299_5) / 6)) > 0 and var_299_3 < var_299_7 then
					arg_296_1.talkMaxDuration = var_299_7

					if var_299_7 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_7 + var_299_2
					end
				end

				arg_296_1.text_.text = var_299_5
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121071", "story_v_out_324121.awb") ~= 0 then
					local var_299_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121071", "story_v_out_324121.awb") / 1000

					if var_299_8 + var_299_2 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_8 + var_299_2
					end

					if var_299_4.prefab_name ~= "" and arg_296_1.actors_[var_299_4.prefab_name] ~= nil then
						local var_299_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_4.prefab_name].transform, "story_v_out_324121", "324121071", "story_v_out_324121.awb")

						arg_296_1:RecordAudio("324121071", var_299_9)
						arg_296_1:RecordAudio("324121071", var_299_9)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_324121", "324121071", "story_v_out_324121.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_324121", "324121071", "story_v_out_324121.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_10 = math.max(var_299_3, arg_296_1.talkMaxDuration)

			if var_299_2 <= arg_296_1.time_ and arg_296_1.time_ < var_299_2 + var_299_10 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_2) / var_299_10

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_2 + var_299_10 and arg_296_1.time_ < var_299_2 + var_299_10 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play324121072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 324121072
		arg_300_1.duration_ = 13.53

		local var_300_0 = {
			zh = 9.6,
			ja = 13.533
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play324121073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["1070ui_story"]) and arg_300_1.var_.characterEffect1070ui_story == nil then
				arg_300_1.var_.characterEffect1070ui_story = arg_300_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_0 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["1070ui_story"]) then
				if arg_300_1.var_.characterEffect1070ui_story and not isNil(arg_300_1.actors_["1070ui_story"]) then
					arg_300_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_300_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_0)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["1070ui_story"]) and arg_300_1.var_.characterEffect1070ui_story then
				arg_300_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_300_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_303_1 = 0
			local var_303_2 = 0.9

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:GetWordFromCfg(324121072)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_6 = 36 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_4) / 36)

				if (36 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_4) / 36)) > 0 and var_303_2 < var_303_6 then
					arg_300_1.talkMaxDuration = var_303_6

					if var_303_6 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_1
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121072", "story_v_out_324121.awb") ~= 0 then
					local var_303_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121072", "story_v_out_324121.awb") / 1000

					if var_303_7 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_1
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_out_324121", "324121072", "story_v_out_324121.awb")

						arg_300_1:RecordAudio("324121072", var_303_8)
						arg_300_1:RecordAudio("324121072", var_303_8)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_324121", "324121072", "story_v_out_324121.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_324121", "324121072", "story_v_out_324121.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_9 = math.max(var_303_2, arg_300_1.talkMaxDuration)

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_9 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_1) / var_303_9

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_1 + var_303_9 and arg_300_1.time_ < var_303_1 + var_303_9 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play324121073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 324121073
		arg_304_1.duration_ = 20.1

		local var_304_0 = {
			zh = 14.133,
			ja = 20.1
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play324121074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 1.35

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_1 = arg_304_1:GetWordFromCfg(324121073)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 54 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 54)

				if (54 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 54)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121073", "story_v_out_324121.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121073", "story_v_out_324121.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_out_324121", "324121073", "story_v_out_324121.awb")

						arg_304_1:RecordAudio("324121073", var_307_6)
						arg_304_1:RecordAudio("324121073", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_324121", "324121073", "story_v_out_324121.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_324121", "324121073", "story_v_out_324121.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_7 and arg_304_1.time_ < 0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play324121074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 324121074
		arg_308_1.duration_ = 13.07

		local var_308_0 = {
			zh = 9.133,
			ja = 13.066
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play324121075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0.875

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_1 = arg_308_1:GetWordFromCfg(324121074)
				local var_311_2 = arg_308_1:FormatText(var_311_1.content)

				arg_308_1.text_.text = var_311_2

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 35 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_2) / 35)

				if (35 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_2) / 35)) > 0 and var_311_0 < var_311_4 then
					arg_308_1.talkMaxDuration = var_311_4

					if var_311_4 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_4 + 0
					end
				end

				arg_308_1.text_.text = var_311_2
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121074", "story_v_out_324121.awb") ~= 0 then
					local var_311_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121074", "story_v_out_324121.awb") / 1000

					if var_311_5 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + 0
					end

					if var_311_1.prefab_name ~= "" and arg_308_1.actors_[var_311_1.prefab_name] ~= nil then
						local var_311_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_1.prefab_name].transform, "story_v_out_324121", "324121074", "story_v_out_324121.awb")

						arg_308_1:RecordAudio("324121074", var_311_6)
						arg_308_1:RecordAudio("324121074", var_311_6)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_324121", "324121074", "story_v_out_324121.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_324121", "324121074", "story_v_out_324121.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_7 and arg_308_1.time_ < 0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play324121075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 324121075
		arg_312_1.duration_ = 18.33

		local var_312_0 = {
			zh = 15.733,
			ja = 18.333
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play324121076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 1.6

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_1 = arg_312_1:GetWordFromCfg(324121075)
				local var_315_2 = arg_312_1:FormatText(var_315_1.content)

				arg_312_1.text_.text = var_315_2

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_4 = 64 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 64)

				if (64 <= 0 and var_315_0 or var_315_0 * (utf8.len(var_315_2) / 64)) > 0 and var_315_0 < var_315_4 then
					arg_312_1.talkMaxDuration = var_315_4

					if var_315_4 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_4 + 0
					end
				end

				arg_312_1.text_.text = var_315_2
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121075", "story_v_out_324121.awb") ~= 0 then
					local var_315_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121075", "story_v_out_324121.awb") / 1000

					if var_315_5 + 0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_5 + 0
					end

					if var_315_1.prefab_name ~= "" and arg_312_1.actors_[var_315_1.prefab_name] ~= nil then
						local var_315_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_1.prefab_name].transform, "story_v_out_324121", "324121075", "story_v_out_324121.awb")

						arg_312_1:RecordAudio("324121075", var_315_6)
						arg_312_1:RecordAudio("324121075", var_315_6)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_324121", "324121075", "story_v_out_324121.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_324121", "324121075", "story_v_out_324121.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_7 = math.max(var_315_0, arg_312_1.talkMaxDuration)

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_7 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - 0) / var_315_7

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= 0 + var_315_7 and arg_312_1.time_ < 0 + var_315_7 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play324121076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 324121076
		arg_316_1.duration_ = 3.03

		local var_316_0 = {
			zh = 2.7,
			ja = 3.033
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play324121077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["1070ui_story"]) and arg_316_1.var_.characterEffect1070ui_story == nil then
				arg_316_1.var_.characterEffect1070ui_story = arg_316_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_0 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["1070ui_story"]) then
				if arg_316_1.var_.characterEffect1070ui_story and not isNil(arg_316_1.actors_["1070ui_story"]) then
					arg_316_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["1070ui_story"]) and arg_316_1.var_.characterEffect1070ui_story then
				arg_316_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_319_2 = 0
			local var_319_3 = 0.35

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_2 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_4 = arg_316_1:GetWordFromCfg(324121076)
				local var_319_5 = arg_316_1:FormatText(var_319_4.content)

				arg_316_1.text_.text = var_319_5

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_7 = 14 <= 0 and var_319_3 or var_319_3 * (utf8.len(var_319_5) / 14)

				if (14 <= 0 and var_319_3 or var_319_3 * (utf8.len(var_319_5) / 14)) > 0 and var_319_3 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_2 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_2
					end
				end

				arg_316_1.text_.text = var_319_5
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121076", "story_v_out_324121.awb") ~= 0 then
					local var_319_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121076", "story_v_out_324121.awb") / 1000

					if var_319_8 + var_319_2 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_8 + var_319_2
					end

					if var_319_4.prefab_name ~= "" and arg_316_1.actors_[var_319_4.prefab_name] ~= nil then
						local var_319_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_4.prefab_name].transform, "story_v_out_324121", "324121076", "story_v_out_324121.awb")

						arg_316_1:RecordAudio("324121076", var_319_9)
						arg_316_1:RecordAudio("324121076", var_319_9)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_324121", "324121076", "story_v_out_324121.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_324121", "324121076", "story_v_out_324121.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_10 = math.max(var_319_3, arg_316_1.talkMaxDuration)

			if var_319_2 <= arg_316_1.time_ and arg_316_1.time_ < var_319_2 + var_319_10 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_2) / var_319_10

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_2 + var_319_10 and arg_316_1.time_ < var_319_2 + var_319_10 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play324121077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 324121077
		arg_320_1.duration_ = 11.17

		local var_320_0 = {
			zh = 7.5,
			ja = 11.166
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play324121078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(arg_320_1.actors_["1070ui_story"]) and arg_320_1.var_.characterEffect1070ui_story == nil then
				arg_320_1.var_.characterEffect1070ui_story = arg_320_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_0 = 0.200000002980232

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 and not isNil(arg_320_1.actors_["1070ui_story"]) then
				if arg_320_1.var_.characterEffect1070ui_story and not isNil(arg_320_1.actors_["1070ui_story"]) then
					arg_320_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_320_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_320_1.time_ - 0) / var_323_0)
				end
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 and not isNil(arg_320_1.actors_["1070ui_story"]) and arg_320_1.var_.characterEffect1070ui_story then
				arg_320_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_320_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_323_1 = 0
			local var_323_2 = 0.7

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_3 = arg_320_1:GetWordFromCfg(324121077)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_6 = 28 <= 0 and var_323_2 or var_323_2 * (utf8.len(var_323_4) / 28)

				if (28 <= 0 and var_323_2 or var_323_2 * (utf8.len(var_323_4) / 28)) > 0 and var_323_2 < var_323_6 then
					arg_320_1.talkMaxDuration = var_323_6

					if var_323_6 + var_323_1 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_6 + var_323_1
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121077", "story_v_out_324121.awb") ~= 0 then
					local var_323_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121077", "story_v_out_324121.awb") / 1000

					if var_323_7 + var_323_1 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_1
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_out_324121", "324121077", "story_v_out_324121.awb")

						arg_320_1:RecordAudio("324121077", var_323_8)
						arg_320_1:RecordAudio("324121077", var_323_8)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_324121", "324121077", "story_v_out_324121.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_324121", "324121077", "story_v_out_324121.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_9 = math.max(var_323_2, arg_320_1.talkMaxDuration)

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_9 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_1) / var_323_9

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_1 + var_323_9 and arg_320_1.time_ < var_323_1 + var_323_9 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play324121078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 324121078
		arg_324_1.duration_ = 19.47

		local var_324_0 = {
			zh = 13.533,
			ja = 19.466
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play324121079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 1.375

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_1 = arg_324_1:GetWordFromCfg(324121078)
				local var_327_2 = arg_324_1:FormatText(var_327_1.content)

				arg_324_1.text_.text = var_327_2

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 55 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 55)

				if (55 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_2) / 55)) > 0 and var_327_0 < var_327_4 then
					arg_324_1.talkMaxDuration = var_327_4

					if var_327_4 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_4 + 0
					end
				end

				arg_324_1.text_.text = var_327_2
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121078", "story_v_out_324121.awb") ~= 0 then
					local var_327_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121078", "story_v_out_324121.awb") / 1000

					if var_327_5 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_5 + 0
					end

					if var_327_1.prefab_name ~= "" and arg_324_1.actors_[var_327_1.prefab_name] ~= nil then
						local var_327_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_1.prefab_name].transform, "story_v_out_324121", "324121078", "story_v_out_324121.awb")

						arg_324_1:RecordAudio("324121078", var_327_6)
						arg_324_1:RecordAudio("324121078", var_327_6)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_324121", "324121078", "story_v_out_324121.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_324121", "324121078", "story_v_out_324121.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_7 and arg_324_1.time_ < 0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play324121079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 324121079
		arg_328_1.duration_ = 8.1

		local var_328_0 = {
			zh = 6.1,
			ja = 8.1
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play324121080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["1070ui_story"]) and arg_328_1.var_.characterEffect1070ui_story == nil then
				arg_328_1.var_.characterEffect1070ui_story = arg_328_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_0 = 0.200000002980232

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["1070ui_story"]) then
				if arg_328_1.var_.characterEffect1070ui_story and not isNil(arg_328_1.actors_["1070ui_story"]) then
					arg_328_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["1070ui_story"]) and arg_328_1.var_.characterEffect1070ui_story then
				arg_328_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_331_2 = 0
			local var_331_3 = 0.65

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_2 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_4 = arg_328_1:GetWordFromCfg(324121079)
				local var_331_5 = arg_328_1:FormatText(var_331_4.content)

				arg_328_1.text_.text = var_331_5

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_7 = 26 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_5) / 26)

				if (26 <= 0 and var_331_3 or var_331_3 * (utf8.len(var_331_5) / 26)) > 0 and var_331_3 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_2 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_2
					end
				end

				arg_328_1.text_.text = var_331_5
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121079", "story_v_out_324121.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121079", "story_v_out_324121.awb") / 1000

					if var_331_8 + var_331_2 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_2
					end

					if var_331_4.prefab_name ~= "" and arg_328_1.actors_[var_331_4.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_4.prefab_name].transform, "story_v_out_324121", "324121079", "story_v_out_324121.awb")

						arg_328_1:RecordAudio("324121079", var_331_9)
						arg_328_1:RecordAudio("324121079", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_324121", "324121079", "story_v_out_324121.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_324121", "324121079", "story_v_out_324121.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_3, arg_328_1.talkMaxDuration)

			if var_331_2 <= arg_328_1.time_ and arg_328_1.time_ < var_331_2 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_2) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_2 + var_331_10 and arg_328_1.time_ < var_331_2 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play324121080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 324121080
		arg_332_1.duration_ = 9.83

		local var_332_0 = {
			zh = 6.933,
			ja = 9.833
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play324121081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(arg_332_1.actors_["1070ui_story"]) and arg_332_1.var_.characterEffect1070ui_story == nil then
				arg_332_1.var_.characterEffect1070ui_story = arg_332_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_0 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 and not isNil(arg_332_1.actors_["1070ui_story"]) then
				if arg_332_1.var_.characterEffect1070ui_story and not isNil(arg_332_1.actors_["1070ui_story"]) then
					arg_332_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_332_1.time_ - 0) / var_335_0)
				end
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 and not isNil(arg_332_1.actors_["1070ui_story"]) and arg_332_1.var_.characterEffect1070ui_story then
				arg_332_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_335_1 = 0
			local var_335_2 = 0.625

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_3 = arg_332_1:GetWordFromCfg(324121080)
				local var_335_4 = arg_332_1:FormatText(var_335_3.content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_6 = 25 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_4) / 25)

				if (25 <= 0 and var_335_2 or var_335_2 * (utf8.len(var_335_4) / 25)) > 0 and var_335_2 < var_335_6 then
					arg_332_1.talkMaxDuration = var_335_6

					if var_335_6 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_6 + var_335_1
					end
				end

				arg_332_1.text_.text = var_335_4
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121080", "story_v_out_324121.awb") ~= 0 then
					local var_335_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121080", "story_v_out_324121.awb") / 1000

					if var_335_7 + var_335_1 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_1
					end

					if var_335_3.prefab_name ~= "" and arg_332_1.actors_[var_335_3.prefab_name] ~= nil then
						local var_335_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_3.prefab_name].transform, "story_v_out_324121", "324121080", "story_v_out_324121.awb")

						arg_332_1:RecordAudio("324121080", var_335_8)
						arg_332_1:RecordAudio("324121080", var_335_8)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_324121", "324121080", "story_v_out_324121.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_324121", "324121080", "story_v_out_324121.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_9 = math.max(var_335_2, arg_332_1.talkMaxDuration)

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_9 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_1) / var_335_9

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_1 + var_335_9 and arg_332_1.time_ < var_335_1 + var_335_9 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play324121081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 324121081
		arg_336_1.duration_ = 5.17

		local var_336_0 = {
			zh = 5.166,
			ja = 5
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play324121082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(arg_336_1.actors_["1070ui_story"]) and arg_336_1.var_.characterEffect1070ui_story == nil then
				arg_336_1.var_.characterEffect1070ui_story = arg_336_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_0 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 and not isNil(arg_336_1.actors_["1070ui_story"]) then
				if arg_336_1.var_.characterEffect1070ui_story and not isNil(arg_336_1.actors_["1070ui_story"]) then
					arg_336_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 and not isNil(arg_336_1.actors_["1070ui_story"]) and arg_336_1.var_.characterEffect1070ui_story then
				arg_336_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_339_2 = 0
			local var_339_3 = 0.425

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_2 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_4 = arg_336_1:GetWordFromCfg(324121081)
				local var_339_5 = arg_336_1:FormatText(var_339_4.content)

				arg_336_1.text_.text = var_339_5

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_7 = 17 <= 0 and var_339_3 or var_339_3 * (utf8.len(var_339_5) / 17)

				if (17 <= 0 and var_339_3 or var_339_3 * (utf8.len(var_339_5) / 17)) > 0 and var_339_3 < var_339_7 then
					arg_336_1.talkMaxDuration = var_339_7

					if var_339_7 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_2
					end
				end

				arg_336_1.text_.text = var_339_5
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121081", "story_v_out_324121.awb") ~= 0 then
					local var_339_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121081", "story_v_out_324121.awb") / 1000

					if var_339_8 + var_339_2 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_8 + var_339_2
					end

					if var_339_4.prefab_name ~= "" and arg_336_1.actors_[var_339_4.prefab_name] ~= nil then
						local var_339_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_4.prefab_name].transform, "story_v_out_324121", "324121081", "story_v_out_324121.awb")

						arg_336_1:RecordAudio("324121081", var_339_9)
						arg_336_1:RecordAudio("324121081", var_339_9)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_324121", "324121081", "story_v_out_324121.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_324121", "324121081", "story_v_out_324121.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_10 = math.max(var_339_3, arg_336_1.talkMaxDuration)

			if var_339_2 <= arg_336_1.time_ and arg_336_1.time_ < var_339_2 + var_339_10 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_2) / var_339_10

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_2 + var_339_10 and arg_336_1.time_ < var_339_2 + var_339_10 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play324121082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 324121082
		arg_340_1.duration_ = 2.4

		local var_340_0 = {
			zh = 1.833,
			ja = 2.4
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play324121083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["1070ui_story"]) and arg_340_1.var_.characterEffect1070ui_story == nil then
				arg_340_1.var_.characterEffect1070ui_story = arg_340_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_0 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["1070ui_story"]) then
				if arg_340_1.var_.characterEffect1070ui_story and not isNil(arg_340_1.actors_["1070ui_story"]) then
					arg_340_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_340_1.time_ - 0) / var_343_0)
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["1070ui_story"]) and arg_340_1.var_.characterEffect1070ui_story then
				arg_340_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_343_1 = 0
			local var_343_2 = 0.125

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_3 = arg_340_1:GetWordFromCfg(324121082)
				local var_343_4 = arg_340_1:FormatText(var_343_3.content)

				arg_340_1.text_.text = var_343_4

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_6 = 5 <= 0 and var_343_2 or var_343_2 * (utf8.len(var_343_4) / 5)

				if (5 <= 0 and var_343_2 or var_343_2 * (utf8.len(var_343_4) / 5)) > 0 and var_343_2 < var_343_6 then
					arg_340_1.talkMaxDuration = var_343_6

					if var_343_6 + var_343_1 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_6 + var_343_1
					end
				end

				arg_340_1.text_.text = var_343_4
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121082", "story_v_out_324121.awb") ~= 0 then
					local var_343_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121082", "story_v_out_324121.awb") / 1000

					if var_343_7 + var_343_1 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_1
					end

					if var_343_3.prefab_name ~= "" and arg_340_1.actors_[var_343_3.prefab_name] ~= nil then
						local var_343_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_3.prefab_name].transform, "story_v_out_324121", "324121082", "story_v_out_324121.awb")

						arg_340_1:RecordAudio("324121082", var_343_8)
						arg_340_1:RecordAudio("324121082", var_343_8)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_324121", "324121082", "story_v_out_324121.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_324121", "324121082", "story_v_out_324121.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_9 = math.max(var_343_2, arg_340_1.talkMaxDuration)

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_9 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_1) / var_343_9

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_1 + var_343_9 and arg_340_1.time_ < var_343_1 + var_343_9 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play324121083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 324121083
		arg_344_1.duration_ = 5.57

		local var_344_0 = {
			zh = 5.566,
			ja = 4.1
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play324121084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["1070ui_story"]) and arg_344_1.var_.characterEffect1070ui_story == nil then
				arg_344_1.var_.characterEffect1070ui_story = arg_344_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_0 = 0.200000002980232

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["1070ui_story"]) then
				if arg_344_1.var_.characterEffect1070ui_story and not isNil(arg_344_1.actors_["1070ui_story"]) then
					arg_344_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["1070ui_story"]) and arg_344_1.var_.characterEffect1070ui_story then
				arg_344_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_347_2 = 0
			local var_347_3 = 0.575

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_2 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_4 = arg_344_1:GetWordFromCfg(324121083)
				local var_347_5 = arg_344_1:FormatText(var_347_4.content)

				arg_344_1.text_.text = var_347_5

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_7 = 23 <= 0 and var_347_3 or var_347_3 * (utf8.len(var_347_5) / 23)

				if (23 <= 0 and var_347_3 or var_347_3 * (utf8.len(var_347_5) / 23)) > 0 and var_347_3 < var_347_7 then
					arg_344_1.talkMaxDuration = var_347_7

					if var_347_7 + var_347_2 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_7 + var_347_2
					end
				end

				arg_344_1.text_.text = var_347_5
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121083", "story_v_out_324121.awb") ~= 0 then
					local var_347_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121083", "story_v_out_324121.awb") / 1000

					if var_347_8 + var_347_2 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_2
					end

					if var_347_4.prefab_name ~= "" and arg_344_1.actors_[var_347_4.prefab_name] ~= nil then
						local var_347_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_4.prefab_name].transform, "story_v_out_324121", "324121083", "story_v_out_324121.awb")

						arg_344_1:RecordAudio("324121083", var_347_9)
						arg_344_1:RecordAudio("324121083", var_347_9)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_324121", "324121083", "story_v_out_324121.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_324121", "324121083", "story_v_out_324121.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_10 = math.max(var_347_3, arg_344_1.talkMaxDuration)

			if var_347_2 <= arg_344_1.time_ and arg_344_1.time_ < var_347_2 + var_347_10 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_2) / var_347_10

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_2 + var_347_10 and arg_344_1.time_ < var_347_2 + var_347_10 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play324121084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 324121084
		arg_348_1.duration_ = 5.5

		local var_348_0 = {
			zh = 5.5,
			ja = 5.233
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play324121085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action437")
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_351_0 = 0
			local var_351_1 = 0.675

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_2 = arg_348_1:GetWordFromCfg(324121084)
				local var_351_3 = arg_348_1:FormatText(var_351_2.content)

				arg_348_1.text_.text = var_351_3

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 27 <= 0 and var_351_1 or var_351_1 * (utf8.len(var_351_3) / 27)

				if (27 <= 0 and var_351_1 or var_351_1 * (utf8.len(var_351_3) / 27)) > 0 and var_351_1 < var_351_5 then
					arg_348_1.talkMaxDuration = var_351_5

					if var_351_5 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_3
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121084", "story_v_out_324121.awb") ~= 0 then
					local var_351_6 = manager.audio:GetVoiceLength("story_v_out_324121", "324121084", "story_v_out_324121.awb") / 1000

					if var_351_6 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_6 + var_351_0
					end

					if var_351_2.prefab_name ~= "" and arg_348_1.actors_[var_351_2.prefab_name] ~= nil then
						local var_351_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_2.prefab_name].transform, "story_v_out_324121", "324121084", "story_v_out_324121.awb")

						arg_348_1:RecordAudio("324121084", var_351_7)
						arg_348_1:RecordAudio("324121084", var_351_7)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_324121", "324121084", "story_v_out_324121.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_324121", "324121084", "story_v_out_324121.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_8 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_8 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_8

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_8 and arg_348_1.time_ < var_351_0 + var_351_8 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play324121085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 324121085
		arg_352_1.duration_ = 7

		local var_352_0 = {
			zh = 7,
			ja = 6.7
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play324121086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1070ui_story"]) and arg_352_1.var_.characterEffect1070ui_story == nil then
				arg_352_1.var_.characterEffect1070ui_story = arg_352_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1070ui_story"]) then
				if arg_352_1.var_.characterEffect1070ui_story and not isNil(arg_352_1.actors_["1070ui_story"]) then
					arg_352_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_0)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1070ui_story"]) and arg_352_1.var_.characterEffect1070ui_story then
				arg_352_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_355_1 = 0
			local var_355_2 = 0.75

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:GetWordFromCfg(324121085)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_6 = 30 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_4) / 30)

				if (30 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_4) / 30)) > 0 and var_355_2 < var_355_6 then
					arg_352_1.talkMaxDuration = var_355_6

					if var_355_6 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_6 + var_355_1
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121085", "story_v_out_324121.awb") ~= 0 then
					local var_355_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121085", "story_v_out_324121.awb") / 1000

					if var_355_7 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_1
					end

					if var_355_3.prefab_name ~= "" and arg_352_1.actors_[var_355_3.prefab_name] ~= nil then
						local var_355_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_3.prefab_name].transform, "story_v_out_324121", "324121085", "story_v_out_324121.awb")

						arg_352_1:RecordAudio("324121085", var_355_8)
						arg_352_1:RecordAudio("324121085", var_355_8)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_324121", "324121085", "story_v_out_324121.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_324121", "324121085", "story_v_out_324121.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_9 = math.max(var_355_2, arg_352_1.talkMaxDuration)

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_9 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_1) / var_355_9

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_1 + var_355_9 and arg_352_1.time_ < var_355_1 + var_355_9 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play324121086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 324121086
		arg_356_1.duration_ = 2.5

		local var_356_0 = {
			zh = 2.5,
			ja = 2.166
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play324121087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(arg_356_1.actors_["1070ui_story"]) and arg_356_1.var_.characterEffect1070ui_story == nil then
				arg_356_1.var_.characterEffect1070ui_story = arg_356_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_0 = 0.200000002980232

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 and not isNil(arg_356_1.actors_["1070ui_story"]) then
				if arg_356_1.var_.characterEffect1070ui_story and not isNil(arg_356_1.actors_["1070ui_story"]) then
					arg_356_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 and not isNil(arg_356_1.actors_["1070ui_story"]) and arg_356_1.var_.characterEffect1070ui_story then
				arg_356_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_359_2 = 0
			local var_359_3 = 0.225

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_2 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_4 = arg_356_1:GetWordFromCfg(324121086)
				local var_359_5 = arg_356_1:FormatText(var_359_4.content)

				arg_356_1.text_.text = var_359_5

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_7 = 9 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_5) / 9)

				if (9 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_5) / 9)) > 0 and var_359_3 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_2
					end
				end

				arg_356_1.text_.text = var_359_5
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121086", "story_v_out_324121.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121086", "story_v_out_324121.awb") / 1000

					if var_359_8 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_2
					end

					if var_359_4.prefab_name ~= "" and arg_356_1.actors_[var_359_4.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_4.prefab_name].transform, "story_v_out_324121", "324121086", "story_v_out_324121.awb")

						arg_356_1:RecordAudio("324121086", var_359_9)
						arg_356_1:RecordAudio("324121086", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_324121", "324121086", "story_v_out_324121.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_324121", "324121086", "story_v_out_324121.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_3, arg_356_1.talkMaxDuration)

			if var_359_2 <= arg_356_1.time_ and arg_356_1.time_ < var_359_2 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_2) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_2 + var_359_10 and arg_356_1.time_ < var_359_2 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play324121087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 324121087
		arg_360_1.duration_ = 9.7

		local var_360_0 = {
			zh = 8.633,
			ja = 9.7
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play324121088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(arg_360_1.actors_["1070ui_story"]) and arg_360_1.var_.characterEffect1070ui_story == nil then
				arg_360_1.var_.characterEffect1070ui_story = arg_360_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_0 = 0.200000002980232

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_0 and not isNil(arg_360_1.actors_["1070ui_story"]) then
				if arg_360_1.var_.characterEffect1070ui_story and not isNil(arg_360_1.actors_["1070ui_story"]) then
					arg_360_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_360_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_360_1.time_ - 0) / var_363_0)
				end
			end

			if arg_360_1.time_ >= 0 + var_363_0 and arg_360_1.time_ < 0 + var_363_0 + arg_363_0 and not isNil(arg_360_1.actors_["1070ui_story"]) and arg_360_1.var_.characterEffect1070ui_story then
				arg_360_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_360_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_363_1 = 0
			local var_363_2 = 0.75

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, true)
				arg_360_1.iconController_:SetSelectedState("hero")

				arg_360_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_360_1.callingController_:SetSelectedState("normal")

				arg_360_1.keyicon_.color = Color.New(1, 1, 1)
				arg_360_1.icon_.color = Color.New(1, 1, 1)

				local var_363_3 = arg_360_1:GetWordFromCfg(324121087)
				local var_363_4 = arg_360_1:FormatText(var_363_3.content)

				arg_360_1.text_.text = var_363_4

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_6 = 30 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_4) / 30)

				if (30 <= 0 and var_363_2 or var_363_2 * (utf8.len(var_363_4) / 30)) > 0 and var_363_2 < var_363_6 then
					arg_360_1.talkMaxDuration = var_363_6

					if var_363_6 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_6 + var_363_1
					end
				end

				arg_360_1.text_.text = var_363_4
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121087", "story_v_out_324121.awb") ~= 0 then
					local var_363_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121087", "story_v_out_324121.awb") / 1000

					if var_363_7 + var_363_1 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_7 + var_363_1
					end

					if var_363_3.prefab_name ~= "" and arg_360_1.actors_[var_363_3.prefab_name] ~= nil then
						local var_363_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_3.prefab_name].transform, "story_v_out_324121", "324121087", "story_v_out_324121.awb")

						arg_360_1:RecordAudio("324121087", var_363_8)
						arg_360_1:RecordAudio("324121087", var_363_8)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_324121", "324121087", "story_v_out_324121.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_324121", "324121087", "story_v_out_324121.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_9 = math.max(var_363_2, arg_360_1.talkMaxDuration)

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_9 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_1) / var_363_9

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_1 + var_363_9 and arg_360_1.time_ < var_363_1 + var_363_9 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play324121088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 324121088
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play324121089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos1070ui_story = arg_364_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_367_0 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_0 then
				arg_364_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_364_1.time_ - 0) / var_367_0)
				arg_364_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_364_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1070ui_story"].transform.position).z)
				arg_364_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_364_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_364_1.actors_["1070ui_story"].transform.localEulerAngles = arg_364_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_364_1.time_ >= 0 + var_367_0 and arg_364_1.time_ < 0 + var_367_0 + arg_367_0 then
				arg_364_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_364_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_364_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_364_1.actors_["1070ui_story"].transform.position).z)
				arg_364_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_364_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_364_1.actors_["1070ui_story"].transform.localEulerAngles = arg_364_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_367_1 = 0
			local var_367_2 = 1.1

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_3 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(324121088).content)

				arg_364_1.text_.text = var_367_3

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 44 <= 0 and var_367_2 or var_367_2 * (utf8.len(var_367_3) / 44)

				if (44 <= 0 and var_367_2 or var_367_2 * (utf8.len(var_367_3) / 44)) > 0 and var_367_2 < var_367_5 then
					arg_364_1.talkMaxDuration = var_367_5

					if var_367_5 + var_367_1 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + var_367_1
					end
				end

				arg_364_1.text_.text = var_367_3
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_6 = math.max(var_367_2, arg_364_1.talkMaxDuration)

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_6 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_1) / var_367_6

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_1 + var_367_6 and arg_364_1.time_ < var_367_1 + var_367_6 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
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

		arg_364_1:InitPlayNodeList()
	end,
	Play324121089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 324121089
		arg_368_1.duration_ = 10.6

		local var_368_0 = {
			zh = 10.166,
			ja = 10.6
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play324121090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 1.125

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_1 = arg_368_1:GetWordFromCfg(324121089)
				local var_371_2 = arg_368_1:FormatText(var_371_1.content)

				arg_368_1.text_.text = var_371_2

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 45 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 45)

				if (45 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 45)) > 0 and var_371_0 < var_371_4 then
					arg_368_1.talkMaxDuration = var_371_4

					if var_371_4 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_4 + 0
					end
				end

				arg_368_1.text_.text = var_371_2
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121089", "story_v_out_324121.awb") ~= 0 then
					local var_371_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121089", "story_v_out_324121.awb") / 1000

					if var_371_5 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + 0
					end

					if var_371_1.prefab_name ~= "" and arg_368_1.actors_[var_371_1.prefab_name] ~= nil then
						local var_371_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_1.prefab_name].transform, "story_v_out_324121", "324121089", "story_v_out_324121.awb")

						arg_368_1:RecordAudio("324121089", var_371_6)
						arg_368_1:RecordAudio("324121089", var_371_6)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_324121", "324121089", "story_v_out_324121.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_324121", "324121089", "story_v_out_324121.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_7 and arg_368_1.time_ < 0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play324121090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 324121090
		arg_372_1.duration_ = 8.7

		local var_372_0 = {
			zh = 5.3,
			ja = 8.7
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play324121091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.var_.moveOldPos1070ui_story = arg_372_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_375_0 = 0.001

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 then
				arg_372_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_372_1.time_ - 0) / var_375_0)
				arg_372_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1070ui_story"].transform.position).z)
				arg_372_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["1070ui_story"].transform.localEulerAngles = arg_372_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 then
				arg_372_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_372_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_372_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_372_1.actors_["1070ui_story"].transform.position).z)
				arg_372_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_372_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_372_1.actors_["1070ui_story"].transform.localEulerAngles = arg_372_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_375_1 = arg_372_1.actors_["1070ui_story"]

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(var_375_1) and arg_372_1.var_.characterEffect1070ui_story == nil then
				arg_372_1.var_.characterEffect1070ui_story = var_375_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_2 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_2 and not isNil(var_375_1) then
				if arg_372_1.var_.characterEffect1070ui_story and not isNil(var_375_1) then
					arg_372_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= 0 + var_375_2 and arg_372_1.time_ < 0 + var_375_2 + arg_375_0 and not isNil(var_375_1) and arg_372_1.var_.characterEffect1070ui_story then
				arg_372_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_375_4 = 0
			local var_375_5 = 0.575

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_4 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_6 = arg_372_1:GetWordFromCfg(324121090)
				local var_375_7 = arg_372_1:FormatText(var_375_6.content)

				arg_372_1.text_.text = var_375_7

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_9 = 23 <= 0 and var_375_5 or var_375_5 * (utf8.len(var_375_7) / 23)

				if (23 <= 0 and var_375_5 or var_375_5 * (utf8.len(var_375_7) / 23)) > 0 and var_375_5 < var_375_9 then
					arg_372_1.talkMaxDuration = var_375_9

					if var_375_9 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_9 + var_375_4
					end
				end

				arg_372_1.text_.text = var_375_7
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121090", "story_v_out_324121.awb") ~= 0 then
					local var_375_10 = manager.audio:GetVoiceLength("story_v_out_324121", "324121090", "story_v_out_324121.awb") / 1000

					if var_375_10 + var_375_4 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_10 + var_375_4
					end

					if var_375_6.prefab_name ~= "" and arg_372_1.actors_[var_375_6.prefab_name] ~= nil then
						local var_375_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_6.prefab_name].transform, "story_v_out_324121", "324121090", "story_v_out_324121.awb")

						arg_372_1:RecordAudio("324121090", var_375_11)
						arg_372_1:RecordAudio("324121090", var_375_11)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_324121", "324121090", "story_v_out_324121.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_324121", "324121090", "story_v_out_324121.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_12 = math.max(var_375_5, arg_372_1.talkMaxDuration)

			if var_375_4 <= arg_372_1.time_ and arg_372_1.time_ < var_375_4 + var_375_12 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_4) / var_375_12

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_4 + var_375_12 and arg_372_1.time_ < var_375_4 + var_375_12 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
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

		arg_372_1:InitPlayNodeList()
	end,
	Play324121091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 324121091
		arg_376_1.duration_ = 10.43

		local var_376_0 = {
			zh = 10.433,
			ja = 7.6
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play324121092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["1070ui_story"]) and arg_376_1.var_.characterEffect1070ui_story == nil then
				arg_376_1.var_.characterEffect1070ui_story = arg_376_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_0 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["1070ui_story"]) then
				if arg_376_1.var_.characterEffect1070ui_story and not isNil(arg_376_1.actors_["1070ui_story"]) then
					arg_376_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_376_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_376_1.time_ - 0) / var_379_0)
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["1070ui_story"]) and arg_376_1.var_.characterEffect1070ui_story then
				arg_376_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_376_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_379_1 = 0
			local var_379_2 = 0.475

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_3 = arg_376_1:GetWordFromCfg(324121091)
				local var_379_4 = arg_376_1:FormatText(var_379_3.content)

				arg_376_1.text_.text = var_379_4

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_6 = 19 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_4) / 19)

				if (19 <= 0 and var_379_2 or var_379_2 * (utf8.len(var_379_4) / 19)) > 0 and var_379_2 < var_379_6 then
					arg_376_1.talkMaxDuration = var_379_6

					if var_379_6 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_6 + var_379_1
					end
				end

				arg_376_1.text_.text = var_379_4
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121091", "story_v_out_324121.awb") ~= 0 then
					local var_379_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121091", "story_v_out_324121.awb") / 1000

					if var_379_7 + var_379_1 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_1
					end

					if var_379_3.prefab_name ~= "" and arg_376_1.actors_[var_379_3.prefab_name] ~= nil then
						local var_379_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_3.prefab_name].transform, "story_v_out_324121", "324121091", "story_v_out_324121.awb")

						arg_376_1:RecordAudio("324121091", var_379_8)
						arg_376_1:RecordAudio("324121091", var_379_8)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_324121", "324121091", "story_v_out_324121.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_324121", "324121091", "story_v_out_324121.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_9 = math.max(var_379_2, arg_376_1.talkMaxDuration)

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_9 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_1) / var_379_9

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_1 + var_379_9 and arg_376_1.time_ < var_379_1 + var_379_9 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play324121092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 324121092
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play324121093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos1070ui_story = arg_380_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_383_0 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 then
				arg_380_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_380_1.time_ - 0) / var_383_0)
				arg_380_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1070ui_story"].transform.position).z)
				arg_380_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1070ui_story"].transform.localEulerAngles = arg_380_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 then
				arg_380_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_380_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1070ui_story"].transform.position).z)
				arg_380_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1070ui_story"].transform.localEulerAngles = arg_380_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_383_1 = 0
			local var_383_2 = 1.05

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_3 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(324121092).content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 42 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 42)

				if (42 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 42)) > 0 and var_383_2 < var_383_5 then
					arg_380_1.talkMaxDuration = var_383_5

					if var_383_5 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_6 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_6 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_6

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_6 and arg_380_1.time_ < var_383_1 + var_383_6 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
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

		arg_380_1:InitPlayNodeList()
	end,
	Play324121093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 324121093
		arg_384_1.duration_ = 10

		local var_384_0 = {
			zh = 7.2,
			ja = 10
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play324121094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos1070ui_story = arg_384_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_387_0 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 then
				arg_384_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_384_1.time_ - 0) / var_387_0)
				arg_384_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1070ui_story"].transform.position).z)
				arg_384_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["1070ui_story"].transform.localEulerAngles = arg_384_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 then
				arg_384_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_384_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1070ui_story"].transform.position).z)
				arg_384_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["1070ui_story"].transform.localEulerAngles = arg_384_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_387_1 = arg_384_1.actors_["1070ui_story"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_1) and arg_384_1.var_.characterEffect1070ui_story == nil then
				arg_384_1.var_.characterEffect1070ui_story = var_387_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_2 and not isNil(var_387_1) then
				if arg_384_1.var_.characterEffect1070ui_story and not isNil(var_387_1) then
					arg_384_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= 0 + var_387_2 and arg_384_1.time_ < 0 + var_387_2 + arg_387_0 and not isNil(var_387_1) and arg_384_1.var_.characterEffect1070ui_story then
				arg_384_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_2")
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_387_4 = 0
			local var_387_5 = 0.725

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_4 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_6 = arg_384_1:GetWordFromCfg(324121093)
				local var_387_7 = arg_384_1:FormatText(var_387_6.content)

				arg_384_1.text_.text = var_387_7

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_9 = 29 <= 0 and var_387_5 or var_387_5 * (utf8.len(var_387_7) / 29)

				if (29 <= 0 and var_387_5 or var_387_5 * (utf8.len(var_387_7) / 29)) > 0 and var_387_5 < var_387_9 then
					arg_384_1.talkMaxDuration = var_387_9

					if var_387_9 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_9 + var_387_4
					end
				end

				arg_384_1.text_.text = var_387_7
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121093", "story_v_out_324121.awb") ~= 0 then
					local var_387_10 = manager.audio:GetVoiceLength("story_v_out_324121", "324121093", "story_v_out_324121.awb") / 1000

					if var_387_10 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_10 + var_387_4
					end

					if var_387_6.prefab_name ~= "" and arg_384_1.actors_[var_387_6.prefab_name] ~= nil then
						local var_387_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_6.prefab_name].transform, "story_v_out_324121", "324121093", "story_v_out_324121.awb")

						arg_384_1:RecordAudio("324121093", var_387_11)
						arg_384_1:RecordAudio("324121093", var_387_11)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_324121", "324121093", "story_v_out_324121.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_324121", "324121093", "story_v_out_324121.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_12 = math.max(var_387_5, arg_384_1.talkMaxDuration)

			if var_387_4 <= arg_384_1.time_ and arg_384_1.time_ < var_387_4 + var_387_12 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_4) / var_387_12

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_4 + var_387_12 and arg_384_1.time_ < var_387_4 + var_387_12 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
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

		arg_384_1:InitPlayNodeList()
	end,
	Play324121094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 324121094
		arg_388_1.duration_ = 8.87

		local var_388_0 = {
			zh = 7.033,
			ja = 8.866
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play324121095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["1070ui_story"]) and arg_388_1.var_.characterEffect1070ui_story == nil then
				arg_388_1.var_.characterEffect1070ui_story = arg_388_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_0 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["1070ui_story"]) then
				if arg_388_1.var_.characterEffect1070ui_story and not isNil(arg_388_1.actors_["1070ui_story"]) then
					arg_388_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_388_1.time_ - 0) / var_391_0)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["1070ui_story"]) and arg_388_1.var_.characterEffect1070ui_story then
				arg_388_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_391_1 = 0
			local var_391_2 = 0.65

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_3 = arg_388_1:GetWordFromCfg(324121094)
				local var_391_4 = arg_388_1:FormatText(var_391_3.content)

				arg_388_1.text_.text = var_391_4

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_6 = 26 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_4) / 26)

				if (26 <= 0 and var_391_2 or var_391_2 * (utf8.len(var_391_4) / 26)) > 0 and var_391_2 < var_391_6 then
					arg_388_1.talkMaxDuration = var_391_6

					if var_391_6 + var_391_1 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_6 + var_391_1
					end
				end

				arg_388_1.text_.text = var_391_4
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121094", "story_v_out_324121.awb") ~= 0 then
					local var_391_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121094", "story_v_out_324121.awb") / 1000

					if var_391_7 + var_391_1 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_7 + var_391_1
					end

					if var_391_3.prefab_name ~= "" and arg_388_1.actors_[var_391_3.prefab_name] ~= nil then
						local var_391_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_3.prefab_name].transform, "story_v_out_324121", "324121094", "story_v_out_324121.awb")

						arg_388_1:RecordAudio("324121094", var_391_8)
						arg_388_1:RecordAudio("324121094", var_391_8)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_324121", "324121094", "story_v_out_324121.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_324121", "324121094", "story_v_out_324121.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_9 = math.max(var_391_2, arg_388_1.talkMaxDuration)

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_9 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_1) / var_391_9

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_1 + var_391_9 and arg_388_1.time_ < var_391_1 + var_391_9 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play324121095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 324121095
		arg_392_1.duration_ = 10.5

		local var_392_0 = {
			zh = 6.466,
			ja = 10.5
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play324121096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["1070ui_story"]) and arg_392_1.var_.characterEffect1070ui_story == nil then
				arg_392_1.var_.characterEffect1070ui_story = arg_392_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_0 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["1070ui_story"]) then
				if arg_392_1.var_.characterEffect1070ui_story and not isNil(arg_392_1.actors_["1070ui_story"]) then
					arg_392_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["1070ui_story"]) and arg_392_1.var_.characterEffect1070ui_story then
				arg_392_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_395_2 = 0
			local var_395_3 = 0.625

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_2 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_4 = arg_392_1:GetWordFromCfg(324121095)
				local var_395_5 = arg_392_1:FormatText(var_395_4.content)

				arg_392_1.text_.text = var_395_5

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_7 = 25 <= 0 and var_395_3 or var_395_3 * (utf8.len(var_395_5) / 25)

				if (25 <= 0 and var_395_3 or var_395_3 * (utf8.len(var_395_5) / 25)) > 0 and var_395_3 < var_395_7 then
					arg_392_1.talkMaxDuration = var_395_7

					if var_395_7 + var_395_2 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_2
					end
				end

				arg_392_1.text_.text = var_395_5
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121095", "story_v_out_324121.awb") ~= 0 then
					local var_395_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121095", "story_v_out_324121.awb") / 1000

					if var_395_8 + var_395_2 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_8 + var_395_2
					end

					if var_395_4.prefab_name ~= "" and arg_392_1.actors_[var_395_4.prefab_name] ~= nil then
						local var_395_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_4.prefab_name].transform, "story_v_out_324121", "324121095", "story_v_out_324121.awb")

						arg_392_1:RecordAudio("324121095", var_395_9)
						arg_392_1:RecordAudio("324121095", var_395_9)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_324121", "324121095", "story_v_out_324121.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_324121", "324121095", "story_v_out_324121.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_10 = math.max(var_395_3, arg_392_1.talkMaxDuration)

			if var_395_2 <= arg_392_1.time_ and arg_392_1.time_ < var_395_2 + var_395_10 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_2) / var_395_10

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_2 + var_395_10 and arg_392_1.time_ < var_395_2 + var_395_10 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play324121096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 324121096
		arg_396_1.duration_ = 3.4

		local var_396_0 = {
			zh = 2.533,
			ja = 3.4
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play324121097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["1070ui_story"]) and arg_396_1.var_.characterEffect1070ui_story == nil then
				arg_396_1.var_.characterEffect1070ui_story = arg_396_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_0 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["1070ui_story"]) then
				if arg_396_1.var_.characterEffect1070ui_story and not isNil(arg_396_1.actors_["1070ui_story"]) then
					arg_396_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_396_1.time_ - 0) / var_399_0)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["1070ui_story"]) and arg_396_1.var_.characterEffect1070ui_story then
				arg_396_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_399_1 = 0
			local var_399_2 = 0.2

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_3 = arg_396_1:GetWordFromCfg(324121096)
				local var_399_4 = arg_396_1:FormatText(var_399_3.content)

				arg_396_1.text_.text = var_399_4

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_6 = 8 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_4) / 8)

				if (8 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_4) / 8)) > 0 and var_399_2 < var_399_6 then
					arg_396_1.talkMaxDuration = var_399_6

					if var_399_6 + var_399_1 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_6 + var_399_1
					end
				end

				arg_396_1.text_.text = var_399_4
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121096", "story_v_out_324121.awb") ~= 0 then
					local var_399_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121096", "story_v_out_324121.awb") / 1000

					if var_399_7 + var_399_1 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_1
					end

					if var_399_3.prefab_name ~= "" and arg_396_1.actors_[var_399_3.prefab_name] ~= nil then
						local var_399_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_3.prefab_name].transform, "story_v_out_324121", "324121096", "story_v_out_324121.awb")

						arg_396_1:RecordAudio("324121096", var_399_8)
						arg_396_1:RecordAudio("324121096", var_399_8)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_324121", "324121096", "story_v_out_324121.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_324121", "324121096", "story_v_out_324121.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_9 = math.max(var_399_2, arg_396_1.talkMaxDuration)

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_9 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_1) / var_399_9

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_1 + var_399_9 and arg_396_1.time_ < var_399_1 + var_399_9 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play324121097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 324121097
		arg_400_1.duration_ = 1

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play324121098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(arg_400_1.actors_["1070ui_story"]) and arg_400_1.var_.characterEffect1070ui_story == nil then
				arg_400_1.var_.characterEffect1070ui_story = arg_400_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_0 = 0.200000002980232

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_0 and not isNil(arg_400_1.actors_["1070ui_story"]) then
				if arg_400_1.var_.characterEffect1070ui_story and not isNil(arg_400_1.actors_["1070ui_story"]) then
					arg_400_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= 0 + var_403_0 and arg_400_1.time_ < 0 + var_403_0 + arg_403_0 and not isNil(arg_400_1.actors_["1070ui_story"]) and arg_400_1.var_.characterEffect1070ui_story then
				arg_400_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_403_2 = 0
			local var_403_3 = 0.05

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_2 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_4 = arg_400_1:GetWordFromCfg(324121097)
				local var_403_5 = arg_400_1:FormatText(var_403_4.content)

				arg_400_1.text_.text = var_403_5

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_7 = 2 <= 0 and var_403_3 or var_403_3 * (utf8.len(var_403_5) / 2)

				if (2 <= 0 and var_403_3 or var_403_3 * (utf8.len(var_403_5) / 2)) > 0 and var_403_3 < var_403_7 then
					arg_400_1.talkMaxDuration = var_403_7

					if var_403_7 + var_403_2 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_7 + var_403_2
					end
				end

				arg_400_1.text_.text = var_403_5
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121097", "story_v_out_324121.awb") ~= 0 then
					local var_403_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121097", "story_v_out_324121.awb") / 1000

					if var_403_8 + var_403_2 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_8 + var_403_2
					end

					if var_403_4.prefab_name ~= "" and arg_400_1.actors_[var_403_4.prefab_name] ~= nil then
						local var_403_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_4.prefab_name].transform, "story_v_out_324121", "324121097", "story_v_out_324121.awb")

						arg_400_1:RecordAudio("324121097", var_403_9)
						arg_400_1:RecordAudio("324121097", var_403_9)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_324121", "324121097", "story_v_out_324121.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_324121", "324121097", "story_v_out_324121.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_10 = math.max(var_403_3, arg_400_1.talkMaxDuration)

			if var_403_2 <= arg_400_1.time_ and arg_400_1.time_ < var_403_2 + var_403_10 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_2) / var_403_10

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_2 + var_403_10 and arg_400_1.time_ < var_403_2 + var_403_10 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play324121098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 324121098
		arg_404_1.duration_ = 11.7

		local var_404_0 = {
			zh = 6.366,
			ja = 11.7
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play324121099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(arg_404_1.actors_["1070ui_story"]) and arg_404_1.var_.characterEffect1070ui_story == nil then
				arg_404_1.var_.characterEffect1070ui_story = arg_404_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_0 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 and not isNil(arg_404_1.actors_["1070ui_story"]) then
				if arg_404_1.var_.characterEffect1070ui_story and not isNil(arg_404_1.actors_["1070ui_story"]) then
					arg_404_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_404_1.time_ - 0) / var_407_0)
				end
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 and not isNil(arg_404_1.actors_["1070ui_story"]) and arg_404_1.var_.characterEffect1070ui_story then
				arg_404_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_407_1 = 0
			local var_407_2 = 0.675

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_3 = arg_404_1:GetWordFromCfg(324121098)
				local var_407_4 = arg_404_1:FormatText(var_407_3.content)

				arg_404_1.text_.text = var_407_4

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_6 = 27 <= 0 and var_407_2 or var_407_2 * (utf8.len(var_407_4) / 27)

				if (27 <= 0 and var_407_2 or var_407_2 * (utf8.len(var_407_4) / 27)) > 0 and var_407_2 < var_407_6 then
					arg_404_1.talkMaxDuration = var_407_6

					if var_407_6 + var_407_1 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_6 + var_407_1
					end
				end

				arg_404_1.text_.text = var_407_4
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121098", "story_v_out_324121.awb") ~= 0 then
					local var_407_7 = manager.audio:GetVoiceLength("story_v_out_324121", "324121098", "story_v_out_324121.awb") / 1000

					if var_407_7 + var_407_1 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_7 + var_407_1
					end

					if var_407_3.prefab_name ~= "" and arg_404_1.actors_[var_407_3.prefab_name] ~= nil then
						local var_407_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_3.prefab_name].transform, "story_v_out_324121", "324121098", "story_v_out_324121.awb")

						arg_404_1:RecordAudio("324121098", var_407_8)
						arg_404_1:RecordAudio("324121098", var_407_8)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_324121", "324121098", "story_v_out_324121.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_324121", "324121098", "story_v_out_324121.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_9 = math.max(var_407_2, arg_404_1.talkMaxDuration)

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_9 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_1) / var_407_9

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_1 + var_407_9 and arg_404_1.time_ < var_407_1 + var_407_9 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play324121099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 324121099
		arg_408_1.duration_ = 12.23

		local var_408_0 = {
			zh = 9.7,
			ja = 12.233
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play324121100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.975

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_408_1.callingController_:SetSelectedState("normal")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_1 = arg_408_1:GetWordFromCfg(324121099)
				local var_411_2 = arg_408_1:FormatText(var_411_1.content)

				arg_408_1.text_.text = var_411_2

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 39 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 39)

				if (39 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 39)) > 0 and var_411_0 < var_411_4 then
					arg_408_1.talkMaxDuration = var_411_4

					if var_411_4 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_4 + 0
					end
				end

				arg_408_1.text_.text = var_411_2
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121099", "story_v_out_324121.awb") ~= 0 then
					local var_411_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121099", "story_v_out_324121.awb") / 1000

					if var_411_5 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + 0
					end

					if var_411_1.prefab_name ~= "" and arg_408_1.actors_[var_411_1.prefab_name] ~= nil then
						local var_411_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_1.prefab_name].transform, "story_v_out_324121", "324121099", "story_v_out_324121.awb")

						arg_408_1:RecordAudio("324121099", var_411_6)
						arg_408_1:RecordAudio("324121099", var_411_6)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_324121", "324121099", "story_v_out_324121.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_324121", "324121099", "story_v_out_324121.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_7 and arg_408_1.time_ < 0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play324121100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 324121100
		arg_412_1.duration_ = 12.7

		local var_412_0 = {
			zh = 11,
			ja = 12.7
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play324121101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 1.125

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_1 = arg_412_1:GetWordFromCfg(324121100)
				local var_415_2 = arg_412_1:FormatText(var_415_1.content)

				arg_412_1.text_.text = var_415_2

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_4 = 45 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 45)

				if (45 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 45)) > 0 and var_415_0 < var_415_4 then
					arg_412_1.talkMaxDuration = var_415_4

					if var_415_4 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_4 + 0
					end
				end

				arg_412_1.text_.text = var_415_2
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121100", "story_v_out_324121.awb") ~= 0 then
					local var_415_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121100", "story_v_out_324121.awb") / 1000

					if var_415_5 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_5 + 0
					end

					if var_415_1.prefab_name ~= "" and arg_412_1.actors_[var_415_1.prefab_name] ~= nil then
						local var_415_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_1.prefab_name].transform, "story_v_out_324121", "324121100", "story_v_out_324121.awb")

						arg_412_1:RecordAudio("324121100", var_415_6)
						arg_412_1:RecordAudio("324121100", var_415_6)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_324121", "324121100", "story_v_out_324121.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_324121", "324121100", "story_v_out_324121.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_7 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_7 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_7

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_7 and arg_412_1.time_ < 0 + var_415_7 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play324121101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 324121101
		arg_416_1.duration_ = 16.8

		local var_416_0 = {
			zh = 8.233,
			ja = 16.8
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play324121102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.8

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[1454].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_1 = arg_416_1:GetWordFromCfg(324121101)
				local var_419_2 = arg_416_1:FormatText(var_419_1.content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 32 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 32)

				if (32 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 32)) > 0 and var_419_0 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + 0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121101", "story_v_out_324121.awb") ~= 0 then
					local var_419_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121101", "story_v_out_324121.awb") / 1000

					if var_419_5 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + 0
					end

					if var_419_1.prefab_name ~= "" and arg_416_1.actors_[var_419_1.prefab_name] ~= nil then
						local var_419_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_1.prefab_name].transform, "story_v_out_324121", "324121101", "story_v_out_324121.awb")

						arg_416_1:RecordAudio("324121101", var_419_6)
						arg_416_1:RecordAudio("324121101", var_419_6)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_324121", "324121101", "story_v_out_324121.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_324121", "324121101", "story_v_out_324121.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play324121102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 324121102
		arg_420_1.duration_ = 3.67

		local var_420_0 = {
			zh = 2.5,
			ja = 3.666
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play324121103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["1070ui_story"]) and arg_420_1.var_.characterEffect1070ui_story == nil then
				arg_420_1.var_.characterEffect1070ui_story = arg_420_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_0 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["1070ui_story"]) then
				if arg_420_1.var_.characterEffect1070ui_story and not isNil(arg_420_1.actors_["1070ui_story"]) then
					arg_420_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["1070ui_story"]) and arg_420_1.var_.characterEffect1070ui_story then
				arg_420_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_423_2 = 0
			local var_423_3 = 0.2

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_2 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_4 = arg_420_1:GetWordFromCfg(324121102)
				local var_423_5 = arg_420_1:FormatText(var_423_4.content)

				arg_420_1.text_.text = var_423_5

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_7 = 8 <= 0 and var_423_3 or var_423_3 * (utf8.len(var_423_5) / 8)

				if (8 <= 0 and var_423_3 or var_423_3 * (utf8.len(var_423_5) / 8)) > 0 and var_423_3 < var_423_7 then
					arg_420_1.talkMaxDuration = var_423_7

					if var_423_7 + var_423_2 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_7 + var_423_2
					end
				end

				arg_420_1.text_.text = var_423_5
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121102", "story_v_out_324121.awb") ~= 0 then
					local var_423_8 = manager.audio:GetVoiceLength("story_v_out_324121", "324121102", "story_v_out_324121.awb") / 1000

					if var_423_8 + var_423_2 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_8 + var_423_2
					end

					if var_423_4.prefab_name ~= "" and arg_420_1.actors_[var_423_4.prefab_name] ~= nil then
						local var_423_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_4.prefab_name].transform, "story_v_out_324121", "324121102", "story_v_out_324121.awb")

						arg_420_1:RecordAudio("324121102", var_423_9)
						arg_420_1:RecordAudio("324121102", var_423_9)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_324121", "324121102", "story_v_out_324121.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_324121", "324121102", "story_v_out_324121.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_10 = math.max(var_423_3, arg_420_1.talkMaxDuration)

			if var_423_2 <= arg_420_1.time_ and arg_420_1.time_ < var_423_2 + var_423_10 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_2) / var_423_10

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_2 + var_423_10 and arg_420_1.time_ < var_423_2 + var_423_10 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play324121103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 324121103
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play324121104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos1070ui_story = arg_424_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_427_0 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 then
				arg_424_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_424_1.time_ - 0) / var_427_0)
				arg_424_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1070ui_story"].transform.position).z)
				arg_424_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1070ui_story"].transform.localEulerAngles = arg_424_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 then
				arg_424_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_424_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1070ui_story"].transform.position).z)
				arg_424_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1070ui_story"].transform.localEulerAngles = arg_424_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_427_1 = arg_424_1.actors_["1070ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect1070ui_story == nil then
				arg_424_1.var_.characterEffect1070ui_story = var_427_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_2 and not isNil(var_427_1) then
				if arg_424_1.var_.characterEffect1070ui_story and not isNil(var_427_1) then
					arg_424_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_424_1.time_ - 0) / var_427_2)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_2 and arg_424_1.time_ < 0 + var_427_2 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect1070ui_story then
				arg_424_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_427_3 = 0
			local var_427_4 = 0.125

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_3 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_5 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(324121103).content)

				arg_424_1.text_.text = var_427_5

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_7 = 5 <= 0 and var_427_4 or var_427_4 * (utf8.len(var_427_5) / 5)

				if (5 <= 0 and var_427_4 or var_427_4 * (utf8.len(var_427_5) / 5)) > 0 and var_427_4 < var_427_7 then
					arg_424_1.talkMaxDuration = var_427_7

					if var_427_7 + var_427_3 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_7 + var_427_3
					end
				end

				arg_424_1.text_.text = var_427_5
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_8 = math.max(var_427_4, arg_424_1.talkMaxDuration)

			if var_427_3 <= arg_424_1.time_ and arg_424_1.time_ < var_427_3 + var_427_8 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_3) / var_427_8

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_3 + var_427_8 and arg_424_1.time_ < var_427_3 + var_427_8 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
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

		arg_424_1:InitPlayNodeList()
	end,
	Play324121104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 324121104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play324121105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0.85

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_1 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(324121104).content)

				arg_428_1.text_.text = var_431_1

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_3 = 34 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_1) / 34)

				if (34 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_1) / 34)) > 0 and var_431_0 < var_431_3 then
					arg_428_1.talkMaxDuration = var_431_3

					if var_431_3 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_3 + 0
					end
				end

				arg_428_1.text_.text = var_431_1
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_4 = math.max(var_431_0, arg_428_1.talkMaxDuration)

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_4 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - 0) / var_431_4

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= 0 + var_431_4 and arg_428_1.time_ < 0 + var_431_4 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play324121105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 324121105
		arg_432_1.duration_ = 8.47

		local var_432_0 = {
			zh = 6.840999999999,
			ja = 8.474999999999
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play324121106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if arg_432_1.bgs_.ST2003 == nil then
				local var_435_0 = Object.Instantiate(arg_432_1.paintGo_)

				var_435_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2003")
				var_435_0.name = "ST2003"
				var_435_0.transform.parent = arg_432_1.stage_.transform
				var_435_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_432_1.bgs_.ST2003 = var_435_0
			end

			if 1.999999999999 < arg_432_1.time_ and arg_432_1.time_ <= 1.999999999999 + arg_435_0 then
				local var_435_1 = arg_432_1.bgs_.ST2003

				arg_432_1.bgs_.ST2003.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_435_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_435_2 = var_435_1:GetComponent("SpriteRenderer")

				if var_435_2 and var_435_2.sprite then
					local var_435_3 = 2 * (var_435_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_435_1.transform.localScale = Vector3.New(var_435_3 / var_435_2.sprite.bounds.size.y < var_435_3 * manager.ui.mainCameraCom_.aspect / var_435_2.sprite.bounds.size.x and var_435_3 * manager.ui.mainCameraCom_.aspect / var_435_2.sprite.bounds.size.x or var_435_3 / var_435_2.sprite.bounds.size.y, var_435_3 / var_435_2.sprite.bounds.size.y < var_435_3 * manager.ui.mainCameraCom_.aspect / var_435_2.sprite.bounds.size.x and var_435_3 * manager.ui.mainCameraCom_.aspect / var_435_2.sprite.bounds.size.x or var_435_3 / var_435_2.sprite.bounds.size.y, 0)
				end

				for iter_435_0, iter_435_1 in pairs(arg_432_1.bgs_) do
					if iter_435_0 ~= "ST2003" then
						iter_435_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_435_4 = 0

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_4 + arg_435_0 then
				arg_432_1.allBtn_.enabled = false
			end

			if arg_432_1.time_ >= var_435_4 + 0.3 and arg_432_1.time_ < var_435_4 + 0.3 + arg_435_0 then
				arg_432_1.allBtn_.enabled = true
			end

			local var_435_5 = 0

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_5 + arg_435_0 then
				arg_432_1.mask_.enabled = true
				arg_432_1.mask_.raycastTarget = true

				arg_432_1:SetGaussion(false)
			end

			local var_435_6 = 2

			if var_435_5 <= arg_432_1.time_ and arg_432_1.time_ < var_435_5 + var_435_6 then
				local var_435_7 = Color.New(0, 0, 0)

				var_435_7.a = Mathf.Lerp(0, 1, (arg_432_1.time_ - var_435_5) / var_435_6)
				arg_432_1.mask_.color = var_435_7
			end

			if arg_432_1.time_ >= var_435_5 + var_435_6 and arg_432_1.time_ < var_435_5 + var_435_6 + arg_435_0 then
				local var_435_8 = Color.New(0, 0, 0)

				var_435_8.a = 1
				arg_432_1.mask_.color = var_435_8
			end

			local var_435_9 = 1.999999999999

			if 1.999999999999 < arg_432_1.time_ and arg_432_1.time_ <= var_435_9 + arg_435_0 then
				arg_432_1.mask_.enabled = true
				arg_432_1.mask_.raycastTarget = true

				arg_432_1:SetGaussion(false)
			end

			local var_435_10 = 2

			if var_435_9 <= arg_432_1.time_ and arg_432_1.time_ < var_435_9 + var_435_10 then
				local var_435_11 = Color.New(0, 0, 0)

				var_435_11.a = Mathf.Lerp(1, 0, (arg_432_1.time_ - var_435_9) / var_435_10)
				arg_432_1.mask_.color = var_435_11
			end

			if arg_432_1.time_ >= var_435_9 + var_435_10 and arg_432_1.time_ < var_435_9 + var_435_10 + arg_435_0 then
				local var_435_12 = Color.New(0, 0, 0)

				arg_432_1.mask_.enabled = false
				var_435_12.a = 0
				arg_432_1.mask_.color = var_435_12
			end

			local var_435_13 = "10039ui_story"

			if arg_432_1.actors_["10039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10039ui_story"))) then
				local var_435_14 = Object.Instantiate(Asset.Load("Char/" .. "10039ui_story"), arg_432_1.stage_.transform)

				var_435_14.name = var_435_13
				var_435_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_432_1.actors_[var_435_13] = var_435_14

				local var_435_15 = var_435_14:GetComponentInChildren(typeof(CharacterEffect))

				var_435_15.enabled = true

				local var_435_16 = GameObjectTools.GetOrAddComponent(var_435_14, typeof(DynamicBoneHelper))

				if var_435_16 then
					var_435_16:EnableDynamicBone(false)
				end

				arg_432_1:ShowWeapon(var_435_15.transform, false)

				arg_432_1.var_[var_435_13 .. "Animator"] = var_435_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_432_1.var_[var_435_13 .. "Animator"].applyRootMotion = true
				arg_432_1.var_[var_435_13 .. "LipSync"] = var_435_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_435_17 = arg_432_1.actors_["10039ui_story"].transform

			if 3.43333333333333 < arg_432_1.time_ and arg_432_1.time_ <= 3.43333333333333 + arg_435_0 then
				arg_432_1.var_.moveOldPos10039ui_story = var_435_17.localPosition
			end

			local var_435_18 = 0.001

			if 3.43333333333333 <= arg_432_1.time_ and arg_432_1.time_ < 3.43333333333333 + var_435_18 then
				var_435_17.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10039ui_story, Vector3.New(0, -0.8, -6.2), (arg_432_1.time_ - 3.43333333333333) / var_435_18)
				var_435_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_435_17.position).x, (manager.ui.mainCamera.transform.position - var_435_17.position).y, (manager.ui.mainCamera.transform.position - var_435_17.position).z)
				var_435_17.localEulerAngles.z = 0
				var_435_17.localEulerAngles.x = 0
				var_435_17.localEulerAngles = var_435_17.localEulerAngles
			end

			if arg_432_1.time_ >= 3.43333333333333 + var_435_18 and arg_432_1.time_ < 3.43333333333333 + var_435_18 + arg_435_0 then
				var_435_17.localPosition = Vector3.New(0, -0.8, -6.2)
				var_435_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_435_17.position).x, (manager.ui.mainCamera.transform.position - var_435_17.position).y, (manager.ui.mainCamera.transform.position - var_435_17.position).z)
				var_435_17.localEulerAngles.z = 0
				var_435_17.localEulerAngles.x = 0
				var_435_17.localEulerAngles = var_435_17.localEulerAngles
			end

			local var_435_19 = arg_432_1.actors_["10039ui_story"]

			if 3.43333333333333 < arg_432_1.time_ and arg_432_1.time_ <= 3.43333333333333 + arg_435_0 and not isNil(var_435_19) and arg_432_1.var_.characterEffect10039ui_story == nil then
				arg_432_1.var_.characterEffect10039ui_story = var_435_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_20 = 0.200000002980232

			if 3.43333333333333 <= arg_432_1.time_ and arg_432_1.time_ < 3.43333333333333 + var_435_20 and not isNil(var_435_19) then
				if arg_432_1.var_.characterEffect10039ui_story and not isNil(var_435_19) then
					arg_432_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= 3.43333333333333 + var_435_20 and arg_432_1.time_ < 3.43333333333333 + var_435_20 + arg_435_0 and not isNil(var_435_19) and arg_432_1.var_.characterEffect10039ui_story then
				arg_432_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			if 3.43333333333333 < arg_432_1.time_ and arg_432_1.time_ <= 3.43333333333333 + arg_435_0 then
				arg_432_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			if 3.43333333333333 < arg_432_1.time_ and arg_432_1.time_ <= 3.43333333333333 + arg_435_0 then
				arg_432_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_435_22 = 1.999999999999

			arg_432_1.isInRecall_ = true

			if var_435_22 < arg_432_1.time_ and arg_432_1.time_ <= var_435_22 + arg_435_0 then
				arg_432_1.screenFilterGo_:SetActive(true)

				arg_432_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_432_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_432_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_435_2, iter_435_3 in pairs(arg_432_1.actors_) do
					for iter_435_4, iter_435_5 in ipairs((iter_435_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_435_5.color = iter_435_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_435_23 = 0.0166666666666667

			if var_435_22 <= arg_432_1.time_ and arg_432_1.time_ < var_435_22 + var_435_23 then
				arg_432_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_432_1.time_ - var_435_22) / var_435_23)
			end

			if arg_432_1.time_ >= var_435_22 + var_435_23 and arg_432_1.time_ < var_435_22 + var_435_23 + arg_435_0 then
				arg_432_1.screenFilterEffect_.weight = 1
			end

			if 1.2 < arg_432_1.time_ and arg_432_1.time_ <= 1.2 + arg_435_0 then
				arg_432_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0.1 < arg_432_1.time_ and arg_432_1.time_ <= 0.1 + arg_435_0 then
				arg_432_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_ice_cave", "")
			end

			if arg_432_1.frameCnt_ <= 1 then
				arg_432_1.dialog_:SetActive(false)
			end

			local var_435_26 = 3.674999999999
			local var_435_27 = 0.325

			if 3.674999999999 < arg_432_1.time_ and arg_432_1.time_ <= var_435_26 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0

				arg_432_1.dialog_:SetActive(true)

				arg_432_1.dialogCg_.alpha = 0

				local var_435_28 = LeanTween.value(arg_432_1.dialog_, 0, 1, 0.3)

				var_435_28:setOnUpdate(LuaHelper.FloatAction(function(arg_436_0)
					arg_432_1.dialogCg_.alpha = arg_436_0
				end))
				var_435_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_432_1.dialog_)
					var_435_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_432_1.duration_ = arg_432_1.duration_ + 0.3

				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_29 = arg_432_1:GetWordFromCfg(324121105)
				local var_435_30 = arg_432_1:FormatText(var_435_29.content)

				arg_432_1.text_.text = var_435_30

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_32 = 13 <= 0 and var_435_27 or var_435_27 * (utf8.len(var_435_30) / 13)

				if (13 <= 0 and var_435_27 or var_435_27 * (utf8.len(var_435_30) / 13)) > 0 and var_435_27 < var_435_32 then
					arg_432_1.talkMaxDuration = var_435_32
					var_435_26 = var_435_26 + 0.3

					if var_435_32 + var_435_26 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_32 + var_435_26
					end
				end

				arg_432_1.text_.text = var_435_30
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121105", "story_v_out_324121.awb") ~= 0 then
					local var_435_33 = manager.audio:GetVoiceLength("story_v_out_324121", "324121105", "story_v_out_324121.awb") / 1000

					if var_435_33 + var_435_26 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_33 + var_435_26
					end

					if var_435_29.prefab_name ~= "" and arg_432_1.actors_[var_435_29.prefab_name] ~= nil then
						local var_435_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_29.prefab_name].transform, "story_v_out_324121", "324121105", "story_v_out_324121.awb")

						arg_432_1:RecordAudio("324121105", var_435_34)
						arg_432_1:RecordAudio("324121105", var_435_34)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_324121", "324121105", "story_v_out_324121.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_324121", "324121105", "story_v_out_324121.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_35 = var_435_26 + 0.3
			local var_435_36 = math.max(var_435_27, arg_432_1.talkMaxDuration)

			if var_435_26 + 0.3 <= arg_432_1.time_ and arg_432_1.time_ < var_435_35 + var_435_36 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_35) / var_435_36

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_35 + var_435_36 and arg_432_1.time_ < var_435_35 + var_435_36 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.43333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play324121106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 324121106
		arg_438_1.duration_ = 5.13

		local var_438_0 = {
			zh = 3.433,
			ja = 5.133
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play324121107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.35

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_1 = arg_438_1:GetWordFromCfg(324121106)
				local var_441_2 = arg_438_1:FormatText(var_441_1.content)

				arg_438_1.text_.text = var_441_2

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_4 = 14 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 14)

				if (14 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 14)) > 0 and var_441_0 < var_441_4 then
					arg_438_1.talkMaxDuration = var_441_4

					if var_441_4 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_4 + 0
					end
				end

				arg_438_1.text_.text = var_441_2
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121106", "story_v_out_324121.awb") ~= 0 then
					local var_441_5 = manager.audio:GetVoiceLength("story_v_out_324121", "324121106", "story_v_out_324121.awb") / 1000

					if var_441_5 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + 0
					end

					if var_441_1.prefab_name ~= "" and arg_438_1.actors_[var_441_1.prefab_name] ~= nil then
						local var_441_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_1.prefab_name].transform, "story_v_out_324121", "324121106", "story_v_out_324121.awb")

						arg_438_1:RecordAudio("324121106", var_441_6)
						arg_438_1:RecordAudio("324121106", var_441_6)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_324121", "324121106", "story_v_out_324121.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_324121", "324121106", "story_v_out_324121.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_7 = math.max(var_441_0, arg_438_1.talkMaxDuration)

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_7 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - 0) / var_441_7

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= 0 + var_441_7 and arg_438_1.time_ < 0 + var_441_7 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play324121107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 324121107
		arg_442_1.duration_ = 8.87

		local var_442_0 = {
			zh = 6.3,
			ja = 8.866
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play324121108(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_445_0 = 0
			local var_445_1 = 0.65

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_2 = arg_442_1:GetWordFromCfg(324121107)
				local var_445_3 = arg_442_1:FormatText(var_445_2.content)

				arg_442_1.text_.text = var_445_3

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_5 = 26 <= 0 and var_445_1 or var_445_1 * (utf8.len(var_445_3) / 26)

				if (26 <= 0 and var_445_1 or var_445_1 * (utf8.len(var_445_3) / 26)) > 0 and var_445_1 < var_445_5 then
					arg_442_1.talkMaxDuration = var_445_5

					if var_445_5 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_5 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_3
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324121", "324121107", "story_v_out_324121.awb") ~= 0 then
					local var_445_6 = manager.audio:GetVoiceLength("story_v_out_324121", "324121107", "story_v_out_324121.awb") / 1000

					if var_445_6 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_6 + var_445_0
					end

					if var_445_2.prefab_name ~= "" and arg_442_1.actors_[var_445_2.prefab_name] ~= nil then
						local var_445_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_2.prefab_name].transform, "story_v_out_324121", "324121107", "story_v_out_324121.awb")

						arg_442_1:RecordAudio("324121107", var_445_7)
						arg_442_1:RecordAudio("324121107", var_445_7)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_324121", "324121107", "story_v_out_324121.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_324121", "324121107", "story_v_out_324121.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_8 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_8 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_8

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_8 and arg_442_1.time_ < var_445_0 + var_445_8 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play324121108 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 324121108
		arg_446_1.duration_ = 8.4

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play324121109(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 1.7 < arg_446_1.time_ and arg_446_1.time_ <= 1.7 + arg_449_0 then
				local var_449_0 = arg_446_1.bgs_.ST2005

				arg_446_1.bgs_.ST2005.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_449_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_449_1 = var_449_0:GetComponent("SpriteRenderer")

				if var_449_1 and var_449_1.sprite then
					local var_449_2 = 2 * (var_449_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_449_0.transform.localScale = Vector3.New(var_449_2 / var_449_1.sprite.bounds.size.y < var_449_2 * manager.ui.mainCameraCom_.aspect / var_449_1.sprite.bounds.size.x and var_449_2 * manager.ui.mainCameraCom_.aspect / var_449_1.sprite.bounds.size.x or var_449_2 / var_449_1.sprite.bounds.size.y, var_449_2 / var_449_1.sprite.bounds.size.y < var_449_2 * manager.ui.mainCameraCom_.aspect / var_449_1.sprite.bounds.size.x and var_449_2 * manager.ui.mainCameraCom_.aspect / var_449_1.sprite.bounds.size.x or var_449_2 / var_449_1.sprite.bounds.size.y, 0)
				end

				for iter_449_0, iter_449_1 in pairs(arg_446_1.bgs_) do
					if iter_449_0 ~= "ST2005" then
						iter_449_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_449_3 = 1.7

			if 1.7 < arg_446_1.time_ and arg_446_1.time_ <= var_449_3 + arg_449_0 then
				arg_446_1.allBtn_.enabled = false
			end

			if arg_446_1.time_ >= var_449_3 + 0.3 and arg_446_1.time_ < var_449_3 + 0.3 + arg_449_0 then
				arg_446_1.allBtn_.enabled = true
			end

			local var_449_4 = 0

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_4 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_5 = 1.7

			if var_449_4 <= arg_446_1.time_ and arg_446_1.time_ < var_449_4 + var_449_5 then
				local var_449_6 = Color.New(0, 0, 0)

				var_449_6.a = Mathf.Lerp(0, 1, (arg_446_1.time_ - var_449_4) / var_449_5)
				arg_446_1.mask_.color = var_449_6
			end

			if arg_446_1.time_ >= var_449_4 + var_449_5 and arg_446_1.time_ < var_449_4 + var_449_5 + arg_449_0 then
				local var_449_7 = Color.New(0, 0, 0)

				var_449_7.a = 1
				arg_446_1.mask_.color = var_449_7
			end

			local var_449_8 = 1.7

			if 1.7 < arg_446_1.time_ and arg_446_1.time_ <= var_449_8 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_9 = 2

			if var_449_8 <= arg_446_1.time_ and arg_446_1.time_ < var_449_8 + var_449_9 then
				local var_449_10 = Color.New(0, 0, 0)

				var_449_10.a = Mathf.Lerp(1, 0, (arg_446_1.time_ - var_449_8) / var_449_9)
				arg_446_1.mask_.color = var_449_10
			end

			if arg_446_1.time_ >= var_449_8 + var_449_9 and arg_446_1.time_ < var_449_8 + var_449_9 + arg_449_0 then
				local var_449_11 = Color.New(0, 0, 0)

				arg_446_1.mask_.enabled = false
				var_449_11.a = 0
				arg_446_1.mask_.color = var_449_11
			end

			local var_449_12 = arg_446_1.actors_["10039ui_story"].transform

			if 1.7 < arg_446_1.time_ and arg_446_1.time_ <= 1.7 + arg_449_0 then
				arg_446_1.var_.moveOldPos10039ui_story = var_449_12.localPosition
			end

			local var_449_13 = 0.001

			if 1.7 <= arg_446_1.time_ and arg_446_1.time_ < 1.7 + var_449_13 then
				var_449_12.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos10039ui_story, Vector3.New(0, 100, 0), (arg_446_1.time_ - 1.7) / var_449_13)
				var_449_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_449_12.position).x, (manager.ui.mainCamera.transform.position - var_449_12.position).y, (manager.ui.mainCamera.transform.position - var_449_12.position).z)
				var_449_12.localEulerAngles.z = 0
				var_449_12.localEulerAngles.x = 0
				var_449_12.localEulerAngles = var_449_12.localEulerAngles
			end

			if arg_446_1.time_ >= 1.7 + var_449_13 and arg_446_1.time_ < 1.7 + var_449_13 + arg_449_0 then
				var_449_12.localPosition = Vector3.New(0, 100, 0)
				var_449_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_449_12.position).x, (manager.ui.mainCamera.transform.position - var_449_12.position).y, (manager.ui.mainCamera.transform.position - var_449_12.position).z)
				var_449_12.localEulerAngles.z = 0
				var_449_12.localEulerAngles.x = 0
				var_449_12.localEulerAngles = var_449_12.localEulerAngles
			end

			local var_449_14 = arg_446_1.actors_["10039ui_story"]

			if 1.7 < arg_446_1.time_ and arg_446_1.time_ <= 1.7 + arg_449_0 and not isNil(var_449_14) and arg_446_1.var_.characterEffect10039ui_story == nil then
				arg_446_1.var_.characterEffect10039ui_story = var_449_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_15 = 0.200000002980232

			if 1.7 <= arg_446_1.time_ and arg_446_1.time_ < 1.7 + var_449_15 and not isNil(var_449_14) then
				if arg_446_1.var_.characterEffect10039ui_story and not isNil(var_449_14) then
					arg_446_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_446_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_446_1.time_ - 1.7) / var_449_15)
				end
			end

			if arg_446_1.time_ >= 1.7 + var_449_15 and arg_446_1.time_ < 1.7 + var_449_15 + arg_449_0 and not isNil(var_449_14) and arg_446_1.var_.characterEffect10039ui_story then
				arg_446_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_446_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			local var_449_16 = 1.7

			arg_446_1.isInRecall_ = false

			if var_449_16 < arg_446_1.time_ and arg_446_1.time_ <= var_449_16 + arg_449_0 then
				arg_446_1.screenFilterGo_:SetActive(false)

				for iter_449_2, iter_449_3 in pairs(arg_446_1.actors_) do
					for iter_449_4, iter_449_5 in ipairs((iter_449_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_449_5.color = iter_449_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_449_17 = 0.0166666666666667

			if var_449_16 <= arg_446_1.time_ and arg_446_1.time_ < var_449_16 + var_449_17 then
				arg_446_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_446_1.time_ - var_449_16) / var_449_17)
			end

			if arg_446_1.time_ >= var_449_16 + var_449_17 and arg_446_1.time_ < var_449_16 + var_449_17 + arg_449_0 then
				arg_446_1.screenFilterEffect_.weight = 0
			end

			if 1.2 < arg_446_1.time_ and arg_446_1.time_ <= 1.2 + arg_449_0 then
				arg_446_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_ice_cave", "")
			end

			if 0.1 < arg_446_1.time_ and arg_446_1.time_ <= 0.1 + arg_449_0 then
				arg_446_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_446_1.frameCnt_ <= 1 then
				arg_446_1.dialog_:SetActive(false)
			end

			local var_449_20 = 3.4
			local var_449_21 = 0.675

			if 3.4 < arg_446_1.time_ and arg_446_1.time_ <= var_449_20 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0

				arg_446_1.dialog_:SetActive(true)

				arg_446_1.dialogCg_.alpha = 0

				local var_449_22 = LeanTween.value(arg_446_1.dialog_, 0, 1, 0.3)

				var_449_22:setOnUpdate(LuaHelper.FloatAction(function(arg_450_0)
					arg_446_1.dialogCg_.alpha = arg_450_0
				end))
				var_449_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_446_1.dialog_)
					var_449_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_446_1.duration_ = arg_446_1.duration_ + 0.3

				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_23 = arg_446_1:FormatText(arg_446_1:GetWordFromCfg(324121108).content)

				arg_446_1.text_.text = var_449_23

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_25 = 27 <= 0 and var_449_21 or var_449_21 * (utf8.len(var_449_23) / 27)

				if (27 <= 0 and var_449_21 or var_449_21 * (utf8.len(var_449_23) / 27)) > 0 and var_449_21 < var_449_25 then
					arg_446_1.talkMaxDuration = var_449_25
					var_449_20 = var_449_20 + 0.3

					if var_449_25 + var_449_20 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_25 + var_449_20
					end
				end

				arg_446_1.text_.text = var_449_23
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_26 = var_449_20 + 0.3
			local var_449_27 = math.max(var_449_21, arg_446_1.talkMaxDuration)

			if var_449_20 + 0.3 <= arg_446_1.time_ and arg_446_1.time_ < var_449_26 + var_449_27 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_26) / var_449_27

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_26 + var_449_27 and arg_446_1.time_ < var_449_26 + var_449_27 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play324121109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 324121109
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
			arg_452_1.auto_ = false
		end

		function arg_452_1.playNext_(arg_454_0)
			arg_452_1.onStoryFinished_()
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 1.575

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_1 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(324121109).content)

				arg_452_1.text_.text = var_455_1

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_3 = 63 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_1) / 63)

				if (63 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_1) / 63)) > 0 and var_455_0 < var_455_3 then
					arg_452_1.talkMaxDuration = var_455_3

					if var_455_3 + 0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_3 + 0
					end
				end

				arg_452_1.text_.text = var_455_1
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_4 = math.max(var_455_0, arg_452_1.talkMaxDuration)

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_4 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - 0) / var_455_4

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= 0 + var_455_4 and arg_452_1.time_ < 0 + var_455_4 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I17l",
		"TextureConfig/Background/J24g",
		"TextureConfig/Background/ST2005",
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/ST2003"
	},
	voices = {
		"story_v_out_324121.awb"
	}
}
