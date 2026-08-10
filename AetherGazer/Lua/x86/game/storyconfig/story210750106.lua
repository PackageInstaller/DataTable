return {
	Play1107506001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1107506001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1107506002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST32a"

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
				local var_4_5 = arg_1_1.bgs_.ST32a

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
					if iter_4_0 ~= "ST32a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_24 = "1075ui_actor"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1075ui_actor")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1075ui_actor"]
			local var_4_30 = 2

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1075ui_actor == nil then
				arg_1_1.var_.characterEffect1075ui_actor = var_4_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_31 = 0.200000002980232

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 and not isNil(var_4_29) then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31

				if arg_1_1.var_.characterEffect1075ui_actor and not isNil(var_4_29) then
					arg_1_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 and not isNil(var_4_29) and arg_1_1.var_.characterEffect1075ui_actor then
				arg_1_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_4_33 = 0
			local var_4_34 = 0.616666666666667

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "music"

				arg_1_1:AudioAction(var_4_35, var_4_36, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_37 = ""
				local var_4_38 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_38 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_38 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_38

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_38
						arg_1_1.bgmTxt2_.text = var_4_38
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_39 = 1.7
			local var_4_40 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_41 = "play"
				local var_4_42 = "effect"

				arg_1_1:AudioAction(var_4_41, var_4_42, "se_story_side_1075", "se_story_side_1075_footstep_quiet", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_43 = 2
			local var_4_44 = 0.925

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_45 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_45:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_46 = arg_1_1:GetWordFromCfg(1107506001)
				local var_4_47 = arg_1_1:FormatText(var_4_46.content)

				arg_1_1.text_.text = var_4_47

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_48 = 37
				local var_4_49 = utf8.len(var_4_47)
				local var_4_50 = var_4_48 <= 0 and var_4_44 or var_4_44 * (var_4_49 / var_4_48)

				if var_4_50 > 0 and var_4_44 < var_4_50 then
					arg_1_1.talkMaxDuration = var_4_50
					var_4_43 = var_4_43 + 0.3

					if var_4_50 + var_4_43 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_50 + var_4_43
					end
				end

				arg_1_1.text_.text = var_4_47
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_51 = var_4_43 + 0.3
			local var_4_52 = math.max(var_4_44, arg_1_1.talkMaxDuration)

			if var_4_51 <= arg_1_1.time_ and arg_1_1.time_ < var_4_51 + var_4_52 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_51) / var_4_52

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_51 + var_4_52 and arg_1_1.time_ < var_4_51 + var_4_52 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1107506002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1107506002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1107506003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.125

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(1107506002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 45
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1107506003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1107506003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1107506004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.225

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_2 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(1107506003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 9
				local var_15_6 = utf8.len(var_15_4)
				local var_15_7 = var_15_5 <= 0 and var_15_1 or var_15_1 * (var_15_6 / var_15_5)

				if var_15_7 > 0 and var_15_1 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_4
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_8 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_8 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_8

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_8 and arg_12_1.time_ < var_15_0 + var_15_8 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1107506004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1107506004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1107506005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.725

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_2 = arg_16_1:GetWordFromCfg(1107506004)
				local var_19_3 = arg_16_1:FormatText(var_19_2.content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 29
				local var_19_5 = utf8.len(var_19_3)
				local var_19_6 = var_19_4 <= 0 and var_19_1 or var_19_1 * (var_19_5 / var_19_4)

				if var_19_6 > 0 and var_19_1 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_7 and arg_16_1.time_ < var_19_0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play1107506005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1107506005
		arg_20_1.duration_ = 9

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1107506006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "ST37a"

			if arg_20_1.bgs_[var_23_0] == nil then
				local var_23_1 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_23_0)
				var_23_1.name = var_23_0
				var_23_1.transform.parent = arg_20_1.stage_.transform
				var_23_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_[var_23_0] = var_23_1
			end

			local var_23_2 = 2

			if var_23_2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				local var_23_3 = manager.ui.mainCamera.transform.localPosition
				local var_23_4 = Vector3.New(0, 0, 10) + Vector3.New(var_23_3.x, var_23_3.y, 0)
				local var_23_5 = arg_20_1.bgs_.ST37a

				var_23_5.transform.localPosition = var_23_4
				var_23_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_6 = var_23_5:GetComponent("SpriteRenderer")

				if var_23_6 and var_23_6.sprite then
					local var_23_7 = (var_23_5.transform.localPosition - var_23_3).z
					local var_23_8 = manager.ui.mainCameraCom_
					local var_23_9 = 2 * var_23_7 * Mathf.Tan(var_23_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_23_10 = var_23_9 * var_23_8.aspect
					local var_23_11 = var_23_6.sprite.bounds.size.x
					local var_23_12 = var_23_6.sprite.bounds.size.y
					local var_23_13 = var_23_10 / var_23_11
					local var_23_14 = var_23_9 / var_23_12
					local var_23_15 = var_23_14 < var_23_13 and var_23_13 or var_23_14

					var_23_5.transform.localScale = Vector3.New(var_23_15, var_23_15, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "ST37a" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_16 = 3.999999999999

			if var_23_16 < arg_20_1.time_ and arg_20_1.time_ <= var_23_16 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_17 = 0.3

			if arg_20_1.time_ >= var_23_16 + var_23_17 and arg_20_1.time_ < var_23_16 + var_23_17 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_18 = 0

			if var_23_18 < arg_20_1.time_ and arg_20_1.time_ <= var_23_18 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_19 = 2

			if var_23_18 <= arg_20_1.time_ and arg_20_1.time_ < var_23_18 + var_23_19 then
				local var_23_20 = (arg_20_1.time_ - var_23_18) / var_23_19
				local var_23_21 = Color.New(0, 0, 0)

				var_23_21.a = Mathf.Lerp(0, 1, var_23_20)
				arg_20_1.mask_.color = var_23_21
			end

			if arg_20_1.time_ >= var_23_18 + var_23_19 and arg_20_1.time_ < var_23_18 + var_23_19 + arg_23_0 then
				local var_23_22 = Color.New(0, 0, 0)

				var_23_22.a = 1
				arg_20_1.mask_.color = var_23_22
			end

			local var_23_23 = 2

			if var_23_23 < arg_20_1.time_ and arg_20_1.time_ <= var_23_23 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_24 = 2

			if var_23_23 <= arg_20_1.time_ and arg_20_1.time_ < var_23_23 + var_23_24 then
				local var_23_25 = (arg_20_1.time_ - var_23_23) / var_23_24
				local var_23_26 = Color.New(0, 0, 0)

				var_23_26.a = Mathf.Lerp(1, 0, var_23_25)
				arg_20_1.mask_.color = var_23_26
			end

			if arg_20_1.time_ >= var_23_23 + var_23_24 and arg_20_1.time_ < var_23_23 + var_23_24 + arg_23_0 then
				local var_23_27 = Color.New(0, 0, 0)
				local var_23_28 = 0

				arg_20_1.mask_.enabled = false
				var_23_27.a = var_23_28
				arg_20_1.mask_.color = var_23_27
			end

			local var_23_29 = 0
			local var_23_30 = 0.616666666666667

			if var_23_29 < arg_20_1.time_ and arg_20_1.time_ <= var_23_29 + arg_23_0 then
				local var_23_31 = "play"
				local var_23_32 = "music"

				arg_20_1:AudioAction(var_23_31, var_23_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_23_33 = ""
				local var_23_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_23_34 ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_34 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_34

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_34
						arg_20_1.bgmTxt2_.text = var_23_34
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_23_35 = 1.23333333333333
			local var_23_36 = 1

			if var_23_35 < arg_20_1.time_ and arg_20_1.time_ <= var_23_35 + arg_23_0 then
				local var_23_37 = "play"
				local var_23_38 = "music"

				arg_20_1:AudioAction(var_23_37, var_23_38, "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_23_39 = ""
				local var_23_40 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if var_23_40 ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_40 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_40

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_40
						arg_20_1.bgmTxt2_.text = var_23_40
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_41 = 4
			local var_23_42 = 0.375

			if var_23_41 < arg_20_1.time_ and arg_20_1.time_ <= var_23_41 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_43 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_43:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_20_1.dialogCg_.alpha = arg_26_0
				end))
				var_23_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_44 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_45 = arg_20_1:GetWordFromCfg(1107506005)
				local var_23_46 = arg_20_1:FormatText(var_23_45.content)

				arg_20_1.text_.text = var_23_46

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_47 = 15
				local var_23_48 = utf8.len(var_23_46)
				local var_23_49 = var_23_47 <= 0 and var_23_42 or var_23_42 * (var_23_48 / var_23_47)

				if var_23_49 > 0 and var_23_42 < var_23_49 then
					arg_20_1.talkMaxDuration = var_23_49
					var_23_41 = var_23_41 + 0.3

					if var_23_49 + var_23_41 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_49 + var_23_41
					end
				end

				arg_20_1.text_.text = var_23_46
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_50 = var_23_41 + 0.3
			local var_23_51 = math.max(var_23_42, arg_20_1.talkMaxDuration)

			if var_23_50 <= arg_20_1.time_ and arg_20_1.time_ < var_23_50 + var_23_51 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_50) / var_23_51

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_50 + var_23_51 and arg_20_1.time_ < var_23_50 + var_23_51 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1107506006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1107506006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1107506007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(1107506006)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 40
				local var_31_5 = utf8.len(var_31_3)
				local var_31_6 = var_31_4 <= 0 and var_31_1 or var_31_1 * (var_31_5 / var_31_4)

				if var_31_6 > 0 and var_31_1 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_7 and arg_28_1.time_ < var_31_0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1107506007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1107506007
		arg_32_1.duration_ = 6.3

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1107506008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1075ui_actor"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1075ui_actor = var_35_0.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_3 then
				local var_35_4 = (arg_32_1.time_ - var_35_1) / var_35_3
				local var_35_5 = Vector3.New(0, -1.055, -6.16)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1075ui_actor, var_35_5, var_35_4)

				local var_35_6 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_6.x, var_35_6.y, var_35_6.z)

				local var_35_7 = var_35_0.localEulerAngles

				var_35_7.z = 0
				var_35_7.x = 0
				var_35_0.localEulerAngles = var_35_7
			end

			if arg_32_1.time_ >= var_35_1 + var_35_3 and arg_32_1.time_ < var_35_1 + var_35_3 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_35_8 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_8.x, var_35_8.y, var_35_8.z)

				local var_35_9 = var_35_0.localEulerAngles

				var_35_9.z = 0
				var_35_9.x = 0
				var_35_0.localEulerAngles = var_35_9

				local var_35_10 = GameObjectTools.GetOrAddComponent(var_35_0.gameObject, typeof(DynamicBoneHelper))

				if var_35_10 then
					var_35_10:EnableDynamicBone(true)
				end
			end

			local var_35_11 = arg_32_1.actors_["1075ui_actor"]
			local var_35_12 = 0

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 and not isNil(var_35_11) and arg_32_1.var_.characterEffect1075ui_actor == nil then
				arg_32_1.var_.characterEffect1075ui_actor = var_35_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_13 = 0.200000002980232

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_13 and not isNil(var_35_11) then
				local var_35_14 = (arg_32_1.time_ - var_35_12) / var_35_13

				if arg_32_1.var_.characterEffect1075ui_actor and not isNil(var_35_11) then
					arg_32_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_12 + var_35_13 and arg_32_1.time_ < var_35_12 + var_35_13 + arg_35_0 and not isNil(var_35_11) and arg_32_1.var_.characterEffect1075ui_actor then
				arg_32_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_35_16 = 0

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_35_17 = 0
			local var_35_18 = 0.425

			if var_35_17 < arg_32_1.time_ and arg_32_1.time_ <= var_35_17 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_19 = arg_32_1:FormatText(StoryNameCfg[381].name)

				arg_32_1.leftNameTxt_.text = var_35_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_20 = arg_32_1:GetWordFromCfg(1107506007)
				local var_35_21 = arg_32_1:FormatText(var_35_20.content)

				arg_32_1.text_.text = var_35_21

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_22 = 17
				local var_35_23 = utf8.len(var_35_21)
				local var_35_24 = var_35_22 <= 0 and var_35_18 or var_35_18 * (var_35_23 / var_35_22)

				if var_35_24 > 0 and var_35_18 < var_35_24 then
					arg_32_1.talkMaxDuration = var_35_24

					if var_35_24 + var_35_17 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_24 + var_35_17
					end
				end

				arg_32_1.text_.text = var_35_21
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506007", "story_v_side_new_1107506.awb") ~= 0 then
					local var_35_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506007", "story_v_side_new_1107506.awb") / 1000

					if var_35_25 + var_35_17 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_25 + var_35_17
					end

					if var_35_20.prefab_name ~= "" and arg_32_1.actors_[var_35_20.prefab_name] ~= nil then
						local var_35_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_20.prefab_name].transform, "story_v_side_new_1107506", "1107506007", "story_v_side_new_1107506.awb")

						arg_32_1:RecordAudio("1107506007", var_35_26)
						arg_32_1:RecordAudio("1107506007", var_35_26)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506007", "story_v_side_new_1107506.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506007", "story_v_side_new_1107506.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_27 = math.max(var_35_18, arg_32_1.talkMaxDuration)

			if var_35_17 <= arg_32_1.time_ and arg_32_1.time_ < var_35_17 + var_35_27 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_17) / var_35_27

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_17 + var_35_27 and arg_32_1.time_ < var_35_17 + var_35_27 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play1107506008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1107506008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1107506009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1075ui_actor"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1075ui_actor == nil then
				arg_36_1.var_.characterEffect1075ui_actor = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1075ui_actor and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_36_1.var_.characterEffect1075ui_actor.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1075ui_actor then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_36_1.var_.characterEffect1075ui_actor.fillRatio = var_39_5
			end

			local var_39_6 = 0
			local var_39_7 = 0.425

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[7].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_9 = arg_36_1:GetWordFromCfg(1107506008)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 17
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play1107506009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1107506009
		arg_40_1.duration_ = 3.7

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1107506010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1075ui_actor"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1075ui_actor == nil then
				arg_40_1.var_.characterEffect1075ui_actor = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1075ui_actor and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1075ui_actor then
				arg_40_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_43_4 = 0

			if var_43_4 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_43_6 = 0
			local var_43_7 = 0.325

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[381].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_9 = arg_40_1:GetWordFromCfg(1107506009)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 13
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506009", "story_v_side_new_1107506.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506009", "story_v_side_new_1107506.awb") / 1000

					if var_43_14 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_6
					end

					if var_43_9.prefab_name ~= "" and arg_40_1.actors_[var_43_9.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_9.prefab_name].transform, "story_v_side_new_1107506", "1107506009", "story_v_side_new_1107506.awb")

						arg_40_1:RecordAudio("1107506009", var_43_15)
						arg_40_1:RecordAudio("1107506009", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506009", "story_v_side_new_1107506.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506009", "story_v_side_new_1107506.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_16 and arg_40_1.time_ < var_43_6 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1107506010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1107506010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1107506011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1075ui_actor"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1075ui_actor == nil then
				arg_44_1.var_.characterEffect1075ui_actor = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1075ui_actor and not isNil(var_47_0) then
					local var_47_4 = Mathf.Lerp(0, 0.5, var_47_3)

					arg_44_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_44_1.var_.characterEffect1075ui_actor.fillRatio = var_47_4
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1075ui_actor then
				local var_47_5 = 0.5

				arg_44_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_44_1.var_.characterEffect1075ui_actor.fillRatio = var_47_5
			end

			local var_47_6 = 0
			local var_47_7 = 0.675

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[7].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_9 = arg_44_1:GetWordFromCfg(1107506010)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 27
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_14 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_14 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_14

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_14 and arg_44_1.time_ < var_47_6 + var_47_14 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1107506011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1107506011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1107506012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.35

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(1107506011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 14
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play1107506012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1107506012
		arg_52_1.duration_ = 5.3

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1107506013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1075ui_actor"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1075ui_actor == nil then
				arg_52_1.var_.characterEffect1075ui_actor = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1075ui_actor and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1075ui_actor then
				arg_52_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_55_4 = 0

			if var_55_4 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_2")
			end

			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_55_6 = 0
			local var_55_7 = 0.625

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[381].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_9 = arg_52_1:GetWordFromCfg(1107506012)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 25
				local var_55_12 = utf8.len(var_55_10)
				local var_55_13 = var_55_11 <= 0 and var_55_7 or var_55_7 * (var_55_12 / var_55_11)

				if var_55_13 > 0 and var_55_7 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506012", "story_v_side_new_1107506.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506012", "story_v_side_new_1107506.awb") / 1000

					if var_55_14 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_6
					end

					if var_55_9.prefab_name ~= "" and arg_52_1.actors_[var_55_9.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_9.prefab_name].transform, "story_v_side_new_1107506", "1107506012", "story_v_side_new_1107506.awb")

						arg_52_1:RecordAudio("1107506012", var_55_15)
						arg_52_1:RecordAudio("1107506012", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506012", "story_v_side_new_1107506.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506012", "story_v_side_new_1107506.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_16 and arg_52_1.time_ < var_55_6 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1107506013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1107506013
		arg_56_1.duration_ = 3.77

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1107506014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_59_2 = 0
			local var_59_3 = 0.325

			if var_59_2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_4 = arg_56_1:FormatText(StoryNameCfg[381].name)

				arg_56_1.leftNameTxt_.text = var_59_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_5 = arg_56_1:GetWordFromCfg(1107506013)
				local var_59_6 = arg_56_1:FormatText(var_59_5.content)

				arg_56_1.text_.text = var_59_6

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 13
				local var_59_8 = utf8.len(var_59_6)
				local var_59_9 = var_59_7 <= 0 and var_59_3 or var_59_3 * (var_59_8 / var_59_7)

				if var_59_9 > 0 and var_59_3 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_6
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506013", "story_v_side_new_1107506.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506013", "story_v_side_new_1107506.awb") / 1000

					if var_59_10 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_2
					end

					if var_59_5.prefab_name ~= "" and arg_56_1.actors_[var_59_5.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_5.prefab_name].transform, "story_v_side_new_1107506", "1107506013", "story_v_side_new_1107506.awb")

						arg_56_1:RecordAudio("1107506013", var_59_11)
						arg_56_1:RecordAudio("1107506013", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506013", "story_v_side_new_1107506.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506013", "story_v_side_new_1107506.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_12 and arg_56_1.time_ < var_59_2 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1107506014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1107506014
		arg_60_1.duration_ = 6.49

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1107506015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "ST47"

			if arg_60_1.bgs_[var_63_0] == nil then
				local var_63_1 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_63_0)
				var_63_1.name = var_63_0
				var_63_1.transform.parent = arg_60_1.stage_.transform
				var_63_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_[var_63_0] = var_63_1
			end

			local var_63_2 = 2.46666666666667

			if var_63_2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				local var_63_3 = manager.ui.mainCamera.transform.localPosition
				local var_63_4 = Vector3.New(0, 0, 10) + Vector3.New(var_63_3.x, var_63_3.y, 0)
				local var_63_5 = arg_60_1.bgs_.ST47

				var_63_5.transform.localPosition = var_63_4
				var_63_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_6 = var_63_5:GetComponent("SpriteRenderer")

				if var_63_6 and var_63_6.sprite then
					local var_63_7 = (var_63_5.transform.localPosition - var_63_3).z
					local var_63_8 = manager.ui.mainCameraCom_
					local var_63_9 = 2 * var_63_7 * Mathf.Tan(var_63_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_63_10 = var_63_9 * var_63_8.aspect
					local var_63_11 = var_63_6.sprite.bounds.size.x
					local var_63_12 = var_63_6.sprite.bounds.size.y
					local var_63_13 = var_63_10 / var_63_11
					local var_63_14 = var_63_9 / var_63_12
					local var_63_15 = var_63_14 < var_63_13 and var_63_13 or var_63_14

					var_63_5.transform.localScale = Vector3.New(var_63_15, var_63_15, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "ST47" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_16 = 5.066666

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			local var_63_17 = 0.3

			if arg_60_1.time_ >= var_63_16 + var_63_17 and arg_60_1.time_ < var_63_16 + var_63_17 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_18 = 0

			if var_63_18 < arg_60_1.time_ and arg_60_1.time_ <= var_63_18 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_19 = 2.5

			if var_63_18 <= arg_60_1.time_ and arg_60_1.time_ < var_63_18 + var_63_19 then
				local var_63_20 = (arg_60_1.time_ - var_63_18) / var_63_19
				local var_63_21 = Color.New(0, 0, 0)

				var_63_21.a = Mathf.Lerp(0, 1, var_63_20)
				arg_60_1.mask_.color = var_63_21
			end

			if arg_60_1.time_ >= var_63_18 + var_63_19 and arg_60_1.time_ < var_63_18 + var_63_19 + arg_63_0 then
				local var_63_22 = Color.New(0, 0, 0)

				var_63_22.a = 1
				arg_60_1.mask_.color = var_63_22
			end

			local var_63_23 = 2.5

			if var_63_23 < arg_60_1.time_ and arg_60_1.time_ <= var_63_23 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_24 = 2.566666

			if var_63_23 <= arg_60_1.time_ and arg_60_1.time_ < var_63_23 + var_63_24 then
				local var_63_25 = (arg_60_1.time_ - var_63_23) / var_63_24
				local var_63_26 = Color.New(0, 0, 0)

				var_63_26.a = Mathf.Lerp(1, 0, var_63_25)
				arg_60_1.mask_.color = var_63_26
			end

			if arg_60_1.time_ >= var_63_23 + var_63_24 and arg_60_1.time_ < var_63_23 + var_63_24 + arg_63_0 then
				local var_63_27 = Color.New(0, 0, 0)
				local var_63_28 = 0

				arg_60_1.mask_.enabled = false
				var_63_27.a = var_63_28
				arg_60_1.mask_.color = var_63_27
			end

			local var_63_29 = arg_60_1.actors_["1075ui_actor"].transform
			local var_63_30 = 1.96599999815226

			if var_63_30 < arg_60_1.time_ and arg_60_1.time_ <= var_63_30 + arg_63_0 then
				arg_60_1.var_.moveOldPos1075ui_actor = var_63_29.localPosition

				local var_63_31 = GameObjectTools.GetOrAddComponent(var_63_29.gameObject, typeof(DynamicBoneHelper))

				if var_63_31 then
					var_63_31:EnableDynamicBone(false)
				end
			end

			local var_63_32 = 0.001

			if var_63_30 <= arg_60_1.time_ and arg_60_1.time_ < var_63_30 + var_63_32 then
				local var_63_33 = (arg_60_1.time_ - var_63_30) / var_63_32
				local var_63_34 = Vector3.New(0, 100, 0)

				var_63_29.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1075ui_actor, var_63_34, var_63_33)

				local var_63_35 = manager.ui.mainCamera.transform.position - var_63_29.position

				var_63_29.forward = Vector3.New(var_63_35.x, var_63_35.y, var_63_35.z)

				local var_63_36 = var_63_29.localEulerAngles

				var_63_36.z = 0
				var_63_36.x = 0
				var_63_29.localEulerAngles = var_63_36
			end

			if arg_60_1.time_ >= var_63_30 + var_63_32 and arg_60_1.time_ < var_63_30 + var_63_32 + arg_63_0 then
				var_63_29.localPosition = Vector3.New(0, 100, 0)

				local var_63_37 = manager.ui.mainCamera.transform.position - var_63_29.position

				var_63_29.forward = Vector3.New(var_63_37.x, var_63_37.y, var_63_37.z)

				local var_63_38 = var_63_29.localEulerAngles

				var_63_38.z = 0
				var_63_38.x = 0
				var_63_29.localEulerAngles = var_63_38

				local var_63_39 = GameObjectTools.GetOrAddComponent(var_63_29.gameObject, typeof(DynamicBoneHelper))

				if var_63_39 then
					var_63_39:EnableDynamicBone(true)
				end
			end

			local var_63_40 = "10044ui_story"

			if arg_60_1.actors_[var_63_40] == nil then
				local var_63_41 = Asset.Load("Char/" .. "10044ui_story")

				if not isNil(var_63_41) then
					local var_63_42 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_60_1.stage_.transform)

					var_63_42.name = var_63_40
					var_63_42.transform.localPosition = Vector3.New(0, 100, 0)
					arg_60_1.actors_[var_63_40] = var_63_42

					local var_63_43 = var_63_42:GetComponentInChildren(typeof(CharacterEffect))

					var_63_43.enabled = true

					local var_63_44 = GameObjectTools.GetOrAddComponent(var_63_42, typeof(DynamicBoneHelper))

					if var_63_44 then
						var_63_44:EnableDynamicBone(false)
					end

					arg_60_1:ShowWeapon(var_63_43.transform, false)

					arg_60_1.var_[var_63_40 .. "Animator"] = var_63_43.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_60_1.var_[var_63_40 .. "Animator"].applyRootMotion = true
					arg_60_1.var_[var_63_40 .. "LipSync"] = var_63_43.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_63_45 = arg_60_1.actors_["10044ui_story"].transform
			local var_63_46 = 3.8

			if var_63_46 < arg_60_1.time_ and arg_60_1.time_ <= var_63_46 + arg_63_0 then
				arg_60_1.var_.moveOldPos10044ui_story = var_63_45.localPosition
			end

			local var_63_47 = 0.001

			if var_63_46 <= arg_60_1.time_ and arg_60_1.time_ < var_63_46 + var_63_47 then
				local var_63_48 = (arg_60_1.time_ - var_63_46) / var_63_47
				local var_63_49 = Vector3.New(0, -0.72, -6.3)

				var_63_45.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10044ui_story, var_63_49, var_63_48)

				local var_63_50 = manager.ui.mainCamera.transform.position - var_63_45.position

				var_63_45.forward = Vector3.New(var_63_50.x, var_63_50.y, var_63_50.z)

				local var_63_51 = var_63_45.localEulerAngles

				var_63_51.z = 0
				var_63_51.x = 0
				var_63_45.localEulerAngles = var_63_51
			end

			if arg_60_1.time_ >= var_63_46 + var_63_47 and arg_60_1.time_ < var_63_46 + var_63_47 + arg_63_0 then
				var_63_45.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_63_52 = manager.ui.mainCamera.transform.position - var_63_45.position

				var_63_45.forward = Vector3.New(var_63_52.x, var_63_52.y, var_63_52.z)

				local var_63_53 = var_63_45.localEulerAngles

				var_63_53.z = 0
				var_63_53.x = 0
				var_63_45.localEulerAngles = var_63_53
			end

			local var_63_54 = arg_60_1.actors_["10044ui_story"]
			local var_63_55 = 3.8

			if var_63_55 < arg_60_1.time_ and arg_60_1.time_ <= var_63_55 + arg_63_0 and not isNil(var_63_54) and arg_60_1.var_.characterEffect10044ui_story == nil then
				arg_60_1.var_.characterEffect10044ui_story = var_63_54:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_56 = 0.200000002980232

			if var_63_55 <= arg_60_1.time_ and arg_60_1.time_ < var_63_55 + var_63_56 and not isNil(var_63_54) then
				local var_63_57 = (arg_60_1.time_ - var_63_55) / var_63_56

				if arg_60_1.var_.characterEffect10044ui_story and not isNil(var_63_54) then
					arg_60_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_55 + var_63_56 and arg_60_1.time_ < var_63_55 + var_63_56 + arg_63_0 and not isNil(var_63_54) and arg_60_1.var_.characterEffect10044ui_story then
				arg_60_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_63_58 = arg_60_1.actors_["1075ui_actor"]
			local var_63_59 = 1.98333333333333

			if var_63_59 < arg_60_1.time_ and arg_60_1.time_ <= var_63_59 + arg_63_0 and not isNil(var_63_58) and arg_60_1.var_.characterEffect1075ui_actor == nil then
				arg_60_1.var_.characterEffect1075ui_actor = var_63_58:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_60 = 0.0166666666666666

			if var_63_59 <= arg_60_1.time_ and arg_60_1.time_ < var_63_59 + var_63_60 and not isNil(var_63_58) then
				local var_63_61 = (arg_60_1.time_ - var_63_59) / var_63_60

				if arg_60_1.var_.characterEffect1075ui_actor and not isNil(var_63_58) then
					local var_63_62 = Mathf.Lerp(0, 0.5, var_63_61)

					arg_60_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_60_1.var_.characterEffect1075ui_actor.fillRatio = var_63_62
				end
			end

			if arg_60_1.time_ >= var_63_59 + var_63_60 and arg_60_1.time_ < var_63_59 + var_63_60 + arg_63_0 and not isNil(var_63_58) and arg_60_1.var_.characterEffect1075ui_actor then
				local var_63_63 = 0.5

				arg_60_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_60_1.var_.characterEffect1075ui_actor.fillRatio = var_63_63
			end

			local var_63_64 = 3.8

			if var_63_64 < arg_60_1.time_ and arg_60_1.time_ <= var_63_64 + arg_63_0 then
				arg_60_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_63_65 = 3.8

			if var_63_65 < arg_60_1.time_ and arg_60_1.time_ <= var_63_65 + arg_63_0 then
				arg_60_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_63_66 = 2.5

			arg_60_1.isInRecall_ = false

			if var_63_66 < arg_60_1.time_ and arg_60_1.time_ <= var_63_66 + arg_63_0 then
				arg_60_1.screenFilterGo_:SetActive(true)

				arg_60_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_63_2, iter_63_3 in pairs(arg_60_1.actors_) do
					local var_63_67 = iter_63_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_63_4, iter_63_5 in ipairs(var_63_67) do
						if iter_63_5.color.r > 0.51 then
							iter_63_5.color = Color.New(1, 1, 1)
						else
							iter_63_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_63_68 = 0.0333333333333332

			if var_63_66 <= arg_60_1.time_ and arg_60_1.time_ < var_63_66 + var_63_68 then
				local var_63_69 = (arg_60_1.time_ - var_63_66) / var_63_68

				arg_60_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_63_69)
			end

			if arg_60_1.time_ >= var_63_66 + var_63_68 and arg_60_1.time_ < var_63_66 + var_63_68 + arg_63_0 then
				arg_60_1.screenFilterEffect_.weight = 1
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_70 = 4.891666
			local var_63_71 = 0.175

			if var_63_70 < arg_60_1.time_ and arg_60_1.time_ <= var_63_70 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_72 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_72:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_73 = arg_60_1:FormatText(StoryNameCfg[380].name)

				arg_60_1.leftNameTxt_.text = var_63_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_74 = arg_60_1:GetWordFromCfg(1107506014)
				local var_63_75 = arg_60_1:FormatText(var_63_74.content)

				arg_60_1.text_.text = var_63_75

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_76 = 7
				local var_63_77 = utf8.len(var_63_75)
				local var_63_78 = var_63_76 <= 0 and var_63_71 or var_63_71 * (var_63_77 / var_63_76)

				if var_63_78 > 0 and var_63_71 < var_63_78 then
					arg_60_1.talkMaxDuration = var_63_78
					var_63_70 = var_63_70 + 0.3

					if var_63_78 + var_63_70 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_78 + var_63_70
					end
				end

				arg_60_1.text_.text = var_63_75
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506014", "story_v_side_new_1107506.awb") ~= 0 then
					local var_63_79 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506014", "story_v_side_new_1107506.awb") / 1000

					if var_63_79 + var_63_70 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_79 + var_63_70
					end

					if var_63_74.prefab_name ~= "" and arg_60_1.actors_[var_63_74.prefab_name] ~= nil then
						local var_63_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_74.prefab_name].transform, "story_v_side_new_1107506", "1107506014", "story_v_side_new_1107506.awb")

						arg_60_1:RecordAudio("1107506014", var_63_80)
						arg_60_1:RecordAudio("1107506014", var_63_80)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506014", "story_v_side_new_1107506.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506014", "story_v_side_new_1107506.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_81 = var_63_70 + 0.3
			local var_63_82 = math.max(var_63_71, arg_60_1.talkMaxDuration)

			if var_63_81 <= arg_60_1.time_ and arg_60_1.time_ < var_63_81 + var_63_82 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_81) / var_63_82

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_81 + var_63_82 and arg_60_1.time_ < var_63_81 + var_63_82 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play1107506015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 1107506015
		arg_66_1.duration_ = 3.7

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play1107506016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["10044ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos10044ui_story = var_69_0.localPosition
			end

			local var_69_2 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2
				local var_69_4 = Vector3.New(-0.7, -0.72, -6.3)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10044ui_story, var_69_4, var_69_3)

				local var_69_5 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_5.x, var_69_5.y, var_69_5.z)

				local var_69_6 = var_69_0.localEulerAngles

				var_69_6.z = 0
				var_69_6.x = 0
				var_69_0.localEulerAngles = var_69_6
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_69_7 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_7.x, var_69_7.y, var_69_7.z)

				local var_69_8 = var_69_0.localEulerAngles

				var_69_8.z = 0
				var_69_8.x = 0
				var_69_0.localEulerAngles = var_69_8
			end

			local var_69_9 = arg_66_1.actors_["1075ui_actor"].transform
			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1.var_.moveOldPos1075ui_actor = var_69_9.localPosition

				local var_69_11 = GameObjectTools.GetOrAddComponent(var_69_9.gameObject, typeof(DynamicBoneHelper))

				if var_69_11 then
					var_69_11:EnableDynamicBone(false)
				end
			end

			local var_69_12 = 0.001

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_12 then
				local var_69_13 = (arg_66_1.time_ - var_69_10) / var_69_12
				local var_69_14 = Vector3.New(0.7, -1.055, -6.16)

				var_69_9.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1075ui_actor, var_69_14, var_69_13)

				local var_69_15 = manager.ui.mainCamera.transform.position - var_69_9.position

				var_69_9.forward = Vector3.New(var_69_15.x, var_69_15.y, var_69_15.z)

				local var_69_16 = var_69_9.localEulerAngles

				var_69_16.z = 0
				var_69_16.x = 0
				var_69_9.localEulerAngles = var_69_16
			end

			if arg_66_1.time_ >= var_69_10 + var_69_12 and arg_66_1.time_ < var_69_10 + var_69_12 + arg_69_0 then
				var_69_9.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_69_17 = manager.ui.mainCamera.transform.position - var_69_9.position

				var_69_9.forward = Vector3.New(var_69_17.x, var_69_17.y, var_69_17.z)

				local var_69_18 = var_69_9.localEulerAngles

				var_69_18.z = 0
				var_69_18.x = 0
				var_69_9.localEulerAngles = var_69_18

				local var_69_19 = GameObjectTools.GetOrAddComponent(var_69_9.gameObject, typeof(DynamicBoneHelper))

				if var_69_19 then
					var_69_19:EnableDynamicBone(true)
				end
			end

			local var_69_20 = arg_66_1.actors_["1075ui_actor"]
			local var_69_21 = 0

			if var_69_21 < arg_66_1.time_ and arg_66_1.time_ <= var_69_21 + arg_69_0 and not isNil(var_69_20) and arg_66_1.var_.characterEffect1075ui_actor == nil then
				arg_66_1.var_.characterEffect1075ui_actor = var_69_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_22 = 0.200000002980232

			if var_69_21 <= arg_66_1.time_ and arg_66_1.time_ < var_69_21 + var_69_22 and not isNil(var_69_20) then
				local var_69_23 = (arg_66_1.time_ - var_69_21) / var_69_22

				if arg_66_1.var_.characterEffect1075ui_actor and not isNil(var_69_20) then
					arg_66_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_21 + var_69_22 and arg_66_1.time_ < var_69_21 + var_69_22 + arg_69_0 and not isNil(var_69_20) and arg_66_1.var_.characterEffect1075ui_actor then
				arg_66_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_69_24 = arg_66_1.actors_["10044ui_story"]
			local var_69_25 = 0

			if var_69_25 < arg_66_1.time_ and arg_66_1.time_ <= var_69_25 + arg_69_0 and not isNil(var_69_24) and arg_66_1.var_.characterEffect10044ui_story == nil then
				arg_66_1.var_.characterEffect10044ui_story = var_69_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_26 = 0.200000002980232

			if var_69_25 <= arg_66_1.time_ and arg_66_1.time_ < var_69_25 + var_69_26 and not isNil(var_69_24) then
				local var_69_27 = (arg_66_1.time_ - var_69_25) / var_69_26

				if arg_66_1.var_.characterEffect10044ui_story and not isNil(var_69_24) then
					local var_69_28 = Mathf.Lerp(0, 0.5, var_69_27)

					arg_66_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_66_1.var_.characterEffect10044ui_story.fillRatio = var_69_28
				end
			end

			if arg_66_1.time_ >= var_69_25 + var_69_26 and arg_66_1.time_ < var_69_25 + var_69_26 + arg_69_0 and not isNil(var_69_24) and arg_66_1.var_.characterEffect10044ui_story then
				local var_69_29 = 0.5

				arg_66_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_66_1.var_.characterEffect10044ui_story.fillRatio = var_69_29
			end

			local var_69_30 = 0

			if var_69_30 < arg_66_1.time_ and arg_66_1.time_ <= var_69_30 + arg_69_0 then
				arg_66_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_69_31 = 0

			if var_69_31 < arg_66_1.time_ and arg_66_1.time_ <= var_69_31 + arg_69_0 then
				arg_66_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_69_32 = 0
			local var_69_33 = 0.375

			if var_69_32 < arg_66_1.time_ and arg_66_1.time_ <= var_69_32 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_34 = arg_66_1:FormatText(StoryNameCfg[381].name)

				arg_66_1.leftNameTxt_.text = var_69_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_35 = arg_66_1:GetWordFromCfg(1107506015)
				local var_69_36 = arg_66_1:FormatText(var_69_35.content)

				arg_66_1.text_.text = var_69_36

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_37 = 15
				local var_69_38 = utf8.len(var_69_36)
				local var_69_39 = var_69_37 <= 0 and var_69_33 or var_69_33 * (var_69_38 / var_69_37)

				if var_69_39 > 0 and var_69_33 < var_69_39 then
					arg_66_1.talkMaxDuration = var_69_39

					if var_69_39 + var_69_32 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_39 + var_69_32
					end
				end

				arg_66_1.text_.text = var_69_36
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506015", "story_v_side_new_1107506.awb") ~= 0 then
					local var_69_40 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506015", "story_v_side_new_1107506.awb") / 1000

					if var_69_40 + var_69_32 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_40 + var_69_32
					end

					if var_69_35.prefab_name ~= "" and arg_66_1.actors_[var_69_35.prefab_name] ~= nil then
						local var_69_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_35.prefab_name].transform, "story_v_side_new_1107506", "1107506015", "story_v_side_new_1107506.awb")

						arg_66_1:RecordAudio("1107506015", var_69_41)
						arg_66_1:RecordAudio("1107506015", var_69_41)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506015", "story_v_side_new_1107506.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506015", "story_v_side_new_1107506.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_42 = math.max(var_69_33, arg_66_1.talkMaxDuration)

			if var_69_32 <= arg_66_1.time_ and arg_66_1.time_ < var_69_32 + var_69_42 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_32) / var_69_42

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_32 + var_69_42 and arg_66_1.time_ < var_69_32 + var_69_42 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_actor",
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
	Play1107506016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 1107506016
		arg_70_1.duration_ = 5.77

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play1107506017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10044ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10044ui_story == nil then
				arg_70_1.var_.characterEffect10044ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect10044ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10044ui_story then
				arg_70_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["1075ui_actor"]
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1075ui_actor == nil then
				arg_70_1.var_.characterEffect1075ui_actor = var_73_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.200000002980232

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 and not isNil(var_73_4) then
				local var_73_7 = (arg_70_1.time_ - var_73_5) / var_73_6

				if arg_70_1.var_.characterEffect1075ui_actor and not isNil(var_73_4) then
					local var_73_8 = Mathf.Lerp(0, 0.5, var_73_7)

					arg_70_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_70_1.var_.characterEffect1075ui_actor.fillRatio = var_73_8
				end
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1075ui_actor then
				local var_73_9 = 0.5

				arg_70_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_70_1.var_.characterEffect1075ui_actor.fillRatio = var_73_9
			end

			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action435")
			end

			local var_73_11 = 0

			if var_73_11 < arg_70_1.time_ and arg_70_1.time_ <= var_73_11 + arg_73_0 then
				arg_70_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_73_12 = 0
			local var_73_13 = 0.675

			if var_73_12 < arg_70_1.time_ and arg_70_1.time_ <= var_73_12 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_14 = arg_70_1:FormatText(StoryNameCfg[380].name)

				arg_70_1.leftNameTxt_.text = var_73_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_15 = arg_70_1:GetWordFromCfg(1107506016)
				local var_73_16 = arg_70_1:FormatText(var_73_15.content)

				arg_70_1.text_.text = var_73_16

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_17 = 27
				local var_73_18 = utf8.len(var_73_16)
				local var_73_19 = var_73_17 <= 0 and var_73_13 or var_73_13 * (var_73_18 / var_73_17)

				if var_73_19 > 0 and var_73_13 < var_73_19 then
					arg_70_1.talkMaxDuration = var_73_19

					if var_73_19 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_19 + var_73_12
					end
				end

				arg_70_1.text_.text = var_73_16
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506016", "story_v_side_new_1107506.awb") ~= 0 then
					local var_73_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506016", "story_v_side_new_1107506.awb") / 1000

					if var_73_20 + var_73_12 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_20 + var_73_12
					end

					if var_73_15.prefab_name ~= "" and arg_70_1.actors_[var_73_15.prefab_name] ~= nil then
						local var_73_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_15.prefab_name].transform, "story_v_side_new_1107506", "1107506016", "story_v_side_new_1107506.awb")

						arg_70_1:RecordAudio("1107506016", var_73_21)
						arg_70_1:RecordAudio("1107506016", var_73_21)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506016", "story_v_side_new_1107506.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506016", "story_v_side_new_1107506.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_22 = math.max(var_73_13, arg_70_1.talkMaxDuration)

			if var_73_12 <= arg_70_1.time_ and arg_70_1.time_ < var_73_12 + var_73_22 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_12) / var_73_22

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_12 + var_73_22 and arg_70_1.time_ < var_73_12 + var_73_22 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play1107506017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 1107506017
		arg_74_1.duration_ = 8.1

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play1107506018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1075ui_actor"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1075ui_actor == nil then
				arg_74_1.var_.characterEffect1075ui_actor = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1075ui_actor and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1075ui_actor then
				arg_74_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_77_4 = arg_74_1.actors_["10044ui_story"]
			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect10044ui_story == nil then
				arg_74_1.var_.characterEffect10044ui_story = var_77_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_6 = 0.200000002980232

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_6 and not isNil(var_77_4) then
				local var_77_7 = (arg_74_1.time_ - var_77_5) / var_77_6

				if arg_74_1.var_.characterEffect10044ui_story and not isNil(var_77_4) then
					local var_77_8 = Mathf.Lerp(0, 0.5, var_77_7)

					arg_74_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_74_1.var_.characterEffect10044ui_story.fillRatio = var_77_8
				end
			end

			if arg_74_1.time_ >= var_77_5 + var_77_6 and arg_74_1.time_ < var_77_5 + var_77_6 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect10044ui_story then
				local var_77_9 = 0.5

				arg_74_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_74_1.var_.characterEffect10044ui_story.fillRatio = var_77_9
			end

			local var_77_10 = 0

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_77_11 = 0

			if var_77_11 < arg_74_1.time_ and arg_74_1.time_ <= var_77_11 + arg_77_0 then
				arg_74_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_77_12 = 0
			local var_77_13 = 0.825

			if var_77_12 < arg_74_1.time_ and arg_74_1.time_ <= var_77_12 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_14 = arg_74_1:FormatText(StoryNameCfg[381].name)

				arg_74_1.leftNameTxt_.text = var_77_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_15 = arg_74_1:GetWordFromCfg(1107506017)
				local var_77_16 = arg_74_1:FormatText(var_77_15.content)

				arg_74_1.text_.text = var_77_16

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_17 = 33
				local var_77_18 = utf8.len(var_77_16)
				local var_77_19 = var_77_17 <= 0 and var_77_13 or var_77_13 * (var_77_18 / var_77_17)

				if var_77_19 > 0 and var_77_13 < var_77_19 then
					arg_74_1.talkMaxDuration = var_77_19

					if var_77_19 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_19 + var_77_12
					end
				end

				arg_74_1.text_.text = var_77_16
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506017", "story_v_side_new_1107506.awb") ~= 0 then
					local var_77_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506017", "story_v_side_new_1107506.awb") / 1000

					if var_77_20 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_20 + var_77_12
					end

					if var_77_15.prefab_name ~= "" and arg_74_1.actors_[var_77_15.prefab_name] ~= nil then
						local var_77_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_15.prefab_name].transform, "story_v_side_new_1107506", "1107506017", "story_v_side_new_1107506.awb")

						arg_74_1:RecordAudio("1107506017", var_77_21)
						arg_74_1:RecordAudio("1107506017", var_77_21)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506017", "story_v_side_new_1107506.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506017", "story_v_side_new_1107506.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_22 = math.max(var_77_13, arg_74_1.talkMaxDuration)

			if var_77_12 <= arg_74_1.time_ and arg_74_1.time_ < var_77_12 + var_77_22 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_12) / var_77_22

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_12 + var_77_22 and arg_74_1.time_ < var_77_12 + var_77_22 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play1107506018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 1107506018
		arg_78_1.duration_ = 6.57

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play1107506019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10044ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10044ui_story == nil then
				arg_78_1.var_.characterEffect10044ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect10044ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10044ui_story then
				arg_78_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_81_4 = arg_78_1.actors_["1075ui_actor"]
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect1075ui_actor == nil then
				arg_78_1.var_.characterEffect1075ui_actor = var_81_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_6 = 0.200000002980232

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_6 and not isNil(var_81_4) then
				local var_81_7 = (arg_78_1.time_ - var_81_5) / var_81_6

				if arg_78_1.var_.characterEffect1075ui_actor and not isNil(var_81_4) then
					local var_81_8 = Mathf.Lerp(0, 0.5, var_81_7)

					arg_78_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_78_1.var_.characterEffect1075ui_actor.fillRatio = var_81_8
				end
			end

			if arg_78_1.time_ >= var_81_5 + var_81_6 and arg_78_1.time_ < var_81_5 + var_81_6 + arg_81_0 and not isNil(var_81_4) and arg_78_1.var_.characterEffect1075ui_actor then
				local var_81_9 = 0.5

				arg_78_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_78_1.var_.characterEffect1075ui_actor.fillRatio = var_81_9
			end

			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_2")
			end

			local var_81_11 = 0

			if var_81_11 < arg_78_1.time_ and arg_78_1.time_ <= var_81_11 + arg_81_0 then
				arg_78_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_81_12 = 0
			local var_81_13 = 0.725

			if var_81_12 < arg_78_1.time_ and arg_78_1.time_ <= var_81_12 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_14 = arg_78_1:FormatText(StoryNameCfg[380].name)

				arg_78_1.leftNameTxt_.text = var_81_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_15 = arg_78_1:GetWordFromCfg(1107506018)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506018", "story_v_side_new_1107506.awb") ~= 0 then
					local var_81_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506018", "story_v_side_new_1107506.awb") / 1000

					if var_81_20 + var_81_12 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_20 + var_81_12
					end

					if var_81_15.prefab_name ~= "" and arg_78_1.actors_[var_81_15.prefab_name] ~= nil then
						local var_81_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_15.prefab_name].transform, "story_v_side_new_1107506", "1107506018", "story_v_side_new_1107506.awb")

						arg_78_1:RecordAudio("1107506018", var_81_21)
						arg_78_1:RecordAudio("1107506018", var_81_21)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506018", "story_v_side_new_1107506.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506018", "story_v_side_new_1107506.awb")
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
	Play1107506019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 1107506019
		arg_82_1.duration_ = 6.57

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play1107506020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_85_2 = 0
			local var_85_3 = 0.9

			if var_85_2 < arg_82_1.time_ and arg_82_1.time_ <= var_85_2 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_4 = arg_82_1:FormatText(StoryNameCfg[380].name)

				arg_82_1.leftNameTxt_.text = var_85_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_5 = arg_82_1:GetWordFromCfg(1107506019)
				local var_85_6 = arg_82_1:FormatText(var_85_5.content)

				arg_82_1.text_.text = var_85_6

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_7 = 36
				local var_85_8 = utf8.len(var_85_6)
				local var_85_9 = var_85_7 <= 0 and var_85_3 or var_85_3 * (var_85_8 / var_85_7)

				if var_85_9 > 0 and var_85_3 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_2
					end
				end

				arg_82_1.text_.text = var_85_6
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506019", "story_v_side_new_1107506.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506019", "story_v_side_new_1107506.awb") / 1000

					if var_85_10 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_2
					end

					if var_85_5.prefab_name ~= "" and arg_82_1.actors_[var_85_5.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_5.prefab_name].transform, "story_v_side_new_1107506", "1107506019", "story_v_side_new_1107506.awb")

						arg_82_1:RecordAudio("1107506019", var_85_11)
						arg_82_1:RecordAudio("1107506019", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506019", "story_v_side_new_1107506.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506019", "story_v_side_new_1107506.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_12 = math.max(var_85_3, arg_82_1.talkMaxDuration)

			if var_85_2 <= arg_82_1.time_ and arg_82_1.time_ < var_85_2 + var_85_12 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_2) / var_85_12

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_2 + var_85_12 and arg_82_1.time_ < var_85_2 + var_85_12 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play1107506020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 1107506020
		arg_86_1.duration_ = 3.37

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play1107506021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1075ui_actor"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1075ui_actor == nil then
				arg_86_1.var_.characterEffect1075ui_actor = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1075ui_actor and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1075ui_actor then
				arg_86_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_89_4 = arg_86_1.actors_["10044ui_story"]
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10044ui_story == nil then
				arg_86_1.var_.characterEffect10044ui_story = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.200000002980232

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 and not isNil(var_89_4) then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6

				if arg_86_1.var_.characterEffect10044ui_story and not isNil(var_89_4) then
					local var_89_8 = Mathf.Lerp(0, 0.5, var_89_7)

					arg_86_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10044ui_story.fillRatio = var_89_8
				end
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect10044ui_story then
				local var_89_9 = 0.5

				arg_86_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10044ui_story.fillRatio = var_89_9
			end

			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action454")
			end

			local var_89_11 = 0

			if var_89_11 < arg_86_1.time_ and arg_86_1.time_ <= var_89_11 + arg_89_0 then
				arg_86_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_89_12 = 0
			local var_89_13 = 0.3

			if var_89_12 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_14 = arg_86_1:FormatText(StoryNameCfg[381].name)

				arg_86_1.leftNameTxt_.text = var_89_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_15 = arg_86_1:GetWordFromCfg(1107506020)
				local var_89_16 = arg_86_1:FormatText(var_89_15.content)

				arg_86_1.text_.text = var_89_16

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_17 = 12
				local var_89_18 = utf8.len(var_89_16)
				local var_89_19 = var_89_17 <= 0 and var_89_13 or var_89_13 * (var_89_18 / var_89_17)

				if var_89_19 > 0 and var_89_13 < var_89_19 then
					arg_86_1.talkMaxDuration = var_89_19

					if var_89_19 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_19 + var_89_12
					end
				end

				arg_86_1.text_.text = var_89_16
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506020", "story_v_side_new_1107506.awb") ~= 0 then
					local var_89_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506020", "story_v_side_new_1107506.awb") / 1000

					if var_89_20 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_20 + var_89_12
					end

					if var_89_15.prefab_name ~= "" and arg_86_1.actors_[var_89_15.prefab_name] ~= nil then
						local var_89_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_15.prefab_name].transform, "story_v_side_new_1107506", "1107506020", "story_v_side_new_1107506.awb")

						arg_86_1:RecordAudio("1107506020", var_89_21)
						arg_86_1:RecordAudio("1107506020", var_89_21)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506020", "story_v_side_new_1107506.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506020", "story_v_side_new_1107506.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_22 = math.max(var_89_13, arg_86_1.talkMaxDuration)

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_22 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_12) / var_89_22

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_12 + var_89_22 and arg_86_1.time_ < var_89_12 + var_89_22 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play1107506021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1107506021
		arg_90_1.duration_ = 3.43

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play1107506022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["10044ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect10044ui_story == nil then
				arg_90_1.var_.characterEffect10044ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect10044ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect10044ui_story then
				arg_90_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_93_4 = arg_90_1.actors_["1075ui_actor"]
			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect1075ui_actor == nil then
				arg_90_1.var_.characterEffect1075ui_actor = var_93_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_6 = 0.200000002980232

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_6 and not isNil(var_93_4) then
				local var_93_7 = (arg_90_1.time_ - var_93_5) / var_93_6

				if arg_90_1.var_.characterEffect1075ui_actor and not isNil(var_93_4) then
					local var_93_8 = Mathf.Lerp(0, 0.5, var_93_7)

					arg_90_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_90_1.var_.characterEffect1075ui_actor.fillRatio = var_93_8
				end
			end

			if arg_90_1.time_ >= var_93_5 + var_93_6 and arg_90_1.time_ < var_93_5 + var_93_6 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect1075ui_actor then
				local var_93_9 = 0.5

				arg_90_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_90_1.var_.characterEffect1075ui_actor.fillRatio = var_93_9
			end

			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 then
				arg_90_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_93_11 = 0

			if var_93_11 < arg_90_1.time_ and arg_90_1.time_ <= var_93_11 + arg_93_0 then
				arg_90_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_93_12 = 0
			local var_93_13 = 0.375

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_14 = arg_90_1:FormatText(StoryNameCfg[380].name)

				arg_90_1.leftNameTxt_.text = var_93_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_15 = arg_90_1:GetWordFromCfg(1107506021)
				local var_93_16 = arg_90_1:FormatText(var_93_15.content)

				arg_90_1.text_.text = var_93_16

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_17 = 15
				local var_93_18 = utf8.len(var_93_16)
				local var_93_19 = var_93_17 <= 0 and var_93_13 or var_93_13 * (var_93_18 / var_93_17)

				if var_93_19 > 0 and var_93_13 < var_93_19 then
					arg_90_1.talkMaxDuration = var_93_19

					if var_93_19 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_19 + var_93_12
					end
				end

				arg_90_1.text_.text = var_93_16
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506021", "story_v_side_new_1107506.awb") ~= 0 then
					local var_93_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506021", "story_v_side_new_1107506.awb") / 1000

					if var_93_20 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_20 + var_93_12
					end

					if var_93_15.prefab_name ~= "" and arg_90_1.actors_[var_93_15.prefab_name] ~= nil then
						local var_93_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_15.prefab_name].transform, "story_v_side_new_1107506", "1107506021", "story_v_side_new_1107506.awb")

						arg_90_1:RecordAudio("1107506021", var_93_21)
						arg_90_1:RecordAudio("1107506021", var_93_21)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506021", "story_v_side_new_1107506.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506021", "story_v_side_new_1107506.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_22 = math.max(var_93_13, arg_90_1.talkMaxDuration)

			if var_93_12 <= arg_90_1.time_ and arg_90_1.time_ < var_93_12 + var_93_22 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_12) / var_93_22

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_12 + var_93_22 and arg_90_1.time_ < var_93_12 + var_93_22 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play1107506022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 1107506022
		arg_94_1.duration_ = 4.4

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play1107506023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1075ui_actor"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1075ui_actor == nil then
				arg_94_1.var_.characterEffect1075ui_actor = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1075ui_actor and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1075ui_actor then
				arg_94_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["10044ui_story"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect10044ui_story == nil then
				arg_94_1.var_.characterEffect10044ui_story = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.200000002980232

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect10044ui_story and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_94_1.var_.characterEffect10044ui_story.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect10044ui_story then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_94_1.var_.characterEffect10044ui_story.fillRatio = var_97_9
			end

			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_97_11 = 0

			if var_97_11 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_97_12 = 0
			local var_97_13 = 0.3

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_14 = arg_94_1:FormatText(StoryNameCfg[381].name)

				arg_94_1.leftNameTxt_.text = var_97_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_15 = arg_94_1:GetWordFromCfg(1107506022)
				local var_97_16 = arg_94_1:FormatText(var_97_15.content)

				arg_94_1.text_.text = var_97_16

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_17 = 12
				local var_97_18 = utf8.len(var_97_16)
				local var_97_19 = var_97_17 <= 0 and var_97_13 or var_97_13 * (var_97_18 / var_97_17)

				if var_97_19 > 0 and var_97_13 < var_97_19 then
					arg_94_1.talkMaxDuration = var_97_19

					if var_97_19 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_19 + var_97_12
					end
				end

				arg_94_1.text_.text = var_97_16
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506022", "story_v_side_new_1107506.awb") ~= 0 then
					local var_97_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506022", "story_v_side_new_1107506.awb") / 1000

					if var_97_20 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_20 + var_97_12
					end

					if var_97_15.prefab_name ~= "" and arg_94_1.actors_[var_97_15.prefab_name] ~= nil then
						local var_97_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_15.prefab_name].transform, "story_v_side_new_1107506", "1107506022", "story_v_side_new_1107506.awb")

						arg_94_1:RecordAudio("1107506022", var_97_21)
						arg_94_1:RecordAudio("1107506022", var_97_21)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506022", "story_v_side_new_1107506.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506022", "story_v_side_new_1107506.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_22 = math.max(var_97_13, arg_94_1.talkMaxDuration)

			if var_97_12 <= arg_94_1.time_ and arg_94_1.time_ < var_97_12 + var_97_22 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_12) / var_97_22

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_12 + var_97_22 and arg_94_1.time_ < var_97_12 + var_97_22 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play1107506023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1107506023
		arg_98_1.duration_ = 9

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play1107506024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 2

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				local var_101_1 = manager.ui.mainCamera.transform.localPosition
				local var_101_2 = Vector3.New(0, 0, 10) + Vector3.New(var_101_1.x, var_101_1.y, 0)
				local var_101_3 = arg_98_1.bgs_.ST37a

				var_101_3.transform.localPosition = var_101_2
				var_101_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_4 = var_101_3:GetComponent("SpriteRenderer")

				if var_101_4 and var_101_4.sprite then
					local var_101_5 = (var_101_3.transform.localPosition - var_101_1).z
					local var_101_6 = manager.ui.mainCameraCom_
					local var_101_7 = 2 * var_101_5 * Mathf.Tan(var_101_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_101_8 = var_101_7 * var_101_6.aspect
					local var_101_9 = var_101_4.sprite.bounds.size.x
					local var_101_10 = var_101_4.sprite.bounds.size.y
					local var_101_11 = var_101_8 / var_101_9
					local var_101_12 = var_101_7 / var_101_10
					local var_101_13 = var_101_12 < var_101_11 and var_101_11 or var_101_12

					var_101_3.transform.localScale = Vector3.New(var_101_13, var_101_13, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "ST37a" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_14 = 4

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			local var_101_15 = 0.3

			if arg_98_1.time_ >= var_101_14 + var_101_15 and arg_98_1.time_ < var_101_14 + var_101_15 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_16 = 0

			if var_101_16 < arg_98_1.time_ and arg_98_1.time_ <= var_101_16 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_17 = 2

			if var_101_16 <= arg_98_1.time_ and arg_98_1.time_ < var_101_16 + var_101_17 then
				local var_101_18 = (arg_98_1.time_ - var_101_16) / var_101_17
				local var_101_19 = Color.New(0, 0, 0)

				var_101_19.a = Mathf.Lerp(0, 1, var_101_18)
				arg_98_1.mask_.color = var_101_19
			end

			if arg_98_1.time_ >= var_101_16 + var_101_17 and arg_98_1.time_ < var_101_16 + var_101_17 + arg_101_0 then
				local var_101_20 = Color.New(0, 0, 0)

				var_101_20.a = 1
				arg_98_1.mask_.color = var_101_20
			end

			local var_101_21 = 2

			if var_101_21 < arg_98_1.time_ and arg_98_1.time_ <= var_101_21 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_22 = 2

			if var_101_21 <= arg_98_1.time_ and arg_98_1.time_ < var_101_21 + var_101_22 then
				local var_101_23 = (arg_98_1.time_ - var_101_21) / var_101_22
				local var_101_24 = Color.New(0, 0, 0)

				var_101_24.a = Mathf.Lerp(1, 0, var_101_23)
				arg_98_1.mask_.color = var_101_24
			end

			if arg_98_1.time_ >= var_101_21 + var_101_22 and arg_98_1.time_ < var_101_21 + var_101_22 + arg_101_0 then
				local var_101_25 = Color.New(0, 0, 0)
				local var_101_26 = 0

				arg_98_1.mask_.enabled = false
				var_101_25.a = var_101_26
				arg_98_1.mask_.color = var_101_25
			end

			local var_101_27 = arg_98_1.actors_["1075ui_actor"].transform
			local var_101_28 = 1.96599999815226

			if var_101_28 < arg_98_1.time_ and arg_98_1.time_ <= var_101_28 + arg_101_0 then
				arg_98_1.var_.moveOldPos1075ui_actor = var_101_27.localPosition

				local var_101_29 = GameObjectTools.GetOrAddComponent(var_101_27.gameObject, typeof(DynamicBoneHelper))

				if var_101_29 then
					var_101_29:EnableDynamicBone(false)
				end
			end

			local var_101_30 = 0.001

			if var_101_28 <= arg_98_1.time_ and arg_98_1.time_ < var_101_28 + var_101_30 then
				local var_101_31 = (arg_98_1.time_ - var_101_28) / var_101_30
				local var_101_32 = Vector3.New(0, 100, 0)

				var_101_27.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1075ui_actor, var_101_32, var_101_31)

				local var_101_33 = manager.ui.mainCamera.transform.position - var_101_27.position

				var_101_27.forward = Vector3.New(var_101_33.x, var_101_33.y, var_101_33.z)

				local var_101_34 = var_101_27.localEulerAngles

				var_101_34.z = 0
				var_101_34.x = 0
				var_101_27.localEulerAngles = var_101_34
			end

			if arg_98_1.time_ >= var_101_28 + var_101_30 and arg_98_1.time_ < var_101_28 + var_101_30 + arg_101_0 then
				var_101_27.localPosition = Vector3.New(0, 100, 0)

				local var_101_35 = manager.ui.mainCamera.transform.position - var_101_27.position

				var_101_27.forward = Vector3.New(var_101_35.x, var_101_35.y, var_101_35.z)

				local var_101_36 = var_101_27.localEulerAngles

				var_101_36.z = 0
				var_101_36.x = 0
				var_101_27.localEulerAngles = var_101_36

				local var_101_37 = GameObjectTools.GetOrAddComponent(var_101_27.gameObject, typeof(DynamicBoneHelper))

				if var_101_37 then
					var_101_37:EnableDynamicBone(true)
				end
			end

			local var_101_38 = arg_98_1.actors_["10044ui_story"].transform
			local var_101_39 = 1.96599999815226

			if var_101_39 < arg_98_1.time_ and arg_98_1.time_ <= var_101_39 + arg_101_0 then
				arg_98_1.var_.moveOldPos10044ui_story = var_101_38.localPosition
			end

			local var_101_40 = 0.001

			if var_101_39 <= arg_98_1.time_ and arg_98_1.time_ < var_101_39 + var_101_40 then
				local var_101_41 = (arg_98_1.time_ - var_101_39) / var_101_40
				local var_101_42 = Vector3.New(0, 100, 0)

				var_101_38.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10044ui_story, var_101_42, var_101_41)

				local var_101_43 = manager.ui.mainCamera.transform.position - var_101_38.position

				var_101_38.forward = Vector3.New(var_101_43.x, var_101_43.y, var_101_43.z)

				local var_101_44 = var_101_38.localEulerAngles

				var_101_44.z = 0
				var_101_44.x = 0
				var_101_38.localEulerAngles = var_101_44
			end

			if arg_98_1.time_ >= var_101_39 + var_101_40 and arg_98_1.time_ < var_101_39 + var_101_40 + arg_101_0 then
				var_101_38.localPosition = Vector3.New(0, 100, 0)

				local var_101_45 = manager.ui.mainCamera.transform.position - var_101_38.position

				var_101_38.forward = Vector3.New(var_101_45.x, var_101_45.y, var_101_45.z)

				local var_101_46 = var_101_38.localEulerAngles

				var_101_46.z = 0
				var_101_46.x = 0
				var_101_38.localEulerAngles = var_101_46
			end

			local var_101_47 = arg_98_1.actors_["1075ui_actor"]
			local var_101_48 = 1.98333333333333

			if var_101_48 < arg_98_1.time_ and arg_98_1.time_ <= var_101_48 + arg_101_0 and not isNil(var_101_47) and arg_98_1.var_.characterEffect1075ui_actor == nil then
				arg_98_1.var_.characterEffect1075ui_actor = var_101_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_49 = 0.0166666666666667

			if var_101_48 <= arg_98_1.time_ and arg_98_1.time_ < var_101_48 + var_101_49 and not isNil(var_101_47) then
				local var_101_50 = (arg_98_1.time_ - var_101_48) / var_101_49

				if arg_98_1.var_.characterEffect1075ui_actor and not isNil(var_101_47) then
					local var_101_51 = Mathf.Lerp(0, 0.5, var_101_50)

					arg_98_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_98_1.var_.characterEffect1075ui_actor.fillRatio = var_101_51
				end
			end

			if arg_98_1.time_ >= var_101_48 + var_101_49 and arg_98_1.time_ < var_101_48 + var_101_49 + arg_101_0 and not isNil(var_101_47) and arg_98_1.var_.characterEffect1075ui_actor then
				local var_101_52 = 0.5

				arg_98_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_98_1.var_.characterEffect1075ui_actor.fillRatio = var_101_52
			end

			local var_101_53 = 1.96666666666667

			arg_98_1.isInRecall_ = false

			if var_101_53 < arg_98_1.time_ and arg_98_1.time_ <= var_101_53 + arg_101_0 then
				arg_98_1.screenFilterGo_:SetActive(false)

				for iter_101_2, iter_101_3 in pairs(arg_98_1.actors_) do
					local var_101_54 = iter_101_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_101_4, iter_101_5 in ipairs(var_101_54) do
						if iter_101_5.color.r > 0.51 then
							iter_101_5.color = Color.New(1, 1, 1)
						else
							iter_101_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_101_55 = 0.0333333333333332

			if var_101_53 <= arg_98_1.time_ and arg_98_1.time_ < var_101_53 + var_101_55 then
				local var_101_56 = (arg_98_1.time_ - var_101_53) / var_101_55

				arg_98_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_101_56)
			end

			if arg_98_1.time_ >= var_101_53 + var_101_55 and arg_98_1.time_ < var_101_53 + var_101_55 + arg_101_0 then
				arg_98_1.screenFilterEffect_.weight = 0
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_57 = 4
			local var_101_58 = 0.375

			if var_101_57 < arg_98_1.time_ and arg_98_1.time_ <= var_101_57 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_59 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_59:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_60 = arg_98_1:FormatText(StoryNameCfg[7].name)

				arg_98_1.leftNameTxt_.text = var_101_60

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_61 = arg_98_1:GetWordFromCfg(1107506023)
				local var_101_62 = arg_98_1:FormatText(var_101_61.content)

				arg_98_1.text_.text = var_101_62

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_63 = 15
				local var_101_64 = utf8.len(var_101_62)
				local var_101_65 = var_101_63 <= 0 and var_101_58 or var_101_58 * (var_101_64 / var_101_63)

				if var_101_65 > 0 and var_101_58 < var_101_65 then
					arg_98_1.talkMaxDuration = var_101_65
					var_101_57 = var_101_57 + 0.3

					if var_101_65 + var_101_57 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_65 + var_101_57
					end
				end

				arg_98_1.text_.text = var_101_62
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_66 = var_101_57 + 0.3
			local var_101_67 = math.max(var_101_58, arg_98_1.talkMaxDuration)

			if var_101_66 <= arg_98_1.time_ and arg_98_1.time_ < var_101_66 + var_101_67 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_66) / var_101_67

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_66 + var_101_67 and arg_98_1.time_ < var_101_66 + var_101_67 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play1107506024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1107506024
		arg_104_1.duration_ = 7.83

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1107506025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1075ui_actor"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1075ui_actor = var_107_0.localPosition

				local var_107_2 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(false)
				end
			end

			local var_107_3 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_3 then
				local var_107_4 = (arg_104_1.time_ - var_107_1) / var_107_3
				local var_107_5 = Vector3.New(0, -1.055, -6.16)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1075ui_actor, var_107_5, var_107_4)

				local var_107_6 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_6.x, var_107_6.y, var_107_6.z)

				local var_107_7 = var_107_0.localEulerAngles

				var_107_7.z = 0
				var_107_7.x = 0
				var_107_0.localEulerAngles = var_107_7
			end

			if arg_104_1.time_ >= var_107_1 + var_107_3 and arg_104_1.time_ < var_107_1 + var_107_3 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_107_8 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_8.x, var_107_8.y, var_107_8.z)

				local var_107_9 = var_107_0.localEulerAngles

				var_107_9.z = 0
				var_107_9.x = 0
				var_107_0.localEulerAngles = var_107_9

				local var_107_10 = GameObjectTools.GetOrAddComponent(var_107_0.gameObject, typeof(DynamicBoneHelper))

				if var_107_10 then
					var_107_10:EnableDynamicBone(true)
				end
			end

			local var_107_11 = arg_104_1.actors_["1075ui_actor"]
			local var_107_12 = 0

			if var_107_12 < arg_104_1.time_ and arg_104_1.time_ <= var_107_12 + arg_107_0 and not isNil(var_107_11) and arg_104_1.var_.characterEffect1075ui_actor == nil then
				arg_104_1.var_.characterEffect1075ui_actor = var_107_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_13 = 0.200000002980232

			if var_107_12 <= arg_104_1.time_ and arg_104_1.time_ < var_107_12 + var_107_13 and not isNil(var_107_11) then
				local var_107_14 = (arg_104_1.time_ - var_107_12) / var_107_13

				if arg_104_1.var_.characterEffect1075ui_actor and not isNil(var_107_11) then
					arg_104_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_12 + var_107_13 and arg_104_1.time_ < var_107_12 + var_107_13 + arg_107_0 and not isNil(var_107_11) and arg_104_1.var_.characterEffect1075ui_actor then
				arg_104_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_107_15 = 0

			if var_107_15 < arg_104_1.time_ and arg_104_1.time_ <= var_107_15 + arg_107_0 then
				arg_104_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_107_16 = 0

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 then
				arg_104_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_107_17 = 0
			local var_107_18 = 0.8

			if var_107_17 < arg_104_1.time_ and arg_104_1.time_ <= var_107_17 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_19 = arg_104_1:FormatText(StoryNameCfg[381].name)

				arg_104_1.leftNameTxt_.text = var_107_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_20 = arg_104_1:GetWordFromCfg(1107506024)
				local var_107_21 = arg_104_1:FormatText(var_107_20.content)

				arg_104_1.text_.text = var_107_21

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_22 = 32
				local var_107_23 = utf8.len(var_107_21)
				local var_107_24 = var_107_22 <= 0 and var_107_18 or var_107_18 * (var_107_23 / var_107_22)

				if var_107_24 > 0 and var_107_18 < var_107_24 then
					arg_104_1.talkMaxDuration = var_107_24

					if var_107_24 + var_107_17 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_24 + var_107_17
					end
				end

				arg_104_1.text_.text = var_107_21
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506024", "story_v_side_new_1107506.awb") ~= 0 then
					local var_107_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506024", "story_v_side_new_1107506.awb") / 1000

					if var_107_25 + var_107_17 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_25 + var_107_17
					end

					if var_107_20.prefab_name ~= "" and arg_104_1.actors_[var_107_20.prefab_name] ~= nil then
						local var_107_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_20.prefab_name].transform, "story_v_side_new_1107506", "1107506024", "story_v_side_new_1107506.awb")

						arg_104_1:RecordAudio("1107506024", var_107_26)
						arg_104_1:RecordAudio("1107506024", var_107_26)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506024", "story_v_side_new_1107506.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506024", "story_v_side_new_1107506.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_27 = math.max(var_107_18, arg_104_1.talkMaxDuration)

			if var_107_17 <= arg_104_1.time_ and arg_104_1.time_ < var_107_17 + var_107_27 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_17) / var_107_27

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_17 + var_107_27 and arg_104_1.time_ < var_107_17 + var_107_27 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play1107506025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1107506025
		arg_108_1.duration_ = 10.8

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1107506026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_111_2 = 0
			local var_111_3 = 1

			if var_111_2 < arg_108_1.time_ and arg_108_1.time_ <= var_111_2 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_4 = arg_108_1:FormatText(StoryNameCfg[381].name)

				arg_108_1.leftNameTxt_.text = var_111_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_5 = arg_108_1:GetWordFromCfg(1107506025)
				local var_111_6 = arg_108_1:FormatText(var_111_5.content)

				arg_108_1.text_.text = var_111_6

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_7 = 40
				local var_111_8 = utf8.len(var_111_6)
				local var_111_9 = var_111_7 <= 0 and var_111_3 or var_111_3 * (var_111_8 / var_111_7)

				if var_111_9 > 0 and var_111_3 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_2
					end
				end

				arg_108_1.text_.text = var_111_6
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506025", "story_v_side_new_1107506.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506025", "story_v_side_new_1107506.awb") / 1000

					if var_111_10 + var_111_2 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_2
					end

					if var_111_5.prefab_name ~= "" and arg_108_1.actors_[var_111_5.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_5.prefab_name].transform, "story_v_side_new_1107506", "1107506025", "story_v_side_new_1107506.awb")

						arg_108_1:RecordAudio("1107506025", var_111_11)
						arg_108_1:RecordAudio("1107506025", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506025", "story_v_side_new_1107506.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506025", "story_v_side_new_1107506.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_3, arg_108_1.talkMaxDuration)

			if var_111_2 <= arg_108_1.time_ and arg_108_1.time_ < var_111_2 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_2) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_2 + var_111_12 and arg_108_1.time_ < var_111_2 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play1107506026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1107506026
		arg_112_1.duration_ = 6.9

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1107506027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_115_1 = 0
			local var_115_2 = 0.825

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_3 = arg_112_1:FormatText(StoryNameCfg[381].name)

				arg_112_1.leftNameTxt_.text = var_115_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(1107506026)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_6 = 33
				local var_115_7 = utf8.len(var_115_5)
				local var_115_8 = var_115_6 <= 0 and var_115_2 or var_115_2 * (var_115_7 / var_115_6)

				if var_115_8 > 0 and var_115_2 < var_115_8 then
					arg_112_1.talkMaxDuration = var_115_8

					if var_115_8 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506026", "story_v_side_new_1107506.awb") ~= 0 then
					local var_115_9 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506026", "story_v_side_new_1107506.awb") / 1000

					if var_115_9 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_1
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_side_new_1107506", "1107506026", "story_v_side_new_1107506.awb")

						arg_112_1:RecordAudio("1107506026", var_115_10)
						arg_112_1:RecordAudio("1107506026", var_115_10)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506026", "story_v_side_new_1107506.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506026", "story_v_side_new_1107506.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_11 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_11 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_11

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_11 and arg_112_1.time_ < var_115_1 + var_115_11 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play1107506027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1107506027
		arg_116_1.duration_ = 4.43

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1107506028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_119_2 = 0
			local var_119_3 = 0.525

			if var_119_2 < arg_116_1.time_ and arg_116_1.time_ <= var_119_2 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_4 = arg_116_1:FormatText(StoryNameCfg[381].name)

				arg_116_1.leftNameTxt_.text = var_119_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_5 = arg_116_1:GetWordFromCfg(1107506027)
				local var_119_6 = arg_116_1:FormatText(var_119_5.content)

				arg_116_1.text_.text = var_119_6

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_7 = 21
				local var_119_8 = utf8.len(var_119_6)
				local var_119_9 = var_119_7 <= 0 and var_119_3 or var_119_3 * (var_119_8 / var_119_7)

				if var_119_9 > 0 and var_119_3 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_2
					end
				end

				arg_116_1.text_.text = var_119_6
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506027", "story_v_side_new_1107506.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506027", "story_v_side_new_1107506.awb") / 1000

					if var_119_10 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_2
					end

					if var_119_5.prefab_name ~= "" and arg_116_1.actors_[var_119_5.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_5.prefab_name].transform, "story_v_side_new_1107506", "1107506027", "story_v_side_new_1107506.awb")

						arg_116_1:RecordAudio("1107506027", var_119_11)
						arg_116_1:RecordAudio("1107506027", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506027", "story_v_side_new_1107506.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506027", "story_v_side_new_1107506.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_3, arg_116_1.talkMaxDuration)

			if var_119_2 <= arg_116_1.time_ and arg_116_1.time_ < var_119_2 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_2) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_2 + var_119_12 and arg_116_1.time_ < var_119_2 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play1107506028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1107506028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1107506029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1075ui_actor"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1075ui_actor == nil then
				arg_120_1.var_.characterEffect1075ui_actor = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1075ui_actor and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_120_1.var_.characterEffect1075ui_actor.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1075ui_actor then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_120_1.var_.characterEffect1075ui_actor.fillRatio = var_123_5
			end

			local var_123_6 = 0
			local var_123_7 = 0.225

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[7].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_9 = arg_120_1:GetWordFromCfg(1107506028)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 9
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_7 or var_123_7 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_7 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1107506029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1107506029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1107506030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1075ui_actor"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1075ui_actor = var_127_0.localPosition

				local var_127_2 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(false)
				end
			end

			local var_127_3 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_3 then
				local var_127_4 = (arg_124_1.time_ - var_127_1) / var_127_3
				local var_127_5 = Vector3.New(0, 100, 0)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1075ui_actor, var_127_5, var_127_4)

				local var_127_6 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_6.x, var_127_6.y, var_127_6.z)

				local var_127_7 = var_127_0.localEulerAngles

				var_127_7.z = 0
				var_127_7.x = 0
				var_127_0.localEulerAngles = var_127_7
			end

			if arg_124_1.time_ >= var_127_1 + var_127_3 and arg_124_1.time_ < var_127_1 + var_127_3 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, 100, 0)

				local var_127_8 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_8.x, var_127_8.y, var_127_8.z)

				local var_127_9 = var_127_0.localEulerAngles

				var_127_9.z = 0
				var_127_9.x = 0
				var_127_0.localEulerAngles = var_127_9

				local var_127_10 = GameObjectTools.GetOrAddComponent(var_127_0.gameObject, typeof(DynamicBoneHelper))

				if var_127_10 then
					var_127_10:EnableDynamicBone(true)
				end
			end

			local var_127_11 = 0
			local var_127_12 = 0.475

			if var_127_11 < arg_124_1.time_ and arg_124_1.time_ <= var_127_11 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_13 = arg_124_1:GetWordFromCfg(1107506029)
				local var_127_14 = arg_124_1:FormatText(var_127_13.content)

				arg_124_1.text_.text = var_127_14

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_15 = 19
				local var_127_16 = utf8.len(var_127_14)
				local var_127_17 = var_127_15 <= 0 and var_127_12 or var_127_12 * (var_127_16 / var_127_15)

				if var_127_17 > 0 and var_127_12 < var_127_17 then
					arg_124_1.talkMaxDuration = var_127_17

					if var_127_17 + var_127_11 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_17 + var_127_11
					end
				end

				arg_124_1.text_.text = var_127_14
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_18 = math.max(var_127_12, arg_124_1.talkMaxDuration)

			if var_127_11 <= arg_124_1.time_ and arg_124_1.time_ < var_127_11 + var_127_18 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_11) / var_127_18

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_11 + var_127_18 and arg_124_1.time_ < var_127_11 + var_127_18 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play1107506030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1107506030
		arg_128_1.duration_ = 7.43

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1107506031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1075ui_actor"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1075ui_actor = var_131_0.localPosition

				local var_131_2 = GameObjectTools.GetOrAddComponent(var_131_0.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(false)
				end
			end

			local var_131_3 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_3 then
				local var_131_4 = (arg_128_1.time_ - var_131_1) / var_131_3
				local var_131_5 = Vector3.New(0, -1.055, -6.16)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1075ui_actor, var_131_5, var_131_4)

				local var_131_6 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_6.x, var_131_6.y, var_131_6.z)

				local var_131_7 = var_131_0.localEulerAngles

				var_131_7.z = 0
				var_131_7.x = 0
				var_131_0.localEulerAngles = var_131_7
			end

			if arg_128_1.time_ >= var_131_1 + var_131_3 and arg_128_1.time_ < var_131_1 + var_131_3 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_131_8 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_8.x, var_131_8.y, var_131_8.z)

				local var_131_9 = var_131_0.localEulerAngles

				var_131_9.z = 0
				var_131_9.x = 0
				var_131_0.localEulerAngles = var_131_9

				local var_131_10 = GameObjectTools.GetOrAddComponent(var_131_0.gameObject, typeof(DynamicBoneHelper))

				if var_131_10 then
					var_131_10:EnableDynamicBone(true)
				end
			end

			local var_131_11 = arg_128_1.actors_["1075ui_actor"]
			local var_131_12 = 0

			if var_131_12 < arg_128_1.time_ and arg_128_1.time_ <= var_131_12 + arg_131_0 and not isNil(var_131_11) and arg_128_1.var_.characterEffect1075ui_actor == nil then
				arg_128_1.var_.characterEffect1075ui_actor = var_131_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_13 = 0.200000002980232

			if var_131_12 <= arg_128_1.time_ and arg_128_1.time_ < var_131_12 + var_131_13 and not isNil(var_131_11) then
				local var_131_14 = (arg_128_1.time_ - var_131_12) / var_131_13

				if arg_128_1.var_.characterEffect1075ui_actor and not isNil(var_131_11) then
					arg_128_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_12 + var_131_13 and arg_128_1.time_ < var_131_12 + var_131_13 + arg_131_0 and not isNil(var_131_11) and arg_128_1.var_.characterEffect1075ui_actor then
				arg_128_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_131_15 = 0

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_131_16 = 0

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				arg_128_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_131_17 = 0
			local var_131_18 = 0.775

			if var_131_17 < arg_128_1.time_ and arg_128_1.time_ <= var_131_17 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_19 = arg_128_1:FormatText(StoryNameCfg[381].name)

				arg_128_1.leftNameTxt_.text = var_131_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_20 = arg_128_1:GetWordFromCfg(1107506030)
				local var_131_21 = arg_128_1:FormatText(var_131_20.content)

				arg_128_1.text_.text = var_131_21

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_22 = 31
				local var_131_23 = utf8.len(var_131_21)
				local var_131_24 = var_131_22 <= 0 and var_131_18 or var_131_18 * (var_131_23 / var_131_22)

				if var_131_24 > 0 and var_131_18 < var_131_24 then
					arg_128_1.talkMaxDuration = var_131_24

					if var_131_24 + var_131_17 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_24 + var_131_17
					end
				end

				arg_128_1.text_.text = var_131_21
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506030", "story_v_side_new_1107506.awb") ~= 0 then
					local var_131_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506030", "story_v_side_new_1107506.awb") / 1000

					if var_131_25 + var_131_17 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_25 + var_131_17
					end

					if var_131_20.prefab_name ~= "" and arg_128_1.actors_[var_131_20.prefab_name] ~= nil then
						local var_131_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_20.prefab_name].transform, "story_v_side_new_1107506", "1107506030", "story_v_side_new_1107506.awb")

						arg_128_1:RecordAudio("1107506030", var_131_26)
						arg_128_1:RecordAudio("1107506030", var_131_26)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506030", "story_v_side_new_1107506.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506030", "story_v_side_new_1107506.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_27 = math.max(var_131_18, arg_128_1.talkMaxDuration)

			if var_131_17 <= arg_128_1.time_ and arg_128_1.time_ < var_131_17 + var_131_27 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_17) / var_131_27

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_17 + var_131_27 and arg_128_1.time_ < var_131_17 + var_131_27 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
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
	Play1107506031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1107506031
		arg_132_1.duration_ = 14.13

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1107506032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_135_1 = 0
			local var_135_2 = 1.25

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_3 = arg_132_1:FormatText(StoryNameCfg[381].name)

				arg_132_1.leftNameTxt_.text = var_135_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_4 = arg_132_1:GetWordFromCfg(1107506031)
				local var_135_5 = arg_132_1:FormatText(var_135_4.content)

				arg_132_1.text_.text = var_135_5

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_6 = 50
				local var_135_7 = utf8.len(var_135_5)
				local var_135_8 = var_135_6 <= 0 and var_135_2 or var_135_2 * (var_135_7 / var_135_6)

				if var_135_8 > 0 and var_135_2 < var_135_8 then
					arg_132_1.talkMaxDuration = var_135_8

					if var_135_8 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_5
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506031", "story_v_side_new_1107506.awb") ~= 0 then
					local var_135_9 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506031", "story_v_side_new_1107506.awb") / 1000

					if var_135_9 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_1
					end

					if var_135_4.prefab_name ~= "" and arg_132_1.actors_[var_135_4.prefab_name] ~= nil then
						local var_135_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_4.prefab_name].transform, "story_v_side_new_1107506", "1107506031", "story_v_side_new_1107506.awb")

						arg_132_1:RecordAudio("1107506031", var_135_10)
						arg_132_1:RecordAudio("1107506031", var_135_10)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506031", "story_v_side_new_1107506.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506031", "story_v_side_new_1107506.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_11 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_11 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_11

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_11 and arg_132_1.time_ < var_135_1 + var_135_11 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1107506032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1107506032
		arg_136_1.duration_ = 6.8

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1107506033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.65

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[381].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:GetWordFromCfg(1107506032)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506032", "story_v_side_new_1107506.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506032", "story_v_side_new_1107506.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_side_new_1107506", "1107506032", "story_v_side_new_1107506.awb")

						arg_136_1:RecordAudio("1107506032", var_139_9)
						arg_136_1:RecordAudio("1107506032", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506032", "story_v_side_new_1107506.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506032", "story_v_side_new_1107506.awb")
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
	Play1107506033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1107506033
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1107506034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1075ui_actor"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1075ui_actor == nil then
				arg_140_1.var_.characterEffect1075ui_actor = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1075ui_actor and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_140_1.var_.characterEffect1075ui_actor.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1075ui_actor then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_140_1.var_.characterEffect1075ui_actor.fillRatio = var_143_5
			end

			local var_143_6 = 0
			local var_143_7 = 0.375

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_9 = arg_140_1:GetWordFromCfg(1107506033)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 15
				local var_143_12 = utf8.len(var_143_10)
				local var_143_13 = var_143_11 <= 0 and var_143_7 or var_143_7 * (var_143_12 / var_143_11)

				if var_143_13 > 0 and var_143_7 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_10
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_14 and arg_140_1.time_ < var_143_6 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play1107506034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1107506034
		arg_144_1.duration_ = 8.13

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1107506035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1075ui_actor"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1075ui_actor == nil then
				arg_144_1.var_.characterEffect1075ui_actor = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1075ui_actor and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1075ui_actor then
				arg_144_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_147_4 = 0

			if var_147_4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 then
				arg_144_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_147_6 = 0
			local var_147_7 = 0.7

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_8 = arg_144_1:FormatText(StoryNameCfg[381].name)

				arg_144_1.leftNameTxt_.text = var_147_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_9 = arg_144_1:GetWordFromCfg(1107506034)
				local var_147_10 = arg_144_1:FormatText(var_147_9.content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 28
				local var_147_12 = utf8.len(var_147_10)
				local var_147_13 = var_147_11 <= 0 and var_147_7 or var_147_7 * (var_147_12 / var_147_11)

				if var_147_13 > 0 and var_147_7 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_6
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506034", "story_v_side_new_1107506.awb") ~= 0 then
					local var_147_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506034", "story_v_side_new_1107506.awb") / 1000

					if var_147_14 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_14 + var_147_6
					end

					if var_147_9.prefab_name ~= "" and arg_144_1.actors_[var_147_9.prefab_name] ~= nil then
						local var_147_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_9.prefab_name].transform, "story_v_side_new_1107506", "1107506034", "story_v_side_new_1107506.awb")

						arg_144_1:RecordAudio("1107506034", var_147_15)
						arg_144_1:RecordAudio("1107506034", var_147_15)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506034", "story_v_side_new_1107506.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506034", "story_v_side_new_1107506.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_16 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_16 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_16

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_16 and arg_144_1.time_ < var_147_6 + var_147_16 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1107506035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1107506035
		arg_148_1.duration_ = 8.4

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1107506036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0
			local var_151_1 = 0.925

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_2 = arg_148_1:FormatText(StoryNameCfg[381].name)

				arg_148_1.leftNameTxt_.text = var_151_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_3 = arg_148_1:GetWordFromCfg(1107506035)
				local var_151_4 = arg_148_1:FormatText(var_151_3.content)

				arg_148_1.text_.text = var_151_4

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 37
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

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506035", "story_v_side_new_1107506.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506035", "story_v_side_new_1107506.awb") / 1000

					if var_151_8 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_0
					end

					if var_151_3.prefab_name ~= "" and arg_148_1.actors_[var_151_3.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_3.prefab_name].transform, "story_v_side_new_1107506", "1107506035", "story_v_side_new_1107506.awb")

						arg_148_1:RecordAudio("1107506035", var_151_9)
						arg_148_1:RecordAudio("1107506035", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506035", "story_v_side_new_1107506.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506035", "story_v_side_new_1107506.awb")
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
	Play1107506036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1107506036
		arg_152_1.duration_ = 10.67

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1107506037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action453")
			end

			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_155_2 = 0
			local var_155_3 = 0.775

			if var_155_2 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_4 = arg_152_1:FormatText(StoryNameCfg[381].name)

				arg_152_1.leftNameTxt_.text = var_155_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_5 = arg_152_1:GetWordFromCfg(1107506036)
				local var_155_6 = arg_152_1:FormatText(var_155_5.content)

				arg_152_1.text_.text = var_155_6

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_7 = 31
				local var_155_8 = utf8.len(var_155_6)
				local var_155_9 = var_155_7 <= 0 and var_155_3 or var_155_3 * (var_155_8 / var_155_7)

				if var_155_9 > 0 and var_155_3 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_6
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506036", "story_v_side_new_1107506.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506036", "story_v_side_new_1107506.awb") / 1000

					if var_155_10 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_2
					end

					if var_155_5.prefab_name ~= "" and arg_152_1.actors_[var_155_5.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_5.prefab_name].transform, "story_v_side_new_1107506", "1107506036", "story_v_side_new_1107506.awb")

						arg_152_1:RecordAudio("1107506036", var_155_11)
						arg_152_1:RecordAudio("1107506036", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506036", "story_v_side_new_1107506.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506036", "story_v_side_new_1107506.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_12 and arg_152_1.time_ < var_155_2 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play1107506037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1107506037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1107506038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1075ui_actor"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1075ui_actor == nil then
				arg_156_1.var_.characterEffect1075ui_actor = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1075ui_actor and not isNil(var_159_0) then
					local var_159_4 = Mathf.Lerp(0, 0.5, var_159_3)

					arg_156_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_156_1.var_.characterEffect1075ui_actor.fillRatio = var_159_4
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1075ui_actor then
				local var_159_5 = 0.5

				arg_156_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_156_1.var_.characterEffect1075ui_actor.fillRatio = var_159_5
			end

			local var_159_6 = 0
			local var_159_7 = 0.625

			if var_159_6 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_8 = arg_156_1:FormatText(StoryNameCfg[7].name)

				arg_156_1.leftNameTxt_.text = var_159_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_9 = arg_156_1:GetWordFromCfg(1107506037)
				local var_159_10 = arg_156_1:FormatText(var_159_9.content)

				arg_156_1.text_.text = var_159_10

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 25
				local var_159_12 = utf8.len(var_159_10)
				local var_159_13 = var_159_11 <= 0 and var_159_7 or var_159_7 * (var_159_12 / var_159_11)

				if var_159_13 > 0 and var_159_7 < var_159_13 then
					arg_156_1.talkMaxDuration = var_159_13

					if var_159_13 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_10
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_14 and arg_156_1.time_ < var_159_6 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play1107506038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1107506038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1107506039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1075ui_actor"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos1075ui_actor = var_163_0.localPosition

				local var_163_2 = GameObjectTools.GetOrAddComponent(var_163_0.gameObject, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(false)
				end
			end

			local var_163_3 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_3 then
				local var_163_4 = (arg_160_1.time_ - var_163_1) / var_163_3
				local var_163_5 = Vector3.New(0, 100, 0)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1075ui_actor, var_163_5, var_163_4)

				local var_163_6 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_6.x, var_163_6.y, var_163_6.z)

				local var_163_7 = var_163_0.localEulerAngles

				var_163_7.z = 0
				var_163_7.x = 0
				var_163_0.localEulerAngles = var_163_7
			end

			if arg_160_1.time_ >= var_163_1 + var_163_3 and arg_160_1.time_ < var_163_1 + var_163_3 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(0, 100, 0)

				local var_163_8 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_8.x, var_163_8.y, var_163_8.z)

				local var_163_9 = var_163_0.localEulerAngles

				var_163_9.z = 0
				var_163_9.x = 0
				var_163_0.localEulerAngles = var_163_9

				local var_163_10 = GameObjectTools.GetOrAddComponent(var_163_0.gameObject, typeof(DynamicBoneHelper))

				if var_163_10 then
					var_163_10:EnableDynamicBone(true)
				end
			end

			local var_163_11 = 0
			local var_163_12 = 1.05

			if var_163_11 < arg_160_1.time_ and arg_160_1.time_ <= var_163_11 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_13 = arg_160_1:GetWordFromCfg(1107506038)
				local var_163_14 = arg_160_1:FormatText(var_163_13.content)

				arg_160_1.text_.text = var_163_14

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_15 = 42
				local var_163_16 = utf8.len(var_163_14)
				local var_163_17 = var_163_15 <= 0 and var_163_12 or var_163_12 * (var_163_16 / var_163_15)

				if var_163_17 > 0 and var_163_12 < var_163_17 then
					arg_160_1.talkMaxDuration = var_163_17

					if var_163_17 + var_163_11 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_17 + var_163_11
					end
				end

				arg_160_1.text_.text = var_163_14
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_18 = math.max(var_163_12, arg_160_1.talkMaxDuration)

			if var_163_11 <= arg_160_1.time_ and arg_160_1.time_ < var_163_11 + var_163_18 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_11) / var_163_18

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_11 + var_163_18 and arg_160_1.time_ < var_163_11 + var_163_18 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play1107506039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1107506039
		arg_164_1.duration_ = 6.9

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1107506040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1075ui_actor"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1075ui_actor = var_167_0.localPosition

				local var_167_2 = GameObjectTools.GetOrAddComponent(var_167_0.gameObject, typeof(DynamicBoneHelper))

				if var_167_2 then
					var_167_2:EnableDynamicBone(false)
				end
			end

			local var_167_3 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_3 then
				local var_167_4 = (arg_164_1.time_ - var_167_1) / var_167_3
				local var_167_5 = Vector3.New(0, -1.055, -6.16)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1075ui_actor, var_167_5, var_167_4)

				local var_167_6 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_6.x, var_167_6.y, var_167_6.z)

				local var_167_7 = var_167_0.localEulerAngles

				var_167_7.z = 0
				var_167_7.x = 0
				var_167_0.localEulerAngles = var_167_7
			end

			if arg_164_1.time_ >= var_167_1 + var_167_3 and arg_164_1.time_ < var_167_1 + var_167_3 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_167_8 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_8.x, var_167_8.y, var_167_8.z)

				local var_167_9 = var_167_0.localEulerAngles

				var_167_9.z = 0
				var_167_9.x = 0
				var_167_0.localEulerAngles = var_167_9

				local var_167_10 = GameObjectTools.GetOrAddComponent(var_167_0.gameObject, typeof(DynamicBoneHelper))

				if var_167_10 then
					var_167_10:EnableDynamicBone(true)
				end
			end

			local var_167_11 = arg_164_1.actors_["1075ui_actor"]
			local var_167_12 = 0

			if var_167_12 < arg_164_1.time_ and arg_164_1.time_ <= var_167_12 + arg_167_0 and not isNil(var_167_11) and arg_164_1.var_.characterEffect1075ui_actor == nil then
				arg_164_1.var_.characterEffect1075ui_actor = var_167_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_13 = 0.200000002980232

			if var_167_12 <= arg_164_1.time_ and arg_164_1.time_ < var_167_12 + var_167_13 and not isNil(var_167_11) then
				local var_167_14 = (arg_164_1.time_ - var_167_12) / var_167_13

				if arg_164_1.var_.characterEffect1075ui_actor and not isNil(var_167_11) then
					arg_164_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_12 + var_167_13 and arg_164_1.time_ < var_167_12 + var_167_13 + arg_167_0 and not isNil(var_167_11) and arg_164_1.var_.characterEffect1075ui_actor then
				arg_164_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_167_15 = 0

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action432")
			end

			local var_167_16 = 0

			if var_167_16 < arg_164_1.time_ and arg_164_1.time_ <= var_167_16 + arg_167_0 then
				arg_164_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_167_17 = 0
			local var_167_18 = 0.675

			if var_167_17 < arg_164_1.time_ and arg_164_1.time_ <= var_167_17 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_19 = arg_164_1:FormatText(StoryNameCfg[381].name)

				arg_164_1.leftNameTxt_.text = var_167_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_20 = arg_164_1:GetWordFromCfg(1107506039)
				local var_167_21 = arg_164_1:FormatText(var_167_20.content)

				arg_164_1.text_.text = var_167_21

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_22 = 27
				local var_167_23 = utf8.len(var_167_21)
				local var_167_24 = var_167_22 <= 0 and var_167_18 or var_167_18 * (var_167_23 / var_167_22)

				if var_167_24 > 0 and var_167_18 < var_167_24 then
					arg_164_1.talkMaxDuration = var_167_24

					if var_167_24 + var_167_17 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_24 + var_167_17
					end
				end

				arg_164_1.text_.text = var_167_21
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506039", "story_v_side_new_1107506.awb") ~= 0 then
					local var_167_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506039", "story_v_side_new_1107506.awb") / 1000

					if var_167_25 + var_167_17 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_25 + var_167_17
					end

					if var_167_20.prefab_name ~= "" and arg_164_1.actors_[var_167_20.prefab_name] ~= nil then
						local var_167_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_20.prefab_name].transform, "story_v_side_new_1107506", "1107506039", "story_v_side_new_1107506.awb")

						arg_164_1:RecordAudio("1107506039", var_167_26)
						arg_164_1:RecordAudio("1107506039", var_167_26)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506039", "story_v_side_new_1107506.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506039", "story_v_side_new_1107506.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_27 = math.max(var_167_18, arg_164_1.talkMaxDuration)

			if var_167_17 <= arg_164_1.time_ and arg_164_1.time_ < var_167_17 + var_167_27 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_17) / var_167_27

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_17 + var_167_27 and arg_164_1.time_ < var_167_17 + var_167_27 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play1107506040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1107506040
		arg_168_1.duration_ = 9.33

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1107506041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_171_1 = 0
			local var_171_2 = 0.825

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_3 = arg_168_1:FormatText(StoryNameCfg[381].name)

				arg_168_1.leftNameTxt_.text = var_171_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_4 = arg_168_1:GetWordFromCfg(1107506040)
				local var_171_5 = arg_168_1:FormatText(var_171_4.content)

				arg_168_1.text_.text = var_171_5

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_6 = 33
				local var_171_7 = utf8.len(var_171_5)
				local var_171_8 = var_171_6 <= 0 and var_171_2 or var_171_2 * (var_171_7 / var_171_6)

				if var_171_8 > 0 and var_171_2 < var_171_8 then
					arg_168_1.talkMaxDuration = var_171_8

					if var_171_8 + var_171_1 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_1
					end
				end

				arg_168_1.text_.text = var_171_5
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506040", "story_v_side_new_1107506.awb") ~= 0 then
					local var_171_9 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506040", "story_v_side_new_1107506.awb") / 1000

					if var_171_9 + var_171_1 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_9 + var_171_1
					end

					if var_171_4.prefab_name ~= "" and arg_168_1.actors_[var_171_4.prefab_name] ~= nil then
						local var_171_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_4.prefab_name].transform, "story_v_side_new_1107506", "1107506040", "story_v_side_new_1107506.awb")

						arg_168_1:RecordAudio("1107506040", var_171_10)
						arg_168_1:RecordAudio("1107506040", var_171_10)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506040", "story_v_side_new_1107506.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506040", "story_v_side_new_1107506.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_11 = math.max(var_171_2, arg_168_1.talkMaxDuration)

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_11 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_1) / var_171_11

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_1 + var_171_11 and arg_168_1.time_ < var_171_1 + var_171_11 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1107506041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1107506041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1107506042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1075ui_actor"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1075ui_actor == nil then
				arg_172_1.var_.characterEffect1075ui_actor = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1075ui_actor and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_172_1.var_.characterEffect1075ui_actor.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1075ui_actor then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_172_1.var_.characterEffect1075ui_actor.fillRatio = var_175_5
			end

			local var_175_6 = 0
			local var_175_7 = 0.3

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_8 = arg_172_1:FormatText(StoryNameCfg[7].name)

				arg_172_1.leftNameTxt_.text = var_175_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_9 = arg_172_1:GetWordFromCfg(1107506041)
				local var_175_10 = arg_172_1:FormatText(var_175_9.content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 12
				local var_175_12 = utf8.len(var_175_10)
				local var_175_13 = var_175_11 <= 0 and var_175_7 or var_175_7 * (var_175_12 / var_175_11)

				if var_175_13 > 0 and var_175_7 < var_175_13 then
					arg_172_1.talkMaxDuration = var_175_13

					if var_175_13 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_14 and arg_172_1.time_ < var_175_6 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play1107506042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1107506042
		arg_176_1.duration_ = 5.2

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1107506043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1075ui_actor"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1075ui_actor == nil then
				arg_176_1.var_.characterEffect1075ui_actor = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1075ui_actor and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1075ui_actor then
				arg_176_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_179_4 = 0

			if var_179_4 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_2")
			end

			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_179_6 = 0
			local var_179_7 = 0.425

			if var_179_6 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_8 = arg_176_1:FormatText(StoryNameCfg[381].name)

				arg_176_1.leftNameTxt_.text = var_179_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_9 = arg_176_1:GetWordFromCfg(1107506042)
				local var_179_10 = arg_176_1:FormatText(var_179_9.content)

				arg_176_1.text_.text = var_179_10

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_11 = 17
				local var_179_12 = utf8.len(var_179_10)
				local var_179_13 = var_179_11 <= 0 and var_179_7 or var_179_7 * (var_179_12 / var_179_11)

				if var_179_13 > 0 and var_179_7 < var_179_13 then
					arg_176_1.talkMaxDuration = var_179_13

					if var_179_13 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_6
					end
				end

				arg_176_1.text_.text = var_179_10
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506042", "story_v_side_new_1107506.awb") ~= 0 then
					local var_179_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506042", "story_v_side_new_1107506.awb") / 1000

					if var_179_14 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_14 + var_179_6
					end

					if var_179_9.prefab_name ~= "" and arg_176_1.actors_[var_179_9.prefab_name] ~= nil then
						local var_179_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_9.prefab_name].transform, "story_v_side_new_1107506", "1107506042", "story_v_side_new_1107506.awb")

						arg_176_1:RecordAudio("1107506042", var_179_15)
						arg_176_1:RecordAudio("1107506042", var_179_15)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506042", "story_v_side_new_1107506.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506042", "story_v_side_new_1107506.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_16 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_16 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_16

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_16 and arg_176_1.time_ < var_179_6 + var_179_16 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play1107506043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1107506043
		arg_180_1.duration_ = 4.1

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1107506044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_183_1 = 0
			local var_183_2 = 0.45

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_3 = arg_180_1:FormatText(StoryNameCfg[381].name)

				arg_180_1.leftNameTxt_.text = var_183_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_4 = arg_180_1:GetWordFromCfg(1107506043)
				local var_183_5 = arg_180_1:FormatText(var_183_4.content)

				arg_180_1.text_.text = var_183_5

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_6 = 18
				local var_183_7 = utf8.len(var_183_5)
				local var_183_8 = var_183_6 <= 0 and var_183_2 or var_183_2 * (var_183_7 / var_183_6)

				if var_183_8 > 0 and var_183_2 < var_183_8 then
					arg_180_1.talkMaxDuration = var_183_8

					if var_183_8 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_5
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506043", "story_v_side_new_1107506.awb") ~= 0 then
					local var_183_9 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506043", "story_v_side_new_1107506.awb") / 1000

					if var_183_9 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_1
					end

					if var_183_4.prefab_name ~= "" and arg_180_1.actors_[var_183_4.prefab_name] ~= nil then
						local var_183_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_4.prefab_name].transform, "story_v_side_new_1107506", "1107506043", "story_v_side_new_1107506.awb")

						arg_180_1:RecordAudio("1107506043", var_183_10)
						arg_180_1:RecordAudio("1107506043", var_183_10)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506043", "story_v_side_new_1107506.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506043", "story_v_side_new_1107506.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_11 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_11 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_11

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_11 and arg_180_1.time_ < var_183_1 + var_183_11 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play1107506044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1107506044
		arg_184_1.duration_ = 4.3

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1107506045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = "STblack"

			if arg_184_1.bgs_[var_187_0] == nil then
				local var_187_1 = Object.Instantiate(arg_184_1.paintGo_)

				var_187_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_187_0)
				var_187_1.name = var_187_0
				var_187_1.transform.parent = arg_184_1.stage_.transform
				var_187_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_184_1.bgs_[var_187_0] = var_187_1
			end

			local var_187_2 = 1.999999999999

			if var_187_2 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				local var_187_3 = manager.ui.mainCamera.transform.localPosition
				local var_187_4 = Vector3.New(0, 0, 10) + Vector3.New(var_187_3.x, var_187_3.y, 0)
				local var_187_5 = arg_184_1.bgs_.STblack

				var_187_5.transform.localPosition = var_187_4
				var_187_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_187_6 = var_187_5:GetComponent("SpriteRenderer")

				if var_187_6 and var_187_6.sprite then
					local var_187_7 = (var_187_5.transform.localPosition - var_187_3).z
					local var_187_8 = manager.ui.mainCameraCom_
					local var_187_9 = 2 * var_187_7 * Mathf.Tan(var_187_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_187_10 = var_187_9 * var_187_8.aspect
					local var_187_11 = var_187_6.sprite.bounds.size.x
					local var_187_12 = var_187_6.sprite.bounds.size.y
					local var_187_13 = var_187_10 / var_187_11
					local var_187_14 = var_187_9 / var_187_12
					local var_187_15 = var_187_14 < var_187_13 and var_187_13 or var_187_14

					var_187_5.transform.localScale = Vector3.New(var_187_15, var_187_15, 0)
				end

				for iter_187_0, iter_187_1 in pairs(arg_184_1.bgs_) do
					if iter_187_0 ~= "STblack" then
						iter_187_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_187_16 = 3.999999999999

			if var_187_16 < arg_184_1.time_ and arg_184_1.time_ <= var_187_16 + arg_187_0 then
				arg_184_1.allBtn_.enabled = false
			end

			local var_187_17 = 0.3

			if arg_184_1.time_ >= var_187_16 + var_187_17 and arg_184_1.time_ < var_187_16 + var_187_17 + arg_187_0 then
				arg_184_1.allBtn_.enabled = true
			end

			local var_187_18 = 0

			if var_187_18 < arg_184_1.time_ and arg_184_1.time_ <= var_187_18 + arg_187_0 then
				arg_184_1.mask_.enabled = true
				arg_184_1.mask_.raycastTarget = true

				arg_184_1:SetGaussion(false)
			end

			local var_187_19 = 2

			if var_187_18 <= arg_184_1.time_ and arg_184_1.time_ < var_187_18 + var_187_19 then
				local var_187_20 = (arg_184_1.time_ - var_187_18) / var_187_19
				local var_187_21 = Color.New(0, 0, 0)

				var_187_21.a = Mathf.Lerp(0, 1, var_187_20)
				arg_184_1.mask_.color = var_187_21
			end

			if arg_184_1.time_ >= var_187_18 + var_187_19 and arg_184_1.time_ < var_187_18 + var_187_19 + arg_187_0 then
				local var_187_22 = Color.New(0, 0, 0)

				var_187_22.a = 1
				arg_184_1.mask_.color = var_187_22
			end

			local var_187_23 = 2

			if var_187_23 < arg_184_1.time_ and arg_184_1.time_ <= var_187_23 + arg_187_0 then
				arg_184_1.mask_.enabled = true
				arg_184_1.mask_.raycastTarget = true

				arg_184_1:SetGaussion(false)
			end

			local var_187_24 = 2

			if var_187_23 <= arg_184_1.time_ and arg_184_1.time_ < var_187_23 + var_187_24 then
				local var_187_25 = (arg_184_1.time_ - var_187_23) / var_187_24
				local var_187_26 = Color.New(0, 0, 0)

				var_187_26.a = Mathf.Lerp(1, 0, var_187_25)
				arg_184_1.mask_.color = var_187_26
			end

			if arg_184_1.time_ >= var_187_23 + var_187_24 and arg_184_1.time_ < var_187_23 + var_187_24 + arg_187_0 then
				local var_187_27 = Color.New(0, 0, 0)
				local var_187_28 = 0

				arg_184_1.mask_.enabled = false
				var_187_27.a = var_187_28
				arg_184_1.mask_.color = var_187_27
			end

			local var_187_29 = arg_184_1.actors_["1075ui_actor"].transform
			local var_187_30 = 1.96599999815226

			if var_187_30 < arg_184_1.time_ and arg_184_1.time_ <= var_187_30 + arg_187_0 then
				arg_184_1.var_.moveOldPos1075ui_actor = var_187_29.localPosition

				local var_187_31 = GameObjectTools.GetOrAddComponent(var_187_29.gameObject, typeof(DynamicBoneHelper))

				if var_187_31 then
					var_187_31:EnableDynamicBone(false)
				end
			end

			local var_187_32 = 0.001

			if var_187_30 <= arg_184_1.time_ and arg_184_1.time_ < var_187_30 + var_187_32 then
				local var_187_33 = (arg_184_1.time_ - var_187_30) / var_187_32
				local var_187_34 = Vector3.New(0, 100, 0)

				var_187_29.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1075ui_actor, var_187_34, var_187_33)

				local var_187_35 = manager.ui.mainCamera.transform.position - var_187_29.position

				var_187_29.forward = Vector3.New(var_187_35.x, var_187_35.y, var_187_35.z)

				local var_187_36 = var_187_29.localEulerAngles

				var_187_36.z = 0
				var_187_36.x = 0
				var_187_29.localEulerAngles = var_187_36
			end

			if arg_184_1.time_ >= var_187_30 + var_187_32 and arg_184_1.time_ < var_187_30 + var_187_32 + arg_187_0 then
				var_187_29.localPosition = Vector3.New(0, 100, 0)

				local var_187_37 = manager.ui.mainCamera.transform.position - var_187_29.position

				var_187_29.forward = Vector3.New(var_187_37.x, var_187_37.y, var_187_37.z)

				local var_187_38 = var_187_29.localEulerAngles

				var_187_38.z = 0
				var_187_38.x = 0
				var_187_29.localEulerAngles = var_187_38

				local var_187_39 = GameObjectTools.GetOrAddComponent(var_187_29.gameObject, typeof(DynamicBoneHelper))

				if var_187_39 then
					var_187_39:EnableDynamicBone(true)
				end
			end

			local var_187_40 = arg_184_1.actors_["1075ui_actor"]
			local var_187_41 = 1.96599999815226

			if var_187_41 < arg_184_1.time_ and arg_184_1.time_ <= var_187_41 + arg_187_0 and not isNil(var_187_40) and arg_184_1.var_.characterEffect1075ui_actor == nil then
				arg_184_1.var_.characterEffect1075ui_actor = var_187_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_42 = 0.034000001847744

			if var_187_41 <= arg_184_1.time_ and arg_184_1.time_ < var_187_41 + var_187_42 and not isNil(var_187_40) then
				local var_187_43 = (arg_184_1.time_ - var_187_41) / var_187_42

				if arg_184_1.var_.characterEffect1075ui_actor and not isNil(var_187_40) then
					local var_187_44 = Mathf.Lerp(0, 0.5, var_187_43)

					arg_184_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_184_1.var_.characterEffect1075ui_actor.fillRatio = var_187_44
				end
			end

			if arg_184_1.time_ >= var_187_41 + var_187_42 and arg_184_1.time_ < var_187_41 + var_187_42 + arg_187_0 and not isNil(var_187_40) and arg_184_1.var_.characterEffect1075ui_actor then
				local var_187_45 = 0.5

				arg_184_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_184_1.var_.characterEffect1075ui_actor.fillRatio = var_187_45
			end

			local var_187_46 = 2

			if var_187_46 < arg_184_1.time_ and arg_184_1.time_ <= var_187_46 + arg_187_0 then
				arg_184_1.fswbg_:SetActive(true)
				arg_184_1.dialog_:SetActive(false)

				arg_184_1.fswtw_.percent = 0

				local var_187_47 = arg_184_1:GetWordFromCfg(1107506044)
				local var_187_48 = arg_184_1:FormatText(var_187_47.content)

				arg_184_1.fswt_.text = var_187_48

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.fswt_)

				arg_184_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_184_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_184_1.fswtw_:SetDirty()

				arg_184_1.typewritterCharCountI18N = 0

				SetActive(arg_184_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_184_1:ShowNextGo(false)
			end

			local var_187_49 = 2.03400000184774

			if var_187_49 < arg_184_1.time_ and arg_184_1.time_ <= var_187_49 + arg_187_0 then
				arg_184_1.var_.oldValueTypewriter = arg_184_1.fswtw_.percent

				SetActive(arg_184_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_184_1:ShowNextGo(false)
			end

			local var_187_50 = 24
			local var_187_51 = 1.6
			local var_187_52 = arg_184_1:GetWordFromCfg(1107506044)
			local var_187_53 = arg_184_1:FormatText(var_187_52.content)
			local var_187_54, var_187_55 = arg_184_1:GetPercentByPara(var_187_53, 1)

			if var_187_49 < arg_184_1.time_ and arg_184_1.time_ <= var_187_49 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0

				local var_187_56 = var_187_50 <= 0 and var_187_51 or var_187_51 * ((var_187_55 - arg_184_1.typewritterCharCountI18N) / var_187_50)

				if var_187_56 > 0 and var_187_51 < var_187_56 then
					arg_184_1.talkMaxDuration = var_187_56

					if var_187_56 + var_187_49 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_56 + var_187_49
					end
				end
			end

			local var_187_57 = 1.6
			local var_187_58 = math.max(var_187_57, arg_184_1.talkMaxDuration)

			if var_187_49 <= arg_184_1.time_ and arg_184_1.time_ < var_187_49 + var_187_58 then
				local var_187_59 = (arg_184_1.time_ - var_187_49) / var_187_58

				arg_184_1.fswtw_.percent = Mathf.Lerp(arg_184_1.var_.oldValueTypewriter, var_187_54, var_187_59)
				arg_184_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_184_1.fswtw_:SetDirty()
			end

			if arg_184_1.time_ >= var_187_49 + var_187_58 and arg_184_1.time_ < var_187_49 + var_187_58 + arg_187_0 then
				arg_184_1.fswtw_.percent = var_187_54

				arg_184_1.fswtw_:SetDirty()
				arg_184_1:ShowNextGo(true)

				arg_184_1.typewritterCharCountI18N = var_187_55
			end

			local var_187_60 = 2.1

			if var_187_60 < arg_184_1.time_ and arg_184_1.time_ <= var_187_60 + arg_187_0 then
				local var_187_61 = arg_184_1.fswbg_.transform:Find("textbox/adapt/content") or arg_184_1.fswbg_.transform:Find("textbox/content")
				local var_187_62 = arg_184_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_187_63 = var_187_61:GetComponent("Text")
				local var_187_64 = var_187_61:GetComponent("RectTransform")

				var_187_63.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_187_64.offsetMin = Vector2.New(0, 0)
				var_187_64.offsetMax = Vector2.New(0, 0)
			end

			local var_187_65 = 2.03400000184774
			local var_187_66 = 1
			local var_187_67 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506044", "") / 1000

			if var_187_67 > 0 and var_187_66 < var_187_67 and var_187_67 + var_187_65 > arg_184_1.duration_ then
				local var_187_68 = var_187_67

				arg_184_1.duration_ = var_187_67 + var_187_65
			end

			if var_187_65 < arg_184_1.time_ and arg_184_1.time_ <= var_187_65 + arg_187_0 then
				local var_187_69 = "play"
				local var_187_70 = "voice"

				arg_184_1:AudioAction(var_187_69, var_187_70, "story_v_side_new_1107506", "1107506044", "")
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play1107506045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1107506045
		arg_188_1.duration_ = 1.7

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1107506046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.fswbg_:SetActive(true)
				arg_188_1.dialog_:SetActive(false)

				arg_188_1.fswtw_.percent = 0

				local var_191_1 = arg_188_1:GetWordFromCfg(1107506045)
				local var_191_2 = arg_188_1:FormatText(var_191_1.content)

				arg_188_1.fswt_.text = var_191_2

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.fswt_)

				arg_188_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_188_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_188_1.fswtw_:SetDirty()

				arg_188_1.typewritterCharCountI18N = 0

				SetActive(arg_188_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_188_1:ShowNextGo(false)
			end

			local var_191_3 = 0.1

			if var_191_3 < arg_188_1.time_ and arg_188_1.time_ <= var_191_3 + arg_191_0 then
				arg_188_1.var_.oldValueTypewriter = arg_188_1.fswtw_.percent

				SetActive(arg_188_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_188_1:ShowNextGo(false)
			end

			local var_191_4 = 24
			local var_191_5 = 1.6
			local var_191_6 = arg_188_1:GetWordFromCfg(1107506045)
			local var_191_7 = arg_188_1:FormatText(var_191_6.content)
			local var_191_8, var_191_9 = arg_188_1:GetPercentByPara(var_191_7, 1)

			if var_191_3 < arg_188_1.time_ and arg_188_1.time_ <= var_191_3 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				local var_191_10 = var_191_4 <= 0 and var_191_5 or var_191_5 * ((var_191_9 - arg_188_1.typewritterCharCountI18N) / var_191_4)

				if var_191_10 > 0 and var_191_5 < var_191_10 then
					arg_188_1.talkMaxDuration = var_191_10

					if var_191_10 + var_191_3 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_10 + var_191_3
					end
				end
			end

			local var_191_11 = 1.6
			local var_191_12 = math.max(var_191_11, arg_188_1.talkMaxDuration)

			if var_191_3 <= arg_188_1.time_ and arg_188_1.time_ < var_191_3 + var_191_12 then
				local var_191_13 = (arg_188_1.time_ - var_191_3) / var_191_12

				arg_188_1.fswtw_.percent = Mathf.Lerp(arg_188_1.var_.oldValueTypewriter, var_191_8, var_191_13)
				arg_188_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_188_1.fswtw_:SetDirty()
			end

			if arg_188_1.time_ >= var_191_3 + var_191_12 and arg_188_1.time_ < var_191_3 + var_191_12 + arg_191_0 then
				arg_188_1.fswtw_.percent = var_191_8

				arg_188_1.fswtw_:SetDirty()
				arg_188_1:ShowNextGo(true)

				arg_188_1.typewritterCharCountI18N = var_191_9
			end

			local var_191_14 = 0.1
			local var_191_15 = 1
			local var_191_16 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506045", "") / 1000

			if var_191_16 > 0 and var_191_15 < var_191_16 and var_191_16 + var_191_14 > arg_188_1.duration_ then
				local var_191_17 = var_191_16

				arg_188_1.duration_ = var_191_16 + var_191_14
			end

			if var_191_14 < arg_188_1.time_ and arg_188_1.time_ <= var_191_14 + arg_191_0 then
				local var_191_18 = "play"
				local var_191_19 = "voice"

				arg_188_1:AudioAction(var_191_18, var_191_19, "story_v_side_new_1107506", "1107506045", "")
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1107506046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1107506046
		arg_192_1.duration_ = 1.73

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1107506047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.fswbg_:SetActive(true)
				arg_192_1.dialog_:SetActive(false)

				arg_192_1.fswtw_.percent = 0

				local var_195_1 = arg_192_1:GetWordFromCfg(1107506046)
				local var_195_2 = arg_192_1:FormatText(var_195_1.content)

				arg_192_1.fswt_.text = var_195_2

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.fswt_)

				arg_192_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_192_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_192_1.fswtw_:SetDirty()

				arg_192_1.typewritterCharCountI18N = 0

				SetActive(arg_192_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_192_1:ShowNextGo(false)
			end

			local var_195_3 = 0.134000001847744

			if var_195_3 < arg_192_1.time_ and arg_192_1.time_ <= var_195_3 + arg_195_0 then
				arg_192_1.var_.oldValueTypewriter = arg_192_1.fswtw_.percent

				SetActive(arg_192_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_192_1:ShowNextGo(false)
			end

			local var_195_4 = 24
			local var_195_5 = 1.6
			local var_195_6 = arg_192_1:GetWordFromCfg(1107506046)
			local var_195_7 = arg_192_1:FormatText(var_195_6.content)
			local var_195_8, var_195_9 = arg_192_1:GetPercentByPara(var_195_7, 1)

			if var_195_3 < arg_192_1.time_ and arg_192_1.time_ <= var_195_3 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				local var_195_10 = var_195_4 <= 0 and var_195_5 or var_195_5 * ((var_195_9 - arg_192_1.typewritterCharCountI18N) / var_195_4)

				if var_195_10 > 0 and var_195_5 < var_195_10 then
					arg_192_1.talkMaxDuration = var_195_10

					if var_195_10 + var_195_3 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_10 + var_195_3
					end
				end
			end

			local var_195_11 = 1.6
			local var_195_12 = math.max(var_195_11, arg_192_1.talkMaxDuration)

			if var_195_3 <= arg_192_1.time_ and arg_192_1.time_ < var_195_3 + var_195_12 then
				local var_195_13 = (arg_192_1.time_ - var_195_3) / var_195_12

				arg_192_1.fswtw_.percent = Mathf.Lerp(arg_192_1.var_.oldValueTypewriter, var_195_8, var_195_13)
				arg_192_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_192_1.fswtw_:SetDirty()
			end

			if arg_192_1.time_ >= var_195_3 + var_195_12 and arg_192_1.time_ < var_195_3 + var_195_12 + arg_195_0 then
				arg_192_1.fswtw_.percent = var_195_8

				arg_192_1.fswtw_:SetDirty()
				arg_192_1:ShowNextGo(true)

				arg_192_1.typewritterCharCountI18N = var_195_9
			end

			local var_195_14 = 0.134000001847744
			local var_195_15 = 1
			local var_195_16 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506046", "") / 1000

			if var_195_16 > 0 and var_195_15 < var_195_16 and var_195_16 + var_195_14 > arg_192_1.duration_ then
				local var_195_17 = var_195_16

				arg_192_1.duration_ = var_195_16 + var_195_14
			end

			if var_195_14 < arg_192_1.time_ and arg_192_1.time_ <= var_195_14 + arg_195_0 then
				local var_195_18 = "play"
				local var_195_19 = "voice"

				arg_192_1:AudioAction(var_195_18, var_195_19, "story_v_side_new_1107506", "1107506046", "")
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play1107506047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1107506047
		arg_196_1.duration_ = 1.47

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1107506048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.fswbg_:SetActive(true)
				arg_196_1.dialog_:SetActive(false)

				arg_196_1.fswtw_.percent = 0

				local var_199_1 = arg_196_1:GetWordFromCfg(1107506047)
				local var_199_2 = arg_196_1:FormatText(var_199_1.content)

				arg_196_1.fswt_.text = var_199_2

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.fswt_)

				arg_196_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_196_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_196_1.fswtw_:SetDirty()

				arg_196_1.typewritterCharCountI18N = 0

				SetActive(arg_196_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_196_1:ShowNextGo(false)
			end

			local var_199_3 = 0.134000001847744

			if var_199_3 < arg_196_1.time_ and arg_196_1.time_ <= var_199_3 + arg_199_0 then
				arg_196_1.var_.oldValueTypewriter = arg_196_1.fswtw_.percent

				SetActive(arg_196_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_196_1:ShowNextGo(false)
			end

			local var_199_4 = 20
			local var_199_5 = 1.33333333333333
			local var_199_6 = arg_196_1:GetWordFromCfg(1107506047)
			local var_199_7 = arg_196_1:FormatText(var_199_6.content)
			local var_199_8, var_199_9 = arg_196_1:GetPercentByPara(var_199_7, 1)

			if var_199_3 < arg_196_1.time_ and arg_196_1.time_ <= var_199_3 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0

				local var_199_10 = var_199_4 <= 0 and var_199_5 or var_199_5 * ((var_199_9 - arg_196_1.typewritterCharCountI18N) / var_199_4)

				if var_199_10 > 0 and var_199_5 < var_199_10 then
					arg_196_1.talkMaxDuration = var_199_10

					if var_199_10 + var_199_3 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_3
					end
				end
			end

			local var_199_11 = 1.33333333333333
			local var_199_12 = math.max(var_199_11, arg_196_1.talkMaxDuration)

			if var_199_3 <= arg_196_1.time_ and arg_196_1.time_ < var_199_3 + var_199_12 then
				local var_199_13 = (arg_196_1.time_ - var_199_3) / var_199_12

				arg_196_1.fswtw_.percent = Mathf.Lerp(arg_196_1.var_.oldValueTypewriter, var_199_8, var_199_13)
				arg_196_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_196_1.fswtw_:SetDirty()
			end

			if arg_196_1.time_ >= var_199_3 + var_199_12 and arg_196_1.time_ < var_199_3 + var_199_12 + arg_199_0 then
				arg_196_1.fswtw_.percent = var_199_8

				arg_196_1.fswtw_:SetDirty()
				arg_196_1:ShowNextGo(true)

				arg_196_1.typewritterCharCountI18N = var_199_9
			end

			local var_199_14 = 0.134000001847744
			local var_199_15 = 1
			local var_199_16 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506047", "") / 1000

			if var_199_16 > 0 and var_199_15 < var_199_16 and var_199_16 + var_199_14 > arg_196_1.duration_ then
				local var_199_17 = var_199_16

				arg_196_1.duration_ = var_199_16 + var_199_14
			end

			if var_199_14 < arg_196_1.time_ and arg_196_1.time_ <= var_199_14 + arg_199_0 then
				local var_199_18 = "play"
				local var_199_19 = "voice"

				arg_196_1:AudioAction(var_199_18, var_199_19, "story_v_side_new_1107506", "1107506047", "")
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play1107506048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1107506048
		arg_200_1.duration_ = 1.6

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1107506049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.fswbg_:SetActive(true)
				arg_200_1.dialog_:SetActive(false)

				arg_200_1.fswtw_.percent = 0

				local var_203_1 = arg_200_1:GetWordFromCfg(1107506048)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.fswt_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.fswt_)

				arg_200_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_200_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_200_1.fswtw_:SetDirty()

				arg_200_1.typewritterCharCountI18N = 0

				SetActive(arg_200_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_200_1:ShowNextGo(false)
			end

			local var_203_3 = 0.134000001847744

			if var_203_3 < arg_200_1.time_ and arg_200_1.time_ <= var_203_3 + arg_203_0 then
				arg_200_1.var_.oldValueTypewriter = arg_200_1.fswtw_.percent

				SetActive(arg_200_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_200_1:ShowNextGo(false)
			end

			local var_203_4 = 22
			local var_203_5 = 1.46666666666667
			local var_203_6 = arg_200_1:GetWordFromCfg(1107506048)
			local var_203_7 = arg_200_1:FormatText(var_203_6.content)
			local var_203_8, var_203_9 = arg_200_1:GetPercentByPara(var_203_7, 1)

			if var_203_3 < arg_200_1.time_ and arg_200_1.time_ <= var_203_3 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0

				local var_203_10 = var_203_4 <= 0 and var_203_5 or var_203_5 * ((var_203_9 - arg_200_1.typewritterCharCountI18N) / var_203_4)

				if var_203_10 > 0 and var_203_5 < var_203_10 then
					arg_200_1.talkMaxDuration = var_203_10

					if var_203_10 + var_203_3 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_3
					end
				end
			end

			local var_203_11 = 1.46666666666667
			local var_203_12 = math.max(var_203_11, arg_200_1.talkMaxDuration)

			if var_203_3 <= arg_200_1.time_ and arg_200_1.time_ < var_203_3 + var_203_12 then
				local var_203_13 = (arg_200_1.time_ - var_203_3) / var_203_12

				arg_200_1.fswtw_.percent = Mathf.Lerp(arg_200_1.var_.oldValueTypewriter, var_203_8, var_203_13)
				arg_200_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_200_1.fswtw_:SetDirty()
			end

			if arg_200_1.time_ >= var_203_3 + var_203_12 and arg_200_1.time_ < var_203_3 + var_203_12 + arg_203_0 then
				arg_200_1.fswtw_.percent = var_203_8

				arg_200_1.fswtw_:SetDirty()
				arg_200_1:ShowNextGo(true)

				arg_200_1.typewritterCharCountI18N = var_203_9
			end

			local var_203_14 = 0.134000001847744
			local var_203_15 = 1
			local var_203_16 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506048", "") / 1000

			if var_203_16 > 0 and var_203_15 < var_203_16 and var_203_16 + var_203_14 > arg_200_1.duration_ then
				local var_203_17 = var_203_16

				arg_200_1.duration_ = var_203_16 + var_203_14
			end

			if var_203_14 < arg_200_1.time_ and arg_200_1.time_ <= var_203_14 + arg_203_0 then
				local var_203_18 = "play"
				local var_203_19 = "voice"

				arg_200_1:AudioAction(var_203_18, var_203_19, "story_v_side_new_1107506", "1107506048", "")
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1107506049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1107506049
		arg_204_1.duration_ = 10.8

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1107506050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 2.00000000298023

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				local var_207_1 = manager.ui.mainCamera.transform.localPosition
				local var_207_2 = Vector3.New(0, 0, 10) + Vector3.New(var_207_1.x, var_207_1.y, 0)
				local var_207_3 = arg_204_1.bgs_.ST47

				var_207_3.transform.localPosition = var_207_2
				var_207_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_207_4 = var_207_3:GetComponent("SpriteRenderer")

				if var_207_4 and var_207_4.sprite then
					local var_207_5 = (var_207_3.transform.localPosition - var_207_1).z
					local var_207_6 = manager.ui.mainCameraCom_
					local var_207_7 = 2 * var_207_5 * Mathf.Tan(var_207_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_207_8 = var_207_7 * var_207_6.aspect
					local var_207_9 = var_207_4.sprite.bounds.size.x
					local var_207_10 = var_207_4.sprite.bounds.size.y
					local var_207_11 = var_207_8 / var_207_9
					local var_207_12 = var_207_7 / var_207_10
					local var_207_13 = var_207_12 < var_207_11 and var_207_11 or var_207_12

					var_207_3.transform.localScale = Vector3.New(var_207_13, var_207_13, 0)
				end

				for iter_207_0, iter_207_1 in pairs(arg_204_1.bgs_) do
					if iter_207_0 ~= "ST47" then
						iter_207_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_207_14 = 4.00000000298023

			if var_207_14 < arg_204_1.time_ and arg_204_1.time_ <= var_207_14 + arg_207_0 then
				arg_204_1.allBtn_.enabled = false
			end

			local var_207_15 = 0.3

			if arg_204_1.time_ >= var_207_14 + var_207_15 and arg_204_1.time_ < var_207_14 + var_207_15 + arg_207_0 then
				arg_204_1.allBtn_.enabled = true
			end

			local var_207_16 = 0

			if var_207_16 < arg_204_1.time_ and arg_204_1.time_ <= var_207_16 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_17 = 2

			if var_207_16 <= arg_204_1.time_ and arg_204_1.time_ < var_207_16 + var_207_17 then
				local var_207_18 = (arg_204_1.time_ - var_207_16) / var_207_17
				local var_207_19 = Color.New(0, 0, 0)

				var_207_19.a = Mathf.Lerp(0, 1, var_207_18)
				arg_204_1.mask_.color = var_207_19
			end

			if arg_204_1.time_ >= var_207_16 + var_207_17 and arg_204_1.time_ < var_207_16 + var_207_17 + arg_207_0 then
				local var_207_20 = Color.New(0, 0, 0)

				var_207_20.a = 1
				arg_204_1.mask_.color = var_207_20
			end

			local var_207_21 = 2

			if var_207_21 < arg_204_1.time_ and arg_204_1.time_ <= var_207_21 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_22 = 2

			if var_207_21 <= arg_204_1.time_ and arg_204_1.time_ < var_207_21 + var_207_22 then
				local var_207_23 = (arg_204_1.time_ - var_207_21) / var_207_22
				local var_207_24 = Color.New(0, 0, 0)

				var_207_24.a = Mathf.Lerp(1, 0, var_207_23)
				arg_204_1.mask_.color = var_207_24
			end

			if arg_204_1.time_ >= var_207_21 + var_207_22 and arg_204_1.time_ < var_207_21 + var_207_22 + arg_207_0 then
				local var_207_25 = Color.New(0, 0, 0)
				local var_207_26 = 0

				arg_204_1.mask_.enabled = false
				var_207_25.a = var_207_26
				arg_204_1.mask_.color = var_207_25
			end

			local var_207_27 = arg_204_1.actors_["10044ui_story"].transform
			local var_207_28 = 3.8

			if var_207_28 < arg_204_1.time_ and arg_204_1.time_ <= var_207_28 + arg_207_0 then
				arg_204_1.var_.moveOldPos10044ui_story = var_207_27.localPosition
			end

			local var_207_29 = 0.001

			if var_207_28 <= arg_204_1.time_ and arg_204_1.time_ < var_207_28 + var_207_29 then
				local var_207_30 = (arg_204_1.time_ - var_207_28) / var_207_29
				local var_207_31 = Vector3.New(0, -0.72, -6.3)

				var_207_27.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10044ui_story, var_207_31, var_207_30)

				local var_207_32 = manager.ui.mainCamera.transform.position - var_207_27.position

				var_207_27.forward = Vector3.New(var_207_32.x, var_207_32.y, var_207_32.z)

				local var_207_33 = var_207_27.localEulerAngles

				var_207_33.z = 0
				var_207_33.x = 0
				var_207_27.localEulerAngles = var_207_33
			end

			if arg_204_1.time_ >= var_207_28 + var_207_29 and arg_204_1.time_ < var_207_28 + var_207_29 + arg_207_0 then
				var_207_27.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_207_34 = manager.ui.mainCamera.transform.position - var_207_27.position

				var_207_27.forward = Vector3.New(var_207_34.x, var_207_34.y, var_207_34.z)

				local var_207_35 = var_207_27.localEulerAngles

				var_207_35.z = 0
				var_207_35.x = 0
				var_207_27.localEulerAngles = var_207_35
			end

			local var_207_36 = arg_204_1.actors_["10044ui_story"]
			local var_207_37 = 3.8

			if var_207_37 < arg_204_1.time_ and arg_204_1.time_ <= var_207_37 + arg_207_0 and not isNil(var_207_36) and arg_204_1.var_.characterEffect10044ui_story == nil then
				arg_204_1.var_.characterEffect10044ui_story = var_207_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_38 = 0.200000002980232

			if var_207_37 <= arg_204_1.time_ and arg_204_1.time_ < var_207_37 + var_207_38 and not isNil(var_207_36) then
				local var_207_39 = (arg_204_1.time_ - var_207_37) / var_207_38

				if arg_204_1.var_.characterEffect10044ui_story and not isNil(var_207_36) then
					arg_204_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_37 + var_207_38 and arg_204_1.time_ < var_207_37 + var_207_38 + arg_207_0 and not isNil(var_207_36) and arg_204_1.var_.characterEffect10044ui_story then
				arg_204_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_207_40 = 3.8

			if var_207_40 < arg_204_1.time_ and arg_204_1.time_ <= var_207_40 + arg_207_0 then
				arg_204_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_207_41 = 3.8

			if var_207_41 < arg_204_1.time_ and arg_204_1.time_ <= var_207_41 + arg_207_0 then
				arg_204_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_207_42 = 1.95

			if var_207_42 < arg_204_1.time_ and arg_204_1.time_ <= var_207_42 + arg_207_0 then
				arg_204_1.fswbg_:SetActive(false)
				arg_204_1.dialog_:SetActive(false)
				SetActive(arg_204_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_204_1:ShowNextGo(false)
			end

			local var_207_43 = 2.00000000298023

			arg_204_1.isInRecall_ = false

			if var_207_43 < arg_204_1.time_ and arg_204_1.time_ <= var_207_43 + arg_207_0 then
				arg_204_1.screenFilterGo_:SetActive(true)

				arg_204_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")

				for iter_207_2, iter_207_3 in pairs(arg_204_1.actors_) do
					local var_207_44 = iter_207_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_207_4, iter_207_5 in ipairs(var_207_44) do
						if iter_207_5.color.r > 0.51 then
							iter_207_5.color = Color.New(1, 1, 1)
						else
							iter_207_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_207_45 = 0.0333333333333332

			if var_207_43 <= arg_204_1.time_ and arg_204_1.time_ < var_207_43 + var_207_45 then
				local var_207_46 = (arg_204_1.time_ - var_207_43) / var_207_45

				arg_204_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_207_46)
			end

			if arg_204_1.time_ >= var_207_43 + var_207_45 and arg_204_1.time_ < var_207_43 + var_207_45 + arg_207_0 then
				arg_204_1.screenFilterEffect_.weight = 1
			end

			if arg_204_1.frameCnt_ <= 1 then
				arg_204_1.dialog_:SetActive(false)
			end

			local var_207_47 = 4.00000000298023
			local var_207_48 = 0.8

			if var_207_47 < arg_204_1.time_ and arg_204_1.time_ <= var_207_47 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0

				arg_204_1.dialog_:SetActive(true)

				arg_204_1.dialogCg_.alpha = 0

				local var_207_49 = LeanTween.value(arg_204_1.dialog_, 0, 1, 0.3)

				var_207_49:setOnUpdate(LuaHelper.FloatAction(function(arg_208_0)
					arg_204_1.dialogCg_.alpha = arg_208_0
				end))
				var_207_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_204_1.dialog_)
					var_207_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_204_1.duration_ = arg_204_1.duration_ + 0.3

				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_50 = arg_204_1:FormatText(StoryNameCfg[380].name)

				arg_204_1.leftNameTxt_.text = var_207_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_51 = arg_204_1:GetWordFromCfg(1107506049)
				local var_207_52 = arg_204_1:FormatText(var_207_51.content)

				arg_204_1.text_.text = var_207_52

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_53 = 32
				local var_207_54 = utf8.len(var_207_52)
				local var_207_55 = var_207_53 <= 0 and var_207_48 or var_207_48 * (var_207_54 / var_207_53)

				if var_207_55 > 0 and var_207_48 < var_207_55 then
					arg_204_1.talkMaxDuration = var_207_55
					var_207_47 = var_207_47 + 0.3

					if var_207_55 + var_207_47 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_55 + var_207_47
					end
				end

				arg_204_1.text_.text = var_207_52
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506049", "story_v_side_new_1107506.awb") ~= 0 then
					local var_207_56 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506049", "story_v_side_new_1107506.awb") / 1000

					if var_207_56 + var_207_47 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_56 + var_207_47
					end

					if var_207_51.prefab_name ~= "" and arg_204_1.actors_[var_207_51.prefab_name] ~= nil then
						local var_207_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_51.prefab_name].transform, "story_v_side_new_1107506", "1107506049", "story_v_side_new_1107506.awb")

						arg_204_1:RecordAudio("1107506049", var_207_57)
						arg_204_1:RecordAudio("1107506049", var_207_57)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506049", "story_v_side_new_1107506.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506049", "story_v_side_new_1107506.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_58 = var_207_47 + 0.3
			local var_207_59 = math.max(var_207_48, arg_204_1.talkMaxDuration)

			if var_207_58 <= arg_204_1.time_ and arg_204_1.time_ < var_207_58 + var_207_59 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_58) / var_207_59

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_58 + var_207_59 and arg_204_1.time_ < var_207_58 + var_207_59 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play1107506050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1107506050
		arg_210_1.duration_ = 4.5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1107506051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["10044ui_story"].transform
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.var_.moveOldPos10044ui_story = var_213_0.localPosition
			end

			local var_213_2 = 0.001

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2
				local var_213_4 = Vector3.New(-0.7, -0.72, -6.3)

				var_213_0.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10044ui_story, var_213_4, var_213_3)

				local var_213_5 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_5.x, var_213_5.y, var_213_5.z)

				local var_213_6 = var_213_0.localEulerAngles

				var_213_6.z = 0
				var_213_6.x = 0
				var_213_0.localEulerAngles = var_213_6
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 then
				var_213_0.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_213_7 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_7.x, var_213_7.y, var_213_7.z)

				local var_213_8 = var_213_0.localEulerAngles

				var_213_8.z = 0
				var_213_8.x = 0
				var_213_0.localEulerAngles = var_213_8
			end

			local var_213_9 = arg_210_1.actors_["1075ui_actor"].transform
			local var_213_10 = 0

			if var_213_10 < arg_210_1.time_ and arg_210_1.time_ <= var_213_10 + arg_213_0 then
				arg_210_1.var_.moveOldPos1075ui_actor = var_213_9.localPosition

				local var_213_11 = GameObjectTools.GetOrAddComponent(var_213_9.gameObject, typeof(DynamicBoneHelper))

				if var_213_11 then
					var_213_11:EnableDynamicBone(false)
				end
			end

			local var_213_12 = 0.001

			if var_213_10 <= arg_210_1.time_ and arg_210_1.time_ < var_213_10 + var_213_12 then
				local var_213_13 = (arg_210_1.time_ - var_213_10) / var_213_12
				local var_213_14 = Vector3.New(0.7, -1.055, -6.16)

				var_213_9.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1075ui_actor, var_213_14, var_213_13)

				local var_213_15 = manager.ui.mainCamera.transform.position - var_213_9.position

				var_213_9.forward = Vector3.New(var_213_15.x, var_213_15.y, var_213_15.z)

				local var_213_16 = var_213_9.localEulerAngles

				var_213_16.z = 0
				var_213_16.x = 0
				var_213_9.localEulerAngles = var_213_16
			end

			if arg_210_1.time_ >= var_213_10 + var_213_12 and arg_210_1.time_ < var_213_10 + var_213_12 + arg_213_0 then
				var_213_9.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_213_17 = manager.ui.mainCamera.transform.position - var_213_9.position

				var_213_9.forward = Vector3.New(var_213_17.x, var_213_17.y, var_213_17.z)

				local var_213_18 = var_213_9.localEulerAngles

				var_213_18.z = 0
				var_213_18.x = 0
				var_213_9.localEulerAngles = var_213_18

				local var_213_19 = GameObjectTools.GetOrAddComponent(var_213_9.gameObject, typeof(DynamicBoneHelper))

				if var_213_19 then
					var_213_19:EnableDynamicBone(true)
				end
			end

			local var_213_20 = arg_210_1.actors_["1075ui_actor"]
			local var_213_21 = 0

			if var_213_21 < arg_210_1.time_ and arg_210_1.time_ <= var_213_21 + arg_213_0 and not isNil(var_213_20) and arg_210_1.var_.characterEffect1075ui_actor == nil then
				arg_210_1.var_.characterEffect1075ui_actor = var_213_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_22 = 0.200000002980232

			if var_213_21 <= arg_210_1.time_ and arg_210_1.time_ < var_213_21 + var_213_22 and not isNil(var_213_20) then
				local var_213_23 = (arg_210_1.time_ - var_213_21) / var_213_22

				if arg_210_1.var_.characterEffect1075ui_actor and not isNil(var_213_20) then
					arg_210_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_21 + var_213_22 and arg_210_1.time_ < var_213_21 + var_213_22 + arg_213_0 and not isNil(var_213_20) and arg_210_1.var_.characterEffect1075ui_actor then
				arg_210_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_213_24 = arg_210_1.actors_["10044ui_story"]
			local var_213_25 = 0

			if var_213_25 < arg_210_1.time_ and arg_210_1.time_ <= var_213_25 + arg_213_0 and not isNil(var_213_24) and arg_210_1.var_.characterEffect10044ui_story == nil then
				arg_210_1.var_.characterEffect10044ui_story = var_213_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_26 = 0.200000002980232

			if var_213_25 <= arg_210_1.time_ and arg_210_1.time_ < var_213_25 + var_213_26 and not isNil(var_213_24) then
				local var_213_27 = (arg_210_1.time_ - var_213_25) / var_213_26

				if arg_210_1.var_.characterEffect10044ui_story and not isNil(var_213_24) then
					local var_213_28 = Mathf.Lerp(0, 0.5, var_213_27)

					arg_210_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_210_1.var_.characterEffect10044ui_story.fillRatio = var_213_28
				end
			end

			if arg_210_1.time_ >= var_213_25 + var_213_26 and arg_210_1.time_ < var_213_25 + var_213_26 + arg_213_0 and not isNil(var_213_24) and arg_210_1.var_.characterEffect10044ui_story then
				local var_213_29 = 0.5

				arg_210_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_210_1.var_.characterEffect10044ui_story.fillRatio = var_213_29
			end

			local var_213_30 = 0

			if var_213_30 < arg_210_1.time_ and arg_210_1.time_ <= var_213_30 + arg_213_0 then
				arg_210_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_213_31 = 0

			if var_213_31 < arg_210_1.time_ and arg_210_1.time_ <= var_213_31 + arg_213_0 then
				arg_210_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_213_32 = 0
			local var_213_33 = 0.4

			if var_213_32 < arg_210_1.time_ and arg_210_1.time_ <= var_213_32 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_34 = arg_210_1:FormatText(StoryNameCfg[381].name)

				arg_210_1.leftNameTxt_.text = var_213_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_35 = arg_210_1:GetWordFromCfg(1107506050)
				local var_213_36 = arg_210_1:FormatText(var_213_35.content)

				arg_210_1.text_.text = var_213_36

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_37 = 16
				local var_213_38 = utf8.len(var_213_36)
				local var_213_39 = var_213_37 <= 0 and var_213_33 or var_213_33 * (var_213_38 / var_213_37)

				if var_213_39 > 0 and var_213_33 < var_213_39 then
					arg_210_1.talkMaxDuration = var_213_39

					if var_213_39 + var_213_32 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_39 + var_213_32
					end
				end

				arg_210_1.text_.text = var_213_36
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506050", "story_v_side_new_1107506.awb") ~= 0 then
					local var_213_40 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506050", "story_v_side_new_1107506.awb") / 1000

					if var_213_40 + var_213_32 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_40 + var_213_32
					end

					if var_213_35.prefab_name ~= "" and arg_210_1.actors_[var_213_35.prefab_name] ~= nil then
						local var_213_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_35.prefab_name].transform, "story_v_side_new_1107506", "1107506050", "story_v_side_new_1107506.awb")

						arg_210_1:RecordAudio("1107506050", var_213_41)
						arg_210_1:RecordAudio("1107506050", var_213_41)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506050", "story_v_side_new_1107506.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506050", "story_v_side_new_1107506.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_42 = math.max(var_213_33, arg_210_1.talkMaxDuration)

			if var_213_32 <= arg_210_1.time_ and arg_210_1.time_ < var_213_32 + var_213_42 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_32) / var_213_42

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_32 + var_213_42 and arg_210_1.time_ < var_213_32 + var_213_42 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play1107506051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1107506051
		arg_214_1.duration_ = 5.6

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1107506052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["10044ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect10044ui_story == nil then
				arg_214_1.var_.characterEffect10044ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect10044ui_story and not isNil(var_217_0) then
					arg_214_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect10044ui_story then
				arg_214_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_217_4 = arg_214_1.actors_["1075ui_actor"]
			local var_217_5 = 0

			if var_217_5 < arg_214_1.time_ and arg_214_1.time_ <= var_217_5 + arg_217_0 and not isNil(var_217_4) and arg_214_1.var_.characterEffect1075ui_actor == nil then
				arg_214_1.var_.characterEffect1075ui_actor = var_217_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_6 = 0.200000002980232

			if var_217_5 <= arg_214_1.time_ and arg_214_1.time_ < var_217_5 + var_217_6 and not isNil(var_217_4) then
				local var_217_7 = (arg_214_1.time_ - var_217_5) / var_217_6

				if arg_214_1.var_.characterEffect1075ui_actor and not isNil(var_217_4) then
					local var_217_8 = Mathf.Lerp(0, 0.5, var_217_7)

					arg_214_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_214_1.var_.characterEffect1075ui_actor.fillRatio = var_217_8
				end
			end

			if arg_214_1.time_ >= var_217_5 + var_217_6 and arg_214_1.time_ < var_217_5 + var_217_6 + arg_217_0 and not isNil(var_217_4) and arg_214_1.var_.characterEffect1075ui_actor then
				local var_217_9 = 0.5

				arg_214_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_214_1.var_.characterEffect1075ui_actor.fillRatio = var_217_9
			end

			local var_217_10 = 0

			if var_217_10 < arg_214_1.time_ and arg_214_1.time_ <= var_217_10 + arg_217_0 then
				arg_214_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_217_11 = 0

			if var_217_11 < arg_214_1.time_ and arg_214_1.time_ <= var_217_11 + arg_217_0 then
				arg_214_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_217_12 = 0
			local var_217_13 = 0.575

			if var_217_12 < arg_214_1.time_ and arg_214_1.time_ <= var_217_12 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_14 = arg_214_1:FormatText(StoryNameCfg[380].name)

				arg_214_1.leftNameTxt_.text = var_217_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_15 = arg_214_1:GetWordFromCfg(1107506051)
				local var_217_16 = arg_214_1:FormatText(var_217_15.content)

				arg_214_1.text_.text = var_217_16

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_17 = 23
				local var_217_18 = utf8.len(var_217_16)
				local var_217_19 = var_217_17 <= 0 and var_217_13 or var_217_13 * (var_217_18 / var_217_17)

				if var_217_19 > 0 and var_217_13 < var_217_19 then
					arg_214_1.talkMaxDuration = var_217_19

					if var_217_19 + var_217_12 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_19 + var_217_12
					end
				end

				arg_214_1.text_.text = var_217_16
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506051", "story_v_side_new_1107506.awb") ~= 0 then
					local var_217_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506051", "story_v_side_new_1107506.awb") / 1000

					if var_217_20 + var_217_12 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_20 + var_217_12
					end

					if var_217_15.prefab_name ~= "" and arg_214_1.actors_[var_217_15.prefab_name] ~= nil then
						local var_217_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_15.prefab_name].transform, "story_v_side_new_1107506", "1107506051", "story_v_side_new_1107506.awb")

						arg_214_1:RecordAudio("1107506051", var_217_21)
						arg_214_1:RecordAudio("1107506051", var_217_21)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506051", "story_v_side_new_1107506.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506051", "story_v_side_new_1107506.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_22 = math.max(var_217_13, arg_214_1.talkMaxDuration)

			if var_217_12 <= arg_214_1.time_ and arg_214_1.time_ < var_217_12 + var_217_22 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_12) / var_217_22

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_12 + var_217_22 and arg_214_1.time_ < var_217_12 + var_217_22 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1107506052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1107506052
		arg_218_1.duration_ = 7.3

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1107506053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1075ui_actor"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1075ui_actor == nil then
				arg_218_1.var_.characterEffect1075ui_actor = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.200000002980232

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect1075ui_actor and not isNil(var_221_0) then
					arg_218_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect1075ui_actor then
				arg_218_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_221_4 = arg_218_1.actors_["10044ui_story"]
			local var_221_5 = 0

			if var_221_5 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 and not isNil(var_221_4) and arg_218_1.var_.characterEffect10044ui_story == nil then
				arg_218_1.var_.characterEffect10044ui_story = var_221_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_6 = 0.200000002980232

			if var_221_5 <= arg_218_1.time_ and arg_218_1.time_ < var_221_5 + var_221_6 and not isNil(var_221_4) then
				local var_221_7 = (arg_218_1.time_ - var_221_5) / var_221_6

				if arg_218_1.var_.characterEffect10044ui_story and not isNil(var_221_4) then
					local var_221_8 = Mathf.Lerp(0, 0.5, var_221_7)

					arg_218_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10044ui_story.fillRatio = var_221_8
				end
			end

			if arg_218_1.time_ >= var_221_5 + var_221_6 and arg_218_1.time_ < var_221_5 + var_221_6 + arg_221_0 and not isNil(var_221_4) and arg_218_1.var_.characterEffect10044ui_story then
				local var_221_9 = 0.5

				arg_218_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10044ui_story.fillRatio = var_221_9
			end

			local var_221_10 = 0

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 then
				arg_218_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_221_11 = 0

			if var_221_11 < arg_218_1.time_ and arg_218_1.time_ <= var_221_11 + arg_221_0 then
				arg_218_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_221_12 = 0
			local var_221_13 = 0.575

			if var_221_12 < arg_218_1.time_ and arg_218_1.time_ <= var_221_12 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_14 = arg_218_1:FormatText(StoryNameCfg[381].name)

				arg_218_1.leftNameTxt_.text = var_221_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_15 = arg_218_1:GetWordFromCfg(1107506052)
				local var_221_16 = arg_218_1:FormatText(var_221_15.content)

				arg_218_1.text_.text = var_221_16

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_17 = 23
				local var_221_18 = utf8.len(var_221_16)
				local var_221_19 = var_221_17 <= 0 and var_221_13 or var_221_13 * (var_221_18 / var_221_17)

				if var_221_19 > 0 and var_221_13 < var_221_19 then
					arg_218_1.talkMaxDuration = var_221_19

					if var_221_19 + var_221_12 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_19 + var_221_12
					end
				end

				arg_218_1.text_.text = var_221_16
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506052", "story_v_side_new_1107506.awb") ~= 0 then
					local var_221_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506052", "story_v_side_new_1107506.awb") / 1000

					if var_221_20 + var_221_12 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_20 + var_221_12
					end

					if var_221_15.prefab_name ~= "" and arg_218_1.actors_[var_221_15.prefab_name] ~= nil then
						local var_221_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_15.prefab_name].transform, "story_v_side_new_1107506", "1107506052", "story_v_side_new_1107506.awb")

						arg_218_1:RecordAudio("1107506052", var_221_21)
						arg_218_1:RecordAudio("1107506052", var_221_21)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506052", "story_v_side_new_1107506.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506052", "story_v_side_new_1107506.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_22 = math.max(var_221_13, arg_218_1.talkMaxDuration)

			if var_221_12 <= arg_218_1.time_ and arg_218_1.time_ < var_221_12 + var_221_22 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_12) / var_221_22

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_12 + var_221_22 and arg_218_1.time_ < var_221_12 + var_221_22 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1107506053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1107506053
		arg_222_1.duration_ = 4.27

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1107506054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10044ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect10044ui_story == nil then
				arg_222_1.var_.characterEffect10044ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect10044ui_story and not isNil(var_225_0) then
					arg_222_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect10044ui_story then
				arg_222_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_225_4 = arg_222_1.actors_["1075ui_actor"]
			local var_225_5 = 0

			if var_225_5 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 and not isNil(var_225_4) and arg_222_1.var_.characterEffect1075ui_actor == nil then
				arg_222_1.var_.characterEffect1075ui_actor = var_225_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_6 = 0.200000002980232

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_6 and not isNil(var_225_4) then
				local var_225_7 = (arg_222_1.time_ - var_225_5) / var_225_6

				if arg_222_1.var_.characterEffect1075ui_actor and not isNil(var_225_4) then
					local var_225_8 = Mathf.Lerp(0, 0.5, var_225_7)

					arg_222_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_222_1.var_.characterEffect1075ui_actor.fillRatio = var_225_8
				end
			end

			if arg_222_1.time_ >= var_225_5 + var_225_6 and arg_222_1.time_ < var_225_5 + var_225_6 + arg_225_0 and not isNil(var_225_4) and arg_222_1.var_.characterEffect1075ui_actor then
				local var_225_9 = 0.5

				arg_222_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_222_1.var_.characterEffect1075ui_actor.fillRatio = var_225_9
			end

			local var_225_10 = 0

			if var_225_10 < arg_222_1.time_ and arg_222_1.time_ <= var_225_10 + arg_225_0 then
				arg_222_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			local var_225_11 = 0

			if var_225_11 < arg_222_1.time_ and arg_222_1.time_ <= var_225_11 + arg_225_0 then
				arg_222_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_225_12 = 0
			local var_225_13 = 0.35

			if var_225_12 < arg_222_1.time_ and arg_222_1.time_ <= var_225_12 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_14 = arg_222_1:FormatText(StoryNameCfg[380].name)

				arg_222_1.leftNameTxt_.text = var_225_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_15 = arg_222_1:GetWordFromCfg(1107506053)
				local var_225_16 = arg_222_1:FormatText(var_225_15.content)

				arg_222_1.text_.text = var_225_16

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_17 = 14
				local var_225_18 = utf8.len(var_225_16)
				local var_225_19 = var_225_17 <= 0 and var_225_13 or var_225_13 * (var_225_18 / var_225_17)

				if var_225_19 > 0 and var_225_13 < var_225_19 then
					arg_222_1.talkMaxDuration = var_225_19

					if var_225_19 + var_225_12 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_19 + var_225_12
					end
				end

				arg_222_1.text_.text = var_225_16
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506053", "story_v_side_new_1107506.awb") ~= 0 then
					local var_225_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506053", "story_v_side_new_1107506.awb") / 1000

					if var_225_20 + var_225_12 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_20 + var_225_12
					end

					if var_225_15.prefab_name ~= "" and arg_222_1.actors_[var_225_15.prefab_name] ~= nil then
						local var_225_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_15.prefab_name].transform, "story_v_side_new_1107506", "1107506053", "story_v_side_new_1107506.awb")

						arg_222_1:RecordAudio("1107506053", var_225_21)
						arg_222_1:RecordAudio("1107506053", var_225_21)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506053", "story_v_side_new_1107506.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506053", "story_v_side_new_1107506.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_22 = math.max(var_225_13, arg_222_1.talkMaxDuration)

			if var_225_12 <= arg_222_1.time_ and arg_222_1.time_ < var_225_12 + var_225_22 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_12) / var_225_22

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_12 + var_225_22 and arg_222_1.time_ < var_225_12 + var_225_22 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1107506054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1107506054
		arg_226_1.duration_ = 6.23

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1107506055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1075ui_actor"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1075ui_actor == nil then
				arg_226_1.var_.characterEffect1075ui_actor = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.200000002980232

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect1075ui_actor and not isNil(var_229_0) then
					arg_226_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1075ui_actor then
				arg_226_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_229_4 = arg_226_1.actors_["10044ui_story"]
			local var_229_5 = 0

			if var_229_5 < arg_226_1.time_ and arg_226_1.time_ <= var_229_5 + arg_229_0 and not isNil(var_229_4) and arg_226_1.var_.characterEffect10044ui_story == nil then
				arg_226_1.var_.characterEffect10044ui_story = var_229_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_6 = 0.200000002980232

			if var_229_5 <= arg_226_1.time_ and arg_226_1.time_ < var_229_5 + var_229_6 and not isNil(var_229_4) then
				local var_229_7 = (arg_226_1.time_ - var_229_5) / var_229_6

				if arg_226_1.var_.characterEffect10044ui_story and not isNil(var_229_4) then
					local var_229_8 = Mathf.Lerp(0, 0.5, var_229_7)

					arg_226_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_226_1.var_.characterEffect10044ui_story.fillRatio = var_229_8
				end
			end

			if arg_226_1.time_ >= var_229_5 + var_229_6 and arg_226_1.time_ < var_229_5 + var_229_6 + arg_229_0 and not isNil(var_229_4) and arg_226_1.var_.characterEffect10044ui_story then
				local var_229_9 = 0.5

				arg_226_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_226_1.var_.characterEffect10044ui_story.fillRatio = var_229_9
			end

			local var_229_10 = 0

			if var_229_10 < arg_226_1.time_ and arg_226_1.time_ <= var_229_10 + arg_229_0 then
				arg_226_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action423")
			end

			local var_229_11 = 0

			if var_229_11 < arg_226_1.time_ and arg_226_1.time_ <= var_229_11 + arg_229_0 then
				arg_226_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_229_12 = 0
			local var_229_13 = 0.625

			if var_229_12 < arg_226_1.time_ and arg_226_1.time_ <= var_229_12 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_14 = arg_226_1:FormatText(StoryNameCfg[381].name)

				arg_226_1.leftNameTxt_.text = var_229_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_15 = arg_226_1:GetWordFromCfg(1107506054)
				local var_229_16 = arg_226_1:FormatText(var_229_15.content)

				arg_226_1.text_.text = var_229_16

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_17 = 25
				local var_229_18 = utf8.len(var_229_16)
				local var_229_19 = var_229_17 <= 0 and var_229_13 or var_229_13 * (var_229_18 / var_229_17)

				if var_229_19 > 0 and var_229_13 < var_229_19 then
					arg_226_1.talkMaxDuration = var_229_19

					if var_229_19 + var_229_12 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_19 + var_229_12
					end
				end

				arg_226_1.text_.text = var_229_16
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506054", "story_v_side_new_1107506.awb") ~= 0 then
					local var_229_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506054", "story_v_side_new_1107506.awb") / 1000

					if var_229_20 + var_229_12 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_20 + var_229_12
					end

					if var_229_15.prefab_name ~= "" and arg_226_1.actors_[var_229_15.prefab_name] ~= nil then
						local var_229_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_15.prefab_name].transform, "story_v_side_new_1107506", "1107506054", "story_v_side_new_1107506.awb")

						arg_226_1:RecordAudio("1107506054", var_229_21)
						arg_226_1:RecordAudio("1107506054", var_229_21)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506054", "story_v_side_new_1107506.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506054", "story_v_side_new_1107506.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_22 = math.max(var_229_13, arg_226_1.talkMaxDuration)

			if var_229_12 <= arg_226_1.time_ and arg_226_1.time_ < var_229_12 + var_229_22 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_12) / var_229_22

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_12 + var_229_22 and arg_226_1.time_ < var_229_12 + var_229_22 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play1107506055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1107506055
		arg_230_1.duration_ = 7.4

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1107506056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10044ui_story"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect10044ui_story == nil then
				arg_230_1.var_.characterEffect10044ui_story = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect10044ui_story and not isNil(var_233_0) then
					arg_230_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect10044ui_story then
				arg_230_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_233_4 = arg_230_1.actors_["1075ui_actor"]
			local var_233_5 = 0

			if var_233_5 < arg_230_1.time_ and arg_230_1.time_ <= var_233_5 + arg_233_0 and not isNil(var_233_4) and arg_230_1.var_.characterEffect1075ui_actor == nil then
				arg_230_1.var_.characterEffect1075ui_actor = var_233_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_6 = 0.200000002980232

			if var_233_5 <= arg_230_1.time_ and arg_230_1.time_ < var_233_5 + var_233_6 and not isNil(var_233_4) then
				local var_233_7 = (arg_230_1.time_ - var_233_5) / var_233_6

				if arg_230_1.var_.characterEffect1075ui_actor and not isNil(var_233_4) then
					local var_233_8 = Mathf.Lerp(0, 0.5, var_233_7)

					arg_230_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_230_1.var_.characterEffect1075ui_actor.fillRatio = var_233_8
				end
			end

			if arg_230_1.time_ >= var_233_5 + var_233_6 and arg_230_1.time_ < var_233_5 + var_233_6 + arg_233_0 and not isNil(var_233_4) and arg_230_1.var_.characterEffect1075ui_actor then
				local var_233_9 = 0.5

				arg_230_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_230_1.var_.characterEffect1075ui_actor.fillRatio = var_233_9
			end

			local var_233_10 = 0

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 then
				arg_230_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_233_11 = 0

			if var_233_11 < arg_230_1.time_ and arg_230_1.time_ <= var_233_11 + arg_233_0 then
				arg_230_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_233_12 = 0
			local var_233_13 = 0.9

			if var_233_12 < arg_230_1.time_ and arg_230_1.time_ <= var_233_12 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_14 = arg_230_1:FormatText(StoryNameCfg[380].name)

				arg_230_1.leftNameTxt_.text = var_233_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_15 = arg_230_1:GetWordFromCfg(1107506055)
				local var_233_16 = arg_230_1:FormatText(var_233_15.content)

				arg_230_1.text_.text = var_233_16

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_17 = 36
				local var_233_18 = utf8.len(var_233_16)
				local var_233_19 = var_233_17 <= 0 and var_233_13 or var_233_13 * (var_233_18 / var_233_17)

				if var_233_19 > 0 and var_233_13 < var_233_19 then
					arg_230_1.talkMaxDuration = var_233_19

					if var_233_19 + var_233_12 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_19 + var_233_12
					end
				end

				arg_230_1.text_.text = var_233_16
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506055", "story_v_side_new_1107506.awb") ~= 0 then
					local var_233_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506055", "story_v_side_new_1107506.awb") / 1000

					if var_233_20 + var_233_12 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_20 + var_233_12
					end

					if var_233_15.prefab_name ~= "" and arg_230_1.actors_[var_233_15.prefab_name] ~= nil then
						local var_233_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_15.prefab_name].transform, "story_v_side_new_1107506", "1107506055", "story_v_side_new_1107506.awb")

						arg_230_1:RecordAudio("1107506055", var_233_21)
						arg_230_1:RecordAudio("1107506055", var_233_21)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506055", "story_v_side_new_1107506.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506055", "story_v_side_new_1107506.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_22 = math.max(var_233_13, arg_230_1.talkMaxDuration)

			if var_233_12 <= arg_230_1.time_ and arg_230_1.time_ < var_233_12 + var_233_22 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_12) / var_233_22

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_12 + var_233_22 and arg_230_1.time_ < var_233_12 + var_233_22 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1107506056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1107506056
		arg_234_1.duration_ = 2

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1107506057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1075ui_actor"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1075ui_actor == nil then
				arg_234_1.var_.characterEffect1075ui_actor = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect1075ui_actor and not isNil(var_237_0) then
					arg_234_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1075ui_actor then
				arg_234_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_237_4 = arg_234_1.actors_["10044ui_story"]
			local var_237_5 = 0

			if var_237_5 < arg_234_1.time_ and arg_234_1.time_ <= var_237_5 + arg_237_0 and not isNil(var_237_4) and arg_234_1.var_.characterEffect10044ui_story == nil then
				arg_234_1.var_.characterEffect10044ui_story = var_237_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_6 = 0.200000002980232

			if var_237_5 <= arg_234_1.time_ and arg_234_1.time_ < var_237_5 + var_237_6 and not isNil(var_237_4) then
				local var_237_7 = (arg_234_1.time_ - var_237_5) / var_237_6

				if arg_234_1.var_.characterEffect10044ui_story and not isNil(var_237_4) then
					local var_237_8 = Mathf.Lerp(0, 0.5, var_237_7)

					arg_234_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_234_1.var_.characterEffect10044ui_story.fillRatio = var_237_8
				end
			end

			if arg_234_1.time_ >= var_237_5 + var_237_6 and arg_234_1.time_ < var_237_5 + var_237_6 + arg_237_0 and not isNil(var_237_4) and arg_234_1.var_.characterEffect10044ui_story then
				local var_237_9 = 0.5

				arg_234_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_234_1.var_.characterEffect10044ui_story.fillRatio = var_237_9
			end

			local var_237_10 = 0

			if var_237_10 < arg_234_1.time_ and arg_234_1.time_ <= var_237_10 + arg_237_0 then
				arg_234_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_237_11 = 0

			if var_237_11 < arg_234_1.time_ and arg_234_1.time_ <= var_237_11 + arg_237_0 then
				arg_234_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_237_12 = 0
			local var_237_13 = 0.15

			if var_237_12 < arg_234_1.time_ and arg_234_1.time_ <= var_237_12 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_14 = arg_234_1:FormatText(StoryNameCfg[381].name)

				arg_234_1.leftNameTxt_.text = var_237_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_15 = arg_234_1:GetWordFromCfg(1107506056)
				local var_237_16 = arg_234_1:FormatText(var_237_15.content)

				arg_234_1.text_.text = var_237_16

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_17 = 6
				local var_237_18 = utf8.len(var_237_16)
				local var_237_19 = var_237_17 <= 0 and var_237_13 or var_237_13 * (var_237_18 / var_237_17)

				if var_237_19 > 0 and var_237_13 < var_237_19 then
					arg_234_1.talkMaxDuration = var_237_19

					if var_237_19 + var_237_12 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_19 + var_237_12
					end
				end

				arg_234_1.text_.text = var_237_16
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506056", "story_v_side_new_1107506.awb") ~= 0 then
					local var_237_20 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506056", "story_v_side_new_1107506.awb") / 1000

					if var_237_20 + var_237_12 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_20 + var_237_12
					end

					if var_237_15.prefab_name ~= "" and arg_234_1.actors_[var_237_15.prefab_name] ~= nil then
						local var_237_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_15.prefab_name].transform, "story_v_side_new_1107506", "1107506056", "story_v_side_new_1107506.awb")

						arg_234_1:RecordAudio("1107506056", var_237_21)
						arg_234_1:RecordAudio("1107506056", var_237_21)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506056", "story_v_side_new_1107506.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506056", "story_v_side_new_1107506.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_22 = math.max(var_237_13, arg_234_1.talkMaxDuration)

			if var_237_12 <= arg_234_1.time_ and arg_234_1.time_ < var_237_12 + var_237_22 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_12) / var_237_22

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_12 + var_237_22 and arg_234_1.time_ < var_237_12 + var_237_22 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1107506057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1107506057
		arg_238_1.duration_ = 9

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1107506058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 2

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				local var_241_1 = manager.ui.mainCamera.transform.localPosition
				local var_241_2 = Vector3.New(0, 0, 10) + Vector3.New(var_241_1.x, var_241_1.y, 0)
				local var_241_3 = arg_238_1.bgs_.ST37a

				var_241_3.transform.localPosition = var_241_2
				var_241_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_241_4 = var_241_3:GetComponent("SpriteRenderer")

				if var_241_4 and var_241_4.sprite then
					local var_241_5 = (var_241_3.transform.localPosition - var_241_1).z
					local var_241_6 = manager.ui.mainCameraCom_
					local var_241_7 = 2 * var_241_5 * Mathf.Tan(var_241_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_241_8 = var_241_7 * var_241_6.aspect
					local var_241_9 = var_241_4.sprite.bounds.size.x
					local var_241_10 = var_241_4.sprite.bounds.size.y
					local var_241_11 = var_241_8 / var_241_9
					local var_241_12 = var_241_7 / var_241_10
					local var_241_13 = var_241_12 < var_241_11 and var_241_11 or var_241_12

					var_241_3.transform.localScale = Vector3.New(var_241_13, var_241_13, 0)
				end

				for iter_241_0, iter_241_1 in pairs(arg_238_1.bgs_) do
					if iter_241_0 ~= "ST37a" then
						iter_241_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_241_14 = 3.999999999999

			if var_241_14 < arg_238_1.time_ and arg_238_1.time_ <= var_241_14 + arg_241_0 then
				arg_238_1.allBtn_.enabled = false
			end

			local var_241_15 = 0.3

			if arg_238_1.time_ >= var_241_14 + var_241_15 and arg_238_1.time_ < var_241_14 + var_241_15 + arg_241_0 then
				arg_238_1.allBtn_.enabled = true
			end

			local var_241_16 = 0

			if var_241_16 < arg_238_1.time_ and arg_238_1.time_ <= var_241_16 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_17 = 2

			if var_241_16 <= arg_238_1.time_ and arg_238_1.time_ < var_241_16 + var_241_17 then
				local var_241_18 = (arg_238_1.time_ - var_241_16) / var_241_17
				local var_241_19 = Color.New(0, 0, 0)

				var_241_19.a = Mathf.Lerp(0, 1, var_241_18)
				arg_238_1.mask_.color = var_241_19
			end

			if arg_238_1.time_ >= var_241_16 + var_241_17 and arg_238_1.time_ < var_241_16 + var_241_17 + arg_241_0 then
				local var_241_20 = Color.New(0, 0, 0)

				var_241_20.a = 1
				arg_238_1.mask_.color = var_241_20
			end

			local var_241_21 = 2

			if var_241_21 < arg_238_1.time_ and arg_238_1.time_ <= var_241_21 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_22 = 2

			if var_241_21 <= arg_238_1.time_ and arg_238_1.time_ < var_241_21 + var_241_22 then
				local var_241_23 = (arg_238_1.time_ - var_241_21) / var_241_22
				local var_241_24 = Color.New(0, 0, 0)

				var_241_24.a = Mathf.Lerp(1, 0, var_241_23)
				arg_238_1.mask_.color = var_241_24
			end

			if arg_238_1.time_ >= var_241_21 + var_241_22 and arg_238_1.time_ < var_241_21 + var_241_22 + arg_241_0 then
				local var_241_25 = Color.New(0, 0, 0)
				local var_241_26 = 0

				arg_238_1.mask_.enabled = false
				var_241_25.a = var_241_26
				arg_238_1.mask_.color = var_241_25
			end

			local var_241_27 = arg_238_1.actors_["10044ui_story"].transform
			local var_241_28 = 1.96599999815226

			if var_241_28 < arg_238_1.time_ and arg_238_1.time_ <= var_241_28 + arg_241_0 then
				arg_238_1.var_.moveOldPos10044ui_story = var_241_27.localPosition
			end

			local var_241_29 = 0.001

			if var_241_28 <= arg_238_1.time_ and arg_238_1.time_ < var_241_28 + var_241_29 then
				local var_241_30 = (arg_238_1.time_ - var_241_28) / var_241_29
				local var_241_31 = Vector3.New(0, 100, 0)

				var_241_27.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10044ui_story, var_241_31, var_241_30)

				local var_241_32 = manager.ui.mainCamera.transform.position - var_241_27.position

				var_241_27.forward = Vector3.New(var_241_32.x, var_241_32.y, var_241_32.z)

				local var_241_33 = var_241_27.localEulerAngles

				var_241_33.z = 0
				var_241_33.x = 0
				var_241_27.localEulerAngles = var_241_33
			end

			if arg_238_1.time_ >= var_241_28 + var_241_29 and arg_238_1.time_ < var_241_28 + var_241_29 + arg_241_0 then
				var_241_27.localPosition = Vector3.New(0, 100, 0)

				local var_241_34 = manager.ui.mainCamera.transform.position - var_241_27.position

				var_241_27.forward = Vector3.New(var_241_34.x, var_241_34.y, var_241_34.z)

				local var_241_35 = var_241_27.localEulerAngles

				var_241_35.z = 0
				var_241_35.x = 0
				var_241_27.localEulerAngles = var_241_35
			end

			local var_241_36 = arg_238_1.actors_["1075ui_actor"].transform
			local var_241_37 = 1.96599999815226

			if var_241_37 < arg_238_1.time_ and arg_238_1.time_ <= var_241_37 + arg_241_0 then
				arg_238_1.var_.moveOldPos1075ui_actor = var_241_36.localPosition

				local var_241_38 = GameObjectTools.GetOrAddComponent(var_241_36.gameObject, typeof(DynamicBoneHelper))

				if var_241_38 then
					var_241_38:EnableDynamicBone(false)
				end
			end

			local var_241_39 = 0.001

			if var_241_37 <= arg_238_1.time_ and arg_238_1.time_ < var_241_37 + var_241_39 then
				local var_241_40 = (arg_238_1.time_ - var_241_37) / var_241_39
				local var_241_41 = Vector3.New(0, 100, 0)

				var_241_36.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1075ui_actor, var_241_41, var_241_40)

				local var_241_42 = manager.ui.mainCamera.transform.position - var_241_36.position

				var_241_36.forward = Vector3.New(var_241_42.x, var_241_42.y, var_241_42.z)

				local var_241_43 = var_241_36.localEulerAngles

				var_241_43.z = 0
				var_241_43.x = 0
				var_241_36.localEulerAngles = var_241_43
			end

			if arg_238_1.time_ >= var_241_37 + var_241_39 and arg_238_1.time_ < var_241_37 + var_241_39 + arg_241_0 then
				var_241_36.localPosition = Vector3.New(0, 100, 0)

				local var_241_44 = manager.ui.mainCamera.transform.position - var_241_36.position

				var_241_36.forward = Vector3.New(var_241_44.x, var_241_44.y, var_241_44.z)

				local var_241_45 = var_241_36.localEulerAngles

				var_241_45.z = 0
				var_241_45.x = 0
				var_241_36.localEulerAngles = var_241_45

				local var_241_46 = GameObjectTools.GetOrAddComponent(var_241_36.gameObject, typeof(DynamicBoneHelper))

				if var_241_46 then
					var_241_46:EnableDynamicBone(true)
				end
			end

			local var_241_47 = arg_238_1.actors_["1075ui_actor"]
			local var_241_48 = 1.96599999815226

			if var_241_48 < arg_238_1.time_ and arg_238_1.time_ <= var_241_48 + arg_241_0 and not isNil(var_241_47) and arg_238_1.var_.characterEffect1075ui_actor == nil then
				arg_238_1.var_.characterEffect1075ui_actor = var_241_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_49 = 0.034000001847744

			if var_241_48 <= arg_238_1.time_ and arg_238_1.time_ < var_241_48 + var_241_49 and not isNil(var_241_47) then
				local var_241_50 = (arg_238_1.time_ - var_241_48) / var_241_49

				if arg_238_1.var_.characterEffect1075ui_actor and not isNil(var_241_47) then
					local var_241_51 = Mathf.Lerp(0, 0.5, var_241_50)

					arg_238_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_238_1.var_.characterEffect1075ui_actor.fillRatio = var_241_51
				end
			end

			if arg_238_1.time_ >= var_241_48 + var_241_49 and arg_238_1.time_ < var_241_48 + var_241_49 + arg_241_0 and not isNil(var_241_47) and arg_238_1.var_.characterEffect1075ui_actor then
				local var_241_52 = 0.5

				arg_238_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_238_1.var_.characterEffect1075ui_actor.fillRatio = var_241_52
			end

			local var_241_53 = 1.96666666666667

			arg_238_1.isInRecall_ = false

			if var_241_53 < arg_238_1.time_ and arg_238_1.time_ <= var_241_53 + arg_241_0 then
				arg_238_1.screenFilterGo_:SetActive(false)

				for iter_241_2, iter_241_3 in pairs(arg_238_1.actors_) do
					local var_241_54 = iter_241_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_241_4, iter_241_5 in ipairs(var_241_54) do
						if iter_241_5.color.r > 0.51 then
							iter_241_5.color = Color.New(1, 1, 1)
						else
							iter_241_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_241_55 = 0.0333333333333332

			if var_241_53 <= arg_238_1.time_ and arg_238_1.time_ < var_241_53 + var_241_55 then
				local var_241_56 = (arg_238_1.time_ - var_241_53) / var_241_55

				arg_238_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_241_56)
			end

			if arg_238_1.time_ >= var_241_53 + var_241_55 and arg_238_1.time_ < var_241_53 + var_241_55 + arg_241_0 then
				arg_238_1.screenFilterEffect_.weight = 0
			end

			local var_241_57 = 0
			local var_241_58 = 0.616666666666667

			if var_241_57 < arg_238_1.time_ and arg_238_1.time_ <= var_241_57 + arg_241_0 then
				local var_241_59 = "play"
				local var_241_60 = "music"

				arg_238_1:AudioAction(var_241_59, var_241_60, "ui_battle", "ui_battle_stopbgm", "")

				local var_241_61 = ""
				local var_241_62 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_241_62 ~= "" then
					if arg_238_1.bgmTxt_.text ~= var_241_62 and arg_238_1.bgmTxt_.text ~= "" then
						if arg_238_1.bgmTxt2_.text ~= "" then
							arg_238_1.bgmTxt_.text = arg_238_1.bgmTxt2_.text
						end

						arg_238_1.bgmTxt2_.text = var_241_62

						arg_238_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_238_1.bgmTxt_.text = var_241_62
						arg_238_1.bgmTxt2_.text = var_241_62
					end

					if arg_238_1.bgmTimer then
						arg_238_1.bgmTimer:Stop()

						arg_238_1.bgmTimer = nil
					end

					if arg_238_1.settingData.show_music_name == 1 then
						arg_238_1.musicController:SetSelectedState("show")
						arg_238_1.musicAnimator_:Play("open", 0, 0)

						if arg_238_1.settingData.music_time ~= 0 then
							arg_238_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_238_1.settingData.music_time), function()
								if arg_238_1 == nil or isNil(arg_238_1.bgmTxt_) then
									return
								end

								arg_238_1.musicController:SetSelectedState("hide")
								arg_238_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_241_63 = 1.66666666666667
			local var_241_64 = 1

			if var_241_63 < arg_238_1.time_ and arg_238_1.time_ <= var_241_63 + arg_241_0 then
				local var_241_65 = "play"
				local var_241_66 = "music"

				arg_238_1:AudioAction(var_241_65, var_241_66, "bgm_side_daily07", "bgm_side_daily07", "bgm_side_daily07.awb")

				local var_241_67 = ""
				local var_241_68 = manager.audio:GetAudioName("bgm_side_daily07", "bgm_side_daily07")

				if var_241_68 ~= "" then
					if arg_238_1.bgmTxt_.text ~= var_241_68 and arg_238_1.bgmTxt_.text ~= "" then
						if arg_238_1.bgmTxt2_.text ~= "" then
							arg_238_1.bgmTxt_.text = arg_238_1.bgmTxt2_.text
						end

						arg_238_1.bgmTxt2_.text = var_241_68

						arg_238_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_238_1.bgmTxt_.text = var_241_68
						arg_238_1.bgmTxt2_.text = var_241_68
					end

					if arg_238_1.bgmTimer then
						arg_238_1.bgmTimer:Stop()

						arg_238_1.bgmTimer = nil
					end

					if arg_238_1.settingData.show_music_name == 1 then
						arg_238_1.musicController:SetSelectedState("show")
						arg_238_1.musicAnimator_:Play("open", 0, 0)

						if arg_238_1.settingData.music_time ~= 0 then
							arg_238_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_238_1.settingData.music_time), function()
								if arg_238_1 == nil or isNil(arg_238_1.bgmTxt_) then
									return
								end

								arg_238_1.musicController:SetSelectedState("hide")
								arg_238_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_241_69 = 1.76666666666667
			local var_241_70 = 1

			if var_241_69 < arg_238_1.time_ and arg_238_1.time_ <= var_241_69 + arg_241_0 then
				local var_241_71 = "play"
				local var_241_72 = "effect"

				arg_238_1:AudioAction(var_241_71, var_241_72, "se_story_side_1075", "se_story_side_1075_rain_inside01", "")
			end

			if arg_238_1.frameCnt_ <= 1 then
				arg_238_1.dialog_:SetActive(false)
			end

			local var_241_73 = 4
			local var_241_74 = 0.575

			if var_241_73 < arg_238_1.time_ and arg_238_1.time_ <= var_241_73 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_75 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_75:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_238_1.dialogCg_.alpha = arg_244_0
				end))
				var_241_75:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_75:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_76 = arg_238_1:GetWordFromCfg(1107506057)
				local var_241_77 = arg_238_1:FormatText(var_241_76.content)

				arg_238_1.text_.text = var_241_77

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_78 = 23
				local var_241_79 = utf8.len(var_241_77)
				local var_241_80 = var_241_78 <= 0 and var_241_74 or var_241_74 * (var_241_79 / var_241_78)

				if var_241_80 > 0 and var_241_74 < var_241_80 then
					arg_238_1.talkMaxDuration = var_241_80
					var_241_73 = var_241_73 + 0.3

					if var_241_80 + var_241_73 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_80 + var_241_73
					end
				end

				arg_238_1.text_.text = var_241_77
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_81 = var_241_73 + 0.3
			local var_241_82 = math.max(var_241_74, arg_238_1.talkMaxDuration)

			if var_241_81 <= arg_238_1.time_ and arg_238_1.time_ < var_241_81 + var_241_82 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_81) / var_241_82

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_81 + var_241_82 and arg_238_1.time_ < var_241_81 + var_241_82 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play1107506058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1107506058
		arg_246_1.duration_ = 5.8

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1107506059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1075ui_actor"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos1075ui_actor = var_249_0.localPosition

				local var_249_2 = GameObjectTools.GetOrAddComponent(var_249_0.gameObject, typeof(DynamicBoneHelper))

				if var_249_2 then
					var_249_2:EnableDynamicBone(false)
				end
			end

			local var_249_3 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_3 then
				local var_249_4 = (arg_246_1.time_ - var_249_1) / var_249_3
				local var_249_5 = Vector3.New(0, -1.055, -6.16)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1075ui_actor, var_249_5, var_249_4)

				local var_249_6 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_6.x, var_249_6.y, var_249_6.z)

				local var_249_7 = var_249_0.localEulerAngles

				var_249_7.z = 0
				var_249_7.x = 0
				var_249_0.localEulerAngles = var_249_7
			end

			if arg_246_1.time_ >= var_249_1 + var_249_3 and arg_246_1.time_ < var_249_1 + var_249_3 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_249_8 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_8.x, var_249_8.y, var_249_8.z)

				local var_249_9 = var_249_0.localEulerAngles

				var_249_9.z = 0
				var_249_9.x = 0
				var_249_0.localEulerAngles = var_249_9

				local var_249_10 = GameObjectTools.GetOrAddComponent(var_249_0.gameObject, typeof(DynamicBoneHelper))

				if var_249_10 then
					var_249_10:EnableDynamicBone(true)
				end
			end

			local var_249_11 = arg_246_1.actors_["1075ui_actor"]
			local var_249_12 = 0

			if var_249_12 < arg_246_1.time_ and arg_246_1.time_ <= var_249_12 + arg_249_0 and not isNil(var_249_11) and arg_246_1.var_.characterEffect1075ui_actor == nil then
				arg_246_1.var_.characterEffect1075ui_actor = var_249_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_13 = 0.200000002980232

			if var_249_12 <= arg_246_1.time_ and arg_246_1.time_ < var_249_12 + var_249_13 and not isNil(var_249_11) then
				local var_249_14 = (arg_246_1.time_ - var_249_12) / var_249_13

				if arg_246_1.var_.characterEffect1075ui_actor and not isNil(var_249_11) then
					arg_246_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_12 + var_249_13 and arg_246_1.time_ < var_249_12 + var_249_13 + arg_249_0 and not isNil(var_249_11) and arg_246_1.var_.characterEffect1075ui_actor then
				arg_246_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_249_15 = 0

			if var_249_15 < arg_246_1.time_ and arg_246_1.time_ <= var_249_15 + arg_249_0 then
				arg_246_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_249_16 = 0

			if var_249_16 < arg_246_1.time_ and arg_246_1.time_ <= var_249_16 + arg_249_0 then
				arg_246_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_249_17 = 0
			local var_249_18 = 0.55

			if var_249_17 < arg_246_1.time_ and arg_246_1.time_ <= var_249_17 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_19 = arg_246_1:FormatText(StoryNameCfg[381].name)

				arg_246_1.leftNameTxt_.text = var_249_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_20 = arg_246_1:GetWordFromCfg(1107506058)
				local var_249_21 = arg_246_1:FormatText(var_249_20.content)

				arg_246_1.text_.text = var_249_21

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_22 = 22
				local var_249_23 = utf8.len(var_249_21)
				local var_249_24 = var_249_22 <= 0 and var_249_18 or var_249_18 * (var_249_23 / var_249_22)

				if var_249_24 > 0 and var_249_18 < var_249_24 then
					arg_246_1.talkMaxDuration = var_249_24

					if var_249_24 + var_249_17 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_24 + var_249_17
					end
				end

				arg_246_1.text_.text = var_249_21
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506058", "story_v_side_new_1107506.awb") ~= 0 then
					local var_249_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506058", "story_v_side_new_1107506.awb") / 1000

					if var_249_25 + var_249_17 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_25 + var_249_17
					end

					if var_249_20.prefab_name ~= "" and arg_246_1.actors_[var_249_20.prefab_name] ~= nil then
						local var_249_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_20.prefab_name].transform, "story_v_side_new_1107506", "1107506058", "story_v_side_new_1107506.awb")

						arg_246_1:RecordAudio("1107506058", var_249_26)
						arg_246_1:RecordAudio("1107506058", var_249_26)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506058", "story_v_side_new_1107506.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506058", "story_v_side_new_1107506.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_27 = math.max(var_249_18, arg_246_1.talkMaxDuration)

			if var_249_17 <= arg_246_1.time_ and arg_246_1.time_ < var_249_17 + var_249_27 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_17) / var_249_27

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_17 + var_249_27 and arg_246_1.time_ < var_249_17 + var_249_27 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play1107506059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1107506059
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1107506060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1075ui_actor"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1075ui_actor == nil then
				arg_250_1.var_.characterEffect1075ui_actor = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect1075ui_actor and not isNil(var_253_0) then
					local var_253_4 = Mathf.Lerp(0, 0.5, var_253_3)

					arg_250_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_250_1.var_.characterEffect1075ui_actor.fillRatio = var_253_4
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1075ui_actor then
				local var_253_5 = 0.5

				arg_250_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_250_1.var_.characterEffect1075ui_actor.fillRatio = var_253_5
			end

			local var_253_6 = 0
			local var_253_7 = 0.425

			if var_253_6 < arg_250_1.time_ and arg_250_1.time_ <= var_253_6 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_8 = arg_250_1:FormatText(StoryNameCfg[7].name)

				arg_250_1.leftNameTxt_.text = var_253_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_9 = arg_250_1:GetWordFromCfg(1107506059)
				local var_253_10 = arg_250_1:FormatText(var_253_9.content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 17
				local var_253_12 = utf8.len(var_253_10)
				local var_253_13 = var_253_11 <= 0 and var_253_7 or var_253_7 * (var_253_12 / var_253_11)

				if var_253_13 > 0 and var_253_7 < var_253_13 then
					arg_250_1.talkMaxDuration = var_253_13

					if var_253_13 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_6
					end
				end

				arg_250_1.text_.text = var_253_10
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_14 = math.max(var_253_7, arg_250_1.talkMaxDuration)

			if var_253_6 <= arg_250_1.time_ and arg_250_1.time_ < var_253_6 + var_253_14 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_6) / var_253_14

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_6 + var_253_14 and arg_250_1.time_ < var_253_6 + var_253_14 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1107506060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1107506060
		arg_254_1.duration_ = 2.67

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1107506061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1075ui_actor"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1075ui_actor == nil then
				arg_254_1.var_.characterEffect1075ui_actor = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1075ui_actor and not isNil(var_257_0) then
					arg_254_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1075ui_actor then
				arg_254_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_257_4 = 0

			if var_257_4 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			local var_257_5 = 0

			if var_257_5 < arg_254_1.time_ and arg_254_1.time_ <= var_257_5 + arg_257_0 then
				arg_254_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_257_6 = 0
			local var_257_7 = 0.25

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_8 = arg_254_1:FormatText(StoryNameCfg[381].name)

				arg_254_1.leftNameTxt_.text = var_257_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_9 = arg_254_1:GetWordFromCfg(1107506060)
				local var_257_10 = arg_254_1:FormatText(var_257_9.content)

				arg_254_1.text_.text = var_257_10

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 10
				local var_257_12 = utf8.len(var_257_10)
				local var_257_13 = var_257_11 <= 0 and var_257_7 or var_257_7 * (var_257_12 / var_257_11)

				if var_257_13 > 0 and var_257_7 < var_257_13 then
					arg_254_1.talkMaxDuration = var_257_13

					if var_257_13 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_13 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_10
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506060", "story_v_side_new_1107506.awb") ~= 0 then
					local var_257_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506060", "story_v_side_new_1107506.awb") / 1000

					if var_257_14 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_14 + var_257_6
					end

					if var_257_9.prefab_name ~= "" and arg_254_1.actors_[var_257_9.prefab_name] ~= nil then
						local var_257_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_9.prefab_name].transform, "story_v_side_new_1107506", "1107506060", "story_v_side_new_1107506.awb")

						arg_254_1:RecordAudio("1107506060", var_257_15)
						arg_254_1:RecordAudio("1107506060", var_257_15)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506060", "story_v_side_new_1107506.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506060", "story_v_side_new_1107506.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_16 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_16 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_16

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_16 and arg_254_1.time_ < var_257_6 + var_257_16 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1107506061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1107506061
		arg_258_1.duration_ = 7.53

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1107506062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.775

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[381].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_3 = arg_258_1:GetWordFromCfg(1107506061)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 31
				local var_261_6 = utf8.len(var_261_4)
				local var_261_7 = var_261_5 <= 0 and var_261_1 or var_261_1 * (var_261_6 / var_261_5)

				if var_261_7 > 0 and var_261_1 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506061", "story_v_side_new_1107506.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506061", "story_v_side_new_1107506.awb") / 1000

					if var_261_8 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_0
					end

					if var_261_3.prefab_name ~= "" and arg_258_1.actors_[var_261_3.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_3.prefab_name].transform, "story_v_side_new_1107506", "1107506061", "story_v_side_new_1107506.awb")

						arg_258_1:RecordAudio("1107506061", var_261_9)
						arg_258_1:RecordAudio("1107506061", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506061", "story_v_side_new_1107506.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506061", "story_v_side_new_1107506.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_10 and arg_258_1.time_ < var_261_0 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play1107506062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1107506062
		arg_262_1.duration_ = 5.47

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1107506063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 0.625

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[381].name)

				arg_262_1.leftNameTxt_.text = var_265_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_3 = arg_262_1:GetWordFromCfg(1107506062)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 25
				local var_265_6 = utf8.len(var_265_4)
				local var_265_7 = var_265_5 <= 0 and var_265_1 or var_265_1 * (var_265_6 / var_265_5)

				if var_265_7 > 0 and var_265_1 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_4
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506062", "story_v_side_new_1107506.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506062", "story_v_side_new_1107506.awb") / 1000

					if var_265_8 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_0
					end

					if var_265_3.prefab_name ~= "" and arg_262_1.actors_[var_265_3.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_3.prefab_name].transform, "story_v_side_new_1107506", "1107506062", "story_v_side_new_1107506.awb")

						arg_262_1:RecordAudio("1107506062", var_265_9)
						arg_262_1:RecordAudio("1107506062", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506062", "story_v_side_new_1107506.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506062", "story_v_side_new_1107506.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_10 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_10 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_10

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_10 and arg_262_1.time_ < var_265_0 + var_265_10 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1107506063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1107506063
		arg_266_1.duration_ = 6.23

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1107506064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action434")
			end

			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_269_2 = 0
			local var_269_3 = 0.575

			if var_269_2 < arg_266_1.time_ and arg_266_1.time_ <= var_269_2 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_4 = arg_266_1:FormatText(StoryNameCfg[381].name)

				arg_266_1.leftNameTxt_.text = var_269_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_5 = arg_266_1:GetWordFromCfg(1107506063)
				local var_269_6 = arg_266_1:FormatText(var_269_5.content)

				arg_266_1.text_.text = var_269_6

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_7 = 23
				local var_269_8 = utf8.len(var_269_6)
				local var_269_9 = var_269_7 <= 0 and var_269_3 or var_269_3 * (var_269_8 / var_269_7)

				if var_269_9 > 0 and var_269_3 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_2
					end
				end

				arg_266_1.text_.text = var_269_6
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506063", "story_v_side_new_1107506.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506063", "story_v_side_new_1107506.awb") / 1000

					if var_269_10 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_2
					end

					if var_269_5.prefab_name ~= "" and arg_266_1.actors_[var_269_5.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_5.prefab_name].transform, "story_v_side_new_1107506", "1107506063", "story_v_side_new_1107506.awb")

						arg_266_1:RecordAudio("1107506063", var_269_11)
						arg_266_1:RecordAudio("1107506063", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506063", "story_v_side_new_1107506.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506063", "story_v_side_new_1107506.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_3, arg_266_1.talkMaxDuration)

			if var_269_2 <= arg_266_1.time_ and arg_266_1.time_ < var_269_2 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_2) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_2 + var_269_12 and arg_266_1.time_ < var_269_2 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1107506064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1107506064
		arg_270_1.duration_ = 1

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"

			SetActive(arg_270_1.choicesGo_, true)

			for iter_271_0, iter_271_1 in ipairs(arg_270_1.choices_) do
				local var_271_0 = iter_271_0 <= 2

				SetActive(iter_271_1.go, var_271_0)
			end

			arg_270_1.choices_[1].txt.text = arg_270_1:FormatText(StoryChoiceCfg[1167].name)
			arg_270_1.choices_[2].txt.text = arg_270_1:FormatText(StoryChoiceCfg[1168].name)
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1107506065(arg_270_1)
			end

			if arg_272_0 == 2 then
				arg_270_0:Play1107506065(arg_270_1)
			end

			arg_270_1:RecordChoiceLog(1107506064, 1167, 1168)
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1075ui_actor"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1075ui_actor == nil then
				arg_270_1.var_.characterEffect1075ui_actor = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect1075ui_actor and not isNil(var_273_0) then
					local var_273_4 = Mathf.Lerp(0, 0.5, var_273_3)

					arg_270_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_270_1.var_.characterEffect1075ui_actor.fillRatio = var_273_4
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1075ui_actor then
				local var_273_5 = 0.5

				arg_270_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_270_1.var_.characterEffect1075ui_actor.fillRatio = var_273_5
			end

			local var_273_6 = 0

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.allBtn_.enabled = false
			end

			local var_273_7 = 0.6

			if arg_270_1.time_ >= var_273_6 + var_273_7 and arg_270_1.time_ < var_273_6 + var_273_7 + arg_273_0 then
				arg_270_1.allBtn_.enabled = true
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1107506065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1107506065
		arg_274_1.duration_ = 7.73

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1107506066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1075ui_actor"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1075ui_actor == nil then
				arg_274_1.var_.characterEffect1075ui_actor = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.200000002980232

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect1075ui_actor and not isNil(var_277_0) then
					arg_274_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect1075ui_actor then
				arg_274_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_277_4 = "1075ui_actor"

			if arg_274_1.actors_[var_277_4] == nil then
				local var_277_5 = Asset.Load("Char/" .. "1075ui_actor")

				if not isNil(var_277_5) then
					local var_277_6 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_274_1.stage_.transform)

					var_277_6.name = var_277_4
					var_277_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_274_1.actors_[var_277_4] = var_277_6

					local var_277_7 = var_277_6:GetComponentInChildren(typeof(CharacterEffect))

					var_277_7.enabled = true

					local var_277_8 = GameObjectTools.GetOrAddComponent(var_277_6, typeof(DynamicBoneHelper))

					if var_277_8 then
						var_277_8:EnableDynamicBone(false)
					end

					arg_274_1:ShowWeapon(var_277_7.transform, false)

					arg_274_1.var_[var_277_4 .. "Animator"] = var_277_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_274_1.var_[var_277_4 .. "Animator"].applyRootMotion = true
					arg_274_1.var_[var_277_4 .. "LipSync"] = var_277_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_277_9 = 0

			if var_277_9 < arg_274_1.time_ and arg_274_1.time_ <= var_277_9 + arg_277_0 then
				arg_274_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_277_10 = "1075ui_actor"

			if arg_274_1.actors_[var_277_10] == nil then
				local var_277_11 = Asset.Load("Char/" .. "1075ui_actor")

				if not isNil(var_277_11) then
					local var_277_12 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_274_1.stage_.transform)

					var_277_12.name = var_277_10
					var_277_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_274_1.actors_[var_277_10] = var_277_12

					local var_277_13 = var_277_12:GetComponentInChildren(typeof(CharacterEffect))

					var_277_13.enabled = true

					local var_277_14 = GameObjectTools.GetOrAddComponent(var_277_12, typeof(DynamicBoneHelper))

					if var_277_14 then
						var_277_14:EnableDynamicBone(false)
					end

					arg_274_1:ShowWeapon(var_277_13.transform, false)

					arg_274_1.var_[var_277_10 .. "Animator"] = var_277_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_274_1.var_[var_277_10 .. "Animator"].applyRootMotion = true
					arg_274_1.var_[var_277_10 .. "LipSync"] = var_277_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_277_15 = 0

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				arg_274_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_277_16 = 0
			local var_277_17 = 0.675

			if var_277_16 < arg_274_1.time_ and arg_274_1.time_ <= var_277_16 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_18 = arg_274_1:FormatText(StoryNameCfg[381].name)

				arg_274_1.leftNameTxt_.text = var_277_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_19 = arg_274_1:GetWordFromCfg(1107506065)
				local var_277_20 = arg_274_1:FormatText(var_277_19.content)

				arg_274_1.text_.text = var_277_20

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_21 = 27
				local var_277_22 = utf8.len(var_277_20)
				local var_277_23 = var_277_21 <= 0 and var_277_17 or var_277_17 * (var_277_22 / var_277_21)

				if var_277_23 > 0 and var_277_17 < var_277_23 then
					arg_274_1.talkMaxDuration = var_277_23

					if var_277_23 + var_277_16 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_23 + var_277_16
					end
				end

				arg_274_1.text_.text = var_277_20
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506065", "story_v_side_new_1107506.awb") ~= 0 then
					local var_277_24 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506065", "story_v_side_new_1107506.awb") / 1000

					if var_277_24 + var_277_16 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_24 + var_277_16
					end

					if var_277_19.prefab_name ~= "" and arg_274_1.actors_[var_277_19.prefab_name] ~= nil then
						local var_277_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_19.prefab_name].transform, "story_v_side_new_1107506", "1107506065", "story_v_side_new_1107506.awb")

						arg_274_1:RecordAudio("1107506065", var_277_25)
						arg_274_1:RecordAudio("1107506065", var_277_25)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506065", "story_v_side_new_1107506.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506065", "story_v_side_new_1107506.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_26 = math.max(var_277_17, arg_274_1.talkMaxDuration)

			if var_277_16 <= arg_274_1.time_ and arg_274_1.time_ < var_277_16 + var_277_26 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_16) / var_277_26

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_16 + var_277_26 and arg_274_1.time_ < var_277_16 + var_277_26 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play1107506066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1107506066
		arg_278_1.duration_ = 6.37

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1107506067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.65

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[381].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_3 = arg_278_1:GetWordFromCfg(1107506066)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 26
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506066", "story_v_side_new_1107506.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506066", "story_v_side_new_1107506.awb") / 1000

					if var_281_8 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_0
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_side_new_1107506", "1107506066", "story_v_side_new_1107506.awb")

						arg_278_1:RecordAudio("1107506066", var_281_9)
						arg_278_1:RecordAudio("1107506066", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506066", "story_v_side_new_1107506.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506066", "story_v_side_new_1107506.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_10 and arg_278_1.time_ < var_281_0 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play1107506067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1107506067
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1107506068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = arg_282_1.actors_["1075ui_actor"]
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1075ui_actor == nil then
				arg_282_1.var_.characterEffect1075ui_actor = var_285_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_2 and not isNil(var_285_0) then
				local var_285_3 = (arg_282_1.time_ - var_285_1) / var_285_2

				if arg_282_1.var_.characterEffect1075ui_actor and not isNil(var_285_0) then
					local var_285_4 = Mathf.Lerp(0, 0.5, var_285_3)

					arg_282_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_282_1.var_.characterEffect1075ui_actor.fillRatio = var_285_4
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_2 and arg_282_1.time_ < var_285_1 + var_285_2 + arg_285_0 and not isNil(var_285_0) and arg_282_1.var_.characterEffect1075ui_actor then
				local var_285_5 = 0.5

				arg_282_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_282_1.var_.characterEffect1075ui_actor.fillRatio = var_285_5
			end

			local var_285_6 = 0
			local var_285_7 = 0.825

			if var_285_6 < arg_282_1.time_ and arg_282_1.time_ <= var_285_6 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_8 = arg_282_1:GetWordFromCfg(1107506067)
				local var_285_9 = arg_282_1:FormatText(var_285_8.content)

				arg_282_1.text_.text = var_285_9

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_10 = 33
				local var_285_11 = utf8.len(var_285_9)
				local var_285_12 = var_285_10 <= 0 and var_285_7 or var_285_7 * (var_285_11 / var_285_10)

				if var_285_12 > 0 and var_285_7 < var_285_12 then
					arg_282_1.talkMaxDuration = var_285_12

					if var_285_12 + var_285_6 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_12 + var_285_6
					end
				end

				arg_282_1.text_.text = var_285_9
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_13 = math.max(var_285_7, arg_282_1.talkMaxDuration)

			if var_285_6 <= arg_282_1.time_ and arg_282_1.time_ < var_285_6 + var_285_13 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_6) / var_285_13

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_6 + var_285_13 and arg_282_1.time_ < var_285_6 + var_285_13 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play1107506068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1107506068
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1107506069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.65

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[7].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:GetWordFromCfg(1107506068)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 26
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_8 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_8 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_8

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_8 and arg_286_1.time_ < var_289_0 + var_289_8 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play1107506069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1107506069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1107506070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.875

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[7].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:GetWordFromCfg(1107506069)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 35
				local var_293_6 = utf8.len(var_293_4)
				local var_293_7 = var_293_5 <= 0 and var_293_1 or var_293_1 * (var_293_6 / var_293_5)

				if var_293_7 > 0 and var_293_1 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_8 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_8 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_8

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_8 and arg_290_1.time_ < var_293_0 + var_293_8 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1107506070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1107506070
		arg_294_1.duration_ = 2.37

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1107506071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1075ui_actor"]
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1075ui_actor == nil then
				arg_294_1.var_.characterEffect1075ui_actor = var_297_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 and not isNil(var_297_0) then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2

				if arg_294_1.var_.characterEffect1075ui_actor and not isNil(var_297_0) then
					arg_294_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 and not isNil(var_297_0) and arg_294_1.var_.characterEffect1075ui_actor then
				arg_294_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_297_4 = 0

			if var_297_4 < arg_294_1.time_ and arg_294_1.time_ <= var_297_4 + arg_297_0 then
				arg_294_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_297_5 = 0

			if var_297_5 < arg_294_1.time_ and arg_294_1.time_ <= var_297_5 + arg_297_0 then
				arg_294_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_297_6 = 0
			local var_297_7 = 0.275

			if var_297_6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_8 = arg_294_1:FormatText(StoryNameCfg[381].name)

				arg_294_1.leftNameTxt_.text = var_297_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_9 = arg_294_1:GetWordFromCfg(1107506070)
				local var_297_10 = arg_294_1:FormatText(var_297_9.content)

				arg_294_1.text_.text = var_297_10

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_11 = 11
				local var_297_12 = utf8.len(var_297_10)
				local var_297_13 = var_297_11 <= 0 and var_297_7 or var_297_7 * (var_297_12 / var_297_11)

				if var_297_13 > 0 and var_297_7 < var_297_13 then
					arg_294_1.talkMaxDuration = var_297_13

					if var_297_13 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_13 + var_297_6
					end
				end

				arg_294_1.text_.text = var_297_10
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506070", "story_v_side_new_1107506.awb") ~= 0 then
					local var_297_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506070", "story_v_side_new_1107506.awb") / 1000

					if var_297_14 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_14 + var_297_6
					end

					if var_297_9.prefab_name ~= "" and arg_294_1.actors_[var_297_9.prefab_name] ~= nil then
						local var_297_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_9.prefab_name].transform, "story_v_side_new_1107506", "1107506070", "story_v_side_new_1107506.awb")

						arg_294_1:RecordAudio("1107506070", var_297_15)
						arg_294_1:RecordAudio("1107506070", var_297_15)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506070", "story_v_side_new_1107506.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506070", "story_v_side_new_1107506.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_16 = math.max(var_297_7, arg_294_1.talkMaxDuration)

			if var_297_6 <= arg_294_1.time_ and arg_294_1.time_ < var_297_6 + var_297_16 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_6) / var_297_16

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_6 + var_297_16 and arg_294_1.time_ < var_297_6 + var_297_16 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1107506071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 1107506071
		arg_298_1.duration_ = 7.77

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play1107506072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0
			local var_301_1 = 0.85

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_2 = arg_298_1:FormatText(StoryNameCfg[381].name)

				arg_298_1.leftNameTxt_.text = var_301_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_3 = arg_298_1:GetWordFromCfg(1107506071)
				local var_301_4 = arg_298_1:FormatText(var_301_3.content)

				arg_298_1.text_.text = var_301_4

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_5 = 34
				local var_301_6 = utf8.len(var_301_4)
				local var_301_7 = var_301_5 <= 0 and var_301_1 or var_301_1 * (var_301_6 / var_301_5)

				if var_301_7 > 0 and var_301_1 < var_301_7 then
					arg_298_1.talkMaxDuration = var_301_7

					if var_301_7 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_7 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_4
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506071", "story_v_side_new_1107506.awb") ~= 0 then
					local var_301_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506071", "story_v_side_new_1107506.awb") / 1000

					if var_301_8 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_8 + var_301_0
					end

					if var_301_3.prefab_name ~= "" and arg_298_1.actors_[var_301_3.prefab_name] ~= nil then
						local var_301_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_3.prefab_name].transform, "story_v_side_new_1107506", "1107506071", "story_v_side_new_1107506.awb")

						arg_298_1:RecordAudio("1107506071", var_301_9)
						arg_298_1:RecordAudio("1107506071", var_301_9)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506071", "story_v_side_new_1107506.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506071", "story_v_side_new_1107506.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_10 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_10 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_10

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_10 and arg_298_1.time_ < var_301_0 + var_301_10 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play1107506072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 1107506072
		arg_302_1.duration_ = 9.53

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play1107506073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				arg_302_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				arg_302_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_305_2 = 0
			local var_305_3 = 0.8

			if var_305_2 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_4 = arg_302_1:FormatText(StoryNameCfg[381].name)

				arg_302_1.leftNameTxt_.text = var_305_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_5 = arg_302_1:GetWordFromCfg(1107506072)
				local var_305_6 = arg_302_1:FormatText(var_305_5.content)

				arg_302_1.text_.text = var_305_6

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_7 = 32
				local var_305_8 = utf8.len(var_305_6)
				local var_305_9 = var_305_7 <= 0 and var_305_3 or var_305_3 * (var_305_8 / var_305_7)

				if var_305_9 > 0 and var_305_3 < var_305_9 then
					arg_302_1.talkMaxDuration = var_305_9

					if var_305_9 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_9 + var_305_2
					end
				end

				arg_302_1.text_.text = var_305_6
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506072", "story_v_side_new_1107506.awb") ~= 0 then
					local var_305_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506072", "story_v_side_new_1107506.awb") / 1000

					if var_305_10 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_2
					end

					if var_305_5.prefab_name ~= "" and arg_302_1.actors_[var_305_5.prefab_name] ~= nil then
						local var_305_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_5.prefab_name].transform, "story_v_side_new_1107506", "1107506072", "story_v_side_new_1107506.awb")

						arg_302_1:RecordAudio("1107506072", var_305_11)
						arg_302_1:RecordAudio("1107506072", var_305_11)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506072", "story_v_side_new_1107506.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506072", "story_v_side_new_1107506.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_12 = math.max(var_305_3, arg_302_1.talkMaxDuration)

			if var_305_2 <= arg_302_1.time_ and arg_302_1.time_ < var_305_2 + var_305_12 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_2) / var_305_12

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_2 + var_305_12 and arg_302_1.time_ < var_305_2 + var_305_12 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play1107506073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 1107506073
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play1107506074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["1075ui_actor"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1075ui_actor == nil then
				arg_306_1.var_.characterEffect1075ui_actor = var_309_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.200000002980232

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.characterEffect1075ui_actor and not isNil(var_309_0) then
					local var_309_4 = Mathf.Lerp(0, 0.5, var_309_3)

					arg_306_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_306_1.var_.characterEffect1075ui_actor.fillRatio = var_309_4
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1075ui_actor then
				local var_309_5 = 0.5

				arg_306_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_306_1.var_.characterEffect1075ui_actor.fillRatio = var_309_5
			end

			local var_309_6 = 0
			local var_309_7 = 0.8

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_8 = arg_306_1:FormatText(StoryNameCfg[7].name)

				arg_306_1.leftNameTxt_.text = var_309_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_9 = arg_306_1:GetWordFromCfg(1107506073)
				local var_309_10 = arg_306_1:FormatText(var_309_9.content)

				arg_306_1.text_.text = var_309_10

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_11 = 32
				local var_309_12 = utf8.len(var_309_10)
				local var_309_13 = var_309_11 <= 0 and var_309_7 or var_309_7 * (var_309_12 / var_309_11)

				if var_309_13 > 0 and var_309_7 < var_309_13 then
					arg_306_1.talkMaxDuration = var_309_13

					if var_309_13 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_13 + var_309_6
					end
				end

				arg_306_1.text_.text = var_309_10
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_14 = math.max(var_309_7, arg_306_1.talkMaxDuration)

			if var_309_6 <= arg_306_1.time_ and arg_306_1.time_ < var_309_6 + var_309_14 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_6) / var_309_14

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_6 + var_309_14 and arg_306_1.time_ < var_309_6 + var_309_14 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play1107506074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 1107506074
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play1107506075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 0
			local var_313_1 = 0.775

			if var_313_0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_2 = arg_310_1:FormatText(StoryNameCfg[7].name)

				arg_310_1.leftNameTxt_.text = var_313_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_3 = arg_310_1:GetWordFromCfg(1107506074)
				local var_313_4 = arg_310_1:FormatText(var_313_3.content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_5 = 31
				local var_313_6 = utf8.len(var_313_4)
				local var_313_7 = var_313_5 <= 0 and var_313_1 or var_313_1 * (var_313_6 / var_313_5)

				if var_313_7 > 0 and var_313_1 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_0
					end
				end

				arg_310_1.text_.text = var_313_4
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_8 = math.max(var_313_1, arg_310_1.talkMaxDuration)

			if var_313_0 <= arg_310_1.time_ and arg_310_1.time_ < var_313_0 + var_313_8 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_0) / var_313_8

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_0 + var_313_8 and arg_310_1.time_ < var_313_0 + var_313_8 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play1107506075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1107506075
		arg_314_1.duration_ = 15.67

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1107506076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = arg_314_1.actors_["1075ui_actor"]
			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1075ui_actor == nil then
				arg_314_1.var_.characterEffect1075ui_actor = var_317_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if var_317_1 <= arg_314_1.time_ and arg_314_1.time_ < var_317_1 + var_317_2 and not isNil(var_317_0) then
				local var_317_3 = (arg_314_1.time_ - var_317_1) / var_317_2

				if arg_314_1.var_.characterEffect1075ui_actor and not isNil(var_317_0) then
					arg_314_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_314_1.time_ >= var_317_1 + var_317_2 and arg_314_1.time_ < var_317_1 + var_317_2 + arg_317_0 and not isNil(var_317_0) and arg_314_1.var_.characterEffect1075ui_actor then
				arg_314_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_317_4 = 0

			if var_317_4 < arg_314_1.time_ and arg_314_1.time_ <= var_317_4 + arg_317_0 then
				arg_314_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_317_5 = 0

			if var_317_5 < arg_314_1.time_ and arg_314_1.time_ <= var_317_5 + arg_317_0 then
				arg_314_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_317_6 = 0
			local var_317_7 = 1.375

			if var_317_6 < arg_314_1.time_ and arg_314_1.time_ <= var_317_6 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_8 = arg_314_1:FormatText(StoryNameCfg[381].name)

				arg_314_1.leftNameTxt_.text = var_317_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_9 = arg_314_1:GetWordFromCfg(1107506075)
				local var_317_10 = arg_314_1:FormatText(var_317_9.content)

				arg_314_1.text_.text = var_317_10

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_11 = 55
				local var_317_12 = utf8.len(var_317_10)
				local var_317_13 = var_317_11 <= 0 and var_317_7 or var_317_7 * (var_317_12 / var_317_11)

				if var_317_13 > 0 and var_317_7 < var_317_13 then
					arg_314_1.talkMaxDuration = var_317_13

					if var_317_13 + var_317_6 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_13 + var_317_6
					end
				end

				arg_314_1.text_.text = var_317_10
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506075", "story_v_side_new_1107506.awb") ~= 0 then
					local var_317_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506075", "story_v_side_new_1107506.awb") / 1000

					if var_317_14 + var_317_6 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_14 + var_317_6
					end

					if var_317_9.prefab_name ~= "" and arg_314_1.actors_[var_317_9.prefab_name] ~= nil then
						local var_317_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_9.prefab_name].transform, "story_v_side_new_1107506", "1107506075", "story_v_side_new_1107506.awb")

						arg_314_1:RecordAudio("1107506075", var_317_15)
						arg_314_1:RecordAudio("1107506075", var_317_15)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506075", "story_v_side_new_1107506.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506075", "story_v_side_new_1107506.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_16 = math.max(var_317_7, arg_314_1.talkMaxDuration)

			if var_317_6 <= arg_314_1.time_ and arg_314_1.time_ < var_317_6 + var_317_16 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_6) / var_317_16

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_6 + var_317_16 and arg_314_1.time_ < var_317_6 + var_317_16 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play1107506076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1107506076
		arg_318_1.duration_ = 4.87

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1107506077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0
			local var_321_1 = 0.575

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[381].name)

				arg_318_1.leftNameTxt_.text = var_321_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_3 = arg_318_1:GetWordFromCfg(1107506076)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506076", "story_v_side_new_1107506.awb") ~= 0 then
					local var_321_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506076", "story_v_side_new_1107506.awb") / 1000

					if var_321_8 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_8 + var_321_0
					end

					if var_321_3.prefab_name ~= "" and arg_318_1.actors_[var_321_3.prefab_name] ~= nil then
						local var_321_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_3.prefab_name].transform, "story_v_side_new_1107506", "1107506076", "story_v_side_new_1107506.awb")

						arg_318_1:RecordAudio("1107506076", var_321_9)
						arg_318_1:RecordAudio("1107506076", var_321_9)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506076", "story_v_side_new_1107506.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506076", "story_v_side_new_1107506.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_10 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_10 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_10

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_10 and arg_318_1.time_ < var_321_0 + var_321_10 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play1107506077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1107506077
		arg_322_1.duration_ = 7.67

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1107506078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_325_2 = 0
			local var_325_3 = 0.65

			if var_325_2 < arg_322_1.time_ and arg_322_1.time_ <= var_325_2 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_4 = arg_322_1:FormatText(StoryNameCfg[381].name)

				arg_322_1.leftNameTxt_.text = var_325_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_5 = arg_322_1:GetWordFromCfg(1107506077)
				local var_325_6 = arg_322_1:FormatText(var_325_5.content)

				arg_322_1.text_.text = var_325_6

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_7 = 26
				local var_325_8 = utf8.len(var_325_6)
				local var_325_9 = var_325_7 <= 0 and var_325_3 or var_325_3 * (var_325_8 / var_325_7)

				if var_325_9 > 0 and var_325_3 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9

					if var_325_9 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_2
					end
				end

				arg_322_1.text_.text = var_325_6
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506077", "story_v_side_new_1107506.awb") ~= 0 then
					local var_325_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506077", "story_v_side_new_1107506.awb") / 1000

					if var_325_10 + var_325_2 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_10 + var_325_2
					end

					if var_325_5.prefab_name ~= "" and arg_322_1.actors_[var_325_5.prefab_name] ~= nil then
						local var_325_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_5.prefab_name].transform, "story_v_side_new_1107506", "1107506077", "story_v_side_new_1107506.awb")

						arg_322_1:RecordAudio("1107506077", var_325_11)
						arg_322_1:RecordAudio("1107506077", var_325_11)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506077", "story_v_side_new_1107506.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506077", "story_v_side_new_1107506.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_12 = math.max(var_325_3, arg_322_1.talkMaxDuration)

			if var_325_2 <= arg_322_1.time_ and arg_322_1.time_ < var_325_2 + var_325_12 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_2) / var_325_12

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_2 + var_325_12 and arg_322_1.time_ < var_325_2 + var_325_12 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play1107506078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1107506078
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1107506079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["10044ui_story"].transform
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.var_.moveOldPos10044ui_story = var_329_0.localPosition
			end

			local var_329_2 = 0.001

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2
				local var_329_4 = Vector3.New(0, 100, 0)

				var_329_0.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos10044ui_story, var_329_4, var_329_3)

				local var_329_5 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_5.x, var_329_5.y, var_329_5.z)

				local var_329_6 = var_329_0.localEulerAngles

				var_329_6.z = 0
				var_329_6.x = 0
				var_329_0.localEulerAngles = var_329_6
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 then
				var_329_0.localPosition = Vector3.New(0, 100, 0)

				local var_329_7 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_7.x, var_329_7.y, var_329_7.z)

				local var_329_8 = var_329_0.localEulerAngles

				var_329_8.z = 0
				var_329_8.x = 0
				var_329_0.localEulerAngles = var_329_8
			end

			local var_329_9 = arg_326_1.actors_["1075ui_actor"]
			local var_329_10 = 0

			if var_329_10 < arg_326_1.time_ and arg_326_1.time_ <= var_329_10 + arg_329_0 and not isNil(var_329_9) and arg_326_1.var_.characterEffect1075ui_actor == nil then
				arg_326_1.var_.characterEffect1075ui_actor = var_329_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_11 = 0.200000002980232

			if var_329_10 <= arg_326_1.time_ and arg_326_1.time_ < var_329_10 + var_329_11 and not isNil(var_329_9) then
				local var_329_12 = (arg_326_1.time_ - var_329_10) / var_329_11

				if arg_326_1.var_.characterEffect1075ui_actor and not isNil(var_329_9) then
					local var_329_13 = Mathf.Lerp(0, 0.5, var_329_12)

					arg_326_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_326_1.var_.characterEffect1075ui_actor.fillRatio = var_329_13
				end
			end

			if arg_326_1.time_ >= var_329_10 + var_329_11 and arg_326_1.time_ < var_329_10 + var_329_11 + arg_329_0 and not isNil(var_329_9) and arg_326_1.var_.characterEffect1075ui_actor then
				local var_329_14 = 0.5

				arg_326_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_326_1.var_.characterEffect1075ui_actor.fillRatio = var_329_14
			end

			local var_329_15 = 0
			local var_329_16 = 1.075

			if var_329_15 < arg_326_1.time_ and arg_326_1.time_ <= var_329_15 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_17 = arg_326_1:GetWordFromCfg(1107506078)
				local var_329_18 = arg_326_1:FormatText(var_329_17.content)

				arg_326_1.text_.text = var_329_18

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_19 = 43
				local var_329_20 = utf8.len(var_329_18)
				local var_329_21 = var_329_19 <= 0 and var_329_16 or var_329_16 * (var_329_20 / var_329_19)

				if var_329_21 > 0 and var_329_16 < var_329_21 then
					arg_326_1.talkMaxDuration = var_329_21

					if var_329_21 + var_329_15 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_21 + var_329_15
					end
				end

				arg_326_1.text_.text = var_329_18
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_22 = math.max(var_329_16, arg_326_1.talkMaxDuration)

			if var_329_15 <= arg_326_1.time_ and arg_326_1.time_ < var_329_15 + var_329_22 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_15) / var_329_22

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_15 + var_329_22 and arg_326_1.time_ < var_329_15 + var_329_22 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play1107506079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 1107506079
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play1107506080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0
			local var_333_1 = 0.675

			if var_333_0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_2 = arg_330_1:GetWordFromCfg(1107506079)
				local var_333_3 = arg_330_1:FormatText(var_333_2.content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_4 = 27
				local var_333_5 = utf8.len(var_333_3)
				local var_333_6 = var_333_4 <= 0 and var_333_1 or var_333_1 * (var_333_5 / var_333_4)

				if var_333_6 > 0 and var_333_1 < var_333_6 then
					arg_330_1.talkMaxDuration = var_333_6

					if var_333_6 + var_333_0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_6 + var_333_0
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_7 = math.max(var_333_1, arg_330_1.talkMaxDuration)

			if var_333_0 <= arg_330_1.time_ and arg_330_1.time_ < var_333_0 + var_333_7 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_0) / var_333_7

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_0 + var_333_7 and arg_330_1.time_ < var_333_0 + var_333_7 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play1107506080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 1107506080
		arg_334_1.duration_ = 7.93

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play1107506081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["1075ui_actor"].transform
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.var_.moveOldPos1075ui_actor = var_337_0.localPosition

				local var_337_2 = GameObjectTools.GetOrAddComponent(var_337_0.gameObject, typeof(DynamicBoneHelper))

				if var_337_2 then
					var_337_2:EnableDynamicBone(false)
				end
			end

			local var_337_3 = 0.001

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_3 then
				local var_337_4 = (arg_334_1.time_ - var_337_1) / var_337_3
				local var_337_5 = Vector3.New(0, -1.055, -6.16)

				var_337_0.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1075ui_actor, var_337_5, var_337_4)

				local var_337_6 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_6.x, var_337_6.y, var_337_6.z)

				local var_337_7 = var_337_0.localEulerAngles

				var_337_7.z = 0
				var_337_7.x = 0
				var_337_0.localEulerAngles = var_337_7
			end

			if arg_334_1.time_ >= var_337_1 + var_337_3 and arg_334_1.time_ < var_337_1 + var_337_3 + arg_337_0 then
				var_337_0.localPosition = Vector3.New(0, -1.055, -6.16)

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

			local var_337_11 = arg_334_1.actors_["1075ui_actor"]
			local var_337_12 = 0

			if var_337_12 < arg_334_1.time_ and arg_334_1.time_ <= var_337_12 + arg_337_0 and not isNil(var_337_11) and arg_334_1.var_.characterEffect1075ui_actor == nil then
				arg_334_1.var_.characterEffect1075ui_actor = var_337_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_13 = 0.200000002980232

			if var_337_12 <= arg_334_1.time_ and arg_334_1.time_ < var_337_12 + var_337_13 and not isNil(var_337_11) then
				local var_337_14 = (arg_334_1.time_ - var_337_12) / var_337_13

				if arg_334_1.var_.characterEffect1075ui_actor and not isNil(var_337_11) then
					arg_334_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_12 + var_337_13 and arg_334_1.time_ < var_337_12 + var_337_13 + arg_337_0 and not isNil(var_337_11) and arg_334_1.var_.characterEffect1075ui_actor then
				arg_334_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_337_15 = 0

			if var_337_15 < arg_334_1.time_ and arg_334_1.time_ <= var_337_15 + arg_337_0 then
				arg_334_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_337_16 = 0

			if var_337_16 < arg_334_1.time_ and arg_334_1.time_ <= var_337_16 + arg_337_0 then
				arg_334_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_337_17 = 0
			local var_337_18 = 0.95

			if var_337_17 < arg_334_1.time_ and arg_334_1.time_ <= var_337_17 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_19 = arg_334_1:FormatText(StoryNameCfg[381].name)

				arg_334_1.leftNameTxt_.text = var_337_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_20 = arg_334_1:GetWordFromCfg(1107506080)
				local var_337_21 = arg_334_1:FormatText(var_337_20.content)

				arg_334_1.text_.text = var_337_21

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_22 = 38
				local var_337_23 = utf8.len(var_337_21)
				local var_337_24 = var_337_22 <= 0 and var_337_18 or var_337_18 * (var_337_23 / var_337_22)

				if var_337_24 > 0 and var_337_18 < var_337_24 then
					arg_334_1.talkMaxDuration = var_337_24

					if var_337_24 + var_337_17 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_24 + var_337_17
					end
				end

				arg_334_1.text_.text = var_337_21
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506080", "story_v_side_new_1107506.awb") ~= 0 then
					local var_337_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506080", "story_v_side_new_1107506.awb") / 1000

					if var_337_25 + var_337_17 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_25 + var_337_17
					end

					if var_337_20.prefab_name ~= "" and arg_334_1.actors_[var_337_20.prefab_name] ~= nil then
						local var_337_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_20.prefab_name].transform, "story_v_side_new_1107506", "1107506080", "story_v_side_new_1107506.awb")

						arg_334_1:RecordAudio("1107506080", var_337_26)
						arg_334_1:RecordAudio("1107506080", var_337_26)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506080", "story_v_side_new_1107506.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506080", "story_v_side_new_1107506.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_27 = math.max(var_337_18, arg_334_1.talkMaxDuration)

			if var_337_17 <= arg_334_1.time_ and arg_334_1.time_ < var_337_17 + var_337_27 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_17) / var_337_27

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_17 + var_337_27 and arg_334_1.time_ < var_337_17 + var_337_27 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
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
	Play1107506081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 1107506081
		arg_338_1.duration_ = 1

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"

			SetActive(arg_338_1.choicesGo_, true)

			for iter_339_0, iter_339_1 in ipairs(arg_338_1.choices_) do
				local var_339_0 = iter_339_0 <= 1

				SetActive(iter_339_1.go, var_339_0)
			end

			arg_338_1.choices_[1].txt.text = arg_338_1:FormatText(StoryChoiceCfg[1169].name)
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play1107506082(arg_338_1)
			end

			arg_338_1:RecordChoiceLog(1107506081, 1169)
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1075ui_actor"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1075ui_actor == nil then
				arg_338_1.var_.characterEffect1075ui_actor = var_341_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.characterEffect1075ui_actor and not isNil(var_341_0) then
					local var_341_4 = Mathf.Lerp(0, 0.5, var_341_3)

					arg_338_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_338_1.var_.characterEffect1075ui_actor.fillRatio = var_341_4
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect1075ui_actor then
				local var_341_5 = 0.5

				arg_338_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_338_1.var_.characterEffect1075ui_actor.fillRatio = var_341_5
			end

			local var_341_6 = 0

			if var_341_6 < arg_338_1.time_ and arg_338_1.time_ <= var_341_6 + arg_341_0 then
				arg_338_1.allBtn_.enabled = false
			end

			local var_341_7 = 0.5

			if arg_338_1.time_ >= var_341_6 + var_341_7 and arg_338_1.time_ < var_341_6 + var_341_7 + arg_341_0 then
				arg_338_1.allBtn_.enabled = true
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play1107506082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 1107506082
		arg_342_1.duration_ = 2

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play1107506083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1075ui_actor"]
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1075ui_actor == nil then
				arg_342_1.var_.characterEffect1075ui_actor = var_345_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_2 = 0.200000002980232

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 and not isNil(var_345_0) then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2

				if arg_342_1.var_.characterEffect1075ui_actor and not isNil(var_345_0) then
					arg_342_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 and not isNil(var_345_0) and arg_342_1.var_.characterEffect1075ui_actor then
				arg_342_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_345_4 = 0

			if var_345_4 < arg_342_1.time_ and arg_342_1.time_ <= var_345_4 + arg_345_0 then
				arg_342_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_345_5 = 0

			if var_345_5 < arg_342_1.time_ and arg_342_1.time_ <= var_345_5 + arg_345_0 then
				arg_342_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_345_6 = 0
			local var_345_7 = 0.125

			if var_345_6 < arg_342_1.time_ and arg_342_1.time_ <= var_345_6 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_8 = arg_342_1:FormatText(StoryNameCfg[381].name)

				arg_342_1.leftNameTxt_.text = var_345_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_9 = arg_342_1:GetWordFromCfg(1107506082)
				local var_345_10 = arg_342_1:FormatText(var_345_9.content)

				arg_342_1.text_.text = var_345_10

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_11 = 5
				local var_345_12 = utf8.len(var_345_10)
				local var_345_13 = var_345_11 <= 0 and var_345_7 or var_345_7 * (var_345_12 / var_345_11)

				if var_345_13 > 0 and var_345_7 < var_345_13 then
					arg_342_1.talkMaxDuration = var_345_13

					if var_345_13 + var_345_6 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_13 + var_345_6
					end
				end

				arg_342_1.text_.text = var_345_10
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506082", "story_v_side_new_1107506.awb") ~= 0 then
					local var_345_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506082", "story_v_side_new_1107506.awb") / 1000

					if var_345_14 + var_345_6 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_14 + var_345_6
					end

					if var_345_9.prefab_name ~= "" and arg_342_1.actors_[var_345_9.prefab_name] ~= nil then
						local var_345_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_9.prefab_name].transform, "story_v_side_new_1107506", "1107506082", "story_v_side_new_1107506.awb")

						arg_342_1:RecordAudio("1107506082", var_345_15)
						arg_342_1:RecordAudio("1107506082", var_345_15)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506082", "story_v_side_new_1107506.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506082", "story_v_side_new_1107506.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_16 = math.max(var_345_7, arg_342_1.talkMaxDuration)

			if var_345_6 <= arg_342_1.time_ and arg_342_1.time_ < var_345_6 + var_345_16 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_6) / var_345_16

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_6 + var_345_16 and arg_342_1.time_ < var_345_6 + var_345_16 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play1107506083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 1107506083
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play1107506084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["1075ui_actor"]
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1075ui_actor == nil then
				arg_346_1.var_.characterEffect1075ui_actor = var_349_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_2 and not isNil(var_349_0) then
				local var_349_3 = (arg_346_1.time_ - var_349_1) / var_349_2

				if arg_346_1.var_.characterEffect1075ui_actor and not isNil(var_349_0) then
					local var_349_4 = Mathf.Lerp(0, 0.5, var_349_3)

					arg_346_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_346_1.var_.characterEffect1075ui_actor.fillRatio = var_349_4
				end
			end

			if arg_346_1.time_ >= var_349_1 + var_349_2 and arg_346_1.time_ < var_349_1 + var_349_2 + arg_349_0 and not isNil(var_349_0) and arg_346_1.var_.characterEffect1075ui_actor then
				local var_349_5 = 0.5

				arg_346_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_346_1.var_.characterEffect1075ui_actor.fillRatio = var_349_5
			end

			local var_349_6 = 0
			local var_349_7 = 0.75

			if var_349_6 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_8 = arg_346_1:GetWordFromCfg(1107506083)
				local var_349_9 = arg_346_1:FormatText(var_349_8.content)

				arg_346_1.text_.text = var_349_9

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_10 = 30
				local var_349_11 = utf8.len(var_349_9)
				local var_349_12 = var_349_10 <= 0 and var_349_7 or var_349_7 * (var_349_11 / var_349_10)

				if var_349_12 > 0 and var_349_7 < var_349_12 then
					arg_346_1.talkMaxDuration = var_349_12

					if var_349_12 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_12 + var_349_6
					end
				end

				arg_346_1.text_.text = var_349_9
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_13 = math.max(var_349_7, arg_346_1.talkMaxDuration)

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_13 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_6) / var_349_13

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_6 + var_349_13 and arg_346_1.time_ < var_349_6 + var_349_13 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play1107506084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 1107506084
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play1107506085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 0.85

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_2 = arg_350_1:FormatText(StoryNameCfg[7].name)

				arg_350_1.leftNameTxt_.text = var_353_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_3 = arg_350_1:GetWordFromCfg(1107506084)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 34
				local var_353_6 = utf8.len(var_353_4)
				local var_353_7 = var_353_5 <= 0 and var_353_1 or var_353_1 * (var_353_6 / var_353_5)

				if var_353_7 > 0 and var_353_1 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_4
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_8 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_8 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_8

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_8 and arg_350_1.time_ < var_353_0 + var_353_8 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play1107506085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 1107506085
		arg_354_1.duration_ = 8.6

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play1107506086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["1075ui_actor"]
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1075ui_actor == nil then
				arg_354_1.var_.characterEffect1075ui_actor = var_357_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_2 = 0.200000002980232

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_2 and not isNil(var_357_0) then
				local var_357_3 = (arg_354_1.time_ - var_357_1) / var_357_2

				if arg_354_1.var_.characterEffect1075ui_actor and not isNil(var_357_0) then
					arg_354_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_354_1.time_ >= var_357_1 + var_357_2 and arg_354_1.time_ < var_357_1 + var_357_2 + arg_357_0 and not isNil(var_357_0) and arg_354_1.var_.characterEffect1075ui_actor then
				arg_354_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_357_4 = 0

			if var_357_4 < arg_354_1.time_ and arg_354_1.time_ <= var_357_4 + arg_357_0 then
				arg_354_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_357_5 = 0

			if var_357_5 < arg_354_1.time_ and arg_354_1.time_ <= var_357_5 + arg_357_0 then
				arg_354_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_357_6 = 0
			local var_357_7 = 0.9

			if var_357_6 < arg_354_1.time_ and arg_354_1.time_ <= var_357_6 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_8 = arg_354_1:FormatText(StoryNameCfg[381].name)

				arg_354_1.leftNameTxt_.text = var_357_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_9 = arg_354_1:GetWordFromCfg(1107506085)
				local var_357_10 = arg_354_1:FormatText(var_357_9.content)

				arg_354_1.text_.text = var_357_10

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_11 = 36
				local var_357_12 = utf8.len(var_357_10)
				local var_357_13 = var_357_11 <= 0 and var_357_7 or var_357_7 * (var_357_12 / var_357_11)

				if var_357_13 > 0 and var_357_7 < var_357_13 then
					arg_354_1.talkMaxDuration = var_357_13

					if var_357_13 + var_357_6 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_13 + var_357_6
					end
				end

				arg_354_1.text_.text = var_357_10
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506085", "story_v_side_new_1107506.awb") ~= 0 then
					local var_357_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506085", "story_v_side_new_1107506.awb") / 1000

					if var_357_14 + var_357_6 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_14 + var_357_6
					end

					if var_357_9.prefab_name ~= "" and arg_354_1.actors_[var_357_9.prefab_name] ~= nil then
						local var_357_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_9.prefab_name].transform, "story_v_side_new_1107506", "1107506085", "story_v_side_new_1107506.awb")

						arg_354_1:RecordAudio("1107506085", var_357_15)
						arg_354_1:RecordAudio("1107506085", var_357_15)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506085", "story_v_side_new_1107506.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506085", "story_v_side_new_1107506.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_16 = math.max(var_357_7, arg_354_1.talkMaxDuration)

			if var_357_6 <= arg_354_1.time_ and arg_354_1.time_ < var_357_6 + var_357_16 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_6) / var_357_16

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_6 + var_357_16 and arg_354_1.time_ < var_357_6 + var_357_16 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play1107506086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 1107506086
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play1107506087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["1075ui_actor"]
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1075ui_actor == nil then
				arg_358_1.var_.characterEffect1075ui_actor = var_361_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_2 = 0.200000002980232

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_2 and not isNil(var_361_0) then
				local var_361_3 = (arg_358_1.time_ - var_361_1) / var_361_2

				if arg_358_1.var_.characterEffect1075ui_actor and not isNil(var_361_0) then
					local var_361_4 = Mathf.Lerp(0, 0.5, var_361_3)

					arg_358_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_358_1.var_.characterEffect1075ui_actor.fillRatio = var_361_4
				end
			end

			if arg_358_1.time_ >= var_361_1 + var_361_2 and arg_358_1.time_ < var_361_1 + var_361_2 + arg_361_0 and not isNil(var_361_0) and arg_358_1.var_.characterEffect1075ui_actor then
				local var_361_5 = 0.5

				arg_358_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_358_1.var_.characterEffect1075ui_actor.fillRatio = var_361_5
			end

			local var_361_6 = 0
			local var_361_7 = 1

			if var_361_6 < arg_358_1.time_ and arg_358_1.time_ <= var_361_6 + arg_361_0 then
				local var_361_8 = "stop"
				local var_361_9 = "effect"

				arg_358_1:AudioAction(var_361_8, var_361_9, "se_story_side_1075", "se_story_side_1075_rain_inside01", "")
			end

			local var_361_10 = 0.1
			local var_361_11 = 1

			if var_361_10 < arg_358_1.time_ and arg_358_1.time_ <= var_361_10 + arg_361_0 then
				local var_361_12 = "play"
				local var_361_13 = "effect"

				arg_358_1:AudioAction(var_361_12, var_361_13, "se_story_side_1075", "se_story_side_1075_rain_inside02", "")
			end

			local var_361_14 = 0
			local var_361_15 = 1

			if var_361_14 < arg_358_1.time_ and arg_358_1.time_ <= var_361_14 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_16 = arg_358_1:GetWordFromCfg(1107506086)
				local var_361_17 = arg_358_1:FormatText(var_361_16.content)

				arg_358_1.text_.text = var_361_17

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_18 = 40
				local var_361_19 = utf8.len(var_361_17)
				local var_361_20 = var_361_18 <= 0 and var_361_15 or var_361_15 * (var_361_19 / var_361_18)

				if var_361_20 > 0 and var_361_15 < var_361_20 then
					arg_358_1.talkMaxDuration = var_361_20

					if var_361_20 + var_361_14 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_20 + var_361_14
					end
				end

				arg_358_1.text_.text = var_361_17
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_21 = math.max(var_361_15, arg_358_1.talkMaxDuration)

			if var_361_14 <= arg_358_1.time_ and arg_358_1.time_ < var_361_14 + var_361_21 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_14) / var_361_21

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_14 + var_361_21 and arg_358_1.time_ < var_361_14 + var_361_21 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play1107506087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1107506087
		arg_362_1.duration_ = 5

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1107506088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0
			local var_365_1 = 0.825

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_2 = arg_362_1:FormatText(StoryNameCfg[7].name)

				arg_362_1.leftNameTxt_.text = var_365_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_3 = arg_362_1:GetWordFromCfg(1107506087)
				local var_365_4 = arg_362_1:FormatText(var_365_3.content)

				arg_362_1.text_.text = var_365_4

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_5 = 33
				local var_365_6 = utf8.len(var_365_4)
				local var_365_7 = var_365_5 <= 0 and var_365_1 or var_365_1 * (var_365_6 / var_365_5)

				if var_365_7 > 0 and var_365_1 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_0
					end
				end

				arg_362_1.text_.text = var_365_4
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_8 = math.max(var_365_1, arg_362_1.talkMaxDuration)

			if var_365_0 <= arg_362_1.time_ and arg_362_1.time_ < var_365_0 + var_365_8 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_0) / var_365_8

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_0 + var_365_8 and arg_362_1.time_ < var_365_0 + var_365_8 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play1107506088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1107506088
		arg_366_1.duration_ = 3.63

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1107506089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["1075ui_actor"]
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect1075ui_actor == nil then
				arg_366_1.var_.characterEffect1075ui_actor = var_369_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_2 = 0.200000002980232

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 and not isNil(var_369_0) then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2

				if arg_366_1.var_.characterEffect1075ui_actor and not isNil(var_369_0) then
					arg_366_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 and not isNil(var_369_0) and arg_366_1.var_.characterEffect1075ui_actor then
				arg_366_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_369_4 = 0

			if var_369_4 < arg_366_1.time_ and arg_366_1.time_ <= var_369_4 + arg_369_0 then
				arg_366_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_369_5 = 0

			if var_369_5 < arg_366_1.time_ and arg_366_1.time_ <= var_369_5 + arg_369_0 then
				arg_366_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_369_6 = 0
			local var_369_7 = 0.55

			if var_369_6 < arg_366_1.time_ and arg_366_1.time_ <= var_369_6 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_8 = arg_366_1:FormatText(StoryNameCfg[381].name)

				arg_366_1.leftNameTxt_.text = var_369_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_9 = arg_366_1:GetWordFromCfg(1107506088)
				local var_369_10 = arg_366_1:FormatText(var_369_9.content)

				arg_366_1.text_.text = var_369_10

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_11 = 22
				local var_369_12 = utf8.len(var_369_10)
				local var_369_13 = var_369_11 <= 0 and var_369_7 or var_369_7 * (var_369_12 / var_369_11)

				if var_369_13 > 0 and var_369_7 < var_369_13 then
					arg_366_1.talkMaxDuration = var_369_13

					if var_369_13 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_6
					end
				end

				arg_366_1.text_.text = var_369_10
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506088", "story_v_side_new_1107506.awb") ~= 0 then
					local var_369_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506088", "story_v_side_new_1107506.awb") / 1000

					if var_369_14 + var_369_6 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_14 + var_369_6
					end

					if var_369_9.prefab_name ~= "" and arg_366_1.actors_[var_369_9.prefab_name] ~= nil then
						local var_369_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_9.prefab_name].transform, "story_v_side_new_1107506", "1107506088", "story_v_side_new_1107506.awb")

						arg_366_1:RecordAudio("1107506088", var_369_15)
						arg_366_1:RecordAudio("1107506088", var_369_15)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506088", "story_v_side_new_1107506.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506088", "story_v_side_new_1107506.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_7, arg_366_1.talkMaxDuration)

			if var_369_6 <= arg_366_1.time_ and arg_366_1.time_ < var_369_6 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_6) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_6 + var_369_16 and arg_366_1.time_ < var_369_6 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play1107506089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1107506089
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1107506090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1075ui_actor"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect1075ui_actor == nil then
				arg_370_1.var_.characterEffect1075ui_actor = var_373_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.200000002980232

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.characterEffect1075ui_actor and not isNil(var_373_0) then
					local var_373_4 = Mathf.Lerp(0, 0.5, var_373_3)

					arg_370_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_370_1.var_.characterEffect1075ui_actor.fillRatio = var_373_4
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect1075ui_actor then
				local var_373_5 = 0.5

				arg_370_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_370_1.var_.characterEffect1075ui_actor.fillRatio = var_373_5
			end

			local var_373_6 = 0
			local var_373_7 = 0.625

			if var_373_6 < arg_370_1.time_ and arg_370_1.time_ <= var_373_6 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_8 = arg_370_1:FormatText(StoryNameCfg[7].name)

				arg_370_1.leftNameTxt_.text = var_373_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, true)
				arg_370_1.iconController_:SetSelectedState("hero")

				arg_370_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_370_1.callingController_:SetSelectedState("normal")

				arg_370_1.keyicon_.color = Color.New(1, 1, 1)
				arg_370_1.icon_.color = Color.New(1, 1, 1)

				local var_373_9 = arg_370_1:GetWordFromCfg(1107506089)
				local var_373_10 = arg_370_1:FormatText(var_373_9.content)

				arg_370_1.text_.text = var_373_10

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_11 = 25
				local var_373_12 = utf8.len(var_373_10)
				local var_373_13 = var_373_11 <= 0 and var_373_7 or var_373_7 * (var_373_12 / var_373_11)

				if var_373_13 > 0 and var_373_7 < var_373_13 then
					arg_370_1.talkMaxDuration = var_373_13

					if var_373_13 + var_373_6 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_13 + var_373_6
					end
				end

				arg_370_1.text_.text = var_373_10
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_14 = math.max(var_373_7, arg_370_1.talkMaxDuration)

			if var_373_6 <= arg_370_1.time_ and arg_370_1.time_ < var_373_6 + var_373_14 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_6) / var_373_14

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_6 + var_373_14 and arg_370_1.time_ < var_373_6 + var_373_14 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play1107506090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1107506090
		arg_374_1.duration_ = 3.03

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1107506091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = arg_374_1.actors_["1075ui_actor"]
			local var_377_1 = 0

			if var_377_1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_1 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1075ui_actor == nil then
				arg_374_1.var_.characterEffect1075ui_actor = var_377_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_2 = 0.200000002980232

			if var_377_1 <= arg_374_1.time_ and arg_374_1.time_ < var_377_1 + var_377_2 and not isNil(var_377_0) then
				local var_377_3 = (arg_374_1.time_ - var_377_1) / var_377_2

				if arg_374_1.var_.characterEffect1075ui_actor and not isNil(var_377_0) then
					arg_374_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_374_1.time_ >= var_377_1 + var_377_2 and arg_374_1.time_ < var_377_1 + var_377_2 + arg_377_0 and not isNil(var_377_0) and arg_374_1.var_.characterEffect1075ui_actor then
				arg_374_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_377_4 = 0

			if var_377_4 < arg_374_1.time_ and arg_374_1.time_ <= var_377_4 + arg_377_0 then
				arg_374_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_377_5 = 0

			if var_377_5 < arg_374_1.time_ and arg_374_1.time_ <= var_377_5 + arg_377_0 then
				arg_374_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_377_6 = 0
			local var_377_7 = 0.2

			if var_377_6 < arg_374_1.time_ and arg_374_1.time_ <= var_377_6 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_8 = arg_374_1:FormatText(StoryNameCfg[381].name)

				arg_374_1.leftNameTxt_.text = var_377_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_9 = arg_374_1:GetWordFromCfg(1107506090)
				local var_377_10 = arg_374_1:FormatText(var_377_9.content)

				arg_374_1.text_.text = var_377_10

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_11 = 8
				local var_377_12 = utf8.len(var_377_10)
				local var_377_13 = var_377_11 <= 0 and var_377_7 or var_377_7 * (var_377_12 / var_377_11)

				if var_377_13 > 0 and var_377_7 < var_377_13 then
					arg_374_1.talkMaxDuration = var_377_13

					if var_377_13 + var_377_6 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_13 + var_377_6
					end
				end

				arg_374_1.text_.text = var_377_10
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506090", "story_v_side_new_1107506.awb") ~= 0 then
					local var_377_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506090", "story_v_side_new_1107506.awb") / 1000

					if var_377_14 + var_377_6 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_14 + var_377_6
					end

					if var_377_9.prefab_name ~= "" and arg_374_1.actors_[var_377_9.prefab_name] ~= nil then
						local var_377_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_9.prefab_name].transform, "story_v_side_new_1107506", "1107506090", "story_v_side_new_1107506.awb")

						arg_374_1:RecordAudio("1107506090", var_377_15)
						arg_374_1:RecordAudio("1107506090", var_377_15)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506090", "story_v_side_new_1107506.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506090", "story_v_side_new_1107506.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_16 = math.max(var_377_7, arg_374_1.talkMaxDuration)

			if var_377_6 <= arg_374_1.time_ and arg_374_1.time_ < var_377_6 + var_377_16 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_6) / var_377_16

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_6 + var_377_16 and arg_374_1.time_ < var_377_6 + var_377_16 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1107506091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1107506091
		arg_378_1.duration_ = 5

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1107506092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1075ui_actor"]
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1075ui_actor == nil then
				arg_378_1.var_.characterEffect1075ui_actor = var_381_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.200000002980232

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 and not isNil(var_381_0) then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2

				if arg_378_1.var_.characterEffect1075ui_actor and not isNil(var_381_0) then
					local var_381_4 = Mathf.Lerp(0, 0.5, var_381_3)

					arg_378_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_378_1.var_.characterEffect1075ui_actor.fillRatio = var_381_4
				end
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 and not isNil(var_381_0) and arg_378_1.var_.characterEffect1075ui_actor then
				local var_381_5 = 0.5

				arg_378_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_378_1.var_.characterEffect1075ui_actor.fillRatio = var_381_5
			end

			local var_381_6 = 0
			local var_381_7 = 1.025

			if var_381_6 < arg_378_1.time_ and arg_378_1.time_ <= var_381_6 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_8 = arg_378_1:FormatText(StoryNameCfg[7].name)

				arg_378_1.leftNameTxt_.text = var_381_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_9 = arg_378_1:GetWordFromCfg(1107506091)
				local var_381_10 = arg_378_1:FormatText(var_381_9.content)

				arg_378_1.text_.text = var_381_10

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_11 = 41
				local var_381_12 = utf8.len(var_381_10)
				local var_381_13 = var_381_11 <= 0 and var_381_7 or var_381_7 * (var_381_12 / var_381_11)

				if var_381_13 > 0 and var_381_7 < var_381_13 then
					arg_378_1.talkMaxDuration = var_381_13

					if var_381_13 + var_381_6 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_13 + var_381_6
					end
				end

				arg_378_1.text_.text = var_381_10
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)
				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_14 = math.max(var_381_7, arg_378_1.talkMaxDuration)

			if var_381_6 <= arg_378_1.time_ and arg_378_1.time_ < var_381_6 + var_381_14 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_6) / var_381_14

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_6 + var_381_14 and arg_378_1.time_ < var_381_6 + var_381_14 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play1107506092 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1107506092
		arg_382_1.duration_ = 4.17

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1107506093(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["1075ui_actor"]
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1075ui_actor == nil then
				arg_382_1.var_.characterEffect1075ui_actor = var_385_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_2 = 0.200000002980232

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 and not isNil(var_385_0) then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2

				if arg_382_1.var_.characterEffect1075ui_actor and not isNil(var_385_0) then
					arg_382_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 and not isNil(var_385_0) and arg_382_1.var_.characterEffect1075ui_actor then
				arg_382_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_385_4 = 0

			if var_385_4 < arg_382_1.time_ and arg_382_1.time_ <= var_385_4 + arg_385_0 then
				arg_382_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			local var_385_5 = 0

			if var_385_5 < arg_382_1.time_ and arg_382_1.time_ <= var_385_5 + arg_385_0 then
				arg_382_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_385_6 = 0
			local var_385_7 = 0.425

			if var_385_6 < arg_382_1.time_ and arg_382_1.time_ <= var_385_6 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_8 = arg_382_1:FormatText(StoryNameCfg[381].name)

				arg_382_1.leftNameTxt_.text = var_385_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_9 = arg_382_1:GetWordFromCfg(1107506092)
				local var_385_10 = arg_382_1:FormatText(var_385_9.content)

				arg_382_1.text_.text = var_385_10

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_11 = 17
				local var_385_12 = utf8.len(var_385_10)
				local var_385_13 = var_385_11 <= 0 and var_385_7 or var_385_7 * (var_385_12 / var_385_11)

				if var_385_13 > 0 and var_385_7 < var_385_13 then
					arg_382_1.talkMaxDuration = var_385_13

					if var_385_13 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_13 + var_385_6
					end
				end

				arg_382_1.text_.text = var_385_10
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506092", "story_v_side_new_1107506.awb") ~= 0 then
					local var_385_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506092", "story_v_side_new_1107506.awb") / 1000

					if var_385_14 + var_385_6 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_14 + var_385_6
					end

					if var_385_9.prefab_name ~= "" and arg_382_1.actors_[var_385_9.prefab_name] ~= nil then
						local var_385_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_9.prefab_name].transform, "story_v_side_new_1107506", "1107506092", "story_v_side_new_1107506.awb")

						arg_382_1:RecordAudio("1107506092", var_385_15)
						arg_382_1:RecordAudio("1107506092", var_385_15)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506092", "story_v_side_new_1107506.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506092", "story_v_side_new_1107506.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_16 = math.max(var_385_7, arg_382_1.talkMaxDuration)

			if var_385_6 <= arg_382_1.time_ and arg_382_1.time_ < var_385_6 + var_385_16 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_6) / var_385_16

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_6 + var_385_16 and arg_382_1.time_ < var_385_6 + var_385_16 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play1107506093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1107506093
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1107506094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = arg_386_1.actors_["1075ui_actor"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect1075ui_actor == nil then
				arg_386_1.var_.characterEffect1075ui_actor = var_389_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.200000002980232

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.characterEffect1075ui_actor and not isNil(var_389_0) then
					local var_389_4 = Mathf.Lerp(0, 0.5, var_389_3)

					arg_386_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_386_1.var_.characterEffect1075ui_actor.fillRatio = var_389_4
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect1075ui_actor then
				local var_389_5 = 0.5

				arg_386_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_386_1.var_.characterEffect1075ui_actor.fillRatio = var_389_5
			end

			local var_389_6 = 0
			local var_389_7 = 0.825

			if var_389_6 < arg_386_1.time_ and arg_386_1.time_ <= var_389_6 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_8 = arg_386_1:GetWordFromCfg(1107506093)
				local var_389_9 = arg_386_1:FormatText(var_389_8.content)

				arg_386_1.text_.text = var_389_9

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_10 = 33
				local var_389_11 = utf8.len(var_389_9)
				local var_389_12 = var_389_10 <= 0 and var_389_7 or var_389_7 * (var_389_11 / var_389_10)

				if var_389_12 > 0 and var_389_7 < var_389_12 then
					arg_386_1.talkMaxDuration = var_389_12

					if var_389_12 + var_389_6 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_12 + var_389_6
					end
				end

				arg_386_1.text_.text = var_389_9
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_13 = math.max(var_389_7, arg_386_1.talkMaxDuration)

			if var_389_6 <= arg_386_1.time_ and arg_386_1.time_ < var_389_6 + var_389_13 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_6) / var_389_13

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_6 + var_389_13 and arg_386_1.time_ < var_389_6 + var_389_13 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play1107506094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1107506094
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1107506095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 0.925

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				local var_393_2 = arg_390_1:FormatText(StoryNameCfg[7].name)

				arg_390_1.leftNameTxt_.text = var_393_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_3 = arg_390_1:GetWordFromCfg(1107506094)
				local var_393_4 = arg_390_1:FormatText(var_393_3.content)

				arg_390_1.text_.text = var_393_4

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_5 = 37
				local var_393_6 = utf8.len(var_393_4)
				local var_393_7 = var_393_5 <= 0 and var_393_1 or var_393_1 * (var_393_6 / var_393_5)

				if var_393_7 > 0 and var_393_1 < var_393_7 then
					arg_390_1.talkMaxDuration = var_393_7

					if var_393_7 + var_393_0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_7 + var_393_0
					end
				end

				arg_390_1.text_.text = var_393_4
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_8 = math.max(var_393_1, arg_390_1.talkMaxDuration)

			if var_393_0 <= arg_390_1.time_ and arg_390_1.time_ < var_393_0 + var_393_8 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_0) / var_393_8

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_0 + var_393_8 and arg_390_1.time_ < var_393_0 + var_393_8 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play1107506095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1107506095
		arg_394_1.duration_ = 4.9

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1107506096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = arg_394_1.actors_["1075ui_actor"]
			local var_397_1 = 0

			if var_397_1 < arg_394_1.time_ and arg_394_1.time_ <= var_397_1 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1075ui_actor == nil then
				arg_394_1.var_.characterEffect1075ui_actor = var_397_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_2 = 0.200000002980232

			if var_397_1 <= arg_394_1.time_ and arg_394_1.time_ < var_397_1 + var_397_2 and not isNil(var_397_0) then
				local var_397_3 = (arg_394_1.time_ - var_397_1) / var_397_2

				if arg_394_1.var_.characterEffect1075ui_actor and not isNil(var_397_0) then
					arg_394_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_394_1.time_ >= var_397_1 + var_397_2 and arg_394_1.time_ < var_397_1 + var_397_2 + arg_397_0 and not isNil(var_397_0) and arg_394_1.var_.characterEffect1075ui_actor then
				arg_394_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_397_4 = 0

			if var_397_4 < arg_394_1.time_ and arg_394_1.time_ <= var_397_4 + arg_397_0 then
				arg_394_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_397_5 = 0

			if var_397_5 < arg_394_1.time_ and arg_394_1.time_ <= var_397_5 + arg_397_0 then
				arg_394_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_397_6 = 0
			local var_397_7 = 0.5

			if var_397_6 < arg_394_1.time_ and arg_394_1.time_ <= var_397_6 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_8 = arg_394_1:FormatText(StoryNameCfg[381].name)

				arg_394_1.leftNameTxt_.text = var_397_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_9 = arg_394_1:GetWordFromCfg(1107506095)
				local var_397_10 = arg_394_1:FormatText(var_397_9.content)

				arg_394_1.text_.text = var_397_10

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_11 = 20
				local var_397_12 = utf8.len(var_397_10)
				local var_397_13 = var_397_11 <= 0 and var_397_7 or var_397_7 * (var_397_12 / var_397_11)

				if var_397_13 > 0 and var_397_7 < var_397_13 then
					arg_394_1.talkMaxDuration = var_397_13

					if var_397_13 + var_397_6 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_13 + var_397_6
					end
				end

				arg_394_1.text_.text = var_397_10
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506095", "story_v_side_new_1107506.awb") ~= 0 then
					local var_397_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506095", "story_v_side_new_1107506.awb") / 1000

					if var_397_14 + var_397_6 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_14 + var_397_6
					end

					if var_397_9.prefab_name ~= "" and arg_394_1.actors_[var_397_9.prefab_name] ~= nil then
						local var_397_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_9.prefab_name].transform, "story_v_side_new_1107506", "1107506095", "story_v_side_new_1107506.awb")

						arg_394_1:RecordAudio("1107506095", var_397_15)
						arg_394_1:RecordAudio("1107506095", var_397_15)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506095", "story_v_side_new_1107506.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506095", "story_v_side_new_1107506.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_16 = math.max(var_397_7, arg_394_1.talkMaxDuration)

			if var_397_6 <= arg_394_1.time_ and arg_394_1.time_ < var_397_6 + var_397_16 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_6) / var_397_16

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_6 + var_397_16 and arg_394_1.time_ < var_397_6 + var_397_16 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play1107506096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1107506096
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1107506097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = arg_398_1.actors_["1075ui_actor"]
			local var_401_1 = 0

			if var_401_1 < arg_398_1.time_ and arg_398_1.time_ <= var_401_1 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.characterEffect1075ui_actor == nil then
				arg_398_1.var_.characterEffect1075ui_actor = var_401_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_2 = 0.200000002980232

			if var_401_1 <= arg_398_1.time_ and arg_398_1.time_ < var_401_1 + var_401_2 and not isNil(var_401_0) then
				local var_401_3 = (arg_398_1.time_ - var_401_1) / var_401_2

				if arg_398_1.var_.characterEffect1075ui_actor and not isNil(var_401_0) then
					local var_401_4 = Mathf.Lerp(0, 0.5, var_401_3)

					arg_398_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_398_1.var_.characterEffect1075ui_actor.fillRatio = var_401_4
				end
			end

			if arg_398_1.time_ >= var_401_1 + var_401_2 and arg_398_1.time_ < var_401_1 + var_401_2 + arg_401_0 and not isNil(var_401_0) and arg_398_1.var_.characterEffect1075ui_actor then
				local var_401_5 = 0.5

				arg_398_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_398_1.var_.characterEffect1075ui_actor.fillRatio = var_401_5
			end

			local var_401_6 = 0
			local var_401_7 = 0.55

			if var_401_6 < arg_398_1.time_ and arg_398_1.time_ <= var_401_6 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_8 = arg_398_1:GetWordFromCfg(1107506096)
				local var_401_9 = arg_398_1:FormatText(var_401_8.content)

				arg_398_1.text_.text = var_401_9

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_10 = 22
				local var_401_11 = utf8.len(var_401_9)
				local var_401_12 = var_401_10 <= 0 and var_401_7 or var_401_7 * (var_401_11 / var_401_10)

				if var_401_12 > 0 and var_401_7 < var_401_12 then
					arg_398_1.talkMaxDuration = var_401_12

					if var_401_12 + var_401_6 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_12 + var_401_6
					end
				end

				arg_398_1.text_.text = var_401_9
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_13 = math.max(var_401_7, arg_398_1.talkMaxDuration)

			if var_401_6 <= arg_398_1.time_ and arg_398_1.time_ < var_401_6 + var_401_13 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_6) / var_401_13

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_6 + var_401_13 and arg_398_1.time_ < var_401_6 + var_401_13 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play1107506097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 1107506097
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play1107506098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 0.55

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_2 = arg_402_1:FormatText(StoryNameCfg[7].name)

				arg_402_1.leftNameTxt_.text = var_405_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:GetWordFromCfg(1107506097)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 22
				local var_405_6 = utf8.len(var_405_4)
				local var_405_7 = var_405_5 <= 0 and var_405_1 or var_405_1 * (var_405_6 / var_405_5)

				if var_405_7 > 0 and var_405_1 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_8 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_8 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_8

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_8 and arg_402_1.time_ < var_405_0 + var_405_8 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play1107506098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 1107506098
		arg_406_1.duration_ = 9

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play1107506099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 2

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				local var_409_1 = manager.ui.mainCamera.transform.localPosition
				local var_409_2 = Vector3.New(0, 0, 10) + Vector3.New(var_409_1.x, var_409_1.y, 0)
				local var_409_3 = arg_406_1.bgs_.ST37a

				var_409_3.transform.localPosition = var_409_2
				var_409_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_409_4 = var_409_3:GetComponent("SpriteRenderer")

				if var_409_4 and var_409_4.sprite then
					local var_409_5 = (var_409_3.transform.localPosition - var_409_1).z
					local var_409_6 = manager.ui.mainCameraCom_
					local var_409_7 = 2 * var_409_5 * Mathf.Tan(var_409_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_409_8 = var_409_7 * var_409_6.aspect
					local var_409_9 = var_409_4.sprite.bounds.size.x
					local var_409_10 = var_409_4.sprite.bounds.size.y
					local var_409_11 = var_409_8 / var_409_9
					local var_409_12 = var_409_7 / var_409_10
					local var_409_13 = var_409_12 < var_409_11 and var_409_11 or var_409_12

					var_409_3.transform.localScale = Vector3.New(var_409_13, var_409_13, 0)
				end

				for iter_409_0, iter_409_1 in pairs(arg_406_1.bgs_) do
					if iter_409_0 ~= "ST37a" then
						iter_409_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_409_14 = 3.999999999999

			if var_409_14 < arg_406_1.time_ and arg_406_1.time_ <= var_409_14 + arg_409_0 then
				arg_406_1.allBtn_.enabled = false
			end

			local var_409_15 = 0.3

			if arg_406_1.time_ >= var_409_14 + var_409_15 and arg_406_1.time_ < var_409_14 + var_409_15 + arg_409_0 then
				arg_406_1.allBtn_.enabled = true
			end

			local var_409_16 = 0

			if var_409_16 < arg_406_1.time_ and arg_406_1.time_ <= var_409_16 + arg_409_0 then
				arg_406_1.mask_.enabled = true
				arg_406_1.mask_.raycastTarget = true

				arg_406_1:SetGaussion(false)
			end

			local var_409_17 = 2

			if var_409_16 <= arg_406_1.time_ and arg_406_1.time_ < var_409_16 + var_409_17 then
				local var_409_18 = (arg_406_1.time_ - var_409_16) / var_409_17
				local var_409_19 = Color.New(0, 0, 0)

				var_409_19.a = Mathf.Lerp(0, 1, var_409_18)
				arg_406_1.mask_.color = var_409_19
			end

			if arg_406_1.time_ >= var_409_16 + var_409_17 and arg_406_1.time_ < var_409_16 + var_409_17 + arg_409_0 then
				local var_409_20 = Color.New(0, 0, 0)

				var_409_20.a = 1
				arg_406_1.mask_.color = var_409_20
			end

			local var_409_21 = 2

			if var_409_21 < arg_406_1.time_ and arg_406_1.time_ <= var_409_21 + arg_409_0 then
				arg_406_1.mask_.enabled = true
				arg_406_1.mask_.raycastTarget = true

				arg_406_1:SetGaussion(false)
			end

			local var_409_22 = 2

			if var_409_21 <= arg_406_1.time_ and arg_406_1.time_ < var_409_21 + var_409_22 then
				local var_409_23 = (arg_406_1.time_ - var_409_21) / var_409_22
				local var_409_24 = Color.New(0, 0, 0)

				var_409_24.a = Mathf.Lerp(1, 0, var_409_23)
				arg_406_1.mask_.color = var_409_24
			end

			if arg_406_1.time_ >= var_409_21 + var_409_22 and arg_406_1.time_ < var_409_21 + var_409_22 + arg_409_0 then
				local var_409_25 = Color.New(0, 0, 0)
				local var_409_26 = 0

				arg_406_1.mask_.enabled = false
				var_409_25.a = var_409_26
				arg_406_1.mask_.color = var_409_25
			end

			local var_409_27 = arg_406_1.actors_["1075ui_actor"].transform
			local var_409_28 = 1.96599999815226

			if var_409_28 < arg_406_1.time_ and arg_406_1.time_ <= var_409_28 + arg_409_0 then
				arg_406_1.var_.moveOldPos1075ui_actor = var_409_27.localPosition

				local var_409_29 = GameObjectTools.GetOrAddComponent(var_409_27.gameObject, typeof(DynamicBoneHelper))

				if var_409_29 then
					var_409_29:EnableDynamicBone(false)
				end
			end

			local var_409_30 = 0.001

			if var_409_28 <= arg_406_1.time_ and arg_406_1.time_ < var_409_28 + var_409_30 then
				local var_409_31 = (arg_406_1.time_ - var_409_28) / var_409_30
				local var_409_32 = Vector3.New(0, 100, 0)

				var_409_27.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1075ui_actor, var_409_32, var_409_31)

				local var_409_33 = manager.ui.mainCamera.transform.position - var_409_27.position

				var_409_27.forward = Vector3.New(var_409_33.x, var_409_33.y, var_409_33.z)

				local var_409_34 = var_409_27.localEulerAngles

				var_409_34.z = 0
				var_409_34.x = 0
				var_409_27.localEulerAngles = var_409_34
			end

			if arg_406_1.time_ >= var_409_28 + var_409_30 and arg_406_1.time_ < var_409_28 + var_409_30 + arg_409_0 then
				var_409_27.localPosition = Vector3.New(0, 100, 0)

				local var_409_35 = manager.ui.mainCamera.transform.position - var_409_27.position

				var_409_27.forward = Vector3.New(var_409_35.x, var_409_35.y, var_409_35.z)

				local var_409_36 = var_409_27.localEulerAngles

				var_409_36.z = 0
				var_409_36.x = 0
				var_409_27.localEulerAngles = var_409_36

				local var_409_37 = GameObjectTools.GetOrAddComponent(var_409_27.gameObject, typeof(DynamicBoneHelper))

				if var_409_37 then
					var_409_37:EnableDynamicBone(true)
				end
			end

			if arg_406_1.frameCnt_ <= 1 then
				arg_406_1.dialog_:SetActive(false)
			end

			local var_409_38 = 4
			local var_409_39 = 0.6

			if var_409_38 < arg_406_1.time_ and arg_406_1.time_ <= var_409_38 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0

				arg_406_1.dialog_:SetActive(true)

				arg_406_1.dialogCg_.alpha = 0

				local var_409_40 = LeanTween.value(arg_406_1.dialog_, 0, 1, 0.3)

				var_409_40:setOnUpdate(LuaHelper.FloatAction(function(arg_410_0)
					arg_406_1.dialogCg_.alpha = arg_410_0
				end))
				var_409_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_406_1.dialog_)
					var_409_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_406_1.duration_ = arg_406_1.duration_ + 0.3

				SetActive(arg_406_1.leftNameGo_, false)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_41 = arg_406_1:GetWordFromCfg(1107506098)
				local var_409_42 = arg_406_1:FormatText(var_409_41.content)

				arg_406_1.text_.text = var_409_42

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_43 = 24
				local var_409_44 = utf8.len(var_409_42)
				local var_409_45 = var_409_43 <= 0 and var_409_39 or var_409_39 * (var_409_44 / var_409_43)

				if var_409_45 > 0 and var_409_39 < var_409_45 then
					arg_406_1.talkMaxDuration = var_409_45
					var_409_38 = var_409_38 + 0.3

					if var_409_45 + var_409_38 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_45 + var_409_38
					end
				end

				arg_406_1.text_.text = var_409_42
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)
				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_46 = var_409_38 + 0.3
			local var_409_47 = math.max(var_409_39, arg_406_1.talkMaxDuration)

			if var_409_46 <= arg_406_1.time_ and arg_406_1.time_ < var_409_46 + var_409_47 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_46) / var_409_47

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_46 + var_409_47 and arg_406_1.time_ < var_409_46 + var_409_47 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play1107506099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1107506099
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1107506100(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 1.075

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_2 = arg_412_1:GetWordFromCfg(1107506099)
				local var_415_3 = arg_412_1:FormatText(var_415_2.content)

				arg_412_1.text_.text = var_415_3

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_4 = 43
				local var_415_5 = utf8.len(var_415_3)
				local var_415_6 = var_415_4 <= 0 and var_415_1 or var_415_1 * (var_415_5 / var_415_4)

				if var_415_6 > 0 and var_415_1 < var_415_6 then
					arg_412_1.talkMaxDuration = var_415_6

					if var_415_6 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_6 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_3
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_7 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_7 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_7

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_7 and arg_412_1.time_ < var_415_0 + var_415_7 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1107506100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1107506100
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1107506101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0
			local var_419_1 = 0.6

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_2 = arg_416_1:FormatText(StoryNameCfg[7].name)

				arg_416_1.leftNameTxt_.text = var_419_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_3 = arg_416_1:GetWordFromCfg(1107506100)
				local var_419_4 = arg_416_1:FormatText(var_419_3.content)

				arg_416_1.text_.text = var_419_4

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_5 = 24
				local var_419_6 = utf8.len(var_419_4)
				local var_419_7 = var_419_5 <= 0 and var_419_1 or var_419_1 * (var_419_6 / var_419_5)

				if var_419_7 > 0 and var_419_1 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_0
					end
				end

				arg_416_1.text_.text = var_419_4
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_8 = math.max(var_419_1, arg_416_1.talkMaxDuration)

			if var_419_0 <= arg_416_1.time_ and arg_416_1.time_ < var_419_0 + var_419_8 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_0) / var_419_8

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_0 + var_419_8 and arg_416_1.time_ < var_419_0 + var_419_8 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1107506101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1107506101
		arg_420_1.duration_ = 7.33

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1107506102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1075ui_actor"].transform
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 then
				arg_420_1.var_.moveOldPos1075ui_actor = var_423_0.localPosition

				local var_423_2 = GameObjectTools.GetOrAddComponent(var_423_0.gameObject, typeof(DynamicBoneHelper))

				if var_423_2 then
					var_423_2:EnableDynamicBone(false)
				end
			end

			local var_423_3 = 0.001

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_3 then
				local var_423_4 = (arg_420_1.time_ - var_423_1) / var_423_3
				local var_423_5 = Vector3.New(0, -1.055, -6.16)

				var_423_0.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1075ui_actor, var_423_5, var_423_4)

				local var_423_6 = manager.ui.mainCamera.transform.position - var_423_0.position

				var_423_0.forward = Vector3.New(var_423_6.x, var_423_6.y, var_423_6.z)

				local var_423_7 = var_423_0.localEulerAngles

				var_423_7.z = 0
				var_423_7.x = 0
				var_423_0.localEulerAngles = var_423_7
			end

			if arg_420_1.time_ >= var_423_1 + var_423_3 and arg_420_1.time_ < var_423_1 + var_423_3 + arg_423_0 then
				var_423_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_423_8 = manager.ui.mainCamera.transform.position - var_423_0.position

				var_423_0.forward = Vector3.New(var_423_8.x, var_423_8.y, var_423_8.z)

				local var_423_9 = var_423_0.localEulerAngles

				var_423_9.z = 0
				var_423_9.x = 0
				var_423_0.localEulerAngles = var_423_9

				local var_423_10 = GameObjectTools.GetOrAddComponent(var_423_0.gameObject, typeof(DynamicBoneHelper))

				if var_423_10 then
					var_423_10:EnableDynamicBone(true)
				end
			end

			local var_423_11 = arg_420_1.actors_["1075ui_actor"]
			local var_423_12 = 0

			if var_423_12 < arg_420_1.time_ and arg_420_1.time_ <= var_423_12 + arg_423_0 and not isNil(var_423_11) and arg_420_1.var_.characterEffect1075ui_actor == nil then
				arg_420_1.var_.characterEffect1075ui_actor = var_423_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_13 = 0.200000002980232

			if var_423_12 <= arg_420_1.time_ and arg_420_1.time_ < var_423_12 + var_423_13 and not isNil(var_423_11) then
				local var_423_14 = (arg_420_1.time_ - var_423_12) / var_423_13

				if arg_420_1.var_.characterEffect1075ui_actor and not isNil(var_423_11) then
					arg_420_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_420_1.time_ >= var_423_12 + var_423_13 and arg_420_1.time_ < var_423_12 + var_423_13 + arg_423_0 and not isNil(var_423_11) and arg_420_1.var_.characterEffect1075ui_actor then
				arg_420_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_423_15 = 0

			if var_423_15 < arg_420_1.time_ and arg_420_1.time_ <= var_423_15 + arg_423_0 then
				arg_420_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_423_16 = 0

			if var_423_16 < arg_420_1.time_ and arg_420_1.time_ <= var_423_16 + arg_423_0 then
				arg_420_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_423_17 = 0
			local var_423_18 = 0.875

			if var_423_17 < arg_420_1.time_ and arg_420_1.time_ <= var_423_17 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_19 = arg_420_1:FormatText(StoryNameCfg[381].name)

				arg_420_1.leftNameTxt_.text = var_423_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_20 = arg_420_1:GetWordFromCfg(1107506101)
				local var_423_21 = arg_420_1:FormatText(var_423_20.content)

				arg_420_1.text_.text = var_423_21

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_22 = 35
				local var_423_23 = utf8.len(var_423_21)
				local var_423_24 = var_423_22 <= 0 and var_423_18 or var_423_18 * (var_423_23 / var_423_22)

				if var_423_24 > 0 and var_423_18 < var_423_24 then
					arg_420_1.talkMaxDuration = var_423_24

					if var_423_24 + var_423_17 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_24 + var_423_17
					end
				end

				arg_420_1.text_.text = var_423_21
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506101", "story_v_side_new_1107506.awb") ~= 0 then
					local var_423_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506101", "story_v_side_new_1107506.awb") / 1000

					if var_423_25 + var_423_17 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_25 + var_423_17
					end

					if var_423_20.prefab_name ~= "" and arg_420_1.actors_[var_423_20.prefab_name] ~= nil then
						local var_423_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_20.prefab_name].transform, "story_v_side_new_1107506", "1107506101", "story_v_side_new_1107506.awb")

						arg_420_1:RecordAudio("1107506101", var_423_26)
						arg_420_1:RecordAudio("1107506101", var_423_26)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506101", "story_v_side_new_1107506.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506101", "story_v_side_new_1107506.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_27 = math.max(var_423_18, arg_420_1.talkMaxDuration)

			if var_423_17 <= arg_420_1.time_ and arg_420_1.time_ < var_423_17 + var_423_27 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_17) / var_423_27

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_17 + var_423_27 and arg_420_1.time_ < var_423_17 + var_423_27 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play1107506102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1107506102
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1107506103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["1075ui_actor"]
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect1075ui_actor == nil then
				arg_424_1.var_.characterEffect1075ui_actor = var_427_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 and not isNil(var_427_0) then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2

				if arg_424_1.var_.characterEffect1075ui_actor and not isNil(var_427_0) then
					local var_427_4 = Mathf.Lerp(0, 0.5, var_427_3)

					arg_424_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_424_1.var_.characterEffect1075ui_actor.fillRatio = var_427_4
				end
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 and not isNil(var_427_0) and arg_424_1.var_.characterEffect1075ui_actor then
				local var_427_5 = 0.5

				arg_424_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_424_1.var_.characterEffect1075ui_actor.fillRatio = var_427_5
			end

			local var_427_6 = 0
			local var_427_7 = 0.75

			if var_427_6 < arg_424_1.time_ and arg_424_1.time_ <= var_427_6 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_8 = arg_424_1:FormatText(StoryNameCfg[7].name)

				arg_424_1.leftNameTxt_.text = var_427_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_9 = arg_424_1:GetWordFromCfg(1107506102)
				local var_427_10 = arg_424_1:FormatText(var_427_9.content)

				arg_424_1.text_.text = var_427_10

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_11 = 30
				local var_427_12 = utf8.len(var_427_10)
				local var_427_13 = var_427_11 <= 0 and var_427_7 or var_427_7 * (var_427_12 / var_427_11)

				if var_427_13 > 0 and var_427_7 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_6
					end
				end

				arg_424_1.text_.text = var_427_10
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_14 = math.max(var_427_7, arg_424_1.talkMaxDuration)

			if var_427_6 <= arg_424_1.time_ and arg_424_1.time_ < var_427_6 + var_427_14 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_6) / var_427_14

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_6 + var_427_14 and arg_424_1.time_ < var_427_6 + var_427_14 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play1107506103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1107506103
		arg_428_1.duration_ = 7.53

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1107506104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["1075ui_actor"]
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect1075ui_actor == nil then
				arg_428_1.var_.characterEffect1075ui_actor = var_431_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.200000002980232

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 and not isNil(var_431_0) then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2

				if arg_428_1.var_.characterEffect1075ui_actor and not isNil(var_431_0) then
					arg_428_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect1075ui_actor then
				arg_428_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_431_4 = 0

			if var_431_4 < arg_428_1.time_ and arg_428_1.time_ <= var_431_4 + arg_431_0 then
				arg_428_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_431_5 = 0

			if var_431_5 < arg_428_1.time_ and arg_428_1.time_ <= var_431_5 + arg_431_0 then
				arg_428_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_431_6 = 0
			local var_431_7 = 0.8

			if var_431_6 < arg_428_1.time_ and arg_428_1.time_ <= var_431_6 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_8 = arg_428_1:FormatText(StoryNameCfg[381].name)

				arg_428_1.leftNameTxt_.text = var_431_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_9 = arg_428_1:GetWordFromCfg(1107506103)
				local var_431_10 = arg_428_1:FormatText(var_431_9.content)

				arg_428_1.text_.text = var_431_10

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_11 = 32
				local var_431_12 = utf8.len(var_431_10)
				local var_431_13 = var_431_11 <= 0 and var_431_7 or var_431_7 * (var_431_12 / var_431_11)

				if var_431_13 > 0 and var_431_7 < var_431_13 then
					arg_428_1.talkMaxDuration = var_431_13

					if var_431_13 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_13 + var_431_6
					end
				end

				arg_428_1.text_.text = var_431_10
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506103", "story_v_side_new_1107506.awb") ~= 0 then
					local var_431_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506103", "story_v_side_new_1107506.awb") / 1000

					if var_431_14 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_14 + var_431_6
					end

					if var_431_9.prefab_name ~= "" and arg_428_1.actors_[var_431_9.prefab_name] ~= nil then
						local var_431_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_9.prefab_name].transform, "story_v_side_new_1107506", "1107506103", "story_v_side_new_1107506.awb")

						arg_428_1:RecordAudio("1107506103", var_431_15)
						arg_428_1:RecordAudio("1107506103", var_431_15)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506103", "story_v_side_new_1107506.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506103", "story_v_side_new_1107506.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_16 = math.max(var_431_7, arg_428_1.talkMaxDuration)

			if var_431_6 <= arg_428_1.time_ and arg_428_1.time_ < var_431_6 + var_431_16 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_6) / var_431_16

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_6 + var_431_16 and arg_428_1.time_ < var_431_6 + var_431_16 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play1107506104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1107506104
		arg_432_1.duration_ = 1

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"

			SetActive(arg_432_1.choicesGo_, true)

			for iter_433_0, iter_433_1 in ipairs(arg_432_1.choices_) do
				local var_433_0 = iter_433_0 <= 1

				SetActive(iter_433_1.go, var_433_0)
			end

			arg_432_1.choices_[1].txt.text = arg_432_1:FormatText(StoryChoiceCfg[1170].name)
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1107506105(arg_432_1)
			end

			arg_432_1:RecordChoiceLog(1107506104, 1170)
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["1075ui_actor"]
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect1075ui_actor == nil then
				arg_432_1.var_.characterEffect1075ui_actor = var_435_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_2 = 0.200000002980232

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 and not isNil(var_435_0) then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2

				if arg_432_1.var_.characterEffect1075ui_actor and not isNil(var_435_0) then
					local var_435_4 = Mathf.Lerp(0, 0.5, var_435_3)

					arg_432_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_432_1.var_.characterEffect1075ui_actor.fillRatio = var_435_4
				end
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 and not isNil(var_435_0) and arg_432_1.var_.characterEffect1075ui_actor then
				local var_435_5 = 0.5

				arg_432_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_432_1.var_.characterEffect1075ui_actor.fillRatio = var_435_5
			end

			local var_435_6 = 0

			if var_435_6 < arg_432_1.time_ and arg_432_1.time_ <= var_435_6 + arg_435_0 then
				arg_432_1.allBtn_.enabled = false
			end

			local var_435_7 = 0.5

			if arg_432_1.time_ >= var_435_6 + var_435_7 and arg_432_1.time_ < var_435_6 + var_435_7 + arg_435_0 then
				arg_432_1.allBtn_.enabled = true
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1107506105 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1107506105
		arg_436_1.duration_ = 2

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1107506106(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["1075ui_actor"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect1075ui_actor == nil then
				arg_436_1.var_.characterEffect1075ui_actor = var_439_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.characterEffect1075ui_actor and not isNil(var_439_0) then
					arg_436_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect1075ui_actor then
				arg_436_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_439_4 = 0

			if var_439_4 < arg_436_1.time_ and arg_436_1.time_ <= var_439_4 + arg_439_0 then
				arg_436_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action424")
			end

			local var_439_5 = 0

			if var_439_5 < arg_436_1.time_ and arg_436_1.time_ <= var_439_5 + arg_439_0 then
				arg_436_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_439_6 = 0
			local var_439_7 = 0.125

			if var_439_6 < arg_436_1.time_ and arg_436_1.time_ <= var_439_6 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_8 = arg_436_1:FormatText(StoryNameCfg[381].name)

				arg_436_1.leftNameTxt_.text = var_439_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_9 = arg_436_1:GetWordFromCfg(1107506105)
				local var_439_10 = arg_436_1:FormatText(var_439_9.content)

				arg_436_1.text_.text = var_439_10

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_11 = 5
				local var_439_12 = utf8.len(var_439_10)
				local var_439_13 = var_439_11 <= 0 and var_439_7 or var_439_7 * (var_439_12 / var_439_11)

				if var_439_13 > 0 and var_439_7 < var_439_13 then
					arg_436_1.talkMaxDuration = var_439_13

					if var_439_13 + var_439_6 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_13 + var_439_6
					end
				end

				arg_436_1.text_.text = var_439_10
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506105", "story_v_side_new_1107506.awb") ~= 0 then
					local var_439_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506105", "story_v_side_new_1107506.awb") / 1000

					if var_439_14 + var_439_6 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_14 + var_439_6
					end

					if var_439_9.prefab_name ~= "" and arg_436_1.actors_[var_439_9.prefab_name] ~= nil then
						local var_439_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_9.prefab_name].transform, "story_v_side_new_1107506", "1107506105", "story_v_side_new_1107506.awb")

						arg_436_1:RecordAudio("1107506105", var_439_15)
						arg_436_1:RecordAudio("1107506105", var_439_15)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506105", "story_v_side_new_1107506.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506105", "story_v_side_new_1107506.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_16 = math.max(var_439_7, arg_436_1.talkMaxDuration)

			if var_439_6 <= arg_436_1.time_ and arg_436_1.time_ < var_439_6 + var_439_16 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_6) / var_439_16

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_6 + var_439_16 and arg_436_1.time_ < var_439_6 + var_439_16 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1107506106 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1107506106
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1107506107(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["1075ui_actor"].transform
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.var_.moveOldPos1075ui_actor = var_443_0.localPosition

				local var_443_2 = GameObjectTools.GetOrAddComponent(var_443_0.gameObject, typeof(DynamicBoneHelper))

				if var_443_2 then
					var_443_2:EnableDynamicBone(false)
				end
			end

			local var_443_3 = 0.001

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_3 then
				local var_443_4 = (arg_440_1.time_ - var_443_1) / var_443_3
				local var_443_5 = Vector3.New(0, 100, 0)

				var_443_0.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1075ui_actor, var_443_5, var_443_4)

				local var_443_6 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_6.x, var_443_6.y, var_443_6.z)

				local var_443_7 = var_443_0.localEulerAngles

				var_443_7.z = 0
				var_443_7.x = 0
				var_443_0.localEulerAngles = var_443_7
			end

			if arg_440_1.time_ >= var_443_1 + var_443_3 and arg_440_1.time_ < var_443_1 + var_443_3 + arg_443_0 then
				var_443_0.localPosition = Vector3.New(0, 100, 0)

				local var_443_8 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_8.x, var_443_8.y, var_443_8.z)

				local var_443_9 = var_443_0.localEulerAngles

				var_443_9.z = 0
				var_443_9.x = 0
				var_443_0.localEulerAngles = var_443_9

				local var_443_10 = GameObjectTools.GetOrAddComponent(var_443_0.gameObject, typeof(DynamicBoneHelper))

				if var_443_10 then
					var_443_10:EnableDynamicBone(true)
				end
			end

			local var_443_11 = arg_440_1.actors_["1075ui_actor"]
			local var_443_12 = 0

			if var_443_12 < arg_440_1.time_ and arg_440_1.time_ <= var_443_12 + arg_443_0 and not isNil(var_443_11) and arg_440_1.var_.characterEffect1075ui_actor == nil then
				arg_440_1.var_.characterEffect1075ui_actor = var_443_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_13 = 0.200000002980232

			if var_443_12 <= arg_440_1.time_ and arg_440_1.time_ < var_443_12 + var_443_13 and not isNil(var_443_11) then
				local var_443_14 = (arg_440_1.time_ - var_443_12) / var_443_13

				if arg_440_1.var_.characterEffect1075ui_actor and not isNil(var_443_11) then
					local var_443_15 = Mathf.Lerp(0, 0.5, var_443_14)

					arg_440_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_440_1.var_.characterEffect1075ui_actor.fillRatio = var_443_15
				end
			end

			if arg_440_1.time_ >= var_443_12 + var_443_13 and arg_440_1.time_ < var_443_12 + var_443_13 + arg_443_0 and not isNil(var_443_11) and arg_440_1.var_.characterEffect1075ui_actor then
				local var_443_16 = 0.5

				arg_440_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_440_1.var_.characterEffect1075ui_actor.fillRatio = var_443_16
			end

			local var_443_17 = 0
			local var_443_18 = 0.85

			if var_443_17 < arg_440_1.time_ and arg_440_1.time_ <= var_443_17 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, false)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_19 = arg_440_1:GetWordFromCfg(1107506106)
				local var_443_20 = arg_440_1:FormatText(var_443_19.content)

				arg_440_1.text_.text = var_443_20

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_21 = 34
				local var_443_22 = utf8.len(var_443_20)
				local var_443_23 = var_443_21 <= 0 and var_443_18 or var_443_18 * (var_443_22 / var_443_21)

				if var_443_23 > 0 and var_443_18 < var_443_23 then
					arg_440_1.talkMaxDuration = var_443_23

					if var_443_23 + var_443_17 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_23 + var_443_17
					end
				end

				arg_440_1.text_.text = var_443_20
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_24 = math.max(var_443_18, arg_440_1.talkMaxDuration)

			if var_443_17 <= arg_440_1.time_ and arg_440_1.time_ < var_443_17 + var_443_24 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_17) / var_443_24

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_17 + var_443_24 and arg_440_1.time_ < var_443_17 + var_443_24 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_440_1:InitPlayNodeList()
	end,
	Play1107506107 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1107506107
		arg_444_1.duration_ = 4.5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1107506108(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1075ui_actor"].transform
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.var_.moveOldPos1075ui_actor = var_447_0.localPosition

				local var_447_2 = GameObjectTools.GetOrAddComponent(var_447_0.gameObject, typeof(DynamicBoneHelper))

				if var_447_2 then
					var_447_2:EnableDynamicBone(false)
				end
			end

			local var_447_3 = 0.001

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_3 then
				local var_447_4 = (arg_444_1.time_ - var_447_1) / var_447_3
				local var_447_5 = Vector3.New(0, -1.055, -6.16)

				var_447_0.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1075ui_actor, var_447_5, var_447_4)

				local var_447_6 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_6.x, var_447_6.y, var_447_6.z)

				local var_447_7 = var_447_0.localEulerAngles

				var_447_7.z = 0
				var_447_7.x = 0
				var_447_0.localEulerAngles = var_447_7
			end

			if arg_444_1.time_ >= var_447_1 + var_447_3 and arg_444_1.time_ < var_447_1 + var_447_3 + arg_447_0 then
				var_447_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_447_8 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_8.x, var_447_8.y, var_447_8.z)

				local var_447_9 = var_447_0.localEulerAngles

				var_447_9.z = 0
				var_447_9.x = 0
				var_447_0.localEulerAngles = var_447_9

				local var_447_10 = GameObjectTools.GetOrAddComponent(var_447_0.gameObject, typeof(DynamicBoneHelper))

				if var_447_10 then
					var_447_10:EnableDynamicBone(true)
				end
			end

			local var_447_11 = arg_444_1.actors_["1075ui_actor"]
			local var_447_12 = 0

			if var_447_12 < arg_444_1.time_ and arg_444_1.time_ <= var_447_12 + arg_447_0 and not isNil(var_447_11) and arg_444_1.var_.characterEffect1075ui_actor == nil then
				arg_444_1.var_.characterEffect1075ui_actor = var_447_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_13 = 0.200000002980232

			if var_447_12 <= arg_444_1.time_ and arg_444_1.time_ < var_447_12 + var_447_13 and not isNil(var_447_11) then
				local var_447_14 = (arg_444_1.time_ - var_447_12) / var_447_13

				if arg_444_1.var_.characterEffect1075ui_actor and not isNil(var_447_11) then
					arg_444_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_444_1.time_ >= var_447_12 + var_447_13 and arg_444_1.time_ < var_447_12 + var_447_13 + arg_447_0 and not isNil(var_447_11) and arg_444_1.var_.characterEffect1075ui_actor then
				arg_444_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_447_15 = 0

			if var_447_15 < arg_444_1.time_ and arg_444_1.time_ <= var_447_15 + arg_447_0 then
				arg_444_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075actionlink/1075action443")
			end

			local var_447_16 = 0

			if var_447_16 < arg_444_1.time_ and arg_444_1.time_ <= var_447_16 + arg_447_0 then
				arg_444_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_447_17 = 0
			local var_447_18 = 0.45

			if var_447_17 < arg_444_1.time_ and arg_444_1.time_ <= var_447_17 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_19 = arg_444_1:FormatText(StoryNameCfg[381].name)

				arg_444_1.leftNameTxt_.text = var_447_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_20 = arg_444_1:GetWordFromCfg(1107506107)
				local var_447_21 = arg_444_1:FormatText(var_447_20.content)

				arg_444_1.text_.text = var_447_21

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_22 = 18
				local var_447_23 = utf8.len(var_447_21)
				local var_447_24 = var_447_22 <= 0 and var_447_18 or var_447_18 * (var_447_23 / var_447_22)

				if var_447_24 > 0 and var_447_18 < var_447_24 then
					arg_444_1.talkMaxDuration = var_447_24

					if var_447_24 + var_447_17 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_24 + var_447_17
					end
				end

				arg_444_1.text_.text = var_447_21
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506107", "story_v_side_new_1107506.awb") ~= 0 then
					local var_447_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506107", "story_v_side_new_1107506.awb") / 1000

					if var_447_25 + var_447_17 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_25 + var_447_17
					end

					if var_447_20.prefab_name ~= "" and arg_444_1.actors_[var_447_20.prefab_name] ~= nil then
						local var_447_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_20.prefab_name].transform, "story_v_side_new_1107506", "1107506107", "story_v_side_new_1107506.awb")

						arg_444_1:RecordAudio("1107506107", var_447_26)
						arg_444_1:RecordAudio("1107506107", var_447_26)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506107", "story_v_side_new_1107506.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506107", "story_v_side_new_1107506.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_27 = math.max(var_447_18, arg_444_1.talkMaxDuration)

			if var_447_17 <= arg_444_1.time_ and arg_444_1.time_ < var_447_17 + var_447_27 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_17) / var_447_27

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_17 + var_447_27 and arg_444_1.time_ < var_447_17 + var_447_27 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_444_1:InitPlayNodeList()
	end,
	Play1107506108 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1107506108
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1107506109(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["1075ui_actor"]
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1075ui_actor == nil then
				arg_448_1.var_.characterEffect1075ui_actor = var_451_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 and not isNil(var_451_0) then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2

				if arg_448_1.var_.characterEffect1075ui_actor and not isNil(var_451_0) then
					local var_451_4 = Mathf.Lerp(0, 0.5, var_451_3)

					arg_448_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_448_1.var_.characterEffect1075ui_actor.fillRatio = var_451_4
				end
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 and not isNil(var_451_0) and arg_448_1.var_.characterEffect1075ui_actor then
				local var_451_5 = 0.5

				arg_448_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_448_1.var_.characterEffect1075ui_actor.fillRatio = var_451_5
			end

			local var_451_6 = 0
			local var_451_7 = 0.325

			if var_451_6 < arg_448_1.time_ and arg_448_1.time_ <= var_451_6 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_8 = arg_448_1:FormatText(StoryNameCfg[7].name)

				arg_448_1.leftNameTxt_.text = var_451_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_9 = arg_448_1:GetWordFromCfg(1107506108)
				local var_451_10 = arg_448_1:FormatText(var_451_9.content)

				arg_448_1.text_.text = var_451_10

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_11 = 13
				local var_451_12 = utf8.len(var_451_10)
				local var_451_13 = var_451_11 <= 0 and var_451_7 or var_451_7 * (var_451_12 / var_451_11)

				if var_451_13 > 0 and var_451_7 < var_451_13 then
					arg_448_1.talkMaxDuration = var_451_13

					if var_451_13 + var_451_6 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_13 + var_451_6
					end
				end

				arg_448_1.text_.text = var_451_10
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_14 = math.max(var_451_7, arg_448_1.talkMaxDuration)

			if var_451_6 <= arg_448_1.time_ and arg_448_1.time_ < var_451_6 + var_451_14 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_6) / var_451_14

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_6 + var_451_14 and arg_448_1.time_ < var_451_6 + var_451_14 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play1107506109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1107506109
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1107506110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["1075ui_actor"].transform
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.var_.moveOldPos1075ui_actor = var_455_0.localPosition

				local var_455_2 = GameObjectTools.GetOrAddComponent(var_455_0.gameObject, typeof(DynamicBoneHelper))

				if var_455_2 then
					var_455_2:EnableDynamicBone(false)
				end
			end

			local var_455_3 = 0.001

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_3 then
				local var_455_4 = (arg_452_1.time_ - var_455_1) / var_455_3
				local var_455_5 = Vector3.New(0, 100, 0)

				var_455_0.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1075ui_actor, var_455_5, var_455_4)

				local var_455_6 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_6.x, var_455_6.y, var_455_6.z)

				local var_455_7 = var_455_0.localEulerAngles

				var_455_7.z = 0
				var_455_7.x = 0
				var_455_0.localEulerAngles = var_455_7
			end

			if arg_452_1.time_ >= var_455_1 + var_455_3 and arg_452_1.time_ < var_455_1 + var_455_3 + arg_455_0 then
				var_455_0.localPosition = Vector3.New(0, 100, 0)

				local var_455_8 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_8.x, var_455_8.y, var_455_8.z)

				local var_455_9 = var_455_0.localEulerAngles

				var_455_9.z = 0
				var_455_9.x = 0
				var_455_0.localEulerAngles = var_455_9

				local var_455_10 = GameObjectTools.GetOrAddComponent(var_455_0.gameObject, typeof(DynamicBoneHelper))

				if var_455_10 then
					var_455_10:EnableDynamicBone(true)
				end
			end

			local var_455_11 = 0
			local var_455_12 = 0.6

			if var_455_11 < arg_452_1.time_ and arg_452_1.time_ <= var_455_11 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_13 = arg_452_1:GetWordFromCfg(1107506109)
				local var_455_14 = arg_452_1:FormatText(var_455_13.content)

				arg_452_1.text_.text = var_455_14

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_15 = 24
				local var_455_16 = utf8.len(var_455_14)
				local var_455_17 = var_455_15 <= 0 and var_455_12 or var_455_12 * (var_455_16 / var_455_15)

				if var_455_17 > 0 and var_455_12 < var_455_17 then
					arg_452_1.talkMaxDuration = var_455_17

					if var_455_17 + var_455_11 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_17 + var_455_11
					end
				end

				arg_452_1.text_.text = var_455_14
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_18 = math.max(var_455_12, arg_452_1.talkMaxDuration)

			if var_455_11 <= arg_452_1.time_ and arg_452_1.time_ < var_455_11 + var_455_18 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_11) / var_455_18

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_11 + var_455_18 and arg_452_1.time_ < var_455_11 + var_455_18 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play1107506110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1107506110
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1107506111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0
			local var_459_1 = 0.625

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_2 = arg_456_1:FormatText(StoryNameCfg[7].name)

				arg_456_1.leftNameTxt_.text = var_459_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, true)
				arg_456_1.iconController_:SetSelectedState("hero")

				arg_456_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_456_1.callingController_:SetSelectedState("normal")

				arg_456_1.keyicon_.color = Color.New(1, 1, 1)
				arg_456_1.icon_.color = Color.New(1, 1, 1)

				local var_459_3 = arg_456_1:GetWordFromCfg(1107506110)
				local var_459_4 = arg_456_1:FormatText(var_459_3.content)

				arg_456_1.text_.text = var_459_4

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 25
				local var_459_6 = utf8.len(var_459_4)
				local var_459_7 = var_459_5 <= 0 and var_459_1 or var_459_1 * (var_459_6 / var_459_5)

				if var_459_7 > 0 and var_459_1 < var_459_7 then
					arg_456_1.talkMaxDuration = var_459_7

					if var_459_7 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_7 + var_459_0
					end
				end

				arg_456_1.text_.text = var_459_4
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_8 = math.max(var_459_1, arg_456_1.talkMaxDuration)

			if var_459_0 <= arg_456_1.time_ and arg_456_1.time_ < var_459_0 + var_459_8 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_0) / var_459_8

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_0 + var_459_8 and arg_456_1.time_ < var_459_0 + var_459_8 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1107506111 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1107506111
		arg_460_1.duration_ = 2.6

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1107506112(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["1075ui_actor"].transform
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 then
				arg_460_1.var_.moveOldPos1075ui_actor = var_463_0.localPosition

				local var_463_2 = GameObjectTools.GetOrAddComponent(var_463_0.gameObject, typeof(DynamicBoneHelper))

				if var_463_2 then
					var_463_2:EnableDynamicBone(false)
				end
			end

			local var_463_3 = 0.001

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_3 then
				local var_463_4 = (arg_460_1.time_ - var_463_1) / var_463_3
				local var_463_5 = Vector3.New(0, -1.055, -6.16)

				var_463_0.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1075ui_actor, var_463_5, var_463_4)

				local var_463_6 = manager.ui.mainCamera.transform.position - var_463_0.position

				var_463_0.forward = Vector3.New(var_463_6.x, var_463_6.y, var_463_6.z)

				local var_463_7 = var_463_0.localEulerAngles

				var_463_7.z = 0
				var_463_7.x = 0
				var_463_0.localEulerAngles = var_463_7
			end

			if arg_460_1.time_ >= var_463_1 + var_463_3 and arg_460_1.time_ < var_463_1 + var_463_3 + arg_463_0 then
				var_463_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_463_8 = manager.ui.mainCamera.transform.position - var_463_0.position

				var_463_0.forward = Vector3.New(var_463_8.x, var_463_8.y, var_463_8.z)

				local var_463_9 = var_463_0.localEulerAngles

				var_463_9.z = 0
				var_463_9.x = 0
				var_463_0.localEulerAngles = var_463_9

				local var_463_10 = GameObjectTools.GetOrAddComponent(var_463_0.gameObject, typeof(DynamicBoneHelper))

				if var_463_10 then
					var_463_10:EnableDynamicBone(true)
				end
			end

			local var_463_11 = arg_460_1.actors_["1075ui_actor"]
			local var_463_12 = 0

			if var_463_12 < arg_460_1.time_ and arg_460_1.time_ <= var_463_12 + arg_463_0 and not isNil(var_463_11) and arg_460_1.var_.characterEffect1075ui_actor == nil then
				arg_460_1.var_.characterEffect1075ui_actor = var_463_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_13 = 0.200000002980232

			if var_463_12 <= arg_460_1.time_ and arg_460_1.time_ < var_463_12 + var_463_13 and not isNil(var_463_11) then
				local var_463_14 = (arg_460_1.time_ - var_463_12) / var_463_13

				if arg_460_1.var_.characterEffect1075ui_actor and not isNil(var_463_11) then
					arg_460_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_460_1.time_ >= var_463_12 + var_463_13 and arg_460_1.time_ < var_463_12 + var_463_13 + arg_463_0 and not isNil(var_463_11) and arg_460_1.var_.characterEffect1075ui_actor then
				arg_460_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_463_15 = 0

			if var_463_15 < arg_460_1.time_ and arg_460_1.time_ <= var_463_15 + arg_463_0 then
				arg_460_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_463_16 = 0

			if var_463_16 < arg_460_1.time_ and arg_460_1.time_ <= var_463_16 + arg_463_0 then
				arg_460_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_463_17 = 0
			local var_463_18 = 0.225

			if var_463_17 < arg_460_1.time_ and arg_460_1.time_ <= var_463_17 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_19 = arg_460_1:FormatText(StoryNameCfg[381].name)

				arg_460_1.leftNameTxt_.text = var_463_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_20 = arg_460_1:GetWordFromCfg(1107506111)
				local var_463_21 = arg_460_1:FormatText(var_463_20.content)

				arg_460_1.text_.text = var_463_21

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_22 = 9
				local var_463_23 = utf8.len(var_463_21)
				local var_463_24 = var_463_22 <= 0 and var_463_18 or var_463_18 * (var_463_23 / var_463_22)

				if var_463_24 > 0 and var_463_18 < var_463_24 then
					arg_460_1.talkMaxDuration = var_463_24

					if var_463_24 + var_463_17 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_24 + var_463_17
					end
				end

				arg_460_1.text_.text = var_463_21
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506111", "story_v_side_new_1107506.awb") ~= 0 then
					local var_463_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506111", "story_v_side_new_1107506.awb") / 1000

					if var_463_25 + var_463_17 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_25 + var_463_17
					end

					if var_463_20.prefab_name ~= "" and arg_460_1.actors_[var_463_20.prefab_name] ~= nil then
						local var_463_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_20.prefab_name].transform, "story_v_side_new_1107506", "1107506111", "story_v_side_new_1107506.awb")

						arg_460_1:RecordAudio("1107506111", var_463_26)
						arg_460_1:RecordAudio("1107506111", var_463_26)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506111", "story_v_side_new_1107506.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506111", "story_v_side_new_1107506.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_27 = math.max(var_463_18, arg_460_1.talkMaxDuration)

			if var_463_17 <= arg_460_1.time_ and arg_460_1.time_ < var_463_17 + var_463_27 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_17) / var_463_27

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_17 + var_463_27 and arg_460_1.time_ < var_463_17 + var_463_27 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_460_1:InitPlayNodeList()
	end,
	Play1107506112 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1107506112
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1107506113(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = arg_464_1.actors_["1075ui_actor"]
			local var_467_1 = 0

			if var_467_1 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.characterEffect1075ui_actor == nil then
				arg_464_1.var_.characterEffect1075ui_actor = var_467_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_2 = 0.200000002980232

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_2 and not isNil(var_467_0) then
				local var_467_3 = (arg_464_1.time_ - var_467_1) / var_467_2

				if arg_464_1.var_.characterEffect1075ui_actor and not isNil(var_467_0) then
					local var_467_4 = Mathf.Lerp(0, 0.5, var_467_3)

					arg_464_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_464_1.var_.characterEffect1075ui_actor.fillRatio = var_467_4
				end
			end

			if arg_464_1.time_ >= var_467_1 + var_467_2 and arg_464_1.time_ < var_467_1 + var_467_2 + arg_467_0 and not isNil(var_467_0) and arg_464_1.var_.characterEffect1075ui_actor then
				local var_467_5 = 0.5

				arg_464_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_464_1.var_.characterEffect1075ui_actor.fillRatio = var_467_5
			end

			local var_467_6 = 0
			local var_467_7 = 0.225

			if var_467_6 < arg_464_1.time_ and arg_464_1.time_ <= var_467_6 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_8 = arg_464_1:FormatText(StoryNameCfg[7].name)

				arg_464_1.leftNameTxt_.text = var_467_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_9 = arg_464_1:GetWordFromCfg(1107506112)
				local var_467_10 = arg_464_1:FormatText(var_467_9.content)

				arg_464_1.text_.text = var_467_10

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_11 = 9
				local var_467_12 = utf8.len(var_467_10)
				local var_467_13 = var_467_11 <= 0 and var_467_7 or var_467_7 * (var_467_12 / var_467_11)

				if var_467_13 > 0 and var_467_7 < var_467_13 then
					arg_464_1.talkMaxDuration = var_467_13

					if var_467_13 + var_467_6 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_13 + var_467_6
					end
				end

				arg_464_1.text_.text = var_467_10
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_14 = math.max(var_467_7, arg_464_1.talkMaxDuration)

			if var_467_6 <= arg_464_1.time_ and arg_464_1.time_ < var_467_6 + var_467_14 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_6) / var_467_14

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_6 + var_467_14 and arg_464_1.time_ < var_467_6 + var_467_14 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play1107506113 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1107506113
		arg_468_1.duration_ = 8.6

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1107506114(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = arg_468_1.actors_["1075ui_actor"]
			local var_471_1 = 0

			if var_471_1 < arg_468_1.time_ and arg_468_1.time_ <= var_471_1 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1075ui_actor == nil then
				arg_468_1.var_.characterEffect1075ui_actor = var_471_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if var_471_1 <= arg_468_1.time_ and arg_468_1.time_ < var_471_1 + var_471_2 and not isNil(var_471_0) then
				local var_471_3 = (arg_468_1.time_ - var_471_1) / var_471_2

				if arg_468_1.var_.characterEffect1075ui_actor and not isNil(var_471_0) then
					arg_468_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_468_1.time_ >= var_471_1 + var_471_2 and arg_468_1.time_ < var_471_1 + var_471_2 + arg_471_0 and not isNil(var_471_0) and arg_468_1.var_.characterEffect1075ui_actor then
				arg_468_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_471_4 = 0

			if var_471_4 < arg_468_1.time_ and arg_468_1.time_ <= var_471_4 + arg_471_0 then
				arg_468_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_471_5 = 0
			local var_471_6 = 0.95

			if var_471_5 < arg_468_1.time_ and arg_468_1.time_ <= var_471_5 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				local var_471_7 = arg_468_1:FormatText(StoryNameCfg[381].name)

				arg_468_1.leftNameTxt_.text = var_471_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_8 = arg_468_1:GetWordFromCfg(1107506113)
				local var_471_9 = arg_468_1:FormatText(var_471_8.content)

				arg_468_1.text_.text = var_471_9

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_10 = 38
				local var_471_11 = utf8.len(var_471_9)
				local var_471_12 = var_471_10 <= 0 and var_471_6 or var_471_6 * (var_471_11 / var_471_10)

				if var_471_12 > 0 and var_471_6 < var_471_12 then
					arg_468_1.talkMaxDuration = var_471_12

					if var_471_12 + var_471_5 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_12 + var_471_5
					end
				end

				arg_468_1.text_.text = var_471_9
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506113", "story_v_side_new_1107506.awb") ~= 0 then
					local var_471_13 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506113", "story_v_side_new_1107506.awb") / 1000

					if var_471_13 + var_471_5 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_13 + var_471_5
					end

					if var_471_8.prefab_name ~= "" and arg_468_1.actors_[var_471_8.prefab_name] ~= nil then
						local var_471_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_8.prefab_name].transform, "story_v_side_new_1107506", "1107506113", "story_v_side_new_1107506.awb")

						arg_468_1:RecordAudio("1107506113", var_471_14)
						arg_468_1:RecordAudio("1107506113", var_471_14)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506113", "story_v_side_new_1107506.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506113", "story_v_side_new_1107506.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_15 = math.max(var_471_6, arg_468_1.talkMaxDuration)

			if var_471_5 <= arg_468_1.time_ and arg_468_1.time_ < var_471_5 + var_471_15 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_5) / var_471_15

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_5 + var_471_15 and arg_468_1.time_ < var_471_5 + var_471_15 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play1107506114 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1107506114
		arg_472_1.duration_ = 5.73

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1107506115(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0
			local var_475_1 = 0.575

			if var_475_0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_2 = arg_472_1:FormatText(StoryNameCfg[381].name)

				arg_472_1.leftNameTxt_.text = var_475_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_3 = arg_472_1:GetWordFromCfg(1107506114)
				local var_475_4 = arg_472_1:FormatText(var_475_3.content)

				arg_472_1.text_.text = var_475_4

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_5 = 23
				local var_475_6 = utf8.len(var_475_4)
				local var_475_7 = var_475_5 <= 0 and var_475_1 or var_475_1 * (var_475_6 / var_475_5)

				if var_475_7 > 0 and var_475_1 < var_475_7 then
					arg_472_1.talkMaxDuration = var_475_7

					if var_475_7 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_7 + var_475_0
					end
				end

				arg_472_1.text_.text = var_475_4
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506114", "story_v_side_new_1107506.awb") ~= 0 then
					local var_475_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506114", "story_v_side_new_1107506.awb") / 1000

					if var_475_8 + var_475_0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_8 + var_475_0
					end

					if var_475_3.prefab_name ~= "" and arg_472_1.actors_[var_475_3.prefab_name] ~= nil then
						local var_475_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_3.prefab_name].transform, "story_v_side_new_1107506", "1107506114", "story_v_side_new_1107506.awb")

						arg_472_1:RecordAudio("1107506114", var_475_9)
						arg_472_1:RecordAudio("1107506114", var_475_9)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506114", "story_v_side_new_1107506.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506114", "story_v_side_new_1107506.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_10 = math.max(var_475_1, arg_472_1.talkMaxDuration)

			if var_475_0 <= arg_472_1.time_ and arg_472_1.time_ < var_475_0 + var_475_10 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_0) / var_475_10

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_0 + var_475_10 and arg_472_1.time_ < var_475_0 + var_475_10 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play1107506115 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1107506115
		arg_476_1.duration_ = 5.47

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1107506116(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0

			if var_479_0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_0 + arg_479_0 then
				arg_476_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_479_1 = 0

			if var_479_1 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 then
				arg_476_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_479_2 = 0
			local var_479_3 = 0.6

			if var_479_2 < arg_476_1.time_ and arg_476_1.time_ <= var_479_2 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				local var_479_4 = arg_476_1:FormatText(StoryNameCfg[381].name)

				arg_476_1.leftNameTxt_.text = var_479_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_5 = arg_476_1:GetWordFromCfg(1107506115)
				local var_479_6 = arg_476_1:FormatText(var_479_5.content)

				arg_476_1.text_.text = var_479_6

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_7 = 24
				local var_479_8 = utf8.len(var_479_6)
				local var_479_9 = var_479_7 <= 0 and var_479_3 or var_479_3 * (var_479_8 / var_479_7)

				if var_479_9 > 0 and var_479_3 < var_479_9 then
					arg_476_1.talkMaxDuration = var_479_9

					if var_479_9 + var_479_2 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_9 + var_479_2
					end
				end

				arg_476_1.text_.text = var_479_6
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506115", "story_v_side_new_1107506.awb") ~= 0 then
					local var_479_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506115", "story_v_side_new_1107506.awb") / 1000

					if var_479_10 + var_479_2 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_10 + var_479_2
					end

					if var_479_5.prefab_name ~= "" and arg_476_1.actors_[var_479_5.prefab_name] ~= nil then
						local var_479_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_476_1.actors_[var_479_5.prefab_name].transform, "story_v_side_new_1107506", "1107506115", "story_v_side_new_1107506.awb")

						arg_476_1:RecordAudio("1107506115", var_479_11)
						arg_476_1:RecordAudio("1107506115", var_479_11)
					else
						arg_476_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506115", "story_v_side_new_1107506.awb")
					end

					arg_476_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506115", "story_v_side_new_1107506.awb")
				end

				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_12 = math.max(var_479_3, arg_476_1.talkMaxDuration)

			if var_479_2 <= arg_476_1.time_ and arg_476_1.time_ < var_479_2 + var_479_12 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_2) / var_479_12

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_2 + var_479_12 and arg_476_1.time_ < var_479_2 + var_479_12 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play1107506116 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1107506116
		arg_480_1.duration_ = 1

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"

			SetActive(arg_480_1.choicesGo_, true)

			for iter_481_0, iter_481_1 in ipairs(arg_480_1.choices_) do
				local var_481_0 = iter_481_0 <= 2

				SetActive(iter_481_1.go, var_481_0)
			end

			arg_480_1.choices_[1].txt.text = arg_480_1:FormatText(StoryChoiceCfg[1171].name)
			arg_480_1.choices_[2].txt.text = arg_480_1:FormatText(StoryChoiceCfg[1172].name)
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play1107506117(arg_480_1)
			end

			if arg_482_0 == 2 then
				arg_480_0:Play1107506118(arg_480_1)
			end

			arg_480_1:RecordChoiceLog(1107506116, 1171, 1172)
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			local var_483_0 = arg_480_1.actors_["1075ui_actor"]
			local var_483_1 = 0

			if var_483_1 < arg_480_1.time_ and arg_480_1.time_ <= var_483_1 + arg_483_0 and not isNil(var_483_0) and arg_480_1.var_.characterEffect1075ui_actor == nil then
				arg_480_1.var_.characterEffect1075ui_actor = var_483_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_483_2 = 0.200000002980232

			if var_483_1 <= arg_480_1.time_ and arg_480_1.time_ < var_483_1 + var_483_2 and not isNil(var_483_0) then
				local var_483_3 = (arg_480_1.time_ - var_483_1) / var_483_2

				if arg_480_1.var_.characterEffect1075ui_actor and not isNil(var_483_0) then
					local var_483_4 = Mathf.Lerp(0, 0.5, var_483_3)

					arg_480_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_480_1.var_.characterEffect1075ui_actor.fillRatio = var_483_4
				end
			end

			if arg_480_1.time_ >= var_483_1 + var_483_2 and arg_480_1.time_ < var_483_1 + var_483_2 + arg_483_0 and not isNil(var_483_0) and arg_480_1.var_.characterEffect1075ui_actor then
				local var_483_5 = 0.5

				arg_480_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_480_1.var_.characterEffect1075ui_actor.fillRatio = var_483_5
			end

			local var_483_6 = 0

			if var_483_6 < arg_480_1.time_ and arg_480_1.time_ <= var_483_6 + arg_483_0 then
				arg_480_1.allBtn_.enabled = false
			end

			local var_483_7 = 0.6

			if arg_480_1.time_ >= var_483_6 + var_483_7 and arg_480_1.time_ < var_483_6 + var_483_7 + arg_483_0 then
				arg_480_1.allBtn_.enabled = true
			end
		end

		arg_480_1.nodeConfigList_ = {}

		arg_480_1:InitPlayNodeList()
	end,
	Play1107506117 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1107506117
		arg_484_1.duration_ = 3.23

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1107506119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = arg_484_1.actors_["1075ui_actor"]
			local var_487_1 = 0

			if var_487_1 < arg_484_1.time_ and arg_484_1.time_ <= var_487_1 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.characterEffect1075ui_actor == nil then
				arg_484_1.var_.characterEffect1075ui_actor = var_487_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_487_2 = 0.200000002980232

			if var_487_1 <= arg_484_1.time_ and arg_484_1.time_ < var_487_1 + var_487_2 and not isNil(var_487_0) then
				local var_487_3 = (arg_484_1.time_ - var_487_1) / var_487_2

				if arg_484_1.var_.characterEffect1075ui_actor and not isNil(var_487_0) then
					arg_484_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_484_1.time_ >= var_487_1 + var_487_2 and arg_484_1.time_ < var_487_1 + var_487_2 + arg_487_0 and not isNil(var_487_0) and arg_484_1.var_.characterEffect1075ui_actor then
				arg_484_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_487_4 = 0

			if var_487_4 < arg_484_1.time_ and arg_484_1.time_ <= var_487_4 + arg_487_0 then
				arg_484_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_487_5 = 0

			if var_487_5 < arg_484_1.time_ and arg_484_1.time_ <= var_487_5 + arg_487_0 then
				arg_484_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_487_6 = 0
			local var_487_7 = 0.375

			if var_487_6 < arg_484_1.time_ and arg_484_1.time_ <= var_487_6 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				local var_487_8 = arg_484_1:FormatText(StoryNameCfg[381].name)

				arg_484_1.leftNameTxt_.text = var_487_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, false)
				arg_484_1.callingController_:SetSelectedState("normal")

				local var_487_9 = arg_484_1:GetWordFromCfg(1107506117)
				local var_487_10 = arg_484_1:FormatText(var_487_9.content)

				arg_484_1.text_.text = var_487_10

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_11 = 15
				local var_487_12 = utf8.len(var_487_10)
				local var_487_13 = var_487_11 <= 0 and var_487_7 or var_487_7 * (var_487_12 / var_487_11)

				if var_487_13 > 0 and var_487_7 < var_487_13 then
					arg_484_1.talkMaxDuration = var_487_13

					if var_487_13 + var_487_6 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_13 + var_487_6
					end
				end

				arg_484_1.text_.text = var_487_10
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506117", "story_v_side_new_1107506.awb") ~= 0 then
					local var_487_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506117", "story_v_side_new_1107506.awb") / 1000

					if var_487_14 + var_487_6 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_14 + var_487_6
					end

					if var_487_9.prefab_name ~= "" and arg_484_1.actors_[var_487_9.prefab_name] ~= nil then
						local var_487_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_484_1.actors_[var_487_9.prefab_name].transform, "story_v_side_new_1107506", "1107506117", "story_v_side_new_1107506.awb")

						arg_484_1:RecordAudio("1107506117", var_487_15)
						arg_484_1:RecordAudio("1107506117", var_487_15)
					else
						arg_484_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506117", "story_v_side_new_1107506.awb")
					end

					arg_484_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506117", "story_v_side_new_1107506.awb")
				end

				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_16 = math.max(var_487_7, arg_484_1.talkMaxDuration)

			if var_487_6 <= arg_484_1.time_ and arg_484_1.time_ < var_487_6 + var_487_16 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_6) / var_487_16

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_6 + var_487_16 and arg_484_1.time_ < var_487_6 + var_487_16 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1107506119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1107506119
		arg_488_1.duration_ = 5

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1107506120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = arg_488_1.actors_["1075ui_actor"]
			local var_491_1 = 0

			if var_491_1 < arg_488_1.time_ and arg_488_1.time_ <= var_491_1 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.characterEffect1075ui_actor == nil then
				arg_488_1.var_.characterEffect1075ui_actor = var_491_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_491_2 = 0.200000002980232

			if var_491_1 <= arg_488_1.time_ and arg_488_1.time_ < var_491_1 + var_491_2 and not isNil(var_491_0) then
				local var_491_3 = (arg_488_1.time_ - var_491_1) / var_491_2

				if arg_488_1.var_.characterEffect1075ui_actor and not isNil(var_491_0) then
					local var_491_4 = Mathf.Lerp(0, 0.5, var_491_3)

					arg_488_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_488_1.var_.characterEffect1075ui_actor.fillRatio = var_491_4
				end
			end

			if arg_488_1.time_ >= var_491_1 + var_491_2 and arg_488_1.time_ < var_491_1 + var_491_2 + arg_491_0 and not isNil(var_491_0) and arg_488_1.var_.characterEffect1075ui_actor then
				local var_491_5 = 0.5

				arg_488_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_488_1.var_.characterEffect1075ui_actor.fillRatio = var_491_5
			end

			local var_491_6 = 0
			local var_491_7 = 0.475

			if var_491_6 < arg_488_1.time_ and arg_488_1.time_ <= var_491_6 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				local var_491_8 = arg_488_1:FormatText(StoryNameCfg[7].name)

				arg_488_1.leftNameTxt_.text = var_491_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, true)
				arg_488_1.iconController_:SetSelectedState("hero")

				arg_488_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_488_1.callingController_:SetSelectedState("normal")

				arg_488_1.keyicon_.color = Color.New(1, 1, 1)
				arg_488_1.icon_.color = Color.New(1, 1, 1)

				local var_491_9 = arg_488_1:GetWordFromCfg(1107506119)
				local var_491_10 = arg_488_1:FormatText(var_491_9.content)

				arg_488_1.text_.text = var_491_10

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_11 = 19
				local var_491_12 = utf8.len(var_491_10)
				local var_491_13 = var_491_11 <= 0 and var_491_7 or var_491_7 * (var_491_12 / var_491_11)

				if var_491_13 > 0 and var_491_7 < var_491_13 then
					arg_488_1.talkMaxDuration = var_491_13

					if var_491_13 + var_491_6 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_13 + var_491_6
					end
				end

				arg_488_1.text_.text = var_491_10
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)
				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_14 = math.max(var_491_7, arg_488_1.talkMaxDuration)

			if var_491_6 <= arg_488_1.time_ and arg_488_1.time_ < var_491_6 + var_491_14 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - var_491_6) / var_491_14

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= var_491_6 + var_491_14 and arg_488_1.time_ < var_491_6 + var_491_14 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play1107506120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 1107506120
		arg_492_1.duration_ = 5

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play1107506121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			local var_495_0 = arg_492_1.actors_["1075ui_actor"].transform
			local var_495_1 = 0

			if var_495_1 < arg_492_1.time_ and arg_492_1.time_ <= var_495_1 + arg_495_0 then
				arg_492_1.var_.moveOldPos1075ui_actor = var_495_0.localPosition

				local var_495_2 = GameObjectTools.GetOrAddComponent(var_495_0.gameObject, typeof(DynamicBoneHelper))

				if var_495_2 then
					var_495_2:EnableDynamicBone(false)
				end
			end

			local var_495_3 = 0.001

			if var_495_1 <= arg_492_1.time_ and arg_492_1.time_ < var_495_1 + var_495_3 then
				local var_495_4 = (arg_492_1.time_ - var_495_1) / var_495_3
				local var_495_5 = Vector3.New(0, 100, 0)

				var_495_0.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1075ui_actor, var_495_5, var_495_4)

				local var_495_6 = manager.ui.mainCamera.transform.position - var_495_0.position

				var_495_0.forward = Vector3.New(var_495_6.x, var_495_6.y, var_495_6.z)

				local var_495_7 = var_495_0.localEulerAngles

				var_495_7.z = 0
				var_495_7.x = 0
				var_495_0.localEulerAngles = var_495_7
			end

			if arg_492_1.time_ >= var_495_1 + var_495_3 and arg_492_1.time_ < var_495_1 + var_495_3 + arg_495_0 then
				var_495_0.localPosition = Vector3.New(0, 100, 0)

				local var_495_8 = manager.ui.mainCamera.transform.position - var_495_0.position

				var_495_0.forward = Vector3.New(var_495_8.x, var_495_8.y, var_495_8.z)

				local var_495_9 = var_495_0.localEulerAngles

				var_495_9.z = 0
				var_495_9.x = 0
				var_495_0.localEulerAngles = var_495_9

				local var_495_10 = GameObjectTools.GetOrAddComponent(var_495_0.gameObject, typeof(DynamicBoneHelper))

				if var_495_10 then
					var_495_10:EnableDynamicBone(true)
				end
			end

			local var_495_11 = 0
			local var_495_12 = 0.675

			if var_495_11 < arg_492_1.time_ and arg_492_1.time_ <= var_495_11 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, false)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_13 = arg_492_1:GetWordFromCfg(1107506120)
				local var_495_14 = arg_492_1:FormatText(var_495_13.content)

				arg_492_1.text_.text = var_495_14

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_15 = 27
				local var_495_16 = utf8.len(var_495_14)
				local var_495_17 = var_495_15 <= 0 and var_495_12 or var_495_12 * (var_495_16 / var_495_15)

				if var_495_17 > 0 and var_495_12 < var_495_17 then
					arg_492_1.talkMaxDuration = var_495_17

					if var_495_17 + var_495_11 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_17 + var_495_11
					end
				end

				arg_492_1.text_.text = var_495_14
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)
				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_18 = math.max(var_495_12, arg_492_1.talkMaxDuration)

			if var_495_11 <= arg_492_1.time_ and arg_492_1.time_ < var_495_11 + var_495_18 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_11) / var_495_18

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_11 + var_495_18 and arg_492_1.time_ < var_495_11 + var_495_18 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play1107506121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1107506121
		arg_496_1.duration_ = 3.17

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1107506122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			local var_499_0 = arg_496_1.actors_["1075ui_actor"].transform
			local var_499_1 = 0

			if var_499_1 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 then
				arg_496_1.var_.moveOldPos1075ui_actor = var_499_0.localPosition

				local var_499_2 = GameObjectTools.GetOrAddComponent(var_499_0.gameObject, typeof(DynamicBoneHelper))

				if var_499_2 then
					var_499_2:EnableDynamicBone(false)
				end
			end

			local var_499_3 = 0.001

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_3 then
				local var_499_4 = (arg_496_1.time_ - var_499_1) / var_499_3
				local var_499_5 = Vector3.New(0, -1.055, -6.16)

				var_499_0.localPosition = Vector3.Lerp(arg_496_1.var_.moveOldPos1075ui_actor, var_499_5, var_499_4)

				local var_499_6 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_6.x, var_499_6.y, var_499_6.z)

				local var_499_7 = var_499_0.localEulerAngles

				var_499_7.z = 0
				var_499_7.x = 0
				var_499_0.localEulerAngles = var_499_7
			end

			if arg_496_1.time_ >= var_499_1 + var_499_3 and arg_496_1.time_ < var_499_1 + var_499_3 + arg_499_0 then
				var_499_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_499_8 = manager.ui.mainCamera.transform.position - var_499_0.position

				var_499_0.forward = Vector3.New(var_499_8.x, var_499_8.y, var_499_8.z)

				local var_499_9 = var_499_0.localEulerAngles

				var_499_9.z = 0
				var_499_9.x = 0
				var_499_0.localEulerAngles = var_499_9

				local var_499_10 = GameObjectTools.GetOrAddComponent(var_499_0.gameObject, typeof(DynamicBoneHelper))

				if var_499_10 then
					var_499_10:EnableDynamicBone(true)
				end
			end

			local var_499_11 = arg_496_1.actors_["1075ui_actor"]
			local var_499_12 = 0

			if var_499_12 < arg_496_1.time_ and arg_496_1.time_ <= var_499_12 + arg_499_0 and not isNil(var_499_11) and arg_496_1.var_.characterEffect1075ui_actor == nil then
				arg_496_1.var_.characterEffect1075ui_actor = var_499_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_13 = 0.200000002980232

			if var_499_12 <= arg_496_1.time_ and arg_496_1.time_ < var_499_12 + var_499_13 and not isNil(var_499_11) then
				local var_499_14 = (arg_496_1.time_ - var_499_12) / var_499_13

				if arg_496_1.var_.characterEffect1075ui_actor and not isNil(var_499_11) then
					arg_496_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_496_1.time_ >= var_499_12 + var_499_13 and arg_496_1.time_ < var_499_12 + var_499_13 + arg_499_0 and not isNil(var_499_11) and arg_496_1.var_.characterEffect1075ui_actor then
				arg_496_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_499_15 = 0

			if var_499_15 < arg_496_1.time_ and arg_496_1.time_ <= var_499_15 + arg_499_0 then
				arg_496_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_499_16 = 0

			if var_499_16 < arg_496_1.time_ and arg_496_1.time_ <= var_499_16 + arg_499_0 then
				arg_496_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_499_17 = 0
			local var_499_18 = 0.275

			if var_499_17 < arg_496_1.time_ and arg_496_1.time_ <= var_499_17 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				local var_499_19 = arg_496_1:FormatText(StoryNameCfg[381].name)

				arg_496_1.leftNameTxt_.text = var_499_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_20 = arg_496_1:GetWordFromCfg(1107506121)
				local var_499_21 = arg_496_1:FormatText(var_499_20.content)

				arg_496_1.text_.text = var_499_21

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_22 = 11
				local var_499_23 = utf8.len(var_499_21)
				local var_499_24 = var_499_22 <= 0 and var_499_18 or var_499_18 * (var_499_23 / var_499_22)

				if var_499_24 > 0 and var_499_18 < var_499_24 then
					arg_496_1.talkMaxDuration = var_499_24

					if var_499_24 + var_499_17 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_24 + var_499_17
					end
				end

				arg_496_1.text_.text = var_499_21
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506121", "story_v_side_new_1107506.awb") ~= 0 then
					local var_499_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506121", "story_v_side_new_1107506.awb") / 1000

					if var_499_25 + var_499_17 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_25 + var_499_17
					end

					if var_499_20.prefab_name ~= "" and arg_496_1.actors_[var_499_20.prefab_name] ~= nil then
						local var_499_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_20.prefab_name].transform, "story_v_side_new_1107506", "1107506121", "story_v_side_new_1107506.awb")

						arg_496_1:RecordAudio("1107506121", var_499_26)
						arg_496_1:RecordAudio("1107506121", var_499_26)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506121", "story_v_side_new_1107506.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506121", "story_v_side_new_1107506.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_27 = math.max(var_499_18, arg_496_1.talkMaxDuration)

			if var_499_17 <= arg_496_1.time_ and arg_496_1.time_ < var_499_17 + var_499_27 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_17) / var_499_27

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_17 + var_499_27 and arg_496_1.time_ < var_499_17 + var_499_27 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_496_1:InitPlayNodeList()
	end,
	Play1107506122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1107506122
		arg_500_1.duration_ = 7.67

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1107506123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.775

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_2 = arg_500_1:FormatText(StoryNameCfg[381].name)

				arg_500_1.leftNameTxt_.text = var_503_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_3 = arg_500_1:GetWordFromCfg(1107506122)
				local var_503_4 = arg_500_1:FormatText(var_503_3.content)

				arg_500_1.text_.text = var_503_4

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_5 = 31
				local var_503_6 = utf8.len(var_503_4)
				local var_503_7 = var_503_5 <= 0 and var_503_1 or var_503_1 * (var_503_6 / var_503_5)

				if var_503_7 > 0 and var_503_1 < var_503_7 then
					arg_500_1.talkMaxDuration = var_503_7

					if var_503_7 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_7 + var_503_0
					end
				end

				arg_500_1.text_.text = var_503_4
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506122", "story_v_side_new_1107506.awb") ~= 0 then
					local var_503_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506122", "story_v_side_new_1107506.awb") / 1000

					if var_503_8 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_8 + var_503_0
					end

					if var_503_3.prefab_name ~= "" and arg_500_1.actors_[var_503_3.prefab_name] ~= nil then
						local var_503_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_3.prefab_name].transform, "story_v_side_new_1107506", "1107506122", "story_v_side_new_1107506.awb")

						arg_500_1:RecordAudio("1107506122", var_503_9)
						arg_500_1:RecordAudio("1107506122", var_503_9)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506122", "story_v_side_new_1107506.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506122", "story_v_side_new_1107506.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_10 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_10 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_10

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_10 and arg_500_1.time_ < var_503_0 + var_503_10 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play1107506123 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 1107506123
		arg_504_1.duration_ = 4.1

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play1107506124(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_507_1 = 0

			if var_507_1 < arg_504_1.time_ and arg_504_1.time_ <= var_507_1 + arg_507_0 then
				arg_504_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_507_2 = 0
			local var_507_3 = 0.4

			if var_507_2 < arg_504_1.time_ and arg_504_1.time_ <= var_507_2 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_4 = arg_504_1:FormatText(StoryNameCfg[381].name)

				arg_504_1.leftNameTxt_.text = var_507_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_5 = arg_504_1:GetWordFromCfg(1107506123)
				local var_507_6 = arg_504_1:FormatText(var_507_5.content)

				arg_504_1.text_.text = var_507_6

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_7 = 16
				local var_507_8 = utf8.len(var_507_6)
				local var_507_9 = var_507_7 <= 0 and var_507_3 or var_507_3 * (var_507_8 / var_507_7)

				if var_507_9 > 0 and var_507_3 < var_507_9 then
					arg_504_1.talkMaxDuration = var_507_9

					if var_507_9 + var_507_2 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_9 + var_507_2
					end
				end

				arg_504_1.text_.text = var_507_6
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506123", "story_v_side_new_1107506.awb") ~= 0 then
					local var_507_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506123", "story_v_side_new_1107506.awb") / 1000

					if var_507_10 + var_507_2 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_10 + var_507_2
					end

					if var_507_5.prefab_name ~= "" and arg_504_1.actors_[var_507_5.prefab_name] ~= nil then
						local var_507_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_5.prefab_name].transform, "story_v_side_new_1107506", "1107506123", "story_v_side_new_1107506.awb")

						arg_504_1:RecordAudio("1107506123", var_507_11)
						arg_504_1:RecordAudio("1107506123", var_507_11)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506123", "story_v_side_new_1107506.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506123", "story_v_side_new_1107506.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_12 = math.max(var_507_3, arg_504_1.talkMaxDuration)

			if var_507_2 <= arg_504_1.time_ and arg_504_1.time_ < var_507_2 + var_507_12 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_2) / var_507_12

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_2 + var_507_12 and arg_504_1.time_ < var_507_2 + var_507_12 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play1107506124 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 1107506124
		arg_508_1.duration_ = 5

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play1107506125(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = arg_508_1.actors_["1075ui_actor"].transform
			local var_511_1 = 0

			if var_511_1 < arg_508_1.time_ and arg_508_1.time_ <= var_511_1 + arg_511_0 then
				arg_508_1.var_.moveOldPos1075ui_actor = var_511_0.localPosition

				local var_511_2 = GameObjectTools.GetOrAddComponent(var_511_0.gameObject, typeof(DynamicBoneHelper))

				if var_511_2 then
					var_511_2:EnableDynamicBone(false)
				end
			end

			local var_511_3 = 0.001

			if var_511_1 <= arg_508_1.time_ and arg_508_1.time_ < var_511_1 + var_511_3 then
				local var_511_4 = (arg_508_1.time_ - var_511_1) / var_511_3
				local var_511_5 = Vector3.New(0, 100, 0)

				var_511_0.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPos1075ui_actor, var_511_5, var_511_4)

				local var_511_6 = manager.ui.mainCamera.transform.position - var_511_0.position

				var_511_0.forward = Vector3.New(var_511_6.x, var_511_6.y, var_511_6.z)

				local var_511_7 = var_511_0.localEulerAngles

				var_511_7.z = 0
				var_511_7.x = 0
				var_511_0.localEulerAngles = var_511_7
			end

			if arg_508_1.time_ >= var_511_1 + var_511_3 and arg_508_1.time_ < var_511_1 + var_511_3 + arg_511_0 then
				var_511_0.localPosition = Vector3.New(0, 100, 0)

				local var_511_8 = manager.ui.mainCamera.transform.position - var_511_0.position

				var_511_0.forward = Vector3.New(var_511_8.x, var_511_8.y, var_511_8.z)

				local var_511_9 = var_511_0.localEulerAngles

				var_511_9.z = 0
				var_511_9.x = 0
				var_511_0.localEulerAngles = var_511_9

				local var_511_10 = GameObjectTools.GetOrAddComponent(var_511_0.gameObject, typeof(DynamicBoneHelper))

				if var_511_10 then
					var_511_10:EnableDynamicBone(true)
				end
			end

			local var_511_11 = arg_508_1.actors_["1075ui_actor"]
			local var_511_12 = 0

			if var_511_12 < arg_508_1.time_ and arg_508_1.time_ <= var_511_12 + arg_511_0 and not isNil(var_511_11) and arg_508_1.var_.characterEffect1075ui_actor == nil then
				arg_508_1.var_.characterEffect1075ui_actor = var_511_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_511_13 = 0.200000002980232

			if var_511_12 <= arg_508_1.time_ and arg_508_1.time_ < var_511_12 + var_511_13 and not isNil(var_511_11) then
				local var_511_14 = (arg_508_1.time_ - var_511_12) / var_511_13

				if arg_508_1.var_.characterEffect1075ui_actor and not isNil(var_511_11) then
					local var_511_15 = Mathf.Lerp(0, 0.5, var_511_14)

					arg_508_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_508_1.var_.characterEffect1075ui_actor.fillRatio = var_511_15
				end
			end

			if arg_508_1.time_ >= var_511_12 + var_511_13 and arg_508_1.time_ < var_511_12 + var_511_13 + arg_511_0 and not isNil(var_511_11) and arg_508_1.var_.characterEffect1075ui_actor then
				local var_511_16 = 0.5

				arg_508_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_508_1.var_.characterEffect1075ui_actor.fillRatio = var_511_16
			end

			local var_511_17 = 0
			local var_511_18 = 0.65

			if var_511_17 < arg_508_1.time_ and arg_508_1.time_ <= var_511_17 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, false)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_19 = arg_508_1:GetWordFromCfg(1107506124)
				local var_511_20 = arg_508_1:FormatText(var_511_19.content)

				arg_508_1.text_.text = var_511_20

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_21 = 26
				local var_511_22 = utf8.len(var_511_20)
				local var_511_23 = var_511_21 <= 0 and var_511_18 or var_511_18 * (var_511_22 / var_511_21)

				if var_511_23 > 0 and var_511_18 < var_511_23 then
					arg_508_1.talkMaxDuration = var_511_23

					if var_511_23 + var_511_17 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_23 + var_511_17
					end
				end

				arg_508_1.text_.text = var_511_20
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)
				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_24 = math.max(var_511_18, arg_508_1.talkMaxDuration)

			if var_511_17 <= arg_508_1.time_ and arg_508_1.time_ < var_511_17 + var_511_24 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_17) / var_511_24

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_17 + var_511_24 and arg_508_1.time_ < var_511_17 + var_511_24 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_508_1:InitPlayNodeList()
	end,
	Play1107506125 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 1107506125
		arg_512_1.duration_ = 1

		SetActive(arg_512_1.tipsGo_, true)

		arg_512_1.tipsText_.text = StoryTipsCfg[107501].name

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"

			SetActive(arg_512_1.choicesGo_, true)

			for iter_513_0, iter_513_1 in ipairs(arg_512_1.choices_) do
				local var_513_0 = iter_513_0 <= 2

				SetActive(iter_513_1.go, var_513_0)
			end

			arg_512_1.choices_[1].txt.text = arg_512_1:FormatText(StoryChoiceCfg[1173].name)
			arg_512_1.choices_[2].txt.text = arg_512_1:FormatText(StoryChoiceCfg[1174].name)
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				PlayerAction.UseStoryTrigger(1075012, 210750106, 1107506125, 1)
				arg_512_0:Play1107506126(arg_512_1)
			end

			if arg_514_0 == 2 then
				arg_512_0:Play1107506128(arg_512_1)
			end

			arg_512_1:RecordChoiceLog(1107506125, 1173, 1174)
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = 0

			if var_515_0 < arg_512_1.time_ and arg_512_1.time_ <= var_515_0 + arg_515_0 then
				arg_512_1.allBtn_.enabled = false
			end

			local var_515_1 = 0.5

			if arg_512_1.time_ >= var_515_0 + var_515_1 and arg_512_1.time_ < var_515_0 + var_515_1 + arg_515_0 then
				arg_512_1.allBtn_.enabled = true
			end
		end

		arg_512_1.nodeConfigList_ = {}

		arg_512_1:InitPlayNodeList()
	end,
	Play1107506126 = function(arg_516_0, arg_516_1)
		arg_516_1.time_ = 0
		arg_516_1.frameCnt_ = 0
		arg_516_1.state_ = "playing"
		arg_516_1.curTalkId_ = 1107506126
		arg_516_1.duration_ = 5

		SetActive(arg_516_1.tipsGo_, false)

		function arg_516_1.onSingleLineFinish_()
			arg_516_1.onSingleLineUpdate_ = nil
			arg_516_1.onSingleLineFinish_ = nil
			arg_516_1.state_ = "waiting"
		end

		function arg_516_1.playNext_(arg_518_0)
			if arg_518_0 == 1 then
				arg_516_0:Play1107506127(arg_516_1)
			end
		end

		function arg_516_1.onSingleLineUpdate_(arg_519_0)
			local var_519_0 = 0
			local var_519_1 = 0.75

			if var_519_0 < arg_516_1.time_ and arg_516_1.time_ <= var_519_0 + arg_519_0 then
				arg_516_1.talkMaxDuration = 0
				arg_516_1.dialogCg_.alpha = 1

				arg_516_1.dialog_:SetActive(true)
				SetActive(arg_516_1.leftNameGo_, false)

				arg_516_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_516_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_516_1:RecordName(arg_516_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_516_1.iconTrs_.gameObject, false)
				arg_516_1.callingController_:SetSelectedState("normal")

				local var_519_2 = arg_516_1:GetWordFromCfg(1107506126)
				local var_519_3 = arg_516_1:FormatText(var_519_2.content)

				arg_516_1.text_.text = var_519_3

				LuaForUtil.ClearLinePrefixSymbol(arg_516_1.text_)

				local var_519_4 = 30
				local var_519_5 = utf8.len(var_519_3)
				local var_519_6 = var_519_4 <= 0 and var_519_1 or var_519_1 * (var_519_5 / var_519_4)

				if var_519_6 > 0 and var_519_1 < var_519_6 then
					arg_516_1.talkMaxDuration = var_519_6

					if var_519_6 + var_519_0 > arg_516_1.duration_ then
						arg_516_1.duration_ = var_519_6 + var_519_0
					end
				end

				arg_516_1.text_.text = var_519_3
				arg_516_1.typewritter.percent = 0

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(false)
				arg_516_1:RecordContent(arg_516_1.text_.text)
			end

			local var_519_7 = math.max(var_519_1, arg_516_1.talkMaxDuration)

			if var_519_0 <= arg_516_1.time_ and arg_516_1.time_ < var_519_0 + var_519_7 then
				arg_516_1.typewritter.percent = (arg_516_1.time_ - var_519_0) / var_519_7

				arg_516_1.typewritter:SetDirty()
			end

			if arg_516_1.time_ >= var_519_0 + var_519_7 and arg_516_1.time_ < var_519_0 + var_519_7 + arg_519_0 then
				arg_516_1.typewritter.percent = 1

				arg_516_1.typewritter:SetDirty()
				arg_516_1:ShowNextGo(true)
			end
		end

		arg_516_1.nodeConfigList_ = {}

		arg_516_1:InitPlayNodeList()
	end,
	Play1107506127 = function(arg_520_0, arg_520_1)
		arg_520_1.time_ = 0
		arg_520_1.frameCnt_ = 0
		arg_520_1.state_ = "playing"
		arg_520_1.curTalkId_ = 1107506127
		arg_520_1.duration_ = 5

		SetActive(arg_520_1.tipsGo_, false)

		function arg_520_1.onSingleLineFinish_()
			arg_520_1.onSingleLineUpdate_ = nil
			arg_520_1.onSingleLineFinish_ = nil
			arg_520_1.state_ = "waiting"
		end

		function arg_520_1.playNext_(arg_522_0)
			if arg_522_0 == 1 then
				arg_520_0:Play1107506130(arg_520_1)
			end
		end

		function arg_520_1.onSingleLineUpdate_(arg_523_0)
			local var_523_0 = 0
			local var_523_1 = 0.475

			if var_523_0 < arg_520_1.time_ and arg_520_1.time_ <= var_523_0 + arg_523_0 then
				arg_520_1.talkMaxDuration = 0
				arg_520_1.dialogCg_.alpha = 1

				arg_520_1.dialog_:SetActive(true)
				SetActive(arg_520_1.leftNameGo_, true)

				local var_523_2 = arg_520_1:FormatText(StoryNameCfg[7].name)

				arg_520_1.leftNameTxt_.text = var_523_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_520_1.leftNameTxt_.transform)

				arg_520_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_520_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_520_1:RecordName(arg_520_1.leftNameTxt_.text)
				SetActive(arg_520_1.iconTrs_.gameObject, true)
				arg_520_1.iconController_:SetSelectedState("hero")

				arg_520_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_520_1.callingController_:SetSelectedState("normal")

				arg_520_1.keyicon_.color = Color.New(1, 1, 1)
				arg_520_1.icon_.color = Color.New(1, 1, 1)

				local var_523_3 = arg_520_1:GetWordFromCfg(1107506127)
				local var_523_4 = arg_520_1:FormatText(var_523_3.content)

				arg_520_1.text_.text = var_523_4

				LuaForUtil.ClearLinePrefixSymbol(arg_520_1.text_)

				local var_523_5 = 24
				local var_523_6 = utf8.len(var_523_4)
				local var_523_7 = var_523_5 <= 0 and var_523_1 or var_523_1 * (var_523_6 / var_523_5)

				if var_523_7 > 0 and var_523_1 < var_523_7 then
					arg_520_1.talkMaxDuration = var_523_7

					if var_523_7 + var_523_0 > arg_520_1.duration_ then
						arg_520_1.duration_ = var_523_7 + var_523_0
					end
				end

				arg_520_1.text_.text = var_523_4
				arg_520_1.typewritter.percent = 0

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(false)
				arg_520_1:RecordContent(arg_520_1.text_.text)
			end

			local var_523_8 = math.max(var_523_1, arg_520_1.talkMaxDuration)

			if var_523_0 <= arg_520_1.time_ and arg_520_1.time_ < var_523_0 + var_523_8 then
				arg_520_1.typewritter.percent = (arg_520_1.time_ - var_523_0) / var_523_8

				arg_520_1.typewritter:SetDirty()
			end

			if arg_520_1.time_ >= var_523_0 + var_523_8 and arg_520_1.time_ < var_523_0 + var_523_8 + arg_523_0 then
				arg_520_1.typewritter.percent = 1

				arg_520_1.typewritter:SetDirty()
				arg_520_1:ShowNextGo(true)
			end
		end

		arg_520_1.nodeConfigList_ = {}

		arg_520_1:InitPlayNodeList()
	end,
	Play1107506130 = function(arg_524_0, arg_524_1)
		arg_524_1.time_ = 0
		arg_524_1.frameCnt_ = 0
		arg_524_1.state_ = "playing"
		arg_524_1.curTalkId_ = 1107506130
		arg_524_1.duration_ = 5.2

		SetActive(arg_524_1.tipsGo_, false)

		function arg_524_1.onSingleLineFinish_()
			arg_524_1.onSingleLineUpdate_ = nil
			arg_524_1.onSingleLineFinish_ = nil
			arg_524_1.state_ = "waiting"
		end

		function arg_524_1.playNext_(arg_526_0)
			if arg_526_0 == 1 then
				arg_524_0:Play1107506131(arg_524_1)
			end
		end

		function arg_524_1.onSingleLineUpdate_(arg_527_0)
			local var_527_0 = arg_524_1.actors_["1075ui_actor"].transform
			local var_527_1 = 0

			if var_527_1 < arg_524_1.time_ and arg_524_1.time_ <= var_527_1 + arg_527_0 then
				arg_524_1.var_.moveOldPos1075ui_actor = var_527_0.localPosition

				local var_527_2 = GameObjectTools.GetOrAddComponent(var_527_0.gameObject, typeof(DynamicBoneHelper))

				if var_527_2 then
					var_527_2:EnableDynamicBone(false)
				end
			end

			local var_527_3 = 0.001

			if var_527_1 <= arg_524_1.time_ and arg_524_1.time_ < var_527_1 + var_527_3 then
				local var_527_4 = (arg_524_1.time_ - var_527_1) / var_527_3
				local var_527_5 = Vector3.New(0, -1.055, -6.16)

				var_527_0.localPosition = Vector3.Lerp(arg_524_1.var_.moveOldPos1075ui_actor, var_527_5, var_527_4)

				local var_527_6 = manager.ui.mainCamera.transform.position - var_527_0.position

				var_527_0.forward = Vector3.New(var_527_6.x, var_527_6.y, var_527_6.z)

				local var_527_7 = var_527_0.localEulerAngles

				var_527_7.z = 0
				var_527_7.x = 0
				var_527_0.localEulerAngles = var_527_7
			end

			if arg_524_1.time_ >= var_527_1 + var_527_3 and arg_524_1.time_ < var_527_1 + var_527_3 + arg_527_0 then
				var_527_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_527_8 = manager.ui.mainCamera.transform.position - var_527_0.position

				var_527_0.forward = Vector3.New(var_527_8.x, var_527_8.y, var_527_8.z)

				local var_527_9 = var_527_0.localEulerAngles

				var_527_9.z = 0
				var_527_9.x = 0
				var_527_0.localEulerAngles = var_527_9

				local var_527_10 = GameObjectTools.GetOrAddComponent(var_527_0.gameObject, typeof(DynamicBoneHelper))

				if var_527_10 then
					var_527_10:EnableDynamicBone(true)
				end
			end

			local var_527_11 = arg_524_1.actors_["1075ui_actor"]
			local var_527_12 = 0

			if var_527_12 < arg_524_1.time_ and arg_524_1.time_ <= var_527_12 + arg_527_0 and not isNil(var_527_11) and arg_524_1.var_.characterEffect1075ui_actor == nil then
				arg_524_1.var_.characterEffect1075ui_actor = var_527_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_527_13 = 0.200000002980232

			if var_527_12 <= arg_524_1.time_ and arg_524_1.time_ < var_527_12 + var_527_13 and not isNil(var_527_11) then
				local var_527_14 = (arg_524_1.time_ - var_527_12) / var_527_13

				if arg_524_1.var_.characterEffect1075ui_actor and not isNil(var_527_11) then
					arg_524_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_524_1.time_ >= var_527_12 + var_527_13 and arg_524_1.time_ < var_527_12 + var_527_13 + arg_527_0 and not isNil(var_527_11) and arg_524_1.var_.characterEffect1075ui_actor then
				arg_524_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_527_15 = 0

			if var_527_15 < arg_524_1.time_ and arg_524_1.time_ <= var_527_15 + arg_527_0 then
				arg_524_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_527_16 = 0

			if var_527_16 < arg_524_1.time_ and arg_524_1.time_ <= var_527_16 + arg_527_0 then
				arg_524_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_527_17 = 0
			local var_527_18 = 0.525

			if var_527_17 < arg_524_1.time_ and arg_524_1.time_ <= var_527_17 + arg_527_0 then
				arg_524_1.talkMaxDuration = 0
				arg_524_1.dialogCg_.alpha = 1

				arg_524_1.dialog_:SetActive(true)
				SetActive(arg_524_1.leftNameGo_, true)

				local var_527_19 = arg_524_1:FormatText(StoryNameCfg[381].name)

				arg_524_1.leftNameTxt_.text = var_527_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_524_1.leftNameTxt_.transform)

				arg_524_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_524_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_524_1:RecordName(arg_524_1.leftNameTxt_.text)
				SetActive(arg_524_1.iconTrs_.gameObject, false)
				arg_524_1.callingController_:SetSelectedState("normal")

				local var_527_20 = arg_524_1:GetWordFromCfg(1107506130)
				local var_527_21 = arg_524_1:FormatText(var_527_20.content)

				arg_524_1.text_.text = var_527_21

				LuaForUtil.ClearLinePrefixSymbol(arg_524_1.text_)

				local var_527_22 = 21
				local var_527_23 = utf8.len(var_527_21)
				local var_527_24 = var_527_22 <= 0 and var_527_18 or var_527_18 * (var_527_23 / var_527_22)

				if var_527_24 > 0 and var_527_18 < var_527_24 then
					arg_524_1.talkMaxDuration = var_527_24

					if var_527_24 + var_527_17 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_24 + var_527_17
					end
				end

				arg_524_1.text_.text = var_527_21
				arg_524_1.typewritter.percent = 0

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506130", "story_v_side_new_1107506.awb") ~= 0 then
					local var_527_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506130", "story_v_side_new_1107506.awb") / 1000

					if var_527_25 + var_527_17 > arg_524_1.duration_ then
						arg_524_1.duration_ = var_527_25 + var_527_17
					end

					if var_527_20.prefab_name ~= "" and arg_524_1.actors_[var_527_20.prefab_name] ~= nil then
						local var_527_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_524_1.actors_[var_527_20.prefab_name].transform, "story_v_side_new_1107506", "1107506130", "story_v_side_new_1107506.awb")

						arg_524_1:RecordAudio("1107506130", var_527_26)
						arg_524_1:RecordAudio("1107506130", var_527_26)
					else
						arg_524_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506130", "story_v_side_new_1107506.awb")
					end

					arg_524_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506130", "story_v_side_new_1107506.awb")
				end

				arg_524_1:RecordContent(arg_524_1.text_.text)
			end

			local var_527_27 = math.max(var_527_18, arg_524_1.talkMaxDuration)

			if var_527_17 <= arg_524_1.time_ and arg_524_1.time_ < var_527_17 + var_527_27 then
				arg_524_1.typewritter.percent = (arg_524_1.time_ - var_527_17) / var_527_27

				arg_524_1.typewritter:SetDirty()
			end

			if arg_524_1.time_ >= var_527_17 + var_527_27 and arg_524_1.time_ < var_527_17 + var_527_27 + arg_527_0 then
				arg_524_1.typewritter.percent = 1

				arg_524_1.typewritter:SetDirty()
				arg_524_1:ShowNextGo(true)
			end
		end

		arg_524_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_524_1:InitPlayNodeList()
	end,
	Play1107506131 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 1107506131
		arg_528_1.duration_ = 5

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play1107506132(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = arg_528_1.actors_["1075ui_actor"]
			local var_531_1 = 0

			if var_531_1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 and not isNil(var_531_0) and arg_528_1.var_.characterEffect1075ui_actor == nil then
				arg_528_1.var_.characterEffect1075ui_actor = var_531_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_531_2 = 0.200000002980232

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_2 and not isNil(var_531_0) then
				local var_531_3 = (arg_528_1.time_ - var_531_1) / var_531_2

				if arg_528_1.var_.characterEffect1075ui_actor and not isNil(var_531_0) then
					local var_531_4 = Mathf.Lerp(0, 0.5, var_531_3)

					arg_528_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_528_1.var_.characterEffect1075ui_actor.fillRatio = var_531_4
				end
			end

			if arg_528_1.time_ >= var_531_1 + var_531_2 and arg_528_1.time_ < var_531_1 + var_531_2 + arg_531_0 and not isNil(var_531_0) and arg_528_1.var_.characterEffect1075ui_actor then
				local var_531_5 = 0.5

				arg_528_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_528_1.var_.characterEffect1075ui_actor.fillRatio = var_531_5
			end

			local var_531_6 = 0
			local var_531_7 = 0.225

			if var_531_6 < arg_528_1.time_ and arg_528_1.time_ <= var_531_6 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_8 = arg_528_1:FormatText(StoryNameCfg[7].name)

				arg_528_1.leftNameTxt_.text = var_531_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, true)
				arg_528_1.iconController_:SetSelectedState("hero")

				arg_528_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_528_1.callingController_:SetSelectedState("normal")

				arg_528_1.keyicon_.color = Color.New(1, 1, 1)
				arg_528_1.icon_.color = Color.New(1, 1, 1)

				local var_531_9 = arg_528_1:GetWordFromCfg(1107506131)
				local var_531_10 = arg_528_1:FormatText(var_531_9.content)

				arg_528_1.text_.text = var_531_10

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_11 = 9
				local var_531_12 = utf8.len(var_531_10)
				local var_531_13 = var_531_11 <= 0 and var_531_7 or var_531_7 * (var_531_12 / var_531_11)

				if var_531_13 > 0 and var_531_7 < var_531_13 then
					arg_528_1.talkMaxDuration = var_531_13

					if var_531_13 + var_531_6 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_13 + var_531_6
					end
				end

				arg_528_1.text_.text = var_531_10
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)
				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_14 = math.max(var_531_7, arg_528_1.talkMaxDuration)

			if var_531_6 <= arg_528_1.time_ and arg_528_1.time_ < var_531_6 + var_531_14 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_6) / var_531_14

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_6 + var_531_14 and arg_528_1.time_ < var_531_6 + var_531_14 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {}

		arg_528_1:InitPlayNodeList()
	end,
	Play1107506132 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 1107506132
		arg_532_1.duration_ = 5

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play1107506133(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 1

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_2 = arg_532_1:FormatText(StoryNameCfg[7].name)

				arg_532_1.leftNameTxt_.text = var_535_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, true)
				arg_532_1.iconController_:SetSelectedState("hero")

				arg_532_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_532_1.callingController_:SetSelectedState("normal")

				arg_532_1.keyicon_.color = Color.New(1, 1, 1)
				arg_532_1.icon_.color = Color.New(1, 1, 1)

				local var_535_3 = arg_532_1:GetWordFromCfg(1107506132)
				local var_535_4 = arg_532_1:FormatText(var_535_3.content)

				arg_532_1.text_.text = var_535_4

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 40
				local var_535_6 = utf8.len(var_535_4)
				local var_535_7 = var_535_5 <= 0 and var_535_1 or var_535_1 * (var_535_6 / var_535_5)

				if var_535_7 > 0 and var_535_1 < var_535_7 then
					arg_532_1.talkMaxDuration = var_535_7

					if var_535_7 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_7 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_4
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)
				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_8 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_8 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_8

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_8 and arg_532_1.time_ < var_535_0 + var_535_8 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play1107506133 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 1107506133
		arg_536_1.duration_ = 3.43

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play1107506134(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = arg_536_1.actors_["1075ui_actor"]
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.characterEffect1075ui_actor == nil then
				arg_536_1.var_.characterEffect1075ui_actor = var_539_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_539_2 = 0.200000002980232

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_2 and not isNil(var_539_0) then
				local var_539_3 = (arg_536_1.time_ - var_539_1) / var_539_2

				if arg_536_1.var_.characterEffect1075ui_actor and not isNil(var_539_0) then
					arg_536_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_536_1.time_ >= var_539_1 + var_539_2 and arg_536_1.time_ < var_539_1 + var_539_2 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.characterEffect1075ui_actor then
				arg_536_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_539_4 = 0

			if var_539_4 < arg_536_1.time_ and arg_536_1.time_ <= var_539_4 + arg_539_0 then
				arg_536_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_539_5 = 0

			if var_539_5 < arg_536_1.time_ and arg_536_1.time_ <= var_539_5 + arg_539_0 then
				arg_536_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_539_6 = 0
			local var_539_7 = 0.25

			if var_539_6 < arg_536_1.time_ and arg_536_1.time_ <= var_539_6 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_8 = arg_536_1:FormatText(StoryNameCfg[381].name)

				arg_536_1.leftNameTxt_.text = var_539_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, false)
				arg_536_1.callingController_:SetSelectedState("normal")

				local var_539_9 = arg_536_1:GetWordFromCfg(1107506133)
				local var_539_10 = arg_536_1:FormatText(var_539_9.content)

				arg_536_1.text_.text = var_539_10

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_11 = 10
				local var_539_12 = utf8.len(var_539_10)
				local var_539_13 = var_539_11 <= 0 and var_539_7 or var_539_7 * (var_539_12 / var_539_11)

				if var_539_13 > 0 and var_539_7 < var_539_13 then
					arg_536_1.talkMaxDuration = var_539_13

					if var_539_13 + var_539_6 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_13 + var_539_6
					end
				end

				arg_536_1.text_.text = var_539_10
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506133", "story_v_side_new_1107506.awb") ~= 0 then
					local var_539_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506133", "story_v_side_new_1107506.awb") / 1000

					if var_539_14 + var_539_6 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_14 + var_539_6
					end

					if var_539_9.prefab_name ~= "" and arg_536_1.actors_[var_539_9.prefab_name] ~= nil then
						local var_539_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_9.prefab_name].transform, "story_v_side_new_1107506", "1107506133", "story_v_side_new_1107506.awb")

						arg_536_1:RecordAudio("1107506133", var_539_15)
						arg_536_1:RecordAudio("1107506133", var_539_15)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506133", "story_v_side_new_1107506.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506133", "story_v_side_new_1107506.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_16 = math.max(var_539_7, arg_536_1.talkMaxDuration)

			if var_539_6 <= arg_536_1.time_ and arg_536_1.time_ < var_539_6 + var_539_16 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_6) / var_539_16

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_6 + var_539_16 and arg_536_1.time_ < var_539_6 + var_539_16 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play1107506134 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 1107506134
		arg_540_1.duration_ = 5

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play1107506135(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["1075ui_actor"]
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.characterEffect1075ui_actor == nil then
				arg_540_1.var_.characterEffect1075ui_actor = var_543_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_543_2 = 0.200000002980232

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_2 and not isNil(var_543_0) then
				local var_543_3 = (arg_540_1.time_ - var_543_1) / var_543_2

				if arg_540_1.var_.characterEffect1075ui_actor and not isNil(var_543_0) then
					local var_543_4 = Mathf.Lerp(0, 0.5, var_543_3)

					arg_540_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_540_1.var_.characterEffect1075ui_actor.fillRatio = var_543_4
				end
			end

			if arg_540_1.time_ >= var_543_1 + var_543_2 and arg_540_1.time_ < var_543_1 + var_543_2 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.characterEffect1075ui_actor then
				local var_543_5 = 0.5

				arg_540_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_540_1.var_.characterEffect1075ui_actor.fillRatio = var_543_5
			end

			local var_543_6 = 0
			local var_543_7 = 0.1

			if var_543_6 < arg_540_1.time_ and arg_540_1.time_ <= var_543_6 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_8 = arg_540_1:FormatText(StoryNameCfg[7].name)

				arg_540_1.leftNameTxt_.text = var_543_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, true)
				arg_540_1.iconController_:SetSelectedState("hero")

				arg_540_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_540_1.callingController_:SetSelectedState("normal")

				arg_540_1.keyicon_.color = Color.New(1, 1, 1)
				arg_540_1.icon_.color = Color.New(1, 1, 1)

				local var_543_9 = arg_540_1:GetWordFromCfg(1107506134)
				local var_543_10 = arg_540_1:FormatText(var_543_9.content)

				arg_540_1.text_.text = var_543_10

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_11 = 4
				local var_543_12 = utf8.len(var_543_10)
				local var_543_13 = var_543_11 <= 0 and var_543_7 or var_543_7 * (var_543_12 / var_543_11)

				if var_543_13 > 0 and var_543_7 < var_543_13 then
					arg_540_1.talkMaxDuration = var_543_13

					if var_543_13 + var_543_6 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_13 + var_543_6
					end
				end

				arg_540_1.text_.text = var_543_10
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)
				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_14 = math.max(var_543_7, arg_540_1.talkMaxDuration)

			if var_543_6 <= arg_540_1.time_ and arg_540_1.time_ < var_543_6 + var_543_14 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_6) / var_543_14

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_6 + var_543_14 and arg_540_1.time_ < var_543_6 + var_543_14 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {}

		arg_540_1:InitPlayNodeList()
	end,
	Play1107506135 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 1107506135
		arg_544_1.duration_ = 12.6

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play1107506136(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = arg_544_1.actors_["1075ui_actor"]
			local var_547_1 = 0

			if var_547_1 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 and not isNil(var_547_0) and arg_544_1.var_.characterEffect1075ui_actor == nil then
				arg_544_1.var_.characterEffect1075ui_actor = var_547_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_2 = 0.200000002980232

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_2 and not isNil(var_547_0) then
				local var_547_3 = (arg_544_1.time_ - var_547_1) / var_547_2

				if arg_544_1.var_.characterEffect1075ui_actor and not isNil(var_547_0) then
					arg_544_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_544_1.time_ >= var_547_1 + var_547_2 and arg_544_1.time_ < var_547_1 + var_547_2 + arg_547_0 and not isNil(var_547_0) and arg_544_1.var_.characterEffect1075ui_actor then
				arg_544_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_547_4 = 0

			if var_547_4 < arg_544_1.time_ and arg_544_1.time_ <= var_547_4 + arg_547_0 then
				arg_544_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_547_5 = 0

			if var_547_5 < arg_544_1.time_ and arg_544_1.time_ <= var_547_5 + arg_547_0 then
				arg_544_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_547_6 = 0
			local var_547_7 = 1.175

			if var_547_6 < arg_544_1.time_ and arg_544_1.time_ <= var_547_6 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_8 = arg_544_1:FormatText(StoryNameCfg[381].name)

				arg_544_1.leftNameTxt_.text = var_547_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_9 = arg_544_1:GetWordFromCfg(1107506135)
				local var_547_10 = arg_544_1:FormatText(var_547_9.content)

				arg_544_1.text_.text = var_547_10

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_11 = 47
				local var_547_12 = utf8.len(var_547_10)
				local var_547_13 = var_547_11 <= 0 and var_547_7 or var_547_7 * (var_547_12 / var_547_11)

				if var_547_13 > 0 and var_547_7 < var_547_13 then
					arg_544_1.talkMaxDuration = var_547_13

					if var_547_13 + var_547_6 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_13 + var_547_6
					end
				end

				arg_544_1.text_.text = var_547_10
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506135", "story_v_side_new_1107506.awb") ~= 0 then
					local var_547_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506135", "story_v_side_new_1107506.awb") / 1000

					if var_547_14 + var_547_6 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_14 + var_547_6
					end

					if var_547_9.prefab_name ~= "" and arg_544_1.actors_[var_547_9.prefab_name] ~= nil then
						local var_547_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_9.prefab_name].transform, "story_v_side_new_1107506", "1107506135", "story_v_side_new_1107506.awb")

						arg_544_1:RecordAudio("1107506135", var_547_15)
						arg_544_1:RecordAudio("1107506135", var_547_15)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506135", "story_v_side_new_1107506.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506135", "story_v_side_new_1107506.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_16 = math.max(var_547_7, arg_544_1.talkMaxDuration)

			if var_547_6 <= arg_544_1.time_ and arg_544_1.time_ < var_547_6 + var_547_16 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_6) / var_547_16

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_6 + var_547_16 and arg_544_1.time_ < var_547_6 + var_547_16 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play1107506136 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 1107506136
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play1107506137(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = arg_548_1.actors_["1075ui_actor"]
			local var_551_1 = 0

			if var_551_1 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.characterEffect1075ui_actor == nil then
				arg_548_1.var_.characterEffect1075ui_actor = var_551_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_551_2 = 0.200000002980232

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_2 and not isNil(var_551_0) then
				local var_551_3 = (arg_548_1.time_ - var_551_1) / var_551_2

				if arg_548_1.var_.characterEffect1075ui_actor and not isNil(var_551_0) then
					local var_551_4 = Mathf.Lerp(0, 0.5, var_551_3)

					arg_548_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_548_1.var_.characterEffect1075ui_actor.fillRatio = var_551_4
				end
			end

			if arg_548_1.time_ >= var_551_1 + var_551_2 and arg_548_1.time_ < var_551_1 + var_551_2 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.characterEffect1075ui_actor then
				local var_551_5 = 0.5

				arg_548_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_548_1.var_.characterEffect1075ui_actor.fillRatio = var_551_5
			end

			local var_551_6 = 0
			local var_551_7 = 0.8

			if var_551_6 < arg_548_1.time_ and arg_548_1.time_ <= var_551_6 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_8 = arg_548_1:GetWordFromCfg(1107506136)
				local var_551_9 = arg_548_1:FormatText(var_551_8.content)

				arg_548_1.text_.text = var_551_9

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_10 = 43
				local var_551_11 = utf8.len(var_551_9)
				local var_551_12 = var_551_10 <= 0 and var_551_7 or var_551_7 * (var_551_11 / var_551_10)

				if var_551_12 > 0 and var_551_7 < var_551_12 then
					arg_548_1.talkMaxDuration = var_551_12

					if var_551_12 + var_551_6 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_12 + var_551_6
					end
				end

				arg_548_1.text_.text = var_551_9
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_13 = math.max(var_551_7, arg_548_1.talkMaxDuration)

			if var_551_6 <= arg_548_1.time_ and arg_548_1.time_ < var_551_6 + var_551_13 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_6) / var_551_13

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_6 + var_551_13 and arg_548_1.time_ < var_551_6 + var_551_13 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play1107506137 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 1107506137
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play1107506138(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0
			local var_555_1 = 0.425

			if var_555_0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_2 = arg_552_1:FormatText(StoryNameCfg[7].name)

				arg_552_1.leftNameTxt_.text = var_555_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_3 = arg_552_1:GetWordFromCfg(1107506137)
				local var_555_4 = arg_552_1:FormatText(var_555_3.content)

				arg_552_1.text_.text = var_555_4

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_5 = 17
				local var_555_6 = utf8.len(var_555_4)
				local var_555_7 = var_555_5 <= 0 and var_555_1 or var_555_1 * (var_555_6 / var_555_5)

				if var_555_7 > 0 and var_555_1 < var_555_7 then
					arg_552_1.talkMaxDuration = var_555_7

					if var_555_7 + var_555_0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_7 + var_555_0
					end
				end

				arg_552_1.text_.text = var_555_4
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_8 = math.max(var_555_1, arg_552_1.talkMaxDuration)

			if var_555_0 <= arg_552_1.time_ and arg_552_1.time_ < var_555_0 + var_555_8 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_0) / var_555_8

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_0 + var_555_8 and arg_552_1.time_ < var_555_0 + var_555_8 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play1107506138 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 1107506138
		arg_556_1.duration_ = 8.97

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play1107506139(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = 1.96599999815226

			if var_559_0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_0 + arg_559_0 then
				local var_559_1 = manager.ui.mainCamera.transform.localPosition
				local var_559_2 = Vector3.New(0, 0, 10) + Vector3.New(var_559_1.x, var_559_1.y, 0)
				local var_559_3 = arg_556_1.bgs_.ST37a

				var_559_3.transform.localPosition = var_559_2
				var_559_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_559_4 = var_559_3:GetComponent("SpriteRenderer")

				if var_559_4 and var_559_4.sprite then
					local var_559_5 = (var_559_3.transform.localPosition - var_559_1).z
					local var_559_6 = manager.ui.mainCameraCom_
					local var_559_7 = 2 * var_559_5 * Mathf.Tan(var_559_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_559_8 = var_559_7 * var_559_6.aspect
					local var_559_9 = var_559_4.sprite.bounds.size.x
					local var_559_10 = var_559_4.sprite.bounds.size.y
					local var_559_11 = var_559_8 / var_559_9
					local var_559_12 = var_559_7 / var_559_10
					local var_559_13 = var_559_12 < var_559_11 and var_559_11 or var_559_12

					var_559_3.transform.localScale = Vector3.New(var_559_13, var_559_13, 0)
				end

				for iter_559_0, iter_559_1 in pairs(arg_556_1.bgs_) do
					if iter_559_0 ~= "ST37a" then
						iter_559_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_559_14 = 4

			if var_559_14 < arg_556_1.time_ and arg_556_1.time_ <= var_559_14 + arg_559_0 then
				arg_556_1.allBtn_.enabled = false
			end

			local var_559_15 = 0.3

			if arg_556_1.time_ >= var_559_14 + var_559_15 and arg_556_1.time_ < var_559_14 + var_559_15 + arg_559_0 then
				arg_556_1.allBtn_.enabled = true
			end

			local var_559_16 = 0

			if var_559_16 < arg_556_1.time_ and arg_556_1.time_ <= var_559_16 + arg_559_0 then
				arg_556_1.mask_.enabled = true
				arg_556_1.mask_.raycastTarget = true

				arg_556_1:SetGaussion(false)
			end

			local var_559_17 = 2

			if var_559_16 <= arg_556_1.time_ and arg_556_1.time_ < var_559_16 + var_559_17 then
				local var_559_18 = (arg_556_1.time_ - var_559_16) / var_559_17
				local var_559_19 = Color.New(0, 0, 0)

				var_559_19.a = Mathf.Lerp(0, 1, var_559_18)
				arg_556_1.mask_.color = var_559_19
			end

			if arg_556_1.time_ >= var_559_16 + var_559_17 and arg_556_1.time_ < var_559_16 + var_559_17 + arg_559_0 then
				local var_559_20 = Color.New(0, 0, 0)

				var_559_20.a = 1
				arg_556_1.mask_.color = var_559_20
			end

			local var_559_21 = 2

			if var_559_21 < arg_556_1.time_ and arg_556_1.time_ <= var_559_21 + arg_559_0 then
				arg_556_1.mask_.enabled = true
				arg_556_1.mask_.raycastTarget = true

				arg_556_1:SetGaussion(false)
			end

			local var_559_22 = 2

			if var_559_21 <= arg_556_1.time_ and arg_556_1.time_ < var_559_21 + var_559_22 then
				local var_559_23 = (arg_556_1.time_ - var_559_21) / var_559_22
				local var_559_24 = Color.New(0, 0, 0)

				var_559_24.a = Mathf.Lerp(1, 0, var_559_23)
				arg_556_1.mask_.color = var_559_24
			end

			if arg_556_1.time_ >= var_559_21 + var_559_22 and arg_556_1.time_ < var_559_21 + var_559_22 + arg_559_0 then
				local var_559_25 = Color.New(0, 0, 0)
				local var_559_26 = 0

				arg_556_1.mask_.enabled = false
				var_559_25.a = var_559_26
				arg_556_1.mask_.color = var_559_25
			end

			local var_559_27 = arg_556_1.actors_["1075ui_actor"].transform
			local var_559_28 = 1.96599999815226

			if var_559_28 < arg_556_1.time_ and arg_556_1.time_ <= var_559_28 + arg_559_0 then
				arg_556_1.var_.moveOldPos1075ui_actor = var_559_27.localPosition

				local var_559_29 = GameObjectTools.GetOrAddComponent(var_559_27.gameObject, typeof(DynamicBoneHelper))

				if var_559_29 then
					var_559_29:EnableDynamicBone(false)
				end
			end

			local var_559_30 = 0.001

			if var_559_28 <= arg_556_1.time_ and arg_556_1.time_ < var_559_28 + var_559_30 then
				local var_559_31 = (arg_556_1.time_ - var_559_28) / var_559_30
				local var_559_32 = Vector3.New(0, 100, 0)

				var_559_27.localPosition = Vector3.Lerp(arg_556_1.var_.moveOldPos1075ui_actor, var_559_32, var_559_31)

				local var_559_33 = manager.ui.mainCamera.transform.position - var_559_27.position

				var_559_27.forward = Vector3.New(var_559_33.x, var_559_33.y, var_559_33.z)

				local var_559_34 = var_559_27.localEulerAngles

				var_559_34.z = 0
				var_559_34.x = 0
				var_559_27.localEulerAngles = var_559_34
			end

			if arg_556_1.time_ >= var_559_28 + var_559_30 and arg_556_1.time_ < var_559_28 + var_559_30 + arg_559_0 then
				var_559_27.localPosition = Vector3.New(0, 100, 0)

				local var_559_35 = manager.ui.mainCamera.transform.position - var_559_27.position

				var_559_27.forward = Vector3.New(var_559_35.x, var_559_35.y, var_559_35.z)

				local var_559_36 = var_559_27.localEulerAngles

				var_559_36.z = 0
				var_559_36.x = 0
				var_559_27.localEulerAngles = var_559_36

				local var_559_37 = GameObjectTools.GetOrAddComponent(var_559_27.gameObject, typeof(DynamicBoneHelper))

				if var_559_37 then
					var_559_37:EnableDynamicBone(true)
				end
			end

			if arg_556_1.frameCnt_ <= 1 then
				arg_556_1.dialog_:SetActive(false)
			end

			local var_559_38 = 3.96599999815226
			local var_559_39 = 0.625

			if var_559_38 < arg_556_1.time_ and arg_556_1.time_ <= var_559_38 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0

				arg_556_1.dialog_:SetActive(true)

				arg_556_1.dialogCg_.alpha = 0

				local var_559_40 = LeanTween.value(arg_556_1.dialog_, 0, 1, 0.3)

				var_559_40:setOnUpdate(LuaHelper.FloatAction(function(arg_560_0)
					arg_556_1.dialogCg_.alpha = arg_560_0
				end))
				var_559_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_556_1.dialog_)
					var_559_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_556_1.duration_ = arg_556_1.duration_ + 0.3

				SetActive(arg_556_1.leftNameGo_, false)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_41 = arg_556_1:GetWordFromCfg(1107506138)
				local var_559_42 = arg_556_1:FormatText(var_559_41.content)

				arg_556_1.text_.text = var_559_42

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_43 = 25
				local var_559_44 = utf8.len(var_559_42)
				local var_559_45 = var_559_43 <= 0 and var_559_39 or var_559_39 * (var_559_44 / var_559_43)

				if var_559_45 > 0 and var_559_39 < var_559_45 then
					arg_556_1.talkMaxDuration = var_559_45
					var_559_38 = var_559_38 + 0.3

					if var_559_45 + var_559_38 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_45 + var_559_38
					end
				end

				arg_556_1.text_.text = var_559_42
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_46 = var_559_38 + 0.3
			local var_559_47 = math.max(var_559_39, arg_556_1.talkMaxDuration)

			if var_559_46 <= arg_556_1.time_ and arg_556_1.time_ < var_559_46 + var_559_47 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_46) / var_559_47

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_46 + var_559_47 and arg_556_1.time_ < var_559_46 + var_559_47 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_556_1:InitPlayNodeList()
	end,
	Play1107506139 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 1107506139
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play1107506140(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0
			local var_565_1 = 1

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				local var_565_2 = "stop"
				local var_565_3 = "effect"

				arg_562_1:AudioAction(var_565_2, var_565_3, "se_story_side_1075", "se_story_side_1075_rain_inside02", "")
			end

			local var_565_4 = 0
			local var_565_5 = 1

			if var_565_4 < arg_562_1.time_ and arg_562_1.time_ <= var_565_4 + arg_565_0 then
				local var_565_6 = "play"
				local var_565_7 = "effect"

				arg_562_1:AudioAction(var_565_6, var_565_7, "se_story_side_1075", "se_story_side_1075_rain_inside01", "")
			end

			local var_565_8 = 0
			local var_565_9 = 0.55

			if var_565_8 < arg_562_1.time_ and arg_562_1.time_ <= var_565_8 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, false)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_10 = arg_562_1:GetWordFromCfg(1107506139)
				local var_565_11 = arg_562_1:FormatText(var_565_10.content)

				arg_562_1.text_.text = var_565_11

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_12 = 22
				local var_565_13 = utf8.len(var_565_11)
				local var_565_14 = var_565_12 <= 0 and var_565_9 or var_565_9 * (var_565_13 / var_565_12)

				if var_565_14 > 0 and var_565_9 < var_565_14 then
					arg_562_1.talkMaxDuration = var_565_14

					if var_565_14 + var_565_8 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_14 + var_565_8
					end
				end

				arg_562_1.text_.text = var_565_11
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_15 = math.max(var_565_9, arg_562_1.talkMaxDuration)

			if var_565_8 <= arg_562_1.time_ and arg_562_1.time_ < var_565_8 + var_565_15 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_8) / var_565_15

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_8 + var_565_15 and arg_562_1.time_ < var_565_8 + var_565_15 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play1107506140 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 1107506140
		arg_566_1.duration_ = 4.5

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play1107506141(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = arg_566_1.actors_["1075ui_actor"].transform
			local var_569_1 = 0

			if var_569_1 < arg_566_1.time_ and arg_566_1.time_ <= var_569_1 + arg_569_0 then
				arg_566_1.var_.moveOldPos1075ui_actor = var_569_0.localPosition

				local var_569_2 = GameObjectTools.GetOrAddComponent(var_569_0.gameObject, typeof(DynamicBoneHelper))

				if var_569_2 then
					var_569_2:EnableDynamicBone(false)
				end
			end

			local var_569_3 = 0.001

			if var_569_1 <= arg_566_1.time_ and arg_566_1.time_ < var_569_1 + var_569_3 then
				local var_569_4 = (arg_566_1.time_ - var_569_1) / var_569_3
				local var_569_5 = Vector3.New(0, -1.055, -6.16)

				var_569_0.localPosition = Vector3.Lerp(arg_566_1.var_.moveOldPos1075ui_actor, var_569_5, var_569_4)

				local var_569_6 = manager.ui.mainCamera.transform.position - var_569_0.position

				var_569_0.forward = Vector3.New(var_569_6.x, var_569_6.y, var_569_6.z)

				local var_569_7 = var_569_0.localEulerAngles

				var_569_7.z = 0
				var_569_7.x = 0
				var_569_0.localEulerAngles = var_569_7
			end

			if arg_566_1.time_ >= var_569_1 + var_569_3 and arg_566_1.time_ < var_569_1 + var_569_3 + arg_569_0 then
				var_569_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_569_8 = manager.ui.mainCamera.transform.position - var_569_0.position

				var_569_0.forward = Vector3.New(var_569_8.x, var_569_8.y, var_569_8.z)

				local var_569_9 = var_569_0.localEulerAngles

				var_569_9.z = 0
				var_569_9.x = 0
				var_569_0.localEulerAngles = var_569_9

				local var_569_10 = GameObjectTools.GetOrAddComponent(var_569_0.gameObject, typeof(DynamicBoneHelper))

				if var_569_10 then
					var_569_10:EnableDynamicBone(true)
				end
			end

			local var_569_11 = arg_566_1.actors_["1075ui_actor"]
			local var_569_12 = 0

			if var_569_12 < arg_566_1.time_ and arg_566_1.time_ <= var_569_12 + arg_569_0 and not isNil(var_569_11) and arg_566_1.var_.characterEffect1075ui_actor == nil then
				arg_566_1.var_.characterEffect1075ui_actor = var_569_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_569_13 = 0.200000002980232

			if var_569_12 <= arg_566_1.time_ and arg_566_1.time_ < var_569_12 + var_569_13 and not isNil(var_569_11) then
				local var_569_14 = (arg_566_1.time_ - var_569_12) / var_569_13

				if arg_566_1.var_.characterEffect1075ui_actor and not isNil(var_569_11) then
					arg_566_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_566_1.time_ >= var_569_12 + var_569_13 and arg_566_1.time_ < var_569_12 + var_569_13 + arg_569_0 and not isNil(var_569_11) and arg_566_1.var_.characterEffect1075ui_actor then
				arg_566_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_569_15 = 0

			if var_569_15 < arg_566_1.time_ and arg_566_1.time_ <= var_569_15 + arg_569_0 then
				arg_566_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_569_16 = 0

			if var_569_16 < arg_566_1.time_ and arg_566_1.time_ <= var_569_16 + arg_569_0 then
				arg_566_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_569_17 = 0
			local var_569_18 = 0.525

			if var_569_17 < arg_566_1.time_ and arg_566_1.time_ <= var_569_17 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_19 = arg_566_1:FormatText(StoryNameCfg[381].name)

				arg_566_1.leftNameTxt_.text = var_569_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_20 = arg_566_1:GetWordFromCfg(1107506140)
				local var_569_21 = arg_566_1:FormatText(var_569_20.content)

				arg_566_1.text_.text = var_569_21

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_22 = 21
				local var_569_23 = utf8.len(var_569_21)
				local var_569_24 = var_569_22 <= 0 and var_569_18 or var_569_18 * (var_569_23 / var_569_22)

				if var_569_24 > 0 and var_569_18 < var_569_24 then
					arg_566_1.talkMaxDuration = var_569_24

					if var_569_24 + var_569_17 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_24 + var_569_17
					end
				end

				arg_566_1.text_.text = var_569_21
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506140", "story_v_side_new_1107506.awb") ~= 0 then
					local var_569_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506140", "story_v_side_new_1107506.awb") / 1000

					if var_569_25 + var_569_17 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_25 + var_569_17
					end

					if var_569_20.prefab_name ~= "" and arg_566_1.actors_[var_569_20.prefab_name] ~= nil then
						local var_569_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_20.prefab_name].transform, "story_v_side_new_1107506", "1107506140", "story_v_side_new_1107506.awb")

						arg_566_1:RecordAudio("1107506140", var_569_26)
						arg_566_1:RecordAudio("1107506140", var_569_26)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506140", "story_v_side_new_1107506.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506140", "story_v_side_new_1107506.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_27 = math.max(var_569_18, arg_566_1.talkMaxDuration)

			if var_569_17 <= arg_566_1.time_ and arg_566_1.time_ < var_569_17 + var_569_27 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_17) / var_569_27

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_17 + var_569_27 and arg_566_1.time_ < var_569_17 + var_569_27 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_566_1:InitPlayNodeList()
	end,
	Play1107506141 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 1107506141
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play1107506142(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = arg_570_1.actors_["1075ui_actor"]
			local var_573_1 = 0

			if var_573_1 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect1075ui_actor == nil then
				arg_570_1.var_.characterEffect1075ui_actor = var_573_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_2 = 0.200000002980232

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_2 and not isNil(var_573_0) then
				local var_573_3 = (arg_570_1.time_ - var_573_1) / var_573_2

				if arg_570_1.var_.characterEffect1075ui_actor and not isNil(var_573_0) then
					local var_573_4 = Mathf.Lerp(0, 0.5, var_573_3)

					arg_570_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_570_1.var_.characterEffect1075ui_actor.fillRatio = var_573_4
				end
			end

			if arg_570_1.time_ >= var_573_1 + var_573_2 and arg_570_1.time_ < var_573_1 + var_573_2 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect1075ui_actor then
				local var_573_5 = 0.5

				arg_570_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_570_1.var_.characterEffect1075ui_actor.fillRatio = var_573_5
			end

			local var_573_6 = 0
			local var_573_7 = 0.475

			if var_573_6 < arg_570_1.time_ and arg_570_1.time_ <= var_573_6 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				local var_573_8 = arg_570_1:FormatText(StoryNameCfg[7].name)

				arg_570_1.leftNameTxt_.text = var_573_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, true)
				arg_570_1.iconController_:SetSelectedState("hero")

				arg_570_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_570_1.callingController_:SetSelectedState("normal")

				arg_570_1.keyicon_.color = Color.New(1, 1, 1)
				arg_570_1.icon_.color = Color.New(1, 1, 1)

				local var_573_9 = arg_570_1:GetWordFromCfg(1107506141)
				local var_573_10 = arg_570_1:FormatText(var_573_9.content)

				arg_570_1.text_.text = var_573_10

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_11 = 19
				local var_573_12 = utf8.len(var_573_10)
				local var_573_13 = var_573_11 <= 0 and var_573_7 or var_573_7 * (var_573_12 / var_573_11)

				if var_573_13 > 0 and var_573_7 < var_573_13 then
					arg_570_1.talkMaxDuration = var_573_13

					if var_573_13 + var_573_6 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_13 + var_573_6
					end
				end

				arg_570_1.text_.text = var_573_10
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_14 = math.max(var_573_7, arg_570_1.talkMaxDuration)

			if var_573_6 <= arg_570_1.time_ and arg_570_1.time_ < var_573_6 + var_573_14 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_6) / var_573_14

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_6 + var_573_14 and arg_570_1.time_ < var_573_6 + var_573_14 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {}

		arg_570_1:InitPlayNodeList()
	end,
	Play1107506142 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 1107506142
		arg_574_1.duration_ = 2.8

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play1107506143(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = arg_574_1.actors_["1075ui_actor"]
			local var_577_1 = 0

			if var_577_1 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.characterEffect1075ui_actor == nil then
				arg_574_1.var_.characterEffect1075ui_actor = var_577_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_577_2 = 0.200000002980232

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_2 and not isNil(var_577_0) then
				local var_577_3 = (arg_574_1.time_ - var_577_1) / var_577_2

				if arg_574_1.var_.characterEffect1075ui_actor and not isNil(var_577_0) then
					arg_574_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_574_1.time_ >= var_577_1 + var_577_2 and arg_574_1.time_ < var_577_1 + var_577_2 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.characterEffect1075ui_actor then
				arg_574_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_577_4 = 0

			if var_577_4 < arg_574_1.time_ and arg_574_1.time_ <= var_577_4 + arg_577_0 then
				arg_574_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_577_5 = 0

			if var_577_5 < arg_574_1.time_ and arg_574_1.time_ <= var_577_5 + arg_577_0 then
				arg_574_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_577_6 = 0
			local var_577_7 = 0.325

			if var_577_6 < arg_574_1.time_ and arg_574_1.time_ <= var_577_6 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				local var_577_8 = arg_574_1:FormatText(StoryNameCfg[381].name)

				arg_574_1.leftNameTxt_.text = var_577_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, false)
				arg_574_1.callingController_:SetSelectedState("normal")

				local var_577_9 = arg_574_1:GetWordFromCfg(1107506142)
				local var_577_10 = arg_574_1:FormatText(var_577_9.content)

				arg_574_1.text_.text = var_577_10

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_11 = 13
				local var_577_12 = utf8.len(var_577_10)
				local var_577_13 = var_577_11 <= 0 and var_577_7 or var_577_7 * (var_577_12 / var_577_11)

				if var_577_13 > 0 and var_577_7 < var_577_13 then
					arg_574_1.talkMaxDuration = var_577_13

					if var_577_13 + var_577_6 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_13 + var_577_6
					end
				end

				arg_574_1.text_.text = var_577_10
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506142", "story_v_side_new_1107506.awb") ~= 0 then
					local var_577_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506142", "story_v_side_new_1107506.awb") / 1000

					if var_577_14 + var_577_6 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_14 + var_577_6
					end

					if var_577_9.prefab_name ~= "" and arg_574_1.actors_[var_577_9.prefab_name] ~= nil then
						local var_577_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_9.prefab_name].transform, "story_v_side_new_1107506", "1107506142", "story_v_side_new_1107506.awb")

						arg_574_1:RecordAudio("1107506142", var_577_15)
						arg_574_1:RecordAudio("1107506142", var_577_15)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506142", "story_v_side_new_1107506.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506142", "story_v_side_new_1107506.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_16 = math.max(var_577_7, arg_574_1.talkMaxDuration)

			if var_577_6 <= arg_574_1.time_ and arg_574_1.time_ < var_577_6 + var_577_16 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_6) / var_577_16

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_6 + var_577_16 and arg_574_1.time_ < var_577_6 + var_577_16 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play1107506143 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 1107506143
		arg_578_1.duration_ = 5

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play1107506144(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = arg_578_1.actors_["1075ui_actor"]
			local var_581_1 = 0

			if var_581_1 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.characterEffect1075ui_actor == nil then
				arg_578_1.var_.characterEffect1075ui_actor = var_581_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_581_2 = 0.200000002980232

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_2 and not isNil(var_581_0) then
				local var_581_3 = (arg_578_1.time_ - var_581_1) / var_581_2

				if arg_578_1.var_.characterEffect1075ui_actor and not isNil(var_581_0) then
					local var_581_4 = Mathf.Lerp(0, 0.5, var_581_3)

					arg_578_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_578_1.var_.characterEffect1075ui_actor.fillRatio = var_581_4
				end
			end

			if arg_578_1.time_ >= var_581_1 + var_581_2 and arg_578_1.time_ < var_581_1 + var_581_2 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.characterEffect1075ui_actor then
				local var_581_5 = 0.5

				arg_578_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_578_1.var_.characterEffect1075ui_actor.fillRatio = var_581_5
			end

			local var_581_6 = 0
			local var_581_7 = 0.475

			if var_581_6 < arg_578_1.time_ and arg_578_1.time_ <= var_581_6 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				local var_581_8 = arg_578_1:FormatText(StoryNameCfg[7].name)

				arg_578_1.leftNameTxt_.text = var_581_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, true)
				arg_578_1.iconController_:SetSelectedState("hero")

				arg_578_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_578_1.callingController_:SetSelectedState("normal")

				arg_578_1.keyicon_.color = Color.New(1, 1, 1)
				arg_578_1.icon_.color = Color.New(1, 1, 1)

				local var_581_9 = arg_578_1:GetWordFromCfg(1107506143)
				local var_581_10 = arg_578_1:FormatText(var_581_9.content)

				arg_578_1.text_.text = var_581_10

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_11 = 19
				local var_581_12 = utf8.len(var_581_10)
				local var_581_13 = var_581_11 <= 0 and var_581_7 or var_581_7 * (var_581_12 / var_581_11)

				if var_581_13 > 0 and var_581_7 < var_581_13 then
					arg_578_1.talkMaxDuration = var_581_13

					if var_581_13 + var_581_6 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_13 + var_581_6
					end
				end

				arg_578_1.text_.text = var_581_10
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)
				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_14 = math.max(var_581_7, arg_578_1.talkMaxDuration)

			if var_581_6 <= arg_578_1.time_ and arg_578_1.time_ < var_581_6 + var_581_14 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_6) / var_581_14

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_6 + var_581_14 and arg_578_1.time_ < var_581_6 + var_581_14 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play1107506144 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1107506144
		arg_582_1.duration_ = 9

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1107506145(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = 1.999999999999

			if var_585_0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_0 + arg_585_0 then
				local var_585_1 = manager.ui.mainCamera.transform.localPosition
				local var_585_2 = Vector3.New(0, 0, 10) + Vector3.New(var_585_1.x, var_585_1.y, 0)
				local var_585_3 = arg_582_1.bgs_.STblack

				var_585_3.transform.localPosition = var_585_2
				var_585_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_585_4 = var_585_3:GetComponent("SpriteRenderer")

				if var_585_4 and var_585_4.sprite then
					local var_585_5 = (var_585_3.transform.localPosition - var_585_1).z
					local var_585_6 = manager.ui.mainCameraCom_
					local var_585_7 = 2 * var_585_5 * Mathf.Tan(var_585_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_585_8 = var_585_7 * var_585_6.aspect
					local var_585_9 = var_585_4.sprite.bounds.size.x
					local var_585_10 = var_585_4.sprite.bounds.size.y
					local var_585_11 = var_585_8 / var_585_9
					local var_585_12 = var_585_7 / var_585_10
					local var_585_13 = var_585_12 < var_585_11 and var_585_11 or var_585_12

					var_585_3.transform.localScale = Vector3.New(var_585_13, var_585_13, 0)
				end

				for iter_585_0, iter_585_1 in pairs(arg_582_1.bgs_) do
					if iter_585_0 ~= "STblack" then
						iter_585_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_585_14 = 3.999999999999

			if var_585_14 < arg_582_1.time_ and arg_582_1.time_ <= var_585_14 + arg_585_0 then
				arg_582_1.allBtn_.enabled = false
			end

			local var_585_15 = 0.3

			if arg_582_1.time_ >= var_585_14 + var_585_15 and arg_582_1.time_ < var_585_14 + var_585_15 + arg_585_0 then
				arg_582_1.allBtn_.enabled = true
			end

			local var_585_16 = 0

			if var_585_16 < arg_582_1.time_ and arg_582_1.time_ <= var_585_16 + arg_585_0 then
				arg_582_1.mask_.enabled = true
				arg_582_1.mask_.raycastTarget = true

				arg_582_1:SetGaussion(false)
			end

			local var_585_17 = 2

			if var_585_16 <= arg_582_1.time_ and arg_582_1.time_ < var_585_16 + var_585_17 then
				local var_585_18 = (arg_582_1.time_ - var_585_16) / var_585_17
				local var_585_19 = Color.New(0, 0, 0)

				var_585_19.a = Mathf.Lerp(0, 1, var_585_18)
				arg_582_1.mask_.color = var_585_19
			end

			if arg_582_1.time_ >= var_585_16 + var_585_17 and arg_582_1.time_ < var_585_16 + var_585_17 + arg_585_0 then
				local var_585_20 = Color.New(0, 0, 0)

				var_585_20.a = 1
				arg_582_1.mask_.color = var_585_20
			end

			local var_585_21 = 2

			if var_585_21 < arg_582_1.time_ and arg_582_1.time_ <= var_585_21 + arg_585_0 then
				arg_582_1.mask_.enabled = true
				arg_582_1.mask_.raycastTarget = true

				arg_582_1:SetGaussion(false)
			end

			local var_585_22 = 2

			if var_585_21 <= arg_582_1.time_ and arg_582_1.time_ < var_585_21 + var_585_22 then
				local var_585_23 = (arg_582_1.time_ - var_585_21) / var_585_22
				local var_585_24 = Color.New(0, 0, 0)

				var_585_24.a = Mathf.Lerp(1, 0, var_585_23)
				arg_582_1.mask_.color = var_585_24
			end

			if arg_582_1.time_ >= var_585_21 + var_585_22 and arg_582_1.time_ < var_585_21 + var_585_22 + arg_585_0 then
				local var_585_25 = Color.New(0, 0, 0)
				local var_585_26 = 0

				arg_582_1.mask_.enabled = false
				var_585_25.a = var_585_26
				arg_582_1.mask_.color = var_585_25
			end

			local var_585_27 = arg_582_1.actors_["1075ui_actor"].transform
			local var_585_28 = 1.96599999815226

			if var_585_28 < arg_582_1.time_ and arg_582_1.time_ <= var_585_28 + arg_585_0 then
				arg_582_1.var_.moveOldPos1075ui_actor = var_585_27.localPosition

				local var_585_29 = GameObjectTools.GetOrAddComponent(var_585_27.gameObject, typeof(DynamicBoneHelper))

				if var_585_29 then
					var_585_29:EnableDynamicBone(false)
				end
			end

			local var_585_30 = 0.001

			if var_585_28 <= arg_582_1.time_ and arg_582_1.time_ < var_585_28 + var_585_30 then
				local var_585_31 = (arg_582_1.time_ - var_585_28) / var_585_30
				local var_585_32 = Vector3.New(0, 100, 0)

				var_585_27.localPosition = Vector3.Lerp(arg_582_1.var_.moveOldPos1075ui_actor, var_585_32, var_585_31)

				local var_585_33 = manager.ui.mainCamera.transform.position - var_585_27.position

				var_585_27.forward = Vector3.New(var_585_33.x, var_585_33.y, var_585_33.z)

				local var_585_34 = var_585_27.localEulerAngles

				var_585_34.z = 0
				var_585_34.x = 0
				var_585_27.localEulerAngles = var_585_34
			end

			if arg_582_1.time_ >= var_585_28 + var_585_30 and arg_582_1.time_ < var_585_28 + var_585_30 + arg_585_0 then
				var_585_27.localPosition = Vector3.New(0, 100, 0)

				local var_585_35 = manager.ui.mainCamera.transform.position - var_585_27.position

				var_585_27.forward = Vector3.New(var_585_35.x, var_585_35.y, var_585_35.z)

				local var_585_36 = var_585_27.localEulerAngles

				var_585_36.z = 0
				var_585_36.x = 0
				var_585_27.localEulerAngles = var_585_36

				local var_585_37 = GameObjectTools.GetOrAddComponent(var_585_27.gameObject, typeof(DynamicBoneHelper))

				if var_585_37 then
					var_585_37:EnableDynamicBone(true)
				end
			end

			if arg_582_1.frameCnt_ <= 1 then
				arg_582_1.dialog_:SetActive(false)
			end

			local var_585_38 = 3.999999999999
			local var_585_39 = 0.775

			if var_585_38 < arg_582_1.time_ and arg_582_1.time_ <= var_585_38 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0

				arg_582_1.dialog_:SetActive(true)

				arg_582_1.dialogCg_.alpha = 0

				local var_585_40 = LeanTween.value(arg_582_1.dialog_, 0, 1, 0.3)

				var_585_40:setOnUpdate(LuaHelper.FloatAction(function(arg_586_0)
					arg_582_1.dialogCg_.alpha = arg_586_0
				end))
				var_585_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_582_1.dialog_)
					var_585_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_582_1.duration_ = arg_582_1.duration_ + 0.3

				SetActive(arg_582_1.leftNameGo_, false)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_41 = arg_582_1:GetWordFromCfg(1107506144)
				local var_585_42 = arg_582_1:FormatText(var_585_41.content)

				arg_582_1.text_.text = var_585_42

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_43 = 31
				local var_585_44 = utf8.len(var_585_42)
				local var_585_45 = var_585_43 <= 0 and var_585_39 or var_585_39 * (var_585_44 / var_585_43)

				if var_585_45 > 0 and var_585_39 < var_585_45 then
					arg_582_1.talkMaxDuration = var_585_45
					var_585_38 = var_585_38 + 0.3

					if var_585_45 + var_585_38 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_45 + var_585_38
					end
				end

				arg_582_1.text_.text = var_585_42
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_46 = var_585_38 + 0.3
			local var_585_47 = math.max(var_585_39, arg_582_1.talkMaxDuration)

			if var_585_46 <= arg_582_1.time_ and arg_582_1.time_ < var_585_46 + var_585_47 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_46) / var_585_47

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_46 + var_585_47 and arg_582_1.time_ < var_585_46 + var_585_47 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_582_1:InitPlayNodeList()
	end,
	Play1107506145 = function(arg_588_0, arg_588_1)
		arg_588_1.time_ = 0
		arg_588_1.frameCnt_ = 0
		arg_588_1.state_ = "playing"
		arg_588_1.curTalkId_ = 1107506145
		arg_588_1.duration_ = 5

		SetActive(arg_588_1.tipsGo_, false)

		function arg_588_1.onSingleLineFinish_()
			arg_588_1.onSingleLineUpdate_ = nil
			arg_588_1.onSingleLineFinish_ = nil
			arg_588_1.state_ = "waiting"
		end

		function arg_588_1.playNext_(arg_590_0)
			if arg_590_0 == 1 then
				arg_588_0:Play1107506146(arg_588_1)
			end
		end

		function arg_588_1.onSingleLineUpdate_(arg_591_0)
			local var_591_0 = 0
			local var_591_1 = 0.875

			if var_591_0 < arg_588_1.time_ and arg_588_1.time_ <= var_591_0 + arg_591_0 then
				arg_588_1.talkMaxDuration = 0
				arg_588_1.dialogCg_.alpha = 1

				arg_588_1.dialog_:SetActive(true)
				SetActive(arg_588_1.leftNameGo_, false)

				arg_588_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_588_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_588_1:RecordName(arg_588_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_588_1.iconTrs_.gameObject, false)
				arg_588_1.callingController_:SetSelectedState("normal")

				local var_591_2 = arg_588_1:GetWordFromCfg(1107506145)
				local var_591_3 = arg_588_1:FormatText(var_591_2.content)

				arg_588_1.text_.text = var_591_3

				LuaForUtil.ClearLinePrefixSymbol(arg_588_1.text_)

				local var_591_4 = 35
				local var_591_5 = utf8.len(var_591_3)
				local var_591_6 = var_591_4 <= 0 and var_591_1 or var_591_1 * (var_591_5 / var_591_4)

				if var_591_6 > 0 and var_591_1 < var_591_6 then
					arg_588_1.talkMaxDuration = var_591_6

					if var_591_6 + var_591_0 > arg_588_1.duration_ then
						arg_588_1.duration_ = var_591_6 + var_591_0
					end
				end

				arg_588_1.text_.text = var_591_3
				arg_588_1.typewritter.percent = 0

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(false)
				arg_588_1:RecordContent(arg_588_1.text_.text)
			end

			local var_591_7 = math.max(var_591_1, arg_588_1.talkMaxDuration)

			if var_591_0 <= arg_588_1.time_ and arg_588_1.time_ < var_591_0 + var_591_7 then
				arg_588_1.typewritter.percent = (arg_588_1.time_ - var_591_0) / var_591_7

				arg_588_1.typewritter:SetDirty()
			end

			if arg_588_1.time_ >= var_591_0 + var_591_7 and arg_588_1.time_ < var_591_0 + var_591_7 + arg_591_0 then
				arg_588_1.typewritter.percent = 1

				arg_588_1.typewritter:SetDirty()
				arg_588_1:ShowNextGo(true)
			end
		end

		arg_588_1.nodeConfigList_ = {}

		arg_588_1:InitPlayNodeList()
	end,
	Play1107506146 = function(arg_592_0, arg_592_1)
		arg_592_1.time_ = 0
		arg_592_1.frameCnt_ = 0
		arg_592_1.state_ = "playing"
		arg_592_1.curTalkId_ = 1107506146
		arg_592_1.duration_ = 5

		SetActive(arg_592_1.tipsGo_, false)

		function arg_592_1.onSingleLineFinish_()
			arg_592_1.onSingleLineUpdate_ = nil
			arg_592_1.onSingleLineFinish_ = nil
			arg_592_1.state_ = "waiting"
		end

		function arg_592_1.playNext_(arg_594_0)
			if arg_594_0 == 1 then
				arg_592_0:Play1107506147(arg_592_1)
			end
		end

		function arg_592_1.onSingleLineUpdate_(arg_595_0)
			local var_595_0 = 0
			local var_595_1 = 0.125

			if var_595_0 < arg_592_1.time_ and arg_592_1.time_ <= var_595_0 + arg_595_0 then
				arg_592_1.talkMaxDuration = 0
				arg_592_1.dialogCg_.alpha = 1

				arg_592_1.dialog_:SetActive(true)
				SetActive(arg_592_1.leftNameGo_, true)

				local var_595_2 = arg_592_1:FormatText(StoryNameCfg[7].name)

				arg_592_1.leftNameTxt_.text = var_595_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_592_1.leftNameTxt_.transform)

				arg_592_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_592_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_592_1:RecordName(arg_592_1.leftNameTxt_.text)
				SetActive(arg_592_1.iconTrs_.gameObject, true)
				arg_592_1.iconController_:SetSelectedState("hero")

				arg_592_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_592_1.callingController_:SetSelectedState("normal")

				arg_592_1.keyicon_.color = Color.New(1, 1, 1)
				arg_592_1.icon_.color = Color.New(1, 1, 1)

				local var_595_3 = arg_592_1:GetWordFromCfg(1107506146)
				local var_595_4 = arg_592_1:FormatText(var_595_3.content)

				arg_592_1.text_.text = var_595_4

				LuaForUtil.ClearLinePrefixSymbol(arg_592_1.text_)

				local var_595_5 = 5
				local var_595_6 = utf8.len(var_595_4)
				local var_595_7 = var_595_5 <= 0 and var_595_1 or var_595_1 * (var_595_6 / var_595_5)

				if var_595_7 > 0 and var_595_1 < var_595_7 then
					arg_592_1.talkMaxDuration = var_595_7

					if var_595_7 + var_595_0 > arg_592_1.duration_ then
						arg_592_1.duration_ = var_595_7 + var_595_0
					end
				end

				arg_592_1.text_.text = var_595_4
				arg_592_1.typewritter.percent = 0

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(false)
				arg_592_1:RecordContent(arg_592_1.text_.text)
			end

			local var_595_8 = math.max(var_595_1, arg_592_1.talkMaxDuration)

			if var_595_0 <= arg_592_1.time_ and arg_592_1.time_ < var_595_0 + var_595_8 then
				arg_592_1.typewritter.percent = (arg_592_1.time_ - var_595_0) / var_595_8

				arg_592_1.typewritter:SetDirty()
			end

			if arg_592_1.time_ >= var_595_0 + var_595_8 and arg_592_1.time_ < var_595_0 + var_595_8 + arg_595_0 then
				arg_592_1.typewritter.percent = 1

				arg_592_1.typewritter:SetDirty()
				arg_592_1:ShowNextGo(true)
			end
		end

		arg_592_1.nodeConfigList_ = {}

		arg_592_1:InitPlayNodeList()
	end,
	Play1107506147 = function(arg_596_0, arg_596_1)
		arg_596_1.time_ = 0
		arg_596_1.frameCnt_ = 0
		arg_596_1.state_ = "playing"
		arg_596_1.curTalkId_ = 1107506147
		arg_596_1.duration_ = 3.93

		SetActive(arg_596_1.tipsGo_, false)

		function arg_596_1.onSingleLineFinish_()
			arg_596_1.onSingleLineUpdate_ = nil
			arg_596_1.onSingleLineFinish_ = nil
			arg_596_1.state_ = "waiting"
		end

		function arg_596_1.playNext_(arg_598_0)
			if arg_598_0 == 1 then
				arg_596_0:Play1107506148(arg_596_1)
			end
		end

		function arg_596_1.onSingleLineUpdate_(arg_599_0)
			local var_599_0 = arg_596_1.actors_["1075ui_actor"]
			local var_599_1 = 0

			if var_599_1 < arg_596_1.time_ and arg_596_1.time_ <= var_599_1 + arg_599_0 and not isNil(var_599_0) and arg_596_1.var_.characterEffect1075ui_actor == nil then
				arg_596_1.var_.characterEffect1075ui_actor = var_599_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_599_2 = 0.200000002980232

			if var_599_1 <= arg_596_1.time_ and arg_596_1.time_ < var_599_1 + var_599_2 and not isNil(var_599_0) then
				local var_599_3 = (arg_596_1.time_ - var_599_1) / var_599_2

				if arg_596_1.var_.characterEffect1075ui_actor and not isNil(var_599_0) then
					arg_596_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_596_1.time_ >= var_599_1 + var_599_2 and arg_596_1.time_ < var_599_1 + var_599_2 + arg_599_0 and not isNil(var_599_0) and arg_596_1.var_.characterEffect1075ui_actor then
				arg_596_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_599_4 = 0
			local var_599_5 = 0.5

			if var_599_4 < arg_596_1.time_ and arg_596_1.time_ <= var_599_4 + arg_599_0 then
				arg_596_1.talkMaxDuration = 0
				arg_596_1.dialogCg_.alpha = 1

				arg_596_1.dialog_:SetActive(true)
				SetActive(arg_596_1.leftNameGo_, true)

				local var_599_6 = arg_596_1:FormatText(StoryNameCfg[381].name)

				arg_596_1.leftNameTxt_.text = var_599_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_596_1.leftNameTxt_.transform)

				arg_596_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_596_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_596_1:RecordName(arg_596_1.leftNameTxt_.text)
				SetActive(arg_596_1.iconTrs_.gameObject, true)
				arg_596_1.iconController_:SetSelectedState("hero")

				arg_596_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_596_1.callingController_:SetSelectedState("normal")

				arg_596_1.keyicon_.color = Color.New(1, 1, 1)
				arg_596_1.icon_.color = Color.New(1, 1, 1)

				local var_599_7 = arg_596_1:GetWordFromCfg(1107506147)
				local var_599_8 = arg_596_1:FormatText(var_599_7.content)

				arg_596_1.text_.text = var_599_8

				LuaForUtil.ClearLinePrefixSymbol(arg_596_1.text_)

				local var_599_9 = 20
				local var_599_10 = utf8.len(var_599_8)
				local var_599_11 = var_599_9 <= 0 and var_599_5 or var_599_5 * (var_599_10 / var_599_9)

				if var_599_11 > 0 and var_599_5 < var_599_11 then
					arg_596_1.talkMaxDuration = var_599_11

					if var_599_11 + var_599_4 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_11 + var_599_4
					end
				end

				arg_596_1.text_.text = var_599_8
				arg_596_1.typewritter.percent = 0

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506147", "story_v_side_new_1107506.awb") ~= 0 then
					local var_599_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506147", "story_v_side_new_1107506.awb") / 1000

					if var_599_12 + var_599_4 > arg_596_1.duration_ then
						arg_596_1.duration_ = var_599_12 + var_599_4
					end

					if var_599_7.prefab_name ~= "" and arg_596_1.actors_[var_599_7.prefab_name] ~= nil then
						local var_599_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_596_1.actors_[var_599_7.prefab_name].transform, "story_v_side_new_1107506", "1107506147", "story_v_side_new_1107506.awb")

						arg_596_1:RecordAudio("1107506147", var_599_13)
						arg_596_1:RecordAudio("1107506147", var_599_13)
					else
						arg_596_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506147", "story_v_side_new_1107506.awb")
					end

					arg_596_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506147", "story_v_side_new_1107506.awb")
				end

				arg_596_1:RecordContent(arg_596_1.text_.text)
			end

			local var_599_14 = math.max(var_599_5, arg_596_1.talkMaxDuration)

			if var_599_4 <= arg_596_1.time_ and arg_596_1.time_ < var_599_4 + var_599_14 then
				arg_596_1.typewritter.percent = (arg_596_1.time_ - var_599_4) / var_599_14

				arg_596_1.typewritter:SetDirty()
			end

			if arg_596_1.time_ >= var_599_4 + var_599_14 and arg_596_1.time_ < var_599_4 + var_599_14 + arg_599_0 then
				arg_596_1.typewritter.percent = 1

				arg_596_1.typewritter:SetDirty()
				arg_596_1:ShowNextGo(true)
			end
		end

		arg_596_1.nodeConfigList_ = {}

		arg_596_1:InitPlayNodeList()
	end,
	Play1107506148 = function(arg_600_0, arg_600_1)
		arg_600_1.time_ = 0
		arg_600_1.frameCnt_ = 0
		arg_600_1.state_ = "playing"
		arg_600_1.curTalkId_ = 1107506148
		arg_600_1.duration_ = 6.43

		SetActive(arg_600_1.tipsGo_, false)

		function arg_600_1.onSingleLineFinish_()
			arg_600_1.onSingleLineUpdate_ = nil
			arg_600_1.onSingleLineFinish_ = nil
			arg_600_1.state_ = "waiting"
		end

		function arg_600_1.playNext_(arg_602_0)
			if arg_602_0 == 1 then
				arg_600_0:Play1107506149(arg_600_1)
			end
		end

		function arg_600_1.onSingleLineUpdate_(arg_603_0)
			local var_603_0 = 0
			local var_603_1 = 0.675

			if var_603_0 < arg_600_1.time_ and arg_600_1.time_ <= var_603_0 + arg_603_0 then
				arg_600_1.talkMaxDuration = 0
				arg_600_1.dialogCg_.alpha = 1

				arg_600_1.dialog_:SetActive(true)
				SetActive(arg_600_1.leftNameGo_, true)

				local var_603_2 = arg_600_1:FormatText(StoryNameCfg[381].name)

				arg_600_1.leftNameTxt_.text = var_603_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_600_1.leftNameTxt_.transform)

				arg_600_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_600_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_600_1:RecordName(arg_600_1.leftNameTxt_.text)
				SetActive(arg_600_1.iconTrs_.gameObject, true)
				arg_600_1.iconController_:SetSelectedState("hero")

				arg_600_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_600_1.callingController_:SetSelectedState("normal")

				arg_600_1.keyicon_.color = Color.New(1, 1, 1)
				arg_600_1.icon_.color = Color.New(1, 1, 1)

				local var_603_3 = arg_600_1:GetWordFromCfg(1107506148)
				local var_603_4 = arg_600_1:FormatText(var_603_3.content)

				arg_600_1.text_.text = var_603_4

				LuaForUtil.ClearLinePrefixSymbol(arg_600_1.text_)

				local var_603_5 = 27
				local var_603_6 = utf8.len(var_603_4)
				local var_603_7 = var_603_5 <= 0 and var_603_1 or var_603_1 * (var_603_6 / var_603_5)

				if var_603_7 > 0 and var_603_1 < var_603_7 then
					arg_600_1.talkMaxDuration = var_603_7

					if var_603_7 + var_603_0 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_7 + var_603_0
					end
				end

				arg_600_1.text_.text = var_603_4
				arg_600_1.typewritter.percent = 0

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506148", "story_v_side_new_1107506.awb") ~= 0 then
					local var_603_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506148", "story_v_side_new_1107506.awb") / 1000

					if var_603_8 + var_603_0 > arg_600_1.duration_ then
						arg_600_1.duration_ = var_603_8 + var_603_0
					end

					if var_603_3.prefab_name ~= "" and arg_600_1.actors_[var_603_3.prefab_name] ~= nil then
						local var_603_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_600_1.actors_[var_603_3.prefab_name].transform, "story_v_side_new_1107506", "1107506148", "story_v_side_new_1107506.awb")

						arg_600_1:RecordAudio("1107506148", var_603_9)
						arg_600_1:RecordAudio("1107506148", var_603_9)
					else
						arg_600_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506148", "story_v_side_new_1107506.awb")
					end

					arg_600_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506148", "story_v_side_new_1107506.awb")
				end

				arg_600_1:RecordContent(arg_600_1.text_.text)
			end

			local var_603_10 = math.max(var_603_1, arg_600_1.talkMaxDuration)

			if var_603_0 <= arg_600_1.time_ and arg_600_1.time_ < var_603_0 + var_603_10 then
				arg_600_1.typewritter.percent = (arg_600_1.time_ - var_603_0) / var_603_10

				arg_600_1.typewritter:SetDirty()
			end

			if arg_600_1.time_ >= var_603_0 + var_603_10 and arg_600_1.time_ < var_603_0 + var_603_10 + arg_603_0 then
				arg_600_1.typewritter.percent = 1

				arg_600_1.typewritter:SetDirty()
				arg_600_1:ShowNextGo(true)
			end
		end

		arg_600_1.nodeConfigList_ = {}

		arg_600_1:InitPlayNodeList()
	end,
	Play1107506149 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 1107506149
		arg_604_1.duration_ = 8.53

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play1107506150(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = 0
			local var_607_1 = 0.825

			if var_607_0 < arg_604_1.time_ and arg_604_1.time_ <= var_607_0 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				local var_607_2 = arg_604_1:FormatText(StoryNameCfg[381].name)

				arg_604_1.leftNameTxt_.text = var_607_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, true)
				arg_604_1.iconController_:SetSelectedState("hero")

				arg_604_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_604_1.callingController_:SetSelectedState("normal")

				arg_604_1.keyicon_.color = Color.New(1, 1, 1)
				arg_604_1.icon_.color = Color.New(1, 1, 1)

				local var_607_3 = arg_604_1:GetWordFromCfg(1107506149)
				local var_607_4 = arg_604_1:FormatText(var_607_3.content)

				arg_604_1.text_.text = var_607_4

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_5 = 33
				local var_607_6 = utf8.len(var_607_4)
				local var_607_7 = var_607_5 <= 0 and var_607_1 or var_607_1 * (var_607_6 / var_607_5)

				if var_607_7 > 0 and var_607_1 < var_607_7 then
					arg_604_1.talkMaxDuration = var_607_7

					if var_607_7 + var_607_0 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_7 + var_607_0
					end
				end

				arg_604_1.text_.text = var_607_4
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506149", "story_v_side_new_1107506.awb") ~= 0 then
					local var_607_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506149", "story_v_side_new_1107506.awb") / 1000

					if var_607_8 + var_607_0 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_8 + var_607_0
					end

					if var_607_3.prefab_name ~= "" and arg_604_1.actors_[var_607_3.prefab_name] ~= nil then
						local var_607_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_3.prefab_name].transform, "story_v_side_new_1107506", "1107506149", "story_v_side_new_1107506.awb")

						arg_604_1:RecordAudio("1107506149", var_607_9)
						arg_604_1:RecordAudio("1107506149", var_607_9)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506149", "story_v_side_new_1107506.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506149", "story_v_side_new_1107506.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_10 = math.max(var_607_1, arg_604_1.talkMaxDuration)

			if var_607_0 <= arg_604_1.time_ and arg_604_1.time_ < var_607_0 + var_607_10 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_0) / var_607_10

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_0 + var_607_10 and arg_604_1.time_ < var_607_0 + var_607_10 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play1107506150 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 1107506150
		arg_608_1.duration_ = 5

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play1107506151(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = arg_608_1.actors_["1075ui_actor"]
			local var_611_1 = 0

			if var_611_1 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 and not isNil(var_611_0) and arg_608_1.var_.characterEffect1075ui_actor == nil then
				arg_608_1.var_.characterEffect1075ui_actor = var_611_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_611_2 = 0.200000002980232

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_2 and not isNil(var_611_0) then
				local var_611_3 = (arg_608_1.time_ - var_611_1) / var_611_2

				if arg_608_1.var_.characterEffect1075ui_actor and not isNil(var_611_0) then
					local var_611_4 = Mathf.Lerp(0, 0.5, var_611_3)

					arg_608_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_608_1.var_.characterEffect1075ui_actor.fillRatio = var_611_4
				end
			end

			if arg_608_1.time_ >= var_611_1 + var_611_2 and arg_608_1.time_ < var_611_1 + var_611_2 + arg_611_0 and not isNil(var_611_0) and arg_608_1.var_.characterEffect1075ui_actor then
				local var_611_5 = 0.5

				arg_608_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_608_1.var_.characterEffect1075ui_actor.fillRatio = var_611_5
			end

			local var_611_6 = 0
			local var_611_7 = 0.5

			if var_611_6 < arg_608_1.time_ and arg_608_1.time_ <= var_611_6 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				local var_611_8 = arg_608_1:FormatText(StoryNameCfg[7].name)

				arg_608_1.leftNameTxt_.text = var_611_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, true)
				arg_608_1.iconController_:SetSelectedState("hero")

				arg_608_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_608_1.callingController_:SetSelectedState("normal")

				arg_608_1.keyicon_.color = Color.New(1, 1, 1)
				arg_608_1.icon_.color = Color.New(1, 1, 1)

				local var_611_9 = arg_608_1:GetWordFromCfg(1107506150)
				local var_611_10 = arg_608_1:FormatText(var_611_9.content)

				arg_608_1.text_.text = var_611_10

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_11 = 20
				local var_611_12 = utf8.len(var_611_10)
				local var_611_13 = var_611_11 <= 0 and var_611_7 or var_611_7 * (var_611_12 / var_611_11)

				if var_611_13 > 0 and var_611_7 < var_611_13 then
					arg_608_1.talkMaxDuration = var_611_13

					if var_611_13 + var_611_6 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_13 + var_611_6
					end
				end

				arg_608_1.text_.text = var_611_10
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)
				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_14 = math.max(var_611_7, arg_608_1.talkMaxDuration)

			if var_611_6 <= arg_608_1.time_ and arg_608_1.time_ < var_611_6 + var_611_14 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_6) / var_611_14

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_6 + var_611_14 and arg_608_1.time_ < var_611_6 + var_611_14 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {}

		arg_608_1:InitPlayNodeList()
	end,
	Play1107506151 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 1107506151
		arg_612_1.duration_ = 5

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
		end

		function arg_612_1.playNext_(arg_614_0)
			if arg_614_0 == 1 then
				arg_612_0:Play1107506152(arg_612_1)
			end
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0
			local var_615_1 = 0.3

			if var_615_0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				local var_615_2 = arg_612_1:FormatText(StoryNameCfg[7].name)

				arg_612_1.leftNameTxt_.text = var_615_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, true)
				arg_612_1.iconController_:SetSelectedState("hero")

				arg_612_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_612_1.callingController_:SetSelectedState("normal")

				arg_612_1.keyicon_.color = Color.New(1, 1, 1)
				arg_612_1.icon_.color = Color.New(1, 1, 1)

				local var_615_3 = arg_612_1:GetWordFromCfg(1107506151)
				local var_615_4 = arg_612_1:FormatText(var_615_3.content)

				arg_612_1.text_.text = var_615_4

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_5 = 12
				local var_615_6 = utf8.len(var_615_4)
				local var_615_7 = var_615_5 <= 0 and var_615_1 or var_615_1 * (var_615_6 / var_615_5)

				if var_615_7 > 0 and var_615_1 < var_615_7 then
					arg_612_1.talkMaxDuration = var_615_7

					if var_615_7 + var_615_0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_7 + var_615_0
					end
				end

				arg_612_1.text_.text = var_615_4
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)
				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_8 = math.max(var_615_1, arg_612_1.talkMaxDuration)

			if var_615_0 <= arg_612_1.time_ and arg_612_1.time_ < var_615_0 + var_615_8 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_0) / var_615_8

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_0 + var_615_8 and arg_612_1.time_ < var_615_0 + var_615_8 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play1107506152 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 1107506152
		arg_616_1.duration_ = 7

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play1107506153(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = "ST37"

			if arg_616_1.bgs_[var_619_0] == nil then
				local var_619_1 = Object.Instantiate(arg_616_1.paintGo_)

				var_619_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_619_0)
				var_619_1.name = var_619_0
				var_619_1.transform.parent = arg_616_1.stage_.transform
				var_619_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_616_1.bgs_[var_619_0] = var_619_1
			end

			local var_619_2 = 0

			if var_619_2 < arg_616_1.time_ and arg_616_1.time_ <= var_619_2 + arg_619_0 then
				local var_619_3 = manager.ui.mainCamera.transform.localPosition
				local var_619_4 = Vector3.New(0, 0, 10) + Vector3.New(var_619_3.x, var_619_3.y, 0)
				local var_619_5 = arg_616_1.bgs_.ST37

				var_619_5.transform.localPosition = var_619_4
				var_619_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_619_6 = var_619_5:GetComponent("SpriteRenderer")

				if var_619_6 and var_619_6.sprite then
					local var_619_7 = (var_619_5.transform.localPosition - var_619_3).z
					local var_619_8 = manager.ui.mainCameraCom_
					local var_619_9 = 2 * var_619_7 * Mathf.Tan(var_619_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_619_10 = var_619_9 * var_619_8.aspect
					local var_619_11 = var_619_6.sprite.bounds.size.x
					local var_619_12 = var_619_6.sprite.bounds.size.y
					local var_619_13 = var_619_10 / var_619_11
					local var_619_14 = var_619_9 / var_619_12
					local var_619_15 = var_619_14 < var_619_13 and var_619_13 or var_619_14

					var_619_5.transform.localScale = Vector3.New(var_619_15, var_619_15, 0)
				end

				for iter_619_0, iter_619_1 in pairs(arg_616_1.bgs_) do
					if iter_619_0 ~= "ST37" then
						iter_619_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_619_16 = 2

			if var_619_16 < arg_616_1.time_ and arg_616_1.time_ <= var_619_16 + arg_619_0 then
				arg_616_1.allBtn_.enabled = false
			end

			local var_619_17 = 0.3

			if arg_616_1.time_ >= var_619_16 + var_619_17 and arg_616_1.time_ < var_619_16 + var_619_17 + arg_619_0 then
				arg_616_1.allBtn_.enabled = true
			end

			local var_619_18 = 0

			if var_619_18 < arg_616_1.time_ and arg_616_1.time_ <= var_619_18 + arg_619_0 then
				arg_616_1.mask_.enabled = true
				arg_616_1.mask_.raycastTarget = true

				arg_616_1:SetGaussion(false)
			end

			local var_619_19 = 2

			if var_619_18 <= arg_616_1.time_ and arg_616_1.time_ < var_619_18 + var_619_19 then
				local var_619_20 = (arg_616_1.time_ - var_619_18) / var_619_19
				local var_619_21 = Color.New(0, 0, 0)

				var_619_21.a = Mathf.Lerp(1, 0, var_619_20)
				arg_616_1.mask_.color = var_619_21
			end

			if arg_616_1.time_ >= var_619_18 + var_619_19 and arg_616_1.time_ < var_619_18 + var_619_19 + arg_619_0 then
				local var_619_22 = Color.New(0, 0, 0)
				local var_619_23 = 0

				arg_616_1.mask_.enabled = false
				var_619_22.a = var_619_23
				arg_616_1.mask_.color = var_619_22
			end

			local var_619_24 = 0.233333333333333
			local var_619_25 = 1

			if var_619_24 < arg_616_1.time_ and arg_616_1.time_ <= var_619_24 + arg_619_0 then
				local var_619_26 = "play"
				local var_619_27 = "effect"

				arg_616_1:AudioAction(var_619_26, var_619_27, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_619_28 = 0
			local var_619_29 = 1

			if var_619_28 < arg_616_1.time_ and arg_616_1.time_ <= var_619_28 + arg_619_0 then
				local var_619_30 = "stop"
				local var_619_31 = "effect"

				arg_616_1:AudioAction(var_619_30, var_619_31, "se_story_side_1075", "se_story_side_1075_rain_inside01", "")
			end

			local var_619_32 = "ST37_blur"

			if arg_616_1.bgs_[var_619_32] == nil then
				local var_619_33 = Object.Instantiate(arg_616_1.blurPaintGo_)
				local var_619_34 = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_619_32)

				var_619_33:GetComponent("SpriteRenderer").sprite = var_619_34
				var_619_33.name = var_619_32
				var_619_33.transform.parent = arg_616_1.stage_.transform
				var_619_33.transform.localPosition = Vector3.New(0, 100, 0)
				arg_616_1.bgs_[var_619_32] = var_619_33
			end

			local var_619_35 = 0
			local var_619_36 = arg_616_1.bgs_[var_619_32]

			if var_619_35 < arg_616_1.time_ and arg_616_1.time_ <= var_619_35 + arg_619_0 then
				local var_619_37 = manager.ui.mainCamera.transform.localPosition
				local var_619_38 = Vector3.New(0, 0, 10) + Vector3.New(var_619_37.x, var_619_37.y, 0)

				var_619_36.transform.localPosition = var_619_38
				var_619_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_619_39 = var_619_36:GetComponent("SpriteRenderer")

				if var_619_39 and var_619_39.sprite then
					local var_619_40 = (var_619_36.transform.localPosition - var_619_37).z
					local var_619_41 = manager.ui.mainCameraCom_
					local var_619_42 = 2 * var_619_40 * Mathf.Tan(var_619_41.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_619_43 = var_619_42 * var_619_41.aspect
					local var_619_44 = var_619_39.sprite.bounds.size.x
					local var_619_45 = var_619_39.sprite.bounds.size.y
					local var_619_46 = var_619_43 / var_619_44
					local var_619_47 = var_619_42 / var_619_45
					local var_619_48 = var_619_47 < var_619_46 and var_619_46 or var_619_47

					var_619_36.transform.localScale = Vector3.New(var_619_48, var_619_48, 0)
				end
			end

			local var_619_49 = 3

			if var_619_35 <= arg_616_1.time_ and arg_616_1.time_ < var_619_35 + var_619_49 then
				local var_619_50 = (arg_616_1.time_ - var_619_35) / var_619_49
				local var_619_51 = Color.New(1, 1, 1)

				var_619_51.a = Mathf.Lerp(1, 0, var_619_50)

				var_619_36:GetComponent("SpriteRenderer").material:SetColor("_Color", var_619_51)
			end

			local var_619_52 = 2

			if var_619_52 < arg_616_1.time_ and arg_616_1.time_ <= var_619_52 + arg_619_0 then
				arg_616_1.allBtn_.enabled = false
			end

			local var_619_53 = 1

			if arg_616_1.time_ >= var_619_52 + var_619_53 and arg_616_1.time_ < var_619_52 + var_619_53 + arg_619_0 then
				arg_616_1.allBtn_.enabled = true
			end

			if arg_616_1.frameCnt_ <= 1 then
				arg_616_1.dialog_:SetActive(false)
			end

			local var_619_54 = 2
			local var_619_55 = 0.85

			if var_619_54 < arg_616_1.time_ and arg_616_1.time_ <= var_619_54 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0

				arg_616_1.dialog_:SetActive(true)

				arg_616_1.dialogCg_.alpha = 0

				local var_619_56 = LeanTween.value(arg_616_1.dialog_, 0, 1, 0.3)

				var_619_56:setOnUpdate(LuaHelper.FloatAction(function(arg_620_0)
					arg_616_1.dialogCg_.alpha = arg_620_0
				end))
				var_619_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_616_1.dialog_)
					var_619_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_616_1.duration_ = arg_616_1.duration_ + 0.3

				SetActive(arg_616_1.leftNameGo_, false)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_57 = arg_616_1:GetWordFromCfg(1107506152)
				local var_619_58 = arg_616_1:FormatText(var_619_57.content)

				arg_616_1.text_.text = var_619_58

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_59 = 34
				local var_619_60 = utf8.len(var_619_58)
				local var_619_61 = var_619_59 <= 0 and var_619_55 or var_619_55 * (var_619_60 / var_619_59)

				if var_619_61 > 0 and var_619_55 < var_619_61 then
					arg_616_1.talkMaxDuration = var_619_61
					var_619_54 = var_619_54 + 0.3

					if var_619_61 + var_619_54 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_61 + var_619_54
					end
				end

				arg_616_1.text_.text = var_619_58
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)
				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_62 = var_619_54 + 0.3
			local var_619_63 = math.max(var_619_55, arg_616_1.talkMaxDuration)

			if var_619_62 <= arg_616_1.time_ and arg_616_1.time_ < var_619_62 + var_619_63 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_62) / var_619_63

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_62 + var_619_63 and arg_616_1.time_ < var_619_62 + var_619_63 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play1107506153 = function(arg_622_0, arg_622_1)
		arg_622_1.time_ = 0
		arg_622_1.frameCnt_ = 0
		arg_622_1.state_ = "playing"
		arg_622_1.curTalkId_ = 1107506153
		arg_622_1.duration_ = 5

		SetActive(arg_622_1.tipsGo_, false)

		function arg_622_1.onSingleLineFinish_()
			arg_622_1.onSingleLineUpdate_ = nil
			arg_622_1.onSingleLineFinish_ = nil
			arg_622_1.state_ = "waiting"
		end

		function arg_622_1.playNext_(arg_624_0)
			if arg_624_0 == 1 then
				arg_622_0:Play1107506154(arg_622_1)
			end
		end

		function arg_622_1.onSingleLineUpdate_(arg_625_0)
			local var_625_0 = 0
			local var_625_1 = 0.475

			if var_625_0 < arg_622_1.time_ and arg_622_1.time_ <= var_625_0 + arg_625_0 then
				arg_622_1.talkMaxDuration = 0
				arg_622_1.dialogCg_.alpha = 1

				arg_622_1.dialog_:SetActive(true)
				SetActive(arg_622_1.leftNameGo_, true)

				local var_625_2 = arg_622_1:FormatText(StoryNameCfg[7].name)

				arg_622_1.leftNameTxt_.text = var_625_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_622_1.leftNameTxt_.transform)

				arg_622_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_622_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_622_1:RecordName(arg_622_1.leftNameTxt_.text)
				SetActive(arg_622_1.iconTrs_.gameObject, true)
				arg_622_1.iconController_:SetSelectedState("hero")

				arg_622_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_622_1.callingController_:SetSelectedState("normal")

				arg_622_1.keyicon_.color = Color.New(1, 1, 1)
				arg_622_1.icon_.color = Color.New(1, 1, 1)

				local var_625_3 = arg_622_1:GetWordFromCfg(1107506153)
				local var_625_4 = arg_622_1:FormatText(var_625_3.content)

				arg_622_1.text_.text = var_625_4

				LuaForUtil.ClearLinePrefixSymbol(arg_622_1.text_)

				local var_625_5 = 19
				local var_625_6 = utf8.len(var_625_4)
				local var_625_7 = var_625_5 <= 0 and var_625_1 or var_625_1 * (var_625_6 / var_625_5)

				if var_625_7 > 0 and var_625_1 < var_625_7 then
					arg_622_1.talkMaxDuration = var_625_7

					if var_625_7 + var_625_0 > arg_622_1.duration_ then
						arg_622_1.duration_ = var_625_7 + var_625_0
					end
				end

				arg_622_1.text_.text = var_625_4
				arg_622_1.typewritter.percent = 0

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(false)
				arg_622_1:RecordContent(arg_622_1.text_.text)
			end

			local var_625_8 = math.max(var_625_1, arg_622_1.talkMaxDuration)

			if var_625_0 <= arg_622_1.time_ and arg_622_1.time_ < var_625_0 + var_625_8 then
				arg_622_1.typewritter.percent = (arg_622_1.time_ - var_625_0) / var_625_8

				arg_622_1.typewritter:SetDirty()
			end

			if arg_622_1.time_ >= var_625_0 + var_625_8 and arg_622_1.time_ < var_625_0 + var_625_8 + arg_625_0 then
				arg_622_1.typewritter.percent = 1

				arg_622_1.typewritter:SetDirty()
				arg_622_1:ShowNextGo(true)
			end
		end

		arg_622_1.nodeConfigList_ = {}

		arg_622_1:InitPlayNodeList()
	end,
	Play1107506154 = function(arg_626_0, arg_626_1)
		arg_626_1.time_ = 0
		arg_626_1.frameCnt_ = 0
		arg_626_1.state_ = "playing"
		arg_626_1.curTalkId_ = 1107506154
		arg_626_1.duration_ = 5

		SetActive(arg_626_1.tipsGo_, false)

		function arg_626_1.onSingleLineFinish_()
			arg_626_1.onSingleLineUpdate_ = nil
			arg_626_1.onSingleLineFinish_ = nil
			arg_626_1.state_ = "waiting"
		end

		function arg_626_1.playNext_(arg_628_0)
			if arg_628_0 == 1 then
				arg_626_0:Play1107506155(arg_626_1)
			end
		end

		function arg_626_1.onSingleLineUpdate_(arg_629_0)
			local var_629_0 = 0
			local var_629_1 = 0.15

			if var_629_0 < arg_626_1.time_ and arg_626_1.time_ <= var_629_0 + arg_629_0 then
				arg_626_1.talkMaxDuration = 0
				arg_626_1.dialogCg_.alpha = 1

				arg_626_1.dialog_:SetActive(true)
				SetActive(arg_626_1.leftNameGo_, true)

				local var_629_2 = arg_626_1:FormatText(StoryNameCfg[7].name)

				arg_626_1.leftNameTxt_.text = var_629_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_626_1.leftNameTxt_.transform)

				arg_626_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_626_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_626_1:RecordName(arg_626_1.leftNameTxt_.text)
				SetActive(arg_626_1.iconTrs_.gameObject, true)
				arg_626_1.iconController_:SetSelectedState("hero")

				arg_626_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_626_1.callingController_:SetSelectedState("normal")

				arg_626_1.keyicon_.color = Color.New(1, 1, 1)
				arg_626_1.icon_.color = Color.New(1, 1, 1)

				local var_629_3 = arg_626_1:GetWordFromCfg(1107506154)
				local var_629_4 = arg_626_1:FormatText(var_629_3.content)

				arg_626_1.text_.text = var_629_4

				LuaForUtil.ClearLinePrefixSymbol(arg_626_1.text_)

				local var_629_5 = 6
				local var_629_6 = utf8.len(var_629_4)
				local var_629_7 = var_629_5 <= 0 and var_629_1 or var_629_1 * (var_629_6 / var_629_5)

				if var_629_7 > 0 and var_629_1 < var_629_7 then
					arg_626_1.talkMaxDuration = var_629_7

					if var_629_7 + var_629_0 > arg_626_1.duration_ then
						arg_626_1.duration_ = var_629_7 + var_629_0
					end
				end

				arg_626_1.text_.text = var_629_4
				arg_626_1.typewritter.percent = 0

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(false)
				arg_626_1:RecordContent(arg_626_1.text_.text)
			end

			local var_629_8 = math.max(var_629_1, arg_626_1.talkMaxDuration)

			if var_629_0 <= arg_626_1.time_ and arg_626_1.time_ < var_629_0 + var_629_8 then
				arg_626_1.typewritter.percent = (arg_626_1.time_ - var_629_0) / var_629_8

				arg_626_1.typewritter:SetDirty()
			end

			if arg_626_1.time_ >= var_629_0 + var_629_8 and arg_626_1.time_ < var_629_0 + var_629_8 + arg_629_0 then
				arg_626_1.typewritter.percent = 1

				arg_626_1.typewritter:SetDirty()
				arg_626_1:ShowNextGo(true)
			end
		end

		arg_626_1.nodeConfigList_ = {}

		arg_626_1:InitPlayNodeList()
	end,
	Play1107506155 = function(arg_630_0, arg_630_1)
		arg_630_1.time_ = 0
		arg_630_1.frameCnt_ = 0
		arg_630_1.state_ = "playing"
		arg_630_1.curTalkId_ = 1107506155
		arg_630_1.duration_ = 5

		SetActive(arg_630_1.tipsGo_, false)

		function arg_630_1.onSingleLineFinish_()
			arg_630_1.onSingleLineUpdate_ = nil
			arg_630_1.onSingleLineFinish_ = nil
			arg_630_1.state_ = "waiting"
		end

		function arg_630_1.playNext_(arg_632_0)
			if arg_632_0 == 1 then
				arg_630_0:Play1107506156(arg_630_1)
			end
		end

		function arg_630_1.onSingleLineUpdate_(arg_633_0)
			local var_633_0 = 0
			local var_633_1 = 0.675

			if var_633_0 < arg_630_1.time_ and arg_630_1.time_ <= var_633_0 + arg_633_0 then
				arg_630_1.talkMaxDuration = 0
				arg_630_1.dialogCg_.alpha = 1

				arg_630_1.dialog_:SetActive(true)
				SetActive(arg_630_1.leftNameGo_, false)

				arg_630_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_630_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_630_1:RecordName(arg_630_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_630_1.iconTrs_.gameObject, false)
				arg_630_1.callingController_:SetSelectedState("normal")

				local var_633_2 = arg_630_1:GetWordFromCfg(1107506155)
				local var_633_3 = arg_630_1:FormatText(var_633_2.content)

				arg_630_1.text_.text = var_633_3

				LuaForUtil.ClearLinePrefixSymbol(arg_630_1.text_)

				local var_633_4 = 28
				local var_633_5 = utf8.len(var_633_3)
				local var_633_6 = var_633_4 <= 0 and var_633_1 or var_633_1 * (var_633_5 / var_633_4)

				if var_633_6 > 0 and var_633_1 < var_633_6 then
					arg_630_1.talkMaxDuration = var_633_6

					if var_633_6 + var_633_0 > arg_630_1.duration_ then
						arg_630_1.duration_ = var_633_6 + var_633_0
					end
				end

				arg_630_1.text_.text = var_633_3
				arg_630_1.typewritter.percent = 0

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(false)
				arg_630_1:RecordContent(arg_630_1.text_.text)
			end

			local var_633_7 = math.max(var_633_1, arg_630_1.talkMaxDuration)

			if var_633_0 <= arg_630_1.time_ and arg_630_1.time_ < var_633_0 + var_633_7 then
				arg_630_1.typewritter.percent = (arg_630_1.time_ - var_633_0) / var_633_7

				arg_630_1.typewritter:SetDirty()
			end

			if arg_630_1.time_ >= var_633_0 + var_633_7 and arg_630_1.time_ < var_633_0 + var_633_7 + arg_633_0 then
				arg_630_1.typewritter.percent = 1

				arg_630_1.typewritter:SetDirty()
				arg_630_1:ShowNextGo(true)
			end
		end

		arg_630_1.nodeConfigList_ = {}

		arg_630_1:InitPlayNodeList()
	end,
	Play1107506156 = function(arg_634_0, arg_634_1)
		arg_634_1.time_ = 0
		arg_634_1.frameCnt_ = 0
		arg_634_1.state_ = "playing"
		arg_634_1.curTalkId_ = 1107506156
		arg_634_1.duration_ = 5

		SetActive(arg_634_1.tipsGo_, false)

		function arg_634_1.onSingleLineFinish_()
			arg_634_1.onSingleLineUpdate_ = nil
			arg_634_1.onSingleLineFinish_ = nil
			arg_634_1.state_ = "waiting"
		end

		function arg_634_1.playNext_(arg_636_0)
			if arg_636_0 == 1 then
				arg_634_0:Play1107506157(arg_634_1)
			end
		end

		function arg_634_1.onSingleLineUpdate_(arg_637_0)
			local var_637_0 = 0
			local var_637_1 = 0.475

			if var_637_0 < arg_634_1.time_ and arg_634_1.time_ <= var_637_0 + arg_637_0 then
				arg_634_1.talkMaxDuration = 0
				arg_634_1.dialogCg_.alpha = 1

				arg_634_1.dialog_:SetActive(true)
				SetActive(arg_634_1.leftNameGo_, true)

				local var_637_2 = arg_634_1:FormatText(StoryNameCfg[7].name)

				arg_634_1.leftNameTxt_.text = var_637_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_634_1.leftNameTxt_.transform)

				arg_634_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_634_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_634_1:RecordName(arg_634_1.leftNameTxt_.text)
				SetActive(arg_634_1.iconTrs_.gameObject, true)
				arg_634_1.iconController_:SetSelectedState("hero")

				arg_634_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_634_1.callingController_:SetSelectedState("normal")

				arg_634_1.keyicon_.color = Color.New(1, 1, 1)
				arg_634_1.icon_.color = Color.New(1, 1, 1)

				local var_637_3 = arg_634_1:GetWordFromCfg(1107506156)
				local var_637_4 = arg_634_1:FormatText(var_637_3.content)

				arg_634_1.text_.text = var_637_4

				LuaForUtil.ClearLinePrefixSymbol(arg_634_1.text_)

				local var_637_5 = 19
				local var_637_6 = utf8.len(var_637_4)
				local var_637_7 = var_637_5 <= 0 and var_637_1 or var_637_1 * (var_637_6 / var_637_5)

				if var_637_7 > 0 and var_637_1 < var_637_7 then
					arg_634_1.talkMaxDuration = var_637_7

					if var_637_7 + var_637_0 > arg_634_1.duration_ then
						arg_634_1.duration_ = var_637_7 + var_637_0
					end
				end

				arg_634_1.text_.text = var_637_4
				arg_634_1.typewritter.percent = 0

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(false)
				arg_634_1:RecordContent(arg_634_1.text_.text)
			end

			local var_637_8 = math.max(var_637_1, arg_634_1.talkMaxDuration)

			if var_637_0 <= arg_634_1.time_ and arg_634_1.time_ < var_637_0 + var_637_8 then
				arg_634_1.typewritter.percent = (arg_634_1.time_ - var_637_0) / var_637_8

				arg_634_1.typewritter:SetDirty()
			end

			if arg_634_1.time_ >= var_637_0 + var_637_8 and arg_634_1.time_ < var_637_0 + var_637_8 + arg_637_0 then
				arg_634_1.typewritter.percent = 1

				arg_634_1.typewritter:SetDirty()
				arg_634_1:ShowNextGo(true)
			end
		end

		arg_634_1.nodeConfigList_ = {}

		arg_634_1:InitPlayNodeList()
	end,
	Play1107506157 = function(arg_638_0, arg_638_1)
		arg_638_1.time_ = 0
		arg_638_1.frameCnt_ = 0
		arg_638_1.state_ = "playing"
		arg_638_1.curTalkId_ = 1107506157
		arg_638_1.duration_ = 5

		SetActive(arg_638_1.tipsGo_, false)

		function arg_638_1.onSingleLineFinish_()
			arg_638_1.onSingleLineUpdate_ = nil
			arg_638_1.onSingleLineFinish_ = nil
			arg_638_1.state_ = "waiting"
		end

		function arg_638_1.playNext_(arg_640_0)
			if arg_640_0 == 1 then
				arg_638_0:Play1107506158(arg_638_1)
			end
		end

		function arg_638_1.onSingleLineUpdate_(arg_641_0)
			local var_641_0 = 0
			local var_641_1 = 0.775

			if var_641_0 < arg_638_1.time_ and arg_638_1.time_ <= var_641_0 + arg_641_0 then
				arg_638_1.talkMaxDuration = 0
				arg_638_1.dialogCg_.alpha = 1

				arg_638_1.dialog_:SetActive(true)
				SetActive(arg_638_1.leftNameGo_, false)

				arg_638_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_638_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_638_1:RecordName(arg_638_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_638_1.iconTrs_.gameObject, false)
				arg_638_1.callingController_:SetSelectedState("normal")

				local var_641_2 = arg_638_1:GetWordFromCfg(1107506157)
				local var_641_3 = arg_638_1:FormatText(var_641_2.content)

				arg_638_1.text_.text = var_641_3

				LuaForUtil.ClearLinePrefixSymbol(arg_638_1.text_)

				local var_641_4 = 31
				local var_641_5 = utf8.len(var_641_3)
				local var_641_6 = var_641_4 <= 0 and var_641_1 or var_641_1 * (var_641_5 / var_641_4)

				if var_641_6 > 0 and var_641_1 < var_641_6 then
					arg_638_1.talkMaxDuration = var_641_6

					if var_641_6 + var_641_0 > arg_638_1.duration_ then
						arg_638_1.duration_ = var_641_6 + var_641_0
					end
				end

				arg_638_1.text_.text = var_641_3
				arg_638_1.typewritter.percent = 0

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(false)
				arg_638_1:RecordContent(arg_638_1.text_.text)
			end

			local var_641_7 = math.max(var_641_1, arg_638_1.talkMaxDuration)

			if var_641_0 <= arg_638_1.time_ and arg_638_1.time_ < var_641_0 + var_641_7 then
				arg_638_1.typewritter.percent = (arg_638_1.time_ - var_641_0) / var_641_7

				arg_638_1.typewritter:SetDirty()
			end

			if arg_638_1.time_ >= var_641_0 + var_641_7 and arg_638_1.time_ < var_641_0 + var_641_7 + arg_641_0 then
				arg_638_1.typewritter.percent = 1

				arg_638_1.typewritter:SetDirty()
				arg_638_1:ShowNextGo(true)
			end
		end

		arg_638_1.nodeConfigList_ = {}

		arg_638_1:InitPlayNodeList()
	end,
	Play1107506158 = function(arg_642_0, arg_642_1)
		arg_642_1.time_ = 0
		arg_642_1.frameCnt_ = 0
		arg_642_1.state_ = "playing"
		arg_642_1.curTalkId_ = 1107506158
		arg_642_1.duration_ = 2.27

		SetActive(arg_642_1.tipsGo_, false)

		function arg_642_1.onSingleLineFinish_()
			arg_642_1.onSingleLineUpdate_ = nil
			arg_642_1.onSingleLineFinish_ = nil
			arg_642_1.state_ = "waiting"
		end

		function arg_642_1.playNext_(arg_644_0)
			if arg_644_0 == 1 then
				arg_642_0:Play1107506159(arg_642_1)
			end
		end

		function arg_642_1.onSingleLineUpdate_(arg_645_0)
			local var_645_0 = arg_642_1.actors_["1075ui_actor"]
			local var_645_1 = 0

			if var_645_1 < arg_642_1.time_ and arg_642_1.time_ <= var_645_1 + arg_645_0 and not isNil(var_645_0) and arg_642_1.var_.characterEffect1075ui_actor == nil then
				arg_642_1.var_.characterEffect1075ui_actor = var_645_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_645_2 = 0.200000002980232

			if var_645_1 <= arg_642_1.time_ and arg_642_1.time_ < var_645_1 + var_645_2 and not isNil(var_645_0) then
				local var_645_3 = (arg_642_1.time_ - var_645_1) / var_645_2

				if arg_642_1.var_.characterEffect1075ui_actor and not isNil(var_645_0) then
					arg_642_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_642_1.time_ >= var_645_1 + var_645_2 and arg_642_1.time_ < var_645_1 + var_645_2 + arg_645_0 and not isNil(var_645_0) and arg_642_1.var_.characterEffect1075ui_actor then
				arg_642_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_645_4 = 0
			local var_645_5 = 0.075

			if var_645_4 < arg_642_1.time_ and arg_642_1.time_ <= var_645_4 + arg_645_0 then
				arg_642_1.talkMaxDuration = 0
				arg_642_1.dialogCg_.alpha = 1

				arg_642_1.dialog_:SetActive(true)
				SetActive(arg_642_1.leftNameGo_, true)

				local var_645_6 = arg_642_1:FormatText(StoryNameCfg[381].name)

				arg_642_1.leftNameTxt_.text = var_645_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_642_1.leftNameTxt_.transform)

				arg_642_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_642_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_642_1:RecordName(arg_642_1.leftNameTxt_.text)
				SetActive(arg_642_1.iconTrs_.gameObject, true)
				arg_642_1.iconController_:SetSelectedState("hero")

				arg_642_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_642_1.callingController_:SetSelectedState("normal")

				arg_642_1.keyicon_.color = Color.New(1, 1, 1)
				arg_642_1.icon_.color = Color.New(1, 1, 1)

				local var_645_7 = arg_642_1:GetWordFromCfg(1107506158)
				local var_645_8 = arg_642_1:FormatText(var_645_7.content)

				arg_642_1.text_.text = var_645_8

				LuaForUtil.ClearLinePrefixSymbol(arg_642_1.text_)

				local var_645_9 = 3
				local var_645_10 = utf8.len(var_645_8)
				local var_645_11 = var_645_9 <= 0 and var_645_5 or var_645_5 * (var_645_10 / var_645_9)

				if var_645_11 > 0 and var_645_5 < var_645_11 then
					arg_642_1.talkMaxDuration = var_645_11

					if var_645_11 + var_645_4 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_11 + var_645_4
					end
				end

				arg_642_1.text_.text = var_645_8
				arg_642_1.typewritter.percent = 0

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506158", "story_v_side_new_1107506.awb") ~= 0 then
					local var_645_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506158", "story_v_side_new_1107506.awb") / 1000

					if var_645_12 + var_645_4 > arg_642_1.duration_ then
						arg_642_1.duration_ = var_645_12 + var_645_4
					end

					if var_645_7.prefab_name ~= "" and arg_642_1.actors_[var_645_7.prefab_name] ~= nil then
						local var_645_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_642_1.actors_[var_645_7.prefab_name].transform, "story_v_side_new_1107506", "1107506158", "story_v_side_new_1107506.awb")

						arg_642_1:RecordAudio("1107506158", var_645_13)
						arg_642_1:RecordAudio("1107506158", var_645_13)
					else
						arg_642_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506158", "story_v_side_new_1107506.awb")
					end

					arg_642_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506158", "story_v_side_new_1107506.awb")
				end

				arg_642_1:RecordContent(arg_642_1.text_.text)
			end

			local var_645_14 = math.max(var_645_5, arg_642_1.talkMaxDuration)

			if var_645_4 <= arg_642_1.time_ and arg_642_1.time_ < var_645_4 + var_645_14 then
				arg_642_1.typewritter.percent = (arg_642_1.time_ - var_645_4) / var_645_14

				arg_642_1.typewritter:SetDirty()
			end

			if arg_642_1.time_ >= var_645_4 + var_645_14 and arg_642_1.time_ < var_645_4 + var_645_14 + arg_645_0 then
				arg_642_1.typewritter.percent = 1

				arg_642_1.typewritter:SetDirty()
				arg_642_1:ShowNextGo(true)
			end
		end

		arg_642_1.nodeConfigList_ = {}

		arg_642_1:InitPlayNodeList()
	end,
	Play1107506159 = function(arg_646_0, arg_646_1)
		arg_646_1.time_ = 0
		arg_646_1.frameCnt_ = 0
		arg_646_1.state_ = "playing"
		arg_646_1.curTalkId_ = 1107506159
		arg_646_1.duration_ = 5

		SetActive(arg_646_1.tipsGo_, false)

		function arg_646_1.onSingleLineFinish_()
			arg_646_1.onSingleLineUpdate_ = nil
			arg_646_1.onSingleLineFinish_ = nil
			arg_646_1.state_ = "waiting"
		end

		function arg_646_1.playNext_(arg_648_0)
			if arg_648_0 == 1 then
				arg_646_0:Play1107506160(arg_646_1)
			end
		end

		function arg_646_1.onSingleLineUpdate_(arg_649_0)
			local var_649_0 = arg_646_1.actors_["1075ui_actor"]
			local var_649_1 = 0

			if var_649_1 < arg_646_1.time_ and arg_646_1.time_ <= var_649_1 + arg_649_0 and not isNil(var_649_0) and arg_646_1.var_.characterEffect1075ui_actor == nil then
				arg_646_1.var_.characterEffect1075ui_actor = var_649_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_649_2 = 0.200000002980232

			if var_649_1 <= arg_646_1.time_ and arg_646_1.time_ < var_649_1 + var_649_2 and not isNil(var_649_0) then
				local var_649_3 = (arg_646_1.time_ - var_649_1) / var_649_2

				if arg_646_1.var_.characterEffect1075ui_actor and not isNil(var_649_0) then
					local var_649_4 = Mathf.Lerp(0, 0.5, var_649_3)

					arg_646_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_646_1.var_.characterEffect1075ui_actor.fillRatio = var_649_4
				end
			end

			if arg_646_1.time_ >= var_649_1 + var_649_2 and arg_646_1.time_ < var_649_1 + var_649_2 + arg_649_0 and not isNil(var_649_0) and arg_646_1.var_.characterEffect1075ui_actor then
				local var_649_5 = 0.5

				arg_646_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_646_1.var_.characterEffect1075ui_actor.fillRatio = var_649_5
			end

			local var_649_6 = 0
			local var_649_7 = 1.1

			if var_649_6 < arg_646_1.time_ and arg_646_1.time_ <= var_649_6 + arg_649_0 then
				arg_646_1.talkMaxDuration = 0
				arg_646_1.dialogCg_.alpha = 1

				arg_646_1.dialog_:SetActive(true)
				SetActive(arg_646_1.leftNameGo_, false)

				arg_646_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_646_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_646_1:RecordName(arg_646_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_646_1.iconTrs_.gameObject, false)
				arg_646_1.callingController_:SetSelectedState("normal")

				local var_649_8 = arg_646_1:GetWordFromCfg(1107506159)
				local var_649_9 = arg_646_1:FormatText(var_649_8.content)

				arg_646_1.text_.text = var_649_9

				LuaForUtil.ClearLinePrefixSymbol(arg_646_1.text_)

				local var_649_10 = 44
				local var_649_11 = utf8.len(var_649_9)
				local var_649_12 = var_649_10 <= 0 and var_649_7 or var_649_7 * (var_649_11 / var_649_10)

				if var_649_12 > 0 and var_649_7 < var_649_12 then
					arg_646_1.talkMaxDuration = var_649_12

					if var_649_12 + var_649_6 > arg_646_1.duration_ then
						arg_646_1.duration_ = var_649_12 + var_649_6
					end
				end

				arg_646_1.text_.text = var_649_9
				arg_646_1.typewritter.percent = 0

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(false)
				arg_646_1:RecordContent(arg_646_1.text_.text)
			end

			local var_649_13 = math.max(var_649_7, arg_646_1.talkMaxDuration)

			if var_649_6 <= arg_646_1.time_ and arg_646_1.time_ < var_649_6 + var_649_13 then
				arg_646_1.typewritter.percent = (arg_646_1.time_ - var_649_6) / var_649_13

				arg_646_1.typewritter:SetDirty()
			end

			if arg_646_1.time_ >= var_649_6 + var_649_13 and arg_646_1.time_ < var_649_6 + var_649_13 + arg_649_0 then
				arg_646_1.typewritter.percent = 1

				arg_646_1.typewritter:SetDirty()
				arg_646_1:ShowNextGo(true)
			end
		end

		arg_646_1.nodeConfigList_ = {}

		arg_646_1:InitPlayNodeList()
	end,
	Play1107506160 = function(arg_650_0, arg_650_1)
		arg_650_1.time_ = 0
		arg_650_1.frameCnt_ = 0
		arg_650_1.state_ = "playing"
		arg_650_1.curTalkId_ = 1107506160
		arg_650_1.duration_ = 9

		SetActive(arg_650_1.tipsGo_, false)

		function arg_650_1.onSingleLineFinish_()
			arg_650_1.onSingleLineUpdate_ = nil
			arg_650_1.onSingleLineFinish_ = nil
			arg_650_1.state_ = "waiting"
		end

		function arg_650_1.playNext_(arg_652_0)
			if arg_652_0 == 1 then
				arg_650_0:Play1107506161(arg_650_1)
			end
		end

		function arg_650_1.onSingleLineUpdate_(arg_653_0)
			local var_653_0 = "R7502"

			if arg_650_1.bgs_[var_653_0] == nil then
				local var_653_1 = Object.Instantiate(arg_650_1.paintGo_)

				var_653_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_653_0)
				var_653_1.name = var_653_0
				var_653_1.transform.parent = arg_650_1.stage_.transform
				var_653_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_650_1.bgs_[var_653_0] = var_653_1
			end

			local var_653_2 = 2

			if var_653_2 < arg_650_1.time_ and arg_650_1.time_ <= var_653_2 + arg_653_0 then
				local var_653_3 = manager.ui.mainCamera.transform.localPosition
				local var_653_4 = Vector3.New(0, 0, 10) + Vector3.New(var_653_3.x, var_653_3.y, 0)
				local var_653_5 = arg_650_1.bgs_.R7502

				var_653_5.transform.localPosition = var_653_4
				var_653_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_653_6 = var_653_5:GetComponent("SpriteRenderer")

				if var_653_6 and var_653_6.sprite then
					local var_653_7 = (var_653_5.transform.localPosition - var_653_3).z
					local var_653_8 = manager.ui.mainCameraCom_
					local var_653_9 = 2 * var_653_7 * Mathf.Tan(var_653_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_653_10 = var_653_9 * var_653_8.aspect
					local var_653_11 = var_653_6.sprite.bounds.size.x
					local var_653_12 = var_653_6.sprite.bounds.size.y
					local var_653_13 = var_653_10 / var_653_11
					local var_653_14 = var_653_9 / var_653_12
					local var_653_15 = var_653_14 < var_653_13 and var_653_13 or var_653_14

					var_653_5.transform.localScale = Vector3.New(var_653_15, var_653_15, 0)
				end

				for iter_653_0, iter_653_1 in pairs(arg_650_1.bgs_) do
					if iter_653_0 ~= "R7502" then
						iter_653_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_653_16 = 4

			if var_653_16 < arg_650_1.time_ and arg_650_1.time_ <= var_653_16 + arg_653_0 then
				arg_650_1.allBtn_.enabled = false
			end

			local var_653_17 = 0.3

			if arg_650_1.time_ >= var_653_16 + var_653_17 and arg_650_1.time_ < var_653_16 + var_653_17 + arg_653_0 then
				arg_650_1.allBtn_.enabled = true
			end

			local var_653_18 = 0

			if var_653_18 < arg_650_1.time_ and arg_650_1.time_ <= var_653_18 + arg_653_0 then
				arg_650_1.mask_.enabled = true
				arg_650_1.mask_.raycastTarget = true

				arg_650_1:SetGaussion(false)
			end

			local var_653_19 = 2

			if var_653_18 <= arg_650_1.time_ and arg_650_1.time_ < var_653_18 + var_653_19 then
				local var_653_20 = (arg_650_1.time_ - var_653_18) / var_653_19
				local var_653_21 = Color.New(0, 0, 0)

				var_653_21.a = Mathf.Lerp(0, 1, var_653_20)
				arg_650_1.mask_.color = var_653_21
			end

			if arg_650_1.time_ >= var_653_18 + var_653_19 and arg_650_1.time_ < var_653_18 + var_653_19 + arg_653_0 then
				local var_653_22 = Color.New(0, 0, 0)

				var_653_22.a = 1
				arg_650_1.mask_.color = var_653_22
			end

			local var_653_23 = 2

			if var_653_23 < arg_650_1.time_ and arg_650_1.time_ <= var_653_23 + arg_653_0 then
				arg_650_1.mask_.enabled = true
				arg_650_1.mask_.raycastTarget = true

				arg_650_1:SetGaussion(false)
			end

			local var_653_24 = 2

			if var_653_23 <= arg_650_1.time_ and arg_650_1.time_ < var_653_23 + var_653_24 then
				local var_653_25 = (arg_650_1.time_ - var_653_23) / var_653_24
				local var_653_26 = Color.New(0, 0, 0)

				var_653_26.a = Mathf.Lerp(1, 0, var_653_25)
				arg_650_1.mask_.color = var_653_26
			end

			if arg_650_1.time_ >= var_653_23 + var_653_24 and arg_650_1.time_ < var_653_23 + var_653_24 + arg_653_0 then
				local var_653_27 = Color.New(0, 0, 0)
				local var_653_28 = 0

				arg_650_1.mask_.enabled = false
				var_653_27.a = var_653_28
				arg_650_1.mask_.color = var_653_27
			end

			local var_653_29 = arg_650_1.bgs_.R7502.transform
			local var_653_30 = 2

			if var_653_30 < arg_650_1.time_ and arg_650_1.time_ <= var_653_30 + arg_653_0 then
				arg_650_1.var_.moveOldPosR7502 = var_653_29.localPosition
			end

			local var_653_31 = 0.001

			if var_653_30 <= arg_650_1.time_ and arg_650_1.time_ < var_653_30 + var_653_31 then
				local var_653_32 = (arg_650_1.time_ - var_653_30) / var_653_31
				local var_653_33 = Vector3.New(-1.5, 0.15, 5)

				var_653_29.localPosition = Vector3.Lerp(arg_650_1.var_.moveOldPosR7502, var_653_33, var_653_32)
			end

			if arg_650_1.time_ >= var_653_30 + var_653_31 and arg_650_1.time_ < var_653_30 + var_653_31 + arg_653_0 then
				var_653_29.localPosition = Vector3.New(-1.5, 0.15, 5)
			end

			local var_653_34 = arg_650_1.bgs_.R7502.transform
			local var_653_35 = 2.01666666666667

			if var_653_35 < arg_650_1.time_ and arg_650_1.time_ <= var_653_35 + arg_653_0 then
				arg_650_1.var_.moveOldPosR7502 = var_653_34.localPosition
			end

			local var_653_36 = 5.5

			if var_653_35 <= arg_650_1.time_ and arg_650_1.time_ < var_653_35 + var_653_36 then
				local var_653_37 = (arg_650_1.time_ - var_653_35) / var_653_36
				local var_653_38 = Vector3.New(-1.5, 0.15, 5.5)

				var_653_34.localPosition = Vector3.Lerp(arg_650_1.var_.moveOldPosR7502, var_653_38, var_653_37)
			end

			if arg_650_1.time_ >= var_653_35 + var_653_36 and arg_650_1.time_ < var_653_35 + var_653_36 + arg_653_0 then
				var_653_34.localPosition = Vector3.New(-1.5, 0.15, 5.5)
			end

			local var_653_39 = 4

			if var_653_39 < arg_650_1.time_ and arg_650_1.time_ <= var_653_39 + arg_653_0 then
				arg_650_1.allBtn_.enabled = false
			end

			local var_653_40 = 3.51666666666667

			if arg_650_1.time_ >= var_653_39 + var_653_40 and arg_650_1.time_ < var_653_39 + var_653_40 + arg_653_0 then
				arg_650_1.allBtn_.enabled = true
			end

			if arg_650_1.frameCnt_ <= 1 then
				arg_650_1.dialog_:SetActive(false)
			end

			local var_653_41 = 4
			local var_653_42 = 0.15

			if var_653_41 < arg_650_1.time_ and arg_650_1.time_ <= var_653_41 + arg_653_0 then
				arg_650_1.talkMaxDuration = 0

				arg_650_1.dialog_:SetActive(true)

				arg_650_1.dialogCg_.alpha = 0

				local var_653_43 = LeanTween.value(arg_650_1.dialog_, 0, 1, 0.3)

				var_653_43:setOnUpdate(LuaHelper.FloatAction(function(arg_654_0)
					arg_650_1.dialogCg_.alpha = arg_654_0
				end))
				var_653_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_650_1.dialog_)
					var_653_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_650_1.duration_ = arg_650_1.duration_ + 0.3

				SetActive(arg_650_1.leftNameGo_, true)

				local var_653_44 = arg_650_1:FormatText(StoryNameCfg[7].name)

				arg_650_1.leftNameTxt_.text = var_653_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_650_1.leftNameTxt_.transform)

				arg_650_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_650_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_650_1:RecordName(arg_650_1.leftNameTxt_.text)
				SetActive(arg_650_1.iconTrs_.gameObject, true)
				arg_650_1.iconController_:SetSelectedState("hero")

				arg_650_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_650_1.callingController_:SetSelectedState("normal")

				arg_650_1.keyicon_.color = Color.New(1, 1, 1)
				arg_650_1.icon_.color = Color.New(1, 1, 1)

				local var_653_45 = arg_650_1:GetWordFromCfg(1107506160)
				local var_653_46 = arg_650_1:FormatText(var_653_45.content)

				arg_650_1.text_.text = var_653_46

				LuaForUtil.ClearLinePrefixSymbol(arg_650_1.text_)

				local var_653_47 = 6
				local var_653_48 = utf8.len(var_653_46)
				local var_653_49 = var_653_47 <= 0 and var_653_42 or var_653_42 * (var_653_48 / var_653_47)

				if var_653_49 > 0 and var_653_42 < var_653_49 then
					arg_650_1.talkMaxDuration = var_653_49
					var_653_41 = var_653_41 + 0.3

					if var_653_49 + var_653_41 > arg_650_1.duration_ then
						arg_650_1.duration_ = var_653_49 + var_653_41
					end
				end

				arg_650_1.text_.text = var_653_46
				arg_650_1.typewritter.percent = 0

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(false)
				arg_650_1:RecordContent(arg_650_1.text_.text)
			end

			local var_653_50 = var_653_41 + 0.3
			local var_653_51 = math.max(var_653_42, arg_650_1.talkMaxDuration)

			if var_653_50 <= arg_650_1.time_ and arg_650_1.time_ < var_653_50 + var_653_51 then
				arg_650_1.typewritter.percent = (arg_650_1.time_ - var_653_50) / var_653_51

				arg_650_1.typewritter:SetDirty()
			end

			if arg_650_1.time_ >= var_653_50 + var_653_51 and arg_650_1.time_ < var_653_50 + var_653_51 + arg_653_0 then
				arg_650_1.typewritter.percent = 1

				arg_650_1.typewritter:SetDirty()
				arg_650_1:ShowNextGo(true)
			end
		end

		arg_650_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R7502",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R7502",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5.5,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_650_1:InitPlayNodeList()
	end,
	Play1107506161 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 1107506161
		arg_656_1.duration_ = 4.17

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play1107506162(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = arg_656_1.actors_["1075ui_actor"]
			local var_659_1 = 0

			if var_659_1 < arg_656_1.time_ and arg_656_1.time_ <= var_659_1 + arg_659_0 and not isNil(var_659_0) and arg_656_1.var_.characterEffect1075ui_actor == nil then
				arg_656_1.var_.characterEffect1075ui_actor = var_659_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_659_2 = 0.200000002980232

			if var_659_1 <= arg_656_1.time_ and arg_656_1.time_ < var_659_1 + var_659_2 and not isNil(var_659_0) then
				local var_659_3 = (arg_656_1.time_ - var_659_1) / var_659_2

				if arg_656_1.var_.characterEffect1075ui_actor and not isNil(var_659_0) then
					arg_656_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_656_1.time_ >= var_659_1 + var_659_2 and arg_656_1.time_ < var_659_1 + var_659_2 + arg_659_0 and not isNil(var_659_0) and arg_656_1.var_.characterEffect1075ui_actor then
				arg_656_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_659_4 = 0
			local var_659_5 = 0.25

			if var_659_4 < arg_656_1.time_ and arg_656_1.time_ <= var_659_4 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				local var_659_6 = arg_656_1:FormatText(StoryNameCfg[381].name)

				arg_656_1.leftNameTxt_.text = var_659_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_7 = arg_656_1:GetWordFromCfg(1107506161)
				local var_659_8 = arg_656_1:FormatText(var_659_7.content)

				arg_656_1.text_.text = var_659_8

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_9 = 10
				local var_659_10 = utf8.len(var_659_8)
				local var_659_11 = var_659_9 <= 0 and var_659_5 or var_659_5 * (var_659_10 / var_659_9)

				if var_659_11 > 0 and var_659_5 < var_659_11 then
					arg_656_1.talkMaxDuration = var_659_11

					if var_659_11 + var_659_4 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_11 + var_659_4
					end
				end

				arg_656_1.text_.text = var_659_8
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506161", "story_v_side_new_1107506.awb") ~= 0 then
					local var_659_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506161", "story_v_side_new_1107506.awb") / 1000

					if var_659_12 + var_659_4 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_12 + var_659_4
					end

					if var_659_7.prefab_name ~= "" and arg_656_1.actors_[var_659_7.prefab_name] ~= nil then
						local var_659_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_656_1.actors_[var_659_7.prefab_name].transform, "story_v_side_new_1107506", "1107506161", "story_v_side_new_1107506.awb")

						arg_656_1:RecordAudio("1107506161", var_659_13)
						arg_656_1:RecordAudio("1107506161", var_659_13)
					else
						arg_656_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506161", "story_v_side_new_1107506.awb")
					end

					arg_656_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506161", "story_v_side_new_1107506.awb")
				end

				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_14 = math.max(var_659_5, arg_656_1.talkMaxDuration)

			if var_659_4 <= arg_656_1.time_ and arg_656_1.time_ < var_659_4 + var_659_14 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_4) / var_659_14

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_4 + var_659_14 and arg_656_1.time_ < var_659_4 + var_659_14 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {}

		arg_656_1:InitPlayNodeList()
	end,
	Play1107506162 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1107506162
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play1107506163(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = arg_660_1.actors_["1075ui_actor"]
			local var_663_1 = 0

			if var_663_1 < arg_660_1.time_ and arg_660_1.time_ <= var_663_1 + arg_663_0 and not isNil(var_663_0) and arg_660_1.var_.characterEffect1075ui_actor == nil then
				arg_660_1.var_.characterEffect1075ui_actor = var_663_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_663_2 = 0.200000002980232

			if var_663_1 <= arg_660_1.time_ and arg_660_1.time_ < var_663_1 + var_663_2 and not isNil(var_663_0) then
				local var_663_3 = (arg_660_1.time_ - var_663_1) / var_663_2

				if arg_660_1.var_.characterEffect1075ui_actor and not isNil(var_663_0) then
					local var_663_4 = Mathf.Lerp(0, 0.5, var_663_3)

					arg_660_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_660_1.var_.characterEffect1075ui_actor.fillRatio = var_663_4
				end
			end

			if arg_660_1.time_ >= var_663_1 + var_663_2 and arg_660_1.time_ < var_663_1 + var_663_2 + arg_663_0 and not isNil(var_663_0) and arg_660_1.var_.characterEffect1075ui_actor then
				local var_663_5 = 0.5

				arg_660_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_660_1.var_.characterEffect1075ui_actor.fillRatio = var_663_5
			end

			local var_663_6 = 0
			local var_663_7 = 0.175

			if var_663_6 < arg_660_1.time_ and arg_660_1.time_ <= var_663_6 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, true)

				local var_663_8 = arg_660_1:FormatText(StoryNameCfg[7].name)

				arg_660_1.leftNameTxt_.text = var_663_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_660_1.leftNameTxt_.transform)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1.leftNameTxt_.text)
				SetActive(arg_660_1.iconTrs_.gameObject, true)
				arg_660_1.iconController_:SetSelectedState("hero")

				arg_660_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_660_1.callingController_:SetSelectedState("normal")

				arg_660_1.keyicon_.color = Color.New(1, 1, 1)
				arg_660_1.icon_.color = Color.New(1, 1, 1)

				local var_663_9 = arg_660_1:GetWordFromCfg(1107506162)
				local var_663_10 = arg_660_1:FormatText(var_663_9.content)

				arg_660_1.text_.text = var_663_10

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_11 = 7
				local var_663_12 = utf8.len(var_663_10)
				local var_663_13 = var_663_11 <= 0 and var_663_7 or var_663_7 * (var_663_12 / var_663_11)

				if var_663_13 > 0 and var_663_7 < var_663_13 then
					arg_660_1.talkMaxDuration = var_663_13

					if var_663_13 + var_663_6 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_13 + var_663_6
					end
				end

				arg_660_1.text_.text = var_663_10
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_14 = math.max(var_663_7, arg_660_1.talkMaxDuration)

			if var_663_6 <= arg_660_1.time_ and arg_660_1.time_ < var_663_6 + var_663_14 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_6) / var_663_14

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_6 + var_663_14 and arg_660_1.time_ < var_663_6 + var_663_14 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play1107506163 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 1107506163
		arg_664_1.duration_ = 5

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play1107506164(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = 0
			local var_667_1 = 0.7

			if var_667_0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_0 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, false)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_2 = arg_664_1:GetWordFromCfg(1107506163)
				local var_667_3 = arg_664_1:FormatText(var_667_2.content)

				arg_664_1.text_.text = var_667_3

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_4 = 28
				local var_667_5 = utf8.len(var_667_3)
				local var_667_6 = var_667_4 <= 0 and var_667_1 or var_667_1 * (var_667_5 / var_667_4)

				if var_667_6 > 0 and var_667_1 < var_667_6 then
					arg_664_1.talkMaxDuration = var_667_6

					if var_667_6 + var_667_0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_6 + var_667_0
					end
				end

				arg_664_1.text_.text = var_667_3
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)
				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_7 = math.max(var_667_1, arg_664_1.talkMaxDuration)

			if var_667_0 <= arg_664_1.time_ and arg_664_1.time_ < var_667_0 + var_667_7 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_0) / var_667_7

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_0 + var_667_7 and arg_664_1.time_ < var_667_0 + var_667_7 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	Play1107506164 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 1107506164
		arg_668_1.duration_ = 2.9

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play1107506165(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			local var_671_0 = arg_668_1.actors_["1075ui_actor"]
			local var_671_1 = 0

			if var_671_1 < arg_668_1.time_ and arg_668_1.time_ <= var_671_1 + arg_671_0 and not isNil(var_671_0) and arg_668_1.var_.characterEffect1075ui_actor == nil then
				arg_668_1.var_.characterEffect1075ui_actor = var_671_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_671_2 = 0.200000002980232

			if var_671_1 <= arg_668_1.time_ and arg_668_1.time_ < var_671_1 + var_671_2 and not isNil(var_671_0) then
				local var_671_3 = (arg_668_1.time_ - var_671_1) / var_671_2

				if arg_668_1.var_.characterEffect1075ui_actor and not isNil(var_671_0) then
					arg_668_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_668_1.time_ >= var_671_1 + var_671_2 and arg_668_1.time_ < var_671_1 + var_671_2 + arg_671_0 and not isNil(var_671_0) and arg_668_1.var_.characterEffect1075ui_actor then
				arg_668_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_671_4 = 0
			local var_671_5 = 0.275

			if var_671_4 < arg_668_1.time_ and arg_668_1.time_ <= var_671_4 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0
				arg_668_1.dialogCg_.alpha = 1

				arg_668_1.dialog_:SetActive(true)
				SetActive(arg_668_1.leftNameGo_, true)

				local var_671_6 = arg_668_1:FormatText(StoryNameCfg[381].name)

				arg_668_1.leftNameTxt_.text = var_671_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, false)
				arg_668_1.callingController_:SetSelectedState("normal")

				local var_671_7 = arg_668_1:GetWordFromCfg(1107506164)
				local var_671_8 = arg_668_1:FormatText(var_671_7.content)

				arg_668_1.text_.text = var_671_8

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_9 = 11
				local var_671_10 = utf8.len(var_671_8)
				local var_671_11 = var_671_9 <= 0 and var_671_5 or var_671_5 * (var_671_10 / var_671_9)

				if var_671_11 > 0 and var_671_5 < var_671_11 then
					arg_668_1.talkMaxDuration = var_671_11

					if var_671_11 + var_671_4 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_11 + var_671_4
					end
				end

				arg_668_1.text_.text = var_671_8
				arg_668_1.typewritter.percent = 0

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506164", "story_v_side_new_1107506.awb") ~= 0 then
					local var_671_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506164", "story_v_side_new_1107506.awb") / 1000

					if var_671_12 + var_671_4 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_12 + var_671_4
					end

					if var_671_7.prefab_name ~= "" and arg_668_1.actors_[var_671_7.prefab_name] ~= nil then
						local var_671_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_668_1.actors_[var_671_7.prefab_name].transform, "story_v_side_new_1107506", "1107506164", "story_v_side_new_1107506.awb")

						arg_668_1:RecordAudio("1107506164", var_671_13)
						arg_668_1:RecordAudio("1107506164", var_671_13)
					else
						arg_668_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506164", "story_v_side_new_1107506.awb")
					end

					arg_668_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506164", "story_v_side_new_1107506.awb")
				end

				arg_668_1:RecordContent(arg_668_1.text_.text)
			end

			local var_671_14 = math.max(var_671_5, arg_668_1.talkMaxDuration)

			if var_671_4 <= arg_668_1.time_ and arg_668_1.time_ < var_671_4 + var_671_14 then
				arg_668_1.typewritter.percent = (arg_668_1.time_ - var_671_4) / var_671_14

				arg_668_1.typewritter:SetDirty()
			end

			if arg_668_1.time_ >= var_671_4 + var_671_14 and arg_668_1.time_ < var_671_4 + var_671_14 + arg_671_0 then
				arg_668_1.typewritter.percent = 1

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(true)
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play1107506165 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 1107506165
		arg_672_1.duration_ = 5

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play1107506166(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			local var_675_0 = arg_672_1.actors_["1075ui_actor"]
			local var_675_1 = 0

			if var_675_1 < arg_672_1.time_ and arg_672_1.time_ <= var_675_1 + arg_675_0 and not isNil(var_675_0) and arg_672_1.var_.characterEffect1075ui_actor == nil then
				arg_672_1.var_.characterEffect1075ui_actor = var_675_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_675_2 = 0.200000002980232

			if var_675_1 <= arg_672_1.time_ and arg_672_1.time_ < var_675_1 + var_675_2 and not isNil(var_675_0) then
				local var_675_3 = (arg_672_1.time_ - var_675_1) / var_675_2

				if arg_672_1.var_.characterEffect1075ui_actor and not isNil(var_675_0) then
					local var_675_4 = Mathf.Lerp(0, 0.5, var_675_3)

					arg_672_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_672_1.var_.characterEffect1075ui_actor.fillRatio = var_675_4
				end
			end

			if arg_672_1.time_ >= var_675_1 + var_675_2 and arg_672_1.time_ < var_675_1 + var_675_2 + arg_675_0 and not isNil(var_675_0) and arg_672_1.var_.characterEffect1075ui_actor then
				local var_675_5 = 0.5

				arg_672_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_672_1.var_.characterEffect1075ui_actor.fillRatio = var_675_5
			end

			local var_675_6 = 0
			local var_675_7 = 0.175

			if var_675_6 < arg_672_1.time_ and arg_672_1.time_ <= var_675_6 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, true)

				local var_675_8 = arg_672_1:FormatText(StoryNameCfg[7].name)

				arg_672_1.leftNameTxt_.text = var_675_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_672_1.leftNameTxt_.transform)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1.leftNameTxt_.text)
				SetActive(arg_672_1.iconTrs_.gameObject, true)
				arg_672_1.iconController_:SetSelectedState("hero")

				arg_672_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_672_1.callingController_:SetSelectedState("normal")

				arg_672_1.keyicon_.color = Color.New(1, 1, 1)
				arg_672_1.icon_.color = Color.New(1, 1, 1)

				local var_675_9 = arg_672_1:GetWordFromCfg(1107506165)
				local var_675_10 = arg_672_1:FormatText(var_675_9.content)

				arg_672_1.text_.text = var_675_10

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_11 = 7
				local var_675_12 = utf8.len(var_675_10)
				local var_675_13 = var_675_11 <= 0 and var_675_7 or var_675_7 * (var_675_12 / var_675_11)

				if var_675_13 > 0 and var_675_7 < var_675_13 then
					arg_672_1.talkMaxDuration = var_675_13

					if var_675_13 + var_675_6 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_13 + var_675_6
					end
				end

				arg_672_1.text_.text = var_675_10
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)
				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_14 = math.max(var_675_7, arg_672_1.talkMaxDuration)

			if var_675_6 <= arg_672_1.time_ and arg_672_1.time_ < var_675_6 + var_675_14 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - var_675_6) / var_675_14

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= var_675_6 + var_675_14 and arg_672_1.time_ < var_675_6 + var_675_14 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play1107506166 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 1107506166
		arg_676_1.duration_ = 5

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play1107506167(arg_676_1)
			end
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			local var_679_0 = 0
			local var_679_1 = 0.65

			if var_679_0 < arg_676_1.time_ and arg_676_1.time_ <= var_679_0 + arg_679_0 then
				arg_676_1.talkMaxDuration = 0
				arg_676_1.dialogCg_.alpha = 1

				arg_676_1.dialog_:SetActive(true)
				SetActive(arg_676_1.leftNameGo_, false)

				arg_676_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_676_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_676_1:RecordName(arg_676_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_676_1.iconTrs_.gameObject, false)
				arg_676_1.callingController_:SetSelectedState("normal")

				local var_679_2 = arg_676_1:GetWordFromCfg(1107506166)
				local var_679_3 = arg_676_1:FormatText(var_679_2.content)

				arg_676_1.text_.text = var_679_3

				LuaForUtil.ClearLinePrefixSymbol(arg_676_1.text_)

				local var_679_4 = 26
				local var_679_5 = utf8.len(var_679_3)
				local var_679_6 = var_679_4 <= 0 and var_679_1 or var_679_1 * (var_679_5 / var_679_4)

				if var_679_6 > 0 and var_679_1 < var_679_6 then
					arg_676_1.talkMaxDuration = var_679_6

					if var_679_6 + var_679_0 > arg_676_1.duration_ then
						arg_676_1.duration_ = var_679_6 + var_679_0
					end
				end

				arg_676_1.text_.text = var_679_3
				arg_676_1.typewritter.percent = 0

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(false)
				arg_676_1:RecordContent(arg_676_1.text_.text)
			end

			local var_679_7 = math.max(var_679_1, arg_676_1.talkMaxDuration)

			if var_679_0 <= arg_676_1.time_ and arg_676_1.time_ < var_679_0 + var_679_7 then
				arg_676_1.typewritter.percent = (arg_676_1.time_ - var_679_0) / var_679_7

				arg_676_1.typewritter:SetDirty()
			end

			if arg_676_1.time_ >= var_679_0 + var_679_7 and arg_676_1.time_ < var_679_0 + var_679_7 + arg_679_0 then
				arg_676_1.typewritter.percent = 1

				arg_676_1.typewritter:SetDirty()
				arg_676_1:ShowNextGo(true)
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play1107506167 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 1107506167
		arg_680_1.duration_ = 5

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
		end

		function arg_680_1.playNext_(arg_682_0)
			if arg_682_0 == 1 then
				arg_680_0:Play1107506168(arg_680_1)
			end
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			local var_683_0 = 0
			local var_683_1 = 0.725

			if var_683_0 < arg_680_1.time_ and arg_680_1.time_ <= var_683_0 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0
				arg_680_1.dialogCg_.alpha = 1

				arg_680_1.dialog_:SetActive(true)
				SetActive(arg_680_1.leftNameGo_, false)

				arg_680_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_680_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_680_1:RecordName(arg_680_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_680_1.iconTrs_.gameObject, false)
				arg_680_1.callingController_:SetSelectedState("normal")

				local var_683_2 = arg_680_1:GetWordFromCfg(1107506167)
				local var_683_3 = arg_680_1:FormatText(var_683_2.content)

				arg_680_1.text_.text = var_683_3

				LuaForUtil.ClearLinePrefixSymbol(arg_680_1.text_)

				local var_683_4 = 29
				local var_683_5 = utf8.len(var_683_3)
				local var_683_6 = var_683_4 <= 0 and var_683_1 or var_683_1 * (var_683_5 / var_683_4)

				if var_683_6 > 0 and var_683_1 < var_683_6 then
					arg_680_1.talkMaxDuration = var_683_6

					if var_683_6 + var_683_0 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_6 + var_683_0
					end
				end

				arg_680_1.text_.text = var_683_3
				arg_680_1.typewritter.percent = 0

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(false)
				arg_680_1:RecordContent(arg_680_1.text_.text)
			end

			local var_683_7 = math.max(var_683_1, arg_680_1.talkMaxDuration)

			if var_683_0 <= arg_680_1.time_ and arg_680_1.time_ < var_683_0 + var_683_7 then
				arg_680_1.typewritter.percent = (arg_680_1.time_ - var_683_0) / var_683_7

				arg_680_1.typewritter:SetDirty()
			end

			if arg_680_1.time_ >= var_683_0 + var_683_7 and arg_680_1.time_ < var_683_0 + var_683_7 + arg_683_0 then
				arg_680_1.typewritter.percent = 1

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(true)
			end
		end

		arg_680_1.nodeConfigList_ = {}

		arg_680_1:InitPlayNodeList()
	end,
	Play1107506168 = function(arg_684_0, arg_684_1)
		arg_684_1.time_ = 0
		arg_684_1.frameCnt_ = 0
		arg_684_1.state_ = "playing"
		arg_684_1.curTalkId_ = 1107506168
		arg_684_1.duration_ = 7.36

		SetActive(arg_684_1.tipsGo_, false)

		function arg_684_1.onSingleLineFinish_()
			arg_684_1.onSingleLineUpdate_ = nil
			arg_684_1.onSingleLineFinish_ = nil
			arg_684_1.state_ = "waiting"
		end

		function arg_684_1.playNext_(arg_686_0)
			if arg_686_0 == 1 then
				arg_684_0:Play1107506169(arg_684_1)
			end
		end

		function arg_684_1.onSingleLineUpdate_(arg_687_0)
			local var_687_0 = "R7502a"

			if arg_684_1.bgs_[var_687_0] == nil then
				local var_687_1 = Object.Instantiate(arg_684_1.paintGo_)

				var_687_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_687_0)
				var_687_1.name = var_687_0
				var_687_1.transform.parent = arg_684_1.stage_.transform
				var_687_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_684_1.bgs_[var_687_0] = var_687_1
			end

			local var_687_2 = 2

			if var_687_2 < arg_684_1.time_ and arg_684_1.time_ <= var_687_2 + arg_687_0 then
				local var_687_3 = manager.ui.mainCamera.transform.localPosition
				local var_687_4 = Vector3.New(0, 0, 10) + Vector3.New(var_687_3.x, var_687_3.y, 0)
				local var_687_5 = arg_684_1.bgs_.R7502a

				var_687_5.transform.localPosition = var_687_4
				var_687_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_687_6 = var_687_5:GetComponent("SpriteRenderer")

				if var_687_6 and var_687_6.sprite then
					local var_687_7 = (var_687_5.transform.localPosition - var_687_3).z
					local var_687_8 = manager.ui.mainCameraCom_
					local var_687_9 = 2 * var_687_7 * Mathf.Tan(var_687_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_687_10 = var_687_9 * var_687_8.aspect
					local var_687_11 = var_687_6.sprite.bounds.size.x
					local var_687_12 = var_687_6.sprite.bounds.size.y
					local var_687_13 = var_687_10 / var_687_11
					local var_687_14 = var_687_9 / var_687_12
					local var_687_15 = var_687_14 < var_687_13 and var_687_13 or var_687_14

					var_687_5.transform.localScale = Vector3.New(var_687_15, var_687_15, 0)
				end

				for iter_687_0, iter_687_1 in pairs(arg_684_1.bgs_) do
					if iter_687_0 ~= "R7502a" then
						iter_687_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_687_16 = 4

			if var_687_16 < arg_684_1.time_ and arg_684_1.time_ <= var_687_16 + arg_687_0 then
				arg_684_1.allBtn_.enabled = false
			end

			local var_687_17 = 0.3

			if arg_684_1.time_ >= var_687_16 + var_687_17 and arg_684_1.time_ < var_687_16 + var_687_17 + arg_687_0 then
				arg_684_1.allBtn_.enabled = true
			end

			local var_687_18 = 0

			if var_687_18 < arg_684_1.time_ and arg_684_1.time_ <= var_687_18 + arg_687_0 then
				arg_684_1.mask_.enabled = true
				arg_684_1.mask_.raycastTarget = true

				arg_684_1:SetGaussion(false)
			end

			local var_687_19 = 2

			if var_687_18 <= arg_684_1.time_ and arg_684_1.time_ < var_687_18 + var_687_19 then
				local var_687_20 = (arg_684_1.time_ - var_687_18) / var_687_19
				local var_687_21 = Color.New(0, 0, 0)

				var_687_21.a = Mathf.Lerp(0, 1, var_687_20)
				arg_684_1.mask_.color = var_687_21
			end

			if arg_684_1.time_ >= var_687_18 + var_687_19 and arg_684_1.time_ < var_687_18 + var_687_19 + arg_687_0 then
				local var_687_22 = Color.New(0, 0, 0)

				var_687_22.a = 1
				arg_684_1.mask_.color = var_687_22
			end

			local var_687_23 = 2

			if var_687_23 < arg_684_1.time_ and arg_684_1.time_ <= var_687_23 + arg_687_0 then
				arg_684_1.mask_.enabled = true
				arg_684_1.mask_.raycastTarget = true

				arg_684_1:SetGaussion(false)
			end

			local var_687_24 = 2

			if var_687_23 <= arg_684_1.time_ and arg_684_1.time_ < var_687_23 + var_687_24 then
				local var_687_25 = (arg_684_1.time_ - var_687_23) / var_687_24
				local var_687_26 = Color.New(0, 0, 0)

				var_687_26.a = Mathf.Lerp(1, 0, var_687_25)
				arg_684_1.mask_.color = var_687_26
			end

			if arg_684_1.time_ >= var_687_23 + var_687_24 and arg_684_1.time_ < var_687_23 + var_687_24 + arg_687_0 then
				local var_687_27 = Color.New(0, 0, 0)
				local var_687_28 = 0

				arg_684_1.mask_.enabled = false
				var_687_27.a = var_687_28
				arg_684_1.mask_.color = var_687_27
			end

			local var_687_29 = arg_684_1.actors_["1075ui_actor"]
			local var_687_30 = 4

			if var_687_30 < arg_684_1.time_ and arg_684_1.time_ <= var_687_30 + arg_687_0 and not isNil(var_687_29) and arg_684_1.var_.characterEffect1075ui_actor == nil then
				arg_684_1.var_.characterEffect1075ui_actor = var_687_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_687_31 = 0.200000002980232

			if var_687_30 <= arg_684_1.time_ and arg_684_1.time_ < var_687_30 + var_687_31 and not isNil(var_687_29) then
				local var_687_32 = (arg_684_1.time_ - var_687_30) / var_687_31

				if arg_684_1.var_.characterEffect1075ui_actor and not isNil(var_687_29) then
					arg_684_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_684_1.time_ >= var_687_30 + var_687_31 and arg_684_1.time_ < var_687_30 + var_687_31 + arg_687_0 and not isNil(var_687_29) and arg_684_1.var_.characterEffect1075ui_actor then
				arg_684_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_687_33 = arg_684_1.bgs_.R7502a.transform
			local var_687_34 = 2

			if var_687_34 < arg_684_1.time_ and arg_684_1.time_ <= var_687_34 + arg_687_0 then
				arg_684_1.var_.moveOldPosR7502a = var_687_33.localPosition
			end

			local var_687_35 = 0.001

			if var_687_34 <= arg_684_1.time_ and arg_684_1.time_ < var_687_34 + var_687_35 then
				local var_687_36 = (arg_684_1.time_ - var_687_34) / var_687_35
				local var_687_37 = Vector3.New(-2.5, -1.15, -2.5)

				var_687_33.localPosition = Vector3.Lerp(arg_684_1.var_.moveOldPosR7502a, var_687_37, var_687_36)
			end

			if arg_684_1.time_ >= var_687_34 + var_687_35 and arg_684_1.time_ < var_687_34 + var_687_35 + arg_687_0 then
				var_687_33.localPosition = Vector3.New(-2.5, -1.15, -2.5)
			end

			local var_687_38 = arg_684_1.bgs_.R7502a.transform
			local var_687_39 = 2.01666666666667

			if var_687_39 < arg_684_1.time_ and arg_684_1.time_ <= var_687_39 + arg_687_0 then
				arg_684_1.var_.moveOldPosR7502a = var_687_38.localPosition
			end

			local var_687_40 = 3

			if var_687_39 <= arg_684_1.time_ and arg_684_1.time_ < var_687_39 + var_687_40 then
				local var_687_41 = (arg_684_1.time_ - var_687_39) / var_687_40
				local var_687_42 = Vector3.New(-2.5, -1.35, -2.5)

				var_687_38.localPosition = Vector3.Lerp(arg_684_1.var_.moveOldPosR7502a, var_687_42, var_687_41)
			end

			if arg_684_1.time_ >= var_687_39 + var_687_40 and arg_684_1.time_ < var_687_39 + var_687_40 + arg_687_0 then
				var_687_38.localPosition = Vector3.New(-2.5, -1.35, -2.5)
			end

			local var_687_43 = 4

			if var_687_43 < arg_684_1.time_ and arg_684_1.time_ <= var_687_43 + arg_687_0 then
				arg_684_1.allBtn_.enabled = false
			end

			local var_687_44 = 1.01666666666667

			if arg_684_1.time_ >= var_687_43 + var_687_44 and arg_684_1.time_ < var_687_43 + var_687_44 + arg_687_0 then
				arg_684_1.allBtn_.enabled = true
			end

			if arg_684_1.frameCnt_ <= 1 then
				arg_684_1.dialog_:SetActive(false)
			end

			local var_687_45 = 4.025
			local var_687_46 = 0.275

			if var_687_45 < arg_684_1.time_ and arg_684_1.time_ <= var_687_45 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0

				arg_684_1.dialog_:SetActive(true)

				arg_684_1.dialogCg_.alpha = 0

				local var_687_47 = LeanTween.value(arg_684_1.dialog_, 0, 1, 0.3)

				var_687_47:setOnUpdate(LuaHelper.FloatAction(function(arg_688_0)
					arg_684_1.dialogCg_.alpha = arg_688_0
				end))
				var_687_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_684_1.dialog_)
					var_687_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_684_1.duration_ = arg_684_1.duration_ + 0.3

				SetActive(arg_684_1.leftNameGo_, true)

				local var_687_48 = arg_684_1:FormatText(StoryNameCfg[381].name)

				arg_684_1.leftNameTxt_.text = var_687_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_684_1.leftNameTxt_.transform)

				arg_684_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_684_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_684_1:RecordName(arg_684_1.leftNameTxt_.text)
				SetActive(arg_684_1.iconTrs_.gameObject, false)
				arg_684_1.callingController_:SetSelectedState("normal")

				local var_687_49 = arg_684_1:GetWordFromCfg(1107506168)
				local var_687_50 = arg_684_1:FormatText(var_687_49.content)

				arg_684_1.text_.text = var_687_50

				LuaForUtil.ClearLinePrefixSymbol(arg_684_1.text_)

				local var_687_51 = 11
				local var_687_52 = utf8.len(var_687_50)
				local var_687_53 = var_687_51 <= 0 and var_687_46 or var_687_46 * (var_687_52 / var_687_51)

				if var_687_53 > 0 and var_687_46 < var_687_53 then
					arg_684_1.talkMaxDuration = var_687_53
					var_687_45 = var_687_45 + 0.3

					if var_687_53 + var_687_45 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_53 + var_687_45
					end
				end

				arg_684_1.text_.text = var_687_50
				arg_684_1.typewritter.percent = 0

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506168", "story_v_side_new_1107506.awb") ~= 0 then
					local var_687_54 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506168", "story_v_side_new_1107506.awb") / 1000

					if var_687_54 + var_687_45 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_54 + var_687_45
					end

					if var_687_49.prefab_name ~= "" and arg_684_1.actors_[var_687_49.prefab_name] ~= nil then
						local var_687_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_684_1.actors_[var_687_49.prefab_name].transform, "story_v_side_new_1107506", "1107506168", "story_v_side_new_1107506.awb")

						arg_684_1:RecordAudio("1107506168", var_687_55)
						arg_684_1:RecordAudio("1107506168", var_687_55)
					else
						arg_684_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506168", "story_v_side_new_1107506.awb")
					end

					arg_684_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506168", "story_v_side_new_1107506.awb")
				end

				arg_684_1:RecordContent(arg_684_1.text_.text)
			end

			local var_687_56 = var_687_45 + 0.3
			local var_687_57 = math.max(var_687_46, arg_684_1.talkMaxDuration)

			if var_687_56 <= arg_684_1.time_ and arg_684_1.time_ < var_687_56 + var_687_57 then
				arg_684_1.typewritter.percent = (arg_684_1.time_ - var_687_56) / var_687_57

				arg_684_1.typewritter:SetDirty()
			end

			if arg_684_1.time_ >= var_687_56 + var_687_57 and arg_684_1.time_ < var_687_56 + var_687_57 + arg_687_0 then
				arg_684_1.typewritter.percent = 1

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(true)
			end
		end

		arg_684_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R7502a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R7502a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_684_1:InitPlayNodeList()
	end,
	Play1107506169 = function(arg_690_0, arg_690_1)
		arg_690_1.time_ = 0
		arg_690_1.frameCnt_ = 0
		arg_690_1.state_ = "playing"
		arg_690_1.curTalkId_ = 1107506169
		arg_690_1.duration_ = 7.67

		SetActive(arg_690_1.tipsGo_, false)

		function arg_690_1.onSingleLineFinish_()
			arg_690_1.onSingleLineUpdate_ = nil
			arg_690_1.onSingleLineFinish_ = nil
			arg_690_1.state_ = "waiting"
		end

		function arg_690_1.playNext_(arg_692_0)
			if arg_692_0 == 1 then
				arg_690_0:Play1107506170(arg_690_1)
			end
		end

		function arg_690_1.onSingleLineUpdate_(arg_693_0)
			local var_693_0 = 0
			local var_693_1 = 0.75

			if var_693_0 < arg_690_1.time_ and arg_690_1.time_ <= var_693_0 + arg_693_0 then
				arg_690_1.talkMaxDuration = 0
				arg_690_1.dialogCg_.alpha = 1

				arg_690_1.dialog_:SetActive(true)
				SetActive(arg_690_1.leftNameGo_, true)

				local var_693_2 = arg_690_1:FormatText(StoryNameCfg[381].name)

				arg_690_1.leftNameTxt_.text = var_693_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_690_1.leftNameTxt_.transform)

				arg_690_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_690_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_690_1:RecordName(arg_690_1.leftNameTxt_.text)
				SetActive(arg_690_1.iconTrs_.gameObject, false)
				arg_690_1.callingController_:SetSelectedState("normal")

				local var_693_3 = arg_690_1:GetWordFromCfg(1107506169)
				local var_693_4 = arg_690_1:FormatText(var_693_3.content)

				arg_690_1.text_.text = var_693_4

				LuaForUtil.ClearLinePrefixSymbol(arg_690_1.text_)

				local var_693_5 = 30
				local var_693_6 = utf8.len(var_693_4)
				local var_693_7 = var_693_5 <= 0 and var_693_1 or var_693_1 * (var_693_6 / var_693_5)

				if var_693_7 > 0 and var_693_1 < var_693_7 then
					arg_690_1.talkMaxDuration = var_693_7

					if var_693_7 + var_693_0 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_7 + var_693_0
					end
				end

				arg_690_1.text_.text = var_693_4
				arg_690_1.typewritter.percent = 0

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506169", "story_v_side_new_1107506.awb") ~= 0 then
					local var_693_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506169", "story_v_side_new_1107506.awb") / 1000

					if var_693_8 + var_693_0 > arg_690_1.duration_ then
						arg_690_1.duration_ = var_693_8 + var_693_0
					end

					if var_693_3.prefab_name ~= "" and arg_690_1.actors_[var_693_3.prefab_name] ~= nil then
						local var_693_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_690_1.actors_[var_693_3.prefab_name].transform, "story_v_side_new_1107506", "1107506169", "story_v_side_new_1107506.awb")

						arg_690_1:RecordAudio("1107506169", var_693_9)
						arg_690_1:RecordAudio("1107506169", var_693_9)
					else
						arg_690_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506169", "story_v_side_new_1107506.awb")
					end

					arg_690_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506169", "story_v_side_new_1107506.awb")
				end

				arg_690_1:RecordContent(arg_690_1.text_.text)
			end

			local var_693_10 = math.max(var_693_1, arg_690_1.talkMaxDuration)

			if var_693_0 <= arg_690_1.time_ and arg_690_1.time_ < var_693_0 + var_693_10 then
				arg_690_1.typewritter.percent = (arg_690_1.time_ - var_693_0) / var_693_10

				arg_690_1.typewritter:SetDirty()
			end

			if arg_690_1.time_ >= var_693_0 + var_693_10 and arg_690_1.time_ < var_693_0 + var_693_10 + arg_693_0 then
				arg_690_1.typewritter.percent = 1

				arg_690_1.typewritter:SetDirty()
				arg_690_1:ShowNextGo(true)
			end
		end

		arg_690_1.nodeConfigList_ = {}

		arg_690_1:InitPlayNodeList()
	end,
	Play1107506170 = function(arg_694_0, arg_694_1)
		arg_694_1.time_ = 0
		arg_694_1.frameCnt_ = 0
		arg_694_1.state_ = "playing"
		arg_694_1.curTalkId_ = 1107506170
		arg_694_1.duration_ = 1

		SetActive(arg_694_1.tipsGo_, true)

		arg_694_1.tipsText_.text = StoryTipsCfg[107501].name

		function arg_694_1.onSingleLineFinish_()
			arg_694_1.onSingleLineUpdate_ = nil
			arg_694_1.onSingleLineFinish_ = nil
			arg_694_1.state_ = "waiting"

			SetActive(arg_694_1.choicesGo_, true)

			for iter_695_0, iter_695_1 in ipairs(arg_694_1.choices_) do
				local var_695_0 = iter_695_0 <= 2

				SetActive(iter_695_1.go, var_695_0)
			end

			arg_694_1.choices_[1].txt.text = arg_694_1:FormatText(StoryChoiceCfg[1175].name)
			arg_694_1.choices_[2].txt.text = arg_694_1:FormatText(StoryChoiceCfg[1176].name)
		end

		function arg_694_1.playNext_(arg_696_0)
			if arg_696_0 == 1 then
				PlayerAction.UseStoryTrigger(1075013, 210750106, 1107506170, 1)
				arg_694_0:Play1107506171(arg_694_1)
			end

			if arg_696_0 == 2 then
				PlayerAction.UseStoryTrigger(1075013, 210750106, 1107506170, 2)
				arg_694_0:Play1107506171(arg_694_1)
			end

			arg_694_1:RecordChoiceLog(1107506170, 1175, 1176)
		end

		function arg_694_1.onSingleLineUpdate_(arg_697_0)
			local var_697_0 = arg_694_1.actors_["1075ui_actor"]
			local var_697_1 = 0

			if var_697_1 < arg_694_1.time_ and arg_694_1.time_ <= var_697_1 + arg_697_0 and not isNil(var_697_0) and arg_694_1.var_.characterEffect1075ui_actor == nil then
				arg_694_1.var_.characterEffect1075ui_actor = var_697_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_697_2 = 0.2

			if var_697_1 <= arg_694_1.time_ and arg_694_1.time_ < var_697_1 + var_697_2 and not isNil(var_697_0) then
				local var_697_3 = (arg_694_1.time_ - var_697_1) / var_697_2

				if arg_694_1.var_.characterEffect1075ui_actor and not isNil(var_697_0) then
					local var_697_4 = Mathf.Lerp(0, 0.5, var_697_3)

					arg_694_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_694_1.var_.characterEffect1075ui_actor.fillRatio = var_697_4
				end
			end

			if arg_694_1.time_ >= var_697_1 + var_697_2 and arg_694_1.time_ < var_697_1 + var_697_2 + arg_697_0 and not isNil(var_697_0) and arg_694_1.var_.characterEffect1075ui_actor then
				local var_697_5 = 0.5

				arg_694_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_694_1.var_.characterEffect1075ui_actor.fillRatio = var_697_5
			end

			local var_697_6 = 0

			if var_697_6 < arg_694_1.time_ and arg_694_1.time_ <= var_697_6 + arg_697_0 then
				arg_694_1.allBtn_.enabled = false
			end

			local var_697_7 = 0.5

			if arg_694_1.time_ >= var_697_6 + var_697_7 and arg_694_1.time_ < var_697_6 + var_697_7 + arg_697_0 then
				arg_694_1.allBtn_.enabled = true
			end
		end

		arg_694_1.nodeConfigList_ = {}

		arg_694_1:InitPlayNodeList()
	end,
	Play1107506171 = function(arg_698_0, arg_698_1)
		arg_698_1.time_ = 0
		arg_698_1.frameCnt_ = 0
		arg_698_1.state_ = "playing"
		arg_698_1.curTalkId_ = 1107506171
		arg_698_1.duration_ = 8

		SetActive(arg_698_1.tipsGo_, false)

		function arg_698_1.onSingleLineFinish_()
			arg_698_1.onSingleLineUpdate_ = nil
			arg_698_1.onSingleLineFinish_ = nil
			arg_698_1.state_ = "waiting"
		end

		function arg_698_1.playNext_(arg_700_0)
			if arg_700_0 == 1 then
				arg_698_0:Play1107506172(arg_698_1)
			end
		end

		function arg_698_1.onSingleLineUpdate_(arg_701_0)
			local var_701_0 = 1.5

			if var_701_0 < arg_698_1.time_ and arg_698_1.time_ <= var_701_0 + arg_701_0 then
				local var_701_1 = manager.ui.mainCamera.transform.localPosition
				local var_701_2 = Vector3.New(0, 0, 10) + Vector3.New(var_701_1.x, var_701_1.y, 0)
				local var_701_3 = arg_698_1.bgs_.R7502a

				var_701_3.transform.localPosition = var_701_2
				var_701_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_701_4 = var_701_3:GetComponent("SpriteRenderer")

				if var_701_4 and var_701_4.sprite then
					local var_701_5 = (var_701_3.transform.localPosition - var_701_1).z
					local var_701_6 = manager.ui.mainCameraCom_
					local var_701_7 = 2 * var_701_5 * Mathf.Tan(var_701_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_701_8 = var_701_7 * var_701_6.aspect
					local var_701_9 = var_701_4.sprite.bounds.size.x
					local var_701_10 = var_701_4.sprite.bounds.size.y
					local var_701_11 = var_701_8 / var_701_9
					local var_701_12 = var_701_7 / var_701_10
					local var_701_13 = var_701_12 < var_701_11 and var_701_11 or var_701_12

					var_701_3.transform.localScale = Vector3.New(var_701_13, var_701_13, 0)
				end

				for iter_701_0, iter_701_1 in pairs(arg_698_1.bgs_) do
					if iter_701_0 ~= "R7502a" then
						iter_701_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_701_14 = 0

			if var_701_14 < arg_698_1.time_ and arg_698_1.time_ <= var_701_14 + arg_701_0 then
				arg_698_1.mask_.enabled = true
				arg_698_1.mask_.raycastTarget = true

				arg_698_1:SetGaussion(false)
			end

			local var_701_15 = 1.5

			if var_701_14 <= arg_698_1.time_ and arg_698_1.time_ < var_701_14 + var_701_15 then
				local var_701_16 = (arg_698_1.time_ - var_701_14) / var_701_15
				local var_701_17 = Color.New(0, 0, 0)

				var_701_17.a = Mathf.Lerp(0, 1, var_701_16)
				arg_698_1.mask_.color = var_701_17
			end

			if arg_698_1.time_ >= var_701_14 + var_701_15 and arg_698_1.time_ < var_701_14 + var_701_15 + arg_701_0 then
				local var_701_18 = Color.New(0, 0, 0)

				var_701_18.a = 1
				arg_698_1.mask_.color = var_701_18
			end

			local var_701_19 = 1.5

			if var_701_19 < arg_698_1.time_ and arg_698_1.time_ <= var_701_19 + arg_701_0 then
				arg_698_1.mask_.enabled = true
				arg_698_1.mask_.raycastTarget = true

				arg_698_1:SetGaussion(false)
			end

			local var_701_20 = 1.5

			if var_701_19 <= arg_698_1.time_ and arg_698_1.time_ < var_701_19 + var_701_20 then
				local var_701_21 = (arg_698_1.time_ - var_701_19) / var_701_20
				local var_701_22 = Color.New(0.06603771, 0.06603771, 0.06603771)

				var_701_22.a = Mathf.Lerp(1, 0, var_701_21)
				arg_698_1.mask_.color = var_701_22
			end

			if arg_698_1.time_ >= var_701_19 + var_701_20 and arg_698_1.time_ < var_701_19 + var_701_20 + arg_701_0 then
				local var_701_23 = Color.New(0.06603771, 0.06603771, 0.06603771)
				local var_701_24 = 0

				arg_698_1.mask_.enabled = false
				var_701_23.a = var_701_24
				arg_698_1.mask_.color = var_701_23
			end

			local var_701_25 = arg_698_1.bgs_.R7502a.transform
			local var_701_26 = 1.5

			if var_701_26 < arg_698_1.time_ and arg_698_1.time_ <= var_701_26 + arg_701_0 then
				arg_698_1.var_.moveOldPosR7502a = var_701_25.localPosition
			end

			local var_701_27 = 0.001

			if var_701_26 <= arg_698_1.time_ and arg_698_1.time_ < var_701_26 + var_701_27 then
				local var_701_28 = (arg_698_1.time_ - var_701_26) / var_701_27
				local var_701_29 = Vector3.New(0, 1, 9.5)

				var_701_25.localPosition = Vector3.Lerp(arg_698_1.var_.moveOldPosR7502a, var_701_29, var_701_28)
			end

			if arg_698_1.time_ >= var_701_26 + var_701_27 and arg_698_1.time_ < var_701_26 + var_701_27 + arg_701_0 then
				var_701_25.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_701_30 = arg_698_1.bgs_.R7502a.transform
			local var_701_31 = 1.51666666666667

			if var_701_31 < arg_698_1.time_ and arg_698_1.time_ <= var_701_31 + arg_701_0 then
				arg_698_1.var_.moveOldPosR7502a = var_701_30.localPosition
			end

			local var_701_32 = 4.5

			if var_701_31 <= arg_698_1.time_ and arg_698_1.time_ < var_701_31 + var_701_32 then
				local var_701_33 = (arg_698_1.time_ - var_701_31) / var_701_32
				local var_701_34 = Vector3.New(0, 1, 10)

				var_701_30.localPosition = Vector3.Lerp(arg_698_1.var_.moveOldPosR7502a, var_701_34, var_701_33)
			end

			if arg_698_1.time_ >= var_701_31 + var_701_32 and arg_698_1.time_ < var_701_31 + var_701_32 + arg_701_0 then
				var_701_30.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_698_1.frameCnt_ <= 1 then
				arg_698_1.dialog_:SetActive(false)
			end

			local var_701_35 = 3
			local var_701_36 = 0.65

			if var_701_35 < arg_698_1.time_ and arg_698_1.time_ <= var_701_35 + arg_701_0 then
				arg_698_1.talkMaxDuration = 0

				arg_698_1.dialog_:SetActive(true)

				arg_698_1.dialogCg_.alpha = 0

				local var_701_37 = LeanTween.value(arg_698_1.dialog_, 0, 1, 0.3)

				var_701_37:setOnUpdate(LuaHelper.FloatAction(function(arg_702_0)
					arg_698_1.dialogCg_.alpha = arg_702_0
				end))
				var_701_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_698_1.dialog_)
					var_701_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_698_1.duration_ = arg_698_1.duration_ + 0.3

				SetActive(arg_698_1.leftNameGo_, false)

				arg_698_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_698_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_698_1:RecordName(arg_698_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_698_1.iconTrs_.gameObject, false)
				arg_698_1.callingController_:SetSelectedState("normal")

				local var_701_38 = arg_698_1:GetWordFromCfg(1107506171)
				local var_701_39 = arg_698_1:FormatText(var_701_38.content)

				arg_698_1.text_.text = var_701_39

				LuaForUtil.ClearLinePrefixSymbol(arg_698_1.text_)

				local var_701_40 = 26
				local var_701_41 = utf8.len(var_701_39)
				local var_701_42 = var_701_40 <= 0 and var_701_36 or var_701_36 * (var_701_41 / var_701_40)

				if var_701_42 > 0 and var_701_36 < var_701_42 then
					arg_698_1.talkMaxDuration = var_701_42
					var_701_35 = var_701_35 + 0.3

					if var_701_42 + var_701_35 > arg_698_1.duration_ then
						arg_698_1.duration_ = var_701_42 + var_701_35
					end
				end

				arg_698_1.text_.text = var_701_39
				arg_698_1.typewritter.percent = 0

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(false)
				arg_698_1:RecordContent(arg_698_1.text_.text)
			end

			local var_701_43 = var_701_35 + 0.3
			local var_701_44 = math.max(var_701_36, arg_698_1.talkMaxDuration)

			if var_701_43 <= arg_698_1.time_ and arg_698_1.time_ < var_701_43 + var_701_44 then
				arg_698_1.typewritter.percent = (arg_698_1.time_ - var_701_43) / var_701_44

				arg_698_1.typewritter:SetDirty()
			end

			if arg_698_1.time_ >= var_701_43 + var_701_44 and arg_698_1.time_ < var_701_43 + var_701_44 + arg_701_0 then
				arg_698_1.typewritter.percent = 1

				arg_698_1.typewritter:SetDirty()
				arg_698_1:ShowNextGo(true)
			end
		end

		arg_698_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R7502a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R7502a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 1.51666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_698_1:InitPlayNodeList()
	end,
	Play1107506172 = function(arg_704_0, arg_704_1)
		arg_704_1.time_ = 0
		arg_704_1.frameCnt_ = 0
		arg_704_1.state_ = "playing"
		arg_704_1.curTalkId_ = 1107506172
		arg_704_1.duration_ = 5

		SetActive(arg_704_1.tipsGo_, false)

		function arg_704_1.onSingleLineFinish_()
			arg_704_1.onSingleLineUpdate_ = nil
			arg_704_1.onSingleLineFinish_ = nil
			arg_704_1.state_ = "waiting"
		end

		function arg_704_1.playNext_(arg_706_0)
			if arg_706_0 == 1 then
				arg_704_0:Play1107506173(arg_704_1)
			end
		end

		function arg_704_1.onSingleLineUpdate_(arg_707_0)
			local var_707_0 = 0
			local var_707_1 = 1.325

			if var_707_0 < arg_704_1.time_ and arg_704_1.time_ <= var_707_0 + arg_707_0 then
				arg_704_1.talkMaxDuration = 0
				arg_704_1.dialogCg_.alpha = 1

				arg_704_1.dialog_:SetActive(true)
				SetActive(arg_704_1.leftNameGo_, false)

				arg_704_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_704_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_704_1:RecordName(arg_704_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_704_1.iconTrs_.gameObject, false)
				arg_704_1.callingController_:SetSelectedState("normal")

				local var_707_2 = arg_704_1:GetWordFromCfg(1107506172)
				local var_707_3 = arg_704_1:FormatText(var_707_2.content)

				arg_704_1.text_.text = var_707_3

				LuaForUtil.ClearLinePrefixSymbol(arg_704_1.text_)

				local var_707_4 = 53
				local var_707_5 = utf8.len(var_707_3)
				local var_707_6 = var_707_4 <= 0 and var_707_1 or var_707_1 * (var_707_5 / var_707_4)

				if var_707_6 > 0 and var_707_1 < var_707_6 then
					arg_704_1.talkMaxDuration = var_707_6

					if var_707_6 + var_707_0 > arg_704_1.duration_ then
						arg_704_1.duration_ = var_707_6 + var_707_0
					end
				end

				arg_704_1.text_.text = var_707_3
				arg_704_1.typewritter.percent = 0

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(false)
				arg_704_1:RecordContent(arg_704_1.text_.text)
			end

			local var_707_7 = math.max(var_707_1, arg_704_1.talkMaxDuration)

			if var_707_0 <= arg_704_1.time_ and arg_704_1.time_ < var_707_0 + var_707_7 then
				arg_704_1.typewritter.percent = (arg_704_1.time_ - var_707_0) / var_707_7

				arg_704_1.typewritter:SetDirty()
			end

			if arg_704_1.time_ >= var_707_0 + var_707_7 and arg_704_1.time_ < var_707_0 + var_707_7 + arg_707_0 then
				arg_704_1.typewritter.percent = 1

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(true)
			end
		end

		arg_704_1.nodeConfigList_ = {}

		arg_704_1:InitPlayNodeList()
	end,
	Play1107506173 = function(arg_708_0, arg_708_1)
		arg_708_1.time_ = 0
		arg_708_1.frameCnt_ = 0
		arg_708_1.state_ = "playing"
		arg_708_1.curTalkId_ = 1107506173
		arg_708_1.duration_ = 4.43

		SetActive(arg_708_1.tipsGo_, false)

		function arg_708_1.onSingleLineFinish_()
			arg_708_1.onSingleLineUpdate_ = nil
			arg_708_1.onSingleLineFinish_ = nil
			arg_708_1.state_ = "waiting"
		end

		function arg_708_1.playNext_(arg_710_0)
			if arg_710_0 == 1 then
				arg_708_0:Play1107506174(arg_708_1)
			end
		end

		function arg_708_1.onSingleLineUpdate_(arg_711_0)
			local var_711_0 = arg_708_1.actors_["1075ui_actor"]
			local var_711_1 = 0

			if var_711_1 < arg_708_1.time_ and arg_708_1.time_ <= var_711_1 + arg_711_0 and not isNil(var_711_0) and arg_708_1.var_.characterEffect1075ui_actor == nil then
				arg_708_1.var_.characterEffect1075ui_actor = var_711_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_711_2 = 0.200000002980232

			if var_711_1 <= arg_708_1.time_ and arg_708_1.time_ < var_711_1 + var_711_2 and not isNil(var_711_0) then
				local var_711_3 = (arg_708_1.time_ - var_711_1) / var_711_2

				if arg_708_1.var_.characterEffect1075ui_actor and not isNil(var_711_0) then
					arg_708_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_708_1.time_ >= var_711_1 + var_711_2 and arg_708_1.time_ < var_711_1 + var_711_2 + arg_711_0 and not isNil(var_711_0) and arg_708_1.var_.characterEffect1075ui_actor then
				arg_708_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_711_4 = 0
			local var_711_5 = 0.4

			if var_711_4 < arg_708_1.time_ and arg_708_1.time_ <= var_711_4 + arg_711_0 then
				arg_708_1.talkMaxDuration = 0
				arg_708_1.dialogCg_.alpha = 1

				arg_708_1.dialog_:SetActive(true)
				SetActive(arg_708_1.leftNameGo_, true)

				local var_711_6 = arg_708_1:FormatText(StoryNameCfg[381].name)

				arg_708_1.leftNameTxt_.text = var_711_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_708_1.leftNameTxt_.transform)

				arg_708_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_708_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_708_1:RecordName(arg_708_1.leftNameTxt_.text)
				SetActive(arg_708_1.iconTrs_.gameObject, false)
				arg_708_1.callingController_:SetSelectedState("normal")

				local var_711_7 = arg_708_1:GetWordFromCfg(1107506173)
				local var_711_8 = arg_708_1:FormatText(var_711_7.content)

				arg_708_1.text_.text = var_711_8

				LuaForUtil.ClearLinePrefixSymbol(arg_708_1.text_)

				local var_711_9 = 16
				local var_711_10 = utf8.len(var_711_8)
				local var_711_11 = var_711_9 <= 0 and var_711_5 or var_711_5 * (var_711_10 / var_711_9)

				if var_711_11 > 0 and var_711_5 < var_711_11 then
					arg_708_1.talkMaxDuration = var_711_11

					if var_711_11 + var_711_4 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_11 + var_711_4
					end
				end

				arg_708_1.text_.text = var_711_8
				arg_708_1.typewritter.percent = 0

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506173", "story_v_side_new_1107506.awb") ~= 0 then
					local var_711_12 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506173", "story_v_side_new_1107506.awb") / 1000

					if var_711_12 + var_711_4 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_12 + var_711_4
					end

					if var_711_7.prefab_name ~= "" and arg_708_1.actors_[var_711_7.prefab_name] ~= nil then
						local var_711_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_708_1.actors_[var_711_7.prefab_name].transform, "story_v_side_new_1107506", "1107506173", "story_v_side_new_1107506.awb")

						arg_708_1:RecordAudio("1107506173", var_711_13)
						arg_708_1:RecordAudio("1107506173", var_711_13)
					else
						arg_708_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506173", "story_v_side_new_1107506.awb")
					end

					arg_708_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506173", "story_v_side_new_1107506.awb")
				end

				arg_708_1:RecordContent(arg_708_1.text_.text)
			end

			local var_711_14 = math.max(var_711_5, arg_708_1.talkMaxDuration)

			if var_711_4 <= arg_708_1.time_ and arg_708_1.time_ < var_711_4 + var_711_14 then
				arg_708_1.typewritter.percent = (arg_708_1.time_ - var_711_4) / var_711_14

				arg_708_1.typewritter:SetDirty()
			end

			if arg_708_1.time_ >= var_711_4 + var_711_14 and arg_708_1.time_ < var_711_4 + var_711_14 + arg_711_0 then
				arg_708_1.typewritter.percent = 1

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(true)
			end
		end

		arg_708_1.nodeConfigList_ = {}

		arg_708_1:InitPlayNodeList()
	end,
	Play1107506174 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 1107506174
		arg_712_1.duration_ = 3.9

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play1107506175(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			local var_715_0 = 0
			local var_715_1 = 0.375

			if var_715_0 < arg_712_1.time_ and arg_712_1.time_ <= var_715_0 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0
				arg_712_1.dialogCg_.alpha = 1

				arg_712_1.dialog_:SetActive(true)
				SetActive(arg_712_1.leftNameGo_, true)

				local var_715_2 = arg_712_1:FormatText(StoryNameCfg[381].name)

				arg_712_1.leftNameTxt_.text = var_715_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_712_1.leftNameTxt_.transform)

				arg_712_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_712_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_712_1:RecordName(arg_712_1.leftNameTxt_.text)
				SetActive(arg_712_1.iconTrs_.gameObject, false)
				arg_712_1.callingController_:SetSelectedState("normal")

				local var_715_3 = arg_712_1:GetWordFromCfg(1107506174)
				local var_715_4 = arg_712_1:FormatText(var_715_3.content)

				arg_712_1.text_.text = var_715_4

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.text_)

				local var_715_5 = 15
				local var_715_6 = utf8.len(var_715_4)
				local var_715_7 = var_715_5 <= 0 and var_715_1 or var_715_1 * (var_715_6 / var_715_5)

				if var_715_7 > 0 and var_715_1 < var_715_7 then
					arg_712_1.talkMaxDuration = var_715_7

					if var_715_7 + var_715_0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_7 + var_715_0
					end
				end

				arg_712_1.text_.text = var_715_4
				arg_712_1.typewritter.percent = 0

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506174", "story_v_side_new_1107506.awb") ~= 0 then
					local var_715_8 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506174", "story_v_side_new_1107506.awb") / 1000

					if var_715_8 + var_715_0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_8 + var_715_0
					end

					if var_715_3.prefab_name ~= "" and arg_712_1.actors_[var_715_3.prefab_name] ~= nil then
						local var_715_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_712_1.actors_[var_715_3.prefab_name].transform, "story_v_side_new_1107506", "1107506174", "story_v_side_new_1107506.awb")

						arg_712_1:RecordAudio("1107506174", var_715_9)
						arg_712_1:RecordAudio("1107506174", var_715_9)
					else
						arg_712_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506174", "story_v_side_new_1107506.awb")
					end

					arg_712_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506174", "story_v_side_new_1107506.awb")
				end

				arg_712_1:RecordContent(arg_712_1.text_.text)
			end

			local var_715_10 = math.max(var_715_1, arg_712_1.talkMaxDuration)

			if var_715_0 <= arg_712_1.time_ and arg_712_1.time_ < var_715_0 + var_715_10 then
				arg_712_1.typewritter.percent = (arg_712_1.time_ - var_715_0) / var_715_10

				arg_712_1.typewritter:SetDirty()
			end

			if arg_712_1.time_ >= var_715_0 + var_715_10 and arg_712_1.time_ < var_715_0 + var_715_10 + arg_715_0 then
				arg_712_1.typewritter.percent = 1

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(true)
			end
		end

		arg_712_1.nodeConfigList_ = {}

		arg_712_1:InitPlayNodeList()
	end,
	Play1107506175 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 1107506175
		arg_716_1.duration_ = 9

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
		end

		function arg_716_1.playNext_(arg_718_0)
			if arg_718_0 == 1 then
				arg_716_0:Play1107506176(arg_716_1)
			end
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			local var_719_0 = "ST45"

			if arg_716_1.bgs_[var_719_0] == nil then
				local var_719_1 = Object.Instantiate(arg_716_1.paintGo_)

				var_719_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_719_0)
				var_719_1.name = var_719_0
				var_719_1.transform.parent = arg_716_1.stage_.transform
				var_719_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_716_1.bgs_[var_719_0] = var_719_1
			end

			local var_719_2 = 2

			if var_719_2 < arg_716_1.time_ and arg_716_1.time_ <= var_719_2 + arg_719_0 then
				local var_719_3 = manager.ui.mainCamera.transform.localPosition
				local var_719_4 = Vector3.New(0, 0, 10) + Vector3.New(var_719_3.x, var_719_3.y, 0)
				local var_719_5 = arg_716_1.bgs_.ST45

				var_719_5.transform.localPosition = var_719_4
				var_719_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_719_6 = var_719_5:GetComponent("SpriteRenderer")

				if var_719_6 and var_719_6.sprite then
					local var_719_7 = (var_719_5.transform.localPosition - var_719_3).z
					local var_719_8 = manager.ui.mainCameraCom_
					local var_719_9 = 2 * var_719_7 * Mathf.Tan(var_719_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_719_10 = var_719_9 * var_719_8.aspect
					local var_719_11 = var_719_6.sprite.bounds.size.x
					local var_719_12 = var_719_6.sprite.bounds.size.y
					local var_719_13 = var_719_10 / var_719_11
					local var_719_14 = var_719_9 / var_719_12
					local var_719_15 = var_719_14 < var_719_13 and var_719_13 or var_719_14

					var_719_5.transform.localScale = Vector3.New(var_719_15, var_719_15, 0)
				end

				for iter_719_0, iter_719_1 in pairs(arg_716_1.bgs_) do
					if iter_719_0 ~= "ST45" then
						iter_719_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_719_16 = 4

			if var_719_16 < arg_716_1.time_ and arg_716_1.time_ <= var_719_16 + arg_719_0 then
				arg_716_1.allBtn_.enabled = false
			end

			local var_719_17 = 0.3

			if arg_716_1.time_ >= var_719_16 + var_719_17 and arg_716_1.time_ < var_719_16 + var_719_17 + arg_719_0 then
				arg_716_1.allBtn_.enabled = true
			end

			local var_719_18 = 0

			if var_719_18 < arg_716_1.time_ and arg_716_1.time_ <= var_719_18 + arg_719_0 then
				arg_716_1.mask_.enabled = true
				arg_716_1.mask_.raycastTarget = true

				arg_716_1:SetGaussion(false)
			end

			local var_719_19 = 2

			if var_719_18 <= arg_716_1.time_ and arg_716_1.time_ < var_719_18 + var_719_19 then
				local var_719_20 = (arg_716_1.time_ - var_719_18) / var_719_19
				local var_719_21 = Color.New(0, 0, 0)

				var_719_21.a = Mathf.Lerp(0, 1, var_719_20)
				arg_716_1.mask_.color = var_719_21
			end

			if arg_716_1.time_ >= var_719_18 + var_719_19 and arg_716_1.time_ < var_719_18 + var_719_19 + arg_719_0 then
				local var_719_22 = Color.New(0, 0, 0)

				var_719_22.a = 1
				arg_716_1.mask_.color = var_719_22
			end

			local var_719_23 = 2

			if var_719_23 < arg_716_1.time_ and arg_716_1.time_ <= var_719_23 + arg_719_0 then
				arg_716_1.mask_.enabled = true
				arg_716_1.mask_.raycastTarget = true

				arg_716_1:SetGaussion(false)
			end

			local var_719_24 = 2

			if var_719_23 <= arg_716_1.time_ and arg_716_1.time_ < var_719_23 + var_719_24 then
				local var_719_25 = (arg_716_1.time_ - var_719_23) / var_719_24
				local var_719_26 = Color.New(0, 0, 0)

				var_719_26.a = Mathf.Lerp(1, 0, var_719_25)
				arg_716_1.mask_.color = var_719_26
			end

			if arg_716_1.time_ >= var_719_23 + var_719_24 and arg_716_1.time_ < var_719_23 + var_719_24 + arg_719_0 then
				local var_719_27 = Color.New(0, 0, 0)
				local var_719_28 = 0

				arg_716_1.mask_.enabled = false
				var_719_27.a = var_719_28
				arg_716_1.mask_.color = var_719_27
			end

			if arg_716_1.frameCnt_ <= 1 then
				arg_716_1.dialog_:SetActive(false)
			end

			local var_719_29 = 4
			local var_719_30 = 0.525

			if var_719_29 < arg_716_1.time_ and arg_716_1.time_ <= var_719_29 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0

				arg_716_1.dialog_:SetActive(true)

				arg_716_1.dialogCg_.alpha = 0

				local var_719_31 = LeanTween.value(arg_716_1.dialog_, 0, 1, 0.3)

				var_719_31:setOnUpdate(LuaHelper.FloatAction(function(arg_720_0)
					arg_716_1.dialogCg_.alpha = arg_720_0
				end))
				var_719_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_716_1.dialog_)
					var_719_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_716_1.duration_ = arg_716_1.duration_ + 0.3

				SetActive(arg_716_1.leftNameGo_, false)

				arg_716_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_716_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_716_1:RecordName(arg_716_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_716_1.iconTrs_.gameObject, false)
				arg_716_1.callingController_:SetSelectedState("normal")

				local var_719_32 = arg_716_1:GetWordFromCfg(1107506175)
				local var_719_33 = arg_716_1:FormatText(var_719_32.content)

				arg_716_1.text_.text = var_719_33

				LuaForUtil.ClearLinePrefixSymbol(arg_716_1.text_)

				local var_719_34 = 21
				local var_719_35 = utf8.len(var_719_33)
				local var_719_36 = var_719_34 <= 0 and var_719_30 or var_719_30 * (var_719_35 / var_719_34)

				if var_719_36 > 0 and var_719_30 < var_719_36 then
					arg_716_1.talkMaxDuration = var_719_36
					var_719_29 = var_719_29 + 0.3

					if var_719_36 + var_719_29 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_36 + var_719_29
					end
				end

				arg_716_1.text_.text = var_719_33
				arg_716_1.typewritter.percent = 0

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(false)
				arg_716_1:RecordContent(arg_716_1.text_.text)
			end

			local var_719_37 = var_719_29 + 0.3
			local var_719_38 = math.max(var_719_30, arg_716_1.talkMaxDuration)

			if var_719_37 <= arg_716_1.time_ and arg_716_1.time_ < var_719_37 + var_719_38 then
				arg_716_1.typewritter.percent = (arg_716_1.time_ - var_719_37) / var_719_38

				arg_716_1.typewritter:SetDirty()
			end

			if arg_716_1.time_ >= var_719_37 + var_719_38 and arg_716_1.time_ < var_719_37 + var_719_38 + arg_719_0 then
				arg_716_1.typewritter.percent = 1

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(true)
			end
		end

		arg_716_1.nodeConfigList_ = {}

		arg_716_1:InitPlayNodeList()
	end,
	Play1107506176 = function(arg_722_0, arg_722_1)
		arg_722_1.time_ = 0
		arg_722_1.frameCnt_ = 0
		arg_722_1.state_ = "playing"
		arg_722_1.curTalkId_ = 1107506176
		arg_722_1.duration_ = 5

		SetActive(arg_722_1.tipsGo_, false)

		function arg_722_1.onSingleLineFinish_()
			arg_722_1.onSingleLineUpdate_ = nil
			arg_722_1.onSingleLineFinish_ = nil
			arg_722_1.state_ = "waiting"
		end

		function arg_722_1.playNext_(arg_724_0)
			if arg_724_0 == 1 then
				arg_722_0:Play1107506177(arg_722_1)
			end
		end

		function arg_722_1.onSingleLineUpdate_(arg_725_0)
			local var_725_0 = 0
			local var_725_1 = 0.3

			if var_725_0 < arg_722_1.time_ and arg_722_1.time_ <= var_725_0 + arg_725_0 then
				arg_722_1.talkMaxDuration = 0
				arg_722_1.dialogCg_.alpha = 1

				arg_722_1.dialog_:SetActive(true)
				SetActive(arg_722_1.leftNameGo_, true)

				local var_725_2 = arg_722_1:FormatText(StoryNameCfg[7].name)

				arg_722_1.leftNameTxt_.text = var_725_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_722_1.leftNameTxt_.transform)

				arg_722_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_722_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_722_1:RecordName(arg_722_1.leftNameTxt_.text)
				SetActive(arg_722_1.iconTrs_.gameObject, true)
				arg_722_1.iconController_:SetSelectedState("hero")

				arg_722_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_722_1.callingController_:SetSelectedState("normal")

				arg_722_1.keyicon_.color = Color.New(1, 1, 1)
				arg_722_1.icon_.color = Color.New(1, 1, 1)

				local var_725_3 = arg_722_1:GetWordFromCfg(1107506176)
				local var_725_4 = arg_722_1:FormatText(var_725_3.content)

				arg_722_1.text_.text = var_725_4

				LuaForUtil.ClearLinePrefixSymbol(arg_722_1.text_)

				local var_725_5 = 12
				local var_725_6 = utf8.len(var_725_4)
				local var_725_7 = var_725_5 <= 0 and var_725_1 or var_725_1 * (var_725_6 / var_725_5)

				if var_725_7 > 0 and var_725_1 < var_725_7 then
					arg_722_1.talkMaxDuration = var_725_7

					if var_725_7 + var_725_0 > arg_722_1.duration_ then
						arg_722_1.duration_ = var_725_7 + var_725_0
					end
				end

				arg_722_1.text_.text = var_725_4
				arg_722_1.typewritter.percent = 0

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(false)
				arg_722_1:RecordContent(arg_722_1.text_.text)
			end

			local var_725_8 = math.max(var_725_1, arg_722_1.talkMaxDuration)

			if var_725_0 <= arg_722_1.time_ and arg_722_1.time_ < var_725_0 + var_725_8 then
				arg_722_1.typewritter.percent = (arg_722_1.time_ - var_725_0) / var_725_8

				arg_722_1.typewritter:SetDirty()
			end

			if arg_722_1.time_ >= var_725_0 + var_725_8 and arg_722_1.time_ < var_725_0 + var_725_8 + arg_725_0 then
				arg_722_1.typewritter.percent = 1

				arg_722_1.typewritter:SetDirty()
				arg_722_1:ShowNextGo(true)
			end
		end

		arg_722_1.nodeConfigList_ = {}

		arg_722_1:InitPlayNodeList()
	end,
	Play1107506177 = function(arg_726_0, arg_726_1)
		arg_726_1.time_ = 0
		arg_726_1.frameCnt_ = 0
		arg_726_1.state_ = "playing"
		arg_726_1.curTalkId_ = 1107506177
		arg_726_1.duration_ = 8.57

		SetActive(arg_726_1.tipsGo_, false)

		function arg_726_1.onSingleLineFinish_()
			arg_726_1.onSingleLineUpdate_ = nil
			arg_726_1.onSingleLineFinish_ = nil
			arg_726_1.state_ = "waiting"
		end

		function arg_726_1.playNext_(arg_728_0)
			if arg_728_0 == 1 then
				arg_726_0:Play1107506178(arg_726_1)
			end
		end

		function arg_726_1.onSingleLineUpdate_(arg_729_0)
			local var_729_0 = arg_726_1.actors_["1075ui_actor"].transform
			local var_729_1 = 0

			if var_729_1 < arg_726_1.time_ and arg_726_1.time_ <= var_729_1 + arg_729_0 then
				arg_726_1.var_.moveOldPos1075ui_actor = var_729_0.localPosition

				local var_729_2 = GameObjectTools.GetOrAddComponent(var_729_0.gameObject, typeof(DynamicBoneHelper))

				if var_729_2 then
					var_729_2:EnableDynamicBone(false)
				end
			end

			local var_729_3 = 0.001

			if var_729_1 <= arg_726_1.time_ and arg_726_1.time_ < var_729_1 + var_729_3 then
				local var_729_4 = (arg_726_1.time_ - var_729_1) / var_729_3
				local var_729_5 = Vector3.New(0, -1.055, -6.16)

				var_729_0.localPosition = Vector3.Lerp(arg_726_1.var_.moveOldPos1075ui_actor, var_729_5, var_729_4)

				local var_729_6 = manager.ui.mainCamera.transform.position - var_729_0.position

				var_729_0.forward = Vector3.New(var_729_6.x, var_729_6.y, var_729_6.z)

				local var_729_7 = var_729_0.localEulerAngles

				var_729_7.z = 0
				var_729_7.x = 0
				var_729_0.localEulerAngles = var_729_7
			end

			if arg_726_1.time_ >= var_729_1 + var_729_3 and arg_726_1.time_ < var_729_1 + var_729_3 + arg_729_0 then
				var_729_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_729_8 = manager.ui.mainCamera.transform.position - var_729_0.position

				var_729_0.forward = Vector3.New(var_729_8.x, var_729_8.y, var_729_8.z)

				local var_729_9 = var_729_0.localEulerAngles

				var_729_9.z = 0
				var_729_9.x = 0
				var_729_0.localEulerAngles = var_729_9

				local var_729_10 = GameObjectTools.GetOrAddComponent(var_729_0.gameObject, typeof(DynamicBoneHelper))

				if var_729_10 then
					var_729_10:EnableDynamicBone(true)
				end
			end

			local var_729_11 = arg_726_1.actors_["1075ui_actor"]
			local var_729_12 = 0

			if var_729_12 < arg_726_1.time_ and arg_726_1.time_ <= var_729_12 + arg_729_0 and not isNil(var_729_11) and arg_726_1.var_.characterEffect1075ui_actor == nil then
				arg_726_1.var_.characterEffect1075ui_actor = var_729_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_729_13 = 0.200000002980232

			if var_729_12 <= arg_726_1.time_ and arg_726_1.time_ < var_729_12 + var_729_13 and not isNil(var_729_11) then
				local var_729_14 = (arg_726_1.time_ - var_729_12) / var_729_13

				if arg_726_1.var_.characterEffect1075ui_actor and not isNil(var_729_11) then
					arg_726_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_726_1.time_ >= var_729_12 + var_729_13 and arg_726_1.time_ < var_729_12 + var_729_13 + arg_729_0 and not isNil(var_729_11) and arg_726_1.var_.characterEffect1075ui_actor then
				arg_726_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_729_15 = 0

			if var_729_15 < arg_726_1.time_ and arg_726_1.time_ <= var_729_15 + arg_729_0 then
				arg_726_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_1")
			end

			local var_729_16 = 0

			if var_729_16 < arg_726_1.time_ and arg_726_1.time_ <= var_729_16 + arg_729_0 then
				arg_726_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_729_17 = 0
			local var_729_18 = 0.875

			if var_729_17 < arg_726_1.time_ and arg_726_1.time_ <= var_729_17 + arg_729_0 then
				arg_726_1.talkMaxDuration = 0
				arg_726_1.dialogCg_.alpha = 1

				arg_726_1.dialog_:SetActive(true)
				SetActive(arg_726_1.leftNameGo_, true)

				local var_729_19 = arg_726_1:FormatText(StoryNameCfg[381].name)

				arg_726_1.leftNameTxt_.text = var_729_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_726_1.leftNameTxt_.transform)

				arg_726_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_726_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_726_1:RecordName(arg_726_1.leftNameTxt_.text)
				SetActive(arg_726_1.iconTrs_.gameObject, false)
				arg_726_1.callingController_:SetSelectedState("normal")

				local var_729_20 = arg_726_1:GetWordFromCfg(1107506177)
				local var_729_21 = arg_726_1:FormatText(var_729_20.content)

				arg_726_1.text_.text = var_729_21

				LuaForUtil.ClearLinePrefixSymbol(arg_726_1.text_)

				local var_729_22 = 35
				local var_729_23 = utf8.len(var_729_21)
				local var_729_24 = var_729_22 <= 0 and var_729_18 or var_729_18 * (var_729_23 / var_729_22)

				if var_729_24 > 0 and var_729_18 < var_729_24 then
					arg_726_1.talkMaxDuration = var_729_24

					if var_729_24 + var_729_17 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_24 + var_729_17
					end
				end

				arg_726_1.text_.text = var_729_21
				arg_726_1.typewritter.percent = 0

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506177", "story_v_side_new_1107506.awb") ~= 0 then
					local var_729_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506177", "story_v_side_new_1107506.awb") / 1000

					if var_729_25 + var_729_17 > arg_726_1.duration_ then
						arg_726_1.duration_ = var_729_25 + var_729_17
					end

					if var_729_20.prefab_name ~= "" and arg_726_1.actors_[var_729_20.prefab_name] ~= nil then
						local var_729_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_726_1.actors_[var_729_20.prefab_name].transform, "story_v_side_new_1107506", "1107506177", "story_v_side_new_1107506.awb")

						arg_726_1:RecordAudio("1107506177", var_729_26)
						arg_726_1:RecordAudio("1107506177", var_729_26)
					else
						arg_726_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506177", "story_v_side_new_1107506.awb")
					end

					arg_726_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506177", "story_v_side_new_1107506.awb")
				end

				arg_726_1:RecordContent(arg_726_1.text_.text)
			end

			local var_729_27 = math.max(var_729_18, arg_726_1.talkMaxDuration)

			if var_729_17 <= arg_726_1.time_ and arg_726_1.time_ < var_729_17 + var_729_27 then
				arg_726_1.typewritter.percent = (arg_726_1.time_ - var_729_17) / var_729_27

				arg_726_1.typewritter:SetDirty()
			end

			if arg_726_1.time_ >= var_729_17 + var_729_27 and arg_726_1.time_ < var_729_17 + var_729_27 + arg_729_0 then
				arg_726_1.typewritter.percent = 1

				arg_726_1.typewritter:SetDirty()
				arg_726_1:ShowNextGo(true)
			end
		end

		arg_726_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_726_1:InitPlayNodeList()
	end,
	Play1107506178 = function(arg_730_0, arg_730_1)
		arg_730_1.time_ = 0
		arg_730_1.frameCnt_ = 0
		arg_730_1.state_ = "playing"
		arg_730_1.curTalkId_ = 1107506178
		arg_730_1.duration_ = 8.2

		SetActive(arg_730_1.tipsGo_, false)

		function arg_730_1.onSingleLineFinish_()
			arg_730_1.onSingleLineUpdate_ = nil
			arg_730_1.onSingleLineFinish_ = nil
			arg_730_1.state_ = "waiting"
		end

		function arg_730_1.playNext_(arg_732_0)
			if arg_732_0 == 1 then
				arg_730_0:Play1107506179(arg_730_1)
			end
		end

		function arg_730_1.onSingleLineUpdate_(arg_733_0)
			local var_733_0 = 0

			if var_733_0 < arg_730_1.time_ and arg_730_1.time_ <= var_733_0 + arg_733_0 then
				arg_730_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action2_2")
			end

			local var_733_1 = 0

			if var_733_1 < arg_730_1.time_ and arg_730_1.time_ <= var_733_1 + arg_733_0 then
				arg_730_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_733_2 = 0
			local var_733_3 = 0.825

			if var_733_2 < arg_730_1.time_ and arg_730_1.time_ <= var_733_2 + arg_733_0 then
				arg_730_1.talkMaxDuration = 0
				arg_730_1.dialogCg_.alpha = 1

				arg_730_1.dialog_:SetActive(true)
				SetActive(arg_730_1.leftNameGo_, true)

				local var_733_4 = arg_730_1:FormatText(StoryNameCfg[381].name)

				arg_730_1.leftNameTxt_.text = var_733_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_730_1.leftNameTxt_.transform)

				arg_730_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_730_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_730_1:RecordName(arg_730_1.leftNameTxt_.text)
				SetActive(arg_730_1.iconTrs_.gameObject, false)
				arg_730_1.callingController_:SetSelectedState("normal")

				local var_733_5 = arg_730_1:GetWordFromCfg(1107506178)
				local var_733_6 = arg_730_1:FormatText(var_733_5.content)

				arg_730_1.text_.text = var_733_6

				LuaForUtil.ClearLinePrefixSymbol(arg_730_1.text_)

				local var_733_7 = 33
				local var_733_8 = utf8.len(var_733_6)
				local var_733_9 = var_733_7 <= 0 and var_733_3 or var_733_3 * (var_733_8 / var_733_7)

				if var_733_9 > 0 and var_733_3 < var_733_9 then
					arg_730_1.talkMaxDuration = var_733_9

					if var_733_9 + var_733_2 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_9 + var_733_2
					end
				end

				arg_730_1.text_.text = var_733_6
				arg_730_1.typewritter.percent = 0

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506178", "story_v_side_new_1107506.awb") ~= 0 then
					local var_733_10 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506178", "story_v_side_new_1107506.awb") / 1000

					if var_733_10 + var_733_2 > arg_730_1.duration_ then
						arg_730_1.duration_ = var_733_10 + var_733_2
					end

					if var_733_5.prefab_name ~= "" and arg_730_1.actors_[var_733_5.prefab_name] ~= nil then
						local var_733_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_730_1.actors_[var_733_5.prefab_name].transform, "story_v_side_new_1107506", "1107506178", "story_v_side_new_1107506.awb")

						arg_730_1:RecordAudio("1107506178", var_733_11)
						arg_730_1:RecordAudio("1107506178", var_733_11)
					else
						arg_730_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506178", "story_v_side_new_1107506.awb")
					end

					arg_730_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506178", "story_v_side_new_1107506.awb")
				end

				arg_730_1:RecordContent(arg_730_1.text_.text)
			end

			local var_733_12 = math.max(var_733_3, arg_730_1.talkMaxDuration)

			if var_733_2 <= arg_730_1.time_ and arg_730_1.time_ < var_733_2 + var_733_12 then
				arg_730_1.typewritter.percent = (arg_730_1.time_ - var_733_2) / var_733_12

				arg_730_1.typewritter:SetDirty()
			end

			if arg_730_1.time_ >= var_733_2 + var_733_12 and arg_730_1.time_ < var_733_2 + var_733_12 + arg_733_0 then
				arg_730_1.typewritter.percent = 1

				arg_730_1.typewritter:SetDirty()
				arg_730_1:ShowNextGo(true)
			end
		end

		arg_730_1.nodeConfigList_ = {}

		arg_730_1:InitPlayNodeList()
	end,
	Play1107506179 = function(arg_734_0, arg_734_1)
		arg_734_1.time_ = 0
		arg_734_1.frameCnt_ = 0
		arg_734_1.state_ = "playing"
		arg_734_1.curTalkId_ = 1107506179
		arg_734_1.duration_ = 5

		SetActive(arg_734_1.tipsGo_, false)

		function arg_734_1.onSingleLineFinish_()
			arg_734_1.onSingleLineUpdate_ = nil
			arg_734_1.onSingleLineFinish_ = nil
			arg_734_1.state_ = "waiting"
		end

		function arg_734_1.playNext_(arg_736_0)
			if arg_736_0 == 1 then
				arg_734_0:Play1107506180(arg_734_1)
			end
		end

		function arg_734_1.onSingleLineUpdate_(arg_737_0)
			local var_737_0 = arg_734_1.actors_["1075ui_actor"]
			local var_737_1 = 0

			if var_737_1 < arg_734_1.time_ and arg_734_1.time_ <= var_737_1 + arg_737_0 and not isNil(var_737_0) and arg_734_1.var_.characterEffect1075ui_actor == nil then
				arg_734_1.var_.characterEffect1075ui_actor = var_737_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_737_2 = 0.200000002980232

			if var_737_1 <= arg_734_1.time_ and arg_734_1.time_ < var_737_1 + var_737_2 and not isNil(var_737_0) then
				local var_737_3 = (arg_734_1.time_ - var_737_1) / var_737_2

				if arg_734_1.var_.characterEffect1075ui_actor and not isNil(var_737_0) then
					local var_737_4 = Mathf.Lerp(0, 0.5, var_737_3)

					arg_734_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_734_1.var_.characterEffect1075ui_actor.fillRatio = var_737_4
				end
			end

			if arg_734_1.time_ >= var_737_1 + var_737_2 and arg_734_1.time_ < var_737_1 + var_737_2 + arg_737_0 and not isNil(var_737_0) and arg_734_1.var_.characterEffect1075ui_actor then
				local var_737_5 = 0.5

				arg_734_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_734_1.var_.characterEffect1075ui_actor.fillRatio = var_737_5
			end

			local var_737_6 = 0
			local var_737_7 = 0.275

			if var_737_6 < arg_734_1.time_ and arg_734_1.time_ <= var_737_6 + arg_737_0 then
				arg_734_1.talkMaxDuration = 0
				arg_734_1.dialogCg_.alpha = 1

				arg_734_1.dialog_:SetActive(true)
				SetActive(arg_734_1.leftNameGo_, true)

				local var_737_8 = arg_734_1:FormatText(StoryNameCfg[7].name)

				arg_734_1.leftNameTxt_.text = var_737_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_734_1.leftNameTxt_.transform)

				arg_734_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_734_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_734_1:RecordName(arg_734_1.leftNameTxt_.text)
				SetActive(arg_734_1.iconTrs_.gameObject, true)
				arg_734_1.iconController_:SetSelectedState("hero")

				arg_734_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_734_1.callingController_:SetSelectedState("normal")

				arg_734_1.keyicon_.color = Color.New(1, 1, 1)
				arg_734_1.icon_.color = Color.New(1, 1, 1)

				local var_737_9 = arg_734_1:GetWordFromCfg(1107506179)
				local var_737_10 = arg_734_1:FormatText(var_737_9.content)

				arg_734_1.text_.text = var_737_10

				LuaForUtil.ClearLinePrefixSymbol(arg_734_1.text_)

				local var_737_11 = 11
				local var_737_12 = utf8.len(var_737_10)
				local var_737_13 = var_737_11 <= 0 and var_737_7 or var_737_7 * (var_737_12 / var_737_11)

				if var_737_13 > 0 and var_737_7 < var_737_13 then
					arg_734_1.talkMaxDuration = var_737_13

					if var_737_13 + var_737_6 > arg_734_1.duration_ then
						arg_734_1.duration_ = var_737_13 + var_737_6
					end
				end

				arg_734_1.text_.text = var_737_10
				arg_734_1.typewritter.percent = 0

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(false)
				arg_734_1:RecordContent(arg_734_1.text_.text)
			end

			local var_737_14 = math.max(var_737_7, arg_734_1.talkMaxDuration)

			if var_737_6 <= arg_734_1.time_ and arg_734_1.time_ < var_737_6 + var_737_14 then
				arg_734_1.typewritter.percent = (arg_734_1.time_ - var_737_6) / var_737_14

				arg_734_1.typewritter:SetDirty()
			end

			if arg_734_1.time_ >= var_737_6 + var_737_14 and arg_734_1.time_ < var_737_6 + var_737_14 + arg_737_0 then
				arg_734_1.typewritter.percent = 1

				arg_734_1.typewritter:SetDirty()
				arg_734_1:ShowNextGo(true)
			end
		end

		arg_734_1.nodeConfigList_ = {}

		arg_734_1:InitPlayNodeList()
	end,
	Play1107506180 = function(arg_738_0, arg_738_1)
		arg_738_1.time_ = 0
		arg_738_1.frameCnt_ = 0
		arg_738_1.state_ = "playing"
		arg_738_1.curTalkId_ = 1107506180
		arg_738_1.duration_ = 5

		SetActive(arg_738_1.tipsGo_, false)

		function arg_738_1.onSingleLineFinish_()
			arg_738_1.onSingleLineUpdate_ = nil
			arg_738_1.onSingleLineFinish_ = nil
			arg_738_1.state_ = "waiting"
		end

		function arg_738_1.playNext_(arg_740_0)
			if arg_740_0 == 1 then
				arg_738_0:Play1107506181(arg_738_1)
			end
		end

		function arg_738_1.onSingleLineUpdate_(arg_741_0)
			local var_741_0 = 0
			local var_741_1 = 0.325

			if var_741_0 < arg_738_1.time_ and arg_738_1.time_ <= var_741_0 + arg_741_0 then
				arg_738_1.talkMaxDuration = 0
				arg_738_1.dialogCg_.alpha = 1

				arg_738_1.dialog_:SetActive(true)
				SetActive(arg_738_1.leftNameGo_, true)

				local var_741_2 = arg_738_1:FormatText(StoryNameCfg[7].name)

				arg_738_1.leftNameTxt_.text = var_741_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_738_1.leftNameTxt_.transform)

				arg_738_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_738_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_738_1:RecordName(arg_738_1.leftNameTxt_.text)
				SetActive(arg_738_1.iconTrs_.gameObject, true)
				arg_738_1.iconController_:SetSelectedState("hero")

				arg_738_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_738_1.callingController_:SetSelectedState("normal")

				arg_738_1.keyicon_.color = Color.New(1, 1, 1)
				arg_738_1.icon_.color = Color.New(1, 1, 1)

				local var_741_3 = arg_738_1:GetWordFromCfg(1107506180)
				local var_741_4 = arg_738_1:FormatText(var_741_3.content)

				arg_738_1.text_.text = var_741_4

				LuaForUtil.ClearLinePrefixSymbol(arg_738_1.text_)

				local var_741_5 = 13
				local var_741_6 = utf8.len(var_741_4)
				local var_741_7 = var_741_5 <= 0 and var_741_1 or var_741_1 * (var_741_6 / var_741_5)

				if var_741_7 > 0 and var_741_1 < var_741_7 then
					arg_738_1.talkMaxDuration = var_741_7

					if var_741_7 + var_741_0 > arg_738_1.duration_ then
						arg_738_1.duration_ = var_741_7 + var_741_0
					end
				end

				arg_738_1.text_.text = var_741_4
				arg_738_1.typewritter.percent = 0

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(false)
				arg_738_1:RecordContent(arg_738_1.text_.text)
			end

			local var_741_8 = math.max(var_741_1, arg_738_1.talkMaxDuration)

			if var_741_0 <= arg_738_1.time_ and arg_738_1.time_ < var_741_0 + var_741_8 then
				arg_738_1.typewritter.percent = (arg_738_1.time_ - var_741_0) / var_741_8

				arg_738_1.typewritter:SetDirty()
			end

			if arg_738_1.time_ >= var_741_0 + var_741_8 and arg_738_1.time_ < var_741_0 + var_741_8 + arg_741_0 then
				arg_738_1.typewritter.percent = 1

				arg_738_1.typewritter:SetDirty()
				arg_738_1:ShowNextGo(true)
			end
		end

		arg_738_1.nodeConfigList_ = {}

		arg_738_1:InitPlayNodeList()
	end,
	Play1107506181 = function(arg_742_0, arg_742_1)
		arg_742_1.time_ = 0
		arg_742_1.frameCnt_ = 0
		arg_742_1.state_ = "playing"
		arg_742_1.curTalkId_ = 1107506181
		arg_742_1.duration_ = 8.53

		SetActive(arg_742_1.tipsGo_, false)

		function arg_742_1.onSingleLineFinish_()
			arg_742_1.onSingleLineUpdate_ = nil
			arg_742_1.onSingleLineFinish_ = nil
			arg_742_1.state_ = "waiting"
		end

		function arg_742_1.playNext_(arg_744_0)
			if arg_744_0 == 1 then
				arg_742_0:Play1107506182(arg_742_1)
			end
		end

		function arg_742_1.onSingleLineUpdate_(arg_745_0)
			local var_745_0 = arg_742_1.actors_["1075ui_actor"]
			local var_745_1 = 0

			if var_745_1 < arg_742_1.time_ and arg_742_1.time_ <= var_745_1 + arg_745_0 and not isNil(var_745_0) and arg_742_1.var_.characterEffect1075ui_actor == nil then
				arg_742_1.var_.characterEffect1075ui_actor = var_745_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_745_2 = 0.200000002980232

			if var_745_1 <= arg_742_1.time_ and arg_742_1.time_ < var_745_1 + var_745_2 and not isNil(var_745_0) then
				local var_745_3 = (arg_742_1.time_ - var_745_1) / var_745_2

				if arg_742_1.var_.characterEffect1075ui_actor and not isNil(var_745_0) then
					arg_742_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_742_1.time_ >= var_745_1 + var_745_2 and arg_742_1.time_ < var_745_1 + var_745_2 + arg_745_0 and not isNil(var_745_0) and arg_742_1.var_.characterEffect1075ui_actor then
				arg_742_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_745_4 = 0

			if var_745_4 < arg_742_1.time_ and arg_742_1.time_ <= var_745_4 + arg_745_0 then
				arg_742_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action6_1")
			end

			local var_745_5 = 0

			if var_745_5 < arg_742_1.time_ and arg_742_1.time_ <= var_745_5 + arg_745_0 then
				arg_742_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_745_6 = 0
			local var_745_7 = 1.025

			if var_745_6 < arg_742_1.time_ and arg_742_1.time_ <= var_745_6 + arg_745_0 then
				arg_742_1.talkMaxDuration = 0
				arg_742_1.dialogCg_.alpha = 1

				arg_742_1.dialog_:SetActive(true)
				SetActive(arg_742_1.leftNameGo_, true)

				local var_745_8 = arg_742_1:FormatText(StoryNameCfg[381].name)

				arg_742_1.leftNameTxt_.text = var_745_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_742_1.leftNameTxt_.transform)

				arg_742_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_742_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_742_1:RecordName(arg_742_1.leftNameTxt_.text)
				SetActive(arg_742_1.iconTrs_.gameObject, false)
				arg_742_1.callingController_:SetSelectedState("normal")

				local var_745_9 = arg_742_1:GetWordFromCfg(1107506181)
				local var_745_10 = arg_742_1:FormatText(var_745_9.content)

				arg_742_1.text_.text = var_745_10

				LuaForUtil.ClearLinePrefixSymbol(arg_742_1.text_)

				local var_745_11 = 41
				local var_745_12 = utf8.len(var_745_10)
				local var_745_13 = var_745_11 <= 0 and var_745_7 or var_745_7 * (var_745_12 / var_745_11)

				if var_745_13 > 0 and var_745_7 < var_745_13 then
					arg_742_1.talkMaxDuration = var_745_13

					if var_745_13 + var_745_6 > arg_742_1.duration_ then
						arg_742_1.duration_ = var_745_13 + var_745_6
					end
				end

				arg_742_1.text_.text = var_745_10
				arg_742_1.typewritter.percent = 0

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506181", "story_v_side_new_1107506.awb") ~= 0 then
					local var_745_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506181", "story_v_side_new_1107506.awb") / 1000

					if var_745_14 + var_745_6 > arg_742_1.duration_ then
						arg_742_1.duration_ = var_745_14 + var_745_6
					end

					if var_745_9.prefab_name ~= "" and arg_742_1.actors_[var_745_9.prefab_name] ~= nil then
						local var_745_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_742_1.actors_[var_745_9.prefab_name].transform, "story_v_side_new_1107506", "1107506181", "story_v_side_new_1107506.awb")

						arg_742_1:RecordAudio("1107506181", var_745_15)
						arg_742_1:RecordAudio("1107506181", var_745_15)
					else
						arg_742_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506181", "story_v_side_new_1107506.awb")
					end

					arg_742_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506181", "story_v_side_new_1107506.awb")
				end

				arg_742_1:RecordContent(arg_742_1.text_.text)
			end

			local var_745_16 = math.max(var_745_7, arg_742_1.talkMaxDuration)

			if var_745_6 <= arg_742_1.time_ and arg_742_1.time_ < var_745_6 + var_745_16 then
				arg_742_1.typewritter.percent = (arg_742_1.time_ - var_745_6) / var_745_16

				arg_742_1.typewritter:SetDirty()
			end

			if arg_742_1.time_ >= var_745_6 + var_745_16 and arg_742_1.time_ < var_745_6 + var_745_16 + arg_745_0 then
				arg_742_1.typewritter.percent = 1

				arg_742_1.typewritter:SetDirty()
				arg_742_1:ShowNextGo(true)
			end
		end

		arg_742_1.nodeConfigList_ = {}

		arg_742_1:InitPlayNodeList()
	end,
	Play1107506182 = function(arg_746_0, arg_746_1)
		arg_746_1.time_ = 0
		arg_746_1.frameCnt_ = 0
		arg_746_1.state_ = "playing"
		arg_746_1.curTalkId_ = 1107506182
		arg_746_1.duration_ = 5

		SetActive(arg_746_1.tipsGo_, false)

		function arg_746_1.onSingleLineFinish_()
			arg_746_1.onSingleLineUpdate_ = nil
			arg_746_1.onSingleLineFinish_ = nil
			arg_746_1.state_ = "waiting"
		end

		function arg_746_1.playNext_(arg_748_0)
			if arg_748_0 == 1 then
				arg_746_0:Play1107506183(arg_746_1)
			end
		end

		function arg_746_1.onSingleLineUpdate_(arg_749_0)
			local var_749_0 = arg_746_1.actors_["1075ui_actor"]
			local var_749_1 = 0

			if var_749_1 < arg_746_1.time_ and arg_746_1.time_ <= var_749_1 + arg_749_0 and not isNil(var_749_0) and arg_746_1.var_.characterEffect1075ui_actor == nil then
				arg_746_1.var_.characterEffect1075ui_actor = var_749_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_749_2 = 0.200000002980232

			if var_749_1 <= arg_746_1.time_ and arg_746_1.time_ < var_749_1 + var_749_2 and not isNil(var_749_0) then
				local var_749_3 = (arg_746_1.time_ - var_749_1) / var_749_2

				if arg_746_1.var_.characterEffect1075ui_actor and not isNil(var_749_0) then
					local var_749_4 = Mathf.Lerp(0, 0.5, var_749_3)

					arg_746_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_746_1.var_.characterEffect1075ui_actor.fillRatio = var_749_4
				end
			end

			if arg_746_1.time_ >= var_749_1 + var_749_2 and arg_746_1.time_ < var_749_1 + var_749_2 + arg_749_0 and not isNil(var_749_0) and arg_746_1.var_.characterEffect1075ui_actor then
				local var_749_5 = 0.5

				arg_746_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_746_1.var_.characterEffect1075ui_actor.fillRatio = var_749_5
			end

			local var_749_6 = 0
			local var_749_7 = 0.45

			if var_749_6 < arg_746_1.time_ and arg_746_1.time_ <= var_749_6 + arg_749_0 then
				arg_746_1.talkMaxDuration = 0
				arg_746_1.dialogCg_.alpha = 1

				arg_746_1.dialog_:SetActive(true)
				SetActive(arg_746_1.leftNameGo_, true)

				local var_749_8 = arg_746_1:FormatText(StoryNameCfg[7].name)

				arg_746_1.leftNameTxt_.text = var_749_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_746_1.leftNameTxt_.transform)

				arg_746_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_746_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_746_1:RecordName(arg_746_1.leftNameTxt_.text)
				SetActive(arg_746_1.iconTrs_.gameObject, true)
				arg_746_1.iconController_:SetSelectedState("hero")

				arg_746_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_746_1.callingController_:SetSelectedState("normal")

				arg_746_1.keyicon_.color = Color.New(1, 1, 1)
				arg_746_1.icon_.color = Color.New(1, 1, 1)

				local var_749_9 = arg_746_1:GetWordFromCfg(1107506182)
				local var_749_10 = arg_746_1:FormatText(var_749_9.content)

				arg_746_1.text_.text = var_749_10

				LuaForUtil.ClearLinePrefixSymbol(arg_746_1.text_)

				local var_749_11 = 18
				local var_749_12 = utf8.len(var_749_10)
				local var_749_13 = var_749_11 <= 0 and var_749_7 or var_749_7 * (var_749_12 / var_749_11)

				if var_749_13 > 0 and var_749_7 < var_749_13 then
					arg_746_1.talkMaxDuration = var_749_13

					if var_749_13 + var_749_6 > arg_746_1.duration_ then
						arg_746_1.duration_ = var_749_13 + var_749_6
					end
				end

				arg_746_1.text_.text = var_749_10
				arg_746_1.typewritter.percent = 0

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(false)
				arg_746_1:RecordContent(arg_746_1.text_.text)
			end

			local var_749_14 = math.max(var_749_7, arg_746_1.talkMaxDuration)

			if var_749_6 <= arg_746_1.time_ and arg_746_1.time_ < var_749_6 + var_749_14 then
				arg_746_1.typewritter.percent = (arg_746_1.time_ - var_749_6) / var_749_14

				arg_746_1.typewritter:SetDirty()
			end

			if arg_746_1.time_ >= var_749_6 + var_749_14 and arg_746_1.time_ < var_749_6 + var_749_14 + arg_749_0 then
				arg_746_1.typewritter.percent = 1

				arg_746_1.typewritter:SetDirty()
				arg_746_1:ShowNextGo(true)
			end
		end

		arg_746_1.nodeConfigList_ = {}

		arg_746_1:InitPlayNodeList()
	end,
	Play1107506183 = function(arg_750_0, arg_750_1)
		arg_750_1.time_ = 0
		arg_750_1.frameCnt_ = 0
		arg_750_1.state_ = "playing"
		arg_750_1.curTalkId_ = 1107506183
		arg_750_1.duration_ = 5

		SetActive(arg_750_1.tipsGo_, false)

		function arg_750_1.onSingleLineFinish_()
			arg_750_1.onSingleLineUpdate_ = nil
			arg_750_1.onSingleLineFinish_ = nil
			arg_750_1.state_ = "waiting"
		end

		function arg_750_1.playNext_(arg_752_0)
			if arg_752_0 == 1 then
				arg_750_0:Play1107506184(arg_750_1)
			end
		end

		function arg_750_1.onSingleLineUpdate_(arg_753_0)
			local var_753_0 = arg_750_1.actors_["1075ui_actor"].transform
			local var_753_1 = 0

			if var_753_1 < arg_750_1.time_ and arg_750_1.time_ <= var_753_1 + arg_753_0 then
				arg_750_1.var_.moveOldPos1075ui_actor = var_753_0.localPosition

				local var_753_2 = GameObjectTools.GetOrAddComponent(var_753_0.gameObject, typeof(DynamicBoneHelper))

				if var_753_2 then
					var_753_2:EnableDynamicBone(false)
				end
			end

			local var_753_3 = 0.001

			if var_753_1 <= arg_750_1.time_ and arg_750_1.time_ < var_753_1 + var_753_3 then
				local var_753_4 = (arg_750_1.time_ - var_753_1) / var_753_3
				local var_753_5 = Vector3.New(0, 100, 0)

				var_753_0.localPosition = Vector3.Lerp(arg_750_1.var_.moveOldPos1075ui_actor, var_753_5, var_753_4)

				local var_753_6 = manager.ui.mainCamera.transform.position - var_753_0.position

				var_753_0.forward = Vector3.New(var_753_6.x, var_753_6.y, var_753_6.z)

				local var_753_7 = var_753_0.localEulerAngles

				var_753_7.z = 0
				var_753_7.x = 0
				var_753_0.localEulerAngles = var_753_7
			end

			if arg_750_1.time_ >= var_753_1 + var_753_3 and arg_750_1.time_ < var_753_1 + var_753_3 + arg_753_0 then
				var_753_0.localPosition = Vector3.New(0, 100, 0)

				local var_753_8 = manager.ui.mainCamera.transform.position - var_753_0.position

				var_753_0.forward = Vector3.New(var_753_8.x, var_753_8.y, var_753_8.z)

				local var_753_9 = var_753_0.localEulerAngles

				var_753_9.z = 0
				var_753_9.x = 0
				var_753_0.localEulerAngles = var_753_9

				local var_753_10 = GameObjectTools.GetOrAddComponent(var_753_0.gameObject, typeof(DynamicBoneHelper))

				if var_753_10 then
					var_753_10:EnableDynamicBone(true)
				end
			end

			local var_753_11 = 0
			local var_753_12 = 0.55

			if var_753_11 < arg_750_1.time_ and arg_750_1.time_ <= var_753_11 + arg_753_0 then
				arg_750_1.talkMaxDuration = 0
				arg_750_1.dialogCg_.alpha = 1

				arg_750_1.dialog_:SetActive(true)
				SetActive(arg_750_1.leftNameGo_, false)

				arg_750_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_750_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_750_1:RecordName(arg_750_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_750_1.iconTrs_.gameObject, false)
				arg_750_1.callingController_:SetSelectedState("normal")

				local var_753_13 = arg_750_1:GetWordFromCfg(1107506183)
				local var_753_14 = arg_750_1:FormatText(var_753_13.content)

				arg_750_1.text_.text = var_753_14

				LuaForUtil.ClearLinePrefixSymbol(arg_750_1.text_)

				local var_753_15 = 22
				local var_753_16 = utf8.len(var_753_14)
				local var_753_17 = var_753_15 <= 0 and var_753_12 or var_753_12 * (var_753_16 / var_753_15)

				if var_753_17 > 0 and var_753_12 < var_753_17 then
					arg_750_1.talkMaxDuration = var_753_17

					if var_753_17 + var_753_11 > arg_750_1.duration_ then
						arg_750_1.duration_ = var_753_17 + var_753_11
					end
				end

				arg_750_1.text_.text = var_753_14
				arg_750_1.typewritter.percent = 0

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(false)
				arg_750_1:RecordContent(arg_750_1.text_.text)
			end

			local var_753_18 = math.max(var_753_12, arg_750_1.talkMaxDuration)

			if var_753_11 <= arg_750_1.time_ and arg_750_1.time_ < var_753_11 + var_753_18 then
				arg_750_1.typewritter.percent = (arg_750_1.time_ - var_753_11) / var_753_18

				arg_750_1.typewritter:SetDirty()
			end

			if arg_750_1.time_ >= var_753_11 + var_753_18 and arg_750_1.time_ < var_753_11 + var_753_18 + arg_753_0 then
				arg_750_1.typewritter.percent = 1

				arg_750_1.typewritter:SetDirty()
				arg_750_1:ShowNextGo(true)
			end
		end

		arg_750_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_750_1:InitPlayNodeList()
	end,
	Play1107506184 = function(arg_754_0, arg_754_1)
		arg_754_1.time_ = 0
		arg_754_1.frameCnt_ = 0
		arg_754_1.state_ = "playing"
		arg_754_1.curTalkId_ = 1107506184
		arg_754_1.duration_ = 5

		SetActive(arg_754_1.tipsGo_, false)

		function arg_754_1.onSingleLineFinish_()
			arg_754_1.onSingleLineUpdate_ = nil
			arg_754_1.onSingleLineFinish_ = nil
			arg_754_1.state_ = "waiting"
		end

		function arg_754_1.playNext_(arg_756_0)
			if arg_756_0 == 1 then
				arg_754_0:Play1107506185(arg_754_1)
			end
		end

		function arg_754_1.onSingleLineUpdate_(arg_757_0)
			local var_757_0 = 0
			local var_757_1 = 0.25

			if var_757_0 < arg_754_1.time_ and arg_754_1.time_ <= var_757_0 + arg_757_0 then
				arg_754_1.talkMaxDuration = 0
				arg_754_1.dialogCg_.alpha = 1

				arg_754_1.dialog_:SetActive(true)
				SetActive(arg_754_1.leftNameGo_, true)

				local var_757_2 = arg_754_1:FormatText(StoryNameCfg[7].name)

				arg_754_1.leftNameTxt_.text = var_757_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_754_1.leftNameTxt_.transform)

				arg_754_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_754_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_754_1:RecordName(arg_754_1.leftNameTxt_.text)
				SetActive(arg_754_1.iconTrs_.gameObject, true)
				arg_754_1.iconController_:SetSelectedState("hero")

				arg_754_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_754_1.callingController_:SetSelectedState("normal")

				arg_754_1.keyicon_.color = Color.New(1, 1, 1)
				arg_754_1.icon_.color = Color.New(1, 1, 1)

				local var_757_3 = arg_754_1:GetWordFromCfg(1107506184)
				local var_757_4 = arg_754_1:FormatText(var_757_3.content)

				arg_754_1.text_.text = var_757_4

				LuaForUtil.ClearLinePrefixSymbol(arg_754_1.text_)

				local var_757_5 = 10
				local var_757_6 = utf8.len(var_757_4)
				local var_757_7 = var_757_5 <= 0 and var_757_1 or var_757_1 * (var_757_6 / var_757_5)

				if var_757_7 > 0 and var_757_1 < var_757_7 then
					arg_754_1.talkMaxDuration = var_757_7

					if var_757_7 + var_757_0 > arg_754_1.duration_ then
						arg_754_1.duration_ = var_757_7 + var_757_0
					end
				end

				arg_754_1.text_.text = var_757_4
				arg_754_1.typewritter.percent = 0

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(false)
				arg_754_1:RecordContent(arg_754_1.text_.text)
			end

			local var_757_8 = math.max(var_757_1, arg_754_1.talkMaxDuration)

			if var_757_0 <= arg_754_1.time_ and arg_754_1.time_ < var_757_0 + var_757_8 then
				arg_754_1.typewritter.percent = (arg_754_1.time_ - var_757_0) / var_757_8

				arg_754_1.typewritter:SetDirty()
			end

			if arg_754_1.time_ >= var_757_0 + var_757_8 and arg_754_1.time_ < var_757_0 + var_757_8 + arg_757_0 then
				arg_754_1.typewritter.percent = 1

				arg_754_1.typewritter:SetDirty()
				arg_754_1:ShowNextGo(true)
			end
		end

		arg_754_1.nodeConfigList_ = {}

		arg_754_1:InitPlayNodeList()
	end,
	Play1107506185 = function(arg_758_0, arg_758_1)
		arg_758_1.time_ = 0
		arg_758_1.frameCnt_ = 0
		arg_758_1.state_ = "playing"
		arg_758_1.curTalkId_ = 1107506185
		arg_758_1.duration_ = 5

		SetActive(arg_758_1.tipsGo_, false)

		function arg_758_1.onSingleLineFinish_()
			arg_758_1.onSingleLineUpdate_ = nil
			arg_758_1.onSingleLineFinish_ = nil
			arg_758_1.state_ = "waiting"
		end

		function arg_758_1.playNext_(arg_760_0)
			if arg_760_0 == 1 then
				arg_758_0:Play1107506186(arg_758_1)
			end
		end

		function arg_758_1.onSingleLineUpdate_(arg_761_0)
			local var_761_0 = 0
			local var_761_1 = 0.7

			if var_761_0 < arg_758_1.time_ and arg_758_1.time_ <= var_761_0 + arg_761_0 then
				arg_758_1.talkMaxDuration = 0
				arg_758_1.dialogCg_.alpha = 1

				arg_758_1.dialog_:SetActive(true)
				SetActive(arg_758_1.leftNameGo_, false)

				arg_758_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_758_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_758_1:RecordName(arg_758_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_758_1.iconTrs_.gameObject, false)
				arg_758_1.callingController_:SetSelectedState("normal")

				local var_761_2 = arg_758_1:GetWordFromCfg(1107506185)
				local var_761_3 = arg_758_1:FormatText(var_761_2.content)

				arg_758_1.text_.text = var_761_3

				LuaForUtil.ClearLinePrefixSymbol(arg_758_1.text_)

				local var_761_4 = 28
				local var_761_5 = utf8.len(var_761_3)
				local var_761_6 = var_761_4 <= 0 and var_761_1 or var_761_1 * (var_761_5 / var_761_4)

				if var_761_6 > 0 and var_761_1 < var_761_6 then
					arg_758_1.talkMaxDuration = var_761_6

					if var_761_6 + var_761_0 > arg_758_1.duration_ then
						arg_758_1.duration_ = var_761_6 + var_761_0
					end
				end

				arg_758_1.text_.text = var_761_3
				arg_758_1.typewritter.percent = 0

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(false)
				arg_758_1:RecordContent(arg_758_1.text_.text)
			end

			local var_761_7 = math.max(var_761_1, arg_758_1.talkMaxDuration)

			if var_761_0 <= arg_758_1.time_ and arg_758_1.time_ < var_761_0 + var_761_7 then
				arg_758_1.typewritter.percent = (arg_758_1.time_ - var_761_0) / var_761_7

				arg_758_1.typewritter:SetDirty()
			end

			if arg_758_1.time_ >= var_761_0 + var_761_7 and arg_758_1.time_ < var_761_0 + var_761_7 + arg_761_0 then
				arg_758_1.typewritter.percent = 1

				arg_758_1.typewritter:SetDirty()
				arg_758_1:ShowNextGo(true)
			end
		end

		arg_758_1.nodeConfigList_ = {}

		arg_758_1:InitPlayNodeList()
	end,
	Play1107506186 = function(arg_762_0, arg_762_1)
		arg_762_1.time_ = 0
		arg_762_1.frameCnt_ = 0
		arg_762_1.state_ = "playing"
		arg_762_1.curTalkId_ = 1107506186
		arg_762_1.duration_ = 3.3

		SetActive(arg_762_1.tipsGo_, false)

		function arg_762_1.onSingleLineFinish_()
			arg_762_1.onSingleLineUpdate_ = nil
			arg_762_1.onSingleLineFinish_ = nil
			arg_762_1.state_ = "waiting"
		end

		function arg_762_1.playNext_(arg_764_0)
			if arg_764_0 == 1 then
				arg_762_0:Play1107506187(arg_762_1)
			end
		end

		function arg_762_1.onSingleLineUpdate_(arg_765_0)
			local var_765_0 = arg_762_1.actors_["1075ui_actor"].transform
			local var_765_1 = 0

			if var_765_1 < arg_762_1.time_ and arg_762_1.time_ <= var_765_1 + arg_765_0 then
				arg_762_1.var_.moveOldPos1075ui_actor = var_765_0.localPosition

				local var_765_2 = GameObjectTools.GetOrAddComponent(var_765_0.gameObject, typeof(DynamicBoneHelper))

				if var_765_2 then
					var_765_2:EnableDynamicBone(false)
				end
			end

			local var_765_3 = 0.001

			if var_765_1 <= arg_762_1.time_ and arg_762_1.time_ < var_765_1 + var_765_3 then
				local var_765_4 = (arg_762_1.time_ - var_765_1) / var_765_3
				local var_765_5 = Vector3.New(0, -1.055, -6.16)

				var_765_0.localPosition = Vector3.Lerp(arg_762_1.var_.moveOldPos1075ui_actor, var_765_5, var_765_4)

				local var_765_6 = manager.ui.mainCamera.transform.position - var_765_0.position

				var_765_0.forward = Vector3.New(var_765_6.x, var_765_6.y, var_765_6.z)

				local var_765_7 = var_765_0.localEulerAngles

				var_765_7.z = 0
				var_765_7.x = 0
				var_765_0.localEulerAngles = var_765_7
			end

			if arg_762_1.time_ >= var_765_1 + var_765_3 and arg_762_1.time_ < var_765_1 + var_765_3 + arg_765_0 then
				var_765_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_765_8 = manager.ui.mainCamera.transform.position - var_765_0.position

				var_765_0.forward = Vector3.New(var_765_8.x, var_765_8.y, var_765_8.z)

				local var_765_9 = var_765_0.localEulerAngles

				var_765_9.z = 0
				var_765_9.x = 0
				var_765_0.localEulerAngles = var_765_9

				local var_765_10 = GameObjectTools.GetOrAddComponent(var_765_0.gameObject, typeof(DynamicBoneHelper))

				if var_765_10 then
					var_765_10:EnableDynamicBone(true)
				end
			end

			local var_765_11 = arg_762_1.actors_["1075ui_actor"]
			local var_765_12 = 0

			if var_765_12 < arg_762_1.time_ and arg_762_1.time_ <= var_765_12 + arg_765_0 and not isNil(var_765_11) and arg_762_1.var_.characterEffect1075ui_actor == nil then
				arg_762_1.var_.characterEffect1075ui_actor = var_765_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_765_13 = 0.200000002980232

			if var_765_12 <= arg_762_1.time_ and arg_762_1.time_ < var_765_12 + var_765_13 and not isNil(var_765_11) then
				local var_765_14 = (arg_762_1.time_ - var_765_12) / var_765_13

				if arg_762_1.var_.characterEffect1075ui_actor and not isNil(var_765_11) then
					arg_762_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_762_1.time_ >= var_765_12 + var_765_13 and arg_762_1.time_ < var_765_12 + var_765_13 + arg_765_0 and not isNil(var_765_11) and arg_762_1.var_.characterEffect1075ui_actor then
				arg_762_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_765_15 = 0

			if var_765_15 < arg_762_1.time_ and arg_762_1.time_ <= var_765_15 + arg_765_0 then
				arg_762_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action6_2")
			end

			local var_765_16 = 0

			if var_765_16 < arg_762_1.time_ and arg_762_1.time_ <= var_765_16 + arg_765_0 then
				arg_762_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_765_17 = 0
			local var_765_18 = 0.3

			if var_765_17 < arg_762_1.time_ and arg_762_1.time_ <= var_765_17 + arg_765_0 then
				arg_762_1.talkMaxDuration = 0
				arg_762_1.dialogCg_.alpha = 1

				arg_762_1.dialog_:SetActive(true)
				SetActive(arg_762_1.leftNameGo_, true)

				local var_765_19 = arg_762_1:FormatText(StoryNameCfg[381].name)

				arg_762_1.leftNameTxt_.text = var_765_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_762_1.leftNameTxt_.transform)

				arg_762_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_762_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_762_1:RecordName(arg_762_1.leftNameTxt_.text)
				SetActive(arg_762_1.iconTrs_.gameObject, false)
				arg_762_1.callingController_:SetSelectedState("normal")

				local var_765_20 = arg_762_1:GetWordFromCfg(1107506186)
				local var_765_21 = arg_762_1:FormatText(var_765_20.content)

				arg_762_1.text_.text = var_765_21

				LuaForUtil.ClearLinePrefixSymbol(arg_762_1.text_)

				local var_765_22 = 12
				local var_765_23 = utf8.len(var_765_21)
				local var_765_24 = var_765_22 <= 0 and var_765_18 or var_765_18 * (var_765_23 / var_765_22)

				if var_765_24 > 0 and var_765_18 < var_765_24 then
					arg_762_1.talkMaxDuration = var_765_24

					if var_765_24 + var_765_17 > arg_762_1.duration_ then
						arg_762_1.duration_ = var_765_24 + var_765_17
					end
				end

				arg_762_1.text_.text = var_765_21
				arg_762_1.typewritter.percent = 0

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506186", "story_v_side_new_1107506.awb") ~= 0 then
					local var_765_25 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506186", "story_v_side_new_1107506.awb") / 1000

					if var_765_25 + var_765_17 > arg_762_1.duration_ then
						arg_762_1.duration_ = var_765_25 + var_765_17
					end

					if var_765_20.prefab_name ~= "" and arg_762_1.actors_[var_765_20.prefab_name] ~= nil then
						local var_765_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_762_1.actors_[var_765_20.prefab_name].transform, "story_v_side_new_1107506", "1107506186", "story_v_side_new_1107506.awb")

						arg_762_1:RecordAudio("1107506186", var_765_26)
						arg_762_1:RecordAudio("1107506186", var_765_26)
					else
						arg_762_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506186", "story_v_side_new_1107506.awb")
					end

					arg_762_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506186", "story_v_side_new_1107506.awb")
				end

				arg_762_1:RecordContent(arg_762_1.text_.text)
			end

			local var_765_27 = math.max(var_765_18, arg_762_1.talkMaxDuration)

			if var_765_17 <= arg_762_1.time_ and arg_762_1.time_ < var_765_17 + var_765_27 then
				arg_762_1.typewritter.percent = (arg_762_1.time_ - var_765_17) / var_765_27

				arg_762_1.typewritter:SetDirty()
			end

			if arg_762_1.time_ >= var_765_17 + var_765_27 and arg_762_1.time_ < var_765_17 + var_765_27 + arg_765_0 then
				arg_762_1.typewritter.percent = 1

				arg_762_1.typewritter:SetDirty()
				arg_762_1:ShowNextGo(true)
			end
		end

		arg_762_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_762_1:InitPlayNodeList()
	end,
	Play1107506187 = function(arg_766_0, arg_766_1)
		arg_766_1.time_ = 0
		arg_766_1.frameCnt_ = 0
		arg_766_1.state_ = "playing"
		arg_766_1.curTalkId_ = 1107506187
		arg_766_1.duration_ = 5

		SetActive(arg_766_1.tipsGo_, false)

		function arg_766_1.onSingleLineFinish_()
			arg_766_1.onSingleLineUpdate_ = nil
			arg_766_1.onSingleLineFinish_ = nil
			arg_766_1.state_ = "waiting"
		end

		function arg_766_1.playNext_(arg_768_0)
			if arg_768_0 == 1 then
				arg_766_0:Play1107506188(arg_766_1)
			end
		end

		function arg_766_1.onSingleLineUpdate_(arg_769_0)
			local var_769_0 = arg_766_1.actors_["1075ui_actor"]
			local var_769_1 = 0

			if var_769_1 < arg_766_1.time_ and arg_766_1.time_ <= var_769_1 + arg_769_0 and not isNil(var_769_0) and arg_766_1.var_.characterEffect1075ui_actor == nil then
				arg_766_1.var_.characterEffect1075ui_actor = var_769_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_769_2 = 0.200000002980232

			if var_769_1 <= arg_766_1.time_ and arg_766_1.time_ < var_769_1 + var_769_2 and not isNil(var_769_0) then
				local var_769_3 = (arg_766_1.time_ - var_769_1) / var_769_2

				if arg_766_1.var_.characterEffect1075ui_actor and not isNil(var_769_0) then
					local var_769_4 = Mathf.Lerp(0, 0.5, var_769_3)

					arg_766_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_766_1.var_.characterEffect1075ui_actor.fillRatio = var_769_4
				end
			end

			if arg_766_1.time_ >= var_769_1 + var_769_2 and arg_766_1.time_ < var_769_1 + var_769_2 + arg_769_0 and not isNil(var_769_0) and arg_766_1.var_.characterEffect1075ui_actor then
				local var_769_5 = 0.5

				arg_766_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_766_1.var_.characterEffect1075ui_actor.fillRatio = var_769_5
			end

			local var_769_6 = 0
			local var_769_7 = 0.35

			if var_769_6 < arg_766_1.time_ and arg_766_1.time_ <= var_769_6 + arg_769_0 then
				arg_766_1.talkMaxDuration = 0
				arg_766_1.dialogCg_.alpha = 1

				arg_766_1.dialog_:SetActive(true)
				SetActive(arg_766_1.leftNameGo_, true)

				local var_769_8 = arg_766_1:FormatText(StoryNameCfg[7].name)

				arg_766_1.leftNameTxt_.text = var_769_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_766_1.leftNameTxt_.transform)

				arg_766_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_766_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_766_1:RecordName(arg_766_1.leftNameTxt_.text)
				SetActive(arg_766_1.iconTrs_.gameObject, true)
				arg_766_1.iconController_:SetSelectedState("hero")

				arg_766_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_766_1.callingController_:SetSelectedState("normal")

				arg_766_1.keyicon_.color = Color.New(1, 1, 1)
				arg_766_1.icon_.color = Color.New(1, 1, 1)

				local var_769_9 = arg_766_1:GetWordFromCfg(1107506187)
				local var_769_10 = arg_766_1:FormatText(var_769_9.content)

				arg_766_1.text_.text = var_769_10

				LuaForUtil.ClearLinePrefixSymbol(arg_766_1.text_)

				local var_769_11 = 14
				local var_769_12 = utf8.len(var_769_10)
				local var_769_13 = var_769_11 <= 0 and var_769_7 or var_769_7 * (var_769_12 / var_769_11)

				if var_769_13 > 0 and var_769_7 < var_769_13 then
					arg_766_1.talkMaxDuration = var_769_13

					if var_769_13 + var_769_6 > arg_766_1.duration_ then
						arg_766_1.duration_ = var_769_13 + var_769_6
					end
				end

				arg_766_1.text_.text = var_769_10
				arg_766_1.typewritter.percent = 0

				arg_766_1.typewritter:SetDirty()
				arg_766_1:ShowNextGo(false)
				arg_766_1:RecordContent(arg_766_1.text_.text)
			end

			local var_769_14 = math.max(var_769_7, arg_766_1.talkMaxDuration)

			if var_769_6 <= arg_766_1.time_ and arg_766_1.time_ < var_769_6 + var_769_14 then
				arg_766_1.typewritter.percent = (arg_766_1.time_ - var_769_6) / var_769_14

				arg_766_1.typewritter:SetDirty()
			end

			if arg_766_1.time_ >= var_769_6 + var_769_14 and arg_766_1.time_ < var_769_6 + var_769_14 + arg_769_0 then
				arg_766_1.typewritter.percent = 1

				arg_766_1.typewritter:SetDirty()
				arg_766_1:ShowNextGo(true)
			end
		end

		arg_766_1.nodeConfigList_ = {}

		arg_766_1:InitPlayNodeList()
	end,
	Play1107506188 = function(arg_770_0, arg_770_1)
		arg_770_1.time_ = 0
		arg_770_1.frameCnt_ = 0
		arg_770_1.state_ = "playing"
		arg_770_1.curTalkId_ = 1107506188
		arg_770_1.duration_ = 4.1

		SetActive(arg_770_1.tipsGo_, false)

		function arg_770_1.onSingleLineFinish_()
			arg_770_1.onSingleLineUpdate_ = nil
			arg_770_1.onSingleLineFinish_ = nil
			arg_770_1.state_ = "waiting"
		end

		function arg_770_1.playNext_(arg_772_0)
			if arg_772_0 == 1 then
				arg_770_0:Play1107506189(arg_770_1)
			end
		end

		function arg_770_1.onSingleLineUpdate_(arg_773_0)
			local var_773_0 = arg_770_1.actors_["1075ui_actor"]
			local var_773_1 = 0

			if var_773_1 < arg_770_1.time_ and arg_770_1.time_ <= var_773_1 + arg_773_0 and not isNil(var_773_0) and arg_770_1.var_.characterEffect1075ui_actor == nil then
				arg_770_1.var_.characterEffect1075ui_actor = var_773_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_773_2 = 0.200000002980232

			if var_773_1 <= arg_770_1.time_ and arg_770_1.time_ < var_773_1 + var_773_2 and not isNil(var_773_0) then
				local var_773_3 = (arg_770_1.time_ - var_773_1) / var_773_2

				if arg_770_1.var_.characterEffect1075ui_actor and not isNil(var_773_0) then
					arg_770_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_770_1.time_ >= var_773_1 + var_773_2 and arg_770_1.time_ < var_773_1 + var_773_2 + arg_773_0 and not isNil(var_773_0) and arg_770_1.var_.characterEffect1075ui_actor then
				arg_770_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_773_4 = 0

			if var_773_4 < arg_770_1.time_ and arg_770_1.time_ <= var_773_4 + arg_773_0 then
				arg_770_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_773_5 = 0

			if var_773_5 < arg_770_1.time_ and arg_770_1.time_ <= var_773_5 + arg_773_0 then
				arg_770_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_773_6 = 0
			local var_773_7 = 0.425

			if var_773_6 < arg_770_1.time_ and arg_770_1.time_ <= var_773_6 + arg_773_0 then
				arg_770_1.talkMaxDuration = 0
				arg_770_1.dialogCg_.alpha = 1

				arg_770_1.dialog_:SetActive(true)
				SetActive(arg_770_1.leftNameGo_, true)

				local var_773_8 = arg_770_1:FormatText(StoryNameCfg[381].name)

				arg_770_1.leftNameTxt_.text = var_773_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_770_1.leftNameTxt_.transform)

				arg_770_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_770_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_770_1:RecordName(arg_770_1.leftNameTxt_.text)
				SetActive(arg_770_1.iconTrs_.gameObject, false)
				arg_770_1.callingController_:SetSelectedState("normal")

				local var_773_9 = arg_770_1:GetWordFromCfg(1107506188)
				local var_773_10 = arg_770_1:FormatText(var_773_9.content)

				arg_770_1.text_.text = var_773_10

				LuaForUtil.ClearLinePrefixSymbol(arg_770_1.text_)

				local var_773_11 = 17
				local var_773_12 = utf8.len(var_773_10)
				local var_773_13 = var_773_11 <= 0 and var_773_7 or var_773_7 * (var_773_12 / var_773_11)

				if var_773_13 > 0 and var_773_7 < var_773_13 then
					arg_770_1.talkMaxDuration = var_773_13

					if var_773_13 + var_773_6 > arg_770_1.duration_ then
						arg_770_1.duration_ = var_773_13 + var_773_6
					end
				end

				arg_770_1.text_.text = var_773_10
				arg_770_1.typewritter.percent = 0

				arg_770_1.typewritter:SetDirty()
				arg_770_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506188", "story_v_side_new_1107506.awb") ~= 0 then
					local var_773_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506188", "story_v_side_new_1107506.awb") / 1000

					if var_773_14 + var_773_6 > arg_770_1.duration_ then
						arg_770_1.duration_ = var_773_14 + var_773_6
					end

					if var_773_9.prefab_name ~= "" and arg_770_1.actors_[var_773_9.prefab_name] ~= nil then
						local var_773_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_770_1.actors_[var_773_9.prefab_name].transform, "story_v_side_new_1107506", "1107506188", "story_v_side_new_1107506.awb")

						arg_770_1:RecordAudio("1107506188", var_773_15)
						arg_770_1:RecordAudio("1107506188", var_773_15)
					else
						arg_770_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506188", "story_v_side_new_1107506.awb")
					end

					arg_770_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506188", "story_v_side_new_1107506.awb")
				end

				arg_770_1:RecordContent(arg_770_1.text_.text)
			end

			local var_773_16 = math.max(var_773_7, arg_770_1.talkMaxDuration)

			if var_773_6 <= arg_770_1.time_ and arg_770_1.time_ < var_773_6 + var_773_16 then
				arg_770_1.typewritter.percent = (arg_770_1.time_ - var_773_6) / var_773_16

				arg_770_1.typewritter:SetDirty()
			end

			if arg_770_1.time_ >= var_773_6 + var_773_16 and arg_770_1.time_ < var_773_6 + var_773_16 + arg_773_0 then
				arg_770_1.typewritter.percent = 1

				arg_770_1.typewritter:SetDirty()
				arg_770_1:ShowNextGo(true)
			end
		end

		arg_770_1.nodeConfigList_ = {}

		arg_770_1:InitPlayNodeList()
	end,
	Play1107506189 = function(arg_774_0, arg_774_1)
		arg_774_1.time_ = 0
		arg_774_1.frameCnt_ = 0
		arg_774_1.state_ = "playing"
		arg_774_1.curTalkId_ = 1107506189
		arg_774_1.duration_ = 5

		SetActive(arg_774_1.tipsGo_, false)

		function arg_774_1.onSingleLineFinish_()
			arg_774_1.onSingleLineUpdate_ = nil
			arg_774_1.onSingleLineFinish_ = nil
			arg_774_1.state_ = "waiting"
		end

		function arg_774_1.playNext_(arg_776_0)
			if arg_776_0 == 1 then
				arg_774_0:Play1107506190(arg_774_1)
			end
		end

		function arg_774_1.onSingleLineUpdate_(arg_777_0)
			local var_777_0 = arg_774_1.actors_["1075ui_actor"]
			local var_777_1 = 0

			if var_777_1 < arg_774_1.time_ and arg_774_1.time_ <= var_777_1 + arg_777_0 and not isNil(var_777_0) and arg_774_1.var_.characterEffect1075ui_actor == nil then
				arg_774_1.var_.characterEffect1075ui_actor = var_777_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_777_2 = 0.200000002980232

			if var_777_1 <= arg_774_1.time_ and arg_774_1.time_ < var_777_1 + var_777_2 and not isNil(var_777_0) then
				local var_777_3 = (arg_774_1.time_ - var_777_1) / var_777_2

				if arg_774_1.var_.characterEffect1075ui_actor and not isNil(var_777_0) then
					local var_777_4 = Mathf.Lerp(0, 0.5, var_777_3)

					arg_774_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_774_1.var_.characterEffect1075ui_actor.fillRatio = var_777_4
				end
			end

			if arg_774_1.time_ >= var_777_1 + var_777_2 and arg_774_1.time_ < var_777_1 + var_777_2 + arg_777_0 and not isNil(var_777_0) and arg_774_1.var_.characterEffect1075ui_actor then
				local var_777_5 = 0.5

				arg_774_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_774_1.var_.characterEffect1075ui_actor.fillRatio = var_777_5
			end

			local var_777_6 = 0
			local var_777_7 = 0.35

			if var_777_6 < arg_774_1.time_ and arg_774_1.time_ <= var_777_6 + arg_777_0 then
				arg_774_1.talkMaxDuration = 0
				arg_774_1.dialogCg_.alpha = 1

				arg_774_1.dialog_:SetActive(true)
				SetActive(arg_774_1.leftNameGo_, true)

				local var_777_8 = arg_774_1:FormatText(StoryNameCfg[7].name)

				arg_774_1.leftNameTxt_.text = var_777_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_774_1.leftNameTxt_.transform)

				arg_774_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_774_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_774_1:RecordName(arg_774_1.leftNameTxt_.text)
				SetActive(arg_774_1.iconTrs_.gameObject, true)
				arg_774_1.iconController_:SetSelectedState("hero")

				arg_774_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_774_1.callingController_:SetSelectedState("normal")

				arg_774_1.keyicon_.color = Color.New(1, 1, 1)
				arg_774_1.icon_.color = Color.New(1, 1, 1)

				local var_777_9 = arg_774_1:GetWordFromCfg(1107506189)
				local var_777_10 = arg_774_1:FormatText(var_777_9.content)

				arg_774_1.text_.text = var_777_10

				LuaForUtil.ClearLinePrefixSymbol(arg_774_1.text_)

				local var_777_11 = 14
				local var_777_12 = utf8.len(var_777_10)
				local var_777_13 = var_777_11 <= 0 and var_777_7 or var_777_7 * (var_777_12 / var_777_11)

				if var_777_13 > 0 and var_777_7 < var_777_13 then
					arg_774_1.talkMaxDuration = var_777_13

					if var_777_13 + var_777_6 > arg_774_1.duration_ then
						arg_774_1.duration_ = var_777_13 + var_777_6
					end
				end

				arg_774_1.text_.text = var_777_10
				arg_774_1.typewritter.percent = 0

				arg_774_1.typewritter:SetDirty()
				arg_774_1:ShowNextGo(false)
				arg_774_1:RecordContent(arg_774_1.text_.text)
			end

			local var_777_14 = math.max(var_777_7, arg_774_1.talkMaxDuration)

			if var_777_6 <= arg_774_1.time_ and arg_774_1.time_ < var_777_6 + var_777_14 then
				arg_774_1.typewritter.percent = (arg_774_1.time_ - var_777_6) / var_777_14

				arg_774_1.typewritter:SetDirty()
			end

			if arg_774_1.time_ >= var_777_6 + var_777_14 and arg_774_1.time_ < var_777_6 + var_777_14 + arg_777_0 then
				arg_774_1.typewritter.percent = 1

				arg_774_1.typewritter:SetDirty()
				arg_774_1:ShowNextGo(true)
			end
		end

		arg_774_1.nodeConfigList_ = {}

		arg_774_1:InitPlayNodeList()
	end,
	Play1107506190 = function(arg_778_0, arg_778_1)
		arg_778_1.time_ = 0
		arg_778_1.frameCnt_ = 0
		arg_778_1.state_ = "playing"
		arg_778_1.curTalkId_ = 1107506190
		arg_778_1.duration_ = 3.67

		SetActive(arg_778_1.tipsGo_, false)

		function arg_778_1.onSingleLineFinish_()
			arg_778_1.onSingleLineUpdate_ = nil
			arg_778_1.onSingleLineFinish_ = nil
			arg_778_1.state_ = "waiting"
		end

		function arg_778_1.playNext_(arg_780_0)
			if arg_780_0 == 1 then
				arg_778_0:Play1107506191(arg_778_1)
			end
		end

		function arg_778_1.onSingleLineUpdate_(arg_781_0)
			local var_781_0 = arg_778_1.actors_["1075ui_actor"]
			local var_781_1 = 0

			if var_781_1 < arg_778_1.time_ and arg_778_1.time_ <= var_781_1 + arg_781_0 and not isNil(var_781_0) and arg_778_1.var_.characterEffect1075ui_actor == nil then
				arg_778_1.var_.characterEffect1075ui_actor = var_781_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_781_2 = 0.200000002980232

			if var_781_1 <= arg_778_1.time_ and arg_778_1.time_ < var_781_1 + var_781_2 and not isNil(var_781_0) then
				local var_781_3 = (arg_778_1.time_ - var_781_1) / var_781_2

				if arg_778_1.var_.characterEffect1075ui_actor and not isNil(var_781_0) then
					arg_778_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_778_1.time_ >= var_781_1 + var_781_2 and arg_778_1.time_ < var_781_1 + var_781_2 + arg_781_0 and not isNil(var_781_0) and arg_778_1.var_.characterEffect1075ui_actor then
				arg_778_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_781_4 = 0

			if var_781_4 < arg_778_1.time_ and arg_778_1.time_ <= var_781_4 + arg_781_0 then
				arg_778_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_781_5 = 0

			if var_781_5 < arg_778_1.time_ and arg_778_1.time_ <= var_781_5 + arg_781_0 then
				arg_778_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_781_6 = 0
			local var_781_7 = 0.4

			if var_781_6 < arg_778_1.time_ and arg_778_1.time_ <= var_781_6 + arg_781_0 then
				arg_778_1.talkMaxDuration = 0
				arg_778_1.dialogCg_.alpha = 1

				arg_778_1.dialog_:SetActive(true)
				SetActive(arg_778_1.leftNameGo_, true)

				local var_781_8 = arg_778_1:FormatText(StoryNameCfg[381].name)

				arg_778_1.leftNameTxt_.text = var_781_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_778_1.leftNameTxt_.transform)

				arg_778_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_778_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_778_1:RecordName(arg_778_1.leftNameTxt_.text)
				SetActive(arg_778_1.iconTrs_.gameObject, false)
				arg_778_1.callingController_:SetSelectedState("normal")

				local var_781_9 = arg_778_1:GetWordFromCfg(1107506190)
				local var_781_10 = arg_778_1:FormatText(var_781_9.content)

				arg_778_1.text_.text = var_781_10

				LuaForUtil.ClearLinePrefixSymbol(arg_778_1.text_)

				local var_781_11 = 16
				local var_781_12 = utf8.len(var_781_10)
				local var_781_13 = var_781_11 <= 0 and var_781_7 or var_781_7 * (var_781_12 / var_781_11)

				if var_781_13 > 0 and var_781_7 < var_781_13 then
					arg_778_1.talkMaxDuration = var_781_13

					if var_781_13 + var_781_6 > arg_778_1.duration_ then
						arg_778_1.duration_ = var_781_13 + var_781_6
					end
				end

				arg_778_1.text_.text = var_781_10
				arg_778_1.typewritter.percent = 0

				arg_778_1.typewritter:SetDirty()
				arg_778_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506190", "story_v_side_new_1107506.awb") ~= 0 then
					local var_781_14 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506190", "story_v_side_new_1107506.awb") / 1000

					if var_781_14 + var_781_6 > arg_778_1.duration_ then
						arg_778_1.duration_ = var_781_14 + var_781_6
					end

					if var_781_9.prefab_name ~= "" and arg_778_1.actors_[var_781_9.prefab_name] ~= nil then
						local var_781_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_778_1.actors_[var_781_9.prefab_name].transform, "story_v_side_new_1107506", "1107506190", "story_v_side_new_1107506.awb")

						arg_778_1:RecordAudio("1107506190", var_781_15)
						arg_778_1:RecordAudio("1107506190", var_781_15)
					else
						arg_778_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506190", "story_v_side_new_1107506.awb")
					end

					arg_778_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506190", "story_v_side_new_1107506.awb")
				end

				arg_778_1:RecordContent(arg_778_1.text_.text)
			end

			local var_781_16 = math.max(var_781_7, arg_778_1.talkMaxDuration)

			if var_781_6 <= arg_778_1.time_ and arg_778_1.time_ < var_781_6 + var_781_16 then
				arg_778_1.typewritter.percent = (arg_778_1.time_ - var_781_6) / var_781_16

				arg_778_1.typewritter:SetDirty()
			end

			if arg_778_1.time_ >= var_781_6 + var_781_16 and arg_778_1.time_ < var_781_6 + var_781_16 + arg_781_0 then
				arg_778_1.typewritter.percent = 1

				arg_778_1.typewritter:SetDirty()
				arg_778_1:ShowNextGo(true)
			end
		end

		arg_778_1.nodeConfigList_ = {}

		arg_778_1:InitPlayNodeList()
	end,
	Play1107506191 = function(arg_782_0, arg_782_1)
		arg_782_1.time_ = 0
		arg_782_1.frameCnt_ = 0
		arg_782_1.state_ = "playing"
		arg_782_1.curTalkId_ = 1107506191
		arg_782_1.duration_ = 5

		SetActive(arg_782_1.tipsGo_, false)

		function arg_782_1.onSingleLineFinish_()
			arg_782_1.onSingleLineUpdate_ = nil
			arg_782_1.onSingleLineFinish_ = nil
			arg_782_1.state_ = "waiting"
		end

		function arg_782_1.playNext_(arg_784_0)
			if arg_784_0 == 1 then
				arg_782_0:Play1107506192(arg_782_1)
			end
		end

		function arg_782_1.onSingleLineUpdate_(arg_785_0)
			local var_785_0 = arg_782_1.actors_["1075ui_actor"]
			local var_785_1 = 0

			if var_785_1 < arg_782_1.time_ and arg_782_1.time_ <= var_785_1 + arg_785_0 and not isNil(var_785_0) and arg_782_1.var_.characterEffect1075ui_actor == nil then
				arg_782_1.var_.characterEffect1075ui_actor = var_785_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_785_2 = 0.200000002980232

			if var_785_1 <= arg_782_1.time_ and arg_782_1.time_ < var_785_1 + var_785_2 and not isNil(var_785_0) then
				local var_785_3 = (arg_782_1.time_ - var_785_1) / var_785_2

				if arg_782_1.var_.characterEffect1075ui_actor and not isNil(var_785_0) then
					local var_785_4 = Mathf.Lerp(0, 0.5, var_785_3)

					arg_782_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_782_1.var_.characterEffect1075ui_actor.fillRatio = var_785_4
				end
			end

			if arg_782_1.time_ >= var_785_1 + var_785_2 and arg_782_1.time_ < var_785_1 + var_785_2 + arg_785_0 and not isNil(var_785_0) and arg_782_1.var_.characterEffect1075ui_actor then
				local var_785_5 = 0.5

				arg_782_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_782_1.var_.characterEffect1075ui_actor.fillRatio = var_785_5
			end

			local var_785_6 = 0
			local var_785_7 = 0.5

			if var_785_6 < arg_782_1.time_ and arg_782_1.time_ <= var_785_6 + arg_785_0 then
				arg_782_1.talkMaxDuration = 0
				arg_782_1.dialogCg_.alpha = 1

				arg_782_1.dialog_:SetActive(true)
				SetActive(arg_782_1.leftNameGo_, true)

				local var_785_8 = arg_782_1:FormatText(StoryNameCfg[7].name)

				arg_782_1.leftNameTxt_.text = var_785_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_782_1.leftNameTxt_.transform)

				arg_782_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_782_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_782_1:RecordName(arg_782_1.leftNameTxt_.text)
				SetActive(arg_782_1.iconTrs_.gameObject, true)
				arg_782_1.iconController_:SetSelectedState("hero")

				arg_782_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_782_1.callingController_:SetSelectedState("normal")

				arg_782_1.keyicon_.color = Color.New(1, 1, 1)
				arg_782_1.icon_.color = Color.New(1, 1, 1)

				local var_785_9 = arg_782_1:GetWordFromCfg(1107506191)
				local var_785_10 = arg_782_1:FormatText(var_785_9.content)

				arg_782_1.text_.text = var_785_10

				LuaForUtil.ClearLinePrefixSymbol(arg_782_1.text_)

				local var_785_11 = 20
				local var_785_12 = utf8.len(var_785_10)
				local var_785_13 = var_785_11 <= 0 and var_785_7 or var_785_7 * (var_785_12 / var_785_11)

				if var_785_13 > 0 and var_785_7 < var_785_13 then
					arg_782_1.talkMaxDuration = var_785_13

					if var_785_13 + var_785_6 > arg_782_1.duration_ then
						arg_782_1.duration_ = var_785_13 + var_785_6
					end
				end

				arg_782_1.text_.text = var_785_10
				arg_782_1.typewritter.percent = 0

				arg_782_1.typewritter:SetDirty()
				arg_782_1:ShowNextGo(false)
				arg_782_1:RecordContent(arg_782_1.text_.text)
			end

			local var_785_14 = math.max(var_785_7, arg_782_1.talkMaxDuration)

			if var_785_6 <= arg_782_1.time_ and arg_782_1.time_ < var_785_6 + var_785_14 then
				arg_782_1.typewritter.percent = (arg_782_1.time_ - var_785_6) / var_785_14

				arg_782_1.typewritter:SetDirty()
			end

			if arg_782_1.time_ >= var_785_6 + var_785_14 and arg_782_1.time_ < var_785_6 + var_785_14 + arg_785_0 then
				arg_782_1.typewritter.percent = 1

				arg_782_1.typewritter:SetDirty()
				arg_782_1:ShowNextGo(true)
			end
		end

		arg_782_1.nodeConfigList_ = {}

		arg_782_1:InitPlayNodeList()
	end,
	Play1107506192 = function(arg_786_0, arg_786_1)
		arg_786_1.time_ = 0
		arg_786_1.frameCnt_ = 0
		arg_786_1.state_ = "playing"
		arg_786_1.curTalkId_ = 1107506192
		arg_786_1.duration_ = 5

		SetActive(arg_786_1.tipsGo_, false)

		function arg_786_1.onSingleLineFinish_()
			arg_786_1.onSingleLineUpdate_ = nil
			arg_786_1.onSingleLineFinish_ = nil
			arg_786_1.state_ = "waiting"
		end

		function arg_786_1.playNext_(arg_788_0)
			if arg_788_0 == 1 then
				arg_786_0:Play1107506193(arg_786_1)
			end
		end

		function arg_786_1.onSingleLineUpdate_(arg_789_0)
			local var_789_0 = arg_786_1.actors_["1075ui_actor"].transform
			local var_789_1 = 0

			if var_789_1 < arg_786_1.time_ and arg_786_1.time_ <= var_789_1 + arg_789_0 then
				arg_786_1.var_.moveOldPos1075ui_actor = var_789_0.localPosition

				local var_789_2 = GameObjectTools.GetOrAddComponent(var_789_0.gameObject, typeof(DynamicBoneHelper))

				if var_789_2 then
					var_789_2:EnableDynamicBone(false)
				end
			end

			local var_789_3 = 0.001

			if var_789_1 <= arg_786_1.time_ and arg_786_1.time_ < var_789_1 + var_789_3 then
				local var_789_4 = (arg_786_1.time_ - var_789_1) / var_789_3
				local var_789_5 = Vector3.New(0, 100, 0)

				var_789_0.localPosition = Vector3.Lerp(arg_786_1.var_.moveOldPos1075ui_actor, var_789_5, var_789_4)

				local var_789_6 = manager.ui.mainCamera.transform.position - var_789_0.position

				var_789_0.forward = Vector3.New(var_789_6.x, var_789_6.y, var_789_6.z)

				local var_789_7 = var_789_0.localEulerAngles

				var_789_7.z = 0
				var_789_7.x = 0
				var_789_0.localEulerAngles = var_789_7
			end

			if arg_786_1.time_ >= var_789_1 + var_789_3 and arg_786_1.time_ < var_789_1 + var_789_3 + arg_789_0 then
				var_789_0.localPosition = Vector3.New(0, 100, 0)

				local var_789_8 = manager.ui.mainCamera.transform.position - var_789_0.position

				var_789_0.forward = Vector3.New(var_789_8.x, var_789_8.y, var_789_8.z)

				local var_789_9 = var_789_0.localEulerAngles

				var_789_9.z = 0
				var_789_9.x = 0
				var_789_0.localEulerAngles = var_789_9

				local var_789_10 = GameObjectTools.GetOrAddComponent(var_789_0.gameObject, typeof(DynamicBoneHelper))

				if var_789_10 then
					var_789_10:EnableDynamicBone(true)
				end
			end

			local var_789_11 = 0
			local var_789_12 = 1.25

			if var_789_11 < arg_786_1.time_ and arg_786_1.time_ <= var_789_11 + arg_789_0 then
				arg_786_1.talkMaxDuration = 0
				arg_786_1.dialogCg_.alpha = 1

				arg_786_1.dialog_:SetActive(true)
				SetActive(arg_786_1.leftNameGo_, false)

				arg_786_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_786_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_786_1:RecordName(arg_786_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_786_1.iconTrs_.gameObject, false)
				arg_786_1.callingController_:SetSelectedState("normal")

				local var_789_13 = arg_786_1:GetWordFromCfg(1107506192)
				local var_789_14 = arg_786_1:FormatText(var_789_13.content)

				arg_786_1.text_.text = var_789_14

				LuaForUtil.ClearLinePrefixSymbol(arg_786_1.text_)

				local var_789_15 = 50
				local var_789_16 = utf8.len(var_789_14)
				local var_789_17 = var_789_15 <= 0 and var_789_12 or var_789_12 * (var_789_16 / var_789_15)

				if var_789_17 > 0 and var_789_12 < var_789_17 then
					arg_786_1.talkMaxDuration = var_789_17

					if var_789_17 + var_789_11 > arg_786_1.duration_ then
						arg_786_1.duration_ = var_789_17 + var_789_11
					end
				end

				arg_786_1.text_.text = var_789_14
				arg_786_1.typewritter.percent = 0

				arg_786_1.typewritter:SetDirty()
				arg_786_1:ShowNextGo(false)
				arg_786_1:RecordContent(arg_786_1.text_.text)
			end

			local var_789_18 = math.max(var_789_12, arg_786_1.talkMaxDuration)

			if var_789_11 <= arg_786_1.time_ and arg_786_1.time_ < var_789_11 + var_789_18 then
				arg_786_1.typewritter.percent = (arg_786_1.time_ - var_789_11) / var_789_18

				arg_786_1.typewritter:SetDirty()
			end

			if arg_786_1.time_ >= var_789_11 + var_789_18 and arg_786_1.time_ < var_789_11 + var_789_18 + arg_789_0 then
				arg_786_1.typewritter.percent = 1

				arg_786_1.typewritter:SetDirty()
				arg_786_1:ShowNextGo(true)
			end
		end

		arg_786_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_786_1:InitPlayNodeList()
	end,
	Play1107506193 = function(arg_790_0, arg_790_1)
		arg_790_1.time_ = 0
		arg_790_1.frameCnt_ = 0
		arg_790_1.state_ = "playing"
		arg_790_1.curTalkId_ = 1107506193
		arg_790_1.duration_ = 5

		SetActive(arg_790_1.tipsGo_, false)

		function arg_790_1.onSingleLineFinish_()
			arg_790_1.onSingleLineUpdate_ = nil
			arg_790_1.onSingleLineFinish_ = nil
			arg_790_1.state_ = "waiting"
			arg_790_1.auto_ = false
		end

		function arg_790_1.playNext_(arg_792_0)
			arg_790_1.onStoryFinished_()
		end

		function arg_790_1.onSingleLineUpdate_(arg_793_0)
			local var_793_0 = 0
			local var_793_1 = 0.775

			if var_793_0 < arg_790_1.time_ and arg_790_1.time_ <= var_793_0 + arg_793_0 then
				arg_790_1.talkMaxDuration = 0
				arg_790_1.dialogCg_.alpha = 1

				arg_790_1.dialog_:SetActive(true)
				SetActive(arg_790_1.leftNameGo_, false)

				arg_790_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_790_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_790_1:RecordName(arg_790_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_790_1.iconTrs_.gameObject, false)
				arg_790_1.callingController_:SetSelectedState("normal")

				local var_793_2 = arg_790_1:GetWordFromCfg(1107506193)
				local var_793_3 = arg_790_1:FormatText(var_793_2.content)

				arg_790_1.text_.text = var_793_3

				LuaForUtil.ClearLinePrefixSymbol(arg_790_1.text_)

				local var_793_4 = 31
				local var_793_5 = utf8.len(var_793_3)
				local var_793_6 = var_793_4 <= 0 and var_793_1 or var_793_1 * (var_793_5 / var_793_4)

				if var_793_6 > 0 and var_793_1 < var_793_6 then
					arg_790_1.talkMaxDuration = var_793_6

					if var_793_6 + var_793_0 > arg_790_1.duration_ then
						arg_790_1.duration_ = var_793_6 + var_793_0
					end
				end

				arg_790_1.text_.text = var_793_3
				arg_790_1.typewritter.percent = 0

				arg_790_1.typewritter:SetDirty()
				arg_790_1:ShowNextGo(false)
				arg_790_1:RecordContent(arg_790_1.text_.text)
			end

			local var_793_7 = math.max(var_793_1, arg_790_1.talkMaxDuration)

			if var_793_0 <= arg_790_1.time_ and arg_790_1.time_ < var_793_0 + var_793_7 then
				arg_790_1.typewritter.percent = (arg_790_1.time_ - var_793_0) / var_793_7

				arg_790_1.typewritter:SetDirty()
			end

			if arg_790_1.time_ >= var_793_0 + var_793_7 and arg_790_1.time_ < var_793_0 + var_793_7 + arg_793_0 then
				arg_790_1.typewritter.percent = 1

				arg_790_1.typewritter:SetDirty()
				arg_790_1:ShowNextGo(true)
			end
		end

		arg_790_1.nodeConfigList_ = {}

		arg_790_1:InitPlayNodeList()
	end,
	Play1107506128 = function(arg_794_0, arg_794_1)
		arg_794_1.time_ = 0
		arg_794_1.frameCnt_ = 0
		arg_794_1.state_ = "playing"
		arg_794_1.curTalkId_ = 1107506128
		arg_794_1.duration_ = 4.1

		SetActive(arg_794_1.tipsGo_, false)

		function arg_794_1.onSingleLineFinish_()
			arg_794_1.onSingleLineUpdate_ = nil
			arg_794_1.onSingleLineFinish_ = nil
			arg_794_1.state_ = "waiting"
		end

		function arg_794_1.playNext_(arg_796_0)
			if arg_796_0 == 1 then
				arg_794_0:Play1107506129(arg_794_1)
			end
		end

		function arg_794_1.onSingleLineUpdate_(arg_797_0)
			local var_797_0 = arg_794_1.actors_["1075ui_actor"].transform
			local var_797_1 = 0

			if var_797_1 < arg_794_1.time_ and arg_794_1.time_ <= var_797_1 + arg_797_0 then
				arg_794_1.var_.moveOldPos1075ui_actor = var_797_0.localPosition

				local var_797_2 = GameObjectTools.GetOrAddComponent(var_797_0.gameObject, typeof(DynamicBoneHelper))

				if var_797_2 then
					var_797_2:EnableDynamicBone(false)
				end
			end

			local var_797_3 = 0.001

			if var_797_1 <= arg_794_1.time_ and arg_794_1.time_ < var_797_1 + var_797_3 then
				local var_797_4 = (arg_794_1.time_ - var_797_1) / var_797_3
				local var_797_5 = Vector3.New(0, -1.055, -6.16)

				var_797_0.localPosition = Vector3.Lerp(arg_794_1.var_.moveOldPos1075ui_actor, var_797_5, var_797_4)

				local var_797_6 = manager.ui.mainCamera.transform.position - var_797_0.position

				var_797_0.forward = Vector3.New(var_797_6.x, var_797_6.y, var_797_6.z)

				local var_797_7 = var_797_0.localEulerAngles

				var_797_7.z = 0
				var_797_7.x = 0
				var_797_0.localEulerAngles = var_797_7
			end

			if arg_794_1.time_ >= var_797_1 + var_797_3 and arg_794_1.time_ < var_797_1 + var_797_3 + arg_797_0 then
				var_797_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_797_8 = manager.ui.mainCamera.transform.position - var_797_0.position

				var_797_0.forward = Vector3.New(var_797_8.x, var_797_8.y, var_797_8.z)

				local var_797_9 = var_797_0.localEulerAngles

				var_797_9.z = 0
				var_797_9.x = 0
				var_797_0.localEulerAngles = var_797_9

				local var_797_10 = GameObjectTools.GetOrAddComponent(var_797_0.gameObject, typeof(DynamicBoneHelper))

				if var_797_10 then
					var_797_10:EnableDynamicBone(true)
				end
			end

			local var_797_11 = arg_794_1.actors_["1075ui_actor"]
			local var_797_12 = 0

			if var_797_12 < arg_794_1.time_ and arg_794_1.time_ <= var_797_12 + arg_797_0 and not isNil(var_797_11) and arg_794_1.var_.characterEffect1075ui_actor == nil then
				arg_794_1.var_.characterEffect1075ui_actor = var_797_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_797_13 = 0.200000002980232

			if var_797_12 <= arg_794_1.time_ and arg_794_1.time_ < var_797_12 + var_797_13 and not isNil(var_797_11) then
				local var_797_14 = (arg_794_1.time_ - var_797_12) / var_797_13

				if arg_794_1.var_.characterEffect1075ui_actor and not isNil(var_797_11) then
					arg_794_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_794_1.time_ >= var_797_12 + var_797_13 and arg_794_1.time_ < var_797_12 + var_797_13 + arg_797_0 and not isNil(var_797_11) and arg_794_1.var_.characterEffect1075ui_actor then
				arg_794_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_797_15 = "1075ui_actor"

			if arg_794_1.actors_[var_797_15] == nil then
				local var_797_16 = Asset.Load("Char/" .. "1075ui_actor")

				if not isNil(var_797_16) then
					local var_797_17 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_794_1.stage_.transform)

					var_797_17.name = var_797_15
					var_797_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_794_1.actors_[var_797_15] = var_797_17

					local var_797_18 = var_797_17:GetComponentInChildren(typeof(CharacterEffect))

					var_797_18.enabled = true

					local var_797_19 = GameObjectTools.GetOrAddComponent(var_797_17, typeof(DynamicBoneHelper))

					if var_797_19 then
						var_797_19:EnableDynamicBone(false)
					end

					arg_794_1:ShowWeapon(var_797_18.transform, false)

					arg_794_1.var_[var_797_15 .. "Animator"] = var_797_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_794_1.var_[var_797_15 .. "Animator"].applyRootMotion = true
					arg_794_1.var_[var_797_15 .. "LipSync"] = var_797_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_797_20 = 0

			if var_797_20 < arg_794_1.time_ and arg_794_1.time_ <= var_797_20 + arg_797_0 then
				arg_794_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_797_21 = "1075ui_actor"

			if arg_794_1.actors_[var_797_21] == nil then
				local var_797_22 = Asset.Load("Char/" .. "1075ui_actor")

				if not isNil(var_797_22) then
					local var_797_23 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_794_1.stage_.transform)

					var_797_23.name = var_797_21
					var_797_23.transform.localPosition = Vector3.New(0, 100, 0)
					arg_794_1.actors_[var_797_21] = var_797_23

					local var_797_24 = var_797_23:GetComponentInChildren(typeof(CharacterEffect))

					var_797_24.enabled = true

					local var_797_25 = GameObjectTools.GetOrAddComponent(var_797_23, typeof(DynamicBoneHelper))

					if var_797_25 then
						var_797_25:EnableDynamicBone(false)
					end

					arg_794_1:ShowWeapon(var_797_24.transform, false)

					arg_794_1.var_[var_797_21 .. "Animator"] = var_797_24.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_794_1.var_[var_797_21 .. "Animator"].applyRootMotion = true
					arg_794_1.var_[var_797_21 .. "LipSync"] = var_797_24.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_797_26 = 0

			if var_797_26 < arg_794_1.time_ and arg_794_1.time_ <= var_797_26 + arg_797_0 then
				arg_794_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_797_27 = 0
			local var_797_28 = 0.45

			if var_797_27 < arg_794_1.time_ and arg_794_1.time_ <= var_797_27 + arg_797_0 then
				arg_794_1.talkMaxDuration = 0
				arg_794_1.dialogCg_.alpha = 1

				arg_794_1.dialog_:SetActive(true)
				SetActive(arg_794_1.leftNameGo_, true)

				local var_797_29 = arg_794_1:FormatText(StoryNameCfg[381].name)

				arg_794_1.leftNameTxt_.text = var_797_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_794_1.leftNameTxt_.transform)

				arg_794_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_794_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_794_1:RecordName(arg_794_1.leftNameTxt_.text)
				SetActive(arg_794_1.iconTrs_.gameObject, false)
				arg_794_1.callingController_:SetSelectedState("normal")

				local var_797_30 = arg_794_1:GetWordFromCfg(1107506128)
				local var_797_31 = arg_794_1:FormatText(var_797_30.content)

				arg_794_1.text_.text = var_797_31

				LuaForUtil.ClearLinePrefixSymbol(arg_794_1.text_)

				local var_797_32 = 18
				local var_797_33 = utf8.len(var_797_31)
				local var_797_34 = var_797_32 <= 0 and var_797_28 or var_797_28 * (var_797_33 / var_797_32)

				if var_797_34 > 0 and var_797_28 < var_797_34 then
					arg_794_1.talkMaxDuration = var_797_34

					if var_797_34 + var_797_27 > arg_794_1.duration_ then
						arg_794_1.duration_ = var_797_34 + var_797_27
					end
				end

				arg_794_1.text_.text = var_797_31
				arg_794_1.typewritter.percent = 0

				arg_794_1.typewritter:SetDirty()
				arg_794_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506128", "story_v_side_new_1107506.awb") ~= 0 then
					local var_797_35 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506128", "story_v_side_new_1107506.awb") / 1000

					if var_797_35 + var_797_27 > arg_794_1.duration_ then
						arg_794_1.duration_ = var_797_35 + var_797_27
					end

					if var_797_30.prefab_name ~= "" and arg_794_1.actors_[var_797_30.prefab_name] ~= nil then
						local var_797_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_794_1.actors_[var_797_30.prefab_name].transform, "story_v_side_new_1107506", "1107506128", "story_v_side_new_1107506.awb")

						arg_794_1:RecordAudio("1107506128", var_797_36)
						arg_794_1:RecordAudio("1107506128", var_797_36)
					else
						arg_794_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506128", "story_v_side_new_1107506.awb")
					end

					arg_794_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506128", "story_v_side_new_1107506.awb")
				end

				arg_794_1:RecordContent(arg_794_1.text_.text)
			end

			local var_797_37 = math.max(var_797_28, arg_794_1.talkMaxDuration)

			if var_797_27 <= arg_794_1.time_ and arg_794_1.time_ < var_797_27 + var_797_37 then
				arg_794_1.typewritter.percent = (arg_794_1.time_ - var_797_27) / var_797_37

				arg_794_1.typewritter:SetDirty()
			end

			if arg_794_1.time_ >= var_797_27 + var_797_37 and arg_794_1.time_ < var_797_27 + var_797_37 + arg_797_0 then
				arg_794_1.typewritter.percent = 1

				arg_794_1.typewritter:SetDirty()
				arg_794_1:ShowNextGo(true)
			end
		end

		arg_794_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_actor",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_794_1:InitPlayNodeList()
	end,
	Play1107506129 = function(arg_798_0, arg_798_1)
		arg_798_1.time_ = 0
		arg_798_1.frameCnt_ = 0
		arg_798_1.state_ = "playing"
		arg_798_1.curTalkId_ = 1107506129
		arg_798_1.duration_ = 5

		SetActive(arg_798_1.tipsGo_, false)

		function arg_798_1.onSingleLineFinish_()
			arg_798_1.onSingleLineUpdate_ = nil
			arg_798_1.onSingleLineFinish_ = nil
			arg_798_1.state_ = "waiting"
		end

		function arg_798_1.playNext_(arg_800_0)
			if arg_800_0 == 1 then
				arg_798_0:Play1107506130(arg_798_1)
			end
		end

		function arg_798_1.onSingleLineUpdate_(arg_801_0)
			local var_801_0 = arg_798_1.actors_["1075ui_actor"]
			local var_801_1 = 0

			if var_801_1 < arg_798_1.time_ and arg_798_1.time_ <= var_801_1 + arg_801_0 and not isNil(var_801_0) and arg_798_1.var_.characterEffect1075ui_actor == nil then
				arg_798_1.var_.characterEffect1075ui_actor = var_801_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_801_2 = 0.200000002980232

			if var_801_1 <= arg_798_1.time_ and arg_798_1.time_ < var_801_1 + var_801_2 and not isNil(var_801_0) then
				local var_801_3 = (arg_798_1.time_ - var_801_1) / var_801_2

				if arg_798_1.var_.characterEffect1075ui_actor and not isNil(var_801_0) then
					local var_801_4 = Mathf.Lerp(0, 0.5, var_801_3)

					arg_798_1.var_.characterEffect1075ui_actor.fillFlat = true
					arg_798_1.var_.characterEffect1075ui_actor.fillRatio = var_801_4
				end
			end

			if arg_798_1.time_ >= var_801_1 + var_801_2 and arg_798_1.time_ < var_801_1 + var_801_2 + arg_801_0 and not isNil(var_801_0) and arg_798_1.var_.characterEffect1075ui_actor then
				local var_801_5 = 0.5

				arg_798_1.var_.characterEffect1075ui_actor.fillFlat = true
				arg_798_1.var_.characterEffect1075ui_actor.fillRatio = var_801_5
			end

			local var_801_6 = 0
			local var_801_7 = 0.35

			if var_801_6 < arg_798_1.time_ and arg_798_1.time_ <= var_801_6 + arg_801_0 then
				arg_798_1.talkMaxDuration = 0
				arg_798_1.dialogCg_.alpha = 1

				arg_798_1.dialog_:SetActive(true)
				SetActive(arg_798_1.leftNameGo_, true)

				local var_801_8 = arg_798_1:FormatText(StoryNameCfg[7].name)

				arg_798_1.leftNameTxt_.text = var_801_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_798_1.leftNameTxt_.transform)

				arg_798_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_798_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_798_1:RecordName(arg_798_1.leftNameTxt_.text)
				SetActive(arg_798_1.iconTrs_.gameObject, true)
				arg_798_1.iconController_:SetSelectedState("hero")

				arg_798_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_798_1.callingController_:SetSelectedState("normal")

				arg_798_1.keyicon_.color = Color.New(1, 1, 1)
				arg_798_1.icon_.color = Color.New(1, 1, 1)

				local var_801_9 = arg_798_1:GetWordFromCfg(1107506129)
				local var_801_10 = arg_798_1:FormatText(var_801_9.content)

				arg_798_1.text_.text = var_801_10

				LuaForUtil.ClearLinePrefixSymbol(arg_798_1.text_)

				local var_801_11 = 14
				local var_801_12 = utf8.len(var_801_10)
				local var_801_13 = var_801_11 <= 0 and var_801_7 or var_801_7 * (var_801_12 / var_801_11)

				if var_801_13 > 0 and var_801_7 < var_801_13 then
					arg_798_1.talkMaxDuration = var_801_13

					if var_801_13 + var_801_6 > arg_798_1.duration_ then
						arg_798_1.duration_ = var_801_13 + var_801_6
					end
				end

				arg_798_1.text_.text = var_801_10
				arg_798_1.typewritter.percent = 0

				arg_798_1.typewritter:SetDirty()
				arg_798_1:ShowNextGo(false)
				arg_798_1:RecordContent(arg_798_1.text_.text)
			end

			local var_801_14 = math.max(var_801_7, arg_798_1.talkMaxDuration)

			if var_801_6 <= arg_798_1.time_ and arg_798_1.time_ < var_801_6 + var_801_14 then
				arg_798_1.typewritter.percent = (arg_798_1.time_ - var_801_6) / var_801_14

				arg_798_1.typewritter:SetDirty()
			end

			if arg_798_1.time_ >= var_801_6 + var_801_14 and arg_798_1.time_ < var_801_6 + var_801_14 + arg_801_0 then
				arg_798_1.typewritter.percent = 1

				arg_798_1.typewritter:SetDirty()
				arg_798_1:ShowNextGo(true)
			end
		end

		arg_798_1.nodeConfigList_ = {}

		arg_798_1:InitPlayNodeList()
	end,
	Play1107506118 = function(arg_802_0, arg_802_1)
		arg_802_1.time_ = 0
		arg_802_1.frameCnt_ = 0
		arg_802_1.state_ = "playing"
		arg_802_1.curTalkId_ = 1107506118
		arg_802_1.duration_ = 5.4

		SetActive(arg_802_1.tipsGo_, false)

		function arg_802_1.onSingleLineFinish_()
			arg_802_1.onSingleLineUpdate_ = nil
			arg_802_1.onSingleLineFinish_ = nil
			arg_802_1.state_ = "waiting"
		end

		function arg_802_1.playNext_(arg_804_0)
			if arg_804_0 == 1 then
				arg_802_0:Play1107506119(arg_802_1)
			end
		end

		function arg_802_1.onSingleLineUpdate_(arg_805_0)
			local var_805_0 = "1075ui_actor"

			if arg_802_1.actors_[var_805_0] == nil then
				local var_805_1 = Asset.Load("Char/" .. "1075ui_actor")

				if not isNil(var_805_1) then
					local var_805_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_802_1.stage_.transform)

					var_805_2.name = var_805_0
					var_805_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_802_1.actors_[var_805_0] = var_805_2

					local var_805_3 = var_805_2:GetComponentInChildren(typeof(CharacterEffect))

					var_805_3.enabled = true

					local var_805_4 = GameObjectTools.GetOrAddComponent(var_805_2, typeof(DynamicBoneHelper))

					if var_805_4 then
						var_805_4:EnableDynamicBone(false)
					end

					arg_802_1:ShowWeapon(var_805_3.transform, false)

					arg_802_1.var_[var_805_0 .. "Animator"] = var_805_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_802_1.var_[var_805_0 .. "Animator"].applyRootMotion = true
					arg_802_1.var_[var_805_0 .. "LipSync"] = var_805_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_805_5 = 0

			if var_805_5 < arg_802_1.time_ and arg_802_1.time_ <= var_805_5 + arg_805_0 then
				arg_802_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_805_6 = "1075ui_actor"

			if arg_802_1.actors_[var_805_6] == nil then
				local var_805_7 = Asset.Load("Char/" .. "1075ui_actor")

				if not isNil(var_805_7) then
					local var_805_8 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_actor"), arg_802_1.stage_.transform)

					var_805_8.name = var_805_6
					var_805_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_802_1.actors_[var_805_6] = var_805_8

					local var_805_9 = var_805_8:GetComponentInChildren(typeof(CharacterEffect))

					var_805_9.enabled = true

					local var_805_10 = GameObjectTools.GetOrAddComponent(var_805_8, typeof(DynamicBoneHelper))

					if var_805_10 then
						var_805_10:EnableDynamicBone(false)
					end

					arg_802_1:ShowWeapon(var_805_9.transform, false)

					arg_802_1.var_[var_805_6 .. "Animator"] = var_805_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_802_1.var_[var_805_6 .. "Animator"].applyRootMotion = true
					arg_802_1.var_[var_805_6 .. "LipSync"] = var_805_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_805_11 = 0

			if var_805_11 < arg_802_1.time_ and arg_802_1.time_ <= var_805_11 + arg_805_0 then
				arg_802_1:PlayTimeline("1075ui_actor", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_805_12 = arg_802_1.actors_["1075ui_actor"]
			local var_805_13 = 0

			if var_805_13 < arg_802_1.time_ and arg_802_1.time_ <= var_805_13 + arg_805_0 and not isNil(var_805_12) and arg_802_1.var_.characterEffect1075ui_actor == nil then
				arg_802_1.var_.characterEffect1075ui_actor = var_805_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_805_14 = 0.200000002980232

			if var_805_13 <= arg_802_1.time_ and arg_802_1.time_ < var_805_13 + var_805_14 and not isNil(var_805_12) then
				local var_805_15 = (arg_802_1.time_ - var_805_13) / var_805_14

				if arg_802_1.var_.characterEffect1075ui_actor and not isNil(var_805_12) then
					arg_802_1.var_.characterEffect1075ui_actor.fillFlat = false
				end
			end

			if arg_802_1.time_ >= var_805_13 + var_805_14 and arg_802_1.time_ < var_805_13 + var_805_14 + arg_805_0 and not isNil(var_805_12) and arg_802_1.var_.characterEffect1075ui_actor then
				arg_802_1.var_.characterEffect1075ui_actor.fillFlat = false
			end

			local var_805_16 = 0
			local var_805_17 = 0.5

			if var_805_16 < arg_802_1.time_ and arg_802_1.time_ <= var_805_16 + arg_805_0 then
				arg_802_1.talkMaxDuration = 0
				arg_802_1.dialogCg_.alpha = 1

				arg_802_1.dialog_:SetActive(true)
				SetActive(arg_802_1.leftNameGo_, true)

				local var_805_18 = arg_802_1:FormatText(StoryNameCfg[381].name)

				arg_802_1.leftNameTxt_.text = var_805_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_802_1.leftNameTxt_.transform)

				arg_802_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_802_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_802_1:RecordName(arg_802_1.leftNameTxt_.text)
				SetActive(arg_802_1.iconTrs_.gameObject, false)
				arg_802_1.callingController_:SetSelectedState("normal")

				local var_805_19 = arg_802_1:GetWordFromCfg(1107506118)
				local var_805_20 = arg_802_1:FormatText(var_805_19.content)

				arg_802_1.text_.text = var_805_20

				LuaForUtil.ClearLinePrefixSymbol(arg_802_1.text_)

				local var_805_21 = 20
				local var_805_22 = utf8.len(var_805_20)
				local var_805_23 = var_805_21 <= 0 and var_805_17 or var_805_17 * (var_805_22 / var_805_21)

				if var_805_23 > 0 and var_805_17 < var_805_23 then
					arg_802_1.talkMaxDuration = var_805_23

					if var_805_23 + var_805_16 > arg_802_1.duration_ then
						arg_802_1.duration_ = var_805_23 + var_805_16
					end
				end

				arg_802_1.text_.text = var_805_20
				arg_802_1.typewritter.percent = 0

				arg_802_1.typewritter:SetDirty()
				arg_802_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506118", "story_v_side_new_1107506.awb") ~= 0 then
					local var_805_24 = manager.audio:GetVoiceLength("story_v_side_new_1107506", "1107506118", "story_v_side_new_1107506.awb") / 1000

					if var_805_24 + var_805_16 > arg_802_1.duration_ then
						arg_802_1.duration_ = var_805_24 + var_805_16
					end

					if var_805_19.prefab_name ~= "" and arg_802_1.actors_[var_805_19.prefab_name] ~= nil then
						local var_805_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_802_1.actors_[var_805_19.prefab_name].transform, "story_v_side_new_1107506", "1107506118", "story_v_side_new_1107506.awb")

						arg_802_1:RecordAudio("1107506118", var_805_25)
						arg_802_1:RecordAudio("1107506118", var_805_25)
					else
						arg_802_1:AudioAction("play", "voice", "story_v_side_new_1107506", "1107506118", "story_v_side_new_1107506.awb")
					end

					arg_802_1:RecordHistoryTalkVoice("story_v_side_new_1107506", "1107506118", "story_v_side_new_1107506.awb")
				end

				arg_802_1:RecordContent(arg_802_1.text_.text)
			end

			local var_805_26 = math.max(var_805_17, arg_802_1.talkMaxDuration)

			if var_805_16 <= arg_802_1.time_ and arg_802_1.time_ < var_805_16 + var_805_26 then
				arg_802_1.typewritter.percent = (arg_802_1.time_ - var_805_16) / var_805_26

				arg_802_1.typewritter:SetDirty()
			end

			if arg_802_1.time_ >= var_805_16 + var_805_26 and arg_802_1.time_ < var_805_16 + var_805_26 + arg_805_0 then
				arg_802_1.typewritter.percent = 1

				arg_802_1.typewritter:SetDirty()
				arg_802_1:ShowNextGo(true)
			end
		end

		arg_802_1.nodeConfigList_ = {}

		arg_802_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST32a",
		"TextureConfig/Background/ST37a",
		"TextureConfig/Background/ST47",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/R7502",
		"TextureConfig/Background/R7502a",
		"TextureConfig/Background/ST45"
	},
	voices = {
		"story_v_side_new_1107506.awb"
	}
}
