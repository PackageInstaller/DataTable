return {
	Play324081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324081001
		arg_1_1.duration_ = 5.47

		local var_1_0 = {
			zh = 4.46666666666667,
			ja = 5.46666666666667
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J27f"

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
				local var_4_5 = arg_1_1.bgs_.J27f

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
					if iter_4_0 ~= "J27f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = "1070ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1070ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_1_1.stage_.transform)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentInChildren(typeof(CharacterEffect))

					var_4_27.enabled = true

					local var_4_28 = GameObjectTools.GetOrAddComponent(var_4_26, typeof(DynamicBoneHelper))

					if var_4_28 then
						var_4_28:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_27.transform, false)

					arg_1_1.var_[var_4_24 .. "Animator"] = var_4_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_24 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_24 .. "LipSync"] = var_4_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_29 = arg_1_1.actors_["1070ui_story"]
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1070ui_story == nil then
				arg_1_1.var_.characterEffect1070ui_story = var_4_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_31 = 0.200000002980232

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 and not isNil(var_4_29) then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31

				if arg_1_1.var_.characterEffect1070ui_story and not isNil(var_4_29) then
					arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1070ui_story then
				arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_4_33 = 0.1
			local var_4_34 = 1

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "effect"

				arg_1_1:AudioAction(var_4_35, var_4_36, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_4_37 = 0
			local var_4_38 = 1

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_39 = "play"
				local var_4_40 = "effect"

				arg_1_1:AudioAction(var_4_39, var_4_40, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_41 = 1.86666666666667
			local var_4_42 = 0.25

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_43 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_43:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_44 = arg_1_1:FormatText(StoryNameCfg[318].name)

				arg_1_1.leftNameTxt_.text = var_4_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_45 = arg_1_1:GetWordFromCfg(324081001)
				local var_4_46 = arg_1_1:FormatText(var_4_45.content)

				arg_1_1.text_.text = var_4_46

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_47 = 10
				local var_4_48 = utf8.len(var_4_46)
				local var_4_49 = var_4_47 <= 0 and var_4_42 or var_4_42 * (var_4_48 / var_4_47)

				if var_4_49 > 0 and var_4_42 < var_4_49 then
					arg_1_1.talkMaxDuration = var_4_49
					var_4_41 = var_4_41 + 0.3

					if var_4_49 + var_4_41 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_49 + var_4_41
					end
				end

				arg_1_1.text_.text = var_4_46
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081001", "story_v_out_324081.awb") ~= 0 then
					local var_4_50 = manager.audio:GetVoiceLength("story_v_out_324081", "324081001", "story_v_out_324081.awb") / 1000

					if var_4_50 + var_4_41 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_50 + var_4_41
					end

					if var_4_45.prefab_name ~= "" and arg_1_1.actors_[var_4_45.prefab_name] ~= nil then
						local var_4_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_45.prefab_name].transform, "story_v_out_324081", "324081001", "story_v_out_324081.awb")

						arg_1_1:RecordAudio("324081001", var_4_51)
						arg_1_1:RecordAudio("324081001", var_4_51)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324081", "324081001", "story_v_out_324081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324081", "324081001", "story_v_out_324081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_52 = var_4_41 + 0.3
			local var_4_53 = math.max(var_4_42, arg_1_1.talkMaxDuration)

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_53 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_52) / var_4_53

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324081002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 324081002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play324081003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = arg_7_1.actors_["1070ui_story"]
			local var_10_1 = 0

			if var_10_1 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 and not isNil(var_10_0) and arg_7_1.var_.characterEffect1070ui_story == nil then
				arg_7_1.var_.characterEffect1070ui_story = var_10_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_2 = 0.200000002980232

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_2 and not isNil(var_10_0) then
				local var_10_3 = (arg_7_1.time_ - var_10_1) / var_10_2

				if arg_7_1.var_.characterEffect1070ui_story and not isNil(var_10_0) then
					local var_10_4 = Mathf.Lerp(0, 0.5, var_10_3)

					arg_7_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1070ui_story.fillRatio = var_10_4
				end
			end

			if arg_7_1.time_ >= var_10_1 + var_10_2 and arg_7_1.time_ < var_10_1 + var_10_2 + arg_10_0 and not isNil(var_10_0) and arg_7_1.var_.characterEffect1070ui_story then
				local var_10_5 = 0.5

				arg_7_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1070ui_story.fillRatio = var_10_5
			end

			local var_10_6 = 0
			local var_10_7 = 1.625

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_8 = arg_7_1:GetWordFromCfg(324081002)
				local var_10_9 = arg_7_1:FormatText(var_10_8.content)

				arg_7_1.text_.text = var_10_9

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_10 = 65
				local var_10_11 = utf8.len(var_10_9)
				local var_10_12 = var_10_10 <= 0 and var_10_7 or var_10_7 * (var_10_11 / var_10_10)

				if var_10_12 > 0 and var_10_7 < var_10_12 then
					arg_7_1.talkMaxDuration = var_10_12

					if var_10_12 + var_10_6 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_12 + var_10_6
					end
				end

				arg_7_1.text_.text = var_10_9
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_13 = math.max(var_10_7, arg_7_1.talkMaxDuration)

			if var_10_6 <= arg_7_1.time_ and arg_7_1.time_ < var_10_6 + var_10_13 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_6) / var_10_13

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_6 + var_10_13 and arg_7_1.time_ < var_10_6 + var_10_13 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play324081003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 324081003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play324081004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 1.15

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

				local var_14_2 = arg_11_1:GetWordFromCfg(324081003)
				local var_14_3 = arg_11_1:FormatText(var_14_2.content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_4 = 46
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
	Play324081004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 324081004
		arg_15_1.duration_ = 3.47

		local var_15_0 = {
			zh = 2.133,
			ja = 3.466
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play324081005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["1070ui_story"].transform
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.var_.moveOldPos1070ui_story = var_18_0.localPosition
			end

			local var_18_2 = 0.001

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2
				local var_18_4 = Vector3.New(0, -0.95, -6.05)

				var_18_0.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1070ui_story, var_18_4, var_18_3)

				local var_18_5 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_5.x, var_18_5.y, var_18_5.z)

				local var_18_6 = var_18_0.localEulerAngles

				var_18_6.z = 0
				var_18_6.x = 0
				var_18_0.localEulerAngles = var_18_6
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 then
				var_18_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_18_7 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_7.x, var_18_7.y, var_18_7.z)

				local var_18_8 = var_18_0.localEulerAngles

				var_18_8.z = 0
				var_18_8.x = 0
				var_18_0.localEulerAngles = var_18_8
			end

			local var_18_9 = arg_15_1.actors_["1070ui_story"]
			local var_18_10 = 0

			if var_18_10 < arg_15_1.time_ and arg_15_1.time_ <= var_18_10 + arg_18_0 and not isNil(var_18_9) and arg_15_1.var_.characterEffect1070ui_story == nil then
				arg_15_1.var_.characterEffect1070ui_story = var_18_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_11 = 0.200000002980232

			if var_18_10 <= arg_15_1.time_ and arg_15_1.time_ < var_18_10 + var_18_11 and not isNil(var_18_9) then
				local var_18_12 = (arg_15_1.time_ - var_18_10) / var_18_11

				if arg_15_1.var_.characterEffect1070ui_story and not isNil(var_18_9) then
					arg_15_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_10 + var_18_11 and arg_15_1.time_ < var_18_10 + var_18_11 + arg_18_0 and not isNil(var_18_9) and arg_15_1.var_.characterEffect1070ui_story then
				arg_15_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_18_13 = 0

			if var_18_13 < arg_15_1.time_ and arg_15_1.time_ <= var_18_13 + arg_18_0 then
				arg_15_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_18_14 = 0

			if var_18_14 < arg_15_1.time_ and arg_15_1.time_ <= var_18_14 + arg_18_0 then
				arg_15_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_18_15 = 0
			local var_18_16 = 0.2

			if var_18_15 < arg_15_1.time_ and arg_15_1.time_ <= var_18_15 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_17 = arg_15_1:FormatText(StoryNameCfg[318].name)

				arg_15_1.leftNameTxt_.text = var_18_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_18 = arg_15_1:GetWordFromCfg(324081004)
				local var_18_19 = arg_15_1:FormatText(var_18_18.content)

				arg_15_1.text_.text = var_18_19

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_20 = 8
				local var_18_21 = utf8.len(var_18_19)
				local var_18_22 = var_18_20 <= 0 and var_18_16 or var_18_16 * (var_18_21 / var_18_20)

				if var_18_22 > 0 and var_18_16 < var_18_22 then
					arg_15_1.talkMaxDuration = var_18_22

					if var_18_22 + var_18_15 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_22 + var_18_15
					end
				end

				arg_15_1.text_.text = var_18_19
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081004", "story_v_out_324081.awb") ~= 0 then
					local var_18_23 = manager.audio:GetVoiceLength("story_v_out_324081", "324081004", "story_v_out_324081.awb") / 1000

					if var_18_23 + var_18_15 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_23 + var_18_15
					end

					if var_18_18.prefab_name ~= "" and arg_15_1.actors_[var_18_18.prefab_name] ~= nil then
						local var_18_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_18.prefab_name].transform, "story_v_out_324081", "324081004", "story_v_out_324081.awb")

						arg_15_1:RecordAudio("324081004", var_18_24)
						arg_15_1:RecordAudio("324081004", var_18_24)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_324081", "324081004", "story_v_out_324081.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_324081", "324081004", "story_v_out_324081.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_25 = math.max(var_18_16, arg_15_1.talkMaxDuration)

			if var_18_15 <= arg_15_1.time_ and arg_15_1.time_ < var_18_15 + var_18_25 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_15) / var_18_25

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_15 + var_18_25 and arg_15_1.time_ < var_18_15 + var_18_25 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
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

		arg_15_1:InitPlayNodeList()
	end,
	Play324081005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 324081005
		arg_19_1.duration_ = 2.9

		local var_19_0 = {
			zh = 2.4,
			ja = 2.9
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
				arg_19_0:Play324081006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			local var_22_1 = 0.1
			local var_22_2 = 1

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				local var_22_3 = "play"
				local var_22_4 = "effect"

				arg_19_1:AudioAction(var_22_3, var_22_4, "se_story_141", "se_story_141_sword_wing01", "")
			end

			local var_22_5 = 0
			local var_22_6 = 0.225

			if var_22_5 < arg_19_1.time_ and arg_19_1.time_ <= var_22_5 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_7 = arg_19_1:FormatText(StoryNameCfg[318].name)

				arg_19_1.leftNameTxt_.text = var_22_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_8 = arg_19_1:GetWordFromCfg(324081005)
				local var_22_9 = arg_19_1:FormatText(var_22_8.content)

				arg_19_1.text_.text = var_22_9

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_10 = 9
				local var_22_11 = utf8.len(var_22_9)
				local var_22_12 = var_22_10 <= 0 and var_22_6 or var_22_6 * (var_22_11 / var_22_10)

				if var_22_12 > 0 and var_22_6 < var_22_12 then
					arg_19_1.talkMaxDuration = var_22_12

					if var_22_12 + var_22_5 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_12 + var_22_5
					end
				end

				arg_19_1.text_.text = var_22_9
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081005", "story_v_out_324081.awb") ~= 0 then
					local var_22_13 = manager.audio:GetVoiceLength("story_v_out_324081", "324081005", "story_v_out_324081.awb") / 1000

					if var_22_13 + var_22_5 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_13 + var_22_5
					end

					if var_22_8.prefab_name ~= "" and arg_19_1.actors_[var_22_8.prefab_name] ~= nil then
						local var_22_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_8.prefab_name].transform, "story_v_out_324081", "324081005", "story_v_out_324081.awb")

						arg_19_1:RecordAudio("324081005", var_22_14)
						arg_19_1:RecordAudio("324081005", var_22_14)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_324081", "324081005", "story_v_out_324081.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_324081", "324081005", "story_v_out_324081.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_15 = math.max(var_22_6, arg_19_1.talkMaxDuration)

			if var_22_5 <= arg_19_1.time_ and arg_19_1.time_ < var_22_5 + var_22_15 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_5) / var_22_15

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_5 + var_22_15 and arg_19_1.time_ < var_22_5 + var_22_15 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play324081006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 324081006
		arg_23_1.duration_ = 6.4

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play324081007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1070ui_story"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos1070ui_story = var_26_0.localPosition
			end

			local var_26_2 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2
				local var_26_4 = Vector3.New(0, 100, 0)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1070ui_story, var_26_4, var_26_3)

				local var_26_5 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_5.x, var_26_5.y, var_26_5.z)

				local var_26_6 = var_26_0.localEulerAngles

				var_26_6.z = 0
				var_26_6.x = 0
				var_26_0.localEulerAngles = var_26_6
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(0, 100, 0)

				local var_26_7 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_7.x, var_26_7.y, var_26_7.z)

				local var_26_8 = var_26_0.localEulerAngles

				var_26_8.z = 0
				var_26_8.x = 0
				var_26_0.localEulerAngles = var_26_8
			end

			local var_26_9 = arg_23_1.actors_["1070ui_story"]
			local var_26_10 = 0

			if var_26_10 < arg_23_1.time_ and arg_23_1.time_ <= var_26_10 + arg_26_0 and not isNil(var_26_9) and arg_23_1.var_.characterEffect1070ui_story == nil then
				arg_23_1.var_.characterEffect1070ui_story = var_26_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_11 = 0.200000002980232

			if var_26_10 <= arg_23_1.time_ and arg_23_1.time_ < var_26_10 + var_26_11 and not isNil(var_26_9) then
				local var_26_12 = (arg_23_1.time_ - var_26_10) / var_26_11

				if arg_23_1.var_.characterEffect1070ui_story and not isNil(var_26_9) then
					local var_26_13 = Mathf.Lerp(0, 0.5, var_26_12)

					arg_23_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1070ui_story.fillRatio = var_26_13
				end
			end

			if arg_23_1.time_ >= var_26_10 + var_26_11 and arg_23_1.time_ < var_26_10 + var_26_11 + arg_26_0 and not isNil(var_26_9) and arg_23_1.var_.characterEffect1070ui_story then
				local var_26_14 = 0.5

				arg_23_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1070ui_story.fillRatio = var_26_14
			end

			local var_26_15 = manager.ui.mainCamera.transform
			local var_26_16 = 0

			if var_26_16 < arg_23_1.time_ and arg_23_1.time_ <= var_26_16 + arg_26_0 then
				local var_26_17 = arg_23_1.var_.effect323
				local var_26_18
				local var_26_19 = var_26_15

				if not var_26_17 then
					var_26_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), var_26_19)
					var_26_17.name = "323"
					arg_23_1.var_.effect323 = var_26_17
				else
					var_26_17.transform:SetParent(var_26_19)
				end

				var_26_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_26_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_26_20 = arg_23_1.bgs_.J27f.transform
			local var_26_21 = 0

			if var_26_21 < arg_23_1.time_ and arg_23_1.time_ <= var_26_21 + arg_26_0 then
				arg_23_1.var_.moveOldPosJ27f = var_26_20.localPosition
			end

			local var_26_22 = 1.79166666666667

			if var_26_21 <= arg_23_1.time_ and arg_23_1.time_ < var_26_21 + var_26_22 then
				local var_26_23 = (arg_23_1.time_ - var_26_21) / var_26_22
				local var_26_24 = Vector3.New(0, 1, 10)

				var_26_20.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPosJ27f, var_26_24, var_26_23)
			end

			if arg_23_1.time_ >= var_26_21 + var_26_22 and arg_23_1.time_ < var_26_21 + var_26_22 + arg_26_0 then
				var_26_20.localPosition = Vector3.New(0, 1, 10)
			end

			local var_26_25 = 0.1
			local var_26_26 = 1

			if var_26_25 < arg_23_1.time_ and arg_23_1.time_ <= var_26_25 + arg_26_0 then
				local var_26_27 = "play"
				local var_26_28 = "effect"

				arg_23_1:AudioAction(var_26_27, var_26_28, "se_story_1311", "se_story_1311_wind_parachuting", "")
			end

			if arg_23_1.frameCnt_ <= 1 then
				arg_23_1.dialog_:SetActive(false)
			end

			local var_26_29 = 1.4
			local var_26_30 = 0.7

			if var_26_29 < arg_23_1.time_ and arg_23_1.time_ <= var_26_29 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				arg_23_1.dialog_:SetActive(true)

				arg_23_1.dialogCg_.alpha = 0

				local var_26_31 = LeanTween.value(arg_23_1.dialog_, 0, 1, 0.3)

				var_26_31:setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
					arg_23_1.dialogCg_.alpha = arg_27_0
				end))
				var_26_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_23_1.dialog_)
					var_26_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_23_1.duration_ = arg_23_1.duration_ + 0.3

				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_32 = arg_23_1:GetWordFromCfg(324081006)
				local var_26_33 = arg_23_1:FormatText(var_26_32.content)

				arg_23_1.text_.text = var_26_33

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_34 = 28
				local var_26_35 = utf8.len(var_26_33)
				local var_26_36 = var_26_34 <= 0 and var_26_30 or var_26_30 * (var_26_35 / var_26_34)

				if var_26_36 > 0 and var_26_30 < var_26_36 then
					arg_23_1.talkMaxDuration = var_26_36
					var_26_29 = var_26_29 + 0.3

					if var_26_36 + var_26_29 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_36 + var_26_29
					end
				end

				arg_23_1.text_.text = var_26_33
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_37 = var_26_29 + 0.3
			local var_26_38 = math.max(var_26_30, arg_23_1.talkMaxDuration)

			if var_26_37 <= arg_23_1.time_ and arg_23_1.time_ < var_26_37 + var_26_38 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_37) / var_26_38

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_37 + var_26_38 and arg_23_1.time_ < var_26_37 + var_26_38 + arg_26_0 then
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
				needEase = true,
				actorName = "J27f",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.79166666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 7.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play324081007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 324081007
		arg_29_1.duration_ = 3.73

		local var_29_0 = {
			zh = 3.43333333333333,
			ja = 3.73333333333333
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play324081008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = "STblack"

			if arg_29_1.bgs_[var_32_0] == nil then
				local var_32_1 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_32_0)
				var_32_1.name = var_32_0
				var_32_1.transform.parent = arg_29_1.stage_.transform
				var_32_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_[var_32_0] = var_32_1
			end

			local var_32_2 = 1.2

			if var_32_2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				local var_32_3 = manager.ui.mainCamera.transform.localPosition
				local var_32_4 = Vector3.New(0, 0, 10) + Vector3.New(var_32_3.x, var_32_3.y, 0)
				local var_32_5 = arg_29_1.bgs_.STblack

				var_32_5.transform.localPosition = var_32_4
				var_32_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_6 = var_32_5:GetComponent("SpriteRenderer")

				if var_32_6 and var_32_6.sprite then
					local var_32_7 = (var_32_5.transform.localPosition - var_32_3).z
					local var_32_8 = manager.ui.mainCameraCom_
					local var_32_9 = 2 * var_32_7 * Mathf.Tan(var_32_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_32_10 = var_32_9 * var_32_8.aspect
					local var_32_11 = var_32_6.sprite.bounds.size.x
					local var_32_12 = var_32_6.sprite.bounds.size.y
					local var_32_13 = var_32_10 / var_32_11
					local var_32_14 = var_32_9 / var_32_12
					local var_32_15 = var_32_14 < var_32_13 and var_32_13 or var_32_14

					var_32_5.transform.localScale = Vector3.New(var_32_15, var_32_15, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "STblack" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_16 = 1.2

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			local var_32_17 = 0.3

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_18 = 0

			if var_32_18 < arg_29_1.time_ and arg_29_1.time_ <= var_32_18 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_19 = 1.2

			if var_32_18 <= arg_29_1.time_ and arg_29_1.time_ < var_32_18 + var_32_19 then
				local var_32_20 = (arg_29_1.time_ - var_32_18) / var_32_19
				local var_32_21 = Color.New(0, 0, 0)

				var_32_21.a = Mathf.Lerp(0, 1, var_32_20)
				arg_29_1.mask_.color = var_32_21
			end

			if arg_29_1.time_ >= var_32_18 + var_32_19 and arg_29_1.time_ < var_32_18 + var_32_19 + arg_32_0 then
				local var_32_22 = Color.New(0, 0, 0)

				var_32_22.a = 1
				arg_29_1.mask_.color = var_32_22
			end

			local var_32_23 = 1.20000000298023

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_24 = 2

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_24 then
				local var_32_25 = (arg_29_1.time_ - var_32_23) / var_32_24
				local var_32_26 = Color.New(0, 0, 0)

				var_32_26.a = Mathf.Lerp(1, 0, var_32_25)
				arg_29_1.mask_.color = var_32_26
			end

			if arg_29_1.time_ >= var_32_23 + var_32_24 and arg_29_1.time_ < var_32_23 + var_32_24 + arg_32_0 then
				local var_32_27 = Color.New(0, 0, 0)
				local var_32_28 = 0

				arg_29_1.mask_.enabled = false
				var_32_27.a = var_32_28
				arg_29_1.mask_.color = var_32_27
			end

			local var_32_29 = arg_29_1.actors_["1070ui_story"]
			local var_32_30 = 1.2

			if var_32_30 < arg_29_1.time_ and arg_29_1.time_ <= var_32_30 + arg_32_0 and not isNil(var_32_29) and arg_29_1.var_.characterEffect1070ui_story == nil then
				arg_29_1.var_.characterEffect1070ui_story = var_32_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_31 = 0.200000002980232

			if var_32_30 <= arg_29_1.time_ and arg_29_1.time_ < var_32_30 + var_32_31 and not isNil(var_32_29) then
				local var_32_32 = (arg_29_1.time_ - var_32_30) / var_32_31

				if arg_29_1.var_.characterEffect1070ui_story and not isNil(var_32_29) then
					arg_29_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_30 + var_32_31 and arg_29_1.time_ < var_32_30 + var_32_31 + arg_32_0 and not isNil(var_32_29) and arg_29_1.var_.characterEffect1070ui_story then
				arg_29_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_32_33 = manager.ui.mainCamera.transform
			local var_32_34 = 1.2

			if var_32_34 < arg_29_1.time_ and arg_29_1.time_ <= var_32_34 + arg_32_0 then
				local var_32_35 = arg_29_1.var_.effect323

				if var_32_35 then
					Object.Destroy(var_32_35)

					arg_29_1.var_.effect323 = nil
				end
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_36 = 2.43333333333333
			local var_32_37 = 0.05

			if var_32_36 < arg_29_1.time_ and arg_29_1.time_ <= var_32_36 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_38 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_38:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_39 = arg_29_1:FormatText(StoryNameCfg[318].name)

				arg_29_1.leftNameTxt_.text = var_32_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_40 = arg_29_1:GetWordFromCfg(324081007)
				local var_32_41 = arg_29_1:FormatText(var_32_40.content)

				arg_29_1.text_.text = var_32_41

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_42 = 2
				local var_32_43 = utf8.len(var_32_41)
				local var_32_44 = var_32_42 <= 0 and var_32_37 or var_32_37 * (var_32_43 / var_32_42)

				if var_32_44 > 0 and var_32_37 < var_32_44 then
					arg_29_1.talkMaxDuration = var_32_44
					var_32_36 = var_32_36 + 0.3

					if var_32_44 + var_32_36 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_44 + var_32_36
					end
				end

				arg_29_1.text_.text = var_32_41
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081007", "story_v_out_324081.awb") ~= 0 then
					local var_32_45 = manager.audio:GetVoiceLength("story_v_out_324081", "324081007", "story_v_out_324081.awb") / 1000

					if var_32_45 + var_32_36 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_45 + var_32_36
					end

					if var_32_40.prefab_name ~= "" and arg_29_1.actors_[var_32_40.prefab_name] ~= nil then
						local var_32_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_40.prefab_name].transform, "story_v_out_324081", "324081007", "story_v_out_324081.awb")

						arg_29_1:RecordAudio("324081007", var_32_46)
						arg_29_1:RecordAudio("324081007", var_32_46)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_324081", "324081007", "story_v_out_324081.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_324081", "324081007", "story_v_out_324081.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_47 = var_32_36 + 0.3
			local var_32_48 = math.max(var_32_37, arg_29_1.talkMaxDuration)

			if var_32_47 <= arg_29_1.time_ and arg_29_1.time_ < var_32_47 + var_32_48 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_47) / var_32_48

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_47 + var_32_48 and arg_29_1.time_ < var_32_47 + var_32_48 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play324081008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 324081008
		arg_35_1.duration_ = 1

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play324081009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.05

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[318].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:GetWordFromCfg(324081008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 2
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081008", "story_v_out_324081.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081008", "story_v_out_324081.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_324081", "324081008", "story_v_out_324081.awb")

						arg_35_1:RecordAudio("324081008", var_38_9)
						arg_35_1:RecordAudio("324081008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_324081", "324081008", "story_v_out_324081.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_324081", "324081008", "story_v_out_324081.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_10 and arg_35_1.time_ < var_38_0 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play324081009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 324081009
		arg_39_1.duration_ = 2.3

		local var_39_0 = {
			zh = 1.166,
			ja = 2.3
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
				arg_39_0:Play324081010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.1
			local var_42_1 = 1

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				local var_42_2 = "play"
				local var_42_3 = "effect"

				arg_39_1:AudioAction(var_42_2, var_42_3, "se_story_150", "se_story_150_fall_down", "")
			end

			local var_42_4 = 0
			local var_42_5 = 0.1

			if var_42_4 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_6 = arg_39_1:FormatText(StoryNameCfg[318].name)

				arg_39_1.leftNameTxt_.text = var_42_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_7 = arg_39_1:GetWordFromCfg(324081009)
				local var_42_8 = arg_39_1:FormatText(var_42_7.content)

				arg_39_1.text_.text = var_42_8

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 4
				local var_42_10 = utf8.len(var_42_8)
				local var_42_11 = var_42_9 <= 0 and var_42_5 or var_42_5 * (var_42_10 / var_42_9)

				if var_42_11 > 0 and var_42_5 < var_42_11 then
					arg_39_1.talkMaxDuration = var_42_11

					if var_42_11 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_11 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_8
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081009", "story_v_out_324081.awb") ~= 0 then
					local var_42_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081009", "story_v_out_324081.awb") / 1000

					if var_42_12 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_12 + var_42_4
					end

					if var_42_7.prefab_name ~= "" and arg_39_1.actors_[var_42_7.prefab_name] ~= nil then
						local var_42_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_7.prefab_name].transform, "story_v_out_324081", "324081009", "story_v_out_324081.awb")

						arg_39_1:RecordAudio("324081009", var_42_13)
						arg_39_1:RecordAudio("324081009", var_42_13)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_324081", "324081009", "story_v_out_324081.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_324081", "324081009", "story_v_out_324081.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_14 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_14 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_14

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_14 and arg_39_1.time_ < var_42_4 + var_42_14 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play324081010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 324081010
		arg_43_1.duration_ = 1.93

		local var_43_0 = {
			zh = 1.933,
			ja = 1.466
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play324081011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = "10171ui_story"

			if arg_43_1.actors_[var_46_0] == nil then
				local var_46_1 = Asset.Load("Char/" .. "10171ui_story")

				if not isNil(var_46_1) then
					local var_46_2 = Object.Instantiate(Asset.Load("Char/" .. "10171ui_story"), arg_43_1.stage_.transform)

					var_46_2.name = var_46_0
					var_46_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_43_1.actors_[var_46_0] = var_46_2

					local var_46_3 = var_46_2:GetComponentInChildren(typeof(CharacterEffect))

					var_46_3.enabled = true

					local var_46_4 = GameObjectTools.GetOrAddComponent(var_46_2, typeof(DynamicBoneHelper))

					if var_46_4 then
						var_46_4:EnableDynamicBone(false)
					end

					arg_43_1:ShowWeapon(var_46_3.transform, false)

					arg_43_1.var_[var_46_0 .. "Animator"] = var_46_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_43_1.var_[var_46_0 .. "Animator"].applyRootMotion = true
					arg_43_1.var_[var_46_0 .. "LipSync"] = var_46_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_46_5 = arg_43_1.actors_["10171ui_story"]
			local var_46_6 = 0

			if var_46_6 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.characterEffect10171ui_story == nil then
				arg_43_1.var_.characterEffect10171ui_story = var_46_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_7 = 0.200000002980232

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_7 and not isNil(var_46_5) then
				local var_46_8 = (arg_43_1.time_ - var_46_6) / var_46_7

				if arg_43_1.var_.characterEffect10171ui_story and not isNil(var_46_5) then
					arg_43_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_6 + var_46_7 and arg_43_1.time_ < var_46_6 + var_46_7 + arg_46_0 and not isNil(var_46_5) and arg_43_1.var_.characterEffect10171ui_story then
				arg_43_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_46_9 = arg_43_1.actors_["1070ui_story"]
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1070ui_story == nil then
				arg_43_1.var_.characterEffect1070ui_story = var_46_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_11 = 0.200000002980232

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 and not isNil(var_46_9) then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11

				if arg_43_1.var_.characterEffect1070ui_story and not isNil(var_46_9) then
					local var_46_13 = Mathf.Lerp(0, 0.5, var_46_12)

					arg_43_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1070ui_story.fillRatio = var_46_13
				end
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 and not isNil(var_46_9) and arg_43_1.var_.characterEffect1070ui_story then
				local var_46_14 = 0.5

				arg_43_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1070ui_story.fillRatio = var_46_14
			end

			local var_46_15 = 0
			local var_46_16 = 0.1

			if var_46_15 < arg_43_1.time_ and arg_43_1.time_ <= var_46_15 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_17 = arg_43_1:FormatText(StoryNameCfg[1451].name)

				arg_43_1.leftNameTxt_.text = var_46_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_18 = arg_43_1:GetWordFromCfg(324081010)
				local var_46_19 = arg_43_1:FormatText(var_46_18.content)

				arg_43_1.text_.text = var_46_19

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_20 = 4
				local var_46_21 = utf8.len(var_46_19)
				local var_46_22 = var_46_20 <= 0 and var_46_16 or var_46_16 * (var_46_21 / var_46_20)

				if var_46_22 > 0 and var_46_16 < var_46_22 then
					arg_43_1.talkMaxDuration = var_46_22

					if var_46_22 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_22 + var_46_15
					end
				end

				arg_43_1.text_.text = var_46_19
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081010", "story_v_out_324081.awb") ~= 0 then
					local var_46_23 = manager.audio:GetVoiceLength("story_v_out_324081", "324081010", "story_v_out_324081.awb") / 1000

					if var_46_23 + var_46_15 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_23 + var_46_15
					end

					if var_46_18.prefab_name ~= "" and arg_43_1.actors_[var_46_18.prefab_name] ~= nil then
						local var_46_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_18.prefab_name].transform, "story_v_out_324081", "324081010", "story_v_out_324081.awb")

						arg_43_1:RecordAudio("324081010", var_46_24)
						arg_43_1:RecordAudio("324081010", var_46_24)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_324081", "324081010", "story_v_out_324081.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_324081", "324081010", "story_v_out_324081.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_25 = math.max(var_46_16, arg_43_1.talkMaxDuration)

			if var_46_15 <= arg_43_1.time_ and arg_43_1.time_ < var_46_15 + var_46_25 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_15) / var_46_25

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_15 + var_46_25 and arg_43_1.time_ < var_46_15 + var_46_25 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play324081011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 324081011
		arg_47_1.duration_ = 7

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play324081012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = "J22f"

			if arg_47_1.bgs_[var_50_0] == nil then
				local var_50_1 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_50_0)
				var_50_1.name = var_50_0
				var_50_1.transform.parent = arg_47_1.stage_.transform
				var_50_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_[var_50_0] = var_50_1
			end

			local var_50_2 = 0

			if var_50_2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				local var_50_3 = manager.ui.mainCamera.transform.localPosition
				local var_50_4 = Vector3.New(0, 0, 10) + Vector3.New(var_50_3.x, var_50_3.y, 0)
				local var_50_5 = arg_47_1.bgs_.J22f

				var_50_5.transform.localPosition = var_50_4
				var_50_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_6 = var_50_5:GetComponent("SpriteRenderer")

				if var_50_6 and var_50_6.sprite then
					local var_50_7 = (var_50_5.transform.localPosition - var_50_3).z
					local var_50_8 = manager.ui.mainCameraCom_
					local var_50_9 = 2 * var_50_7 * Mathf.Tan(var_50_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_50_10 = var_50_9 * var_50_8.aspect
					local var_50_11 = var_50_6.sprite.bounds.size.x
					local var_50_12 = var_50_6.sprite.bounds.size.y
					local var_50_13 = var_50_10 / var_50_11
					local var_50_14 = var_50_9 / var_50_12
					local var_50_15 = var_50_14 < var_50_13 and var_50_13 or var_50_14

					var_50_5.transform.localScale = Vector3.New(var_50_15, var_50_15, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "J22f" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_16 = 0

			if var_50_16 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 then
				arg_47_1.allBtn_.enabled = false
			end

			local var_50_17 = 0.3

			if arg_47_1.time_ >= var_50_16 + var_50_17 and arg_47_1.time_ < var_50_16 + var_50_17 + arg_50_0 then
				arg_47_1.allBtn_.enabled = true
			end

			local var_50_18 = 0

			if var_50_18 < arg_47_1.time_ and arg_47_1.time_ <= var_50_18 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_19 = 2

			if var_50_18 <= arg_47_1.time_ and arg_47_1.time_ < var_50_18 + var_50_19 then
				local var_50_20 = (arg_47_1.time_ - var_50_18) / var_50_19
				local var_50_21 = Color.New(0, 0, 0)

				var_50_21.a = Mathf.Lerp(1, 0, var_50_20)
				arg_47_1.mask_.color = var_50_21
			end

			if arg_47_1.time_ >= var_50_18 + var_50_19 and arg_47_1.time_ < var_50_18 + var_50_19 + arg_50_0 then
				local var_50_22 = Color.New(0, 0, 0)
				local var_50_23 = 0

				arg_47_1.mask_.enabled = false
				var_50_22.a = var_50_23
				arg_47_1.mask_.color = var_50_22
			end

			local var_50_24 = arg_47_1.actors_["10171ui_story"]
			local var_50_25 = 0

			if var_50_25 < arg_47_1.time_ and arg_47_1.time_ <= var_50_25 + arg_50_0 and not isNil(var_50_24) and arg_47_1.var_.characterEffect10171ui_story == nil then
				arg_47_1.var_.characterEffect10171ui_story = var_50_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_26 = 0.200000002980232

			if var_50_25 <= arg_47_1.time_ and arg_47_1.time_ < var_50_25 + var_50_26 and not isNil(var_50_24) then
				local var_50_27 = (arg_47_1.time_ - var_50_25) / var_50_26

				if arg_47_1.var_.characterEffect10171ui_story and not isNil(var_50_24) then
					local var_50_28 = Mathf.Lerp(0, 0.5, var_50_27)

					arg_47_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10171ui_story.fillRatio = var_50_28
				end
			end

			if arg_47_1.time_ >= var_50_25 + var_50_26 and arg_47_1.time_ < var_50_25 + var_50_26 + arg_50_0 and not isNil(var_50_24) and arg_47_1.var_.characterEffect10171ui_story then
				local var_50_29 = 0.5

				arg_47_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10171ui_story.fillRatio = var_50_29
			end

			local var_50_30 = 1.2
			local var_50_31 = 1

			if var_50_30 < arg_47_1.time_ and arg_47_1.time_ <= var_50_30 + arg_50_0 then
				local var_50_32 = "play"
				local var_50_33 = "effect"

				arg_47_1:AudioAction(var_50_32, var_50_33, "se_story_148", "se_story_148_amb_lost_city", "")
			end

			local var_50_34 = 0.1
			local var_50_35 = 1

			if var_50_34 < arg_47_1.time_ and arg_47_1.time_ <= var_50_34 + arg_50_0 then
				local var_50_36 = "stop"
				local var_50_37 = "effect"

				arg_47_1:AudioAction(var_50_36, var_50_37, "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_50_38 = 1
			local var_50_39 = 1

			if var_50_38 < arg_47_1.time_ and arg_47_1.time_ <= var_50_38 + arg_50_0 then
				local var_50_40 = "play"
				local var_50_41 = "music"

				arg_47_1:AudioAction(var_50_40, var_50_41, "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_50_42 = ""
				local var_50_43 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

				if var_50_43 ~= "" then
					if arg_47_1.bgmTxt_.text ~= var_50_43 and arg_47_1.bgmTxt_.text ~= "" then
						if arg_47_1.bgmTxt2_.text ~= "" then
							arg_47_1.bgmTxt_.text = arg_47_1.bgmTxt2_.text
						end

						arg_47_1.bgmTxt2_.text = var_50_43

						arg_47_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_47_1.bgmTxt_.text = var_50_43
						arg_47_1.bgmTxt2_.text = var_50_43
					end

					if arg_47_1.bgmTimer then
						arg_47_1.bgmTimer:Stop()

						arg_47_1.bgmTimer = nil
					end

					if arg_47_1.settingData.show_music_name == 1 then
						arg_47_1.musicController:SetSelectedState("show")
						arg_47_1.musicAnimator_:Play("open", 0, 0)

						if arg_47_1.settingData.music_time ~= 0 then
							arg_47_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_47_1.settingData.music_time), function()
								if arg_47_1 == nil or isNil(arg_47_1.bgmTxt_) then
									return
								end

								arg_47_1.musicController:SetSelectedState("hide")
								arg_47_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_44 = 2
			local var_50_45 = 1.675

			if var_50_44 < arg_47_1.time_ and arg_47_1.time_ <= var_50_44 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_46 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_46:setOnUpdate(LuaHelper.FloatAction(function(arg_52_0)
					arg_47_1.dialogCg_.alpha = arg_52_0
				end))
				var_50_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_47 = arg_47_1:GetWordFromCfg(324081011)
				local var_50_48 = arg_47_1:FormatText(var_50_47.content)

				arg_47_1.text_.text = var_50_48

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_49 = 67
				local var_50_50 = utf8.len(var_50_48)
				local var_50_51 = var_50_49 <= 0 and var_50_45 or var_50_45 * (var_50_50 / var_50_49)

				if var_50_51 > 0 and var_50_45 < var_50_51 then
					arg_47_1.talkMaxDuration = var_50_51
					var_50_44 = var_50_44 + 0.3

					if var_50_51 + var_50_44 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_51 + var_50_44
					end
				end

				arg_47_1.text_.text = var_50_48
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_52 = var_50_44 + 0.3
			local var_50_53 = math.max(var_50_45, arg_47_1.talkMaxDuration)

			if var_50_52 <= arg_47_1.time_ and arg_47_1.time_ < var_50_52 + var_50_53 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_52) / var_50_53

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_52 + var_50_53 and arg_47_1.time_ < var_50_52 + var_50_53 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play324081012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 324081012
		arg_54_1.duration_ = 5.6

		local var_54_0 = {
			zh = 4.7,
			ja = 5.6
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
				arg_54_0:Play324081013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1070ui_story"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos1070ui_story = var_57_0.localPosition
			end

			local var_57_2 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2
				local var_57_4 = Vector3.New(0, -0.95, -6.05)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1070ui_story, var_57_4, var_57_3)

				local var_57_5 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_5.x, var_57_5.y, var_57_5.z)

				local var_57_6 = var_57_0.localEulerAngles

				var_57_6.z = 0
				var_57_6.x = 0
				var_57_0.localEulerAngles = var_57_6
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_57_7 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_7.x, var_57_7.y, var_57_7.z)

				local var_57_8 = var_57_0.localEulerAngles

				var_57_8.z = 0
				var_57_8.x = 0
				var_57_0.localEulerAngles = var_57_8
			end

			local var_57_9 = arg_54_1.actors_["1070ui_story"]
			local var_57_10 = 0

			if var_57_10 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect1070ui_story == nil then
				arg_54_1.var_.characterEffect1070ui_story = var_57_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_11 = 0.200000002980232

			if var_57_10 <= arg_54_1.time_ and arg_54_1.time_ < var_57_10 + var_57_11 and not isNil(var_57_9) then
				local var_57_12 = (arg_54_1.time_ - var_57_10) / var_57_11

				if arg_54_1.var_.characterEffect1070ui_story and not isNil(var_57_9) then
					arg_54_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_10 + var_57_11 and arg_54_1.time_ < var_57_10 + var_57_11 + arg_57_0 and not isNil(var_57_9) and arg_54_1.var_.characterEffect1070ui_story then
				arg_54_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_57_13 = 0

			if var_57_13 < arg_54_1.time_ and arg_54_1.time_ <= var_57_13 + arg_57_0 then
				arg_54_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_2")
			end

			local var_57_14 = 0

			if var_57_14 < arg_54_1.time_ and arg_54_1.time_ <= var_57_14 + arg_57_0 then
				arg_54_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_57_15 = 0
			local var_57_16 = 0.475

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_17 = arg_54_1:FormatText(StoryNameCfg[318].name)

				arg_54_1.leftNameTxt_.text = var_57_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_18 = arg_54_1:GetWordFromCfg(324081012)
				local var_57_19 = arg_54_1:FormatText(var_57_18.content)

				arg_54_1.text_.text = var_57_19

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_20 = 19
				local var_57_21 = utf8.len(var_57_19)
				local var_57_22 = var_57_20 <= 0 and var_57_16 or var_57_16 * (var_57_21 / var_57_20)

				if var_57_22 > 0 and var_57_16 < var_57_22 then
					arg_54_1.talkMaxDuration = var_57_22

					if var_57_22 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_22 + var_57_15
					end
				end

				arg_54_1.text_.text = var_57_19
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081012", "story_v_out_324081.awb") ~= 0 then
					local var_57_23 = manager.audio:GetVoiceLength("story_v_out_324081", "324081012", "story_v_out_324081.awb") / 1000

					if var_57_23 + var_57_15 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_23 + var_57_15
					end

					if var_57_18.prefab_name ~= "" and arg_54_1.actors_[var_57_18.prefab_name] ~= nil then
						local var_57_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_18.prefab_name].transform, "story_v_out_324081", "324081012", "story_v_out_324081.awb")

						arg_54_1:RecordAudio("324081012", var_57_24)
						arg_54_1:RecordAudio("324081012", var_57_24)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_324081", "324081012", "story_v_out_324081.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_324081", "324081012", "story_v_out_324081.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_25 = math.max(var_57_16, arg_54_1.talkMaxDuration)

			if var_57_15 <= arg_54_1.time_ and arg_54_1.time_ < var_57_15 + var_57_25 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_15) / var_57_25

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_15 + var_57_25 and arg_54_1.time_ < var_57_15 + var_57_25 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
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

		arg_54_1:InitPlayNodeList()
	end,
	Play324081013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324081013
		arg_58_1.duration_ = 4.2

		local var_58_0 = {
			zh = 3.633,
			ja = 4.2
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play324081014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10171ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect10171ui_story == nil then
				arg_58_1.var_.characterEffect10171ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect10171ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect10171ui_story then
				arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_61_4 = arg_58_1.actors_["1070ui_story"]
			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1070ui_story == nil then
				arg_58_1.var_.characterEffect1070ui_story = var_61_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_6 = 0.200000002980232

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 and not isNil(var_61_4) then
				local var_61_7 = (arg_58_1.time_ - var_61_5) / var_61_6

				if arg_58_1.var_.characterEffect1070ui_story and not isNil(var_61_4) then
					local var_61_8 = Mathf.Lerp(0, 0.5, var_61_7)

					arg_58_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1070ui_story.fillRatio = var_61_8
				end
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect1070ui_story then
				local var_61_9 = 0.5

				arg_58_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1070ui_story.fillRatio = var_61_9
			end

			local var_61_10 = arg_58_1.actors_["10171ui_story"].transform
			local var_61_11 = 0

			if var_61_11 < arg_58_1.time_ and arg_58_1.time_ <= var_61_11 + arg_61_0 then
				arg_58_1.var_.moveOldPos10171ui_story = var_61_10.localPosition

				local var_61_12 = GameObjectTools.GetOrAddComponent(var_61_10.gameObject, typeof(DynamicBoneHelper))

				if var_61_12 then
					var_61_12:EnableDynamicBone(false)
				end
			end

			local var_61_13 = 0.001

			if var_61_11 <= arg_58_1.time_ and arg_58_1.time_ < var_61_11 + var_61_13 then
				local var_61_14 = (arg_58_1.time_ - var_61_11) / var_61_13
				local var_61_15 = Vector3.New(-0.7, -0.95, -6.05)

				var_61_10.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10171ui_story, var_61_15, var_61_14)

				local var_61_16 = manager.ui.mainCamera.transform.position - var_61_10.position

				var_61_10.forward = Vector3.New(var_61_16.x, var_61_16.y, var_61_16.z)

				local var_61_17 = var_61_10.localEulerAngles

				var_61_17.z = 0
				var_61_17.x = 0
				var_61_10.localEulerAngles = var_61_17
			end

			if arg_58_1.time_ >= var_61_11 + var_61_13 and arg_58_1.time_ < var_61_11 + var_61_13 + arg_61_0 then
				var_61_10.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_61_18 = manager.ui.mainCamera.transform.position - var_61_10.position

				var_61_10.forward = Vector3.New(var_61_18.x, var_61_18.y, var_61_18.z)

				local var_61_19 = var_61_10.localEulerAngles

				var_61_19.z = 0
				var_61_19.x = 0
				var_61_10.localEulerAngles = var_61_19

				local var_61_20 = GameObjectTools.GetOrAddComponent(var_61_10.gameObject, typeof(DynamicBoneHelper))

				if var_61_20 then
					var_61_20:EnableDynamicBone(true)
				end
			end

			local var_61_21 = arg_58_1.actors_["10171ui_story"]
			local var_61_22 = 0

			if var_61_22 < arg_58_1.time_ and arg_58_1.time_ <= var_61_22 + arg_61_0 and not isNil(var_61_21) and arg_58_1.var_.characterEffect10171ui_story == nil then
				arg_58_1.var_.characterEffect10171ui_story = var_61_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_23 = 0.200000002980232

			if var_61_22 <= arg_58_1.time_ and arg_58_1.time_ < var_61_22 + var_61_23 and not isNil(var_61_21) then
				local var_61_24 = (arg_58_1.time_ - var_61_22) / var_61_23

				if arg_58_1.var_.characterEffect10171ui_story and not isNil(var_61_21) then
					arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_22 + var_61_23 and arg_58_1.time_ < var_61_22 + var_61_23 + arg_61_0 and not isNil(var_61_21) and arg_58_1.var_.characterEffect10171ui_story then
				arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_61_25 = 0

			if var_61_25 < arg_58_1.time_ and arg_58_1.time_ <= var_61_25 + arg_61_0 then
				arg_58_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			local var_61_26 = 0

			if var_61_26 < arg_58_1.time_ and arg_58_1.time_ <= var_61_26 + arg_61_0 then
				arg_58_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_61_27 = arg_58_1.actors_["1070ui_story"].transform
			local var_61_28 = 0

			if var_61_28 < arg_58_1.time_ and arg_58_1.time_ <= var_61_28 + arg_61_0 then
				arg_58_1.var_.moveOldPos1070ui_story = var_61_27.localPosition
			end

			local var_61_29 = 0.001

			if var_61_28 <= arg_58_1.time_ and arg_58_1.time_ < var_61_28 + var_61_29 then
				local var_61_30 = (arg_58_1.time_ - var_61_28) / var_61_29
				local var_61_31 = Vector3.New(0.7, -0.95, -6.05)

				var_61_27.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1070ui_story, var_61_31, var_61_30)

				local var_61_32 = manager.ui.mainCamera.transform.position - var_61_27.position

				var_61_27.forward = Vector3.New(var_61_32.x, var_61_32.y, var_61_32.z)

				local var_61_33 = var_61_27.localEulerAngles

				var_61_33.z = 0
				var_61_33.x = 0
				var_61_27.localEulerAngles = var_61_33
			end

			if arg_58_1.time_ >= var_61_28 + var_61_29 and arg_58_1.time_ < var_61_28 + var_61_29 + arg_61_0 then
				var_61_27.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_61_34 = manager.ui.mainCamera.transform.position - var_61_27.position

				var_61_27.forward = Vector3.New(var_61_34.x, var_61_34.y, var_61_34.z)

				local var_61_35 = var_61_27.localEulerAngles

				var_61_35.z = 0
				var_61_35.x = 0
				var_61_27.localEulerAngles = var_61_35
			end

			local var_61_36 = 0
			local var_61_37 = 0.525

			if var_61_36 < arg_58_1.time_ and arg_58_1.time_ <= var_61_36 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_38 = arg_58_1:FormatText(StoryNameCfg[1451].name)

				arg_58_1.leftNameTxt_.text = var_61_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_39 = arg_58_1:GetWordFromCfg(324081013)
				local var_61_40 = arg_58_1:FormatText(var_61_39.content)

				arg_58_1.text_.text = var_61_40

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_41 = 21
				local var_61_42 = utf8.len(var_61_40)
				local var_61_43 = var_61_41 <= 0 and var_61_37 or var_61_37 * (var_61_42 / var_61_41)

				if var_61_43 > 0 and var_61_37 < var_61_43 then
					arg_58_1.talkMaxDuration = var_61_43

					if var_61_43 + var_61_36 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_43 + var_61_36
					end
				end

				arg_58_1.text_.text = var_61_40
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081013", "story_v_out_324081.awb") ~= 0 then
					local var_61_44 = manager.audio:GetVoiceLength("story_v_out_324081", "324081013", "story_v_out_324081.awb") / 1000

					if var_61_44 + var_61_36 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_44 + var_61_36
					end

					if var_61_39.prefab_name ~= "" and arg_58_1.actors_[var_61_39.prefab_name] ~= nil then
						local var_61_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_39.prefab_name].transform, "story_v_out_324081", "324081013", "story_v_out_324081.awb")

						arg_58_1:RecordAudio("324081013", var_61_45)
						arg_58_1:RecordAudio("324081013", var_61_45)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_324081", "324081013", "story_v_out_324081.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_324081", "324081013", "story_v_out_324081.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_46 = math.max(var_61_37, arg_58_1.talkMaxDuration)

			if var_61_36 <= arg_58_1.time_ and arg_58_1.time_ < var_61_36 + var_61_46 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_36) / var_61_46

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_36 + var_61_46 and arg_58_1.time_ < var_61_36 + var_61_46 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
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

		arg_58_1:InitPlayNodeList()
	end,
	Play324081014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324081014
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play324081015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1070ui_story"].transform
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 then
				arg_62_1.var_.moveOldPos1070ui_story = var_65_0.localPosition
			end

			local var_65_2 = 0.001

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2
				local var_65_4 = Vector3.New(0, 100, 0)

				var_65_0.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1070ui_story, var_65_4, var_65_3)

				local var_65_5 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_5.x, var_65_5.y, var_65_5.z)

				local var_65_6 = var_65_0.localEulerAngles

				var_65_6.z = 0
				var_65_6.x = 0
				var_65_0.localEulerAngles = var_65_6
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 then
				var_65_0.localPosition = Vector3.New(0, 100, 0)

				local var_65_7 = manager.ui.mainCamera.transform.position - var_65_0.position

				var_65_0.forward = Vector3.New(var_65_7.x, var_65_7.y, var_65_7.z)

				local var_65_8 = var_65_0.localEulerAngles

				var_65_8.z = 0
				var_65_8.x = 0
				var_65_0.localEulerAngles = var_65_8
			end

			local var_65_9 = arg_62_1.actors_["10171ui_story"]
			local var_65_10 = 0

			if var_65_10 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 and not isNil(var_65_9) and arg_62_1.var_.characterEffect10171ui_story == nil then
				arg_62_1.var_.characterEffect10171ui_story = var_65_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_11 = 0.200000002980232

			if var_65_10 <= arg_62_1.time_ and arg_62_1.time_ < var_65_10 + var_65_11 and not isNil(var_65_9) then
				local var_65_12 = (arg_62_1.time_ - var_65_10) / var_65_11

				if arg_62_1.var_.characterEffect10171ui_story and not isNil(var_65_9) then
					local var_65_13 = Mathf.Lerp(0, 0.5, var_65_12)

					arg_62_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_62_1.var_.characterEffect10171ui_story.fillRatio = var_65_13
				end
			end

			if arg_62_1.time_ >= var_65_10 + var_65_11 and arg_62_1.time_ < var_65_10 + var_65_11 + arg_65_0 and not isNil(var_65_9) and arg_62_1.var_.characterEffect10171ui_story then
				local var_65_14 = 0.5

				arg_62_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_62_1.var_.characterEffect10171ui_story.fillRatio = var_65_14
			end

			local var_65_15 = arg_62_1.actors_["10171ui_story"].transform
			local var_65_16 = 0

			if var_65_16 < arg_62_1.time_ and arg_62_1.time_ <= var_65_16 + arg_65_0 then
				arg_62_1.var_.moveOldPos10171ui_story = var_65_15.localPosition

				local var_65_17 = GameObjectTools.GetOrAddComponent(var_65_15.gameObject, typeof(DynamicBoneHelper))

				if var_65_17 then
					var_65_17:EnableDynamicBone(false)
				end
			end

			local var_65_18 = 0.001

			if var_65_16 <= arg_62_1.time_ and arg_62_1.time_ < var_65_16 + var_65_18 then
				local var_65_19 = (arg_62_1.time_ - var_65_16) / var_65_18
				local var_65_20 = Vector3.New(0, 100, 0)

				var_65_15.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10171ui_story, var_65_20, var_65_19)

				local var_65_21 = manager.ui.mainCamera.transform.position - var_65_15.position

				var_65_15.forward = Vector3.New(var_65_21.x, var_65_21.y, var_65_21.z)

				local var_65_22 = var_65_15.localEulerAngles

				var_65_22.z = 0
				var_65_22.x = 0
				var_65_15.localEulerAngles = var_65_22
			end

			if arg_62_1.time_ >= var_65_16 + var_65_18 and arg_62_1.time_ < var_65_16 + var_65_18 + arg_65_0 then
				var_65_15.localPosition = Vector3.New(0, 100, 0)

				local var_65_23 = manager.ui.mainCamera.transform.position - var_65_15.position

				var_65_15.forward = Vector3.New(var_65_23.x, var_65_23.y, var_65_23.z)

				local var_65_24 = var_65_15.localEulerAngles

				var_65_24.z = 0
				var_65_24.x = 0
				var_65_15.localEulerAngles = var_65_24

				local var_65_25 = GameObjectTools.GetOrAddComponent(var_65_15.gameObject, typeof(DynamicBoneHelper))

				if var_65_25 then
					var_65_25:EnableDynamicBone(true)
				end
			end

			local var_65_26 = 0
			local var_65_27 = 0.925

			if var_65_26 < arg_62_1.time_ and arg_62_1.time_ <= var_65_26 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_28 = arg_62_1:GetWordFromCfg(324081014)
				local var_65_29 = arg_62_1:FormatText(var_65_28.content)

				arg_62_1.text_.text = var_65_29

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_30 = 37
				local var_65_31 = utf8.len(var_65_29)
				local var_65_32 = var_65_30 <= 0 and var_65_27 or var_65_27 * (var_65_31 / var_65_30)

				if var_65_32 > 0 and var_65_27 < var_65_32 then
					arg_62_1.talkMaxDuration = var_65_32

					if var_65_32 + var_65_26 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_32 + var_65_26
					end
				end

				arg_62_1.text_.text = var_65_29
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_33 = math.max(var_65_27, arg_62_1.talkMaxDuration)

			if var_65_26 <= arg_62_1.time_ and arg_62_1.time_ < var_65_26 + var_65_33 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_26) / var_65_33

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_26 + var_65_33 and arg_62_1.time_ < var_65_26 + var_65_33 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play324081015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 324081015
		arg_66_1.duration_ = 3.97

		local var_66_0 = {
			zh = 3.7,
			ja = 3.966
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play324081016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10171ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos10171ui_story = var_69_0.localPosition

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_0.gameObject, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end
			end

			local var_69_3 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_3 then
				local var_69_4 = (arg_66_1.time_ - var_69_1) / var_69_3
				local var_69_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10171ui_story, var_69_5, var_69_4)

				local var_69_6 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_6.x, var_69_6.y, var_69_6.z)

				local var_69_7 = var_69_0.localEulerAngles

				var_69_7.z = 0
				var_69_7.x = 0
				var_69_0.localEulerAngles = var_69_7
			end

			if arg_66_1.time_ >= var_69_1 + var_69_3 and arg_66_1.time_ < var_69_1 + var_69_3 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_69_8 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_8.x, var_69_8.y, var_69_8.z)

				local var_69_9 = var_69_0.localEulerAngles

				var_69_9.z = 0
				var_69_9.x = 0
				var_69_0.localEulerAngles = var_69_9

				local var_69_10 = GameObjectTools.GetOrAddComponent(var_69_0.gameObject, typeof(DynamicBoneHelper))

				if var_69_10 then
					var_69_10:EnableDynamicBone(true)
				end
			end

			local var_69_11 = arg_66_1.actors_["10171ui_story"]
			local var_69_12 = 0

			if var_69_12 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 and not isNil(var_69_11) and arg_66_1.var_.characterEffect10171ui_story == nil then
				arg_66_1.var_.characterEffect10171ui_story = var_69_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_13 = 0.200000002980232

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_13 and not isNil(var_69_11) then
				local var_69_14 = (arg_66_1.time_ - var_69_12) / var_69_13

				if arg_66_1.var_.characterEffect10171ui_story and not isNil(var_69_11) then
					arg_66_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_12 + var_69_13 and arg_66_1.time_ < var_69_12 + var_69_13 + arg_69_0 and not isNil(var_69_11) and arg_66_1.var_.characterEffect10171ui_story then
				arg_66_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_69_15 = 0

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_2")
			end

			local var_69_16 = 0

			if var_69_16 < arg_66_1.time_ and arg_66_1.time_ <= var_69_16 + arg_69_0 then
				arg_66_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_69_17 = 0
			local var_69_18 = 0.4

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_19 = arg_66_1:FormatText(StoryNameCfg[1451].name)

				arg_66_1.leftNameTxt_.text = var_69_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_20 = arg_66_1:GetWordFromCfg(324081015)
				local var_69_21 = arg_66_1:FormatText(var_69_20.content)

				arg_66_1.text_.text = var_69_21

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_22 = 16
				local var_69_23 = utf8.len(var_69_21)
				local var_69_24 = var_69_22 <= 0 and var_69_18 or var_69_18 * (var_69_23 / var_69_22)

				if var_69_24 > 0 and var_69_18 < var_69_24 then
					arg_66_1.talkMaxDuration = var_69_24

					if var_69_24 + var_69_17 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_24 + var_69_17
					end
				end

				arg_66_1.text_.text = var_69_21
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081015", "story_v_out_324081.awb") ~= 0 then
					local var_69_25 = manager.audio:GetVoiceLength("story_v_out_324081", "324081015", "story_v_out_324081.awb") / 1000

					if var_69_25 + var_69_17 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_25 + var_69_17
					end

					if var_69_20.prefab_name ~= "" and arg_66_1.actors_[var_69_20.prefab_name] ~= nil then
						local var_69_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_20.prefab_name].transform, "story_v_out_324081", "324081015", "story_v_out_324081.awb")

						arg_66_1:RecordAudio("324081015", var_69_26)
						arg_66_1:RecordAudio("324081015", var_69_26)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_324081", "324081015", "story_v_out_324081.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_324081", "324081015", "story_v_out_324081.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_27 = math.max(var_69_18, arg_66_1.talkMaxDuration)

			if var_69_17 <= arg_66_1.time_ and arg_66_1.time_ < var_69_17 + var_69_27 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_17) / var_69_27

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_17 + var_69_27 and arg_66_1.time_ < var_69_17 + var_69_27 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play324081016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 324081016
		arg_70_1.duration_ = 9.63

		local var_70_0 = {
			zh = 7.3,
			ja = 9.633
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play324081017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1070ui_story"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos1070ui_story = var_73_0.localPosition
			end

			local var_73_2 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2
				local var_73_4 = Vector3.New(0.7, -0.95, -6.05)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1070ui_story, var_73_4, var_73_3)

				local var_73_5 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_5.x, var_73_5.y, var_73_5.z)

				local var_73_6 = var_73_0.localEulerAngles

				var_73_6.z = 0
				var_73_6.x = 0
				var_73_0.localEulerAngles = var_73_6
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_73_7 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_7.x, var_73_7.y, var_73_7.z)

				local var_73_8 = var_73_0.localEulerAngles

				var_73_8.z = 0
				var_73_8.x = 0
				var_73_0.localEulerAngles = var_73_8
			end

			local var_73_9 = arg_70_1.actors_["1070ui_story"]
			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 and not isNil(var_73_9) and arg_70_1.var_.characterEffect1070ui_story == nil then
				arg_70_1.var_.characterEffect1070ui_story = var_73_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_11 = 0.200000002980232

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_11 and not isNil(var_73_9) then
				local var_73_12 = (arg_70_1.time_ - var_73_10) / var_73_11

				if arg_70_1.var_.characterEffect1070ui_story and not isNil(var_73_9) then
					arg_70_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_10 + var_73_11 and arg_70_1.time_ < var_73_10 + var_73_11 + arg_73_0 and not isNil(var_73_9) and arg_70_1.var_.characterEffect1070ui_story then
				arg_70_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_73_13 = arg_70_1.actors_["10171ui_story"]
			local var_73_14 = 0

			if var_73_14 < arg_70_1.time_ and arg_70_1.time_ <= var_73_14 + arg_73_0 and not isNil(var_73_13) and arg_70_1.var_.characterEffect10171ui_story == nil then
				arg_70_1.var_.characterEffect10171ui_story = var_73_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_15 = 0.200000002980232

			if var_73_14 <= arg_70_1.time_ and arg_70_1.time_ < var_73_14 + var_73_15 and not isNil(var_73_13) then
				local var_73_16 = (arg_70_1.time_ - var_73_14) / var_73_15

				if arg_70_1.var_.characterEffect10171ui_story and not isNil(var_73_13) then
					local var_73_17 = Mathf.Lerp(0, 0.5, var_73_16)

					arg_70_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10171ui_story.fillRatio = var_73_17
				end
			end

			if arg_70_1.time_ >= var_73_14 + var_73_15 and arg_70_1.time_ < var_73_14 + var_73_15 + arg_73_0 and not isNil(var_73_13) and arg_70_1.var_.characterEffect10171ui_story then
				local var_73_18 = 0.5

				arg_70_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10171ui_story.fillRatio = var_73_18
			end

			local var_73_19 = 0
			local var_73_20 = 0.85

			if var_73_19 < arg_70_1.time_ and arg_70_1.time_ <= var_73_19 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_21 = arg_70_1:FormatText(StoryNameCfg[318].name)

				arg_70_1.leftNameTxt_.text = var_73_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_22 = arg_70_1:GetWordFromCfg(324081016)
				local var_73_23 = arg_70_1:FormatText(var_73_22.content)

				arg_70_1.text_.text = var_73_23

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_24 = 34
				local var_73_25 = utf8.len(var_73_23)
				local var_73_26 = var_73_24 <= 0 and var_73_20 or var_73_20 * (var_73_25 / var_73_24)

				if var_73_26 > 0 and var_73_20 < var_73_26 then
					arg_70_1.talkMaxDuration = var_73_26

					if var_73_26 + var_73_19 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_26 + var_73_19
					end
				end

				arg_70_1.text_.text = var_73_23
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081016", "story_v_out_324081.awb") ~= 0 then
					local var_73_27 = manager.audio:GetVoiceLength("story_v_out_324081", "324081016", "story_v_out_324081.awb") / 1000

					if var_73_27 + var_73_19 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_27 + var_73_19
					end

					if var_73_22.prefab_name ~= "" and arg_70_1.actors_[var_73_22.prefab_name] ~= nil then
						local var_73_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_22.prefab_name].transform, "story_v_out_324081", "324081016", "story_v_out_324081.awb")

						arg_70_1:RecordAudio("324081016", var_73_28)
						arg_70_1:RecordAudio("324081016", var_73_28)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_324081", "324081016", "story_v_out_324081.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_324081", "324081016", "story_v_out_324081.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_29 = math.max(var_73_20, arg_70_1.talkMaxDuration)

			if var_73_19 <= arg_70_1.time_ and arg_70_1.time_ < var_73_19 + var_73_29 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_19) / var_73_29

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_19 + var_73_29 and arg_70_1.time_ < var_73_19 + var_73_29 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play324081017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 324081017
		arg_74_1.duration_ = 5.5

		local var_74_0 = {
			zh = 3.933,
			ja = 5.5
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play324081018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["10171ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect10171ui_story == nil then
				arg_74_1.var_.characterEffect10171ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect10171ui_story and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect10171ui_story then
				arg_74_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_77_4 = arg_74_1.actors_["1070ui_story"]
			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect1070ui_story == nil then
				arg_74_1.var_.characterEffect1070ui_story = var_77_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_6 = 0.200000002980232

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_6 and not isNil(var_77_4) then
				local var_77_7 = (arg_74_1.time_ - var_77_5) / var_77_6

				if arg_74_1.var_.characterEffect1070ui_story and not isNil(var_77_4) then
					local var_77_8 = Mathf.Lerp(0, 0.5, var_77_7)

					arg_74_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1070ui_story.fillRatio = var_77_8
				end
			end

			if arg_74_1.time_ >= var_77_5 + var_77_6 and arg_74_1.time_ < var_77_5 + var_77_6 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect1070ui_story then
				local var_77_9 = 0.5

				arg_74_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1070ui_story.fillRatio = var_77_9
			end

			local var_77_10 = 0
			local var_77_11 = 0.45

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_12 = arg_74_1:FormatText(StoryNameCfg[1451].name)

				arg_74_1.leftNameTxt_.text = var_77_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_13 = arg_74_1:GetWordFromCfg(324081017)
				local var_77_14 = arg_74_1:FormatText(var_77_13.content)

				arg_74_1.text_.text = var_77_14

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_15 = 18
				local var_77_16 = utf8.len(var_77_14)
				local var_77_17 = var_77_15 <= 0 and var_77_11 or var_77_11 * (var_77_16 / var_77_15)

				if var_77_17 > 0 and var_77_11 < var_77_17 then
					arg_74_1.talkMaxDuration = var_77_17

					if var_77_17 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_17 + var_77_10
					end
				end

				arg_74_1.text_.text = var_77_14
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081017", "story_v_out_324081.awb") ~= 0 then
					local var_77_18 = manager.audio:GetVoiceLength("story_v_out_324081", "324081017", "story_v_out_324081.awb") / 1000

					if var_77_18 + var_77_10 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_18 + var_77_10
					end

					if var_77_13.prefab_name ~= "" and arg_74_1.actors_[var_77_13.prefab_name] ~= nil then
						local var_77_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_13.prefab_name].transform, "story_v_out_324081", "324081017", "story_v_out_324081.awb")

						arg_74_1:RecordAudio("324081017", var_77_19)
						arg_74_1:RecordAudio("324081017", var_77_19)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_324081", "324081017", "story_v_out_324081.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_324081", "324081017", "story_v_out_324081.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_20 = math.max(var_77_11, arg_74_1.talkMaxDuration)

			if var_77_10 <= arg_74_1.time_ and arg_74_1.time_ < var_77_10 + var_77_20 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_10) / var_77_20

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_10 + var_77_20 and arg_74_1.time_ < var_77_10 + var_77_20 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play324081018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 324081018
		arg_78_1.duration_ = 7.1

		local var_78_0 = {
			zh = 7.1,
			ja = 7.066
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play324081019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1070ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1070ui_story == nil then
				arg_78_1.var_.characterEffect1070ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1070ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1070ui_story then
				arg_78_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_81_4 = arg_78_1.actors_["10171ui_story"]
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect10171ui_story == nil then
				arg_78_1.var_.characterEffect10171ui_story = var_81_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_6 = 0.200000002980232

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_6 and not isNil(var_81_4) then
				local var_81_7 = (arg_78_1.time_ - var_81_5) / var_81_6

				if arg_78_1.var_.characterEffect10171ui_story and not isNil(var_81_4) then
					local var_81_8 = Mathf.Lerp(0, 0.5, var_81_7)

					arg_78_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10171ui_story.fillRatio = var_81_8
				end
			end

			if arg_78_1.time_ >= var_81_5 + var_81_6 and arg_78_1.time_ < var_81_5 + var_81_6 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect10171ui_story then
				local var_81_9 = 0.5

				arg_78_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10171ui_story.fillRatio = var_81_9
			end

			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_81_11 = 0

			if var_81_11 < arg_78_1.time_ and arg_78_1.time_ <= var_81_11 + arg_81_0 then
				arg_78_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_81_12 = 0
			local var_81_13 = 0.725

			if var_81_12 < arg_78_1.time_ and arg_78_1.time_ <= var_81_12 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_14 = arg_78_1:FormatText(StoryNameCfg[318].name)

				arg_78_1.leftNameTxt_.text = var_81_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_15 = arg_78_1:GetWordFromCfg(324081018)
				local var_81_16 = arg_78_1:FormatText(var_81_15.content)

				arg_78_1.text_.text = var_81_16

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_17 = 29
				local var_81_18 = utf8.len(var_81_16)
				local var_81_19 = var_81_17 <= 0 and var_81_13 or var_81_13 * (var_81_18 / var_81_17)

				if var_81_19 > 0 and var_81_13 < var_81_19 then
					arg_78_1.talkMaxDuration = var_81_19

					if var_81_19 + var_81_12 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_19 + var_81_12
					end
				end

				arg_78_1.text_.text = var_81_16
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081018", "story_v_out_324081.awb") ~= 0 then
					local var_81_20 = manager.audio:GetVoiceLength("story_v_out_324081", "324081018", "story_v_out_324081.awb") / 1000

					if var_81_20 + var_81_12 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_20 + var_81_12
					end

					if var_81_15.prefab_name ~= "" and arg_78_1.actors_[var_81_15.prefab_name] ~= nil then
						local var_81_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_15.prefab_name].transform, "story_v_out_324081", "324081018", "story_v_out_324081.awb")

						arg_78_1:RecordAudio("324081018", var_81_21)
						arg_78_1:RecordAudio("324081018", var_81_21)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_324081", "324081018", "story_v_out_324081.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_324081", "324081018", "story_v_out_324081.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_22 = math.max(var_81_13, arg_78_1.talkMaxDuration)

			if var_81_12 <= arg_78_1.time_ and arg_78_1.time_ < var_81_12 + var_81_22 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_12) / var_81_22

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_12 + var_81_22 and arg_78_1.time_ < var_81_12 + var_81_22 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play324081019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 324081019
		arg_82_1.duration_ = 4.2

		local var_82_0 = {
			zh = 2.933,
			ja = 4.2
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play324081020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["10171ui_story"]
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10171ui_story == nil then
				arg_82_1.var_.characterEffect10171ui_story = var_85_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 and not isNil(var_85_0) then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2

				if arg_82_1.var_.characterEffect10171ui_story and not isNil(var_85_0) then
					arg_82_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 and not isNil(var_85_0) and arg_82_1.var_.characterEffect10171ui_story then
				arg_82_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_85_4 = arg_82_1.actors_["1070ui_story"]
			local var_85_5 = 0

			if var_85_5 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect1070ui_story == nil then
				arg_82_1.var_.characterEffect1070ui_story = var_85_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_6 = 0.200000002980232

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_6 and not isNil(var_85_4) then
				local var_85_7 = (arg_82_1.time_ - var_85_5) / var_85_6

				if arg_82_1.var_.characterEffect1070ui_story and not isNil(var_85_4) then
					local var_85_8 = Mathf.Lerp(0, 0.5, var_85_7)

					arg_82_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1070ui_story.fillRatio = var_85_8
				end
			end

			if arg_82_1.time_ >= var_85_5 + var_85_6 and arg_82_1.time_ < var_85_5 + var_85_6 + arg_85_0 and not isNil(var_85_4) and arg_82_1.var_.characterEffect1070ui_story then
				local var_85_9 = 0.5

				arg_82_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1070ui_story.fillRatio = var_85_9
			end

			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_85_11 = 0

			if var_85_11 < arg_82_1.time_ and arg_82_1.time_ <= var_85_11 + arg_85_0 then
				arg_82_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_85_12 = 0
			local var_85_13 = 0.375

			if var_85_12 < arg_82_1.time_ and arg_82_1.time_ <= var_85_12 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_14 = arg_82_1:FormatText(StoryNameCfg[1451].name)

				arg_82_1.leftNameTxt_.text = var_85_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_15 = arg_82_1:GetWordFromCfg(324081019)
				local var_85_16 = arg_82_1:FormatText(var_85_15.content)

				arg_82_1.text_.text = var_85_16

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_17 = 15
				local var_85_18 = utf8.len(var_85_16)
				local var_85_19 = var_85_17 <= 0 and var_85_13 or var_85_13 * (var_85_18 / var_85_17)

				if var_85_19 > 0 and var_85_13 < var_85_19 then
					arg_82_1.talkMaxDuration = var_85_19

					if var_85_19 + var_85_12 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_19 + var_85_12
					end
				end

				arg_82_1.text_.text = var_85_16
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081019", "story_v_out_324081.awb") ~= 0 then
					local var_85_20 = manager.audio:GetVoiceLength("story_v_out_324081", "324081019", "story_v_out_324081.awb") / 1000

					if var_85_20 + var_85_12 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_20 + var_85_12
					end

					if var_85_15.prefab_name ~= "" and arg_82_1.actors_[var_85_15.prefab_name] ~= nil then
						local var_85_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_15.prefab_name].transform, "story_v_out_324081", "324081019", "story_v_out_324081.awb")

						arg_82_1:RecordAudio("324081019", var_85_21)
						arg_82_1:RecordAudio("324081019", var_85_21)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_324081", "324081019", "story_v_out_324081.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_324081", "324081019", "story_v_out_324081.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_22 = math.max(var_85_13, arg_82_1.talkMaxDuration)

			if var_85_12 <= arg_82_1.time_ and arg_82_1.time_ < var_85_12 + var_85_22 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_12) / var_85_22

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_12 + var_85_22 and arg_82_1.time_ < var_85_12 + var_85_22 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play324081020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 324081020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play324081021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1070ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1070ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(0, 100, 0)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1070ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, 100, 0)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = arg_86_1.actors_["10171ui_story"].transform
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.var_.moveOldPos10171ui_story = var_89_9.localPosition

				local var_89_11 = GameObjectTools.GetOrAddComponent(var_89_9.gameObject, typeof(DynamicBoneHelper))

				if var_89_11 then
					var_89_11:EnableDynamicBone(false)
				end
			end

			local var_89_12 = 0.001

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_12 then
				local var_89_13 = (arg_86_1.time_ - var_89_10) / var_89_12
				local var_89_14 = Vector3.New(0, 100, 0)

				var_89_9.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10171ui_story, var_89_14, var_89_13)

				local var_89_15 = manager.ui.mainCamera.transform.position - var_89_9.position

				var_89_9.forward = Vector3.New(var_89_15.x, var_89_15.y, var_89_15.z)

				local var_89_16 = var_89_9.localEulerAngles

				var_89_16.z = 0
				var_89_16.x = 0
				var_89_9.localEulerAngles = var_89_16
			end

			if arg_86_1.time_ >= var_89_10 + var_89_12 and arg_86_1.time_ < var_89_10 + var_89_12 + arg_89_0 then
				var_89_9.localPosition = Vector3.New(0, 100, 0)

				local var_89_17 = manager.ui.mainCamera.transform.position - var_89_9.position

				var_89_9.forward = Vector3.New(var_89_17.x, var_89_17.y, var_89_17.z)

				local var_89_18 = var_89_9.localEulerAngles

				var_89_18.z = 0
				var_89_18.x = 0
				var_89_9.localEulerAngles = var_89_18

				local var_89_19 = GameObjectTools.GetOrAddComponent(var_89_9.gameObject, typeof(DynamicBoneHelper))

				if var_89_19 then
					var_89_19:EnableDynamicBone(true)
				end
			end

			local var_89_20 = arg_86_1.actors_["10171ui_story"]
			local var_89_21 = 0

			if var_89_21 < arg_86_1.time_ and arg_86_1.time_ <= var_89_21 + arg_89_0 and not isNil(var_89_20) and arg_86_1.var_.characterEffect10171ui_story == nil then
				arg_86_1.var_.characterEffect10171ui_story = var_89_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_22 = 0.200000002980232

			if var_89_21 <= arg_86_1.time_ and arg_86_1.time_ < var_89_21 + var_89_22 and not isNil(var_89_20) then
				local var_89_23 = (arg_86_1.time_ - var_89_21) / var_89_22

				if arg_86_1.var_.characterEffect10171ui_story and not isNil(var_89_20) then
					local var_89_24 = Mathf.Lerp(0, 0.5, var_89_23)

					arg_86_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10171ui_story.fillRatio = var_89_24
				end
			end

			if arg_86_1.time_ >= var_89_21 + var_89_22 and arg_86_1.time_ < var_89_21 + var_89_22 + arg_89_0 and not isNil(var_89_20) and arg_86_1.var_.characterEffect10171ui_story then
				local var_89_25 = 0.5

				arg_86_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10171ui_story.fillRatio = var_89_25
			end

			local var_89_26 = 0
			local var_89_27 = 1.075

			if var_89_26 < arg_86_1.time_ and arg_86_1.time_ <= var_89_26 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_28 = arg_86_1:GetWordFromCfg(324081020)
				local var_89_29 = arg_86_1:FormatText(var_89_28.content)

				arg_86_1.text_.text = var_89_29

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_30 = 43
				local var_89_31 = utf8.len(var_89_29)
				local var_89_32 = var_89_30 <= 0 and var_89_27 or var_89_27 * (var_89_31 / var_89_30)

				if var_89_32 > 0 and var_89_27 < var_89_32 then
					arg_86_1.talkMaxDuration = var_89_32

					if var_89_32 + var_89_26 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_32 + var_89_26
					end
				end

				arg_86_1.text_.text = var_89_29
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_33 = math.max(var_89_27, arg_86_1.talkMaxDuration)

			if var_89_26 <= arg_86_1.time_ and arg_86_1.time_ < var_89_26 + var_89_33 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_26) / var_89_33

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_26 + var_89_33 and arg_86_1.time_ < var_89_26 + var_89_33 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play324081021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324081021
		arg_90_1.duration_ = 8.23

		local var_90_0 = {
			zh = 8.233,
			ja = 7.9
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play324081022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10171ui_story"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos10171ui_story = var_93_0.localPosition

				local var_93_2 = GameObjectTools.GetOrAddComponent(var_93_0.gameObject, typeof(DynamicBoneHelper))

				if var_93_2 then
					var_93_2:EnableDynamicBone(false)
				end
			end

			local var_93_3 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_3 then
				local var_93_4 = (arg_90_1.time_ - var_93_1) / var_93_3
				local var_93_5 = Vector3.New(0, -0.95, -6.05)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10171ui_story, var_93_5, var_93_4)

				local var_93_6 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_6.x, var_93_6.y, var_93_6.z)

				local var_93_7 = var_93_0.localEulerAngles

				var_93_7.z = 0
				var_93_7.x = 0
				var_93_0.localEulerAngles = var_93_7
			end

			if arg_90_1.time_ >= var_93_1 + var_93_3 and arg_90_1.time_ < var_93_1 + var_93_3 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_93_8 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_8.x, var_93_8.y, var_93_8.z)

				local var_93_9 = var_93_0.localEulerAngles

				var_93_9.z = 0
				var_93_9.x = 0
				var_93_0.localEulerAngles = var_93_9

				local var_93_10 = GameObjectTools.GetOrAddComponent(var_93_0.gameObject, typeof(DynamicBoneHelper))

				if var_93_10 then
					var_93_10:EnableDynamicBone(true)
				end
			end

			local var_93_11 = arg_90_1.actors_["10171ui_story"]
			local var_93_12 = 0

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 and not isNil(var_93_11) and arg_90_1.var_.characterEffect10171ui_story == nil then
				arg_90_1.var_.characterEffect10171ui_story = var_93_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_13 = 0.200000002980232

			if var_93_12 <= arg_90_1.time_ and arg_90_1.time_ < var_93_12 + var_93_13 and not isNil(var_93_11) then
				local var_93_14 = (arg_90_1.time_ - var_93_12) / var_93_13

				if arg_90_1.var_.characterEffect10171ui_story and not isNil(var_93_11) then
					arg_90_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_12 + var_93_13 and arg_90_1.time_ < var_93_12 + var_93_13 + arg_93_0 and not isNil(var_93_11) and arg_90_1.var_.characterEffect10171ui_story then
				arg_90_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_93_15 = 0
			local var_93_16 = 0.9

			if var_93_15 < arg_90_1.time_ and arg_90_1.time_ <= var_93_15 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_17 = arg_90_1:FormatText(StoryNameCfg[1451].name)

				arg_90_1.leftNameTxt_.text = var_93_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_18 = arg_90_1:GetWordFromCfg(324081021)
				local var_93_19 = arg_90_1:FormatText(var_93_18.content)

				arg_90_1.text_.text = var_93_19

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_20 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081021", "story_v_out_324081.awb") ~= 0 then
					local var_93_23 = manager.audio:GetVoiceLength("story_v_out_324081", "324081021", "story_v_out_324081.awb") / 1000

					if var_93_23 + var_93_15 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_23 + var_93_15
					end

					if var_93_18.prefab_name ~= "" and arg_90_1.actors_[var_93_18.prefab_name] ~= nil then
						local var_93_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_18.prefab_name].transform, "story_v_out_324081", "324081021", "story_v_out_324081.awb")

						arg_90_1:RecordAudio("324081021", var_93_24)
						arg_90_1:RecordAudio("324081021", var_93_24)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_324081", "324081021", "story_v_out_324081.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_324081", "324081021", "story_v_out_324081.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_25 = math.max(var_93_16, arg_90_1.talkMaxDuration)

			if var_93_15 <= arg_90_1.time_ and arg_90_1.time_ < var_93_15 + var_93_25 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_15) / var_93_25

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_15 + var_93_25 and arg_90_1.time_ < var_93_15 + var_93_25 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play324081022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324081022
		arg_94_1.duration_ = 10

		local var_94_0 = {
			zh = 10,
			ja = 8.9
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play324081023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1.275

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[1451].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(324081022)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 51
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081022", "story_v_out_324081.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081022", "story_v_out_324081.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_324081", "324081022", "story_v_out_324081.awb")

						arg_94_1:RecordAudio("324081022", var_97_9)
						arg_94_1:RecordAudio("324081022", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_324081", "324081022", "story_v_out_324081.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_324081", "324081022", "story_v_out_324081.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play324081023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324081023
		arg_98_1.duration_ = 9.3

		local var_98_0 = {
			zh = 9.3,
			ja = 9.2
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play324081024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_101_2 = 0
			local var_101_3 = 1.125

			if var_101_2 < arg_98_1.time_ and arg_98_1.time_ <= var_101_2 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_4 = arg_98_1:FormatText(StoryNameCfg[1451].name)

				arg_98_1.leftNameTxt_.text = var_101_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_5 = arg_98_1:GetWordFromCfg(324081023)
				local var_101_6 = arg_98_1:FormatText(var_101_5.content)

				arg_98_1.text_.text = var_101_6

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_7 = 45
				local var_101_8 = utf8.len(var_101_6)
				local var_101_9 = var_101_7 <= 0 and var_101_3 or var_101_3 * (var_101_8 / var_101_7)

				if var_101_9 > 0 and var_101_3 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_2
					end
				end

				arg_98_1.text_.text = var_101_6
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081023", "story_v_out_324081.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081023", "story_v_out_324081.awb") / 1000

					if var_101_10 + var_101_2 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_2
					end

					if var_101_5.prefab_name ~= "" and arg_98_1.actors_[var_101_5.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_5.prefab_name].transform, "story_v_out_324081", "324081023", "story_v_out_324081.awb")

						arg_98_1:RecordAudio("324081023", var_101_11)
						arg_98_1:RecordAudio("324081023", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_324081", "324081023", "story_v_out_324081.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_324081", "324081023", "story_v_out_324081.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_3, arg_98_1.talkMaxDuration)

			if var_101_2 <= arg_98_1.time_ and arg_98_1.time_ < var_101_2 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_2) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_2 + var_101_12 and arg_98_1.time_ < var_101_2 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play324081024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 324081024
		arg_102_1.duration_ = 8.13

		local var_102_0 = {
			zh = 8.133,
			ja = 7.266
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play324081025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1070ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1070ui_story == nil then
				arg_102_1.var_.characterEffect1070ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1070ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1070ui_story then
				arg_102_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["10171ui_story"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect10171ui_story == nil then
				arg_102_1.var_.characterEffect10171ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.200000002980232

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.characterEffect10171ui_story and not isNil(var_105_4) then
					local var_105_8 = Mathf.Lerp(0, 0.5, var_105_7)

					arg_102_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10171ui_story.fillRatio = var_105_8
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect10171ui_story then
				local var_105_9 = 0.5

				arg_102_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10171ui_story.fillRatio = var_105_9
			end

			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_105_11 = 0

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_105_12 = arg_102_1.actors_["10171ui_story"].transform
			local var_105_13 = 0

			if var_105_13 < arg_102_1.time_ and arg_102_1.time_ <= var_105_13 + arg_105_0 then
				arg_102_1.var_.moveOldPos10171ui_story = var_105_12.localPosition

				local var_105_14 = GameObjectTools.GetOrAddComponent(var_105_12.gameObject, typeof(DynamicBoneHelper))

				if var_105_14 then
					var_105_14:EnableDynamicBone(false)
				end
			end

			local var_105_15 = 0.001

			if var_105_13 <= arg_102_1.time_ and arg_102_1.time_ < var_105_13 + var_105_15 then
				local var_105_16 = (arg_102_1.time_ - var_105_13) / var_105_15
				local var_105_17 = Vector3.New(-0.7, -0.95, -6.05)

				var_105_12.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10171ui_story, var_105_17, var_105_16)

				local var_105_18 = manager.ui.mainCamera.transform.position - var_105_12.position

				var_105_12.forward = Vector3.New(var_105_18.x, var_105_18.y, var_105_18.z)

				local var_105_19 = var_105_12.localEulerAngles

				var_105_19.z = 0
				var_105_19.x = 0
				var_105_12.localEulerAngles = var_105_19
			end

			if arg_102_1.time_ >= var_105_13 + var_105_15 and arg_102_1.time_ < var_105_13 + var_105_15 + arg_105_0 then
				var_105_12.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_105_20 = manager.ui.mainCamera.transform.position - var_105_12.position

				var_105_12.forward = Vector3.New(var_105_20.x, var_105_20.y, var_105_20.z)

				local var_105_21 = var_105_12.localEulerAngles

				var_105_21.z = 0
				var_105_21.x = 0
				var_105_12.localEulerAngles = var_105_21

				local var_105_22 = GameObjectTools.GetOrAddComponent(var_105_12.gameObject, typeof(DynamicBoneHelper))

				if var_105_22 then
					var_105_22:EnableDynamicBone(true)
				end
			end

			local var_105_23 = arg_102_1.actors_["1070ui_story"].transform
			local var_105_24 = 0

			if var_105_24 < arg_102_1.time_ and arg_102_1.time_ <= var_105_24 + arg_105_0 then
				arg_102_1.var_.moveOldPos1070ui_story = var_105_23.localPosition
			end

			local var_105_25 = 0.001

			if var_105_24 <= arg_102_1.time_ and arg_102_1.time_ < var_105_24 + var_105_25 then
				local var_105_26 = (arg_102_1.time_ - var_105_24) / var_105_25
				local var_105_27 = Vector3.New(0.7, -0.95, -6.05)

				var_105_23.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1070ui_story, var_105_27, var_105_26)

				local var_105_28 = manager.ui.mainCamera.transform.position - var_105_23.position

				var_105_23.forward = Vector3.New(var_105_28.x, var_105_28.y, var_105_28.z)

				local var_105_29 = var_105_23.localEulerAngles

				var_105_29.z = 0
				var_105_29.x = 0
				var_105_23.localEulerAngles = var_105_29
			end

			if arg_102_1.time_ >= var_105_24 + var_105_25 and arg_102_1.time_ < var_105_24 + var_105_25 + arg_105_0 then
				var_105_23.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_105_30 = manager.ui.mainCamera.transform.position - var_105_23.position

				var_105_23.forward = Vector3.New(var_105_30.x, var_105_30.y, var_105_30.z)

				local var_105_31 = var_105_23.localEulerAngles

				var_105_31.z = 0
				var_105_31.x = 0
				var_105_23.localEulerAngles = var_105_31
			end

			local var_105_32 = 0
			local var_105_33 = 0.975

			if var_105_32 < arg_102_1.time_ and arg_102_1.time_ <= var_105_32 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_34 = arg_102_1:FormatText(StoryNameCfg[318].name)

				arg_102_1.leftNameTxt_.text = var_105_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_35 = arg_102_1:GetWordFromCfg(324081024)
				local var_105_36 = arg_102_1:FormatText(var_105_35.content)

				arg_102_1.text_.text = var_105_36

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_37 = 39
				local var_105_38 = utf8.len(var_105_36)
				local var_105_39 = var_105_37 <= 0 and var_105_33 or var_105_33 * (var_105_38 / var_105_37)

				if var_105_39 > 0 and var_105_33 < var_105_39 then
					arg_102_1.talkMaxDuration = var_105_39

					if var_105_39 + var_105_32 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_39 + var_105_32
					end
				end

				arg_102_1.text_.text = var_105_36
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081024", "story_v_out_324081.awb") ~= 0 then
					local var_105_40 = manager.audio:GetVoiceLength("story_v_out_324081", "324081024", "story_v_out_324081.awb") / 1000

					if var_105_40 + var_105_32 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_40 + var_105_32
					end

					if var_105_35.prefab_name ~= "" and arg_102_1.actors_[var_105_35.prefab_name] ~= nil then
						local var_105_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_35.prefab_name].transform, "story_v_out_324081", "324081024", "story_v_out_324081.awb")

						arg_102_1:RecordAudio("324081024", var_105_41)
						arg_102_1:RecordAudio("324081024", var_105_41)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_324081", "324081024", "story_v_out_324081.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_324081", "324081024", "story_v_out_324081.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_42 = math.max(var_105_33, arg_102_1.talkMaxDuration)

			if var_105_32 <= arg_102_1.time_ and arg_102_1.time_ < var_105_32 + var_105_42 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_32) / var_105_42

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_32 + var_105_42 and arg_102_1.time_ < var_105_32 + var_105_42 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
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

		arg_102_1:InitPlayNodeList()
	end,
	Play324081025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 324081025
		arg_106_1.duration_ = 3.63

		local var_106_0 = {
			zh = 2.5,
			ja = 3.633
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play324081026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["10171ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10171ui_story == nil then
				arg_106_1.var_.characterEffect10171ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect10171ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect10171ui_story then
				arg_106_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_109_4 = arg_106_1.actors_["1070ui_story"]
			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect1070ui_story == nil then
				arg_106_1.var_.characterEffect1070ui_story = var_109_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.200000002980232

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_6 and not isNil(var_109_4) then
				local var_109_7 = (arg_106_1.time_ - var_109_5) / var_109_6

				if arg_106_1.var_.characterEffect1070ui_story and not isNil(var_109_4) then
					local var_109_8 = Mathf.Lerp(0, 0.5, var_109_7)

					arg_106_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1070ui_story.fillRatio = var_109_8
				end
			end

			if arg_106_1.time_ >= var_109_5 + var_109_6 and arg_106_1.time_ < var_109_5 + var_109_6 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect1070ui_story then
				local var_109_9 = 0.5

				arg_106_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1070ui_story.fillRatio = var_109_9
			end

			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			local var_109_11 = 0

			if var_109_11 < arg_106_1.time_ and arg_106_1.time_ <= var_109_11 + arg_109_0 then
				arg_106_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_109_12 = 0
			local var_109_13 = 0.325

			if var_109_12 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_14 = arg_106_1:FormatText(StoryNameCfg[1451].name)

				arg_106_1.leftNameTxt_.text = var_109_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_15 = arg_106_1:GetWordFromCfg(324081025)
				local var_109_16 = arg_106_1:FormatText(var_109_15.content)

				arg_106_1.text_.text = var_109_16

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_17 = 13
				local var_109_18 = utf8.len(var_109_16)
				local var_109_19 = var_109_17 <= 0 and var_109_13 or var_109_13 * (var_109_18 / var_109_17)

				if var_109_19 > 0 and var_109_13 < var_109_19 then
					arg_106_1.talkMaxDuration = var_109_19

					if var_109_19 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_19 + var_109_12
					end
				end

				arg_106_1.text_.text = var_109_16
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081025", "story_v_out_324081.awb") ~= 0 then
					local var_109_20 = manager.audio:GetVoiceLength("story_v_out_324081", "324081025", "story_v_out_324081.awb") / 1000

					if var_109_20 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_20 + var_109_12
					end

					if var_109_15.prefab_name ~= "" and arg_106_1.actors_[var_109_15.prefab_name] ~= nil then
						local var_109_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_15.prefab_name].transform, "story_v_out_324081", "324081025", "story_v_out_324081.awb")

						arg_106_1:RecordAudio("324081025", var_109_21)
						arg_106_1:RecordAudio("324081025", var_109_21)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_324081", "324081025", "story_v_out_324081.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_324081", "324081025", "story_v_out_324081.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_22 = math.max(var_109_13, arg_106_1.talkMaxDuration)

			if var_109_12 <= arg_106_1.time_ and arg_106_1.time_ < var_109_12 + var_109_22 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_12) / var_109_22

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_12 + var_109_22 and arg_106_1.time_ < var_109_12 + var_109_22 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play324081026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 324081026
		arg_110_1.duration_ = 4.6

		local var_110_0 = {
			zh = 3.2,
			ja = 4.6
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play324081027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1070ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1070ui_story == nil then
				arg_110_1.var_.characterEffect1070ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1070ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1070ui_story then
				arg_110_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_113_4 = arg_110_1.actors_["10171ui_story"]
			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect10171ui_story == nil then
				arg_110_1.var_.characterEffect10171ui_story = var_113_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_6 = 0.200000002980232

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 and not isNil(var_113_4) then
				local var_113_7 = (arg_110_1.time_ - var_113_5) / var_113_6

				if arg_110_1.var_.characterEffect10171ui_story and not isNil(var_113_4) then
					local var_113_8 = Mathf.Lerp(0, 0.5, var_113_7)

					arg_110_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_110_1.var_.characterEffect10171ui_story.fillRatio = var_113_8
				end
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect10171ui_story then
				local var_113_9 = 0.5

				arg_110_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_110_1.var_.characterEffect10171ui_story.fillRatio = var_113_9
			end

			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_113_11 = 0

			if var_113_11 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
				arg_110_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_113_12 = 0
			local var_113_13 = 0.3

			if var_113_12 < arg_110_1.time_ and arg_110_1.time_ <= var_113_12 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_14 = arg_110_1:FormatText(StoryNameCfg[318].name)

				arg_110_1.leftNameTxt_.text = var_113_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_15 = arg_110_1:GetWordFromCfg(324081026)
				local var_113_16 = arg_110_1:FormatText(var_113_15.content)

				arg_110_1.text_.text = var_113_16

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_17 = 12
				local var_113_18 = utf8.len(var_113_16)
				local var_113_19 = var_113_17 <= 0 and var_113_13 or var_113_13 * (var_113_18 / var_113_17)

				if var_113_19 > 0 and var_113_13 < var_113_19 then
					arg_110_1.talkMaxDuration = var_113_19

					if var_113_19 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_19 + var_113_12
					end
				end

				arg_110_1.text_.text = var_113_16
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081026", "story_v_out_324081.awb") ~= 0 then
					local var_113_20 = manager.audio:GetVoiceLength("story_v_out_324081", "324081026", "story_v_out_324081.awb") / 1000

					if var_113_20 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_20 + var_113_12
					end

					if var_113_15.prefab_name ~= "" and arg_110_1.actors_[var_113_15.prefab_name] ~= nil then
						local var_113_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_15.prefab_name].transform, "story_v_out_324081", "324081026", "story_v_out_324081.awb")

						arg_110_1:RecordAudio("324081026", var_113_21)
						arg_110_1:RecordAudio("324081026", var_113_21)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_324081", "324081026", "story_v_out_324081.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_324081", "324081026", "story_v_out_324081.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_22 = math.max(var_113_13, arg_110_1.talkMaxDuration)

			if var_113_12 <= arg_110_1.time_ and arg_110_1.time_ < var_113_12 + var_113_22 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_12) / var_113_22

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_12 + var_113_22 and arg_110_1.time_ < var_113_12 + var_113_22 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play324081027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 324081027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play324081028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1070ui_story"].transform
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.var_.moveOldPos1070ui_story = var_117_0.localPosition
			end

			local var_117_2 = 0.001

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2
				local var_117_4 = Vector3.New(0, 100, 0)

				var_117_0.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1070ui_story, var_117_4, var_117_3)

				local var_117_5 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_5.x, var_117_5.y, var_117_5.z)

				local var_117_6 = var_117_0.localEulerAngles

				var_117_6.z = 0
				var_117_6.x = 0
				var_117_0.localEulerAngles = var_117_6
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 then
				var_117_0.localPosition = Vector3.New(0, 100, 0)

				local var_117_7 = manager.ui.mainCamera.transform.position - var_117_0.position

				var_117_0.forward = Vector3.New(var_117_7.x, var_117_7.y, var_117_7.z)

				local var_117_8 = var_117_0.localEulerAngles

				var_117_8.z = 0
				var_117_8.x = 0
				var_117_0.localEulerAngles = var_117_8
			end

			local var_117_9 = arg_114_1.actors_["10171ui_story"].transform
			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1.var_.moveOldPos10171ui_story = var_117_9.localPosition

				local var_117_11 = GameObjectTools.GetOrAddComponent(var_117_9.gameObject, typeof(DynamicBoneHelper))

				if var_117_11 then
					var_117_11:EnableDynamicBone(false)
				end
			end

			local var_117_12 = 0.001

			if var_117_10 <= arg_114_1.time_ and arg_114_1.time_ < var_117_10 + var_117_12 then
				local var_117_13 = (arg_114_1.time_ - var_117_10) / var_117_12
				local var_117_14 = Vector3.New(0, 100, 0)

				var_117_9.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10171ui_story, var_117_14, var_117_13)

				local var_117_15 = manager.ui.mainCamera.transform.position - var_117_9.position

				var_117_9.forward = Vector3.New(var_117_15.x, var_117_15.y, var_117_15.z)

				local var_117_16 = var_117_9.localEulerAngles

				var_117_16.z = 0
				var_117_16.x = 0
				var_117_9.localEulerAngles = var_117_16
			end

			if arg_114_1.time_ >= var_117_10 + var_117_12 and arg_114_1.time_ < var_117_10 + var_117_12 + arg_117_0 then
				var_117_9.localPosition = Vector3.New(0, 100, 0)

				local var_117_17 = manager.ui.mainCamera.transform.position - var_117_9.position

				var_117_9.forward = Vector3.New(var_117_17.x, var_117_17.y, var_117_17.z)

				local var_117_18 = var_117_9.localEulerAngles

				var_117_18.z = 0
				var_117_18.x = 0
				var_117_9.localEulerAngles = var_117_18

				local var_117_19 = GameObjectTools.GetOrAddComponent(var_117_9.gameObject, typeof(DynamicBoneHelper))

				if var_117_19 then
					var_117_19:EnableDynamicBone(true)
				end
			end

			local var_117_20 = arg_114_1.actors_["1070ui_story"]
			local var_117_21 = 0

			if var_117_21 < arg_114_1.time_ and arg_114_1.time_ <= var_117_21 + arg_117_0 and not isNil(var_117_20) and arg_114_1.var_.characterEffect1070ui_story == nil then
				arg_114_1.var_.characterEffect1070ui_story = var_117_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_22 = 0.200000002980232

			if var_117_21 <= arg_114_1.time_ and arg_114_1.time_ < var_117_21 + var_117_22 and not isNil(var_117_20) then
				local var_117_23 = (arg_114_1.time_ - var_117_21) / var_117_22

				if arg_114_1.var_.characterEffect1070ui_story and not isNil(var_117_20) then
					local var_117_24 = Mathf.Lerp(0, 0.5, var_117_23)

					arg_114_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1070ui_story.fillRatio = var_117_24
				end
			end

			if arg_114_1.time_ >= var_117_21 + var_117_22 and arg_114_1.time_ < var_117_21 + var_117_22 + arg_117_0 and not isNil(var_117_20) and arg_114_1.var_.characterEffect1070ui_story then
				local var_117_25 = 0.5

				arg_114_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1070ui_story.fillRatio = var_117_25
			end

			local var_117_26 = 0
			local var_117_27 = 1.7

			if var_117_26 < arg_114_1.time_ and arg_114_1.time_ <= var_117_26 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_28 = arg_114_1:GetWordFromCfg(324081027)
				local var_117_29 = arg_114_1:FormatText(var_117_28.content)

				arg_114_1.text_.text = var_117_29

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_30 = 68
				local var_117_31 = utf8.len(var_117_29)
				local var_117_32 = var_117_30 <= 0 and var_117_27 or var_117_27 * (var_117_31 / var_117_30)

				if var_117_32 > 0 and var_117_27 < var_117_32 then
					arg_114_1.talkMaxDuration = var_117_32

					if var_117_32 + var_117_26 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_32 + var_117_26
					end
				end

				arg_114_1.text_.text = var_117_29
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_33 = math.max(var_117_27, arg_114_1.talkMaxDuration)

			if var_117_26 <= arg_114_1.time_ and arg_114_1.time_ < var_117_26 + var_117_33 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_26) / var_117_33

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_26 + var_117_33 and arg_114_1.time_ < var_117_26 + var_117_33 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play324081028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 324081028
		arg_118_1.duration_ = 1.27

		local var_118_0 = {
			zh = 1.2,
			ja = 1.266
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play324081029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1070ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1070ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(0.7, -0.95, -6.05)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1070ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = arg_118_1.actors_["1070ui_story"]
			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect1070ui_story == nil then
				arg_118_1.var_.characterEffect1070ui_story = var_121_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_11 = 0.200000002980232

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_11 and not isNil(var_121_9) then
				local var_121_12 = (arg_118_1.time_ - var_121_10) / var_121_11

				if arg_118_1.var_.characterEffect1070ui_story and not isNil(var_121_9) then
					arg_118_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_10 + var_121_11 and arg_118_1.time_ < var_121_10 + var_121_11 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect1070ui_story then
				arg_118_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_121_13 = 0

			if var_121_13 < arg_118_1.time_ and arg_118_1.time_ <= var_121_13 + arg_121_0 then
				arg_118_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_121_14 = 0

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				arg_118_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_121_15 = 0
			local var_121_16 = 0.1

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_17 = arg_118_1:FormatText(StoryNameCfg[318].name)

				arg_118_1.leftNameTxt_.text = var_121_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_18 = arg_118_1:GetWordFromCfg(324081028)
				local var_121_19 = arg_118_1:FormatText(var_121_18.content)

				arg_118_1.text_.text = var_121_19

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_20 = 4
				local var_121_21 = utf8.len(var_121_19)
				local var_121_22 = var_121_20 <= 0 and var_121_16 or var_121_16 * (var_121_21 / var_121_20)

				if var_121_22 > 0 and var_121_16 < var_121_22 then
					arg_118_1.talkMaxDuration = var_121_22

					if var_121_22 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_22 + var_121_15
					end
				end

				arg_118_1.text_.text = var_121_19
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081028", "story_v_out_324081.awb") ~= 0 then
					local var_121_23 = manager.audio:GetVoiceLength("story_v_out_324081", "324081028", "story_v_out_324081.awb") / 1000

					if var_121_23 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_23 + var_121_15
					end

					if var_121_18.prefab_name ~= "" and arg_118_1.actors_[var_121_18.prefab_name] ~= nil then
						local var_121_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_18.prefab_name].transform, "story_v_out_324081", "324081028", "story_v_out_324081.awb")

						arg_118_1:RecordAudio("324081028", var_121_24)
						arg_118_1:RecordAudio("324081028", var_121_24)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_324081", "324081028", "story_v_out_324081.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_324081", "324081028", "story_v_out_324081.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_25 = math.max(var_121_16, arg_118_1.talkMaxDuration)

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_25 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_15) / var_121_25

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_15 + var_121_25 and arg_118_1.time_ < var_121_15 + var_121_25 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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

		arg_118_1:InitPlayNodeList()
	end,
	Play324081029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 324081029
		arg_122_1.duration_ = 2.37

		local var_122_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play324081030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["10171ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos10171ui_story = var_125_0.localPosition

				local var_125_2 = GameObjectTools.GetOrAddComponent(var_125_0.gameObject, typeof(DynamicBoneHelper))

				if var_125_2 then
					var_125_2:EnableDynamicBone(false)
				end
			end

			local var_125_3 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_3 then
				local var_125_4 = (arg_122_1.time_ - var_125_1) / var_125_3
				local var_125_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10171ui_story, var_125_5, var_125_4)

				local var_125_6 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_6.x, var_125_6.y, var_125_6.z)

				local var_125_7 = var_125_0.localEulerAngles

				var_125_7.z = 0
				var_125_7.x = 0
				var_125_0.localEulerAngles = var_125_7
			end

			if arg_122_1.time_ >= var_125_1 + var_125_3 and arg_122_1.time_ < var_125_1 + var_125_3 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_125_8 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_8.x, var_125_8.y, var_125_8.z)

				local var_125_9 = var_125_0.localEulerAngles

				var_125_9.z = 0
				var_125_9.x = 0
				var_125_0.localEulerAngles = var_125_9

				local var_125_10 = GameObjectTools.GetOrAddComponent(var_125_0.gameObject, typeof(DynamicBoneHelper))

				if var_125_10 then
					var_125_10:EnableDynamicBone(true)
				end
			end

			local var_125_11 = arg_122_1.actors_["10171ui_story"]
			local var_125_12 = 0

			if var_125_12 < arg_122_1.time_ and arg_122_1.time_ <= var_125_12 + arg_125_0 and not isNil(var_125_11) and arg_122_1.var_.characterEffect10171ui_story == nil then
				arg_122_1.var_.characterEffect10171ui_story = var_125_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_13 = 0.200000002980232

			if var_125_12 <= arg_122_1.time_ and arg_122_1.time_ < var_125_12 + var_125_13 and not isNil(var_125_11) then
				local var_125_14 = (arg_122_1.time_ - var_125_12) / var_125_13

				if arg_122_1.var_.characterEffect10171ui_story and not isNil(var_125_11) then
					arg_122_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_12 + var_125_13 and arg_122_1.time_ < var_125_12 + var_125_13 + arg_125_0 and not isNil(var_125_11) and arg_122_1.var_.characterEffect10171ui_story then
				arg_122_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_125_15 = arg_122_1.actors_["1070ui_story"]
			local var_125_16 = 0

			if var_125_16 < arg_122_1.time_ and arg_122_1.time_ <= var_125_16 + arg_125_0 and not isNil(var_125_15) and arg_122_1.var_.characterEffect1070ui_story == nil then
				arg_122_1.var_.characterEffect1070ui_story = var_125_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_17 = 0.200000002980232

			if var_125_16 <= arg_122_1.time_ and arg_122_1.time_ < var_125_16 + var_125_17 and not isNil(var_125_15) then
				local var_125_18 = (arg_122_1.time_ - var_125_16) / var_125_17

				if arg_122_1.var_.characterEffect1070ui_story and not isNil(var_125_15) then
					local var_125_19 = Mathf.Lerp(0, 0.5, var_125_18)

					arg_122_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1070ui_story.fillRatio = var_125_19
				end
			end

			if arg_122_1.time_ >= var_125_16 + var_125_17 and arg_122_1.time_ < var_125_16 + var_125_17 + arg_125_0 and not isNil(var_125_15) and arg_122_1.var_.characterEffect1070ui_story then
				local var_125_20 = 0.5

				arg_122_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1070ui_story.fillRatio = var_125_20
			end

			local var_125_21 = 0

			if var_125_21 < arg_122_1.time_ and arg_122_1.time_ <= var_125_21 + arg_125_0 then
				arg_122_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_125_22 = 0

			if var_125_22 < arg_122_1.time_ and arg_122_1.time_ <= var_125_22 + arg_125_0 then
				arg_122_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_125_23 = 0
			local var_125_24 = 0.15

			if var_125_23 < arg_122_1.time_ and arg_122_1.time_ <= var_125_23 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_25 = arg_122_1:FormatText(StoryNameCfg[1451].name)

				arg_122_1.leftNameTxt_.text = var_125_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_26 = arg_122_1:GetWordFromCfg(324081029)
				local var_125_27 = arg_122_1:FormatText(var_125_26.content)

				arg_122_1.text_.text = var_125_27

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_28 = 6
				local var_125_29 = utf8.len(var_125_27)
				local var_125_30 = var_125_28 <= 0 and var_125_24 or var_125_24 * (var_125_29 / var_125_28)

				if var_125_30 > 0 and var_125_24 < var_125_30 then
					arg_122_1.talkMaxDuration = var_125_30

					if var_125_30 + var_125_23 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_30 + var_125_23
					end
				end

				arg_122_1.text_.text = var_125_27
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081029", "story_v_out_324081.awb") ~= 0 then
					local var_125_31 = manager.audio:GetVoiceLength("story_v_out_324081", "324081029", "story_v_out_324081.awb") / 1000

					if var_125_31 + var_125_23 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_31 + var_125_23
					end

					if var_125_26.prefab_name ~= "" and arg_122_1.actors_[var_125_26.prefab_name] ~= nil then
						local var_125_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_26.prefab_name].transform, "story_v_out_324081", "324081029", "story_v_out_324081.awb")

						arg_122_1:RecordAudio("324081029", var_125_32)
						arg_122_1:RecordAudio("324081029", var_125_32)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_324081", "324081029", "story_v_out_324081.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_324081", "324081029", "story_v_out_324081.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_33 = math.max(var_125_24, arg_122_1.talkMaxDuration)

			if var_125_23 <= arg_122_1.time_ and arg_122_1.time_ < var_125_23 + var_125_33 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_23) / var_125_33

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_23 + var_125_33 and arg_122_1.time_ < var_125_23 + var_125_33 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play324081030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 324081030
		arg_126_1.duration_ = 6.07

		local var_126_0 = {
			zh = 6.06633333333333,
			ja = 5.86633333333333
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play324081031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = "J22g"

			if arg_126_1.bgs_[var_129_0] == nil then
				local var_129_1 = Object.Instantiate(arg_126_1.paintGo_)

				var_129_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_129_0)
				var_129_1.name = var_129_0
				var_129_1.transform.parent = arg_126_1.stage_.transform
				var_129_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.bgs_[var_129_0] = var_129_1
			end

			local var_129_2 = 1.56666666666667

			if var_129_2 < arg_126_1.time_ and arg_126_1.time_ <= var_129_2 + arg_129_0 then
				local var_129_3 = manager.ui.mainCamera.transform.localPosition
				local var_129_4 = Vector3.New(0, 0, 10) + Vector3.New(var_129_3.x, var_129_3.y, 0)
				local var_129_5 = arg_126_1.bgs_.J22g

				var_129_5.transform.localPosition = var_129_4
				var_129_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_129_6 = var_129_5:GetComponent("SpriteRenderer")

				if var_129_6 and var_129_6.sprite then
					local var_129_7 = (var_129_5.transform.localPosition - var_129_3).z
					local var_129_8 = manager.ui.mainCameraCom_
					local var_129_9 = 2 * var_129_7 * Mathf.Tan(var_129_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_129_10 = var_129_9 * var_129_8.aspect
					local var_129_11 = var_129_6.sprite.bounds.size.x
					local var_129_12 = var_129_6.sprite.bounds.size.y
					local var_129_13 = var_129_10 / var_129_11
					local var_129_14 = var_129_9 / var_129_12
					local var_129_15 = var_129_14 < var_129_13 and var_129_13 or var_129_14

					var_129_5.transform.localScale = Vector3.New(var_129_15, var_129_15, 0)
				end

				for iter_129_0, iter_129_1 in pairs(arg_126_1.bgs_) do
					if iter_129_0 ~= "J22g" then
						iter_129_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_129_16 = 1.56666666666667

			if var_129_16 < arg_126_1.time_ and arg_126_1.time_ <= var_129_16 + arg_129_0 then
				arg_126_1.allBtn_.enabled = false
			end

			local var_129_17 = 0.3

			if arg_126_1.time_ >= var_129_16 + var_129_17 and arg_126_1.time_ < var_129_16 + var_129_17 + arg_129_0 then
				arg_126_1.allBtn_.enabled = true
			end

			local var_129_18 = 0

			if var_129_18 < arg_126_1.time_ and arg_126_1.time_ <= var_129_18 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_19 = 1.56666666666667

			if var_129_18 <= arg_126_1.time_ and arg_126_1.time_ < var_129_18 + var_129_19 then
				local var_129_20 = (arg_126_1.time_ - var_129_18) / var_129_19
				local var_129_21 = Color.New(0, 0, 0)

				var_129_21.a = Mathf.Lerp(0, 1, var_129_20)
				arg_126_1.mask_.color = var_129_21
			end

			if arg_126_1.time_ >= var_129_18 + var_129_19 and arg_126_1.time_ < var_129_18 + var_129_19 + arg_129_0 then
				local var_129_22 = Color.New(0, 0, 0)

				var_129_22.a = 1
				arg_126_1.mask_.color = var_129_22
			end

			local var_129_23 = 1.56666666666667

			if var_129_23 < arg_126_1.time_ and arg_126_1.time_ <= var_129_23 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_24 = 2

			if var_129_23 <= arg_126_1.time_ and arg_126_1.time_ < var_129_23 + var_129_24 then
				local var_129_25 = (arg_126_1.time_ - var_129_23) / var_129_24
				local var_129_26 = Color.New(0, 0, 0)

				var_129_26.a = Mathf.Lerp(1, 0, var_129_25)
				arg_126_1.mask_.color = var_129_26
			end

			if arg_126_1.time_ >= var_129_23 + var_129_24 and arg_126_1.time_ < var_129_23 + var_129_24 + arg_129_0 then
				local var_129_27 = Color.New(0, 0, 0)
				local var_129_28 = 0

				arg_126_1.mask_.enabled = false
				var_129_27.a = var_129_28
				arg_126_1.mask_.color = var_129_27
			end

			local var_129_29 = arg_126_1.actors_["10171ui_story"]
			local var_129_30 = 1.56666666666667

			if var_129_30 < arg_126_1.time_ and arg_126_1.time_ <= var_129_30 + arg_129_0 and not isNil(var_129_29) and arg_126_1.var_.characterEffect10171ui_story == nil then
				arg_126_1.var_.characterEffect10171ui_story = var_129_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_31 = 0.200000002980232

			if var_129_30 <= arg_126_1.time_ and arg_126_1.time_ < var_129_30 + var_129_31 and not isNil(var_129_29) then
				local var_129_32 = (arg_126_1.time_ - var_129_30) / var_129_31

				if arg_126_1.var_.characterEffect10171ui_story and not isNil(var_129_29) then
					local var_129_33 = Mathf.Lerp(0, 0.5, var_129_32)

					arg_126_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10171ui_story.fillRatio = var_129_33
				end
			end

			if arg_126_1.time_ >= var_129_30 + var_129_31 and arg_126_1.time_ < var_129_30 + var_129_31 + arg_129_0 and not isNil(var_129_29) and arg_126_1.var_.characterEffect10171ui_story then
				local var_129_34 = 0.5

				arg_126_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10171ui_story.fillRatio = var_129_34
			end

			local var_129_35 = arg_126_1.actors_["10171ui_story"].transform
			local var_129_36 = 1.56666666666667

			if var_129_36 < arg_126_1.time_ and arg_126_1.time_ <= var_129_36 + arg_129_0 then
				arg_126_1.var_.moveOldPos10171ui_story = var_129_35.localPosition

				local var_129_37 = GameObjectTools.GetOrAddComponent(var_129_35.gameObject, typeof(DynamicBoneHelper))

				if var_129_37 then
					var_129_37:EnableDynamicBone(false)
				end
			end

			local var_129_38 = 0.001

			if var_129_36 <= arg_126_1.time_ and arg_126_1.time_ < var_129_36 + var_129_38 then
				local var_129_39 = (arg_126_1.time_ - var_129_36) / var_129_38
				local var_129_40 = Vector3.New(0, 100, 0)

				var_129_35.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10171ui_story, var_129_40, var_129_39)

				local var_129_41 = manager.ui.mainCamera.transform.position - var_129_35.position

				var_129_35.forward = Vector3.New(var_129_41.x, var_129_41.y, var_129_41.z)

				local var_129_42 = var_129_35.localEulerAngles

				var_129_42.z = 0
				var_129_42.x = 0
				var_129_35.localEulerAngles = var_129_42
			end

			if arg_126_1.time_ >= var_129_36 + var_129_38 and arg_126_1.time_ < var_129_36 + var_129_38 + arg_129_0 then
				var_129_35.localPosition = Vector3.New(0, 100, 0)

				local var_129_43 = manager.ui.mainCamera.transform.position - var_129_35.position

				var_129_35.forward = Vector3.New(var_129_43.x, var_129_43.y, var_129_43.z)

				local var_129_44 = var_129_35.localEulerAngles

				var_129_44.z = 0
				var_129_44.x = 0
				var_129_35.localEulerAngles = var_129_44

				local var_129_45 = GameObjectTools.GetOrAddComponent(var_129_35.gameObject, typeof(DynamicBoneHelper))

				if var_129_45 then
					var_129_45:EnableDynamicBone(true)
				end
			end

			local var_129_46 = arg_126_1.actors_["1070ui_story"].transform
			local var_129_47 = 1.56666666666667

			if var_129_47 < arg_126_1.time_ and arg_126_1.time_ <= var_129_47 + arg_129_0 then
				arg_126_1.var_.moveOldPos1070ui_story = var_129_46.localPosition
			end

			local var_129_48 = 0.001

			if var_129_47 <= arg_126_1.time_ and arg_126_1.time_ < var_129_47 + var_129_48 then
				local var_129_49 = (arg_126_1.time_ - var_129_47) / var_129_48
				local var_129_50 = Vector3.New(0, 100, 0)

				var_129_46.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1070ui_story, var_129_50, var_129_49)

				local var_129_51 = manager.ui.mainCamera.transform.position - var_129_46.position

				var_129_46.forward = Vector3.New(var_129_51.x, var_129_51.y, var_129_51.z)

				local var_129_52 = var_129_46.localEulerAngles

				var_129_52.z = 0
				var_129_52.x = 0
				var_129_46.localEulerAngles = var_129_52
			end

			if arg_126_1.time_ >= var_129_47 + var_129_48 and arg_126_1.time_ < var_129_47 + var_129_48 + arg_129_0 then
				var_129_46.localPosition = Vector3.New(0, 100, 0)

				local var_129_53 = manager.ui.mainCamera.transform.position - var_129_46.position

				var_129_46.forward = Vector3.New(var_129_53.x, var_129_53.y, var_129_53.z)

				local var_129_54 = var_129_46.localEulerAngles

				var_129_54.z = 0
				var_129_54.x = 0
				var_129_46.localEulerAngles = var_129_54
			end

			local var_129_55 = 1.2
			local var_129_56 = 1

			if var_129_55 < arg_126_1.time_ and arg_126_1.time_ <= var_129_55 + arg_129_0 then
				local var_129_57 = "play"
				local var_129_58 = "effect"

				arg_126_1:AudioAction(var_129_57, var_129_58, "se_story_145", "se_story_145_amb_construction", "")
			end

			local var_129_59 = 0.1
			local var_129_60 = 1

			if var_129_59 < arg_126_1.time_ and arg_126_1.time_ <= var_129_59 + arg_129_0 then
				local var_129_61 = "stop"
				local var_129_62 = "effect"

				arg_126_1:AudioAction(var_129_61, var_129_62, "se_story_148", "se_story_148_amb_lost_city", "")
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_63 = 3.13333333333333
			local var_129_64 = 0.225

			if var_129_63 < arg_126_1.time_ and arg_126_1.time_ <= var_129_63 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_65 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_65:setOnUpdate(LuaHelper.FloatAction(function(arg_130_0)
					arg_126_1.dialogCg_.alpha = arg_130_0
				end))
				var_129_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_66 = arg_126_1:FormatText(StoryNameCfg[1468].name)

				arg_126_1.leftNameTxt_.text = var_129_66

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_67 = arg_126_1:GetWordFromCfg(324081030)
				local var_129_68 = arg_126_1:FormatText(var_129_67.content)

				arg_126_1.text_.text = var_129_68

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_69 = 9
				local var_129_70 = utf8.len(var_129_68)
				local var_129_71 = var_129_69 <= 0 and var_129_64 or var_129_64 * (var_129_70 / var_129_69)

				if var_129_71 > 0 and var_129_64 < var_129_71 then
					arg_126_1.talkMaxDuration = var_129_71
					var_129_63 = var_129_63 + 0.3

					if var_129_71 + var_129_63 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_71 + var_129_63
					end
				end

				arg_126_1.text_.text = var_129_68
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081030", "story_v_out_324081.awb") ~= 0 then
					local var_129_72 = manager.audio:GetVoiceLength("story_v_out_324081", "324081030", "story_v_out_324081.awb") / 1000

					if var_129_72 + var_129_63 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_72 + var_129_63
					end

					if var_129_67.prefab_name ~= "" and arg_126_1.actors_[var_129_67.prefab_name] ~= nil then
						local var_129_73 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_67.prefab_name].transform, "story_v_out_324081", "324081030", "story_v_out_324081.awb")

						arg_126_1:RecordAudio("324081030", var_129_73)
						arg_126_1:RecordAudio("324081030", var_129_73)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_324081", "324081030", "story_v_out_324081.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_324081", "324081030", "story_v_out_324081.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_74 = var_129_63 + 0.3
			local var_129_75 = math.max(var_129_64, arg_126_1.talkMaxDuration)

			if var_129_74 <= arg_126_1.time_ and arg_126_1.time_ < var_129_74 + var_129_75 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_74) / var_129_75

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_74 + var_129_75 and arg_126_1.time_ < var_129_74 + var_129_75 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play324081031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324081031
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324081032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1070ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1070ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(0, 100, 0)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1070ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, 100, 0)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = arg_132_1.actors_["10171ui_story"].transform
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1.var_.moveOldPos10171ui_story = var_135_9.localPosition

				local var_135_11 = GameObjectTools.GetOrAddComponent(var_135_9.gameObject, typeof(DynamicBoneHelper))

				if var_135_11 then
					var_135_11:EnableDynamicBone(false)
				end
			end

			local var_135_12 = 0.001

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_12 then
				local var_135_13 = (arg_132_1.time_ - var_135_10) / var_135_12
				local var_135_14 = Vector3.New(0, 100, 0)

				var_135_9.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10171ui_story, var_135_14, var_135_13)

				local var_135_15 = manager.ui.mainCamera.transform.position - var_135_9.position

				var_135_9.forward = Vector3.New(var_135_15.x, var_135_15.y, var_135_15.z)

				local var_135_16 = var_135_9.localEulerAngles

				var_135_16.z = 0
				var_135_16.x = 0
				var_135_9.localEulerAngles = var_135_16
			end

			if arg_132_1.time_ >= var_135_10 + var_135_12 and arg_132_1.time_ < var_135_10 + var_135_12 + arg_135_0 then
				var_135_9.localPosition = Vector3.New(0, 100, 0)

				local var_135_17 = manager.ui.mainCamera.transform.position - var_135_9.position

				var_135_9.forward = Vector3.New(var_135_17.x, var_135_17.y, var_135_17.z)

				local var_135_18 = var_135_9.localEulerAngles

				var_135_18.z = 0
				var_135_18.x = 0
				var_135_9.localEulerAngles = var_135_18

				local var_135_19 = GameObjectTools.GetOrAddComponent(var_135_9.gameObject, typeof(DynamicBoneHelper))

				if var_135_19 then
					var_135_19:EnableDynamicBone(true)
				end
			end

			local var_135_20 = 0.6
			local var_135_21 = 1

			if var_135_20 < arg_132_1.time_ and arg_132_1.time_ <= var_135_20 + arg_135_0 then
				local var_135_22 = "play"
				local var_135_23 = "effect"

				arg_132_1:AudioAction(var_135_22, var_135_23, "se_story_140", "se_story_140_footstep_run01", "")
			end

			local var_135_24 = 0
			local var_135_25 = 1.2

			if var_135_24 < arg_132_1.time_ and arg_132_1.time_ <= var_135_24 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_26 = arg_132_1:GetWordFromCfg(324081031)
				local var_135_27 = arg_132_1:FormatText(var_135_26.content)

				arg_132_1.text_.text = var_135_27

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_28 = 48
				local var_135_29 = utf8.len(var_135_27)
				local var_135_30 = var_135_28 <= 0 and var_135_25 or var_135_25 * (var_135_29 / var_135_28)

				if var_135_30 > 0 and var_135_25 < var_135_30 then
					arg_132_1.talkMaxDuration = var_135_30

					if var_135_30 + var_135_24 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_30 + var_135_24
					end
				end

				arg_132_1.text_.text = var_135_27
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_31 = math.max(var_135_25, arg_132_1.talkMaxDuration)

			if var_135_24 <= arg_132_1.time_ and arg_132_1.time_ < var_135_24 + var_135_31 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_24) / var_135_31

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_24 + var_135_31 and arg_132_1.time_ < var_135_24 + var_135_31 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play324081032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324081032
		arg_136_1.duration_ = 3.9

		local var_136_0 = {
			zh = 2.933,
			ja = 3.9
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
				arg_136_0:Play324081033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.325

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[1468].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(324081032)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 13
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081032", "story_v_out_324081.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081032", "story_v_out_324081.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_324081", "324081032", "story_v_out_324081.awb")

						arg_136_1:RecordAudio("324081032", var_139_9)
						arg_136_1:RecordAudio("324081032", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_324081", "324081032", "story_v_out_324081.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_324081", "324081032", "story_v_out_324081.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play324081033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324081033
		arg_140_1.duration_ = 3.7

		local var_140_0 = {
			zh = 3.166,
			ja = 3.7
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
				arg_140_0:Play324081034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0
			local var_143_1 = 0.425

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_2 = arg_140_1:FormatText(StoryNameCfg[1452].name)

				arg_140_1.leftNameTxt_.text = var_143_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(324081033)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 17
				local var_143_6 = utf8.len(var_143_4)
				local var_143_7 = var_143_5 <= 0 and var_143_1 or var_143_1 * (var_143_6 / var_143_5)

				if var_143_7 > 0 and var_143_1 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081033", "story_v_out_324081.awb") ~= 0 then
					local var_143_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081033", "story_v_out_324081.awb") / 1000

					if var_143_8 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_0
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_324081", "324081033", "story_v_out_324081.awb")

						arg_140_1:RecordAudio("324081033", var_143_9)
						arg_140_1:RecordAudio("324081033", var_143_9)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_324081", "324081033", "story_v_out_324081.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_324081", "324081033", "story_v_out_324081.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_10 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_10 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_10

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_10 and arg_140_1.time_ < var_143_0 + var_143_10 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play324081034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 324081034
		arg_144_1.duration_ = 4.23

		local var_144_0 = {
			zh = 3.3,
			ja = 4.233
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
				arg_144_0:Play324081035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.375

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[1448].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(324081034)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 15
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081034", "story_v_out_324081.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081034", "story_v_out_324081.awb") / 1000

					if var_147_8 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_0
					end

					if var_147_3.prefab_name ~= "" and arg_144_1.actors_[var_147_3.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_3.prefab_name].transform, "story_v_out_324081", "324081034", "story_v_out_324081.awb")

						arg_144_1:RecordAudio("324081034", var_147_9)
						arg_144_1:RecordAudio("324081034", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_324081", "324081034", "story_v_out_324081.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_324081", "324081034", "story_v_out_324081.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_10 and arg_144_1.time_ < var_147_0 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play324081035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 324081035
		arg_148_1.duration_ = 8

		local var_148_0 = {
			zh = 6.4,
			ja = 8
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play324081036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.7

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[1468].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_3 = arg_148_1:GetWordFromCfg(324081035)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 28
				local var_151_6 = utf8.len(var_151_4)
				local var_151_7 = var_151_5 <= 0 and var_151_1 or var_151_1 * (var_151_6 / var_151_5)

				if var_151_7 > 0 and var_151_1 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_4
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081035", "story_v_out_324081.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081035", "story_v_out_324081.awb") / 1000

					if var_151_8 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_0
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_out_324081", "324081035", "story_v_out_324081.awb")

						arg_148_1:RecordAudio("324081035", var_151_9)
						arg_148_1:RecordAudio("324081035", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_324081", "324081035", "story_v_out_324081.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_324081", "324081035", "story_v_out_324081.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_10 and arg_148_1.time_ < var_151_0 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play324081036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324081036
		arg_152_1.duration_ = 6.1

		local var_152_0 = {
			zh = 5.4,
			ja = 6.1
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
				arg_152_0:Play324081037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.65

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[1448].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:GetWordFromCfg(324081036)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 26
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081036", "story_v_out_324081.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081036", "story_v_out_324081.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_324081", "324081036", "story_v_out_324081.awb")

						arg_152_1:RecordAudio("324081036", var_155_9)
						arg_152_1:RecordAudio("324081036", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_324081", "324081036", "story_v_out_324081.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_324081", "324081036", "story_v_out_324081.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_10 and arg_152_1.time_ < var_155_0 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play324081037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324081037
		arg_156_1.duration_ = 5.63

		local var_156_0 = {
			zh = 4.3,
			ja = 5.633
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
				arg_156_0:Play324081038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 0.575

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_2 = arg_156_1:FormatText(StoryNameCfg[1448].name)

				arg_156_1.leftNameTxt_.text = var_159_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:GetWordFromCfg(324081037)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 23
				local var_159_6 = utf8.len(var_159_4)
				local var_159_7 = var_159_5 <= 0 and var_159_1 or var_159_1 * (var_159_6 / var_159_5)

				if var_159_7 > 0 and var_159_1 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081037", "story_v_out_324081.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081037", "story_v_out_324081.awb") / 1000

					if var_159_8 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_0
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_out_324081", "324081037", "story_v_out_324081.awb")

						arg_156_1:RecordAudio("324081037", var_159_9)
						arg_156_1:RecordAudio("324081037", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_324081", "324081037", "story_v_out_324081.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_324081", "324081037", "story_v_out_324081.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_10 and arg_156_1.time_ < var_159_0 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play324081038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324081038
		arg_160_1.duration_ = 7.6

		local var_160_0 = {
			zh = 5.633,
			ja = 7.6
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
				arg_160_0:Play324081039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 0.725

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[1468].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_3 = arg_160_1:GetWordFromCfg(324081038)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 29
				local var_163_6 = utf8.len(var_163_4)
				local var_163_7 = var_163_5 <= 0 and var_163_1 or var_163_1 * (var_163_6 / var_163_5)

				if var_163_7 > 0 and var_163_1 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081038", "story_v_out_324081.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081038", "story_v_out_324081.awb") / 1000

					if var_163_8 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_0
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_324081", "324081038", "story_v_out_324081.awb")

						arg_160_1:RecordAudio("324081038", var_163_9)
						arg_160_1:RecordAudio("324081038", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_324081", "324081038", "story_v_out_324081.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_324081", "324081038", "story_v_out_324081.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_10 and arg_160_1.time_ < var_163_0 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play324081039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324081039
		arg_164_1.duration_ = 3.1

		local var_164_0 = {
			zh = 2.6,
			ja = 3.1
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
				arg_164_0:Play324081040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.3

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[1448].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:GetWordFromCfg(324081039)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 12
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081039", "story_v_out_324081.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081039", "story_v_out_324081.awb") / 1000

					if var_167_8 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_0
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_324081", "324081039", "story_v_out_324081.awb")

						arg_164_1:RecordAudio("324081039", var_167_9)
						arg_164_1:RecordAudio("324081039", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_324081", "324081039", "story_v_out_324081.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_324081", "324081039", "story_v_out_324081.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_10 and arg_164_1.time_ < var_167_0 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play324081040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324081040
		arg_168_1.duration_ = 3.97

		local var_168_0 = {
			zh = 2.666,
			ja = 3.966
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
				arg_168_0:Play324081041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 0.175

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_2 = arg_168_1:FormatText(StoryNameCfg[1468].name)

				arg_168_1.leftNameTxt_.text = var_171_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_3 = arg_168_1:GetWordFromCfg(324081040)
				local var_171_4 = arg_168_1:FormatText(var_171_3.content)

				arg_168_1.text_.text = var_171_4

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 7
				local var_171_6 = utf8.len(var_171_4)
				local var_171_7 = var_171_5 <= 0 and var_171_1 or var_171_1 * (var_171_6 / var_171_5)

				if var_171_7 > 0 and var_171_1 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_0
					end
				end

				arg_168_1.text_.text = var_171_4
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081040", "story_v_out_324081.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081040", "story_v_out_324081.awb") / 1000

					if var_171_8 + var_171_0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_0
					end

					if var_171_3.prefab_name ~= "" and arg_168_1.actors_[var_171_3.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_3.prefab_name].transform, "story_v_out_324081", "324081040", "story_v_out_324081.awb")

						arg_168_1:RecordAudio("324081040", var_171_9)
						arg_168_1:RecordAudio("324081040", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_324081", "324081040", "story_v_out_324081.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_324081", "324081040", "story_v_out_324081.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_10 and arg_168_1.time_ < var_171_0 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play324081041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324081041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play324081042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 1.225

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_2 = arg_172_1:GetWordFromCfg(324081041)
				local var_175_3 = arg_172_1:FormatText(var_175_2.content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 49
				local var_175_5 = utf8.len(var_175_3)
				local var_175_6 = var_175_4 <= 0 and var_175_1 or var_175_1 * (var_175_5 / var_175_4)

				if var_175_6 > 0 and var_175_1 < var_175_6 then
					arg_172_1.talkMaxDuration = var_175_6

					if var_175_6 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_6 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_7 and arg_172_1.time_ < var_175_0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play324081042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 324081042
		arg_176_1.duration_ = 2

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play324081043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10171ui_story"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos10171ui_story = var_179_0.localPosition

				local var_179_2 = GameObjectTools.GetOrAddComponent(var_179_0.gameObject, typeof(DynamicBoneHelper))

				if var_179_2 then
					var_179_2:EnableDynamicBone(false)
				end
			end

			local var_179_3 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_3 then
				local var_179_4 = (arg_176_1.time_ - var_179_1) / var_179_3
				local var_179_5 = Vector3.New(0, -0.95, -6.05)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10171ui_story, var_179_5, var_179_4)

				local var_179_6 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_6.x, var_179_6.y, var_179_6.z)

				local var_179_7 = var_179_0.localEulerAngles

				var_179_7.z = 0
				var_179_7.x = 0
				var_179_0.localEulerAngles = var_179_7
			end

			if arg_176_1.time_ >= var_179_1 + var_179_3 and arg_176_1.time_ < var_179_1 + var_179_3 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_179_8 = manager.ui.mainCamera.transform.position - var_179_0.position

				var_179_0.forward = Vector3.New(var_179_8.x, var_179_8.y, var_179_8.z)

				local var_179_9 = var_179_0.localEulerAngles

				var_179_9.z = 0
				var_179_9.x = 0
				var_179_0.localEulerAngles = var_179_9

				local var_179_10 = GameObjectTools.GetOrAddComponent(var_179_0.gameObject, typeof(DynamicBoneHelper))

				if var_179_10 then
					var_179_10:EnableDynamicBone(true)
				end
			end

			local var_179_11 = arg_176_1.actors_["10171ui_story"]
			local var_179_12 = 0

			if var_179_12 < arg_176_1.time_ and arg_176_1.time_ <= var_179_12 + arg_179_0 and not isNil(var_179_11) and arg_176_1.var_.characterEffect10171ui_story == nil then
				arg_176_1.var_.characterEffect10171ui_story = var_179_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_13 = 0.200000002980232

			if var_179_12 <= arg_176_1.time_ and arg_176_1.time_ < var_179_12 + var_179_13 and not isNil(var_179_11) then
				local var_179_14 = (arg_176_1.time_ - var_179_12) / var_179_13

				if arg_176_1.var_.characterEffect10171ui_story and not isNil(var_179_11) then
					arg_176_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_12 + var_179_13 and arg_176_1.time_ < var_179_12 + var_179_13 + arg_179_0 and not isNil(var_179_11) and arg_176_1.var_.characterEffect10171ui_story then
				arg_176_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_179_15 = 0

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 then
				arg_176_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action28_1")
			end

			local var_179_16 = 0

			if var_179_16 < arg_176_1.time_ and arg_176_1.time_ <= var_179_16 + arg_179_0 then
				arg_176_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_179_17 = 0
			local var_179_18 = 0.075

			if var_179_17 < arg_176_1.time_ and arg_176_1.time_ <= var_179_17 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_19 = arg_176_1:FormatText(StoryNameCfg[1451].name)

				arg_176_1.leftNameTxt_.text = var_179_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_20 = arg_176_1:GetWordFromCfg(324081042)
				local var_179_21 = arg_176_1:FormatText(var_179_20.content)

				arg_176_1.text_.text = var_179_21

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_22 = 3
				local var_179_23 = utf8.len(var_179_21)
				local var_179_24 = var_179_22 <= 0 and var_179_18 or var_179_18 * (var_179_23 / var_179_22)

				if var_179_24 > 0 and var_179_18 < var_179_24 then
					arg_176_1.talkMaxDuration = var_179_24

					if var_179_24 + var_179_17 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_24 + var_179_17
					end
				end

				arg_176_1.text_.text = var_179_21
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081042", "story_v_out_324081.awb") ~= 0 then
					local var_179_25 = manager.audio:GetVoiceLength("story_v_out_324081", "324081042", "story_v_out_324081.awb") / 1000

					if var_179_25 + var_179_17 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_25 + var_179_17
					end

					if var_179_20.prefab_name ~= "" and arg_176_1.actors_[var_179_20.prefab_name] ~= nil then
						local var_179_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_20.prefab_name].transform, "story_v_out_324081", "324081042", "story_v_out_324081.awb")

						arg_176_1:RecordAudio("324081042", var_179_26)
						arg_176_1:RecordAudio("324081042", var_179_26)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_324081", "324081042", "story_v_out_324081.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_324081", "324081042", "story_v_out_324081.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_27 = math.max(var_179_18, arg_176_1.talkMaxDuration)

			if var_179_17 <= arg_176_1.time_ and arg_176_1.time_ < var_179_17 + var_179_27 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_17) / var_179_27

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_17 + var_179_27 and arg_176_1.time_ < var_179_17 + var_179_27 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play324081043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 324081043
		arg_180_1.duration_ = 2.73

		local var_180_0 = {
			zh = 2.5,
			ja = 2.733
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play324081044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10171ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10171ui_story == nil then
				arg_180_1.var_.characterEffect10171ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect10171ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_180_1.var_.characterEffect10171ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect10171ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_180_1.var_.characterEffect10171ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0
			local var_183_7 = 0.225

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_8 = arg_180_1:FormatText(StoryNameCfg[1448].name)

				arg_180_1.leftNameTxt_.text = var_183_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_9 = arg_180_1:GetWordFromCfg(324081043)
				local var_183_10 = arg_180_1:FormatText(var_183_9.content)

				arg_180_1.text_.text = var_183_10

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 9
				local var_183_12 = utf8.len(var_183_10)
				local var_183_13 = var_183_11 <= 0 and var_183_7 or var_183_7 * (var_183_12 / var_183_11)

				if var_183_13 > 0 and var_183_7 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_10
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081043", "story_v_out_324081.awb") ~= 0 then
					local var_183_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081043", "story_v_out_324081.awb") / 1000

					if var_183_14 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_14 + var_183_6
					end

					if var_183_9.prefab_name ~= "" and arg_180_1.actors_[var_183_9.prefab_name] ~= nil then
						local var_183_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_9.prefab_name].transform, "story_v_out_324081", "324081043", "story_v_out_324081.awb")

						arg_180_1:RecordAudio("324081043", var_183_15)
						arg_180_1:RecordAudio("324081043", var_183_15)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_324081", "324081043", "story_v_out_324081.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_324081", "324081043", "story_v_out_324081.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_16 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_16 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_16

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_16 and arg_180_1.time_ < var_183_6 + var_183_16 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play324081044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 324081044
		arg_184_1.duration_ = 2.93

		local var_184_0 = {
			zh = 2.466,
			ja = 2.933
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play324081045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10171ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10171ui_story == nil then
				arg_184_1.var_.characterEffect10171ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect10171ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10171ui_story then
				arg_184_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_187_4 = 0

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171actionlink/10171action42829")
			end

			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_187_6 = 0
			local var_187_7 = 0.3

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_8 = arg_184_1:FormatText(StoryNameCfg[1451].name)

				arg_184_1.leftNameTxt_.text = var_187_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_9 = arg_184_1:GetWordFromCfg(324081044)
				local var_187_10 = arg_184_1:FormatText(var_187_9.content)

				arg_184_1.text_.text = var_187_10

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_11 = 12
				local var_187_12 = utf8.len(var_187_10)
				local var_187_13 = var_187_11 <= 0 and var_187_7 or var_187_7 * (var_187_12 / var_187_11)

				if var_187_13 > 0 and var_187_7 < var_187_13 then
					arg_184_1.talkMaxDuration = var_187_13

					if var_187_13 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_6
					end
				end

				arg_184_1.text_.text = var_187_10
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081044", "story_v_out_324081.awb") ~= 0 then
					local var_187_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081044", "story_v_out_324081.awb") / 1000

					if var_187_14 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_6
					end

					if var_187_9.prefab_name ~= "" and arg_184_1.actors_[var_187_9.prefab_name] ~= nil then
						local var_187_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_9.prefab_name].transform, "story_v_out_324081", "324081044", "story_v_out_324081.awb")

						arg_184_1:RecordAudio("324081044", var_187_15)
						arg_184_1:RecordAudio("324081044", var_187_15)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_324081", "324081044", "story_v_out_324081.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_324081", "324081044", "story_v_out_324081.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_16 = math.max(var_187_7, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_16 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_6) / var_187_16

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_16 and arg_184_1.time_ < var_187_6 + var_187_16 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play324081045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 324081045
		arg_188_1.duration_ = 9.03

		local var_188_0 = {
			zh = 4.966,
			ja = 9.033
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play324081046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10171ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect10171ui_story == nil then
				arg_188_1.var_.characterEffect10171ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect10171ui_story and not isNil(var_191_0) then
					local var_191_4 = Mathf.Lerp(0, 0.5, var_191_3)

					arg_188_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_188_1.var_.characterEffect10171ui_story.fillRatio = var_191_4
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect10171ui_story then
				local var_191_5 = 0.5

				arg_188_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_188_1.var_.characterEffect10171ui_story.fillRatio = var_191_5
			end

			local var_191_6 = 0
			local var_191_7 = 0.475

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_8 = arg_188_1:FormatText(StoryNameCfg[1448].name)

				arg_188_1.leftNameTxt_.text = var_191_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_9 = arg_188_1:GetWordFromCfg(324081045)
				local var_191_10 = arg_188_1:FormatText(var_191_9.content)

				arg_188_1.text_.text = var_191_10

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_11 = 19
				local var_191_12 = utf8.len(var_191_10)
				local var_191_13 = var_191_11 <= 0 and var_191_7 or var_191_7 * (var_191_12 / var_191_11)

				if var_191_13 > 0 and var_191_7 < var_191_13 then
					arg_188_1.talkMaxDuration = var_191_13

					if var_191_13 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_13 + var_191_6
					end
				end

				arg_188_1.text_.text = var_191_10
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081045", "story_v_out_324081.awb") ~= 0 then
					local var_191_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081045", "story_v_out_324081.awb") / 1000

					if var_191_14 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_14 + var_191_6
					end

					if var_191_9.prefab_name ~= "" and arg_188_1.actors_[var_191_9.prefab_name] ~= nil then
						local var_191_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_9.prefab_name].transform, "story_v_out_324081", "324081045", "story_v_out_324081.awb")

						arg_188_1:RecordAudio("324081045", var_191_15)
						arg_188_1:RecordAudio("324081045", var_191_15)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_324081", "324081045", "story_v_out_324081.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_324081", "324081045", "story_v_out_324081.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_16 = math.max(var_191_7, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_16 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_6) / var_191_16

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_16 and arg_188_1.time_ < var_191_6 + var_191_16 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play324081046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 324081046
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play324081047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10171ui_story"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos10171ui_story = var_195_0.localPosition

				local var_195_2 = GameObjectTools.GetOrAddComponent(var_195_0.gameObject, typeof(DynamicBoneHelper))

				if var_195_2 then
					var_195_2:EnableDynamicBone(false)
				end
			end

			local var_195_3 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_3 then
				local var_195_4 = (arg_192_1.time_ - var_195_1) / var_195_3
				local var_195_5 = Vector3.New(0, 100, 0)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10171ui_story, var_195_5, var_195_4)

				local var_195_6 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_6.x, var_195_6.y, var_195_6.z)

				local var_195_7 = var_195_0.localEulerAngles

				var_195_7.z = 0
				var_195_7.x = 0
				var_195_0.localEulerAngles = var_195_7
			end

			if arg_192_1.time_ >= var_195_1 + var_195_3 and arg_192_1.time_ < var_195_1 + var_195_3 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(0, 100, 0)

				local var_195_8 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_8.x, var_195_8.y, var_195_8.z)

				local var_195_9 = var_195_0.localEulerAngles

				var_195_9.z = 0
				var_195_9.x = 0
				var_195_0.localEulerAngles = var_195_9

				local var_195_10 = GameObjectTools.GetOrAddComponent(var_195_0.gameObject, typeof(DynamicBoneHelper))

				if var_195_10 then
					var_195_10:EnableDynamicBone(true)
				end
			end

			local var_195_11 = 0
			local var_195_12 = 0.575

			if var_195_11 < arg_192_1.time_ and arg_192_1.time_ <= var_195_11 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_13 = arg_192_1:GetWordFromCfg(324081046)
				local var_195_14 = arg_192_1:FormatText(var_195_13.content)

				arg_192_1.text_.text = var_195_14

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_15 = 23
				local var_195_16 = utf8.len(var_195_14)
				local var_195_17 = var_195_15 <= 0 and var_195_12 or var_195_12 * (var_195_16 / var_195_15)

				if var_195_17 > 0 and var_195_12 < var_195_17 then
					arg_192_1.talkMaxDuration = var_195_17

					if var_195_17 + var_195_11 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_17 + var_195_11
					end
				end

				arg_192_1.text_.text = var_195_14
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_18 = math.max(var_195_12, arg_192_1.talkMaxDuration)

			if var_195_11 <= arg_192_1.time_ and arg_192_1.time_ < var_195_11 + var_195_18 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_11) / var_195_18

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_11 + var_195_18 and arg_192_1.time_ < var_195_11 + var_195_18 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play324081047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 324081047
		arg_196_1.duration_ = 6.33

		local var_196_0 = {
			zh = 5.933,
			ja = 6.333
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play324081048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0
			local var_199_1 = 0.5

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_2 = arg_196_1:FormatText(StoryNameCfg[1448].name)

				arg_196_1.leftNameTxt_.text = var_199_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_3 = arg_196_1:GetWordFromCfg(324081047)
				local var_199_4 = arg_196_1:FormatText(var_199_3.content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_5 = 20
				local var_199_6 = utf8.len(var_199_4)
				local var_199_7 = var_199_5 <= 0 and var_199_1 or var_199_1 * (var_199_6 / var_199_5)

				if var_199_7 > 0 and var_199_1 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081047", "story_v_out_324081.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081047", "story_v_out_324081.awb") / 1000

					if var_199_8 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_0
					end

					if var_199_3.prefab_name ~= "" and arg_196_1.actors_[var_199_3.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_3.prefab_name].transform, "story_v_out_324081", "324081047", "story_v_out_324081.awb")

						arg_196_1:RecordAudio("324081047", var_199_9)
						arg_196_1:RecordAudio("324081047", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_324081", "324081047", "story_v_out_324081.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_324081", "324081047", "story_v_out_324081.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_10 and arg_196_1.time_ < var_199_0 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play324081048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 324081048
		arg_200_1.duration_ = 8.17

		local var_200_0 = {
			zh = 7.766,
			ja = 8.166
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play324081049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1070ui_story"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos1070ui_story = var_203_0.localPosition
			end

			local var_203_2 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2
				local var_203_4 = Vector3.New(0, -0.95, -6.05)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1070ui_story, var_203_4, var_203_3)

				local var_203_5 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_5.x, var_203_5.y, var_203_5.z)

				local var_203_6 = var_203_0.localEulerAngles

				var_203_6.z = 0
				var_203_6.x = 0
				var_203_0.localEulerAngles = var_203_6
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_203_7 = manager.ui.mainCamera.transform.position - var_203_0.position

				var_203_0.forward = Vector3.New(var_203_7.x, var_203_7.y, var_203_7.z)

				local var_203_8 = var_203_0.localEulerAngles

				var_203_8.z = 0
				var_203_8.x = 0
				var_203_0.localEulerAngles = var_203_8
			end

			local var_203_9 = arg_200_1.actors_["1070ui_story"]
			local var_203_10 = 0

			if var_203_10 < arg_200_1.time_ and arg_200_1.time_ <= var_203_10 + arg_203_0 and not isNil(var_203_9) and arg_200_1.var_.characterEffect1070ui_story == nil then
				arg_200_1.var_.characterEffect1070ui_story = var_203_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_11 = 0.200000002980232

			if var_203_10 <= arg_200_1.time_ and arg_200_1.time_ < var_203_10 + var_203_11 and not isNil(var_203_9) then
				local var_203_12 = (arg_200_1.time_ - var_203_10) / var_203_11

				if arg_200_1.var_.characterEffect1070ui_story and not isNil(var_203_9) then
					arg_200_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= var_203_10 + var_203_11 and arg_200_1.time_ < var_203_10 + var_203_11 + arg_203_0 and not isNil(var_203_9) and arg_200_1.var_.characterEffect1070ui_story then
				arg_200_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_203_13 = 0

			if var_203_13 < arg_200_1.time_ and arg_200_1.time_ <= var_203_13 + arg_203_0 then
				arg_200_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_203_14 = 0

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				arg_200_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_203_15 = 0
			local var_203_16 = 0.9

			if var_203_15 < arg_200_1.time_ and arg_200_1.time_ <= var_203_15 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_17 = arg_200_1:FormatText(StoryNameCfg[318].name)

				arg_200_1.leftNameTxt_.text = var_203_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_18 = arg_200_1:GetWordFromCfg(324081048)
				local var_203_19 = arg_200_1:FormatText(var_203_18.content)

				arg_200_1.text_.text = var_203_19

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_20 = 36
				local var_203_21 = utf8.len(var_203_19)
				local var_203_22 = var_203_20 <= 0 and var_203_16 or var_203_16 * (var_203_21 / var_203_20)

				if var_203_22 > 0 and var_203_16 < var_203_22 then
					arg_200_1.talkMaxDuration = var_203_22

					if var_203_22 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_22 + var_203_15
					end
				end

				arg_200_1.text_.text = var_203_19
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081048", "story_v_out_324081.awb") ~= 0 then
					local var_203_23 = manager.audio:GetVoiceLength("story_v_out_324081", "324081048", "story_v_out_324081.awb") / 1000

					if var_203_23 + var_203_15 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_23 + var_203_15
					end

					if var_203_18.prefab_name ~= "" and arg_200_1.actors_[var_203_18.prefab_name] ~= nil then
						local var_203_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_18.prefab_name].transform, "story_v_out_324081", "324081048", "story_v_out_324081.awb")

						arg_200_1:RecordAudio("324081048", var_203_24)
						arg_200_1:RecordAudio("324081048", var_203_24)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_324081", "324081048", "story_v_out_324081.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_324081", "324081048", "story_v_out_324081.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_25 = math.max(var_203_16, arg_200_1.talkMaxDuration)

			if var_203_15 <= arg_200_1.time_ and arg_200_1.time_ < var_203_15 + var_203_25 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_15) / var_203_25

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_15 + var_203_25 and arg_200_1.time_ < var_203_15 + var_203_25 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
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

		arg_200_1:InitPlayNodeList()
	end,
	Play324081049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 324081049
		arg_204_1.duration_ = 7.6

		local var_204_0 = {
			zh = 7.6,
			ja = 5.833
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play324081050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["1070ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1070ui_story == nil then
				arg_204_1.var_.characterEffect1070ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect1070ui_story and not isNil(var_207_0) then
					local var_207_4 = Mathf.Lerp(0, 0.5, var_207_3)

					arg_204_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1070ui_story.fillRatio = var_207_4
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect1070ui_story then
				local var_207_5 = 0.5

				arg_204_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1070ui_story.fillRatio = var_207_5
			end

			local var_207_6 = 0
			local var_207_7 = 0.725

			if var_207_6 < arg_204_1.time_ and arg_204_1.time_ <= var_207_6 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_8 = arg_204_1:FormatText(StoryNameCfg[1448].name)

				arg_204_1.leftNameTxt_.text = var_207_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_9 = arg_204_1:GetWordFromCfg(324081049)
				local var_207_10 = arg_204_1:FormatText(var_207_9.content)

				arg_204_1.text_.text = var_207_10

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_11 = 29
				local var_207_12 = utf8.len(var_207_10)
				local var_207_13 = var_207_11 <= 0 and var_207_7 or var_207_7 * (var_207_12 / var_207_11)

				if var_207_13 > 0 and var_207_7 < var_207_13 then
					arg_204_1.talkMaxDuration = var_207_13

					if var_207_13 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_13 + var_207_6
					end
				end

				arg_204_1.text_.text = var_207_10
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081049", "story_v_out_324081.awb") ~= 0 then
					local var_207_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081049", "story_v_out_324081.awb") / 1000

					if var_207_14 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_14 + var_207_6
					end

					if var_207_9.prefab_name ~= "" and arg_204_1.actors_[var_207_9.prefab_name] ~= nil then
						local var_207_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_9.prefab_name].transform, "story_v_out_324081", "324081049", "story_v_out_324081.awb")

						arg_204_1:RecordAudio("324081049", var_207_15)
						arg_204_1:RecordAudio("324081049", var_207_15)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_324081", "324081049", "story_v_out_324081.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_324081", "324081049", "story_v_out_324081.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_16 = math.max(var_207_7, arg_204_1.talkMaxDuration)

			if var_207_6 <= arg_204_1.time_ and arg_204_1.time_ < var_207_6 + var_207_16 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_6) / var_207_16

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_6 + var_207_16 and arg_204_1.time_ < var_207_6 + var_207_16 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play324081050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 324081050
		arg_208_1.duration_ = 8.3

		local var_208_0 = {
			zh = 7.8,
			ja = 8.3
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play324081051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 0.85

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_2 = arg_208_1:FormatText(StoryNameCfg[1448].name)

				arg_208_1.leftNameTxt_.text = var_211_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_3 = arg_208_1:GetWordFromCfg(324081050)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 34
				local var_211_6 = utf8.len(var_211_4)
				local var_211_7 = var_211_5 <= 0 and var_211_1 or var_211_1 * (var_211_6 / var_211_5)

				if var_211_7 > 0 and var_211_1 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081050", "story_v_out_324081.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081050", "story_v_out_324081.awb") / 1000

					if var_211_8 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_0
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_out_324081", "324081050", "story_v_out_324081.awb")

						arg_208_1:RecordAudio("324081050", var_211_9)
						arg_208_1:RecordAudio("324081050", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_324081", "324081050", "story_v_out_324081.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_324081", "324081050", "story_v_out_324081.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_10 and arg_208_1.time_ < var_211_0 + var_211_10 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play324081051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 324081051
		arg_212_1.duration_ = 4.2

		local var_212_0 = {
			zh = 3.233,
			ja = 4.2
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play324081052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1070ui_story"].transform
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.var_.moveOldPos1070ui_story = var_215_0.localPosition
			end

			local var_215_2 = 0.001

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2
				local var_215_4 = Vector3.New(0, 100, 0)

				var_215_0.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1070ui_story, var_215_4, var_215_3)

				local var_215_5 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_5.x, var_215_5.y, var_215_5.z)

				local var_215_6 = var_215_0.localEulerAngles

				var_215_6.z = 0
				var_215_6.x = 0
				var_215_0.localEulerAngles = var_215_6
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 then
				var_215_0.localPosition = Vector3.New(0, 100, 0)

				local var_215_7 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_7.x, var_215_7.y, var_215_7.z)

				local var_215_8 = var_215_0.localEulerAngles

				var_215_8.z = 0
				var_215_8.x = 0
				var_215_0.localEulerAngles = var_215_8
			end

			local var_215_9 = arg_212_1.actors_["10171ui_story"].transform
			local var_215_10 = 0

			if var_215_10 < arg_212_1.time_ and arg_212_1.time_ <= var_215_10 + arg_215_0 then
				arg_212_1.var_.moveOldPos10171ui_story = var_215_9.localPosition

				local var_215_11 = GameObjectTools.GetOrAddComponent(var_215_9.gameObject, typeof(DynamicBoneHelper))

				if var_215_11 then
					var_215_11:EnableDynamicBone(false)
				end
			end

			local var_215_12 = 0.001

			if var_215_10 <= arg_212_1.time_ and arg_212_1.time_ < var_215_10 + var_215_12 then
				local var_215_13 = (arg_212_1.time_ - var_215_10) / var_215_12
				local var_215_14 = Vector3.New(0, -0.95, -6.05)

				var_215_9.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10171ui_story, var_215_14, var_215_13)

				local var_215_15 = manager.ui.mainCamera.transform.position - var_215_9.position

				var_215_9.forward = Vector3.New(var_215_15.x, var_215_15.y, var_215_15.z)

				local var_215_16 = var_215_9.localEulerAngles

				var_215_16.z = 0
				var_215_16.x = 0
				var_215_9.localEulerAngles = var_215_16
			end

			if arg_212_1.time_ >= var_215_10 + var_215_12 and arg_212_1.time_ < var_215_10 + var_215_12 + arg_215_0 then
				var_215_9.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_215_17 = manager.ui.mainCamera.transform.position - var_215_9.position

				var_215_9.forward = Vector3.New(var_215_17.x, var_215_17.y, var_215_17.z)

				local var_215_18 = var_215_9.localEulerAngles

				var_215_18.z = 0
				var_215_18.x = 0
				var_215_9.localEulerAngles = var_215_18

				local var_215_19 = GameObjectTools.GetOrAddComponent(var_215_9.gameObject, typeof(DynamicBoneHelper))

				if var_215_19 then
					var_215_19:EnableDynamicBone(true)
				end
			end

			local var_215_20 = arg_212_1.actors_["10171ui_story"]
			local var_215_21 = 0

			if var_215_21 < arg_212_1.time_ and arg_212_1.time_ <= var_215_21 + arg_215_0 and not isNil(var_215_20) and arg_212_1.var_.characterEffect10171ui_story == nil then
				arg_212_1.var_.characterEffect10171ui_story = var_215_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_22 = 0.200000002980232

			if var_215_21 <= arg_212_1.time_ and arg_212_1.time_ < var_215_21 + var_215_22 and not isNil(var_215_20) then
				local var_215_23 = (arg_212_1.time_ - var_215_21) / var_215_22

				if arg_212_1.var_.characterEffect10171ui_story and not isNil(var_215_20) then
					arg_212_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_21 + var_215_22 and arg_212_1.time_ < var_215_21 + var_215_22 + arg_215_0 and not isNil(var_215_20) and arg_212_1.var_.characterEffect10171ui_story then
				arg_212_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_215_24 = 0

			if var_215_24 < arg_212_1.time_ and arg_212_1.time_ <= var_215_24 + arg_215_0 then
				arg_212_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action29_2")
			end

			local var_215_25 = 0

			if var_215_25 < arg_212_1.time_ and arg_212_1.time_ <= var_215_25 + arg_215_0 then
				arg_212_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_215_26 = 0
			local var_215_27 = 0.375

			if var_215_26 < arg_212_1.time_ and arg_212_1.time_ <= var_215_26 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_28 = arg_212_1:FormatText(StoryNameCfg[1451].name)

				arg_212_1.leftNameTxt_.text = var_215_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_29 = arg_212_1:GetWordFromCfg(324081051)
				local var_215_30 = arg_212_1:FormatText(var_215_29.content)

				arg_212_1.text_.text = var_215_30

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_31 = 15
				local var_215_32 = utf8.len(var_215_30)
				local var_215_33 = var_215_31 <= 0 and var_215_27 or var_215_27 * (var_215_32 / var_215_31)

				if var_215_33 > 0 and var_215_27 < var_215_33 then
					arg_212_1.talkMaxDuration = var_215_33

					if var_215_33 + var_215_26 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_33 + var_215_26
					end
				end

				arg_212_1.text_.text = var_215_30
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081051", "story_v_out_324081.awb") ~= 0 then
					local var_215_34 = manager.audio:GetVoiceLength("story_v_out_324081", "324081051", "story_v_out_324081.awb") / 1000

					if var_215_34 + var_215_26 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_34 + var_215_26
					end

					if var_215_29.prefab_name ~= "" and arg_212_1.actors_[var_215_29.prefab_name] ~= nil then
						local var_215_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_29.prefab_name].transform, "story_v_out_324081", "324081051", "story_v_out_324081.awb")

						arg_212_1:RecordAudio("324081051", var_215_35)
						arg_212_1:RecordAudio("324081051", var_215_35)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_324081", "324081051", "story_v_out_324081.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_324081", "324081051", "story_v_out_324081.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_36 = math.max(var_215_27, arg_212_1.talkMaxDuration)

			if var_215_26 <= arg_212_1.time_ and arg_212_1.time_ < var_215_26 + var_215_36 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_26) / var_215_36

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_26 + var_215_36 and arg_212_1.time_ < var_215_26 + var_215_36 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play324081052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 324081052
		arg_216_1.duration_ = 13.07

		local var_216_0 = {
			zh = 7.933,
			ja = 13.066
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play324081053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1070ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1070ui_story == nil then
				arg_216_1.var_.characterEffect1070ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1070ui_story and not isNil(var_219_0) then
					arg_216_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1070ui_story then
				arg_216_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_219_4 = arg_216_1.actors_["10171ui_story"]
			local var_219_5 = 0

			if var_219_5 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 and not isNil(var_219_4) and arg_216_1.var_.characterEffect10171ui_story == nil then
				arg_216_1.var_.characterEffect10171ui_story = var_219_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_6 = 0.200000002980232

			if var_219_5 <= arg_216_1.time_ and arg_216_1.time_ < var_219_5 + var_219_6 and not isNil(var_219_4) then
				local var_219_7 = (arg_216_1.time_ - var_219_5) / var_219_6

				if arg_216_1.var_.characterEffect10171ui_story and not isNil(var_219_4) then
					local var_219_8 = Mathf.Lerp(0, 0.5, var_219_7)

					arg_216_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10171ui_story.fillRatio = var_219_8
				end
			end

			if arg_216_1.time_ >= var_219_5 + var_219_6 and arg_216_1.time_ < var_219_5 + var_219_6 + arg_219_0 and not isNil(var_219_4) and arg_216_1.var_.characterEffect10171ui_story then
				local var_219_9 = 0.5

				arg_216_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10171ui_story.fillRatio = var_219_9
			end

			local var_219_10 = arg_216_1.actors_["10171ui_story"].transform
			local var_219_11 = 0

			if var_219_11 < arg_216_1.time_ and arg_216_1.time_ <= var_219_11 + arg_219_0 then
				arg_216_1.var_.moveOldPos10171ui_story = var_219_10.localPosition

				local var_219_12 = GameObjectTools.GetOrAddComponent(var_219_10.gameObject, typeof(DynamicBoneHelper))

				if var_219_12 then
					var_219_12:EnableDynamicBone(false)
				end
			end

			local var_219_13 = 0.001

			if var_219_11 <= arg_216_1.time_ and arg_216_1.time_ < var_219_11 + var_219_13 then
				local var_219_14 = (arg_216_1.time_ - var_219_11) / var_219_13
				local var_219_15 = Vector3.New(0.7, -0.95, -6.05)

				var_219_10.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10171ui_story, var_219_15, var_219_14)

				local var_219_16 = manager.ui.mainCamera.transform.position - var_219_10.position

				var_219_10.forward = Vector3.New(var_219_16.x, var_219_16.y, var_219_16.z)

				local var_219_17 = var_219_10.localEulerAngles

				var_219_17.z = 0
				var_219_17.x = 0
				var_219_10.localEulerAngles = var_219_17
			end

			if arg_216_1.time_ >= var_219_11 + var_219_13 and arg_216_1.time_ < var_219_11 + var_219_13 + arg_219_0 then
				var_219_10.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_219_18 = manager.ui.mainCamera.transform.position - var_219_10.position

				var_219_10.forward = Vector3.New(var_219_18.x, var_219_18.y, var_219_18.z)

				local var_219_19 = var_219_10.localEulerAngles

				var_219_19.z = 0
				var_219_19.x = 0
				var_219_10.localEulerAngles = var_219_19

				local var_219_20 = GameObjectTools.GetOrAddComponent(var_219_10.gameObject, typeof(DynamicBoneHelper))

				if var_219_20 then
					var_219_20:EnableDynamicBone(true)
				end
			end

			local var_219_21 = arg_216_1.actors_["1070ui_story"].transform
			local var_219_22 = 0

			if var_219_22 < arg_216_1.time_ and arg_216_1.time_ <= var_219_22 + arg_219_0 then
				arg_216_1.var_.moveOldPos1070ui_story = var_219_21.localPosition
			end

			local var_219_23 = 0.001

			if var_219_22 <= arg_216_1.time_ and arg_216_1.time_ < var_219_22 + var_219_23 then
				local var_219_24 = (arg_216_1.time_ - var_219_22) / var_219_23
				local var_219_25 = Vector3.New(-0.7, -0.95, -6.05)

				var_219_21.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1070ui_story, var_219_25, var_219_24)

				local var_219_26 = manager.ui.mainCamera.transform.position - var_219_21.position

				var_219_21.forward = Vector3.New(var_219_26.x, var_219_26.y, var_219_26.z)

				local var_219_27 = var_219_21.localEulerAngles

				var_219_27.z = 0
				var_219_27.x = 0
				var_219_21.localEulerAngles = var_219_27
			end

			if arg_216_1.time_ >= var_219_22 + var_219_23 and arg_216_1.time_ < var_219_22 + var_219_23 + arg_219_0 then
				var_219_21.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_219_28 = manager.ui.mainCamera.transform.position - var_219_21.position

				var_219_21.forward = Vector3.New(var_219_28.x, var_219_28.y, var_219_28.z)

				local var_219_29 = var_219_21.localEulerAngles

				var_219_29.z = 0
				var_219_29.x = 0
				var_219_21.localEulerAngles = var_219_29
			end

			local var_219_30 = 0

			if var_219_30 < arg_216_1.time_ and arg_216_1.time_ <= var_219_30 + arg_219_0 then
				arg_216_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_219_31 = 0
			local var_219_32 = 1

			if var_219_31 < arg_216_1.time_ and arg_216_1.time_ <= var_219_31 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_33 = arg_216_1:FormatText(StoryNameCfg[318].name)

				arg_216_1.leftNameTxt_.text = var_219_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_34 = arg_216_1:GetWordFromCfg(324081052)
				local var_219_35 = arg_216_1:FormatText(var_219_34.content)

				arg_216_1.text_.text = var_219_35

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_36 = 40
				local var_219_37 = utf8.len(var_219_35)
				local var_219_38 = var_219_36 <= 0 and var_219_32 or var_219_32 * (var_219_37 / var_219_36)

				if var_219_38 > 0 and var_219_32 < var_219_38 then
					arg_216_1.talkMaxDuration = var_219_38

					if var_219_38 + var_219_31 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_38 + var_219_31
					end
				end

				arg_216_1.text_.text = var_219_35
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081052", "story_v_out_324081.awb") ~= 0 then
					local var_219_39 = manager.audio:GetVoiceLength("story_v_out_324081", "324081052", "story_v_out_324081.awb") / 1000

					if var_219_39 + var_219_31 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_39 + var_219_31
					end

					if var_219_34.prefab_name ~= "" and arg_216_1.actors_[var_219_34.prefab_name] ~= nil then
						local var_219_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_34.prefab_name].transform, "story_v_out_324081", "324081052", "story_v_out_324081.awb")

						arg_216_1:RecordAudio("324081052", var_219_40)
						arg_216_1:RecordAudio("324081052", var_219_40)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_324081", "324081052", "story_v_out_324081.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_324081", "324081052", "story_v_out_324081.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_41 = math.max(var_219_32, arg_216_1.talkMaxDuration)

			if var_219_31 <= arg_216_1.time_ and arg_216_1.time_ < var_219_31 + var_219_41 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_31) / var_219_41

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_31 + var_219_41 and arg_216_1.time_ < var_219_31 + var_219_41 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
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

		arg_216_1:InitPlayNodeList()
	end,
	Play324081053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 324081053
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play324081054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["1070ui_story"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos1070ui_story = var_223_0.localPosition
			end

			local var_223_2 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2
				local var_223_4 = Vector3.New(0, 100, 0)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1070ui_story, var_223_4, var_223_3)

				local var_223_5 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_5.x, var_223_5.y, var_223_5.z)

				local var_223_6 = var_223_0.localEulerAngles

				var_223_6.z = 0
				var_223_6.x = 0
				var_223_0.localEulerAngles = var_223_6
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(0, 100, 0)

				local var_223_7 = manager.ui.mainCamera.transform.position - var_223_0.position

				var_223_0.forward = Vector3.New(var_223_7.x, var_223_7.y, var_223_7.z)

				local var_223_8 = var_223_0.localEulerAngles

				var_223_8.z = 0
				var_223_8.x = 0
				var_223_0.localEulerAngles = var_223_8
			end

			local var_223_9 = arg_220_1.actors_["10171ui_story"].transform
			local var_223_10 = 0

			if var_223_10 < arg_220_1.time_ and arg_220_1.time_ <= var_223_10 + arg_223_0 then
				arg_220_1.var_.moveOldPos10171ui_story = var_223_9.localPosition

				local var_223_11 = GameObjectTools.GetOrAddComponent(var_223_9.gameObject, typeof(DynamicBoneHelper))

				if var_223_11 then
					var_223_11:EnableDynamicBone(false)
				end
			end

			local var_223_12 = 0.001

			if var_223_10 <= arg_220_1.time_ and arg_220_1.time_ < var_223_10 + var_223_12 then
				local var_223_13 = (arg_220_1.time_ - var_223_10) / var_223_12
				local var_223_14 = Vector3.New(0, 100, 0)

				var_223_9.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10171ui_story, var_223_14, var_223_13)

				local var_223_15 = manager.ui.mainCamera.transform.position - var_223_9.position

				var_223_9.forward = Vector3.New(var_223_15.x, var_223_15.y, var_223_15.z)

				local var_223_16 = var_223_9.localEulerAngles

				var_223_16.z = 0
				var_223_16.x = 0
				var_223_9.localEulerAngles = var_223_16
			end

			if arg_220_1.time_ >= var_223_10 + var_223_12 and arg_220_1.time_ < var_223_10 + var_223_12 + arg_223_0 then
				var_223_9.localPosition = Vector3.New(0, 100, 0)

				local var_223_17 = manager.ui.mainCamera.transform.position - var_223_9.position

				var_223_9.forward = Vector3.New(var_223_17.x, var_223_17.y, var_223_17.z)

				local var_223_18 = var_223_9.localEulerAngles

				var_223_18.z = 0
				var_223_18.x = 0
				var_223_9.localEulerAngles = var_223_18

				local var_223_19 = GameObjectTools.GetOrAddComponent(var_223_9.gameObject, typeof(DynamicBoneHelper))

				if var_223_19 then
					var_223_19:EnableDynamicBone(true)
				end
			end

			local var_223_20 = arg_220_1.actors_["1070ui_story"]
			local var_223_21 = 0

			if var_223_21 < arg_220_1.time_ and arg_220_1.time_ <= var_223_21 + arg_223_0 and not isNil(var_223_20) and arg_220_1.var_.characterEffect1070ui_story == nil then
				arg_220_1.var_.characterEffect1070ui_story = var_223_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_22 = 0.200000002980232

			if var_223_21 <= arg_220_1.time_ and arg_220_1.time_ < var_223_21 + var_223_22 and not isNil(var_223_20) then
				local var_223_23 = (arg_220_1.time_ - var_223_21) / var_223_22

				if arg_220_1.var_.characterEffect1070ui_story and not isNil(var_223_20) then
					local var_223_24 = Mathf.Lerp(0, 0.5, var_223_23)

					arg_220_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1070ui_story.fillRatio = var_223_24
				end
			end

			if arg_220_1.time_ >= var_223_21 + var_223_22 and arg_220_1.time_ < var_223_21 + var_223_22 + arg_223_0 and not isNil(var_223_20) and arg_220_1.var_.characterEffect1070ui_story then
				local var_223_25 = 0.5

				arg_220_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1070ui_story.fillRatio = var_223_25
			end

			local var_223_26 = 0

			if var_223_26 < arg_220_1.time_ and arg_220_1.time_ <= var_223_26 + arg_223_0 then
				arg_220_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_223_27 = 0

			if var_223_27 < arg_220_1.time_ and arg_220_1.time_ <= var_223_27 + arg_223_0 then
				arg_220_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_223_28 = 0
			local var_223_29 = 1.625

			if var_223_28 < arg_220_1.time_ and arg_220_1.time_ <= var_223_28 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_30 = arg_220_1:GetWordFromCfg(324081053)
				local var_223_31 = arg_220_1:FormatText(var_223_30.content)

				arg_220_1.text_.text = var_223_31

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_32 = 65
				local var_223_33 = utf8.len(var_223_31)
				local var_223_34 = var_223_32 <= 0 and var_223_29 or var_223_29 * (var_223_33 / var_223_32)

				if var_223_34 > 0 and var_223_29 < var_223_34 then
					arg_220_1.talkMaxDuration = var_223_34

					if var_223_34 + var_223_28 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_34 + var_223_28
					end
				end

				arg_220_1.text_.text = var_223_31
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_35 = math.max(var_223_29, arg_220_1.talkMaxDuration)

			if var_223_28 <= arg_220_1.time_ and arg_220_1.time_ < var_223_28 + var_223_35 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_28) / var_223_35

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_28 + var_223_35 and arg_220_1.time_ < var_223_28 + var_223_35 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play324081054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 324081054
		arg_224_1.duration_ = 17.93

		local var_224_0 = {
			zh = 17.933,
			ja = 14.7
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play324081055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0
			local var_227_1 = 1.625

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_2 = arg_224_1:FormatText(StoryNameCfg[1448].name)

				arg_224_1.leftNameTxt_.text = var_227_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_3 = arg_224_1:GetWordFromCfg(324081054)
				local var_227_4 = arg_224_1:FormatText(var_227_3.content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 65
				local var_227_6 = utf8.len(var_227_4)
				local var_227_7 = var_227_5 <= 0 and var_227_1 or var_227_1 * (var_227_6 / var_227_5)

				if var_227_7 > 0 and var_227_1 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_0
					end
				end

				arg_224_1.text_.text = var_227_4
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081054", "story_v_out_324081.awb") ~= 0 then
					local var_227_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081054", "story_v_out_324081.awb") / 1000

					if var_227_8 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_8 + var_227_0
					end

					if var_227_3.prefab_name ~= "" and arg_224_1.actors_[var_227_3.prefab_name] ~= nil then
						local var_227_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_3.prefab_name].transform, "story_v_out_324081", "324081054", "story_v_out_324081.awb")

						arg_224_1:RecordAudio("324081054", var_227_9)
						arg_224_1:RecordAudio("324081054", var_227_9)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_324081", "324081054", "story_v_out_324081.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_324081", "324081054", "story_v_out_324081.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_10 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_10 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_10

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_10 and arg_224_1.time_ < var_227_0 + var_227_10 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play324081055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 324081055
		arg_228_1.duration_ = 5.9

		local var_228_0 = {
			zh = 3.333,
			ja = 5.9
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play324081056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1070ui_story"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos1070ui_story = var_231_0.localPosition
			end

			local var_231_2 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2
				local var_231_4 = Vector3.New(0, -0.95, -6.05)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1070ui_story, var_231_4, var_231_3)

				local var_231_5 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_5.x, var_231_5.y, var_231_5.z)

				local var_231_6 = var_231_0.localEulerAngles

				var_231_6.z = 0
				var_231_6.x = 0
				var_231_0.localEulerAngles = var_231_6
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_231_7 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_7.x, var_231_7.y, var_231_7.z)

				local var_231_8 = var_231_0.localEulerAngles

				var_231_8.z = 0
				var_231_8.x = 0
				var_231_0.localEulerAngles = var_231_8
			end

			local var_231_9 = arg_228_1.actors_["1070ui_story"]
			local var_231_10 = 0

			if var_231_10 < arg_228_1.time_ and arg_228_1.time_ <= var_231_10 + arg_231_0 and not isNil(var_231_9) and arg_228_1.var_.characterEffect1070ui_story == nil then
				arg_228_1.var_.characterEffect1070ui_story = var_231_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_11 = 0.200000002980232

			if var_231_10 <= arg_228_1.time_ and arg_228_1.time_ < var_231_10 + var_231_11 and not isNil(var_231_9) then
				local var_231_12 = (arg_228_1.time_ - var_231_10) / var_231_11

				if arg_228_1.var_.characterEffect1070ui_story and not isNil(var_231_9) then
					arg_228_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_10 + var_231_11 and arg_228_1.time_ < var_231_10 + var_231_11 + arg_231_0 and not isNil(var_231_9) and arg_228_1.var_.characterEffect1070ui_story then
				arg_228_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_231_13 = 0

			if var_231_13 < arg_228_1.time_ and arg_228_1.time_ <= var_231_13 + arg_231_0 then
				arg_228_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_231_14 = 0

			if var_231_14 < arg_228_1.time_ and arg_228_1.time_ <= var_231_14 + arg_231_0 then
				arg_228_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_231_15 = 0
			local var_231_16 = 0.4

			if var_231_15 < arg_228_1.time_ and arg_228_1.time_ <= var_231_15 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_17 = arg_228_1:FormatText(StoryNameCfg[318].name)

				arg_228_1.leftNameTxt_.text = var_231_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_18 = arg_228_1:GetWordFromCfg(324081055)
				local var_231_19 = arg_228_1:FormatText(var_231_18.content)

				arg_228_1.text_.text = var_231_19

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_20 = 16
				local var_231_21 = utf8.len(var_231_19)
				local var_231_22 = var_231_20 <= 0 and var_231_16 or var_231_16 * (var_231_21 / var_231_20)

				if var_231_22 > 0 and var_231_16 < var_231_22 then
					arg_228_1.talkMaxDuration = var_231_22

					if var_231_22 + var_231_15 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_22 + var_231_15
					end
				end

				arg_228_1.text_.text = var_231_19
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081055", "story_v_out_324081.awb") ~= 0 then
					local var_231_23 = manager.audio:GetVoiceLength("story_v_out_324081", "324081055", "story_v_out_324081.awb") / 1000

					if var_231_23 + var_231_15 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_23 + var_231_15
					end

					if var_231_18.prefab_name ~= "" and arg_228_1.actors_[var_231_18.prefab_name] ~= nil then
						local var_231_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_18.prefab_name].transform, "story_v_out_324081", "324081055", "story_v_out_324081.awb")

						arg_228_1:RecordAudio("324081055", var_231_24)
						arg_228_1:RecordAudio("324081055", var_231_24)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_324081", "324081055", "story_v_out_324081.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_324081", "324081055", "story_v_out_324081.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_25 = math.max(var_231_16, arg_228_1.talkMaxDuration)

			if var_231_15 <= arg_228_1.time_ and arg_228_1.time_ < var_231_15 + var_231_25 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_15) / var_231_25

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_15 + var_231_25 and arg_228_1.time_ < var_231_15 + var_231_25 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
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

		arg_228_1:InitPlayNodeList()
	end,
	Play324081056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 324081056
		arg_232_1.duration_ = 11.67

		local var_232_0 = {
			zh = 9.6,
			ja = 11.666
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play324081057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1070ui_story"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1070ui_story == nil then
				arg_232_1.var_.characterEffect1070ui_story = var_235_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.characterEffect1070ui_story and not isNil(var_235_0) then
					local var_235_4 = Mathf.Lerp(0, 0.5, var_235_3)

					arg_232_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1070ui_story.fillRatio = var_235_4
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1070ui_story then
				local var_235_5 = 0.5

				arg_232_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1070ui_story.fillRatio = var_235_5
			end

			local var_235_6 = 0
			local var_235_7 = 0.975

			if var_235_6 < arg_232_1.time_ and arg_232_1.time_ <= var_235_6 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_8 = arg_232_1:FormatText(StoryNameCfg[1448].name)

				arg_232_1.leftNameTxt_.text = var_235_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_9 = arg_232_1:GetWordFromCfg(324081056)
				local var_235_10 = arg_232_1:FormatText(var_235_9.content)

				arg_232_1.text_.text = var_235_10

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_11 = 39
				local var_235_12 = utf8.len(var_235_10)
				local var_235_13 = var_235_11 <= 0 and var_235_7 or var_235_7 * (var_235_12 / var_235_11)

				if var_235_13 > 0 and var_235_7 < var_235_13 then
					arg_232_1.talkMaxDuration = var_235_13

					if var_235_13 + var_235_6 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_13 + var_235_6
					end
				end

				arg_232_1.text_.text = var_235_10
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081056", "story_v_out_324081.awb") ~= 0 then
					local var_235_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081056", "story_v_out_324081.awb") / 1000

					if var_235_14 + var_235_6 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_14 + var_235_6
					end

					if var_235_9.prefab_name ~= "" and arg_232_1.actors_[var_235_9.prefab_name] ~= nil then
						local var_235_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_9.prefab_name].transform, "story_v_out_324081", "324081056", "story_v_out_324081.awb")

						arg_232_1:RecordAudio("324081056", var_235_15)
						arg_232_1:RecordAudio("324081056", var_235_15)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_324081", "324081056", "story_v_out_324081.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_324081", "324081056", "story_v_out_324081.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_16 = math.max(var_235_7, arg_232_1.talkMaxDuration)

			if var_235_6 <= arg_232_1.time_ and arg_232_1.time_ < var_235_6 + var_235_16 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_6) / var_235_16

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_6 + var_235_16 and arg_232_1.time_ < var_235_6 + var_235_16 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play324081057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 324081057
		arg_236_1.duration_ = 10.5

		local var_236_0 = {
			zh = 7.733,
			ja = 10.5
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play324081058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0
			local var_239_1 = 0.8

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_2 = arg_236_1:FormatText(StoryNameCfg[1448].name)

				arg_236_1.leftNameTxt_.text = var_239_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_3 = arg_236_1:GetWordFromCfg(324081057)
				local var_239_4 = arg_236_1:FormatText(var_239_3.content)

				arg_236_1.text_.text = var_239_4

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_5 = 32
				local var_239_6 = utf8.len(var_239_4)
				local var_239_7 = var_239_5 <= 0 and var_239_1 or var_239_1 * (var_239_6 / var_239_5)

				if var_239_7 > 0 and var_239_1 < var_239_7 then
					arg_236_1.talkMaxDuration = var_239_7

					if var_239_7 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_7 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_4
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081057", "story_v_out_324081.awb") ~= 0 then
					local var_239_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081057", "story_v_out_324081.awb") / 1000

					if var_239_8 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_0
					end

					if var_239_3.prefab_name ~= "" and arg_236_1.actors_[var_239_3.prefab_name] ~= nil then
						local var_239_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_3.prefab_name].transform, "story_v_out_324081", "324081057", "story_v_out_324081.awb")

						arg_236_1:RecordAudio("324081057", var_239_9)
						arg_236_1:RecordAudio("324081057", var_239_9)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_324081", "324081057", "story_v_out_324081.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_324081", "324081057", "story_v_out_324081.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_10 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_10 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_10

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_10 and arg_236_1.time_ < var_239_0 + var_239_10 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play324081058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 324081058
		arg_240_1.duration_ = 9.27

		local var_240_0 = {
			zh = 6.366,
			ja = 9.266
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play324081059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["1070ui_story"].transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPos1070ui_story = var_243_0.localPosition
			end

			local var_243_2 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2
				local var_243_4 = Vector3.New(0, 100, 0)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1070ui_story, var_243_4, var_243_3)

				local var_243_5 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_5.x, var_243_5.y, var_243_5.z)

				local var_243_6 = var_243_0.localEulerAngles

				var_243_6.z = 0
				var_243_6.x = 0
				var_243_0.localEulerAngles = var_243_6
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(0, 100, 0)

				local var_243_7 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_7.x, var_243_7.y, var_243_7.z)

				local var_243_8 = var_243_0.localEulerAngles

				var_243_8.z = 0
				var_243_8.x = 0
				var_243_0.localEulerAngles = var_243_8
			end

			local var_243_9 = arg_240_1.actors_["10171ui_story"].transform
			local var_243_10 = 0

			if var_243_10 < arg_240_1.time_ and arg_240_1.time_ <= var_243_10 + arg_243_0 then
				arg_240_1.var_.moveOldPos10171ui_story = var_243_9.localPosition

				local var_243_11 = GameObjectTools.GetOrAddComponent(var_243_9.gameObject, typeof(DynamicBoneHelper))

				if var_243_11 then
					var_243_11:EnableDynamicBone(false)
				end
			end

			local var_243_12 = 0.001

			if var_243_10 <= arg_240_1.time_ and arg_240_1.time_ < var_243_10 + var_243_12 then
				local var_243_13 = (arg_240_1.time_ - var_243_10) / var_243_12
				local var_243_14 = Vector3.New(0, -0.95, -6.05)

				var_243_9.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10171ui_story, var_243_14, var_243_13)

				local var_243_15 = manager.ui.mainCamera.transform.position - var_243_9.position

				var_243_9.forward = Vector3.New(var_243_15.x, var_243_15.y, var_243_15.z)

				local var_243_16 = var_243_9.localEulerAngles

				var_243_16.z = 0
				var_243_16.x = 0
				var_243_9.localEulerAngles = var_243_16
			end

			if arg_240_1.time_ >= var_243_10 + var_243_12 and arg_240_1.time_ < var_243_10 + var_243_12 + arg_243_0 then
				var_243_9.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_243_17 = manager.ui.mainCamera.transform.position - var_243_9.position

				var_243_9.forward = Vector3.New(var_243_17.x, var_243_17.y, var_243_17.z)

				local var_243_18 = var_243_9.localEulerAngles

				var_243_18.z = 0
				var_243_18.x = 0
				var_243_9.localEulerAngles = var_243_18

				local var_243_19 = GameObjectTools.GetOrAddComponent(var_243_9.gameObject, typeof(DynamicBoneHelper))

				if var_243_19 then
					var_243_19:EnableDynamicBone(true)
				end
			end

			local var_243_20 = arg_240_1.actors_["10171ui_story"]
			local var_243_21 = 0

			if var_243_21 < arg_240_1.time_ and arg_240_1.time_ <= var_243_21 + arg_243_0 and not isNil(var_243_20) and arg_240_1.var_.characterEffect10171ui_story == nil then
				arg_240_1.var_.characterEffect10171ui_story = var_243_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_22 = 0.200000002980232

			if var_243_21 <= arg_240_1.time_ and arg_240_1.time_ < var_243_21 + var_243_22 and not isNil(var_243_20) then
				local var_243_23 = (arg_240_1.time_ - var_243_21) / var_243_22

				if arg_240_1.var_.characterEffect10171ui_story and not isNil(var_243_20) then
					arg_240_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_21 + var_243_22 and arg_240_1.time_ < var_243_21 + var_243_22 + arg_243_0 and not isNil(var_243_20) and arg_240_1.var_.characterEffect10171ui_story then
				arg_240_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_243_24 = 0

			if var_243_24 < arg_240_1.time_ and arg_240_1.time_ <= var_243_24 + arg_243_0 then
				arg_240_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			local var_243_25 = 0

			if var_243_25 < arg_240_1.time_ and arg_240_1.time_ <= var_243_25 + arg_243_0 then
				arg_240_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_243_26 = 0
			local var_243_27 = 0.75

			if var_243_26 < arg_240_1.time_ and arg_240_1.time_ <= var_243_26 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_28 = arg_240_1:FormatText(StoryNameCfg[1451].name)

				arg_240_1.leftNameTxt_.text = var_243_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_29 = arg_240_1:GetWordFromCfg(324081058)
				local var_243_30 = arg_240_1:FormatText(var_243_29.content)

				arg_240_1.text_.text = var_243_30

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_31 = 30
				local var_243_32 = utf8.len(var_243_30)
				local var_243_33 = var_243_31 <= 0 and var_243_27 or var_243_27 * (var_243_32 / var_243_31)

				if var_243_33 > 0 and var_243_27 < var_243_33 then
					arg_240_1.talkMaxDuration = var_243_33

					if var_243_33 + var_243_26 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_33 + var_243_26
					end
				end

				arg_240_1.text_.text = var_243_30
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081058", "story_v_out_324081.awb") ~= 0 then
					local var_243_34 = manager.audio:GetVoiceLength("story_v_out_324081", "324081058", "story_v_out_324081.awb") / 1000

					if var_243_34 + var_243_26 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_34 + var_243_26
					end

					if var_243_29.prefab_name ~= "" and arg_240_1.actors_[var_243_29.prefab_name] ~= nil then
						local var_243_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_29.prefab_name].transform, "story_v_out_324081", "324081058", "story_v_out_324081.awb")

						arg_240_1:RecordAudio("324081058", var_243_35)
						arg_240_1:RecordAudio("324081058", var_243_35)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_324081", "324081058", "story_v_out_324081.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_324081", "324081058", "story_v_out_324081.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_36 = math.max(var_243_27, arg_240_1.talkMaxDuration)

			if var_243_26 <= arg_240_1.time_ and arg_240_1.time_ < var_243_26 + var_243_36 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_26) / var_243_36

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_26 + var_243_36 and arg_240_1.time_ < var_243_26 + var_243_36 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play324081059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 324081059
		arg_244_1.duration_ = 8.9

		local var_244_0 = {
			zh = 8.9,
			ja = 8.733
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play324081060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["10171ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect10171ui_story == nil then
				arg_244_1.var_.characterEffect10171ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect10171ui_story and not isNil(var_247_0) then
					local var_247_4 = Mathf.Lerp(0, 0.5, var_247_3)

					arg_244_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_244_1.var_.characterEffect10171ui_story.fillRatio = var_247_4
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect10171ui_story then
				local var_247_5 = 0.5

				arg_244_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_244_1.var_.characterEffect10171ui_story.fillRatio = var_247_5
			end

			local var_247_6 = 0
			local var_247_7 = 0.9

			if var_247_6 < arg_244_1.time_ and arg_244_1.time_ <= var_247_6 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_8 = arg_244_1:FormatText(StoryNameCfg[1448].name)

				arg_244_1.leftNameTxt_.text = var_247_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_9 = arg_244_1:GetWordFromCfg(324081059)
				local var_247_10 = arg_244_1:FormatText(var_247_9.content)

				arg_244_1.text_.text = var_247_10

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_11 = 36
				local var_247_12 = utf8.len(var_247_10)
				local var_247_13 = var_247_11 <= 0 and var_247_7 or var_247_7 * (var_247_12 / var_247_11)

				if var_247_13 > 0 and var_247_7 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_6
					end
				end

				arg_244_1.text_.text = var_247_10
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081059", "story_v_out_324081.awb") ~= 0 then
					local var_247_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081059", "story_v_out_324081.awb") / 1000

					if var_247_14 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_14 + var_247_6
					end

					if var_247_9.prefab_name ~= "" and arg_244_1.actors_[var_247_9.prefab_name] ~= nil then
						local var_247_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_9.prefab_name].transform, "story_v_out_324081", "324081059", "story_v_out_324081.awb")

						arg_244_1:RecordAudio("324081059", var_247_15)
						arg_244_1:RecordAudio("324081059", var_247_15)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_324081", "324081059", "story_v_out_324081.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_324081", "324081059", "story_v_out_324081.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_16 = math.max(var_247_7, arg_244_1.talkMaxDuration)

			if var_247_6 <= arg_244_1.time_ and arg_244_1.time_ < var_247_6 + var_247_16 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_6) / var_247_16

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_6 + var_247_16 and arg_244_1.time_ < var_247_6 + var_247_16 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play324081060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 324081060
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play324081061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["1070ui_story"].transform
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.var_.moveOldPos1070ui_story = var_251_0.localPosition
			end

			local var_251_2 = 0.001

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2
				local var_251_4 = Vector3.New(0, 100, 0)

				var_251_0.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1070ui_story, var_251_4, var_251_3)

				local var_251_5 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_5.x, var_251_5.y, var_251_5.z)

				local var_251_6 = var_251_0.localEulerAngles

				var_251_6.z = 0
				var_251_6.x = 0
				var_251_0.localEulerAngles = var_251_6
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 then
				var_251_0.localPosition = Vector3.New(0, 100, 0)

				local var_251_7 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_7.x, var_251_7.y, var_251_7.z)

				local var_251_8 = var_251_0.localEulerAngles

				var_251_8.z = 0
				var_251_8.x = 0
				var_251_0.localEulerAngles = var_251_8
			end

			local var_251_9 = arg_248_1.actors_["10171ui_story"].transform
			local var_251_10 = 0

			if var_251_10 < arg_248_1.time_ and arg_248_1.time_ <= var_251_10 + arg_251_0 then
				arg_248_1.var_.moveOldPos10171ui_story = var_251_9.localPosition

				local var_251_11 = GameObjectTools.GetOrAddComponent(var_251_9.gameObject, typeof(DynamicBoneHelper))

				if var_251_11 then
					var_251_11:EnableDynamicBone(false)
				end
			end

			local var_251_12 = 0.001

			if var_251_10 <= arg_248_1.time_ and arg_248_1.time_ < var_251_10 + var_251_12 then
				local var_251_13 = (arg_248_1.time_ - var_251_10) / var_251_12
				local var_251_14 = Vector3.New(0, 100, 0)

				var_251_9.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10171ui_story, var_251_14, var_251_13)

				local var_251_15 = manager.ui.mainCamera.transform.position - var_251_9.position

				var_251_9.forward = Vector3.New(var_251_15.x, var_251_15.y, var_251_15.z)

				local var_251_16 = var_251_9.localEulerAngles

				var_251_16.z = 0
				var_251_16.x = 0
				var_251_9.localEulerAngles = var_251_16
			end

			if arg_248_1.time_ >= var_251_10 + var_251_12 and arg_248_1.time_ < var_251_10 + var_251_12 + arg_251_0 then
				var_251_9.localPosition = Vector3.New(0, 100, 0)

				local var_251_17 = manager.ui.mainCamera.transform.position - var_251_9.position

				var_251_9.forward = Vector3.New(var_251_17.x, var_251_17.y, var_251_17.z)

				local var_251_18 = var_251_9.localEulerAngles

				var_251_18.z = 0
				var_251_18.x = 0
				var_251_9.localEulerAngles = var_251_18

				local var_251_19 = GameObjectTools.GetOrAddComponent(var_251_9.gameObject, typeof(DynamicBoneHelper))

				if var_251_19 then
					var_251_19:EnableDynamicBone(true)
				end
			end

			local var_251_20 = 0
			local var_251_21 = 1.15

			if var_251_20 < arg_248_1.time_ and arg_248_1.time_ <= var_251_20 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_22 = arg_248_1:GetWordFromCfg(324081060)
				local var_251_23 = arg_248_1:FormatText(var_251_22.content)

				arg_248_1.text_.text = var_251_23

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_24 = 46
				local var_251_25 = utf8.len(var_251_23)
				local var_251_26 = var_251_24 <= 0 and var_251_21 or var_251_21 * (var_251_25 / var_251_24)

				if var_251_26 > 0 and var_251_21 < var_251_26 then
					arg_248_1.talkMaxDuration = var_251_26

					if var_251_26 + var_251_20 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_26 + var_251_20
					end
				end

				arg_248_1.text_.text = var_251_23
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_27 = math.max(var_251_21, arg_248_1.talkMaxDuration)

			if var_251_20 <= arg_248_1.time_ and arg_248_1.time_ < var_251_20 + var_251_27 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_20) / var_251_27

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_20 + var_251_27 and arg_248_1.time_ < var_251_20 + var_251_27 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play324081061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 324081061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play324081062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0
			local var_255_1 = 1.325

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_2 = arg_252_1:GetWordFromCfg(324081061)
				local var_255_3 = arg_252_1:FormatText(var_255_2.content)

				arg_252_1.text_.text = var_255_3

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_4 = 53
				local var_255_5 = utf8.len(var_255_3)
				local var_255_6 = var_255_4 <= 0 and var_255_1 or var_255_1 * (var_255_5 / var_255_4)

				if var_255_6 > 0 and var_255_1 < var_255_6 then
					arg_252_1.talkMaxDuration = var_255_6

					if var_255_6 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_6 + var_255_0
					end
				end

				arg_252_1.text_.text = var_255_3
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_7 = math.max(var_255_1, arg_252_1.talkMaxDuration)

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_7 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_0) / var_255_7

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_0 + var_255_7 and arg_252_1.time_ < var_255_0 + var_255_7 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play324081062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 324081062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play324081063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 1.45
			local var_259_1 = 1

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				local var_259_2 = "play"
				local var_259_3 = "effect"

				arg_256_1:AudioAction(var_259_2, var_259_3, "se_story_side_1148", "se_story_1148_applause", "")
			end

			local var_259_4 = 0
			local var_259_5 = 1.675

			if var_259_4 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_6 = arg_256_1:GetWordFromCfg(324081062)
				local var_259_7 = arg_256_1:FormatText(var_259_6.content)

				arg_256_1.text_.text = var_259_7

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_8 = 67
				local var_259_9 = utf8.len(var_259_7)
				local var_259_10 = var_259_8 <= 0 and var_259_5 or var_259_5 * (var_259_9 / var_259_8)

				if var_259_10 > 0 and var_259_5 < var_259_10 then
					arg_256_1.talkMaxDuration = var_259_10

					if var_259_10 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_4
					end
				end

				arg_256_1.text_.text = var_259_7
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_11 = math.max(var_259_5, arg_256_1.talkMaxDuration)

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_11 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_4) / var_259_11

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_4 + var_259_11 and arg_256_1.time_ < var_259_4 + var_259_11 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play324081063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 324081063
		arg_260_1.duration_ = 3

		local var_260_0 = {
			zh = 2.9,
			ja = 3
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play324081064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.25

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[1468].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_3 = arg_260_1:GetWordFromCfg(324081063)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 10
				local var_263_6 = utf8.len(var_263_4)
				local var_263_7 = var_263_5 <= 0 and var_263_1 or var_263_1 * (var_263_6 / var_263_5)

				if var_263_7 > 0 and var_263_1 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081063", "story_v_out_324081.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081063", "story_v_out_324081.awb") / 1000

					if var_263_8 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_0
					end

					if var_263_3.prefab_name ~= "" and arg_260_1.actors_[var_263_3.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_3.prefab_name].transform, "story_v_out_324081", "324081063", "story_v_out_324081.awb")

						arg_260_1:RecordAudio("324081063", var_263_9)
						arg_260_1:RecordAudio("324081063", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_324081", "324081063", "story_v_out_324081.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_324081", "324081063", "story_v_out_324081.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_10 and arg_260_1.time_ < var_263_0 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play324081064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 324081064
		arg_264_1.duration_ = 4.23

		local var_264_0 = {
			zh = 3.433,
			ja = 4.233
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play324081065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["10171ui_story"].transform
			local var_267_1 = 0

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.var_.moveOldPos10171ui_story = var_267_0.localPosition

				local var_267_2 = GameObjectTools.GetOrAddComponent(var_267_0.gameObject, typeof(DynamicBoneHelper))

				if var_267_2 then
					var_267_2:EnableDynamicBone(false)
				end
			end

			local var_267_3 = 0.001

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_3 then
				local var_267_4 = (arg_264_1.time_ - var_267_1) / var_267_3
				local var_267_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_267_0.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10171ui_story, var_267_5, var_267_4)

				local var_267_6 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_6.x, var_267_6.y, var_267_6.z)

				local var_267_7 = var_267_0.localEulerAngles

				var_267_7.z = 0
				var_267_7.x = 0
				var_267_0.localEulerAngles = var_267_7
			end

			if arg_264_1.time_ >= var_267_1 + var_267_3 and arg_264_1.time_ < var_267_1 + var_267_3 + arg_267_0 then
				var_267_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_267_8 = manager.ui.mainCamera.transform.position - var_267_0.position

				var_267_0.forward = Vector3.New(var_267_8.x, var_267_8.y, var_267_8.z)

				local var_267_9 = var_267_0.localEulerAngles

				var_267_9.z = 0
				var_267_9.x = 0
				var_267_0.localEulerAngles = var_267_9

				local var_267_10 = GameObjectTools.GetOrAddComponent(var_267_0.gameObject, typeof(DynamicBoneHelper))

				if var_267_10 then
					var_267_10:EnableDynamicBone(true)
				end
			end

			local var_267_11 = arg_264_1.actors_["10171ui_story"]
			local var_267_12 = 0

			if var_267_12 < arg_264_1.time_ and arg_264_1.time_ <= var_267_12 + arg_267_0 and not isNil(var_267_11) and arg_264_1.var_.characterEffect10171ui_story == nil then
				arg_264_1.var_.characterEffect10171ui_story = var_267_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_13 = 0.200000002980232

			if var_267_12 <= arg_264_1.time_ and arg_264_1.time_ < var_267_12 + var_267_13 and not isNil(var_267_11) then
				local var_267_14 = (arg_264_1.time_ - var_267_12) / var_267_13

				if arg_264_1.var_.characterEffect10171ui_story and not isNil(var_267_11) then
					arg_264_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_12 + var_267_13 and arg_264_1.time_ < var_267_12 + var_267_13 + arg_267_0 and not isNil(var_267_11) and arg_264_1.var_.characterEffect10171ui_story then
				arg_264_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_267_15 = 0

			if var_267_15 < arg_264_1.time_ and arg_264_1.time_ <= var_267_15 + arg_267_0 then
				arg_264_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171actionlink/10171action43027")
			end

			local var_267_16 = 0

			if var_267_16 < arg_264_1.time_ and arg_264_1.time_ <= var_267_16 + arg_267_0 then
				arg_264_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_267_17 = 0
			local var_267_18 = 0.35

			if var_267_17 < arg_264_1.time_ and arg_264_1.time_ <= var_267_17 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_19 = arg_264_1:FormatText(StoryNameCfg[1451].name)

				arg_264_1.leftNameTxt_.text = var_267_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_20 = arg_264_1:GetWordFromCfg(324081064)
				local var_267_21 = arg_264_1:FormatText(var_267_20.content)

				arg_264_1.text_.text = var_267_21

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_22 = 14
				local var_267_23 = utf8.len(var_267_21)
				local var_267_24 = var_267_22 <= 0 and var_267_18 or var_267_18 * (var_267_23 / var_267_22)

				if var_267_24 > 0 and var_267_18 < var_267_24 then
					arg_264_1.talkMaxDuration = var_267_24

					if var_267_24 + var_267_17 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_24 + var_267_17
					end
				end

				arg_264_1.text_.text = var_267_21
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081064", "story_v_out_324081.awb") ~= 0 then
					local var_267_25 = manager.audio:GetVoiceLength("story_v_out_324081", "324081064", "story_v_out_324081.awb") / 1000

					if var_267_25 + var_267_17 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_25 + var_267_17
					end

					if var_267_20.prefab_name ~= "" and arg_264_1.actors_[var_267_20.prefab_name] ~= nil then
						local var_267_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_20.prefab_name].transform, "story_v_out_324081", "324081064", "story_v_out_324081.awb")

						arg_264_1:RecordAudio("324081064", var_267_26)
						arg_264_1:RecordAudio("324081064", var_267_26)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_324081", "324081064", "story_v_out_324081.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_324081", "324081064", "story_v_out_324081.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_27 = math.max(var_267_18, arg_264_1.talkMaxDuration)

			if var_267_17 <= arg_264_1.time_ and arg_264_1.time_ < var_267_17 + var_267_27 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_17) / var_267_27

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_17 + var_267_27 and arg_264_1.time_ < var_267_17 + var_267_27 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play324081065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 324081065
		arg_268_1.duration_ = 8.07

		local var_268_0 = {
			zh = 7.766,
			ja = 8.066
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play324081066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["10171ui_story"]
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect10171ui_story == nil then
				arg_268_1.var_.characterEffect10171ui_story = var_271_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_2 = 0.200000002980232

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 and not isNil(var_271_0) then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2

				if arg_268_1.var_.characterEffect10171ui_story and not isNil(var_271_0) then
					local var_271_4 = Mathf.Lerp(0, 0.5, var_271_3)

					arg_268_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_268_1.var_.characterEffect10171ui_story.fillRatio = var_271_4
				end
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 and not isNil(var_271_0) and arg_268_1.var_.characterEffect10171ui_story then
				local var_271_5 = 0.5

				arg_268_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_268_1.var_.characterEffect10171ui_story.fillRatio = var_271_5
			end

			local var_271_6 = 0
			local var_271_7 = 0.675

			if var_271_6 < arg_268_1.time_ and arg_268_1.time_ <= var_271_6 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_8 = arg_268_1:FormatText(StoryNameCfg[1448].name)

				arg_268_1.leftNameTxt_.text = var_271_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_9 = arg_268_1:GetWordFromCfg(324081065)
				local var_271_10 = arg_268_1:FormatText(var_271_9.content)

				arg_268_1.text_.text = var_271_10

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_11 = 27
				local var_271_12 = utf8.len(var_271_10)
				local var_271_13 = var_271_11 <= 0 and var_271_7 or var_271_7 * (var_271_12 / var_271_11)

				if var_271_13 > 0 and var_271_7 < var_271_13 then
					arg_268_1.talkMaxDuration = var_271_13

					if var_271_13 + var_271_6 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_13 + var_271_6
					end
				end

				arg_268_1.text_.text = var_271_10
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081065", "story_v_out_324081.awb") ~= 0 then
					local var_271_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081065", "story_v_out_324081.awb") / 1000

					if var_271_14 + var_271_6 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_14 + var_271_6
					end

					if var_271_9.prefab_name ~= "" and arg_268_1.actors_[var_271_9.prefab_name] ~= nil then
						local var_271_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_9.prefab_name].transform, "story_v_out_324081", "324081065", "story_v_out_324081.awb")

						arg_268_1:RecordAudio("324081065", var_271_15)
						arg_268_1:RecordAudio("324081065", var_271_15)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_324081", "324081065", "story_v_out_324081.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_324081", "324081065", "story_v_out_324081.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_16 = math.max(var_271_7, arg_268_1.talkMaxDuration)

			if var_271_6 <= arg_268_1.time_ and arg_268_1.time_ < var_271_6 + var_271_16 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_6) / var_271_16

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_6 + var_271_16 and arg_268_1.time_ < var_271_6 + var_271_16 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play324081066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 324081066
		arg_272_1.duration_ = 10.03

		local var_272_0 = {
			zh = 8.333,
			ja = 10.033
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play324081067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 0.8

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[1448].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_3 = arg_272_1:GetWordFromCfg(324081066)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 32
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081066", "story_v_out_324081.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081066", "story_v_out_324081.awb") / 1000

					if var_275_8 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_0
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_324081", "324081066", "story_v_out_324081.awb")

						arg_272_1:RecordAudio("324081066", var_275_9)
						arg_272_1:RecordAudio("324081066", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_324081", "324081066", "story_v_out_324081.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_324081", "324081066", "story_v_out_324081.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_10 and arg_272_1.time_ < var_275_0 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play324081067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 324081067
		arg_276_1.duration_ = 3.93

		local var_276_0 = {
			zh = 2.3,
			ja = 3.933
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play324081068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1070ui_story"].transform
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.var_.moveOldPos1070ui_story = var_279_0.localPosition
			end

			local var_279_2 = 0.001

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2
				local var_279_4 = Vector3.New(0.7, -0.95, -6.05)

				var_279_0.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1070ui_story, var_279_4, var_279_3)

				local var_279_5 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_5.x, var_279_5.y, var_279_5.z)

				local var_279_6 = var_279_0.localEulerAngles

				var_279_6.z = 0
				var_279_6.x = 0
				var_279_0.localEulerAngles = var_279_6
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 then
				var_279_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_279_7 = manager.ui.mainCamera.transform.position - var_279_0.position

				var_279_0.forward = Vector3.New(var_279_7.x, var_279_7.y, var_279_7.z)

				local var_279_8 = var_279_0.localEulerAngles

				var_279_8.z = 0
				var_279_8.x = 0
				var_279_0.localEulerAngles = var_279_8
			end

			local var_279_9 = arg_276_1.actors_["1070ui_story"]
			local var_279_10 = 0

			if var_279_10 < arg_276_1.time_ and arg_276_1.time_ <= var_279_10 + arg_279_0 and not isNil(var_279_9) and arg_276_1.var_.characterEffect1070ui_story == nil then
				arg_276_1.var_.characterEffect1070ui_story = var_279_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_11 = 0.200000002980232

			if var_279_10 <= arg_276_1.time_ and arg_276_1.time_ < var_279_10 + var_279_11 and not isNil(var_279_9) then
				local var_279_12 = (arg_276_1.time_ - var_279_10) / var_279_11

				if arg_276_1.var_.characterEffect1070ui_story and not isNil(var_279_9) then
					arg_276_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= var_279_10 + var_279_11 and arg_276_1.time_ < var_279_10 + var_279_11 + arg_279_0 and not isNil(var_279_9) and arg_276_1.var_.characterEffect1070ui_story then
				arg_276_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_279_13 = 0

			if var_279_13 < arg_276_1.time_ and arg_276_1.time_ <= var_279_13 + arg_279_0 then
				arg_276_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_279_14 = 0

			if var_279_14 < arg_276_1.time_ and arg_276_1.time_ <= var_279_14 + arg_279_0 then
				arg_276_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_279_15 = 0
			local var_279_16 = 0.275

			if var_279_15 < arg_276_1.time_ and arg_276_1.time_ <= var_279_15 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_17 = arg_276_1:FormatText(StoryNameCfg[318].name)

				arg_276_1.leftNameTxt_.text = var_279_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_18 = arg_276_1:GetWordFromCfg(324081067)
				local var_279_19 = arg_276_1:FormatText(var_279_18.content)

				arg_276_1.text_.text = var_279_19

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_20 = 11
				local var_279_21 = utf8.len(var_279_19)
				local var_279_22 = var_279_20 <= 0 and var_279_16 or var_279_16 * (var_279_21 / var_279_20)

				if var_279_22 > 0 and var_279_16 < var_279_22 then
					arg_276_1.talkMaxDuration = var_279_22

					if var_279_22 + var_279_15 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_22 + var_279_15
					end
				end

				arg_276_1.text_.text = var_279_19
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081067", "story_v_out_324081.awb") ~= 0 then
					local var_279_23 = manager.audio:GetVoiceLength("story_v_out_324081", "324081067", "story_v_out_324081.awb") / 1000

					if var_279_23 + var_279_15 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_23 + var_279_15
					end

					if var_279_18.prefab_name ~= "" and arg_276_1.actors_[var_279_18.prefab_name] ~= nil then
						local var_279_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_18.prefab_name].transform, "story_v_out_324081", "324081067", "story_v_out_324081.awb")

						arg_276_1:RecordAudio("324081067", var_279_24)
						arg_276_1:RecordAudio("324081067", var_279_24)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_324081", "324081067", "story_v_out_324081.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_324081", "324081067", "story_v_out_324081.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_25 = math.max(var_279_16, arg_276_1.talkMaxDuration)

			if var_279_15 <= arg_276_1.time_ and arg_276_1.time_ < var_279_15 + var_279_25 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_15) / var_279_25

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_15 + var_279_25 and arg_276_1.time_ < var_279_15 + var_279_25 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
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

		arg_276_1:InitPlayNodeList()
	end,
	Play324081068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 324081068
		arg_280_1.duration_ = 12.93

		local var_280_0 = {
			zh = 12.933,
			ja = 12.5
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play324081069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1070ui_story"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1070ui_story == nil then
				arg_280_1.var_.characterEffect1070ui_story = var_283_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.characterEffect1070ui_story and not isNil(var_283_0) then
					local var_283_4 = Mathf.Lerp(0, 0.5, var_283_3)

					arg_280_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1070ui_story.fillRatio = var_283_4
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1070ui_story then
				local var_283_5 = 0.5

				arg_280_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1070ui_story.fillRatio = var_283_5
			end

			local var_283_6 = 0
			local var_283_7 = 1

			if var_283_6 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_8 = arg_280_1:FormatText(StoryNameCfg[1448].name)

				arg_280_1.leftNameTxt_.text = var_283_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_9 = arg_280_1:GetWordFromCfg(324081068)
				local var_283_10 = arg_280_1:FormatText(var_283_9.content)

				arg_280_1.text_.text = var_283_10

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_11 = 40
				local var_283_12 = utf8.len(var_283_10)
				local var_283_13 = var_283_11 <= 0 and var_283_7 or var_283_7 * (var_283_12 / var_283_11)

				if var_283_13 > 0 and var_283_7 < var_283_13 then
					arg_280_1.talkMaxDuration = var_283_13

					if var_283_13 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_10
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081068", "story_v_out_324081.awb") ~= 0 then
					local var_283_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081068", "story_v_out_324081.awb") / 1000

					if var_283_14 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_14 + var_283_6
					end

					if var_283_9.prefab_name ~= "" and arg_280_1.actors_[var_283_9.prefab_name] ~= nil then
						local var_283_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_9.prefab_name].transform, "story_v_out_324081", "324081068", "story_v_out_324081.awb")

						arg_280_1:RecordAudio("324081068", var_283_15)
						arg_280_1:RecordAudio("324081068", var_283_15)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_324081", "324081068", "story_v_out_324081.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_324081", "324081068", "story_v_out_324081.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_16 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_16 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_16

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_16 and arg_280_1.time_ < var_283_6 + var_283_16 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play324081069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 324081069
		arg_284_1.duration_ = 2.47

		local var_284_0 = {
			zh = 2.466,
			ja = 2.433
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
				arg_284_0:Play324081070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0
			local var_287_1 = 0.175

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_2 = arg_284_1:FormatText(StoryNameCfg[1448].name)

				arg_284_1.leftNameTxt_.text = var_287_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_3 = arg_284_1:GetWordFromCfg(324081069)
				local var_287_4 = arg_284_1:FormatText(var_287_3.content)

				arg_284_1.text_.text = var_287_4

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 7
				local var_287_6 = utf8.len(var_287_4)
				local var_287_7 = var_287_5 <= 0 and var_287_1 or var_287_1 * (var_287_6 / var_287_5)

				if var_287_7 > 0 and var_287_1 < var_287_7 then
					arg_284_1.talkMaxDuration = var_287_7

					if var_287_7 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_7 + var_287_0
					end
				end

				arg_284_1.text_.text = var_287_4
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081069", "story_v_out_324081.awb") ~= 0 then
					local var_287_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081069", "story_v_out_324081.awb") / 1000

					if var_287_8 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_8 + var_287_0
					end

					if var_287_3.prefab_name ~= "" and arg_284_1.actors_[var_287_3.prefab_name] ~= nil then
						local var_287_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_3.prefab_name].transform, "story_v_out_324081", "324081069", "story_v_out_324081.awb")

						arg_284_1:RecordAudio("324081069", var_287_9)
						arg_284_1:RecordAudio("324081069", var_287_9)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_324081", "324081069", "story_v_out_324081.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_324081", "324081069", "story_v_out_324081.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_10 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_10

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_10 and arg_284_1.time_ < var_287_0 + var_287_10 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play324081070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 324081070
		arg_288_1.duration_ = 4

		local var_288_0 = {
			zh = 4,
			ja = 2.866
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
				arg_288_0:Play324081071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1070ui_story"].transform
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.var_.moveOldPos1070ui_story = var_291_0.localPosition
			end

			local var_291_2 = 0.001

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2
				local var_291_4 = Vector3.New(0.7, -0.95, -6.05)

				var_291_0.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1070ui_story, var_291_4, var_291_3)

				local var_291_5 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_5.x, var_291_5.y, var_291_5.z)

				local var_291_6 = var_291_0.localEulerAngles

				var_291_6.z = 0
				var_291_6.x = 0
				var_291_0.localEulerAngles = var_291_6
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 then
				var_291_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_291_7 = manager.ui.mainCamera.transform.position - var_291_0.position

				var_291_0.forward = Vector3.New(var_291_7.x, var_291_7.y, var_291_7.z)

				local var_291_8 = var_291_0.localEulerAngles

				var_291_8.z = 0
				var_291_8.x = 0
				var_291_0.localEulerAngles = var_291_8
			end

			local var_291_9 = arg_288_1.actors_["10171ui_story"].transform
			local var_291_10 = 0

			if var_291_10 < arg_288_1.time_ and arg_288_1.time_ <= var_291_10 + arg_291_0 then
				arg_288_1.var_.moveOldPos10171ui_story = var_291_9.localPosition

				local var_291_11 = GameObjectTools.GetOrAddComponent(var_291_9.gameObject, typeof(DynamicBoneHelper))

				if var_291_11 then
					var_291_11:EnableDynamicBone(false)
				end
			end

			local var_291_12 = 0.001

			if var_291_10 <= arg_288_1.time_ and arg_288_1.time_ < var_291_10 + var_291_12 then
				local var_291_13 = (arg_288_1.time_ - var_291_10) / var_291_12
				local var_291_14 = Vector3.New(-0.7, -0.95, -6.05)

				var_291_9.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10171ui_story, var_291_14, var_291_13)

				local var_291_15 = manager.ui.mainCamera.transform.position - var_291_9.position

				var_291_9.forward = Vector3.New(var_291_15.x, var_291_15.y, var_291_15.z)

				local var_291_16 = var_291_9.localEulerAngles

				var_291_16.z = 0
				var_291_16.x = 0
				var_291_9.localEulerAngles = var_291_16
			end

			if arg_288_1.time_ >= var_291_10 + var_291_12 and arg_288_1.time_ < var_291_10 + var_291_12 + arg_291_0 then
				var_291_9.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_291_17 = manager.ui.mainCamera.transform.position - var_291_9.position

				var_291_9.forward = Vector3.New(var_291_17.x, var_291_17.y, var_291_17.z)

				local var_291_18 = var_291_9.localEulerAngles

				var_291_18.z = 0
				var_291_18.x = 0
				var_291_9.localEulerAngles = var_291_18

				local var_291_19 = GameObjectTools.GetOrAddComponent(var_291_9.gameObject, typeof(DynamicBoneHelper))

				if var_291_19 then
					var_291_19:EnableDynamicBone(true)
				end
			end

			local var_291_20 = arg_288_1.actors_["10171ui_story"]
			local var_291_21 = 0

			if var_291_21 < arg_288_1.time_ and arg_288_1.time_ <= var_291_21 + arg_291_0 and not isNil(var_291_20) and arg_288_1.var_.characterEffect10171ui_story == nil then
				arg_288_1.var_.characterEffect10171ui_story = var_291_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_22 = 0.200000002980232

			if var_291_21 <= arg_288_1.time_ and arg_288_1.time_ < var_291_21 + var_291_22 and not isNil(var_291_20) then
				local var_291_23 = (arg_288_1.time_ - var_291_21) / var_291_22

				if arg_288_1.var_.characterEffect10171ui_story and not isNil(var_291_20) then
					arg_288_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_21 + var_291_22 and arg_288_1.time_ < var_291_21 + var_291_22 + arg_291_0 and not isNil(var_291_20) and arg_288_1.var_.characterEffect10171ui_story then
				arg_288_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_291_24 = 0

			if var_291_24 < arg_288_1.time_ and arg_288_1.time_ <= var_291_24 + arg_291_0 then
				arg_288_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_2")
			end

			local var_291_25 = 0

			if var_291_25 < arg_288_1.time_ and arg_288_1.time_ <= var_291_25 + arg_291_0 then
				arg_288_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_291_26 = 0
			local var_291_27 = 0.275

			if var_291_26 < arg_288_1.time_ and arg_288_1.time_ <= var_291_26 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_28 = arg_288_1:FormatText(StoryNameCfg[1451].name)

				arg_288_1.leftNameTxt_.text = var_291_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_29 = arg_288_1:GetWordFromCfg(324081070)
				local var_291_30 = arg_288_1:FormatText(var_291_29.content)

				arg_288_1.text_.text = var_291_30

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_31 = 11
				local var_291_32 = utf8.len(var_291_30)
				local var_291_33 = var_291_31 <= 0 and var_291_27 or var_291_27 * (var_291_32 / var_291_31)

				if var_291_33 > 0 and var_291_27 < var_291_33 then
					arg_288_1.talkMaxDuration = var_291_33

					if var_291_33 + var_291_26 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_33 + var_291_26
					end
				end

				arg_288_1.text_.text = var_291_30
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081070", "story_v_out_324081.awb") ~= 0 then
					local var_291_34 = manager.audio:GetVoiceLength("story_v_out_324081", "324081070", "story_v_out_324081.awb") / 1000

					if var_291_34 + var_291_26 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_34 + var_291_26
					end

					if var_291_29.prefab_name ~= "" and arg_288_1.actors_[var_291_29.prefab_name] ~= nil then
						local var_291_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_29.prefab_name].transform, "story_v_out_324081", "324081070", "story_v_out_324081.awb")

						arg_288_1:RecordAudio("324081070", var_291_35)
						arg_288_1:RecordAudio("324081070", var_291_35)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_324081", "324081070", "story_v_out_324081.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_324081", "324081070", "story_v_out_324081.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_36 = math.max(var_291_27, arg_288_1.talkMaxDuration)

			if var_291_26 <= arg_288_1.time_ and arg_288_1.time_ < var_291_26 + var_291_36 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_26) / var_291_36

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_26 + var_291_36 and arg_288_1.time_ < var_291_26 + var_291_36 + arg_291_0 then
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
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
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
	Play324081071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 324081071
		arg_292_1.duration_ = 3.97

		local var_292_0 = {
			zh = 2.333,
			ja = 3.966
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
				arg_292_0:Play324081072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1070ui_story"]
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1070ui_story == nil then
				arg_292_1.var_.characterEffect1070ui_story = var_295_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 and not isNil(var_295_0) then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2

				if arg_292_1.var_.characterEffect1070ui_story and not isNil(var_295_0) then
					arg_292_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 and not isNil(var_295_0) and arg_292_1.var_.characterEffect1070ui_story then
				arg_292_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_295_4 = arg_292_1.actors_["10171ui_story"]
			local var_295_5 = 0

			if var_295_5 < arg_292_1.time_ and arg_292_1.time_ <= var_295_5 + arg_295_0 and not isNil(var_295_4) and arg_292_1.var_.characterEffect10171ui_story == nil then
				arg_292_1.var_.characterEffect10171ui_story = var_295_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_6 = 0.200000002980232

			if var_295_5 <= arg_292_1.time_ and arg_292_1.time_ < var_295_5 + var_295_6 and not isNil(var_295_4) then
				local var_295_7 = (arg_292_1.time_ - var_295_5) / var_295_6

				if arg_292_1.var_.characterEffect10171ui_story and not isNil(var_295_4) then
					local var_295_8 = Mathf.Lerp(0, 0.5, var_295_7)

					arg_292_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_292_1.var_.characterEffect10171ui_story.fillRatio = var_295_8
				end
			end

			if arg_292_1.time_ >= var_295_5 + var_295_6 and arg_292_1.time_ < var_295_5 + var_295_6 + arg_295_0 and not isNil(var_295_4) and arg_292_1.var_.characterEffect10171ui_story then
				local var_295_9 = 0.5

				arg_292_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_292_1.var_.characterEffect10171ui_story.fillRatio = var_295_9
			end

			local var_295_10 = 0

			if var_295_10 < arg_292_1.time_ and arg_292_1.time_ <= var_295_10 + arg_295_0 then
				arg_292_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_295_11 = 0

			if var_295_11 < arg_292_1.time_ and arg_292_1.time_ <= var_295_11 + arg_295_0 then
				arg_292_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_295_12 = 0
			local var_295_13 = 0.225

			if var_295_12 < arg_292_1.time_ and arg_292_1.time_ <= var_295_12 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_14 = arg_292_1:FormatText(StoryNameCfg[318].name)

				arg_292_1.leftNameTxt_.text = var_295_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_15 = arg_292_1:GetWordFromCfg(324081071)
				local var_295_16 = arg_292_1:FormatText(var_295_15.content)

				arg_292_1.text_.text = var_295_16

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_17 = 9
				local var_295_18 = utf8.len(var_295_16)
				local var_295_19 = var_295_17 <= 0 and var_295_13 or var_295_13 * (var_295_18 / var_295_17)

				if var_295_19 > 0 and var_295_13 < var_295_19 then
					arg_292_1.talkMaxDuration = var_295_19

					if var_295_19 + var_295_12 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_19 + var_295_12
					end
				end

				arg_292_1.text_.text = var_295_16
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081071", "story_v_out_324081.awb") ~= 0 then
					local var_295_20 = manager.audio:GetVoiceLength("story_v_out_324081", "324081071", "story_v_out_324081.awb") / 1000

					if var_295_20 + var_295_12 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_20 + var_295_12
					end

					if var_295_15.prefab_name ~= "" and arg_292_1.actors_[var_295_15.prefab_name] ~= nil then
						local var_295_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_15.prefab_name].transform, "story_v_out_324081", "324081071", "story_v_out_324081.awb")

						arg_292_1:RecordAudio("324081071", var_295_21)
						arg_292_1:RecordAudio("324081071", var_295_21)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_324081", "324081071", "story_v_out_324081.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_324081", "324081071", "story_v_out_324081.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_22 = math.max(var_295_13, arg_292_1.talkMaxDuration)

			if var_295_12 <= arg_292_1.time_ and arg_292_1.time_ < var_295_12 + var_295_22 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_12) / var_295_22

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_12 + var_295_22 and arg_292_1.time_ < var_295_12 + var_295_22 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play324081072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 324081072
		arg_296_1.duration_ = 9.6

		local var_296_0 = {
			zh = 9.566,
			ja = 9.6
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
				arg_296_0:Play324081073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["10171ui_story"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect10171ui_story == nil then
				arg_296_1.var_.characterEffect10171ui_story = var_299_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.characterEffect10171ui_story and not isNil(var_299_0) then
					arg_296_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.characterEffect10171ui_story then
				arg_296_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_299_4 = arg_296_1.actors_["1070ui_story"]
			local var_299_5 = 0

			if var_299_5 < arg_296_1.time_ and arg_296_1.time_ <= var_299_5 + arg_299_0 and not isNil(var_299_4) and arg_296_1.var_.characterEffect1070ui_story == nil then
				arg_296_1.var_.characterEffect1070ui_story = var_299_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_6 = 0.200000002980232

			if var_299_5 <= arg_296_1.time_ and arg_296_1.time_ < var_299_5 + var_299_6 and not isNil(var_299_4) then
				local var_299_7 = (arg_296_1.time_ - var_299_5) / var_299_6

				if arg_296_1.var_.characterEffect1070ui_story and not isNil(var_299_4) then
					local var_299_8 = Mathf.Lerp(0, 0.5, var_299_7)

					arg_296_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1070ui_story.fillRatio = var_299_8
				end
			end

			if arg_296_1.time_ >= var_299_5 + var_299_6 and arg_296_1.time_ < var_299_5 + var_299_6 + arg_299_0 and not isNil(var_299_4) and arg_296_1.var_.characterEffect1070ui_story then
				local var_299_9 = 0.5

				arg_296_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1070ui_story.fillRatio = var_299_9
			end

			local var_299_10 = 0
			local var_299_11 = 1.15

			if var_299_10 < arg_296_1.time_ and arg_296_1.time_ <= var_299_10 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_12 = arg_296_1:FormatText(StoryNameCfg[1451].name)

				arg_296_1.leftNameTxt_.text = var_299_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_13 = arg_296_1:GetWordFromCfg(324081072)
				local var_299_14 = arg_296_1:FormatText(var_299_13.content)

				arg_296_1.text_.text = var_299_14

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_15 = 46
				local var_299_16 = utf8.len(var_299_14)
				local var_299_17 = var_299_15 <= 0 and var_299_11 or var_299_11 * (var_299_16 / var_299_15)

				if var_299_17 > 0 and var_299_11 < var_299_17 then
					arg_296_1.talkMaxDuration = var_299_17

					if var_299_17 + var_299_10 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_17 + var_299_10
					end
				end

				arg_296_1.text_.text = var_299_14
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081072", "story_v_out_324081.awb") ~= 0 then
					local var_299_18 = manager.audio:GetVoiceLength("story_v_out_324081", "324081072", "story_v_out_324081.awb") / 1000

					if var_299_18 + var_299_10 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_18 + var_299_10
					end

					if var_299_13.prefab_name ~= "" and arg_296_1.actors_[var_299_13.prefab_name] ~= nil then
						local var_299_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_13.prefab_name].transform, "story_v_out_324081", "324081072", "story_v_out_324081.awb")

						arg_296_1:RecordAudio("324081072", var_299_19)
						arg_296_1:RecordAudio("324081072", var_299_19)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_324081", "324081072", "story_v_out_324081.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_324081", "324081072", "story_v_out_324081.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_20 = math.max(var_299_11, arg_296_1.talkMaxDuration)

			if var_299_10 <= arg_296_1.time_ and arg_296_1.time_ < var_299_10 + var_299_20 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_10) / var_299_20

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_10 + var_299_20 and arg_296_1.time_ < var_299_10 + var_299_20 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play324081073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 324081073
		arg_300_1.duration_ = 1.2

		local var_300_0 = {
			zh = 1.2,
			ja = 0.999999999999
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
				arg_300_0:Play324081074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10171ui_story"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect10171ui_story == nil then
				arg_300_1.var_.characterEffect10171ui_story = var_303_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.200000002980232

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.characterEffect10171ui_story and not isNil(var_303_0) then
					local var_303_4 = Mathf.Lerp(0, 0.5, var_303_3)

					arg_300_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_300_1.var_.characterEffect10171ui_story.fillRatio = var_303_4
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect10171ui_story then
				local var_303_5 = 0.5

				arg_300_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_300_1.var_.characterEffect10171ui_story.fillRatio = var_303_5
			end

			local var_303_6 = 0
			local var_303_7 = 0.075

			if var_303_6 < arg_300_1.time_ and arg_300_1.time_ <= var_303_6 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_8 = arg_300_1:FormatText(StoryNameCfg[1448].name)

				arg_300_1.leftNameTxt_.text = var_303_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_9 = arg_300_1:GetWordFromCfg(324081073)
				local var_303_10 = arg_300_1:FormatText(var_303_9.content)

				arg_300_1.text_.text = var_303_10

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_11 = 3
				local var_303_12 = utf8.len(var_303_10)
				local var_303_13 = var_303_11 <= 0 and var_303_7 or var_303_7 * (var_303_12 / var_303_11)

				if var_303_13 > 0 and var_303_7 < var_303_13 then
					arg_300_1.talkMaxDuration = var_303_13

					if var_303_13 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_13 + var_303_6
					end
				end

				arg_300_1.text_.text = var_303_10
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081073", "story_v_out_324081.awb") ~= 0 then
					local var_303_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081073", "story_v_out_324081.awb") / 1000

					if var_303_14 + var_303_6 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_14 + var_303_6
					end

					if var_303_9.prefab_name ~= "" and arg_300_1.actors_[var_303_9.prefab_name] ~= nil then
						local var_303_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_9.prefab_name].transform, "story_v_out_324081", "324081073", "story_v_out_324081.awb")

						arg_300_1:RecordAudio("324081073", var_303_15)
						arg_300_1:RecordAudio("324081073", var_303_15)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_324081", "324081073", "story_v_out_324081.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_324081", "324081073", "story_v_out_324081.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_16 = math.max(var_303_7, arg_300_1.talkMaxDuration)

			if var_303_6 <= arg_300_1.time_ and arg_300_1.time_ < var_303_6 + var_303_16 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_6) / var_303_16

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_6 + var_303_16 and arg_300_1.time_ < var_303_6 + var_303_16 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play324081074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 324081074
		arg_304_1.duration_ = 12.93

		local var_304_0 = {
			zh = 12.933,
			ja = 12.366
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
				arg_304_0:Play324081075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 1.2

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_2 = arg_304_1:FormatText(StoryNameCfg[1448].name)

				arg_304_1.leftNameTxt_.text = var_307_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_3 = arg_304_1:GetWordFromCfg(324081074)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 48
				local var_307_6 = utf8.len(var_307_4)
				local var_307_7 = var_307_5 <= 0 and var_307_1 or var_307_1 * (var_307_6 / var_307_5)

				if var_307_7 > 0 and var_307_1 < var_307_7 then
					arg_304_1.talkMaxDuration = var_307_7

					if var_307_7 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_7 + var_307_0
					end
				end

				arg_304_1.text_.text = var_307_4
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081074", "story_v_out_324081.awb") ~= 0 then
					local var_307_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081074", "story_v_out_324081.awb") / 1000

					if var_307_8 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_8 + var_307_0
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_out_324081", "324081074", "story_v_out_324081.awb")

						arg_304_1:RecordAudio("324081074", var_307_9)
						arg_304_1:RecordAudio("324081074", var_307_9)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_324081", "324081074", "story_v_out_324081.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_324081", "324081074", "story_v_out_324081.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_10 = math.max(var_307_1, arg_304_1.talkMaxDuration)

			if var_307_0 <= arg_304_1.time_ and arg_304_1.time_ < var_307_0 + var_307_10 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_0) / var_307_10

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_0 + var_307_10 and arg_304_1.time_ < var_307_0 + var_307_10 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play324081075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 324081075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play324081076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["1070ui_story"].transform
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.var_.moveOldPos1070ui_story = var_311_0.localPosition
			end

			local var_311_2 = 0.001

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2
				local var_311_4 = Vector3.New(0, 100, 0)

				var_311_0.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1070ui_story, var_311_4, var_311_3)

				local var_311_5 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_5.x, var_311_5.y, var_311_5.z)

				local var_311_6 = var_311_0.localEulerAngles

				var_311_6.z = 0
				var_311_6.x = 0
				var_311_0.localEulerAngles = var_311_6
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 then
				var_311_0.localPosition = Vector3.New(0, 100, 0)

				local var_311_7 = manager.ui.mainCamera.transform.position - var_311_0.position

				var_311_0.forward = Vector3.New(var_311_7.x, var_311_7.y, var_311_7.z)

				local var_311_8 = var_311_0.localEulerAngles

				var_311_8.z = 0
				var_311_8.x = 0
				var_311_0.localEulerAngles = var_311_8
			end

			local var_311_9 = arg_308_1.actors_["10171ui_story"].transform
			local var_311_10 = 0

			if var_311_10 < arg_308_1.time_ and arg_308_1.time_ <= var_311_10 + arg_311_0 then
				arg_308_1.var_.moveOldPos10171ui_story = var_311_9.localPosition

				local var_311_11 = GameObjectTools.GetOrAddComponent(var_311_9.gameObject, typeof(DynamicBoneHelper))

				if var_311_11 then
					var_311_11:EnableDynamicBone(false)
				end
			end

			local var_311_12 = 0.001

			if var_311_10 <= arg_308_1.time_ and arg_308_1.time_ < var_311_10 + var_311_12 then
				local var_311_13 = (arg_308_1.time_ - var_311_10) / var_311_12
				local var_311_14 = Vector3.New(0, 100, 0)

				var_311_9.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10171ui_story, var_311_14, var_311_13)

				local var_311_15 = manager.ui.mainCamera.transform.position - var_311_9.position

				var_311_9.forward = Vector3.New(var_311_15.x, var_311_15.y, var_311_15.z)

				local var_311_16 = var_311_9.localEulerAngles

				var_311_16.z = 0
				var_311_16.x = 0
				var_311_9.localEulerAngles = var_311_16
			end

			if arg_308_1.time_ >= var_311_10 + var_311_12 and arg_308_1.time_ < var_311_10 + var_311_12 + arg_311_0 then
				var_311_9.localPosition = Vector3.New(0, 100, 0)

				local var_311_17 = manager.ui.mainCamera.transform.position - var_311_9.position

				var_311_9.forward = Vector3.New(var_311_17.x, var_311_17.y, var_311_17.z)

				local var_311_18 = var_311_9.localEulerAngles

				var_311_18.z = 0
				var_311_18.x = 0
				var_311_9.localEulerAngles = var_311_18

				local var_311_19 = GameObjectTools.GetOrAddComponent(var_311_9.gameObject, typeof(DynamicBoneHelper))

				if var_311_19 then
					var_311_19:EnableDynamicBone(true)
				end
			end

			local var_311_20 = 1.5
			local var_311_21 = 1

			if var_311_20 < arg_308_1.time_ and arg_308_1.time_ <= var_311_20 + arg_311_0 then
				local var_311_22 = "play"
				local var_311_23 = "effect"

				arg_308_1:AudioAction(var_311_22, var_311_23, "se_story_side_1034", "se_story_side_1034_car_door", "")
			end

			local var_311_24 = 0
			local var_311_25 = 1.625

			if var_311_24 < arg_308_1.time_ and arg_308_1.time_ <= var_311_24 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_26 = arg_308_1:GetWordFromCfg(324081075)
				local var_311_27 = arg_308_1:FormatText(var_311_26.content)

				arg_308_1.text_.text = var_311_27

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_28 = 65
				local var_311_29 = utf8.len(var_311_27)
				local var_311_30 = var_311_28 <= 0 and var_311_25 or var_311_25 * (var_311_29 / var_311_28)

				if var_311_30 > 0 and var_311_25 < var_311_30 then
					arg_308_1.talkMaxDuration = var_311_30

					if var_311_30 + var_311_24 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_30 + var_311_24
					end
				end

				arg_308_1.text_.text = var_311_27
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_31 = math.max(var_311_25, arg_308_1.talkMaxDuration)

			if var_311_24 <= arg_308_1.time_ and arg_308_1.time_ < var_311_24 + var_311_31 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_24) / var_311_31

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_24 + var_311_31 and arg_308_1.time_ < var_311_24 + var_311_31 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play324081076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 324081076
		arg_312_1.duration_ = 4.33

		local var_312_0 = {
			zh = 4.333,
			ja = 2.766
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
				arg_312_0:Play324081077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["10171ui_story"].transform
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 then
				arg_312_1.var_.moveOldPos10171ui_story = var_315_0.localPosition

				local var_315_2 = GameObjectTools.GetOrAddComponent(var_315_0.gameObject, typeof(DynamicBoneHelper))

				if var_315_2 then
					var_315_2:EnableDynamicBone(false)
				end
			end

			local var_315_3 = 0.001

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_3 then
				local var_315_4 = (arg_312_1.time_ - var_315_1) / var_315_3
				local var_315_5 = Vector3.New(0, -0.95, -6.05)

				var_315_0.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10171ui_story, var_315_5, var_315_4)

				local var_315_6 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_6.x, var_315_6.y, var_315_6.z)

				local var_315_7 = var_315_0.localEulerAngles

				var_315_7.z = 0
				var_315_7.x = 0
				var_315_0.localEulerAngles = var_315_7
			end

			if arg_312_1.time_ >= var_315_1 + var_315_3 and arg_312_1.time_ < var_315_1 + var_315_3 + arg_315_0 then
				var_315_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_315_8 = manager.ui.mainCamera.transform.position - var_315_0.position

				var_315_0.forward = Vector3.New(var_315_8.x, var_315_8.y, var_315_8.z)

				local var_315_9 = var_315_0.localEulerAngles

				var_315_9.z = 0
				var_315_9.x = 0
				var_315_0.localEulerAngles = var_315_9

				local var_315_10 = GameObjectTools.GetOrAddComponent(var_315_0.gameObject, typeof(DynamicBoneHelper))

				if var_315_10 then
					var_315_10:EnableDynamicBone(true)
				end
			end

			local var_315_11 = arg_312_1.actors_["10171ui_story"]
			local var_315_12 = 0

			if var_315_12 < arg_312_1.time_ and arg_312_1.time_ <= var_315_12 + arg_315_0 and not isNil(var_315_11) and arg_312_1.var_.characterEffect10171ui_story == nil then
				arg_312_1.var_.characterEffect10171ui_story = var_315_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_13 = 0.200000002980232

			if var_315_12 <= arg_312_1.time_ and arg_312_1.time_ < var_315_12 + var_315_13 and not isNil(var_315_11) then
				local var_315_14 = (arg_312_1.time_ - var_315_12) / var_315_13

				if arg_312_1.var_.characterEffect10171ui_story and not isNil(var_315_11) then
					arg_312_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= var_315_12 + var_315_13 and arg_312_1.time_ < var_315_12 + var_315_13 + arg_315_0 and not isNil(var_315_11) and arg_312_1.var_.characterEffect10171ui_story then
				arg_312_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_315_15 = 0

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				arg_312_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			local var_315_16 = 0

			if var_315_16 < arg_312_1.time_ and arg_312_1.time_ <= var_315_16 + arg_315_0 then
				arg_312_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_315_17 = 0
			local var_315_18 = 0.3

			if var_315_17 < arg_312_1.time_ and arg_312_1.time_ <= var_315_17 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_19 = arg_312_1:FormatText(StoryNameCfg[1451].name)

				arg_312_1.leftNameTxt_.text = var_315_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_20 = arg_312_1:GetWordFromCfg(324081076)
				local var_315_21 = arg_312_1:FormatText(var_315_20.content)

				arg_312_1.text_.text = var_315_21

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_22 = 12
				local var_315_23 = utf8.len(var_315_21)
				local var_315_24 = var_315_22 <= 0 and var_315_18 or var_315_18 * (var_315_23 / var_315_22)

				if var_315_24 > 0 and var_315_18 < var_315_24 then
					arg_312_1.talkMaxDuration = var_315_24

					if var_315_24 + var_315_17 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_24 + var_315_17
					end
				end

				arg_312_1.text_.text = var_315_21
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081076", "story_v_out_324081.awb") ~= 0 then
					local var_315_25 = manager.audio:GetVoiceLength("story_v_out_324081", "324081076", "story_v_out_324081.awb") / 1000

					if var_315_25 + var_315_17 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_25 + var_315_17
					end

					if var_315_20.prefab_name ~= "" and arg_312_1.actors_[var_315_20.prefab_name] ~= nil then
						local var_315_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_20.prefab_name].transform, "story_v_out_324081", "324081076", "story_v_out_324081.awb")

						arg_312_1:RecordAudio("324081076", var_315_26)
						arg_312_1:RecordAudio("324081076", var_315_26)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_324081", "324081076", "story_v_out_324081.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_324081", "324081076", "story_v_out_324081.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_27 = math.max(var_315_18, arg_312_1.talkMaxDuration)

			if var_315_17 <= arg_312_1.time_ and arg_312_1.time_ < var_315_17 + var_315_27 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_17) / var_315_27

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_17 + var_315_27 and arg_312_1.time_ < var_315_17 + var_315_27 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play324081077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 324081077
		arg_316_1.duration_ = 7.27

		local var_316_0 = {
			zh = 5.366,
			ja = 7.266
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
				arg_316_0:Play324081078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["10171ui_story"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect10171ui_story == nil then
				arg_316_1.var_.characterEffect10171ui_story = var_319_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.characterEffect10171ui_story and not isNil(var_319_0) then
					local var_319_4 = Mathf.Lerp(0, 0.5, var_319_3)

					arg_316_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_316_1.var_.characterEffect10171ui_story.fillRatio = var_319_4
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect10171ui_story then
				local var_319_5 = 0.5

				arg_316_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_316_1.var_.characterEffect10171ui_story.fillRatio = var_319_5
			end

			local var_319_6 = 0
			local var_319_7 = 0.525

			if var_319_6 < arg_316_1.time_ and arg_316_1.time_ <= var_319_6 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_8 = arg_316_1:FormatText(StoryNameCfg[1448].name)

				arg_316_1.leftNameTxt_.text = var_319_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_9 = arg_316_1:GetWordFromCfg(324081077)
				local var_319_10 = arg_316_1:FormatText(var_319_9.content)

				arg_316_1.text_.text = var_319_10

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_11 = 21
				local var_319_12 = utf8.len(var_319_10)
				local var_319_13 = var_319_11 <= 0 and var_319_7 or var_319_7 * (var_319_12 / var_319_11)

				if var_319_13 > 0 and var_319_7 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_6
					end
				end

				arg_316_1.text_.text = var_319_10
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081077", "story_v_out_324081.awb") ~= 0 then
					local var_319_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081077", "story_v_out_324081.awb") / 1000

					if var_319_14 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_14 + var_319_6
					end

					if var_319_9.prefab_name ~= "" and arg_316_1.actors_[var_319_9.prefab_name] ~= nil then
						local var_319_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_9.prefab_name].transform, "story_v_out_324081", "324081077", "story_v_out_324081.awb")

						arg_316_1:RecordAudio("324081077", var_319_15)
						arg_316_1:RecordAudio("324081077", var_319_15)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_324081", "324081077", "story_v_out_324081.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_324081", "324081077", "story_v_out_324081.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_16 = math.max(var_319_7, arg_316_1.talkMaxDuration)

			if var_319_6 <= arg_316_1.time_ and arg_316_1.time_ < var_319_6 + var_319_16 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_6) / var_319_16

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_6 + var_319_16 and arg_316_1.time_ < var_319_6 + var_319_16 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play324081078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 324081078
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play324081079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["10171ui_story"].transform
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.var_.moveOldPos10171ui_story = var_323_0.localPosition

				local var_323_2 = GameObjectTools.GetOrAddComponent(var_323_0.gameObject, typeof(DynamicBoneHelper))

				if var_323_2 then
					var_323_2:EnableDynamicBone(false)
				end
			end

			local var_323_3 = 0.001

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_3 then
				local var_323_4 = (arg_320_1.time_ - var_323_1) / var_323_3
				local var_323_5 = Vector3.New(0, 100, 0)

				var_323_0.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10171ui_story, var_323_5, var_323_4)

				local var_323_6 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_6.x, var_323_6.y, var_323_6.z)

				local var_323_7 = var_323_0.localEulerAngles

				var_323_7.z = 0
				var_323_7.x = 0
				var_323_0.localEulerAngles = var_323_7
			end

			if arg_320_1.time_ >= var_323_1 + var_323_3 and arg_320_1.time_ < var_323_1 + var_323_3 + arg_323_0 then
				var_323_0.localPosition = Vector3.New(0, 100, 0)

				local var_323_8 = manager.ui.mainCamera.transform.position - var_323_0.position

				var_323_0.forward = Vector3.New(var_323_8.x, var_323_8.y, var_323_8.z)

				local var_323_9 = var_323_0.localEulerAngles

				var_323_9.z = 0
				var_323_9.x = 0
				var_323_0.localEulerAngles = var_323_9

				local var_323_10 = GameObjectTools.GetOrAddComponent(var_323_0.gameObject, typeof(DynamicBoneHelper))

				if var_323_10 then
					var_323_10:EnableDynamicBone(true)
				end
			end

			local var_323_11 = 0
			local var_323_12 = 0.85

			if var_323_11 < arg_320_1.time_ and arg_320_1.time_ <= var_323_11 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_13 = arg_320_1:GetWordFromCfg(324081078)
				local var_323_14 = arg_320_1:FormatText(var_323_13.content)

				arg_320_1.text_.text = var_323_14

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_15 = 34
				local var_323_16 = utf8.len(var_323_14)
				local var_323_17 = var_323_15 <= 0 and var_323_12 or var_323_12 * (var_323_16 / var_323_15)

				if var_323_17 > 0 and var_323_12 < var_323_17 then
					arg_320_1.talkMaxDuration = var_323_17

					if var_323_17 + var_323_11 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_17 + var_323_11
					end
				end

				arg_320_1.text_.text = var_323_14
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_18 = math.max(var_323_12, arg_320_1.talkMaxDuration)

			if var_323_11 <= arg_320_1.time_ and arg_320_1.time_ < var_323_11 + var_323_18 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_11) / var_323_18

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_11 + var_323_18 and arg_320_1.time_ < var_323_11 + var_323_18 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play324081079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 324081079
		arg_324_1.duration_ = 2

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play324081080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["10171ui_story"]
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect10171ui_story == nil then
				arg_324_1.var_.characterEffect10171ui_story = var_327_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 and not isNil(var_327_0) then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2

				if arg_324_1.var_.characterEffect10171ui_story and not isNil(var_327_0) then
					arg_324_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 and not isNil(var_327_0) and arg_324_1.var_.characterEffect10171ui_story then
				arg_324_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_327_4 = arg_324_1.actors_["10171ui_story"].transform
			local var_327_5 = 0

			if var_327_5 < arg_324_1.time_ and arg_324_1.time_ <= var_327_5 + arg_327_0 then
				arg_324_1.var_.moveOldPos10171ui_story = var_327_4.localPosition

				local var_327_6 = GameObjectTools.GetOrAddComponent(var_327_4.gameObject, typeof(DynamicBoneHelper))

				if var_327_6 then
					var_327_6:EnableDynamicBone(false)
				end
			end

			local var_327_7 = 0.001

			if var_327_5 <= arg_324_1.time_ and arg_324_1.time_ < var_327_5 + var_327_7 then
				local var_327_8 = (arg_324_1.time_ - var_327_5) / var_327_7
				local var_327_9 = Vector3.New(0, -0.95, -6.05)

				var_327_4.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos10171ui_story, var_327_9, var_327_8)

				local var_327_10 = manager.ui.mainCamera.transform.position - var_327_4.position

				var_327_4.forward = Vector3.New(var_327_10.x, var_327_10.y, var_327_10.z)

				local var_327_11 = var_327_4.localEulerAngles

				var_327_11.z = 0
				var_327_11.x = 0
				var_327_4.localEulerAngles = var_327_11
			end

			if arg_324_1.time_ >= var_327_5 + var_327_7 and arg_324_1.time_ < var_327_5 + var_327_7 + arg_327_0 then
				var_327_4.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_327_12 = manager.ui.mainCamera.transform.position - var_327_4.position

				var_327_4.forward = Vector3.New(var_327_12.x, var_327_12.y, var_327_12.z)

				local var_327_13 = var_327_4.localEulerAngles

				var_327_13.z = 0
				var_327_13.x = 0
				var_327_4.localEulerAngles = var_327_13

				local var_327_14 = GameObjectTools.GetOrAddComponent(var_327_4.gameObject, typeof(DynamicBoneHelper))

				if var_327_14 then
					var_327_14:EnableDynamicBone(true)
				end
			end

			local var_327_15 = 0

			if var_327_15 < arg_324_1.time_ and arg_324_1.time_ <= var_327_15 + arg_327_0 then
				arg_324_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			local var_327_16 = 0

			if var_327_16 < arg_324_1.time_ and arg_324_1.time_ <= var_327_16 + arg_327_0 then
				arg_324_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_327_17 = 0
			local var_327_18 = 0.25

			if var_327_17 < arg_324_1.time_ and arg_324_1.time_ <= var_327_17 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_19 = arg_324_1:FormatText(StoryNameCfg[1451].name)

				arg_324_1.leftNameTxt_.text = var_327_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_20 = arg_324_1:GetWordFromCfg(324081079)
				local var_327_21 = arg_324_1:FormatText(var_327_20.content)

				arg_324_1.text_.text = var_327_21

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_22 = 10
				local var_327_23 = utf8.len(var_327_21)
				local var_327_24 = var_327_22 <= 0 and var_327_18 or var_327_18 * (var_327_23 / var_327_22)

				if var_327_24 > 0 and var_327_18 < var_327_24 then
					arg_324_1.talkMaxDuration = var_327_24

					if var_327_24 + var_327_17 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_24 + var_327_17
					end
				end

				arg_324_1.text_.text = var_327_21
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081079", "story_v_out_324081.awb") ~= 0 then
					local var_327_25 = manager.audio:GetVoiceLength("story_v_out_324081", "324081079", "story_v_out_324081.awb") / 1000

					if var_327_25 + var_327_17 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_25 + var_327_17
					end

					if var_327_20.prefab_name ~= "" and arg_324_1.actors_[var_327_20.prefab_name] ~= nil then
						local var_327_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_20.prefab_name].transform, "story_v_out_324081", "324081079", "story_v_out_324081.awb")

						arg_324_1:RecordAudio("324081079", var_327_26)
						arg_324_1:RecordAudio("324081079", var_327_26)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_324081", "324081079", "story_v_out_324081.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_324081", "324081079", "story_v_out_324081.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_27 = math.max(var_327_18, arg_324_1.talkMaxDuration)

			if var_327_17 <= arg_324_1.time_ and arg_324_1.time_ < var_327_17 + var_327_27 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_17) / var_327_27

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_17 + var_327_27 and arg_324_1.time_ < var_327_17 + var_327_27 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play324081080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 324081080
		arg_328_1.duration_ = 5.58

		local var_328_0 = {
			zh = 5.37859469829127,
			ja = 5.57859469829127
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
				arg_328_0:Play324081081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 1.8

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				local var_331_1 = manager.ui.mainCamera.transform.localPosition
				local var_331_2 = Vector3.New(0, 0, 10) + Vector3.New(var_331_1.x, var_331_1.y, 0)
				local var_331_3 = arg_328_1.bgs_.J22f

				var_331_3.transform.localPosition = var_331_2
				var_331_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_331_4 = var_331_3:GetComponent("SpriteRenderer")

				if var_331_4 and var_331_4.sprite then
					local var_331_5 = (var_331_3.transform.localPosition - var_331_1).z
					local var_331_6 = manager.ui.mainCameraCom_
					local var_331_7 = 2 * var_331_5 * Mathf.Tan(var_331_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_331_8 = var_331_7 * var_331_6.aspect
					local var_331_9 = var_331_4.sprite.bounds.size.x
					local var_331_10 = var_331_4.sprite.bounds.size.y
					local var_331_11 = var_331_8 / var_331_9
					local var_331_12 = var_331_7 / var_331_10
					local var_331_13 = var_331_12 < var_331_11 and var_331_11 or var_331_12

					var_331_3.transform.localScale = Vector3.New(var_331_13, var_331_13, 0)
				end

				for iter_331_0, iter_331_1 in pairs(arg_328_1.bgs_) do
					if iter_331_0 ~= "J22f" then
						iter_331_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_331_14 = 1.8

			if var_331_14 < arg_328_1.time_ and arg_328_1.time_ <= var_331_14 + arg_331_0 then
				arg_328_1.allBtn_.enabled = false
			end

			local var_331_15 = 0.3

			if arg_328_1.time_ >= var_331_14 + var_331_15 and arg_328_1.time_ < var_331_14 + var_331_15 + arg_331_0 then
				arg_328_1.allBtn_.enabled = true
			end

			local var_331_16 = 0

			if var_331_16 < arg_328_1.time_ and arg_328_1.time_ <= var_331_16 + arg_331_0 then
				arg_328_1.mask_.enabled = true
				arg_328_1.mask_.raycastTarget = true

				arg_328_1:SetGaussion(false)
			end

			local var_331_17 = 1.8

			if var_331_16 <= arg_328_1.time_ and arg_328_1.time_ < var_331_16 + var_331_17 then
				local var_331_18 = (arg_328_1.time_ - var_331_16) / var_331_17
				local var_331_19 = Color.New(0, 0, 0)

				var_331_19.a = Mathf.Lerp(0, 1, var_331_18)
				arg_328_1.mask_.color = var_331_19
			end

			if arg_328_1.time_ >= var_331_16 + var_331_17 and arg_328_1.time_ < var_331_16 + var_331_17 + arg_331_0 then
				local var_331_20 = Color.New(0, 0, 0)

				var_331_20.a = 1
				arg_328_1.mask_.color = var_331_20
			end

			local var_331_21 = 1.8

			if var_331_21 < arg_328_1.time_ and arg_328_1.time_ <= var_331_21 + arg_331_0 then
				arg_328_1.mask_.enabled = true
				arg_328_1.mask_.raycastTarget = true

				arg_328_1:SetGaussion(false)
			end

			local var_331_22 = 2

			if var_331_21 <= arg_328_1.time_ and arg_328_1.time_ < var_331_21 + var_331_22 then
				local var_331_23 = (arg_328_1.time_ - var_331_21) / var_331_22
				local var_331_24 = Color.New(0, 0, 0)

				var_331_24.a = Mathf.Lerp(1, 0, var_331_23)
				arg_328_1.mask_.color = var_331_24
			end

			if arg_328_1.time_ >= var_331_21 + var_331_22 and arg_328_1.time_ < var_331_21 + var_331_22 + arg_331_0 then
				local var_331_25 = Color.New(0, 0, 0)
				local var_331_26 = 0

				arg_328_1.mask_.enabled = false
				var_331_25.a = var_331_26
				arg_328_1.mask_.color = var_331_25
			end

			local var_331_27 = arg_328_1.actors_["1070ui_story"]
			local var_331_28 = 1.8

			if var_331_28 < arg_328_1.time_ and arg_328_1.time_ <= var_331_28 + arg_331_0 and not isNil(var_331_27) and arg_328_1.var_.characterEffect1070ui_story == nil then
				arg_328_1.var_.characterEffect1070ui_story = var_331_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_29 = 0.200000002980232

			if var_331_28 <= arg_328_1.time_ and arg_328_1.time_ < var_331_28 + var_331_29 and not isNil(var_331_27) then
				local var_331_30 = (arg_328_1.time_ - var_331_28) / var_331_29

				if arg_328_1.var_.characterEffect1070ui_story and not isNil(var_331_27) then
					arg_328_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_28 + var_331_29 and arg_328_1.time_ < var_331_28 + var_331_29 + arg_331_0 and not isNil(var_331_27) and arg_328_1.var_.characterEffect1070ui_story then
				arg_328_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_331_31 = arg_328_1.actors_["10171ui_story"]
			local var_331_32 = 1.8

			if var_331_32 < arg_328_1.time_ and arg_328_1.time_ <= var_331_32 + arg_331_0 and not isNil(var_331_31) and arg_328_1.var_.characterEffect10171ui_story == nil then
				arg_328_1.var_.characterEffect10171ui_story = var_331_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_33 = 0.200000002980232

			if var_331_32 <= arg_328_1.time_ and arg_328_1.time_ < var_331_32 + var_331_33 and not isNil(var_331_31) then
				local var_331_34 = (arg_328_1.time_ - var_331_32) / var_331_33

				if arg_328_1.var_.characterEffect10171ui_story and not isNil(var_331_31) then
					local var_331_35 = Mathf.Lerp(0, 0.5, var_331_34)

					arg_328_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_328_1.var_.characterEffect10171ui_story.fillRatio = var_331_35
				end
			end

			if arg_328_1.time_ >= var_331_32 + var_331_33 and arg_328_1.time_ < var_331_32 + var_331_33 + arg_331_0 and not isNil(var_331_31) and arg_328_1.var_.characterEffect10171ui_story then
				local var_331_36 = 0.5

				arg_328_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_328_1.var_.characterEffect10171ui_story.fillRatio = var_331_36
			end

			local var_331_37 = arg_328_1.actors_["10171ui_story"].transform
			local var_331_38 = 1.8

			if var_331_38 < arg_328_1.time_ and arg_328_1.time_ <= var_331_38 + arg_331_0 then
				arg_328_1.var_.moveOldPos10171ui_story = var_331_37.localPosition

				local var_331_39 = GameObjectTools.GetOrAddComponent(var_331_37.gameObject, typeof(DynamicBoneHelper))

				if var_331_39 then
					var_331_39:EnableDynamicBone(false)
				end
			end

			local var_331_40 = 0.001

			if var_331_38 <= arg_328_1.time_ and arg_328_1.time_ < var_331_38 + var_331_40 then
				local var_331_41 = (arg_328_1.time_ - var_331_38) / var_331_40
				local var_331_42 = Vector3.New(0, 100, 0)

				var_331_37.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos10171ui_story, var_331_42, var_331_41)

				local var_331_43 = manager.ui.mainCamera.transform.position - var_331_37.position

				var_331_37.forward = Vector3.New(var_331_43.x, var_331_43.y, var_331_43.z)

				local var_331_44 = var_331_37.localEulerAngles

				var_331_44.z = 0
				var_331_44.x = 0
				var_331_37.localEulerAngles = var_331_44
			end

			if arg_328_1.time_ >= var_331_38 + var_331_40 and arg_328_1.time_ < var_331_38 + var_331_40 + arg_331_0 then
				var_331_37.localPosition = Vector3.New(0, 100, 0)

				local var_331_45 = manager.ui.mainCamera.transform.position - var_331_37.position

				var_331_37.forward = Vector3.New(var_331_45.x, var_331_45.y, var_331_45.z)

				local var_331_46 = var_331_37.localEulerAngles

				var_331_46.z = 0
				var_331_46.x = 0
				var_331_37.localEulerAngles = var_331_46

				local var_331_47 = GameObjectTools.GetOrAddComponent(var_331_37.gameObject, typeof(DynamicBoneHelper))

				if var_331_47 then
					var_331_47:EnableDynamicBone(true)
				end
			end

			local var_331_48 = 1.2
			local var_331_49 = 1

			if var_331_48 < arg_328_1.time_ and arg_328_1.time_ <= var_331_48 + arg_331_0 then
				local var_331_50 = "play"
				local var_331_51 = "effect"

				arg_328_1:AudioAction(var_331_50, var_331_51, "se_story_148", "se_story_148_amb_lost_city", "")
			end

			local var_331_52 = 0.1
			local var_331_53 = 1

			if var_331_52 < arg_328_1.time_ and arg_328_1.time_ <= var_331_52 + arg_331_0 then
				local var_331_54 = "stop"
				local var_331_55 = "effect"

				arg_328_1:AudioAction(var_331_54, var_331_55, "se_story_145", "se_story_145_amb_construction", "")
			end

			if arg_328_1.frameCnt_ <= 1 then
				arg_328_1.dialog_:SetActive(false)
			end

			local var_331_56 = 3.57859469829127
			local var_331_57 = 0.2

			if var_331_56 < arg_328_1.time_ and arg_328_1.time_ <= var_331_56 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0

				arg_328_1.dialog_:SetActive(true)

				arg_328_1.dialogCg_.alpha = 0

				local var_331_58 = LeanTween.value(arg_328_1.dialog_, 0, 1, 0.3)

				var_331_58:setOnUpdate(LuaHelper.FloatAction(function(arg_332_0)
					arg_328_1.dialogCg_.alpha = arg_332_0
				end))
				var_331_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_328_1.dialog_)
					var_331_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_328_1.duration_ = arg_328_1.duration_ + 0.3

				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_59 = arg_328_1:FormatText(StoryNameCfg[318].name)

				arg_328_1.leftNameTxt_.text = var_331_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_60 = arg_328_1:GetWordFromCfg(324081080)
				local var_331_61 = arg_328_1:FormatText(var_331_60.content)

				arg_328_1.text_.text = var_331_61

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_62 = 8
				local var_331_63 = utf8.len(var_331_61)
				local var_331_64 = var_331_62 <= 0 and var_331_57 or var_331_57 * (var_331_63 / var_331_62)

				if var_331_64 > 0 and var_331_57 < var_331_64 then
					arg_328_1.talkMaxDuration = var_331_64
					var_331_56 = var_331_56 + 0.3

					if var_331_64 + var_331_56 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_64 + var_331_56
					end
				end

				arg_328_1.text_.text = var_331_61
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081080", "story_v_out_324081.awb") ~= 0 then
					local var_331_65 = manager.audio:GetVoiceLength("story_v_out_324081", "324081080", "story_v_out_324081.awb") / 1000

					if var_331_65 + var_331_56 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_65 + var_331_56
					end

					if var_331_60.prefab_name ~= "" and arg_328_1.actors_[var_331_60.prefab_name] ~= nil then
						local var_331_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_60.prefab_name].transform, "story_v_out_324081", "324081080", "story_v_out_324081.awb")

						arg_328_1:RecordAudio("324081080", var_331_66)
						arg_328_1:RecordAudio("324081080", var_331_66)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_324081", "324081080", "story_v_out_324081.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_324081", "324081080", "story_v_out_324081.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_67 = var_331_56 + 0.3
			local var_331_68 = math.max(var_331_57, arg_328_1.talkMaxDuration)

			if var_331_67 <= arg_328_1.time_ and arg_328_1.time_ < var_331_67 + var_331_68 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_67) / var_331_68

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_67 + var_331_68 and arg_328_1.time_ < var_331_67 + var_331_68 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play324081081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 324081081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play324081082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["10171ui_story"].transform
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.var_.moveOldPos10171ui_story = var_337_0.localPosition

				local var_337_2 = GameObjectTools.GetOrAddComponent(var_337_0.gameObject, typeof(DynamicBoneHelper))

				if var_337_2 then
					var_337_2:EnableDynamicBone(false)
				end
			end

			local var_337_3 = 0.001

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_3 then
				local var_337_4 = (arg_334_1.time_ - var_337_1) / var_337_3
				local var_337_5 = Vector3.New(0, 100, 0)

				var_337_0.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10171ui_story, var_337_5, var_337_4)

				local var_337_6 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_6.x, var_337_6.y, var_337_6.z)

				local var_337_7 = var_337_0.localEulerAngles

				var_337_7.z = 0
				var_337_7.x = 0
				var_337_0.localEulerAngles = var_337_7
			end

			if arg_334_1.time_ >= var_337_1 + var_337_3 and arg_334_1.time_ < var_337_1 + var_337_3 + arg_337_0 then
				var_337_0.localPosition = Vector3.New(0, 100, 0)

				local var_337_8 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_8.x, var_337_8.y, var_337_8.z)

				local var_337_9 = var_337_0.localEulerAngles

				var_337_9.z = 0
				var_337_9.x = 0
				var_337_0.localEulerAngles = var_337_9

				local var_337_10 = GameObjectTools.GetOrAddComponent(var_337_0.gameObject, typeof(DynamicBoneHelper))

				if var_337_10 then
					var_337_10:EnableDynamicBone(true)
				end
			end

			local var_337_11 = arg_334_1.actors_["1070ui_story"]
			local var_337_12 = 0

			if var_337_12 < arg_334_1.time_ and arg_334_1.time_ <= var_337_12 + arg_337_0 and not isNil(var_337_11) and arg_334_1.var_.characterEffect1070ui_story == nil then
				arg_334_1.var_.characterEffect1070ui_story = var_337_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_13 = 0.200000002980232

			if var_337_12 <= arg_334_1.time_ and arg_334_1.time_ < var_337_12 + var_337_13 and not isNil(var_337_11) then
				local var_337_14 = (arg_334_1.time_ - var_337_12) / var_337_13

				if arg_334_1.var_.characterEffect1070ui_story and not isNil(var_337_11) then
					local var_337_15 = Mathf.Lerp(0, 0.5, var_337_14)

					arg_334_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1070ui_story.fillRatio = var_337_15
				end
			end

			if arg_334_1.time_ >= var_337_12 + var_337_13 and arg_334_1.time_ < var_337_12 + var_337_13 + arg_337_0 and not isNil(var_337_11) and arg_334_1.var_.characterEffect1070ui_story then
				local var_337_16 = 0.5

				arg_334_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1070ui_story.fillRatio = var_337_16
			end

			local var_337_17 = 0
			local var_337_18 = 1.025

			if var_337_17 < arg_334_1.time_ and arg_334_1.time_ <= var_337_17 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_19 = arg_334_1:GetWordFromCfg(324081081)
				local var_337_20 = arg_334_1:FormatText(var_337_19.content)

				arg_334_1.text_.text = var_337_20

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_21 = 41
				local var_337_22 = utf8.len(var_337_20)
				local var_337_23 = var_337_21 <= 0 and var_337_18 or var_337_18 * (var_337_22 / var_337_21)

				if var_337_23 > 0 and var_337_18 < var_337_23 then
					arg_334_1.talkMaxDuration = var_337_23

					if var_337_23 + var_337_17 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_23 + var_337_17
					end
				end

				arg_334_1.text_.text = var_337_20
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_24 = math.max(var_337_18, arg_334_1.talkMaxDuration)

			if var_337_17 <= arg_334_1.time_ and arg_334_1.time_ < var_337_17 + var_337_24 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_17) / var_337_24

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_17 + var_337_24 and arg_334_1.time_ < var_337_17 + var_337_24 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play324081082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 324081082
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play324081083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = 0.6
			local var_341_1 = 1

			if var_341_0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_0 + arg_341_0 then
				local var_341_2 = "play"
				local var_341_3 = "effect"

				arg_338_1:AudioAction(var_341_2, var_341_3, "se_story_150", "se_story_150_branch", "")
			end

			local var_341_4 = 0
			local var_341_5 = 1

			if var_341_4 < arg_338_1.time_ and arg_338_1.time_ <= var_341_4 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_6 = arg_338_1:GetWordFromCfg(324081082)
				local var_341_7 = arg_338_1:FormatText(var_341_6.content)

				arg_338_1.text_.text = var_341_7

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_8 = 40
				local var_341_9 = utf8.len(var_341_7)
				local var_341_10 = var_341_8 <= 0 and var_341_5 or var_341_5 * (var_341_9 / var_341_8)

				if var_341_10 > 0 and var_341_5 < var_341_10 then
					arg_338_1.talkMaxDuration = var_341_10

					if var_341_10 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_10 + var_341_4
					end
				end

				arg_338_1.text_.text = var_341_7
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_11 = math.max(var_341_5, arg_338_1.talkMaxDuration)

			if var_341_4 <= arg_338_1.time_ and arg_338_1.time_ < var_341_4 + var_341_11 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_4) / var_341_11

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_4 + var_341_11 and arg_338_1.time_ < var_341_4 + var_341_11 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play324081083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 324081083
		arg_342_1.duration_ = 3.9

		local var_342_0 = {
			zh = 3.9,
			ja = 2.1
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play324081084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["10171ui_story"].transform
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.var_.moveOldPos10171ui_story = var_345_0.localPosition

				local var_345_2 = GameObjectTools.GetOrAddComponent(var_345_0.gameObject, typeof(DynamicBoneHelper))

				if var_345_2 then
					var_345_2:EnableDynamicBone(false)
				end
			end

			local var_345_3 = 0.001

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_3 then
				local var_345_4 = (arg_342_1.time_ - var_345_1) / var_345_3
				local var_345_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_345_0.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos10171ui_story, var_345_5, var_345_4)

				local var_345_6 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_6.x, var_345_6.y, var_345_6.z)

				local var_345_7 = var_345_0.localEulerAngles

				var_345_7.z = 0
				var_345_7.x = 0
				var_345_0.localEulerAngles = var_345_7
			end

			if arg_342_1.time_ >= var_345_1 + var_345_3 and arg_342_1.time_ < var_345_1 + var_345_3 + arg_345_0 then
				var_345_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_345_8 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_8.x, var_345_8.y, var_345_8.z)

				local var_345_9 = var_345_0.localEulerAngles

				var_345_9.z = 0
				var_345_9.x = 0
				var_345_0.localEulerAngles = var_345_9

				local var_345_10 = GameObjectTools.GetOrAddComponent(var_345_0.gameObject, typeof(DynamicBoneHelper))

				if var_345_10 then
					var_345_10:EnableDynamicBone(true)
				end
			end

			local var_345_11 = arg_342_1.actors_["10171ui_story"]
			local var_345_12 = 0

			if var_345_12 < arg_342_1.time_ and arg_342_1.time_ <= var_345_12 + arg_345_0 and not isNil(var_345_11) and arg_342_1.var_.characterEffect10171ui_story == nil then
				arg_342_1.var_.characterEffect10171ui_story = var_345_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_13 = 0.200000002980232

			if var_345_12 <= arg_342_1.time_ and arg_342_1.time_ < var_345_12 + var_345_13 and not isNil(var_345_11) then
				local var_345_14 = (arg_342_1.time_ - var_345_12) / var_345_13

				if arg_342_1.var_.characterEffect10171ui_story and not isNil(var_345_11) then
					arg_342_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= var_345_12 + var_345_13 and arg_342_1.time_ < var_345_12 + var_345_13 + arg_345_0 and not isNil(var_345_11) and arg_342_1.var_.characterEffect10171ui_story then
				arg_342_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_345_15 = 0

			if var_345_15 < arg_342_1.time_ and arg_342_1.time_ <= var_345_15 + arg_345_0 then
				arg_342_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action33_1")
			end

			local var_345_16 = 0

			if var_345_16 < arg_342_1.time_ and arg_342_1.time_ <= var_345_16 + arg_345_0 then
				arg_342_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_345_17 = 0

			if var_345_17 < arg_342_1.time_ and arg_342_1.time_ <= var_345_17 + arg_345_0 then
				arg_342_1.allBtn_.enabled = false
			end

			local var_345_18 = 1.6

			if arg_342_1.time_ >= var_345_17 + var_345_18 and arg_342_1.time_ < var_345_17 + var_345_18 + arg_345_0 then
				arg_342_1.allBtn_.enabled = true
			end

			local var_345_19 = 0
			local var_345_20 = 0.2

			if var_345_19 < arg_342_1.time_ and arg_342_1.time_ <= var_345_19 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_21 = arg_342_1:FormatText(StoryNameCfg[1451].name)

				arg_342_1.leftNameTxt_.text = var_345_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_22 = arg_342_1:GetWordFromCfg(324081083)
				local var_345_23 = arg_342_1:FormatText(var_345_22.content)

				arg_342_1.text_.text = var_345_23

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_24 = 8
				local var_345_25 = utf8.len(var_345_23)
				local var_345_26 = var_345_24 <= 0 and var_345_20 or var_345_20 * (var_345_25 / var_345_24)

				if var_345_26 > 0 and var_345_20 < var_345_26 then
					arg_342_1.talkMaxDuration = var_345_26

					if var_345_26 + var_345_19 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_26 + var_345_19
					end
				end

				arg_342_1.text_.text = var_345_23
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081083", "story_v_out_324081.awb") ~= 0 then
					local var_345_27 = manager.audio:GetVoiceLength("story_v_out_324081", "324081083", "story_v_out_324081.awb") / 1000

					if var_345_27 + var_345_19 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_27 + var_345_19
					end

					if var_345_22.prefab_name ~= "" and arg_342_1.actors_[var_345_22.prefab_name] ~= nil then
						local var_345_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_22.prefab_name].transform, "story_v_out_324081", "324081083", "story_v_out_324081.awb")

						arg_342_1:RecordAudio("324081083", var_345_28)
						arg_342_1:RecordAudio("324081083", var_345_28)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_324081", "324081083", "story_v_out_324081.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_324081", "324081083", "story_v_out_324081.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_29 = math.max(var_345_20, arg_342_1.talkMaxDuration)

			if var_345_19 <= arg_342_1.time_ and arg_342_1.time_ < var_345_19 + var_345_29 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_19) / var_345_29

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_19 + var_345_29 and arg_342_1.time_ < var_345_19 + var_345_29 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play324081084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 324081084
		arg_346_1.duration_ = 6.33

		local var_346_0 = {
			zh = 4.566,
			ja = 6.333
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play324081085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1070ui_story"].transform
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.var_.moveOldPos1070ui_story = var_349_0.localPosition
			end

			local var_349_2 = 0.001

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2
				local var_349_4 = Vector3.New(0.7, -0.95, -6.05)

				var_349_0.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1070ui_story, var_349_4, var_349_3)

				local var_349_5 = manager.ui.mainCamera.transform.position - var_349_0.position

				var_349_0.forward = Vector3.New(var_349_5.x, var_349_5.y, var_349_5.z)

				local var_349_6 = var_349_0.localEulerAngles

				var_349_6.z = 0
				var_349_6.x = 0
				var_349_0.localEulerAngles = var_349_6
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 then
				var_349_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_349_7 = manager.ui.mainCamera.transform.position - var_349_0.position

				var_349_0.forward = Vector3.New(var_349_7.x, var_349_7.y, var_349_7.z)

				local var_349_8 = var_349_0.localEulerAngles

				var_349_8.z = 0
				var_349_8.x = 0
				var_349_0.localEulerAngles = var_349_8
			end

			local var_349_9 = arg_346_1.actors_["1070ui_story"]
			local var_349_10 = 0

			if var_349_10 < arg_346_1.time_ and arg_346_1.time_ <= var_349_10 + arg_349_0 and not isNil(var_349_9) and arg_346_1.var_.characterEffect1070ui_story == nil then
				arg_346_1.var_.characterEffect1070ui_story = var_349_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_11 = 0.200000002980232

			if var_349_10 <= arg_346_1.time_ and arg_346_1.time_ < var_349_10 + var_349_11 and not isNil(var_349_9) then
				local var_349_12 = (arg_346_1.time_ - var_349_10) / var_349_11

				if arg_346_1.var_.characterEffect1070ui_story and not isNil(var_349_9) then
					arg_346_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= var_349_10 + var_349_11 and arg_346_1.time_ < var_349_10 + var_349_11 + arg_349_0 and not isNil(var_349_9) and arg_346_1.var_.characterEffect1070ui_story then
				arg_346_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_349_13 = arg_346_1.actors_["10171ui_story"]
			local var_349_14 = 0

			if var_349_14 < arg_346_1.time_ and arg_346_1.time_ <= var_349_14 + arg_349_0 and not isNil(var_349_13) and arg_346_1.var_.characterEffect10171ui_story == nil then
				arg_346_1.var_.characterEffect10171ui_story = var_349_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_15 = 0.200000002980232

			if var_349_14 <= arg_346_1.time_ and arg_346_1.time_ < var_349_14 + var_349_15 and not isNil(var_349_13) then
				local var_349_16 = (arg_346_1.time_ - var_349_14) / var_349_15

				if arg_346_1.var_.characterEffect10171ui_story and not isNil(var_349_13) then
					local var_349_17 = Mathf.Lerp(0, 0.5, var_349_16)

					arg_346_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_346_1.var_.characterEffect10171ui_story.fillRatio = var_349_17
				end
			end

			if arg_346_1.time_ >= var_349_14 + var_349_15 and arg_346_1.time_ < var_349_14 + var_349_15 + arg_349_0 and not isNil(var_349_13) and arg_346_1.var_.characterEffect10171ui_story then
				local var_349_18 = 0.5

				arg_346_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_346_1.var_.characterEffect10171ui_story.fillRatio = var_349_18
			end

			local var_349_19 = 0

			if var_349_19 < arg_346_1.time_ and arg_346_1.time_ <= var_349_19 + arg_349_0 then
				arg_346_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_349_20 = 0

			if var_349_20 < arg_346_1.time_ and arg_346_1.time_ <= var_349_20 + arg_349_0 then
				arg_346_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_349_21 = 0
			local var_349_22 = 0.45

			if var_349_21 < arg_346_1.time_ and arg_346_1.time_ <= var_349_21 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_23 = arg_346_1:FormatText(StoryNameCfg[318].name)

				arg_346_1.leftNameTxt_.text = var_349_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_24 = arg_346_1:GetWordFromCfg(324081084)
				local var_349_25 = arg_346_1:FormatText(var_349_24.content)

				arg_346_1.text_.text = var_349_25

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_26 = 18
				local var_349_27 = utf8.len(var_349_25)
				local var_349_28 = var_349_26 <= 0 and var_349_22 or var_349_22 * (var_349_27 / var_349_26)

				if var_349_28 > 0 and var_349_22 < var_349_28 then
					arg_346_1.talkMaxDuration = var_349_28

					if var_349_28 + var_349_21 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_28 + var_349_21
					end
				end

				arg_346_1.text_.text = var_349_25
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081084", "story_v_out_324081.awb") ~= 0 then
					local var_349_29 = manager.audio:GetVoiceLength("story_v_out_324081", "324081084", "story_v_out_324081.awb") / 1000

					if var_349_29 + var_349_21 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_29 + var_349_21
					end

					if var_349_24.prefab_name ~= "" and arg_346_1.actors_[var_349_24.prefab_name] ~= nil then
						local var_349_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_24.prefab_name].transform, "story_v_out_324081", "324081084", "story_v_out_324081.awb")

						arg_346_1:RecordAudio("324081084", var_349_30)
						arg_346_1:RecordAudio("324081084", var_349_30)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_324081", "324081084", "story_v_out_324081.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_324081", "324081084", "story_v_out_324081.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_31 = math.max(var_349_22, arg_346_1.talkMaxDuration)

			if var_349_21 <= arg_346_1.time_ and arg_346_1.time_ < var_349_21 + var_349_31 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_21) / var_349_31

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_21 + var_349_31 and arg_346_1.time_ < var_349_21 + var_349_31 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
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

		arg_346_1:InitPlayNodeList()
	end,
	Play324081085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 324081085
		arg_350_1.duration_ = 6.77

		local var_350_0 = {
			zh = 6.766,
			ja = 5.766
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play324081086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["10171ui_story"]
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect10171ui_story == nil then
				arg_350_1.var_.characterEffect10171ui_story = var_353_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_2 = 0.200000002980232

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_2 and not isNil(var_353_0) then
				local var_353_3 = (arg_350_1.time_ - var_353_1) / var_353_2

				if arg_350_1.var_.characterEffect10171ui_story and not isNil(var_353_0) then
					arg_350_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= var_353_1 + var_353_2 and arg_350_1.time_ < var_353_1 + var_353_2 + arg_353_0 and not isNil(var_353_0) and arg_350_1.var_.characterEffect10171ui_story then
				arg_350_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_353_4 = arg_350_1.actors_["1070ui_story"]
			local var_353_5 = 0

			if var_353_5 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 and not isNil(var_353_4) and arg_350_1.var_.characterEffect1070ui_story == nil then
				arg_350_1.var_.characterEffect1070ui_story = var_353_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_6 = 0.200000002980232

			if var_353_5 <= arg_350_1.time_ and arg_350_1.time_ < var_353_5 + var_353_6 and not isNil(var_353_4) then
				local var_353_7 = (arg_350_1.time_ - var_353_5) / var_353_6

				if arg_350_1.var_.characterEffect1070ui_story and not isNil(var_353_4) then
					local var_353_8 = Mathf.Lerp(0, 0.5, var_353_7)

					arg_350_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_350_1.var_.characterEffect1070ui_story.fillRatio = var_353_8
				end
			end

			if arg_350_1.time_ >= var_353_5 + var_353_6 and arg_350_1.time_ < var_353_5 + var_353_6 + arg_353_0 and not isNil(var_353_4) and arg_350_1.var_.characterEffect1070ui_story then
				local var_353_9 = 0.5

				arg_350_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_350_1.var_.characterEffect1070ui_story.fillRatio = var_353_9
			end

			local var_353_10 = 0
			local var_353_11 = 0.725

			if var_353_10 < arg_350_1.time_ and arg_350_1.time_ <= var_353_10 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_12 = arg_350_1:FormatText(StoryNameCfg[1451].name)

				arg_350_1.leftNameTxt_.text = var_353_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_13 = arg_350_1:GetWordFromCfg(324081085)
				local var_353_14 = arg_350_1:FormatText(var_353_13.content)

				arg_350_1.text_.text = var_353_14

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_15 = 29
				local var_353_16 = utf8.len(var_353_14)
				local var_353_17 = var_353_15 <= 0 and var_353_11 or var_353_11 * (var_353_16 / var_353_15)

				if var_353_17 > 0 and var_353_11 < var_353_17 then
					arg_350_1.talkMaxDuration = var_353_17

					if var_353_17 + var_353_10 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_17 + var_353_10
					end
				end

				arg_350_1.text_.text = var_353_14
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081085", "story_v_out_324081.awb") ~= 0 then
					local var_353_18 = manager.audio:GetVoiceLength("story_v_out_324081", "324081085", "story_v_out_324081.awb") / 1000

					if var_353_18 + var_353_10 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_18 + var_353_10
					end

					if var_353_13.prefab_name ~= "" and arg_350_1.actors_[var_353_13.prefab_name] ~= nil then
						local var_353_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_13.prefab_name].transform, "story_v_out_324081", "324081085", "story_v_out_324081.awb")

						arg_350_1:RecordAudio("324081085", var_353_19)
						arg_350_1:RecordAudio("324081085", var_353_19)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_324081", "324081085", "story_v_out_324081.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_324081", "324081085", "story_v_out_324081.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_20 = math.max(var_353_11, arg_350_1.talkMaxDuration)

			if var_353_10 <= arg_350_1.time_ and arg_350_1.time_ < var_353_10 + var_353_20 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_10) / var_353_20

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_10 + var_353_20 and arg_350_1.time_ < var_353_10 + var_353_20 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play324081086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 324081086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play324081087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1070ui_story"].transform
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.var_.moveOldPos1070ui_story = var_357_0.localPosition
			end

			local var_357_2 = 0.001

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2
				local var_357_4 = Vector3.New(0, 100, 0)

				var_357_0.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1070ui_story, var_357_4, var_357_3)

				local var_357_5 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_5.x, var_357_5.y, var_357_5.z)

				local var_357_6 = var_357_0.localEulerAngles

				var_357_6.z = 0
				var_357_6.x = 0
				var_357_0.localEulerAngles = var_357_6
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 then
				var_357_0.localPosition = Vector3.New(0, 100, 0)

				local var_357_7 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_7.x, var_357_7.y, var_357_7.z)

				local var_357_8 = var_357_0.localEulerAngles

				var_357_8.z = 0
				var_357_8.x = 0
				var_357_0.localEulerAngles = var_357_8
			end

			local var_357_9 = arg_354_1.actors_["10171ui_story"].transform
			local var_357_10 = 0

			if var_357_10 < arg_354_1.time_ and arg_354_1.time_ <= var_357_10 + arg_357_0 then
				arg_354_1.var_.moveOldPos10171ui_story = var_357_9.localPosition

				local var_357_11 = GameObjectTools.GetOrAddComponent(var_357_9.gameObject, typeof(DynamicBoneHelper))

				if var_357_11 then
					var_357_11:EnableDynamicBone(false)
				end
			end

			local var_357_12 = 0.001

			if var_357_10 <= arg_354_1.time_ and arg_354_1.time_ < var_357_10 + var_357_12 then
				local var_357_13 = (arg_354_1.time_ - var_357_10) / var_357_12
				local var_357_14 = Vector3.New(0, 100, 0)

				var_357_9.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10171ui_story, var_357_14, var_357_13)

				local var_357_15 = manager.ui.mainCamera.transform.position - var_357_9.position

				var_357_9.forward = Vector3.New(var_357_15.x, var_357_15.y, var_357_15.z)

				local var_357_16 = var_357_9.localEulerAngles

				var_357_16.z = 0
				var_357_16.x = 0
				var_357_9.localEulerAngles = var_357_16
			end

			if arg_354_1.time_ >= var_357_10 + var_357_12 and arg_354_1.time_ < var_357_10 + var_357_12 + arg_357_0 then
				var_357_9.localPosition = Vector3.New(0, 100, 0)

				local var_357_17 = manager.ui.mainCamera.transform.position - var_357_9.position

				var_357_9.forward = Vector3.New(var_357_17.x, var_357_17.y, var_357_17.z)

				local var_357_18 = var_357_9.localEulerAngles

				var_357_18.z = 0
				var_357_18.x = 0
				var_357_9.localEulerAngles = var_357_18

				local var_357_19 = GameObjectTools.GetOrAddComponent(var_357_9.gameObject, typeof(DynamicBoneHelper))

				if var_357_19 then
					var_357_19:EnableDynamicBone(true)
				end
			end

			local var_357_20 = arg_354_1.actors_["10171ui_story"]
			local var_357_21 = 0

			if var_357_21 < arg_354_1.time_ and arg_354_1.time_ <= var_357_21 + arg_357_0 and not isNil(var_357_20) and arg_354_1.var_.characterEffect10171ui_story == nil then
				arg_354_1.var_.characterEffect10171ui_story = var_357_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_22 = 0.200000002980232

			if var_357_21 <= arg_354_1.time_ and arg_354_1.time_ < var_357_21 + var_357_22 and not isNil(var_357_20) then
				local var_357_23 = (arg_354_1.time_ - var_357_21) / var_357_22

				if arg_354_1.var_.characterEffect10171ui_story and not isNil(var_357_20) then
					local var_357_24 = Mathf.Lerp(0, 0.5, var_357_23)

					arg_354_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_354_1.var_.characterEffect10171ui_story.fillRatio = var_357_24
				end
			end

			if arg_354_1.time_ >= var_357_21 + var_357_22 and arg_354_1.time_ < var_357_21 + var_357_22 + arg_357_0 and not isNil(var_357_20) and arg_354_1.var_.characterEffect10171ui_story then
				local var_357_25 = 0.5

				arg_354_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_354_1.var_.characterEffect10171ui_story.fillRatio = var_357_25
			end

			local var_357_26 = 0
			local var_357_27 = 0.75

			if var_357_26 < arg_354_1.time_ and arg_354_1.time_ <= var_357_26 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_28 = arg_354_1:GetWordFromCfg(324081086)
				local var_357_29 = arg_354_1:FormatText(var_357_28.content)

				arg_354_1.text_.text = var_357_29

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_30 = 30
				local var_357_31 = utf8.len(var_357_29)
				local var_357_32 = var_357_30 <= 0 and var_357_27 or var_357_27 * (var_357_31 / var_357_30)

				if var_357_32 > 0 and var_357_27 < var_357_32 then
					arg_354_1.talkMaxDuration = var_357_32

					if var_357_32 + var_357_26 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_32 + var_357_26
					end
				end

				arg_354_1.text_.text = var_357_29
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_33 = math.max(var_357_27, arg_354_1.talkMaxDuration)

			if var_357_26 <= arg_354_1.time_ and arg_354_1.time_ < var_357_26 + var_357_33 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_26) / var_357_33

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_26 + var_357_33 and arg_354_1.time_ < var_357_26 + var_357_33 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play324081087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 324081087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play324081088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0
			local var_361_1 = 1.425

			if var_361_0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_2 = arg_358_1:GetWordFromCfg(324081087)
				local var_361_3 = arg_358_1:FormatText(var_361_2.content)

				arg_358_1.text_.text = var_361_3

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_4 = 57
				local var_361_5 = utf8.len(var_361_3)
				local var_361_6 = var_361_4 <= 0 and var_361_1 or var_361_1 * (var_361_5 / var_361_4)

				if var_361_6 > 0 and var_361_1 < var_361_6 then
					arg_358_1.talkMaxDuration = var_361_6

					if var_361_6 + var_361_0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_6 + var_361_0
					end
				end

				arg_358_1.text_.text = var_361_3
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_7 = math.max(var_361_1, arg_358_1.talkMaxDuration)

			if var_361_0 <= arg_358_1.time_ and arg_358_1.time_ < var_361_0 + var_361_7 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_0) / var_361_7

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_0 + var_361_7 and arg_358_1.time_ < var_361_0 + var_361_7 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play324081088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 324081088
		arg_362_1.duration_ = 7.23

		local var_362_0 = {
			zh = 4.633,
			ja = 7.233
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play324081089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["1070ui_story"].transform
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.var_.moveOldPos1070ui_story = var_365_0.localPosition
			end

			local var_365_2 = 0.001

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2
				local var_365_4 = Vector3.New(0.7, -0.95, -6.05)

				var_365_0.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1070ui_story, var_365_4, var_365_3)

				local var_365_5 = manager.ui.mainCamera.transform.position - var_365_0.position

				var_365_0.forward = Vector3.New(var_365_5.x, var_365_5.y, var_365_5.z)

				local var_365_6 = var_365_0.localEulerAngles

				var_365_6.z = 0
				var_365_6.x = 0
				var_365_0.localEulerAngles = var_365_6
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 then
				var_365_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_365_7 = manager.ui.mainCamera.transform.position - var_365_0.position

				var_365_0.forward = Vector3.New(var_365_7.x, var_365_7.y, var_365_7.z)

				local var_365_8 = var_365_0.localEulerAngles

				var_365_8.z = 0
				var_365_8.x = 0
				var_365_0.localEulerAngles = var_365_8
			end

			local var_365_9 = arg_362_1.actors_["1070ui_story"]
			local var_365_10 = 0

			if var_365_10 < arg_362_1.time_ and arg_362_1.time_ <= var_365_10 + arg_365_0 and not isNil(var_365_9) and arg_362_1.var_.characterEffect1070ui_story == nil then
				arg_362_1.var_.characterEffect1070ui_story = var_365_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_11 = 0.200000002980232

			if var_365_10 <= arg_362_1.time_ and arg_362_1.time_ < var_365_10 + var_365_11 and not isNil(var_365_9) then
				local var_365_12 = (arg_362_1.time_ - var_365_10) / var_365_11

				if arg_362_1.var_.characterEffect1070ui_story and not isNil(var_365_9) then
					arg_362_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= var_365_10 + var_365_11 and arg_362_1.time_ < var_365_10 + var_365_11 + arg_365_0 and not isNil(var_365_9) and arg_362_1.var_.characterEffect1070ui_story then
				arg_362_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_365_13 = 0

			if var_365_13 < arg_362_1.time_ and arg_362_1.time_ <= var_365_13 + arg_365_0 then
				arg_362_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_365_14 = 0

			if var_365_14 < arg_362_1.time_ and arg_362_1.time_ <= var_365_14 + arg_365_0 then
				arg_362_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_365_15 = 0
			local var_365_16 = 0.55

			if var_365_15 < arg_362_1.time_ and arg_362_1.time_ <= var_365_15 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_17 = arg_362_1:FormatText(StoryNameCfg[318].name)

				arg_362_1.leftNameTxt_.text = var_365_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_18 = arg_362_1:GetWordFromCfg(324081088)
				local var_365_19 = arg_362_1:FormatText(var_365_18.content)

				arg_362_1.text_.text = var_365_19

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_20 = 22
				local var_365_21 = utf8.len(var_365_19)
				local var_365_22 = var_365_20 <= 0 and var_365_16 or var_365_16 * (var_365_21 / var_365_20)

				if var_365_22 > 0 and var_365_16 < var_365_22 then
					arg_362_1.talkMaxDuration = var_365_22

					if var_365_22 + var_365_15 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_22 + var_365_15
					end
				end

				arg_362_1.text_.text = var_365_19
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081088", "story_v_out_324081.awb") ~= 0 then
					local var_365_23 = manager.audio:GetVoiceLength("story_v_out_324081", "324081088", "story_v_out_324081.awb") / 1000

					if var_365_23 + var_365_15 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_23 + var_365_15
					end

					if var_365_18.prefab_name ~= "" and arg_362_1.actors_[var_365_18.prefab_name] ~= nil then
						local var_365_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_18.prefab_name].transform, "story_v_out_324081", "324081088", "story_v_out_324081.awb")

						arg_362_1:RecordAudio("324081088", var_365_24)
						arg_362_1:RecordAudio("324081088", var_365_24)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_324081", "324081088", "story_v_out_324081.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_324081", "324081088", "story_v_out_324081.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_25 = math.max(var_365_16, arg_362_1.talkMaxDuration)

			if var_365_15 <= arg_362_1.time_ and arg_362_1.time_ < var_365_15 + var_365_25 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_15) / var_365_25

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_15 + var_365_25 and arg_362_1.time_ < var_365_15 + var_365_25 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
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

		arg_362_1:InitPlayNodeList()
	end,
	Play324081089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 324081089
		arg_366_1.duration_ = 4.73

		local var_366_0 = {
			zh = 3.6,
			ja = 4.733
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play324081090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["10171ui_story"].transform
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.var_.moveOldPos10171ui_story = var_369_0.localPosition

				local var_369_2 = GameObjectTools.GetOrAddComponent(var_369_0.gameObject, typeof(DynamicBoneHelper))

				if var_369_2 then
					var_369_2:EnableDynamicBone(false)
				end
			end

			local var_369_3 = 0.001

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_3 then
				local var_369_4 = (arg_366_1.time_ - var_369_1) / var_369_3
				local var_369_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_369_0.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos10171ui_story, var_369_5, var_369_4)

				local var_369_6 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_6.x, var_369_6.y, var_369_6.z)

				local var_369_7 = var_369_0.localEulerAngles

				var_369_7.z = 0
				var_369_7.x = 0
				var_369_0.localEulerAngles = var_369_7
			end

			if arg_366_1.time_ >= var_369_1 + var_369_3 and arg_366_1.time_ < var_369_1 + var_369_3 + arg_369_0 then
				var_369_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_369_8 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_8.x, var_369_8.y, var_369_8.z)

				local var_369_9 = var_369_0.localEulerAngles

				var_369_9.z = 0
				var_369_9.x = 0
				var_369_0.localEulerAngles = var_369_9

				local var_369_10 = GameObjectTools.GetOrAddComponent(var_369_0.gameObject, typeof(DynamicBoneHelper))

				if var_369_10 then
					var_369_10:EnableDynamicBone(true)
				end
			end

			local var_369_11 = arg_366_1.actors_["10171ui_story"]
			local var_369_12 = 0

			if var_369_12 < arg_366_1.time_ and arg_366_1.time_ <= var_369_12 + arg_369_0 and not isNil(var_369_11) and arg_366_1.var_.characterEffect10171ui_story == nil then
				arg_366_1.var_.characterEffect10171ui_story = var_369_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_13 = 0.200000002980232

			if var_369_12 <= arg_366_1.time_ and arg_366_1.time_ < var_369_12 + var_369_13 and not isNil(var_369_11) then
				local var_369_14 = (arg_366_1.time_ - var_369_12) / var_369_13

				if arg_366_1.var_.characterEffect10171ui_story and not isNil(var_369_11) then
					arg_366_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= var_369_12 + var_369_13 and arg_366_1.time_ < var_369_12 + var_369_13 + arg_369_0 and not isNil(var_369_11) and arg_366_1.var_.characterEffect10171ui_story then
				arg_366_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_369_15 = arg_366_1.actors_["1070ui_story"]
			local var_369_16 = 0

			if var_369_16 < arg_366_1.time_ and arg_366_1.time_ <= var_369_16 + arg_369_0 and not isNil(var_369_15) and arg_366_1.var_.characterEffect1070ui_story == nil then
				arg_366_1.var_.characterEffect1070ui_story = var_369_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_17 = 0.200000002980232

			if var_369_16 <= arg_366_1.time_ and arg_366_1.time_ < var_369_16 + var_369_17 and not isNil(var_369_15) then
				local var_369_18 = (arg_366_1.time_ - var_369_16) / var_369_17

				if arg_366_1.var_.characterEffect1070ui_story and not isNil(var_369_15) then
					local var_369_19 = Mathf.Lerp(0, 0.5, var_369_18)

					arg_366_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_366_1.var_.characterEffect1070ui_story.fillRatio = var_369_19
				end
			end

			if arg_366_1.time_ >= var_369_16 + var_369_17 and arg_366_1.time_ < var_369_16 + var_369_17 + arg_369_0 and not isNil(var_369_15) and arg_366_1.var_.characterEffect1070ui_story then
				local var_369_20 = 0.5

				arg_366_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_366_1.var_.characterEffect1070ui_story.fillRatio = var_369_20
			end

			local var_369_21 = 0

			if var_369_21 < arg_366_1.time_ and arg_366_1.time_ <= var_369_21 + arg_369_0 then
				arg_366_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action33_2")
			end

			local var_369_22 = 0
			local var_369_23 = 0.375

			if var_369_22 < arg_366_1.time_ and arg_366_1.time_ <= var_369_22 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_24 = arg_366_1:FormatText(StoryNameCfg[1451].name)

				arg_366_1.leftNameTxt_.text = var_369_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_25 = arg_366_1:GetWordFromCfg(324081089)
				local var_369_26 = arg_366_1:FormatText(var_369_25.content)

				arg_366_1.text_.text = var_369_26

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_27 = 15
				local var_369_28 = utf8.len(var_369_26)
				local var_369_29 = var_369_27 <= 0 and var_369_23 or var_369_23 * (var_369_28 / var_369_27)

				if var_369_29 > 0 and var_369_23 < var_369_29 then
					arg_366_1.talkMaxDuration = var_369_29

					if var_369_29 + var_369_22 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_29 + var_369_22
					end
				end

				arg_366_1.text_.text = var_369_26
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081089", "story_v_out_324081.awb") ~= 0 then
					local var_369_30 = manager.audio:GetVoiceLength("story_v_out_324081", "324081089", "story_v_out_324081.awb") / 1000

					if var_369_30 + var_369_22 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_30 + var_369_22
					end

					if var_369_25.prefab_name ~= "" and arg_366_1.actors_[var_369_25.prefab_name] ~= nil then
						local var_369_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_25.prefab_name].transform, "story_v_out_324081", "324081089", "story_v_out_324081.awb")

						arg_366_1:RecordAudio("324081089", var_369_31)
						arg_366_1:RecordAudio("324081089", var_369_31)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_324081", "324081089", "story_v_out_324081.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_324081", "324081089", "story_v_out_324081.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_32 = math.max(var_369_23, arg_366_1.talkMaxDuration)

			if var_369_22 <= arg_366_1.time_ and arg_366_1.time_ < var_369_22 + var_369_32 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_22) / var_369_32

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_22 + var_369_32 and arg_366_1.time_ < var_369_22 + var_369_32 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play324081090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 324081090
		arg_370_1.duration_ = 5.07

		local var_370_0 = {
			zh = 3.6,
			ja = 5.066
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play324081091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1070ui_story"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect1070ui_story == nil then
				arg_370_1.var_.characterEffect1070ui_story = var_373_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.200000002980232

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.characterEffect1070ui_story and not isNil(var_373_0) then
					arg_370_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect1070ui_story then
				arg_370_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_373_4 = arg_370_1.actors_["10171ui_story"]
			local var_373_5 = 0

			if var_373_5 < arg_370_1.time_ and arg_370_1.time_ <= var_373_5 + arg_373_0 and not isNil(var_373_4) and arg_370_1.var_.characterEffect10171ui_story == nil then
				arg_370_1.var_.characterEffect10171ui_story = var_373_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_6 = 0.200000002980232

			if var_373_5 <= arg_370_1.time_ and arg_370_1.time_ < var_373_5 + var_373_6 and not isNil(var_373_4) then
				local var_373_7 = (arg_370_1.time_ - var_373_5) / var_373_6

				if arg_370_1.var_.characterEffect10171ui_story and not isNil(var_373_4) then
					local var_373_8 = Mathf.Lerp(0, 0.5, var_373_7)

					arg_370_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_370_1.var_.characterEffect10171ui_story.fillRatio = var_373_8
				end
			end

			if arg_370_1.time_ >= var_373_5 + var_373_6 and arg_370_1.time_ < var_373_5 + var_373_6 + arg_373_0 and not isNil(var_373_4) and arg_370_1.var_.characterEffect10171ui_story then
				local var_373_9 = 0.5

				arg_370_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_370_1.var_.characterEffect10171ui_story.fillRatio = var_373_9
			end

			local var_373_10 = 0
			local var_373_11 = 0.375

			if var_373_10 < arg_370_1.time_ and arg_370_1.time_ <= var_373_10 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_12 = arg_370_1:FormatText(StoryNameCfg[318].name)

				arg_370_1.leftNameTxt_.text = var_373_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_13 = arg_370_1:GetWordFromCfg(324081090)
				local var_373_14 = arg_370_1:FormatText(var_373_13.content)

				arg_370_1.text_.text = var_373_14

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_15 = 15
				local var_373_16 = utf8.len(var_373_14)
				local var_373_17 = var_373_15 <= 0 and var_373_11 or var_373_11 * (var_373_16 / var_373_15)

				if var_373_17 > 0 and var_373_11 < var_373_17 then
					arg_370_1.talkMaxDuration = var_373_17

					if var_373_17 + var_373_10 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_17 + var_373_10
					end
				end

				arg_370_1.text_.text = var_373_14
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081090", "story_v_out_324081.awb") ~= 0 then
					local var_373_18 = manager.audio:GetVoiceLength("story_v_out_324081", "324081090", "story_v_out_324081.awb") / 1000

					if var_373_18 + var_373_10 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_18 + var_373_10
					end

					if var_373_13.prefab_name ~= "" and arg_370_1.actors_[var_373_13.prefab_name] ~= nil then
						local var_373_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_13.prefab_name].transform, "story_v_out_324081", "324081090", "story_v_out_324081.awb")

						arg_370_1:RecordAudio("324081090", var_373_19)
						arg_370_1:RecordAudio("324081090", var_373_19)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_324081", "324081090", "story_v_out_324081.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_324081", "324081090", "story_v_out_324081.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_20 = math.max(var_373_11, arg_370_1.talkMaxDuration)

			if var_373_10 <= arg_370_1.time_ and arg_370_1.time_ < var_373_10 + var_373_20 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_10) / var_373_20

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_10 + var_373_20 and arg_370_1.time_ < var_373_10 + var_373_20 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play324081091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 324081091
		arg_374_1.duration_ = 10

		local var_374_0 = {
			zh = 9.566,
			ja = 10
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play324081092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["10171ui_story"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect10171ui_story == nil then
				arg_374_1.var_.characterEffect10171ui_story = var_377_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.200000002980232

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.characterEffect10171ui_story and not isNil(var_377_0) then
					arg_374_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect10171ui_story then
				arg_374_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_377_4 = arg_374_1.actors_["1070ui_story"]
			local var_377_5 = 0

			if var_377_5 < arg_374_1.time_ and arg_374_1.time_ <= var_377_5 + arg_377_0 and not isNil(var_377_4) and arg_374_1.var_.characterEffect1070ui_story == nil then
				arg_374_1.var_.characterEffect1070ui_story = var_377_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_6 = 0.200000002980232

			if var_377_5 <= arg_374_1.time_ and arg_374_1.time_ < var_377_5 + var_377_6 and not isNil(var_377_4) then
				local var_377_7 = (arg_374_1.time_ - var_377_5) / var_377_6

				if arg_374_1.var_.characterEffect1070ui_story and not isNil(var_377_4) then
					local var_377_8 = Mathf.Lerp(0, 0.5, var_377_7)

					arg_374_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_374_1.var_.characterEffect1070ui_story.fillRatio = var_377_8
				end
			end

			if arg_374_1.time_ >= var_377_5 + var_377_6 and arg_374_1.time_ < var_377_5 + var_377_6 + arg_377_0 and not isNil(var_377_4) and arg_374_1.var_.characterEffect1070ui_story then
				local var_377_9 = 0.5

				arg_374_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_374_1.var_.characterEffect1070ui_story.fillRatio = var_377_9
			end

			local var_377_10 = 0
			local var_377_11 = 1.15

			if var_377_10 < arg_374_1.time_ and arg_374_1.time_ <= var_377_10 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_12 = arg_374_1:FormatText(StoryNameCfg[1451].name)

				arg_374_1.leftNameTxt_.text = var_377_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_13 = arg_374_1:GetWordFromCfg(324081091)
				local var_377_14 = arg_374_1:FormatText(var_377_13.content)

				arg_374_1.text_.text = var_377_14

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_15 = 46
				local var_377_16 = utf8.len(var_377_14)
				local var_377_17 = var_377_15 <= 0 and var_377_11 or var_377_11 * (var_377_16 / var_377_15)

				if var_377_17 > 0 and var_377_11 < var_377_17 then
					arg_374_1.talkMaxDuration = var_377_17

					if var_377_17 + var_377_10 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_17 + var_377_10
					end
				end

				arg_374_1.text_.text = var_377_14
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081091", "story_v_out_324081.awb") ~= 0 then
					local var_377_18 = manager.audio:GetVoiceLength("story_v_out_324081", "324081091", "story_v_out_324081.awb") / 1000

					if var_377_18 + var_377_10 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_18 + var_377_10
					end

					if var_377_13.prefab_name ~= "" and arg_374_1.actors_[var_377_13.prefab_name] ~= nil then
						local var_377_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_13.prefab_name].transform, "story_v_out_324081", "324081091", "story_v_out_324081.awb")

						arg_374_1:RecordAudio("324081091", var_377_19)
						arg_374_1:RecordAudio("324081091", var_377_19)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_324081", "324081091", "story_v_out_324081.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_324081", "324081091", "story_v_out_324081.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_20 = math.max(var_377_11, arg_374_1.talkMaxDuration)

			if var_377_10 <= arg_374_1.time_ and arg_374_1.time_ < var_377_10 + var_377_20 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_10) / var_377_20

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_10 + var_377_20 and arg_374_1.time_ < var_377_10 + var_377_20 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play324081092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 324081092
		arg_378_1.duration_ = 12.23

		local var_378_0 = {
			zh = 12.233,
			ja = 6.7
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play324081093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0

			if var_381_0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action31_1")
			end

			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_381_2 = 0
			local var_381_3 = 1.425

			if var_381_2 < arg_378_1.time_ and arg_378_1.time_ <= var_381_2 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_4 = arg_378_1:FormatText(StoryNameCfg[1451].name)

				arg_378_1.leftNameTxt_.text = var_381_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_5 = arg_378_1:GetWordFromCfg(324081092)
				local var_381_6 = arg_378_1:FormatText(var_381_5.content)

				arg_378_1.text_.text = var_381_6

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_7 = 57
				local var_381_8 = utf8.len(var_381_6)
				local var_381_9 = var_381_7 <= 0 and var_381_3 or var_381_3 * (var_381_8 / var_381_7)

				if var_381_9 > 0 and var_381_3 < var_381_9 then
					arg_378_1.talkMaxDuration = var_381_9

					if var_381_9 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_9 + var_381_2
					end
				end

				arg_378_1.text_.text = var_381_6
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081092", "story_v_out_324081.awb") ~= 0 then
					local var_381_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081092", "story_v_out_324081.awb") / 1000

					if var_381_10 + var_381_2 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_10 + var_381_2
					end

					if var_381_5.prefab_name ~= "" and arg_378_1.actors_[var_381_5.prefab_name] ~= nil then
						local var_381_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_5.prefab_name].transform, "story_v_out_324081", "324081092", "story_v_out_324081.awb")

						arg_378_1:RecordAudio("324081092", var_381_11)
						arg_378_1:RecordAudio("324081092", var_381_11)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_324081", "324081092", "story_v_out_324081.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_324081", "324081092", "story_v_out_324081.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_12 = math.max(var_381_3, arg_378_1.talkMaxDuration)

			if var_381_2 <= arg_378_1.time_ and arg_378_1.time_ < var_381_2 + var_381_12 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_2) / var_381_12

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_2 + var_381_12 and arg_378_1.time_ < var_381_2 + var_381_12 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play324081093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 324081093
		arg_382_1.duration_ = 12.83

		local var_382_0 = {
			zh = 11.066,
			ja = 12.833
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play324081094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1070ui_story"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1070ui_story == nil then
				arg_382_1.var_.characterEffect1070ui_story = var_385_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.characterEffect1070ui_story and not isNil(var_385_0) then
					arg_382_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1070ui_story then
				arg_382_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_385_4 = arg_382_1.actors_["10171ui_story"]
			local var_385_5 = 0

			if var_385_5 < arg_382_1.time_ and arg_382_1.time_ <= var_385_5 + arg_385_0 and not isNil(var_385_4) and arg_382_1.var_.characterEffect10171ui_story == nil then
				arg_382_1.var_.characterEffect10171ui_story = var_385_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_6 = 0.200000002980232

			if var_385_5 <= arg_382_1.time_ and arg_382_1.time_ < var_385_5 + var_385_6 and not isNil(var_385_4) then
				local var_385_7 = (arg_382_1.time_ - var_385_5) / var_385_6

				if arg_382_1.var_.characterEffect10171ui_story and not isNil(var_385_4) then
					local var_385_8 = Mathf.Lerp(0, 0.5, var_385_7)

					arg_382_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_382_1.var_.characterEffect10171ui_story.fillRatio = var_385_8
				end
			end

			if arg_382_1.time_ >= var_385_5 + var_385_6 and arg_382_1.time_ < var_385_5 + var_385_6 + arg_385_0 and not isNil(var_385_4) and arg_382_1.var_.characterEffect10171ui_story then
				local var_385_9 = 0.5

				arg_382_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_382_1.var_.characterEffect10171ui_story.fillRatio = var_385_9
			end

			local var_385_10 = 0

			if var_385_10 < arg_382_1.time_ and arg_382_1.time_ <= var_385_10 + arg_385_0 then
				arg_382_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_385_11 = 0

			if var_385_11 < arg_382_1.time_ and arg_382_1.time_ <= var_385_11 + arg_385_0 then
				arg_382_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_385_12 = 0
			local var_385_13 = 1.225

			if var_385_12 < arg_382_1.time_ and arg_382_1.time_ <= var_385_12 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_14 = arg_382_1:FormatText(StoryNameCfg[318].name)

				arg_382_1.leftNameTxt_.text = var_385_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_15 = arg_382_1:GetWordFromCfg(324081093)
				local var_385_16 = arg_382_1:FormatText(var_385_15.content)

				arg_382_1.text_.text = var_385_16

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_17 = 49
				local var_385_18 = utf8.len(var_385_16)
				local var_385_19 = var_385_17 <= 0 and var_385_13 or var_385_13 * (var_385_18 / var_385_17)

				if var_385_19 > 0 and var_385_13 < var_385_19 then
					arg_382_1.talkMaxDuration = var_385_19

					if var_385_19 + var_385_12 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_19 + var_385_12
					end
				end

				arg_382_1.text_.text = var_385_16
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081093", "story_v_out_324081.awb") ~= 0 then
					local var_385_20 = manager.audio:GetVoiceLength("story_v_out_324081", "324081093", "story_v_out_324081.awb") / 1000

					if var_385_20 + var_385_12 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_20 + var_385_12
					end

					if var_385_15.prefab_name ~= "" and arg_382_1.actors_[var_385_15.prefab_name] ~= nil then
						local var_385_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_15.prefab_name].transform, "story_v_out_324081", "324081093", "story_v_out_324081.awb")

						arg_382_1:RecordAudio("324081093", var_385_21)
						arg_382_1:RecordAudio("324081093", var_385_21)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_324081", "324081093", "story_v_out_324081.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_324081", "324081093", "story_v_out_324081.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_22 = math.max(var_385_13, arg_382_1.talkMaxDuration)

			if var_385_12 <= arg_382_1.time_ and arg_382_1.time_ < var_385_12 + var_385_22 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_12) / var_385_22

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_12 + var_385_22 and arg_382_1.time_ < var_385_12 + var_385_22 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play324081094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 324081094
		arg_386_1.duration_ = 2

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play324081095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["10171ui_story"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect10171ui_story == nil then
				arg_386_1.var_.characterEffect10171ui_story = var_389_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.characterEffect10171ui_story and not isNil(var_389_0) then
					arg_386_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect10171ui_story then
				arg_386_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_389_4 = arg_386_1.actors_["1070ui_story"]
			local var_389_5 = 0

			if var_389_5 < arg_386_1.time_ and arg_386_1.time_ <= var_389_5 + arg_389_0 and not isNil(var_389_4) and arg_386_1.var_.characterEffect1070ui_story == nil then
				arg_386_1.var_.characterEffect1070ui_story = var_389_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_6 = 0.200000002980232

			if var_389_5 <= arg_386_1.time_ and arg_386_1.time_ < var_389_5 + var_389_6 and not isNil(var_389_4) then
				local var_389_7 = (arg_386_1.time_ - var_389_5) / var_389_6

				if arg_386_1.var_.characterEffect1070ui_story and not isNil(var_389_4) then
					local var_389_8 = Mathf.Lerp(0, 0.5, var_389_7)

					arg_386_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_386_1.var_.characterEffect1070ui_story.fillRatio = var_389_8
				end
			end

			if arg_386_1.time_ >= var_389_5 + var_389_6 and arg_386_1.time_ < var_389_5 + var_389_6 + arg_389_0 and not isNil(var_389_4) and arg_386_1.var_.characterEffect1070ui_story then
				local var_389_9 = 0.5

				arg_386_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_386_1.var_.characterEffect1070ui_story.fillRatio = var_389_9
			end

			local var_389_10 = 0

			if var_389_10 < arg_386_1.time_ and arg_386_1.time_ <= var_389_10 + arg_389_0 then
				arg_386_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action31_2")
			end

			local var_389_11 = 0
			local var_389_12 = 0.125

			if var_389_11 < arg_386_1.time_ and arg_386_1.time_ <= var_389_11 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_13 = arg_386_1:FormatText(StoryNameCfg[1451].name)

				arg_386_1.leftNameTxt_.text = var_389_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_14 = arg_386_1:GetWordFromCfg(324081094)
				local var_389_15 = arg_386_1:FormatText(var_389_14.content)

				arg_386_1.text_.text = var_389_15

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_16 = 5
				local var_389_17 = utf8.len(var_389_15)
				local var_389_18 = var_389_16 <= 0 and var_389_12 or var_389_12 * (var_389_17 / var_389_16)

				if var_389_18 > 0 and var_389_12 < var_389_18 then
					arg_386_1.talkMaxDuration = var_389_18

					if var_389_18 + var_389_11 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_18 + var_389_11
					end
				end

				arg_386_1.text_.text = var_389_15
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081094", "story_v_out_324081.awb") ~= 0 then
					local var_389_19 = manager.audio:GetVoiceLength("story_v_out_324081", "324081094", "story_v_out_324081.awb") / 1000

					if var_389_19 + var_389_11 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_19 + var_389_11
					end

					if var_389_14.prefab_name ~= "" and arg_386_1.actors_[var_389_14.prefab_name] ~= nil then
						local var_389_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_14.prefab_name].transform, "story_v_out_324081", "324081094", "story_v_out_324081.awb")

						arg_386_1:RecordAudio("324081094", var_389_20)
						arg_386_1:RecordAudio("324081094", var_389_20)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_324081", "324081094", "story_v_out_324081.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_324081", "324081094", "story_v_out_324081.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_21 = math.max(var_389_12, arg_386_1.talkMaxDuration)

			if var_389_11 <= arg_386_1.time_ and arg_386_1.time_ < var_389_11 + var_389_21 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_11) / var_389_21

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_11 + var_389_21 and arg_386_1.time_ < var_389_11 + var_389_21 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play324081095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 324081095
		arg_390_1.duration_ = 4.4

		local var_390_0 = {
			zh = 4.1,
			ja = 4.4
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play324081096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = arg_390_1.actors_["1070ui_story"]
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect1070ui_story == nil then
				arg_390_1.var_.characterEffect1070ui_story = var_393_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_2 = 0.200000002980232

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 and not isNil(var_393_0) then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2

				if arg_390_1.var_.characterEffect1070ui_story and not isNil(var_393_0) then
					arg_390_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 and not isNil(var_393_0) and arg_390_1.var_.characterEffect1070ui_story then
				arg_390_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_393_4 = arg_390_1.actors_["10171ui_story"]
			local var_393_5 = 0

			if var_393_5 < arg_390_1.time_ and arg_390_1.time_ <= var_393_5 + arg_393_0 and not isNil(var_393_4) and arg_390_1.var_.characterEffect10171ui_story == nil then
				arg_390_1.var_.characterEffect10171ui_story = var_393_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_6 = 0.200000002980232

			if var_393_5 <= arg_390_1.time_ and arg_390_1.time_ < var_393_5 + var_393_6 and not isNil(var_393_4) then
				local var_393_7 = (arg_390_1.time_ - var_393_5) / var_393_6

				if arg_390_1.var_.characterEffect10171ui_story and not isNil(var_393_4) then
					local var_393_8 = Mathf.Lerp(0, 0.5, var_393_7)

					arg_390_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_390_1.var_.characterEffect10171ui_story.fillRatio = var_393_8
				end
			end

			if arg_390_1.time_ >= var_393_5 + var_393_6 and arg_390_1.time_ < var_393_5 + var_393_6 + arg_393_0 and not isNil(var_393_4) and arg_390_1.var_.characterEffect10171ui_story then
				local var_393_9 = 0.5

				arg_390_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_390_1.var_.characterEffect10171ui_story.fillRatio = var_393_9
			end

			local var_393_10 = 0

			if var_393_10 < arg_390_1.time_ and arg_390_1.time_ <= var_393_10 + arg_393_0 then
				arg_390_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_393_11 = 0

			if var_393_11 < arg_390_1.time_ and arg_390_1.time_ <= var_393_11 + arg_393_0 then
				arg_390_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_393_12 = 0
			local var_393_13 = 0.45

			if var_393_12 < arg_390_1.time_ and arg_390_1.time_ <= var_393_12 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_14 = arg_390_1:FormatText(StoryNameCfg[318].name)

				arg_390_1.leftNameTxt_.text = var_393_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_15 = arg_390_1:GetWordFromCfg(324081095)
				local var_393_16 = arg_390_1:FormatText(var_393_15.content)

				arg_390_1.text_.text = var_393_16

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_17 = 18
				local var_393_18 = utf8.len(var_393_16)
				local var_393_19 = var_393_17 <= 0 and var_393_13 or var_393_13 * (var_393_18 / var_393_17)

				if var_393_19 > 0 and var_393_13 < var_393_19 then
					arg_390_1.talkMaxDuration = var_393_19

					if var_393_19 + var_393_12 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_19 + var_393_12
					end
				end

				arg_390_1.text_.text = var_393_16
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081095", "story_v_out_324081.awb") ~= 0 then
					local var_393_20 = manager.audio:GetVoiceLength("story_v_out_324081", "324081095", "story_v_out_324081.awb") / 1000

					if var_393_20 + var_393_12 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_20 + var_393_12
					end

					if var_393_15.prefab_name ~= "" and arg_390_1.actors_[var_393_15.prefab_name] ~= nil then
						local var_393_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_15.prefab_name].transform, "story_v_out_324081", "324081095", "story_v_out_324081.awb")

						arg_390_1:RecordAudio("324081095", var_393_21)
						arg_390_1:RecordAudio("324081095", var_393_21)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_324081", "324081095", "story_v_out_324081.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_324081", "324081095", "story_v_out_324081.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_22 = math.max(var_393_13, arg_390_1.talkMaxDuration)

			if var_393_12 <= arg_390_1.time_ and arg_390_1.time_ < var_393_12 + var_393_22 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_12) / var_393_22

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_12 + var_393_22 and arg_390_1.time_ < var_393_12 + var_393_22 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play324081096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 324081096
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play324081097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1070ui_story"].transform
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 then
				arg_394_1.var_.moveOldPos1070ui_story = var_397_0.localPosition
			end

			local var_397_2 = 0.001

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2
				local var_397_4 = Vector3.New(0, 100, 0)

				var_397_0.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1070ui_story, var_397_4, var_397_3)

				local var_397_5 = manager.ui.mainCamera.transform.position - var_397_0.position

				var_397_0.forward = Vector3.New(var_397_5.x, var_397_5.y, var_397_5.z)

				local var_397_6 = var_397_0.localEulerAngles

				var_397_6.z = 0
				var_397_6.x = 0
				var_397_0.localEulerAngles = var_397_6
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 then
				var_397_0.localPosition = Vector3.New(0, 100, 0)

				local var_397_7 = manager.ui.mainCamera.transform.position - var_397_0.position

				var_397_0.forward = Vector3.New(var_397_7.x, var_397_7.y, var_397_7.z)

				local var_397_8 = var_397_0.localEulerAngles

				var_397_8.z = 0
				var_397_8.x = 0
				var_397_0.localEulerAngles = var_397_8
			end

			local var_397_9 = arg_394_1.actors_["10171ui_story"].transform
			local var_397_10 = 0

			if var_397_10 < arg_394_1.time_ and arg_394_1.time_ <= var_397_10 + arg_397_0 then
				arg_394_1.var_.moveOldPos10171ui_story = var_397_9.localPosition

				local var_397_11 = GameObjectTools.GetOrAddComponent(var_397_9.gameObject, typeof(DynamicBoneHelper))

				if var_397_11 then
					var_397_11:EnableDynamicBone(false)
				end
			end

			local var_397_12 = 0.001

			if var_397_10 <= arg_394_1.time_ and arg_394_1.time_ < var_397_10 + var_397_12 then
				local var_397_13 = (arg_394_1.time_ - var_397_10) / var_397_12
				local var_397_14 = Vector3.New(0, 100, 0)

				var_397_9.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos10171ui_story, var_397_14, var_397_13)

				local var_397_15 = manager.ui.mainCamera.transform.position - var_397_9.position

				var_397_9.forward = Vector3.New(var_397_15.x, var_397_15.y, var_397_15.z)

				local var_397_16 = var_397_9.localEulerAngles

				var_397_16.z = 0
				var_397_16.x = 0
				var_397_9.localEulerAngles = var_397_16
			end

			if arg_394_1.time_ >= var_397_10 + var_397_12 and arg_394_1.time_ < var_397_10 + var_397_12 + arg_397_0 then
				var_397_9.localPosition = Vector3.New(0, 100, 0)

				local var_397_17 = manager.ui.mainCamera.transform.position - var_397_9.position

				var_397_9.forward = Vector3.New(var_397_17.x, var_397_17.y, var_397_17.z)

				local var_397_18 = var_397_9.localEulerAngles

				var_397_18.z = 0
				var_397_18.x = 0
				var_397_9.localEulerAngles = var_397_18

				local var_397_19 = GameObjectTools.GetOrAddComponent(var_397_9.gameObject, typeof(DynamicBoneHelper))

				if var_397_19 then
					var_397_19:EnableDynamicBone(true)
				end
			end

			local var_397_20 = arg_394_1.actors_["1070ui_story"]
			local var_397_21 = 0

			if var_397_21 < arg_394_1.time_ and arg_394_1.time_ <= var_397_21 + arg_397_0 and not isNil(var_397_20) and arg_394_1.var_.characterEffect1070ui_story == nil then
				arg_394_1.var_.characterEffect1070ui_story = var_397_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_22 = 0.200000002980232

			if var_397_21 <= arg_394_1.time_ and arg_394_1.time_ < var_397_21 + var_397_22 and not isNil(var_397_20) then
				local var_397_23 = (arg_394_1.time_ - var_397_21) / var_397_22

				if arg_394_1.var_.characterEffect1070ui_story and not isNil(var_397_20) then
					local var_397_24 = Mathf.Lerp(0, 0.5, var_397_23)

					arg_394_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1070ui_story.fillRatio = var_397_24
				end
			end

			if arg_394_1.time_ >= var_397_21 + var_397_22 and arg_394_1.time_ < var_397_21 + var_397_22 + arg_397_0 and not isNil(var_397_20) and arg_394_1.var_.characterEffect1070ui_story then
				local var_397_25 = 0.5

				arg_394_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1070ui_story.fillRatio = var_397_25
			end

			local var_397_26 = 0
			local var_397_27 = 0.85

			if var_397_26 < arg_394_1.time_ and arg_394_1.time_ <= var_397_26 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_28 = arg_394_1:GetWordFromCfg(324081096)
				local var_397_29 = arg_394_1:FormatText(var_397_28.content)

				arg_394_1.text_.text = var_397_29

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_30 = 34
				local var_397_31 = utf8.len(var_397_29)
				local var_397_32 = var_397_30 <= 0 and var_397_27 or var_397_27 * (var_397_31 / var_397_30)

				if var_397_32 > 0 and var_397_27 < var_397_32 then
					arg_394_1.talkMaxDuration = var_397_32

					if var_397_32 + var_397_26 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_32 + var_397_26
					end
				end

				arg_394_1.text_.text = var_397_29
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_33 = math.max(var_397_27, arg_394_1.talkMaxDuration)

			if var_397_26 <= arg_394_1.time_ and arg_394_1.time_ < var_397_26 + var_397_33 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_26) / var_397_33

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_26 + var_397_33 and arg_394_1.time_ < var_397_26 + var_397_33 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play324081097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 324081097
		arg_398_1.duration_ = 4.23

		local var_398_0 = {
			zh = 2.566,
			ja = 4.233
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play324081098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1070ui_story"].transform
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 then
				arg_398_1.var_.moveOldPos1070ui_story = var_401_0.localPosition
			end

			local var_401_2 = 0.001

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2
				local var_401_4 = Vector3.New(0.7, -0.95, -6.05)

				var_401_0.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1070ui_story, var_401_4, var_401_3)

				local var_401_5 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_5.x, var_401_5.y, var_401_5.z)

				local var_401_6 = var_401_0.localEulerAngles

				var_401_6.z = 0
				var_401_6.x = 0
				var_401_0.localEulerAngles = var_401_6
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 then
				var_401_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_401_7 = manager.ui.mainCamera.transform.position - var_401_0.position

				var_401_0.forward = Vector3.New(var_401_7.x, var_401_7.y, var_401_7.z)

				local var_401_8 = var_401_0.localEulerAngles

				var_401_8.z = 0
				var_401_8.x = 0
				var_401_0.localEulerAngles = var_401_8
			end

			local var_401_9 = arg_398_1.actors_["1070ui_story"]
			local var_401_10 = 0

			if var_401_10 < arg_398_1.time_ and arg_398_1.time_ <= var_401_10 + arg_401_0 and not isNil(var_401_9) and arg_398_1.var_.characterEffect1070ui_story == nil then
				arg_398_1.var_.characterEffect1070ui_story = var_401_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_11 = 0.200000002980232

			if var_401_10 <= arg_398_1.time_ and arg_398_1.time_ < var_401_10 + var_401_11 and not isNil(var_401_9) then
				local var_401_12 = (arg_398_1.time_ - var_401_10) / var_401_11

				if arg_398_1.var_.characterEffect1070ui_story and not isNil(var_401_9) then
					arg_398_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= var_401_10 + var_401_11 and arg_398_1.time_ < var_401_10 + var_401_11 + arg_401_0 and not isNil(var_401_9) and arg_398_1.var_.characterEffect1070ui_story then
				arg_398_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_401_13 = 0

			if var_401_13 < arg_398_1.time_ and arg_398_1.time_ <= var_401_13 + arg_401_0 then
				arg_398_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_401_14 = 0

			if var_401_14 < arg_398_1.time_ and arg_398_1.time_ <= var_401_14 + arg_401_0 then
				arg_398_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_401_15 = 0
			local var_401_16 = 0.35

			if var_401_15 < arg_398_1.time_ and arg_398_1.time_ <= var_401_15 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_17 = arg_398_1:FormatText(StoryNameCfg[318].name)

				arg_398_1.leftNameTxt_.text = var_401_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_18 = arg_398_1:GetWordFromCfg(324081097)
				local var_401_19 = arg_398_1:FormatText(var_401_18.content)

				arg_398_1.text_.text = var_401_19

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_20 = 14
				local var_401_21 = utf8.len(var_401_19)
				local var_401_22 = var_401_20 <= 0 and var_401_16 or var_401_16 * (var_401_21 / var_401_20)

				if var_401_22 > 0 and var_401_16 < var_401_22 then
					arg_398_1.talkMaxDuration = var_401_22

					if var_401_22 + var_401_15 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_22 + var_401_15
					end
				end

				arg_398_1.text_.text = var_401_19
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081097", "story_v_out_324081.awb") ~= 0 then
					local var_401_23 = manager.audio:GetVoiceLength("story_v_out_324081", "324081097", "story_v_out_324081.awb") / 1000

					if var_401_23 + var_401_15 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_23 + var_401_15
					end

					if var_401_18.prefab_name ~= "" and arg_398_1.actors_[var_401_18.prefab_name] ~= nil then
						local var_401_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_18.prefab_name].transform, "story_v_out_324081", "324081097", "story_v_out_324081.awb")

						arg_398_1:RecordAudio("324081097", var_401_24)
						arg_398_1:RecordAudio("324081097", var_401_24)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_324081", "324081097", "story_v_out_324081.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_324081", "324081097", "story_v_out_324081.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_25 = math.max(var_401_16, arg_398_1.talkMaxDuration)

			if var_401_15 <= arg_398_1.time_ and arg_398_1.time_ < var_401_15 + var_401_25 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_15) / var_401_25

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_15 + var_401_25 and arg_398_1.time_ < var_401_15 + var_401_25 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
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

		arg_398_1:InitPlayNodeList()
	end,
	Play324081098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 324081098
		arg_402_1.duration_ = 3.07

		local var_402_0 = {
			zh = 2.6,
			ja = 3.066
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play324081099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = arg_402_1.actors_["10171ui_story"].transform
			local var_405_1 = 0

			if var_405_1 < arg_402_1.time_ and arg_402_1.time_ <= var_405_1 + arg_405_0 then
				arg_402_1.var_.moveOldPos10171ui_story = var_405_0.localPosition

				local var_405_2 = GameObjectTools.GetOrAddComponent(var_405_0.gameObject, typeof(DynamicBoneHelper))

				if var_405_2 then
					var_405_2:EnableDynamicBone(false)
				end
			end

			local var_405_3 = 0.001

			if var_405_1 <= arg_402_1.time_ and arg_402_1.time_ < var_405_1 + var_405_3 then
				local var_405_4 = (arg_402_1.time_ - var_405_1) / var_405_3
				local var_405_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_405_0.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos10171ui_story, var_405_5, var_405_4)

				local var_405_6 = manager.ui.mainCamera.transform.position - var_405_0.position

				var_405_0.forward = Vector3.New(var_405_6.x, var_405_6.y, var_405_6.z)

				local var_405_7 = var_405_0.localEulerAngles

				var_405_7.z = 0
				var_405_7.x = 0
				var_405_0.localEulerAngles = var_405_7
			end

			if arg_402_1.time_ >= var_405_1 + var_405_3 and arg_402_1.time_ < var_405_1 + var_405_3 + arg_405_0 then
				var_405_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_405_8 = manager.ui.mainCamera.transform.position - var_405_0.position

				var_405_0.forward = Vector3.New(var_405_8.x, var_405_8.y, var_405_8.z)

				local var_405_9 = var_405_0.localEulerAngles

				var_405_9.z = 0
				var_405_9.x = 0
				var_405_0.localEulerAngles = var_405_9

				local var_405_10 = GameObjectTools.GetOrAddComponent(var_405_0.gameObject, typeof(DynamicBoneHelper))

				if var_405_10 then
					var_405_10:EnableDynamicBone(true)
				end
			end

			local var_405_11 = arg_402_1.actors_["10171ui_story"]
			local var_405_12 = 0

			if var_405_12 < arg_402_1.time_ and arg_402_1.time_ <= var_405_12 + arg_405_0 and not isNil(var_405_11) and arg_402_1.var_.characterEffect10171ui_story == nil then
				arg_402_1.var_.characterEffect10171ui_story = var_405_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_13 = 0.200000002980232

			if var_405_12 <= arg_402_1.time_ and arg_402_1.time_ < var_405_12 + var_405_13 and not isNil(var_405_11) then
				local var_405_14 = (arg_402_1.time_ - var_405_12) / var_405_13

				if arg_402_1.var_.characterEffect10171ui_story and not isNil(var_405_11) then
					arg_402_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= var_405_12 + var_405_13 and arg_402_1.time_ < var_405_12 + var_405_13 + arg_405_0 and not isNil(var_405_11) and arg_402_1.var_.characterEffect10171ui_story then
				arg_402_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_405_15 = arg_402_1.actors_["1070ui_story"]
			local var_405_16 = 0

			if var_405_16 < arg_402_1.time_ and arg_402_1.time_ <= var_405_16 + arg_405_0 and not isNil(var_405_15) and arg_402_1.var_.characterEffect1070ui_story == nil then
				arg_402_1.var_.characterEffect1070ui_story = var_405_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_17 = 0.200000002980232

			if var_405_16 <= arg_402_1.time_ and arg_402_1.time_ < var_405_16 + var_405_17 and not isNil(var_405_15) then
				local var_405_18 = (arg_402_1.time_ - var_405_16) / var_405_17

				if arg_402_1.var_.characterEffect1070ui_story and not isNil(var_405_15) then
					local var_405_19 = Mathf.Lerp(0, 0.5, var_405_18)

					arg_402_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1070ui_story.fillRatio = var_405_19
				end
			end

			if arg_402_1.time_ >= var_405_16 + var_405_17 and arg_402_1.time_ < var_405_16 + var_405_17 + arg_405_0 and not isNil(var_405_15) and arg_402_1.var_.characterEffect1070ui_story then
				local var_405_20 = 0.5

				arg_402_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1070ui_story.fillRatio = var_405_20
			end

			local var_405_21 = 0

			if var_405_21 < arg_402_1.time_ and arg_402_1.time_ <= var_405_21 + arg_405_0 then
				arg_402_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_405_22 = 0

			if var_405_22 < arg_402_1.time_ and arg_402_1.time_ <= var_405_22 + arg_405_0 then
				arg_402_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_405_23 = 0
			local var_405_24 = 0.225

			if var_405_23 < arg_402_1.time_ and arg_402_1.time_ <= var_405_23 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_25 = arg_402_1:FormatText(StoryNameCfg[1451].name)

				arg_402_1.leftNameTxt_.text = var_405_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_26 = arg_402_1:GetWordFromCfg(324081098)
				local var_405_27 = arg_402_1:FormatText(var_405_26.content)

				arg_402_1.text_.text = var_405_27

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_28 = 9
				local var_405_29 = utf8.len(var_405_27)
				local var_405_30 = var_405_28 <= 0 and var_405_24 or var_405_24 * (var_405_29 / var_405_28)

				if var_405_30 > 0 and var_405_24 < var_405_30 then
					arg_402_1.talkMaxDuration = var_405_30

					if var_405_30 + var_405_23 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_30 + var_405_23
					end
				end

				arg_402_1.text_.text = var_405_27
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081098", "story_v_out_324081.awb") ~= 0 then
					local var_405_31 = manager.audio:GetVoiceLength("story_v_out_324081", "324081098", "story_v_out_324081.awb") / 1000

					if var_405_31 + var_405_23 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_31 + var_405_23
					end

					if var_405_26.prefab_name ~= "" and arg_402_1.actors_[var_405_26.prefab_name] ~= nil then
						local var_405_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_26.prefab_name].transform, "story_v_out_324081", "324081098", "story_v_out_324081.awb")

						arg_402_1:RecordAudio("324081098", var_405_32)
						arg_402_1:RecordAudio("324081098", var_405_32)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_324081", "324081098", "story_v_out_324081.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_324081", "324081098", "story_v_out_324081.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_33 = math.max(var_405_24, arg_402_1.talkMaxDuration)

			if var_405_23 <= arg_402_1.time_ and arg_402_1.time_ < var_405_23 + var_405_33 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_23) / var_405_33

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_23 + var_405_33 and arg_402_1.time_ < var_405_23 + var_405_33 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play324081099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 324081099
		arg_406_1.duration_ = 5.1

		local var_406_0 = {
			zh = 3.266,
			ja = 5.1
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play324081100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = arg_406_1.actors_["1070ui_story"]
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1070ui_story == nil then
				arg_406_1.var_.characterEffect1070ui_story = var_409_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.200000002980232

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 and not isNil(var_409_0) then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / var_409_2

				if arg_406_1.var_.characterEffect1070ui_story and not isNil(var_409_0) then
					arg_406_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 and not isNil(var_409_0) and arg_406_1.var_.characterEffect1070ui_story then
				arg_406_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_409_4 = arg_406_1.actors_["10171ui_story"]
			local var_409_5 = 0

			if var_409_5 < arg_406_1.time_ and arg_406_1.time_ <= var_409_5 + arg_409_0 and not isNil(var_409_4) and arg_406_1.var_.characterEffect10171ui_story == nil then
				arg_406_1.var_.characterEffect10171ui_story = var_409_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_6 = 0.200000002980232

			if var_409_5 <= arg_406_1.time_ and arg_406_1.time_ < var_409_5 + var_409_6 and not isNil(var_409_4) then
				local var_409_7 = (arg_406_1.time_ - var_409_5) / var_409_6

				if arg_406_1.var_.characterEffect10171ui_story and not isNil(var_409_4) then
					local var_409_8 = Mathf.Lerp(0, 0.5, var_409_7)

					arg_406_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_406_1.var_.characterEffect10171ui_story.fillRatio = var_409_8
				end
			end

			if arg_406_1.time_ >= var_409_5 + var_409_6 and arg_406_1.time_ < var_409_5 + var_409_6 + arg_409_0 and not isNil(var_409_4) and arg_406_1.var_.characterEffect10171ui_story then
				local var_409_9 = 0.5

				arg_406_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_406_1.var_.characterEffect10171ui_story.fillRatio = var_409_9
			end

			local var_409_10 = 0
			local var_409_11 = 0.375

			if var_409_10 < arg_406_1.time_ and arg_406_1.time_ <= var_409_10 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_12 = arg_406_1:FormatText(StoryNameCfg[318].name)

				arg_406_1.leftNameTxt_.text = var_409_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_13 = arg_406_1:GetWordFromCfg(324081099)
				local var_409_14 = arg_406_1:FormatText(var_409_13.content)

				arg_406_1.text_.text = var_409_14

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_15 = 15
				local var_409_16 = utf8.len(var_409_14)
				local var_409_17 = var_409_15 <= 0 and var_409_11 or var_409_11 * (var_409_16 / var_409_15)

				if var_409_17 > 0 and var_409_11 < var_409_17 then
					arg_406_1.talkMaxDuration = var_409_17

					if var_409_17 + var_409_10 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_17 + var_409_10
					end
				end

				arg_406_1.text_.text = var_409_14
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081099", "story_v_out_324081.awb") ~= 0 then
					local var_409_18 = manager.audio:GetVoiceLength("story_v_out_324081", "324081099", "story_v_out_324081.awb") / 1000

					if var_409_18 + var_409_10 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_18 + var_409_10
					end

					if var_409_13.prefab_name ~= "" and arg_406_1.actors_[var_409_13.prefab_name] ~= nil then
						local var_409_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_13.prefab_name].transform, "story_v_out_324081", "324081099", "story_v_out_324081.awb")

						arg_406_1:RecordAudio("324081099", var_409_19)
						arg_406_1:RecordAudio("324081099", var_409_19)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_324081", "324081099", "story_v_out_324081.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_324081", "324081099", "story_v_out_324081.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_20 = math.max(var_409_11, arg_406_1.talkMaxDuration)

			if var_409_10 <= arg_406_1.time_ and arg_406_1.time_ < var_409_10 + var_409_20 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_10) / var_409_20

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_10 + var_409_20 and arg_406_1.time_ < var_409_10 + var_409_20 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play324081100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 324081100
		arg_410_1.duration_ = 6.8

		local var_410_0 = {
			zh = 6,
			ja = 6.8
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play324081101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			local var_413_1 = 0
			local var_413_2 = 0.65

			if var_413_1 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_3 = arg_410_1:FormatText(StoryNameCfg[318].name)

				arg_410_1.leftNameTxt_.text = var_413_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_4 = arg_410_1:GetWordFromCfg(324081100)
				local var_413_5 = arg_410_1:FormatText(var_413_4.content)

				arg_410_1.text_.text = var_413_5

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_6 = 26
				local var_413_7 = utf8.len(var_413_5)
				local var_413_8 = var_413_6 <= 0 and var_413_2 or var_413_2 * (var_413_7 / var_413_6)

				if var_413_8 > 0 and var_413_2 < var_413_8 then
					arg_410_1.talkMaxDuration = var_413_8

					if var_413_8 + var_413_1 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_1
					end
				end

				arg_410_1.text_.text = var_413_5
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081100", "story_v_out_324081.awb") ~= 0 then
					local var_413_9 = manager.audio:GetVoiceLength("story_v_out_324081", "324081100", "story_v_out_324081.awb") / 1000

					if var_413_9 + var_413_1 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_9 + var_413_1
					end

					if var_413_4.prefab_name ~= "" and arg_410_1.actors_[var_413_4.prefab_name] ~= nil then
						local var_413_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_4.prefab_name].transform, "story_v_out_324081", "324081100", "story_v_out_324081.awb")

						arg_410_1:RecordAudio("324081100", var_413_10)
						arg_410_1:RecordAudio("324081100", var_413_10)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_324081", "324081100", "story_v_out_324081.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_324081", "324081100", "story_v_out_324081.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_11 = math.max(var_413_2, arg_410_1.talkMaxDuration)

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_11 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_1) / var_413_11

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_1 + var_413_11 and arg_410_1.time_ < var_413_1 + var_413_11 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play324081101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 324081101
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play324081102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = arg_414_1.actors_["1070ui_story"].transform
			local var_417_1 = 0

			if var_417_1 < arg_414_1.time_ and arg_414_1.time_ <= var_417_1 + arg_417_0 then
				arg_414_1.var_.moveOldPos1070ui_story = var_417_0.localPosition
			end

			local var_417_2 = 0.001

			if var_417_1 <= arg_414_1.time_ and arg_414_1.time_ < var_417_1 + var_417_2 then
				local var_417_3 = (arg_414_1.time_ - var_417_1) / var_417_2
				local var_417_4 = Vector3.New(0, 100, 0)

				var_417_0.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1070ui_story, var_417_4, var_417_3)

				local var_417_5 = manager.ui.mainCamera.transform.position - var_417_0.position

				var_417_0.forward = Vector3.New(var_417_5.x, var_417_5.y, var_417_5.z)

				local var_417_6 = var_417_0.localEulerAngles

				var_417_6.z = 0
				var_417_6.x = 0
				var_417_0.localEulerAngles = var_417_6
			end

			if arg_414_1.time_ >= var_417_1 + var_417_2 and arg_414_1.time_ < var_417_1 + var_417_2 + arg_417_0 then
				var_417_0.localPosition = Vector3.New(0, 100, 0)

				local var_417_7 = manager.ui.mainCamera.transform.position - var_417_0.position

				var_417_0.forward = Vector3.New(var_417_7.x, var_417_7.y, var_417_7.z)

				local var_417_8 = var_417_0.localEulerAngles

				var_417_8.z = 0
				var_417_8.x = 0
				var_417_0.localEulerAngles = var_417_8
			end

			local var_417_9 = arg_414_1.actors_["10171ui_story"].transform
			local var_417_10 = 0

			if var_417_10 < arg_414_1.time_ and arg_414_1.time_ <= var_417_10 + arg_417_0 then
				arg_414_1.var_.moveOldPos10171ui_story = var_417_9.localPosition

				local var_417_11 = GameObjectTools.GetOrAddComponent(var_417_9.gameObject, typeof(DynamicBoneHelper))

				if var_417_11 then
					var_417_11:EnableDynamicBone(false)
				end
			end

			local var_417_12 = 0.001

			if var_417_10 <= arg_414_1.time_ and arg_414_1.time_ < var_417_10 + var_417_12 then
				local var_417_13 = (arg_414_1.time_ - var_417_10) / var_417_12
				local var_417_14 = Vector3.New(0, 100, 0)

				var_417_9.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos10171ui_story, var_417_14, var_417_13)

				local var_417_15 = manager.ui.mainCamera.transform.position - var_417_9.position

				var_417_9.forward = Vector3.New(var_417_15.x, var_417_15.y, var_417_15.z)

				local var_417_16 = var_417_9.localEulerAngles

				var_417_16.z = 0
				var_417_16.x = 0
				var_417_9.localEulerAngles = var_417_16
			end

			if arg_414_1.time_ >= var_417_10 + var_417_12 and arg_414_1.time_ < var_417_10 + var_417_12 + arg_417_0 then
				var_417_9.localPosition = Vector3.New(0, 100, 0)

				local var_417_17 = manager.ui.mainCamera.transform.position - var_417_9.position

				var_417_9.forward = Vector3.New(var_417_17.x, var_417_17.y, var_417_17.z)

				local var_417_18 = var_417_9.localEulerAngles

				var_417_18.z = 0
				var_417_18.x = 0
				var_417_9.localEulerAngles = var_417_18

				local var_417_19 = GameObjectTools.GetOrAddComponent(var_417_9.gameObject, typeof(DynamicBoneHelper))

				if var_417_19 then
					var_417_19:EnableDynamicBone(true)
				end
			end

			local var_417_20 = arg_414_1.actors_["1070ui_story"]
			local var_417_21 = 0

			if var_417_21 < arg_414_1.time_ and arg_414_1.time_ <= var_417_21 + arg_417_0 and not isNil(var_417_20) and arg_414_1.var_.characterEffect1070ui_story == nil then
				arg_414_1.var_.characterEffect1070ui_story = var_417_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_22 = 0.200000002980232

			if var_417_21 <= arg_414_1.time_ and arg_414_1.time_ < var_417_21 + var_417_22 and not isNil(var_417_20) then
				local var_417_23 = (arg_414_1.time_ - var_417_21) / var_417_22

				if arg_414_1.var_.characterEffect1070ui_story and not isNil(var_417_20) then
					local var_417_24 = Mathf.Lerp(0, 0.5, var_417_23)

					arg_414_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1070ui_story.fillRatio = var_417_24
				end
			end

			if arg_414_1.time_ >= var_417_21 + var_417_22 and arg_414_1.time_ < var_417_21 + var_417_22 + arg_417_0 and not isNil(var_417_20) and arg_414_1.var_.characterEffect1070ui_story then
				local var_417_25 = 0.5

				arg_414_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1070ui_story.fillRatio = var_417_25
			end

			local var_417_26 = 0
			local var_417_27 = 0.875

			if var_417_26 < arg_414_1.time_ and arg_414_1.time_ <= var_417_26 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_28 = arg_414_1:GetWordFromCfg(324081101)
				local var_417_29 = arg_414_1:FormatText(var_417_28.content)

				arg_414_1.text_.text = var_417_29

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_30 = 35
				local var_417_31 = utf8.len(var_417_29)
				local var_417_32 = var_417_30 <= 0 and var_417_27 or var_417_27 * (var_417_31 / var_417_30)

				if var_417_32 > 0 and var_417_27 < var_417_32 then
					arg_414_1.talkMaxDuration = var_417_32

					if var_417_32 + var_417_26 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_32 + var_417_26
					end
				end

				arg_414_1.text_.text = var_417_29
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_33 = math.max(var_417_27, arg_414_1.talkMaxDuration)

			if var_417_26 <= arg_414_1.time_ and arg_414_1.time_ < var_417_26 + var_417_33 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_26) / var_417_33

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_26 + var_417_33 and arg_414_1.time_ < var_417_26 + var_417_33 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play324081102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 324081102
		arg_418_1.duration_ = 8.67

		local var_418_0 = {
			zh = 8.066,
			ja = 8.666
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play324081103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = arg_418_1.actors_["1070ui_story"].transform
			local var_421_1 = 0

			if var_421_1 < arg_418_1.time_ and arg_418_1.time_ <= var_421_1 + arg_421_0 then
				arg_418_1.var_.moveOldPos1070ui_story = var_421_0.localPosition
			end

			local var_421_2 = 0.001

			if var_421_1 <= arg_418_1.time_ and arg_418_1.time_ < var_421_1 + var_421_2 then
				local var_421_3 = (arg_418_1.time_ - var_421_1) / var_421_2
				local var_421_4 = Vector3.New(0, -0.95, -6.05)

				var_421_0.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1070ui_story, var_421_4, var_421_3)

				local var_421_5 = manager.ui.mainCamera.transform.position - var_421_0.position

				var_421_0.forward = Vector3.New(var_421_5.x, var_421_5.y, var_421_5.z)

				local var_421_6 = var_421_0.localEulerAngles

				var_421_6.z = 0
				var_421_6.x = 0
				var_421_0.localEulerAngles = var_421_6
			end

			if arg_418_1.time_ >= var_421_1 + var_421_2 and arg_418_1.time_ < var_421_1 + var_421_2 + arg_421_0 then
				var_421_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_421_7 = manager.ui.mainCamera.transform.position - var_421_0.position

				var_421_0.forward = Vector3.New(var_421_7.x, var_421_7.y, var_421_7.z)

				local var_421_8 = var_421_0.localEulerAngles

				var_421_8.z = 0
				var_421_8.x = 0
				var_421_0.localEulerAngles = var_421_8
			end

			local var_421_9 = arg_418_1.actors_["1070ui_story"]
			local var_421_10 = 0

			if var_421_10 < arg_418_1.time_ and arg_418_1.time_ <= var_421_10 + arg_421_0 and not isNil(var_421_9) and arg_418_1.var_.characterEffect1070ui_story == nil then
				arg_418_1.var_.characterEffect1070ui_story = var_421_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_11 = 0.200000002980232

			if var_421_10 <= arg_418_1.time_ and arg_418_1.time_ < var_421_10 + var_421_11 and not isNil(var_421_9) then
				local var_421_12 = (arg_418_1.time_ - var_421_10) / var_421_11

				if arg_418_1.var_.characterEffect1070ui_story and not isNil(var_421_9) then
					arg_418_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= var_421_10 + var_421_11 and arg_418_1.time_ < var_421_10 + var_421_11 + arg_421_0 and not isNil(var_421_9) and arg_418_1.var_.characterEffect1070ui_story then
				arg_418_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_421_13 = 0

			if var_421_13 < arg_418_1.time_ and arg_418_1.time_ <= var_421_13 + arg_421_0 then
				arg_418_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_2")
			end

			local var_421_14 = 0

			if var_421_14 < arg_418_1.time_ and arg_418_1.time_ <= var_421_14 + arg_421_0 then
				arg_418_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_421_15 = 0
			local var_421_16 = 1

			if var_421_15 < arg_418_1.time_ and arg_418_1.time_ <= var_421_15 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_17 = arg_418_1:FormatText(StoryNameCfg[318].name)

				arg_418_1.leftNameTxt_.text = var_421_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_18 = arg_418_1:GetWordFromCfg(324081102)
				local var_421_19 = arg_418_1:FormatText(var_421_18.content)

				arg_418_1.text_.text = var_421_19

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_20 = 40
				local var_421_21 = utf8.len(var_421_19)
				local var_421_22 = var_421_20 <= 0 and var_421_16 or var_421_16 * (var_421_21 / var_421_20)

				if var_421_22 > 0 and var_421_16 < var_421_22 then
					arg_418_1.talkMaxDuration = var_421_22

					if var_421_22 + var_421_15 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_22 + var_421_15
					end
				end

				arg_418_1.text_.text = var_421_19
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081102", "story_v_out_324081.awb") ~= 0 then
					local var_421_23 = manager.audio:GetVoiceLength("story_v_out_324081", "324081102", "story_v_out_324081.awb") / 1000

					if var_421_23 + var_421_15 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_23 + var_421_15
					end

					if var_421_18.prefab_name ~= "" and arg_418_1.actors_[var_421_18.prefab_name] ~= nil then
						local var_421_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_18.prefab_name].transform, "story_v_out_324081", "324081102", "story_v_out_324081.awb")

						arg_418_1:RecordAudio("324081102", var_421_24)
						arg_418_1:RecordAudio("324081102", var_421_24)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_324081", "324081102", "story_v_out_324081.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_324081", "324081102", "story_v_out_324081.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_25 = math.max(var_421_16, arg_418_1.talkMaxDuration)

			if var_421_15 <= arg_418_1.time_ and arg_418_1.time_ < var_421_15 + var_421_25 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_15) / var_421_25

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_15 + var_421_25 and arg_418_1.time_ < var_421_15 + var_421_25 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
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

		arg_418_1:InitPlayNodeList()
	end,
	Play324081103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 324081103
		arg_422_1.duration_ = 2.63

		local var_422_0 = {
			zh = 2.366,
			ja = 2.633
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play324081104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = arg_422_1.actors_["1070ui_story"]
			local var_425_1 = 0

			if var_425_1 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect1070ui_story == nil then
				arg_422_1.var_.characterEffect1070ui_story = var_425_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_2 = 0.200000002980232

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_2 and not isNil(var_425_0) then
				local var_425_3 = (arg_422_1.time_ - var_425_1) / var_425_2

				if arg_422_1.var_.characterEffect1070ui_story and not isNil(var_425_0) then
					local var_425_4 = Mathf.Lerp(0, 0.5, var_425_3)

					arg_422_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_422_1.var_.characterEffect1070ui_story.fillRatio = var_425_4
				end
			end

			if arg_422_1.time_ >= var_425_1 + var_425_2 and arg_422_1.time_ < var_425_1 + var_425_2 + arg_425_0 and not isNil(var_425_0) and arg_422_1.var_.characterEffect1070ui_story then
				local var_425_5 = 0.5

				arg_422_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_422_1.var_.characterEffect1070ui_story.fillRatio = var_425_5
			end

			local var_425_6 = 0
			local var_425_7 = 0.225

			if var_425_6 < arg_422_1.time_ and arg_422_1.time_ <= var_425_6 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_8 = arg_422_1:FormatText(StoryNameCfg[1501].name)

				arg_422_1.leftNameTxt_.text = var_425_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_9 = arg_422_1:GetWordFromCfg(324081103)
				local var_425_10 = arg_422_1:FormatText(var_425_9.content)

				arg_422_1.text_.text = var_425_10

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_11 = 9
				local var_425_12 = utf8.len(var_425_10)
				local var_425_13 = var_425_11 <= 0 and var_425_7 or var_425_7 * (var_425_12 / var_425_11)

				if var_425_13 > 0 and var_425_7 < var_425_13 then
					arg_422_1.talkMaxDuration = var_425_13

					if var_425_13 + var_425_6 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_13 + var_425_6
					end
				end

				arg_422_1.text_.text = var_425_10
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081103", "story_v_out_324081.awb") ~= 0 then
					local var_425_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081103", "story_v_out_324081.awb") / 1000

					if var_425_14 + var_425_6 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_14 + var_425_6
					end

					if var_425_9.prefab_name ~= "" and arg_422_1.actors_[var_425_9.prefab_name] ~= nil then
						local var_425_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_9.prefab_name].transform, "story_v_out_324081", "324081103", "story_v_out_324081.awb")

						arg_422_1:RecordAudio("324081103", var_425_15)
						arg_422_1:RecordAudio("324081103", var_425_15)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_324081", "324081103", "story_v_out_324081.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_324081", "324081103", "story_v_out_324081.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_16 = math.max(var_425_7, arg_422_1.talkMaxDuration)

			if var_425_6 <= arg_422_1.time_ and arg_422_1.time_ < var_425_6 + var_425_16 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_6) / var_425_16

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_6 + var_425_16 and arg_422_1.time_ < var_425_6 + var_425_16 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play324081104 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 324081104
		arg_426_1.duration_ = 2.2

		local var_426_0 = {
			zh = 1.966,
			ja = 2.2
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play324081105(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = arg_426_1.actors_["1070ui_story"]
			local var_429_1 = 0

			if var_429_1 < arg_426_1.time_ and arg_426_1.time_ <= var_429_1 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.characterEffect1070ui_story == nil then
				arg_426_1.var_.characterEffect1070ui_story = var_429_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_2 = 0.200000002980232

			if var_429_1 <= arg_426_1.time_ and arg_426_1.time_ < var_429_1 + var_429_2 and not isNil(var_429_0) then
				local var_429_3 = (arg_426_1.time_ - var_429_1) / var_429_2

				if arg_426_1.var_.characterEffect1070ui_story and not isNil(var_429_0) then
					arg_426_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= var_429_1 + var_429_2 and arg_426_1.time_ < var_429_1 + var_429_2 + arg_429_0 and not isNil(var_429_0) and arg_426_1.var_.characterEffect1070ui_story then
				arg_426_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_429_4 = 0
			local var_429_5 = 0.125

			if var_429_4 < arg_426_1.time_ and arg_426_1.time_ <= var_429_4 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_6 = arg_426_1:FormatText(StoryNameCfg[318].name)

				arg_426_1.leftNameTxt_.text = var_429_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_7 = arg_426_1:GetWordFromCfg(324081104)
				local var_429_8 = arg_426_1:FormatText(var_429_7.content)

				arg_426_1.text_.text = var_429_8

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_9 = 5
				local var_429_10 = utf8.len(var_429_8)
				local var_429_11 = var_429_9 <= 0 and var_429_5 or var_429_5 * (var_429_10 / var_429_9)

				if var_429_11 > 0 and var_429_5 < var_429_11 then
					arg_426_1.talkMaxDuration = var_429_11

					if var_429_11 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_11 + var_429_4
					end
				end

				arg_426_1.text_.text = var_429_8
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081104", "story_v_out_324081.awb") ~= 0 then
					local var_429_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081104", "story_v_out_324081.awb") / 1000

					if var_429_12 + var_429_4 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_12 + var_429_4
					end

					if var_429_7.prefab_name ~= "" and arg_426_1.actors_[var_429_7.prefab_name] ~= nil then
						local var_429_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_7.prefab_name].transform, "story_v_out_324081", "324081104", "story_v_out_324081.awb")

						arg_426_1:RecordAudio("324081104", var_429_13)
						arg_426_1:RecordAudio("324081104", var_429_13)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_324081", "324081104", "story_v_out_324081.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_324081", "324081104", "story_v_out_324081.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_14 = math.max(var_429_5, arg_426_1.talkMaxDuration)

			if var_429_4 <= arg_426_1.time_ and arg_426_1.time_ < var_429_4 + var_429_14 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_4) / var_429_14

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_4 + var_429_14 and arg_426_1.time_ < var_429_4 + var_429_14 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play324081105 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 324081105
		arg_430_1.duration_ = 5.9

		local var_430_0 = {
			zh = 4.533,
			ja = 5.9
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play324081106(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["1070ui_story"]
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1070ui_story == nil then
				arg_430_1.var_.characterEffect1070ui_story = var_433_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_2 = 0.200000002980232

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 and not isNil(var_433_0) then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2

				if arg_430_1.var_.characterEffect1070ui_story and not isNil(var_433_0) then
					local var_433_4 = Mathf.Lerp(0, 0.5, var_433_3)

					arg_430_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_430_1.var_.characterEffect1070ui_story.fillRatio = var_433_4
				end
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 and not isNil(var_433_0) and arg_430_1.var_.characterEffect1070ui_story then
				local var_433_5 = 0.5

				arg_430_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_430_1.var_.characterEffect1070ui_story.fillRatio = var_433_5
			end

			local var_433_6 = 0
			local var_433_7 = 0.55

			if var_433_6 < arg_430_1.time_ and arg_430_1.time_ <= var_433_6 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_8 = arg_430_1:FormatText(StoryNameCfg[1501].name)

				arg_430_1.leftNameTxt_.text = var_433_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_9 = arg_430_1:GetWordFromCfg(324081105)
				local var_433_10 = arg_430_1:FormatText(var_433_9.content)

				arg_430_1.text_.text = var_433_10

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_11 = 22
				local var_433_12 = utf8.len(var_433_10)
				local var_433_13 = var_433_11 <= 0 and var_433_7 or var_433_7 * (var_433_12 / var_433_11)

				if var_433_13 > 0 and var_433_7 < var_433_13 then
					arg_430_1.talkMaxDuration = var_433_13

					if var_433_13 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_13 + var_433_6
					end
				end

				arg_430_1.text_.text = var_433_10
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081105", "story_v_out_324081.awb") ~= 0 then
					local var_433_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081105", "story_v_out_324081.awb") / 1000

					if var_433_14 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_14 + var_433_6
					end

					if var_433_9.prefab_name ~= "" and arg_430_1.actors_[var_433_9.prefab_name] ~= nil then
						local var_433_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_9.prefab_name].transform, "story_v_out_324081", "324081105", "story_v_out_324081.awb")

						arg_430_1:RecordAudio("324081105", var_433_15)
						arg_430_1:RecordAudio("324081105", var_433_15)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_324081", "324081105", "story_v_out_324081.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_324081", "324081105", "story_v_out_324081.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_16 = math.max(var_433_7, arg_430_1.talkMaxDuration)

			if var_433_6 <= arg_430_1.time_ and arg_430_1.time_ < var_433_6 + var_433_16 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_6) / var_433_16

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_6 + var_433_16 and arg_430_1.time_ < var_433_6 + var_433_16 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play324081106 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 324081106
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play324081107(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["1070ui_story"].transform
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.var_.moveOldPos1070ui_story = var_437_0.localPosition
			end

			local var_437_2 = 0.001

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2
				local var_437_4 = Vector3.New(0, 100, 0)

				var_437_0.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1070ui_story, var_437_4, var_437_3)

				local var_437_5 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_5.x, var_437_5.y, var_437_5.z)

				local var_437_6 = var_437_0.localEulerAngles

				var_437_6.z = 0
				var_437_6.x = 0
				var_437_0.localEulerAngles = var_437_6
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 then
				var_437_0.localPosition = Vector3.New(0, 100, 0)

				local var_437_7 = manager.ui.mainCamera.transform.position - var_437_0.position

				var_437_0.forward = Vector3.New(var_437_7.x, var_437_7.y, var_437_7.z)

				local var_437_8 = var_437_0.localEulerAngles

				var_437_8.z = 0
				var_437_8.x = 0
				var_437_0.localEulerAngles = var_437_8
			end

			local var_437_9 = 0
			local var_437_10 = 1.1

			if var_437_9 < arg_434_1.time_ and arg_434_1.time_ <= var_437_9 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_11 = arg_434_1:GetWordFromCfg(324081106)
				local var_437_12 = arg_434_1:FormatText(var_437_11.content)

				arg_434_1.text_.text = var_437_12

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_13 = 44
				local var_437_14 = utf8.len(var_437_12)
				local var_437_15 = var_437_13 <= 0 and var_437_10 or var_437_10 * (var_437_14 / var_437_13)

				if var_437_15 > 0 and var_437_10 < var_437_15 then
					arg_434_1.talkMaxDuration = var_437_15

					if var_437_15 + var_437_9 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_15 + var_437_9
					end
				end

				arg_434_1.text_.text = var_437_12
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_16 = math.max(var_437_10, arg_434_1.talkMaxDuration)

			if var_437_9 <= arg_434_1.time_ and arg_434_1.time_ < var_437_9 + var_437_16 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_9) / var_437_16

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_9 + var_437_16 and arg_434_1.time_ < var_437_9 + var_437_16 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
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

		arg_434_1:InitPlayNodeList()
	end,
	Play324081107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 324081107
		arg_438_1.duration_ = 9.63

		local var_438_0 = {
			zh = 8.133,
			ja = 9.633
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
				arg_438_0:Play324081108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0
			local var_441_1 = 0.975

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_2 = arg_438_1:FormatText(StoryNameCfg[1468].name)

				arg_438_1.leftNameTxt_.text = var_441_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_3 = arg_438_1:GetWordFromCfg(324081107)
				local var_441_4 = arg_438_1:FormatText(var_441_3.content)

				arg_438_1.text_.text = var_441_4

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_5 = 39
				local var_441_6 = utf8.len(var_441_4)
				local var_441_7 = var_441_5 <= 0 and var_441_1 or var_441_1 * (var_441_6 / var_441_5)

				if var_441_7 > 0 and var_441_1 < var_441_7 then
					arg_438_1.talkMaxDuration = var_441_7

					if var_441_7 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_7 + var_441_0
					end
				end

				arg_438_1.text_.text = var_441_4
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081107", "story_v_out_324081.awb") ~= 0 then
					local var_441_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081107", "story_v_out_324081.awb") / 1000

					if var_441_8 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_8 + var_441_0
					end

					if var_441_3.prefab_name ~= "" and arg_438_1.actors_[var_441_3.prefab_name] ~= nil then
						local var_441_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_3.prefab_name].transform, "story_v_out_324081", "324081107", "story_v_out_324081.awb")

						arg_438_1:RecordAudio("324081107", var_441_9)
						arg_438_1:RecordAudio("324081107", var_441_9)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_324081", "324081107", "story_v_out_324081.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_324081", "324081107", "story_v_out_324081.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_10 = math.max(var_441_1, arg_438_1.talkMaxDuration)

			if var_441_0 <= arg_438_1.time_ and arg_438_1.time_ < var_441_0 + var_441_10 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_0) / var_441_10

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_0 + var_441_10 and arg_438_1.time_ < var_441_0 + var_441_10 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play324081108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 324081108
		arg_442_1.duration_ = 2.53

		local var_442_0 = {
			zh = 2.3,
			ja = 2.533
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
				arg_442_0:Play324081109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0
			local var_445_1 = 0.175

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_2 = arg_442_1:FormatText(StoryNameCfg[1501].name)

				arg_442_1.leftNameTxt_.text = var_445_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_3 = arg_442_1:GetWordFromCfg(324081108)
				local var_445_4 = arg_442_1:FormatText(var_445_3.content)

				arg_442_1.text_.text = var_445_4

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_5 = 7
				local var_445_6 = utf8.len(var_445_4)
				local var_445_7 = var_445_5 <= 0 and var_445_1 or var_445_1 * (var_445_6 / var_445_5)

				if var_445_7 > 0 and var_445_1 < var_445_7 then
					arg_442_1.talkMaxDuration = var_445_7

					if var_445_7 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_7 + var_445_0
					end
				end

				arg_442_1.text_.text = var_445_4
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081108", "story_v_out_324081.awb") ~= 0 then
					local var_445_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081108", "story_v_out_324081.awb") / 1000

					if var_445_8 + var_445_0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_8 + var_445_0
					end

					if var_445_3.prefab_name ~= "" and arg_442_1.actors_[var_445_3.prefab_name] ~= nil then
						local var_445_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_3.prefab_name].transform, "story_v_out_324081", "324081108", "story_v_out_324081.awb")

						arg_442_1:RecordAudio("324081108", var_445_9)
						arg_442_1:RecordAudio("324081108", var_445_9)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_324081", "324081108", "story_v_out_324081.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_324081", "324081108", "story_v_out_324081.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_10 = math.max(var_445_1, arg_442_1.talkMaxDuration)

			if var_445_0 <= arg_442_1.time_ and arg_442_1.time_ < var_445_0 + var_445_10 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_0) / var_445_10

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_0 + var_445_10 and arg_442_1.time_ < var_445_0 + var_445_10 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play324081109 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 324081109
		arg_446_1.duration_ = 3.73

		local var_446_0 = {
			zh = 3.533,
			ja = 3.733
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play324081110(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0
			local var_449_1 = 0.35

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_2 = arg_446_1:FormatText(StoryNameCfg[1468].name)

				arg_446_1.leftNameTxt_.text = var_449_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_3 = arg_446_1:GetWordFromCfg(324081109)
				local var_449_4 = arg_446_1:FormatText(var_449_3.content)

				arg_446_1.text_.text = var_449_4

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_5 = 14
				local var_449_6 = utf8.len(var_449_4)
				local var_449_7 = var_449_5 <= 0 and var_449_1 or var_449_1 * (var_449_6 / var_449_5)

				if var_449_7 > 0 and var_449_1 < var_449_7 then
					arg_446_1.talkMaxDuration = var_449_7

					if var_449_7 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_7 + var_449_0
					end
				end

				arg_446_1.text_.text = var_449_4
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081109", "story_v_out_324081.awb") ~= 0 then
					local var_449_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081109", "story_v_out_324081.awb") / 1000

					if var_449_8 + var_449_0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_8 + var_449_0
					end

					if var_449_3.prefab_name ~= "" and arg_446_1.actors_[var_449_3.prefab_name] ~= nil then
						local var_449_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_3.prefab_name].transform, "story_v_out_324081", "324081109", "story_v_out_324081.awb")

						arg_446_1:RecordAudio("324081109", var_449_9)
						arg_446_1:RecordAudio("324081109", var_449_9)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_324081", "324081109", "story_v_out_324081.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_324081", "324081109", "story_v_out_324081.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_10 = math.max(var_449_1, arg_446_1.talkMaxDuration)

			if var_449_0 <= arg_446_1.time_ and arg_446_1.time_ < var_449_0 + var_449_10 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_0) / var_449_10

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_0 + var_449_10 and arg_446_1.time_ < var_449_0 + var_449_10 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play324081110 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 324081110
		arg_450_1.duration_ = 6.73

		local var_450_0 = {
			zh = 4.366,
			ja = 6.733
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play324081111(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0
			local var_453_1 = 0.575

			if var_453_0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_2 = arg_450_1:FormatText(StoryNameCfg[1501].name)

				arg_450_1.leftNameTxt_.text = var_453_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_3 = arg_450_1:GetWordFromCfg(324081110)
				local var_453_4 = arg_450_1:FormatText(var_453_3.content)

				arg_450_1.text_.text = var_453_4

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 23
				local var_453_6 = utf8.len(var_453_4)
				local var_453_7 = var_453_5 <= 0 and var_453_1 or var_453_1 * (var_453_6 / var_453_5)

				if var_453_7 > 0 and var_453_1 < var_453_7 then
					arg_450_1.talkMaxDuration = var_453_7

					if var_453_7 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_7 + var_453_0
					end
				end

				arg_450_1.text_.text = var_453_4
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081110", "story_v_out_324081.awb") ~= 0 then
					local var_453_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081110", "story_v_out_324081.awb") / 1000

					if var_453_8 + var_453_0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_8 + var_453_0
					end

					if var_453_3.prefab_name ~= "" and arg_450_1.actors_[var_453_3.prefab_name] ~= nil then
						local var_453_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_3.prefab_name].transform, "story_v_out_324081", "324081110", "story_v_out_324081.awb")

						arg_450_1:RecordAudio("324081110", var_453_9)
						arg_450_1:RecordAudio("324081110", var_453_9)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_324081", "324081110", "story_v_out_324081.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_324081", "324081110", "story_v_out_324081.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_10 = math.max(var_453_1, arg_450_1.talkMaxDuration)

			if var_453_0 <= arg_450_1.time_ and arg_450_1.time_ < var_453_0 + var_453_10 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_0) / var_453_10

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_0 + var_453_10 and arg_450_1.time_ < var_453_0 + var_453_10 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play324081111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 324081111
		arg_454_1.duration_ = 3.73

		local var_454_0 = {
			zh = 1.9,
			ja = 3.733
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play324081112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1070ui_story"]
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1070ui_story == nil then
				arg_454_1.var_.characterEffect1070ui_story = var_457_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_2 = 0.200000002980232

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 and not isNil(var_457_0) then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2

				if arg_454_1.var_.characterEffect1070ui_story and not isNil(var_457_0) then
					arg_454_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1070ui_story then
				arg_454_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_457_4 = 0
			local var_457_5 = 0.25

			if var_457_4 < arg_454_1.time_ and arg_454_1.time_ <= var_457_4 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_6 = arg_454_1:FormatText(StoryNameCfg[318].name)

				arg_454_1.leftNameTxt_.text = var_457_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_7 = arg_454_1:GetWordFromCfg(324081111)
				local var_457_8 = arg_454_1:FormatText(var_457_7.content)

				arg_454_1.text_.text = var_457_8

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_9 = 10
				local var_457_10 = utf8.len(var_457_8)
				local var_457_11 = var_457_9 <= 0 and var_457_5 or var_457_5 * (var_457_10 / var_457_9)

				if var_457_11 > 0 and var_457_5 < var_457_11 then
					arg_454_1.talkMaxDuration = var_457_11

					if var_457_11 + var_457_4 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_11 + var_457_4
					end
				end

				arg_454_1.text_.text = var_457_8
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081111", "story_v_out_324081.awb") ~= 0 then
					local var_457_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081111", "story_v_out_324081.awb") / 1000

					if var_457_12 + var_457_4 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_12 + var_457_4
					end

					if var_457_7.prefab_name ~= "" and arg_454_1.actors_[var_457_7.prefab_name] ~= nil then
						local var_457_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_7.prefab_name].transform, "story_v_out_324081", "324081111", "story_v_out_324081.awb")

						arg_454_1:RecordAudio("324081111", var_457_13)
						arg_454_1:RecordAudio("324081111", var_457_13)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_324081", "324081111", "story_v_out_324081.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_324081", "324081111", "story_v_out_324081.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_14 = math.max(var_457_5, arg_454_1.talkMaxDuration)

			if var_457_4 <= arg_454_1.time_ and arg_454_1.time_ < var_457_4 + var_457_14 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_4) / var_457_14

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_4 + var_457_14 and arg_454_1.time_ < var_457_4 + var_457_14 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play324081112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 324081112
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play324081113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["1070ui_story"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1070ui_story == nil then
				arg_458_1.var_.characterEffect1070ui_story = var_461_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.characterEffect1070ui_story and not isNil(var_461_0) then
					local var_461_4 = Mathf.Lerp(0, 0.5, var_461_3)

					arg_458_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1070ui_story.fillRatio = var_461_4
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1070ui_story then
				local var_461_5 = 0.5

				arg_458_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1070ui_story.fillRatio = var_461_5
			end

			local var_461_6 = 0
			local var_461_7 = 0.95

			if var_461_6 < arg_458_1.time_ and arg_458_1.time_ <= var_461_6 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_8 = arg_458_1:GetWordFromCfg(324081112)
				local var_461_9 = arg_458_1:FormatText(var_461_8.content)

				arg_458_1.text_.text = var_461_9

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_10 = 38
				local var_461_11 = utf8.len(var_461_9)
				local var_461_12 = var_461_10 <= 0 and var_461_7 or var_461_7 * (var_461_11 / var_461_10)

				if var_461_12 > 0 and var_461_7 < var_461_12 then
					arg_458_1.talkMaxDuration = var_461_12

					if var_461_12 + var_461_6 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_12 + var_461_6
					end
				end

				arg_458_1.text_.text = var_461_9
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_13 = math.max(var_461_7, arg_458_1.talkMaxDuration)

			if var_461_6 <= arg_458_1.time_ and arg_458_1.time_ < var_461_6 + var_461_13 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_6) / var_461_13

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_6 + var_461_13 and arg_458_1.time_ < var_461_6 + var_461_13 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play324081113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 324081113
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play324081114(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0
			local var_465_1 = 1.675

			if var_465_0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_2 = arg_462_1:GetWordFromCfg(324081113)
				local var_465_3 = arg_462_1:FormatText(var_465_2.content)

				arg_462_1.text_.text = var_465_3

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_4 = 67
				local var_465_5 = utf8.len(var_465_3)
				local var_465_6 = var_465_4 <= 0 and var_465_1 or var_465_1 * (var_465_5 / var_465_4)

				if var_465_6 > 0 and var_465_1 < var_465_6 then
					arg_462_1.talkMaxDuration = var_465_6

					if var_465_6 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_6 + var_465_0
					end
				end

				arg_462_1.text_.text = var_465_3
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_7 = math.max(var_465_1, arg_462_1.talkMaxDuration)

			if var_465_0 <= arg_462_1.time_ and arg_462_1.time_ < var_465_0 + var_465_7 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_0) / var_465_7

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_0 + var_465_7 and arg_462_1.time_ < var_465_0 + var_465_7 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play324081114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 324081114
		arg_466_1.duration_ = 2

		local var_466_0 = {
			zh = 2,
			ja = 1.2
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play324081115(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1070ui_story"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1070ui_story == nil then
				arg_466_1.var_.characterEffect1070ui_story = var_469_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.characterEffect1070ui_story and not isNil(var_469_0) then
					arg_466_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1070ui_story then
				arg_466_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_469_4 = 0
			local var_469_5 = 0.125

			if var_469_4 < arg_466_1.time_ and arg_466_1.time_ <= var_469_4 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_6 = arg_466_1:FormatText(StoryNameCfg[318].name)

				arg_466_1.leftNameTxt_.text = var_469_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_7 = arg_466_1:GetWordFromCfg(324081114)
				local var_469_8 = arg_466_1:FormatText(var_469_7.content)

				arg_466_1.text_.text = var_469_8

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_9 = 5
				local var_469_10 = utf8.len(var_469_8)
				local var_469_11 = var_469_9 <= 0 and var_469_5 or var_469_5 * (var_469_10 / var_469_9)

				if var_469_11 > 0 and var_469_5 < var_469_11 then
					arg_466_1.talkMaxDuration = var_469_11

					if var_469_11 + var_469_4 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_11 + var_469_4
					end
				end

				arg_466_1.text_.text = var_469_8
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081114", "story_v_out_324081.awb") ~= 0 then
					local var_469_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081114", "story_v_out_324081.awb") / 1000

					if var_469_12 + var_469_4 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_12 + var_469_4
					end

					if var_469_7.prefab_name ~= "" and arg_466_1.actors_[var_469_7.prefab_name] ~= nil then
						local var_469_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_7.prefab_name].transform, "story_v_out_324081", "324081114", "story_v_out_324081.awb")

						arg_466_1:RecordAudio("324081114", var_469_13)
						arg_466_1:RecordAudio("324081114", var_469_13)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_324081", "324081114", "story_v_out_324081.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_324081", "324081114", "story_v_out_324081.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_14 = math.max(var_469_5, arg_466_1.talkMaxDuration)

			if var_469_4 <= arg_466_1.time_ and arg_466_1.time_ < var_469_4 + var_469_14 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_4) / var_469_14

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_4 + var_469_14 and arg_466_1.time_ < var_469_4 + var_469_14 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play324081115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 324081115
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play324081116(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = arg_470_1.actors_["1070ui_story"]
			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect1070ui_story == nil then
				arg_470_1.var_.characterEffect1070ui_story = var_473_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_2 = 0.200000002980232

			if var_473_1 <= arg_470_1.time_ and arg_470_1.time_ < var_473_1 + var_473_2 and not isNil(var_473_0) then
				local var_473_3 = (arg_470_1.time_ - var_473_1) / var_473_2

				if arg_470_1.var_.characterEffect1070ui_story and not isNil(var_473_0) then
					local var_473_4 = Mathf.Lerp(0, 0.5, var_473_3)

					arg_470_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1070ui_story.fillRatio = var_473_4
				end
			end

			if arg_470_1.time_ >= var_473_1 + var_473_2 and arg_470_1.time_ < var_473_1 + var_473_2 + arg_473_0 and not isNil(var_473_0) and arg_470_1.var_.characterEffect1070ui_story then
				local var_473_5 = 0.5

				arg_470_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1070ui_story.fillRatio = var_473_5
			end

			local var_473_6 = 0.6
			local var_473_7 = 1

			if var_473_6 < arg_470_1.time_ and arg_470_1.time_ <= var_473_6 + arg_473_0 then
				local var_473_8 = "play"
				local var_473_9 = "effect"

				arg_470_1:AudioAction(var_473_8, var_473_9, "se_story_150", "se_story_150_marble01", "")
			end

			local var_473_10 = 0
			local var_473_11 = 1.225

			if var_473_10 < arg_470_1.time_ and arg_470_1.time_ <= var_473_10 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_12 = arg_470_1:GetWordFromCfg(324081115)
				local var_473_13 = arg_470_1:FormatText(var_473_12.content)

				arg_470_1.text_.text = var_473_13

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_14 = 49
				local var_473_15 = utf8.len(var_473_13)
				local var_473_16 = var_473_14 <= 0 and var_473_11 or var_473_11 * (var_473_15 / var_473_14)

				if var_473_16 > 0 and var_473_11 < var_473_16 then
					arg_470_1.talkMaxDuration = var_473_16

					if var_473_16 + var_473_10 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_16 + var_473_10
					end
				end

				arg_470_1.text_.text = var_473_13
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_17 = math.max(var_473_11, arg_470_1.talkMaxDuration)

			if var_473_10 <= arg_470_1.time_ and arg_470_1.time_ < var_473_10 + var_473_17 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_10) / var_473_17

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_10 + var_473_17 and arg_470_1.time_ < var_473_10 + var_473_17 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play324081116 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 324081116
		arg_474_1.duration_ = 2

		local var_474_0 = {
			zh = 1.3,
			ja = 2
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play324081117(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0
			local var_477_1 = 0.1

			if var_477_0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				local var_477_2 = arg_474_1:FormatText(StoryNameCfg[1501].name)

				arg_474_1.leftNameTxt_.text = var_477_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_3 = arg_474_1:GetWordFromCfg(324081116)
				local var_477_4 = arg_474_1:FormatText(var_477_3.content)

				arg_474_1.text_.text = var_477_4

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 4
				local var_477_6 = utf8.len(var_477_4)
				local var_477_7 = var_477_5 <= 0 and var_477_1 or var_477_1 * (var_477_6 / var_477_5)

				if var_477_7 > 0 and var_477_1 < var_477_7 then
					arg_474_1.talkMaxDuration = var_477_7

					if var_477_7 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_7 + var_477_0
					end
				end

				arg_474_1.text_.text = var_477_4
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081116", "story_v_out_324081.awb") ~= 0 then
					local var_477_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081116", "story_v_out_324081.awb") / 1000

					if var_477_8 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_8 + var_477_0
					end

					if var_477_3.prefab_name ~= "" and arg_474_1.actors_[var_477_3.prefab_name] ~= nil then
						local var_477_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_3.prefab_name].transform, "story_v_out_324081", "324081116", "story_v_out_324081.awb")

						arg_474_1:RecordAudio("324081116", var_477_9)
						arg_474_1:RecordAudio("324081116", var_477_9)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_324081", "324081116", "story_v_out_324081.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_324081", "324081116", "story_v_out_324081.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_10 = math.max(var_477_1, arg_474_1.talkMaxDuration)

			if var_477_0 <= arg_474_1.time_ and arg_474_1.time_ < var_477_0 + var_477_10 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_0) / var_477_10

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_0 + var_477_10 and arg_474_1.time_ < var_477_0 + var_477_10 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play324081117 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 324081117
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play324081118(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 1
			local var_481_1 = 1

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				local var_481_2 = "play"
				local var_481_3 = "effect"

				arg_478_1:AudioAction(var_481_2, var_481_3, "se_story_150", "se_story_150_marble02", "")
			end

			local var_481_4 = 0
			local var_481_5 = 1.45

			if var_481_4 < arg_478_1.time_ and arg_478_1.time_ <= var_481_4 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_6 = arg_478_1:GetWordFromCfg(324081117)
				local var_481_7 = arg_478_1:FormatText(var_481_6.content)

				arg_478_1.text_.text = var_481_7

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_8 = 58
				local var_481_9 = utf8.len(var_481_7)
				local var_481_10 = var_481_8 <= 0 and var_481_5 or var_481_5 * (var_481_9 / var_481_8)

				if var_481_10 > 0 and var_481_5 < var_481_10 then
					arg_478_1.talkMaxDuration = var_481_10

					if var_481_10 + var_481_4 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_10 + var_481_4
					end
				end

				arg_478_1.text_.text = var_481_7
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_11 = math.max(var_481_5, arg_478_1.talkMaxDuration)

			if var_481_4 <= arg_478_1.time_ and arg_478_1.time_ < var_481_4 + var_481_11 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_4) / var_481_11

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_4 + var_481_11 and arg_478_1.time_ < var_481_4 + var_481_11 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play324081118 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 324081118
		arg_482_1.duration_ = 3

		local var_482_0 = {
			zh = 2.6,
			ja = 3
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play324081119(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.3

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_2 = arg_482_1:FormatText(StoryNameCfg[1501].name)

				arg_482_1.leftNameTxt_.text = var_485_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_3 = arg_482_1:GetWordFromCfg(324081118)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 12
				local var_485_6 = utf8.len(var_485_4)
				local var_485_7 = var_485_5 <= 0 and var_485_1 or var_485_1 * (var_485_6 / var_485_5)

				if var_485_7 > 0 and var_485_1 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081118", "story_v_out_324081.awb") ~= 0 then
					local var_485_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081118", "story_v_out_324081.awb") / 1000

					if var_485_8 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_8 + var_485_0
					end

					if var_485_3.prefab_name ~= "" and arg_482_1.actors_[var_485_3.prefab_name] ~= nil then
						local var_485_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_3.prefab_name].transform, "story_v_out_324081", "324081118", "story_v_out_324081.awb")

						arg_482_1:RecordAudio("324081118", var_485_9)
						arg_482_1:RecordAudio("324081118", var_485_9)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_324081", "324081118", "story_v_out_324081.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_324081", "324081118", "story_v_out_324081.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_10 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_10 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_10

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_10 and arg_482_1.time_ < var_485_0 + var_485_10 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play324081119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 324081119
		arg_486_1.duration_ = 3.43

		local var_486_0 = {
			zh = 2.2,
			ja = 3.433
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play324081120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0
			local var_489_1 = 0.125

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_2 = arg_486_1:FormatText(StoryNameCfg[1468].name)

				arg_486_1.leftNameTxt_.text = var_489_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_3 = arg_486_1:GetWordFromCfg(324081119)
				local var_489_4 = arg_486_1:FormatText(var_489_3.content)

				arg_486_1.text_.text = var_489_4

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_5 = 5
				local var_489_6 = utf8.len(var_489_4)
				local var_489_7 = var_489_5 <= 0 and var_489_1 or var_489_1 * (var_489_6 / var_489_5)

				if var_489_7 > 0 and var_489_1 < var_489_7 then
					arg_486_1.talkMaxDuration = var_489_7

					if var_489_7 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_7 + var_489_0
					end
				end

				arg_486_1.text_.text = var_489_4
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081119", "story_v_out_324081.awb") ~= 0 then
					local var_489_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081119", "story_v_out_324081.awb") / 1000

					if var_489_8 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_8 + var_489_0
					end

					if var_489_3.prefab_name ~= "" and arg_486_1.actors_[var_489_3.prefab_name] ~= nil then
						local var_489_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_3.prefab_name].transform, "story_v_out_324081", "324081119", "story_v_out_324081.awb")

						arg_486_1:RecordAudio("324081119", var_489_9)
						arg_486_1:RecordAudio("324081119", var_489_9)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_324081", "324081119", "story_v_out_324081.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_324081", "324081119", "story_v_out_324081.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_10 = math.max(var_489_1, arg_486_1.talkMaxDuration)

			if var_489_0 <= arg_486_1.time_ and arg_486_1.time_ < var_489_0 + var_489_10 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_0) / var_489_10

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_0 + var_489_10 and arg_486_1.time_ < var_489_0 + var_489_10 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play324081120 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 324081120
		arg_490_1.duration_ = 5.13

		local var_490_0 = {
			zh = 2.666,
			ja = 5.133
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play324081121(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = arg_490_1.actors_["10171ui_story"].transform
			local var_493_1 = 0

			if var_493_1 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 then
				arg_490_1.var_.moveOldPos10171ui_story = var_493_0.localPosition

				local var_493_2 = GameObjectTools.GetOrAddComponent(var_493_0.gameObject, typeof(DynamicBoneHelper))

				if var_493_2 then
					var_493_2:EnableDynamicBone(false)
				end
			end

			local var_493_3 = 0.001

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_3 then
				local var_493_4 = (arg_490_1.time_ - var_493_1) / var_493_3
				local var_493_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_493_0.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos10171ui_story, var_493_5, var_493_4)

				local var_493_6 = manager.ui.mainCamera.transform.position - var_493_0.position

				var_493_0.forward = Vector3.New(var_493_6.x, var_493_6.y, var_493_6.z)

				local var_493_7 = var_493_0.localEulerAngles

				var_493_7.z = 0
				var_493_7.x = 0
				var_493_0.localEulerAngles = var_493_7
			end

			if arg_490_1.time_ >= var_493_1 + var_493_3 and arg_490_1.time_ < var_493_1 + var_493_3 + arg_493_0 then
				var_493_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_493_8 = manager.ui.mainCamera.transform.position - var_493_0.position

				var_493_0.forward = Vector3.New(var_493_8.x, var_493_8.y, var_493_8.z)

				local var_493_9 = var_493_0.localEulerAngles

				var_493_9.z = 0
				var_493_9.x = 0
				var_493_0.localEulerAngles = var_493_9

				local var_493_10 = GameObjectTools.GetOrAddComponent(var_493_0.gameObject, typeof(DynamicBoneHelper))

				if var_493_10 then
					var_493_10:EnableDynamicBone(true)
				end
			end

			local var_493_11 = arg_490_1.actors_["10171ui_story"]
			local var_493_12 = 0

			if var_493_12 < arg_490_1.time_ and arg_490_1.time_ <= var_493_12 + arg_493_0 and not isNil(var_493_11) and arg_490_1.var_.characterEffect10171ui_story == nil then
				arg_490_1.var_.characterEffect10171ui_story = var_493_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_13 = 0.200000002980232

			if var_493_12 <= arg_490_1.time_ and arg_490_1.time_ < var_493_12 + var_493_13 and not isNil(var_493_11) then
				local var_493_14 = (arg_490_1.time_ - var_493_12) / var_493_13

				if arg_490_1.var_.characterEffect10171ui_story and not isNil(var_493_11) then
					arg_490_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= var_493_12 + var_493_13 and arg_490_1.time_ < var_493_12 + var_493_13 + arg_493_0 and not isNil(var_493_11) and arg_490_1.var_.characterEffect10171ui_story then
				arg_490_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_493_15 = 0

			if var_493_15 < arg_490_1.time_ and arg_490_1.time_ <= var_493_15 + arg_493_0 then
				arg_490_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_1")
			end

			local var_493_16 = 0

			if var_493_16 < arg_490_1.time_ and arg_490_1.time_ <= var_493_16 + arg_493_0 then
				arg_490_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_493_17 = 0
			local var_493_18 = 0.325

			if var_493_17 < arg_490_1.time_ and arg_490_1.time_ <= var_493_17 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_19 = arg_490_1:FormatText(StoryNameCfg[1451].name)

				arg_490_1.leftNameTxt_.text = var_493_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_20 = arg_490_1:GetWordFromCfg(324081120)
				local var_493_21 = arg_490_1:FormatText(var_493_20.content)

				arg_490_1.text_.text = var_493_21

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_22 = 13
				local var_493_23 = utf8.len(var_493_21)
				local var_493_24 = var_493_22 <= 0 and var_493_18 or var_493_18 * (var_493_23 / var_493_22)

				if var_493_24 > 0 and var_493_18 < var_493_24 then
					arg_490_1.talkMaxDuration = var_493_24

					if var_493_24 + var_493_17 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_24 + var_493_17
					end
				end

				arg_490_1.text_.text = var_493_21
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081120", "story_v_out_324081.awb") ~= 0 then
					local var_493_25 = manager.audio:GetVoiceLength("story_v_out_324081", "324081120", "story_v_out_324081.awb") / 1000

					if var_493_25 + var_493_17 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_25 + var_493_17
					end

					if var_493_20.prefab_name ~= "" and arg_490_1.actors_[var_493_20.prefab_name] ~= nil then
						local var_493_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_20.prefab_name].transform, "story_v_out_324081", "324081120", "story_v_out_324081.awb")

						arg_490_1:RecordAudio("324081120", var_493_26)
						arg_490_1:RecordAudio("324081120", var_493_26)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_324081", "324081120", "story_v_out_324081.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_324081", "324081120", "story_v_out_324081.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_27 = math.max(var_493_18, arg_490_1.talkMaxDuration)

			if var_493_17 <= arg_490_1.time_ and arg_490_1.time_ < var_493_17 + var_493_27 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_17) / var_493_27

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_17 + var_493_27 and arg_490_1.time_ < var_493_17 + var_493_27 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play324081121 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 324081121
		arg_494_1.duration_ = 8.5

		local var_494_0 = {
			zh = 7.033,
			ja = 8.5
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play324081122(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["1070ui_story"].transform
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 then
				arg_494_1.var_.moveOldPos1070ui_story = var_497_0.localPosition
			end

			local var_497_2 = 0.001

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2
				local var_497_4 = Vector3.New(0.7, -0.95, -6.05)

				var_497_0.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1070ui_story, var_497_4, var_497_3)

				local var_497_5 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_5.x, var_497_5.y, var_497_5.z)

				local var_497_6 = var_497_0.localEulerAngles

				var_497_6.z = 0
				var_497_6.x = 0
				var_497_0.localEulerAngles = var_497_6
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 then
				var_497_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_497_7 = manager.ui.mainCamera.transform.position - var_497_0.position

				var_497_0.forward = Vector3.New(var_497_7.x, var_497_7.y, var_497_7.z)

				local var_497_8 = var_497_0.localEulerAngles

				var_497_8.z = 0
				var_497_8.x = 0
				var_497_0.localEulerAngles = var_497_8
			end

			local var_497_9 = arg_494_1.actors_["1070ui_story"]
			local var_497_10 = 0

			if var_497_10 < arg_494_1.time_ and arg_494_1.time_ <= var_497_10 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect1070ui_story == nil then
				arg_494_1.var_.characterEffect1070ui_story = var_497_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_11 = 0.200000002980232

			if var_497_10 <= arg_494_1.time_ and arg_494_1.time_ < var_497_10 + var_497_11 and not isNil(var_497_9) then
				local var_497_12 = (arg_494_1.time_ - var_497_10) / var_497_11

				if arg_494_1.var_.characterEffect1070ui_story and not isNil(var_497_9) then
					arg_494_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= var_497_10 + var_497_11 and arg_494_1.time_ < var_497_10 + var_497_11 + arg_497_0 and not isNil(var_497_9) and arg_494_1.var_.characterEffect1070ui_story then
				arg_494_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_497_13 = arg_494_1.actors_["10171ui_story"]
			local var_497_14 = 0

			if var_497_14 < arg_494_1.time_ and arg_494_1.time_ <= var_497_14 + arg_497_0 and not isNil(var_497_13) and arg_494_1.var_.characterEffect10171ui_story == nil then
				arg_494_1.var_.characterEffect10171ui_story = var_497_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_15 = 0.200000002980232

			if var_497_14 <= arg_494_1.time_ and arg_494_1.time_ < var_497_14 + var_497_15 and not isNil(var_497_13) then
				local var_497_16 = (arg_494_1.time_ - var_497_14) / var_497_15

				if arg_494_1.var_.characterEffect10171ui_story and not isNil(var_497_13) then
					local var_497_17 = Mathf.Lerp(0, 0.5, var_497_16)

					arg_494_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_494_1.var_.characterEffect10171ui_story.fillRatio = var_497_17
				end
			end

			if arg_494_1.time_ >= var_497_14 + var_497_15 and arg_494_1.time_ < var_497_14 + var_497_15 + arg_497_0 and not isNil(var_497_13) and arg_494_1.var_.characterEffect10171ui_story then
				local var_497_18 = 0.5

				arg_494_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_494_1.var_.characterEffect10171ui_story.fillRatio = var_497_18
			end

			local var_497_19 = 0

			if var_497_19 < arg_494_1.time_ and arg_494_1.time_ <= var_497_19 + arg_497_0 then
				arg_494_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_497_20 = 0

			if var_497_20 < arg_494_1.time_ and arg_494_1.time_ <= var_497_20 + arg_497_0 then
				arg_494_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_497_21 = 0
			local var_497_22 = 0.65

			if var_497_21 < arg_494_1.time_ and arg_494_1.time_ <= var_497_21 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_23 = arg_494_1:FormatText(StoryNameCfg[318].name)

				arg_494_1.leftNameTxt_.text = var_497_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_24 = arg_494_1:GetWordFromCfg(324081121)
				local var_497_25 = arg_494_1:FormatText(var_497_24.content)

				arg_494_1.text_.text = var_497_25

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_26 = 26
				local var_497_27 = utf8.len(var_497_25)
				local var_497_28 = var_497_26 <= 0 and var_497_22 or var_497_22 * (var_497_27 / var_497_26)

				if var_497_28 > 0 and var_497_22 < var_497_28 then
					arg_494_1.talkMaxDuration = var_497_28

					if var_497_28 + var_497_21 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_28 + var_497_21
					end
				end

				arg_494_1.text_.text = var_497_25
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081121", "story_v_out_324081.awb") ~= 0 then
					local var_497_29 = manager.audio:GetVoiceLength("story_v_out_324081", "324081121", "story_v_out_324081.awb") / 1000

					if var_497_29 + var_497_21 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_29 + var_497_21
					end

					if var_497_24.prefab_name ~= "" and arg_494_1.actors_[var_497_24.prefab_name] ~= nil then
						local var_497_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_24.prefab_name].transform, "story_v_out_324081", "324081121", "story_v_out_324081.awb")

						arg_494_1:RecordAudio("324081121", var_497_30)
						arg_494_1:RecordAudio("324081121", var_497_30)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_324081", "324081121", "story_v_out_324081.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_324081", "324081121", "story_v_out_324081.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_31 = math.max(var_497_22, arg_494_1.talkMaxDuration)

			if var_497_21 <= arg_494_1.time_ and arg_494_1.time_ < var_497_21 + var_497_31 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_21) / var_497_31

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_21 + var_497_31 and arg_494_1.time_ < var_497_21 + var_497_31 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
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

		arg_494_1:InitPlayNodeList()
	end,
	Play324081122 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 324081122
		arg_498_1.duration_ = 10.2

		local var_498_0 = {
			zh = 8.133,
			ja = 10.2
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play324081123(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["10171ui_story"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect10171ui_story == nil then
				arg_498_1.var_.characterEffect10171ui_story = var_501_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.characterEffect10171ui_story and not isNil(var_501_0) then
					arg_498_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect10171ui_story then
				arg_498_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_501_4 = arg_498_1.actors_["1070ui_story"]
			local var_501_5 = 0

			if var_501_5 < arg_498_1.time_ and arg_498_1.time_ <= var_501_5 + arg_501_0 and not isNil(var_501_4) and arg_498_1.var_.characterEffect1070ui_story == nil then
				arg_498_1.var_.characterEffect1070ui_story = var_501_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_6 = 0.200000002980232

			if var_501_5 <= arg_498_1.time_ and arg_498_1.time_ < var_501_5 + var_501_6 and not isNil(var_501_4) then
				local var_501_7 = (arg_498_1.time_ - var_501_5) / var_501_6

				if arg_498_1.var_.characterEffect1070ui_story and not isNil(var_501_4) then
					local var_501_8 = Mathf.Lerp(0, 0.5, var_501_7)

					arg_498_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_498_1.var_.characterEffect1070ui_story.fillRatio = var_501_8
				end
			end

			if arg_498_1.time_ >= var_501_5 + var_501_6 and arg_498_1.time_ < var_501_5 + var_501_6 + arg_501_0 and not isNil(var_501_4) and arg_498_1.var_.characterEffect1070ui_story then
				local var_501_9 = 0.5

				arg_498_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_498_1.var_.characterEffect1070ui_story.fillRatio = var_501_9
			end

			local var_501_10 = 0
			local var_501_11 = 0.975

			if var_501_10 < arg_498_1.time_ and arg_498_1.time_ <= var_501_10 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_12 = arg_498_1:FormatText(StoryNameCfg[1451].name)

				arg_498_1.leftNameTxt_.text = var_501_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_13 = arg_498_1:GetWordFromCfg(324081122)
				local var_501_14 = arg_498_1:FormatText(var_501_13.content)

				arg_498_1.text_.text = var_501_14

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_15 = 39
				local var_501_16 = utf8.len(var_501_14)
				local var_501_17 = var_501_15 <= 0 and var_501_11 or var_501_11 * (var_501_16 / var_501_15)

				if var_501_17 > 0 and var_501_11 < var_501_17 then
					arg_498_1.talkMaxDuration = var_501_17

					if var_501_17 + var_501_10 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_17 + var_501_10
					end
				end

				arg_498_1.text_.text = var_501_14
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081122", "story_v_out_324081.awb") ~= 0 then
					local var_501_18 = manager.audio:GetVoiceLength("story_v_out_324081", "324081122", "story_v_out_324081.awb") / 1000

					if var_501_18 + var_501_10 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_18 + var_501_10
					end

					if var_501_13.prefab_name ~= "" and arg_498_1.actors_[var_501_13.prefab_name] ~= nil then
						local var_501_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_13.prefab_name].transform, "story_v_out_324081", "324081122", "story_v_out_324081.awb")

						arg_498_1:RecordAudio("324081122", var_501_19)
						arg_498_1:RecordAudio("324081122", var_501_19)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_324081", "324081122", "story_v_out_324081.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_324081", "324081122", "story_v_out_324081.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_20 = math.max(var_501_11, arg_498_1.talkMaxDuration)

			if var_501_10 <= arg_498_1.time_ and arg_498_1.time_ < var_501_10 + var_501_20 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_10) / var_501_20

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_10 + var_501_20 and arg_498_1.time_ < var_501_10 + var_501_20 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play324081123 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 324081123
		arg_502_1.duration_ = 7.27

		local var_502_0 = {
			zh = 7.1,
			ja = 7.266
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play324081124(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = arg_502_1.actors_["1070ui_story"]
			local var_505_1 = 0

			if var_505_1 < arg_502_1.time_ and arg_502_1.time_ <= var_505_1 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.characterEffect1070ui_story == nil then
				arg_502_1.var_.characterEffect1070ui_story = var_505_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_2 = 0.200000002980232

			if var_505_1 <= arg_502_1.time_ and arg_502_1.time_ < var_505_1 + var_505_2 and not isNil(var_505_0) then
				local var_505_3 = (arg_502_1.time_ - var_505_1) / var_505_2

				if arg_502_1.var_.characterEffect1070ui_story and not isNil(var_505_0) then
					arg_502_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_502_1.time_ >= var_505_1 + var_505_2 and arg_502_1.time_ < var_505_1 + var_505_2 + arg_505_0 and not isNil(var_505_0) and arg_502_1.var_.characterEffect1070ui_story then
				arg_502_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_505_4 = arg_502_1.actors_["10171ui_story"]
			local var_505_5 = 0

			if var_505_5 < arg_502_1.time_ and arg_502_1.time_ <= var_505_5 + arg_505_0 and not isNil(var_505_4) and arg_502_1.var_.characterEffect10171ui_story == nil then
				arg_502_1.var_.characterEffect10171ui_story = var_505_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_6 = 0.200000002980232

			if var_505_5 <= arg_502_1.time_ and arg_502_1.time_ < var_505_5 + var_505_6 and not isNil(var_505_4) then
				local var_505_7 = (arg_502_1.time_ - var_505_5) / var_505_6

				if arg_502_1.var_.characterEffect10171ui_story and not isNil(var_505_4) then
					local var_505_8 = Mathf.Lerp(0, 0.5, var_505_7)

					arg_502_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_502_1.var_.characterEffect10171ui_story.fillRatio = var_505_8
				end
			end

			if arg_502_1.time_ >= var_505_5 + var_505_6 and arg_502_1.time_ < var_505_5 + var_505_6 + arg_505_0 and not isNil(var_505_4) and arg_502_1.var_.characterEffect10171ui_story then
				local var_505_9 = 0.5

				arg_502_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_502_1.var_.characterEffect10171ui_story.fillRatio = var_505_9
			end

			local var_505_10 = 0
			local var_505_11 = 0.825

			if var_505_10 < arg_502_1.time_ and arg_502_1.time_ <= var_505_10 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_12 = arg_502_1:FormatText(StoryNameCfg[318].name)

				arg_502_1.leftNameTxt_.text = var_505_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_13 = arg_502_1:GetWordFromCfg(324081123)
				local var_505_14 = arg_502_1:FormatText(var_505_13.content)

				arg_502_1.text_.text = var_505_14

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_15 = 33
				local var_505_16 = utf8.len(var_505_14)
				local var_505_17 = var_505_15 <= 0 and var_505_11 or var_505_11 * (var_505_16 / var_505_15)

				if var_505_17 > 0 and var_505_11 < var_505_17 then
					arg_502_1.talkMaxDuration = var_505_17

					if var_505_17 + var_505_10 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_17 + var_505_10
					end
				end

				arg_502_1.text_.text = var_505_14
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081123", "story_v_out_324081.awb") ~= 0 then
					local var_505_18 = manager.audio:GetVoiceLength("story_v_out_324081", "324081123", "story_v_out_324081.awb") / 1000

					if var_505_18 + var_505_10 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_18 + var_505_10
					end

					if var_505_13.prefab_name ~= "" and arg_502_1.actors_[var_505_13.prefab_name] ~= nil then
						local var_505_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_13.prefab_name].transform, "story_v_out_324081", "324081123", "story_v_out_324081.awb")

						arg_502_1:RecordAudio("324081123", var_505_19)
						arg_502_1:RecordAudio("324081123", var_505_19)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_324081", "324081123", "story_v_out_324081.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_324081", "324081123", "story_v_out_324081.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_20 = math.max(var_505_11, arg_502_1.talkMaxDuration)

			if var_505_10 <= arg_502_1.time_ and arg_502_1.time_ < var_505_10 + var_505_20 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_10) / var_505_20

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_10 + var_505_20 and arg_502_1.time_ < var_505_10 + var_505_20 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play324081124 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 324081124
		arg_506_1.duration_ = 10.17

		local var_506_0 = {
			zh = 8.1,
			ja = 10.166
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play324081125(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = arg_506_1.actors_["10171ui_story"]
			local var_509_1 = 0

			if var_509_1 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.characterEffect10171ui_story == nil then
				arg_506_1.var_.characterEffect10171ui_story = var_509_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_2 = 0.200000002980232

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_2 and not isNil(var_509_0) then
				local var_509_3 = (arg_506_1.time_ - var_509_1) / var_509_2

				if arg_506_1.var_.characterEffect10171ui_story and not isNil(var_509_0) then
					arg_506_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= var_509_1 + var_509_2 and arg_506_1.time_ < var_509_1 + var_509_2 + arg_509_0 and not isNil(var_509_0) and arg_506_1.var_.characterEffect10171ui_story then
				arg_506_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_509_4 = arg_506_1.actors_["1070ui_story"]
			local var_509_5 = 0

			if var_509_5 < arg_506_1.time_ and arg_506_1.time_ <= var_509_5 + arg_509_0 and not isNil(var_509_4) and arg_506_1.var_.characterEffect1070ui_story == nil then
				arg_506_1.var_.characterEffect1070ui_story = var_509_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_6 = 0.200000002980232

			if var_509_5 <= arg_506_1.time_ and arg_506_1.time_ < var_509_5 + var_509_6 and not isNil(var_509_4) then
				local var_509_7 = (arg_506_1.time_ - var_509_5) / var_509_6

				if arg_506_1.var_.characterEffect1070ui_story and not isNil(var_509_4) then
					local var_509_8 = Mathf.Lerp(0, 0.5, var_509_7)

					arg_506_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_506_1.var_.characterEffect1070ui_story.fillRatio = var_509_8
				end
			end

			if arg_506_1.time_ >= var_509_5 + var_509_6 and arg_506_1.time_ < var_509_5 + var_509_6 + arg_509_0 and not isNil(var_509_4) and arg_506_1.var_.characterEffect1070ui_story then
				local var_509_9 = 0.5

				arg_506_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_506_1.var_.characterEffect1070ui_story.fillRatio = var_509_9
			end

			local var_509_10 = 0

			if var_509_10 < arg_506_1.time_ and arg_506_1.time_ <= var_509_10 + arg_509_0 then
				arg_506_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171actionlink/10171action42731")
			end

			local var_509_11 = 0

			if var_509_11 < arg_506_1.time_ and arg_506_1.time_ <= var_509_11 + arg_509_0 then
				arg_506_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_509_12 = 0

			if var_509_12 < arg_506_1.time_ and arg_506_1.time_ <= var_509_12 + arg_509_0 then
				arg_506_1.allBtn_.enabled = false
			end

			local var_509_13 = 1.63333333333333

			if arg_506_1.time_ >= var_509_12 + var_509_13 and arg_506_1.time_ < var_509_12 + var_509_13 + arg_509_0 then
				arg_506_1.allBtn_.enabled = true
			end

			local var_509_14 = 0
			local var_509_15 = 0.95

			if var_509_14 < arg_506_1.time_ and arg_506_1.time_ <= var_509_14 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_16 = arg_506_1:FormatText(StoryNameCfg[1451].name)

				arg_506_1.leftNameTxt_.text = var_509_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_17 = arg_506_1:GetWordFromCfg(324081124)
				local var_509_18 = arg_506_1:FormatText(var_509_17.content)

				arg_506_1.text_.text = var_509_18

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_19 = 38
				local var_509_20 = utf8.len(var_509_18)
				local var_509_21 = var_509_19 <= 0 and var_509_15 or var_509_15 * (var_509_20 / var_509_19)

				if var_509_21 > 0 and var_509_15 < var_509_21 then
					arg_506_1.talkMaxDuration = var_509_21

					if var_509_21 + var_509_14 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_21 + var_509_14
					end
				end

				arg_506_1.text_.text = var_509_18
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081124", "story_v_out_324081.awb") ~= 0 then
					local var_509_22 = manager.audio:GetVoiceLength("story_v_out_324081", "324081124", "story_v_out_324081.awb") / 1000

					if var_509_22 + var_509_14 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_22 + var_509_14
					end

					if var_509_17.prefab_name ~= "" and arg_506_1.actors_[var_509_17.prefab_name] ~= nil then
						local var_509_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_17.prefab_name].transform, "story_v_out_324081", "324081124", "story_v_out_324081.awb")

						arg_506_1:RecordAudio("324081124", var_509_23)
						arg_506_1:RecordAudio("324081124", var_509_23)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_324081", "324081124", "story_v_out_324081.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_324081", "324081124", "story_v_out_324081.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_24 = math.max(var_509_15, arg_506_1.talkMaxDuration)

			if var_509_14 <= arg_506_1.time_ and arg_506_1.time_ < var_509_14 + var_509_24 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_14) / var_509_24

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_14 + var_509_24 and arg_506_1.time_ < var_509_14 + var_509_24 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play324081125 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 324081125
		arg_510_1.duration_ = 2

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play324081126(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["1070ui_story"]
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect1070ui_story == nil then
				arg_510_1.var_.characterEffect1070ui_story = var_513_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_2 = 0.200000002980232

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 and not isNil(var_513_0) then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2

				if arg_510_1.var_.characterEffect1070ui_story and not isNil(var_513_0) then
					arg_510_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect1070ui_story then
				arg_510_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_513_4 = arg_510_1.actors_["10171ui_story"]
			local var_513_5 = 0

			if var_513_5 < arg_510_1.time_ and arg_510_1.time_ <= var_513_5 + arg_513_0 and not isNil(var_513_4) and arg_510_1.var_.characterEffect10171ui_story == nil then
				arg_510_1.var_.characterEffect10171ui_story = var_513_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_6 = 0.200000002980232

			if var_513_5 <= arg_510_1.time_ and arg_510_1.time_ < var_513_5 + var_513_6 and not isNil(var_513_4) then
				local var_513_7 = (arg_510_1.time_ - var_513_5) / var_513_6

				if arg_510_1.var_.characterEffect10171ui_story and not isNil(var_513_4) then
					local var_513_8 = Mathf.Lerp(0, 0.5, var_513_7)

					arg_510_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_510_1.var_.characterEffect10171ui_story.fillRatio = var_513_8
				end
			end

			if arg_510_1.time_ >= var_513_5 + var_513_6 and arg_510_1.time_ < var_513_5 + var_513_6 + arg_513_0 and not isNil(var_513_4) and arg_510_1.var_.characterEffect10171ui_story then
				local var_513_9 = 0.5

				arg_510_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_510_1.var_.characterEffect10171ui_story.fillRatio = var_513_9
			end

			local var_513_10 = 0

			if var_513_10 < arg_510_1.time_ and arg_510_1.time_ <= var_513_10 + arg_513_0 then
				arg_510_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_513_11 = 0
			local var_513_12 = 0.05

			if var_513_11 < arg_510_1.time_ and arg_510_1.time_ <= var_513_11 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_13 = arg_510_1:FormatText(StoryNameCfg[318].name)

				arg_510_1.leftNameTxt_.text = var_513_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_14 = arg_510_1:GetWordFromCfg(324081125)
				local var_513_15 = arg_510_1:FormatText(var_513_14.content)

				arg_510_1.text_.text = var_513_15

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_16 = 2
				local var_513_17 = utf8.len(var_513_15)
				local var_513_18 = var_513_16 <= 0 and var_513_12 or var_513_12 * (var_513_17 / var_513_16)

				if var_513_18 > 0 and var_513_12 < var_513_18 then
					arg_510_1.talkMaxDuration = var_513_18

					if var_513_18 + var_513_11 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_18 + var_513_11
					end
				end

				arg_510_1.text_.text = var_513_15
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081125", "story_v_out_324081.awb") ~= 0 then
					local var_513_19 = manager.audio:GetVoiceLength("story_v_out_324081", "324081125", "story_v_out_324081.awb") / 1000

					if var_513_19 + var_513_11 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_19 + var_513_11
					end

					if var_513_14.prefab_name ~= "" and arg_510_1.actors_[var_513_14.prefab_name] ~= nil then
						local var_513_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_14.prefab_name].transform, "story_v_out_324081", "324081125", "story_v_out_324081.awb")

						arg_510_1:RecordAudio("324081125", var_513_20)
						arg_510_1:RecordAudio("324081125", var_513_20)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_out_324081", "324081125", "story_v_out_324081.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_out_324081", "324081125", "story_v_out_324081.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_21 = math.max(var_513_12, arg_510_1.talkMaxDuration)

			if var_513_11 <= arg_510_1.time_ and arg_510_1.time_ < var_513_11 + var_513_21 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_11) / var_513_21

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_11 + var_513_21 and arg_510_1.time_ < var_513_11 + var_513_21 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play324081126 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 324081126
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play324081127(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["10171ui_story"].transform
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 then
				arg_514_1.var_.moveOldPos10171ui_story = var_517_0.localPosition

				local var_517_2 = GameObjectTools.GetOrAddComponent(var_517_0.gameObject, typeof(DynamicBoneHelper))

				if var_517_2 then
					var_517_2:EnableDynamicBone(false)
				end
			end

			local var_517_3 = 0.001

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_3 then
				local var_517_4 = (arg_514_1.time_ - var_517_1) / var_517_3
				local var_517_5 = Vector3.New(0, 100, 0)

				var_517_0.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos10171ui_story, var_517_5, var_517_4)

				local var_517_6 = manager.ui.mainCamera.transform.position - var_517_0.position

				var_517_0.forward = Vector3.New(var_517_6.x, var_517_6.y, var_517_6.z)

				local var_517_7 = var_517_0.localEulerAngles

				var_517_7.z = 0
				var_517_7.x = 0
				var_517_0.localEulerAngles = var_517_7
			end

			if arg_514_1.time_ >= var_517_1 + var_517_3 and arg_514_1.time_ < var_517_1 + var_517_3 + arg_517_0 then
				var_517_0.localPosition = Vector3.New(0, 100, 0)

				local var_517_8 = manager.ui.mainCamera.transform.position - var_517_0.position

				var_517_0.forward = Vector3.New(var_517_8.x, var_517_8.y, var_517_8.z)

				local var_517_9 = var_517_0.localEulerAngles

				var_517_9.z = 0
				var_517_9.x = 0
				var_517_0.localEulerAngles = var_517_9

				local var_517_10 = GameObjectTools.GetOrAddComponent(var_517_0.gameObject, typeof(DynamicBoneHelper))

				if var_517_10 then
					var_517_10:EnableDynamicBone(true)
				end
			end

			local var_517_11 = arg_514_1.actors_["1070ui_story"].transform
			local var_517_12 = 0

			if var_517_12 < arg_514_1.time_ and arg_514_1.time_ <= var_517_12 + arg_517_0 then
				arg_514_1.var_.moveOldPos1070ui_story = var_517_11.localPosition
			end

			local var_517_13 = 0.001

			if var_517_12 <= arg_514_1.time_ and arg_514_1.time_ < var_517_12 + var_517_13 then
				local var_517_14 = (arg_514_1.time_ - var_517_12) / var_517_13
				local var_517_15 = Vector3.New(0, 100, 0)

				var_517_11.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1070ui_story, var_517_15, var_517_14)

				local var_517_16 = manager.ui.mainCamera.transform.position - var_517_11.position

				var_517_11.forward = Vector3.New(var_517_16.x, var_517_16.y, var_517_16.z)

				local var_517_17 = var_517_11.localEulerAngles

				var_517_17.z = 0
				var_517_17.x = 0
				var_517_11.localEulerAngles = var_517_17
			end

			if arg_514_1.time_ >= var_517_12 + var_517_13 and arg_514_1.time_ < var_517_12 + var_517_13 + arg_517_0 then
				var_517_11.localPosition = Vector3.New(0, 100, 0)

				local var_517_18 = manager.ui.mainCamera.transform.position - var_517_11.position

				var_517_11.forward = Vector3.New(var_517_18.x, var_517_18.y, var_517_18.z)

				local var_517_19 = var_517_11.localEulerAngles

				var_517_19.z = 0
				var_517_19.x = 0
				var_517_11.localEulerAngles = var_517_19
			end

			local var_517_20 = arg_514_1.actors_["1070ui_story"]
			local var_517_21 = 0

			if var_517_21 < arg_514_1.time_ and arg_514_1.time_ <= var_517_21 + arg_517_0 and not isNil(var_517_20) and arg_514_1.var_.characterEffect1070ui_story == nil then
				arg_514_1.var_.characterEffect1070ui_story = var_517_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_22 = 0.200000002980232

			if var_517_21 <= arg_514_1.time_ and arg_514_1.time_ < var_517_21 + var_517_22 and not isNil(var_517_20) then
				local var_517_23 = (arg_514_1.time_ - var_517_21) / var_517_22

				if arg_514_1.var_.characterEffect1070ui_story and not isNil(var_517_20) then
					local var_517_24 = Mathf.Lerp(0, 0.5, var_517_23)

					arg_514_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_514_1.var_.characterEffect1070ui_story.fillRatio = var_517_24
				end
			end

			if arg_514_1.time_ >= var_517_21 + var_517_22 and arg_514_1.time_ < var_517_21 + var_517_22 + arg_517_0 and not isNil(var_517_20) and arg_514_1.var_.characterEffect1070ui_story then
				local var_517_25 = 0.5

				arg_514_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_514_1.var_.characterEffect1070ui_story.fillRatio = var_517_25
			end

			local var_517_26 = 0
			local var_517_27 = 1.35

			if var_517_26 < arg_514_1.time_ and arg_514_1.time_ <= var_517_26 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, false)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_28 = arg_514_1:GetWordFromCfg(324081126)
				local var_517_29 = arg_514_1:FormatText(var_517_28.content)

				arg_514_1.text_.text = var_517_29

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_30 = 54
				local var_517_31 = utf8.len(var_517_29)
				local var_517_32 = var_517_30 <= 0 and var_517_27 or var_517_27 * (var_517_31 / var_517_30)

				if var_517_32 > 0 and var_517_27 < var_517_32 then
					arg_514_1.talkMaxDuration = var_517_32

					if var_517_32 + var_517_26 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_32 + var_517_26
					end
				end

				arg_514_1.text_.text = var_517_29
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_33 = math.max(var_517_27, arg_514_1.talkMaxDuration)

			if var_517_26 <= arg_514_1.time_ and arg_514_1.time_ < var_517_26 + var_517_33 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_26) / var_517_33

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_26 + var_517_33 and arg_514_1.time_ < var_517_26 + var_517_33 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
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

		arg_514_1:InitPlayNodeList()
	end,
	Play324081127 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 324081127
		arg_518_1.duration_ = 3.93

		local var_518_0 = {
			zh = 3.1,
			ja = 3.933
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
			arg_518_1.auto_ = false
		end

		function arg_518_1.playNext_(arg_520_0)
			arg_518_1.onStoryFinished_()
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["10171ui_story"].transform
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 then
				arg_518_1.var_.moveOldPos10171ui_story = var_521_0.localPosition

				local var_521_2 = GameObjectTools.GetOrAddComponent(var_521_0.gameObject, typeof(DynamicBoneHelper))

				if var_521_2 then
					var_521_2:EnableDynamicBone(false)
				end
			end

			local var_521_3 = 0.001

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_3 then
				local var_521_4 = (arg_518_1.time_ - var_521_1) / var_521_3
				local var_521_5 = Vector3.New(0, -0.95, -6.05)

				var_521_0.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos10171ui_story, var_521_5, var_521_4)

				local var_521_6 = manager.ui.mainCamera.transform.position - var_521_0.position

				var_521_0.forward = Vector3.New(var_521_6.x, var_521_6.y, var_521_6.z)

				local var_521_7 = var_521_0.localEulerAngles

				var_521_7.z = 0
				var_521_7.x = 0
				var_521_0.localEulerAngles = var_521_7
			end

			if arg_518_1.time_ >= var_521_1 + var_521_3 and arg_518_1.time_ < var_521_1 + var_521_3 + arg_521_0 then
				var_521_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_521_8 = manager.ui.mainCamera.transform.position - var_521_0.position

				var_521_0.forward = Vector3.New(var_521_8.x, var_521_8.y, var_521_8.z)

				local var_521_9 = var_521_0.localEulerAngles

				var_521_9.z = 0
				var_521_9.x = 0
				var_521_0.localEulerAngles = var_521_9

				local var_521_10 = GameObjectTools.GetOrAddComponent(var_521_0.gameObject, typeof(DynamicBoneHelper))

				if var_521_10 then
					var_521_10:EnableDynamicBone(true)
				end
			end

			local var_521_11 = arg_518_1.actors_["10171ui_story"]
			local var_521_12 = 0

			if var_521_12 < arg_518_1.time_ and arg_518_1.time_ <= var_521_12 + arg_521_0 and not isNil(var_521_11) and arg_518_1.var_.characterEffect10171ui_story == nil then
				arg_518_1.var_.characterEffect10171ui_story = var_521_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_13 = 0.200000002980232

			if var_521_12 <= arg_518_1.time_ and arg_518_1.time_ < var_521_12 + var_521_13 and not isNil(var_521_11) then
				local var_521_14 = (arg_518_1.time_ - var_521_12) / var_521_13

				if arg_518_1.var_.characterEffect10171ui_story and not isNil(var_521_11) then
					arg_518_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= var_521_12 + var_521_13 and arg_518_1.time_ < var_521_12 + var_521_13 + arg_521_0 and not isNil(var_521_11) and arg_518_1.var_.characterEffect10171ui_story then
				arg_518_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_521_15 = 0

			if var_521_15 < arg_518_1.time_ and arg_518_1.time_ <= var_521_15 + arg_521_0 then
				arg_518_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action31_2")
			end

			local var_521_16 = 0

			if var_521_16 < arg_518_1.time_ and arg_518_1.time_ <= var_521_16 + arg_521_0 then
				arg_518_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_521_17 = 0
			local var_521_18 = 0.325

			if var_521_17 < arg_518_1.time_ and arg_518_1.time_ <= var_521_17 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_19 = arg_518_1:FormatText(StoryNameCfg[1451].name)

				arg_518_1.leftNameTxt_.text = var_521_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_20 = arg_518_1:GetWordFromCfg(324081127)
				local var_521_21 = arg_518_1:FormatText(var_521_20.content)

				arg_518_1.text_.text = var_521_21

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_22 = 13
				local var_521_23 = utf8.len(var_521_21)
				local var_521_24 = var_521_22 <= 0 and var_521_18 or var_521_18 * (var_521_23 / var_521_22)

				if var_521_24 > 0 and var_521_18 < var_521_24 then
					arg_518_1.talkMaxDuration = var_521_24

					if var_521_24 + var_521_17 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_24 + var_521_17
					end
				end

				arg_518_1.text_.text = var_521_21
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081127", "story_v_out_324081.awb") ~= 0 then
					local var_521_25 = manager.audio:GetVoiceLength("story_v_out_324081", "324081127", "story_v_out_324081.awb") / 1000

					if var_521_25 + var_521_17 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_25 + var_521_17
					end

					if var_521_20.prefab_name ~= "" and arg_518_1.actors_[var_521_20.prefab_name] ~= nil then
						local var_521_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_20.prefab_name].transform, "story_v_out_324081", "324081127", "story_v_out_324081.awb")

						arg_518_1:RecordAudio("324081127", var_521_26)
						arg_518_1:RecordAudio("324081127", var_521_26)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_324081", "324081127", "story_v_out_324081.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_324081", "324081127", "story_v_out_324081.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_27 = math.max(var_521_18, arg_518_1.talkMaxDuration)

			if var_521_17 <= arg_518_1.time_ and arg_518_1.time_ < var_521_17 + var_521_27 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_17) / var_521_27

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_17 + var_521_27 and arg_518_1.time_ < var_521_17 + var_521_27 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J27f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J22f",
		"TextureConfig/Background/J22g"
	},
	voices = {
		"story_v_out_324081.awb"
	}
}
