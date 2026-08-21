return {
	Play1106101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1106101001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1106101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST41a"

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
				local var_4_5 = arg_1_1.bgs_.ST41a

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
					if iter_4_0 ~= "ST41a" then
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

			local var_4_24 = 0.0333333333333333
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_4_28 = 0
			local var_4_29 = 0.433333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 0.25

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_37 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_38 = arg_1_1:GetWordFromCfg(1106101001)
				local var_4_39 = arg_1_1:FormatText(var_4_38.content)

				arg_1_1.text_.text = var_4_39

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 10
				local var_4_41 = utf8.len(var_4_39)
				local var_4_42 = var_4_40 <= 0 and var_4_35 or var_4_35 * (var_4_41 / var_4_40)

				if var_4_42 > 0 and var_4_35 < var_4_42 then
					arg_1_1.talkMaxDuration = var_4_42
					var_4_34 = var_4_34 + 0.3

					if var_4_42 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_42 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_39
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_43 = var_4_34 + 0.3
			local var_4_44 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_43 <= arg_1_1.time_ and arg_1_1.time_ < var_4_43 + var_4_44 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_43) / var_4_44

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1106101002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1106101002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1106101003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.3

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

				local var_11_2 = arg_8_1:GetWordFromCfg(1106101002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 52
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
	Play1106101003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1106101003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1106101004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.75

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(1106101003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 30
				local var_15_5 = utf8.len(var_15_3)
				local var_15_6 = var_15_4 <= 0 and var_15_1 or var_15_1 * (var_15_5 / var_15_4)

				if var_15_6 > 0 and var_15_1 < var_15_6 then
					arg_12_1.talkMaxDuration = var_15_6

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_7 and arg_12_1.time_ < var_15_0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play1106101004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1106101004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1106101005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.375

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(1106101004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 15
				local var_19_6 = utf8.len(var_19_4)
				local var_19_7 = var_19_5 <= 0 and var_19_1 or var_19_1 * (var_19_6 / var_19_5)

				if var_19_7 > 0 and var_19_1 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_0
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_8 and arg_16_1.time_ < var_19_0 + var_19_8 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play1106101005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1106101005
		arg_20_1.duration_ = 1.6

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1106101006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "1061ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_20_1.stage_.transform)

					var_23_2.name = var_23_0
					var_23_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_20_1.actors_[var_23_0] = var_23_2

					local var_23_3 = var_23_2:GetComponentInChildren(typeof(CharacterEffect))

					var_23_3.enabled = true

					local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_2, typeof(DynamicBoneHelper))

					if var_23_4 then
						var_23_4:EnableDynamicBone(false)
					end

					arg_20_1:ShowWeapon(var_23_3.transform, false)

					arg_20_1.var_[var_23_0 .. "Animator"] = var_23_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_20_1.var_[var_23_0 .. "Animator"].applyRootMotion = true
					arg_20_1.var_[var_23_0 .. "LipSync"] = var_23_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_23_5 = arg_20_1.actors_["1061ui_story"]
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1061ui_story == nil then
				arg_20_1.var_.characterEffect1061ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_7 = 0.200000002980232

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 and not isNil(var_23_5) then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7

				if arg_20_1.var_.characterEffect1061ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1061ui_story then
				arg_20_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_23_9 = 0
			local var_23_10 = 1

			if var_23_9 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 then
				local var_23_11 = "play"
				local var_23_12 = "effect"

				arg_20_1:AudioAction(var_23_11, var_23_12, "se_story_141", "se_story_141_xuanji01", "")
			end

			local var_23_13 = 0
			local var_23_14 = 0.433333333333333

			if var_23_13 < arg_20_1.time_ and arg_20_1.time_ <= var_23_13 + arg_23_0 then
				local var_23_15 = "play"
				local var_23_16 = "music"

				arg_20_1:AudioAction(var_23_15, var_23_16, "ui_battle", "ui_battle_stopbgm", "")

				local var_23_17 = ""
				local var_23_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_23_18 ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_18 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_18

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_18
						arg_20_1.bgmTxt2_.text = var_23_18
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

			local var_23_19 = 0.6
			local var_23_20 = 1

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				local var_23_21 = "play"
				local var_23_22 = "music"

				arg_20_1:AudioAction(var_23_21, var_23_22, "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan.awb")

				local var_23_23 = ""
				local var_23_24 = manager.audio:GetAudioName("bgm_activity_2_1_story_sifangyuan", "bgm_activity_2_1_story_sifangyuan")

				if var_23_24 ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_24 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_24

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_24
						arg_20_1.bgmTxt2_.text = var_23_24
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

			local var_23_25 = 0
			local var_23_26 = 0.1

			if var_23_25 < arg_20_1.time_ and arg_20_1.time_ <= var_23_25 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_27 = arg_20_1:FormatText(StoryNameCfg[612].name)

				arg_20_1.leftNameTxt_.text = var_23_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_28 = arg_20_1:GetWordFromCfg(1106101005)
				local var_23_29 = arg_20_1:FormatText(var_23_28.content)

				arg_20_1.text_.text = var_23_29

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_30 = 4
				local var_23_31 = utf8.len(var_23_29)
				local var_23_32 = var_23_30 <= 0 and var_23_26 or var_23_26 * (var_23_31 / var_23_30)

				if var_23_32 > 0 and var_23_26 < var_23_32 then
					arg_20_1.talkMaxDuration = var_23_32

					if var_23_32 + var_23_25 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_32 + var_23_25
					end
				end

				arg_20_1.text_.text = var_23_29
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101005", "story_v_side_new_1106101.awb") ~= 0 then
					local var_23_33 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101005", "story_v_side_new_1106101.awb") / 1000

					if var_23_33 + var_23_25 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_33 + var_23_25
					end

					if var_23_28.prefab_name ~= "" and arg_20_1.actors_[var_23_28.prefab_name] ~= nil then
						local var_23_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_28.prefab_name].transform, "story_v_side_new_1106101", "1106101005", "story_v_side_new_1106101.awb")

						arg_20_1:RecordAudio("1106101005", var_23_34)
						arg_20_1:RecordAudio("1106101005", var_23_34)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101005", "story_v_side_new_1106101.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101005", "story_v_side_new_1106101.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_35 = math.max(var_23_26, arg_20_1.talkMaxDuration)

			if var_23_25 <= arg_20_1.time_ and arg_20_1.time_ < var_23_25 + var_23_35 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_25) / var_23_35

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_25 + var_23_35 and arg_20_1.time_ < var_23_25 + var_23_35 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1106101006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 1106101006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play1106101007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1061ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1061ui_story == nil then
				arg_26_1.var_.characterEffect1061ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.200000002980232

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect1061ui_story and not isNil(var_29_0) then
					local var_29_4 = Mathf.Lerp(0, 0.5, var_29_3)

					arg_26_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_26_1.var_.characterEffect1061ui_story.fillRatio = var_29_4
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1061ui_story then
				local var_29_5 = 0.5

				arg_26_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_26_1.var_.characterEffect1061ui_story.fillRatio = var_29_5
			end

			local var_29_6 = 0
			local var_29_7 = 0.325

			if var_29_6 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_8 = arg_26_1:FormatText(StoryNameCfg[7].name)

				arg_26_1.leftNameTxt_.text = var_29_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_9 = arg_26_1:GetWordFromCfg(1106101006)
				local var_29_10 = arg_26_1:FormatText(var_29_9.content)

				arg_26_1.text_.text = var_29_10

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_11 = 13
				local var_29_12 = utf8.len(var_29_10)
				local var_29_13 = var_29_11 <= 0 and var_29_7 or var_29_7 * (var_29_12 / var_29_11)

				if var_29_13 > 0 and var_29_7 < var_29_13 then
					arg_26_1.talkMaxDuration = var_29_13

					if var_29_13 + var_29_6 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_13 + var_29_6
					end
				end

				arg_26_1.text_.text = var_29_10
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_14 = math.max(var_29_7, arg_26_1.talkMaxDuration)

			if var_29_6 <= arg_26_1.time_ and arg_26_1.time_ < var_29_6 + var_29_14 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_6) / var_29_14

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_6 + var_29_14 and arg_26_1.time_ < var_29_6 + var_29_14 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play1106101007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 1106101007
		arg_30_1.duration_ = 3.1

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play1106101008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1061ui_story"].transform
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.var_.moveOldPos1061ui_story = var_33_0.localPosition

				local var_33_2 = "1061ui_story"

				arg_30_1:ShowWeapon(arg_30_1.var_[var_33_2 .. "Animator"].transform, false)
			end

			local var_33_3 = 0.001

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_3 then
				local var_33_4 = (arg_30_1.time_ - var_33_1) / var_33_3
				local var_33_5 = Vector3.New(0, -1.18, -6.15)

				var_33_0.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1061ui_story, var_33_5, var_33_4)

				local var_33_6 = manager.ui.mainCamera.transform.position - var_33_0.position

				var_33_0.forward = Vector3.New(var_33_6.x, var_33_6.y, var_33_6.z)

				local var_33_7 = var_33_0.localEulerAngles

				var_33_7.z = 0
				var_33_7.x = 0
				var_33_0.localEulerAngles = var_33_7
			end

			if arg_30_1.time_ >= var_33_1 + var_33_3 and arg_30_1.time_ < var_33_1 + var_33_3 + arg_33_0 then
				var_33_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_33_8 = manager.ui.mainCamera.transform.position - var_33_0.position

				var_33_0.forward = Vector3.New(var_33_8.x, var_33_8.y, var_33_8.z)

				local var_33_9 = var_33_0.localEulerAngles

				var_33_9.z = 0
				var_33_9.x = 0
				var_33_0.localEulerAngles = var_33_9
			end

			local var_33_10 = arg_30_1.actors_["1061ui_story"]
			local var_33_11 = 0

			if var_33_11 < arg_30_1.time_ and arg_30_1.time_ <= var_33_11 + arg_33_0 and not isNil(var_33_10) and arg_30_1.var_.characterEffect1061ui_story == nil then
				arg_30_1.var_.characterEffect1061ui_story = var_33_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_12 = 0.200000002980232

			if var_33_11 <= arg_30_1.time_ and arg_30_1.time_ < var_33_11 + var_33_12 and not isNil(var_33_10) then
				local var_33_13 = (arg_30_1.time_ - var_33_11) / var_33_12

				if arg_30_1.var_.characterEffect1061ui_story and not isNil(var_33_10) then
					arg_30_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_11 + var_33_12 and arg_30_1.time_ < var_33_11 + var_33_12 + arg_33_0 and not isNil(var_33_10) and arg_30_1.var_.characterEffect1061ui_story then
				arg_30_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_33_14 = 0

			if var_33_14 < arg_30_1.time_ and arg_30_1.time_ <= var_33_14 + arg_33_0 then
				arg_30_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			local var_33_15 = 0

			if var_33_15 < arg_30_1.time_ and arg_30_1.time_ <= var_33_15 + arg_33_0 then
				arg_30_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_33_16 = 0
			local var_33_17 = 0.225

			if var_33_16 < arg_30_1.time_ and arg_30_1.time_ <= var_33_16 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_18 = arg_30_1:FormatText(StoryNameCfg[612].name)

				arg_30_1.leftNameTxt_.text = var_33_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_19 = arg_30_1:GetWordFromCfg(1106101007)
				local var_33_20 = arg_30_1:FormatText(var_33_19.content)

				arg_30_1.text_.text = var_33_20

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_21 = 9
				local var_33_22 = utf8.len(var_33_20)
				local var_33_23 = var_33_21 <= 0 and var_33_17 or var_33_17 * (var_33_22 / var_33_21)

				if var_33_23 > 0 and var_33_17 < var_33_23 then
					arg_30_1.talkMaxDuration = var_33_23

					if var_33_23 + var_33_16 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_23 + var_33_16
					end
				end

				arg_30_1.text_.text = var_33_20
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101007", "story_v_side_new_1106101.awb") ~= 0 then
					local var_33_24 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101007", "story_v_side_new_1106101.awb") / 1000

					if var_33_24 + var_33_16 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_24 + var_33_16
					end

					if var_33_19.prefab_name ~= "" and arg_30_1.actors_[var_33_19.prefab_name] ~= nil then
						local var_33_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_19.prefab_name].transform, "story_v_side_new_1106101", "1106101007", "story_v_side_new_1106101.awb")

						arg_30_1:RecordAudio("1106101007", var_33_25)
						arg_30_1:RecordAudio("1106101007", var_33_25)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101007", "story_v_side_new_1106101.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101007", "story_v_side_new_1106101.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_26 = math.max(var_33_17, arg_30_1.talkMaxDuration)

			if var_33_16 <= arg_30_1.time_ and arg_30_1.time_ < var_33_16 + var_33_26 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_16) / var_33_26

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_16 + var_33_26 and arg_30_1.time_ < var_33_16 + var_33_26 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play1106101008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 1106101008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play1106101009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1061ui_story"].transform
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 then
				arg_34_1.var_.moveOldPos1061ui_story = var_37_0.localPosition
			end

			local var_37_2 = 0.001

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2
				local var_37_4 = Vector3.New(0, 100, 0)

				var_37_0.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1061ui_story, var_37_4, var_37_3)

				local var_37_5 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_5.x, var_37_5.y, var_37_5.z)

				local var_37_6 = var_37_0.localEulerAngles

				var_37_6.z = 0
				var_37_6.x = 0
				var_37_0.localEulerAngles = var_37_6
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 then
				var_37_0.localPosition = Vector3.New(0, 100, 0)

				local var_37_7 = manager.ui.mainCamera.transform.position - var_37_0.position

				var_37_0.forward = Vector3.New(var_37_7.x, var_37_7.y, var_37_7.z)

				local var_37_8 = var_37_0.localEulerAngles

				var_37_8.z = 0
				var_37_8.x = 0
				var_37_0.localEulerAngles = var_37_8
			end

			local var_37_9 = arg_34_1.actors_["1061ui_story"]
			local var_37_10 = 0

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect1061ui_story == nil then
				arg_34_1.var_.characterEffect1061ui_story = var_37_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_11 = 0.200000002980232

			if var_37_10 <= arg_34_1.time_ and arg_34_1.time_ < var_37_10 + var_37_11 and not isNil(var_37_9) then
				local var_37_12 = (arg_34_1.time_ - var_37_10) / var_37_11

				if arg_34_1.var_.characterEffect1061ui_story and not isNil(var_37_9) then
					local var_37_13 = Mathf.Lerp(0, 0.5, var_37_12)

					arg_34_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1061ui_story.fillRatio = var_37_13
				end
			end

			if arg_34_1.time_ >= var_37_10 + var_37_11 and arg_34_1.time_ < var_37_10 + var_37_11 + arg_37_0 and not isNil(var_37_9) and arg_34_1.var_.characterEffect1061ui_story then
				local var_37_14 = 0.5

				arg_34_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1061ui_story.fillRatio = var_37_14
			end

			local var_37_15 = 0
			local var_37_16 = 0.925

			if var_37_15 < arg_34_1.time_ and arg_34_1.time_ <= var_37_15 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_17 = arg_34_1:GetWordFromCfg(1106101008)
				local var_37_18 = arg_34_1:FormatText(var_37_17.content)

				arg_34_1.text_.text = var_37_18

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_19 = 37
				local var_37_20 = utf8.len(var_37_18)
				local var_37_21 = var_37_19 <= 0 and var_37_16 or var_37_16 * (var_37_20 / var_37_19)

				if var_37_21 > 0 and var_37_16 < var_37_21 then
					arg_34_1.talkMaxDuration = var_37_21

					if var_37_21 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_21 + var_37_15
					end
				end

				arg_34_1.text_.text = var_37_18
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_22 = math.max(var_37_16, arg_34_1.talkMaxDuration)

			if var_37_15 <= arg_34_1.time_ and arg_34_1.time_ < var_37_15 + var_37_22 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_15) / var_37_22

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_15 + var_37_22 and arg_34_1.time_ < var_37_15 + var_37_22 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play1106101009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 1106101009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play1106101010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 0.65

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_2 = arg_38_1:FormatText(StoryNameCfg[7].name)

				arg_38_1.leftNameTxt_.text = var_41_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_3 = arg_38_1:GetWordFromCfg(1106101009)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 26
				local var_41_6 = utf8.len(var_41_4)
				local var_41_7 = var_41_5 <= 0 and var_41_1 or var_41_1 * (var_41_6 / var_41_5)

				if var_41_7 > 0 and var_41_1 < var_41_7 then
					arg_38_1.talkMaxDuration = var_41_7

					if var_41_7 + var_41_0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_7 + var_41_0
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_8 = math.max(var_41_1, arg_38_1.talkMaxDuration)

			if var_41_0 <= arg_38_1.time_ and arg_38_1.time_ < var_41_0 + var_41_8 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_0) / var_41_8

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_0 + var_41_8 and arg_38_1.time_ < var_41_0 + var_41_8 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play1106101010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 1106101010
		arg_42_1.duration_ = 2

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play1106101011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1061ui_story"].transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.moveOldPos1061ui_story = var_45_0.localPosition
			end

			local var_45_2 = 0.001

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2
				local var_45_4 = Vector3.New(0, -1.18, -6.15)

				var_45_0.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1061ui_story, var_45_4, var_45_3)

				local var_45_5 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_5.x, var_45_5.y, var_45_5.z)

				local var_45_6 = var_45_0.localEulerAngles

				var_45_6.z = 0
				var_45_6.x = 0
				var_45_0.localEulerAngles = var_45_6
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 then
				var_45_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_45_7 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_7.x, var_45_7.y, var_45_7.z)

				local var_45_8 = var_45_0.localEulerAngles

				var_45_8.z = 0
				var_45_8.x = 0
				var_45_0.localEulerAngles = var_45_8
			end

			local var_45_9 = arg_42_1.actors_["1061ui_story"]
			local var_45_10 = 0

			if var_45_10 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 and not isNil(var_45_9) and arg_42_1.var_.characterEffect1061ui_story == nil then
				arg_42_1.var_.characterEffect1061ui_story = var_45_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_11 = 0.200000002980232

			if var_45_10 <= arg_42_1.time_ and arg_42_1.time_ < var_45_10 + var_45_11 and not isNil(var_45_9) then
				local var_45_12 = (arg_42_1.time_ - var_45_10) / var_45_11

				if arg_42_1.var_.characterEffect1061ui_story and not isNil(var_45_9) then
					arg_42_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_10 + var_45_11 and arg_42_1.time_ < var_45_10 + var_45_11 + arg_45_0 and not isNil(var_45_9) and arg_42_1.var_.characterEffect1061ui_story then
				arg_42_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_45_13 = 0

			if var_45_13 < arg_42_1.time_ and arg_42_1.time_ <= var_45_13 + arg_45_0 then
				arg_42_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			local var_45_14 = 0

			if var_45_14 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
				arg_42_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_45_15 = 0
			local var_45_16 = 0.075

			if var_45_15 < arg_42_1.time_ and arg_42_1.time_ <= var_45_15 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_17 = arg_42_1:FormatText(StoryNameCfg[612].name)

				arg_42_1.leftNameTxt_.text = var_45_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_18 = arg_42_1:GetWordFromCfg(1106101010)
				local var_45_19 = arg_42_1:FormatText(var_45_18.content)

				arg_42_1.text_.text = var_45_19

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_20 = 3
				local var_45_21 = utf8.len(var_45_19)
				local var_45_22 = var_45_20 <= 0 and var_45_16 or var_45_16 * (var_45_21 / var_45_20)

				if var_45_22 > 0 and var_45_16 < var_45_22 then
					arg_42_1.talkMaxDuration = var_45_22

					if var_45_22 + var_45_15 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_22 + var_45_15
					end
				end

				arg_42_1.text_.text = var_45_19
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101010", "story_v_side_new_1106101.awb") ~= 0 then
					local var_45_23 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101010", "story_v_side_new_1106101.awb") / 1000

					if var_45_23 + var_45_15 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_23 + var_45_15
					end

					if var_45_18.prefab_name ~= "" and arg_42_1.actors_[var_45_18.prefab_name] ~= nil then
						local var_45_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_18.prefab_name].transform, "story_v_side_new_1106101", "1106101010", "story_v_side_new_1106101.awb")

						arg_42_1:RecordAudio("1106101010", var_45_24)
						arg_42_1:RecordAudio("1106101010", var_45_24)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101010", "story_v_side_new_1106101.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101010", "story_v_side_new_1106101.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_25 = math.max(var_45_16, arg_42_1.talkMaxDuration)

			if var_45_15 <= arg_42_1.time_ and arg_42_1.time_ < var_45_15 + var_45_25 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_15) / var_45_25

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_15 + var_45_25 and arg_42_1.time_ < var_45_15 + var_45_25 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play1106101011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 1106101011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play1106101012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1061ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1061ui_story == nil then
				arg_46_1.var_.characterEffect1061ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect1061ui_story and not isNil(var_49_0) then
					local var_49_4 = Mathf.Lerp(0, 0.5, var_49_3)

					arg_46_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1061ui_story.fillRatio = var_49_4
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1061ui_story then
				local var_49_5 = 0.5

				arg_46_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1061ui_story.fillRatio = var_49_5
			end

			local var_49_6 = 0
			local var_49_7 = 0.525

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_8 = arg_46_1:GetWordFromCfg(1106101011)
				local var_49_9 = arg_46_1:FormatText(var_49_8.content)

				arg_46_1.text_.text = var_49_9

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_10 = 21
				local var_49_11 = utf8.len(var_49_9)
				local var_49_12 = var_49_10 <= 0 and var_49_7 or var_49_7 * (var_49_11 / var_49_10)

				if var_49_12 > 0 and var_49_7 < var_49_12 then
					arg_46_1.talkMaxDuration = var_49_12

					if var_49_12 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_6
					end
				end

				arg_46_1.text_.text = var_49_9
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_13 = math.max(var_49_7, arg_46_1.talkMaxDuration)

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_13 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_6) / var_49_13

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_6 + var_49_13 and arg_46_1.time_ < var_49_6 + var_49_13 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play1106101012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 1106101012
		arg_50_1.duration_ = 7.4

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play1106101013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1061ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1061ui_story == nil then
				arg_50_1.var_.characterEffect1061ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1061ui_story and not isNil(var_53_0) then
					arg_50_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1061ui_story then
				arg_50_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_53_4 = 0

			if var_53_4 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_53_5 = 0

			if var_53_5 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_53_6 = 0
			local var_53_7 = 0.8

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[612].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_9 = arg_50_1:GetWordFromCfg(1106101012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 32
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101012", "story_v_side_new_1106101.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101012", "story_v_side_new_1106101.awb") / 1000

					if var_53_14 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_6
					end

					if var_53_9.prefab_name ~= "" and arg_50_1.actors_[var_53_9.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_9.prefab_name].transform, "story_v_side_new_1106101", "1106101012", "story_v_side_new_1106101.awb")

						arg_50_1:RecordAudio("1106101012", var_53_15)
						arg_50_1:RecordAudio("1106101012", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101012", "story_v_side_new_1106101.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101012", "story_v_side_new_1106101.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_16 and arg_50_1.time_ < var_53_6 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play1106101013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 1106101013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play1106101014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1061ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1061ui_story == nil then
				arg_54_1.var_.characterEffect1061ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1061ui_story and not isNil(var_57_0) then
					local var_57_4 = Mathf.Lerp(0, 0.5, var_57_3)

					arg_54_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1061ui_story.fillRatio = var_57_4
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1061ui_story then
				local var_57_5 = 0.5

				arg_54_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1061ui_story.fillRatio = var_57_5
			end

			local var_57_6 = 0
			local var_57_7 = 0.275

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_8 = arg_54_1:FormatText(StoryNameCfg[7].name)

				arg_54_1.leftNameTxt_.text = var_57_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_9 = arg_54_1:GetWordFromCfg(1106101013)
				local var_57_10 = arg_54_1:FormatText(var_57_9.content)

				arg_54_1.text_.text = var_57_10

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 11
				local var_57_12 = utf8.len(var_57_10)
				local var_57_13 = var_57_11 <= 0 and var_57_7 or var_57_7 * (var_57_12 / var_57_11)

				if var_57_13 > 0 and var_57_7 < var_57_13 then
					arg_54_1.talkMaxDuration = var_57_13

					if var_57_13 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_10
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_14 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_14 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_14

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_14 and arg_54_1.time_ < var_57_6 + var_57_14 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play1106101014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 1106101014
		arg_58_1.duration_ = 2.5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play1106101015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1061ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1061ui_story == nil then
				arg_58_1.var_.characterEffect1061ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1061ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1061ui_story then
				arg_58_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_61_4 = 0

			if var_61_4 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_61_6 = 0
			local var_61_7 = 0.25

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[612].name)

				arg_58_1.leftNameTxt_.text = var_61_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_9 = arg_58_1:GetWordFromCfg(1106101014)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 10
				local var_61_12 = utf8.len(var_61_10)
				local var_61_13 = var_61_11 <= 0 and var_61_7 or var_61_7 * (var_61_12 / var_61_11)

				if var_61_13 > 0 and var_61_7 < var_61_13 then
					arg_58_1.talkMaxDuration = var_61_13

					if var_61_13 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_6
					end
				end

				arg_58_1.text_.text = var_61_10
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101014", "story_v_side_new_1106101.awb") ~= 0 then
					local var_61_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101014", "story_v_side_new_1106101.awb") / 1000

					if var_61_14 + var_61_6 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_6
					end

					if var_61_9.prefab_name ~= "" and arg_58_1.actors_[var_61_9.prefab_name] ~= nil then
						local var_61_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_9.prefab_name].transform, "story_v_side_new_1106101", "1106101014", "story_v_side_new_1106101.awb")

						arg_58_1:RecordAudio("1106101014", var_61_15)
						arg_58_1:RecordAudio("1106101014", var_61_15)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101014", "story_v_side_new_1106101.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101014", "story_v_side_new_1106101.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_16 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_16 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_16

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_16 and arg_58_1.time_ < var_61_6 + var_61_16 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play1106101015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 1106101015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play1106101016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1061ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1061ui_story == nil then
				arg_62_1.var_.characterEffect1061ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1061ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1061ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1061ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1061ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 1

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_8 = arg_62_1:GetWordFromCfg(1106101015)
				local var_65_9 = arg_62_1:FormatText(var_65_8.content)

				arg_62_1.text_.text = var_65_9

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_10 = 40
				local var_65_11 = utf8.len(var_65_9)
				local var_65_12 = var_65_10 <= 0 and var_65_7 or var_65_7 * (var_65_11 / var_65_10)

				if var_65_12 > 0 and var_65_7 < var_65_12 then
					arg_62_1.talkMaxDuration = var_65_12

					if var_65_12 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_12 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_9
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_13 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_13 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_13

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_13 and arg_62_1.time_ < var_65_6 + var_65_13 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play1106101016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 1106101016
		arg_66_1.duration_ = 2

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play1106101017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1061ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1061ui_story == nil then
				arg_66_1.var_.characterEffect1061ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1061ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1061ui_story then
				arg_66_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_69_4 = 0

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_69_6 = 0
			local var_69_7 = 0.125

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_8 = arg_66_1:FormatText(StoryNameCfg[612].name)

				arg_66_1.leftNameTxt_.text = var_69_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_9 = arg_66_1:GetWordFromCfg(1106101016)
				local var_69_10 = arg_66_1:FormatText(var_69_9.content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 5
				local var_69_12 = utf8.len(var_69_10)
				local var_69_13 = var_69_11 <= 0 and var_69_7 or var_69_7 * (var_69_12 / var_69_11)

				if var_69_13 > 0 and var_69_7 < var_69_13 then
					arg_66_1.talkMaxDuration = var_69_13

					if var_69_13 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_10
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101016", "story_v_side_new_1106101.awb") ~= 0 then
					local var_69_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101016", "story_v_side_new_1106101.awb") / 1000

					if var_69_14 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_14 + var_69_6
					end

					if var_69_9.prefab_name ~= "" and arg_66_1.actors_[var_69_9.prefab_name] ~= nil then
						local var_69_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_9.prefab_name].transform, "story_v_side_new_1106101", "1106101016", "story_v_side_new_1106101.awb")

						arg_66_1:RecordAudio("1106101016", var_69_15)
						arg_66_1:RecordAudio("1106101016", var_69_15)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101016", "story_v_side_new_1106101.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101016", "story_v_side_new_1106101.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_16 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_16 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_16

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_16 and arg_66_1.time_ < var_69_6 + var_69_16 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play1106101017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 1106101017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play1106101018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1061ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1061ui_story == nil then
				arg_70_1.var_.characterEffect1061ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1061ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1061ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1061ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1061ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 1.375

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_8 = arg_70_1:FormatText(StoryNameCfg[7].name)

				arg_70_1.leftNameTxt_.text = var_73_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_9 = arg_70_1:GetWordFromCfg(1106101017)
				local var_73_10 = arg_70_1:FormatText(var_73_9.content)

				arg_70_1.text_.text = var_73_10

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 55
				local var_73_12 = utf8.len(var_73_10)
				local var_73_13 = var_73_11 <= 0 and var_73_7 or var_73_7 * (var_73_12 / var_73_11)

				if var_73_13 > 0 and var_73_7 < var_73_13 then
					arg_70_1.talkMaxDuration = var_73_13

					if var_73_13 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_13 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_10
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play1106101018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 1106101018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play1106101019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.625

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[7].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_3 = arg_74_1:GetWordFromCfg(1106101018)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 25
				local var_77_6 = utf8.len(var_77_4)
				local var_77_7 = var_77_5 <= 0 and var_77_1 or var_77_1 * (var_77_6 / var_77_5)

				if var_77_7 > 0 and var_77_1 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_4
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_8 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_8 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_8

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_8 and arg_74_1.time_ < var_77_0 + var_77_8 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play1106101019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 1106101019
		arg_78_1.duration_ = 4.5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play1106101020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1061ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1061ui_story == nil then
				arg_78_1.var_.characterEffect1061ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1061ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1061ui_story then
				arg_78_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_81_4 = 0

			if var_81_4 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_81_6 = 0
			local var_81_7 = 0.6

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_8 = arg_78_1:FormatText(StoryNameCfg[612].name)

				arg_78_1.leftNameTxt_.text = var_81_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_9 = arg_78_1:GetWordFromCfg(1106101019)
				local var_81_10 = arg_78_1:FormatText(var_81_9.content)

				arg_78_1.text_.text = var_81_10

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 24
				local var_81_12 = utf8.len(var_81_10)
				local var_81_13 = var_81_11 <= 0 and var_81_7 or var_81_7 * (var_81_12 / var_81_11)

				if var_81_13 > 0 and var_81_7 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_10
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101019", "story_v_side_new_1106101.awb") ~= 0 then
					local var_81_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101019", "story_v_side_new_1106101.awb") / 1000

					if var_81_14 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_6
					end

					if var_81_9.prefab_name ~= "" and arg_78_1.actors_[var_81_9.prefab_name] ~= nil then
						local var_81_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_9.prefab_name].transform, "story_v_side_new_1106101", "1106101019", "story_v_side_new_1106101.awb")

						arg_78_1:RecordAudio("1106101019", var_81_15)
						arg_78_1:RecordAudio("1106101019", var_81_15)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101019", "story_v_side_new_1106101.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101019", "story_v_side_new_1106101.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_16 and arg_78_1.time_ < var_81_6 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play1106101020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 1106101020
		arg_82_1.duration_ = 7.67

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play1106101021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 1

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[612].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(1106101020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 40
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101020", "story_v_side_new_1106101.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101020", "story_v_side_new_1106101.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_side_new_1106101", "1106101020", "story_v_side_new_1106101.awb")

						arg_82_1:RecordAudio("1106101020", var_85_9)
						arg_82_1:RecordAudio("1106101020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101020", "story_v_side_new_1106101.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101020", "story_v_side_new_1106101.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play1106101021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 1106101021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play1106101022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1061ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1061ui_story == nil then
				arg_86_1.var_.characterEffect1061ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1061ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1061ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1061ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1061ui_story.fillRatio = var_89_5
			end

			local var_89_6 = 0
			local var_89_7 = 0.3

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_8 = arg_86_1:FormatText(StoryNameCfg[7].name)

				arg_86_1.leftNameTxt_.text = var_89_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_9 = arg_86_1:GetWordFromCfg(1106101021)
				local var_89_10 = arg_86_1:FormatText(var_89_9.content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 12
				local var_89_12 = utf8.len(var_89_10)
				local var_89_13 = var_89_11 <= 0 and var_89_7 or var_89_7 * (var_89_12 / var_89_11)

				if var_89_13 > 0 and var_89_7 < var_89_13 then
					arg_86_1.talkMaxDuration = var_89_13

					if var_89_13 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_13 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_10
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_14 and arg_86_1.time_ < var_89_6 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play1106101022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1106101022
		arg_90_1.duration_ = 3.17

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play1106101023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1061ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1061ui_story == nil then
				arg_90_1.var_.characterEffect1061ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1061ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1061ui_story then
				arg_90_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_93_4 = 0

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_2")
			end

			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_93_6 = 0
			local var_93_7 = 0.375

			if var_93_6 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_8 = arg_90_1:FormatText(StoryNameCfg[612].name)

				arg_90_1.leftNameTxt_.text = var_93_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_9 = arg_90_1:GetWordFromCfg(1106101022)
				local var_93_10 = arg_90_1:FormatText(var_93_9.content)

				arg_90_1.text_.text = var_93_10

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 15
				local var_93_12 = utf8.len(var_93_10)
				local var_93_13 = var_93_11 <= 0 and var_93_7 or var_93_7 * (var_93_12 / var_93_11)

				if var_93_13 > 0 and var_93_7 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_10
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101022", "story_v_side_new_1106101.awb") ~= 0 then
					local var_93_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101022", "story_v_side_new_1106101.awb") / 1000

					if var_93_14 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_6
					end

					if var_93_9.prefab_name ~= "" and arg_90_1.actors_[var_93_9.prefab_name] ~= nil then
						local var_93_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_9.prefab_name].transform, "story_v_side_new_1106101", "1106101022", "story_v_side_new_1106101.awb")

						arg_90_1:RecordAudio("1106101022", var_93_15)
						arg_90_1:RecordAudio("1106101022", var_93_15)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101022", "story_v_side_new_1106101.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101022", "story_v_side_new_1106101.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_16 and arg_90_1.time_ < var_93_6 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play1106101023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 1106101023
		arg_94_1.duration_ = 1

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"

			SetActive(arg_94_1.choicesGo_, true)

			for iter_95_0, iter_95_1 in ipairs(arg_94_1.choices_) do
				local var_95_0 = iter_95_0 <= 2

				SetActive(iter_95_1.go, var_95_0)
			end

			arg_94_1.choices_[1].txt.text = arg_94_1:FormatText(StoryChoiceCfg[1380].name)
			arg_94_1.choices_[2].txt.text = arg_94_1:FormatText(StoryChoiceCfg[1381].name)
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play1106101024(arg_94_1)
			end

			if arg_96_0 == 2 then
				arg_94_0:Play1106101024(arg_94_1)
			end

			arg_94_1:RecordChoiceLog(1106101023, 1380, 1381)
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.allBtn_.enabled = false
			end

			local var_97_1 = 0.6

			if arg_94_1.time_ >= var_97_0 + var_97_1 and arg_94_1.time_ < var_97_0 + var_97_1 + arg_97_0 then
				arg_94_1.allBtn_.enabled = true
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play1106101024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1106101024
		arg_98_1.duration_ = 5.57

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play1106101025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1061ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1061ui_story == nil then
				arg_98_1.var_.characterEffect1061ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1061ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1061ui_story then
				arg_98_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_101_4 = 0
			local var_101_5 = 0.575

			if var_101_4 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_6 = arg_98_1:FormatText(StoryNameCfg[612].name)

				arg_98_1.leftNameTxt_.text = var_101_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_7 = arg_98_1:GetWordFromCfg(1106101024)
				local var_101_8 = arg_98_1:FormatText(var_101_7.content)

				arg_98_1.text_.text = var_101_8

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 23
				local var_101_10 = utf8.len(var_101_8)
				local var_101_11 = var_101_9 <= 0 and var_101_5 or var_101_5 * (var_101_10 / var_101_9)

				if var_101_11 > 0 and var_101_5 < var_101_11 then
					arg_98_1.talkMaxDuration = var_101_11

					if var_101_11 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_11 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_8
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101024", "story_v_side_new_1106101.awb") ~= 0 then
					local var_101_12 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101024", "story_v_side_new_1106101.awb") / 1000

					if var_101_12 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_12 + var_101_4
					end

					if var_101_7.prefab_name ~= "" and arg_98_1.actors_[var_101_7.prefab_name] ~= nil then
						local var_101_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_7.prefab_name].transform, "story_v_side_new_1106101", "1106101024", "story_v_side_new_1106101.awb")

						arg_98_1:RecordAudio("1106101024", var_101_13)
						arg_98_1:RecordAudio("1106101024", var_101_13)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101024", "story_v_side_new_1106101.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101024", "story_v_side_new_1106101.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_14 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_14 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_14

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_14 and arg_98_1.time_ < var_101_4 + var_101_14 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play1106101025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 1106101025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play1106101026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1061ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1061ui_story == nil then
				arg_102_1.var_.characterEffect1061ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1061ui_story and not isNil(var_105_0) then
					local var_105_4 = Mathf.Lerp(0, 0.5, var_105_3)

					arg_102_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1061ui_story.fillRatio = var_105_4
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1061ui_story then
				local var_105_5 = 0.5

				arg_102_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1061ui_story.fillRatio = var_105_5
			end

			local var_105_6 = 0
			local var_105_7 = 0.775

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_8 = arg_102_1:FormatText(StoryNameCfg[7].name)

				arg_102_1.leftNameTxt_.text = var_105_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_9 = arg_102_1:GetWordFromCfg(1106101025)
				local var_105_10 = arg_102_1:FormatText(var_105_9.content)

				arg_102_1.text_.text = var_105_10

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 31
				local var_105_12 = utf8.len(var_105_10)
				local var_105_13 = var_105_11 <= 0 and var_105_7 or var_105_7 * (var_105_12 / var_105_11)

				if var_105_13 > 0 and var_105_7 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_10
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_14 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_14 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_14

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_14 and arg_102_1.time_ < var_105_6 + var_105_14 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play1106101026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1106101026
		arg_106_1.duration_ = 2

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play1106101027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1061ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1061ui_story == nil then
				arg_106_1.var_.characterEffect1061ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1061ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1061ui_story then
				arg_106_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_109_4 = 0

			if var_109_4 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_109_5 = 0
			local var_109_6 = 0.15

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_7 = arg_106_1:FormatText(StoryNameCfg[612].name)

				arg_106_1.leftNameTxt_.text = var_109_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_8 = arg_106_1:GetWordFromCfg(1106101026)
				local var_109_9 = arg_106_1:FormatText(var_109_8.content)

				arg_106_1.text_.text = var_109_9

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_10 = 6
				local var_109_11 = utf8.len(var_109_9)
				local var_109_12 = var_109_10 <= 0 and var_109_6 or var_109_6 * (var_109_11 / var_109_10)

				if var_109_12 > 0 and var_109_6 < var_109_12 then
					arg_106_1.talkMaxDuration = var_109_12

					if var_109_12 + var_109_5 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_5
					end
				end

				arg_106_1.text_.text = var_109_9
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101026", "story_v_side_new_1106101.awb") ~= 0 then
					local var_109_13 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101026", "story_v_side_new_1106101.awb") / 1000

					if var_109_13 + var_109_5 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_5
					end

					if var_109_8.prefab_name ~= "" and arg_106_1.actors_[var_109_8.prefab_name] ~= nil then
						local var_109_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_8.prefab_name].transform, "story_v_side_new_1106101", "1106101026", "story_v_side_new_1106101.awb")

						arg_106_1:RecordAudio("1106101026", var_109_14)
						arg_106_1:RecordAudio("1106101026", var_109_14)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101026", "story_v_side_new_1106101.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101026", "story_v_side_new_1106101.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_15 = math.max(var_109_6, arg_106_1.talkMaxDuration)

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_15 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_5) / var_109_15

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_5 + var_109_15 and arg_106_1.time_ < var_109_5 + var_109_15 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play1106101027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1106101027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1106101028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1061ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1061ui_story == nil then
				arg_110_1.var_.characterEffect1061ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1061ui_story and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1061ui_story.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1061ui_story then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1061ui_story.fillRatio = var_113_5
			end

			local var_113_6 = 0
			local var_113_7 = 0.2

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_8 = arg_110_1:FormatText(StoryNameCfg[7].name)

				arg_110_1.leftNameTxt_.text = var_113_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_9 = arg_110_1:GetWordFromCfg(1106101027)
				local var_113_10 = arg_110_1:FormatText(var_113_9.content)

				arg_110_1.text_.text = var_113_10

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 8
				local var_113_12 = utf8.len(var_113_10)
				local var_113_13 = var_113_11 <= 0 and var_113_7 or var_113_7 * (var_113_12 / var_113_11)

				if var_113_13 > 0 and var_113_7 < var_113_13 then
					arg_110_1.talkMaxDuration = var_113_13

					if var_113_13 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_13 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_10
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_14 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_14 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_14

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_14 and arg_110_1.time_ < var_113_6 + var_113_14 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play1106101028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1106101028
		arg_114_1.duration_ = 2

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play1106101029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1061ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1061ui_story == nil then
				arg_114_1.var_.characterEffect1061ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1061ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1061ui_story then
				arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_117_4 = 0

			if var_117_4 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_117_5 = 0
			local var_117_6 = 0.075

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_7 = arg_114_1:FormatText(StoryNameCfg[612].name)

				arg_114_1.leftNameTxt_.text = var_117_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_8 = arg_114_1:GetWordFromCfg(1106101028)
				local var_117_9 = arg_114_1:FormatText(var_117_8.content)

				arg_114_1.text_.text = var_117_9

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_10 = 3
				local var_117_11 = utf8.len(var_117_9)
				local var_117_12 = var_117_10 <= 0 and var_117_6 or var_117_6 * (var_117_11 / var_117_10)

				if var_117_12 > 0 and var_117_6 < var_117_12 then
					arg_114_1.talkMaxDuration = var_117_12

					if var_117_12 + var_117_5 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_12 + var_117_5
					end
				end

				arg_114_1.text_.text = var_117_9
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101028", "story_v_side_new_1106101.awb") ~= 0 then
					local var_117_13 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101028", "story_v_side_new_1106101.awb") / 1000

					if var_117_13 + var_117_5 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_13 + var_117_5
					end

					if var_117_8.prefab_name ~= "" and arg_114_1.actors_[var_117_8.prefab_name] ~= nil then
						local var_117_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_8.prefab_name].transform, "story_v_side_new_1106101", "1106101028", "story_v_side_new_1106101.awb")

						arg_114_1:RecordAudio("1106101028", var_117_14)
						arg_114_1:RecordAudio("1106101028", var_117_14)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101028", "story_v_side_new_1106101.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101028", "story_v_side_new_1106101.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_15 = math.max(var_117_6, arg_114_1.talkMaxDuration)

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_15 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_5) / var_117_15

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_5 + var_117_15 and arg_114_1.time_ < var_117_5 + var_117_15 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play1106101029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1106101029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1106101030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1061ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1061ui_story == nil then
				arg_118_1.var_.characterEffect1061ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1061ui_story and not isNil(var_121_0) then
					local var_121_4 = Mathf.Lerp(0, 0.5, var_121_3)

					arg_118_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1061ui_story.fillRatio = var_121_4
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1061ui_story then
				local var_121_5 = 0.5

				arg_118_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1061ui_story.fillRatio = var_121_5
			end

			local var_121_6 = 0
			local var_121_7 = 0.3

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_8 = arg_118_1:GetWordFromCfg(1106101029)
				local var_121_9 = arg_118_1:FormatText(var_121_8.content)

				arg_118_1.text_.text = var_121_9

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_10 = 12
				local var_121_11 = utf8.len(var_121_9)
				local var_121_12 = var_121_10 <= 0 and var_121_7 or var_121_7 * (var_121_11 / var_121_10)

				if var_121_12 > 0 and var_121_7 < var_121_12 then
					arg_118_1.talkMaxDuration = var_121_12

					if var_121_12 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_12 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_9
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_13 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_13 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_6) / var_121_13

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_6 + var_121_13 and arg_118_1.time_ < var_121_6 + var_121_13 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play1106101030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1106101030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1106101031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0
			local var_125_1 = 0.725

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_2 = arg_122_1:FormatText(StoryNameCfg[7].name)

				arg_122_1.leftNameTxt_.text = var_125_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:GetWordFromCfg(1106101030)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 29
				local var_125_6 = utf8.len(var_125_4)
				local var_125_7 = var_125_5 <= 0 and var_125_1 or var_125_1 * (var_125_6 / var_125_5)

				if var_125_7 > 0 and var_125_1 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_0
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_8 = math.max(var_125_1, arg_122_1.talkMaxDuration)

			if var_125_0 <= arg_122_1.time_ and arg_122_1.time_ < var_125_0 + var_125_8 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_0) / var_125_8

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_0 + var_125_8 and arg_122_1.time_ < var_125_0 + var_125_8 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play1106101031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1106101031
		arg_126_1.duration_ = 2

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1106101032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1061ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1061ui_story == nil then
				arg_126_1.var_.characterEffect1061ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1061ui_story and not isNil(var_129_0) then
					arg_126_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1061ui_story then
				arg_126_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_129_4 = 0

			if var_129_4 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_129_6 = 0
			local var_129_7 = 0.075

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[612].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_9 = arg_126_1:GetWordFromCfg(1106101031)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 3
				local var_129_12 = utf8.len(var_129_10)
				local var_129_13 = var_129_11 <= 0 and var_129_7 or var_129_7 * (var_129_12 / var_129_11)

				if var_129_13 > 0 and var_129_7 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_6
					end
				end

				arg_126_1.text_.text = var_129_10
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101031", "story_v_side_new_1106101.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101031", "story_v_side_new_1106101.awb") / 1000

					if var_129_14 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_6
					end

					if var_129_9.prefab_name ~= "" and arg_126_1.actors_[var_129_9.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_9.prefab_name].transform, "story_v_side_new_1106101", "1106101031", "story_v_side_new_1106101.awb")

						arg_126_1:RecordAudio("1106101031", var_129_15)
						arg_126_1:RecordAudio("1106101031", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101031", "story_v_side_new_1106101.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101031", "story_v_side_new_1106101.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_7, arg_126_1.talkMaxDuration)

			if var_129_6 <= arg_126_1.time_ and arg_126_1.time_ < var_129_6 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_6) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_6 + var_129_16 and arg_126_1.time_ < var_129_6 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play1106101032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1106101032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1106101033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1061ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1061ui_story == nil then
				arg_130_1.var_.characterEffect1061ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect1061ui_story and not isNil(var_133_0) then
					local var_133_4 = Mathf.Lerp(0, 0.5, var_133_3)

					arg_130_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1061ui_story.fillRatio = var_133_4
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1061ui_story then
				local var_133_5 = 0.5

				arg_130_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1061ui_story.fillRatio = var_133_5
			end

			local var_133_6 = 0
			local var_133_7 = 0.775

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_8 = arg_130_1:FormatText(StoryNameCfg[7].name)

				arg_130_1.leftNameTxt_.text = var_133_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_9 = arg_130_1:GetWordFromCfg(1106101032)
				local var_133_10 = arg_130_1:FormatText(var_133_9.content)

				arg_130_1.text_.text = var_133_10

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_11 = 31
				local var_133_12 = utf8.len(var_133_10)
				local var_133_13 = var_133_11 <= 0 and var_133_7 or var_133_7 * (var_133_12 / var_133_11)

				if var_133_13 > 0 and var_133_7 < var_133_13 then
					arg_130_1.talkMaxDuration = var_133_13

					if var_133_13 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_13 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_10
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_14 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_14 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_14

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_14 and arg_130_1.time_ < var_133_6 + var_133_14 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play1106101033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1106101033
		arg_134_1.duration_ = 5.77

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1106101034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1061ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1061ui_story == nil then
				arg_134_1.var_.characterEffect1061ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1061ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1061ui_story then
				arg_134_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_137_4 = 0

			if var_137_4 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action437")
			end

			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 then
				arg_134_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva", "EmotionTimelineAnimator")
			end

			local var_137_6 = 0
			local var_137_7 = 0.675

			if var_137_6 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_8 = arg_134_1:FormatText(StoryNameCfg[612].name)

				arg_134_1.leftNameTxt_.text = var_137_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_9 = arg_134_1:GetWordFromCfg(1106101033)
				local var_137_10 = arg_134_1:FormatText(var_137_9.content)

				arg_134_1.text_.text = var_137_10

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 27
				local var_137_12 = utf8.len(var_137_10)
				local var_137_13 = var_137_11 <= 0 and var_137_7 or var_137_7 * (var_137_12 / var_137_11)

				if var_137_13 > 0 and var_137_7 < var_137_13 then
					arg_134_1.talkMaxDuration = var_137_13

					if var_137_13 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_13 + var_137_6
					end
				end

				arg_134_1.text_.text = var_137_10
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101033", "story_v_side_new_1106101.awb") ~= 0 then
					local var_137_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101033", "story_v_side_new_1106101.awb") / 1000

					if var_137_14 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_14 + var_137_6
					end

					if var_137_9.prefab_name ~= "" and arg_134_1.actors_[var_137_9.prefab_name] ~= nil then
						local var_137_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_9.prefab_name].transform, "story_v_side_new_1106101", "1106101033", "story_v_side_new_1106101.awb")

						arg_134_1:RecordAudio("1106101033", var_137_15)
						arg_134_1:RecordAudio("1106101033", var_137_15)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101033", "story_v_side_new_1106101.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101033", "story_v_side_new_1106101.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_16 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_16 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_16

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_16 and arg_134_1.time_ < var_137_6 + var_137_16 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1106101034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1106101034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1106101035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1061ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1061ui_story == nil then
				arg_138_1.var_.characterEffect1061ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1061ui_story and not isNil(var_141_0) then
					local var_141_4 = Mathf.Lerp(0, 0.5, var_141_3)

					arg_138_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1061ui_story.fillRatio = var_141_4
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1061ui_story then
				local var_141_5 = 0.5

				arg_138_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1061ui_story.fillRatio = var_141_5
			end

			local var_141_6 = 0
			local var_141_7 = 0.55

			if var_141_6 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_8 = arg_138_1:FormatText(StoryNameCfg[7].name)

				arg_138_1.leftNameTxt_.text = var_141_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_9 = arg_138_1:GetWordFromCfg(1106101034)
				local var_141_10 = arg_138_1:FormatText(var_141_9.content)

				arg_138_1.text_.text = var_141_10

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 22
				local var_141_12 = utf8.len(var_141_10)
				local var_141_13 = var_141_11 <= 0 and var_141_7 or var_141_7 * (var_141_12 / var_141_11)

				if var_141_13 > 0 and var_141_7 < var_141_13 then
					arg_138_1.talkMaxDuration = var_141_13

					if var_141_13 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_10
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_14 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_14 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_14

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_14 and arg_138_1.time_ < var_141_6 + var_141_14 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play1106101035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1106101035
		arg_142_1.duration_ = 2

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1106101036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1061ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1061ui_story == nil then
				arg_142_1.var_.characterEffect1061ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.200000002980232

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1061ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1061ui_story then
				arg_142_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_145_4 = 0

			if var_145_4 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action7_2")
			end

			local var_145_5 = 0

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_145_6 = 0
			local var_145_7 = 0.225

			if var_145_6 < arg_142_1.time_ and arg_142_1.time_ <= var_145_6 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_8 = arg_142_1:FormatText(StoryNameCfg[612].name)

				arg_142_1.leftNameTxt_.text = var_145_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_9 = arg_142_1:GetWordFromCfg(1106101035)
				local var_145_10 = arg_142_1:FormatText(var_145_9.content)

				arg_142_1.text_.text = var_145_10

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_11 = 9
				local var_145_12 = utf8.len(var_145_10)
				local var_145_13 = var_145_11 <= 0 and var_145_7 or var_145_7 * (var_145_12 / var_145_11)

				if var_145_13 > 0 and var_145_7 < var_145_13 then
					arg_142_1.talkMaxDuration = var_145_13

					if var_145_13 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_13 + var_145_6
					end
				end

				arg_142_1.text_.text = var_145_10
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101035", "story_v_side_new_1106101.awb") ~= 0 then
					local var_145_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101035", "story_v_side_new_1106101.awb") / 1000

					if var_145_14 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_14 + var_145_6
					end

					if var_145_9.prefab_name ~= "" and arg_142_1.actors_[var_145_9.prefab_name] ~= nil then
						local var_145_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_9.prefab_name].transform, "story_v_side_new_1106101", "1106101035", "story_v_side_new_1106101.awb")

						arg_142_1:RecordAudio("1106101035", var_145_15)
						arg_142_1:RecordAudio("1106101035", var_145_15)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101035", "story_v_side_new_1106101.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101035", "story_v_side_new_1106101.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_16 = math.max(var_145_7, arg_142_1.talkMaxDuration)

			if var_145_6 <= arg_142_1.time_ and arg_142_1.time_ < var_145_6 + var_145_16 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_6) / var_145_16

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_6 + var_145_16 and arg_142_1.time_ < var_145_6 + var_145_16 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play1106101036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1106101036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1106101037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1061ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1061ui_story == nil then
				arg_146_1.var_.characterEffect1061ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1061ui_story and not isNil(var_149_0) then
					local var_149_4 = Mathf.Lerp(0, 0.5, var_149_3)

					arg_146_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1061ui_story.fillRatio = var_149_4
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1061ui_story then
				local var_149_5 = 0.5

				arg_146_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1061ui_story.fillRatio = var_149_5
			end

			local var_149_6 = 0
			local var_149_7 = 0.8

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_8 = arg_146_1:FormatText(StoryNameCfg[7].name)

				arg_146_1.leftNameTxt_.text = var_149_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_9 = arg_146_1:GetWordFromCfg(1106101036)
				local var_149_10 = arg_146_1:FormatText(var_149_9.content)

				arg_146_1.text_.text = var_149_10

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 32
				local var_149_12 = utf8.len(var_149_10)
				local var_149_13 = var_149_11 <= 0 and var_149_7 or var_149_7 * (var_149_12 / var_149_11)

				if var_149_13 > 0 and var_149_7 < var_149_13 then
					arg_146_1.talkMaxDuration = var_149_13

					if var_149_13 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_13 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_10
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_14 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_14 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_14

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_14 and arg_146_1.time_ < var_149_6 + var_149_14 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1106101037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1106101037
		arg_150_1.duration_ = 5.33

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1106101038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1061ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1061ui_story == nil then
				arg_150_1.var_.characterEffect1061ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect1061ui_story and not isNil(var_153_0) then
					arg_150_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1061ui_story then
				arg_150_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_153_4 = 0

			if var_153_4 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				arg_150_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_153_5 = 0

			if var_153_5 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 then
				arg_150_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_153_6 = 0
			local var_153_7 = 0.625

			if var_153_6 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_8 = arg_150_1:FormatText(StoryNameCfg[612].name)

				arg_150_1.leftNameTxt_.text = var_153_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_9 = arg_150_1:GetWordFromCfg(1106101037)
				local var_153_10 = arg_150_1:FormatText(var_153_9.content)

				arg_150_1.text_.text = var_153_10

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_11 = 25
				local var_153_12 = utf8.len(var_153_10)
				local var_153_13 = var_153_11 <= 0 and var_153_7 or var_153_7 * (var_153_12 / var_153_11)

				if var_153_13 > 0 and var_153_7 < var_153_13 then
					arg_150_1.talkMaxDuration = var_153_13

					if var_153_13 + var_153_6 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_13 + var_153_6
					end
				end

				arg_150_1.text_.text = var_153_10
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101037", "story_v_side_new_1106101.awb") ~= 0 then
					local var_153_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101037", "story_v_side_new_1106101.awb") / 1000

					if var_153_14 + var_153_6 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_14 + var_153_6
					end

					if var_153_9.prefab_name ~= "" and arg_150_1.actors_[var_153_9.prefab_name] ~= nil then
						local var_153_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_9.prefab_name].transform, "story_v_side_new_1106101", "1106101037", "story_v_side_new_1106101.awb")

						arg_150_1:RecordAudio("1106101037", var_153_15)
						arg_150_1:RecordAudio("1106101037", var_153_15)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101037", "story_v_side_new_1106101.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101037", "story_v_side_new_1106101.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_16 = math.max(var_153_7, arg_150_1.talkMaxDuration)

			if var_153_6 <= arg_150_1.time_ and arg_150_1.time_ < var_153_6 + var_153_16 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_6) / var_153_16

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_6 + var_153_16 and arg_150_1.time_ < var_153_6 + var_153_16 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play1106101038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1106101038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1106101039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1061ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1061ui_story == nil then
				arg_154_1.var_.characterEffect1061ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1061ui_story and not isNil(var_157_0) then
					local var_157_4 = Mathf.Lerp(0, 0.5, var_157_3)

					arg_154_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1061ui_story.fillRatio = var_157_4
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1061ui_story then
				local var_157_5 = 0.5

				arg_154_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1061ui_story.fillRatio = var_157_5
			end

			local var_157_6 = 0
			local var_157_7 = 0.6

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_8 = arg_154_1:GetWordFromCfg(1106101038)
				local var_157_9 = arg_154_1:FormatText(var_157_8.content)

				arg_154_1.text_.text = var_157_9

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_10 = 24
				local var_157_11 = utf8.len(var_157_9)
				local var_157_12 = var_157_10 <= 0 and var_157_7 or var_157_7 * (var_157_11 / var_157_10)

				if var_157_12 > 0 and var_157_7 < var_157_12 then
					arg_154_1.talkMaxDuration = var_157_12

					if var_157_12 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_12 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_9
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_13 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_13 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_13

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_13 and arg_154_1.time_ < var_157_6 + var_157_13 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play1106101039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1106101039
		arg_158_1.duration_ = 1

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"

			SetActive(arg_158_1.choicesGo_, true)

			for iter_159_0, iter_159_1 in ipairs(arg_158_1.choices_) do
				local var_159_0 = iter_159_0 <= 1

				SetActive(iter_159_1.go, var_159_0)
			end

			arg_158_1.choices_[1].txt.text = arg_158_1:FormatText(StoryChoiceCfg[1382].name)
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1106101040(arg_158_1)
			end

			arg_158_1:RecordChoiceLog(1106101039, 1382)
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.allBtn_.enabled = false
			end

			local var_161_1 = 0.6

			if arg_158_1.time_ >= var_161_0 + var_161_1 and arg_158_1.time_ < var_161_0 + var_161_1 + arg_161_0 then
				arg_158_1.allBtn_.enabled = true
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1106101040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1106101040
		arg_162_1.duration_ = 3.97

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1106101041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1061ui_story"].transform
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.var_.moveOldPos1061ui_story = var_165_0.localPosition
			end

			local var_165_2 = 0.001

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2
				local var_165_4 = Vector3.New(0, -1.18, -6.15)

				var_165_0.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1061ui_story, var_165_4, var_165_3)

				local var_165_5 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_5.x, var_165_5.y, var_165_5.z)

				local var_165_6 = var_165_0.localEulerAngles

				var_165_6.z = 0
				var_165_6.x = 0
				var_165_0.localEulerAngles = var_165_6
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 then
				var_165_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_165_7 = manager.ui.mainCamera.transform.position - var_165_0.position

				var_165_0.forward = Vector3.New(var_165_7.x, var_165_7.y, var_165_7.z)

				local var_165_8 = var_165_0.localEulerAngles

				var_165_8.z = 0
				var_165_8.x = 0
				var_165_0.localEulerAngles = var_165_8
			end

			local var_165_9 = arg_162_1.actors_["1061ui_story"]
			local var_165_10 = 0

			if var_165_10 < arg_162_1.time_ and arg_162_1.time_ <= var_165_10 + arg_165_0 and not isNil(var_165_9) and arg_162_1.var_.characterEffect1061ui_story == nil then
				arg_162_1.var_.characterEffect1061ui_story = var_165_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_11 = 0.200000002980232

			if var_165_10 <= arg_162_1.time_ and arg_162_1.time_ < var_165_10 + var_165_11 and not isNil(var_165_9) then
				local var_165_12 = (arg_162_1.time_ - var_165_10) / var_165_11

				if arg_162_1.var_.characterEffect1061ui_story and not isNil(var_165_9) then
					arg_162_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_10 + var_165_11 and arg_162_1.time_ < var_165_10 + var_165_11 + arg_165_0 and not isNil(var_165_9) and arg_162_1.var_.characterEffect1061ui_story then
				arg_162_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_165_13 = 0

			if var_165_13 < arg_162_1.time_ and arg_162_1.time_ <= var_165_13 + arg_165_0 then
				arg_162_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action429")
			end

			local var_165_14 = 0

			if var_165_14 < arg_162_1.time_ and arg_162_1.time_ <= var_165_14 + arg_165_0 then
				arg_162_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_165_15 = 0
			local var_165_16 = 0.375

			if var_165_15 < arg_162_1.time_ and arg_162_1.time_ <= var_165_15 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_17 = arg_162_1:FormatText(StoryNameCfg[612].name)

				arg_162_1.leftNameTxt_.text = var_165_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_18 = arg_162_1:GetWordFromCfg(1106101040)
				local var_165_19 = arg_162_1:FormatText(var_165_18.content)

				arg_162_1.text_.text = var_165_19

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_20 = 15
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101040", "story_v_side_new_1106101.awb") ~= 0 then
					local var_165_23 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101040", "story_v_side_new_1106101.awb") / 1000

					if var_165_23 + var_165_15 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_23 + var_165_15
					end

					if var_165_18.prefab_name ~= "" and arg_162_1.actors_[var_165_18.prefab_name] ~= nil then
						local var_165_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_18.prefab_name].transform, "story_v_side_new_1106101", "1106101040", "story_v_side_new_1106101.awb")

						arg_162_1:RecordAudio("1106101040", var_165_24)
						arg_162_1:RecordAudio("1106101040", var_165_24)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101040", "story_v_side_new_1106101.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101040", "story_v_side_new_1106101.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_25 = math.max(var_165_16, arg_162_1.talkMaxDuration)

			if var_165_15 <= arg_162_1.time_ and arg_162_1.time_ < var_165_15 + var_165_25 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_15) / var_165_25

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_15 + var_165_25 and arg_162_1.time_ < var_165_15 + var_165_25 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play1106101041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1106101041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1106101042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1061ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1061ui_story == nil then
				arg_166_1.var_.characterEffect1061ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1061ui_story and not isNil(var_169_0) then
					local var_169_4 = Mathf.Lerp(0, 0.5, var_169_3)

					arg_166_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1061ui_story.fillRatio = var_169_4
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1061ui_story then
				local var_169_5 = 0.5

				arg_166_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1061ui_story.fillRatio = var_169_5
			end

			local var_169_6 = 0
			local var_169_7 = 0.775

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_8 = arg_166_1:FormatText(StoryNameCfg[7].name)

				arg_166_1.leftNameTxt_.text = var_169_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_9 = arg_166_1:GetWordFromCfg(1106101041)
				local var_169_10 = arg_166_1:FormatText(var_169_9.content)

				arg_166_1.text_.text = var_169_10

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_11 = 31
				local var_169_12 = utf8.len(var_169_10)
				local var_169_13 = var_169_11 <= 0 and var_169_7 or var_169_7 * (var_169_12 / var_169_11)

				if var_169_13 > 0 and var_169_7 < var_169_13 then
					arg_166_1.talkMaxDuration = var_169_13

					if var_169_13 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_13 + var_169_6
					end
				end

				arg_166_1.text_.text = var_169_10
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_14 = math.max(var_169_7, arg_166_1.talkMaxDuration)

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_14 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_6) / var_169_14

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_6 + var_169_14 and arg_166_1.time_ < var_169_6 + var_169_14 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play1106101042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1106101042
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1106101043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 1.225

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_2 = arg_170_1:FormatText(StoryNameCfg[7].name)

				arg_170_1.leftNameTxt_.text = var_173_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, true)
				arg_170_1.iconController_:SetSelectedState("hero")

				arg_170_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_170_1.callingController_:SetSelectedState("normal")

				arg_170_1.keyicon_.color = Color.New(1, 1, 1)
				arg_170_1.icon_.color = Color.New(1, 1, 1)

				local var_173_3 = arg_170_1:GetWordFromCfg(1106101042)
				local var_173_4 = arg_170_1:FormatText(var_173_3.content)

				arg_170_1.text_.text = var_173_4

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 49
				local var_173_6 = utf8.len(var_173_4)
				local var_173_7 = var_173_5 <= 0 and var_173_1 or var_173_1 * (var_173_6 / var_173_5)

				if var_173_7 > 0 and var_173_1 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_4
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_8 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_8 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_8

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_8 and arg_170_1.time_ < var_173_0 + var_173_8 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play1106101043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1106101043
		arg_174_1.duration_ = 4.93

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1106101044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1061ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1061ui_story == nil then
				arg_174_1.var_.characterEffect1061ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect1061ui_story and not isNil(var_177_0) then
					arg_174_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1061ui_story then
				arg_174_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_177_4 = 0

			if var_177_4 < arg_174_1.time_ and arg_174_1.time_ <= var_177_4 + arg_177_0 then
				arg_174_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action9_2")
			end

			local var_177_5 = 0

			if var_177_5 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 then
				arg_174_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_177_6 = 0
			local var_177_7 = 0.65

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_8 = arg_174_1:FormatText(StoryNameCfg[612].name)

				arg_174_1.leftNameTxt_.text = var_177_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_9 = arg_174_1:GetWordFromCfg(1106101043)
				local var_177_10 = arg_174_1:FormatText(var_177_9.content)

				arg_174_1.text_.text = var_177_10

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_11 = 26
				local var_177_12 = utf8.len(var_177_10)
				local var_177_13 = var_177_11 <= 0 and var_177_7 or var_177_7 * (var_177_12 / var_177_11)

				if var_177_13 > 0 and var_177_7 < var_177_13 then
					arg_174_1.talkMaxDuration = var_177_13

					if var_177_13 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_13 + var_177_6
					end
				end

				arg_174_1.text_.text = var_177_10
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101043", "story_v_side_new_1106101.awb") ~= 0 then
					local var_177_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101043", "story_v_side_new_1106101.awb") / 1000

					if var_177_14 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_14 + var_177_6
					end

					if var_177_9.prefab_name ~= "" and arg_174_1.actors_[var_177_9.prefab_name] ~= nil then
						local var_177_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_9.prefab_name].transform, "story_v_side_new_1106101", "1106101043", "story_v_side_new_1106101.awb")

						arg_174_1:RecordAudio("1106101043", var_177_15)
						arg_174_1:RecordAudio("1106101043", var_177_15)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101043", "story_v_side_new_1106101.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101043", "story_v_side_new_1106101.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_16 = math.max(var_177_7, arg_174_1.talkMaxDuration)

			if var_177_6 <= arg_174_1.time_ and arg_174_1.time_ < var_177_6 + var_177_16 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_6) / var_177_16

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_6 + var_177_16 and arg_174_1.time_ < var_177_6 + var_177_16 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play1106101044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1106101044
		arg_178_1.duration_ = 3.9

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1106101045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.475

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[612].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_3 = arg_178_1:GetWordFromCfg(1106101044)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 19
				local var_181_6 = utf8.len(var_181_4)
				local var_181_7 = var_181_5 <= 0 and var_181_1 or var_181_1 * (var_181_6 / var_181_5)

				if var_181_7 > 0 and var_181_1 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101044", "story_v_side_new_1106101.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101044", "story_v_side_new_1106101.awb") / 1000

					if var_181_8 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_0
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_side_new_1106101", "1106101044", "story_v_side_new_1106101.awb")

						arg_178_1:RecordAudio("1106101044", var_181_9)
						arg_178_1:RecordAudio("1106101044", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101044", "story_v_side_new_1106101.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101044", "story_v_side_new_1106101.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_10 and arg_178_1.time_ < var_181_0 + var_181_10 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play1106101045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1106101045
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1106101046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1061ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1061ui_story == nil then
				arg_182_1.var_.characterEffect1061ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1061ui_story and not isNil(var_185_0) then
					local var_185_4 = Mathf.Lerp(0, 0.5, var_185_3)

					arg_182_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1061ui_story.fillRatio = var_185_4
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1061ui_story then
				local var_185_5 = 0.5

				arg_182_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1061ui_story.fillRatio = var_185_5
			end

			local var_185_6 = 0
			local var_185_7 = 0.8

			if var_185_6 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_8 = arg_182_1:FormatText(StoryNameCfg[7].name)

				arg_182_1.leftNameTxt_.text = var_185_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_9 = arg_182_1:GetWordFromCfg(1106101045)
				local var_185_10 = arg_182_1:FormatText(var_185_9.content)

				arg_182_1.text_.text = var_185_10

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_11 = 32
				local var_185_12 = utf8.len(var_185_10)
				local var_185_13 = var_185_11 <= 0 and var_185_7 or var_185_7 * (var_185_12 / var_185_11)

				if var_185_13 > 0 and var_185_7 < var_185_13 then
					arg_182_1.talkMaxDuration = var_185_13

					if var_185_13 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_13 + var_185_6
					end
				end

				arg_182_1.text_.text = var_185_10
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_14 = math.max(var_185_7, arg_182_1.talkMaxDuration)

			if var_185_6 <= arg_182_1.time_ and arg_182_1.time_ < var_185_6 + var_185_14 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_6) / var_185_14

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_6 + var_185_14 and arg_182_1.time_ < var_185_6 + var_185_14 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play1106101046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1106101046
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1106101047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1061ui_story"].transform
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.var_.moveOldPos1061ui_story = var_189_0.localPosition
			end

			local var_189_2 = 0.001

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2
				local var_189_4 = Vector3.New(0, -1.18, -6.15)

				var_189_0.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1061ui_story, var_189_4, var_189_3)

				local var_189_5 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_5.x, var_189_5.y, var_189_5.z)

				local var_189_6 = var_189_0.localEulerAngles

				var_189_6.z = 0
				var_189_6.x = 0
				var_189_0.localEulerAngles = var_189_6
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 then
				var_189_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_189_7 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_7.x, var_189_7.y, var_189_7.z)

				local var_189_8 = var_189_0.localEulerAngles

				var_189_8.z = 0
				var_189_8.x = 0
				var_189_0.localEulerAngles = var_189_8
			end

			local var_189_9 = arg_186_1.actors_["1061ui_story"]
			local var_189_10 = 0

			if var_189_10 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 and not isNil(var_189_9) and arg_186_1.var_.characterEffect1061ui_story == nil then
				arg_186_1.var_.characterEffect1061ui_story = var_189_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_11 = 0.200000002980232

			if var_189_10 <= arg_186_1.time_ and arg_186_1.time_ < var_189_10 + var_189_11 and not isNil(var_189_9) then
				local var_189_12 = (arg_186_1.time_ - var_189_10) / var_189_11

				if arg_186_1.var_.characterEffect1061ui_story and not isNil(var_189_9) then
					arg_186_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_10 + var_189_11 and arg_186_1.time_ < var_189_10 + var_189_11 + arg_189_0 and not isNil(var_189_9) and arg_186_1.var_.characterEffect1061ui_story then
				arg_186_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_189_13 = 0
			local var_189_14 = 0.05

			if var_189_13 < arg_186_1.time_ and arg_186_1.time_ <= var_189_13 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_15 = arg_186_1:FormatText(StoryNameCfg[612].name)

				arg_186_1.leftNameTxt_.text = var_189_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_16 = arg_186_1:GetWordFromCfg(1106101046)
				local var_189_17 = arg_186_1:FormatText(var_189_16.content)

				arg_186_1.text_.text = var_189_17

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_18 = 2
				local var_189_19 = utf8.len(var_189_17)
				local var_189_20 = var_189_18 <= 0 and var_189_14 or var_189_14 * (var_189_19 / var_189_18)

				if var_189_20 > 0 and var_189_14 < var_189_20 then
					arg_186_1.talkMaxDuration = var_189_20

					if var_189_20 + var_189_13 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_20 + var_189_13
					end
				end

				arg_186_1.text_.text = var_189_17
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_21 = math.max(var_189_14, arg_186_1.talkMaxDuration)

			if var_189_13 <= arg_186_1.time_ and arg_186_1.time_ < var_189_13 + var_189_21 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_13) / var_189_21

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_13 + var_189_21 and arg_186_1.time_ < var_189_13 + var_189_21 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play1106101047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1106101047
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1106101048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1061ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1061ui_story == nil then
				arg_190_1.var_.characterEffect1061ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1061ui_story and not isNil(var_193_0) then
					local var_193_4 = Mathf.Lerp(0, 0.5, var_193_3)

					arg_190_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1061ui_story.fillRatio = var_193_4
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1061ui_story then
				local var_193_5 = 0.5

				arg_190_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1061ui_story.fillRatio = var_193_5
			end

			local var_193_6 = 0
			local var_193_7 = 0.325

			if var_193_6 < arg_190_1.time_ and arg_190_1.time_ <= var_193_6 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_8 = arg_190_1:FormatText(StoryNameCfg[7].name)

				arg_190_1.leftNameTxt_.text = var_193_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_9 = arg_190_1:GetWordFromCfg(1106101047)
				local var_193_10 = arg_190_1:FormatText(var_193_9.content)

				arg_190_1.text_.text = var_193_10

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_11 = 13
				local var_193_12 = utf8.len(var_193_10)
				local var_193_13 = var_193_11 <= 0 and var_193_7 or var_193_7 * (var_193_12 / var_193_11)

				if var_193_13 > 0 and var_193_7 < var_193_13 then
					arg_190_1.talkMaxDuration = var_193_13

					if var_193_13 + var_193_6 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_13 + var_193_6
					end
				end

				arg_190_1.text_.text = var_193_10
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_14 = math.max(var_193_7, arg_190_1.talkMaxDuration)

			if var_193_6 <= arg_190_1.time_ and arg_190_1.time_ < var_193_6 + var_193_14 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_6) / var_193_14

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_6 + var_193_14 and arg_190_1.time_ < var_193_6 + var_193_14 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1106101048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1106101048
		arg_194_1.duration_ = 3.73

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1106101049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1061ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1061ui_story == nil then
				arg_194_1.var_.characterEffect1061ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1061ui_story and not isNil(var_197_0) then
					arg_194_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1061ui_story then
				arg_194_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_197_4 = 0

			if var_197_4 < arg_194_1.time_ and arg_194_1.time_ <= var_197_4 + arg_197_0 then
				arg_194_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_197_5 = 0
			local var_197_6 = 0.35

			if var_197_5 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_7 = arg_194_1:FormatText(StoryNameCfg[612].name)

				arg_194_1.leftNameTxt_.text = var_197_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_8 = arg_194_1:GetWordFromCfg(1106101048)
				local var_197_9 = arg_194_1:FormatText(var_197_8.content)

				arg_194_1.text_.text = var_197_9

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_10 = 14
				local var_197_11 = utf8.len(var_197_9)
				local var_197_12 = var_197_10 <= 0 and var_197_6 or var_197_6 * (var_197_11 / var_197_10)

				if var_197_12 > 0 and var_197_6 < var_197_12 then
					arg_194_1.talkMaxDuration = var_197_12

					if var_197_12 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_12 + var_197_5
					end
				end

				arg_194_1.text_.text = var_197_9
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101048", "story_v_side_new_1106101.awb") ~= 0 then
					local var_197_13 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101048", "story_v_side_new_1106101.awb") / 1000

					if var_197_13 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_5
					end

					if var_197_8.prefab_name ~= "" and arg_194_1.actors_[var_197_8.prefab_name] ~= nil then
						local var_197_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_8.prefab_name].transform, "story_v_side_new_1106101", "1106101048", "story_v_side_new_1106101.awb")

						arg_194_1:RecordAudio("1106101048", var_197_14)
						arg_194_1:RecordAudio("1106101048", var_197_14)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101048", "story_v_side_new_1106101.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101048", "story_v_side_new_1106101.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_15 = math.max(var_197_6, arg_194_1.talkMaxDuration)

			if var_197_5 <= arg_194_1.time_ and arg_194_1.time_ < var_197_5 + var_197_15 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_5) / var_197_15

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_5 + var_197_15 and arg_194_1.time_ < var_197_5 + var_197_15 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1106101049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1106101049
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1106101050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1061ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1061ui_story == nil then
				arg_198_1.var_.characterEffect1061ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1061ui_story and not isNil(var_201_0) then
					local var_201_4 = Mathf.Lerp(0, 0.5, var_201_3)

					arg_198_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1061ui_story.fillRatio = var_201_4
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1061ui_story then
				local var_201_5 = 0.5

				arg_198_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1061ui_story.fillRatio = var_201_5
			end

			local var_201_6 = 0
			local var_201_7 = 0.8

			if var_201_6 < arg_198_1.time_ and arg_198_1.time_ <= var_201_6 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_8 = arg_198_1:FormatText(StoryNameCfg[7].name)

				arg_198_1.leftNameTxt_.text = var_201_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_9 = arg_198_1:GetWordFromCfg(1106101049)
				local var_201_10 = arg_198_1:FormatText(var_201_9.content)

				arg_198_1.text_.text = var_201_10

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_11 = 32
				local var_201_12 = utf8.len(var_201_10)
				local var_201_13 = var_201_11 <= 0 and var_201_7 or var_201_7 * (var_201_12 / var_201_11)

				if var_201_13 > 0 and var_201_7 < var_201_13 then
					arg_198_1.talkMaxDuration = var_201_13

					if var_201_13 + var_201_6 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_6
					end
				end

				arg_198_1.text_.text = var_201_10
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_14 = math.max(var_201_7, arg_198_1.talkMaxDuration)

			if var_201_6 <= arg_198_1.time_ and arg_198_1.time_ < var_201_6 + var_201_14 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_6) / var_201_14

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_6 + var_201_14 and arg_198_1.time_ < var_201_6 + var_201_14 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play1106101050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1106101050
		arg_202_1.duration_ = 2

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1106101051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1061ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1061ui_story == nil then
				arg_202_1.var_.characterEffect1061ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect1061ui_story and not isNil(var_205_0) then
					arg_202_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1061ui_story then
				arg_202_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_205_4 = 0

			if var_205_4 < arg_202_1.time_ and arg_202_1.time_ <= var_205_4 + arg_205_0 then
				arg_202_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_1")
			end

			local var_205_5 = 0

			if var_205_5 < arg_202_1.time_ and arg_202_1.time_ <= var_205_5 + arg_205_0 then
				arg_202_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_205_6 = 0
			local var_205_7 = 0.175

			if var_205_6 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_8 = arg_202_1:FormatText(StoryNameCfg[612].name)

				arg_202_1.leftNameTxt_.text = var_205_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_9 = arg_202_1:GetWordFromCfg(1106101050)
				local var_205_10 = arg_202_1:FormatText(var_205_9.content)

				arg_202_1.text_.text = var_205_10

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_11 = 7
				local var_205_12 = utf8.len(var_205_10)
				local var_205_13 = var_205_11 <= 0 and var_205_7 or var_205_7 * (var_205_12 / var_205_11)

				if var_205_13 > 0 and var_205_7 < var_205_13 then
					arg_202_1.talkMaxDuration = var_205_13

					if var_205_13 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_13 + var_205_6
					end
				end

				arg_202_1.text_.text = var_205_10
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101050", "story_v_side_new_1106101.awb") ~= 0 then
					local var_205_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101050", "story_v_side_new_1106101.awb") / 1000

					if var_205_14 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_14 + var_205_6
					end

					if var_205_9.prefab_name ~= "" and arg_202_1.actors_[var_205_9.prefab_name] ~= nil then
						local var_205_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_9.prefab_name].transform, "story_v_side_new_1106101", "1106101050", "story_v_side_new_1106101.awb")

						arg_202_1:RecordAudio("1106101050", var_205_15)
						arg_202_1:RecordAudio("1106101050", var_205_15)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101050", "story_v_side_new_1106101.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101050", "story_v_side_new_1106101.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_16 = math.max(var_205_7, arg_202_1.talkMaxDuration)

			if var_205_6 <= arg_202_1.time_ and arg_202_1.time_ < var_205_6 + var_205_16 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_6) / var_205_16

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_6 + var_205_16 and arg_202_1.time_ < var_205_6 + var_205_16 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play1106101051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1106101051
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1106101052(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1061ui_story"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect1061ui_story == nil then
				arg_206_1.var_.characterEffect1061ui_story = var_209_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.characterEffect1061ui_story and not isNil(var_209_0) then
					local var_209_4 = Mathf.Lerp(0, 0.5, var_209_3)

					arg_206_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_206_1.var_.characterEffect1061ui_story.fillRatio = var_209_4
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect1061ui_story then
				local var_209_5 = 0.5

				arg_206_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_206_1.var_.characterEffect1061ui_story.fillRatio = var_209_5
			end

			local var_209_6 = 0
			local var_209_7 = 1

			if var_209_6 < arg_206_1.time_ and arg_206_1.time_ <= var_209_6 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_8 = arg_206_1:FormatText(StoryNameCfg[7].name)

				arg_206_1.leftNameTxt_.text = var_209_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_9 = arg_206_1:GetWordFromCfg(1106101051)
				local var_209_10 = arg_206_1:FormatText(var_209_9.content)

				arg_206_1.text_.text = var_209_10

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_11 = 40
				local var_209_12 = utf8.len(var_209_10)
				local var_209_13 = var_209_11 <= 0 and var_209_7 or var_209_7 * (var_209_12 / var_209_11)

				if var_209_13 > 0 and var_209_7 < var_209_13 then
					arg_206_1.talkMaxDuration = var_209_13

					if var_209_13 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_6
					end
				end

				arg_206_1.text_.text = var_209_10
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_14 = math.max(var_209_7, arg_206_1.talkMaxDuration)

			if var_209_6 <= arg_206_1.time_ and arg_206_1.time_ < var_209_6 + var_209_14 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_6) / var_209_14

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_6 + var_209_14 and arg_206_1.time_ < var_209_6 + var_209_14 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1106101052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1106101052
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1106101053(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1061ui_story"].transform
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.var_.moveOldPos1061ui_story = var_213_0.localPosition
			end

			local var_213_2 = 0.001

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2
				local var_213_4 = Vector3.New(0, 100, 0)

				var_213_0.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1061ui_story, var_213_4, var_213_3)

				local var_213_5 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_5.x, var_213_5.y, var_213_5.z)

				local var_213_6 = var_213_0.localEulerAngles

				var_213_6.z = 0
				var_213_6.x = 0
				var_213_0.localEulerAngles = var_213_6
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 then
				var_213_0.localPosition = Vector3.New(0, 100, 0)

				local var_213_7 = manager.ui.mainCamera.transform.position - var_213_0.position

				var_213_0.forward = Vector3.New(var_213_7.x, var_213_7.y, var_213_7.z)

				local var_213_8 = var_213_0.localEulerAngles

				var_213_8.z = 0
				var_213_8.x = 0
				var_213_0.localEulerAngles = var_213_8
			end

			local var_213_9 = 0
			local var_213_10 = 0.925

			if var_213_9 < arg_210_1.time_ and arg_210_1.time_ <= var_213_9 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_11 = arg_210_1:GetWordFromCfg(1106101052)
				local var_213_12 = arg_210_1:FormatText(var_213_11.content)

				arg_210_1.text_.text = var_213_12

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_13 = 37
				local var_213_14 = utf8.len(var_213_12)
				local var_213_15 = var_213_13 <= 0 and var_213_10 or var_213_10 * (var_213_14 / var_213_13)

				if var_213_15 > 0 and var_213_10 < var_213_15 then
					arg_210_1.talkMaxDuration = var_213_15

					if var_213_15 + var_213_9 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_15 + var_213_9
					end
				end

				arg_210_1.text_.text = var_213_12
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_16 = math.max(var_213_10, arg_210_1.talkMaxDuration)

			if var_213_9 <= arg_210_1.time_ and arg_210_1.time_ < var_213_9 + var_213_16 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_9) / var_213_16

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_9 + var_213_16 and arg_210_1.time_ < var_213_9 + var_213_16 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play1106101053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1106101053
		arg_214_1.duration_ = 7.03

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1106101054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1061ui_story"].transform
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.var_.moveOldPos1061ui_story = var_217_0.localPosition
			end

			local var_217_2 = 0.001

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2
				local var_217_4 = Vector3.New(0, -1.18, -6.15)

				var_217_0.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1061ui_story, var_217_4, var_217_3)

				local var_217_5 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_5.x, var_217_5.y, var_217_5.z)

				local var_217_6 = var_217_0.localEulerAngles

				var_217_6.z = 0
				var_217_6.x = 0
				var_217_0.localEulerAngles = var_217_6
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 then
				var_217_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_217_7 = manager.ui.mainCamera.transform.position - var_217_0.position

				var_217_0.forward = Vector3.New(var_217_7.x, var_217_7.y, var_217_7.z)

				local var_217_8 = var_217_0.localEulerAngles

				var_217_8.z = 0
				var_217_8.x = 0
				var_217_0.localEulerAngles = var_217_8
			end

			local var_217_9 = arg_214_1.actors_["1061ui_story"]
			local var_217_10 = 0

			if var_217_10 < arg_214_1.time_ and arg_214_1.time_ <= var_217_10 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect1061ui_story == nil then
				arg_214_1.var_.characterEffect1061ui_story = var_217_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_11 = 0.200000002980232

			if var_217_10 <= arg_214_1.time_ and arg_214_1.time_ < var_217_10 + var_217_11 and not isNil(var_217_9) then
				local var_217_12 = (arg_214_1.time_ - var_217_10) / var_217_11

				if arg_214_1.var_.characterEffect1061ui_story and not isNil(var_217_9) then
					arg_214_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_10 + var_217_11 and arg_214_1.time_ < var_217_10 + var_217_11 + arg_217_0 and not isNil(var_217_9) and arg_214_1.var_.characterEffect1061ui_story then
				arg_214_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_217_13 = 0

			if var_217_13 < arg_214_1.time_ and arg_214_1.time_ <= var_217_13 + arg_217_0 then
				arg_214_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action483")
			end

			local var_217_14 = 0

			if var_217_14 < arg_214_1.time_ and arg_214_1.time_ <= var_217_14 + arg_217_0 then
				arg_214_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_217_15 = 0
			local var_217_16 = 0.8

			if var_217_15 < arg_214_1.time_ and arg_214_1.time_ <= var_217_15 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_17 = arg_214_1:FormatText(StoryNameCfg[612].name)

				arg_214_1.leftNameTxt_.text = var_217_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_18 = arg_214_1:GetWordFromCfg(1106101053)
				local var_217_19 = arg_214_1:FormatText(var_217_18.content)

				arg_214_1.text_.text = var_217_19

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_20 = 32
				local var_217_21 = utf8.len(var_217_19)
				local var_217_22 = var_217_20 <= 0 and var_217_16 or var_217_16 * (var_217_21 / var_217_20)

				if var_217_22 > 0 and var_217_16 < var_217_22 then
					arg_214_1.talkMaxDuration = var_217_22

					if var_217_22 + var_217_15 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_22 + var_217_15
					end
				end

				arg_214_1.text_.text = var_217_19
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101053", "story_v_side_new_1106101.awb") ~= 0 then
					local var_217_23 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101053", "story_v_side_new_1106101.awb") / 1000

					if var_217_23 + var_217_15 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_23 + var_217_15
					end

					if var_217_18.prefab_name ~= "" and arg_214_1.actors_[var_217_18.prefab_name] ~= nil then
						local var_217_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_18.prefab_name].transform, "story_v_side_new_1106101", "1106101053", "story_v_side_new_1106101.awb")

						arg_214_1:RecordAudio("1106101053", var_217_24)
						arg_214_1:RecordAudio("1106101053", var_217_24)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101053", "story_v_side_new_1106101.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101053", "story_v_side_new_1106101.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_25 = math.max(var_217_16, arg_214_1.talkMaxDuration)

			if var_217_15 <= arg_214_1.time_ and arg_214_1.time_ < var_217_15 + var_217_25 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_15) / var_217_25

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_15 + var_217_25 and arg_214_1.time_ < var_217_15 + var_217_25 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play1106101054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1106101054
		arg_218_1.duration_ = 2.87

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1106101055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_221_1 = 0
			local var_221_2 = 0.375

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_3 = arg_218_1:FormatText(StoryNameCfg[612].name)

				arg_218_1.leftNameTxt_.text = var_221_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_4 = arg_218_1:GetWordFromCfg(1106101054)
				local var_221_5 = arg_218_1:FormatText(var_221_4.content)

				arg_218_1.text_.text = var_221_5

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_6 = 15
				local var_221_7 = utf8.len(var_221_5)
				local var_221_8 = var_221_6 <= 0 and var_221_2 or var_221_2 * (var_221_7 / var_221_6)

				if var_221_8 > 0 and var_221_2 < var_221_8 then
					arg_218_1.talkMaxDuration = var_221_8

					if var_221_8 + var_221_1 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_8 + var_221_1
					end
				end

				arg_218_1.text_.text = var_221_5
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101054", "story_v_side_new_1106101.awb") ~= 0 then
					local var_221_9 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101054", "story_v_side_new_1106101.awb") / 1000

					if var_221_9 + var_221_1 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_1
					end

					if var_221_4.prefab_name ~= "" and arg_218_1.actors_[var_221_4.prefab_name] ~= nil then
						local var_221_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_4.prefab_name].transform, "story_v_side_new_1106101", "1106101054", "story_v_side_new_1106101.awb")

						arg_218_1:RecordAudio("1106101054", var_221_10)
						arg_218_1:RecordAudio("1106101054", var_221_10)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101054", "story_v_side_new_1106101.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101054", "story_v_side_new_1106101.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_11 = math.max(var_221_2, arg_218_1.talkMaxDuration)

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_11 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_1) / var_221_11

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_1 + var_221_11 and arg_218_1.time_ < var_221_1 + var_221_11 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1106101055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1106101055
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1106101056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1061ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1061ui_story == nil then
				arg_222_1.var_.characterEffect1061ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect1061ui_story and not isNil(var_225_0) then
					local var_225_4 = Mathf.Lerp(0, 0.5, var_225_3)

					arg_222_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_222_1.var_.characterEffect1061ui_story.fillRatio = var_225_4
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1061ui_story then
				local var_225_5 = 0.5

				arg_222_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_222_1.var_.characterEffect1061ui_story.fillRatio = var_225_5
			end

			local var_225_6 = 0
			local var_225_7 = 0.775

			if var_225_6 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_8 = arg_222_1:GetWordFromCfg(1106101055)
				local var_225_9 = arg_222_1:FormatText(var_225_8.content)

				arg_222_1.text_.text = var_225_9

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_10 = 31
				local var_225_11 = utf8.len(var_225_9)
				local var_225_12 = var_225_10 <= 0 and var_225_7 or var_225_7 * (var_225_11 / var_225_10)

				if var_225_12 > 0 and var_225_7 < var_225_12 then
					arg_222_1.talkMaxDuration = var_225_12

					if var_225_12 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_12 + var_225_6
					end
				end

				arg_222_1.text_.text = var_225_9
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_13 = math.max(var_225_7, arg_222_1.talkMaxDuration)

			if var_225_6 <= arg_222_1.time_ and arg_222_1.time_ < var_225_6 + var_225_13 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_6) / var_225_13

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_6 + var_225_13 and arg_222_1.time_ < var_225_6 + var_225_13 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1106101056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1106101056
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1106101057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0
			local var_229_1 = 0.4

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_2 = arg_226_1:FormatText(StoryNameCfg[7].name)

				arg_226_1.leftNameTxt_.text = var_229_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:GetWordFromCfg(1106101056)
				local var_229_4 = arg_226_1:FormatText(var_229_3.content)

				arg_226_1.text_.text = var_229_4

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 16
				local var_229_6 = utf8.len(var_229_4)
				local var_229_7 = var_229_5 <= 0 and var_229_1 or var_229_1 * (var_229_6 / var_229_5)

				if var_229_7 > 0 and var_229_1 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_0
					end
				end

				arg_226_1.text_.text = var_229_4
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_8 = math.max(var_229_1, arg_226_1.talkMaxDuration)

			if var_229_0 <= arg_226_1.time_ and arg_226_1.time_ < var_229_0 + var_229_8 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_0) / var_229_8

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_0 + var_229_8 and arg_226_1.time_ < var_229_0 + var_229_8 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play1106101057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1106101057
		arg_230_1.duration_ = 6.67

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1106101058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1061ui_story"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1061ui_story == nil then
				arg_230_1.var_.characterEffect1061ui_story = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect1061ui_story and not isNil(var_233_0) then
					arg_230_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1061ui_story then
				arg_230_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_233_4 = 0

			if var_233_4 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action437")
			end

			local var_233_5 = 0

			if var_233_5 < arg_230_1.time_ and arg_230_1.time_ <= var_233_5 + arg_233_0 then
				arg_230_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_233_6 = 0
			local var_233_7 = 0.625

			if var_233_6 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_8 = arg_230_1:FormatText(StoryNameCfg[612].name)

				arg_230_1.leftNameTxt_.text = var_233_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_9 = arg_230_1:GetWordFromCfg(1106101057)
				local var_233_10 = arg_230_1:FormatText(var_233_9.content)

				arg_230_1.text_.text = var_233_10

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_11 = 25
				local var_233_12 = utf8.len(var_233_10)
				local var_233_13 = var_233_11 <= 0 and var_233_7 or var_233_7 * (var_233_12 / var_233_11)

				if var_233_13 > 0 and var_233_7 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_6
					end
				end

				arg_230_1.text_.text = var_233_10
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101057", "story_v_side_new_1106101.awb") ~= 0 then
					local var_233_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101057", "story_v_side_new_1106101.awb") / 1000

					if var_233_14 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_14 + var_233_6
					end

					if var_233_9.prefab_name ~= "" and arg_230_1.actors_[var_233_9.prefab_name] ~= nil then
						local var_233_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_9.prefab_name].transform, "story_v_side_new_1106101", "1106101057", "story_v_side_new_1106101.awb")

						arg_230_1:RecordAudio("1106101057", var_233_15)
						arg_230_1:RecordAudio("1106101057", var_233_15)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101057", "story_v_side_new_1106101.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101057", "story_v_side_new_1106101.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = math.max(var_233_7, arg_230_1.talkMaxDuration)

			if var_233_6 <= arg_230_1.time_ and arg_230_1.time_ < var_233_6 + var_233_16 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_6) / var_233_16

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_6 + var_233_16 and arg_230_1.time_ < var_233_6 + var_233_16 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play1106101058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1106101058
		arg_234_1.duration_ = 1

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"

			SetActive(arg_234_1.choicesGo_, true)

			for iter_235_0, iter_235_1 in ipairs(arg_234_1.choices_) do
				local var_235_0 = iter_235_0 <= 1

				SetActive(iter_235_1.go, var_235_0)
			end

			arg_234_1.choices_[1].txt.text = arg_234_1:FormatText(StoryChoiceCfg[1383].name)
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1106101059(arg_234_1)
			end

			arg_234_1:RecordChoiceLog(1106101058, 1383)
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1061ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1061ui_story == nil then
				arg_234_1.var_.characterEffect1061ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect1061ui_story and not isNil(var_237_0) then
					local var_237_4 = Mathf.Lerp(0, 0.5, var_237_3)

					arg_234_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1061ui_story.fillRatio = var_237_4
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1061ui_story then
				local var_237_5 = 0.5

				arg_234_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1061ui_story.fillRatio = var_237_5
			end

			local var_237_6 = 0

			if var_237_6 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.allBtn_.enabled = false
			end

			local var_237_7 = 0.6

			if arg_234_1.time_ >= var_237_6 + var_237_7 and arg_234_1.time_ < var_237_6 + var_237_7 + arg_237_0 then
				arg_234_1.allBtn_.enabled = true
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1106101059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1106101059
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1106101060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 0.925

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_2 = arg_238_1:FormatText(StoryNameCfg[7].name)

				arg_238_1.leftNameTxt_.text = var_241_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:GetWordFromCfg(1106101059)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 37
				local var_241_6 = utf8.len(var_241_4)
				local var_241_7 = var_241_5 <= 0 and var_241_1 or var_241_1 * (var_241_6 / var_241_5)

				if var_241_7 > 0 and var_241_1 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_0
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_8 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_8 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_8

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_8 and arg_238_1.time_ < var_241_0 + var_241_8 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play1106101060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1106101060
		arg_242_1.duration_ = 2.3

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1106101061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1061ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1061ui_story == nil then
				arg_242_1.var_.characterEffect1061ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect1061ui_story and not isNil(var_245_0) then
					arg_242_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect1061ui_story then
				arg_242_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_245_4 = 0

			if var_245_4 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action7_2")
			end

			local var_245_5 = 0

			if var_245_5 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_245_6 = 0
			local var_245_7 = 0.25

			if var_245_6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_8 = arg_242_1:FormatText(StoryNameCfg[612].name)

				arg_242_1.leftNameTxt_.text = var_245_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_9 = arg_242_1:GetWordFromCfg(1106101060)
				local var_245_10 = arg_242_1:FormatText(var_245_9.content)

				arg_242_1.text_.text = var_245_10

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_11 = 10
				local var_245_12 = utf8.len(var_245_10)
				local var_245_13 = var_245_11 <= 0 and var_245_7 or var_245_7 * (var_245_12 / var_245_11)

				if var_245_13 > 0 and var_245_7 < var_245_13 then
					arg_242_1.talkMaxDuration = var_245_13

					if var_245_13 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_13 + var_245_6
					end
				end

				arg_242_1.text_.text = var_245_10
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101060", "story_v_side_new_1106101.awb") ~= 0 then
					local var_245_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101060", "story_v_side_new_1106101.awb") / 1000

					if var_245_14 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_14 + var_245_6
					end

					if var_245_9.prefab_name ~= "" and arg_242_1.actors_[var_245_9.prefab_name] ~= nil then
						local var_245_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_9.prefab_name].transform, "story_v_side_new_1106101", "1106101060", "story_v_side_new_1106101.awb")

						arg_242_1:RecordAudio("1106101060", var_245_15)
						arg_242_1:RecordAudio("1106101060", var_245_15)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101060", "story_v_side_new_1106101.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101060", "story_v_side_new_1106101.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_16 = math.max(var_245_7, arg_242_1.talkMaxDuration)

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_16 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_6) / var_245_16

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_6 + var_245_16 and arg_242_1.time_ < var_245_6 + var_245_16 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play1106101061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1106101061
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1106101062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["1061ui_story"]
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1061ui_story == nil then
				arg_246_1.var_.characterEffect1061ui_story = var_249_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 and not isNil(var_249_0) then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2

				if arg_246_1.var_.characterEffect1061ui_story and not isNil(var_249_0) then
					local var_249_4 = Mathf.Lerp(0, 0.5, var_249_3)

					arg_246_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1061ui_story.fillRatio = var_249_4
				end
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 and not isNil(var_249_0) and arg_246_1.var_.characterEffect1061ui_story then
				local var_249_5 = 0.5

				arg_246_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1061ui_story.fillRatio = var_249_5
			end

			local var_249_6 = 0
			local var_249_7 = 1.1

			if var_249_6 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_8 = arg_246_1:FormatText(StoryNameCfg[7].name)

				arg_246_1.leftNameTxt_.text = var_249_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_9 = arg_246_1:GetWordFromCfg(1106101061)
				local var_249_10 = arg_246_1:FormatText(var_249_9.content)

				arg_246_1.text_.text = var_249_10

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_11 = 44
				local var_249_12 = utf8.len(var_249_10)
				local var_249_13 = var_249_11 <= 0 and var_249_7 or var_249_7 * (var_249_12 / var_249_11)

				if var_249_13 > 0 and var_249_7 < var_249_13 then
					arg_246_1.talkMaxDuration = var_249_13

					if var_249_13 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_13 + var_249_6
					end
				end

				arg_246_1.text_.text = var_249_10
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_14 = math.max(var_249_7, arg_246_1.talkMaxDuration)

			if var_249_6 <= arg_246_1.time_ and arg_246_1.time_ < var_249_6 + var_249_14 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_6) / var_249_14

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_6 + var_249_14 and arg_246_1.time_ < var_249_6 + var_249_14 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1106101062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1106101062
		arg_250_1.duration_ = 6.13

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1106101063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1061ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1061ui_story == nil then
				arg_250_1.var_.characterEffect1061ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect1061ui_story and not isNil(var_253_0) then
					arg_250_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1061ui_story then
				arg_250_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_253_4 = 0

			if var_253_4 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_253_5 = 0
			local var_253_6 = 0.6

			if var_253_5 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_7 = arg_250_1:FormatText(StoryNameCfg[612].name)

				arg_250_1.leftNameTxt_.text = var_253_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_8 = arg_250_1:GetWordFromCfg(1106101062)
				local var_253_9 = arg_250_1:FormatText(var_253_8.content)

				arg_250_1.text_.text = var_253_9

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_10 = 24
				local var_253_11 = utf8.len(var_253_9)
				local var_253_12 = var_253_10 <= 0 and var_253_6 or var_253_6 * (var_253_11 / var_253_10)

				if var_253_12 > 0 and var_253_6 < var_253_12 then
					arg_250_1.talkMaxDuration = var_253_12

					if var_253_12 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_12 + var_253_5
					end
				end

				arg_250_1.text_.text = var_253_9
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101062", "story_v_side_new_1106101.awb") ~= 0 then
					local var_253_13 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101062", "story_v_side_new_1106101.awb") / 1000

					if var_253_13 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_5
					end

					if var_253_8.prefab_name ~= "" and arg_250_1.actors_[var_253_8.prefab_name] ~= nil then
						local var_253_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_8.prefab_name].transform, "story_v_side_new_1106101", "1106101062", "story_v_side_new_1106101.awb")

						arg_250_1:RecordAudio("1106101062", var_253_14)
						arg_250_1:RecordAudio("1106101062", var_253_14)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101062", "story_v_side_new_1106101.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101062", "story_v_side_new_1106101.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_15 = math.max(var_253_6, arg_250_1.talkMaxDuration)

			if var_253_5 <= arg_250_1.time_ and arg_250_1.time_ < var_253_5 + var_253_15 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_5) / var_253_15

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_5 + var_253_15 and arg_250_1.time_ < var_253_5 + var_253_15 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play1106101063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1106101063
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1106101064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1061ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1061ui_story == nil then
				arg_254_1.var_.characterEffect1061ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1061ui_story and not isNil(var_257_0) then
					local var_257_4 = Mathf.Lerp(0, 0.5, var_257_3)

					arg_254_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1061ui_story.fillRatio = var_257_4
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1061ui_story then
				local var_257_5 = 0.5

				arg_254_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1061ui_story.fillRatio = var_257_5
			end

			local var_257_6 = 0
			local var_257_7 = 0.675

			if var_257_6 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_8 = arg_254_1:FormatText(StoryNameCfg[7].name)

				arg_254_1.leftNameTxt_.text = var_257_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, true)
				arg_254_1.iconController_:SetSelectedState("hero")

				arg_254_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_254_1.callingController_:SetSelectedState("normal")

				arg_254_1.keyicon_.color = Color.New(1, 1, 1)
				arg_254_1.icon_.color = Color.New(1, 1, 1)

				local var_257_9 = arg_254_1:GetWordFromCfg(1106101063)
				local var_257_10 = arg_254_1:FormatText(var_257_9.content)

				arg_254_1.text_.text = var_257_10

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 27
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
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_14 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_14 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_14

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_14 and arg_254_1.time_ < var_257_6 + var_257_14 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1106101064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1106101064
		arg_258_1.duration_ = 2.6

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1106101065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1061ui_story"]
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1061ui_story == nil then
				arg_258_1.var_.characterEffect1061ui_story = var_261_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 and not isNil(var_261_0) then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2

				if arg_258_1.var_.characterEffect1061ui_story and not isNil(var_261_0) then
					arg_258_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 and not isNil(var_261_0) and arg_258_1.var_.characterEffect1061ui_story then
				arg_258_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_261_4 = 0

			if var_261_4 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_1")
			end

			local var_261_5 = 0
			local var_261_6 = 0.25

			if var_261_5 < arg_258_1.time_ and arg_258_1.time_ <= var_261_5 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_7 = arg_258_1:FormatText(StoryNameCfg[612].name)

				arg_258_1.leftNameTxt_.text = var_261_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_8 = arg_258_1:GetWordFromCfg(1106101064)
				local var_261_9 = arg_258_1:FormatText(var_261_8.content)

				arg_258_1.text_.text = var_261_9

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_10 = 10
				local var_261_11 = utf8.len(var_261_9)
				local var_261_12 = var_261_10 <= 0 and var_261_6 or var_261_6 * (var_261_11 / var_261_10)

				if var_261_12 > 0 and var_261_6 < var_261_12 then
					arg_258_1.talkMaxDuration = var_261_12

					if var_261_12 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_12 + var_261_5
					end
				end

				arg_258_1.text_.text = var_261_9
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101064", "story_v_side_new_1106101.awb") ~= 0 then
					local var_261_13 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101064", "story_v_side_new_1106101.awb") / 1000

					if var_261_13 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_5
					end

					if var_261_8.prefab_name ~= "" and arg_258_1.actors_[var_261_8.prefab_name] ~= nil then
						local var_261_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_8.prefab_name].transform, "story_v_side_new_1106101", "1106101064", "story_v_side_new_1106101.awb")

						arg_258_1:RecordAudio("1106101064", var_261_14)
						arg_258_1:RecordAudio("1106101064", var_261_14)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101064", "story_v_side_new_1106101.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101064", "story_v_side_new_1106101.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_15 = math.max(var_261_6, arg_258_1.talkMaxDuration)

			if var_261_5 <= arg_258_1.time_ and arg_258_1.time_ < var_261_5 + var_261_15 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_5) / var_261_15

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_5 + var_261_15 and arg_258_1.time_ < var_261_5 + var_261_15 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play1106101065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1106101065
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1106101066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1061ui_story"].transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.moveOldPos1061ui_story = var_265_0.localPosition
			end

			local var_265_2 = 0.001

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2
				local var_265_4 = Vector3.New(0, 100, 0)

				var_265_0.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1061ui_story, var_265_4, var_265_3)

				local var_265_5 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_5.x, var_265_5.y, var_265_5.z)

				local var_265_6 = var_265_0.localEulerAngles

				var_265_6.z = 0
				var_265_6.x = 0
				var_265_0.localEulerAngles = var_265_6
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 then
				var_265_0.localPosition = Vector3.New(0, 100, 0)

				local var_265_7 = manager.ui.mainCamera.transform.position - var_265_0.position

				var_265_0.forward = Vector3.New(var_265_7.x, var_265_7.y, var_265_7.z)

				local var_265_8 = var_265_0.localEulerAngles

				var_265_8.z = 0
				var_265_8.x = 0
				var_265_0.localEulerAngles = var_265_8
			end

			local var_265_9 = arg_262_1.actors_["1061ui_story"]
			local var_265_10 = 0

			if var_265_10 < arg_262_1.time_ and arg_262_1.time_ <= var_265_10 + arg_265_0 and not isNil(var_265_9) and arg_262_1.var_.characterEffect1061ui_story == nil then
				arg_262_1.var_.characterEffect1061ui_story = var_265_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_11 = 0.200000002980232

			if var_265_10 <= arg_262_1.time_ and arg_262_1.time_ < var_265_10 + var_265_11 and not isNil(var_265_9) then
				local var_265_12 = (arg_262_1.time_ - var_265_10) / var_265_11

				if arg_262_1.var_.characterEffect1061ui_story and not isNil(var_265_9) then
					local var_265_13 = Mathf.Lerp(0, 0.5, var_265_12)

					arg_262_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1061ui_story.fillRatio = var_265_13
				end
			end

			if arg_262_1.time_ >= var_265_10 + var_265_11 and arg_262_1.time_ < var_265_10 + var_265_11 + arg_265_0 and not isNil(var_265_9) and arg_262_1.var_.characterEffect1061ui_story then
				local var_265_14 = 0.5

				arg_262_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1061ui_story.fillRatio = var_265_14
			end

			local var_265_15 = 0
			local var_265_16 = 1.075

			if var_265_15 < arg_262_1.time_ and arg_262_1.time_ <= var_265_15 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_17 = arg_262_1:GetWordFromCfg(1106101065)
				local var_265_18 = arg_262_1:FormatText(var_265_17.content)

				arg_262_1.text_.text = var_265_18

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_19 = 43
				local var_265_20 = utf8.len(var_265_18)
				local var_265_21 = var_265_19 <= 0 and var_265_16 or var_265_16 * (var_265_20 / var_265_19)

				if var_265_21 > 0 and var_265_16 < var_265_21 then
					arg_262_1.talkMaxDuration = var_265_21

					if var_265_21 + var_265_15 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_21 + var_265_15
					end
				end

				arg_262_1.text_.text = var_265_18
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_22 = math.max(var_265_16, arg_262_1.talkMaxDuration)

			if var_265_15 <= arg_262_1.time_ and arg_262_1.time_ < var_265_15 + var_265_22 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_15) / var_265_22

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_15 + var_265_22 and arg_262_1.time_ < var_265_15 + var_265_22 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play1106101066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1106101066
		arg_266_1.duration_ = 2.6

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1106101067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = arg_266_1.actors_["1061ui_story"].transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.moveOldPos1061ui_story = var_269_0.localPosition
			end

			local var_269_2 = 0.001

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / var_269_2
				local var_269_4 = Vector3.New(0, -1.18, -6.15)

				var_269_0.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1061ui_story, var_269_4, var_269_3)

				local var_269_5 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_5.x, var_269_5.y, var_269_5.z)

				local var_269_6 = var_269_0.localEulerAngles

				var_269_6.z = 0
				var_269_6.x = 0
				var_269_0.localEulerAngles = var_269_6
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 then
				var_269_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_269_7 = manager.ui.mainCamera.transform.position - var_269_0.position

				var_269_0.forward = Vector3.New(var_269_7.x, var_269_7.y, var_269_7.z)

				local var_269_8 = var_269_0.localEulerAngles

				var_269_8.z = 0
				var_269_8.x = 0
				var_269_0.localEulerAngles = var_269_8
			end

			local var_269_9 = arg_266_1.actors_["1061ui_story"]
			local var_269_10 = 0

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect1061ui_story == nil then
				arg_266_1.var_.characterEffect1061ui_story = var_269_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_11 = 0.200000002980232

			if var_269_10 <= arg_266_1.time_ and arg_266_1.time_ < var_269_10 + var_269_11 and not isNil(var_269_9) then
				local var_269_12 = (arg_266_1.time_ - var_269_10) / var_269_11

				if arg_266_1.var_.characterEffect1061ui_story and not isNil(var_269_9) then
					arg_266_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= var_269_10 + var_269_11 and arg_266_1.time_ < var_269_10 + var_269_11 + arg_269_0 and not isNil(var_269_9) and arg_266_1.var_.characterEffect1061ui_story then
				arg_266_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_269_13 = 0

			if var_269_13 < arg_266_1.time_ and arg_266_1.time_ <= var_269_13 + arg_269_0 then
				arg_266_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_2")
			end

			local var_269_14 = 0

			if var_269_14 < arg_266_1.time_ and arg_266_1.time_ <= var_269_14 + arg_269_0 then
				arg_266_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_269_15 = 0
			local var_269_16 = 0.225

			if var_269_15 < arg_266_1.time_ and arg_266_1.time_ <= var_269_15 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_17 = arg_266_1:FormatText(StoryNameCfg[612].name)

				arg_266_1.leftNameTxt_.text = var_269_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_18 = arg_266_1:GetWordFromCfg(1106101066)
				local var_269_19 = arg_266_1:FormatText(var_269_18.content)

				arg_266_1.text_.text = var_269_19

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_20 = 9
				local var_269_21 = utf8.len(var_269_19)
				local var_269_22 = var_269_20 <= 0 and var_269_16 or var_269_16 * (var_269_21 / var_269_20)

				if var_269_22 > 0 and var_269_16 < var_269_22 then
					arg_266_1.talkMaxDuration = var_269_22

					if var_269_22 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_22 + var_269_15
					end
				end

				arg_266_1.text_.text = var_269_19
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101066", "story_v_side_new_1106101.awb") ~= 0 then
					local var_269_23 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101066", "story_v_side_new_1106101.awb") / 1000

					if var_269_23 + var_269_15 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_23 + var_269_15
					end

					if var_269_18.prefab_name ~= "" and arg_266_1.actors_[var_269_18.prefab_name] ~= nil then
						local var_269_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_18.prefab_name].transform, "story_v_side_new_1106101", "1106101066", "story_v_side_new_1106101.awb")

						arg_266_1:RecordAudio("1106101066", var_269_24)
						arg_266_1:RecordAudio("1106101066", var_269_24)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101066", "story_v_side_new_1106101.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101066", "story_v_side_new_1106101.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_25 = math.max(var_269_16, arg_266_1.talkMaxDuration)

			if var_269_15 <= arg_266_1.time_ and arg_266_1.time_ < var_269_15 + var_269_25 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_15) / var_269_25

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_15 + var_269_25 and arg_266_1.time_ < var_269_15 + var_269_25 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play1106101067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1106101067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1106101068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1061ui_story"]
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1061ui_story == nil then
				arg_270_1.var_.characterEffect1061ui_story = var_273_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.200000002980232

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 and not isNil(var_273_0) then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2

				if arg_270_1.var_.characterEffect1061ui_story and not isNil(var_273_0) then
					local var_273_4 = Mathf.Lerp(0, 0.5, var_273_3)

					arg_270_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1061ui_story.fillRatio = var_273_4
				end
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 and not isNil(var_273_0) and arg_270_1.var_.characterEffect1061ui_story then
				local var_273_5 = 0.5

				arg_270_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1061ui_story.fillRatio = var_273_5
			end

			local var_273_6 = 0
			local var_273_7 = 0.3

			if var_273_6 < arg_270_1.time_ and arg_270_1.time_ <= var_273_6 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_8 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_9 = arg_270_1:GetWordFromCfg(1106101067)
				local var_273_10 = arg_270_1:FormatText(var_273_9.content)

				arg_270_1.text_.text = var_273_10

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_11 = 12
				local var_273_12 = utf8.len(var_273_10)
				local var_273_13 = var_273_11 <= 0 and var_273_7 or var_273_7 * (var_273_12 / var_273_11)

				if var_273_13 > 0 and var_273_7 < var_273_13 then
					arg_270_1.talkMaxDuration = var_273_13

					if var_273_13 + var_273_6 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_6
					end
				end

				arg_270_1.text_.text = var_273_10
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_14 = math.max(var_273_7, arg_270_1.talkMaxDuration)

			if var_273_6 <= arg_270_1.time_ and arg_270_1.time_ < var_273_6 + var_273_14 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_6) / var_273_14

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_6 + var_273_14 and arg_270_1.time_ < var_273_6 + var_273_14 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1106101068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1106101068
		arg_274_1.duration_ = 9

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1106101069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = "ST37a"

			if arg_274_1.bgs_[var_277_0] == nil then
				local var_277_1 = Object.Instantiate(arg_274_1.paintGo_)

				var_277_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_277_0)
				var_277_1.name = var_277_0
				var_277_1.transform.parent = arg_274_1.stage_.transform
				var_277_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.bgs_[var_277_0] = var_277_1
			end

			local var_277_2 = 2

			if var_277_2 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				local var_277_3 = manager.ui.mainCamera.transform.localPosition
				local var_277_4 = Vector3.New(0, 0, 10) + Vector3.New(var_277_3.x, var_277_3.y, 0)
				local var_277_5 = arg_274_1.bgs_.ST37a

				var_277_5.transform.localPosition = var_277_4
				var_277_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_277_6 = var_277_5:GetComponent("SpriteRenderer")

				if var_277_6 and var_277_6.sprite then
					local var_277_7 = (var_277_5.transform.localPosition - var_277_3).z
					local var_277_8 = manager.ui.mainCameraCom_
					local var_277_9 = 2 * var_277_7 * Mathf.Tan(var_277_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_277_10 = var_277_9 * var_277_8.aspect
					local var_277_11 = var_277_6.sprite.bounds.size.x
					local var_277_12 = var_277_6.sprite.bounds.size.y
					local var_277_13 = var_277_10 / var_277_11
					local var_277_14 = var_277_9 / var_277_12
					local var_277_15 = var_277_14 < var_277_13 and var_277_13 or var_277_14

					var_277_5.transform.localScale = Vector3.New(var_277_15, var_277_15, 0)
				end

				for iter_277_0, iter_277_1 in pairs(arg_274_1.bgs_) do
					if iter_277_0 ~= "ST37a" then
						iter_277_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_277_16 = 3.999999999999

			if var_277_16 < arg_274_1.time_ and arg_274_1.time_ <= var_277_16 + arg_277_0 then
				arg_274_1.allBtn_.enabled = false
			end

			local var_277_17 = 0.3

			if arg_274_1.time_ >= var_277_16 + var_277_17 and arg_274_1.time_ < var_277_16 + var_277_17 + arg_277_0 then
				arg_274_1.allBtn_.enabled = true
			end

			local var_277_18 = 0

			if var_277_18 < arg_274_1.time_ and arg_274_1.time_ <= var_277_18 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_19 = 2

			if var_277_18 <= arg_274_1.time_ and arg_274_1.time_ < var_277_18 + var_277_19 then
				local var_277_20 = (arg_274_1.time_ - var_277_18) / var_277_19
				local var_277_21 = Color.New(0, 0, 0)

				var_277_21.a = Mathf.Lerp(0, 1, var_277_20)
				arg_274_1.mask_.color = var_277_21
			end

			if arg_274_1.time_ >= var_277_18 + var_277_19 and arg_274_1.time_ < var_277_18 + var_277_19 + arg_277_0 then
				local var_277_22 = Color.New(0, 0, 0)

				var_277_22.a = 1
				arg_274_1.mask_.color = var_277_22
			end

			local var_277_23 = 2

			if var_277_23 < arg_274_1.time_ and arg_274_1.time_ <= var_277_23 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_24 = 2

			if var_277_23 <= arg_274_1.time_ and arg_274_1.time_ < var_277_23 + var_277_24 then
				local var_277_25 = (arg_274_1.time_ - var_277_23) / var_277_24
				local var_277_26 = Color.New(0, 0, 0)

				var_277_26.a = Mathf.Lerp(1, 0, var_277_25)
				arg_274_1.mask_.color = var_277_26
			end

			if arg_274_1.time_ >= var_277_23 + var_277_24 and arg_274_1.time_ < var_277_23 + var_277_24 + arg_277_0 then
				local var_277_27 = Color.New(0, 0, 0)
				local var_277_28 = 0

				arg_274_1.mask_.enabled = false
				var_277_27.a = var_277_28
				arg_274_1.mask_.color = var_277_27
			end

			local var_277_29 = arg_274_1.actors_["1061ui_story"].transform
			local var_277_30 = 1.96599999815226

			if var_277_30 < arg_274_1.time_ and arg_274_1.time_ <= var_277_30 + arg_277_0 then
				arg_274_1.var_.moveOldPos1061ui_story = var_277_29.localPosition
			end

			local var_277_31 = 0.001

			if var_277_30 <= arg_274_1.time_ and arg_274_1.time_ < var_277_30 + var_277_31 then
				local var_277_32 = (arg_274_1.time_ - var_277_30) / var_277_31
				local var_277_33 = Vector3.New(0, 100, 0)

				var_277_29.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1061ui_story, var_277_33, var_277_32)

				local var_277_34 = manager.ui.mainCamera.transform.position - var_277_29.position

				var_277_29.forward = Vector3.New(var_277_34.x, var_277_34.y, var_277_34.z)

				local var_277_35 = var_277_29.localEulerAngles

				var_277_35.z = 0
				var_277_35.x = 0
				var_277_29.localEulerAngles = var_277_35
			end

			if arg_274_1.time_ >= var_277_30 + var_277_31 and arg_274_1.time_ < var_277_30 + var_277_31 + arg_277_0 then
				var_277_29.localPosition = Vector3.New(0, 100, 0)

				local var_277_36 = manager.ui.mainCamera.transform.position - var_277_29.position

				var_277_29.forward = Vector3.New(var_277_36.x, var_277_36.y, var_277_36.z)

				local var_277_37 = var_277_29.localEulerAngles

				var_277_37.z = 0
				var_277_37.x = 0
				var_277_29.localEulerAngles = var_277_37
			end

			local var_277_38 = 1.56666666666667
			local var_277_39 = 1

			if var_277_38 < arg_274_1.time_ and arg_274_1.time_ <= var_277_38 + arg_277_0 then
				local var_277_40 = "play"
				local var_277_41 = "effect"

				arg_274_1:AudioAction(var_277_40, var_277_41, "se_story_143", "se_story_143_amb_room", "")
			end

			local var_277_42 = 4.56666666666667
			local var_277_43 = 1

			if var_277_42 < arg_274_1.time_ and arg_274_1.time_ <= var_277_42 + arg_277_0 then
				local var_277_44 = "play"
				local var_277_45 = "effect"

				arg_274_1:AudioAction(var_277_44, var_277_45, "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_277_46 = 0.266666666666667
			local var_277_47 = 1

			if var_277_46 < arg_274_1.time_ and arg_274_1.time_ <= var_277_46 + arg_277_0 then
				local var_277_48 = "stop"
				local var_277_49 = "effect"

				arg_274_1:AudioAction(var_277_48, var_277_49, "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_274_1.frameCnt_ <= 1 then
				arg_274_1.dialog_:SetActive(false)
			end

			local var_277_50 = 4
			local var_277_51 = 0.975

			if var_277_50 < arg_274_1.time_ and arg_274_1.time_ <= var_277_50 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0

				arg_274_1.dialog_:SetActive(true)

				arg_274_1.dialogCg_.alpha = 0

				local var_277_52 = LeanTween.value(arg_274_1.dialog_, 0, 1, 0.3)

				var_277_52:setOnUpdate(LuaHelper.FloatAction(function(arg_278_0)
					arg_274_1.dialogCg_.alpha = arg_278_0
				end))
				var_277_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_274_1.dialog_)
					var_277_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_274_1.duration_ = arg_274_1.duration_ + 0.3

				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_53 = arg_274_1:GetWordFromCfg(1106101068)
				local var_277_54 = arg_274_1:FormatText(var_277_53.content)

				arg_274_1.text_.text = var_277_54

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_55 = 39
				local var_277_56 = utf8.len(var_277_54)
				local var_277_57 = var_277_55 <= 0 and var_277_51 or var_277_51 * (var_277_56 / var_277_55)

				if var_277_57 > 0 and var_277_51 < var_277_57 then
					arg_274_1.talkMaxDuration = var_277_57
					var_277_50 = var_277_50 + 0.3

					if var_277_57 + var_277_50 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_57 + var_277_50
					end
				end

				arg_274_1.text_.text = var_277_54
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_58 = var_277_50 + 0.3
			local var_277_59 = math.max(var_277_51, arg_274_1.talkMaxDuration)

			if var_277_58 <= arg_274_1.time_ and arg_274_1.time_ < var_277_58 + var_277_59 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_58) / var_277_59

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_58 + var_277_59 and arg_274_1.time_ < var_277_58 + var_277_59 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play1106101069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1106101069
		arg_280_1.duration_ = 5.52

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play1106101070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = manager.ui.mainCamera.transform
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				local var_283_2 = arg_280_1.var_.effect564
				local var_283_3
				local var_283_4 = var_283_0

				if not var_283_2 then
					var_283_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heimu_keep"), var_283_4)
					var_283_2.name = "564"
					arg_280_1.var_.effect564 = var_283_2
				else
					var_283_2.transform:SetParent(var_283_4)
				end

				var_283_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_283_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_283_5 = 0

			if var_283_5 < arg_280_1.time_ and arg_280_1.time_ <= var_283_5 + arg_283_0 then
				arg_280_1.allBtn_.enabled = false
			end

			local var_283_6 = 2.36666666666667

			if arg_280_1.time_ >= var_283_5 + var_283_6 and arg_280_1.time_ < var_283_5 + var_283_6 + arg_283_0 then
				arg_280_1.allBtn_.enabled = true
			end

			local var_283_7 = 0.833333333333333
			local var_283_8 = 1

			if var_283_7 < arg_280_1.time_ and arg_280_1.time_ <= var_283_7 + arg_283_0 then
				local var_283_9 = "play"
				local var_283_10 = "music"

				arg_280_1:AudioAction(var_283_9, var_283_10, "se_story_side_1093", "se_story_1093_message_get", "")

				local var_283_11 = ""
				local var_283_12 = manager.audio:GetAudioName("se_story_side_1093", "se_story_1093_message_get")

				if var_283_12 ~= "" then
					if arg_280_1.bgmTxt_.text ~= var_283_12 and arg_280_1.bgmTxt_.text ~= "" then
						if arg_280_1.bgmTxt2_.text ~= "" then
							arg_280_1.bgmTxt_.text = arg_280_1.bgmTxt2_.text
						end

						arg_280_1.bgmTxt2_.text = var_283_12

						arg_280_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_280_1.bgmTxt_.text = var_283_12
						arg_280_1.bgmTxt2_.text = var_283_12
					end

					if arg_280_1.bgmTimer then
						arg_280_1.bgmTimer:Stop()

						arg_280_1.bgmTimer = nil
					end

					if arg_280_1.settingData.show_music_name == 1 then
						arg_280_1.musicController:SetSelectedState("show")
						arg_280_1.musicAnimator_:Play("open", 0, 0)

						if arg_280_1.settingData.music_time ~= 0 then
							arg_280_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_280_1.settingData.music_time), function()
								if arg_280_1 == nil or isNil(arg_280_1.bgmTxt_) then
									return
								end

								arg_280_1.musicController:SetSelectedState("hide")
								arg_280_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_283_13 = 0.525
			local var_283_14 = 0.475

			if var_283_13 < arg_280_1.time_ and arg_280_1.time_ <= var_283_13 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_15 = arg_280_1:GetWordFromCfg(1106101069)
				local var_283_16 = arg_280_1:FormatText(var_283_15.content)

				arg_280_1.text_.text = var_283_16

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_17 = 19
				local var_283_18 = utf8.len(var_283_16)
				local var_283_19 = var_283_17 <= 0 and var_283_14 or var_283_14 * (var_283_18 / var_283_17)

				if var_283_19 > 0 and var_283_14 < var_283_19 then
					arg_280_1.talkMaxDuration = var_283_19

					if var_283_19 + var_283_13 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_19 + var_283_13
					end
				end

				arg_280_1.text_.text = var_283_16
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_20 = math.max(var_283_14, arg_280_1.talkMaxDuration)

			if var_283_13 <= arg_280_1.time_ and arg_280_1.time_ < var_283_13 + var_283_20 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_13) / var_283_20

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_13 + var_283_20 and arg_280_1.time_ < var_283_13 + var_283_20 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play1106101070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1106101070
		arg_285_1.duration_ = 3.7

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1106101071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["1061ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1061ui_story == nil then
				arg_285_1.var_.characterEffect1061ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect1061ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect1061ui_story then
				arg_285_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_288_4 = 0
			local var_288_5 = 0.3

			if var_288_4 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_6 = arg_285_1:FormatText(StoryNameCfg[612].name)

				arg_285_1.leftNameTxt_.text = var_288_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061")

				arg_285_1.callingController_:SetSelectedState("calling")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_7 = arg_285_1:GetWordFromCfg(1106101070)
				local var_288_8 = arg_285_1:FormatText(var_288_7.content)

				arg_285_1.text_.text = var_288_8

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 12
				local var_288_10 = utf8.len(var_288_8)
				local var_288_11 = var_288_9 <= 0 and var_288_5 or var_288_5 * (var_288_10 / var_288_9)

				if var_288_11 > 0 and var_288_5 < var_288_11 then
					arg_285_1.talkMaxDuration = var_288_11

					if var_288_11 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_8
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101070", "story_v_side_new_1106101.awb") ~= 0 then
					local var_288_12 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101070", "story_v_side_new_1106101.awb") / 1000

					if var_288_12 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_12 + var_288_4
					end

					if var_288_7.prefab_name ~= "" and arg_285_1.actors_[var_288_7.prefab_name] ~= nil then
						local var_288_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_7.prefab_name].transform, "story_v_side_new_1106101", "1106101070", "story_v_side_new_1106101.awb")

						arg_285_1:RecordAudio("1106101070", var_288_13)
						arg_285_1:RecordAudio("1106101070", var_288_13)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101070", "story_v_side_new_1106101.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101070", "story_v_side_new_1106101.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_14 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_14 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_14

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_14 and arg_285_1.time_ < var_288_4 + var_288_14 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play1106101071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1106101071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1106101072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1061ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1061ui_story == nil then
				arg_289_1.var_.characterEffect1061ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect1061ui_story and not isNil(var_292_0) then
					local var_292_4 = Mathf.Lerp(0, 0.5, var_292_3)

					arg_289_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1061ui_story.fillRatio = var_292_4
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect1061ui_story then
				local var_292_5 = 0.5

				arg_289_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1061ui_story.fillRatio = var_292_5
			end

			local var_292_6 = 0
			local var_292_7 = 0.05

			if var_292_6 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_8 = arg_289_1:FormatText(StoryNameCfg[7].name)

				arg_289_1.leftNameTxt_.text = var_292_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_9 = arg_289_1:GetWordFromCfg(1106101071)
				local var_292_10 = arg_289_1:FormatText(var_292_9.content)

				arg_289_1.text_.text = var_292_10

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 2
				local var_292_12 = utf8.len(var_292_10)
				local var_292_13 = var_292_11 <= 0 and var_292_7 or var_292_7 * (var_292_12 / var_292_11)

				if var_292_13 > 0 and var_292_7 < var_292_13 then
					arg_289_1.talkMaxDuration = var_292_13

					if var_292_13 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_13 + var_292_6
					end
				end

				arg_289_1.text_.text = var_292_10
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_14 = math.max(var_292_7, arg_289_1.talkMaxDuration)

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_14 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_6) / var_292_14

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_6 + var_292_14 and arg_289_1.time_ < var_292_6 + var_292_14 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1106101072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1106101072
		arg_293_1.duration_ = 3.37

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1106101073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1061ui_story"]
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1061ui_story == nil then
				arg_293_1.var_.characterEffect1061ui_story = var_296_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 and not isNil(var_296_0) then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2

				if arg_293_1.var_.characterEffect1061ui_story and not isNil(var_296_0) then
					arg_293_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 and not isNil(var_296_0) and arg_293_1.var_.characterEffect1061ui_story then
				arg_293_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_296_4 = 0
			local var_296_5 = 0.3

			if var_296_4 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_6 = arg_293_1:FormatText(StoryNameCfg[612].name)

				arg_293_1.leftNameTxt_.text = var_296_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061")

				arg_293_1.callingController_:SetSelectedState("calling")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_7 = arg_293_1:GetWordFromCfg(1106101072)
				local var_296_8 = arg_293_1:FormatText(var_296_7.content)

				arg_293_1.text_.text = var_296_8

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_9 = 12
				local var_296_10 = utf8.len(var_296_8)
				local var_296_11 = var_296_9 <= 0 and var_296_5 or var_296_5 * (var_296_10 / var_296_9)

				if var_296_11 > 0 and var_296_5 < var_296_11 then
					arg_293_1.talkMaxDuration = var_296_11

					if var_296_11 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_8
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101072", "story_v_side_new_1106101.awb") ~= 0 then
					local var_296_12 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101072", "story_v_side_new_1106101.awb") / 1000

					if var_296_12 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_12 + var_296_4
					end

					if var_296_7.prefab_name ~= "" and arg_293_1.actors_[var_296_7.prefab_name] ~= nil then
						local var_296_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_7.prefab_name].transform, "story_v_side_new_1106101", "1106101072", "story_v_side_new_1106101.awb")

						arg_293_1:RecordAudio("1106101072", var_296_13)
						arg_293_1:RecordAudio("1106101072", var_296_13)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101072", "story_v_side_new_1106101.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101072", "story_v_side_new_1106101.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_14 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_14 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_14

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_14 and arg_293_1.time_ < var_296_4 + var_296_14 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1106101073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1106101073
		arg_297_1.duration_ = 1

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"

			SetActive(arg_297_1.choicesGo_, true)

			for iter_298_0, iter_298_1 in ipairs(arg_297_1.choices_) do
				local var_298_0 = iter_298_0 <= 2

				SetActive(iter_298_1.go, var_298_0)
			end

			arg_297_1.choices_[1].txt.text = arg_297_1:FormatText(StoryChoiceCfg[1384].name)
			arg_297_1.choices_[2].txt.text = arg_297_1:FormatText(StoryChoiceCfg[1385].name)
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1106101074(arg_297_1)
			end

			if arg_299_0 == 2 then
				arg_297_0:Play1106101074(arg_297_1)
			end

			arg_297_1:RecordChoiceLog(1106101073, 1384, 1385)
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.allBtn_.enabled = false
			end

			local var_300_1 = 0.6

			if arg_297_1.time_ >= var_300_0 + var_300_1 and arg_297_1.time_ < var_300_0 + var_300_1 + arg_300_0 then
				arg_297_1.allBtn_.enabled = true
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1106101074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1106101074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1106101075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.5

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[7].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:GetWordFromCfg(1106101074)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 20
				local var_304_6 = utf8.len(var_304_4)
				local var_304_7 = var_304_5 <= 0 and var_304_1 or var_304_1 * (var_304_6 / var_304_5)

				if var_304_7 > 0 and var_304_1 < var_304_7 then
					arg_301_1.talkMaxDuration = var_304_7

					if var_304_7 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_7 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_4
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_8 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_8 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_8

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_8 and arg_301_1.time_ < var_304_0 + var_304_8 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1106101075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1106101075
		arg_305_1.duration_ = 4.37

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1106101076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1061ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1061ui_story == nil then
				arg_305_1.var_.characterEffect1061ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1061ui_story and not isNil(var_308_0) then
					arg_305_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1061ui_story then
				arg_305_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_308_4 = 0
			local var_308_5 = 0.425

			if var_308_4 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_6 = arg_305_1:FormatText(StoryNameCfg[612].name)

				arg_305_1.leftNameTxt_.text = var_308_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061")

				arg_305_1.callingController_:SetSelectedState("calling")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_7 = arg_305_1:GetWordFromCfg(1106101075)
				local var_308_8 = arg_305_1:FormatText(var_308_7.content)

				arg_305_1.text_.text = var_308_8

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 17
				local var_308_10 = utf8.len(var_308_8)
				local var_308_11 = var_308_9 <= 0 and var_308_5 or var_308_5 * (var_308_10 / var_308_9)

				if var_308_11 > 0 and var_308_5 < var_308_11 then
					arg_305_1.talkMaxDuration = var_308_11

					if var_308_11 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_11 + var_308_4
					end
				end

				arg_305_1.text_.text = var_308_8
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101075", "story_v_side_new_1106101.awb") ~= 0 then
					local var_308_12 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101075", "story_v_side_new_1106101.awb") / 1000

					if var_308_12 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_12 + var_308_4
					end

					if var_308_7.prefab_name ~= "" and arg_305_1.actors_[var_308_7.prefab_name] ~= nil then
						local var_308_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_7.prefab_name].transform, "story_v_side_new_1106101", "1106101075", "story_v_side_new_1106101.awb")

						arg_305_1:RecordAudio("1106101075", var_308_13)
						arg_305_1:RecordAudio("1106101075", var_308_13)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101075", "story_v_side_new_1106101.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101075", "story_v_side_new_1106101.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_14 = math.max(var_308_5, arg_305_1.talkMaxDuration)

			if var_308_4 <= arg_305_1.time_ and arg_305_1.time_ < var_308_4 + var_308_14 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_4) / var_308_14

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_4 + var_308_14 and arg_305_1.time_ < var_308_4 + var_308_14 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1106101076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1106101076
		arg_309_1.duration_ = 9

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1106101077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = "STblack"

			if arg_309_1.bgs_[var_312_0] == nil then
				local var_312_1 = Object.Instantiate(arg_309_1.paintGo_)

				var_312_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_312_0)
				var_312_1.name = var_312_0
				var_312_1.transform.parent = arg_309_1.stage_.transform
				var_312_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_309_1.bgs_[var_312_0] = var_312_1
			end

			local var_312_2 = 2

			if var_312_2 < arg_309_1.time_ and arg_309_1.time_ <= var_312_2 + arg_312_0 then
				local var_312_3 = manager.ui.mainCamera.transform.localPosition
				local var_312_4 = Vector3.New(0, 0, 10) + Vector3.New(var_312_3.x, var_312_3.y, 0)
				local var_312_5 = arg_309_1.bgs_.STblack

				var_312_5.transform.localPosition = var_312_4
				var_312_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_312_6 = var_312_5:GetComponent("SpriteRenderer")

				if var_312_6 and var_312_6.sprite then
					local var_312_7 = (var_312_5.transform.localPosition - var_312_3).z
					local var_312_8 = manager.ui.mainCameraCom_
					local var_312_9 = 2 * var_312_7 * Mathf.Tan(var_312_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_312_10 = var_312_9 * var_312_8.aspect
					local var_312_11 = var_312_6.sprite.bounds.size.x
					local var_312_12 = var_312_6.sprite.bounds.size.y
					local var_312_13 = var_312_10 / var_312_11
					local var_312_14 = var_312_9 / var_312_12
					local var_312_15 = var_312_14 < var_312_13 and var_312_13 or var_312_14

					var_312_5.transform.localScale = Vector3.New(var_312_15, var_312_15, 0)
				end

				for iter_312_0, iter_312_1 in pairs(arg_309_1.bgs_) do
					if iter_312_0 ~= "STblack" then
						iter_312_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_312_16 = 4

			if var_312_16 < arg_309_1.time_ and arg_309_1.time_ <= var_312_16 + arg_312_0 then
				arg_309_1.allBtn_.enabled = false
			end

			local var_312_17 = 0.3

			if arg_309_1.time_ >= var_312_16 + var_312_17 and arg_309_1.time_ < var_312_16 + var_312_17 + arg_312_0 then
				arg_309_1.allBtn_.enabled = true
			end

			local var_312_18 = 0

			if var_312_18 < arg_309_1.time_ and arg_309_1.time_ <= var_312_18 + arg_312_0 then
				arg_309_1.mask_.enabled = true
				arg_309_1.mask_.raycastTarget = true

				arg_309_1:SetGaussion(false)
			end

			local var_312_19 = 2

			if var_312_18 <= arg_309_1.time_ and arg_309_1.time_ < var_312_18 + var_312_19 then
				local var_312_20 = (arg_309_1.time_ - var_312_18) / var_312_19
				local var_312_21 = Color.New(0, 0, 0)

				var_312_21.a = Mathf.Lerp(0, 1, var_312_20)
				arg_309_1.mask_.color = var_312_21
			end

			if arg_309_1.time_ >= var_312_18 + var_312_19 and arg_309_1.time_ < var_312_18 + var_312_19 + arg_312_0 then
				local var_312_22 = Color.New(0, 0, 0)

				var_312_22.a = 1
				arg_309_1.mask_.color = var_312_22
			end

			local var_312_23 = 2

			if var_312_23 < arg_309_1.time_ and arg_309_1.time_ <= var_312_23 + arg_312_0 then
				arg_309_1.mask_.enabled = true
				arg_309_1.mask_.raycastTarget = true

				arg_309_1:SetGaussion(false)
			end

			local var_312_24 = 2

			if var_312_23 <= arg_309_1.time_ and arg_309_1.time_ < var_312_23 + var_312_24 then
				local var_312_25 = (arg_309_1.time_ - var_312_23) / var_312_24
				local var_312_26 = Color.New(0, 0, 0)

				var_312_26.a = Mathf.Lerp(1, 0, var_312_25)
				arg_309_1.mask_.color = var_312_26
			end

			if arg_309_1.time_ >= var_312_23 + var_312_24 and arg_309_1.time_ < var_312_23 + var_312_24 + arg_312_0 then
				local var_312_27 = Color.New(0, 0, 0)
				local var_312_28 = 0

				arg_309_1.mask_.enabled = false
				var_312_27.a = var_312_28
				arg_309_1.mask_.color = var_312_27
			end

			local var_312_29 = manager.ui.mainCamera.transform
			local var_312_30 = 2

			if var_312_30 < arg_309_1.time_ and arg_309_1.time_ <= var_312_30 + arg_312_0 then
				local var_312_31 = arg_309_1.var_.effect564

				if var_312_31 then
					Object.Destroy(var_312_31)

					arg_309_1.var_.effect564 = nil
				end
			end

			local var_312_32 = 0
			local var_312_33 = 0.433333333333333

			if var_312_32 < arg_309_1.time_ and arg_309_1.time_ <= var_312_32 + arg_312_0 then
				local var_312_34 = "play"
				local var_312_35 = "music"

				arg_309_1:AudioAction(var_312_34, var_312_35, "ui_battle", "ui_battle_stopbgm", "")

				local var_312_36 = ""
				local var_312_37 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_312_37 ~= "" then
					if arg_309_1.bgmTxt_.text ~= var_312_37 and arg_309_1.bgmTxt_.text ~= "" then
						if arg_309_1.bgmTxt2_.text ~= "" then
							arg_309_1.bgmTxt_.text = arg_309_1.bgmTxt2_.text
						end

						arg_309_1.bgmTxt2_.text = var_312_37

						arg_309_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_309_1.bgmTxt_.text = var_312_37
						arg_309_1.bgmTxt2_.text = var_312_37
					end

					if arg_309_1.bgmTimer then
						arg_309_1.bgmTimer:Stop()

						arg_309_1.bgmTimer = nil
					end

					if arg_309_1.settingData.show_music_name == 1 then
						arg_309_1.musicController:SetSelectedState("show")
						arg_309_1.musicAnimator_:Play("open", 0, 0)

						if arg_309_1.settingData.music_time ~= 0 then
							arg_309_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_309_1.settingData.music_time), function()
								if arg_309_1 == nil or isNil(arg_309_1.bgmTxt_) then
									return
								end

								arg_309_1.musicController:SetSelectedState("hide")
								arg_309_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_309_1.frameCnt_ <= 1 then
				arg_309_1.dialog_:SetActive(false)
			end

			local var_312_38 = 4
			local var_312_39 = 0.8

			if var_312_38 < arg_309_1.time_ and arg_309_1.time_ <= var_312_38 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0

				arg_309_1.dialog_:SetActive(true)

				arg_309_1.dialogCg_.alpha = 0

				local var_312_40 = LeanTween.value(arg_309_1.dialog_, 0, 1, 0.3)

				var_312_40:setOnUpdate(LuaHelper.FloatAction(function(arg_314_0)
					arg_309_1.dialogCg_.alpha = arg_314_0
				end))
				var_312_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_309_1.dialog_)
					var_312_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_309_1.duration_ = arg_309_1.duration_ + 0.3

				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_41 = arg_309_1:GetWordFromCfg(1106101076)
				local var_312_42 = arg_309_1:FormatText(var_312_41.content)

				arg_309_1.text_.text = var_312_42

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_43 = 32
				local var_312_44 = utf8.len(var_312_42)
				local var_312_45 = var_312_43 <= 0 and var_312_39 or var_312_39 * (var_312_44 / var_312_43)

				if var_312_45 > 0 and var_312_39 < var_312_45 then
					arg_309_1.talkMaxDuration = var_312_45
					var_312_38 = var_312_38 + 0.3

					if var_312_45 + var_312_38 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_45 + var_312_38
					end
				end

				arg_309_1.text_.text = var_312_42
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_46 = var_312_38 + 0.3
			local var_312_47 = math.max(var_312_39, arg_309_1.talkMaxDuration)

			if var_312_46 <= arg_309_1.time_ and arg_309_1.time_ < var_312_46 + var_312_47 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_46) / var_312_47

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_46 + var_312_47 and arg_309_1.time_ < var_312_46 + var_312_47 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1106101077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1106101077
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1106101078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.35

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_2 = arg_316_1:GetWordFromCfg(1106101077)
				local var_319_3 = arg_316_1:FormatText(var_319_2.content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 14
				local var_319_5 = utf8.len(var_319_3)
				local var_319_6 = var_319_4 <= 0 and var_319_1 or var_319_1 * (var_319_5 / var_319_4)

				if var_319_6 > 0 and var_319_1 < var_319_6 then
					arg_316_1.talkMaxDuration = var_319_6

					if var_319_6 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_6 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_3
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_7 and arg_316_1.time_ < var_319_0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play1106101078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1106101078
		arg_320_1.duration_ = 7

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play1106101079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = "ST31"

			if arg_320_1.bgs_[var_323_0] == nil then
				local var_323_1 = Object.Instantiate(arg_320_1.paintGo_)

				var_323_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_323_0)
				var_323_1.name = var_323_0
				var_323_1.transform.parent = arg_320_1.stage_.transform
				var_323_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_320_1.bgs_[var_323_0] = var_323_1
			end

			local var_323_2 = 0

			if var_323_2 < arg_320_1.time_ and arg_320_1.time_ <= var_323_2 + arg_323_0 then
				local var_323_3 = manager.ui.mainCamera.transform.localPosition
				local var_323_4 = Vector3.New(0, 0, 10) + Vector3.New(var_323_3.x, var_323_3.y, 0)
				local var_323_5 = arg_320_1.bgs_.ST31

				var_323_5.transform.localPosition = var_323_4
				var_323_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_323_6 = var_323_5:GetComponent("SpriteRenderer")

				if var_323_6 and var_323_6.sprite then
					local var_323_7 = (var_323_5.transform.localPosition - var_323_3).z
					local var_323_8 = manager.ui.mainCameraCom_
					local var_323_9 = 2 * var_323_7 * Mathf.Tan(var_323_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_323_10 = var_323_9 * var_323_8.aspect
					local var_323_11 = var_323_6.sprite.bounds.size.x
					local var_323_12 = var_323_6.sprite.bounds.size.y
					local var_323_13 = var_323_10 / var_323_11
					local var_323_14 = var_323_9 / var_323_12
					local var_323_15 = var_323_14 < var_323_13 and var_323_13 or var_323_14

					var_323_5.transform.localScale = Vector3.New(var_323_15, var_323_15, 0)
				end

				for iter_323_0, iter_323_1 in pairs(arg_320_1.bgs_) do
					if iter_323_0 ~= "ST31" then
						iter_323_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_323_16 = 2

			if var_323_16 < arg_320_1.time_ and arg_320_1.time_ <= var_323_16 + arg_323_0 then
				arg_320_1.allBtn_.enabled = false
			end

			local var_323_17 = 0.3

			if arg_320_1.time_ >= var_323_16 + var_323_17 and arg_320_1.time_ < var_323_16 + var_323_17 + arg_323_0 then
				arg_320_1.allBtn_.enabled = true
			end

			local var_323_18 = 0

			if var_323_18 < arg_320_1.time_ and arg_320_1.time_ <= var_323_18 + arg_323_0 then
				arg_320_1.mask_.enabled = true
				arg_320_1.mask_.raycastTarget = true

				arg_320_1:SetGaussion(false)
			end

			local var_323_19 = 2

			if var_323_18 <= arg_320_1.time_ and arg_320_1.time_ < var_323_18 + var_323_19 then
				local var_323_20 = (arg_320_1.time_ - var_323_18) / var_323_19
				local var_323_21 = Color.New(0, 0, 0)

				var_323_21.a = Mathf.Lerp(1, 0, var_323_20)
				arg_320_1.mask_.color = var_323_21
			end

			if arg_320_1.time_ >= var_323_18 + var_323_19 and arg_320_1.time_ < var_323_18 + var_323_19 + arg_323_0 then
				local var_323_22 = Color.New(0, 0, 0)
				local var_323_23 = 0

				arg_320_1.mask_.enabled = false
				var_323_22.a = var_323_23
				arg_320_1.mask_.color = var_323_22
			end

			local var_323_24 = 0.566666666666667
			local var_323_25 = 1

			if var_323_24 < arg_320_1.time_ and arg_320_1.time_ <= var_323_24 + arg_323_0 then
				local var_323_26 = "play"
				local var_323_27 = "effect"

				arg_320_1:AudioAction(var_323_26, var_323_27, "se_story_side_1061", "se_story_side_1061_amb_city_street", "")
			end

			local var_323_28 = 0
			local var_323_29 = 0.433333333333333

			if var_323_28 < arg_320_1.time_ and arg_320_1.time_ <= var_323_28 + arg_323_0 then
				local var_323_30 = "play"
				local var_323_31 = "music"

				arg_320_1:AudioAction(var_323_30, var_323_31, "ui_battle", "ui_battle_stopbgm", "")

				local var_323_32 = ""
				local var_323_33 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_323_33 ~= "" then
					if arg_320_1.bgmTxt_.text ~= var_323_33 and arg_320_1.bgmTxt_.text ~= "" then
						if arg_320_1.bgmTxt2_.text ~= "" then
							arg_320_1.bgmTxt_.text = arg_320_1.bgmTxt2_.text
						end

						arg_320_1.bgmTxt2_.text = var_323_33

						arg_320_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_320_1.bgmTxt_.text = var_323_33
						arg_320_1.bgmTxt2_.text = var_323_33
					end

					if arg_320_1.bgmTimer then
						arg_320_1.bgmTimer:Stop()

						arg_320_1.bgmTimer = nil
					end

					if arg_320_1.settingData.show_music_name == 1 then
						arg_320_1.musicController:SetSelectedState("show")
						arg_320_1.musicAnimator_:Play("open", 0, 0)

						if arg_320_1.settingData.music_time ~= 0 then
							arg_320_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_320_1.settingData.music_time), function()
								if arg_320_1 == nil or isNil(arg_320_1.bgmTxt_) then
									return
								end

								arg_320_1.musicController:SetSelectedState("hide")
								arg_320_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_323_34 = 0.566666666666667
			local var_323_35 = 1

			if var_323_34 < arg_320_1.time_ and arg_320_1.time_ <= var_323_34 + arg_323_0 then
				local var_323_36 = "play"
				local var_323_37 = "music"

				arg_320_1:AudioAction(var_323_36, var_323_37, "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_323_38 = ""
				local var_323_39 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if var_323_39 ~= "" then
					if arg_320_1.bgmTxt_.text ~= var_323_39 and arg_320_1.bgmTxt_.text ~= "" then
						if arg_320_1.bgmTxt2_.text ~= "" then
							arg_320_1.bgmTxt_.text = arg_320_1.bgmTxt2_.text
						end

						arg_320_1.bgmTxt2_.text = var_323_39

						arg_320_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_320_1.bgmTxt_.text = var_323_39
						arg_320_1.bgmTxt2_.text = var_323_39
					end

					if arg_320_1.bgmTimer then
						arg_320_1.bgmTimer:Stop()

						arg_320_1.bgmTimer = nil
					end

					if arg_320_1.settingData.show_music_name == 1 then
						arg_320_1.musicController:SetSelectedState("show")
						arg_320_1.musicAnimator_:Play("open", 0, 0)

						if arg_320_1.settingData.music_time ~= 0 then
							arg_320_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_320_1.settingData.music_time), function()
								if arg_320_1 == nil or isNil(arg_320_1.bgmTxt_) then
									return
								end

								arg_320_1.musicController:SetSelectedState("hide")
								arg_320_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_323_40 = 0.0666666666666667
			local var_323_41 = 1

			if var_323_40 < arg_320_1.time_ and arg_320_1.time_ <= var_323_40 + arg_323_0 then
				local var_323_42 = "stop"
				local var_323_43 = "effect"

				arg_320_1:AudioAction(var_323_42, var_323_43, "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_320_1.frameCnt_ <= 1 then
				arg_320_1.dialog_:SetActive(false)
			end

			local var_323_44 = 2
			local var_323_45 = 0.1

			if var_323_44 < arg_320_1.time_ and arg_320_1.time_ <= var_323_44 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0

				arg_320_1.dialog_:SetActive(true)

				arg_320_1.dialogCg_.alpha = 0

				local var_323_46 = LeanTween.value(arg_320_1.dialog_, 0, 1, 0.3)

				var_323_46:setOnUpdate(LuaHelper.FloatAction(function(arg_326_0)
					arg_320_1.dialogCg_.alpha = arg_326_0
				end))
				var_323_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_320_1.dialog_)
					var_323_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_320_1.duration_ = arg_320_1.duration_ + 0.3

				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_47 = arg_320_1:FormatText(StoryNameCfg[7].name)

				arg_320_1.leftNameTxt_.text = var_323_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_48 = arg_320_1:GetWordFromCfg(1106101078)
				local var_323_49 = arg_320_1:FormatText(var_323_48.content)

				arg_320_1.text_.text = var_323_49

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_50 = 4
				local var_323_51 = utf8.len(var_323_49)
				local var_323_52 = var_323_50 <= 0 and var_323_45 or var_323_45 * (var_323_51 / var_323_50)

				if var_323_52 > 0 and var_323_45 < var_323_52 then
					arg_320_1.talkMaxDuration = var_323_52
					var_323_44 = var_323_44 + 0.3

					if var_323_52 + var_323_44 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_52 + var_323_44
					end
				end

				arg_320_1.text_.text = var_323_49
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_53 = var_323_44 + 0.3
			local var_323_54 = math.max(var_323_45, arg_320_1.talkMaxDuration)

			if var_323_53 <= arg_320_1.time_ and arg_320_1.time_ < var_323_53 + var_323_54 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_53) / var_323_54

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_53 + var_323_54 and arg_320_1.time_ < var_323_53 + var_323_54 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play1106101079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1106101079
		arg_328_1.duration_ = 1.13

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1106101080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["1061ui_story"].transform
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 then
				arg_328_1.var_.moveOldPos1061ui_story = var_331_0.localPosition
			end

			local var_331_2 = 0.001

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2
				local var_331_4 = Vector3.New(0, -1.18, -6.15)

				var_331_0.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1061ui_story, var_331_4, var_331_3)

				local var_331_5 = manager.ui.mainCamera.transform.position - var_331_0.position

				var_331_0.forward = Vector3.New(var_331_5.x, var_331_5.y, var_331_5.z)

				local var_331_6 = var_331_0.localEulerAngles

				var_331_6.z = 0
				var_331_6.x = 0
				var_331_0.localEulerAngles = var_331_6
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 then
				var_331_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_331_7 = manager.ui.mainCamera.transform.position - var_331_0.position

				var_331_0.forward = Vector3.New(var_331_7.x, var_331_7.y, var_331_7.z)

				local var_331_8 = var_331_0.localEulerAngles

				var_331_8.z = 0
				var_331_8.x = 0
				var_331_0.localEulerAngles = var_331_8
			end

			local var_331_9 = arg_328_1.actors_["1061ui_story"]
			local var_331_10 = 0

			if var_331_10 < arg_328_1.time_ and arg_328_1.time_ <= var_331_10 + arg_331_0 and not isNil(var_331_9) and arg_328_1.var_.characterEffect1061ui_story == nil then
				arg_328_1.var_.characterEffect1061ui_story = var_331_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_11 = 0.200000002980232

			if var_331_10 <= arg_328_1.time_ and arg_328_1.time_ < var_331_10 + var_331_11 and not isNil(var_331_9) then
				local var_331_12 = (arg_328_1.time_ - var_331_10) / var_331_11

				if arg_328_1.var_.characterEffect1061ui_story and not isNil(var_331_9) then
					arg_328_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_10 + var_331_11 and arg_328_1.time_ < var_331_10 + var_331_11 + arg_331_0 and not isNil(var_331_9) and arg_328_1.var_.characterEffect1061ui_story then
				arg_328_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_331_13 = 0

			if var_331_13 < arg_328_1.time_ and arg_328_1.time_ <= var_331_13 + arg_331_0 then
				arg_328_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_331_14 = 0

			if var_331_14 < arg_328_1.time_ and arg_328_1.time_ <= var_331_14 + arg_331_0 then
				arg_328_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_331_15 = 0
			local var_331_16 = 0.1

			if var_331_15 < arg_328_1.time_ and arg_328_1.time_ <= var_331_15 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_17 = arg_328_1:FormatText(StoryNameCfg[612].name)

				arg_328_1.leftNameTxt_.text = var_331_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_18 = arg_328_1:GetWordFromCfg(1106101079)
				local var_331_19 = arg_328_1:FormatText(var_331_18.content)

				arg_328_1.text_.text = var_331_19

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_20 = 4
				local var_331_21 = utf8.len(var_331_19)
				local var_331_22 = var_331_20 <= 0 and var_331_16 or var_331_16 * (var_331_21 / var_331_20)

				if var_331_22 > 0 and var_331_16 < var_331_22 then
					arg_328_1.talkMaxDuration = var_331_22

					if var_331_22 + var_331_15 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_22 + var_331_15
					end
				end

				arg_328_1.text_.text = var_331_19
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101079", "story_v_side_new_1106101.awb") ~= 0 then
					local var_331_23 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101079", "story_v_side_new_1106101.awb") / 1000

					if var_331_23 + var_331_15 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_23 + var_331_15
					end

					if var_331_18.prefab_name ~= "" and arg_328_1.actors_[var_331_18.prefab_name] ~= nil then
						local var_331_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_18.prefab_name].transform, "story_v_side_new_1106101", "1106101079", "story_v_side_new_1106101.awb")

						arg_328_1:RecordAudio("1106101079", var_331_24)
						arg_328_1:RecordAudio("1106101079", var_331_24)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101079", "story_v_side_new_1106101.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101079", "story_v_side_new_1106101.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_25 = math.max(var_331_16, arg_328_1.talkMaxDuration)

			if var_331_15 <= arg_328_1.time_ and arg_328_1.time_ < var_331_15 + var_331_25 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_15) / var_331_25

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_15 + var_331_25 and arg_328_1.time_ < var_331_15 + var_331_25 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play1106101080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1106101080
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1106101081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1061ui_story"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1061ui_story == nil then
				arg_332_1.var_.characterEffect1061ui_story = var_335_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.characterEffect1061ui_story and not isNil(var_335_0) then
					local var_335_4 = Mathf.Lerp(0, 0.5, var_335_3)

					arg_332_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1061ui_story.fillRatio = var_335_4
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1061ui_story then
				local var_335_5 = 0.5

				arg_332_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1061ui_story.fillRatio = var_335_5
			end

			local var_335_6 = 0
			local var_335_7 = 0.1

			if var_335_6 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_8 = arg_332_1:FormatText(StoryNameCfg[7].name)

				arg_332_1.leftNameTxt_.text = var_335_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_9 = arg_332_1:GetWordFromCfg(1106101080)
				local var_335_10 = arg_332_1:FormatText(var_335_9.content)

				arg_332_1.text_.text = var_335_10

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_11 = 4
				local var_335_12 = utf8.len(var_335_10)
				local var_335_13 = var_335_11 <= 0 and var_335_7 or var_335_7 * (var_335_12 / var_335_11)

				if var_335_13 > 0 and var_335_7 < var_335_13 then
					arg_332_1.talkMaxDuration = var_335_13

					if var_335_13 + var_335_6 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_13 + var_335_6
					end
				end

				arg_332_1.text_.text = var_335_10
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_14 = math.max(var_335_7, arg_332_1.talkMaxDuration)

			if var_335_6 <= arg_332_1.time_ and arg_332_1.time_ < var_335_6 + var_335_14 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_6) / var_335_14

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_6 + var_335_14 and arg_332_1.time_ < var_335_6 + var_335_14 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play1106101081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1106101081
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1106101082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1061ui_story"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1061ui_story == nil then
				arg_336_1.var_.characterEffect1061ui_story = var_339_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.characterEffect1061ui_story and not isNil(var_339_0) then
					arg_336_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect1061ui_story then
				arg_336_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_339_4 = 0

			if var_339_4 < arg_336_1.time_ and arg_336_1.time_ <= var_339_4 + arg_339_0 then
				arg_336_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_339_5 = 0

			if var_339_5 < arg_336_1.time_ and arg_336_1.time_ <= var_339_5 + arg_339_0 then
				arg_336_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_339_6 = 0
			local var_339_7 = 0.0329999998211861

			if var_339_6 < arg_336_1.time_ and arg_336_1.time_ <= var_339_6 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_8 = arg_336_1:FormatText(StoryNameCfg[612].name)

				arg_336_1.leftNameTxt_.text = var_339_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_9 = arg_336_1:GetWordFromCfg(1106101081)
				local var_339_10 = arg_336_1:FormatText(var_339_9.content)

				arg_336_1.text_.text = var_339_10

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_11 = 1
				local var_339_12 = utf8.len(var_339_10)
				local var_339_13 = var_339_11 <= 0 and var_339_7 or var_339_7 * (var_339_12 / var_339_11)

				if var_339_13 > 0 and var_339_7 < var_339_13 then
					arg_336_1.talkMaxDuration = var_339_13

					if var_339_13 + var_339_6 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_13 + var_339_6
					end
				end

				arg_336_1.text_.text = var_339_10
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_14 = math.max(var_339_7, arg_336_1.talkMaxDuration)

			if var_339_6 <= arg_336_1.time_ and arg_336_1.time_ < var_339_6 + var_339_14 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_6) / var_339_14

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_6 + var_339_14 and arg_336_1.time_ < var_339_6 + var_339_14 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play1106101082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1106101082
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1106101083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1061ui_story"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect1061ui_story == nil then
				arg_340_1.var_.characterEffect1061ui_story = var_343_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.200000002980232

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.characterEffect1061ui_story and not isNil(var_343_0) then
					local var_343_4 = Mathf.Lerp(0, 0.5, var_343_3)

					arg_340_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1061ui_story.fillRatio = var_343_4
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect1061ui_story then
				local var_343_5 = 0.5

				arg_340_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1061ui_story.fillRatio = var_343_5
			end

			local var_343_6 = 0
			local var_343_7 = 0.725

			if var_343_6 < arg_340_1.time_ and arg_340_1.time_ <= var_343_6 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_8 = arg_340_1:FormatText(StoryNameCfg[7].name)

				arg_340_1.leftNameTxt_.text = var_343_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_9 = arg_340_1:GetWordFromCfg(1106101082)
				local var_343_10 = arg_340_1:FormatText(var_343_9.content)

				arg_340_1.text_.text = var_343_10

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_11 = 29
				local var_343_12 = utf8.len(var_343_10)
				local var_343_13 = var_343_11 <= 0 and var_343_7 or var_343_7 * (var_343_12 / var_343_11)

				if var_343_13 > 0 and var_343_7 < var_343_13 then
					arg_340_1.talkMaxDuration = var_343_13

					if var_343_13 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_13 + var_343_6
					end
				end

				arg_340_1.text_.text = var_343_10
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_14 = math.max(var_343_7, arg_340_1.talkMaxDuration)

			if var_343_6 <= arg_340_1.time_ and arg_340_1.time_ < var_343_6 + var_343_14 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_6) / var_343_14

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_6 + var_343_14 and arg_340_1.time_ < var_343_6 + var_343_14 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1106101083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1106101083
		arg_344_1.duration_ = 2.13

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1106101084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1061ui_story"]
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1061ui_story == nil then
				arg_344_1.var_.characterEffect1061ui_story = var_347_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_2 = 0.200000002980232

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 and not isNil(var_347_0) then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2

				if arg_344_1.var_.characterEffect1061ui_story and not isNil(var_347_0) then
					arg_344_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 and not isNil(var_347_0) and arg_344_1.var_.characterEffect1061ui_story then
				arg_344_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_347_4 = 0

			if var_347_4 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				arg_344_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_347_5 = 0
			local var_347_6 = 0.275

			if var_347_5 < arg_344_1.time_ and arg_344_1.time_ <= var_347_5 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_7 = arg_344_1:FormatText(StoryNameCfg[612].name)

				arg_344_1.leftNameTxt_.text = var_347_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_8 = arg_344_1:GetWordFromCfg(1106101083)
				local var_347_9 = arg_344_1:FormatText(var_347_8.content)

				arg_344_1.text_.text = var_347_9

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_10 = 11
				local var_347_11 = utf8.len(var_347_9)
				local var_347_12 = var_347_10 <= 0 and var_347_6 or var_347_6 * (var_347_11 / var_347_10)

				if var_347_12 > 0 and var_347_6 < var_347_12 then
					arg_344_1.talkMaxDuration = var_347_12

					if var_347_12 + var_347_5 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_12 + var_347_5
					end
				end

				arg_344_1.text_.text = var_347_9
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101083", "story_v_side_new_1106101.awb") ~= 0 then
					local var_347_13 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101083", "story_v_side_new_1106101.awb") / 1000

					if var_347_13 + var_347_5 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_13 + var_347_5
					end

					if var_347_8.prefab_name ~= "" and arg_344_1.actors_[var_347_8.prefab_name] ~= nil then
						local var_347_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_8.prefab_name].transform, "story_v_side_new_1106101", "1106101083", "story_v_side_new_1106101.awb")

						arg_344_1:RecordAudio("1106101083", var_347_14)
						arg_344_1:RecordAudio("1106101083", var_347_14)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101083", "story_v_side_new_1106101.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101083", "story_v_side_new_1106101.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_15 = math.max(var_347_6, arg_344_1.talkMaxDuration)

			if var_347_5 <= arg_344_1.time_ and arg_344_1.time_ < var_347_5 + var_347_15 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_5) / var_347_15

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_5 + var_347_15 and arg_344_1.time_ < var_347_5 + var_347_15 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1106101084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1106101084
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1106101085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1061ui_story"]
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect1061ui_story == nil then
				arg_348_1.var_.characterEffect1061ui_story = var_351_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_2 = 0.200000002980232

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 and not isNil(var_351_0) then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2

				if arg_348_1.var_.characterEffect1061ui_story and not isNil(var_351_0) then
					local var_351_4 = Mathf.Lerp(0, 0.5, var_351_3)

					arg_348_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_348_1.var_.characterEffect1061ui_story.fillRatio = var_351_4
				end
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 and not isNil(var_351_0) and arg_348_1.var_.characterEffect1061ui_story then
				local var_351_5 = 0.5

				arg_348_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_348_1.var_.characterEffect1061ui_story.fillRatio = var_351_5
			end

			local var_351_6 = 0
			local var_351_7 = 0.625

			if var_351_6 < arg_348_1.time_ and arg_348_1.time_ <= var_351_6 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_8 = arg_348_1:FormatText(StoryNameCfg[7].name)

				arg_348_1.leftNameTxt_.text = var_351_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_9 = arg_348_1:GetWordFromCfg(1106101084)
				local var_351_10 = arg_348_1:FormatText(var_351_9.content)

				arg_348_1.text_.text = var_351_10

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_11 = 25
				local var_351_12 = utf8.len(var_351_10)
				local var_351_13 = var_351_11 <= 0 and var_351_7 or var_351_7 * (var_351_12 / var_351_11)

				if var_351_13 > 0 and var_351_7 < var_351_13 then
					arg_348_1.talkMaxDuration = var_351_13

					if var_351_13 + var_351_6 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_13 + var_351_6
					end
				end

				arg_348_1.text_.text = var_351_10
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_14 = math.max(var_351_7, arg_348_1.talkMaxDuration)

			if var_351_6 <= arg_348_1.time_ and arg_348_1.time_ < var_351_6 + var_351_14 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_6) / var_351_14

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_6 + var_351_14 and arg_348_1.time_ < var_351_6 + var_351_14 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1106101085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1106101085
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1106101086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1061ui_story"].transform
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.var_.moveOldPos1061ui_story = var_355_0.localPosition
			end

			local var_355_2 = 0.001

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2
				local var_355_4 = Vector3.New(0, 100, 0)

				var_355_0.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1061ui_story, var_355_4, var_355_3)

				local var_355_5 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_5.x, var_355_5.y, var_355_5.z)

				local var_355_6 = var_355_0.localEulerAngles

				var_355_6.z = 0
				var_355_6.x = 0
				var_355_0.localEulerAngles = var_355_6
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 then
				var_355_0.localPosition = Vector3.New(0, 100, 0)

				local var_355_7 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_7.x, var_355_7.y, var_355_7.z)

				local var_355_8 = var_355_0.localEulerAngles

				var_355_8.z = 0
				var_355_8.x = 0
				var_355_0.localEulerAngles = var_355_8
			end

			local var_355_9 = 0
			local var_355_10 = 0.5

			if var_355_9 < arg_352_1.time_ and arg_352_1.time_ <= var_355_9 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, false)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_11 = arg_352_1:GetWordFromCfg(1106101085)
				local var_355_12 = arg_352_1:FormatText(var_355_11.content)

				arg_352_1.text_.text = var_355_12

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_13 = 20
				local var_355_14 = utf8.len(var_355_12)
				local var_355_15 = var_355_13 <= 0 and var_355_10 or var_355_10 * (var_355_14 / var_355_13)

				if var_355_15 > 0 and var_355_10 < var_355_15 then
					arg_352_1.talkMaxDuration = var_355_15

					if var_355_15 + var_355_9 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_15 + var_355_9
					end
				end

				arg_352_1.text_.text = var_355_12
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_16 = math.max(var_355_10, arg_352_1.talkMaxDuration)

			if var_355_9 <= arg_352_1.time_ and arg_352_1.time_ < var_355_9 + var_355_16 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_9) / var_355_16

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_9 + var_355_16 and arg_352_1.time_ < var_355_9 + var_355_16 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play1106101086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1106101086
		arg_356_1.duration_ = 9

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1106101087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = "ST0103"

			if arg_356_1.bgs_[var_359_0] == nil then
				local var_359_1 = Object.Instantiate(arg_356_1.paintGo_)

				var_359_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_359_0)
				var_359_1.name = var_359_0
				var_359_1.transform.parent = arg_356_1.stage_.transform
				var_359_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_356_1.bgs_[var_359_0] = var_359_1
			end

			local var_359_2 = 2

			if var_359_2 < arg_356_1.time_ and arg_356_1.time_ <= var_359_2 + arg_359_0 then
				local var_359_3 = manager.ui.mainCamera.transform.localPosition
				local var_359_4 = Vector3.New(0, 0, 10) + Vector3.New(var_359_3.x, var_359_3.y, 0)
				local var_359_5 = arg_356_1.bgs_.ST0103

				var_359_5.transform.localPosition = var_359_4
				var_359_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_359_6 = var_359_5:GetComponent("SpriteRenderer")

				if var_359_6 and var_359_6.sprite then
					local var_359_7 = (var_359_5.transform.localPosition - var_359_3).z
					local var_359_8 = manager.ui.mainCameraCom_
					local var_359_9 = 2 * var_359_7 * Mathf.Tan(var_359_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_359_10 = var_359_9 * var_359_8.aspect
					local var_359_11 = var_359_6.sprite.bounds.size.x
					local var_359_12 = var_359_6.sprite.bounds.size.y
					local var_359_13 = var_359_10 / var_359_11
					local var_359_14 = var_359_9 / var_359_12
					local var_359_15 = var_359_14 < var_359_13 and var_359_13 or var_359_14

					var_359_5.transform.localScale = Vector3.New(var_359_15, var_359_15, 0)
				end

				for iter_359_0, iter_359_1 in pairs(arg_356_1.bgs_) do
					if iter_359_0 ~= "ST0103" then
						iter_359_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_359_16 = 3.999999999999

			if var_359_16 < arg_356_1.time_ and arg_356_1.time_ <= var_359_16 + arg_359_0 then
				arg_356_1.allBtn_.enabled = false
			end

			local var_359_17 = 0.3

			if arg_356_1.time_ >= var_359_16 + var_359_17 and arg_356_1.time_ < var_359_16 + var_359_17 + arg_359_0 then
				arg_356_1.allBtn_.enabled = true
			end

			local var_359_18 = 0

			if var_359_18 < arg_356_1.time_ and arg_356_1.time_ <= var_359_18 + arg_359_0 then
				arg_356_1.mask_.enabled = true
				arg_356_1.mask_.raycastTarget = true

				arg_356_1:SetGaussion(false)
			end

			local var_359_19 = 2

			if var_359_18 <= arg_356_1.time_ and arg_356_1.time_ < var_359_18 + var_359_19 then
				local var_359_20 = (arg_356_1.time_ - var_359_18) / var_359_19
				local var_359_21 = Color.New(0, 0, 0)

				var_359_21.a = Mathf.Lerp(0, 1, var_359_20)
				arg_356_1.mask_.color = var_359_21
			end

			if arg_356_1.time_ >= var_359_18 + var_359_19 and arg_356_1.time_ < var_359_18 + var_359_19 + arg_359_0 then
				local var_359_22 = Color.New(0, 0, 0)

				var_359_22.a = 1
				arg_356_1.mask_.color = var_359_22
			end

			local var_359_23 = 2

			if var_359_23 < arg_356_1.time_ and arg_356_1.time_ <= var_359_23 + arg_359_0 then
				arg_356_1.mask_.enabled = true
				arg_356_1.mask_.raycastTarget = true

				arg_356_1:SetGaussion(false)
			end

			local var_359_24 = 2

			if var_359_23 <= arg_356_1.time_ and arg_356_1.time_ < var_359_23 + var_359_24 then
				local var_359_25 = (arg_356_1.time_ - var_359_23) / var_359_24
				local var_359_26 = Color.New(0, 0, 0)

				var_359_26.a = Mathf.Lerp(1, 0, var_359_25)
				arg_356_1.mask_.color = var_359_26
			end

			if arg_356_1.time_ >= var_359_23 + var_359_24 and arg_356_1.time_ < var_359_23 + var_359_24 + arg_359_0 then
				local var_359_27 = Color.New(0, 0, 0)
				local var_359_28 = 0

				arg_356_1.mask_.enabled = false
				var_359_27.a = var_359_28
				arg_356_1.mask_.color = var_359_27
			end

			local var_359_29 = 1.5
			local var_359_30 = 1

			if var_359_29 < arg_356_1.time_ and arg_356_1.time_ <= var_359_29 + arg_359_0 then
				local var_359_31 = "play"
				local var_359_32 = "music"

				arg_356_1:AudioAction(var_359_31, var_359_32, "se_story_side_1061", "se_story_side_1061_amb_train", "")

				local var_359_33 = ""
				local var_359_34 = manager.audio:GetAudioName("se_story_side_1061", "se_story_side_1061_amb_train")

				if var_359_34 ~= "" then
					if arg_356_1.bgmTxt_.text ~= var_359_34 and arg_356_1.bgmTxt_.text ~= "" then
						if arg_356_1.bgmTxt2_.text ~= "" then
							arg_356_1.bgmTxt_.text = arg_356_1.bgmTxt2_.text
						end

						arg_356_1.bgmTxt2_.text = var_359_34

						arg_356_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_356_1.bgmTxt_.text = var_359_34
						arg_356_1.bgmTxt2_.text = var_359_34
					end

					if arg_356_1.bgmTimer then
						arg_356_1.bgmTimer:Stop()

						arg_356_1.bgmTimer = nil
					end

					if arg_356_1.settingData.show_music_name == 1 then
						arg_356_1.musicController:SetSelectedState("show")
						arg_356_1.musicAnimator_:Play("open", 0, 0)

						if arg_356_1.settingData.music_time ~= 0 then
							arg_356_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_356_1.settingData.music_time), function()
								if arg_356_1 == nil or isNil(arg_356_1.bgmTxt_) then
									return
								end

								arg_356_1.musicController:SetSelectedState("hide")
								arg_356_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_359_35 = 0.166666666666667
			local var_359_36 = 1

			if var_359_35 < arg_356_1.time_ and arg_356_1.time_ <= var_359_35 + arg_359_0 then
				local var_359_37 = "stop"
				local var_359_38 = "effect"

				arg_356_1:AudioAction(var_359_37, var_359_38, "se_story_142", "se_story_142_amb_city_street", "")
			end

			if arg_356_1.frameCnt_ <= 1 then
				arg_356_1.dialog_:SetActive(false)
			end

			local var_359_39 = 4
			local var_359_40 = 0.425

			if var_359_39 < arg_356_1.time_ and arg_356_1.time_ <= var_359_39 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0

				arg_356_1.dialog_:SetActive(true)

				arg_356_1.dialogCg_.alpha = 0

				local var_359_41 = LeanTween.value(arg_356_1.dialog_, 0, 1, 0.3)

				var_359_41:setOnUpdate(LuaHelper.FloatAction(function(arg_361_0)
					arg_356_1.dialogCg_.alpha = arg_361_0
				end))
				var_359_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_356_1.dialog_)
					var_359_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_356_1.duration_ = arg_356_1.duration_ + 0.3

				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_42 = arg_356_1:FormatText(StoryNameCfg[7].name)

				arg_356_1.leftNameTxt_.text = var_359_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_43 = arg_356_1:GetWordFromCfg(1106101086)
				local var_359_44 = arg_356_1:FormatText(var_359_43.content)

				arg_356_1.text_.text = var_359_44

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_45 = 17
				local var_359_46 = utf8.len(var_359_44)
				local var_359_47 = var_359_45 <= 0 and var_359_40 or var_359_40 * (var_359_46 / var_359_45)

				if var_359_47 > 0 and var_359_40 < var_359_47 then
					arg_356_1.talkMaxDuration = var_359_47
					var_359_39 = var_359_39 + 0.3

					if var_359_47 + var_359_39 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_47 + var_359_39
					end
				end

				arg_356_1.text_.text = var_359_44
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_48 = var_359_39 + 0.3
			local var_359_49 = math.max(var_359_40, arg_356_1.talkMaxDuration)

			if var_359_48 <= arg_356_1.time_ and arg_356_1.time_ < var_359_48 + var_359_49 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_48) / var_359_49

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_48 + var_359_49 and arg_356_1.time_ < var_359_48 + var_359_49 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1106101087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1106101087
		arg_363_1.duration_ = 6.9

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1106101088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1061ui_story"].transform
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.var_.moveOldPos1061ui_story = var_366_0.localPosition
			end

			local var_366_2 = 0.001

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2
				local var_366_4 = Vector3.New(0, -1.18, -6.15)

				var_366_0.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1061ui_story, var_366_4, var_366_3)

				local var_366_5 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_5.x, var_366_5.y, var_366_5.z)

				local var_366_6 = var_366_0.localEulerAngles

				var_366_6.z = 0
				var_366_6.x = 0
				var_366_0.localEulerAngles = var_366_6
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 then
				var_366_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_366_7 = manager.ui.mainCamera.transform.position - var_366_0.position

				var_366_0.forward = Vector3.New(var_366_7.x, var_366_7.y, var_366_7.z)

				local var_366_8 = var_366_0.localEulerAngles

				var_366_8.z = 0
				var_366_8.x = 0
				var_366_0.localEulerAngles = var_366_8
			end

			local var_366_9 = arg_363_1.actors_["1061ui_story"]
			local var_366_10 = 0

			if var_366_10 < arg_363_1.time_ and arg_363_1.time_ <= var_366_10 + arg_366_0 and not isNil(var_366_9) and arg_363_1.var_.characterEffect1061ui_story == nil then
				arg_363_1.var_.characterEffect1061ui_story = var_366_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_11 = 0.200000002980232

			if var_366_10 <= arg_363_1.time_ and arg_363_1.time_ < var_366_10 + var_366_11 and not isNil(var_366_9) then
				local var_366_12 = (arg_363_1.time_ - var_366_10) / var_366_11

				if arg_363_1.var_.characterEffect1061ui_story and not isNil(var_366_9) then
					arg_363_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= var_366_10 + var_366_11 and arg_363_1.time_ < var_366_10 + var_366_11 + arg_366_0 and not isNil(var_366_9) and arg_363_1.var_.characterEffect1061ui_story then
				arg_363_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_366_13 = 0

			if var_366_13 < arg_363_1.time_ and arg_363_1.time_ <= var_366_13 + arg_366_0 then
				arg_363_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_366_14 = 0

			if var_366_14 < arg_363_1.time_ and arg_363_1.time_ <= var_366_14 + arg_366_0 then
				arg_363_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_366_15 = 0
			local var_366_16 = 0.85

			if var_366_15 < arg_363_1.time_ and arg_363_1.time_ <= var_366_15 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_17 = arg_363_1:FormatText(StoryNameCfg[612].name)

				arg_363_1.leftNameTxt_.text = var_366_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_18 = arg_363_1:GetWordFromCfg(1106101087)
				local var_366_19 = arg_363_1:FormatText(var_366_18.content)

				arg_363_1.text_.text = var_366_19

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_20 = 34
				local var_366_21 = utf8.len(var_366_19)
				local var_366_22 = var_366_20 <= 0 and var_366_16 or var_366_16 * (var_366_21 / var_366_20)

				if var_366_22 > 0 and var_366_16 < var_366_22 then
					arg_363_1.talkMaxDuration = var_366_22

					if var_366_22 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_22 + var_366_15
					end
				end

				arg_363_1.text_.text = var_366_19
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101087", "story_v_side_new_1106101.awb") ~= 0 then
					local var_366_23 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101087", "story_v_side_new_1106101.awb") / 1000

					if var_366_23 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_23 + var_366_15
					end

					if var_366_18.prefab_name ~= "" and arg_363_1.actors_[var_366_18.prefab_name] ~= nil then
						local var_366_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_18.prefab_name].transform, "story_v_side_new_1106101", "1106101087", "story_v_side_new_1106101.awb")

						arg_363_1:RecordAudio("1106101087", var_366_24)
						arg_363_1:RecordAudio("1106101087", var_366_24)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101087", "story_v_side_new_1106101.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101087", "story_v_side_new_1106101.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_25 = math.max(var_366_16, arg_363_1.talkMaxDuration)

			if var_366_15 <= arg_363_1.time_ and arg_363_1.time_ < var_366_15 + var_366_25 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_15) / var_366_25

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_15 + var_366_25 and arg_363_1.time_ < var_366_15 + var_366_25 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play1106101088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1106101088
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1106101089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1061ui_story"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1061ui_story == nil then
				arg_367_1.var_.characterEffect1061ui_story = var_370_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 and not isNil(var_370_0) then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.characterEffect1061ui_story and not isNil(var_370_0) then
					local var_370_4 = Mathf.Lerp(0, 0.5, var_370_3)

					arg_367_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_367_1.var_.characterEffect1061ui_story.fillRatio = var_370_4
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and not isNil(var_370_0) and arg_367_1.var_.characterEffect1061ui_story then
				local var_370_5 = 0.5

				arg_367_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_367_1.var_.characterEffect1061ui_story.fillRatio = var_370_5
			end

			local var_370_6 = 0
			local var_370_7 = 0.35

			if var_370_6 < arg_367_1.time_ and arg_367_1.time_ <= var_370_6 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_8 = arg_367_1:FormatText(StoryNameCfg[7].name)

				arg_367_1.leftNameTxt_.text = var_370_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, true)
				arg_367_1.iconController_:SetSelectedState("hero")

				arg_367_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_367_1.callingController_:SetSelectedState("normal")

				arg_367_1.keyicon_.color = Color.New(1, 1, 1)
				arg_367_1.icon_.color = Color.New(1, 1, 1)

				local var_370_9 = arg_367_1:GetWordFromCfg(1106101088)
				local var_370_10 = arg_367_1:FormatText(var_370_9.content)

				arg_367_1.text_.text = var_370_10

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_11 = 14
				local var_370_12 = utf8.len(var_370_10)
				local var_370_13 = var_370_11 <= 0 and var_370_7 or var_370_7 * (var_370_12 / var_370_11)

				if var_370_13 > 0 and var_370_7 < var_370_13 then
					arg_367_1.talkMaxDuration = var_370_13

					if var_370_13 + var_370_6 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_6
					end
				end

				arg_367_1.text_.text = var_370_10
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_14 = math.max(var_370_7, arg_367_1.talkMaxDuration)

			if var_370_6 <= arg_367_1.time_ and arg_367_1.time_ < var_370_6 + var_370_14 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_6) / var_370_14

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_6 + var_370_14 and arg_367_1.time_ < var_370_6 + var_370_14 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1106101089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1106101089
		arg_371_1.duration_ = 6.23

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1106101090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1061ui_story"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1061ui_story == nil then
				arg_371_1.var_.characterEffect1061ui_story = var_374_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.characterEffect1061ui_story and not isNil(var_374_0) then
					arg_371_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1061ui_story then
				arg_371_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_374_4 = 0

			if var_374_4 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_374_5 = 0

			if var_374_5 < arg_371_1.time_ and arg_371_1.time_ <= var_374_5 + arg_374_0 then
				arg_371_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_374_6 = 0
			local var_374_7 = 0.725

			if var_374_6 < arg_371_1.time_ and arg_371_1.time_ <= var_374_6 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_8 = arg_371_1:FormatText(StoryNameCfg[612].name)

				arg_371_1.leftNameTxt_.text = var_374_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_9 = arg_371_1:GetWordFromCfg(1106101089)
				local var_374_10 = arg_371_1:FormatText(var_374_9.content)

				arg_371_1.text_.text = var_374_10

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_11 = 29
				local var_374_12 = utf8.len(var_374_10)
				local var_374_13 = var_374_11 <= 0 and var_374_7 or var_374_7 * (var_374_12 / var_374_11)

				if var_374_13 > 0 and var_374_7 < var_374_13 then
					arg_371_1.talkMaxDuration = var_374_13

					if var_374_13 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_13 + var_374_6
					end
				end

				arg_371_1.text_.text = var_374_10
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101089", "story_v_side_new_1106101.awb") ~= 0 then
					local var_374_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101089", "story_v_side_new_1106101.awb") / 1000

					if var_374_14 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_14 + var_374_6
					end

					if var_374_9.prefab_name ~= "" and arg_371_1.actors_[var_374_9.prefab_name] ~= nil then
						local var_374_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_9.prefab_name].transform, "story_v_side_new_1106101", "1106101089", "story_v_side_new_1106101.awb")

						arg_371_1:RecordAudio("1106101089", var_374_15)
						arg_371_1:RecordAudio("1106101089", var_374_15)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101089", "story_v_side_new_1106101.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101089", "story_v_side_new_1106101.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_16 = math.max(var_374_7, arg_371_1.talkMaxDuration)

			if var_374_6 <= arg_371_1.time_ and arg_371_1.time_ < var_374_6 + var_374_16 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_6) / var_374_16

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_6 + var_374_16 and arg_371_1.time_ < var_374_6 + var_374_16 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1106101090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1106101090
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1106101091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1061ui_story"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1061ui_story == nil then
				arg_375_1.var_.characterEffect1061ui_story = var_378_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 and not isNil(var_378_0) then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.characterEffect1061ui_story and not isNil(var_378_0) then
					local var_378_4 = Mathf.Lerp(0, 0.5, var_378_3)

					arg_375_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_375_1.var_.characterEffect1061ui_story.fillRatio = var_378_4
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and not isNil(var_378_0) and arg_375_1.var_.characterEffect1061ui_story then
				local var_378_5 = 0.5

				arg_375_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_375_1.var_.characterEffect1061ui_story.fillRatio = var_378_5
			end

			local var_378_6 = 0
			local var_378_7 = 0.625

			if var_378_6 < arg_375_1.time_ and arg_375_1.time_ <= var_378_6 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_8 = arg_375_1:FormatText(StoryNameCfg[7].name)

				arg_375_1.leftNameTxt_.text = var_378_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_9 = arg_375_1:GetWordFromCfg(1106101090)
				local var_378_10 = arg_375_1:FormatText(var_378_9.content)

				arg_375_1.text_.text = var_378_10

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_11 = 25
				local var_378_12 = utf8.len(var_378_10)
				local var_378_13 = var_378_11 <= 0 and var_378_7 or var_378_7 * (var_378_12 / var_378_11)

				if var_378_13 > 0 and var_378_7 < var_378_13 then
					arg_375_1.talkMaxDuration = var_378_13

					if var_378_13 + var_378_6 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_13 + var_378_6
					end
				end

				arg_375_1.text_.text = var_378_10
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_14 = math.max(var_378_7, arg_375_1.talkMaxDuration)

			if var_378_6 <= arg_375_1.time_ and arg_375_1.time_ < var_378_6 + var_378_14 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_6) / var_378_14

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_6 + var_378_14 and arg_375_1.time_ < var_378_6 + var_378_14 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1106101091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1106101091
		arg_379_1.duration_ = 5.27

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1106101092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = arg_379_1.actors_["1061ui_story"]
			local var_382_1 = 0

			if var_382_1 < arg_379_1.time_ and arg_379_1.time_ <= var_382_1 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1061ui_story == nil then
				arg_379_1.var_.characterEffect1061ui_story = var_382_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_2 = 0.200000002980232

			if var_382_1 <= arg_379_1.time_ and arg_379_1.time_ < var_382_1 + var_382_2 and not isNil(var_382_0) then
				local var_382_3 = (arg_379_1.time_ - var_382_1) / var_382_2

				if arg_379_1.var_.characterEffect1061ui_story and not isNil(var_382_0) then
					arg_379_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_1 + var_382_2 and arg_379_1.time_ < var_382_1 + var_382_2 + arg_382_0 and not isNil(var_382_0) and arg_379_1.var_.characterEffect1061ui_story then
				arg_379_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_382_4 = 0

			if var_382_4 < arg_379_1.time_ and arg_379_1.time_ <= var_382_4 + arg_382_0 then
				arg_379_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action429")
			end

			local var_382_5 = 0

			if var_382_5 < arg_379_1.time_ and arg_379_1.time_ <= var_382_5 + arg_382_0 then
				arg_379_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_382_6 = 0
			local var_382_7 = 0.325

			if var_382_6 < arg_379_1.time_ and arg_379_1.time_ <= var_382_6 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_8 = arg_379_1:FormatText(StoryNameCfg[612].name)

				arg_379_1.leftNameTxt_.text = var_382_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_9 = arg_379_1:GetWordFromCfg(1106101091)
				local var_382_10 = arg_379_1:FormatText(var_382_9.content)

				arg_379_1.text_.text = var_382_10

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_11 = 13
				local var_382_12 = utf8.len(var_382_10)
				local var_382_13 = var_382_11 <= 0 and var_382_7 or var_382_7 * (var_382_12 / var_382_11)

				if var_382_13 > 0 and var_382_7 < var_382_13 then
					arg_379_1.talkMaxDuration = var_382_13

					if var_382_13 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_6
					end
				end

				arg_379_1.text_.text = var_382_10
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101091", "story_v_side_new_1106101.awb") ~= 0 then
					local var_382_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101091", "story_v_side_new_1106101.awb") / 1000

					if var_382_14 + var_382_6 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_14 + var_382_6
					end

					if var_382_9.prefab_name ~= "" and arg_379_1.actors_[var_382_9.prefab_name] ~= nil then
						local var_382_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_9.prefab_name].transform, "story_v_side_new_1106101", "1106101091", "story_v_side_new_1106101.awb")

						arg_379_1:RecordAudio("1106101091", var_382_15)
						arg_379_1:RecordAudio("1106101091", var_382_15)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101091", "story_v_side_new_1106101.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101091", "story_v_side_new_1106101.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_16 = math.max(var_382_7, arg_379_1.talkMaxDuration)

			if var_382_6 <= arg_379_1.time_ and arg_379_1.time_ < var_382_6 + var_382_16 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_6) / var_382_16

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_6 + var_382_16 and arg_379_1.time_ < var_382_6 + var_382_16 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1106101092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1106101092
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1106101093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1061ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1061ui_story == nil then
				arg_383_1.var_.characterEffect1061ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1061ui_story and not isNil(var_386_0) then
					local var_386_4 = Mathf.Lerp(0, 0.5, var_386_3)

					arg_383_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1061ui_story.fillRatio = var_386_4
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1061ui_story then
				local var_386_5 = 0.5

				arg_383_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1061ui_story.fillRatio = var_386_5
			end

			local var_386_6 = 0

			if var_386_6 < arg_383_1.time_ and arg_383_1.time_ <= var_386_6 + arg_386_0 then
				arg_383_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action494")
			end

			local var_386_7 = 0
			local var_386_8 = 0.65

			if var_386_7 < arg_383_1.time_ and arg_383_1.time_ <= var_386_7 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_9 = arg_383_1:GetWordFromCfg(1106101092)
				local var_386_10 = arg_383_1:FormatText(var_386_9.content)

				arg_383_1.text_.text = var_386_10

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_11 = 26
				local var_386_12 = utf8.len(var_386_10)
				local var_386_13 = var_386_11 <= 0 and var_386_8 or var_386_8 * (var_386_12 / var_386_11)

				if var_386_13 > 0 and var_386_8 < var_386_13 then
					arg_383_1.talkMaxDuration = var_386_13

					if var_386_13 + var_386_7 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_7
					end
				end

				arg_383_1.text_.text = var_386_10
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_14 = math.max(var_386_8, arg_383_1.talkMaxDuration)

			if var_386_7 <= arg_383_1.time_ and arg_383_1.time_ < var_386_7 + var_386_14 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_7) / var_386_14

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_7 + var_386_14 and arg_383_1.time_ < var_386_7 + var_386_14 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1106101093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1106101093
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1106101094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0
			local var_390_1 = 0.325

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_2 = arg_387_1:FormatText(StoryNameCfg[7].name)

				arg_387_1.leftNameTxt_.text = var_390_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_3 = arg_387_1:GetWordFromCfg(1106101093)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_5 = 13
				local var_390_6 = utf8.len(var_390_4)
				local var_390_7 = var_390_5 <= 0 and var_390_1 or var_390_1 * (var_390_6 / var_390_5)

				if var_390_7 > 0 and var_390_1 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_0
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_8 = math.max(var_390_1, arg_387_1.talkMaxDuration)

			if var_390_0 <= arg_387_1.time_ and arg_387_1.time_ < var_390_0 + var_390_8 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_0) / var_390_8

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_0 + var_390_8 and arg_387_1.time_ < var_390_0 + var_390_8 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1106101094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1106101094
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1106101095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0
			local var_394_1 = 0.75

			if var_394_0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_2 = arg_391_1:GetWordFromCfg(1106101094)
				local var_394_3 = arg_391_1:FormatText(var_394_2.content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 30
				local var_394_5 = utf8.len(var_394_3)
				local var_394_6 = var_394_4 <= 0 and var_394_1 or var_394_1 * (var_394_5 / var_394_4)

				if var_394_6 > 0 and var_394_1 < var_394_6 then
					arg_391_1.talkMaxDuration = var_394_6

					if var_394_6 + var_394_0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_6 + var_394_0
					end
				end

				arg_391_1.text_.text = var_394_3
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_1, arg_391_1.talkMaxDuration)

			if var_394_0 <= arg_391_1.time_ and arg_391_1.time_ < var_394_0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_0 + var_394_7 and arg_391_1.time_ < var_394_0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1106101095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1106101095
		arg_395_1.duration_ = 3.67

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play1106101096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1061ui_story"]
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1061ui_story == nil then
				arg_395_1.var_.characterEffect1061ui_story = var_398_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 and not isNil(var_398_0) then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2

				if arg_395_1.var_.characterEffect1061ui_story and not isNil(var_398_0) then
					arg_395_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 and not isNil(var_398_0) and arg_395_1.var_.characterEffect1061ui_story then
				arg_395_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_398_4 = 0
			local var_398_5 = 0.35

			if var_398_4 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_6 = arg_395_1:FormatText(StoryNameCfg[612].name)

				arg_395_1.leftNameTxt_.text = var_398_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_7 = arg_395_1:GetWordFromCfg(1106101095)
				local var_398_8 = arg_395_1:FormatText(var_398_7.content)

				arg_395_1.text_.text = var_398_8

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_9 = 14
				local var_398_10 = utf8.len(var_398_8)
				local var_398_11 = var_398_9 <= 0 and var_398_5 or var_398_5 * (var_398_10 / var_398_9)

				if var_398_11 > 0 and var_398_5 < var_398_11 then
					arg_395_1.talkMaxDuration = var_398_11

					if var_398_11 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_11 + var_398_4
					end
				end

				arg_395_1.text_.text = var_398_8
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101095", "story_v_side_new_1106101.awb") ~= 0 then
					local var_398_12 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101095", "story_v_side_new_1106101.awb") / 1000

					if var_398_12 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_12 + var_398_4
					end

					if var_398_7.prefab_name ~= "" and arg_395_1.actors_[var_398_7.prefab_name] ~= nil then
						local var_398_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_7.prefab_name].transform, "story_v_side_new_1106101", "1106101095", "story_v_side_new_1106101.awb")

						arg_395_1:RecordAudio("1106101095", var_398_13)
						arg_395_1:RecordAudio("1106101095", var_398_13)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101095", "story_v_side_new_1106101.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101095", "story_v_side_new_1106101.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_14 = math.max(var_398_5, arg_395_1.talkMaxDuration)

			if var_398_4 <= arg_395_1.time_ and arg_395_1.time_ < var_398_4 + var_398_14 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_4) / var_398_14

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_4 + var_398_14 and arg_395_1.time_ < var_398_4 + var_398_14 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play1106101096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1106101096
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1106101097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1061ui_story"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1061ui_story == nil then
				arg_399_1.var_.characterEffect1061ui_story = var_402_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_2 = 0.200000002980232

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.characterEffect1061ui_story and not isNil(var_402_0) then
					local var_402_4 = Mathf.Lerp(0, 0.5, var_402_3)

					arg_399_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1061ui_story.fillRatio = var_402_4
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.characterEffect1061ui_story then
				local var_402_5 = 0.5

				arg_399_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1061ui_story.fillRatio = var_402_5
			end

			local var_402_6 = 0
			local var_402_7 = 0.65

			if var_402_6 < arg_399_1.time_ and arg_399_1.time_ <= var_402_6 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_8 = arg_399_1:GetWordFromCfg(1106101096)
				local var_402_9 = arg_399_1:FormatText(var_402_8.content)

				arg_399_1.text_.text = var_402_9

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_10 = 26
				local var_402_11 = utf8.len(var_402_9)
				local var_402_12 = var_402_10 <= 0 and var_402_7 or var_402_7 * (var_402_11 / var_402_10)

				if var_402_12 > 0 and var_402_7 < var_402_12 then
					arg_399_1.talkMaxDuration = var_402_12

					if var_402_12 + var_402_6 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_12 + var_402_6
					end
				end

				arg_399_1.text_.text = var_402_9
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_13 = math.max(var_402_7, arg_399_1.talkMaxDuration)

			if var_402_6 <= arg_399_1.time_ and arg_399_1.time_ < var_402_6 + var_402_13 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_6) / var_402_13

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_6 + var_402_13 and arg_399_1.time_ < var_402_6 + var_402_13 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1106101097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1106101097
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1106101098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0
			local var_406_1 = 1.075

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_2 = arg_403_1:FormatText(StoryNameCfg[7].name)

				arg_403_1.leftNameTxt_.text = var_406_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_3 = arg_403_1:GetWordFromCfg(1106101097)
				local var_406_4 = arg_403_1:FormatText(var_406_3.content)

				arg_403_1.text_.text = var_406_4

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 43
				local var_406_6 = utf8.len(var_406_4)
				local var_406_7 = var_406_5 <= 0 and var_406_1 or var_406_1 * (var_406_6 / var_406_5)

				if var_406_7 > 0 and var_406_1 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_4
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_8 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_8 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_8

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_8 and arg_403_1.time_ < var_406_0 + var_406_8 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1106101098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1106101098
		arg_407_1.duration_ = 2

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1106101099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1061ui_story"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1061ui_story == nil then
				arg_407_1.var_.characterEffect1061ui_story = var_410_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.characterEffect1061ui_story and not isNil(var_410_0) then
					arg_407_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1061ui_story then
				arg_407_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_410_4 = 0

			if var_410_4 < arg_407_1.time_ and arg_407_1.time_ <= var_410_4 + arg_410_0 then
				arg_407_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action4_2")
			end

			local var_410_5 = 0

			if var_410_5 < arg_407_1.time_ and arg_407_1.time_ <= var_410_5 + arg_410_0 then
				arg_407_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_410_6 = 0
			local var_410_7 = 0.075

			if var_410_6 < arg_407_1.time_ and arg_407_1.time_ <= var_410_6 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_8 = arg_407_1:FormatText(StoryNameCfg[612].name)

				arg_407_1.leftNameTxt_.text = var_410_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_9 = arg_407_1:GetWordFromCfg(1106101098)
				local var_410_10 = arg_407_1:FormatText(var_410_9.content)

				arg_407_1.text_.text = var_410_10

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_11 = 3
				local var_410_12 = utf8.len(var_410_10)
				local var_410_13 = var_410_11 <= 0 and var_410_7 or var_410_7 * (var_410_12 / var_410_11)

				if var_410_13 > 0 and var_410_7 < var_410_13 then
					arg_407_1.talkMaxDuration = var_410_13

					if var_410_13 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_6
					end
				end

				arg_407_1.text_.text = var_410_10
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101098", "story_v_side_new_1106101.awb") ~= 0 then
					local var_410_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101098", "story_v_side_new_1106101.awb") / 1000

					if var_410_14 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_14 + var_410_6
					end

					if var_410_9.prefab_name ~= "" and arg_407_1.actors_[var_410_9.prefab_name] ~= nil then
						local var_410_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_9.prefab_name].transform, "story_v_side_new_1106101", "1106101098", "story_v_side_new_1106101.awb")

						arg_407_1:RecordAudio("1106101098", var_410_15)
						arg_407_1:RecordAudio("1106101098", var_410_15)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101098", "story_v_side_new_1106101.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101098", "story_v_side_new_1106101.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_16 = math.max(var_410_7, arg_407_1.talkMaxDuration)

			if var_410_6 <= arg_407_1.time_ and arg_407_1.time_ < var_410_6 + var_410_16 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_6) / var_410_16

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_6 + var_410_16 and arg_407_1.time_ < var_410_6 + var_410_16 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1106101099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1106101099
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1106101100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1061ui_story"].transform
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.var_.moveOldPos1061ui_story = var_414_0.localPosition
			end

			local var_414_2 = 0.001

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2
				local var_414_4 = Vector3.New(0, 100, 0)

				var_414_0.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1061ui_story, var_414_4, var_414_3)

				local var_414_5 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_5.x, var_414_5.y, var_414_5.z)

				local var_414_6 = var_414_0.localEulerAngles

				var_414_6.z = 0
				var_414_6.x = 0
				var_414_0.localEulerAngles = var_414_6
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 then
				var_414_0.localPosition = Vector3.New(0, 100, 0)

				local var_414_7 = manager.ui.mainCamera.transform.position - var_414_0.position

				var_414_0.forward = Vector3.New(var_414_7.x, var_414_7.y, var_414_7.z)

				local var_414_8 = var_414_0.localEulerAngles

				var_414_8.z = 0
				var_414_8.x = 0
				var_414_0.localEulerAngles = var_414_8
			end

			local var_414_9 = arg_411_1.actors_["1061ui_story"]
			local var_414_10 = 0

			if var_414_10 < arg_411_1.time_ and arg_411_1.time_ <= var_414_10 + arg_414_0 and not isNil(var_414_9) and arg_411_1.var_.characterEffect1061ui_story == nil then
				arg_411_1.var_.characterEffect1061ui_story = var_414_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_11 = 0.200000002980232

			if var_414_10 <= arg_411_1.time_ and arg_411_1.time_ < var_414_10 + var_414_11 and not isNil(var_414_9) then
				local var_414_12 = (arg_411_1.time_ - var_414_10) / var_414_11

				if arg_411_1.var_.characterEffect1061ui_story and not isNil(var_414_9) then
					local var_414_13 = Mathf.Lerp(0, 0.5, var_414_12)

					arg_411_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1061ui_story.fillRatio = var_414_13
				end
			end

			if arg_411_1.time_ >= var_414_10 + var_414_11 and arg_411_1.time_ < var_414_10 + var_414_11 + arg_414_0 and not isNil(var_414_9) and arg_411_1.var_.characterEffect1061ui_story then
				local var_414_14 = 0.5

				arg_411_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1061ui_story.fillRatio = var_414_14
			end

			local var_414_15 = 0
			local var_414_16 = 0.575

			if var_414_15 < arg_411_1.time_ and arg_411_1.time_ <= var_414_15 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_17 = arg_411_1:GetWordFromCfg(1106101099)
				local var_414_18 = arg_411_1:FormatText(var_414_17.content)

				arg_411_1.text_.text = var_414_18

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_19 = 23
				local var_414_20 = utf8.len(var_414_18)
				local var_414_21 = var_414_19 <= 0 and var_414_16 or var_414_16 * (var_414_20 / var_414_19)

				if var_414_21 > 0 and var_414_16 < var_414_21 then
					arg_411_1.talkMaxDuration = var_414_21

					if var_414_21 + var_414_15 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_21 + var_414_15
					end
				end

				arg_411_1.text_.text = var_414_18
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_22 = math.max(var_414_16, arg_411_1.talkMaxDuration)

			if var_414_15 <= arg_411_1.time_ and arg_411_1.time_ < var_414_15 + var_414_22 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_15) / var_414_22

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_15 + var_414_22 and arg_411_1.time_ < var_414_15 + var_414_22 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play1106101100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1106101100
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1106101101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0
			local var_418_1 = 0.45

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_2 = arg_415_1:FormatText(StoryNameCfg[7].name)

				arg_415_1.leftNameTxt_.text = var_418_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_3 = arg_415_1:GetWordFromCfg(1106101100)
				local var_418_4 = arg_415_1:FormatText(var_418_3.content)

				arg_415_1.text_.text = var_418_4

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_5 = 18
				local var_418_6 = utf8.len(var_418_4)
				local var_418_7 = var_418_5 <= 0 and var_418_1 or var_418_1 * (var_418_6 / var_418_5)

				if var_418_7 > 0 and var_418_1 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_0
					end
				end

				arg_415_1.text_.text = var_418_4
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_8 = math.max(var_418_1, arg_415_1.talkMaxDuration)

			if var_418_0 <= arg_415_1.time_ and arg_415_1.time_ < var_418_0 + var_418_8 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_0) / var_418_8

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_0 + var_418_8 and arg_415_1.time_ < var_418_0 + var_418_8 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1106101101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1106101101
		arg_419_1.duration_ = 1.23

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1106101102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1061ui_story"].transform
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.var_.moveOldPos1061ui_story = var_422_0.localPosition
			end

			local var_422_2 = 0.001

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2
				local var_422_4 = Vector3.New(0, -1.18, -6.15)

				var_422_0.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1061ui_story, var_422_4, var_422_3)

				local var_422_5 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_5.x, var_422_5.y, var_422_5.z)

				local var_422_6 = var_422_0.localEulerAngles

				var_422_6.z = 0
				var_422_6.x = 0
				var_422_0.localEulerAngles = var_422_6
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 then
				var_422_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_422_7 = manager.ui.mainCamera.transform.position - var_422_0.position

				var_422_0.forward = Vector3.New(var_422_7.x, var_422_7.y, var_422_7.z)

				local var_422_8 = var_422_0.localEulerAngles

				var_422_8.z = 0
				var_422_8.x = 0
				var_422_0.localEulerAngles = var_422_8
			end

			local var_422_9 = arg_419_1.actors_["1061ui_story"]
			local var_422_10 = 0

			if var_422_10 < arg_419_1.time_ and arg_419_1.time_ <= var_422_10 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect1061ui_story == nil then
				arg_419_1.var_.characterEffect1061ui_story = var_422_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_11 = 0.200000002980232

			if var_422_10 <= arg_419_1.time_ and arg_419_1.time_ < var_422_10 + var_422_11 and not isNil(var_422_9) then
				local var_422_12 = (arg_419_1.time_ - var_422_10) / var_422_11

				if arg_419_1.var_.characterEffect1061ui_story and not isNil(var_422_9) then
					arg_419_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= var_422_10 + var_422_11 and arg_419_1.time_ < var_422_10 + var_422_11 + arg_422_0 and not isNil(var_422_9) and arg_419_1.var_.characterEffect1061ui_story then
				arg_419_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_422_13 = 0

			if var_422_13 < arg_419_1.time_ and arg_419_1.time_ <= var_422_13 + arg_422_0 then
				arg_419_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_422_14 = 0

			if var_422_14 < arg_419_1.time_ and arg_419_1.time_ <= var_422_14 + arg_422_0 then
				arg_419_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_422_15 = 0
			local var_422_16 = 0.075

			if var_422_15 < arg_419_1.time_ and arg_419_1.time_ <= var_422_15 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_17 = arg_419_1:FormatText(StoryNameCfg[612].name)

				arg_419_1.leftNameTxt_.text = var_422_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_18 = arg_419_1:GetWordFromCfg(1106101101)
				local var_422_19 = arg_419_1:FormatText(var_422_18.content)

				arg_419_1.text_.text = var_422_19

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_20 = 3
				local var_422_21 = utf8.len(var_422_19)
				local var_422_22 = var_422_20 <= 0 and var_422_16 or var_422_16 * (var_422_21 / var_422_20)

				if var_422_22 > 0 and var_422_16 < var_422_22 then
					arg_419_1.talkMaxDuration = var_422_22

					if var_422_22 + var_422_15 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_22 + var_422_15
					end
				end

				arg_419_1.text_.text = var_422_19
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101101", "story_v_side_new_1106101.awb") ~= 0 then
					local var_422_23 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101101", "story_v_side_new_1106101.awb") / 1000

					if var_422_23 + var_422_15 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_23 + var_422_15
					end

					if var_422_18.prefab_name ~= "" and arg_419_1.actors_[var_422_18.prefab_name] ~= nil then
						local var_422_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_18.prefab_name].transform, "story_v_side_new_1106101", "1106101101", "story_v_side_new_1106101.awb")

						arg_419_1:RecordAudio("1106101101", var_422_24)
						arg_419_1:RecordAudio("1106101101", var_422_24)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101101", "story_v_side_new_1106101.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101101", "story_v_side_new_1106101.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_25 = math.max(var_422_16, arg_419_1.talkMaxDuration)

			if var_422_15 <= arg_419_1.time_ and arg_419_1.time_ < var_422_15 + var_422_25 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_15) / var_422_25

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_15 + var_422_25 and arg_419_1.time_ < var_422_15 + var_422_25 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play1106101102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1106101102
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1106101103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1061ui_story"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1061ui_story == nil then
				arg_423_1.var_.characterEffect1061ui_story = var_426_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 and not isNil(var_426_0) then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.characterEffect1061ui_story and not isNil(var_426_0) then
					local var_426_4 = Mathf.Lerp(0, 0.5, var_426_3)

					arg_423_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1061ui_story.fillRatio = var_426_4
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and not isNil(var_426_0) and arg_423_1.var_.characterEffect1061ui_story then
				local var_426_5 = 0.5

				arg_423_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1061ui_story.fillRatio = var_426_5
			end

			local var_426_6 = 0
			local var_426_7 = 0.95

			if var_426_6 < arg_423_1.time_ and arg_423_1.time_ <= var_426_6 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				local var_426_8 = arg_423_1:FormatText(StoryNameCfg[7].name)

				arg_423_1.leftNameTxt_.text = var_426_8

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

				local var_426_9 = arg_423_1:GetWordFromCfg(1106101102)
				local var_426_10 = arg_423_1:FormatText(var_426_9.content)

				arg_423_1.text_.text = var_426_10

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_11 = 38
				local var_426_12 = utf8.len(var_426_10)
				local var_426_13 = var_426_11 <= 0 and var_426_7 or var_426_7 * (var_426_12 / var_426_11)

				if var_426_13 > 0 and var_426_7 < var_426_13 then
					arg_423_1.talkMaxDuration = var_426_13

					if var_426_13 + var_426_6 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_13 + var_426_6
					end
				end

				arg_423_1.text_.text = var_426_10
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_14 = math.max(var_426_7, arg_423_1.talkMaxDuration)

			if var_426_6 <= arg_423_1.time_ and arg_423_1.time_ < var_426_6 + var_426_14 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_6) / var_426_14

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_6 + var_426_14 and arg_423_1.time_ < var_426_6 + var_426_14 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1106101103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1106101103
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play1106101104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 0.45

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_2 = arg_427_1:FormatText(StoryNameCfg[7].name)

				arg_427_1.leftNameTxt_.text = var_430_2

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

				local var_430_3 = arg_427_1:GetWordFromCfg(1106101103)
				local var_430_4 = arg_427_1:FormatText(var_430_3.content)

				arg_427_1.text_.text = var_430_4

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 18
				local var_430_6 = utf8.len(var_430_4)
				local var_430_7 = var_430_5 <= 0 and var_430_1 or var_430_1 * (var_430_6 / var_430_5)

				if var_430_7 > 0 and var_430_1 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_4
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_8 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_8 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_8

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_8 and arg_427_1.time_ < var_430_0 + var_430_8 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play1106101104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1106101104
		arg_431_1.duration_ = 2

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1106101105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1061ui_story"].transform
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.var_.moveOldPos1061ui_story = var_434_0.localPosition
			end

			local var_434_2 = 0.001

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2
				local var_434_4 = Vector3.New(0, -1.18, -6.15)

				var_434_0.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos1061ui_story, var_434_4, var_434_3)

				local var_434_5 = manager.ui.mainCamera.transform.position - var_434_0.position

				var_434_0.forward = Vector3.New(var_434_5.x, var_434_5.y, var_434_5.z)

				local var_434_6 = var_434_0.localEulerAngles

				var_434_6.z = 0
				var_434_6.x = 0
				var_434_0.localEulerAngles = var_434_6
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 then
				var_434_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_434_7 = manager.ui.mainCamera.transform.position - var_434_0.position

				var_434_0.forward = Vector3.New(var_434_7.x, var_434_7.y, var_434_7.z)

				local var_434_8 = var_434_0.localEulerAngles

				var_434_8.z = 0
				var_434_8.x = 0
				var_434_0.localEulerAngles = var_434_8
			end

			local var_434_9 = arg_431_1.actors_["1061ui_story"]
			local var_434_10 = 0

			if var_434_10 < arg_431_1.time_ and arg_431_1.time_ <= var_434_10 + arg_434_0 and not isNil(var_434_9) and arg_431_1.var_.characterEffect1061ui_story == nil then
				arg_431_1.var_.characterEffect1061ui_story = var_434_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_11 = 0.200000002980232

			if var_434_10 <= arg_431_1.time_ and arg_431_1.time_ < var_434_10 + var_434_11 and not isNil(var_434_9) then
				local var_434_12 = (arg_431_1.time_ - var_434_10) / var_434_11

				if arg_431_1.var_.characterEffect1061ui_story and not isNil(var_434_9) then
					arg_431_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= var_434_10 + var_434_11 and arg_431_1.time_ < var_434_10 + var_434_11 + arg_434_0 and not isNil(var_434_9) and arg_431_1.var_.characterEffect1061ui_story then
				arg_431_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_434_13 = 0

			if var_434_13 < arg_431_1.time_ and arg_431_1.time_ <= var_434_13 + arg_434_0 then
				arg_431_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_434_14 = 0

			if var_434_14 < arg_431_1.time_ and arg_431_1.time_ <= var_434_14 + arg_434_0 then
				arg_431_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_434_15 = 0
			local var_434_16 = 0.15

			if var_434_15 < arg_431_1.time_ and arg_431_1.time_ <= var_434_15 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_17 = arg_431_1:FormatText(StoryNameCfg[612].name)

				arg_431_1.leftNameTxt_.text = var_434_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_18 = arg_431_1:GetWordFromCfg(1106101104)
				local var_434_19 = arg_431_1:FormatText(var_434_18.content)

				arg_431_1.text_.text = var_434_19

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_20 = 6
				local var_434_21 = utf8.len(var_434_19)
				local var_434_22 = var_434_20 <= 0 and var_434_16 or var_434_16 * (var_434_21 / var_434_20)

				if var_434_22 > 0 and var_434_16 < var_434_22 then
					arg_431_1.talkMaxDuration = var_434_22

					if var_434_22 + var_434_15 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_22 + var_434_15
					end
				end

				arg_431_1.text_.text = var_434_19
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101104", "story_v_side_new_1106101.awb") ~= 0 then
					local var_434_23 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101104", "story_v_side_new_1106101.awb") / 1000

					if var_434_23 + var_434_15 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_23 + var_434_15
					end

					if var_434_18.prefab_name ~= "" and arg_431_1.actors_[var_434_18.prefab_name] ~= nil then
						local var_434_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_18.prefab_name].transform, "story_v_side_new_1106101", "1106101104", "story_v_side_new_1106101.awb")

						arg_431_1:RecordAudio("1106101104", var_434_24)
						arg_431_1:RecordAudio("1106101104", var_434_24)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101104", "story_v_side_new_1106101.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101104", "story_v_side_new_1106101.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_25 = math.max(var_434_16, arg_431_1.talkMaxDuration)

			if var_434_15 <= arg_431_1.time_ and arg_431_1.time_ < var_434_15 + var_434_25 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_15) / var_434_25

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_15 + var_434_25 and arg_431_1.time_ < var_434_15 + var_434_25 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play1106101105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1106101105
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1106101106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1061ui_story"]
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1061ui_story == nil then
				arg_435_1.var_.characterEffect1061ui_story = var_438_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_2 = 0.200000002980232

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 and not isNil(var_438_0) then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2

				if arg_435_1.var_.characterEffect1061ui_story and not isNil(var_438_0) then
					local var_438_4 = Mathf.Lerp(0, 0.5, var_438_3)

					arg_435_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1061ui_story.fillRatio = var_438_4
				end
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 and not isNil(var_438_0) and arg_435_1.var_.characterEffect1061ui_story then
				local var_438_5 = 0.5

				arg_435_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1061ui_story.fillRatio = var_438_5
			end

			local var_438_6 = 0
			local var_438_7 = 0.3

			if var_438_6 < arg_435_1.time_ and arg_435_1.time_ <= var_438_6 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_8 = arg_435_1:FormatText(StoryNameCfg[7].name)

				arg_435_1.leftNameTxt_.text = var_438_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_435_1.callingController_:SetSelectedState("normal")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_9 = arg_435_1:GetWordFromCfg(1106101105)
				local var_438_10 = arg_435_1:FormatText(var_438_9.content)

				arg_435_1.text_.text = var_438_10

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_11 = 12
				local var_438_12 = utf8.len(var_438_10)
				local var_438_13 = var_438_11 <= 0 and var_438_7 or var_438_7 * (var_438_12 / var_438_11)

				if var_438_13 > 0 and var_438_7 < var_438_13 then
					arg_435_1.talkMaxDuration = var_438_13

					if var_438_13 + var_438_6 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_13 + var_438_6
					end
				end

				arg_435_1.text_.text = var_438_10
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_14 = math.max(var_438_7, arg_435_1.talkMaxDuration)

			if var_438_6 <= arg_435_1.time_ and arg_435_1.time_ < var_438_6 + var_438_14 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_6) / var_438_14

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_6 + var_438_14 and arg_435_1.time_ < var_438_6 + var_438_14 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play1106101106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1106101106
		arg_439_1.duration_ = 2.4

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1106101107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["1061ui_story"]
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1061ui_story == nil then
				arg_439_1.var_.characterEffect1061ui_story = var_442_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.200000002980232

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_2 and not isNil(var_442_0) then
				local var_442_3 = (arg_439_1.time_ - var_442_1) / var_442_2

				if arg_439_1.var_.characterEffect1061ui_story and not isNil(var_442_0) then
					arg_439_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_439_1.time_ >= var_442_1 + var_442_2 and arg_439_1.time_ < var_442_1 + var_442_2 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1061ui_story then
				arg_439_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_442_4 = 0

			if var_442_4 < arg_439_1.time_ and arg_439_1.time_ <= var_442_4 + arg_442_0 then
				arg_439_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action438")
			end

			local var_442_5 = 0

			if var_442_5 < arg_439_1.time_ and arg_439_1.time_ <= var_442_5 + arg_442_0 then
				arg_439_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_442_6 = 0
			local var_442_7 = 0.3

			if var_442_6 < arg_439_1.time_ and arg_439_1.time_ <= var_442_6 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_8 = arg_439_1:FormatText(StoryNameCfg[612].name)

				arg_439_1.leftNameTxt_.text = var_442_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_9 = arg_439_1:GetWordFromCfg(1106101106)
				local var_442_10 = arg_439_1:FormatText(var_442_9.content)

				arg_439_1.text_.text = var_442_10

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_11 = 12
				local var_442_12 = utf8.len(var_442_10)
				local var_442_13 = var_442_11 <= 0 and var_442_7 or var_442_7 * (var_442_12 / var_442_11)

				if var_442_13 > 0 and var_442_7 < var_442_13 then
					arg_439_1.talkMaxDuration = var_442_13

					if var_442_13 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_13 + var_442_6
					end
				end

				arg_439_1.text_.text = var_442_10
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101106", "story_v_side_new_1106101.awb") ~= 0 then
					local var_442_14 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101106", "story_v_side_new_1106101.awb") / 1000

					if var_442_14 + var_442_6 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_14 + var_442_6
					end

					if var_442_9.prefab_name ~= "" and arg_439_1.actors_[var_442_9.prefab_name] ~= nil then
						local var_442_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_9.prefab_name].transform, "story_v_side_new_1106101", "1106101106", "story_v_side_new_1106101.awb")

						arg_439_1:RecordAudio("1106101106", var_442_15)
						arg_439_1:RecordAudio("1106101106", var_442_15)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101106", "story_v_side_new_1106101.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101106", "story_v_side_new_1106101.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_16 = math.max(var_442_7, arg_439_1.talkMaxDuration)

			if var_442_6 <= arg_439_1.time_ and arg_439_1.time_ < var_442_6 + var_442_16 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_6) / var_442_16

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_6 + var_442_16 and arg_439_1.time_ < var_442_6 + var_442_16 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1106101107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1106101107
		arg_443_1.duration_ = 1

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"

			SetActive(arg_443_1.choicesGo_, true)

			for iter_444_0, iter_444_1 in ipairs(arg_443_1.choices_) do
				local var_444_0 = iter_444_0 <= 1

				SetActive(iter_444_1.go, var_444_0)
			end

			arg_443_1.choices_[1].txt.text = arg_443_1:FormatText(StoryChoiceCfg[1386].name)
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1106101108(arg_443_1)
			end

			arg_443_1:RecordChoiceLog(1106101107, 1386)
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["1061ui_story"]
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.characterEffect1061ui_story == nil then
				arg_443_1.var_.characterEffect1061ui_story = var_446_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_2 = 0.200000002980232

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 and not isNil(var_446_0) then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2

				if arg_443_1.var_.characterEffect1061ui_story and not isNil(var_446_0) then
					local var_446_4 = Mathf.Lerp(0, 0.5, var_446_3)

					arg_443_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_443_1.var_.characterEffect1061ui_story.fillRatio = var_446_4
				end
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 and not isNil(var_446_0) and arg_443_1.var_.characterEffect1061ui_story then
				local var_446_5 = 0.5

				arg_443_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_443_1.var_.characterEffect1061ui_story.fillRatio = var_446_5
			end

			local var_446_6 = 0

			if var_446_6 < arg_443_1.time_ and arg_443_1.time_ <= var_446_6 + arg_446_0 then
				arg_443_1.allBtn_.enabled = false
			end

			local var_446_7 = 0.6

			if arg_443_1.time_ >= var_446_6 + var_446_7 and arg_443_1.time_ < var_446_6 + var_446_7 + arg_446_0 then
				arg_443_1.allBtn_.enabled = true
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play1106101108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1106101108
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1106101109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = arg_447_1.actors_["1061ui_story"].transform
			local var_450_1 = 0

			if var_450_1 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.var_.moveOldPos1061ui_story = var_450_0.localPosition
			end

			local var_450_2 = 0.001

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_2 then
				local var_450_3 = (arg_447_1.time_ - var_450_1) / var_450_2
				local var_450_4 = Vector3.New(0, 100, 0)

				var_450_0.localPosition = Vector3.Lerp(arg_447_1.var_.moveOldPos1061ui_story, var_450_4, var_450_3)

				local var_450_5 = manager.ui.mainCamera.transform.position - var_450_0.position

				var_450_0.forward = Vector3.New(var_450_5.x, var_450_5.y, var_450_5.z)

				local var_450_6 = var_450_0.localEulerAngles

				var_450_6.z = 0
				var_450_6.x = 0
				var_450_0.localEulerAngles = var_450_6
			end

			if arg_447_1.time_ >= var_450_1 + var_450_2 and arg_447_1.time_ < var_450_1 + var_450_2 + arg_450_0 then
				var_450_0.localPosition = Vector3.New(0, 100, 0)

				local var_450_7 = manager.ui.mainCamera.transform.position - var_450_0.position

				var_450_0.forward = Vector3.New(var_450_7.x, var_450_7.y, var_450_7.z)

				local var_450_8 = var_450_0.localEulerAngles

				var_450_8.z = 0
				var_450_8.x = 0
				var_450_0.localEulerAngles = var_450_8
			end

			local var_450_9 = 0.466666666666667
			local var_450_10 = 1

			if var_450_9 < arg_447_1.time_ and arg_447_1.time_ <= var_450_9 + arg_450_0 then
				local var_450_11 = "play"
				local var_450_12 = "music"

				arg_447_1:AudioAction(var_450_11, var_450_12, "se_story_123_01", "se_story_123_01_map", "")

				local var_450_13 = ""
				local var_450_14 = manager.audio:GetAudioName("se_story_123_01", "se_story_123_01_map")

				if var_450_14 ~= "" then
					if arg_447_1.bgmTxt_.text ~= var_450_14 and arg_447_1.bgmTxt_.text ~= "" then
						if arg_447_1.bgmTxt2_.text ~= "" then
							arg_447_1.bgmTxt_.text = arg_447_1.bgmTxt2_.text
						end

						arg_447_1.bgmTxt2_.text = var_450_14

						arg_447_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_447_1.bgmTxt_.text = var_450_14
						arg_447_1.bgmTxt2_.text = var_450_14
					end

					if arg_447_1.bgmTimer then
						arg_447_1.bgmTimer:Stop()

						arg_447_1.bgmTimer = nil
					end

					if arg_447_1.settingData.show_music_name == 1 then
						arg_447_1.musicController:SetSelectedState("show")
						arg_447_1.musicAnimator_:Play("open", 0, 0)

						if arg_447_1.settingData.music_time ~= 0 then
							arg_447_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_447_1.settingData.music_time), function()
								if arg_447_1 == nil or isNil(arg_447_1.bgmTxt_) then
									return
								end

								arg_447_1.musicController:SetSelectedState("hide")
								arg_447_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_450_15 = 0
			local var_450_16 = 0.6

			if var_450_15 < arg_447_1.time_ and arg_447_1.time_ <= var_450_15 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, false)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_17 = arg_447_1:GetWordFromCfg(1106101108)
				local var_450_18 = arg_447_1:FormatText(var_450_17.content)

				arg_447_1.text_.text = var_450_18

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_19 = 24
				local var_450_20 = utf8.len(var_450_18)
				local var_450_21 = var_450_19 <= 0 and var_450_16 or var_450_16 * (var_450_20 / var_450_19)

				if var_450_21 > 0 and var_450_16 < var_450_21 then
					arg_447_1.talkMaxDuration = var_450_21

					if var_450_21 + var_450_15 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_21 + var_450_15
					end
				end

				arg_447_1.text_.text = var_450_18
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_22 = math.max(var_450_16, arg_447_1.talkMaxDuration)

			if var_450_15 <= arg_447_1.time_ and arg_447_1.time_ < var_450_15 + var_450_22 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_15) / var_450_22

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_15 + var_450_22 and arg_447_1.time_ < var_450_15 + var_450_22 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_447_1:InitPlayNodeList()
	end,
	Play1106101109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1106101109
		arg_452_1.duration_ = 5.27

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1106101110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["1061ui_story"].transform
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.var_.moveOldPos1061ui_story = var_455_0.localPosition
			end

			local var_455_2 = 0.001

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2
				local var_455_4 = Vector3.New(0, -1.18, -6.15)

				var_455_0.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1061ui_story, var_455_4, var_455_3)

				local var_455_5 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_5.x, var_455_5.y, var_455_5.z)

				local var_455_6 = var_455_0.localEulerAngles

				var_455_6.z = 0
				var_455_6.x = 0
				var_455_0.localEulerAngles = var_455_6
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 then
				var_455_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_455_7 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_7.x, var_455_7.y, var_455_7.z)

				local var_455_8 = var_455_0.localEulerAngles

				var_455_8.z = 0
				var_455_8.x = 0
				var_455_0.localEulerAngles = var_455_8
			end

			local var_455_9 = arg_452_1.actors_["1061ui_story"]
			local var_455_10 = 0

			if var_455_10 < arg_452_1.time_ and arg_452_1.time_ <= var_455_10 + arg_455_0 and not isNil(var_455_9) and arg_452_1.var_.characterEffect1061ui_story == nil then
				arg_452_1.var_.characterEffect1061ui_story = var_455_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_11 = 0.200000002980232

			if var_455_10 <= arg_452_1.time_ and arg_452_1.time_ < var_455_10 + var_455_11 and not isNil(var_455_9) then
				local var_455_12 = (arg_452_1.time_ - var_455_10) / var_455_11

				if arg_452_1.var_.characterEffect1061ui_story and not isNil(var_455_9) then
					arg_452_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= var_455_10 + var_455_11 and arg_452_1.time_ < var_455_10 + var_455_11 + arg_455_0 and not isNil(var_455_9) and arg_452_1.var_.characterEffect1061ui_story then
				arg_452_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_455_13 = 0

			if var_455_13 < arg_452_1.time_ and arg_452_1.time_ <= var_455_13 + arg_455_0 then
				arg_452_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action8_2")
			end

			local var_455_14 = 0

			if var_455_14 < arg_452_1.time_ and arg_452_1.time_ <= var_455_14 + arg_455_0 then
				arg_452_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_455_15 = 0
			local var_455_16 = 0.725

			if var_455_15 < arg_452_1.time_ and arg_452_1.time_ <= var_455_15 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_17 = arg_452_1:FormatText(StoryNameCfg[612].name)

				arg_452_1.leftNameTxt_.text = var_455_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_18 = arg_452_1:GetWordFromCfg(1106101109)
				local var_455_19 = arg_452_1:FormatText(var_455_18.content)

				arg_452_1.text_.text = var_455_19

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_20 = 29
				local var_455_21 = utf8.len(var_455_19)
				local var_455_22 = var_455_20 <= 0 and var_455_16 or var_455_16 * (var_455_21 / var_455_20)

				if var_455_22 > 0 and var_455_16 < var_455_22 then
					arg_452_1.talkMaxDuration = var_455_22

					if var_455_22 + var_455_15 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_22 + var_455_15
					end
				end

				arg_452_1.text_.text = var_455_19
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101109", "story_v_side_new_1106101.awb") ~= 0 then
					local var_455_23 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101109", "story_v_side_new_1106101.awb") / 1000

					if var_455_23 + var_455_15 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_23 + var_455_15
					end

					if var_455_18.prefab_name ~= "" and arg_452_1.actors_[var_455_18.prefab_name] ~= nil then
						local var_455_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_18.prefab_name].transform, "story_v_side_new_1106101", "1106101109", "story_v_side_new_1106101.awb")

						arg_452_1:RecordAudio("1106101109", var_455_24)
						arg_452_1:RecordAudio("1106101109", var_455_24)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101109", "story_v_side_new_1106101.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101109", "story_v_side_new_1106101.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_25 = math.max(var_455_16, arg_452_1.talkMaxDuration)

			if var_455_15 <= arg_452_1.time_ and arg_452_1.time_ < var_455_15 + var_455_25 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_15) / var_455_25

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_15 + var_455_25 and arg_452_1.time_ < var_455_15 + var_455_25 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
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
	Play1106101110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1106101110
		arg_456_1.duration_ = 6.17

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1106101111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0
			local var_459_1 = 0.65

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_2 = arg_456_1:FormatText(StoryNameCfg[612].name)

				arg_456_1.leftNameTxt_.text = var_459_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_3 = arg_456_1:GetWordFromCfg(1106101110)
				local var_459_4 = arg_456_1:FormatText(var_459_3.content)

				arg_456_1.text_.text = var_459_4

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101110", "story_v_side_new_1106101.awb") ~= 0 then
					local var_459_8 = manager.audio:GetVoiceLength("story_v_side_new_1106101", "1106101110", "story_v_side_new_1106101.awb") / 1000

					if var_459_8 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_8 + var_459_0
					end

					if var_459_3.prefab_name ~= "" and arg_456_1.actors_[var_459_3.prefab_name] ~= nil then
						local var_459_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_3.prefab_name].transform, "story_v_side_new_1106101", "1106101110", "story_v_side_new_1106101.awb")

						arg_456_1:RecordAudio("1106101110", var_459_9)
						arg_456_1:RecordAudio("1106101110", var_459_9)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_side_new_1106101", "1106101110", "story_v_side_new_1106101.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_side_new_1106101", "1106101110", "story_v_side_new_1106101.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_10 = math.max(var_459_1, arg_456_1.talkMaxDuration)

			if var_459_0 <= arg_456_1.time_ and arg_456_1.time_ < var_459_0 + var_459_10 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_0) / var_459_10

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_0 + var_459_10 and arg_456_1.time_ < var_459_0 + var_459_10 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1106101111 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1106101111
		arg_460_1.duration_ = 1

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"

			SetActive(arg_460_1.choicesGo_, true)

			for iter_461_0, iter_461_1 in ipairs(arg_460_1.choices_) do
				local var_461_0 = iter_461_0 <= 2

				SetActive(iter_461_1.go, var_461_0)
			end

			arg_460_1.choices_[1].txt.text = arg_460_1:FormatText(StoryChoiceCfg[1387].name)
			arg_460_1.choices_[2].txt.text = arg_460_1:FormatText(StoryChoiceCfg[1388].name)
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1106101112(arg_460_1)
			end

			if arg_462_0 == 2 then
				arg_460_0:Play1106101112(arg_460_1)
			end

			arg_460_1:RecordChoiceLog(1106101111, 1387, 1388)
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = arg_460_1.actors_["1061ui_story"]
			local var_463_1 = 0

			if var_463_1 < arg_460_1.time_ and arg_460_1.time_ <= var_463_1 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect1061ui_story == nil then
				arg_460_1.var_.characterEffect1061ui_story = var_463_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_2 = 0.200000002980232

			if var_463_1 <= arg_460_1.time_ and arg_460_1.time_ < var_463_1 + var_463_2 and not isNil(var_463_0) then
				local var_463_3 = (arg_460_1.time_ - var_463_1) / var_463_2

				if arg_460_1.var_.characterEffect1061ui_story and not isNil(var_463_0) then
					local var_463_4 = Mathf.Lerp(0, 0.5, var_463_3)

					arg_460_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_460_1.var_.characterEffect1061ui_story.fillRatio = var_463_4
				end
			end

			if arg_460_1.time_ >= var_463_1 + var_463_2 and arg_460_1.time_ < var_463_1 + var_463_2 + arg_463_0 and not isNil(var_463_0) and arg_460_1.var_.characterEffect1061ui_story then
				local var_463_5 = 0.5

				arg_460_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_460_1.var_.characterEffect1061ui_story.fillRatio = var_463_5
			end

			local var_463_6 = 0

			if var_463_6 < arg_460_1.time_ and arg_460_1.time_ <= var_463_6 + arg_463_0 then
				arg_460_1.allBtn_.enabled = false
			end

			local var_463_7 = 0.6

			if arg_460_1.time_ >= var_463_6 + var_463_7 and arg_460_1.time_ < var_463_6 + var_463_7 + arg_463_0 then
				arg_460_1.allBtn_.enabled = true
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play1106101112 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1106101112
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
			arg_464_1.auto_ = false
		end

		function arg_464_1.playNext_(arg_466_0)
			arg_464_1.onStoryFinished_()
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0
			local var_467_1 = 0.433333333333333

			if var_467_0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_0 + arg_467_0 then
				local var_467_2 = "play"
				local var_467_3 = "music"

				arg_464_1:AudioAction(var_467_2, var_467_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_467_4 = ""
				local var_467_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_467_5 ~= "" then
					if arg_464_1.bgmTxt_.text ~= var_467_5 and arg_464_1.bgmTxt_.text ~= "" then
						if arg_464_1.bgmTxt2_.text ~= "" then
							arg_464_1.bgmTxt_.text = arg_464_1.bgmTxt2_.text
						end

						arg_464_1.bgmTxt2_.text = var_467_5

						arg_464_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_464_1.bgmTxt_.text = var_467_5
						arg_464_1.bgmTxt2_.text = var_467_5
					end

					if arg_464_1.bgmTimer then
						arg_464_1.bgmTimer:Stop()

						arg_464_1.bgmTimer = nil
					end

					if arg_464_1.settingData.show_music_name == 1 then
						arg_464_1.musicController:SetSelectedState("show")
						arg_464_1.musicAnimator_:Play("open", 0, 0)

						if arg_464_1.settingData.music_time ~= 0 then
							arg_464_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_464_1.settingData.music_time), function()
								if arg_464_1 == nil or isNil(arg_464_1.bgmTxt_) then
									return
								end

								arg_464_1.musicController:SetSelectedState("hide")
								arg_464_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_467_6 = 0.6
			local var_467_7 = 1

			if var_467_6 < arg_464_1.time_ and arg_464_1.time_ <= var_467_6 + arg_467_0 then
				local var_467_8 = "play"
				local var_467_9 = "music"

				arg_464_1:AudioAction(var_467_8, var_467_9, "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_467_10 = ""
				local var_467_11 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if var_467_11 ~= "" then
					if arg_464_1.bgmTxt_.text ~= var_467_11 and arg_464_1.bgmTxt_.text ~= "" then
						if arg_464_1.bgmTxt2_.text ~= "" then
							arg_464_1.bgmTxt_.text = arg_464_1.bgmTxt2_.text
						end

						arg_464_1.bgmTxt2_.text = var_467_11

						arg_464_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_464_1.bgmTxt_.text = var_467_11
						arg_464_1.bgmTxt2_.text = var_467_11
					end

					if arg_464_1.bgmTimer then
						arg_464_1.bgmTimer:Stop()

						arg_464_1.bgmTimer = nil
					end

					if arg_464_1.settingData.show_music_name == 1 then
						arg_464_1.musicController:SetSelectedState("show")
						arg_464_1.musicAnimator_:Play("open", 0, 0)

						if arg_464_1.settingData.music_time ~= 0 then
							arg_464_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_464_1.settingData.music_time), function()
								if arg_464_1 == nil or isNil(arg_464_1.bgmTxt_) then
									return
								end

								arg_464_1.musicController:SetSelectedState("hide")
								arg_464_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_467_12 = 0
			local var_467_13 = 0.475

			if var_467_12 < arg_464_1.time_ and arg_464_1.time_ <= var_467_12 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				local var_467_14 = arg_464_1:FormatText(StoryNameCfg[7].name)

				arg_464_1.leftNameTxt_.text = var_467_14

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

				local var_467_15 = arg_464_1:GetWordFromCfg(1106101112)
				local var_467_16 = arg_464_1:FormatText(var_467_15.content)

				arg_464_1.text_.text = var_467_16

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_17 = 19
				local var_467_18 = utf8.len(var_467_16)
				local var_467_19 = var_467_17 <= 0 and var_467_13 or var_467_13 * (var_467_18 / var_467_17)

				if var_467_19 > 0 and var_467_13 < var_467_19 then
					arg_464_1.talkMaxDuration = var_467_19

					if var_467_19 + var_467_12 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_19 + var_467_12
					end
				end

				arg_464_1.text_.text = var_467_16
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_20 = math.max(var_467_13, arg_464_1.talkMaxDuration)

			if var_467_12 <= arg_464_1.time_ and arg_464_1.time_ < var_467_12 + var_467_20 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_12) / var_467_20

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_12 + var_467_20 and arg_464_1.time_ < var_467_12 + var_467_20 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST41a",
		"TextureConfig/Background/ST37a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST31",
		"TextureConfig/Background/ST0103"
	},
	voices = {
		"story_v_side_new_1106101.awb"
	}
}
