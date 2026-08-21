return {
	Play930031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 930031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play930031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST60"

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
				local var_4_5 = arg_1_1.bgs_.ST60

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
					if iter_4_0 ~= "ST60" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 1.999999999999

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.8

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(930031001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 32
				local var_4_30 = utf8.len(var_4_28)
				local var_4_31 = var_4_29 <= 0 and var_4_25 or var_4_25 * (var_4_30 / var_4_29)

				if var_4_31 > 0 and var_4_25 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_24 = var_4_24 + 0.3

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_24 + 0.3
			local var_4_33 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_32 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play930031002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 930031002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play930031003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 1.625

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_2 = arg_7_1:GetWordFromCfg(930031002)
				local var_10_3 = arg_7_1:FormatText(var_10_2.content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 67
				local var_10_5 = utf8.len(var_10_3)
				local var_10_6 = var_10_4 <= 0 and var_10_1 or var_10_1 * (var_10_5 / var_10_4)

				if var_10_6 > 0 and var_10_1 < var_10_6 then
					arg_7_1.talkMaxDuration = var_10_6

					if var_10_6 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_6 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_7 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_7 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_7

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_7 and arg_7_1.time_ < var_10_0 + var_10_7 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play930031003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 930031003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play930031004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 1.45

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_2 = arg_11_1:GetWordFromCfg(930031003)
				local var_14_3 = arg_11_1:FormatText(var_14_2.content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_4 = 58
				local var_14_5 = utf8.len(var_14_3)
				local var_14_6 = var_14_4 <= 0 and var_14_1 or var_14_1 * (var_14_5 / var_14_4)

				if var_14_6 > 0 and var_14_1 < var_14_6 then
					arg_11_1.talkMaxDuration = var_14_6

					if var_14_6 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_6 + var_14_0
					end
				end

				arg_11_1.text_.text = var_14_3
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_7 = math.max(var_14_1, arg_11_1.talkMaxDuration)

			if var_14_0 <= arg_11_1.time_ and arg_11_1.time_ < var_14_0 + var_14_7 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_0) / var_14_7

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_0 + var_14_7 and arg_11_1.time_ < var_14_0 + var_14_7 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play930031004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 930031004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play930031005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = "1248ui_story"

			if arg_15_1.actors_[var_18_0] == nil then
				local var_18_1 = Asset.Load("Char/" .. "1248ui_story")

				if not isNil(var_18_1) then
					local var_18_2 = Object.Instantiate(Asset.Load("Char/" .. "1248ui_story"), arg_15_1.stage_.transform)

					var_18_2.name = var_18_0
					var_18_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_15_1.actors_[var_18_0] = var_18_2

					local var_18_3 = var_18_2:GetComponentInChildren(typeof(CharacterEffect))

					var_18_3.enabled = true

					local var_18_4 = GameObjectTools.GetOrAddComponent(var_18_2, typeof(DynamicBoneHelper))

					if var_18_4 then
						var_18_4:EnableDynamicBone(false)
					end

					arg_15_1:ShowWeapon(var_18_3.transform, false)

					arg_15_1.var_[var_18_0 .. "Animator"] = var_18_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_15_1.var_[var_18_0 .. "Animator"].applyRootMotion = true
					arg_15_1.var_[var_18_0 .. "LipSync"] = var_18_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_18_5 = arg_15_1.actors_["1248ui_story"].transform
			local var_18_6 = 0

			if var_18_6 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.var_.moveOldPos1248ui_story = var_18_5.localPosition
			end

			local var_18_7 = 0.001

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_7 then
				local var_18_8 = (arg_15_1.time_ - var_18_6) / var_18_7
				local var_18_9 = Vector3.New(-0.7, -0.775, -6.18)

				var_18_5.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1248ui_story, var_18_9, var_18_8)

				local var_18_10 = manager.ui.mainCamera.transform.position - var_18_5.position

				var_18_5.forward = Vector3.New(var_18_10.x, var_18_10.y, var_18_10.z)

				local var_18_11 = var_18_5.localEulerAngles

				var_18_11.z = 0
				var_18_11.x = 0
				var_18_5.localEulerAngles = var_18_11
			end

			if arg_15_1.time_ >= var_18_6 + var_18_7 and arg_15_1.time_ < var_18_6 + var_18_7 + arg_18_0 then
				var_18_5.localPosition = Vector3.New(-0.7, -0.775, -6.18)

				local var_18_12 = manager.ui.mainCamera.transform.position - var_18_5.position

				var_18_5.forward = Vector3.New(var_18_12.x, var_18_12.y, var_18_12.z)

				local var_18_13 = var_18_5.localEulerAngles

				var_18_13.z = 0
				var_18_13.x = 0
				var_18_5.localEulerAngles = var_18_13
			end

			local var_18_14 = arg_15_1.actors_["1248ui_story"]
			local var_18_15 = 0

			if var_18_15 < arg_15_1.time_ and arg_15_1.time_ <= var_18_15 + arg_18_0 and not isNil(var_18_14) and arg_15_1.var_.characterEffect1248ui_story == nil then
				arg_15_1.var_.characterEffect1248ui_story = var_18_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_16 = 0.200000002980232

			if var_18_15 <= arg_15_1.time_ and arg_15_1.time_ < var_18_15 + var_18_16 and not isNil(var_18_14) then
				local var_18_17 = (arg_15_1.time_ - var_18_15) / var_18_16

				if arg_15_1.var_.characterEffect1248ui_story and not isNil(var_18_14) then
					arg_15_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_15 + var_18_16 and arg_15_1.time_ < var_18_15 + var_18_16 + arg_18_0 and not isNil(var_18_14) and arg_15_1.var_.characterEffect1248ui_story then
				arg_15_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_18_18 = 0

			if var_18_18 < arg_15_1.time_ and arg_15_1.time_ <= var_18_18 + arg_18_0 then
				arg_15_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action4_1")
			end

			local var_18_19 = 0

			if var_18_19 < arg_15_1.time_ and arg_15_1.time_ <= var_18_19 + arg_18_0 then
				arg_15_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_18_20 = 0
			local var_18_21 = 0.475

			if var_18_20 < arg_15_1.time_ and arg_15_1.time_ <= var_18_20 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_22 = arg_15_1:FormatText(StoryNameCfg[8].name)

				arg_15_1.leftNameTxt_.text = var_18_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_23 = arg_15_1:GetWordFromCfg(930031004)
				local var_18_24 = arg_15_1:FormatText(var_18_23.content)

				arg_15_1.text_.text = var_18_24

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_25 = 19
				local var_18_26 = utf8.len(var_18_24)
				local var_18_27 = var_18_25 <= 0 and var_18_21 or var_18_21 * (var_18_26 / var_18_25)

				if var_18_27 > 0 and var_18_21 < var_18_27 then
					arg_15_1.talkMaxDuration = var_18_27

					if var_18_27 + var_18_20 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_27 + var_18_20
					end
				end

				arg_15_1.text_.text = var_18_24
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_28 = math.max(var_18_21, arg_15_1.talkMaxDuration)

			if var_18_20 <= arg_15_1.time_ and arg_15_1.time_ < var_18_20 + var_18_28 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_20) / var_18_28

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_20 + var_18_28 and arg_15_1.time_ < var_18_20 + var_18_28 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play930031005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 930031005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play930031006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = "1044ui_story"

			if arg_19_1.actors_[var_22_0] == nil then
				local var_22_1 = Asset.Load("Char/" .. "1044ui_story")

				if not isNil(var_22_1) then
					local var_22_2 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_19_1.stage_.transform)

					var_22_2.name = var_22_0
					var_22_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_19_1.actors_[var_22_0] = var_22_2

					local var_22_3 = var_22_2:GetComponentInChildren(typeof(CharacterEffect))

					var_22_3.enabled = true

					local var_22_4 = GameObjectTools.GetOrAddComponent(var_22_2, typeof(DynamicBoneHelper))

					if var_22_4 then
						var_22_4:EnableDynamicBone(false)
					end

					arg_19_1:ShowWeapon(var_22_3.transform, false)

					arg_19_1.var_[var_22_0 .. "Animator"] = var_22_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_19_1.var_[var_22_0 .. "Animator"].applyRootMotion = true
					arg_19_1.var_[var_22_0 .. "LipSync"] = var_22_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_22_5 = arg_19_1.actors_["1044ui_story"].transform
			local var_22_6 = 0

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1.var_.moveOldPos1044ui_story = var_22_5.localPosition
			end

			local var_22_7 = 0.001

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_7 then
				local var_22_8 = (arg_19_1.time_ - var_22_6) / var_22_7
				local var_22_9 = Vector3.New(0.7, -1, -5.93)

				var_22_5.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1044ui_story, var_22_9, var_22_8)

				local var_22_10 = manager.ui.mainCamera.transform.position - var_22_5.position

				var_22_5.forward = Vector3.New(var_22_10.x, var_22_10.y, var_22_10.z)

				local var_22_11 = var_22_5.localEulerAngles

				var_22_11.z = 0
				var_22_11.x = 0
				var_22_5.localEulerAngles = var_22_11
			end

			if arg_19_1.time_ >= var_22_6 + var_22_7 and arg_19_1.time_ < var_22_6 + var_22_7 + arg_22_0 then
				var_22_5.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_22_12 = manager.ui.mainCamera.transform.position - var_22_5.position

				var_22_5.forward = Vector3.New(var_22_12.x, var_22_12.y, var_22_12.z)

				local var_22_13 = var_22_5.localEulerAngles

				var_22_13.z = 0
				var_22_13.x = 0
				var_22_5.localEulerAngles = var_22_13
			end

			local var_22_14 = arg_19_1.actors_["1044ui_story"]
			local var_22_15 = 0

			if var_22_15 < arg_19_1.time_ and arg_19_1.time_ <= var_22_15 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect1044ui_story == nil then
				arg_19_1.var_.characterEffect1044ui_story = var_22_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_16 = 0.200000002980232

			if var_22_15 <= arg_19_1.time_ and arg_19_1.time_ < var_22_15 + var_22_16 and not isNil(var_22_14) then
				local var_22_17 = (arg_19_1.time_ - var_22_15) / var_22_16

				if arg_19_1.var_.characterEffect1044ui_story and not isNil(var_22_14) then
					arg_19_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_15 + var_22_16 and arg_19_1.time_ < var_22_15 + var_22_16 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect1044ui_story then
				arg_19_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_22_18 = arg_19_1.actors_["1248ui_story"]
			local var_22_19 = 0

			if var_22_19 < arg_19_1.time_ and arg_19_1.time_ <= var_22_19 + arg_22_0 and not isNil(var_22_18) and arg_19_1.var_.characterEffect1248ui_story == nil then
				arg_19_1.var_.characterEffect1248ui_story = var_22_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_20 = 0.200000002980232

			if var_22_19 <= arg_19_1.time_ and arg_19_1.time_ < var_22_19 + var_22_20 and not isNil(var_22_18) then
				local var_22_21 = (arg_19_1.time_ - var_22_19) / var_22_20

				if arg_19_1.var_.characterEffect1248ui_story and not isNil(var_22_18) then
					local var_22_22 = Mathf.Lerp(0, 0.5, var_22_21)

					arg_19_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1248ui_story.fillRatio = var_22_22
				end
			end

			if arg_19_1.time_ >= var_22_19 + var_22_20 and arg_19_1.time_ < var_22_19 + var_22_20 + arg_22_0 and not isNil(var_22_18) and arg_19_1.var_.characterEffect1248ui_story then
				local var_22_23 = 0.5

				arg_19_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1248ui_story.fillRatio = var_22_23
			end

			local var_22_24 = 0

			if var_22_24 < arg_19_1.time_ and arg_19_1.time_ <= var_22_24 + arg_22_0 then
				arg_19_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_1")
			end

			local var_22_25 = 0

			if var_22_25 < arg_19_1.time_ and arg_19_1.time_ <= var_22_25 + arg_22_0 then
				arg_19_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_22_26 = 0
			local var_22_27 = 0.525

			if var_22_26 < arg_19_1.time_ and arg_19_1.time_ <= var_22_26 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_28 = arg_19_1:FormatText(StoryNameCfg[1367].name)

				arg_19_1.leftNameTxt_.text = var_22_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_29 = arg_19_1:GetWordFromCfg(930031005)
				local var_22_30 = arg_19_1:FormatText(var_22_29.content)

				arg_19_1.text_.text = var_22_30

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_31 = 21
				local var_22_32 = utf8.len(var_22_30)
				local var_22_33 = var_22_31 <= 0 and var_22_27 or var_22_27 * (var_22_32 / var_22_31)

				if var_22_33 > 0 and var_22_27 < var_22_33 then
					arg_19_1.talkMaxDuration = var_22_33

					if var_22_33 + var_22_26 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_33 + var_22_26
					end
				end

				arg_19_1.text_.text = var_22_30
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_34 = math.max(var_22_27, arg_19_1.talkMaxDuration)

			if var_22_26 <= arg_19_1.time_ and arg_19_1.time_ < var_22_26 + var_22_34 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_26) / var_22_34

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_26 + var_22_34 and arg_19_1.time_ < var_22_26 + var_22_34 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play930031006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 930031006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play930031007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1248ui_story"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos1248ui_story = var_26_0.localPosition
			end

			local var_26_2 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2
				local var_26_4 = Vector3.New(-0.7, -0.775, -6.18)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1248ui_story, var_26_4, var_26_3)

				local var_26_5 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_5.x, var_26_5.y, var_26_5.z)

				local var_26_6 = var_26_0.localEulerAngles

				var_26_6.z = 0
				var_26_6.x = 0
				var_26_0.localEulerAngles = var_26_6
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(-0.7, -0.775, -6.18)

				local var_26_7 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_7.x, var_26_7.y, var_26_7.z)

				local var_26_8 = var_26_0.localEulerAngles

				var_26_8.z = 0
				var_26_8.x = 0
				var_26_0.localEulerAngles = var_26_8
			end

			local var_26_9 = arg_23_1.actors_["1248ui_story"]
			local var_26_10 = 0

			if var_26_10 < arg_23_1.time_ and arg_23_1.time_ <= var_26_10 + arg_26_0 and not isNil(var_26_9) and arg_23_1.var_.characterEffect1248ui_story == nil then
				arg_23_1.var_.characterEffect1248ui_story = var_26_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_11 = 0.200000002980232

			if var_26_10 <= arg_23_1.time_ and arg_23_1.time_ < var_26_10 + var_26_11 and not isNil(var_26_9) then
				local var_26_12 = (arg_23_1.time_ - var_26_10) / var_26_11

				if arg_23_1.var_.characterEffect1248ui_story and not isNil(var_26_9) then
					arg_23_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_10 + var_26_11 and arg_23_1.time_ < var_26_10 + var_26_11 + arg_26_0 and not isNil(var_26_9) and arg_23_1.var_.characterEffect1248ui_story then
				arg_23_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_26_13 = arg_23_1.actors_["1044ui_story"]
			local var_26_14 = 0

			if var_26_14 < arg_23_1.time_ and arg_23_1.time_ <= var_26_14 + arg_26_0 and not isNil(var_26_13) and arg_23_1.var_.characterEffect1044ui_story == nil then
				arg_23_1.var_.characterEffect1044ui_story = var_26_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_15 = 0.200000002980232

			if var_26_14 <= arg_23_1.time_ and arg_23_1.time_ < var_26_14 + var_26_15 and not isNil(var_26_13) then
				local var_26_16 = (arg_23_1.time_ - var_26_14) / var_26_15

				if arg_23_1.var_.characterEffect1044ui_story and not isNil(var_26_13) then
					local var_26_17 = Mathf.Lerp(0, 0.5, var_26_16)

					arg_23_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1044ui_story.fillRatio = var_26_17
				end
			end

			if arg_23_1.time_ >= var_26_14 + var_26_15 and arg_23_1.time_ < var_26_14 + var_26_15 + arg_26_0 and not isNil(var_26_13) and arg_23_1.var_.characterEffect1044ui_story then
				local var_26_18 = 0.5

				arg_23_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1044ui_story.fillRatio = var_26_18
			end

			local var_26_19 = 0

			if var_26_19 < arg_23_1.time_ and arg_23_1.time_ <= var_26_19 + arg_26_0 then
				arg_23_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248actionlink/1248action443")
			end

			local var_26_20 = 0

			if var_26_20 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 then
				arg_23_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_26_21 = 0
			local var_26_22 = 0.35

			if var_26_21 < arg_23_1.time_ and arg_23_1.time_ <= var_26_21 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_23 = arg_23_1:FormatText(StoryNameCfg[8].name)

				arg_23_1.leftNameTxt_.text = var_26_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_24 = arg_23_1:GetWordFromCfg(930031006)
				local var_26_25 = arg_23_1:FormatText(var_26_24.content)

				arg_23_1.text_.text = var_26_25

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_26 = 14
				local var_26_27 = utf8.len(var_26_25)
				local var_26_28 = var_26_26 <= 0 and var_26_22 or var_26_22 * (var_26_27 / var_26_26)

				if var_26_28 > 0 and var_26_22 < var_26_28 then
					arg_23_1.talkMaxDuration = var_26_28

					if var_26_28 + var_26_21 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_28 + var_26_21
					end
				end

				arg_23_1.text_.text = var_26_25
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_29 = math.max(var_26_22, arg_23_1.talkMaxDuration)

			if var_26_21 <= arg_23_1.time_ and arg_23_1.time_ < var_26_21 + var_26_29 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_21) / var_26_29

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_21 + var_26_29 and arg_23_1.time_ < var_26_21 + var_26_29 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
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
	Play930031007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 930031007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
			arg_27_1.auto_ = false
		end

		function arg_27_1.playNext_(arg_29_0)
			arg_27_1.onStoryFinished_()
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1044ui_story"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1044ui_story == nil then
				arg_27_1.var_.characterEffect1044ui_story = var_30_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.characterEffect1044ui_story and not isNil(var_30_0) then
					arg_27_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.characterEffect1044ui_story then
				arg_27_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_30_4 = arg_27_1.actors_["1248ui_story"]
			local var_30_5 = 0

			if var_30_5 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1248ui_story == nil then
				arg_27_1.var_.characterEffect1248ui_story = var_30_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_6 = 0.200000002980232

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_6 and not isNil(var_30_4) then
				local var_30_7 = (arg_27_1.time_ - var_30_5) / var_30_6

				if arg_27_1.var_.characterEffect1248ui_story and not isNil(var_30_4) then
					arg_27_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_5 + var_30_6 and arg_27_1.time_ < var_30_5 + var_30_6 + arg_30_0 and not isNil(var_30_4) and arg_27_1.var_.characterEffect1248ui_story then
				arg_27_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_30_8 = 0

			if var_30_8 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_2")
			end

			local var_30_9 = 0

			if var_30_9 < arg_27_1.time_ and arg_27_1.time_ <= var_30_9 + arg_30_0 then
				arg_27_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_30_10 = 0
			local var_30_11 = 0.125

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_12 = arg_27_1:FormatText(StoryNameCfg[1416].name)

				arg_27_1.leftNameTxt_.text = var_30_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_13 = arg_27_1:GetWordFromCfg(930031007)
				local var_30_14 = arg_27_1:FormatText(var_30_13.content)

				arg_27_1.text_.text = var_30_14

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_15 = 5
				local var_30_16 = utf8.len(var_30_14)
				local var_30_17 = var_30_15 <= 0 and var_30_11 or var_30_11 * (var_30_16 / var_30_15)

				if var_30_17 > 0 and var_30_11 < var_30_17 then
					arg_27_1.talkMaxDuration = var_30_17

					if var_30_17 + var_30_10 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_17 + var_30_10
					end
				end

				arg_27_1.text_.text = var_30_14
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_18 = math.max(var_30_11, arg_27_1.talkMaxDuration)

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_18 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_10) / var_30_18

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_10 + var_30_18 and arg_27_1.time_ < var_30_10 + var_30_18 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST60"
	},
	voices = {}
}
