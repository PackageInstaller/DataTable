return {
	Play1108504001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108504001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108504002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST12"

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
				local var_4_5 = arg_1_1.bgs_.ST12

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
					if iter_4_0 ~= "ST12" then
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

			local var_4_24 = 0
			local var_4_25 = 0.3

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.3
			local var_4_31 = 1

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "effect"

				arg_1_1:AudioAction(var_4_32, var_4_33, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_4_34 = 2.3
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_140", "se_story_140_foley_hold", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 0.825

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_41 = arg_1_1:GetWordFromCfg(1108504001)
				local var_4_42 = arg_1_1:FormatText(var_4_41.content)

				arg_1_1.text_.text = var_4_42

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_43 = 33
				local var_4_44 = utf8.len(var_4_42)
				local var_4_45 = var_4_43 <= 0 and var_4_39 or var_4_39 * (var_4_44 / var_4_43)

				if var_4_45 > 0 and var_4_39 < var_4_45 then
					arg_1_1.talkMaxDuration = var_4_45
					var_4_38 = var_4_38 + 0.3

					if var_4_45 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_45 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_42
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_46 = var_4_38 + 0.3
			local var_4_47 = math.max(var_4_39, arg_1_1.talkMaxDuration)

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_46) / var_4_47

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1108504002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1108504002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1108504003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.5

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_2 = arg_8_1:FormatText(StoryNameCfg[7].name)

				arg_8_1.leftNameTxt_.text = var_11_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(1108504002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 20
				local var_11_6 = utf8.len(var_11_4)
				local var_11_7 = var_11_5 <= 0 and var_11_1 or var_11_1 * (var_11_6 / var_11_5)

				if var_11_7 > 0 and var_11_1 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_8 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_8 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_8

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_8 and arg_8_1.time_ < var_11_0 + var_11_8 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play1108504003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1108504003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1108504004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.3

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

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:GetWordFromCfg(1108504003)
				local var_15_4 = arg_12_1:FormatText(var_15_3.content)

				arg_12_1.text_.text = var_15_4

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 12
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
	Play1108504004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1108504004
		arg_16_1.duration_ = 5.97

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1108504005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1085ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1085ui_story"].transform
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1085ui_story = var_19_5.localPosition
			end

			local var_19_7 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7
				local var_19_9 = Vector3.New(0, -1.01, -5.83)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1085ui_story, var_19_9, var_19_8)

				local var_19_10 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_10.x, var_19_10.y, var_19_10.z)

				local var_19_11 = var_19_5.localEulerAngles

				var_19_11.z = 0
				var_19_11.x = 0
				var_19_5.localEulerAngles = var_19_11
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_19_12 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_12.x, var_19_12.y, var_19_12.z)

				local var_19_13 = var_19_5.localEulerAngles

				var_19_13.z = 0
				var_19_13.x = 0
				var_19_5.localEulerAngles = var_19_13
			end

			local var_19_14 = arg_16_1.actors_["1085ui_story"]
			local var_19_15 = 0

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1085ui_story == nil then
				arg_16_1.var_.characterEffect1085ui_story = var_19_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_16 = 0.200000002980232

			if var_19_15 <= arg_16_1.time_ and arg_16_1.time_ < var_19_15 + var_19_16 and not isNil(var_19_14) then
				local var_19_17 = (arg_16_1.time_ - var_19_15) / var_19_16

				if arg_16_1.var_.characterEffect1085ui_story and not isNil(var_19_14) then
					arg_16_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_15 + var_19_16 and arg_16_1.time_ < var_19_15 + var_19_16 + arg_19_0 and not isNil(var_19_14) and arg_16_1.var_.characterEffect1085ui_story then
				arg_16_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_19_18 = 0

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_19_19 = 0

			if var_19_19 < arg_16_1.time_ and arg_16_1.time_ <= var_19_19 + arg_19_0 then
				arg_16_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_19_20 = 0
			local var_19_21 = 0.35

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_22 = arg_16_1:FormatText(StoryNameCfg[328].name)

				arg_16_1.leftNameTxt_.text = var_19_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_23 = arg_16_1:GetWordFromCfg(1108504004)
				local var_19_24 = arg_16_1:FormatText(var_19_23.content)

				arg_16_1.text_.text = var_19_24

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_25 = 14
				local var_19_26 = utf8.len(var_19_24)
				local var_19_27 = var_19_25 <= 0 and var_19_21 or var_19_21 * (var_19_26 / var_19_25)

				if var_19_27 > 0 and var_19_21 < var_19_27 then
					arg_16_1.talkMaxDuration = var_19_27

					if var_19_27 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_27 + var_19_20
					end
				end

				arg_16_1.text_.text = var_19_24
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504004", "story_v_side_new_1108504.awb") ~= 0 then
					local var_19_28 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504004", "story_v_side_new_1108504.awb") / 1000

					if var_19_28 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_20
					end

					if var_19_23.prefab_name ~= "" and arg_16_1.actors_[var_19_23.prefab_name] ~= nil then
						local var_19_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_23.prefab_name].transform, "story_v_side_new_1108504", "1108504004", "story_v_side_new_1108504.awb")

						arg_16_1:RecordAudio("1108504004", var_19_29)
						arg_16_1:RecordAudio("1108504004", var_19_29)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504004", "story_v_side_new_1108504.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504004", "story_v_side_new_1108504.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_30 = math.max(var_19_21, arg_16_1.talkMaxDuration)

			if var_19_20 <= arg_16_1.time_ and arg_16_1.time_ < var_19_20 + var_19_30 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_20) / var_19_30

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_20 + var_19_30 and arg_16_1.time_ < var_19_20 + var_19_30 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play1108504005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1108504005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1108504006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1085ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1085ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(0, 100, 0)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1085ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, 100, 0)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = arg_20_1.actors_["1085ui_story"]
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1085ui_story == nil then
				arg_20_1.var_.characterEffect1085ui_story = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.200000002980232

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 and not isNil(var_23_9) then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11

				if arg_20_1.var_.characterEffect1085ui_story and not isNil(var_23_9) then
					local var_23_13 = Mathf.Lerp(0, 0.5, var_23_12)

					arg_20_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1085ui_story.fillRatio = var_23_13
				end
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1085ui_story then
				local var_23_14 = 0.5

				arg_20_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1085ui_story.fillRatio = var_23_14
			end

			local var_23_15 = 0
			local var_23_16 = 1.05

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_17 = arg_20_1:GetWordFromCfg(1108504005)
				local var_23_18 = arg_20_1:FormatText(var_23_17.content)

				arg_20_1.text_.text = var_23_18

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_19 = 42
				local var_23_20 = utf8.len(var_23_18)
				local var_23_21 = var_23_19 <= 0 and var_23_16 or var_23_16 * (var_23_20 / var_23_19)

				if var_23_21 > 0 and var_23_16 < var_23_21 then
					arg_20_1.talkMaxDuration = var_23_21

					if var_23_21 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_21 + var_23_15
					end
				end

				arg_20_1.text_.text = var_23_18
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_22 = math.max(var_23_16, arg_20_1.talkMaxDuration)

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_22 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_15) / var_23_22

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_15 + var_23_22 and arg_20_1.time_ < var_23_15 + var_23_22 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play1108504006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1108504006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1108504007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.35

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(1108504006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 14
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_8 and arg_24_1.time_ < var_27_0 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1108504007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1108504007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1108504008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 0.7

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_2 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(1108504007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 28
				local var_31_6 = utf8.len(var_31_4)
				local var_31_7 = var_31_5 <= 0 and var_31_1 or var_31_1 * (var_31_6 / var_31_5)

				if var_31_7 > 0 and var_31_1 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_8 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_8 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_8

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_8 and arg_28_1.time_ < var_31_0 + var_31_8 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play1108504008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1108504008
		arg_32_1.duration_ = 5.37

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1108504009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1085ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1085ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0, -1.01, -5.83)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1085ui_story, var_35_4, var_35_3)

				local var_35_5 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_5.x, var_35_5.y, var_35_5.z)

				local var_35_6 = var_35_0.localEulerAngles

				var_35_6.z = 0
				var_35_6.x = 0
				var_35_0.localEulerAngles = var_35_6
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_35_7 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_7.x, var_35_7.y, var_35_7.z)

				local var_35_8 = var_35_0.localEulerAngles

				var_35_8.z = 0
				var_35_8.x = 0
				var_35_0.localEulerAngles = var_35_8
			end

			local var_35_9 = arg_32_1.actors_["1085ui_story"]
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1085ui_story == nil then
				arg_32_1.var_.characterEffect1085ui_story = var_35_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.200000002980232

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_11 and not isNil(var_35_9) then
				local var_35_12 = (arg_32_1.time_ - var_35_10) / var_35_11

				if arg_32_1.var_.characterEffect1085ui_story and not isNil(var_35_9) then
					arg_32_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1085ui_story then
				arg_32_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_35_13 = 0

			if var_35_13 < arg_32_1.time_ and arg_32_1.time_ <= var_35_13 + arg_35_0 then
				arg_32_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_2")
			end

			local var_35_14 = 0

			if var_35_14 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_35_15 = 0
			local var_35_16 = 0.25

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_17 = arg_32_1:FormatText(StoryNameCfg[328].name)

				arg_32_1.leftNameTxt_.text = var_35_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_18 = arg_32_1:GetWordFromCfg(1108504008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 10
				local var_35_21 = utf8.len(var_35_19)
				local var_35_22 = var_35_20 <= 0 and var_35_16 or var_35_16 * (var_35_21 / var_35_20)

				if var_35_22 > 0 and var_35_16 < var_35_22 then
					arg_32_1.talkMaxDuration = var_35_22

					if var_35_22 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_15
					end
				end

				arg_32_1.text_.text = var_35_19
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504008", "story_v_side_new_1108504.awb") ~= 0 then
					local var_35_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504008", "story_v_side_new_1108504.awb") / 1000

					if var_35_23 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_15
					end

					if var_35_18.prefab_name ~= "" and arg_32_1.actors_[var_35_18.prefab_name] ~= nil then
						local var_35_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_18.prefab_name].transform, "story_v_side_new_1108504", "1108504008", "story_v_side_new_1108504.awb")

						arg_32_1:RecordAudio("1108504008", var_35_24)
						arg_32_1:RecordAudio("1108504008", var_35_24)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504008", "story_v_side_new_1108504.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504008", "story_v_side_new_1108504.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_25 = math.max(var_35_16, arg_32_1.talkMaxDuration)

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_25 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_15) / var_35_25

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_15 + var_35_25 and arg_32_1.time_ < var_35_15 + var_35_25 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1108504009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1108504010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1085ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1085ui_story == nil then
				arg_36_1.var_.characterEffect1085ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1085ui_story and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1085ui_story.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1085ui_story then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1085ui_story.fillRatio = var_39_5
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

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_9 = arg_36_1:GetWordFromCfg(1108504009)
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
	Play1108504010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1108504010
		arg_40_1.duration_ = 9

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1108504011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "ST15"

			if arg_40_1.bgs_[var_43_0] == nil then
				local var_43_1 = Object.Instantiate(arg_40_1.paintGo_)

				var_43_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_43_0)
				var_43_1.name = var_43_0
				var_43_1.transform.parent = arg_40_1.stage_.transform
				var_43_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.bgs_[var_43_0] = var_43_1
			end

			local var_43_2 = 2

			if var_43_2 < arg_40_1.time_ and arg_40_1.time_ <= var_43_2 + arg_43_0 then
				local var_43_3 = manager.ui.mainCamera.transform.localPosition
				local var_43_4 = Vector3.New(0, 0, 10) + Vector3.New(var_43_3.x, var_43_3.y, 0)
				local var_43_5 = arg_40_1.bgs_.ST15

				var_43_5.transform.localPosition = var_43_4
				var_43_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_43_6 = var_43_5:GetComponent("SpriteRenderer")

				if var_43_6 and var_43_6.sprite then
					local var_43_7 = (var_43_5.transform.localPosition - var_43_3).z
					local var_43_8 = manager.ui.mainCameraCom_
					local var_43_9 = 2 * var_43_7 * Mathf.Tan(var_43_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_43_10 = var_43_9 * var_43_8.aspect
					local var_43_11 = var_43_6.sprite.bounds.size.x
					local var_43_12 = var_43_6.sprite.bounds.size.y
					local var_43_13 = var_43_10 / var_43_11
					local var_43_14 = var_43_9 / var_43_12
					local var_43_15 = var_43_14 < var_43_13 and var_43_13 or var_43_14

					var_43_5.transform.localScale = Vector3.New(var_43_15, var_43_15, 0)
				end

				for iter_43_0, iter_43_1 in pairs(arg_40_1.bgs_) do
					if iter_43_0 ~= "ST15" then
						iter_43_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_43_16 = 4

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			local var_43_17 = 0.3

			if arg_40_1.time_ >= var_43_16 + var_43_17 and arg_40_1.time_ < var_43_16 + var_43_17 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			local var_43_18 = 0

			if var_43_18 < arg_40_1.time_ and arg_40_1.time_ <= var_43_18 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_19 = 2

			if var_43_18 <= arg_40_1.time_ and arg_40_1.time_ < var_43_18 + var_43_19 then
				local var_43_20 = (arg_40_1.time_ - var_43_18) / var_43_19
				local var_43_21 = Color.New(0, 0, 0)

				var_43_21.a = Mathf.Lerp(0, 1, var_43_20)
				arg_40_1.mask_.color = var_43_21
			end

			if arg_40_1.time_ >= var_43_18 + var_43_19 and arg_40_1.time_ < var_43_18 + var_43_19 + arg_43_0 then
				local var_43_22 = Color.New(0, 0, 0)

				var_43_22.a = 1
				arg_40_1.mask_.color = var_43_22
			end

			local var_43_23 = 2

			if var_43_23 < arg_40_1.time_ and arg_40_1.time_ <= var_43_23 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_24 = 2

			if var_43_23 <= arg_40_1.time_ and arg_40_1.time_ < var_43_23 + var_43_24 then
				local var_43_25 = (arg_40_1.time_ - var_43_23) / var_43_24
				local var_43_26 = Color.New(0, 0, 0)

				var_43_26.a = Mathf.Lerp(1, 0, var_43_25)
				arg_40_1.mask_.color = var_43_26
			end

			if arg_40_1.time_ >= var_43_23 + var_43_24 and arg_40_1.time_ < var_43_23 + var_43_24 + arg_43_0 then
				local var_43_27 = Color.New(0, 0, 0)
				local var_43_28 = 0

				arg_40_1.mask_.enabled = false
				var_43_27.a = var_43_28
				arg_40_1.mask_.color = var_43_27
			end

			local var_43_29 = arg_40_1.actors_["1085ui_story"].transform
			local var_43_30 = 1.96599999815226

			if var_43_30 < arg_40_1.time_ and arg_40_1.time_ <= var_43_30 + arg_43_0 then
				arg_40_1.var_.moveOldPos1085ui_story = var_43_29.localPosition
			end

			local var_43_31 = 0.001

			if var_43_30 <= arg_40_1.time_ and arg_40_1.time_ < var_43_30 + var_43_31 then
				local var_43_32 = (arg_40_1.time_ - var_43_30) / var_43_31
				local var_43_33 = Vector3.New(0, 100, 0)

				var_43_29.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1085ui_story, var_43_33, var_43_32)

				local var_43_34 = manager.ui.mainCamera.transform.position - var_43_29.position

				var_43_29.forward = Vector3.New(var_43_34.x, var_43_34.y, var_43_34.z)

				local var_43_35 = var_43_29.localEulerAngles

				var_43_35.z = 0
				var_43_35.x = 0
				var_43_29.localEulerAngles = var_43_35
			end

			if arg_40_1.time_ >= var_43_30 + var_43_31 and arg_40_1.time_ < var_43_30 + var_43_31 + arg_43_0 then
				var_43_29.localPosition = Vector3.New(0, 100, 0)

				local var_43_36 = manager.ui.mainCamera.transform.position - var_43_29.position

				var_43_29.forward = Vector3.New(var_43_36.x, var_43_36.y, var_43_36.z)

				local var_43_37 = var_43_29.localEulerAngles

				var_43_37.z = 0
				var_43_37.x = 0
				var_43_29.localEulerAngles = var_43_37
			end

			local var_43_38 = 0.333333333333333
			local var_43_39 = 0.3

			if var_43_38 < arg_40_1.time_ and arg_40_1.time_ <= var_43_38 + arg_43_0 then
				local var_43_40 = "play"
				local var_43_41 = "music"

				arg_40_1:AudioAction(var_43_40, var_43_41, "ui_battle", "ui_battle_stopbgm", "")

				local var_43_42 = ""
				local var_43_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_43_43 ~= "" then
					if arg_40_1.bgmTxt_.text ~= var_43_43 and arg_40_1.bgmTxt_.text ~= "" then
						if arg_40_1.bgmTxt2_.text ~= "" then
							arg_40_1.bgmTxt_.text = arg_40_1.bgmTxt2_.text
						end

						arg_40_1.bgmTxt2_.text = var_43_43

						arg_40_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_40_1.bgmTxt_.text = var_43_43
						arg_40_1.bgmTxt2_.text = var_43_43
					end

					if arg_40_1.bgmTimer then
						arg_40_1.bgmTimer:Stop()

						arg_40_1.bgmTimer = nil
					end

					if arg_40_1.settingData.show_music_name == 1 then
						arg_40_1.musicController:SetSelectedState("show")
						arg_40_1.musicAnimator_:Play("open", 0, 0)

						if arg_40_1.settingData.music_time ~= 0 then
							arg_40_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_40_1.settingData.music_time), function()
								if arg_40_1 == nil or isNil(arg_40_1.bgmTxt_) then
									return
								end

								arg_40_1.musicController:SetSelectedState("hide")
								arg_40_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_43_44 = 1.7
			local var_43_45 = 1

			if var_43_44 < arg_40_1.time_ and arg_40_1.time_ <= var_43_44 + arg_43_0 then
				local var_43_46 = "play"
				local var_43_47 = "music"

				arg_40_1:AudioAction(var_43_46, var_43_47, "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night.awb")

				local var_43_48 = ""
				local var_43_49 = manager.audio:GetAudioName("bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night")

				if var_43_49 ~= "" then
					if arg_40_1.bgmTxt_.text ~= var_43_49 and arg_40_1.bgmTxt_.text ~= "" then
						if arg_40_1.bgmTxt2_.text ~= "" then
							arg_40_1.bgmTxt_.text = arg_40_1.bgmTxt2_.text
						end

						arg_40_1.bgmTxt2_.text = var_43_49

						arg_40_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_40_1.bgmTxt_.text = var_43_49
						arg_40_1.bgmTxt2_.text = var_43_49
					end

					if arg_40_1.bgmTimer then
						arg_40_1.bgmTimer:Stop()

						arg_40_1.bgmTimer = nil
					end

					if arg_40_1.settingData.show_music_name == 1 then
						arg_40_1.musicController:SetSelectedState("show")
						arg_40_1.musicAnimator_:Play("open", 0, 0)

						if arg_40_1.settingData.music_time ~= 0 then
							arg_40_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_40_1.settingData.music_time), function()
								if arg_40_1 == nil or isNil(arg_40_1.bgmTxt_) then
									return
								end

								arg_40_1.musicController:SetSelectedState("hide")
								arg_40_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_43_50 = 0.333333333333333
			local var_43_51 = 1

			if var_43_50 < arg_40_1.time_ and arg_40_1.time_ <= var_43_50 + arg_43_0 then
				local var_43_52 = "stop"
				local var_43_53 = "effect"

				arg_40_1:AudioAction(var_43_52, var_43_53, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_43_54 = 1.7
			local var_43_55 = 1

			if var_43_54 < arg_40_1.time_ and arg_40_1.time_ <= var_43_54 + arg_43_0 then
				local var_43_56 = "play"
				local var_43_57 = "effect"

				arg_40_1:AudioAction(var_43_56, var_43_57, "se_story_133", "se_story_133_sea", "")
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_58 = 4
			local var_43_59 = 0.675

			if var_43_58 < arg_40_1.time_ and arg_40_1.time_ <= var_43_58 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_60 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_60:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_40_1.dialogCg_.alpha = arg_46_0
				end))
				var_43_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_61 = arg_40_1:GetWordFromCfg(1108504010)
				local var_43_62 = arg_40_1:FormatText(var_43_61.content)

				arg_40_1.text_.text = var_43_62

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_63 = 27
				local var_43_64 = utf8.len(var_43_62)
				local var_43_65 = var_43_63 <= 0 and var_43_59 or var_43_59 * (var_43_64 / var_43_63)

				if var_43_65 > 0 and var_43_59 < var_43_65 then
					arg_40_1.talkMaxDuration = var_43_65
					var_43_58 = var_43_58 + 0.3

					if var_43_65 + var_43_58 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_65 + var_43_58
					end
				end

				arg_40_1.text_.text = var_43_62
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_66 = var_43_58 + 0.3
			local var_43_67 = math.max(var_43_59, arg_40_1.talkMaxDuration)

			if var_43_66 <= arg_40_1.time_ and arg_40_1.time_ < var_43_66 + var_43_67 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_66) / var_43_67

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_66 + var_43_67 and arg_40_1.time_ < var_43_66 + var_43_67 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play1108504011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1108504011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1108504012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 1.1

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(1108504011)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 44
				local var_51_5 = utf8.len(var_51_3)
				local var_51_6 = var_51_4 <= 0 and var_51_1 or var_51_1 * (var_51_5 / var_51_4)

				if var_51_6 > 0 and var_51_1 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_7 and arg_48_1.time_ < var_51_0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play1108504012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1108504012
		arg_52_1.duration_ = 3.4

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1108504013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1085ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1085ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, -1.01, -5.83)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1085ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = arg_52_1.actors_["1085ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1085ui_story == nil then
				arg_52_1.var_.characterEffect1085ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.200000002980232

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1085ui_story and not isNil(var_55_9) then
					arg_52_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1085ui_story then
				arg_52_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_55_13 = 0

			if var_55_13 < arg_52_1.time_ and arg_52_1.time_ <= var_55_13 + arg_55_0 then
				arg_52_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_55_14 = 0

			if var_55_14 < arg_52_1.time_ and arg_52_1.time_ <= var_55_14 + arg_55_0 then
				arg_52_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_55_15 = 0
			local var_55_16 = 0.15

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_17 = arg_52_1:FormatText(StoryNameCfg[328].name)

				arg_52_1.leftNameTxt_.text = var_55_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_18 = arg_52_1:GetWordFromCfg(1108504012)
				local var_55_19 = arg_52_1:FormatText(var_55_18.content)

				arg_52_1.text_.text = var_55_19

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_20 = 6
				local var_55_21 = utf8.len(var_55_19)
				local var_55_22 = var_55_20 <= 0 and var_55_16 or var_55_16 * (var_55_21 / var_55_20)

				if var_55_22 > 0 and var_55_16 < var_55_22 then
					arg_52_1.talkMaxDuration = var_55_22

					if var_55_22 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_22 + var_55_15
					end
				end

				arg_52_1.text_.text = var_55_19
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504012", "story_v_side_new_1108504.awb") ~= 0 then
					local var_55_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504012", "story_v_side_new_1108504.awb") / 1000

					if var_55_23 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_15
					end

					if var_55_18.prefab_name ~= "" and arg_52_1.actors_[var_55_18.prefab_name] ~= nil then
						local var_55_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_18.prefab_name].transform, "story_v_side_new_1108504", "1108504012", "story_v_side_new_1108504.awb")

						arg_52_1:RecordAudio("1108504012", var_55_24)
						arg_52_1:RecordAudio("1108504012", var_55_24)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504012", "story_v_side_new_1108504.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504012", "story_v_side_new_1108504.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_25 = math.max(var_55_16, arg_52_1.talkMaxDuration)

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_25 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_15) / var_55_25

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_15 + var_55_25 and arg_52_1.time_ < var_55_15 + var_55_25 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play1108504013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1108504013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1108504014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1085ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1085ui_story == nil then
				arg_56_1.var_.characterEffect1085ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1085ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1085ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1085ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1085ui_story.fillRatio = var_59_5
			end

			local var_59_6 = 0
			local var_59_7 = 0.75

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(1108504013)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 30
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_14 and arg_56_1.time_ < var_59_6 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1108504014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1108504014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1108504015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.75

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[7].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(1108504014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 30
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play1108504015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1108504015
		arg_64_1.duration_ = 3.03

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1108504016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1085ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1085ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, -1.01, -5.83)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1085ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["1085ui_story"]
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1085ui_story == nil then
				arg_64_1.var_.characterEffect1085ui_story = var_67_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_11 = 0.200000002980232

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 and not isNil(var_67_9) then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11

				if arg_64_1.var_.characterEffect1085ui_story and not isNil(var_67_9) then
					arg_64_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 and not isNil(var_67_9) and arg_64_1.var_.characterEffect1085ui_story then
				arg_64_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_67_13 = 0

			if var_67_13 < arg_64_1.time_ and arg_64_1.time_ <= var_67_13 + arg_67_0 then
				arg_64_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_67_14 = 0

			if var_67_14 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				arg_64_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_67_15 = 0
			local var_67_16 = 0.175

			if var_67_15 < arg_64_1.time_ and arg_64_1.time_ <= var_67_15 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_17 = arg_64_1:FormatText(StoryNameCfg[328].name)

				arg_64_1.leftNameTxt_.text = var_67_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_18 = arg_64_1:GetWordFromCfg(1108504015)
				local var_67_19 = arg_64_1:FormatText(var_67_18.content)

				arg_64_1.text_.text = var_67_19

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_20 = 7
				local var_67_21 = utf8.len(var_67_19)
				local var_67_22 = var_67_20 <= 0 and var_67_16 or var_67_16 * (var_67_21 / var_67_20)

				if var_67_22 > 0 and var_67_16 < var_67_22 then
					arg_64_1.talkMaxDuration = var_67_22

					if var_67_22 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_22 + var_67_15
					end
				end

				arg_64_1.text_.text = var_67_19
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504015", "story_v_side_new_1108504.awb") ~= 0 then
					local var_67_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504015", "story_v_side_new_1108504.awb") / 1000

					if var_67_23 + var_67_15 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_23 + var_67_15
					end

					if var_67_18.prefab_name ~= "" and arg_64_1.actors_[var_67_18.prefab_name] ~= nil then
						local var_67_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_18.prefab_name].transform, "story_v_side_new_1108504", "1108504015", "story_v_side_new_1108504.awb")

						arg_64_1:RecordAudio("1108504015", var_67_24)
						arg_64_1:RecordAudio("1108504015", var_67_24)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504015", "story_v_side_new_1108504.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504015", "story_v_side_new_1108504.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_25 = math.max(var_67_16, arg_64_1.talkMaxDuration)

			if var_67_15 <= arg_64_1.time_ and arg_64_1.time_ < var_67_15 + var_67_25 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_15) / var_67_25

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_15 + var_67_25 and arg_64_1.time_ < var_67_15 + var_67_25 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play1108504016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1108504016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1108504017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1085ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1085ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, 100, 0)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1085ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, 100, 0)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = arg_68_1.actors_["1085ui_story"]
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1085ui_story == nil then
				arg_68_1.var_.characterEffect1085ui_story = var_71_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_11 = 0.200000002980232

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 and not isNil(var_71_9) then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11

				if arg_68_1.var_.characterEffect1085ui_story and not isNil(var_71_9) then
					local var_71_13 = Mathf.Lerp(0, 0.5, var_71_12)

					arg_68_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1085ui_story.fillRatio = var_71_13
				end
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1085ui_story then
				local var_71_14 = 0.5

				arg_68_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1085ui_story.fillRatio = var_71_14
			end

			local var_71_15 = 0.200000002980232
			local var_71_16 = 1

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				local var_71_17 = "play"
				local var_71_18 = "effect"

				arg_68_1:AudioAction(var_71_17, var_71_18, "se_story_143", "se_story_143_footstep_sand", "")
			end

			local var_71_19 = 0
			local var_71_20 = 0.675

			if var_71_19 < arg_68_1.time_ and arg_68_1.time_ <= var_71_19 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_21 = arg_68_1:GetWordFromCfg(1108504016)
				local var_71_22 = arg_68_1:FormatText(var_71_21.content)

				arg_68_1.text_.text = var_71_22

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_23 = 27
				local var_71_24 = utf8.len(var_71_22)
				local var_71_25 = var_71_23 <= 0 and var_71_20 or var_71_20 * (var_71_24 / var_71_23)

				if var_71_25 > 0 and var_71_20 < var_71_25 then
					arg_68_1.talkMaxDuration = var_71_25

					if var_71_25 + var_71_19 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_25 + var_71_19
					end
				end

				arg_68_1.text_.text = var_71_22
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_26 = math.max(var_71_20, arg_68_1.talkMaxDuration)

			if var_71_19 <= arg_68_1.time_ and arg_68_1.time_ < var_71_19 + var_71_26 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_19) / var_71_26

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_19 + var_71_26 and arg_68_1.time_ < var_71_19 + var_71_26 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play1108504017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1108504017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1108504018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0
			local var_75_1 = 0.75

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(1108504017)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 30
				local var_75_5 = utf8.len(var_75_3)
				local var_75_6 = var_75_4 <= 0 and var_75_1 or var_75_1 * (var_75_5 / var_75_4)

				if var_75_6 > 0 and var_75_1 < var_75_6 then
					arg_72_1.talkMaxDuration = var_75_6

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_7 and arg_72_1.time_ < var_75_0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1108504018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1108504018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1108504019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.75

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(1108504018)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 30
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_8 and arg_76_1.time_ < var_79_0 + var_79_8 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play1108504019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1108504019
		arg_80_1.duration_ = 5.47

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1108504020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1085ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1085ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0, -1.01, -5.83)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1085ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["1085ui_story"]
			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1085ui_story == nil then
				arg_80_1.var_.characterEffect1085ui_story = var_83_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_11 = 0.200000002980232

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 and not isNil(var_83_9) then
				local var_83_12 = (arg_80_1.time_ - var_83_10) / var_83_11

				if arg_80_1.var_.characterEffect1085ui_story and not isNil(var_83_9) then
					arg_80_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_10 + var_83_11 and arg_80_1.time_ < var_83_10 + var_83_11 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1085ui_story then
				arg_80_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_83_13 = 0

			if var_83_13 < arg_80_1.time_ and arg_80_1.time_ <= var_83_13 + arg_83_0 then
				arg_80_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_83_14 = 0

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_83_15 = 0
			local var_83_16 = 0.425

			if var_83_15 < arg_80_1.time_ and arg_80_1.time_ <= var_83_15 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_17 = arg_80_1:FormatText(StoryNameCfg[328].name)

				arg_80_1.leftNameTxt_.text = var_83_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_18 = arg_80_1:GetWordFromCfg(1108504019)
				local var_83_19 = arg_80_1:FormatText(var_83_18.content)

				arg_80_1.text_.text = var_83_19

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_20 = 17
				local var_83_21 = utf8.len(var_83_19)
				local var_83_22 = var_83_20 <= 0 and var_83_16 or var_83_16 * (var_83_21 / var_83_20)

				if var_83_22 > 0 and var_83_16 < var_83_22 then
					arg_80_1.talkMaxDuration = var_83_22

					if var_83_22 + var_83_15 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_22 + var_83_15
					end
				end

				arg_80_1.text_.text = var_83_19
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504019", "story_v_side_new_1108504.awb") ~= 0 then
					local var_83_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504019", "story_v_side_new_1108504.awb") / 1000

					if var_83_23 + var_83_15 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_23 + var_83_15
					end

					if var_83_18.prefab_name ~= "" and arg_80_1.actors_[var_83_18.prefab_name] ~= nil then
						local var_83_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_18.prefab_name].transform, "story_v_side_new_1108504", "1108504019", "story_v_side_new_1108504.awb")

						arg_80_1:RecordAudio("1108504019", var_83_24)
						arg_80_1:RecordAudio("1108504019", var_83_24)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504019", "story_v_side_new_1108504.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504019", "story_v_side_new_1108504.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_25 = math.max(var_83_16, arg_80_1.talkMaxDuration)

			if var_83_15 <= arg_80_1.time_ and arg_80_1.time_ < var_83_15 + var_83_25 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_15) / var_83_25

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_15 + var_83_25 and arg_80_1.time_ < var_83_15 + var_83_25 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play1108504020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1108504020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play1108504021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1085ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1085ui_story == nil then
				arg_84_1.var_.characterEffect1085ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1085ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1085ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1085ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1085ui_story.fillRatio = var_87_5
			end

			local var_87_6 = 0
			local var_87_7 = 0.525

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[7].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_9 = arg_84_1:GetWordFromCfg(1108504020)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 21
				local var_87_12 = utf8.len(var_87_10)
				local var_87_13 = var_87_11 <= 0 and var_87_7 or var_87_7 * (var_87_12 / var_87_11)

				if var_87_13 > 0 and var_87_7 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_14 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_14 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_14

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_14 and arg_84_1.time_ < var_87_6 + var_87_14 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play1108504021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1108504021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1108504022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0
			local var_91_1 = 0.775

			if var_91_0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_2 = arg_88_1:FormatText(StoryNameCfg[7].name)

				arg_88_1.leftNameTxt_.text = var_91_2

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

				local var_91_3 = arg_88_1:GetWordFromCfg(1108504021)
				local var_91_4 = arg_88_1:FormatText(var_91_3.content)

				arg_88_1.text_.text = var_91_4

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 31
				local var_91_6 = utf8.len(var_91_4)
				local var_91_7 = var_91_5 <= 0 and var_91_1 or var_91_1 * (var_91_6 / var_91_5)

				if var_91_7 > 0 and var_91_1 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_0
					end
				end

				arg_88_1.text_.text = var_91_4
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_8 = math.max(var_91_1, arg_88_1.talkMaxDuration)

			if var_91_0 <= arg_88_1.time_ and arg_88_1.time_ < var_91_0 + var_91_8 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_0) / var_91_8

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_0 + var_91_8 and arg_88_1.time_ < var_91_0 + var_91_8 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play1108504022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1108504022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1108504023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1085ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1085ui_story = var_95_0.localPosition
			end

			local var_95_2 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2
				local var_95_4 = Vector3.New(0, 100, 0)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1085ui_story, var_95_4, var_95_3)

				local var_95_5 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_5.x, var_95_5.y, var_95_5.z)

				local var_95_6 = var_95_0.localEulerAngles

				var_95_6.z = 0
				var_95_6.x = 0
				var_95_0.localEulerAngles = var_95_6
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, 100, 0)

				local var_95_7 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_7.x, var_95_7.y, var_95_7.z)

				local var_95_8 = var_95_0.localEulerAngles

				var_95_8.z = 0
				var_95_8.x = 0
				var_95_0.localEulerAngles = var_95_8
			end

			local var_95_9 = 0
			local var_95_10 = 0.75

			if var_95_9 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_11 = arg_92_1:GetWordFromCfg(1108504022)
				local var_95_12 = arg_92_1:FormatText(var_95_11.content)

				arg_92_1.text_.text = var_95_12

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 30
				local var_95_14 = utf8.len(var_95_12)
				local var_95_15 = var_95_13 <= 0 and var_95_10 or var_95_10 * (var_95_14 / var_95_13)

				if var_95_15 > 0 and var_95_10 < var_95_15 then
					arg_92_1.talkMaxDuration = var_95_15

					if var_95_15 + var_95_9 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_15 + var_95_9
					end
				end

				arg_92_1.text_.text = var_95_12
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_10, arg_92_1.talkMaxDuration)

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_9) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_9 + var_95_16 and arg_92_1.time_ < var_95_9 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play1108504023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1108504023
		arg_96_1.duration_ = 4.17

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1108504024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1085ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1085ui_story = var_99_0.localPosition
			end

			local var_99_2 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2
				local var_99_4 = Vector3.New(0, -1.01, -5.83)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1085ui_story, var_99_4, var_99_3)

				local var_99_5 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_5.x, var_99_5.y, var_99_5.z)

				local var_99_6 = var_99_0.localEulerAngles

				var_99_6.z = 0
				var_99_6.x = 0
				var_99_0.localEulerAngles = var_99_6
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_99_7 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_7.x, var_99_7.y, var_99_7.z)

				local var_99_8 = var_99_0.localEulerAngles

				var_99_8.z = 0
				var_99_8.x = 0
				var_99_0.localEulerAngles = var_99_8
			end

			local var_99_9 = arg_96_1.actors_["1085ui_story"]
			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1085ui_story == nil then
				arg_96_1.var_.characterEffect1085ui_story = var_99_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_11 = 0.200000002980232

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_11 and not isNil(var_99_9) then
				local var_99_12 = (arg_96_1.time_ - var_99_10) / var_99_11

				if arg_96_1.var_.characterEffect1085ui_story and not isNil(var_99_9) then
					arg_96_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_10 + var_99_11 and arg_96_1.time_ < var_99_10 + var_99_11 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1085ui_story then
				arg_96_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_99_13 = 0

			if var_99_13 < arg_96_1.time_ and arg_96_1.time_ <= var_99_13 + arg_99_0 then
				arg_96_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_99_14 = 0

			if var_99_14 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_99_15 = 0
			local var_99_16 = 0.2

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_17 = arg_96_1:FormatText(StoryNameCfg[328].name)

				arg_96_1.leftNameTxt_.text = var_99_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(1108504023)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 8
				local var_99_21 = utf8.len(var_99_19)
				local var_99_22 = var_99_20 <= 0 and var_99_16 or var_99_16 * (var_99_21 / var_99_20)

				if var_99_22 > 0 and var_99_16 < var_99_22 then
					arg_96_1.talkMaxDuration = var_99_22

					if var_99_22 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_15
					end
				end

				arg_96_1.text_.text = var_99_19
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504023", "story_v_side_new_1108504.awb") ~= 0 then
					local var_99_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504023", "story_v_side_new_1108504.awb") / 1000

					if var_99_23 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_15
					end

					if var_99_18.prefab_name ~= "" and arg_96_1.actors_[var_99_18.prefab_name] ~= nil then
						local var_99_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_18.prefab_name].transform, "story_v_side_new_1108504", "1108504023", "story_v_side_new_1108504.awb")

						arg_96_1:RecordAudio("1108504023", var_99_24)
						arg_96_1:RecordAudio("1108504023", var_99_24)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504023", "story_v_side_new_1108504.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504023", "story_v_side_new_1108504.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = math.max(var_99_16, arg_96_1.talkMaxDuration)

			if var_99_15 <= arg_96_1.time_ and arg_96_1.time_ < var_99_15 + var_99_25 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_15) / var_99_25

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_15 + var_99_25 and arg_96_1.time_ < var_99_15 + var_99_25 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play1108504024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1108504024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1108504025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1085ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1085ui_story == nil then
				arg_100_1.var_.characterEffect1085ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1085ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1085ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1085ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1085ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 0.95

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_9 = arg_100_1:GetWordFromCfg(1108504024)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 38
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_14 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_14 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_14

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_14 and arg_100_1.time_ < var_103_6 + var_103_14 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play1108504025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1108504025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1108504026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.925

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[7].name)

				arg_104_1.leftNameTxt_.text = var_107_2

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

				local var_107_3 = arg_104_1:GetWordFromCfg(1108504025)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 37
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_8 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_8 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_8

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_8 and arg_104_1.time_ < var_107_0 + var_107_8 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play1108504026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1108504026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play1108504027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.7

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[7].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(1108504026)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 28
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play1108504027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1108504027
		arg_112_1.duration_ = 2.27

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1108504028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1085ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos1085ui_story = var_115_0.localPosition
			end

			local var_115_2 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2
				local var_115_4 = Vector3.New(0, -1.01, -5.83)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1085ui_story, var_115_4, var_115_3)

				local var_115_5 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_5.x, var_115_5.y, var_115_5.z)

				local var_115_6 = var_115_0.localEulerAngles

				var_115_6.z = 0
				var_115_6.x = 0
				var_115_0.localEulerAngles = var_115_6
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_115_7 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_7.x, var_115_7.y, var_115_7.z)

				local var_115_8 = var_115_0.localEulerAngles

				var_115_8.z = 0
				var_115_8.x = 0
				var_115_0.localEulerAngles = var_115_8
			end

			local var_115_9 = arg_112_1.actors_["1085ui_story"]
			local var_115_10 = 0

			if var_115_10 < arg_112_1.time_ and arg_112_1.time_ <= var_115_10 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1085ui_story == nil then
				arg_112_1.var_.characterEffect1085ui_story = var_115_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_11 = 0.200000002980232

			if var_115_10 <= arg_112_1.time_ and arg_112_1.time_ < var_115_10 + var_115_11 and not isNil(var_115_9) then
				local var_115_12 = (arg_112_1.time_ - var_115_10) / var_115_11

				if arg_112_1.var_.characterEffect1085ui_story and not isNil(var_115_9) then
					arg_112_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_10 + var_115_11 and arg_112_1.time_ < var_115_10 + var_115_11 + arg_115_0 and not isNil(var_115_9) and arg_112_1.var_.characterEffect1085ui_story then
				arg_112_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_115_13 = 0

			if var_115_13 < arg_112_1.time_ and arg_112_1.time_ <= var_115_13 + arg_115_0 then
				arg_112_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_115_14 = 0

			if var_115_14 < arg_112_1.time_ and arg_112_1.time_ <= var_115_14 + arg_115_0 then
				arg_112_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_115_15 = 0
			local var_115_16 = 0.175

			if var_115_15 < arg_112_1.time_ and arg_112_1.time_ <= var_115_15 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_17 = arg_112_1:FormatText(StoryNameCfg[328].name)

				arg_112_1.leftNameTxt_.text = var_115_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_18 = arg_112_1:GetWordFromCfg(1108504027)
				local var_115_19 = arg_112_1:FormatText(var_115_18.content)

				arg_112_1.text_.text = var_115_19

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_20 = 7
				local var_115_21 = utf8.len(var_115_19)
				local var_115_22 = var_115_20 <= 0 and var_115_16 or var_115_16 * (var_115_21 / var_115_20)

				if var_115_22 > 0 and var_115_16 < var_115_22 then
					arg_112_1.talkMaxDuration = var_115_22

					if var_115_22 + var_115_15 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_22 + var_115_15
					end
				end

				arg_112_1.text_.text = var_115_19
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504027", "story_v_side_new_1108504.awb") ~= 0 then
					local var_115_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504027", "story_v_side_new_1108504.awb") / 1000

					if var_115_23 + var_115_15 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_23 + var_115_15
					end

					if var_115_18.prefab_name ~= "" and arg_112_1.actors_[var_115_18.prefab_name] ~= nil then
						local var_115_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_18.prefab_name].transform, "story_v_side_new_1108504", "1108504027", "story_v_side_new_1108504.awb")

						arg_112_1:RecordAudio("1108504027", var_115_24)
						arg_112_1:RecordAudio("1108504027", var_115_24)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504027", "story_v_side_new_1108504.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504027", "story_v_side_new_1108504.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_25 = math.max(var_115_16, arg_112_1.talkMaxDuration)

			if var_115_15 <= arg_112_1.time_ and arg_112_1.time_ < var_115_15 + var_115_25 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_15) / var_115_25

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_15 + var_115_25 and arg_112_1.time_ < var_115_15 + var_115_25 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play1108504028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1108504028
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1108504029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1085ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1085ui_story = var_119_0.localPosition
			end

			local var_119_2 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2
				local var_119_4 = Vector3.New(0, 100, 0)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1085ui_story, var_119_4, var_119_3)

				local var_119_5 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_5.x, var_119_5.y, var_119_5.z)

				local var_119_6 = var_119_0.localEulerAngles

				var_119_6.z = 0
				var_119_6.x = 0
				var_119_0.localEulerAngles = var_119_6
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, 100, 0)

				local var_119_7 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_7.x, var_119_7.y, var_119_7.z)

				local var_119_8 = var_119_0.localEulerAngles

				var_119_8.z = 0
				var_119_8.x = 0
				var_119_0.localEulerAngles = var_119_8
			end

			local var_119_9 = arg_116_1.actors_["1085ui_story"]
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1085ui_story == nil then
				arg_116_1.var_.characterEffect1085ui_story = var_119_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_11 = 0.200000002980232

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 and not isNil(var_119_9) then
				local var_119_12 = (arg_116_1.time_ - var_119_10) / var_119_11

				if arg_116_1.var_.characterEffect1085ui_story and not isNil(var_119_9) then
					local var_119_13 = Mathf.Lerp(0, 0.5, var_119_12)

					arg_116_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1085ui_story.fillRatio = var_119_13
				end
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1085ui_story then
				local var_119_14 = 0.5

				arg_116_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1085ui_story.fillRatio = var_119_14
			end

			local var_119_15 = 0
			local var_119_16 = 0.925

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_17 = arg_116_1:GetWordFromCfg(1108504028)
				local var_119_18 = arg_116_1:FormatText(var_119_17.content)

				arg_116_1.text_.text = var_119_18

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_19 = 37
				local var_119_20 = utf8.len(var_119_18)
				local var_119_21 = var_119_19 <= 0 and var_119_16 or var_119_16 * (var_119_20 / var_119_19)

				if var_119_21 > 0 and var_119_16 < var_119_21 then
					arg_116_1.talkMaxDuration = var_119_21

					if var_119_21 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_21 + var_119_15
					end
				end

				arg_116_1.text_.text = var_119_18
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_22 = math.max(var_119_16, arg_116_1.talkMaxDuration)

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_22 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_15) / var_119_22

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_15 + var_119_22 and arg_116_1.time_ < var_119_15 + var_119_22 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1108504029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1108504030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.85

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[7].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(1108504029)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 34
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_8 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_8 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_8

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_8 and arg_120_1.time_ < var_123_0 + var_123_8 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1108504030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1108504030
		arg_124_1.duration_ = 4.27

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1108504031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1085ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1085ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0, -1.01, -5.83)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1085ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = arg_124_1.actors_["1085ui_story"]
			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 and not isNil(var_127_9) and arg_124_1.var_.characterEffect1085ui_story == nil then
				arg_124_1.var_.characterEffect1085ui_story = var_127_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_11 = 0.200000002980232

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_11 and not isNil(var_127_9) then
				local var_127_12 = (arg_124_1.time_ - var_127_10) / var_127_11

				if arg_124_1.var_.characterEffect1085ui_story and not isNil(var_127_9) then
					arg_124_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_10 + var_127_11 and arg_124_1.time_ < var_127_10 + var_127_11 + arg_127_0 and not isNil(var_127_9) and arg_124_1.var_.characterEffect1085ui_story then
				arg_124_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_127_13 = 0

			if var_127_13 < arg_124_1.time_ and arg_124_1.time_ <= var_127_13 + arg_127_0 then
				arg_124_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_127_14 = 0

			if var_127_14 < arg_124_1.time_ and arg_124_1.time_ <= var_127_14 + arg_127_0 then
				arg_124_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_127_15 = 0
			local var_127_16 = 0.375

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_17 = arg_124_1:FormatText(StoryNameCfg[328].name)

				arg_124_1.leftNameTxt_.text = var_127_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_18 = arg_124_1:GetWordFromCfg(1108504030)
				local var_127_19 = arg_124_1:FormatText(var_127_18.content)

				arg_124_1.text_.text = var_127_19

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_20 = 15
				local var_127_21 = utf8.len(var_127_19)
				local var_127_22 = var_127_20 <= 0 and var_127_16 or var_127_16 * (var_127_21 / var_127_20)

				if var_127_22 > 0 and var_127_16 < var_127_22 then
					arg_124_1.talkMaxDuration = var_127_22

					if var_127_22 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_22 + var_127_15
					end
				end

				arg_124_1.text_.text = var_127_19
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504030", "story_v_side_new_1108504.awb") ~= 0 then
					local var_127_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504030", "story_v_side_new_1108504.awb") / 1000

					if var_127_23 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_23 + var_127_15
					end

					if var_127_18.prefab_name ~= "" and arg_124_1.actors_[var_127_18.prefab_name] ~= nil then
						local var_127_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_18.prefab_name].transform, "story_v_side_new_1108504", "1108504030", "story_v_side_new_1108504.awb")

						arg_124_1:RecordAudio("1108504030", var_127_24)
						arg_124_1:RecordAudio("1108504030", var_127_24)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504030", "story_v_side_new_1108504.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504030", "story_v_side_new_1108504.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_25 = math.max(var_127_16, arg_124_1.talkMaxDuration)

			if var_127_15 <= arg_124_1.time_ and arg_124_1.time_ < var_127_15 + var_127_25 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_15) / var_127_25

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_15 + var_127_25 and arg_124_1.time_ < var_127_15 + var_127_25 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1108504031
		arg_128_1.duration_ = 7.83

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1108504032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 0.5

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[328].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:GetWordFromCfg(1108504031)
				local var_131_4 = arg_128_1:FormatText(var_131_3.content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 20
				local var_131_6 = utf8.len(var_131_4)
				local var_131_7 = var_131_5 <= 0 and var_131_1 or var_131_1 * (var_131_6 / var_131_5)

				if var_131_7 > 0 and var_131_1 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504031", "story_v_side_new_1108504.awb") ~= 0 then
					local var_131_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504031", "story_v_side_new_1108504.awb") / 1000

					if var_131_8 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_0
					end

					if var_131_3.prefab_name ~= "" and arg_128_1.actors_[var_131_3.prefab_name] ~= nil then
						local var_131_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_3.prefab_name].transform, "story_v_side_new_1108504", "1108504031", "story_v_side_new_1108504.awb")

						arg_128_1:RecordAudio("1108504031", var_131_9)
						arg_128_1:RecordAudio("1108504031", var_131_9)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504031", "story_v_side_new_1108504.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504031", "story_v_side_new_1108504.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_10 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_10 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_10

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_10 and arg_128_1.time_ < var_131_0 + var_131_10 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play1108504032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 1108504032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play1108504033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1085ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1085ui_story == nil then
				arg_132_1.var_.characterEffect1085ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1085ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1085ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1085ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1085ui_story.fillRatio = var_135_5
			end

			local var_135_6 = 0
			local var_135_7 = 0.55

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[7].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_9 = arg_132_1:GetWordFromCfg(1108504032)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 22
				local var_135_12 = utf8.len(var_135_10)
				local var_135_13 = var_135_11 <= 0 and var_135_7 or var_135_7 * (var_135_12 / var_135_11)

				if var_135_13 > 0 and var_135_7 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_14 and arg_132_1.time_ < var_135_6 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play1108504033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 1108504033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play1108504034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.975

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[7].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:GetWordFromCfg(1108504033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 39
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
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_8 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_8 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_8

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_8 and arg_136_1.time_ < var_139_0 + var_139_8 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play1108504034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 1108504034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play1108504035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1085ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1085ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(0, 100, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1085ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, 100, 0)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = 0
			local var_143_10 = 0.825

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_11 = arg_140_1:GetWordFromCfg(1108504034)
				local var_143_12 = arg_140_1:FormatText(var_143_11.content)

				arg_140_1.text_.text = var_143_12

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 33
				local var_143_14 = utf8.len(var_143_12)
				local var_143_15 = var_143_13 <= 0 and var_143_10 or var_143_10 * (var_143_14 / var_143_13)

				if var_143_15 > 0 and var_143_10 < var_143_15 then
					arg_140_1.talkMaxDuration = var_143_15

					if var_143_15 + var_143_9 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_15 + var_143_9
					end
				end

				arg_140_1.text_.text = var_143_12
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_10, arg_140_1.talkMaxDuration)

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_9) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_9 + var_143_16 and arg_140_1.time_ < var_143_9 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play1108504035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 1108504035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play1108504036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.8

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(1108504035)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 32
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
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_8 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_8 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_8

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_8 and arg_144_1.time_ < var_147_0 + var_147_8 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play1108504036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 1108504036
		arg_148_1.duration_ = 7.3

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play1108504037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1085ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1085ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, -1.01, -5.83)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1085ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = arg_148_1.actors_["1085ui_story"]
			local var_151_10 = 0

			if var_151_10 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1085ui_story == nil then
				arg_148_1.var_.characterEffect1085ui_story = var_151_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_11 = 0.200000002980232

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_11 and not isNil(var_151_9) then
				local var_151_12 = (arg_148_1.time_ - var_151_10) / var_151_11

				if arg_148_1.var_.characterEffect1085ui_story and not isNil(var_151_9) then
					arg_148_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_10 + var_151_11 and arg_148_1.time_ < var_151_10 + var_151_11 + arg_151_0 and not isNil(var_151_9) and arg_148_1.var_.characterEffect1085ui_story then
				arg_148_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_151_13 = 0

			if var_151_13 < arg_148_1.time_ and arg_148_1.time_ <= var_151_13 + arg_151_0 then
				arg_148_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_151_14 = 0

			if var_151_14 < arg_148_1.time_ and arg_148_1.time_ <= var_151_14 + arg_151_0 then
				arg_148_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_151_15 = 0
			local var_151_16 = 0.475

			if var_151_15 < arg_148_1.time_ and arg_148_1.time_ <= var_151_15 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_17 = arg_148_1:FormatText(StoryNameCfg[328].name)

				arg_148_1.leftNameTxt_.text = var_151_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_18 = arg_148_1:GetWordFromCfg(1108504036)
				local var_151_19 = arg_148_1:FormatText(var_151_18.content)

				arg_148_1.text_.text = var_151_19

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_20 = 19
				local var_151_21 = utf8.len(var_151_19)
				local var_151_22 = var_151_20 <= 0 and var_151_16 or var_151_16 * (var_151_21 / var_151_20)

				if var_151_22 > 0 and var_151_16 < var_151_22 then
					arg_148_1.talkMaxDuration = var_151_22

					if var_151_22 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_22 + var_151_15
					end
				end

				arg_148_1.text_.text = var_151_19
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504036", "story_v_side_new_1108504.awb") ~= 0 then
					local var_151_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504036", "story_v_side_new_1108504.awb") / 1000

					if var_151_23 + var_151_15 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_15
					end

					if var_151_18.prefab_name ~= "" and arg_148_1.actors_[var_151_18.prefab_name] ~= nil then
						local var_151_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_18.prefab_name].transform, "story_v_side_new_1108504", "1108504036", "story_v_side_new_1108504.awb")

						arg_148_1:RecordAudio("1108504036", var_151_24)
						arg_148_1:RecordAudio("1108504036", var_151_24)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504036", "story_v_side_new_1108504.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504036", "story_v_side_new_1108504.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_25 = math.max(var_151_16, arg_148_1.talkMaxDuration)

			if var_151_15 <= arg_148_1.time_ and arg_148_1.time_ < var_151_15 + var_151_25 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_15) / var_151_25

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_15 + var_151_25 and arg_148_1.time_ < var_151_15 + var_151_25 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1108504037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play1108504038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["1085ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1085ui_story == nil then
				arg_152_1.var_.characterEffect1085ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect1085ui_story and not isNil(var_155_0) then
					local var_155_4 = Mathf.Lerp(0, 0.5, var_155_3)

					arg_152_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1085ui_story.fillRatio = var_155_4
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect1085ui_story then
				local var_155_5 = 0.5

				arg_152_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1085ui_story.fillRatio = var_155_5
			end

			local var_155_6 = 0
			local var_155_7 = 1.075

			if var_155_6 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_8 = arg_152_1:FormatText(StoryNameCfg[7].name)

				arg_152_1.leftNameTxt_.text = var_155_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_9 = arg_152_1:GetWordFromCfg(1108504037)
				local var_155_10 = arg_152_1:FormatText(var_155_9.content)

				arg_152_1.text_.text = var_155_10

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_11 = 43
				local var_155_12 = utf8.len(var_155_10)
				local var_155_13 = var_155_11 <= 0 and var_155_7 or var_155_7 * (var_155_12 / var_155_11)

				if var_155_13 > 0 and var_155_7 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_10
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_14 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_14 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_14

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_14 and arg_152_1.time_ < var_155_6 + var_155_14 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play1108504038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1108504038
		arg_156_1.duration_ = 2

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1108504039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1085ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1085ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(0, -1.01, -5.83)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1085ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["1085ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1085ui_story == nil then
				arg_156_1.var_.characterEffect1085ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.200000002980232

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect1085ui_story and not isNil(var_159_9) then
					arg_156_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1085ui_story then
				arg_156_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_159_13 = 0

			if var_159_13 < arg_156_1.time_ and arg_156_1.time_ <= var_159_13 + arg_159_0 then
				arg_156_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_159_14 = 0

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 then
				arg_156_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_159_15 = 0
			local var_159_16 = 0.175

			if var_159_15 < arg_156_1.time_ and arg_156_1.time_ <= var_159_15 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_17 = arg_156_1:FormatText(StoryNameCfg[328].name)

				arg_156_1.leftNameTxt_.text = var_159_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_18 = arg_156_1:GetWordFromCfg(1108504038)
				local var_159_19 = arg_156_1:FormatText(var_159_18.content)

				arg_156_1.text_.text = var_159_19

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_20 = 7
				local var_159_21 = utf8.len(var_159_19)
				local var_159_22 = var_159_20 <= 0 and var_159_16 or var_159_16 * (var_159_21 / var_159_20)

				if var_159_22 > 0 and var_159_16 < var_159_22 then
					arg_156_1.talkMaxDuration = var_159_22

					if var_159_22 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_22 + var_159_15
					end
				end

				arg_156_1.text_.text = var_159_19
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504038", "story_v_side_new_1108504.awb") ~= 0 then
					local var_159_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504038", "story_v_side_new_1108504.awb") / 1000

					if var_159_23 + var_159_15 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_23 + var_159_15
					end

					if var_159_18.prefab_name ~= "" and arg_156_1.actors_[var_159_18.prefab_name] ~= nil then
						local var_159_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_18.prefab_name].transform, "story_v_side_new_1108504", "1108504038", "story_v_side_new_1108504.awb")

						arg_156_1:RecordAudio("1108504038", var_159_24)
						arg_156_1:RecordAudio("1108504038", var_159_24)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504038", "story_v_side_new_1108504.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504038", "story_v_side_new_1108504.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_25 = math.max(var_159_16, arg_156_1.talkMaxDuration)

			if var_159_15 <= arg_156_1.time_ and arg_156_1.time_ < var_159_15 + var_159_25 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_15) / var_159_25

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_15 + var_159_25 and arg_156_1.time_ < var_159_15 + var_159_25 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play1108504039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1108504039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1108504040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1085ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1085ui_story == nil then
				arg_160_1.var_.characterEffect1085ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1085ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1085ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1085ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1085ui_story.fillRatio = var_163_5
			end

			local var_163_6 = 0
			local var_163_7 = 1.2

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_8 = arg_160_1:FormatText(StoryNameCfg[7].name)

				arg_160_1.leftNameTxt_.text = var_163_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_9 = arg_160_1:GetWordFromCfg(1108504039)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 48
				local var_163_12 = utf8.len(var_163_10)
				local var_163_13 = var_163_11 <= 0 and var_163_7 or var_163_7 * (var_163_12 / var_163_11)

				if var_163_13 > 0 and var_163_7 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_14 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_14 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_14

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_14 and arg_160_1.time_ < var_163_6 + var_163_14 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play1108504040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 1108504040
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play1108504041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.9

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[7].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:GetWordFromCfg(1108504040)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 36
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
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_8 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_8 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_8

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_8 and arg_164_1.time_ < var_167_0 + var_167_8 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play1108504041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 1108504041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play1108504042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0
			local var_171_1 = 1.2

			if var_171_0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_2 = arg_168_1:FormatText(StoryNameCfg[7].name)

				arg_168_1.leftNameTxt_.text = var_171_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_3 = arg_168_1:GetWordFromCfg(1108504041)
				local var_171_4 = arg_168_1:FormatText(var_171_3.content)

				arg_168_1.text_.text = var_171_4

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_5 = 48
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
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_8 = math.max(var_171_1, arg_168_1.talkMaxDuration)

			if var_171_0 <= arg_168_1.time_ and arg_168_1.time_ < var_171_0 + var_171_8 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_0) / var_171_8

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_0 + var_171_8 and arg_168_1.time_ < var_171_0 + var_171_8 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play1108504042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1108504042
		arg_172_1.duration_ = 2.1

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1108504043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1085ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos1085ui_story = var_175_0.localPosition
			end

			local var_175_2 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2
				local var_175_4 = Vector3.New(0, -1.01, -5.83)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1085ui_story, var_175_4, var_175_3)

				local var_175_5 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_5.x, var_175_5.y, var_175_5.z)

				local var_175_6 = var_175_0.localEulerAngles

				var_175_6.z = 0
				var_175_6.x = 0
				var_175_0.localEulerAngles = var_175_6
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_175_7 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_7.x, var_175_7.y, var_175_7.z)

				local var_175_8 = var_175_0.localEulerAngles

				var_175_8.z = 0
				var_175_8.x = 0
				var_175_0.localEulerAngles = var_175_8
			end

			local var_175_9 = arg_172_1.actors_["1085ui_story"]
			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect1085ui_story == nil then
				arg_172_1.var_.characterEffect1085ui_story = var_175_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_11 = 0.200000002980232

			if var_175_10 <= arg_172_1.time_ and arg_172_1.time_ < var_175_10 + var_175_11 and not isNil(var_175_9) then
				local var_175_12 = (arg_172_1.time_ - var_175_10) / var_175_11

				if arg_172_1.var_.characterEffect1085ui_story and not isNil(var_175_9) then
					arg_172_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_10 + var_175_11 and arg_172_1.time_ < var_175_10 + var_175_11 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect1085ui_story then
				arg_172_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_175_13 = 0

			if var_175_13 < arg_172_1.time_ and arg_172_1.time_ <= var_175_13 + arg_175_0 then
				arg_172_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_175_14 = 0

			if var_175_14 < arg_172_1.time_ and arg_172_1.time_ <= var_175_14 + arg_175_0 then
				arg_172_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_175_15 = 0
			local var_175_16 = 0.225

			if var_175_15 < arg_172_1.time_ and arg_172_1.time_ <= var_175_15 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_17 = arg_172_1:FormatText(StoryNameCfg[328].name)

				arg_172_1.leftNameTxt_.text = var_175_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_18 = arg_172_1:GetWordFromCfg(1108504042)
				local var_175_19 = arg_172_1:FormatText(var_175_18.content)

				arg_172_1.text_.text = var_175_19

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_20 = 9
				local var_175_21 = utf8.len(var_175_19)
				local var_175_22 = var_175_20 <= 0 and var_175_16 or var_175_16 * (var_175_21 / var_175_20)

				if var_175_22 > 0 and var_175_16 < var_175_22 then
					arg_172_1.talkMaxDuration = var_175_22

					if var_175_22 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_22 + var_175_15
					end
				end

				arg_172_1.text_.text = var_175_19
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504042", "story_v_side_new_1108504.awb") ~= 0 then
					local var_175_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504042", "story_v_side_new_1108504.awb") / 1000

					if var_175_23 + var_175_15 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_23 + var_175_15
					end

					if var_175_18.prefab_name ~= "" and arg_172_1.actors_[var_175_18.prefab_name] ~= nil then
						local var_175_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_18.prefab_name].transform, "story_v_side_new_1108504", "1108504042", "story_v_side_new_1108504.awb")

						arg_172_1:RecordAudio("1108504042", var_175_24)
						arg_172_1:RecordAudio("1108504042", var_175_24)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504042", "story_v_side_new_1108504.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504042", "story_v_side_new_1108504.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_25 = math.max(var_175_16, arg_172_1.talkMaxDuration)

			if var_175_15 <= arg_172_1.time_ and arg_172_1.time_ < var_175_15 + var_175_25 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_15) / var_175_25

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_15 + var_175_25 and arg_172_1.time_ < var_175_15 + var_175_25 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play1108504043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1108504043
		arg_176_1.duration_ = 1

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"

			SetActive(arg_176_1.choicesGo_, true)

			for iter_177_0, iter_177_1 in ipairs(arg_176_1.choices_) do
				local var_177_0 = iter_177_0 <= 2

				SetActive(iter_177_1.go, var_177_0)
			end

			arg_176_1.choices_[1].txt.text = arg_176_1:FormatText(StoryChoiceCfg[1636].name)
			arg_176_1.choices_[2].txt.text = arg_176_1:FormatText(StoryChoiceCfg[1637].name)
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1108504044(arg_176_1)
			end

			if arg_178_0 == 2 then
				arg_176_0:Play1108504046(arg_176_1)
			end

			arg_176_1:RecordChoiceLog(1108504043, 1636, 1637)
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1085ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1085ui_story == nil then
				arg_176_1.var_.characterEffect1085ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1085ui_story and not isNil(var_179_0) then
					local var_179_4 = Mathf.Lerp(0, 0.5, var_179_3)

					arg_176_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1085ui_story.fillRatio = var_179_4
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1085ui_story then
				local var_179_5 = 0.5

				arg_176_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1085ui_story.fillRatio = var_179_5
			end

			local var_179_6 = 0

			if var_179_6 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.allBtn_.enabled = false
			end

			local var_179_7 = 0.6

			if arg_176_1.time_ >= var_179_6 + var_179_7 and arg_176_1.time_ < var_179_6 + var_179_7 + arg_179_0 then
				arg_176_1.allBtn_.enabled = true
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play1108504044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1108504044
		arg_180_1.duration_ = 3.53

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1108504045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1085ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos1085ui_story = var_183_0.localPosition
			end

			local var_183_2 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2
				local var_183_4 = Vector3.New(0, -1.01, -5.83)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1085ui_story, var_183_4, var_183_3)

				local var_183_5 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_5.x, var_183_5.y, var_183_5.z)

				local var_183_6 = var_183_0.localEulerAngles

				var_183_6.z = 0
				var_183_6.x = 0
				var_183_0.localEulerAngles = var_183_6
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_183_7 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_7.x, var_183_7.y, var_183_7.z)

				local var_183_8 = var_183_0.localEulerAngles

				var_183_8.z = 0
				var_183_8.x = 0
				var_183_0.localEulerAngles = var_183_8
			end

			local var_183_9 = arg_180_1.actors_["1085ui_story"]
			local var_183_10 = 0

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 and not isNil(var_183_9) and arg_180_1.var_.characterEffect1085ui_story == nil then
				arg_180_1.var_.characterEffect1085ui_story = var_183_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_11 = 0.200000002980232

			if var_183_10 <= arg_180_1.time_ and arg_180_1.time_ < var_183_10 + var_183_11 and not isNil(var_183_9) then
				local var_183_12 = (arg_180_1.time_ - var_183_10) / var_183_11

				if arg_180_1.var_.characterEffect1085ui_story and not isNil(var_183_9) then
					arg_180_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_10 + var_183_11 and arg_180_1.time_ < var_183_10 + var_183_11 + arg_183_0 and not isNil(var_183_9) and arg_180_1.var_.characterEffect1085ui_story then
				arg_180_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_183_13 = 0

			if var_183_13 < arg_180_1.time_ and arg_180_1.time_ <= var_183_13 + arg_183_0 then
				arg_180_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_183_14 = 0

			if var_183_14 < arg_180_1.time_ and arg_180_1.time_ <= var_183_14 + arg_183_0 then
				arg_180_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_183_15 = 0
			local var_183_16 = 0.325

			if var_183_15 < arg_180_1.time_ and arg_180_1.time_ <= var_183_15 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_17 = arg_180_1:FormatText(StoryNameCfg[328].name)

				arg_180_1.leftNameTxt_.text = var_183_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_18 = arg_180_1:GetWordFromCfg(1108504044)
				local var_183_19 = arg_180_1:FormatText(var_183_18.content)

				arg_180_1.text_.text = var_183_19

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_20 = 13
				local var_183_21 = utf8.len(var_183_19)
				local var_183_22 = var_183_20 <= 0 and var_183_16 or var_183_16 * (var_183_21 / var_183_20)

				if var_183_22 > 0 and var_183_16 < var_183_22 then
					arg_180_1.talkMaxDuration = var_183_22

					if var_183_22 + var_183_15 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_22 + var_183_15
					end
				end

				arg_180_1.text_.text = var_183_19
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504044", "story_v_side_new_1108504.awb") ~= 0 then
					local var_183_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504044", "story_v_side_new_1108504.awb") / 1000

					if var_183_23 + var_183_15 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_23 + var_183_15
					end

					if var_183_18.prefab_name ~= "" and arg_180_1.actors_[var_183_18.prefab_name] ~= nil then
						local var_183_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_18.prefab_name].transform, "story_v_side_new_1108504", "1108504044", "story_v_side_new_1108504.awb")

						arg_180_1:RecordAudio("1108504044", var_183_24)
						arg_180_1:RecordAudio("1108504044", var_183_24)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504044", "story_v_side_new_1108504.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504044", "story_v_side_new_1108504.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_25 = math.max(var_183_16, arg_180_1.talkMaxDuration)

			if var_183_15 <= arg_180_1.time_ and arg_180_1.time_ < var_183_15 + var_183_25 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_15) / var_183_25

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_15 + var_183_25 and arg_180_1.time_ < var_183_15 + var_183_25 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1108504045
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play1108504048(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1085ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1085ui_story == nil then
				arg_184_1.var_.characterEffect1085ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1085ui_story and not isNil(var_187_0) then
					local var_187_4 = Mathf.Lerp(0, 0.5, var_187_3)

					arg_184_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1085ui_story.fillRatio = var_187_4
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1085ui_story then
				local var_187_5 = 0.5

				arg_184_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1085ui_story.fillRatio = var_187_5
			end

			local var_187_6 = 0

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_187_7 = 0
			local var_187_8 = 0.6

			if var_187_7 < arg_184_1.time_ and arg_184_1.time_ <= var_187_7 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_9 = arg_184_1:FormatText(StoryNameCfg[7].name)

				arg_184_1.leftNameTxt_.text = var_187_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_10 = arg_184_1:GetWordFromCfg(1108504045)
				local var_187_11 = arg_184_1:FormatText(var_187_10.content)

				arg_184_1.text_.text = var_187_11

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_12 = 24
				local var_187_13 = utf8.len(var_187_11)
				local var_187_14 = var_187_12 <= 0 and var_187_8 or var_187_8 * (var_187_13 / var_187_12)

				if var_187_14 > 0 and var_187_8 < var_187_14 then
					arg_184_1.talkMaxDuration = var_187_14

					if var_187_14 + var_187_7 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_14 + var_187_7
					end
				end

				arg_184_1.text_.text = var_187_11
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_15 = math.max(var_187_8, arg_184_1.talkMaxDuration)

			if var_187_7 <= arg_184_1.time_ and arg_184_1.time_ < var_187_7 + var_187_15 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_7) / var_187_15

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_7 + var_187_15 and arg_184_1.time_ < var_187_7 + var_187_15 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play1108504048 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1108504048
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1108504049(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 1.025

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_2 = arg_188_1:FormatText(StoryNameCfg[7].name)

				arg_188_1.leftNameTxt_.text = var_191_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_3 = arg_188_1:GetWordFromCfg(1108504048)
				local var_191_4 = arg_188_1:FormatText(var_191_3.content)

				arg_188_1.text_.text = var_191_4

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 41
				local var_191_6 = utf8.len(var_191_4)
				local var_191_7 = var_191_5 <= 0 and var_191_1 or var_191_1 * (var_191_6 / var_191_5)

				if var_191_7 > 0 and var_191_1 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_4
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_8 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_8 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_8

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_8 and arg_188_1.time_ < var_191_0 + var_191_8 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1108504049 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1108504049
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1108504050(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 1.1

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[7].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_3 = arg_192_1:GetWordFromCfg(1108504049)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 44
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_8 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_8 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_8

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_8 and arg_192_1.time_ < var_195_0 + var_195_8 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play1108504050 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1108504050
		arg_196_1.duration_ = 4.13

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1108504051(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1085ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1085ui_story = var_199_0.localPosition
			end

			local var_199_2 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2
				local var_199_4 = Vector3.New(0, -1.01, -5.83)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1085ui_story, var_199_4, var_199_3)

				local var_199_5 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_5.x, var_199_5.y, var_199_5.z)

				local var_199_6 = var_199_0.localEulerAngles

				var_199_6.z = 0
				var_199_6.x = 0
				var_199_0.localEulerAngles = var_199_6
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_199_7 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_7.x, var_199_7.y, var_199_7.z)

				local var_199_8 = var_199_0.localEulerAngles

				var_199_8.z = 0
				var_199_8.x = 0
				var_199_0.localEulerAngles = var_199_8
			end

			local var_199_9 = arg_196_1.actors_["1085ui_story"]
			local var_199_10 = 0

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 and not isNil(var_199_9) and arg_196_1.var_.characterEffect1085ui_story == nil then
				arg_196_1.var_.characterEffect1085ui_story = var_199_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_11 = 0.200000002980232

			if var_199_10 <= arg_196_1.time_ and arg_196_1.time_ < var_199_10 + var_199_11 and not isNil(var_199_9) then
				local var_199_12 = (arg_196_1.time_ - var_199_10) / var_199_11

				if arg_196_1.var_.characterEffect1085ui_story and not isNil(var_199_9) then
					arg_196_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_10 + var_199_11 and arg_196_1.time_ < var_199_10 + var_199_11 + arg_199_0 and not isNil(var_199_9) and arg_196_1.var_.characterEffect1085ui_story then
				arg_196_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_199_13 = 0

			if var_199_13 < arg_196_1.time_ and arg_196_1.time_ <= var_199_13 + arg_199_0 then
				arg_196_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_199_14 = 0

			if var_199_14 < arg_196_1.time_ and arg_196_1.time_ <= var_199_14 + arg_199_0 then
				arg_196_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_199_15 = 0
			local var_199_16 = 0.325

			if var_199_15 < arg_196_1.time_ and arg_196_1.time_ <= var_199_15 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_17 = arg_196_1:FormatText(StoryNameCfg[328].name)

				arg_196_1.leftNameTxt_.text = var_199_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_18 = arg_196_1:GetWordFromCfg(1108504050)
				local var_199_19 = arg_196_1:FormatText(var_199_18.content)

				arg_196_1.text_.text = var_199_19

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_20 = 13
				local var_199_21 = utf8.len(var_199_19)
				local var_199_22 = var_199_20 <= 0 and var_199_16 or var_199_16 * (var_199_21 / var_199_20)

				if var_199_22 > 0 and var_199_16 < var_199_22 then
					arg_196_1.talkMaxDuration = var_199_22

					if var_199_22 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_22 + var_199_15
					end
				end

				arg_196_1.text_.text = var_199_19
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504050", "story_v_side_new_1108504.awb") ~= 0 then
					local var_199_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504050", "story_v_side_new_1108504.awb") / 1000

					if var_199_23 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_23 + var_199_15
					end

					if var_199_18.prefab_name ~= "" and arg_196_1.actors_[var_199_18.prefab_name] ~= nil then
						local var_199_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_18.prefab_name].transform, "story_v_side_new_1108504", "1108504050", "story_v_side_new_1108504.awb")

						arg_196_1:RecordAudio("1108504050", var_199_24)
						arg_196_1:RecordAudio("1108504050", var_199_24)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504050", "story_v_side_new_1108504.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504050", "story_v_side_new_1108504.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_25 = math.max(var_199_16, arg_196_1.talkMaxDuration)

			if var_199_15 <= arg_196_1.time_ and arg_196_1.time_ < var_199_15 + var_199_25 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_15) / var_199_25

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_15 + var_199_25 and arg_196_1.time_ < var_199_15 + var_199_25 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play1108504051 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1108504051
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play1108504052(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["1085ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1085ui_story == nil then
				arg_200_1.var_.characterEffect1085ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect1085ui_story and not isNil(var_203_0) then
					local var_203_4 = Mathf.Lerp(0, 0.5, var_203_3)

					arg_200_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1085ui_story.fillRatio = var_203_4
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect1085ui_story then
				local var_203_5 = 0.5

				arg_200_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1085ui_story.fillRatio = var_203_5
			end

			local var_203_6 = 0
			local var_203_7 = 0.825

			if var_203_6 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_8 = arg_200_1:FormatText(StoryNameCfg[7].name)

				arg_200_1.leftNameTxt_.text = var_203_8

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

				local var_203_9 = arg_200_1:GetWordFromCfg(1108504051)
				local var_203_10 = arg_200_1:FormatText(var_203_9.content)

				arg_200_1.text_.text = var_203_10

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_11 = 33
				local var_203_12 = utf8.len(var_203_10)
				local var_203_13 = var_203_11 <= 0 and var_203_7 or var_203_7 * (var_203_12 / var_203_11)

				if var_203_13 > 0 and var_203_7 < var_203_13 then
					arg_200_1.talkMaxDuration = var_203_13

					if var_203_13 + var_203_6 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_13 + var_203_6
					end
				end

				arg_200_1.text_.text = var_203_10
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_14 = math.max(var_203_7, arg_200_1.talkMaxDuration)

			if var_203_6 <= arg_200_1.time_ and arg_200_1.time_ < var_203_6 + var_203_14 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_6) / var_203_14

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_6 + var_203_14 and arg_200_1.time_ < var_203_6 + var_203_14 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1108504052 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1108504052
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1108504053(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.9

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[7].name)

				arg_204_1.leftNameTxt_.text = var_207_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_3 = arg_204_1:GetWordFromCfg(1108504052)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 36
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_8 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_8 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_8

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_8 and arg_204_1.time_ < var_207_0 + var_207_8 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play1108504053 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1108504053
		arg_208_1.duration_ = 6.5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1108504054(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1085ui_story"].transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.moveOldPos1085ui_story = var_211_0.localPosition
			end

			local var_211_2 = 0.001

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2
				local var_211_4 = Vector3.New(0, -1.01, -5.83)

				var_211_0.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1085ui_story, var_211_4, var_211_3)

				local var_211_5 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_5.x, var_211_5.y, var_211_5.z)

				local var_211_6 = var_211_0.localEulerAngles

				var_211_6.z = 0
				var_211_6.x = 0
				var_211_0.localEulerAngles = var_211_6
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 then
				var_211_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_211_7 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_7.x, var_211_7.y, var_211_7.z)

				local var_211_8 = var_211_0.localEulerAngles

				var_211_8.z = 0
				var_211_8.x = 0
				var_211_0.localEulerAngles = var_211_8
			end

			local var_211_9 = arg_208_1.actors_["1085ui_story"]
			local var_211_10 = 0

			if var_211_10 < arg_208_1.time_ and arg_208_1.time_ <= var_211_10 + arg_211_0 and not isNil(var_211_9) and arg_208_1.var_.characterEffect1085ui_story == nil then
				arg_208_1.var_.characterEffect1085ui_story = var_211_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_11 = 0.200000002980232

			if var_211_10 <= arg_208_1.time_ and arg_208_1.time_ < var_211_10 + var_211_11 and not isNil(var_211_9) then
				local var_211_12 = (arg_208_1.time_ - var_211_10) / var_211_11

				if arg_208_1.var_.characterEffect1085ui_story and not isNil(var_211_9) then
					arg_208_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_10 + var_211_11 and arg_208_1.time_ < var_211_10 + var_211_11 + arg_211_0 and not isNil(var_211_9) and arg_208_1.var_.characterEffect1085ui_story then
				arg_208_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_211_13 = 0

			if var_211_13 < arg_208_1.time_ and arg_208_1.time_ <= var_211_13 + arg_211_0 then
				arg_208_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_211_14 = 0

			if var_211_14 < arg_208_1.time_ and arg_208_1.time_ <= var_211_14 + arg_211_0 then
				arg_208_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_211_15 = 0
			local var_211_16 = 0.45

			if var_211_15 < arg_208_1.time_ and arg_208_1.time_ <= var_211_15 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_17 = arg_208_1:FormatText(StoryNameCfg[328].name)

				arg_208_1.leftNameTxt_.text = var_211_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_18 = arg_208_1:GetWordFromCfg(1108504053)
				local var_211_19 = arg_208_1:FormatText(var_211_18.content)

				arg_208_1.text_.text = var_211_19

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_20 = 18
				local var_211_21 = utf8.len(var_211_19)
				local var_211_22 = var_211_20 <= 0 and var_211_16 or var_211_16 * (var_211_21 / var_211_20)

				if var_211_22 > 0 and var_211_16 < var_211_22 then
					arg_208_1.talkMaxDuration = var_211_22

					if var_211_22 + var_211_15 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_22 + var_211_15
					end
				end

				arg_208_1.text_.text = var_211_19
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504053", "story_v_side_new_1108504.awb") ~= 0 then
					local var_211_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504053", "story_v_side_new_1108504.awb") / 1000

					if var_211_23 + var_211_15 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_23 + var_211_15
					end

					if var_211_18.prefab_name ~= "" and arg_208_1.actors_[var_211_18.prefab_name] ~= nil then
						local var_211_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_18.prefab_name].transform, "story_v_side_new_1108504", "1108504053", "story_v_side_new_1108504.awb")

						arg_208_1:RecordAudio("1108504053", var_211_24)
						arg_208_1:RecordAudio("1108504053", var_211_24)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504053", "story_v_side_new_1108504.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504053", "story_v_side_new_1108504.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_25 = math.max(var_211_16, arg_208_1.talkMaxDuration)

			if var_211_15 <= arg_208_1.time_ and arg_208_1.time_ < var_211_15 + var_211_25 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_15) / var_211_25

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_15 + var_211_25 and arg_208_1.time_ < var_211_15 + var_211_25 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play1108504054 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1108504054
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1108504055(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1085ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1085ui_story == nil then
				arg_212_1.var_.characterEffect1085ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect1085ui_story and not isNil(var_215_0) then
					local var_215_4 = Mathf.Lerp(0, 0.5, var_215_3)

					arg_212_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1085ui_story.fillRatio = var_215_4
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect1085ui_story then
				local var_215_5 = 0.5

				arg_212_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1085ui_story.fillRatio = var_215_5
			end

			local var_215_6 = 0
			local var_215_7 = 0.175

			if var_215_6 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_8 = arg_212_1:FormatText(StoryNameCfg[7].name)

				arg_212_1.leftNameTxt_.text = var_215_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_9 = arg_212_1:GetWordFromCfg(1108504054)
				local var_215_10 = arg_212_1:FormatText(var_215_9.content)

				arg_212_1.text_.text = var_215_10

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 7
				local var_215_12 = utf8.len(var_215_10)
				local var_215_13 = var_215_11 <= 0 and var_215_7 or var_215_7 * (var_215_12 / var_215_11)

				if var_215_13 > 0 and var_215_7 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_6
					end
				end

				arg_212_1.text_.text = var_215_10
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_14 = math.max(var_215_7, arg_212_1.talkMaxDuration)

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_14 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_6) / var_215_14

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_6 + var_215_14 and arg_212_1.time_ < var_215_6 + var_215_14 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play1108504055 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1108504055
		arg_216_1.duration_ = 6

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1108504056(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1085ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos1085ui_story = var_219_0.localPosition
			end

			local var_219_2 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2
				local var_219_4 = Vector3.New(0, 100, 0)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1085ui_story, var_219_4, var_219_3)

				local var_219_5 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_5.x, var_219_5.y, var_219_5.z)

				local var_219_6 = var_219_0.localEulerAngles

				var_219_6.z = 0
				var_219_6.x = 0
				var_219_0.localEulerAngles = var_219_6
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(0, 100, 0)

				local var_219_7 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_7.x, var_219_7.y, var_219_7.z)

				local var_219_8 = var_219_0.localEulerAngles

				var_219_8.z = 0
				var_219_8.x = 0
				var_219_0.localEulerAngles = var_219_8
			end

			local var_219_9 = 0

			if var_219_9 < arg_216_1.time_ and arg_216_1.time_ <= var_219_9 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = true

				arg_216_1:SetGaussion(false)
			end

			local var_219_10 = 1

			if var_219_9 <= arg_216_1.time_ and arg_216_1.time_ < var_219_9 + var_219_10 then
				local var_219_11 = (arg_216_1.time_ - var_219_9) / var_219_10
				local var_219_12 = Color.New(1, 1, 1)

				var_219_12.a = Mathf.Lerp(1, 0, var_219_11)
				arg_216_1.mask_.color = var_219_12
			end

			if arg_216_1.time_ >= var_219_9 + var_219_10 and arg_216_1.time_ < var_219_9 + var_219_10 + arg_219_0 then
				local var_219_13 = Color.New(1, 1, 1)
				local var_219_14 = 0

				arg_216_1.mask_.enabled = false
				var_219_13.a = var_219_14
				arg_216_1.mask_.color = var_219_13
			end

			local var_219_15 = arg_216_1.bgs_.ST15.transform
			local var_219_16 = 0

			if var_219_16 < arg_216_1.time_ and arg_216_1.time_ <= var_219_16 + arg_219_0 then
				arg_216_1.var_.moveOldPosST15 = var_219_15.localPosition
			end

			local var_219_17 = 3

			if var_219_16 <= arg_216_1.time_ and arg_216_1.time_ < var_219_16 + var_219_17 then
				local var_219_18 = (arg_216_1.time_ - var_219_16) / var_219_17
				local var_219_19 = Vector3.New(0, 1, 9)

				var_219_15.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPosST15, var_219_19, var_219_18)
			end

			if arg_216_1.time_ >= var_219_16 + var_219_17 and arg_216_1.time_ < var_219_16 + var_219_17 + arg_219_0 then
				var_219_15.localPosition = Vector3.New(0, 1, 9)
			end

			local var_219_20 = manager.ui.mainCamera.transform
			local var_219_21 = 1.23333333333333

			if var_219_21 < arg_216_1.time_ and arg_216_1.time_ <= var_219_21 + arg_219_0 then
				local var_219_22 = arg_216_1.var_.effectbenpaoshatan1
				local var_219_23
				local var_219_24 = var_219_20

				if not var_219_22 then
					var_219_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), var_219_24)
					var_219_22.name = "benpaoshatan1"
					arg_216_1.var_.effectbenpaoshatan1 = var_219_22
				else
					var_219_22.transform:SetParent(var_219_24)
				end

				var_219_22.transform.localPosition = Vector3.New(0, 0, 0)
				var_219_22.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_219_25 = manager.ui.mainCamera.transform
			local var_219_26 = 3

			if var_219_26 < arg_216_1.time_ and arg_216_1.time_ <= var_219_26 + arg_219_0 then
				local var_219_27 = arg_216_1.var_.effectbenpaoshatan1

				if var_219_27 then
					Object.Destroy(var_219_27)

					arg_216_1.var_.effectbenpaoshatan1 = nil
				end
			end

			local var_219_28 = 1.23333333333333
			local var_219_29 = 1

			if var_219_28 < arg_216_1.time_ and arg_216_1.time_ <= var_219_28 + arg_219_0 then
				local var_219_30 = "play"
				local var_219_31 = "effect"

				arg_216_1:AudioAction(var_219_30, var_219_31, "se_story_side_1085", "se_story_side_1085_run_sand", "")
			end

			local var_219_32 = 0
			local var_219_33 = 1

			if var_219_32 < arg_216_1.time_ and arg_216_1.time_ <= var_219_32 + arg_219_0 then
				local var_219_34 = "play"
				local var_219_35 = "effect"

				arg_216_1:AudioAction(var_219_34, var_219_35, "se_story_145", "se_story_145_magic_whoosh02", "")
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_36 = 1
			local var_219_37 = 1.05

			if var_219_36 < arg_216_1.time_ and arg_216_1.time_ <= var_219_36 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_38 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_38:setOnUpdate(LuaHelper.FloatAction(function(arg_220_0)
					arg_216_1.dialogCg_.alpha = arg_220_0
				end))
				var_219_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_39 = arg_216_1:GetWordFromCfg(1108504055)
				local var_219_40 = arg_216_1:FormatText(var_219_39.content)

				arg_216_1.text_.text = var_219_40

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_41 = 42
				local var_219_42 = utf8.len(var_219_40)
				local var_219_43 = var_219_41 <= 0 and var_219_37 or var_219_37 * (var_219_42 / var_219_41)

				if var_219_43 > 0 and var_219_37 < var_219_43 then
					arg_216_1.talkMaxDuration = var_219_43
					var_219_36 = var_219_36 + 0.3

					if var_219_43 + var_219_36 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_43 + var_219_36
					end
				end

				arg_216_1.text_.text = var_219_40
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_44 = var_219_36 + 0.3
			local var_219_45 = math.max(var_219_37, arg_216_1.talkMaxDuration)

			if var_219_44 <= arg_216_1.time_ and arg_216_1.time_ < var_219_44 + var_219_45 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_44) / var_219_45

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_44 + var_219_45 and arg_216_1.time_ < var_219_44 + var_219_45 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
				actorName = "ST15",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play1108504056 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1108504056
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1108504057(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.825

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_2 = arg_222_1:GetWordFromCfg(1108504056)
				local var_225_3 = arg_222_1:FormatText(var_225_2.content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 33
				local var_225_5 = utf8.len(var_225_3)
				local var_225_6 = var_225_4 <= 0 and var_225_1 or var_225_1 * (var_225_5 / var_225_4)

				if var_225_6 > 0 and var_225_1 < var_225_6 then
					arg_222_1.talkMaxDuration = var_225_6

					if var_225_6 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_6 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_7 and arg_222_1.time_ < var_225_0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1108504057 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1108504057
		arg_226_1.duration_ = 5.2

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1108504058(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1085ui_story"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos1085ui_story = var_229_0.localPosition
			end

			local var_229_2 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2
				local var_229_4 = Vector3.New(0, -1.01, -5.83)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1085ui_story, var_229_4, var_229_3)

				local var_229_5 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_5.x, var_229_5.y, var_229_5.z)

				local var_229_6 = var_229_0.localEulerAngles

				var_229_6.z = 0
				var_229_6.x = 0
				var_229_0.localEulerAngles = var_229_6
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_229_7 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_7.x, var_229_7.y, var_229_7.z)

				local var_229_8 = var_229_0.localEulerAngles

				var_229_8.z = 0
				var_229_8.x = 0
				var_229_0.localEulerAngles = var_229_8
			end

			local var_229_9 = arg_226_1.actors_["1085ui_story"]
			local var_229_10 = 0

			if var_229_10 < arg_226_1.time_ and arg_226_1.time_ <= var_229_10 + arg_229_0 and not isNil(var_229_9) and arg_226_1.var_.characterEffect1085ui_story == nil then
				arg_226_1.var_.characterEffect1085ui_story = var_229_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_11 = 0.200000002980232

			if var_229_10 <= arg_226_1.time_ and arg_226_1.time_ < var_229_10 + var_229_11 and not isNil(var_229_9) then
				local var_229_12 = (arg_226_1.time_ - var_229_10) / var_229_11

				if arg_226_1.var_.characterEffect1085ui_story and not isNil(var_229_9) then
					arg_226_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_10 + var_229_11 and arg_226_1.time_ < var_229_10 + var_229_11 + arg_229_0 and not isNil(var_229_9) and arg_226_1.var_.characterEffect1085ui_story then
				arg_226_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_229_13 = 0

			if var_229_13 < arg_226_1.time_ and arg_226_1.time_ <= var_229_13 + arg_229_0 then
				arg_226_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_229_14 = 0

			if var_229_14 < arg_226_1.time_ and arg_226_1.time_ <= var_229_14 + arg_229_0 then
				arg_226_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_229_15 = 0
			local var_229_16 = 0.225

			if var_229_15 < arg_226_1.time_ and arg_226_1.time_ <= var_229_15 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_17 = arg_226_1:FormatText(StoryNameCfg[328].name)

				arg_226_1.leftNameTxt_.text = var_229_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_18 = arg_226_1:GetWordFromCfg(1108504057)
				local var_229_19 = arg_226_1:FormatText(var_229_18.content)

				arg_226_1.text_.text = var_229_19

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_20 = 9
				local var_229_21 = utf8.len(var_229_19)
				local var_229_22 = var_229_20 <= 0 and var_229_16 or var_229_16 * (var_229_21 / var_229_20)

				if var_229_22 > 0 and var_229_16 < var_229_22 then
					arg_226_1.talkMaxDuration = var_229_22

					if var_229_22 + var_229_15 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_22 + var_229_15
					end
				end

				arg_226_1.text_.text = var_229_19
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504057", "story_v_side_new_1108504.awb") ~= 0 then
					local var_229_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504057", "story_v_side_new_1108504.awb") / 1000

					if var_229_23 + var_229_15 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_23 + var_229_15
					end

					if var_229_18.prefab_name ~= "" and arg_226_1.actors_[var_229_18.prefab_name] ~= nil then
						local var_229_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_18.prefab_name].transform, "story_v_side_new_1108504", "1108504057", "story_v_side_new_1108504.awb")

						arg_226_1:RecordAudio("1108504057", var_229_24)
						arg_226_1:RecordAudio("1108504057", var_229_24)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504057", "story_v_side_new_1108504.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504057", "story_v_side_new_1108504.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_25 = math.max(var_229_16, arg_226_1.talkMaxDuration)

			if var_229_15 <= arg_226_1.time_ and arg_226_1.time_ < var_229_15 + var_229_25 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_15) / var_229_25

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_15 + var_229_25 and arg_226_1.time_ < var_229_15 + var_229_25 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504058 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1108504058
		arg_230_1.duration_ = 9

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1108504059(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 2

			if var_233_0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_0 + arg_233_0 then
				local var_233_1 = manager.ui.mainCamera.transform.localPosition
				local var_233_2 = Vector3.New(0, 0, 10) + Vector3.New(var_233_1.x, var_233_1.y, 0)
				local var_233_3 = arg_230_1.bgs_.ST12

				var_233_3.transform.localPosition = var_233_2
				var_233_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_233_4 = var_233_3:GetComponent("SpriteRenderer")

				if var_233_4 and var_233_4.sprite then
					local var_233_5 = (var_233_3.transform.localPosition - var_233_1).z
					local var_233_6 = manager.ui.mainCameraCom_
					local var_233_7 = 2 * var_233_5 * Mathf.Tan(var_233_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_233_8 = var_233_7 * var_233_6.aspect
					local var_233_9 = var_233_4.sprite.bounds.size.x
					local var_233_10 = var_233_4.sprite.bounds.size.y
					local var_233_11 = var_233_8 / var_233_9
					local var_233_12 = var_233_7 / var_233_10
					local var_233_13 = var_233_12 < var_233_11 and var_233_11 or var_233_12

					var_233_3.transform.localScale = Vector3.New(var_233_13, var_233_13, 0)
				end

				for iter_233_0, iter_233_1 in pairs(arg_230_1.bgs_) do
					if iter_233_0 ~= "ST12" then
						iter_233_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_233_14 = 4

			if var_233_14 < arg_230_1.time_ and arg_230_1.time_ <= var_233_14 + arg_233_0 then
				arg_230_1.allBtn_.enabled = false
			end

			local var_233_15 = 0.3

			if arg_230_1.time_ >= var_233_14 + var_233_15 and arg_230_1.time_ < var_233_14 + var_233_15 + arg_233_0 then
				arg_230_1.allBtn_.enabled = true
			end

			local var_233_16 = 0

			if var_233_16 < arg_230_1.time_ and arg_230_1.time_ <= var_233_16 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_17 = 2

			if var_233_16 <= arg_230_1.time_ and arg_230_1.time_ < var_233_16 + var_233_17 then
				local var_233_18 = (arg_230_1.time_ - var_233_16) / var_233_17
				local var_233_19 = Color.New(0, 0, 0)

				var_233_19.a = Mathf.Lerp(0, 1, var_233_18)
				arg_230_1.mask_.color = var_233_19
			end

			if arg_230_1.time_ >= var_233_16 + var_233_17 and arg_230_1.time_ < var_233_16 + var_233_17 + arg_233_0 then
				local var_233_20 = Color.New(0, 0, 0)

				var_233_20.a = 1
				arg_230_1.mask_.color = var_233_20
			end

			local var_233_21 = 2

			if var_233_21 < arg_230_1.time_ and arg_230_1.time_ <= var_233_21 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_22 = 2

			if var_233_21 <= arg_230_1.time_ and arg_230_1.time_ < var_233_21 + var_233_22 then
				local var_233_23 = (arg_230_1.time_ - var_233_21) / var_233_22
				local var_233_24 = Color.New(0, 0, 0)

				var_233_24.a = Mathf.Lerp(1, 0, var_233_23)
				arg_230_1.mask_.color = var_233_24
			end

			if arg_230_1.time_ >= var_233_21 + var_233_22 and arg_230_1.time_ < var_233_21 + var_233_22 + arg_233_0 then
				local var_233_25 = Color.New(0, 0, 0)
				local var_233_26 = 0

				arg_230_1.mask_.enabled = false
				var_233_25.a = var_233_26
				arg_230_1.mask_.color = var_233_25
			end

			local var_233_27 = arg_230_1.actors_["1085ui_story"].transform
			local var_233_28 = 1.96599999815226

			if var_233_28 < arg_230_1.time_ and arg_230_1.time_ <= var_233_28 + arg_233_0 then
				arg_230_1.var_.moveOldPos1085ui_story = var_233_27.localPosition
			end

			local var_233_29 = 0.001

			if var_233_28 <= arg_230_1.time_ and arg_230_1.time_ < var_233_28 + var_233_29 then
				local var_233_30 = (arg_230_1.time_ - var_233_28) / var_233_29
				local var_233_31 = Vector3.New(0, 100, 0)

				var_233_27.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1085ui_story, var_233_31, var_233_30)

				local var_233_32 = manager.ui.mainCamera.transform.position - var_233_27.position

				var_233_27.forward = Vector3.New(var_233_32.x, var_233_32.y, var_233_32.z)

				local var_233_33 = var_233_27.localEulerAngles

				var_233_33.z = 0
				var_233_33.x = 0
				var_233_27.localEulerAngles = var_233_33
			end

			if arg_230_1.time_ >= var_233_28 + var_233_29 and arg_230_1.time_ < var_233_28 + var_233_29 + arg_233_0 then
				var_233_27.localPosition = Vector3.New(0, 100, 0)

				local var_233_34 = manager.ui.mainCamera.transform.position - var_233_27.position

				var_233_27.forward = Vector3.New(var_233_34.x, var_233_34.y, var_233_34.z)

				local var_233_35 = var_233_27.localEulerAngles

				var_233_35.z = 0
				var_233_35.x = 0
				var_233_27.localEulerAngles = var_233_35
			end

			local var_233_36 = arg_230_1.actors_["1085ui_story"]
			local var_233_37 = 1.96599999815226

			if var_233_37 < arg_230_1.time_ and arg_230_1.time_ <= var_233_37 + arg_233_0 and not isNil(var_233_36) and arg_230_1.var_.characterEffect1085ui_story == nil then
				arg_230_1.var_.characterEffect1085ui_story = var_233_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_38 = 0.034000001847744

			if var_233_37 <= arg_230_1.time_ and arg_230_1.time_ < var_233_37 + var_233_38 and not isNil(var_233_36) then
				local var_233_39 = (arg_230_1.time_ - var_233_37) / var_233_38

				if arg_230_1.var_.characterEffect1085ui_story and not isNil(var_233_36) then
					local var_233_40 = Mathf.Lerp(0, 0.5, var_233_39)

					arg_230_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1085ui_story.fillRatio = var_233_40
				end
			end

			if arg_230_1.time_ >= var_233_37 + var_233_38 and arg_230_1.time_ < var_233_37 + var_233_38 + arg_233_0 and not isNil(var_233_36) and arg_230_1.var_.characterEffect1085ui_story then
				local var_233_41 = 0.5

				arg_230_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1085ui_story.fillRatio = var_233_41
			end

			local var_233_42 = 0.266666666666667
			local var_233_43 = 0.3

			if var_233_42 < arg_230_1.time_ and arg_230_1.time_ <= var_233_42 + arg_233_0 then
				local var_233_44 = "play"
				local var_233_45 = "music"

				arg_230_1:AudioAction(var_233_44, var_233_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_233_46 = ""
				local var_233_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_233_47 ~= "" then
					if arg_230_1.bgmTxt_.text ~= var_233_47 and arg_230_1.bgmTxt_.text ~= "" then
						if arg_230_1.bgmTxt2_.text ~= "" then
							arg_230_1.bgmTxt_.text = arg_230_1.bgmTxt2_.text
						end

						arg_230_1.bgmTxt2_.text = var_233_47

						arg_230_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_230_1.bgmTxt_.text = var_233_47
						arg_230_1.bgmTxt2_.text = var_233_47
					end

					if arg_230_1.bgmTimer then
						arg_230_1.bgmTimer:Stop()

						arg_230_1.bgmTimer = nil
					end

					if arg_230_1.settingData.show_music_name == 1 then
						arg_230_1.musicController:SetSelectedState("show")
						arg_230_1.musicAnimator_:Play("open", 0, 0)

						if arg_230_1.settingData.music_time ~= 0 then
							arg_230_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_230_1.settingData.music_time), function()
								if arg_230_1 == nil or isNil(arg_230_1.bgmTxt_) then
									return
								end

								arg_230_1.musicController:SetSelectedState("hide")
								arg_230_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_233_48 = 1.66666666666667
			local var_233_49 = 1

			if var_233_48 < arg_230_1.time_ and arg_230_1.time_ <= var_233_48 + arg_233_0 then
				local var_233_50 = "play"
				local var_233_51 = "music"

				arg_230_1:AudioAction(var_233_50, var_233_51, "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_233_52 = ""
				local var_233_53 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

				if var_233_53 ~= "" then
					if arg_230_1.bgmTxt_.text ~= var_233_53 and arg_230_1.bgmTxt_.text ~= "" then
						if arg_230_1.bgmTxt2_.text ~= "" then
							arg_230_1.bgmTxt_.text = arg_230_1.bgmTxt2_.text
						end

						arg_230_1.bgmTxt2_.text = var_233_53

						arg_230_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_230_1.bgmTxt_.text = var_233_53
						arg_230_1.bgmTxt2_.text = var_233_53
					end

					if arg_230_1.bgmTimer then
						arg_230_1.bgmTimer:Stop()

						arg_230_1.bgmTimer = nil
					end

					if arg_230_1.settingData.show_music_name == 1 then
						arg_230_1.musicController:SetSelectedState("show")
						arg_230_1.musicAnimator_:Play("open", 0, 0)

						if arg_230_1.settingData.music_time ~= 0 then
							arg_230_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_230_1.settingData.music_time), function()
								if arg_230_1 == nil or isNil(arg_230_1.bgmTxt_) then
									return
								end

								arg_230_1.musicController:SetSelectedState("hide")
								arg_230_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_233_54 = 0.266666666666667
			local var_233_55 = 1

			if var_233_54 < arg_230_1.time_ and arg_230_1.time_ <= var_233_54 + arg_233_0 then
				local var_233_56 = "stop"
				local var_233_57 = "effect"

				arg_230_1:AudioAction(var_233_56, var_233_57, "se_story_133", "se_story_133_sea", "")
			end

			local var_233_58 = 1.66666666666667
			local var_233_59 = 1

			if var_233_58 < arg_230_1.time_ and arg_230_1.time_ <= var_233_58 + arg_233_0 then
				local var_233_60 = "play"
				local var_233_61 = "effect"

				arg_230_1:AudioAction(var_233_60, var_233_61, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_62 = 4
			local var_233_63 = 1.3

			if var_233_62 < arg_230_1.time_ and arg_230_1.time_ <= var_233_62 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_64 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_64:setOnUpdate(LuaHelper.FloatAction(function(arg_236_0)
					arg_230_1.dialogCg_.alpha = arg_236_0
				end))
				var_233_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_65 = arg_230_1:GetWordFromCfg(1108504058)
				local var_233_66 = arg_230_1:FormatText(var_233_65.content)

				arg_230_1.text_.text = var_233_66

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_67 = 52
				local var_233_68 = utf8.len(var_233_66)
				local var_233_69 = var_233_67 <= 0 and var_233_63 or var_233_63 * (var_233_68 / var_233_67)

				if var_233_69 > 0 and var_233_63 < var_233_69 then
					arg_230_1.talkMaxDuration = var_233_69
					var_233_62 = var_233_62 + 0.3

					if var_233_69 + var_233_62 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_69 + var_233_62
					end
				end

				arg_230_1.text_.text = var_233_66
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_70 = var_233_62 + 0.3
			local var_233_71 = math.max(var_233_63, arg_230_1.talkMaxDuration)

			if var_233_70 <= arg_230_1.time_ and arg_230_1.time_ < var_233_70 + var_233_71 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_70) / var_233_71

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_70 + var_233_71 and arg_230_1.time_ < var_233_70 + var_233_71 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play1108504059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1108504059
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1108504060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 0.275

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

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:GetWordFromCfg(1108504059)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 11
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
	Play1108504060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1108504060
		arg_242_1.duration_ = 4.03

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1108504061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["1085ui_story"].transform
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 then
				arg_242_1.var_.moveOldPos1085ui_story = var_245_0.localPosition
			end

			local var_245_2 = 0.001

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2
				local var_245_4 = Vector3.New(0, -1.01, -5.83)

				var_245_0.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1085ui_story, var_245_4, var_245_3)

				local var_245_5 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_5.x, var_245_5.y, var_245_5.z)

				local var_245_6 = var_245_0.localEulerAngles

				var_245_6.z = 0
				var_245_6.x = 0
				var_245_0.localEulerAngles = var_245_6
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 then
				var_245_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_245_7 = manager.ui.mainCamera.transform.position - var_245_0.position

				var_245_0.forward = Vector3.New(var_245_7.x, var_245_7.y, var_245_7.z)

				local var_245_8 = var_245_0.localEulerAngles

				var_245_8.z = 0
				var_245_8.x = 0
				var_245_0.localEulerAngles = var_245_8
			end

			local var_245_9 = arg_242_1.actors_["1085ui_story"]
			local var_245_10 = 0

			if var_245_10 < arg_242_1.time_ and arg_242_1.time_ <= var_245_10 + arg_245_0 and not isNil(var_245_9) and arg_242_1.var_.characterEffect1085ui_story == nil then
				arg_242_1.var_.characterEffect1085ui_story = var_245_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_11 = 0.200000002980232

			if var_245_10 <= arg_242_1.time_ and arg_242_1.time_ < var_245_10 + var_245_11 and not isNil(var_245_9) then
				local var_245_12 = (arg_242_1.time_ - var_245_10) / var_245_11

				if arg_242_1.var_.characterEffect1085ui_story and not isNil(var_245_9) then
					arg_242_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_10 + var_245_11 and arg_242_1.time_ < var_245_10 + var_245_11 + arg_245_0 and not isNil(var_245_9) and arg_242_1.var_.characterEffect1085ui_story then
				arg_242_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_245_13 = 0

			if var_245_13 < arg_242_1.time_ and arg_242_1.time_ <= var_245_13 + arg_245_0 then
				arg_242_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_245_14 = 0

			if var_245_14 < arg_242_1.time_ and arg_242_1.time_ <= var_245_14 + arg_245_0 then
				arg_242_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_245_15 = 0
			local var_245_16 = 0.35

			if var_245_15 < arg_242_1.time_ and arg_242_1.time_ <= var_245_15 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_17 = arg_242_1:FormatText(StoryNameCfg[328].name)

				arg_242_1.leftNameTxt_.text = var_245_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_18 = arg_242_1:GetWordFromCfg(1108504060)
				local var_245_19 = arg_242_1:FormatText(var_245_18.content)

				arg_242_1.text_.text = var_245_19

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_20 = 14
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504060", "story_v_side_new_1108504.awb") ~= 0 then
					local var_245_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504060", "story_v_side_new_1108504.awb") / 1000

					if var_245_23 + var_245_15 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_23 + var_245_15
					end

					if var_245_18.prefab_name ~= "" and arg_242_1.actors_[var_245_18.prefab_name] ~= nil then
						local var_245_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_18.prefab_name].transform, "story_v_side_new_1108504", "1108504060", "story_v_side_new_1108504.awb")

						arg_242_1:RecordAudio("1108504060", var_245_24)
						arg_242_1:RecordAudio("1108504060", var_245_24)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504060", "story_v_side_new_1108504.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504060", "story_v_side_new_1108504.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_25 = math.max(var_245_16, arg_242_1.talkMaxDuration)

			if var_245_15 <= arg_242_1.time_ and arg_242_1.time_ < var_245_15 + var_245_25 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_15) / var_245_25

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_15 + var_245_25 and arg_242_1.time_ < var_245_15 + var_245_25 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play1108504061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1108504061
		arg_246_1.duration_ = 3.6

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1108504062(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_249_2 = 0
			local var_249_3 = 0.275

			if var_249_2 < arg_246_1.time_ and arg_246_1.time_ <= var_249_2 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_4 = arg_246_1:FormatText(StoryNameCfg[328].name)

				arg_246_1.leftNameTxt_.text = var_249_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_5 = arg_246_1:GetWordFromCfg(1108504061)
				local var_249_6 = arg_246_1:FormatText(var_249_5.content)

				arg_246_1.text_.text = var_249_6

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_7 = 11
				local var_249_8 = utf8.len(var_249_6)
				local var_249_9 = var_249_7 <= 0 and var_249_3 or var_249_3 * (var_249_8 / var_249_7)

				if var_249_9 > 0 and var_249_3 < var_249_9 then
					arg_246_1.talkMaxDuration = var_249_9

					if var_249_9 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_9 + var_249_2
					end
				end

				arg_246_1.text_.text = var_249_6
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504061", "story_v_side_new_1108504.awb") ~= 0 then
					local var_249_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504061", "story_v_side_new_1108504.awb") / 1000

					if var_249_10 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_10 + var_249_2
					end

					if var_249_5.prefab_name ~= "" and arg_246_1.actors_[var_249_5.prefab_name] ~= nil then
						local var_249_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_5.prefab_name].transform, "story_v_side_new_1108504", "1108504061", "story_v_side_new_1108504.awb")

						arg_246_1:RecordAudio("1108504061", var_249_11)
						arg_246_1:RecordAudio("1108504061", var_249_11)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504061", "story_v_side_new_1108504.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504061", "story_v_side_new_1108504.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_12 = math.max(var_249_3, arg_246_1.talkMaxDuration)

			if var_249_2 <= arg_246_1.time_ and arg_246_1.time_ < var_249_2 + var_249_12 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_2) / var_249_12

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_2 + var_249_12 and arg_246_1.time_ < var_249_2 + var_249_12 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1108504062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1108504062
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1108504063(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1085ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1085ui_story == nil then
				arg_250_1.var_.characterEffect1085ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect1085ui_story and not isNil(var_253_0) then
					local var_253_4 = Mathf.Lerp(0, 0.5, var_253_3)

					arg_250_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1085ui_story.fillRatio = var_253_4
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1085ui_story then
				local var_253_5 = 0.5

				arg_250_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1085ui_story.fillRatio = var_253_5
			end

			local var_253_6 = 0
			local var_253_7 = 0.6

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

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_9 = arg_250_1:GetWordFromCfg(1108504062)
				local var_253_10 = arg_250_1:FormatText(var_253_9.content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 24
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
	Play1108504063 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1108504063
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1108504064(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1085ui_story"].transform
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.var_.moveOldPos1085ui_story = var_257_0.localPosition
			end

			local var_257_2 = 0.001

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2
				local var_257_4 = Vector3.New(0, 100, 0)

				var_257_0.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1085ui_story, var_257_4, var_257_3)

				local var_257_5 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_5.x, var_257_5.y, var_257_5.z)

				local var_257_6 = var_257_0.localEulerAngles

				var_257_6.z = 0
				var_257_6.x = 0
				var_257_0.localEulerAngles = var_257_6
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 then
				var_257_0.localPosition = Vector3.New(0, 100, 0)

				local var_257_7 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_7.x, var_257_7.y, var_257_7.z)

				local var_257_8 = var_257_0.localEulerAngles

				var_257_8.z = 0
				var_257_8.x = 0
				var_257_0.localEulerAngles = var_257_8
			end

			local var_257_9 = 0
			local var_257_10 = 0.575

			if var_257_9 < arg_254_1.time_ and arg_254_1.time_ <= var_257_9 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_11 = arg_254_1:GetWordFromCfg(1108504063)
				local var_257_12 = arg_254_1:FormatText(var_257_11.content)

				arg_254_1.text_.text = var_257_12

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_13 = 23
				local var_257_14 = utf8.len(var_257_12)
				local var_257_15 = var_257_13 <= 0 and var_257_10 or var_257_10 * (var_257_14 / var_257_13)

				if var_257_15 > 0 and var_257_10 < var_257_15 then
					arg_254_1.talkMaxDuration = var_257_15

					if var_257_15 + var_257_9 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_15 + var_257_9
					end
				end

				arg_254_1.text_.text = var_257_12
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_16 = math.max(var_257_10, arg_254_1.talkMaxDuration)

			if var_257_9 <= arg_254_1.time_ and arg_254_1.time_ < var_257_9 + var_257_16 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_9) / var_257_16

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_9 + var_257_16 and arg_254_1.time_ < var_257_9 + var_257_16 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504064 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1108504064
		arg_258_1.duration_ = 2.03

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1108504065(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1085ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1085ui_story = var_261_0.localPosition
			end

			local var_261_2 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2
				local var_261_4 = Vector3.New(0, -1.01, -5.83)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1085ui_story, var_261_4, var_261_3)

				local var_261_5 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_5.x, var_261_5.y, var_261_5.z)

				local var_261_6 = var_261_0.localEulerAngles

				var_261_6.z = 0
				var_261_6.x = 0
				var_261_0.localEulerAngles = var_261_6
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_261_7 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_7.x, var_261_7.y, var_261_7.z)

				local var_261_8 = var_261_0.localEulerAngles

				var_261_8.z = 0
				var_261_8.x = 0
				var_261_0.localEulerAngles = var_261_8
			end

			local var_261_9 = arg_258_1.actors_["1085ui_story"]
			local var_261_10 = 0

			if var_261_10 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect1085ui_story == nil then
				arg_258_1.var_.characterEffect1085ui_story = var_261_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_11 = 0.200000002980232

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_11 and not isNil(var_261_9) then
				local var_261_12 = (arg_258_1.time_ - var_261_10) / var_261_11

				if arg_258_1.var_.characterEffect1085ui_story and not isNil(var_261_9) then
					arg_258_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= var_261_10 + var_261_11 and arg_258_1.time_ < var_261_10 + var_261_11 + arg_261_0 and not isNil(var_261_9) and arg_258_1.var_.characterEffect1085ui_story then
				arg_258_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_261_13 = 0

			if var_261_13 < arg_258_1.time_ and arg_258_1.time_ <= var_261_13 + arg_261_0 then
				arg_258_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_261_14 = 0

			if var_261_14 < arg_258_1.time_ and arg_258_1.time_ <= var_261_14 + arg_261_0 then
				arg_258_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_261_15 = 0
			local var_261_16 = 0.125

			if var_261_15 < arg_258_1.time_ and arg_258_1.time_ <= var_261_15 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_17 = arg_258_1:FormatText(StoryNameCfg[328].name)

				arg_258_1.leftNameTxt_.text = var_261_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_18 = arg_258_1:GetWordFromCfg(1108504064)
				local var_261_19 = arg_258_1:FormatText(var_261_18.content)

				arg_258_1.text_.text = var_261_19

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_20 = 5
				local var_261_21 = utf8.len(var_261_19)
				local var_261_22 = var_261_20 <= 0 and var_261_16 or var_261_16 * (var_261_21 / var_261_20)

				if var_261_22 > 0 and var_261_16 < var_261_22 then
					arg_258_1.talkMaxDuration = var_261_22

					if var_261_22 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_22 + var_261_15
					end
				end

				arg_258_1.text_.text = var_261_19
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504064", "story_v_side_new_1108504.awb") ~= 0 then
					local var_261_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504064", "story_v_side_new_1108504.awb") / 1000

					if var_261_23 + var_261_15 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_23 + var_261_15
					end

					if var_261_18.prefab_name ~= "" and arg_258_1.actors_[var_261_18.prefab_name] ~= nil then
						local var_261_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_18.prefab_name].transform, "story_v_side_new_1108504", "1108504064", "story_v_side_new_1108504.awb")

						arg_258_1:RecordAudio("1108504064", var_261_24)
						arg_258_1:RecordAudio("1108504064", var_261_24)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504064", "story_v_side_new_1108504.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504064", "story_v_side_new_1108504.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_25 = math.max(var_261_16, arg_258_1.talkMaxDuration)

			if var_261_15 <= arg_258_1.time_ and arg_258_1.time_ < var_261_15 + var_261_25 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_15) / var_261_25

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_15 + var_261_25 and arg_258_1.time_ < var_261_15 + var_261_25 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play1108504065 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1108504065
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1108504066(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = arg_262_1.actors_["1085ui_story"]
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1085ui_story == nil then
				arg_262_1.var_.characterEffect1085ui_story = var_265_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_2 = 0.200000002980232

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 and not isNil(var_265_0) then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / var_265_2

				if arg_262_1.var_.characterEffect1085ui_story and not isNil(var_265_0) then
					local var_265_4 = Mathf.Lerp(0, 0.5, var_265_3)

					arg_262_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1085ui_story.fillRatio = var_265_4
				end
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 and not isNil(var_265_0) and arg_262_1.var_.characterEffect1085ui_story then
				local var_265_5 = 0.5

				arg_262_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1085ui_story.fillRatio = var_265_5
			end

			local var_265_6 = 0
			local var_265_7 = 0.75

			if var_265_6 < arg_262_1.time_ and arg_262_1.time_ <= var_265_6 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_8 = arg_262_1:FormatText(StoryNameCfg[7].name)

				arg_262_1.leftNameTxt_.text = var_265_8

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

				local var_265_9 = arg_262_1:GetWordFromCfg(1108504065)
				local var_265_10 = arg_262_1:FormatText(var_265_9.content)

				arg_262_1.text_.text = var_265_10

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_11 = 30
				local var_265_12 = utf8.len(var_265_10)
				local var_265_13 = var_265_11 <= 0 and var_265_7 or var_265_7 * (var_265_12 / var_265_11)

				if var_265_13 > 0 and var_265_7 < var_265_13 then
					arg_262_1.talkMaxDuration = var_265_13

					if var_265_13 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_13 + var_265_6
					end
				end

				arg_262_1.text_.text = var_265_10
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_14 = math.max(var_265_7, arg_262_1.talkMaxDuration)

			if var_265_6 <= arg_262_1.time_ and arg_262_1.time_ < var_265_6 + var_265_14 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_6) / var_265_14

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_6 + var_265_14 and arg_262_1.time_ < var_265_6 + var_265_14 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play1108504066 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1108504066
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1108504067(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.65

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[7].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:GetWordFromCfg(1108504066)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 26
				local var_269_6 = utf8.len(var_269_4)
				local var_269_7 = var_269_5 <= 0 and var_269_1 or var_269_1 * (var_269_6 / var_269_5)

				if var_269_7 > 0 and var_269_1 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_8 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_8 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_8

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_8 and arg_266_1.time_ < var_269_0 + var_269_8 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play1108504067 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1108504067
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1108504068(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["1085ui_story"].transform
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.var_.moveOldPos1085ui_story = var_273_0.localPosition
			end

			local var_273_2 = 0.001

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2
				local var_273_4 = Vector3.New(0, 100, 0)

				var_273_0.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1085ui_story, var_273_4, var_273_3)

				local var_273_5 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_5.x, var_273_5.y, var_273_5.z)

				local var_273_6 = var_273_0.localEulerAngles

				var_273_6.z = 0
				var_273_6.x = 0
				var_273_0.localEulerAngles = var_273_6
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 then
				var_273_0.localPosition = Vector3.New(0, 100, 0)

				local var_273_7 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_7.x, var_273_7.y, var_273_7.z)

				local var_273_8 = var_273_0.localEulerAngles

				var_273_8.z = 0
				var_273_8.x = 0
				var_273_0.localEulerAngles = var_273_8
			end

			local var_273_9 = 0
			local var_273_10 = 1.2

			if var_273_9 < arg_270_1.time_ and arg_270_1.time_ <= var_273_9 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_11 = arg_270_1:GetWordFromCfg(1108504067)
				local var_273_12 = arg_270_1:FormatText(var_273_11.content)

				arg_270_1.text_.text = var_273_12

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_13 = 48
				local var_273_14 = utf8.len(var_273_12)
				local var_273_15 = var_273_13 <= 0 and var_273_10 or var_273_10 * (var_273_14 / var_273_13)

				if var_273_15 > 0 and var_273_10 < var_273_15 then
					arg_270_1.talkMaxDuration = var_273_15

					if var_273_15 + var_273_9 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_15 + var_273_9
					end
				end

				arg_270_1.text_.text = var_273_12
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_16 = math.max(var_273_10, arg_270_1.talkMaxDuration)

			if var_273_9 <= arg_270_1.time_ and arg_270_1.time_ < var_273_9 + var_273_16 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_9) / var_273_16

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_9 + var_273_16 and arg_270_1.time_ < var_273_9 + var_273_16 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play1108504068 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1108504068
		arg_274_1.duration_ = 3.37

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1108504069(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["1085ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos1085ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0, -1.01, -5.83)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1085ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = arg_274_1.actors_["1085ui_story"]
			local var_277_10 = 0

			if var_277_10 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect1085ui_story == nil then
				arg_274_1.var_.characterEffect1085ui_story = var_277_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_11 = 0.200000002980232

			if var_277_10 <= arg_274_1.time_ and arg_274_1.time_ < var_277_10 + var_277_11 and not isNil(var_277_9) then
				local var_277_12 = (arg_274_1.time_ - var_277_10) / var_277_11

				if arg_274_1.var_.characterEffect1085ui_story and not isNil(var_277_9) then
					arg_274_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_10 + var_277_11 and arg_274_1.time_ < var_277_10 + var_277_11 + arg_277_0 and not isNil(var_277_9) and arg_274_1.var_.characterEffect1085ui_story then
				arg_274_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_277_13 = 0

			if var_277_13 < arg_274_1.time_ and arg_274_1.time_ <= var_277_13 + arg_277_0 then
				arg_274_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_2")
			end

			local var_277_14 = 0

			if var_277_14 < arg_274_1.time_ and arg_274_1.time_ <= var_277_14 + arg_277_0 then
				arg_274_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_277_15 = 0
			local var_277_16 = 0.275

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_17 = arg_274_1:FormatText(StoryNameCfg[328].name)

				arg_274_1.leftNameTxt_.text = var_277_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_18 = arg_274_1:GetWordFromCfg(1108504068)
				local var_277_19 = arg_274_1:FormatText(var_277_18.content)

				arg_274_1.text_.text = var_277_19

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_20 = 11
				local var_277_21 = utf8.len(var_277_19)
				local var_277_22 = var_277_20 <= 0 and var_277_16 or var_277_16 * (var_277_21 / var_277_20)

				if var_277_22 > 0 and var_277_16 < var_277_22 then
					arg_274_1.talkMaxDuration = var_277_22

					if var_277_22 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_22 + var_277_15
					end
				end

				arg_274_1.text_.text = var_277_19
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504068", "story_v_side_new_1108504.awb") ~= 0 then
					local var_277_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504068", "story_v_side_new_1108504.awb") / 1000

					if var_277_23 + var_277_15 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_23 + var_277_15
					end

					if var_277_18.prefab_name ~= "" and arg_274_1.actors_[var_277_18.prefab_name] ~= nil then
						local var_277_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_18.prefab_name].transform, "story_v_side_new_1108504", "1108504068", "story_v_side_new_1108504.awb")

						arg_274_1:RecordAudio("1108504068", var_277_24)
						arg_274_1:RecordAudio("1108504068", var_277_24)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504068", "story_v_side_new_1108504.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504068", "story_v_side_new_1108504.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_25 = math.max(var_277_16, arg_274_1.talkMaxDuration)

			if var_277_15 <= arg_274_1.time_ and arg_274_1.time_ < var_277_15 + var_277_25 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_15) / var_277_25

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_15 + var_277_25 and arg_274_1.time_ < var_277_15 + var_277_25 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504069 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1108504069
		arg_278_1.duration_ = 6.3

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1108504070(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = "STblack"

			if arg_278_1.bgs_[var_281_0] == nil then
				local var_281_1 = Object.Instantiate(arg_278_1.paintGo_)

				var_281_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_281_0)
				var_281_1.name = var_281_0
				var_281_1.transform.parent = arg_278_1.stage_.transform
				var_281_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_278_1.bgs_[var_281_0] = var_281_1
			end

			local var_281_2 = 3

			if var_281_2 < arg_278_1.time_ and arg_278_1.time_ <= var_281_2 + arg_281_0 then
				local var_281_3 = manager.ui.mainCamera.transform.localPosition
				local var_281_4 = Vector3.New(0, 0, 10) + Vector3.New(var_281_3.x, var_281_3.y, 0)
				local var_281_5 = arg_278_1.bgs_.STblack

				var_281_5.transform.localPosition = var_281_4
				var_281_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_281_6 = var_281_5:GetComponent("SpriteRenderer")

				if var_281_6 and var_281_6.sprite then
					local var_281_7 = (var_281_5.transform.localPosition - var_281_3).z
					local var_281_8 = manager.ui.mainCameraCom_
					local var_281_9 = 2 * var_281_7 * Mathf.Tan(var_281_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_281_10 = var_281_9 * var_281_8.aspect
					local var_281_11 = var_281_6.sprite.bounds.size.x
					local var_281_12 = var_281_6.sprite.bounds.size.y
					local var_281_13 = var_281_10 / var_281_11
					local var_281_14 = var_281_9 / var_281_12
					local var_281_15 = var_281_14 < var_281_13 and var_281_13 or var_281_14

					var_281_5.transform.localScale = Vector3.New(var_281_15, var_281_15, 0)
				end

				for iter_281_0, iter_281_1 in pairs(arg_278_1.bgs_) do
					if iter_281_0 ~= "STblack" then
						iter_281_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_281_16 = 5.999999999999

			if var_281_16 < arg_278_1.time_ and arg_278_1.time_ <= var_281_16 + arg_281_0 then
				arg_278_1.allBtn_.enabled = false
			end

			local var_281_17 = 0.3

			if arg_278_1.time_ >= var_281_16 + var_281_17 and arg_278_1.time_ < var_281_16 + var_281_17 + arg_281_0 then
				arg_278_1.allBtn_.enabled = true
			end

			local var_281_18 = 0

			if var_281_18 < arg_278_1.time_ and arg_278_1.time_ <= var_281_18 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_19 = 3

			if var_281_18 <= arg_278_1.time_ and arg_278_1.time_ < var_281_18 + var_281_19 then
				local var_281_20 = (arg_278_1.time_ - var_281_18) / var_281_19
				local var_281_21 = Color.New(0, 0, 0)

				var_281_21.a = Mathf.Lerp(0, 1, var_281_20)
				arg_278_1.mask_.color = var_281_21
			end

			if arg_278_1.time_ >= var_281_18 + var_281_19 and arg_278_1.time_ < var_281_18 + var_281_19 + arg_281_0 then
				local var_281_22 = Color.New(0, 0, 0)

				var_281_22.a = 1
				arg_278_1.mask_.color = var_281_22
			end

			local var_281_23 = 3

			if var_281_23 < arg_278_1.time_ and arg_278_1.time_ <= var_281_23 + arg_281_0 then
				arg_278_1.mask_.enabled = true
				arg_278_1.mask_.raycastTarget = true

				arg_278_1:SetGaussion(false)
			end

			local var_281_24 = 3

			if var_281_23 <= arg_278_1.time_ and arg_278_1.time_ < var_281_23 + var_281_24 then
				local var_281_25 = (arg_278_1.time_ - var_281_23) / var_281_24
				local var_281_26 = Color.New(0, 0, 0)

				var_281_26.a = Mathf.Lerp(1, 0, var_281_25)
				arg_278_1.mask_.color = var_281_26
			end

			if arg_278_1.time_ >= var_281_23 + var_281_24 and arg_278_1.time_ < var_281_23 + var_281_24 + arg_281_0 then
				local var_281_27 = Color.New(0, 0, 0)
				local var_281_28 = 0

				arg_278_1.mask_.enabled = false
				var_281_27.a = var_281_28
				arg_278_1.mask_.color = var_281_27
			end

			local var_281_29 = arg_278_1.actors_["1085ui_story"].transform
			local var_281_30 = 2.96599999815226

			if var_281_30 < arg_278_1.time_ and arg_278_1.time_ <= var_281_30 + arg_281_0 then
				arg_278_1.var_.moveOldPos1085ui_story = var_281_29.localPosition
			end

			local var_281_31 = 0.001

			if var_281_30 <= arg_278_1.time_ and arg_278_1.time_ < var_281_30 + var_281_31 then
				local var_281_32 = (arg_278_1.time_ - var_281_30) / var_281_31
				local var_281_33 = Vector3.New(0, 100, 0)

				var_281_29.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos1085ui_story, var_281_33, var_281_32)

				local var_281_34 = manager.ui.mainCamera.transform.position - var_281_29.position

				var_281_29.forward = Vector3.New(var_281_34.x, var_281_34.y, var_281_34.z)

				local var_281_35 = var_281_29.localEulerAngles

				var_281_35.z = 0
				var_281_35.x = 0
				var_281_29.localEulerAngles = var_281_35
			end

			if arg_278_1.time_ >= var_281_30 + var_281_31 and arg_278_1.time_ < var_281_30 + var_281_31 + arg_281_0 then
				var_281_29.localPosition = Vector3.New(0, 100, 0)

				local var_281_36 = manager.ui.mainCamera.transform.position - var_281_29.position

				var_281_29.forward = Vector3.New(var_281_36.x, var_281_36.y, var_281_36.z)

				local var_281_37 = var_281_29.localEulerAngles

				var_281_37.z = 0
				var_281_37.x = 0
				var_281_29.localEulerAngles = var_281_37
			end

			local var_281_38 = arg_278_1.actors_["1085ui_story"]
			local var_281_39 = 2.96599999815226

			if var_281_39 < arg_278_1.time_ and arg_278_1.time_ <= var_281_39 + arg_281_0 and not isNil(var_281_38) and arg_278_1.var_.characterEffect1085ui_story == nil then
				arg_278_1.var_.characterEffect1085ui_story = var_281_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_40 = 0.034000001847744

			if var_281_39 <= arg_278_1.time_ and arg_278_1.time_ < var_281_39 + var_281_40 and not isNil(var_281_38) then
				local var_281_41 = (arg_278_1.time_ - var_281_39) / var_281_40

				if arg_278_1.var_.characterEffect1085ui_story and not isNil(var_281_38) then
					local var_281_42 = Mathf.Lerp(0, 0.5, var_281_41)

					arg_278_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_278_1.var_.characterEffect1085ui_story.fillRatio = var_281_42
				end
			end

			if arg_278_1.time_ >= var_281_39 + var_281_40 and arg_278_1.time_ < var_281_39 + var_281_40 + arg_281_0 and not isNil(var_281_38) and arg_278_1.var_.characterEffect1085ui_story then
				local var_281_43 = 0.5

				arg_278_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_278_1.var_.characterEffect1085ui_story.fillRatio = var_281_43
			end

			local var_281_44 = 4.53333333333333
			local var_281_45 = 1
			local var_281_46 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504069", "story_v_side_new_1108504.awb") / 1000

			if var_281_46 > 0 and var_281_45 < var_281_46 and var_281_46 + var_281_44 > arg_278_1.duration_ then
				local var_281_47 = var_281_46

				arg_278_1.duration_ = var_281_46 + var_281_44
			end

			if var_281_44 < arg_278_1.time_ and arg_278_1.time_ <= var_281_44 + arg_281_0 then
				local var_281_48 = "play"
				local var_281_49 = "voice"

				arg_278_1:AudioAction(var_281_48, var_281_49, "story_v_side_new_1108504", "1108504069", "story_v_side_new_1108504.awb")
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1108504069,
				charCount = 7,
				enableLayoutChange = true,
				duration = 0.466666666666667,
				groupID = "shikoudixinlian1",
				startTime = 4.53333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play1108504070 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1108504070
		arg_282_1.duration_ = 9.1

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1108504071(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = "ST20"

			if arg_282_1.bgs_[var_285_0] == nil then
				local var_285_1 = Object.Instantiate(arg_282_1.paintGo_)

				var_285_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_285_0)
				var_285_1.name = var_285_0
				var_285_1.transform.parent = arg_282_1.stage_.transform
				var_285_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_282_1.bgs_[var_285_0] = var_285_1
			end

			local var_285_2 = 2

			if var_285_2 < arg_282_1.time_ and arg_282_1.time_ <= var_285_2 + arg_285_0 then
				local var_285_3 = manager.ui.mainCamera.transform.localPosition
				local var_285_4 = Vector3.New(0, 0, 10) + Vector3.New(var_285_3.x, var_285_3.y, 0)
				local var_285_5 = arg_282_1.bgs_.ST20

				var_285_5.transform.localPosition = var_285_4
				var_285_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_285_6 = var_285_5:GetComponent("SpriteRenderer")

				if var_285_6 and var_285_6.sprite then
					local var_285_7 = (var_285_5.transform.localPosition - var_285_3).z
					local var_285_8 = manager.ui.mainCameraCom_
					local var_285_9 = 2 * var_285_7 * Mathf.Tan(var_285_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_285_10 = var_285_9 * var_285_8.aspect
					local var_285_11 = var_285_6.sprite.bounds.size.x
					local var_285_12 = var_285_6.sprite.bounds.size.y
					local var_285_13 = var_285_10 / var_285_11
					local var_285_14 = var_285_9 / var_285_12
					local var_285_15 = var_285_14 < var_285_13 and var_285_13 or var_285_14

					var_285_5.transform.localScale = Vector3.New(var_285_15, var_285_15, 0)
				end

				for iter_285_0, iter_285_1 in pairs(arg_282_1.bgs_) do
					if iter_285_0 ~= "ST20" then
						iter_285_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_285_16 = 4

			if var_285_16 < arg_282_1.time_ and arg_282_1.time_ <= var_285_16 + arg_285_0 then
				arg_282_1.allBtn_.enabled = false
			end

			local var_285_17 = 0.3

			if arg_282_1.time_ >= var_285_16 + var_285_17 and arg_282_1.time_ < var_285_16 + var_285_17 + arg_285_0 then
				arg_282_1.allBtn_.enabled = true
			end

			local var_285_18 = 0

			if var_285_18 < arg_282_1.time_ and arg_282_1.time_ <= var_285_18 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = true

				arg_282_1:SetGaussion(false)
			end

			local var_285_19 = 2

			if var_285_18 <= arg_282_1.time_ and arg_282_1.time_ < var_285_18 + var_285_19 then
				local var_285_20 = (arg_282_1.time_ - var_285_18) / var_285_19
				local var_285_21 = Color.New(0, 0, 0)

				var_285_21.a = Mathf.Lerp(0, 1, var_285_20)
				arg_282_1.mask_.color = var_285_21
			end

			if arg_282_1.time_ >= var_285_18 + var_285_19 and arg_282_1.time_ < var_285_18 + var_285_19 + arg_285_0 then
				local var_285_22 = Color.New(0, 0, 0)

				var_285_22.a = 1
				arg_282_1.mask_.color = var_285_22
			end

			local var_285_23 = 2

			if var_285_23 < arg_282_1.time_ and arg_282_1.time_ <= var_285_23 + arg_285_0 then
				arg_282_1.mask_.enabled = true
				arg_282_1.mask_.raycastTarget = true

				arg_282_1:SetGaussion(false)
			end

			local var_285_24 = 2

			if var_285_23 <= arg_282_1.time_ and arg_282_1.time_ < var_285_23 + var_285_24 then
				local var_285_25 = (arg_282_1.time_ - var_285_23) / var_285_24
				local var_285_26 = Color.New(0, 0, 0)

				var_285_26.a = Mathf.Lerp(1, 0, var_285_25)
				arg_282_1.mask_.color = var_285_26
			end

			if arg_282_1.time_ >= var_285_23 + var_285_24 and arg_282_1.time_ < var_285_23 + var_285_24 + arg_285_0 then
				local var_285_27 = Color.New(0, 0, 0)
				local var_285_28 = 0

				arg_282_1.mask_.enabled = false
				var_285_27.a = var_285_28
				arg_282_1.mask_.color = var_285_27
			end

			local var_285_29 = "1037ui_story"

			if arg_282_1.actors_[var_285_29] == nil then
				local var_285_30 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_285_30) then
					local var_285_31 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_282_1.stage_.transform)

					var_285_31.name = var_285_29
					var_285_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_282_1.actors_[var_285_29] = var_285_31

					local var_285_32 = var_285_31:GetComponentInChildren(typeof(CharacterEffect))

					var_285_32.enabled = true

					local var_285_33 = GameObjectTools.GetOrAddComponent(var_285_31, typeof(DynamicBoneHelper))

					if var_285_33 then
						var_285_33:EnableDynamicBone(false)
					end

					arg_282_1:ShowWeapon(var_285_32.transform, false)

					arg_282_1.var_[var_285_29 .. "Animator"] = var_285_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_282_1.var_[var_285_29 .. "Animator"].applyRootMotion = true
					arg_282_1.var_[var_285_29 .. "LipSync"] = var_285_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_285_34 = arg_282_1.actors_["1037ui_story"].transform
			local var_285_35 = 3.8

			if var_285_35 < arg_282_1.time_ and arg_282_1.time_ <= var_285_35 + arg_285_0 then
				arg_282_1.var_.moveOldPos1037ui_story = var_285_34.localPosition
			end

			local var_285_36 = 0.001

			if var_285_35 <= arg_282_1.time_ and arg_282_1.time_ < var_285_35 + var_285_36 then
				local var_285_37 = (arg_282_1.time_ - var_285_35) / var_285_36
				local var_285_38 = Vector3.New(0, -1.09, -5.81)

				var_285_34.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1037ui_story, var_285_38, var_285_37)

				local var_285_39 = manager.ui.mainCamera.transform.position - var_285_34.position

				var_285_34.forward = Vector3.New(var_285_39.x, var_285_39.y, var_285_39.z)

				local var_285_40 = var_285_34.localEulerAngles

				var_285_40.z = 0
				var_285_40.x = 0
				var_285_34.localEulerAngles = var_285_40
			end

			if arg_282_1.time_ >= var_285_35 + var_285_36 and arg_282_1.time_ < var_285_35 + var_285_36 + arg_285_0 then
				var_285_34.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_285_41 = manager.ui.mainCamera.transform.position - var_285_34.position

				var_285_34.forward = Vector3.New(var_285_41.x, var_285_41.y, var_285_41.z)

				local var_285_42 = var_285_34.localEulerAngles

				var_285_42.z = 0
				var_285_42.x = 0
				var_285_34.localEulerAngles = var_285_42
			end

			local var_285_43 = arg_282_1.actors_["1037ui_story"]
			local var_285_44 = 3.8

			if var_285_44 < arg_282_1.time_ and arg_282_1.time_ <= var_285_44 + arg_285_0 and not isNil(var_285_43) and arg_282_1.var_.characterEffect1037ui_story == nil then
				arg_282_1.var_.characterEffect1037ui_story = var_285_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_45 = 0.200000002980232

			if var_285_44 <= arg_282_1.time_ and arg_282_1.time_ < var_285_44 + var_285_45 and not isNil(var_285_43) then
				local var_285_46 = (arg_282_1.time_ - var_285_44) / var_285_45

				if arg_282_1.var_.characterEffect1037ui_story and not isNil(var_285_43) then
					arg_282_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= var_285_44 + var_285_45 and arg_282_1.time_ < var_285_44 + var_285_45 + arg_285_0 and not isNil(var_285_43) and arg_282_1.var_.characterEffect1037ui_story then
				arg_282_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_285_47 = 3.8

			if var_285_47 < arg_282_1.time_ and arg_282_1.time_ <= var_285_47 + arg_285_0 then
				arg_282_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_285_48 = 3.8

			if var_285_48 < arg_282_1.time_ and arg_282_1.time_ <= var_285_48 + arg_285_0 then
				arg_282_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_285_49 = 0.233333333333333
			local var_285_50 = 1

			if var_285_49 < arg_282_1.time_ and arg_282_1.time_ <= var_285_49 + arg_285_0 then
				local var_285_51 = "stop"
				local var_285_52 = "effect"

				arg_282_1:AudioAction(var_285_51, var_285_52, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_285_53 = 1.6
			local var_285_54 = 1

			if var_285_53 < arg_282_1.time_ and arg_282_1.time_ <= var_285_53 + arg_285_0 then
				local var_285_55 = "play"
				local var_285_56 = "effect"

				arg_282_1:AudioAction(var_285_55, var_285_56, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_285_57 = 3.8

			arg_282_1.isInRecall_ = true

			if var_285_57 < arg_282_1.time_ and arg_282_1.time_ <= var_285_57 + arg_285_0 then
				arg_282_1.screenFilterGo_:SetActive(true)

				arg_282_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_282_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_282_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_285_2, iter_285_3 in pairs(arg_282_1.actors_) do
					local var_285_58 = iter_285_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_285_4, iter_285_5 in ipairs(var_285_58) do
						if iter_285_5.color.r > 0.51 then
							iter_285_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_285_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_285_59 = 0.2

			if var_285_57 <= arg_282_1.time_ and arg_282_1.time_ < var_285_57 + var_285_59 then
				local var_285_60 = (arg_282_1.time_ - var_285_57) / var_285_59

				arg_282_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_285_60)
			end

			if arg_282_1.time_ >= var_285_57 + var_285_59 and arg_282_1.time_ < var_285_57 + var_285_59 + arg_285_0 then
				arg_282_1.screenFilterEffect_.weight = 1
			end

			if arg_282_1.frameCnt_ <= 1 then
				arg_282_1.dialog_:SetActive(false)
			end

			local var_285_61 = 4
			local var_285_62 = 0.6

			if var_285_61 < arg_282_1.time_ and arg_282_1.time_ <= var_285_61 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0

				arg_282_1.dialog_:SetActive(true)

				arg_282_1.dialogCg_.alpha = 0

				local var_285_63 = LeanTween.value(arg_282_1.dialog_, 0, 1, 0.3)

				var_285_63:setOnUpdate(LuaHelper.FloatAction(function(arg_286_0)
					arg_282_1.dialogCg_.alpha = arg_286_0
				end))
				var_285_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_282_1.dialog_)
					var_285_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_282_1.duration_ = arg_282_1.duration_ + 0.3

				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_64 = arg_282_1:FormatText(StoryNameCfg[15].name)

				arg_282_1.leftNameTxt_.text = var_285_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_65 = arg_282_1:GetWordFromCfg(1108504070)
				local var_285_66 = arg_282_1:FormatText(var_285_65.content)

				arg_282_1.text_.text = var_285_66

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_67 = 24
				local var_285_68 = utf8.len(var_285_66)
				local var_285_69 = var_285_67 <= 0 and var_285_62 or var_285_62 * (var_285_68 / var_285_67)

				if var_285_69 > 0 and var_285_62 < var_285_69 then
					arg_282_1.talkMaxDuration = var_285_69
					var_285_61 = var_285_61 + 0.3

					if var_285_69 + var_285_61 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_69 + var_285_61
					end
				end

				arg_282_1.text_.text = var_285_66
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504070", "story_v_side_new_1108504.awb") ~= 0 then
					local var_285_70 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504070", "story_v_side_new_1108504.awb") / 1000

					if var_285_70 + var_285_61 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_70 + var_285_61
					end

					if var_285_65.prefab_name ~= "" and arg_282_1.actors_[var_285_65.prefab_name] ~= nil then
						local var_285_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_65.prefab_name].transform, "story_v_side_new_1108504", "1108504070", "story_v_side_new_1108504.awb")

						arg_282_1:RecordAudio("1108504070", var_285_71)
						arg_282_1:RecordAudio("1108504070", var_285_71)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504070", "story_v_side_new_1108504.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504070", "story_v_side_new_1108504.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_72 = var_285_61 + 0.3
			local var_285_73 = math.max(var_285_62, arg_282_1.talkMaxDuration)

			if var_285_72 <= arg_282_1.time_ and arg_282_1.time_ < var_285_72 + var_285_73 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_72) / var_285_73

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_72 + var_285_73 and arg_282_1.time_ < var_285_72 + var_285_73 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "shikoudixinlian1",
				duration = 0.1,
				className = "StoryTextGroupNode",
				startTime = 1.9,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play1108504071 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1108504071
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1108504072(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["1037ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1037ui_story == nil then
				arg_288_1.var_.characterEffect1037ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect1037ui_story and not isNil(var_291_0) then
					local var_291_4 = Mathf.Lerp(0, 0.5, var_291_3)

					arg_288_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1037ui_story.fillRatio = var_291_4
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect1037ui_story then
				local var_291_5 = 0.5

				arg_288_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1037ui_story.fillRatio = var_291_5
			end

			local var_291_6 = 0
			local var_291_7 = 0.625

			if var_291_6 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_8 = arg_288_1:FormatText(StoryNameCfg[7].name)

				arg_288_1.leftNameTxt_.text = var_291_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, true)
				arg_288_1.iconController_:SetSelectedState("hero")

				arg_288_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_288_1.callingController_:SetSelectedState("normal")

				arg_288_1.keyicon_.color = Color.New(1, 1, 1)
				arg_288_1.icon_.color = Color.New(1, 1, 1)

				local var_291_9 = arg_288_1:GetWordFromCfg(1108504071)
				local var_291_10 = arg_288_1:FormatText(var_291_9.content)

				arg_288_1.text_.text = var_291_10

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_11 = 25
				local var_291_12 = utf8.len(var_291_10)
				local var_291_13 = var_291_11 <= 0 and var_291_7 or var_291_7 * (var_291_12 / var_291_11)

				if var_291_13 > 0 and var_291_7 < var_291_13 then
					arg_288_1.talkMaxDuration = var_291_13

					if var_291_13 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_13 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_10
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_14 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_14 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_14

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_14 and arg_288_1.time_ < var_291_6 + var_291_14 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play1108504072 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1108504072
		arg_292_1.duration_ = 3.8

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1108504073(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1085ui_story"].transform
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.var_.moveOldPos1085ui_story = var_295_0.localPosition
			end

			local var_295_2 = 0.001

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2
				local var_295_4 = Vector3.New(0.75, -1.01, -5.83)

				var_295_0.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1085ui_story, var_295_4, var_295_3)

				local var_295_5 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_5.x, var_295_5.y, var_295_5.z)

				local var_295_6 = var_295_0.localEulerAngles

				var_295_6.z = 0
				var_295_6.x = 0
				var_295_0.localEulerAngles = var_295_6
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 then
				var_295_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_295_7 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_7.x, var_295_7.y, var_295_7.z)

				local var_295_8 = var_295_0.localEulerAngles

				var_295_8.z = 0
				var_295_8.x = 0
				var_295_0.localEulerAngles = var_295_8
			end

			local var_295_9 = arg_292_1.actors_["1085ui_story"]
			local var_295_10 = 0

			if var_295_10 < arg_292_1.time_ and arg_292_1.time_ <= var_295_10 + arg_295_0 and not isNil(var_295_9) and arg_292_1.var_.characterEffect1085ui_story == nil then
				arg_292_1.var_.characterEffect1085ui_story = var_295_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_11 = 0.200000002980232

			if var_295_10 <= arg_292_1.time_ and arg_292_1.time_ < var_295_10 + var_295_11 and not isNil(var_295_9) then
				local var_295_12 = (arg_292_1.time_ - var_295_10) / var_295_11

				if arg_292_1.var_.characterEffect1085ui_story and not isNil(var_295_9) then
					arg_292_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= var_295_10 + var_295_11 and arg_292_1.time_ < var_295_10 + var_295_11 + arg_295_0 and not isNil(var_295_9) and arg_292_1.var_.characterEffect1085ui_story then
				arg_292_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_295_13 = 0

			if var_295_13 < arg_292_1.time_ and arg_292_1.time_ <= var_295_13 + arg_295_0 then
				arg_292_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_295_14 = 0

			if var_295_14 < arg_292_1.time_ and arg_292_1.time_ <= var_295_14 + arg_295_0 then
				arg_292_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_295_15 = arg_292_1.actors_["1037ui_story"].transform
			local var_295_16 = 0

			if var_295_16 < arg_292_1.time_ and arg_292_1.time_ <= var_295_16 + arg_295_0 then
				arg_292_1.var_.moveOldPos1037ui_story = var_295_15.localPosition
			end

			local var_295_17 = 0.001

			if var_295_16 <= arg_292_1.time_ and arg_292_1.time_ < var_295_16 + var_295_17 then
				local var_295_18 = (arg_292_1.time_ - var_295_16) / var_295_17
				local var_295_19 = Vector3.New(-0.7, -1.09, -5.81)

				var_295_15.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1037ui_story, var_295_19, var_295_18)

				local var_295_20 = manager.ui.mainCamera.transform.position - var_295_15.position

				var_295_15.forward = Vector3.New(var_295_20.x, var_295_20.y, var_295_20.z)

				local var_295_21 = var_295_15.localEulerAngles

				var_295_21.z = 0
				var_295_21.x = 0
				var_295_15.localEulerAngles = var_295_21
			end

			if arg_292_1.time_ >= var_295_16 + var_295_17 and arg_292_1.time_ < var_295_16 + var_295_17 + arg_295_0 then
				var_295_15.localPosition = Vector3.New(-0.7, -1.09, -5.81)

				local var_295_22 = manager.ui.mainCamera.transform.position - var_295_15.position

				var_295_15.forward = Vector3.New(var_295_22.x, var_295_22.y, var_295_22.z)

				local var_295_23 = var_295_15.localEulerAngles

				var_295_23.z = 0
				var_295_23.x = 0
				var_295_15.localEulerAngles = var_295_23
			end

			local var_295_24 = 0
			local var_295_25 = 0.15

			if var_295_24 < arg_292_1.time_ and arg_292_1.time_ <= var_295_24 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_26 = arg_292_1:FormatText(StoryNameCfg[328].name)

				arg_292_1.leftNameTxt_.text = var_295_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_27 = arg_292_1:GetWordFromCfg(1108504072)
				local var_295_28 = arg_292_1:FormatText(var_295_27.content)

				arg_292_1.text_.text = var_295_28

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_29 = 6
				local var_295_30 = utf8.len(var_295_28)
				local var_295_31 = var_295_29 <= 0 and var_295_25 or var_295_25 * (var_295_30 / var_295_29)

				if var_295_31 > 0 and var_295_25 < var_295_31 then
					arg_292_1.talkMaxDuration = var_295_31

					if var_295_31 + var_295_24 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_31 + var_295_24
					end
				end

				arg_292_1.text_.text = var_295_28
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504072", "story_v_side_new_1108504.awb") ~= 0 then
					local var_295_32 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504072", "story_v_side_new_1108504.awb") / 1000

					if var_295_32 + var_295_24 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_32 + var_295_24
					end

					if var_295_27.prefab_name ~= "" and arg_292_1.actors_[var_295_27.prefab_name] ~= nil then
						local var_295_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_27.prefab_name].transform, "story_v_side_new_1108504", "1108504072", "story_v_side_new_1108504.awb")

						arg_292_1:RecordAudio("1108504072", var_295_33)
						arg_292_1:RecordAudio("1108504072", var_295_33)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504072", "story_v_side_new_1108504.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504072", "story_v_side_new_1108504.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_34 = math.max(var_295_25, arg_292_1.talkMaxDuration)

			if var_295_24 <= arg_292_1.time_ and arg_292_1.time_ < var_295_24 + var_295_34 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_24) / var_295_34

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_24 + var_295_34 and arg_292_1.time_ < var_295_24 + var_295_34 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play1108504073 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1108504073
		arg_296_1.duration_ = 8.9

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1108504074(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1037ui_story"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos1037ui_story = var_299_0.localPosition
			end

			local var_299_2 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2
				local var_299_4 = Vector3.New(-0.7, -1.09, -5.81)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1037ui_story, var_299_4, var_299_3)

				local var_299_5 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_5.x, var_299_5.y, var_299_5.z)

				local var_299_6 = var_299_0.localEulerAngles

				var_299_6.z = 0
				var_299_6.x = 0
				var_299_0.localEulerAngles = var_299_6
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(-0.7, -1.09, -5.81)

				local var_299_7 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_7.x, var_299_7.y, var_299_7.z)

				local var_299_8 = var_299_0.localEulerAngles

				var_299_8.z = 0
				var_299_8.x = 0
				var_299_0.localEulerAngles = var_299_8
			end

			local var_299_9 = arg_296_1.actors_["1037ui_story"]
			local var_299_10 = 0

			if var_299_10 < arg_296_1.time_ and arg_296_1.time_ <= var_299_10 + arg_299_0 and not isNil(var_299_9) and arg_296_1.var_.characterEffect1037ui_story == nil then
				arg_296_1.var_.characterEffect1037ui_story = var_299_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_11 = 0.200000002980232

			if var_299_10 <= arg_296_1.time_ and arg_296_1.time_ < var_299_10 + var_299_11 and not isNil(var_299_9) then
				local var_299_12 = (arg_296_1.time_ - var_299_10) / var_299_11

				if arg_296_1.var_.characterEffect1037ui_story and not isNil(var_299_9) then
					arg_296_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_10 + var_299_11 and arg_296_1.time_ < var_299_10 + var_299_11 + arg_299_0 and not isNil(var_299_9) and arg_296_1.var_.characterEffect1037ui_story then
				arg_296_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_299_13 = arg_296_1.actors_["1085ui_story"]
			local var_299_14 = 0

			if var_299_14 < arg_296_1.time_ and arg_296_1.time_ <= var_299_14 + arg_299_0 and not isNil(var_299_13) and arg_296_1.var_.characterEffect1085ui_story == nil then
				arg_296_1.var_.characterEffect1085ui_story = var_299_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_15 = 0.200000002980232

			if var_299_14 <= arg_296_1.time_ and arg_296_1.time_ < var_299_14 + var_299_15 and not isNil(var_299_13) then
				local var_299_16 = (arg_296_1.time_ - var_299_14) / var_299_15

				if arg_296_1.var_.characterEffect1085ui_story and not isNil(var_299_13) then
					local var_299_17 = Mathf.Lerp(0, 0.5, var_299_16)

					arg_296_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1085ui_story.fillRatio = var_299_17
				end
			end

			if arg_296_1.time_ >= var_299_14 + var_299_15 and arg_296_1.time_ < var_299_14 + var_299_15 + arg_299_0 and not isNil(var_299_13) and arg_296_1.var_.characterEffect1085ui_story then
				local var_299_18 = 0.5

				arg_296_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1085ui_story.fillRatio = var_299_18
			end

			local var_299_19 = 0

			if var_299_19 < arg_296_1.time_ and arg_296_1.time_ <= var_299_19 + arg_299_0 then
				arg_296_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_299_20 = 0

			if var_299_20 < arg_296_1.time_ and arg_296_1.time_ <= var_299_20 + arg_299_0 then
				arg_296_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_299_21 = 0
			local var_299_22 = 0.9

			if var_299_21 < arg_296_1.time_ and arg_296_1.time_ <= var_299_21 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_23 = arg_296_1:FormatText(StoryNameCfg[15].name)

				arg_296_1.leftNameTxt_.text = var_299_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_24 = arg_296_1:GetWordFromCfg(1108504073)
				local var_299_25 = arg_296_1:FormatText(var_299_24.content)

				arg_296_1.text_.text = var_299_25

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_26 = 36
				local var_299_27 = utf8.len(var_299_25)
				local var_299_28 = var_299_26 <= 0 and var_299_22 or var_299_22 * (var_299_27 / var_299_26)

				if var_299_28 > 0 and var_299_22 < var_299_28 then
					arg_296_1.talkMaxDuration = var_299_28

					if var_299_28 + var_299_21 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_28 + var_299_21
					end
				end

				arg_296_1.text_.text = var_299_25
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504073", "story_v_side_new_1108504.awb") ~= 0 then
					local var_299_29 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504073", "story_v_side_new_1108504.awb") / 1000

					if var_299_29 + var_299_21 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_29 + var_299_21
					end

					if var_299_24.prefab_name ~= "" and arg_296_1.actors_[var_299_24.prefab_name] ~= nil then
						local var_299_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_24.prefab_name].transform, "story_v_side_new_1108504", "1108504073", "story_v_side_new_1108504.awb")

						arg_296_1:RecordAudio("1108504073", var_299_30)
						arg_296_1:RecordAudio("1108504073", var_299_30)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504073", "story_v_side_new_1108504.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504073", "story_v_side_new_1108504.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_31 = math.max(var_299_22, arg_296_1.talkMaxDuration)

			if var_299_21 <= arg_296_1.time_ and arg_296_1.time_ < var_299_21 + var_299_31 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_21) / var_299_31

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_21 + var_299_31 and arg_296_1.time_ < var_299_21 + var_299_31 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play1108504074 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1108504074
		arg_300_1.duration_ = 2.7

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1108504075(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["1085ui_story"].transform
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.var_.moveOldPos1085ui_story = var_303_0.localPosition
			end

			local var_303_2 = 0.001

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2
				local var_303_4 = Vector3.New(0.75, -1.01, -5.83)

				var_303_0.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1085ui_story, var_303_4, var_303_3)

				local var_303_5 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_5.x, var_303_5.y, var_303_5.z)

				local var_303_6 = var_303_0.localEulerAngles

				var_303_6.z = 0
				var_303_6.x = 0
				var_303_0.localEulerAngles = var_303_6
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 then
				var_303_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_303_7 = manager.ui.mainCamera.transform.position - var_303_0.position

				var_303_0.forward = Vector3.New(var_303_7.x, var_303_7.y, var_303_7.z)

				local var_303_8 = var_303_0.localEulerAngles

				var_303_8.z = 0
				var_303_8.x = 0
				var_303_0.localEulerAngles = var_303_8
			end

			local var_303_9 = arg_300_1.actors_["1085ui_story"]
			local var_303_10 = 0

			if var_303_10 < arg_300_1.time_ and arg_300_1.time_ <= var_303_10 + arg_303_0 and not isNil(var_303_9) and arg_300_1.var_.characterEffect1085ui_story == nil then
				arg_300_1.var_.characterEffect1085ui_story = var_303_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_11 = 0.200000002980232

			if var_303_10 <= arg_300_1.time_ and arg_300_1.time_ < var_303_10 + var_303_11 and not isNil(var_303_9) then
				local var_303_12 = (arg_300_1.time_ - var_303_10) / var_303_11

				if arg_300_1.var_.characterEffect1085ui_story and not isNil(var_303_9) then
					arg_300_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_10 + var_303_11 and arg_300_1.time_ < var_303_10 + var_303_11 + arg_303_0 and not isNil(var_303_9) and arg_300_1.var_.characterEffect1085ui_story then
				arg_300_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_303_13 = arg_300_1.actors_["1037ui_story"]
			local var_303_14 = 0

			if var_303_14 < arg_300_1.time_ and arg_300_1.time_ <= var_303_14 + arg_303_0 and not isNil(var_303_13) and arg_300_1.var_.characterEffect1037ui_story == nil then
				arg_300_1.var_.characterEffect1037ui_story = var_303_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_15 = 0.200000002980232

			if var_303_14 <= arg_300_1.time_ and arg_300_1.time_ < var_303_14 + var_303_15 and not isNil(var_303_13) then
				local var_303_16 = (arg_300_1.time_ - var_303_14) / var_303_15

				if arg_300_1.var_.characterEffect1037ui_story and not isNil(var_303_13) then
					local var_303_17 = Mathf.Lerp(0, 0.5, var_303_16)

					arg_300_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_300_1.var_.characterEffect1037ui_story.fillRatio = var_303_17
				end
			end

			if arg_300_1.time_ >= var_303_14 + var_303_15 and arg_300_1.time_ < var_303_14 + var_303_15 + arg_303_0 and not isNil(var_303_13) and arg_300_1.var_.characterEffect1037ui_story then
				local var_303_18 = 0.5

				arg_300_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_300_1.var_.characterEffect1037ui_story.fillRatio = var_303_18
			end

			local var_303_19 = 0

			if var_303_19 < arg_300_1.time_ and arg_300_1.time_ <= var_303_19 + arg_303_0 then
				arg_300_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_303_20 = 0

			if var_303_20 < arg_300_1.time_ and arg_300_1.time_ <= var_303_20 + arg_303_0 then
				arg_300_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_303_21 = 0
			local var_303_22 = 0.15

			if var_303_21 < arg_300_1.time_ and arg_300_1.time_ <= var_303_21 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_23 = arg_300_1:FormatText(StoryNameCfg[328].name)

				arg_300_1.leftNameTxt_.text = var_303_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_24 = arg_300_1:GetWordFromCfg(1108504074)
				local var_303_25 = arg_300_1:FormatText(var_303_24.content)

				arg_300_1.text_.text = var_303_25

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_26 = 6
				local var_303_27 = utf8.len(var_303_25)
				local var_303_28 = var_303_26 <= 0 and var_303_22 or var_303_22 * (var_303_27 / var_303_26)

				if var_303_28 > 0 and var_303_22 < var_303_28 then
					arg_300_1.talkMaxDuration = var_303_28

					if var_303_28 + var_303_21 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_28 + var_303_21
					end
				end

				arg_300_1.text_.text = var_303_25
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504074", "story_v_side_new_1108504.awb") ~= 0 then
					local var_303_29 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504074", "story_v_side_new_1108504.awb") / 1000

					if var_303_29 + var_303_21 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_29 + var_303_21
					end

					if var_303_24.prefab_name ~= "" and arg_300_1.actors_[var_303_24.prefab_name] ~= nil then
						local var_303_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_24.prefab_name].transform, "story_v_side_new_1108504", "1108504074", "story_v_side_new_1108504.awb")

						arg_300_1:RecordAudio("1108504074", var_303_30)
						arg_300_1:RecordAudio("1108504074", var_303_30)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504074", "story_v_side_new_1108504.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504074", "story_v_side_new_1108504.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_31 = math.max(var_303_22, arg_300_1.talkMaxDuration)

			if var_303_21 <= arg_300_1.time_ and arg_300_1.time_ < var_303_21 + var_303_31 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_21) / var_303_31

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_21 + var_303_31 and arg_300_1.time_ < var_303_21 + var_303_31 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play1108504075 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1108504075
		arg_304_1.duration_ = 1.37

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1108504076(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 0
			local var_307_1 = 0.1

			if var_307_0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_2 = arg_304_1:FormatText(StoryNameCfg[328].name)

				arg_304_1.leftNameTxt_.text = var_307_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_3 = arg_304_1:GetWordFromCfg(1108504075)
				local var_307_4 = arg_304_1:FormatText(var_307_3.content)

				arg_304_1.text_.text = var_307_4

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 4
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504075", "story_v_side_new_1108504.awb") ~= 0 then
					local var_307_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504075", "story_v_side_new_1108504.awb") / 1000

					if var_307_8 + var_307_0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_8 + var_307_0
					end

					if var_307_3.prefab_name ~= "" and arg_304_1.actors_[var_307_3.prefab_name] ~= nil then
						local var_307_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_3.prefab_name].transform, "story_v_side_new_1108504", "1108504075", "story_v_side_new_1108504.awb")

						arg_304_1:RecordAudio("1108504075", var_307_9)
						arg_304_1:RecordAudio("1108504075", var_307_9)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504075", "story_v_side_new_1108504.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504075", "story_v_side_new_1108504.awb")
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
	Play1108504076 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1108504076
		arg_308_1.duration_ = 10.47

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1108504077(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 2

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				local var_311_1 = manager.ui.mainCamera.transform.localPosition
				local var_311_2 = Vector3.New(0, 0, 10) + Vector3.New(var_311_1.x, var_311_1.y, 0)
				local var_311_3 = arg_308_1.bgs_.ST20

				var_311_3.transform.localPosition = var_311_2
				var_311_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_311_4 = var_311_3:GetComponent("SpriteRenderer")

				if var_311_4 and var_311_4.sprite then
					local var_311_5 = (var_311_3.transform.localPosition - var_311_1).z
					local var_311_6 = manager.ui.mainCameraCom_
					local var_311_7 = 2 * var_311_5 * Mathf.Tan(var_311_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_311_8 = var_311_7 * var_311_6.aspect
					local var_311_9 = var_311_4.sprite.bounds.size.x
					local var_311_10 = var_311_4.sprite.bounds.size.y
					local var_311_11 = var_311_8 / var_311_9
					local var_311_12 = var_311_7 / var_311_10
					local var_311_13 = var_311_12 < var_311_11 and var_311_11 or var_311_12

					var_311_3.transform.localScale = Vector3.New(var_311_13, var_311_13, 0)
				end

				for iter_311_0, iter_311_1 in pairs(arg_308_1.bgs_) do
					if iter_311_0 ~= "ST20" then
						iter_311_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_311_14 = 4

			if var_311_14 < arg_308_1.time_ and arg_308_1.time_ <= var_311_14 + arg_311_0 then
				arg_308_1.allBtn_.enabled = false
			end

			local var_311_15 = 0.3

			if arg_308_1.time_ >= var_311_14 + var_311_15 and arg_308_1.time_ < var_311_14 + var_311_15 + arg_311_0 then
				arg_308_1.allBtn_.enabled = true
			end

			local var_311_16 = 0

			if var_311_16 < arg_308_1.time_ and arg_308_1.time_ <= var_311_16 + arg_311_0 then
				arg_308_1.mask_.enabled = true
				arg_308_1.mask_.raycastTarget = true

				arg_308_1:SetGaussion(false)
			end

			local var_311_17 = 2

			if var_311_16 <= arg_308_1.time_ and arg_308_1.time_ < var_311_16 + var_311_17 then
				local var_311_18 = (arg_308_1.time_ - var_311_16) / var_311_17
				local var_311_19 = Color.New(0, 0, 0)

				var_311_19.a = Mathf.Lerp(0, 1, var_311_18)
				arg_308_1.mask_.color = var_311_19
			end

			if arg_308_1.time_ >= var_311_16 + var_311_17 and arg_308_1.time_ < var_311_16 + var_311_17 + arg_311_0 then
				local var_311_20 = Color.New(0, 0, 0)

				var_311_20.a = 1
				arg_308_1.mask_.color = var_311_20
			end

			local var_311_21 = 2

			if var_311_21 < arg_308_1.time_ and arg_308_1.time_ <= var_311_21 + arg_311_0 then
				arg_308_1.mask_.enabled = true
				arg_308_1.mask_.raycastTarget = true

				arg_308_1:SetGaussion(false)
			end

			local var_311_22 = 2

			if var_311_21 <= arg_308_1.time_ and arg_308_1.time_ < var_311_21 + var_311_22 then
				local var_311_23 = (arg_308_1.time_ - var_311_21) / var_311_22
				local var_311_24 = Color.New(0, 0, 0)

				var_311_24.a = Mathf.Lerp(1, 0, var_311_23)
				arg_308_1.mask_.color = var_311_24
			end

			if arg_308_1.time_ >= var_311_21 + var_311_22 and arg_308_1.time_ < var_311_21 + var_311_22 + arg_311_0 then
				local var_311_25 = Color.New(0, 0, 0)
				local var_311_26 = 0

				arg_308_1.mask_.enabled = false
				var_311_25.a = var_311_26
				arg_308_1.mask_.color = var_311_25
			end

			local var_311_27 = arg_308_1.actors_["1037ui_story"].transform
			local var_311_28 = 1.96599999815226

			if var_311_28 < arg_308_1.time_ and arg_308_1.time_ <= var_311_28 + arg_311_0 then
				arg_308_1.var_.moveOldPos1037ui_story = var_311_27.localPosition
			end

			local var_311_29 = 0.001

			if var_311_28 <= arg_308_1.time_ and arg_308_1.time_ < var_311_28 + var_311_29 then
				local var_311_30 = (arg_308_1.time_ - var_311_28) / var_311_29
				local var_311_31 = Vector3.New(0, 100, 0)

				var_311_27.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1037ui_story, var_311_31, var_311_30)

				local var_311_32 = manager.ui.mainCamera.transform.position - var_311_27.position

				var_311_27.forward = Vector3.New(var_311_32.x, var_311_32.y, var_311_32.z)

				local var_311_33 = var_311_27.localEulerAngles

				var_311_33.z = 0
				var_311_33.x = 0
				var_311_27.localEulerAngles = var_311_33
			end

			if arg_308_1.time_ >= var_311_28 + var_311_29 and arg_308_1.time_ < var_311_28 + var_311_29 + arg_311_0 then
				var_311_27.localPosition = Vector3.New(0, 100, 0)

				local var_311_34 = manager.ui.mainCamera.transform.position - var_311_27.position

				var_311_27.forward = Vector3.New(var_311_34.x, var_311_34.y, var_311_34.z)

				local var_311_35 = var_311_27.localEulerAngles

				var_311_35.z = 0
				var_311_35.x = 0
				var_311_27.localEulerAngles = var_311_35
			end

			local var_311_36 = arg_308_1.actors_["1037ui_story"]
			local var_311_37 = 3.8

			if var_311_37 < arg_308_1.time_ and arg_308_1.time_ <= var_311_37 + arg_311_0 and not isNil(var_311_36) and arg_308_1.var_.characterEffect1037ui_story == nil then
				arg_308_1.var_.characterEffect1037ui_story = var_311_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_38 = 0.200000002980232

			if var_311_37 <= arg_308_1.time_ and arg_308_1.time_ < var_311_37 + var_311_38 and not isNil(var_311_36) then
				local var_311_39 = (arg_308_1.time_ - var_311_37) / var_311_38

				if arg_308_1.var_.characterEffect1037ui_story and not isNil(var_311_36) then
					arg_308_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= var_311_37 + var_311_38 and arg_308_1.time_ < var_311_37 + var_311_38 + arg_311_0 and not isNil(var_311_36) and arg_308_1.var_.characterEffect1037ui_story then
				arg_308_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_311_40 = arg_308_1.actors_["1085ui_story"]
			local var_311_41 = 1.96599999815226

			if var_311_41 < arg_308_1.time_ and arg_308_1.time_ <= var_311_41 + arg_311_0 and not isNil(var_311_40) and arg_308_1.var_.characterEffect1085ui_story == nil then
				arg_308_1.var_.characterEffect1085ui_story = var_311_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_42 = 0.034000001847744

			if var_311_41 <= arg_308_1.time_ and arg_308_1.time_ < var_311_41 + var_311_42 and not isNil(var_311_40) then
				local var_311_43 = (arg_308_1.time_ - var_311_41) / var_311_42

				if arg_308_1.var_.characterEffect1085ui_story and not isNil(var_311_40) then
					local var_311_44 = Mathf.Lerp(0, 0.5, var_311_43)

					arg_308_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1085ui_story.fillRatio = var_311_44
				end
			end

			if arg_308_1.time_ >= var_311_41 + var_311_42 and arg_308_1.time_ < var_311_41 + var_311_42 + arg_311_0 and not isNil(var_311_40) and arg_308_1.var_.characterEffect1085ui_story then
				local var_311_45 = 0.5

				arg_308_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1085ui_story.fillRatio = var_311_45
			end

			local var_311_46 = arg_308_1.actors_["1037ui_story"].transform
			local var_311_47 = 3.8

			if var_311_47 < arg_308_1.time_ and arg_308_1.time_ <= var_311_47 + arg_311_0 then
				arg_308_1.var_.moveOldPos1037ui_story = var_311_46.localPosition
			end

			local var_311_48 = 0.001

			if var_311_47 <= arg_308_1.time_ and arg_308_1.time_ < var_311_47 + var_311_48 then
				local var_311_49 = (arg_308_1.time_ - var_311_47) / var_311_48
				local var_311_50 = Vector3.New(0, -1.09, -5.81)

				var_311_46.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1037ui_story, var_311_50, var_311_49)

				local var_311_51 = manager.ui.mainCamera.transform.position - var_311_46.position

				var_311_46.forward = Vector3.New(var_311_51.x, var_311_51.y, var_311_51.z)

				local var_311_52 = var_311_46.localEulerAngles

				var_311_52.z = 0
				var_311_52.x = 0
				var_311_46.localEulerAngles = var_311_52
			end

			if arg_308_1.time_ >= var_311_47 + var_311_48 and arg_308_1.time_ < var_311_47 + var_311_48 + arg_311_0 then
				var_311_46.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_311_53 = manager.ui.mainCamera.transform.position - var_311_46.position

				var_311_46.forward = Vector3.New(var_311_53.x, var_311_53.y, var_311_53.z)

				local var_311_54 = var_311_46.localEulerAngles

				var_311_54.z = 0
				var_311_54.x = 0
				var_311_46.localEulerAngles = var_311_54
			end

			local var_311_55 = 3.8

			if var_311_55 < arg_308_1.time_ and arg_308_1.time_ <= var_311_55 + arg_311_0 then
				arg_308_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_311_56 = 3.8

			if var_311_56 < arg_308_1.time_ and arg_308_1.time_ <= var_311_56 + arg_311_0 then
				arg_308_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_311_57 = arg_308_1.actors_["1085ui_story"].transform
			local var_311_58 = 1.96599999815226

			if var_311_58 < arg_308_1.time_ and arg_308_1.time_ <= var_311_58 + arg_311_0 then
				arg_308_1.var_.moveOldPos1085ui_story = var_311_57.localPosition
			end

			local var_311_59 = 0.001

			if var_311_58 <= arg_308_1.time_ and arg_308_1.time_ < var_311_58 + var_311_59 then
				local var_311_60 = (arg_308_1.time_ - var_311_58) / var_311_59
				local var_311_61 = Vector3.New(0, 100, 0)

				var_311_57.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1085ui_story, var_311_61, var_311_60)

				local var_311_62 = manager.ui.mainCamera.transform.position - var_311_57.position

				var_311_57.forward = Vector3.New(var_311_62.x, var_311_62.y, var_311_62.z)

				local var_311_63 = var_311_57.localEulerAngles

				var_311_63.z = 0
				var_311_63.x = 0
				var_311_57.localEulerAngles = var_311_63
			end

			if arg_308_1.time_ >= var_311_58 + var_311_59 and arg_308_1.time_ < var_311_58 + var_311_59 + arg_311_0 then
				var_311_57.localPosition = Vector3.New(0, 100, 0)

				local var_311_64 = manager.ui.mainCamera.transform.position - var_311_57.position

				var_311_57.forward = Vector3.New(var_311_64.x, var_311_64.y, var_311_64.z)

				local var_311_65 = var_311_57.localEulerAngles

				var_311_65.z = 0
				var_311_65.x = 0
				var_311_57.localEulerAngles = var_311_65
			end

			if arg_308_1.frameCnt_ <= 1 then
				arg_308_1.dialog_:SetActive(false)
			end

			local var_311_66 = 4
			local var_311_67 = 0.7

			if var_311_66 < arg_308_1.time_ and arg_308_1.time_ <= var_311_66 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0

				arg_308_1.dialog_:SetActive(true)

				arg_308_1.dialogCg_.alpha = 0

				local var_311_68 = LeanTween.value(arg_308_1.dialog_, 0, 1, 0.3)

				var_311_68:setOnUpdate(LuaHelper.FloatAction(function(arg_312_0)
					arg_308_1.dialogCg_.alpha = arg_312_0
				end))
				var_311_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_308_1.dialog_)
					var_311_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_308_1.duration_ = arg_308_1.duration_ + 0.3

				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_69 = arg_308_1:FormatText(StoryNameCfg[15].name)

				arg_308_1.leftNameTxt_.text = var_311_69

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_70 = arg_308_1:GetWordFromCfg(1108504076)
				local var_311_71 = arg_308_1:FormatText(var_311_70.content)

				arg_308_1.text_.text = var_311_71

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_72 = 28
				local var_311_73 = utf8.len(var_311_71)
				local var_311_74 = var_311_72 <= 0 and var_311_67 or var_311_67 * (var_311_73 / var_311_72)

				if var_311_74 > 0 and var_311_67 < var_311_74 then
					arg_308_1.talkMaxDuration = var_311_74
					var_311_66 = var_311_66 + 0.3

					if var_311_74 + var_311_66 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_74 + var_311_66
					end
				end

				arg_308_1.text_.text = var_311_71
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504076", "story_v_side_new_1108504.awb") ~= 0 then
					local var_311_75 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504076", "story_v_side_new_1108504.awb") / 1000

					if var_311_75 + var_311_66 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_75 + var_311_66
					end

					if var_311_70.prefab_name ~= "" and arg_308_1.actors_[var_311_70.prefab_name] ~= nil then
						local var_311_76 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_70.prefab_name].transform, "story_v_side_new_1108504", "1108504076", "story_v_side_new_1108504.awb")

						arg_308_1:RecordAudio("1108504076", var_311_76)
						arg_308_1:RecordAudio("1108504076", var_311_76)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504076", "story_v_side_new_1108504.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504076", "story_v_side_new_1108504.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_77 = var_311_66 + 0.3
			local var_311_78 = math.max(var_311_67, arg_308_1.talkMaxDuration)

			if var_311_77 <= arg_308_1.time_ and arg_308_1.time_ < var_311_77 + var_311_78 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_77) / var_311_78

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_77 + var_311_78 and arg_308_1.time_ < var_311_77 + var_311_78 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play1108504077 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 1108504077
		arg_314_1.duration_ = 8.97

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play1108504078(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			local var_317_1 = 0

			if var_317_1 < arg_314_1.time_ and arg_314_1.time_ <= var_317_1 + arg_317_0 then
				arg_314_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_317_2 = 0
			local var_317_3 = 0.675

			if var_317_2 < arg_314_1.time_ and arg_314_1.time_ <= var_317_2 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_4 = arg_314_1:FormatText(StoryNameCfg[15].name)

				arg_314_1.leftNameTxt_.text = var_317_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_5 = arg_314_1:GetWordFromCfg(1108504077)
				local var_317_6 = arg_314_1:FormatText(var_317_5.content)

				arg_314_1.text_.text = var_317_6

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_7 = 27
				local var_317_8 = utf8.len(var_317_6)
				local var_317_9 = var_317_7 <= 0 and var_317_3 or var_317_3 * (var_317_8 / var_317_7)

				if var_317_9 > 0 and var_317_3 < var_317_9 then
					arg_314_1.talkMaxDuration = var_317_9

					if var_317_9 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_9 + var_317_2
					end
				end

				arg_314_1.text_.text = var_317_6
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504077", "story_v_side_new_1108504.awb") ~= 0 then
					local var_317_10 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504077", "story_v_side_new_1108504.awb") / 1000

					if var_317_10 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_10 + var_317_2
					end

					if var_317_5.prefab_name ~= "" and arg_314_1.actors_[var_317_5.prefab_name] ~= nil then
						local var_317_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_5.prefab_name].transform, "story_v_side_new_1108504", "1108504077", "story_v_side_new_1108504.awb")

						arg_314_1:RecordAudio("1108504077", var_317_11)
						arg_314_1:RecordAudio("1108504077", var_317_11)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504077", "story_v_side_new_1108504.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504077", "story_v_side_new_1108504.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_12 = math.max(var_317_3, arg_314_1.talkMaxDuration)

			if var_317_2 <= arg_314_1.time_ and arg_314_1.time_ < var_317_2 + var_317_12 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_2) / var_317_12

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_2 + var_317_12 and arg_314_1.time_ < var_317_2 + var_317_12 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play1108504078 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 1108504078
		arg_318_1.duration_ = 8.97

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play1108504079(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = arg_318_1.actors_["1037ui_story"].transform
			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.var_.moveOldPos1037ui_story = var_321_0.localPosition
			end

			local var_321_2 = 0.001

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_2 then
				local var_321_3 = (arg_318_1.time_ - var_321_1) / var_321_2
				local var_321_4 = Vector3.New(0, -1.09, -5.81)

				var_321_0.localPosition = Vector3.Lerp(arg_318_1.var_.moveOldPos1037ui_story, var_321_4, var_321_3)

				local var_321_5 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_5.x, var_321_5.y, var_321_5.z)

				local var_321_6 = var_321_0.localEulerAngles

				var_321_6.z = 0
				var_321_6.x = 0
				var_321_0.localEulerAngles = var_321_6
			end

			if arg_318_1.time_ >= var_321_1 + var_321_2 and arg_318_1.time_ < var_321_1 + var_321_2 + arg_321_0 then
				var_321_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_321_7 = manager.ui.mainCamera.transform.position - var_321_0.position

				var_321_0.forward = Vector3.New(var_321_7.x, var_321_7.y, var_321_7.z)

				local var_321_8 = var_321_0.localEulerAngles

				var_321_8.z = 0
				var_321_8.x = 0
				var_321_0.localEulerAngles = var_321_8
			end

			local var_321_9 = 0

			if var_321_9 < arg_318_1.time_ and arg_318_1.time_ <= var_321_9 + arg_321_0 then
				arg_318_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_2")
			end

			local var_321_10 = 0

			if var_321_10 < arg_318_1.time_ and arg_318_1.time_ <= var_321_10 + arg_321_0 then
				arg_318_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_321_11 = 0
			local var_321_12 = 1.025

			if var_321_11 < arg_318_1.time_ and arg_318_1.time_ <= var_321_11 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_13 = arg_318_1:FormatText(StoryNameCfg[15].name)

				arg_318_1.leftNameTxt_.text = var_321_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_14 = arg_318_1:GetWordFromCfg(1108504078)
				local var_321_15 = arg_318_1:FormatText(var_321_14.content)

				arg_318_1.text_.text = var_321_15

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_16 = 41
				local var_321_17 = utf8.len(var_321_15)
				local var_321_18 = var_321_16 <= 0 and var_321_12 or var_321_12 * (var_321_17 / var_321_16)

				if var_321_18 > 0 and var_321_12 < var_321_18 then
					arg_318_1.talkMaxDuration = var_321_18

					if var_321_18 + var_321_11 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_18 + var_321_11
					end
				end

				arg_318_1.text_.text = var_321_15
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504078", "story_v_side_new_1108504.awb") ~= 0 then
					local var_321_19 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504078", "story_v_side_new_1108504.awb") / 1000

					if var_321_19 + var_321_11 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_19 + var_321_11
					end

					if var_321_14.prefab_name ~= "" and arg_318_1.actors_[var_321_14.prefab_name] ~= nil then
						local var_321_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_14.prefab_name].transform, "story_v_side_new_1108504", "1108504078", "story_v_side_new_1108504.awb")

						arg_318_1:RecordAudio("1108504078", var_321_20)
						arg_318_1:RecordAudio("1108504078", var_321_20)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504078", "story_v_side_new_1108504.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504078", "story_v_side_new_1108504.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_21 = math.max(var_321_12, arg_318_1.talkMaxDuration)

			if var_321_11 <= arg_318_1.time_ and arg_318_1.time_ < var_321_11 + var_321_21 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_11) / var_321_21

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_11 + var_321_21 and arg_318_1.time_ < var_321_11 + var_321_21 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_318_1:InitPlayNodeList()
	end,
	Play1108504079 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 1108504079
		arg_322_1.duration_ = 10.2

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play1108504080(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 0

			if var_325_0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_0 + arg_325_0 then
				arg_322_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			local var_325_1 = 0
			local var_325_2 = 1.05

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_3 = arg_322_1:FormatText(StoryNameCfg[15].name)

				arg_322_1.leftNameTxt_.text = var_325_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_4 = arg_322_1:GetWordFromCfg(1108504079)
				local var_325_5 = arg_322_1:FormatText(var_325_4.content)

				arg_322_1.text_.text = var_325_5

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_6 = 42
				local var_325_7 = utf8.len(var_325_5)
				local var_325_8 = var_325_6 <= 0 and var_325_2 or var_325_2 * (var_325_7 / var_325_6)

				if var_325_8 > 0 and var_325_2 < var_325_8 then
					arg_322_1.talkMaxDuration = var_325_8

					if var_325_8 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_1
					end
				end

				arg_322_1.text_.text = var_325_5
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504079", "story_v_side_new_1108504.awb") ~= 0 then
					local var_325_9 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504079", "story_v_side_new_1108504.awb") / 1000

					if var_325_9 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_1
					end

					if var_325_4.prefab_name ~= "" and arg_322_1.actors_[var_325_4.prefab_name] ~= nil then
						local var_325_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_4.prefab_name].transform, "story_v_side_new_1108504", "1108504079", "story_v_side_new_1108504.awb")

						arg_322_1:RecordAudio("1108504079", var_325_10)
						arg_322_1:RecordAudio("1108504079", var_325_10)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504079", "story_v_side_new_1108504.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504079", "story_v_side_new_1108504.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_11 = math.max(var_325_2, arg_322_1.talkMaxDuration)

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_11 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_1) / var_325_11

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_1 + var_325_11 and arg_322_1.time_ < var_325_1 + var_325_11 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play1108504080 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 1108504080
		arg_326_1.duration_ = 8.17

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play1108504081(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = "ST07a"

			if arg_326_1.bgs_[var_329_0] == nil then
				local var_329_1 = Object.Instantiate(arg_326_1.paintGo_)

				var_329_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_329_0)
				var_329_1.name = var_329_0
				var_329_1.transform.parent = arg_326_1.stage_.transform
				var_329_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_326_1.bgs_[var_329_0] = var_329_1
			end

			local var_329_2 = 2

			if var_329_2 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				local var_329_3 = manager.ui.mainCamera.transform.localPosition
				local var_329_4 = Vector3.New(0, 0, 10) + Vector3.New(var_329_3.x, var_329_3.y, 0)
				local var_329_5 = arg_326_1.bgs_.ST07a

				var_329_5.transform.localPosition = var_329_4
				var_329_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_329_6 = var_329_5:GetComponent("SpriteRenderer")

				if var_329_6 and var_329_6.sprite then
					local var_329_7 = (var_329_5.transform.localPosition - var_329_3).z
					local var_329_8 = manager.ui.mainCameraCom_
					local var_329_9 = 2 * var_329_7 * Mathf.Tan(var_329_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_329_10 = var_329_9 * var_329_8.aspect
					local var_329_11 = var_329_6.sprite.bounds.size.x
					local var_329_12 = var_329_6.sprite.bounds.size.y
					local var_329_13 = var_329_10 / var_329_11
					local var_329_14 = var_329_9 / var_329_12
					local var_329_15 = var_329_14 < var_329_13 and var_329_13 or var_329_14

					var_329_5.transform.localScale = Vector3.New(var_329_15, var_329_15, 0)
				end

				for iter_329_0, iter_329_1 in pairs(arg_326_1.bgs_) do
					if iter_329_0 ~= "ST07a" then
						iter_329_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_329_16 = 4

			if var_329_16 < arg_326_1.time_ and arg_326_1.time_ <= var_329_16 + arg_329_0 then
				arg_326_1.allBtn_.enabled = false
			end

			local var_329_17 = 0.3

			if arg_326_1.time_ >= var_329_16 + var_329_17 and arg_326_1.time_ < var_329_16 + var_329_17 + arg_329_0 then
				arg_326_1.allBtn_.enabled = true
			end

			local var_329_18 = 0

			if var_329_18 < arg_326_1.time_ and arg_326_1.time_ <= var_329_18 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_19 = 2

			if var_329_18 <= arg_326_1.time_ and arg_326_1.time_ < var_329_18 + var_329_19 then
				local var_329_20 = (arg_326_1.time_ - var_329_18) / var_329_19
				local var_329_21 = Color.New(0, 0, 0)

				var_329_21.a = Mathf.Lerp(0, 1, var_329_20)
				arg_326_1.mask_.color = var_329_21
			end

			if arg_326_1.time_ >= var_329_18 + var_329_19 and arg_326_1.time_ < var_329_18 + var_329_19 + arg_329_0 then
				local var_329_22 = Color.New(0, 0, 0)

				var_329_22.a = 1
				arg_326_1.mask_.color = var_329_22
			end

			local var_329_23 = 2

			if var_329_23 < arg_326_1.time_ and arg_326_1.time_ <= var_329_23 + arg_329_0 then
				arg_326_1.mask_.enabled = true
				arg_326_1.mask_.raycastTarget = true

				arg_326_1:SetGaussion(false)
			end

			local var_329_24 = 2

			if var_329_23 <= arg_326_1.time_ and arg_326_1.time_ < var_329_23 + var_329_24 then
				local var_329_25 = (arg_326_1.time_ - var_329_23) / var_329_24
				local var_329_26 = Color.New(0, 0, 0)

				var_329_26.a = Mathf.Lerp(1, 0, var_329_25)
				arg_326_1.mask_.color = var_329_26
			end

			if arg_326_1.time_ >= var_329_23 + var_329_24 and arg_326_1.time_ < var_329_23 + var_329_24 + arg_329_0 then
				local var_329_27 = Color.New(0, 0, 0)
				local var_329_28 = 0

				arg_326_1.mask_.enabled = false
				var_329_27.a = var_329_28
				arg_326_1.mask_.color = var_329_27
			end

			local var_329_29 = arg_326_1.actors_["1085ui_story"].transform
			local var_329_30 = 3.79999999701977

			if var_329_30 < arg_326_1.time_ and arg_326_1.time_ <= var_329_30 + arg_329_0 then
				arg_326_1.var_.moveOldPos1085ui_story = var_329_29.localPosition
			end

			local var_329_31 = 0.001

			if var_329_30 <= arg_326_1.time_ and arg_326_1.time_ < var_329_30 + var_329_31 then
				local var_329_32 = (arg_326_1.time_ - var_329_30) / var_329_31
				local var_329_33 = Vector3.New(0.75, -1.01, -5.83)

				var_329_29.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1085ui_story, var_329_33, var_329_32)

				local var_329_34 = manager.ui.mainCamera.transform.position - var_329_29.position

				var_329_29.forward = Vector3.New(var_329_34.x, var_329_34.y, var_329_34.z)

				local var_329_35 = var_329_29.localEulerAngles

				var_329_35.z = 0
				var_329_35.x = 0
				var_329_29.localEulerAngles = var_329_35
			end

			if arg_326_1.time_ >= var_329_30 + var_329_31 and arg_326_1.time_ < var_329_30 + var_329_31 + arg_329_0 then
				var_329_29.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_329_36 = manager.ui.mainCamera.transform.position - var_329_29.position

				var_329_29.forward = Vector3.New(var_329_36.x, var_329_36.y, var_329_36.z)

				local var_329_37 = var_329_29.localEulerAngles

				var_329_37.z = 0
				var_329_37.x = 0
				var_329_29.localEulerAngles = var_329_37
			end

			local var_329_38 = arg_326_1.actors_["1085ui_story"]
			local var_329_39 = 3.79999999701977

			if var_329_39 < arg_326_1.time_ and arg_326_1.time_ <= var_329_39 + arg_329_0 and not isNil(var_329_38) and arg_326_1.var_.characterEffect1085ui_story == nil then
				arg_326_1.var_.characterEffect1085ui_story = var_329_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_40 = 0.2

			if var_329_39 <= arg_326_1.time_ and arg_326_1.time_ < var_329_39 + var_329_40 and not isNil(var_329_38) then
				local var_329_41 = (arg_326_1.time_ - var_329_39) / var_329_40

				if arg_326_1.var_.characterEffect1085ui_story and not isNil(var_329_38) then
					arg_326_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= var_329_39 + var_329_40 and arg_326_1.time_ < var_329_39 + var_329_40 + arg_329_0 and not isNil(var_329_38) and arg_326_1.var_.characterEffect1085ui_story then
				arg_326_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_329_42 = 3.79999999701977

			if var_329_42 < arg_326_1.time_ and arg_326_1.time_ <= var_329_42 + arg_329_0 then
				arg_326_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_329_43 = arg_326_1.actors_["1037ui_story"].transform
			local var_329_44 = 1.96599999815226

			if var_329_44 < arg_326_1.time_ and arg_326_1.time_ <= var_329_44 + arg_329_0 then
				arg_326_1.var_.moveOldPos1037ui_story = var_329_43.localPosition
			end

			local var_329_45 = 0.001

			if var_329_44 <= arg_326_1.time_ and arg_326_1.time_ < var_329_44 + var_329_45 then
				local var_329_46 = (arg_326_1.time_ - var_329_44) / var_329_45
				local var_329_47 = Vector3.New(0, 100, 0)

				var_329_43.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1037ui_story, var_329_47, var_329_46)

				local var_329_48 = manager.ui.mainCamera.transform.position - var_329_43.position

				var_329_43.forward = Vector3.New(var_329_48.x, var_329_48.y, var_329_48.z)

				local var_329_49 = var_329_43.localEulerAngles

				var_329_49.z = 0
				var_329_49.x = 0
				var_329_43.localEulerAngles = var_329_49
			end

			if arg_326_1.time_ >= var_329_44 + var_329_45 and arg_326_1.time_ < var_329_44 + var_329_45 + arg_329_0 then
				var_329_43.localPosition = Vector3.New(0, 100, 0)

				local var_329_50 = manager.ui.mainCamera.transform.position - var_329_43.position

				var_329_43.forward = Vector3.New(var_329_50.x, var_329_50.y, var_329_50.z)

				local var_329_51 = var_329_43.localEulerAngles

				var_329_51.z = 0
				var_329_51.x = 0
				var_329_43.localEulerAngles = var_329_51
			end

			local var_329_52 = 3.79999999701977

			if var_329_52 < arg_326_1.time_ and arg_326_1.time_ <= var_329_52 + arg_329_0 then
				arg_326_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_329_53 = arg_326_1.actors_["1037ui_story"]
			local var_329_54 = 1.98333333333333

			if var_329_54 < arg_326_1.time_ and arg_326_1.time_ <= var_329_54 + arg_329_0 and not isNil(var_329_53) and arg_326_1.var_.characterEffect1037ui_story == nil then
				arg_326_1.var_.characterEffect1037ui_story = var_329_53:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_55 = 0.0166666666666666

			if var_329_54 <= arg_326_1.time_ and arg_326_1.time_ < var_329_54 + var_329_55 and not isNil(var_329_53) then
				local var_329_56 = (arg_326_1.time_ - var_329_54) / var_329_55

				if arg_326_1.var_.characterEffect1037ui_story and not isNil(var_329_53) then
					local var_329_57 = Mathf.Lerp(0, 0.5, var_329_56)

					arg_326_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_326_1.var_.characterEffect1037ui_story.fillRatio = var_329_57
				end
			end

			if arg_326_1.time_ >= var_329_54 + var_329_55 and arg_326_1.time_ < var_329_54 + var_329_55 + arg_329_0 and not isNil(var_329_53) and arg_326_1.var_.characterEffect1037ui_story then
				local var_329_58 = 0.5

				arg_326_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_326_1.var_.characterEffect1037ui_story.fillRatio = var_329_58
			end

			local var_329_59 = 0.266666666666667
			local var_329_60 = 1

			if var_329_59 < arg_326_1.time_ and arg_326_1.time_ <= var_329_59 + arg_329_0 then
				local var_329_61 = "stop"
				local var_329_62 = "effect"

				arg_326_1:AudioAction(var_329_61, var_329_62, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_329_63 = 1.56666666666667
			local var_329_64 = 1

			if var_329_63 < arg_326_1.time_ and arg_326_1.time_ <= var_329_63 + arg_329_0 then
				local var_329_65 = "play"
				local var_329_66 = "effect"

				arg_326_1:AudioAction(var_329_65, var_329_66, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_329_67 = arg_326_1.actors_["1085ui_story"].transform
			local var_329_68 = 1.96599999815226

			if var_329_68 < arg_326_1.time_ and arg_326_1.time_ <= var_329_68 + arg_329_0 then
				arg_326_1.var_.moveOldPos1085ui_story = var_329_67.localPosition
			end

			local var_329_69 = 0.001

			if var_329_68 <= arg_326_1.time_ and arg_326_1.time_ < var_329_68 + var_329_69 then
				local var_329_70 = (arg_326_1.time_ - var_329_68) / var_329_69
				local var_329_71 = Vector3.New(0, 100, 0)

				var_329_67.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1085ui_story, var_329_71, var_329_70)

				local var_329_72 = manager.ui.mainCamera.transform.position - var_329_67.position

				var_329_67.forward = Vector3.New(var_329_72.x, var_329_72.y, var_329_72.z)

				local var_329_73 = var_329_67.localEulerAngles

				var_329_73.z = 0
				var_329_73.x = 0
				var_329_67.localEulerAngles = var_329_73
			end

			if arg_326_1.time_ >= var_329_68 + var_329_69 and arg_326_1.time_ < var_329_68 + var_329_69 + arg_329_0 then
				var_329_67.localPosition = Vector3.New(0, 100, 0)

				local var_329_74 = manager.ui.mainCamera.transform.position - var_329_67.position

				var_329_67.forward = Vector3.New(var_329_74.x, var_329_74.y, var_329_74.z)

				local var_329_75 = var_329_67.localEulerAngles

				var_329_75.z = 0
				var_329_75.x = 0
				var_329_67.localEulerAngles = var_329_75
			end

			if arg_326_1.frameCnt_ <= 1 then
				arg_326_1.dialog_:SetActive(false)
			end

			local var_329_76 = 4
			local var_329_77 = 0.35

			if var_329_76 < arg_326_1.time_ and arg_326_1.time_ <= var_329_76 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0

				arg_326_1.dialog_:SetActive(true)

				arg_326_1.dialogCg_.alpha = 0

				local var_329_78 = LeanTween.value(arg_326_1.dialog_, 0, 1, 0.3)

				var_329_78:setOnUpdate(LuaHelper.FloatAction(function(arg_330_0)
					arg_326_1.dialogCg_.alpha = arg_330_0
				end))
				var_329_78:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_326_1.dialog_)
					var_329_78:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_326_1.duration_ = arg_326_1.duration_ + 0.3

				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_79 = arg_326_1:FormatText(StoryNameCfg[328].name)

				arg_326_1.leftNameTxt_.text = var_329_79

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_80 = arg_326_1:GetWordFromCfg(1108504080)
				local var_329_81 = arg_326_1:FormatText(var_329_80.content)

				arg_326_1.text_.text = var_329_81

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_82 = 14
				local var_329_83 = utf8.len(var_329_81)
				local var_329_84 = var_329_82 <= 0 and var_329_77 or var_329_77 * (var_329_83 / var_329_82)

				if var_329_84 > 0 and var_329_77 < var_329_84 then
					arg_326_1.talkMaxDuration = var_329_84
					var_329_76 = var_329_76 + 0.3

					if var_329_84 + var_329_76 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_84 + var_329_76
					end
				end

				arg_326_1.text_.text = var_329_81
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504080", "story_v_side_new_1108504.awb") ~= 0 then
					local var_329_85 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504080", "story_v_side_new_1108504.awb") / 1000

					if var_329_85 + var_329_76 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_85 + var_329_76
					end

					if var_329_80.prefab_name ~= "" and arg_326_1.actors_[var_329_80.prefab_name] ~= nil then
						local var_329_86 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_80.prefab_name].transform, "story_v_side_new_1108504", "1108504080", "story_v_side_new_1108504.awb")

						arg_326_1:RecordAudio("1108504080", var_329_86)
						arg_326_1:RecordAudio("1108504080", var_329_86)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504080", "story_v_side_new_1108504.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504080", "story_v_side_new_1108504.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_87 = var_329_76 + 0.3
			local var_329_88 = math.max(var_329_77, arg_326_1.talkMaxDuration)

			if var_329_87 <= arg_326_1.time_ and arg_326_1.time_ < var_329_87 + var_329_88 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_87) / var_329_88

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_87 + var_329_88 and arg_326_1.time_ < var_329_87 + var_329_88 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.79999999701977,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_326_1:InitPlayNodeList()
	end,
	Play1108504081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1108504081
		arg_332_1.duration_ = 1.97

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1108504082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = "10066ui_story"

			if arg_332_1.actors_[var_335_0] == nil then
				local var_335_1 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_335_1) then
					local var_335_2 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_332_1.stage_.transform)

					var_335_2.name = var_335_0
					var_335_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_332_1.actors_[var_335_0] = var_335_2

					local var_335_3 = var_335_2:GetComponentInChildren(typeof(CharacterEffect))

					var_335_3.enabled = true

					local var_335_4 = GameObjectTools.GetOrAddComponent(var_335_2, typeof(DynamicBoneHelper))

					if var_335_4 then
						var_335_4:EnableDynamicBone(false)
					end

					arg_332_1:ShowWeapon(var_335_3.transform, false)

					arg_332_1.var_[var_335_0 .. "Animator"] = var_335_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_332_1.var_[var_335_0 .. "Animator"].applyRootMotion = true
					arg_332_1.var_[var_335_0 .. "LipSync"] = var_335_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_335_5 = arg_332_1.actors_["10066ui_story"].transform
			local var_335_6 = 0

			if var_335_6 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 then
				arg_332_1.var_.moveOldPos10066ui_story = var_335_5.localPosition
			end

			local var_335_7 = 0.001

			if var_335_6 <= arg_332_1.time_ and arg_332_1.time_ < var_335_6 + var_335_7 then
				local var_335_8 = (arg_332_1.time_ - var_335_6) / var_335_7
				local var_335_9 = Vector3.New(-0.7, -0.99, -5.83)

				var_335_5.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10066ui_story, var_335_9, var_335_8)

				local var_335_10 = manager.ui.mainCamera.transform.position - var_335_5.position

				var_335_5.forward = Vector3.New(var_335_10.x, var_335_10.y, var_335_10.z)

				local var_335_11 = var_335_5.localEulerAngles

				var_335_11.z = 0
				var_335_11.x = 0
				var_335_5.localEulerAngles = var_335_11
			end

			if arg_332_1.time_ >= var_335_6 + var_335_7 and arg_332_1.time_ < var_335_6 + var_335_7 + arg_335_0 then
				var_335_5.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_335_12 = manager.ui.mainCamera.transform.position - var_335_5.position

				var_335_5.forward = Vector3.New(var_335_12.x, var_335_12.y, var_335_12.z)

				local var_335_13 = var_335_5.localEulerAngles

				var_335_13.z = 0
				var_335_13.x = 0
				var_335_5.localEulerAngles = var_335_13
			end

			local var_335_14 = arg_332_1.actors_["1037ui_story"].transform
			local var_335_15 = 0

			if var_335_15 < arg_332_1.time_ and arg_332_1.time_ <= var_335_15 + arg_335_0 then
				arg_332_1.var_.moveOldPos1037ui_story = var_335_14.localPosition
			end

			local var_335_16 = 0.001

			if var_335_15 <= arg_332_1.time_ and arg_332_1.time_ < var_335_15 + var_335_16 then
				local var_335_17 = (arg_332_1.time_ - var_335_15) / var_335_16
				local var_335_18 = Vector3.New(0, 100, 0)

				var_335_14.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1037ui_story, var_335_18, var_335_17)

				local var_335_19 = manager.ui.mainCamera.transform.position - var_335_14.position

				var_335_14.forward = Vector3.New(var_335_19.x, var_335_19.y, var_335_19.z)

				local var_335_20 = var_335_14.localEulerAngles

				var_335_20.z = 0
				var_335_20.x = 0
				var_335_14.localEulerAngles = var_335_20
			end

			if arg_332_1.time_ >= var_335_15 + var_335_16 and arg_332_1.time_ < var_335_15 + var_335_16 + arg_335_0 then
				var_335_14.localPosition = Vector3.New(0, 100, 0)

				local var_335_21 = manager.ui.mainCamera.transform.position - var_335_14.position

				var_335_14.forward = Vector3.New(var_335_21.x, var_335_21.y, var_335_21.z)

				local var_335_22 = var_335_14.localEulerAngles

				var_335_22.z = 0
				var_335_22.x = 0
				var_335_14.localEulerAngles = var_335_22
			end

			local var_335_23 = arg_332_1.actors_["10066ui_story"]
			local var_335_24 = 0

			if var_335_24 < arg_332_1.time_ and arg_332_1.time_ <= var_335_24 + arg_335_0 and not isNil(var_335_23) and arg_332_1.var_.characterEffect10066ui_story == nil then
				arg_332_1.var_.characterEffect10066ui_story = var_335_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_25 = 0.200000002980232

			if var_335_24 <= arg_332_1.time_ and arg_332_1.time_ < var_335_24 + var_335_25 and not isNil(var_335_23) then
				local var_335_26 = (arg_332_1.time_ - var_335_24) / var_335_25

				if arg_332_1.var_.characterEffect10066ui_story and not isNil(var_335_23) then
					arg_332_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_24 + var_335_25 and arg_332_1.time_ < var_335_24 + var_335_25 + arg_335_0 and not isNil(var_335_23) and arg_332_1.var_.characterEffect10066ui_story then
				arg_332_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_335_27 = arg_332_1.actors_["1085ui_story"]
			local var_335_28 = 0

			if var_335_28 < arg_332_1.time_ and arg_332_1.time_ <= var_335_28 + arg_335_0 and not isNil(var_335_27) and arg_332_1.var_.characterEffect1085ui_story == nil then
				arg_332_1.var_.characterEffect1085ui_story = var_335_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_29 = 0.200000002980232

			if var_335_28 <= arg_332_1.time_ and arg_332_1.time_ < var_335_28 + var_335_29 and not isNil(var_335_27) then
				local var_335_30 = (arg_332_1.time_ - var_335_28) / var_335_29

				if arg_332_1.var_.characterEffect1085ui_story and not isNil(var_335_27) then
					local var_335_31 = Mathf.Lerp(0, 0.5, var_335_30)

					arg_332_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_332_1.var_.characterEffect1085ui_story.fillRatio = var_335_31
				end
			end

			if arg_332_1.time_ >= var_335_28 + var_335_29 and arg_332_1.time_ < var_335_28 + var_335_29 + arg_335_0 and not isNil(var_335_27) and arg_332_1.var_.characterEffect1085ui_story then
				local var_335_32 = 0.5

				arg_332_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_332_1.var_.characterEffect1085ui_story.fillRatio = var_335_32
			end

			local var_335_33 = 0

			if var_335_33 < arg_332_1.time_ and arg_332_1.time_ <= var_335_33 + arg_335_0 then
				arg_332_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_335_34 = 0

			if var_335_34 < arg_332_1.time_ and arg_332_1.time_ <= var_335_34 + arg_335_0 then
				arg_332_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_335_35 = 0
			local var_335_36 = 0.2

			if var_335_35 < arg_332_1.time_ and arg_332_1.time_ <= var_335_35 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_37 = arg_332_1:FormatText(StoryNameCfg[640].name)

				arg_332_1.leftNameTxt_.text = var_335_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_38 = arg_332_1:GetWordFromCfg(1108504081)
				local var_335_39 = arg_332_1:FormatText(var_335_38.content)

				arg_332_1.text_.text = var_335_39

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_40 = 8
				local var_335_41 = utf8.len(var_335_39)
				local var_335_42 = var_335_40 <= 0 and var_335_36 or var_335_36 * (var_335_41 / var_335_40)

				if var_335_42 > 0 and var_335_36 < var_335_42 then
					arg_332_1.talkMaxDuration = var_335_42

					if var_335_42 + var_335_35 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_42 + var_335_35
					end
				end

				arg_332_1.text_.text = var_335_39
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504081", "story_v_side_new_1108504.awb") ~= 0 then
					local var_335_43 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504081", "story_v_side_new_1108504.awb") / 1000

					if var_335_43 + var_335_35 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_43 + var_335_35
					end

					if var_335_38.prefab_name ~= "" and arg_332_1.actors_[var_335_38.prefab_name] ~= nil then
						local var_335_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_38.prefab_name].transform, "story_v_side_new_1108504", "1108504081", "story_v_side_new_1108504.awb")

						arg_332_1:RecordAudio("1108504081", var_335_44)
						arg_332_1:RecordAudio("1108504081", var_335_44)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504081", "story_v_side_new_1108504.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504081", "story_v_side_new_1108504.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_45 = math.max(var_335_36, arg_332_1.talkMaxDuration)

			if var_335_35 <= arg_332_1.time_ and arg_332_1.time_ < var_335_35 + var_335_45 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_35) / var_335_45

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_35 + var_335_45 and arg_332_1.time_ < var_335_35 + var_335_45 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play1108504082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1108504082
		arg_336_1.duration_ = 6.8

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play1108504083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["1085ui_story"].transform
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.var_.moveOldPos1085ui_story = var_339_0.localPosition
			end

			local var_339_2 = 0.001

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2
				local var_339_4 = Vector3.New(0.75, -1.01, -5.83)

				var_339_0.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1085ui_story, var_339_4, var_339_3)

				local var_339_5 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_5.x, var_339_5.y, var_339_5.z)

				local var_339_6 = var_339_0.localEulerAngles

				var_339_6.z = 0
				var_339_6.x = 0
				var_339_0.localEulerAngles = var_339_6
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 then
				var_339_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_339_7 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_7.x, var_339_7.y, var_339_7.z)

				local var_339_8 = var_339_0.localEulerAngles

				var_339_8.z = 0
				var_339_8.x = 0
				var_339_0.localEulerAngles = var_339_8
			end

			local var_339_9 = arg_336_1.actors_["1085ui_story"]
			local var_339_10 = 0

			if var_339_10 < arg_336_1.time_ and arg_336_1.time_ <= var_339_10 + arg_339_0 and not isNil(var_339_9) and arg_336_1.var_.characterEffect1085ui_story == nil then
				arg_336_1.var_.characterEffect1085ui_story = var_339_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_11 = 0.200000002980232

			if var_339_10 <= arg_336_1.time_ and arg_336_1.time_ < var_339_10 + var_339_11 and not isNil(var_339_9) then
				local var_339_12 = (arg_336_1.time_ - var_339_10) / var_339_11

				if arg_336_1.var_.characterEffect1085ui_story and not isNil(var_339_9) then
					arg_336_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_10 + var_339_11 and arg_336_1.time_ < var_339_10 + var_339_11 + arg_339_0 and not isNil(var_339_9) and arg_336_1.var_.characterEffect1085ui_story then
				arg_336_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_339_13 = arg_336_1.actors_["10066ui_story"]
			local var_339_14 = 0

			if var_339_14 < arg_336_1.time_ and arg_336_1.time_ <= var_339_14 + arg_339_0 and not isNil(var_339_13) and arg_336_1.var_.characterEffect10066ui_story == nil then
				arg_336_1.var_.characterEffect10066ui_story = var_339_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_15 = 0.200000002980232

			if var_339_14 <= arg_336_1.time_ and arg_336_1.time_ < var_339_14 + var_339_15 and not isNil(var_339_13) then
				local var_339_16 = (arg_336_1.time_ - var_339_14) / var_339_15

				if arg_336_1.var_.characterEffect10066ui_story and not isNil(var_339_13) then
					local var_339_17 = Mathf.Lerp(0, 0.5, var_339_16)

					arg_336_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_336_1.var_.characterEffect10066ui_story.fillRatio = var_339_17
				end
			end

			if arg_336_1.time_ >= var_339_14 + var_339_15 and arg_336_1.time_ < var_339_14 + var_339_15 + arg_339_0 and not isNil(var_339_13) and arg_336_1.var_.characterEffect10066ui_story then
				local var_339_18 = 0.5

				arg_336_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_336_1.var_.characterEffect10066ui_story.fillRatio = var_339_18
			end

			local var_339_19 = 0

			if var_339_19 < arg_336_1.time_ and arg_336_1.time_ <= var_339_19 + arg_339_0 then
				arg_336_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_339_20 = 0

			if var_339_20 < arg_336_1.time_ and arg_336_1.time_ <= var_339_20 + arg_339_0 then
				arg_336_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_339_21 = 0
			local var_339_22 = 0.6

			if var_339_21 < arg_336_1.time_ and arg_336_1.time_ <= var_339_21 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_23 = arg_336_1:FormatText(StoryNameCfg[328].name)

				arg_336_1.leftNameTxt_.text = var_339_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_24 = arg_336_1:GetWordFromCfg(1108504082)
				local var_339_25 = arg_336_1:FormatText(var_339_24.content)

				arg_336_1.text_.text = var_339_25

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_26 = 24
				local var_339_27 = utf8.len(var_339_25)
				local var_339_28 = var_339_26 <= 0 and var_339_22 or var_339_22 * (var_339_27 / var_339_26)

				if var_339_28 > 0 and var_339_22 < var_339_28 then
					arg_336_1.talkMaxDuration = var_339_28

					if var_339_28 + var_339_21 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_28 + var_339_21
					end
				end

				arg_336_1.text_.text = var_339_25
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504082", "story_v_side_new_1108504.awb") ~= 0 then
					local var_339_29 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504082", "story_v_side_new_1108504.awb") / 1000

					if var_339_29 + var_339_21 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_29 + var_339_21
					end

					if var_339_24.prefab_name ~= "" and arg_336_1.actors_[var_339_24.prefab_name] ~= nil then
						local var_339_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_24.prefab_name].transform, "story_v_side_new_1108504", "1108504082", "story_v_side_new_1108504.awb")

						arg_336_1:RecordAudio("1108504082", var_339_30)
						arg_336_1:RecordAudio("1108504082", var_339_30)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504082", "story_v_side_new_1108504.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504082", "story_v_side_new_1108504.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_31 = math.max(var_339_22, arg_336_1.talkMaxDuration)

			if var_339_21 <= arg_336_1.time_ and arg_336_1.time_ < var_339_21 + var_339_31 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_21) / var_339_31

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_21 + var_339_31 and arg_336_1.time_ < var_339_21 + var_339_31 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play1108504083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1108504083
		arg_340_1.duration_ = 6

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1108504084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 0.525

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_2 = arg_340_1:FormatText(StoryNameCfg[328].name)

				arg_340_1.leftNameTxt_.text = var_343_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_3 = arg_340_1:GetWordFromCfg(1108504083)
				local var_343_4 = arg_340_1:FormatText(var_343_3.content)

				arg_340_1.text_.text = var_343_4

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_5 = 21
				local var_343_6 = utf8.len(var_343_4)
				local var_343_7 = var_343_5 <= 0 and var_343_1 or var_343_1 * (var_343_6 / var_343_5)

				if var_343_7 > 0 and var_343_1 < var_343_7 then
					arg_340_1.talkMaxDuration = var_343_7

					if var_343_7 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_4
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504083", "story_v_side_new_1108504.awb") ~= 0 then
					local var_343_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504083", "story_v_side_new_1108504.awb") / 1000

					if var_343_8 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_8 + var_343_0
					end

					if var_343_3.prefab_name ~= "" and arg_340_1.actors_[var_343_3.prefab_name] ~= nil then
						local var_343_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_3.prefab_name].transform, "story_v_side_new_1108504", "1108504083", "story_v_side_new_1108504.awb")

						arg_340_1:RecordAudio("1108504083", var_343_9)
						arg_340_1:RecordAudio("1108504083", var_343_9)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504083", "story_v_side_new_1108504.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504083", "story_v_side_new_1108504.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_10 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_10 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_10

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_10 and arg_340_1.time_ < var_343_0 + var_343_10 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play1108504084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1108504084
		arg_344_1.duration_ = 6.83

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1108504085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["10066ui_story"].transform
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.var_.moveOldPos10066ui_story = var_347_0.localPosition
			end

			local var_347_2 = 0.001

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2
				local var_347_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_347_0.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10066ui_story, var_347_4, var_347_3)

				local var_347_5 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_5.x, var_347_5.y, var_347_5.z)

				local var_347_6 = var_347_0.localEulerAngles

				var_347_6.z = 0
				var_347_6.x = 0
				var_347_0.localEulerAngles = var_347_6
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 then
				var_347_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_347_7 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_7.x, var_347_7.y, var_347_7.z)

				local var_347_8 = var_347_0.localEulerAngles

				var_347_8.z = 0
				var_347_8.x = 0
				var_347_0.localEulerAngles = var_347_8
			end

			local var_347_9 = arg_344_1.actors_["10066ui_story"]
			local var_347_10 = 0

			if var_347_10 < arg_344_1.time_ and arg_344_1.time_ <= var_347_10 + arg_347_0 and not isNil(var_347_9) and arg_344_1.var_.characterEffect10066ui_story == nil then
				arg_344_1.var_.characterEffect10066ui_story = var_347_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_11 = 0.200000002980232

			if var_347_10 <= arg_344_1.time_ and arg_344_1.time_ < var_347_10 + var_347_11 and not isNil(var_347_9) then
				local var_347_12 = (arg_344_1.time_ - var_347_10) / var_347_11

				if arg_344_1.var_.characterEffect10066ui_story and not isNil(var_347_9) then
					arg_344_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= var_347_10 + var_347_11 and arg_344_1.time_ < var_347_10 + var_347_11 + arg_347_0 and not isNil(var_347_9) and arg_344_1.var_.characterEffect10066ui_story then
				arg_344_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_347_13 = arg_344_1.actors_["1085ui_story"]
			local var_347_14 = 0

			if var_347_14 < arg_344_1.time_ and arg_344_1.time_ <= var_347_14 + arg_347_0 and not isNil(var_347_13) and arg_344_1.var_.characterEffect1085ui_story == nil then
				arg_344_1.var_.characterEffect1085ui_story = var_347_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_15 = 0.200000002980232

			if var_347_14 <= arg_344_1.time_ and arg_344_1.time_ < var_347_14 + var_347_15 and not isNil(var_347_13) then
				local var_347_16 = (arg_344_1.time_ - var_347_14) / var_347_15

				if arg_344_1.var_.characterEffect1085ui_story and not isNil(var_347_13) then
					local var_347_17 = Mathf.Lerp(0, 0.5, var_347_16)

					arg_344_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_344_1.var_.characterEffect1085ui_story.fillRatio = var_347_17
				end
			end

			if arg_344_1.time_ >= var_347_14 + var_347_15 and arg_344_1.time_ < var_347_14 + var_347_15 + arg_347_0 and not isNil(var_347_13) and arg_344_1.var_.characterEffect1085ui_story then
				local var_347_18 = 0.5

				arg_344_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_344_1.var_.characterEffect1085ui_story.fillRatio = var_347_18
			end

			local var_347_19 = 0

			if var_347_19 < arg_344_1.time_ and arg_344_1.time_ <= var_347_19 + arg_347_0 then
				arg_344_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_347_20 = 0

			if var_347_20 < arg_344_1.time_ and arg_344_1.time_ <= var_347_20 + arg_347_0 then
				arg_344_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_347_21 = 0
			local var_347_22 = 0.825

			if var_347_21 < arg_344_1.time_ and arg_344_1.time_ <= var_347_21 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_23 = arg_344_1:FormatText(StoryNameCfg[640].name)

				arg_344_1.leftNameTxt_.text = var_347_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_24 = arg_344_1:GetWordFromCfg(1108504084)
				local var_347_25 = arg_344_1:FormatText(var_347_24.content)

				arg_344_1.text_.text = var_347_25

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_26 = 33
				local var_347_27 = utf8.len(var_347_25)
				local var_347_28 = var_347_26 <= 0 and var_347_22 or var_347_22 * (var_347_27 / var_347_26)

				if var_347_28 > 0 and var_347_22 < var_347_28 then
					arg_344_1.talkMaxDuration = var_347_28

					if var_347_28 + var_347_21 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_28 + var_347_21
					end
				end

				arg_344_1.text_.text = var_347_25
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504084", "story_v_side_new_1108504.awb") ~= 0 then
					local var_347_29 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504084", "story_v_side_new_1108504.awb") / 1000

					if var_347_29 + var_347_21 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_29 + var_347_21
					end

					if var_347_24.prefab_name ~= "" and arg_344_1.actors_[var_347_24.prefab_name] ~= nil then
						local var_347_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_24.prefab_name].transform, "story_v_side_new_1108504", "1108504084", "story_v_side_new_1108504.awb")

						arg_344_1:RecordAudio("1108504084", var_347_30)
						arg_344_1:RecordAudio("1108504084", var_347_30)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504084", "story_v_side_new_1108504.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504084", "story_v_side_new_1108504.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_31 = math.max(var_347_22, arg_344_1.talkMaxDuration)

			if var_347_21 <= arg_344_1.time_ and arg_344_1.time_ < var_347_21 + var_347_31 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_21) / var_347_31

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_21 + var_347_31 and arg_344_1.time_ < var_347_21 + var_347_31 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play1108504085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1108504085
		arg_348_1.duration_ = 7.27

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1108504086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_2")
			end

			local var_351_1 = 0
			local var_351_2 = 0.825

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_3 = arg_348_1:FormatText(StoryNameCfg[640].name)

				arg_348_1.leftNameTxt_.text = var_351_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_4 = arg_348_1:GetWordFromCfg(1108504085)
				local var_351_5 = arg_348_1:FormatText(var_351_4.content)

				arg_348_1.text_.text = var_351_5

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_6 = 33
				local var_351_7 = utf8.len(var_351_5)
				local var_351_8 = var_351_6 <= 0 and var_351_2 or var_351_2 * (var_351_7 / var_351_6)

				if var_351_8 > 0 and var_351_2 < var_351_8 then
					arg_348_1.talkMaxDuration = var_351_8

					if var_351_8 + var_351_1 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_1
					end
				end

				arg_348_1.text_.text = var_351_5
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504085", "story_v_side_new_1108504.awb") ~= 0 then
					local var_351_9 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504085", "story_v_side_new_1108504.awb") / 1000

					if var_351_9 + var_351_1 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_9 + var_351_1
					end

					if var_351_4.prefab_name ~= "" and arg_348_1.actors_[var_351_4.prefab_name] ~= nil then
						local var_351_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_4.prefab_name].transform, "story_v_side_new_1108504", "1108504085", "story_v_side_new_1108504.awb")

						arg_348_1:RecordAudio("1108504085", var_351_10)
						arg_348_1:RecordAudio("1108504085", var_351_10)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504085", "story_v_side_new_1108504.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504085", "story_v_side_new_1108504.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_11 = math.max(var_351_2, arg_348_1.talkMaxDuration)

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_11 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_1) / var_351_11

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_1 + var_351_11 and arg_348_1.time_ < var_351_1 + var_351_11 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1108504086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1108504086
		arg_352_1.duration_ = 2

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1108504087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1085ui_story"].transform
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.var_.moveOldPos1085ui_story = var_355_0.localPosition
			end

			local var_355_2 = 0.001

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2
				local var_355_4 = Vector3.New(0.75, -1.01, -5.83)

				var_355_0.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1085ui_story, var_355_4, var_355_3)

				local var_355_5 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_5.x, var_355_5.y, var_355_5.z)

				local var_355_6 = var_355_0.localEulerAngles

				var_355_6.z = 0
				var_355_6.x = 0
				var_355_0.localEulerAngles = var_355_6
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 then
				var_355_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_355_7 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_7.x, var_355_7.y, var_355_7.z)

				local var_355_8 = var_355_0.localEulerAngles

				var_355_8.z = 0
				var_355_8.x = 0
				var_355_0.localEulerAngles = var_355_8
			end

			local var_355_9 = arg_352_1.actors_["1085ui_story"]
			local var_355_10 = 0

			if var_355_10 < arg_352_1.time_ and arg_352_1.time_ <= var_355_10 + arg_355_0 and not isNil(var_355_9) and arg_352_1.var_.characterEffect1085ui_story == nil then
				arg_352_1.var_.characterEffect1085ui_story = var_355_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_11 = 0.200000002980232

			if var_355_10 <= arg_352_1.time_ and arg_352_1.time_ < var_355_10 + var_355_11 and not isNil(var_355_9) then
				local var_355_12 = (arg_352_1.time_ - var_355_10) / var_355_11

				if arg_352_1.var_.characterEffect1085ui_story and not isNil(var_355_9) then
					arg_352_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_10 + var_355_11 and arg_352_1.time_ < var_355_10 + var_355_11 + arg_355_0 and not isNil(var_355_9) and arg_352_1.var_.characterEffect1085ui_story then
				arg_352_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_355_13 = arg_352_1.actors_["10066ui_story"]
			local var_355_14 = 0

			if var_355_14 < arg_352_1.time_ and arg_352_1.time_ <= var_355_14 + arg_355_0 and not isNil(var_355_13) and arg_352_1.var_.characterEffect10066ui_story == nil then
				arg_352_1.var_.characterEffect10066ui_story = var_355_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_15 = 0.200000002980232

			if var_355_14 <= arg_352_1.time_ and arg_352_1.time_ < var_355_14 + var_355_15 and not isNil(var_355_13) then
				local var_355_16 = (arg_352_1.time_ - var_355_14) / var_355_15

				if arg_352_1.var_.characterEffect10066ui_story and not isNil(var_355_13) then
					local var_355_17 = Mathf.Lerp(0, 0.5, var_355_16)

					arg_352_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_352_1.var_.characterEffect10066ui_story.fillRatio = var_355_17
				end
			end

			if arg_352_1.time_ >= var_355_14 + var_355_15 and arg_352_1.time_ < var_355_14 + var_355_15 + arg_355_0 and not isNil(var_355_13) and arg_352_1.var_.characterEffect10066ui_story then
				local var_355_18 = 0.5

				arg_352_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_352_1.var_.characterEffect10066ui_story.fillRatio = var_355_18
			end

			local var_355_19 = 0

			if var_355_19 < arg_352_1.time_ and arg_352_1.time_ <= var_355_19 + arg_355_0 then
				arg_352_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_355_20 = 0

			if var_355_20 < arg_352_1.time_ and arg_352_1.time_ <= var_355_20 + arg_355_0 then
				arg_352_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_355_21 = 0
			local var_355_22 = 0.075

			if var_355_21 < arg_352_1.time_ and arg_352_1.time_ <= var_355_21 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_23 = arg_352_1:FormatText(StoryNameCfg[328].name)

				arg_352_1.leftNameTxt_.text = var_355_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_24 = arg_352_1:GetWordFromCfg(1108504086)
				local var_355_25 = arg_352_1:FormatText(var_355_24.content)

				arg_352_1.text_.text = var_355_25

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_26 = 3
				local var_355_27 = utf8.len(var_355_25)
				local var_355_28 = var_355_26 <= 0 and var_355_22 or var_355_22 * (var_355_27 / var_355_26)

				if var_355_28 > 0 and var_355_22 < var_355_28 then
					arg_352_1.talkMaxDuration = var_355_28

					if var_355_28 + var_355_21 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_28 + var_355_21
					end
				end

				arg_352_1.text_.text = var_355_25
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504086", "story_v_side_new_1108504.awb") ~= 0 then
					local var_355_29 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504086", "story_v_side_new_1108504.awb") / 1000

					if var_355_29 + var_355_21 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_29 + var_355_21
					end

					if var_355_24.prefab_name ~= "" and arg_352_1.actors_[var_355_24.prefab_name] ~= nil then
						local var_355_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_24.prefab_name].transform, "story_v_side_new_1108504", "1108504086", "story_v_side_new_1108504.awb")

						arg_352_1:RecordAudio("1108504086", var_355_30)
						arg_352_1:RecordAudio("1108504086", var_355_30)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504086", "story_v_side_new_1108504.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504086", "story_v_side_new_1108504.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_31 = math.max(var_355_22, arg_352_1.talkMaxDuration)

			if var_355_21 <= arg_352_1.time_ and arg_352_1.time_ < var_355_21 + var_355_31 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_21) / var_355_31

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_21 + var_355_31 and arg_352_1.time_ < var_355_21 + var_355_31 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1108504087
		arg_356_1.duration_ = 8.83

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1108504088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = "ST07b"

			if arg_356_1.bgs_[var_359_0] == nil then
				local var_359_1 = Object.Instantiate(arg_356_1.paintGo_)

				var_359_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_359_0)
				var_359_1.name = var_359_0
				var_359_1.transform.parent = arg_356_1.stage_.transform
				var_359_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_356_1.bgs_[var_359_0] = var_359_1
			end

			local var_359_2 = 1.999999999999

			if var_359_2 < arg_356_1.time_ and arg_356_1.time_ <= var_359_2 + arg_359_0 then
				local var_359_3 = manager.ui.mainCamera.transform.localPosition
				local var_359_4 = Vector3.New(0, 0, 10) + Vector3.New(var_359_3.x, var_359_3.y, 0)
				local var_359_5 = arg_356_1.bgs_.ST07b

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
					if iter_359_0 ~= "ST07b" then
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

			local var_359_29 = arg_356_1.actors_["10066ui_story"].transform
			local var_359_30 = 3.8

			if var_359_30 < arg_356_1.time_ and arg_356_1.time_ <= var_359_30 + arg_359_0 then
				arg_356_1.var_.moveOldPos10066ui_story = var_359_29.localPosition
			end

			local var_359_31 = 0.001

			if var_359_30 <= arg_356_1.time_ and arg_356_1.time_ < var_359_30 + var_359_31 then
				local var_359_32 = (arg_356_1.time_ - var_359_30) / var_359_31
				local var_359_33 = Vector3.New(-0.7, -0.99, -5.83)

				var_359_29.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos10066ui_story, var_359_33, var_359_32)

				local var_359_34 = manager.ui.mainCamera.transform.position - var_359_29.position

				var_359_29.forward = Vector3.New(var_359_34.x, var_359_34.y, var_359_34.z)

				local var_359_35 = var_359_29.localEulerAngles

				var_359_35.z = 0
				var_359_35.x = 0
				var_359_29.localEulerAngles = var_359_35
			end

			if arg_356_1.time_ >= var_359_30 + var_359_31 and arg_356_1.time_ < var_359_30 + var_359_31 + arg_359_0 then
				var_359_29.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_359_36 = manager.ui.mainCamera.transform.position - var_359_29.position

				var_359_29.forward = Vector3.New(var_359_36.x, var_359_36.y, var_359_36.z)

				local var_359_37 = var_359_29.localEulerAngles

				var_359_37.z = 0
				var_359_37.x = 0
				var_359_29.localEulerAngles = var_359_37
			end

			local var_359_38 = arg_356_1.actors_["10066ui_story"]
			local var_359_39 = 3.8

			if var_359_39 < arg_356_1.time_ and arg_356_1.time_ <= var_359_39 + arg_359_0 and not isNil(var_359_38) and arg_356_1.var_.characterEffect10066ui_story == nil then
				arg_356_1.var_.characterEffect10066ui_story = var_359_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_40 = 0.200000002980232

			if var_359_39 <= arg_356_1.time_ and arg_356_1.time_ < var_359_39 + var_359_40 and not isNil(var_359_38) then
				local var_359_41 = (arg_356_1.time_ - var_359_39) / var_359_40

				if arg_356_1.var_.characterEffect10066ui_story and not isNil(var_359_38) then
					arg_356_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_356_1.time_ >= var_359_39 + var_359_40 and arg_356_1.time_ < var_359_39 + var_359_40 + arg_359_0 and not isNil(var_359_38) and arg_356_1.var_.characterEffect10066ui_story then
				arg_356_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_359_42 = arg_356_1.actors_["1085ui_story"]
			local var_359_43 = 1.79999999701977

			if var_359_43 < arg_356_1.time_ and arg_356_1.time_ <= var_359_43 + arg_359_0 and not isNil(var_359_42) and arg_356_1.var_.characterEffect1085ui_story == nil then
				arg_356_1.var_.characterEffect1085ui_story = var_359_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_359_44 = 0.200000002980232

			if var_359_43 <= arg_356_1.time_ and arg_356_1.time_ < var_359_43 + var_359_44 and not isNil(var_359_42) then
				local var_359_45 = (arg_356_1.time_ - var_359_43) / var_359_44

				if arg_356_1.var_.characterEffect1085ui_story and not isNil(var_359_42) then
					local var_359_46 = Mathf.Lerp(0, 0.5, var_359_45)

					arg_356_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_356_1.var_.characterEffect1085ui_story.fillRatio = var_359_46
				end
			end

			if arg_356_1.time_ >= var_359_43 + var_359_44 and arg_356_1.time_ < var_359_43 + var_359_44 + arg_359_0 and not isNil(var_359_42) and arg_356_1.var_.characterEffect1085ui_story then
				local var_359_47 = 0.5

				arg_356_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_356_1.var_.characterEffect1085ui_story.fillRatio = var_359_47
			end

			local var_359_48 = 3.8

			if var_359_48 < arg_356_1.time_ and arg_356_1.time_ <= var_359_48 + arg_359_0 then
				arg_356_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_359_49 = 3.8

			if var_359_49 < arg_356_1.time_ and arg_356_1.time_ <= var_359_49 + arg_359_0 then
				arg_356_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_359_50 = arg_356_1.actors_["1085ui_story"].transform
			local var_359_51 = 1.96599999815226

			if var_359_51 < arg_356_1.time_ and arg_356_1.time_ <= var_359_51 + arg_359_0 then
				arg_356_1.var_.moveOldPos1085ui_story = var_359_50.localPosition
			end

			local var_359_52 = 0.001

			if var_359_51 <= arg_356_1.time_ and arg_356_1.time_ < var_359_51 + var_359_52 then
				local var_359_53 = (arg_356_1.time_ - var_359_51) / var_359_52
				local var_359_54 = Vector3.New(0, 100, 0)

				var_359_50.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1085ui_story, var_359_54, var_359_53)

				local var_359_55 = manager.ui.mainCamera.transform.position - var_359_50.position

				var_359_50.forward = Vector3.New(var_359_55.x, var_359_55.y, var_359_55.z)

				local var_359_56 = var_359_50.localEulerAngles

				var_359_56.z = 0
				var_359_56.x = 0
				var_359_50.localEulerAngles = var_359_56
			end

			if arg_356_1.time_ >= var_359_51 + var_359_52 and arg_356_1.time_ < var_359_51 + var_359_52 + arg_359_0 then
				var_359_50.localPosition = Vector3.New(0, 100, 0)

				local var_359_57 = manager.ui.mainCamera.transform.position - var_359_50.position

				var_359_50.forward = Vector3.New(var_359_57.x, var_359_57.y, var_359_57.z)

				local var_359_58 = var_359_50.localEulerAngles

				var_359_58.z = 0
				var_359_58.x = 0
				var_359_50.localEulerAngles = var_359_58
			end

			if arg_356_1.frameCnt_ <= 1 then
				arg_356_1.dialog_:SetActive(false)
			end

			local var_359_59 = 3.999999999999
			local var_359_60 = 0.525

			if var_359_59 < arg_356_1.time_ and arg_356_1.time_ <= var_359_59 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0

				arg_356_1.dialog_:SetActive(true)

				arg_356_1.dialogCg_.alpha = 0

				local var_359_61 = LeanTween.value(arg_356_1.dialog_, 0, 1, 0.3)

				var_359_61:setOnUpdate(LuaHelper.FloatAction(function(arg_360_0)
					arg_356_1.dialogCg_.alpha = arg_360_0
				end))
				var_359_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_356_1.dialog_)
					var_359_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_356_1.duration_ = arg_356_1.duration_ + 0.3

				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_62 = arg_356_1:FormatText(StoryNameCfg[640].name)

				arg_356_1.leftNameTxt_.text = var_359_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_63 = arg_356_1:GetWordFromCfg(1108504087)
				local var_359_64 = arg_356_1:FormatText(var_359_63.content)

				arg_356_1.text_.text = var_359_64

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_65 = 21
				local var_359_66 = utf8.len(var_359_64)
				local var_359_67 = var_359_65 <= 0 and var_359_60 or var_359_60 * (var_359_66 / var_359_65)

				if var_359_67 > 0 and var_359_60 < var_359_67 then
					arg_356_1.talkMaxDuration = var_359_67
					var_359_59 = var_359_59 + 0.3

					if var_359_67 + var_359_59 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_67 + var_359_59
					end
				end

				arg_356_1.text_.text = var_359_64
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504087", "story_v_side_new_1108504.awb") ~= 0 then
					local var_359_68 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504087", "story_v_side_new_1108504.awb") / 1000

					if var_359_68 + var_359_59 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_68 + var_359_59
					end

					if var_359_63.prefab_name ~= "" and arg_356_1.actors_[var_359_63.prefab_name] ~= nil then
						local var_359_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_63.prefab_name].transform, "story_v_side_new_1108504", "1108504087", "story_v_side_new_1108504.awb")

						arg_356_1:RecordAudio("1108504087", var_359_69)
						arg_356_1:RecordAudio("1108504087", var_359_69)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504087", "story_v_side_new_1108504.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504087", "story_v_side_new_1108504.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_70 = var_359_59 + 0.3
			local var_359_71 = math.max(var_359_60, arg_356_1.talkMaxDuration)

			if var_359_70 <= arg_356_1.time_ and arg_356_1.time_ < var_359_70 + var_359_71 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_70) / var_359_71

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_70 + var_359_71 and arg_356_1.time_ < var_359_70 + var_359_71 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play1108504088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 1108504088
		arg_362_1.duration_ = 2.63

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play1108504089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = arg_362_1.actors_["1085ui_story"].transform
			local var_365_1 = 0

			if var_365_1 < arg_362_1.time_ and arg_362_1.time_ <= var_365_1 + arg_365_0 then
				arg_362_1.var_.moveOldPos1085ui_story = var_365_0.localPosition
			end

			local var_365_2 = 0.001

			if var_365_1 <= arg_362_1.time_ and arg_362_1.time_ < var_365_1 + var_365_2 then
				local var_365_3 = (arg_362_1.time_ - var_365_1) / var_365_2
				local var_365_4 = Vector3.New(0.75, -1.01, -5.83)

				var_365_0.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1085ui_story, var_365_4, var_365_3)

				local var_365_5 = manager.ui.mainCamera.transform.position - var_365_0.position

				var_365_0.forward = Vector3.New(var_365_5.x, var_365_5.y, var_365_5.z)

				local var_365_6 = var_365_0.localEulerAngles

				var_365_6.z = 0
				var_365_6.x = 0
				var_365_0.localEulerAngles = var_365_6
			end

			if arg_362_1.time_ >= var_365_1 + var_365_2 and arg_362_1.time_ < var_365_1 + var_365_2 + arg_365_0 then
				var_365_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_365_7 = manager.ui.mainCamera.transform.position - var_365_0.position

				var_365_0.forward = Vector3.New(var_365_7.x, var_365_7.y, var_365_7.z)

				local var_365_8 = var_365_0.localEulerAngles

				var_365_8.z = 0
				var_365_8.x = 0
				var_365_0.localEulerAngles = var_365_8
			end

			local var_365_9 = arg_362_1.actors_["1085ui_story"]
			local var_365_10 = 0

			if var_365_10 < arg_362_1.time_ and arg_362_1.time_ <= var_365_10 + arg_365_0 and not isNil(var_365_9) and arg_362_1.var_.characterEffect1085ui_story == nil then
				arg_362_1.var_.characterEffect1085ui_story = var_365_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_11 = 0.200000002980232

			if var_365_10 <= arg_362_1.time_ and arg_362_1.time_ < var_365_10 + var_365_11 and not isNil(var_365_9) then
				local var_365_12 = (arg_362_1.time_ - var_365_10) / var_365_11

				if arg_362_1.var_.characterEffect1085ui_story and not isNil(var_365_9) then
					arg_362_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= var_365_10 + var_365_11 and arg_362_1.time_ < var_365_10 + var_365_11 + arg_365_0 and not isNil(var_365_9) and arg_362_1.var_.characterEffect1085ui_story then
				arg_362_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_365_13 = arg_362_1.actors_["10066ui_story"]
			local var_365_14 = 0

			if var_365_14 < arg_362_1.time_ and arg_362_1.time_ <= var_365_14 + arg_365_0 and not isNil(var_365_13) and arg_362_1.var_.characterEffect10066ui_story == nil then
				arg_362_1.var_.characterEffect10066ui_story = var_365_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_15 = 0.200000002980232

			if var_365_14 <= arg_362_1.time_ and arg_362_1.time_ < var_365_14 + var_365_15 and not isNil(var_365_13) then
				local var_365_16 = (arg_362_1.time_ - var_365_14) / var_365_15

				if arg_362_1.var_.characterEffect10066ui_story and not isNil(var_365_13) then
					local var_365_17 = Mathf.Lerp(0, 0.5, var_365_16)

					arg_362_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_362_1.var_.characterEffect10066ui_story.fillRatio = var_365_17
				end
			end

			if arg_362_1.time_ >= var_365_14 + var_365_15 and arg_362_1.time_ < var_365_14 + var_365_15 + arg_365_0 and not isNil(var_365_13) and arg_362_1.var_.characterEffect10066ui_story then
				local var_365_18 = 0.5

				arg_362_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_362_1.var_.characterEffect10066ui_story.fillRatio = var_365_18
			end

			local var_365_19 = 0

			if var_365_19 < arg_362_1.time_ and arg_362_1.time_ <= var_365_19 + arg_365_0 then
				arg_362_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_365_20 = 0

			if var_365_20 < arg_362_1.time_ and arg_362_1.time_ <= var_365_20 + arg_365_0 then
				arg_362_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_365_21 = 0
			local var_365_22 = 0.225

			if var_365_21 < arg_362_1.time_ and arg_362_1.time_ <= var_365_21 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				local var_365_23 = arg_362_1:FormatText(StoryNameCfg[328].name)

				arg_362_1.leftNameTxt_.text = var_365_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_24 = arg_362_1:GetWordFromCfg(1108504088)
				local var_365_25 = arg_362_1:FormatText(var_365_24.content)

				arg_362_1.text_.text = var_365_25

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_26 = 9
				local var_365_27 = utf8.len(var_365_25)
				local var_365_28 = var_365_26 <= 0 and var_365_22 or var_365_22 * (var_365_27 / var_365_26)

				if var_365_28 > 0 and var_365_22 < var_365_28 then
					arg_362_1.talkMaxDuration = var_365_28

					if var_365_28 + var_365_21 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_28 + var_365_21
					end
				end

				arg_362_1.text_.text = var_365_25
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504088", "story_v_side_new_1108504.awb") ~= 0 then
					local var_365_29 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504088", "story_v_side_new_1108504.awb") / 1000

					if var_365_29 + var_365_21 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_29 + var_365_21
					end

					if var_365_24.prefab_name ~= "" and arg_362_1.actors_[var_365_24.prefab_name] ~= nil then
						local var_365_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_24.prefab_name].transform, "story_v_side_new_1108504", "1108504088", "story_v_side_new_1108504.awb")

						arg_362_1:RecordAudio("1108504088", var_365_30)
						arg_362_1:RecordAudio("1108504088", var_365_30)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504088", "story_v_side_new_1108504.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504088", "story_v_side_new_1108504.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_31 = math.max(var_365_22, arg_362_1.talkMaxDuration)

			if var_365_21 <= arg_362_1.time_ and arg_362_1.time_ < var_365_21 + var_365_31 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_21) / var_365_31

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_21 + var_365_31 and arg_362_1.time_ < var_365_21 + var_365_31 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 1108504089
		arg_366_1.duration_ = 9.6

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play1108504090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = arg_366_1.actors_["10066ui_story"].transform
			local var_369_1 = 0

			if var_369_1 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.var_.moveOldPos10066ui_story = var_369_0.localPosition
			end

			local var_369_2 = 0.001

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_2 then
				local var_369_3 = (arg_366_1.time_ - var_369_1) / var_369_2
				local var_369_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_369_0.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos10066ui_story, var_369_4, var_369_3)

				local var_369_5 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_5.x, var_369_5.y, var_369_5.z)

				local var_369_6 = var_369_0.localEulerAngles

				var_369_6.z = 0
				var_369_6.x = 0
				var_369_0.localEulerAngles = var_369_6
			end

			if arg_366_1.time_ >= var_369_1 + var_369_2 and arg_366_1.time_ < var_369_1 + var_369_2 + arg_369_0 then
				var_369_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_369_7 = manager.ui.mainCamera.transform.position - var_369_0.position

				var_369_0.forward = Vector3.New(var_369_7.x, var_369_7.y, var_369_7.z)

				local var_369_8 = var_369_0.localEulerAngles

				var_369_8.z = 0
				var_369_8.x = 0
				var_369_0.localEulerAngles = var_369_8
			end

			local var_369_9 = arg_366_1.actors_["10066ui_story"]
			local var_369_10 = 0

			if var_369_10 < arg_366_1.time_ and arg_366_1.time_ <= var_369_10 + arg_369_0 and not isNil(var_369_9) and arg_366_1.var_.characterEffect10066ui_story == nil then
				arg_366_1.var_.characterEffect10066ui_story = var_369_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_11 = 0.200000002980232

			if var_369_10 <= arg_366_1.time_ and arg_366_1.time_ < var_369_10 + var_369_11 and not isNil(var_369_9) then
				local var_369_12 = (arg_366_1.time_ - var_369_10) / var_369_11

				if arg_366_1.var_.characterEffect10066ui_story and not isNil(var_369_9) then
					arg_366_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= var_369_10 + var_369_11 and arg_366_1.time_ < var_369_10 + var_369_11 + arg_369_0 and not isNil(var_369_9) and arg_366_1.var_.characterEffect10066ui_story then
				arg_366_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_369_13 = arg_366_1.actors_["1085ui_story"]
			local var_369_14 = 0

			if var_369_14 < arg_366_1.time_ and arg_366_1.time_ <= var_369_14 + arg_369_0 and not isNil(var_369_13) and arg_366_1.var_.characterEffect1085ui_story == nil then
				arg_366_1.var_.characterEffect1085ui_story = var_369_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_15 = 0.200000002980232

			if var_369_14 <= arg_366_1.time_ and arg_366_1.time_ < var_369_14 + var_369_15 and not isNil(var_369_13) then
				local var_369_16 = (arg_366_1.time_ - var_369_14) / var_369_15

				if arg_366_1.var_.characterEffect1085ui_story and not isNil(var_369_13) then
					local var_369_17 = Mathf.Lerp(0, 0.5, var_369_16)

					arg_366_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_366_1.var_.characterEffect1085ui_story.fillRatio = var_369_17
				end
			end

			if arg_366_1.time_ >= var_369_14 + var_369_15 and arg_366_1.time_ < var_369_14 + var_369_15 + arg_369_0 and not isNil(var_369_13) and arg_366_1.var_.characterEffect1085ui_story then
				local var_369_18 = 0.5

				arg_366_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_366_1.var_.characterEffect1085ui_story.fillRatio = var_369_18
			end

			local var_369_19 = 0

			if var_369_19 < arg_366_1.time_ and arg_366_1.time_ <= var_369_19 + arg_369_0 then
				arg_366_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action437")
			end

			local var_369_20 = 0

			if var_369_20 < arg_366_1.time_ and arg_366_1.time_ <= var_369_20 + arg_369_0 then
				arg_366_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_369_21 = 0
			local var_369_22 = 0.825

			if var_369_21 < arg_366_1.time_ and arg_366_1.time_ <= var_369_21 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				local var_369_23 = arg_366_1:FormatText(StoryNameCfg[640].name)

				arg_366_1.leftNameTxt_.text = var_369_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_24 = arg_366_1:GetWordFromCfg(1108504089)
				local var_369_25 = arg_366_1:FormatText(var_369_24.content)

				arg_366_1.text_.text = var_369_25

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_26 = 33
				local var_369_27 = utf8.len(var_369_25)
				local var_369_28 = var_369_26 <= 0 and var_369_22 or var_369_22 * (var_369_27 / var_369_26)

				if var_369_28 > 0 and var_369_22 < var_369_28 then
					arg_366_1.talkMaxDuration = var_369_28

					if var_369_28 + var_369_21 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_28 + var_369_21
					end
				end

				arg_366_1.text_.text = var_369_25
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504089", "story_v_side_new_1108504.awb") ~= 0 then
					local var_369_29 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504089", "story_v_side_new_1108504.awb") / 1000

					if var_369_29 + var_369_21 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_29 + var_369_21
					end

					if var_369_24.prefab_name ~= "" and arg_366_1.actors_[var_369_24.prefab_name] ~= nil then
						local var_369_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_24.prefab_name].transform, "story_v_side_new_1108504", "1108504089", "story_v_side_new_1108504.awb")

						arg_366_1:RecordAudio("1108504089", var_369_30)
						arg_366_1:RecordAudio("1108504089", var_369_30)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504089", "story_v_side_new_1108504.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504089", "story_v_side_new_1108504.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_31 = math.max(var_369_22, arg_366_1.talkMaxDuration)

			if var_369_21 <= arg_366_1.time_ and arg_366_1.time_ < var_369_21 + var_369_31 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_21) / var_369_31

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_21 + var_369_31 and arg_366_1.time_ < var_369_21 + var_369_31 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play1108504090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 1108504090
		arg_370_1.duration_ = 4.17

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play1108504091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["1085ui_story"].transform
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 then
				arg_370_1.var_.moveOldPos1085ui_story = var_373_0.localPosition
			end

			local var_373_2 = 0.001

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2
				local var_373_4 = Vector3.New(0.75, -1.01, -5.83)

				var_373_0.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos1085ui_story, var_373_4, var_373_3)

				local var_373_5 = manager.ui.mainCamera.transform.position - var_373_0.position

				var_373_0.forward = Vector3.New(var_373_5.x, var_373_5.y, var_373_5.z)

				local var_373_6 = var_373_0.localEulerAngles

				var_373_6.z = 0
				var_373_6.x = 0
				var_373_0.localEulerAngles = var_373_6
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 then
				var_373_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_373_7 = manager.ui.mainCamera.transform.position - var_373_0.position

				var_373_0.forward = Vector3.New(var_373_7.x, var_373_7.y, var_373_7.z)

				local var_373_8 = var_373_0.localEulerAngles

				var_373_8.z = 0
				var_373_8.x = 0
				var_373_0.localEulerAngles = var_373_8
			end

			local var_373_9 = arg_370_1.actors_["1085ui_story"]
			local var_373_10 = 0

			if var_373_10 < arg_370_1.time_ and arg_370_1.time_ <= var_373_10 + arg_373_0 and not isNil(var_373_9) and arg_370_1.var_.characterEffect1085ui_story == nil then
				arg_370_1.var_.characterEffect1085ui_story = var_373_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_11 = 0.200000002980232

			if var_373_10 <= arg_370_1.time_ and arg_370_1.time_ < var_373_10 + var_373_11 and not isNil(var_373_9) then
				local var_373_12 = (arg_370_1.time_ - var_373_10) / var_373_11

				if arg_370_1.var_.characterEffect1085ui_story and not isNil(var_373_9) then
					arg_370_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= var_373_10 + var_373_11 and arg_370_1.time_ < var_373_10 + var_373_11 + arg_373_0 and not isNil(var_373_9) and arg_370_1.var_.characterEffect1085ui_story then
				arg_370_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_373_13 = arg_370_1.actors_["10066ui_story"]
			local var_373_14 = 0

			if var_373_14 < arg_370_1.time_ and arg_370_1.time_ <= var_373_14 + arg_373_0 and not isNil(var_373_13) and arg_370_1.var_.characterEffect10066ui_story == nil then
				arg_370_1.var_.characterEffect10066ui_story = var_373_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_15 = 0.200000002980232

			if var_373_14 <= arg_370_1.time_ and arg_370_1.time_ < var_373_14 + var_373_15 and not isNil(var_373_13) then
				local var_373_16 = (arg_370_1.time_ - var_373_14) / var_373_15

				if arg_370_1.var_.characterEffect10066ui_story and not isNil(var_373_13) then
					local var_373_17 = Mathf.Lerp(0, 0.5, var_373_16)

					arg_370_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_370_1.var_.characterEffect10066ui_story.fillRatio = var_373_17
				end
			end

			if arg_370_1.time_ >= var_373_14 + var_373_15 and arg_370_1.time_ < var_373_14 + var_373_15 + arg_373_0 and not isNil(var_373_13) and arg_370_1.var_.characterEffect10066ui_story then
				local var_373_18 = 0.5

				arg_370_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_370_1.var_.characterEffect10066ui_story.fillRatio = var_373_18
			end

			local var_373_19 = 0

			if var_373_19 < arg_370_1.time_ and arg_370_1.time_ <= var_373_19 + arg_373_0 then
				arg_370_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_373_20 = 0

			if var_373_20 < arg_370_1.time_ and arg_370_1.time_ <= var_373_20 + arg_373_0 then
				arg_370_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_373_21 = 0
			local var_373_22 = 0.375

			if var_373_21 < arg_370_1.time_ and arg_370_1.time_ <= var_373_21 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				local var_373_23 = arg_370_1:FormatText(StoryNameCfg[328].name)

				arg_370_1.leftNameTxt_.text = var_373_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_24 = arg_370_1:GetWordFromCfg(1108504090)
				local var_373_25 = arg_370_1:FormatText(var_373_24.content)

				arg_370_1.text_.text = var_373_25

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_26 = 15
				local var_373_27 = utf8.len(var_373_25)
				local var_373_28 = var_373_26 <= 0 and var_373_22 or var_373_22 * (var_373_27 / var_373_26)

				if var_373_28 > 0 and var_373_22 < var_373_28 then
					arg_370_1.talkMaxDuration = var_373_28

					if var_373_28 + var_373_21 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_28 + var_373_21
					end
				end

				arg_370_1.text_.text = var_373_25
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504090", "story_v_side_new_1108504.awb") ~= 0 then
					local var_373_29 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504090", "story_v_side_new_1108504.awb") / 1000

					if var_373_29 + var_373_21 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_29 + var_373_21
					end

					if var_373_24.prefab_name ~= "" and arg_370_1.actors_[var_373_24.prefab_name] ~= nil then
						local var_373_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_24.prefab_name].transform, "story_v_side_new_1108504", "1108504090", "story_v_side_new_1108504.awb")

						arg_370_1:RecordAudio("1108504090", var_373_30)
						arg_370_1:RecordAudio("1108504090", var_373_30)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504090", "story_v_side_new_1108504.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504090", "story_v_side_new_1108504.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_31 = math.max(var_373_22, arg_370_1.talkMaxDuration)

			if var_373_21 <= arg_370_1.time_ and arg_370_1.time_ < var_373_21 + var_373_31 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_21) / var_373_31

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_21 + var_373_31 and arg_370_1.time_ < var_373_21 + var_373_31 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play1108504091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 1108504091
		arg_374_1.duration_ = 4.93

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play1108504092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0
			local var_377_1 = 0.45

			if var_377_0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				local var_377_2 = arg_374_1:FormatText(StoryNameCfg[328].name)

				arg_374_1.leftNameTxt_.text = var_377_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_3 = arg_374_1:GetWordFromCfg(1108504091)
				local var_377_4 = arg_374_1:FormatText(var_377_3.content)

				arg_374_1.text_.text = var_377_4

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_5 = 18
				local var_377_6 = utf8.len(var_377_4)
				local var_377_7 = var_377_5 <= 0 and var_377_1 or var_377_1 * (var_377_6 / var_377_5)

				if var_377_7 > 0 and var_377_1 < var_377_7 then
					arg_374_1.talkMaxDuration = var_377_7

					if var_377_7 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_7 + var_377_0
					end
				end

				arg_374_1.text_.text = var_377_4
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504091", "story_v_side_new_1108504.awb") ~= 0 then
					local var_377_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504091", "story_v_side_new_1108504.awb") / 1000

					if var_377_8 + var_377_0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_8 + var_377_0
					end

					if var_377_3.prefab_name ~= "" and arg_374_1.actors_[var_377_3.prefab_name] ~= nil then
						local var_377_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_3.prefab_name].transform, "story_v_side_new_1108504", "1108504091", "story_v_side_new_1108504.awb")

						arg_374_1:RecordAudio("1108504091", var_377_9)
						arg_374_1:RecordAudio("1108504091", var_377_9)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504091", "story_v_side_new_1108504.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504091", "story_v_side_new_1108504.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_10 = math.max(var_377_1, arg_374_1.talkMaxDuration)

			if var_377_0 <= arg_374_1.time_ and arg_374_1.time_ < var_377_0 + var_377_10 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_0) / var_377_10

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_0 + var_377_10 and arg_374_1.time_ < var_377_0 + var_377_10 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play1108504092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 1108504092
		arg_378_1.duration_ = 4.8

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play1108504093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = arg_378_1.actors_["1085ui_story"].transform
			local var_381_1 = 0

			if var_381_1 < arg_378_1.time_ and arg_378_1.time_ <= var_381_1 + arg_381_0 then
				arg_378_1.var_.moveOldPos1085ui_story = var_381_0.localPosition
			end

			local var_381_2 = 0.001

			if var_381_1 <= arg_378_1.time_ and arg_378_1.time_ < var_381_1 + var_381_2 then
				local var_381_3 = (arg_378_1.time_ - var_381_1) / var_381_2
				local var_381_4 = Vector3.New(0.75, -1.01, -5.83)

				var_381_0.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1085ui_story, var_381_4, var_381_3)

				local var_381_5 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_5.x, var_381_5.y, var_381_5.z)

				local var_381_6 = var_381_0.localEulerAngles

				var_381_6.z = 0
				var_381_6.x = 0
				var_381_0.localEulerAngles = var_381_6
			end

			if arg_378_1.time_ >= var_381_1 + var_381_2 and arg_378_1.time_ < var_381_1 + var_381_2 + arg_381_0 then
				var_381_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_381_7 = manager.ui.mainCamera.transform.position - var_381_0.position

				var_381_0.forward = Vector3.New(var_381_7.x, var_381_7.y, var_381_7.z)

				local var_381_8 = var_381_0.localEulerAngles

				var_381_8.z = 0
				var_381_8.x = 0
				var_381_0.localEulerAngles = var_381_8
			end

			local var_381_9 = 0

			if var_381_9 < arg_378_1.time_ and arg_378_1.time_ <= var_381_9 + arg_381_0 then
				arg_378_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_381_10 = 0

			if var_381_10 < arg_378_1.time_ and arg_378_1.time_ <= var_381_10 + arg_381_0 then
				arg_378_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_381_11 = 0
			local var_381_12 = 0.375

			if var_381_11 < arg_378_1.time_ and arg_378_1.time_ <= var_381_11 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				local var_381_13 = arg_378_1:FormatText(StoryNameCfg[328].name)

				arg_378_1.leftNameTxt_.text = var_381_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_14 = arg_378_1:GetWordFromCfg(1108504092)
				local var_381_15 = arg_378_1:FormatText(var_381_14.content)

				arg_378_1.text_.text = var_381_15

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_16 = 15
				local var_381_17 = utf8.len(var_381_15)
				local var_381_18 = var_381_16 <= 0 and var_381_12 or var_381_12 * (var_381_17 / var_381_16)

				if var_381_18 > 0 and var_381_12 < var_381_18 then
					arg_378_1.talkMaxDuration = var_381_18

					if var_381_18 + var_381_11 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_18 + var_381_11
					end
				end

				arg_378_1.text_.text = var_381_15
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504092", "story_v_side_new_1108504.awb") ~= 0 then
					local var_381_19 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504092", "story_v_side_new_1108504.awb") / 1000

					if var_381_19 + var_381_11 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_19 + var_381_11
					end

					if var_381_14.prefab_name ~= "" and arg_378_1.actors_[var_381_14.prefab_name] ~= nil then
						local var_381_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_14.prefab_name].transform, "story_v_side_new_1108504", "1108504092", "story_v_side_new_1108504.awb")

						arg_378_1:RecordAudio("1108504092", var_381_20)
						arg_378_1:RecordAudio("1108504092", var_381_20)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504092", "story_v_side_new_1108504.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504092", "story_v_side_new_1108504.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_21 = math.max(var_381_12, arg_378_1.talkMaxDuration)

			if var_381_11 <= arg_378_1.time_ and arg_378_1.time_ < var_381_11 + var_381_21 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_11) / var_381_21

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_11 + var_381_21 and arg_378_1.time_ < var_381_11 + var_381_21 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play1108504093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 1108504093
		arg_382_1.duration_ = 5.97

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play1108504094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = arg_382_1.actors_["10066ui_story"].transform
			local var_385_1 = 0

			if var_385_1 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.var_.moveOldPos10066ui_story = var_385_0.localPosition
			end

			local var_385_2 = 0.001

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_2 then
				local var_385_3 = (arg_382_1.time_ - var_385_1) / var_385_2
				local var_385_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_385_0.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos10066ui_story, var_385_4, var_385_3)

				local var_385_5 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_5.x, var_385_5.y, var_385_5.z)

				local var_385_6 = var_385_0.localEulerAngles

				var_385_6.z = 0
				var_385_6.x = 0
				var_385_0.localEulerAngles = var_385_6
			end

			if arg_382_1.time_ >= var_385_1 + var_385_2 and arg_382_1.time_ < var_385_1 + var_385_2 + arg_385_0 then
				var_385_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_385_7 = manager.ui.mainCamera.transform.position - var_385_0.position

				var_385_0.forward = Vector3.New(var_385_7.x, var_385_7.y, var_385_7.z)

				local var_385_8 = var_385_0.localEulerAngles

				var_385_8.z = 0
				var_385_8.x = 0
				var_385_0.localEulerAngles = var_385_8
			end

			local var_385_9 = arg_382_1.actors_["10066ui_story"]
			local var_385_10 = 0

			if var_385_10 < arg_382_1.time_ and arg_382_1.time_ <= var_385_10 + arg_385_0 and not isNil(var_385_9) and arg_382_1.var_.characterEffect10066ui_story == nil then
				arg_382_1.var_.characterEffect10066ui_story = var_385_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_11 = 0.200000002980232

			if var_385_10 <= arg_382_1.time_ and arg_382_1.time_ < var_385_10 + var_385_11 and not isNil(var_385_9) then
				local var_385_12 = (arg_382_1.time_ - var_385_10) / var_385_11

				if arg_382_1.var_.characterEffect10066ui_story and not isNil(var_385_9) then
					arg_382_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= var_385_10 + var_385_11 and arg_382_1.time_ < var_385_10 + var_385_11 + arg_385_0 and not isNil(var_385_9) and arg_382_1.var_.characterEffect10066ui_story then
				arg_382_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_385_13 = arg_382_1.actors_["1085ui_story"]
			local var_385_14 = 0

			if var_385_14 < arg_382_1.time_ and arg_382_1.time_ <= var_385_14 + arg_385_0 and not isNil(var_385_13) and arg_382_1.var_.characterEffect1085ui_story == nil then
				arg_382_1.var_.characterEffect1085ui_story = var_385_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_15 = 0.200000002980232

			if var_385_14 <= arg_382_1.time_ and arg_382_1.time_ < var_385_14 + var_385_15 and not isNil(var_385_13) then
				local var_385_16 = (arg_382_1.time_ - var_385_14) / var_385_15

				if arg_382_1.var_.characterEffect1085ui_story and not isNil(var_385_13) then
					local var_385_17 = Mathf.Lerp(0, 0.5, var_385_16)

					arg_382_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_382_1.var_.characterEffect1085ui_story.fillRatio = var_385_17
				end
			end

			if arg_382_1.time_ >= var_385_14 + var_385_15 and arg_382_1.time_ < var_385_14 + var_385_15 + arg_385_0 and not isNil(var_385_13) and arg_382_1.var_.characterEffect1085ui_story then
				local var_385_18 = 0.5

				arg_382_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_382_1.var_.characterEffect1085ui_story.fillRatio = var_385_18
			end

			local var_385_19 = 0

			if var_385_19 < arg_382_1.time_ and arg_382_1.time_ <= var_385_19 + arg_385_0 then
				arg_382_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action473")
			end

			local var_385_20 = 0

			if var_385_20 < arg_382_1.time_ and arg_382_1.time_ <= var_385_20 + arg_385_0 then
				arg_382_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_385_21 = 0
			local var_385_22 = 0.6

			if var_385_21 < arg_382_1.time_ and arg_382_1.time_ <= var_385_21 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_23 = arg_382_1:FormatText(StoryNameCfg[640].name)

				arg_382_1.leftNameTxt_.text = var_385_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_24 = arg_382_1:GetWordFromCfg(1108504093)
				local var_385_25 = arg_382_1:FormatText(var_385_24.content)

				arg_382_1.text_.text = var_385_25

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_26 = 24
				local var_385_27 = utf8.len(var_385_25)
				local var_385_28 = var_385_26 <= 0 and var_385_22 or var_385_22 * (var_385_27 / var_385_26)

				if var_385_28 > 0 and var_385_22 < var_385_28 then
					arg_382_1.talkMaxDuration = var_385_28

					if var_385_28 + var_385_21 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_28 + var_385_21
					end
				end

				arg_382_1.text_.text = var_385_25
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504093", "story_v_side_new_1108504.awb") ~= 0 then
					local var_385_29 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504093", "story_v_side_new_1108504.awb") / 1000

					if var_385_29 + var_385_21 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_29 + var_385_21
					end

					if var_385_24.prefab_name ~= "" and arg_382_1.actors_[var_385_24.prefab_name] ~= nil then
						local var_385_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_24.prefab_name].transform, "story_v_side_new_1108504", "1108504093", "story_v_side_new_1108504.awb")

						arg_382_1:RecordAudio("1108504093", var_385_30)
						arg_382_1:RecordAudio("1108504093", var_385_30)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504093", "story_v_side_new_1108504.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504093", "story_v_side_new_1108504.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_31 = math.max(var_385_22, arg_382_1.talkMaxDuration)

			if var_385_21 <= arg_382_1.time_ and arg_382_1.time_ < var_385_21 + var_385_31 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_21) / var_385_31

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_21 + var_385_31 and arg_382_1.time_ < var_385_21 + var_385_31 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play1108504094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 1108504094
		arg_386_1.duration_ = 4.3

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play1108504095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 2

			if var_389_0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_0 + arg_389_0 then
				local var_389_1 = manager.ui.mainCamera.transform.localPosition
				local var_389_2 = Vector3.New(0, 0, 10) + Vector3.New(var_389_1.x, var_389_1.y, 0)
				local var_389_3 = arg_386_1.bgs_.STblack

				var_389_3.transform.localPosition = var_389_2
				var_389_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_389_4 = var_389_3:GetComponent("SpriteRenderer")

				if var_389_4 and var_389_4.sprite then
					local var_389_5 = (var_389_3.transform.localPosition - var_389_1).z
					local var_389_6 = manager.ui.mainCameraCom_
					local var_389_7 = 2 * var_389_5 * Mathf.Tan(var_389_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_389_8 = var_389_7 * var_389_6.aspect
					local var_389_9 = var_389_4.sprite.bounds.size.x
					local var_389_10 = var_389_4.sprite.bounds.size.y
					local var_389_11 = var_389_8 / var_389_9
					local var_389_12 = var_389_7 / var_389_10
					local var_389_13 = var_389_12 < var_389_11 and var_389_11 or var_389_12

					var_389_3.transform.localScale = Vector3.New(var_389_13, var_389_13, 0)
				end

				for iter_389_0, iter_389_1 in pairs(arg_386_1.bgs_) do
					if iter_389_0 ~= "STblack" then
						iter_389_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_389_14 = 4

			if var_389_14 < arg_386_1.time_ and arg_386_1.time_ <= var_389_14 + arg_389_0 then
				arg_386_1.allBtn_.enabled = false
			end

			local var_389_15 = 0.3

			if arg_386_1.time_ >= var_389_14 + var_389_15 and arg_386_1.time_ < var_389_14 + var_389_15 + arg_389_0 then
				arg_386_1.allBtn_.enabled = true
			end

			local var_389_16 = 0

			if var_389_16 < arg_386_1.time_ and arg_386_1.time_ <= var_389_16 + arg_389_0 then
				arg_386_1.mask_.enabled = true
				arg_386_1.mask_.raycastTarget = true

				arg_386_1:SetGaussion(false)
			end

			local var_389_17 = 2

			if var_389_16 <= arg_386_1.time_ and arg_386_1.time_ < var_389_16 + var_389_17 then
				local var_389_18 = (arg_386_1.time_ - var_389_16) / var_389_17
				local var_389_19 = Color.New(0, 0, 0)

				var_389_19.a = Mathf.Lerp(0, 1, var_389_18)
				arg_386_1.mask_.color = var_389_19
			end

			if arg_386_1.time_ >= var_389_16 + var_389_17 and arg_386_1.time_ < var_389_16 + var_389_17 + arg_389_0 then
				local var_389_20 = Color.New(0, 0, 0)

				var_389_20.a = 1
				arg_386_1.mask_.color = var_389_20
			end

			local var_389_21 = 2

			if var_389_21 < arg_386_1.time_ and arg_386_1.time_ <= var_389_21 + arg_389_0 then
				arg_386_1.mask_.enabled = true
				arg_386_1.mask_.raycastTarget = true

				arg_386_1:SetGaussion(false)
			end

			local var_389_22 = 2

			if var_389_21 <= arg_386_1.time_ and arg_386_1.time_ < var_389_21 + var_389_22 then
				local var_389_23 = (arg_386_1.time_ - var_389_21) / var_389_22
				local var_389_24 = Color.New(0, 0, 0)

				var_389_24.a = Mathf.Lerp(1, 0, var_389_23)
				arg_386_1.mask_.color = var_389_24
			end

			if arg_386_1.time_ >= var_389_21 + var_389_22 and arg_386_1.time_ < var_389_21 + var_389_22 + arg_389_0 then
				local var_389_25 = Color.New(0, 0, 0)
				local var_389_26 = 0

				arg_386_1.mask_.enabled = false
				var_389_25.a = var_389_26
				arg_386_1.mask_.color = var_389_25
			end

			local var_389_27 = arg_386_1.actors_["10066ui_story"].transform
			local var_389_28 = 1.96599999815226

			if var_389_28 < arg_386_1.time_ and arg_386_1.time_ <= var_389_28 + arg_389_0 then
				arg_386_1.var_.moveOldPos10066ui_story = var_389_27.localPosition
			end

			local var_389_29 = 0.001

			if var_389_28 <= arg_386_1.time_ and arg_386_1.time_ < var_389_28 + var_389_29 then
				local var_389_30 = (arg_386_1.time_ - var_389_28) / var_389_29
				local var_389_31 = Vector3.New(0, 100, 0)

				var_389_27.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos10066ui_story, var_389_31, var_389_30)

				local var_389_32 = manager.ui.mainCamera.transform.position - var_389_27.position

				var_389_27.forward = Vector3.New(var_389_32.x, var_389_32.y, var_389_32.z)

				local var_389_33 = var_389_27.localEulerAngles

				var_389_33.z = 0
				var_389_33.x = 0
				var_389_27.localEulerAngles = var_389_33
			end

			if arg_386_1.time_ >= var_389_28 + var_389_29 and arg_386_1.time_ < var_389_28 + var_389_29 + arg_389_0 then
				var_389_27.localPosition = Vector3.New(0, 100, 0)

				local var_389_34 = manager.ui.mainCamera.transform.position - var_389_27.position

				var_389_27.forward = Vector3.New(var_389_34.x, var_389_34.y, var_389_34.z)

				local var_389_35 = var_389_27.localEulerAngles

				var_389_35.z = 0
				var_389_35.x = 0
				var_389_27.localEulerAngles = var_389_35
			end

			local var_389_36 = arg_386_1.actors_["1085ui_story"].transform
			local var_389_37 = 1.96599999815226

			if var_389_37 < arg_386_1.time_ and arg_386_1.time_ <= var_389_37 + arg_389_0 then
				arg_386_1.var_.moveOldPos1085ui_story = var_389_36.localPosition
			end

			local var_389_38 = 0.001

			if var_389_37 <= arg_386_1.time_ and arg_386_1.time_ < var_389_37 + var_389_38 then
				local var_389_39 = (arg_386_1.time_ - var_389_37) / var_389_38
				local var_389_40 = Vector3.New(0, 100, 0)

				var_389_36.localPosition = Vector3.Lerp(arg_386_1.var_.moveOldPos1085ui_story, var_389_40, var_389_39)

				local var_389_41 = manager.ui.mainCamera.transform.position - var_389_36.position

				var_389_36.forward = Vector3.New(var_389_41.x, var_389_41.y, var_389_41.z)

				local var_389_42 = var_389_36.localEulerAngles

				var_389_42.z = 0
				var_389_42.x = 0
				var_389_36.localEulerAngles = var_389_42
			end

			if arg_386_1.time_ >= var_389_37 + var_389_38 and arg_386_1.time_ < var_389_37 + var_389_38 + arg_389_0 then
				var_389_36.localPosition = Vector3.New(0, 100, 0)

				local var_389_43 = manager.ui.mainCamera.transform.position - var_389_36.position

				var_389_36.forward = Vector3.New(var_389_43.x, var_389_43.y, var_389_43.z)

				local var_389_44 = var_389_36.localEulerAngles

				var_389_44.z = 0
				var_389_44.x = 0
				var_389_36.localEulerAngles = var_389_44
			end

			local var_389_45 = arg_386_1.actors_["10066ui_story"]
			local var_389_46 = 1.96599999815226

			if var_389_46 < arg_386_1.time_ and arg_386_1.time_ <= var_389_46 + arg_389_0 and not isNil(var_389_45) and arg_386_1.var_.characterEffect10066ui_story == nil then
				arg_386_1.var_.characterEffect10066ui_story = var_389_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_47 = 0.034000001847744

			if var_389_46 <= arg_386_1.time_ and arg_386_1.time_ < var_389_46 + var_389_47 and not isNil(var_389_45) then
				local var_389_48 = (arg_386_1.time_ - var_389_46) / var_389_47

				if arg_386_1.var_.characterEffect10066ui_story and not isNil(var_389_45) then
					local var_389_49 = Mathf.Lerp(0, 0.5, var_389_48)

					arg_386_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_386_1.var_.characterEffect10066ui_story.fillRatio = var_389_49
				end
			end

			if arg_386_1.time_ >= var_389_46 + var_389_47 and arg_386_1.time_ < var_389_46 + var_389_47 + arg_389_0 and not isNil(var_389_45) and arg_386_1.var_.characterEffect10066ui_story then
				local var_389_50 = 0.5

				arg_386_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_386_1.var_.characterEffect10066ui_story.fillRatio = var_389_50
			end

			local var_389_51 = 0.133333333333333
			local var_389_52 = 1

			if var_389_51 < arg_386_1.time_ and arg_386_1.time_ <= var_389_51 + arg_389_0 then
				local var_389_53 = "stop"
				local var_389_54 = "effect"

				arg_386_1:AudioAction(var_389_53, var_389_54, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_389_55 = 1.96599999815226
			local var_389_56 = 1
			local var_389_57 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504094", "story_v_side_new_1108504.awb") / 1000

			if var_389_57 > 0 and var_389_56 < var_389_57 and var_389_57 + var_389_55 > arg_386_1.duration_ then
				local var_389_58 = var_389_57

				arg_386_1.duration_ = var_389_57 + var_389_55
			end

			if var_389_55 < arg_386_1.time_ and arg_386_1.time_ <= var_389_55 + arg_389_0 then
				local var_389_59 = "play"
				local var_389_60 = "voice"

				arg_386_1:AudioAction(var_389_59, var_389_60, "story_v_side_new_1108504", "1108504094", "story_v_side_new_1108504.awb")
			end

			local var_389_61 = 1.96599999815226

			arg_386_1.isInRecall_ = true

			if var_389_61 < arg_386_1.time_ and arg_386_1.time_ <= var_389_61 + arg_389_0 then
				arg_386_1.screenFilterGo_:SetActive(false)

				arg_386_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_386_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_389_2, iter_389_3 in pairs(arg_386_1.actors_) do
					local var_389_62 = iter_389_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_389_4, iter_389_5 in ipairs(var_389_62) do
						if iter_389_5.color.r > 0.51 then
							iter_389_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_389_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_389_63 = 0.034000001847744

			if var_389_61 <= arg_386_1.time_ and arg_386_1.time_ < var_389_61 + var_389_63 then
				local var_389_64 = (arg_386_1.time_ - var_389_61) / var_389_63

				arg_386_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_389_64)
			end

			if arg_386_1.time_ >= var_389_61 + var_389_63 and arg_386_1.time_ < var_389_61 + var_389_63 + arg_389_0 then
				arg_386_1.screenFilterEffect_.weight = 0
			end
		end

		arg_386_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1108504094,
				charCount = 19,
				enableLayoutChange = true,
				duration = 1.26666666666667,
				groupID = "ningxidawenben1",
				startTime = 2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_386_1:InitPlayNodeList()
	end,
	Play1108504095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 1108504095
		arg_390_1.duration_ = 5.57

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play1108504096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0
			local var_393_1 = 4.233
			local var_393_2 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb") / 1000

			if var_393_2 > 0 and var_393_1 < var_393_2 and var_393_2 + var_393_0 > arg_390_1.duration_ then
				local var_393_3 = var_393_2

				arg_390_1.duration_ = var_393_2 + var_393_0
			end

			if var_393_0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_0 + arg_393_0 then
				local var_393_4 = "play"
				local var_393_5 = "voice"

				arg_390_1:AudioAction(var_393_4, var_393_5, "story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb")
			end

			local var_393_6 = 0
			local var_393_7 = 0.675

			if var_393_6 < arg_390_1.time_ and arg_390_1.time_ <= var_393_6 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_8 = arg_390_1:GetWordFromCfg(1108504095)
				local var_393_9 = arg_390_1:FormatText(var_393_8.content)

				arg_390_1.text_.text = var_393_9

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_10 = 27
				local var_393_11 = utf8.len(var_393_9)
				local var_393_12 = var_393_10 <= 0 and var_393_7 or var_393_7 * (var_393_11 / var_393_10)

				if var_393_12 > 0 and var_393_7 < var_393_12 then
					arg_390_1.talkMaxDuration = var_393_12

					if var_393_12 + var_393_6 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_12 + var_393_6
					end
				end

				arg_390_1.text_.text = var_393_9
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb") ~= 0 then
					local var_393_13 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb") / 1000

					if var_393_13 + var_393_6 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_13 + var_393_6
					end

					if var_393_8.prefab_name ~= "" and arg_390_1.actors_[var_393_8.prefab_name] ~= nil then
						local var_393_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_8.prefab_name].transform, "story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb")

						arg_390_1:RecordAudio("1108504095", var_393_14)
						arg_390_1:RecordAudio("1108504095", var_393_14)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504095", "story_v_side_new_1108504.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_15 = math.max(var_393_7, arg_390_1.talkMaxDuration)

			if var_393_6 <= arg_390_1.time_ and arg_390_1.time_ < var_393_6 + var_393_15 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_6) / var_393_15

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_6 + var_393_15 and arg_390_1.time_ < var_393_6 + var_393_15 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1108504095,
				charCount = 27,
				enableLayoutChange = true,
				duration = 1.8,
				groupID = "ningxidawenben1",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	Play1108504096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 1108504096
		arg_394_1.duration_ = 4.23

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play1108504097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 4.233
			local var_397_2 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504096", "story_v_side_new_1108504.awb") / 1000

			if var_397_2 > 0 and var_397_1 < var_397_2 and var_397_2 + var_397_0 > arg_394_1.duration_ then
				local var_397_3 = var_397_2

				arg_394_1.duration_ = var_397_2 + var_397_0
			end

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				local var_397_4 = "play"
				local var_397_5 = "voice"

				arg_394_1:AudioAction(var_397_4, var_397_5, "story_v_side_new_1108504", "1108504096", "story_v_side_new_1108504.awb")
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1108504096,
				charCount = 31,
				enableLayoutChange = true,
				duration = 2.06666666666667,
				groupID = "ningxidawenben1",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play1108504097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 1108504097
		arg_398_1.duration_ = 5.33

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play1108504098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.3

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				local var_401_2 = "play"
				local var_401_3 = "music"

				arg_398_1:AudioAction(var_401_2, var_401_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_401_4 = ""
				local var_401_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_401_5 ~= "" then
					if arg_398_1.bgmTxt_.text ~= var_401_5 and arg_398_1.bgmTxt_.text ~= "" then
						if arg_398_1.bgmTxt2_.text ~= "" then
							arg_398_1.bgmTxt_.text = arg_398_1.bgmTxt2_.text
						end

						arg_398_1.bgmTxt2_.text = var_401_5

						arg_398_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_398_1.bgmTxt_.text = var_401_5
						arg_398_1.bgmTxt2_.text = var_401_5
					end

					if arg_398_1.bgmTimer then
						arg_398_1.bgmTimer:Stop()

						arg_398_1.bgmTimer = nil
					end

					if arg_398_1.settingData.show_music_name == 1 then
						arg_398_1.musicController:SetSelectedState("show")
						arg_398_1.musicAnimator_:Play("open", 0, 0)

						if arg_398_1.settingData.music_time ~= 0 then
							arg_398_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_398_1.settingData.music_time), function()
								if arg_398_1 == nil or isNil(arg_398_1.bgmTxt_) then
									return
								end

								arg_398_1.musicController:SetSelectedState("hide")
								arg_398_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_401_6 = 0
			local var_401_7 = 5.333
			local var_401_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504097", "story_v_side_new_1108504.awb") / 1000

			if var_401_8 > 0 and var_401_7 < var_401_8 and var_401_8 + var_401_6 > arg_398_1.duration_ then
				local var_401_9 = var_401_8

				arg_398_1.duration_ = var_401_8 + var_401_6
			end

			if var_401_6 < arg_398_1.time_ and arg_398_1.time_ <= var_401_6 + arg_401_0 then
				local var_401_10 = "play"
				local var_401_11 = "voice"

				arg_398_1:AudioAction(var_401_10, var_401_11, "story_v_side_new_1108504", "1108504097", "story_v_side_new_1108504.awb")
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 1108504097,
				charCount = 18,
				enableLayoutChange = true,
				duration = 1.2,
				groupID = "ningxidawenben1",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play1108504098 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1108504098
		arg_403_1.duration_ = 18

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1108504099(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 2

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				local var_406_1 = manager.ui.mainCamera.transform.localPosition
				local var_406_2 = Vector3.New(0, 0, 10) + Vector3.New(var_406_1.x, var_406_1.y, 0)
				local var_406_3 = arg_403_1.bgs_.ST12

				var_406_3.transform.localPosition = var_406_2
				var_406_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_406_4 = var_406_3:GetComponent("SpriteRenderer")

				if var_406_4 and var_406_4.sprite then
					local var_406_5 = (var_406_3.transform.localPosition - var_406_1).z
					local var_406_6 = manager.ui.mainCameraCom_
					local var_406_7 = 2 * var_406_5 * Mathf.Tan(var_406_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_406_8 = var_406_7 * var_406_6.aspect
					local var_406_9 = var_406_4.sprite.bounds.size.x
					local var_406_10 = var_406_4.sprite.bounds.size.y
					local var_406_11 = var_406_8 / var_406_9
					local var_406_12 = var_406_7 / var_406_10
					local var_406_13 = var_406_12 < var_406_11 and var_406_11 or var_406_12

					var_406_3.transform.localScale = Vector3.New(var_406_13, var_406_13, 0)
				end

				for iter_406_0, iter_406_1 in pairs(arg_403_1.bgs_) do
					if iter_406_0 ~= "ST12" then
						iter_406_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_406_14 = 4.00000000298023

			if var_406_14 < arg_403_1.time_ and arg_403_1.time_ <= var_406_14 + arg_406_0 then
				arg_403_1.allBtn_.enabled = false
			end

			local var_406_15 = 0.3

			if arg_403_1.time_ >= var_406_14 + var_406_15 and arg_403_1.time_ < var_406_14 + var_406_15 + arg_406_0 then
				arg_403_1.allBtn_.enabled = true
			end

			local var_406_16 = 0

			if var_406_16 < arg_403_1.time_ and arg_403_1.time_ <= var_406_16 + arg_406_0 then
				arg_403_1.mask_.enabled = true
				arg_403_1.mask_.raycastTarget = true

				arg_403_1:SetGaussion(false)
			end

			local var_406_17 = 2

			if var_406_16 <= arg_403_1.time_ and arg_403_1.time_ < var_406_16 + var_406_17 then
				local var_406_18 = (arg_403_1.time_ - var_406_16) / var_406_17
				local var_406_19 = Color.New(0, 0, 0)

				var_406_19.a = Mathf.Lerp(0, 1, var_406_18)
				arg_403_1.mask_.color = var_406_19
			end

			if arg_403_1.time_ >= var_406_16 + var_406_17 and arg_403_1.time_ < var_406_16 + var_406_17 + arg_406_0 then
				local var_406_20 = Color.New(0, 0, 0)

				var_406_20.a = 1
				arg_403_1.mask_.color = var_406_20
			end

			local var_406_21 = 2

			if var_406_21 < arg_403_1.time_ and arg_403_1.time_ <= var_406_21 + arg_406_0 then
				arg_403_1.mask_.enabled = true
				arg_403_1.mask_.raycastTarget = true

				arg_403_1:SetGaussion(false)
			end

			local var_406_22 = 2

			if var_406_21 <= arg_403_1.time_ and arg_403_1.time_ < var_406_21 + var_406_22 then
				local var_406_23 = (arg_403_1.time_ - var_406_21) / var_406_22
				local var_406_24 = Color.New(0, 0, 0)

				var_406_24.a = Mathf.Lerp(1, 0, var_406_23)
				arg_403_1.mask_.color = var_406_24
			end

			if arg_403_1.time_ >= var_406_21 + var_406_22 and arg_403_1.time_ < var_406_21 + var_406_22 + arg_406_0 then
				local var_406_25 = Color.New(0, 0, 0)
				local var_406_26 = 0

				arg_403_1.mask_.enabled = false
				var_406_25.a = var_406_26
				arg_403_1.mask_.color = var_406_25
			end

			local var_406_27 = arg_403_1.actors_["1085ui_story"].transform
			local var_406_28 = 3.8

			if var_406_28 < arg_403_1.time_ and arg_403_1.time_ <= var_406_28 + arg_406_0 then
				arg_403_1.var_.moveOldPos1085ui_story = var_406_27.localPosition
			end

			local var_406_29 = 0.001

			if var_406_28 <= arg_403_1.time_ and arg_403_1.time_ < var_406_28 + var_406_29 then
				local var_406_30 = (arg_403_1.time_ - var_406_28) / var_406_29
				local var_406_31 = Vector3.New(0, -1.01, -5.83)

				var_406_27.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1085ui_story, var_406_31, var_406_30)

				local var_406_32 = manager.ui.mainCamera.transform.position - var_406_27.position

				var_406_27.forward = Vector3.New(var_406_32.x, var_406_32.y, var_406_32.z)

				local var_406_33 = var_406_27.localEulerAngles

				var_406_33.z = 0
				var_406_33.x = 0
				var_406_27.localEulerAngles = var_406_33
			end

			if arg_403_1.time_ >= var_406_28 + var_406_29 and arg_403_1.time_ < var_406_28 + var_406_29 + arg_406_0 then
				var_406_27.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_406_34 = manager.ui.mainCamera.transform.position - var_406_27.position

				var_406_27.forward = Vector3.New(var_406_34.x, var_406_34.y, var_406_34.z)

				local var_406_35 = var_406_27.localEulerAngles

				var_406_35.z = 0
				var_406_35.x = 0
				var_406_27.localEulerAngles = var_406_35
			end

			local var_406_36 = arg_403_1.actors_["1085ui_story"]
			local var_406_37 = 3.8

			if var_406_37 < arg_403_1.time_ and arg_403_1.time_ <= var_406_37 + arg_406_0 and not isNil(var_406_36) and arg_403_1.var_.characterEffect1085ui_story == nil then
				arg_403_1.var_.characterEffect1085ui_story = var_406_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_38 = 0.200000002980232

			if var_406_37 <= arg_403_1.time_ and arg_403_1.time_ < var_406_37 + var_406_38 and not isNil(var_406_36) then
				local var_406_39 = (arg_403_1.time_ - var_406_37) / var_406_38

				if arg_403_1.var_.characterEffect1085ui_story and not isNil(var_406_36) then
					arg_403_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_37 + var_406_38 and arg_403_1.time_ < var_406_37 + var_406_38 + arg_406_0 and not isNil(var_406_36) and arg_403_1.var_.characterEffect1085ui_story then
				arg_403_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_406_40 = 3.8

			if var_406_40 < arg_403_1.time_ and arg_403_1.time_ <= var_406_40 + arg_406_0 then
				arg_403_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_406_41 = 3.8

			if var_406_41 < arg_403_1.time_ and arg_403_1.time_ <= var_406_41 + arg_406_0 then
				arg_403_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_406_42 = 1.63333333333333
			local var_406_43 = 1

			if var_406_42 < arg_403_1.time_ and arg_403_1.time_ <= var_406_42 + arg_406_0 then
				local var_406_44 = "play"
				local var_406_45 = "effect"

				arg_403_1:AudioAction(var_406_44, var_406_45, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_403_1.frameCnt_ <= 1 then
				arg_403_1.dialog_:SetActive(false)
			end

			local var_406_46 = 4
			local var_406_47 = 1

			if var_406_46 < arg_403_1.time_ and arg_403_1.time_ <= var_406_46 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0

				arg_403_1.dialog_:SetActive(true)

				arg_403_1.dialogCg_.alpha = 0

				local var_406_48 = LeanTween.value(arg_403_1.dialog_, 0, 1, 0.3)

				var_406_48:setOnUpdate(LuaHelper.FloatAction(function(arg_407_0)
					arg_403_1.dialogCg_.alpha = arg_407_0
				end))
				var_406_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_403_1.dialog_)
					var_406_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_403_1.duration_ = arg_403_1.duration_ + 0.3

				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_49 = arg_403_1:FormatText(StoryNameCfg[328].name)

				arg_403_1.leftNameTxt_.text = var_406_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_50 = arg_403_1:GetWordFromCfg(1108504098)
				local var_406_51 = arg_403_1:FormatText(var_406_50.content)

				arg_403_1.text_.text = var_406_51

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_52 = 42
				local var_406_53 = utf8.len(var_406_51)
				local var_406_54 = var_406_52 <= 0 and var_406_47 or var_406_47 * (var_406_53 / var_406_52)

				if var_406_54 > 0 and var_406_47 < var_406_54 then
					arg_403_1.talkMaxDuration = var_406_54
					var_406_46 = var_406_46 + 0.3

					if var_406_54 + var_406_46 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_54 + var_406_46
					end
				end

				arg_403_1.text_.text = var_406_51
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504098", "story_v_side_new_1108504.awb") ~= 0 then
					local var_406_55 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504098", "story_v_side_new_1108504.awb") / 1000

					if var_406_55 + var_406_46 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_55 + var_406_46
					end

					if var_406_50.prefab_name ~= "" and arg_403_1.actors_[var_406_50.prefab_name] ~= nil then
						local var_406_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_50.prefab_name].transform, "story_v_side_new_1108504", "1108504098", "story_v_side_new_1108504.awb")

						arg_403_1:RecordAudio("1108504098", var_406_56)
						arg_403_1:RecordAudio("1108504098", var_406_56)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504098", "story_v_side_new_1108504.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504098", "story_v_side_new_1108504.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_57 = var_406_46 + 0.3
			local var_406_58 = math.max(var_406_47, arg_403_1.talkMaxDuration)

			if var_406_57 <= arg_403_1.time_ and arg_403_1.time_ < var_406_57 + var_406_58 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_57) / var_406_58

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_57 + var_406_58 and arg_403_1.time_ < var_406_57 + var_406_58 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "ningxidawenben1",
				duration = 0.133333333333333,
				className = "StoryTextGroupNode",
				startTime = 1.86666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play1108504099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1108504099
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1108504100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1085ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos1085ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0, 100, 0)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1085ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, 100, 0)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = arg_409_1.actors_["1085ui_story"]
			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1085ui_story == nil then
				arg_409_1.var_.characterEffect1085ui_story = var_412_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_11 = 0.200000002980232

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_11 and not isNil(var_412_9) then
				local var_412_12 = (arg_409_1.time_ - var_412_10) / var_412_11

				if arg_409_1.var_.characterEffect1085ui_story and not isNil(var_412_9) then
					local var_412_13 = Mathf.Lerp(0, 0.5, var_412_12)

					arg_409_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1085ui_story.fillRatio = var_412_13
				end
			end

			if arg_409_1.time_ >= var_412_10 + var_412_11 and arg_409_1.time_ < var_412_10 + var_412_11 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1085ui_story then
				local var_412_14 = 0.5

				arg_409_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1085ui_story.fillRatio = var_412_14
			end

			local var_412_15 = 0
			local var_412_16 = 0.875

			if var_412_15 < arg_409_1.time_ and arg_409_1.time_ <= var_412_15 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_17 = arg_409_1:GetWordFromCfg(1108504099)
				local var_412_18 = arg_409_1:FormatText(var_412_17.content)

				arg_409_1.text_.text = var_412_18

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_19 = 35
				local var_412_20 = utf8.len(var_412_18)
				local var_412_21 = var_412_19 <= 0 and var_412_16 or var_412_16 * (var_412_20 / var_412_19)

				if var_412_21 > 0 and var_412_16 < var_412_21 then
					arg_409_1.talkMaxDuration = var_412_21

					if var_412_21 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_21 + var_412_15
					end
				end

				arg_409_1.text_.text = var_412_18
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_22 = math.max(var_412_16, arg_409_1.talkMaxDuration)

			if var_412_15 <= arg_409_1.time_ and arg_409_1.time_ < var_412_15 + var_412_22 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_15) / var_412_22

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_15 + var_412_22 and arg_409_1.time_ < var_412_15 + var_412_22 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play1108504100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1108504100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1108504101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0
			local var_416_1 = 0.275

			if var_416_0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_2 = arg_413_1:FormatText(StoryNameCfg[7].name)

				arg_413_1.leftNameTxt_.text = var_416_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_3 = arg_413_1:GetWordFromCfg(1108504100)
				local var_416_4 = arg_413_1:FormatText(var_416_3.content)

				arg_413_1.text_.text = var_416_4

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_5 = 11
				local var_416_6 = utf8.len(var_416_4)
				local var_416_7 = var_416_5 <= 0 and var_416_1 or var_416_1 * (var_416_6 / var_416_5)

				if var_416_7 > 0 and var_416_1 < var_416_7 then
					arg_413_1.talkMaxDuration = var_416_7

					if var_416_7 + var_416_0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_0
					end
				end

				arg_413_1.text_.text = var_416_4
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_8 = math.max(var_416_1, arg_413_1.talkMaxDuration)

			if var_416_0 <= arg_413_1.time_ and arg_413_1.time_ < var_416_0 + var_416_8 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_0) / var_416_8

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_0 + var_416_8 and arg_413_1.time_ < var_416_0 + var_416_8 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1108504101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1108504101
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1108504102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = 0
			local var_420_1 = 0.675

			if var_420_0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_0 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_2 = arg_417_1:FormatText(StoryNameCfg[7].name)

				arg_417_1.leftNameTxt_.text = var_420_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_3 = arg_417_1:GetWordFromCfg(1108504101)
				local var_420_4 = arg_417_1:FormatText(var_420_3.content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_5 = 27
				local var_420_6 = utf8.len(var_420_4)
				local var_420_7 = var_420_5 <= 0 and var_420_1 or var_420_1 * (var_420_6 / var_420_5)

				if var_420_7 > 0 and var_420_1 < var_420_7 then
					arg_417_1.talkMaxDuration = var_420_7

					if var_420_7 + var_420_0 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_0
					end
				end

				arg_417_1.text_.text = var_420_4
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_8 = math.max(var_420_1, arg_417_1.talkMaxDuration)

			if var_420_0 <= arg_417_1.time_ and arg_417_1.time_ < var_420_0 + var_420_8 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_0) / var_420_8

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_0 + var_420_8 and arg_417_1.time_ < var_420_0 + var_420_8 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play1108504102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1108504102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1108504103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0
			local var_424_1 = 1

			if var_424_0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_2 = arg_421_1:FormatText(StoryNameCfg[7].name)

				arg_421_1.leftNameTxt_.text = var_424_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_3 = arg_421_1:GetWordFromCfg(1108504102)
				local var_424_4 = arg_421_1:FormatText(var_424_3.content)

				arg_421_1.text_.text = var_424_4

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_5 = 40
				local var_424_6 = utf8.len(var_424_4)
				local var_424_7 = var_424_5 <= 0 and var_424_1 or var_424_1 * (var_424_6 / var_424_5)

				if var_424_7 > 0 and var_424_1 < var_424_7 then
					arg_421_1.talkMaxDuration = var_424_7

					if var_424_7 + var_424_0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_7 + var_424_0
					end
				end

				arg_421_1.text_.text = var_424_4
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_8 = math.max(var_424_1, arg_421_1.talkMaxDuration)

			if var_424_0 <= arg_421_1.time_ and arg_421_1.time_ < var_424_0 + var_424_8 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_0) / var_424_8

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_0 + var_424_8 and arg_421_1.time_ < var_424_0 + var_424_8 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1108504103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1108504103
		arg_425_1.duration_ = 5.3

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1108504104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = manager.ui.mainCamera.transform
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.var_.shakeOldPos = var_428_0.localPosition
			end

			local var_428_2 = 0.3

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / 0.066
				local var_428_4, var_428_5 = math.modf(var_428_3)

				var_428_0.localPosition = Vector3.New(var_428_5 * 0.13, var_428_5 * 0.13, var_428_5 * 0.13) + arg_425_1.var_.shakeOldPos
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 then
				var_428_0.localPosition = arg_425_1.var_.shakeOldPos
			end

			local var_428_6 = 0

			if var_428_6 < arg_425_1.time_ and arg_425_1.time_ <= var_428_6 + arg_428_0 then
				arg_425_1.allBtn_.enabled = false
			end

			local var_428_7 = 0.3

			if arg_425_1.time_ >= var_428_6 + var_428_7 and arg_425_1.time_ < var_428_6 + var_428_7 + arg_428_0 then
				arg_425_1.allBtn_.enabled = true
			end

			local var_428_8 = 2.77555756156289e-17
			local var_428_9 = 1

			if var_428_8 < arg_425_1.time_ and arg_425_1.time_ <= var_428_8 + arg_428_0 then
				local var_428_10 = "play"
				local var_428_11 = "effect"

				arg_425_1:AudioAction(var_428_10, var_428_11, "se_story_148", "se_story_148_hold", "")
			end

			if arg_425_1.frameCnt_ <= 1 then
				arg_425_1.dialog_:SetActive(false)
			end

			local var_428_12 = 0.3
			local var_428_13 = 1.05

			if var_428_12 < arg_425_1.time_ and arg_425_1.time_ <= var_428_12 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0

				arg_425_1.dialog_:SetActive(true)

				arg_425_1.dialogCg_.alpha = 0

				local var_428_14 = LeanTween.value(arg_425_1.dialog_, 0, 1, 0.3)

				var_428_14:setOnUpdate(LuaHelper.FloatAction(function(arg_429_0)
					arg_425_1.dialogCg_.alpha = arg_429_0
				end))
				var_428_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_425_1.dialog_)
					var_428_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_425_1.duration_ = arg_425_1.duration_ + 0.3

				SetActive(arg_425_1.leftNameGo_, false)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_15 = arg_425_1:GetWordFromCfg(1108504103)
				local var_428_16 = arg_425_1:FormatText(var_428_15.content)

				arg_425_1.text_.text = var_428_16

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_17 = 42
				local var_428_18 = utf8.len(var_428_16)
				local var_428_19 = var_428_17 <= 0 and var_428_13 or var_428_13 * (var_428_18 / var_428_17)

				if var_428_19 > 0 and var_428_13 < var_428_19 then
					arg_425_1.talkMaxDuration = var_428_19
					var_428_12 = var_428_12 + 0.3

					if var_428_19 + var_428_12 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_19 + var_428_12
					end
				end

				arg_425_1.text_.text = var_428_16
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_20 = var_428_12 + 0.3
			local var_428_21 = math.max(var_428_13, arg_425_1.talkMaxDuration)

			if var_428_20 <= arg_425_1.time_ and arg_425_1.time_ < var_428_20 + var_428_21 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_20) / var_428_21

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_20 + var_428_21 and arg_425_1.time_ < var_428_20 + var_428_21 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1108504104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 1108504104
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play1108504105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0
			local var_434_1 = 1.1

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_2 = arg_431_1:GetWordFromCfg(1108504104)
				local var_434_3 = arg_431_1:FormatText(var_434_2.content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_4 = 44
				local var_434_5 = utf8.len(var_434_3)
				local var_434_6 = var_434_4 <= 0 and var_434_1 or var_434_1 * (var_434_5 / var_434_4)

				if var_434_6 > 0 and var_434_1 < var_434_6 then
					arg_431_1.talkMaxDuration = var_434_6

					if var_434_6 + var_434_0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_6 + var_434_0
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_7 = math.max(var_434_1, arg_431_1.talkMaxDuration)

			if var_434_0 <= arg_431_1.time_ and arg_431_1.time_ < var_434_0 + var_434_7 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_0) / var_434_7

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_0 + var_434_7 and arg_431_1.time_ < var_434_0 + var_434_7 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play1108504105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 1108504105
		arg_435_1.duration_ = 3.97

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play1108504106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = arg_435_1.actors_["1085ui_story"].transform
			local var_438_1 = 0

			if var_438_1 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.var_.moveOldPos1085ui_story = var_438_0.localPosition
			end

			local var_438_2 = 0.001

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_2 then
				local var_438_3 = (arg_435_1.time_ - var_438_1) / var_438_2
				local var_438_4 = Vector3.New(0, -1.01, -5.83)

				var_438_0.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1085ui_story, var_438_4, var_438_3)

				local var_438_5 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_5.x, var_438_5.y, var_438_5.z)

				local var_438_6 = var_438_0.localEulerAngles

				var_438_6.z = 0
				var_438_6.x = 0
				var_438_0.localEulerAngles = var_438_6
			end

			if arg_435_1.time_ >= var_438_1 + var_438_2 and arg_435_1.time_ < var_438_1 + var_438_2 + arg_438_0 then
				var_438_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_438_7 = manager.ui.mainCamera.transform.position - var_438_0.position

				var_438_0.forward = Vector3.New(var_438_7.x, var_438_7.y, var_438_7.z)

				local var_438_8 = var_438_0.localEulerAngles

				var_438_8.z = 0
				var_438_8.x = 0
				var_438_0.localEulerAngles = var_438_8
			end

			local var_438_9 = arg_435_1.actors_["1085ui_story"]
			local var_438_10 = 0

			if var_438_10 < arg_435_1.time_ and arg_435_1.time_ <= var_438_10 + arg_438_0 and not isNil(var_438_9) and arg_435_1.var_.characterEffect1085ui_story == nil then
				arg_435_1.var_.characterEffect1085ui_story = var_438_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_11 = 0.200000002980232

			if var_438_10 <= arg_435_1.time_ and arg_435_1.time_ < var_438_10 + var_438_11 and not isNil(var_438_9) then
				local var_438_12 = (arg_435_1.time_ - var_438_10) / var_438_11

				if arg_435_1.var_.characterEffect1085ui_story and not isNil(var_438_9) then
					arg_435_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= var_438_10 + var_438_11 and arg_435_1.time_ < var_438_10 + var_438_11 + arg_438_0 and not isNil(var_438_9) and arg_435_1.var_.characterEffect1085ui_story then
				arg_435_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_438_13 = 0

			if var_438_13 < arg_435_1.time_ and arg_435_1.time_ <= var_438_13 + arg_438_0 then
				arg_435_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_438_14 = 0

			if var_438_14 < arg_435_1.time_ and arg_435_1.time_ <= var_438_14 + arg_438_0 then
				arg_435_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_438_15 = 0
			local var_438_16 = 0.325

			if var_438_15 < arg_435_1.time_ and arg_435_1.time_ <= var_438_15 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_17 = arg_435_1:FormatText(StoryNameCfg[328].name)

				arg_435_1.leftNameTxt_.text = var_438_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_18 = arg_435_1:GetWordFromCfg(1108504105)
				local var_438_19 = arg_435_1:FormatText(var_438_18.content)

				arg_435_1.text_.text = var_438_19

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_20 = 13
				local var_438_21 = utf8.len(var_438_19)
				local var_438_22 = var_438_20 <= 0 and var_438_16 or var_438_16 * (var_438_21 / var_438_20)

				if var_438_22 > 0 and var_438_16 < var_438_22 then
					arg_435_1.talkMaxDuration = var_438_22

					if var_438_22 + var_438_15 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_22 + var_438_15
					end
				end

				arg_435_1.text_.text = var_438_19
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504105", "story_v_side_new_1108504.awb") ~= 0 then
					local var_438_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504105", "story_v_side_new_1108504.awb") / 1000

					if var_438_23 + var_438_15 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_23 + var_438_15
					end

					if var_438_18.prefab_name ~= "" and arg_435_1.actors_[var_438_18.prefab_name] ~= nil then
						local var_438_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_18.prefab_name].transform, "story_v_side_new_1108504", "1108504105", "story_v_side_new_1108504.awb")

						arg_435_1:RecordAudio("1108504105", var_438_24)
						arg_435_1:RecordAudio("1108504105", var_438_24)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504105", "story_v_side_new_1108504.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504105", "story_v_side_new_1108504.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_25 = math.max(var_438_16, arg_435_1.talkMaxDuration)

			if var_438_15 <= arg_435_1.time_ and arg_435_1.time_ < var_438_15 + var_438_25 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_15) / var_438_25

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_15 + var_438_25 and arg_435_1.time_ < var_438_15 + var_438_25 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play1108504106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 1108504106
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play1108504107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = arg_439_1.actors_["1085ui_story"]
			local var_442_1 = 0

			if var_442_1 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1085ui_story == nil then
				arg_439_1.var_.characterEffect1085ui_story = var_442_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_2 = 0.200000002980232

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_2 and not isNil(var_442_0) then
				local var_442_3 = (arg_439_1.time_ - var_442_1) / var_442_2

				if arg_439_1.var_.characterEffect1085ui_story and not isNil(var_442_0) then
					local var_442_4 = Mathf.Lerp(0, 0.5, var_442_3)

					arg_439_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_439_1.var_.characterEffect1085ui_story.fillRatio = var_442_4
				end
			end

			if arg_439_1.time_ >= var_442_1 + var_442_2 and arg_439_1.time_ < var_442_1 + var_442_2 + arg_442_0 and not isNil(var_442_0) and arg_439_1.var_.characterEffect1085ui_story then
				local var_442_5 = 0.5

				arg_439_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_439_1.var_.characterEffect1085ui_story.fillRatio = var_442_5
			end

			local var_442_6 = 0
			local var_442_7 = 0.525

			if var_442_6 < arg_439_1.time_ and arg_439_1.time_ <= var_442_6 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_8 = arg_439_1:FormatText(StoryNameCfg[7].name)

				arg_439_1.leftNameTxt_.text = var_442_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_9 = arg_439_1:GetWordFromCfg(1108504106)
				local var_442_10 = arg_439_1:FormatText(var_442_9.content)

				arg_439_1.text_.text = var_442_10

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_11 = 21
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
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_14 = math.max(var_442_7, arg_439_1.talkMaxDuration)

			if var_442_6 <= arg_439_1.time_ and arg_439_1.time_ < var_442_6 + var_442_14 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_6) / var_442_14

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_6 + var_442_14 and arg_439_1.time_ < var_442_6 + var_442_14 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play1108504107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 1108504107
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play1108504108(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = arg_443_1.actors_["1085ui_story"].transform
			local var_446_1 = 0

			if var_446_1 < arg_443_1.time_ and arg_443_1.time_ <= var_446_1 + arg_446_0 then
				arg_443_1.var_.moveOldPos1085ui_story = var_446_0.localPosition
			end

			local var_446_2 = 0.001

			if var_446_1 <= arg_443_1.time_ and arg_443_1.time_ < var_446_1 + var_446_2 then
				local var_446_3 = (arg_443_1.time_ - var_446_1) / var_446_2
				local var_446_4 = Vector3.New(0, 100, 0)

				var_446_0.localPosition = Vector3.Lerp(arg_443_1.var_.moveOldPos1085ui_story, var_446_4, var_446_3)

				local var_446_5 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_5.x, var_446_5.y, var_446_5.z)

				local var_446_6 = var_446_0.localEulerAngles

				var_446_6.z = 0
				var_446_6.x = 0
				var_446_0.localEulerAngles = var_446_6
			end

			if arg_443_1.time_ >= var_446_1 + var_446_2 and arg_443_1.time_ < var_446_1 + var_446_2 + arg_446_0 then
				var_446_0.localPosition = Vector3.New(0, 100, 0)

				local var_446_7 = manager.ui.mainCamera.transform.position - var_446_0.position

				var_446_0.forward = Vector3.New(var_446_7.x, var_446_7.y, var_446_7.z)

				local var_446_8 = var_446_0.localEulerAngles

				var_446_8.z = 0
				var_446_8.x = 0
				var_446_0.localEulerAngles = var_446_8
			end

			local var_446_9 = 0
			local var_446_10 = 0.65

			if var_446_9 < arg_443_1.time_ and arg_443_1.time_ <= var_446_9 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, false)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_11 = arg_443_1:GetWordFromCfg(1108504107)
				local var_446_12 = arg_443_1:FormatText(var_446_11.content)

				arg_443_1.text_.text = var_446_12

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_13 = 26
				local var_446_14 = utf8.len(var_446_12)
				local var_446_15 = var_446_13 <= 0 and var_446_10 or var_446_10 * (var_446_14 / var_446_13)

				if var_446_15 > 0 and var_446_10 < var_446_15 then
					arg_443_1.talkMaxDuration = var_446_15

					if var_446_15 + var_446_9 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_15 + var_446_9
					end
				end

				arg_443_1.text_.text = var_446_12
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_16 = math.max(var_446_10, arg_443_1.talkMaxDuration)

			if var_446_9 <= arg_443_1.time_ and arg_443_1.time_ < var_446_9 + var_446_16 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_9) / var_446_16

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_9 + var_446_16 and arg_443_1.time_ < var_446_9 + var_446_16 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_443_1:InitPlayNodeList()
	end,
	Play1108504108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 1108504108
		arg_447_1.duration_ = 9

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play1108504109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = "ST12a"

			if arg_447_1.bgs_[var_450_0] == nil then
				local var_450_1 = Object.Instantiate(arg_447_1.paintGo_)

				var_450_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_450_0)
				var_450_1.name = var_450_0
				var_450_1.transform.parent = arg_447_1.stage_.transform
				var_450_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_447_1.bgs_[var_450_0] = var_450_1
			end

			local var_450_2 = 2

			if var_450_2 < arg_447_1.time_ and arg_447_1.time_ <= var_450_2 + arg_450_0 then
				local var_450_3 = manager.ui.mainCamera.transform.localPosition
				local var_450_4 = Vector3.New(0, 0, 10) + Vector3.New(var_450_3.x, var_450_3.y, 0)
				local var_450_5 = arg_447_1.bgs_.ST12a

				var_450_5.transform.localPosition = var_450_4
				var_450_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_450_6 = var_450_5:GetComponent("SpriteRenderer")

				if var_450_6 and var_450_6.sprite then
					local var_450_7 = (var_450_5.transform.localPosition - var_450_3).z
					local var_450_8 = manager.ui.mainCameraCom_
					local var_450_9 = 2 * var_450_7 * Mathf.Tan(var_450_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_450_10 = var_450_9 * var_450_8.aspect
					local var_450_11 = var_450_6.sprite.bounds.size.x
					local var_450_12 = var_450_6.sprite.bounds.size.y
					local var_450_13 = var_450_10 / var_450_11
					local var_450_14 = var_450_9 / var_450_12
					local var_450_15 = var_450_14 < var_450_13 and var_450_13 or var_450_14

					var_450_5.transform.localScale = Vector3.New(var_450_15, var_450_15, 0)
				end

				for iter_450_0, iter_450_1 in pairs(arg_447_1.bgs_) do
					if iter_450_0 ~= "ST12a" then
						iter_450_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_450_16 = 4

			if var_450_16 < arg_447_1.time_ and arg_447_1.time_ <= var_450_16 + arg_450_0 then
				arg_447_1.allBtn_.enabled = false
			end

			local var_450_17 = 0.3

			if arg_447_1.time_ >= var_450_16 + var_450_17 and arg_447_1.time_ < var_450_16 + var_450_17 + arg_450_0 then
				arg_447_1.allBtn_.enabled = true
			end

			local var_450_18 = 0

			if var_450_18 < arg_447_1.time_ and arg_447_1.time_ <= var_450_18 + arg_450_0 then
				arg_447_1.mask_.enabled = true
				arg_447_1.mask_.raycastTarget = true

				arg_447_1:SetGaussion(false)
			end

			local var_450_19 = 2

			if var_450_18 <= arg_447_1.time_ and arg_447_1.time_ < var_450_18 + var_450_19 then
				local var_450_20 = (arg_447_1.time_ - var_450_18) / var_450_19
				local var_450_21 = Color.New(0, 0, 0)

				var_450_21.a = Mathf.Lerp(0, 1, var_450_20)
				arg_447_1.mask_.color = var_450_21
			end

			if arg_447_1.time_ >= var_450_18 + var_450_19 and arg_447_1.time_ < var_450_18 + var_450_19 + arg_450_0 then
				local var_450_22 = Color.New(0, 0, 0)

				var_450_22.a = 1
				arg_447_1.mask_.color = var_450_22
			end

			local var_450_23 = 2

			if var_450_23 < arg_447_1.time_ and arg_447_1.time_ <= var_450_23 + arg_450_0 then
				arg_447_1.mask_.enabled = true
				arg_447_1.mask_.raycastTarget = true

				arg_447_1:SetGaussion(false)
			end

			local var_450_24 = 2

			if var_450_23 <= arg_447_1.time_ and arg_447_1.time_ < var_450_23 + var_450_24 then
				local var_450_25 = (arg_447_1.time_ - var_450_23) / var_450_24
				local var_450_26 = Color.New(0, 0, 0)

				var_450_26.a = Mathf.Lerp(1, 0, var_450_25)
				arg_447_1.mask_.color = var_450_26
			end

			if arg_447_1.time_ >= var_450_23 + var_450_24 and arg_447_1.time_ < var_450_23 + var_450_24 + arg_450_0 then
				local var_450_27 = Color.New(0, 0, 0)
				local var_450_28 = 0

				arg_447_1.mask_.enabled = false
				var_450_27.a = var_450_28
				arg_447_1.mask_.color = var_450_27
			end

			if arg_447_1.frameCnt_ <= 1 then
				arg_447_1.dialog_:SetActive(false)
			end

			local var_450_29 = 4
			local var_450_30 = 0.65

			if var_450_29 < arg_447_1.time_ and arg_447_1.time_ <= var_450_29 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0

				arg_447_1.dialog_:SetActive(true)

				arg_447_1.dialogCg_.alpha = 0

				local var_450_31 = LeanTween.value(arg_447_1.dialog_, 0, 1, 0.3)

				var_450_31:setOnUpdate(LuaHelper.FloatAction(function(arg_451_0)
					arg_447_1.dialogCg_.alpha = arg_451_0
				end))
				var_450_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_447_1.dialog_)
					var_450_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_447_1.duration_ = arg_447_1.duration_ + 0.3

				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_32 = arg_447_1:FormatText(StoryNameCfg[7].name)

				arg_447_1.leftNameTxt_.text = var_450_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_33 = arg_447_1:GetWordFromCfg(1108504108)
				local var_450_34 = arg_447_1:FormatText(var_450_33.content)

				arg_447_1.text_.text = var_450_34

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_35 = 26
				local var_450_36 = utf8.len(var_450_34)
				local var_450_37 = var_450_35 <= 0 and var_450_30 or var_450_30 * (var_450_36 / var_450_35)

				if var_450_37 > 0 and var_450_30 < var_450_37 then
					arg_447_1.talkMaxDuration = var_450_37
					var_450_29 = var_450_29 + 0.3

					if var_450_37 + var_450_29 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_37 + var_450_29
					end
				end

				arg_447_1.text_.text = var_450_34
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_38 = var_450_29 + 0.3
			local var_450_39 = math.max(var_450_30, arg_447_1.talkMaxDuration)

			if var_450_38 <= arg_447_1.time_ and arg_447_1.time_ < var_450_38 + var_450_39 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_38) / var_450_39

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_38 + var_450_39 and arg_447_1.time_ < var_450_38 + var_450_39 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play1108504109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1108504109
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1108504110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 0.5

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_2 = arg_453_1:GetWordFromCfg(1108504109)
				local var_456_3 = arg_453_1:FormatText(var_456_2.content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 20
				local var_456_5 = utf8.len(var_456_3)
				local var_456_6 = var_456_4 <= 0 and var_456_1 or var_456_1 * (var_456_5 / var_456_4)

				if var_456_6 > 0 and var_456_1 < var_456_6 then
					arg_453_1.talkMaxDuration = var_456_6

					if var_456_6 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_3
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_7 and arg_453_1.time_ < var_456_0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1108504110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1108504110
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1108504111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 0.35

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				local var_460_2 = arg_457_1:FormatText(StoryNameCfg[7].name)

				arg_457_1.leftNameTxt_.text = var_460_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:GetWordFromCfg(1108504110)
				local var_460_4 = arg_457_1:FormatText(var_460_3.content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 14
				local var_460_6 = utf8.len(var_460_4)
				local var_460_7 = var_460_5 <= 0 and var_460_1 or var_460_1 * (var_460_6 / var_460_5)

				if var_460_7 > 0 and var_460_1 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_4
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_8 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_8 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_8

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_8 and arg_457_1.time_ < var_460_0 + var_460_8 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play1108504111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1108504111
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1108504112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 1.075

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_2 = arg_461_1:GetWordFromCfg(1108504111)
				local var_464_3 = arg_461_1:FormatText(var_464_2.content)

				arg_461_1.text_.text = var_464_3

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_4 = 43
				local var_464_5 = utf8.len(var_464_3)
				local var_464_6 = var_464_4 <= 0 and var_464_1 or var_464_1 * (var_464_5 / var_464_4)

				if var_464_6 > 0 and var_464_1 < var_464_6 then
					arg_461_1.talkMaxDuration = var_464_6

					if var_464_6 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_6 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_3
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_7 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_7 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_7

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_7 and arg_461_1.time_ < var_464_0 + var_464_7 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1108504112 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1108504112
		arg_465_1.duration_ = 9

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1108504113(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = "R8501"

			if arg_465_1.bgs_[var_468_0] == nil then
				local var_468_1 = Object.Instantiate(arg_465_1.paintGo_)

				var_468_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_468_0)
				var_468_1.name = var_468_0
				var_468_1.transform.parent = arg_465_1.stage_.transform
				var_468_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_465_1.bgs_[var_468_0] = var_468_1
			end

			local var_468_2 = 2

			if var_468_2 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 then
				local var_468_3 = manager.ui.mainCamera.transform.localPosition
				local var_468_4 = Vector3.New(0, 0, 10) + Vector3.New(var_468_3.x, var_468_3.y, 0)
				local var_468_5 = arg_465_1.bgs_.R8501

				var_468_5.transform.localPosition = var_468_4
				var_468_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_468_6 = var_468_5:GetComponent("SpriteRenderer")

				if var_468_6 and var_468_6.sprite then
					local var_468_7 = (var_468_5.transform.localPosition - var_468_3).z
					local var_468_8 = manager.ui.mainCameraCom_
					local var_468_9 = 2 * var_468_7 * Mathf.Tan(var_468_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_468_10 = var_468_9 * var_468_8.aspect
					local var_468_11 = var_468_6.sprite.bounds.size.x
					local var_468_12 = var_468_6.sprite.bounds.size.y
					local var_468_13 = var_468_10 / var_468_11
					local var_468_14 = var_468_9 / var_468_12
					local var_468_15 = var_468_14 < var_468_13 and var_468_13 or var_468_14

					var_468_5.transform.localScale = Vector3.New(var_468_15, var_468_15, 0)
				end

				for iter_468_0, iter_468_1 in pairs(arg_465_1.bgs_) do
					if iter_468_0 ~= "R8501" then
						iter_468_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_468_16 = 4

			if var_468_16 < arg_465_1.time_ and arg_465_1.time_ <= var_468_16 + arg_468_0 then
				arg_465_1.allBtn_.enabled = false
			end

			local var_468_17 = 0.3

			if arg_465_1.time_ >= var_468_16 + var_468_17 and arg_465_1.time_ < var_468_16 + var_468_17 + arg_468_0 then
				arg_465_1.allBtn_.enabled = true
			end

			local var_468_18 = 0

			if var_468_18 < arg_465_1.time_ and arg_465_1.time_ <= var_468_18 + arg_468_0 then
				arg_465_1.mask_.enabled = true
				arg_465_1.mask_.raycastTarget = true

				arg_465_1:SetGaussion(false)
			end

			local var_468_19 = 2

			if var_468_18 <= arg_465_1.time_ and arg_465_1.time_ < var_468_18 + var_468_19 then
				local var_468_20 = (arg_465_1.time_ - var_468_18) / var_468_19
				local var_468_21 = Color.New(0, 0, 0)

				var_468_21.a = Mathf.Lerp(0, 1, var_468_20)
				arg_465_1.mask_.color = var_468_21
			end

			if arg_465_1.time_ >= var_468_18 + var_468_19 and arg_465_1.time_ < var_468_18 + var_468_19 + arg_468_0 then
				local var_468_22 = Color.New(0, 0, 0)

				var_468_22.a = 1
				arg_465_1.mask_.color = var_468_22
			end

			local var_468_23 = 2

			if var_468_23 < arg_465_1.time_ and arg_465_1.time_ <= var_468_23 + arg_468_0 then
				arg_465_1.mask_.enabled = true
				arg_465_1.mask_.raycastTarget = true

				arg_465_1:SetGaussion(false)
			end

			local var_468_24 = 2

			if var_468_23 <= arg_465_1.time_ and arg_465_1.time_ < var_468_23 + var_468_24 then
				local var_468_25 = (arg_465_1.time_ - var_468_23) / var_468_24
				local var_468_26 = Color.New(0, 0, 0)

				var_468_26.a = Mathf.Lerp(1, 0, var_468_25)
				arg_465_1.mask_.color = var_468_26
			end

			if arg_465_1.time_ >= var_468_23 + var_468_24 and arg_465_1.time_ < var_468_23 + var_468_24 + arg_468_0 then
				local var_468_27 = Color.New(0, 0, 0)
				local var_468_28 = 0

				arg_465_1.mask_.enabled = false
				var_468_27.a = var_468_28
				arg_465_1.mask_.color = var_468_27
			end

			local var_468_29 = 0.333333333333333
			local var_468_30 = 0.3

			if var_468_29 < arg_465_1.time_ and arg_465_1.time_ <= var_468_29 + arg_468_0 then
				local var_468_31 = "play"
				local var_468_32 = "music"

				arg_465_1:AudioAction(var_468_31, var_468_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_468_33 = ""
				local var_468_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_468_34 ~= "" then
					if arg_465_1.bgmTxt_.text ~= var_468_34 and arg_465_1.bgmTxt_.text ~= "" then
						if arg_465_1.bgmTxt2_.text ~= "" then
							arg_465_1.bgmTxt_.text = arg_465_1.bgmTxt2_.text
						end

						arg_465_1.bgmTxt2_.text = var_468_34

						arg_465_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_465_1.bgmTxt_.text = var_468_34
						arg_465_1.bgmTxt2_.text = var_468_34
					end

					if arg_465_1.bgmTimer then
						arg_465_1.bgmTimer:Stop()

						arg_465_1.bgmTimer = nil
					end

					if arg_465_1.settingData.show_music_name == 1 then
						arg_465_1.musicController:SetSelectedState("show")
						arg_465_1.musicAnimator_:Play("open", 0, 0)

						if arg_465_1.settingData.music_time ~= 0 then
							arg_465_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_465_1.settingData.music_time), function()
								if arg_465_1 == nil or isNil(arg_465_1.bgmTxt_) then
									return
								end

								arg_465_1.musicController:SetSelectedState("hide")
								arg_465_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_468_35 = 1.63333333333333
			local var_468_36 = 1

			if var_468_35 < arg_465_1.time_ and arg_465_1.time_ <= var_468_35 + arg_468_0 then
				local var_468_37 = "play"
				local var_468_38 = "music"

				arg_465_1:AudioAction(var_468_37, var_468_38, "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_468_39 = ""
				local var_468_40 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if var_468_40 ~= "" then
					if arg_465_1.bgmTxt_.text ~= var_468_40 and arg_465_1.bgmTxt_.text ~= "" then
						if arg_465_1.bgmTxt2_.text ~= "" then
							arg_465_1.bgmTxt_.text = arg_465_1.bgmTxt2_.text
						end

						arg_465_1.bgmTxt2_.text = var_468_40

						arg_465_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_465_1.bgmTxt_.text = var_468_40
						arg_465_1.bgmTxt2_.text = var_468_40
					end

					if arg_465_1.bgmTimer then
						arg_465_1.bgmTimer:Stop()

						arg_465_1.bgmTimer = nil
					end

					if arg_465_1.settingData.show_music_name == 1 then
						arg_465_1.musicController:SetSelectedState("show")
						arg_465_1.musicAnimator_:Play("open", 0, 0)

						if arg_465_1.settingData.music_time ~= 0 then
							arg_465_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_465_1.settingData.music_time), function()
								if arg_465_1 == nil or isNil(arg_465_1.bgmTxt_) then
									return
								end

								arg_465_1.musicController:SetSelectedState("hide")
								arg_465_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_468_41 = arg_465_1.bgs_.R8501.transform
			local var_468_42 = 2

			if var_468_42 < arg_465_1.time_ and arg_465_1.time_ <= var_468_42 + arg_468_0 then
				arg_465_1.var_.moveOldPosR8501 = var_468_41.localPosition
			end

			local var_468_43 = 3.5

			if var_468_42 <= arg_465_1.time_ and arg_465_1.time_ < var_468_42 + var_468_43 then
				local var_468_44 = (arg_465_1.time_ - var_468_42) / var_468_43
				local var_468_45 = Vector3.New(0, 1, 2)

				var_468_41.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPosR8501, var_468_45, var_468_44)
			end

			if arg_465_1.time_ >= var_468_42 + var_468_43 and arg_465_1.time_ < var_468_42 + var_468_43 + arg_468_0 then
				var_468_41.localPosition = Vector3.New(0, 1, 2)
			end

			local var_468_46 = 4

			if var_468_46 < arg_465_1.time_ and arg_465_1.time_ <= var_468_46 + arg_468_0 then
				arg_465_1.allBtn_.enabled = false
			end

			local var_468_47 = 1.5

			if arg_465_1.time_ >= var_468_46 + var_468_47 and arg_465_1.time_ < var_468_46 + var_468_47 + arg_468_0 then
				arg_465_1.allBtn_.enabled = true
			end

			if arg_465_1.frameCnt_ <= 1 then
				arg_465_1.dialog_:SetActive(false)
			end

			local var_468_48 = 4
			local var_468_49 = 0.5

			if var_468_48 < arg_465_1.time_ and arg_465_1.time_ <= var_468_48 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0

				arg_465_1.dialog_:SetActive(true)

				arg_465_1.dialogCg_.alpha = 0

				local var_468_50 = LeanTween.value(arg_465_1.dialog_, 0, 1, 0.3)

				var_468_50:setOnUpdate(LuaHelper.FloatAction(function(arg_471_0)
					arg_465_1.dialogCg_.alpha = arg_471_0
				end))
				var_468_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_465_1.dialog_)
					var_468_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_465_1.duration_ = arg_465_1.duration_ + 0.3

				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_51 = arg_465_1:FormatText(StoryNameCfg[7].name)

				arg_465_1.leftNameTxt_.text = var_468_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_52 = arg_465_1:GetWordFromCfg(1108504112)
				local var_468_53 = arg_465_1:FormatText(var_468_52.content)

				arg_465_1.text_.text = var_468_53

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_54 = 20
				local var_468_55 = utf8.len(var_468_53)
				local var_468_56 = var_468_54 <= 0 and var_468_49 or var_468_49 * (var_468_55 / var_468_54)

				if var_468_56 > 0 and var_468_49 < var_468_56 then
					arg_465_1.talkMaxDuration = var_468_56
					var_468_48 = var_468_48 + 0.3

					if var_468_56 + var_468_48 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_56 + var_468_48
					end
				end

				arg_465_1.text_.text = var_468_53
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_57 = var_468_48 + 0.3
			local var_468_58 = math.max(var_468_49, arg_465_1.talkMaxDuration)

			if var_468_57 <= arg_465_1.time_ and arg_465_1.time_ < var_468_57 + var_468_58 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_57) / var_468_58

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_57 + var_468_58 and arg_465_1.time_ < var_468_57 + var_468_58 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R8501",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.5,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0.5, 2),
					endPos = Vector3.New(0, 1, 2),
					easeType = LeanTweenType.easeInOutQuint
				}
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play1108504113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1108504113
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1108504114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 0.5

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_2 = arg_473_1:FormatText(StoryNameCfg[7].name)

				arg_473_1.leftNameTxt_.text = var_476_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_3 = arg_473_1:GetWordFromCfg(1108504113)
				local var_476_4 = arg_473_1:FormatText(var_476_3.content)

				arg_473_1.text_.text = var_476_4

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_5 = 20
				local var_476_6 = utf8.len(var_476_4)
				local var_476_7 = var_476_5 <= 0 and var_476_1 or var_476_1 * (var_476_6 / var_476_5)

				if var_476_7 > 0 and var_476_1 < var_476_7 then
					arg_473_1.talkMaxDuration = var_476_7

					if var_476_7 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_7 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_4
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_8 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_8 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_8

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_8 and arg_473_1.time_ < var_476_0 + var_476_8 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1108504114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1108504114
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1108504115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0
			local var_480_1 = 0.25

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_2 = arg_477_1:FormatText(StoryNameCfg[7].name)

				arg_477_1.leftNameTxt_.text = var_480_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_3 = arg_477_1:GetWordFromCfg(1108504114)
				local var_480_4 = arg_477_1:FormatText(var_480_3.content)

				arg_477_1.text_.text = var_480_4

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 10
				local var_480_6 = utf8.len(var_480_4)
				local var_480_7 = var_480_5 <= 0 and var_480_1 or var_480_1 * (var_480_6 / var_480_5)

				if var_480_7 > 0 and var_480_1 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_4
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_8 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_8 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_8

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_8 and arg_477_1.time_ < var_480_0 + var_480_8 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1108504115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1108504115
		arg_481_1.duration_ = 1.9

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1108504116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0
			local var_484_1 = 0.1

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_2 = arg_481_1:FormatText(StoryNameCfg[328].name)

				arg_481_1.leftNameTxt_.text = var_484_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_3 = arg_481_1:GetWordFromCfg(1108504115)
				local var_484_4 = arg_481_1:FormatText(var_484_3.content)

				arg_481_1.text_.text = var_484_4

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_5 = 4
				local var_484_6 = utf8.len(var_484_4)
				local var_484_7 = var_484_5 <= 0 and var_484_1 or var_484_1 * (var_484_6 / var_484_5)

				if var_484_7 > 0 and var_484_1 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_0
					end
				end

				arg_481_1.text_.text = var_484_4
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504115", "story_v_side_new_1108504.awb") ~= 0 then
					local var_484_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504115", "story_v_side_new_1108504.awb") / 1000

					if var_484_8 + var_484_0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_8 + var_484_0
					end

					if var_484_3.prefab_name ~= "" and arg_481_1.actors_[var_484_3.prefab_name] ~= nil then
						local var_484_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_3.prefab_name].transform, "story_v_side_new_1108504", "1108504115", "story_v_side_new_1108504.awb")

						arg_481_1:RecordAudio("1108504115", var_484_9)
						arg_481_1:RecordAudio("1108504115", var_484_9)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504115", "story_v_side_new_1108504.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504115", "story_v_side_new_1108504.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_10 = math.max(var_484_1, arg_481_1.talkMaxDuration)

			if var_484_0 <= arg_481_1.time_ and arg_481_1.time_ < var_484_0 + var_484_10 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_0) / var_484_10

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_0 + var_484_10 and arg_481_1.time_ < var_484_0 + var_484_10 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1108504116 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1108504116
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1108504117(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["1085ui_story"]
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect1085ui_story == nil then
				arg_485_1.var_.characterEffect1085ui_story = var_488_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_2 = 0.200000002980232

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 and not isNil(var_488_0) then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2

				if arg_485_1.var_.characterEffect1085ui_story and not isNil(var_488_0) then
					local var_488_4 = Mathf.Lerp(0, 0.5, var_488_3)

					arg_485_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1085ui_story.fillRatio = var_488_4
				end
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 and not isNil(var_488_0) and arg_485_1.var_.characterEffect1085ui_story then
				local var_488_5 = 0.5

				arg_485_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1085ui_story.fillRatio = var_488_5
			end

			local var_488_6 = 0
			local var_488_7 = 0.125

			if var_488_6 < arg_485_1.time_ and arg_485_1.time_ <= var_488_6 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_8 = arg_485_1:FormatText(StoryNameCfg[7].name)

				arg_485_1.leftNameTxt_.text = var_488_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_9 = arg_485_1:GetWordFromCfg(1108504116)
				local var_488_10 = arg_485_1:FormatText(var_488_9.content)

				arg_485_1.text_.text = var_488_10

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_11 = 5
				local var_488_12 = utf8.len(var_488_10)
				local var_488_13 = var_488_11 <= 0 and var_488_7 or var_488_7 * (var_488_12 / var_488_11)

				if var_488_13 > 0 and var_488_7 < var_488_13 then
					arg_485_1.talkMaxDuration = var_488_13

					if var_488_13 + var_488_6 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_13 + var_488_6
					end
				end

				arg_485_1.text_.text = var_488_10
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_14 = math.max(var_488_7, arg_485_1.talkMaxDuration)

			if var_488_6 <= arg_485_1.time_ and arg_485_1.time_ < var_488_6 + var_488_14 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_6) / var_488_14

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_6 + var_488_14 and arg_485_1.time_ < var_488_6 + var_488_14 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play1108504117 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1108504117
		arg_489_1.duration_ = 4.93

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1108504118(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 0.225

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_2 = arg_489_1:FormatText(StoryNameCfg[328].name)

				arg_489_1.leftNameTxt_.text = var_492_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_3 = arg_489_1:GetWordFromCfg(1108504117)
				local var_492_4 = arg_489_1:FormatText(var_492_3.content)

				arg_489_1.text_.text = var_492_4

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 9
				local var_492_6 = utf8.len(var_492_4)
				local var_492_7 = var_492_5 <= 0 and var_492_1 or var_492_1 * (var_492_6 / var_492_5)

				if var_492_7 > 0 and var_492_1 < var_492_7 then
					arg_489_1.talkMaxDuration = var_492_7

					if var_492_7 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_7 + var_492_0
					end
				end

				arg_489_1.text_.text = var_492_4
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504117", "story_v_side_new_1108504.awb") ~= 0 then
					local var_492_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504117", "story_v_side_new_1108504.awb") / 1000

					if var_492_8 + var_492_0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_8 + var_492_0
					end

					if var_492_3.prefab_name ~= "" and arg_489_1.actors_[var_492_3.prefab_name] ~= nil then
						local var_492_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_3.prefab_name].transform, "story_v_side_new_1108504", "1108504117", "story_v_side_new_1108504.awb")

						arg_489_1:RecordAudio("1108504117", var_492_9)
						arg_489_1:RecordAudio("1108504117", var_492_9)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504117", "story_v_side_new_1108504.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504117", "story_v_side_new_1108504.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_10 = math.max(var_492_1, arg_489_1.talkMaxDuration)

			if var_492_0 <= arg_489_1.time_ and arg_489_1.time_ < var_492_0 + var_492_10 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_0) / var_492_10

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_0 + var_492_10 and arg_489_1.time_ < var_492_0 + var_492_10 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1108504118 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1108504118
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1108504119(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["1085ui_story"].transform
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 then
				arg_493_1.var_.moveOldPos1085ui_story = var_496_0.localPosition
			end

			local var_496_2 = 0.001

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2
				local var_496_4 = Vector3.New(0, 100, 0)

				var_496_0.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1085ui_story, var_496_4, var_496_3)

				local var_496_5 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_5.x, var_496_5.y, var_496_5.z)

				local var_496_6 = var_496_0.localEulerAngles

				var_496_6.z = 0
				var_496_6.x = 0
				var_496_0.localEulerAngles = var_496_6
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 then
				var_496_0.localPosition = Vector3.New(0, 100, 0)

				local var_496_7 = manager.ui.mainCamera.transform.position - var_496_0.position

				var_496_0.forward = Vector3.New(var_496_7.x, var_496_7.y, var_496_7.z)

				local var_496_8 = var_496_0.localEulerAngles

				var_496_8.z = 0
				var_496_8.x = 0
				var_496_0.localEulerAngles = var_496_8
			end

			local var_496_9 = arg_493_1.actors_["1085ui_story"]
			local var_496_10 = 0

			if var_496_10 < arg_493_1.time_ and arg_493_1.time_ <= var_496_10 + arg_496_0 and not isNil(var_496_9) and arg_493_1.var_.characterEffect1085ui_story == nil then
				arg_493_1.var_.characterEffect1085ui_story = var_496_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_11 = 0.200000002980232

			if var_496_10 <= arg_493_1.time_ and arg_493_1.time_ < var_496_10 + var_496_11 and not isNil(var_496_9) then
				local var_496_12 = (arg_493_1.time_ - var_496_10) / var_496_11

				if arg_493_1.var_.characterEffect1085ui_story and not isNil(var_496_9) then
					local var_496_13 = Mathf.Lerp(0, 0.5, var_496_12)

					arg_493_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_493_1.var_.characterEffect1085ui_story.fillRatio = var_496_13
				end
			end

			if arg_493_1.time_ >= var_496_10 + var_496_11 and arg_493_1.time_ < var_496_10 + var_496_11 + arg_496_0 and not isNil(var_496_9) and arg_493_1.var_.characterEffect1085ui_story then
				local var_496_14 = 0.5

				arg_493_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_493_1.var_.characterEffect1085ui_story.fillRatio = var_496_14
			end

			local var_496_15 = 0
			local var_496_16 = 0.875

			if var_496_15 < arg_493_1.time_ and arg_493_1.time_ <= var_496_15 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_17 = arg_493_1:GetWordFromCfg(1108504118)
				local var_496_18 = arg_493_1:FormatText(var_496_17.content)

				arg_493_1.text_.text = var_496_18

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_19 = 35
				local var_496_20 = utf8.len(var_496_18)
				local var_496_21 = var_496_19 <= 0 and var_496_16 or var_496_16 * (var_496_20 / var_496_19)

				if var_496_21 > 0 and var_496_16 < var_496_21 then
					arg_493_1.talkMaxDuration = var_496_21

					if var_496_21 + var_496_15 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_21 + var_496_15
					end
				end

				arg_493_1.text_.text = var_496_18
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_22 = math.max(var_496_16, arg_493_1.talkMaxDuration)

			if var_496_15 <= arg_493_1.time_ and arg_493_1.time_ < var_496_15 + var_496_22 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_15) / var_496_22

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_15 + var_496_22 and arg_493_1.time_ < var_496_15 + var_496_22 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504119 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 1108504119
		arg_497_1.duration_ = 3.13

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play1108504120(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0
			local var_500_1 = 0.175

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0

				arg_497_1.dialog_:SetActive(true)

				arg_497_1.dialogCg_.alpha = 0

				local var_500_2 = LeanTween.value(arg_497_1.dialog_, 0, 1, 0.3)

				var_500_2:setOnUpdate(LuaHelper.FloatAction(function(arg_501_0)
					arg_497_1.dialogCg_.alpha = arg_501_0
				end))
				var_500_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_497_1.dialog_)
					var_500_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_497_1.duration_ = arg_497_1.duration_ + 0.3

				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_3 = arg_497_1:FormatText(StoryNameCfg[328].name)

				arg_497_1.leftNameTxt_.text = var_500_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_4 = arg_497_1:GetWordFromCfg(1108504119)
				local var_500_5 = arg_497_1:FormatText(var_500_4.content)

				arg_497_1.text_.text = var_500_5

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_6 = 7
				local var_500_7 = utf8.len(var_500_5)
				local var_500_8 = var_500_6 <= 0 and var_500_1 or var_500_1 * (var_500_7 / var_500_6)

				if var_500_8 > 0 and var_500_1 < var_500_8 then
					arg_497_1.talkMaxDuration = var_500_8
					var_500_0 = var_500_0 + 0.3

					if var_500_8 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_8 + var_500_0
					end
				end

				arg_497_1.text_.text = var_500_5
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504119", "story_v_side_new_1108504.awb") ~= 0 then
					local var_500_9 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504119", "story_v_side_new_1108504.awb") / 1000

					if var_500_9 + var_500_0 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_9 + var_500_0
					end

					if var_500_4.prefab_name ~= "" and arg_497_1.actors_[var_500_4.prefab_name] ~= nil then
						local var_500_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_4.prefab_name].transform, "story_v_side_new_1108504", "1108504119", "story_v_side_new_1108504.awb")

						arg_497_1:RecordAudio("1108504119", var_500_10)
						arg_497_1:RecordAudio("1108504119", var_500_10)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504119", "story_v_side_new_1108504.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504119", "story_v_side_new_1108504.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_11 = var_500_0 + 0.3
			local var_500_12 = math.max(var_500_1, arg_497_1.talkMaxDuration)

			if var_500_11 <= arg_497_1.time_ and arg_497_1.time_ < var_500_11 + var_500_12 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_11) / var_500_12

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_11 + var_500_12 and arg_497_1.time_ < var_500_11 + var_500_12 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play1108504120 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1108504120
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1108504121(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["1085ui_story"]
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.characterEffect1085ui_story == nil then
				arg_503_1.var_.characterEffect1085ui_story = var_506_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 and not isNil(var_506_0) then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2

				if arg_503_1.var_.characterEffect1085ui_story and not isNil(var_506_0) then
					local var_506_4 = Mathf.Lerp(0, 0.5, var_506_3)

					arg_503_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_503_1.var_.characterEffect1085ui_story.fillRatio = var_506_4
				end
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.characterEffect1085ui_story then
				local var_506_5 = 0.5

				arg_503_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_503_1.var_.characterEffect1085ui_story.fillRatio = var_506_5
			end

			local var_506_6 = 0
			local var_506_7 = 0.6

			if var_506_6 < arg_503_1.time_ and arg_503_1.time_ <= var_506_6 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_8 = arg_503_1:FormatText(StoryNameCfg[7].name)

				arg_503_1.leftNameTxt_.text = var_506_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_9 = arg_503_1:GetWordFromCfg(1108504120)
				local var_506_10 = arg_503_1:FormatText(var_506_9.content)

				arg_503_1.text_.text = var_506_10

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_11 = 24
				local var_506_12 = utf8.len(var_506_10)
				local var_506_13 = var_506_11 <= 0 and var_506_7 or var_506_7 * (var_506_12 / var_506_11)

				if var_506_13 > 0 and var_506_7 < var_506_13 then
					arg_503_1.talkMaxDuration = var_506_13

					if var_506_13 + var_506_6 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_13 + var_506_6
					end
				end

				arg_503_1.text_.text = var_506_10
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_14 = math.max(var_506_7, arg_503_1.talkMaxDuration)

			if var_506_6 <= arg_503_1.time_ and arg_503_1.time_ < var_506_6 + var_506_14 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_6) / var_506_14

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_6 + var_506_14 and arg_503_1.time_ < var_506_6 + var_506_14 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1108504121 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1108504121
		arg_507_1.duration_ = 6.47

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1108504122(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 0
			local var_510_1 = 0.325

			if var_510_0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_2 = arg_507_1:FormatText(StoryNameCfg[328].name)

				arg_507_1.leftNameTxt_.text = var_510_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_3 = arg_507_1:GetWordFromCfg(1108504121)
				local var_510_4 = arg_507_1:FormatText(var_510_3.content)

				arg_507_1.text_.text = var_510_4

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 13
				local var_510_6 = utf8.len(var_510_4)
				local var_510_7 = var_510_5 <= 0 and var_510_1 or var_510_1 * (var_510_6 / var_510_5)

				if var_510_7 > 0 and var_510_1 < var_510_7 then
					arg_507_1.talkMaxDuration = var_510_7

					if var_510_7 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_7 + var_510_0
					end
				end

				arg_507_1.text_.text = var_510_4
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504121", "story_v_side_new_1108504.awb") ~= 0 then
					local var_510_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504121", "story_v_side_new_1108504.awb") / 1000

					if var_510_8 + var_510_0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_8 + var_510_0
					end

					if var_510_3.prefab_name ~= "" and arg_507_1.actors_[var_510_3.prefab_name] ~= nil then
						local var_510_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_3.prefab_name].transform, "story_v_side_new_1108504", "1108504121", "story_v_side_new_1108504.awb")

						arg_507_1:RecordAudio("1108504121", var_510_9)
						arg_507_1:RecordAudio("1108504121", var_510_9)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504121", "story_v_side_new_1108504.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504121", "story_v_side_new_1108504.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_10 = math.max(var_510_1, arg_507_1.talkMaxDuration)

			if var_510_0 <= arg_507_1.time_ and arg_507_1.time_ < var_510_0 + var_510_10 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_0) / var_510_10

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_0 + var_510_10 and arg_507_1.time_ < var_510_0 + var_510_10 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play1108504122 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1108504122
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1108504123(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1085ui_story"]
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.characterEffect1085ui_story == nil then
				arg_511_1.var_.characterEffect1085ui_story = var_514_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_2 = 0.200000002980232

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 and not isNil(var_514_0) then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2

				if arg_511_1.var_.characterEffect1085ui_story and not isNil(var_514_0) then
					local var_514_4 = Mathf.Lerp(0, 0.5, var_514_3)

					arg_511_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_511_1.var_.characterEffect1085ui_story.fillRatio = var_514_4
				end
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.characterEffect1085ui_story then
				local var_514_5 = 0.5

				arg_511_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_511_1.var_.characterEffect1085ui_story.fillRatio = var_514_5
			end

			local var_514_6 = 0
			local var_514_7 = 0.225

			if var_514_6 < arg_511_1.time_ and arg_511_1.time_ <= var_514_6 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_8 = arg_511_1:FormatText(StoryNameCfg[7].name)

				arg_511_1.leftNameTxt_.text = var_514_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_9 = arg_511_1:GetWordFromCfg(1108504122)
				local var_514_10 = arg_511_1:FormatText(var_514_9.content)

				arg_511_1.text_.text = var_514_10

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_11 = 9
				local var_514_12 = utf8.len(var_514_10)
				local var_514_13 = var_514_11 <= 0 and var_514_7 or var_514_7 * (var_514_12 / var_514_11)

				if var_514_13 > 0 and var_514_7 < var_514_13 then
					arg_511_1.talkMaxDuration = var_514_13

					if var_514_13 + var_514_6 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_13 + var_514_6
					end
				end

				arg_511_1.text_.text = var_514_10
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_14 = math.max(var_514_7, arg_511_1.talkMaxDuration)

			if var_514_6 <= arg_511_1.time_ and arg_511_1.time_ < var_514_6 + var_514_14 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_6) / var_514_14

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_6 + var_514_14 and arg_511_1.time_ < var_514_6 + var_514_14 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1108504123 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1108504123
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1108504124(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1085ui_story"].transform
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.var_.moveOldPos1085ui_story = var_518_0.localPosition
			end

			local var_518_2 = 0.001

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2
				local var_518_4 = Vector3.New(0, 100, 0)

				var_518_0.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1085ui_story, var_518_4, var_518_3)

				local var_518_5 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_5.x, var_518_5.y, var_518_5.z)

				local var_518_6 = var_518_0.localEulerAngles

				var_518_6.z = 0
				var_518_6.x = 0
				var_518_0.localEulerAngles = var_518_6
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 then
				var_518_0.localPosition = Vector3.New(0, 100, 0)

				local var_518_7 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_7.x, var_518_7.y, var_518_7.z)

				local var_518_8 = var_518_0.localEulerAngles

				var_518_8.z = 0
				var_518_8.x = 0
				var_518_0.localEulerAngles = var_518_8
			end

			local var_518_9 = 0
			local var_518_10 = 0.975

			if var_518_9 < arg_515_1.time_ and arg_515_1.time_ <= var_518_9 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, false)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_11 = arg_515_1:GetWordFromCfg(1108504123)
				local var_518_12 = arg_515_1:FormatText(var_518_11.content)

				arg_515_1.text_.text = var_518_12

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_13 = 39
				local var_518_14 = utf8.len(var_518_12)
				local var_518_15 = var_518_13 <= 0 and var_518_10 or var_518_10 * (var_518_14 / var_518_13)

				if var_518_15 > 0 and var_518_10 < var_518_15 then
					arg_515_1.talkMaxDuration = var_518_15

					if var_518_15 + var_518_9 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_15 + var_518_9
					end
				end

				arg_515_1.text_.text = var_518_12
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_16 = math.max(var_518_10, arg_515_1.talkMaxDuration)

			if var_518_9 <= arg_515_1.time_ and arg_515_1.time_ < var_518_9 + var_518_16 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_9) / var_518_16

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_9 + var_518_16 and arg_515_1.time_ < var_518_9 + var_518_16 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play1108504124 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1108504124
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1108504125(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0
			local var_522_1 = 0.65

			if var_522_0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_2 = arg_519_1:FormatText(StoryNameCfg[7].name)

				arg_519_1.leftNameTxt_.text = var_522_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_3 = arg_519_1:GetWordFromCfg(1108504124)
				local var_522_4 = arg_519_1:FormatText(var_522_3.content)

				arg_519_1.text_.text = var_522_4

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_5 = 26
				local var_522_6 = utf8.len(var_522_4)
				local var_522_7 = var_522_5 <= 0 and var_522_1 or var_522_1 * (var_522_6 / var_522_5)

				if var_522_7 > 0 and var_522_1 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_4
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_8 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_8 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_8

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_8 and arg_519_1.time_ < var_522_0 + var_522_8 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1108504125 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1108504125
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1108504126(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0
			local var_526_1 = 0.15

			if var_526_0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_2 = arg_523_1:FormatText(StoryNameCfg[7].name)

				arg_523_1.leftNameTxt_.text = var_526_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_3 = arg_523_1:GetWordFromCfg(1108504125)
				local var_526_4 = arg_523_1:FormatText(var_526_3.content)

				arg_523_1.text_.text = var_526_4

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 6
				local var_526_6 = utf8.len(var_526_4)
				local var_526_7 = var_526_5 <= 0 and var_526_1 or var_526_1 * (var_526_6 / var_526_5)

				if var_526_7 > 0 and var_526_1 < var_526_7 then
					arg_523_1.talkMaxDuration = var_526_7

					if var_526_7 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_7 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_4
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_8 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_8 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_8

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_8 and arg_523_1.time_ < var_526_0 + var_526_8 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1108504126 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1108504126
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1108504127(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0
			local var_530_1 = 0.775

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_2 = arg_527_1:GetWordFromCfg(1108504126)
				local var_530_3 = arg_527_1:FormatText(var_530_2.content)

				arg_527_1.text_.text = var_530_3

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_4 = 31
				local var_530_5 = utf8.len(var_530_3)
				local var_530_6 = var_530_4 <= 0 and var_530_1 or var_530_1 * (var_530_5 / var_530_4)

				if var_530_6 > 0 and var_530_1 < var_530_6 then
					arg_527_1.talkMaxDuration = var_530_6

					if var_530_6 + var_530_0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_6 + var_530_0
					end
				end

				arg_527_1.text_.text = var_530_3
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_1, arg_527_1.talkMaxDuration)

			if var_530_0 <= arg_527_1.time_ and arg_527_1.time_ < var_530_0 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_0) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_0 + var_530_7 and arg_527_1.time_ < var_530_0 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1108504127 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1108504127
		arg_531_1.duration_ = 9.83

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1108504128(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = "R8501a"

			if arg_531_1.bgs_[var_534_0] == nil then
				local var_534_1 = Object.Instantiate(arg_531_1.paintGo_)

				var_534_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_534_0)
				var_534_1.name = var_534_0
				var_534_1.transform.parent = arg_531_1.stage_.transform
				var_534_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_531_1.bgs_[var_534_0] = var_534_1
			end

			local var_534_2 = 1.16666666666667

			if var_534_2 < arg_531_1.time_ and arg_531_1.time_ <= var_534_2 + arg_534_0 then
				local var_534_3 = manager.ui.mainCamera.transform.localPosition
				local var_534_4 = Vector3.New(0, 0, 10) + Vector3.New(var_534_3.x, var_534_3.y, 0)
				local var_534_5 = arg_531_1.bgs_.R8501a

				var_534_5.transform.localPosition = var_534_4
				var_534_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_534_6 = var_534_5:GetComponent("SpriteRenderer")

				if var_534_6 and var_534_6.sprite then
					local var_534_7 = (var_534_5.transform.localPosition - var_534_3).z
					local var_534_8 = manager.ui.mainCameraCom_
					local var_534_9 = 2 * var_534_7 * Mathf.Tan(var_534_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_534_10 = var_534_9 * var_534_8.aspect
					local var_534_11 = var_534_6.sprite.bounds.size.x
					local var_534_12 = var_534_6.sprite.bounds.size.y
					local var_534_13 = var_534_10 / var_534_11
					local var_534_14 = var_534_9 / var_534_12
					local var_534_15 = var_534_14 < var_534_13 and var_534_13 or var_534_14

					var_534_5.transform.localScale = Vector3.New(var_534_15, var_534_15, 0)
				end

				for iter_534_0, iter_534_1 in pairs(arg_531_1.bgs_) do
					if iter_534_0 ~= "R8501a" then
						iter_534_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_534_16 = 2.05833333333333

			if var_534_16 < arg_531_1.time_ and arg_531_1.time_ <= var_534_16 + arg_534_0 then
				arg_531_1.allBtn_.enabled = false
			end

			local var_534_17 = 0.3

			if arg_531_1.time_ >= var_534_16 + var_534_17 and arg_531_1.time_ < var_534_16 + var_534_17 + arg_534_0 then
				arg_531_1.allBtn_.enabled = true
			end

			local var_534_18 = manager.ui.mainCamera.transform
			local var_534_19 = 0

			if var_534_19 < arg_531_1.time_ and arg_531_1.time_ <= var_534_19 + arg_534_0 then
				local var_534_20 = arg_531_1.var_.effectyewanzhuanchang1
				local var_534_21
				local var_534_22 = var_534_18

				if not var_534_20 then
					var_534_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_in_keep"), var_534_22)
					var_534_20.name = "yewanzhuanchang1"
					arg_531_1.var_.effectyewanzhuanchang1 = var_534_20
				else
					var_534_20.transform:SetParent(var_534_22)
				end

				var_534_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_534_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_534_23 = manager.ui.mainCamera.transform
			local var_534_24 = 1.4

			if var_534_24 < arg_531_1.time_ and arg_531_1.time_ <= var_534_24 + arg_534_0 then
				local var_534_25 = arg_531_1.var_.effectyewanzhuanchang1

				if var_534_25 then
					Object.Destroy(var_534_25)

					arg_531_1.var_.effectyewanzhuanchang1 = nil
				end
			end

			local var_534_26 = manager.ui.mainCamera.transform
			local var_534_27 = 1.4

			if var_534_27 < arg_531_1.time_ and arg_531_1.time_ <= var_534_27 + arg_534_0 then
				local var_534_28 = arg_531_1.var_.effectyewanzhuanchang2
				local var_534_29
				local var_534_30 = var_534_26

				if not var_534_28 then
					var_534_28 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_night_out"), var_534_30)
					var_534_28.name = "yewanzhuanchang2"
					arg_531_1.var_.effectyewanzhuanchang2 = var_534_28
				else
					var_534_28.transform:SetParent(var_534_30)
				end

				var_534_28.transform.localPosition = Vector3.New(0, 0, 0)
				var_534_28.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_534_31 = arg_531_1.bgs_.R8501a.transform
			local var_534_32 = 1.16666666666667

			if var_534_32 < arg_531_1.time_ and arg_531_1.time_ <= var_534_32 + arg_534_0 then
				arg_531_1.var_.moveOldPosR8501a = var_534_31.localPosition
			end

			local var_534_33 = 2.71666666666667

			if var_534_32 <= arg_531_1.time_ and arg_531_1.time_ < var_534_32 + var_534_33 then
				local var_534_34 = (arg_531_1.time_ - var_534_32) / var_534_33
				local var_534_35 = Vector3.New(0, 1, 10)

				var_534_31.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPosR8501a, var_534_35, var_534_34)
			end

			if arg_531_1.time_ >= var_534_32 + var_534_33 and arg_531_1.time_ < var_534_32 + var_534_33 + arg_534_0 then
				var_534_31.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_531_1.frameCnt_ <= 1 then
				arg_531_1.dialog_:SetActive(false)
			end

			local var_534_36 = 2.03333333333333
			local var_534_37 = 0.325

			if var_534_36 < arg_531_1.time_ and arg_531_1.time_ <= var_534_36 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0

				arg_531_1.dialog_:SetActive(true)

				arg_531_1.dialogCg_.alpha = 0

				local var_534_38 = LeanTween.value(arg_531_1.dialog_, 0, 1, 0.3)

				var_534_38:setOnUpdate(LuaHelper.FloatAction(function(arg_535_0)
					arg_531_1.dialogCg_.alpha = arg_535_0
				end))
				var_534_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_531_1.dialog_)
					var_534_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_531_1.duration_ = arg_531_1.duration_ + 0.3

				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_39 = arg_531_1:FormatText(StoryNameCfg[328].name)

				arg_531_1.leftNameTxt_.text = var_534_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_40 = arg_531_1:GetWordFromCfg(1108504127)
				local var_534_41 = arg_531_1:FormatText(var_534_40.content)

				arg_531_1.text_.text = var_534_41

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_42 = 13
				local var_534_43 = utf8.len(var_534_41)
				local var_534_44 = var_534_42 <= 0 and var_534_37 or var_534_37 * (var_534_43 / var_534_42)

				if var_534_44 > 0 and var_534_37 < var_534_44 then
					arg_531_1.talkMaxDuration = var_534_44
					var_534_36 = var_534_36 + 0.3

					if var_534_44 + var_534_36 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_44 + var_534_36
					end
				end

				arg_531_1.text_.text = var_534_41
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504127", "story_v_side_new_1108504.awb") ~= 0 then
					local var_534_45 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504127", "story_v_side_new_1108504.awb") / 1000

					if var_534_45 + var_534_36 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_45 + var_534_36
					end

					if var_534_40.prefab_name ~= "" and arg_531_1.actors_[var_534_40.prefab_name] ~= nil then
						local var_534_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_40.prefab_name].transform, "story_v_side_new_1108504", "1108504127", "story_v_side_new_1108504.awb")

						arg_531_1:RecordAudio("1108504127", var_534_46)
						arg_531_1:RecordAudio("1108504127", var_534_46)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504127", "story_v_side_new_1108504.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504127", "story_v_side_new_1108504.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_47 = var_534_36 + 0.3
			local var_534_48 = math.max(var_534_37, arg_531_1.talkMaxDuration)

			if var_534_47 <= arg_531_1.time_ and arg_531_1.time_ < var_534_47 + var_534_48 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_47) / var_534_48

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_47 + var_534_48 and arg_531_1.time_ < var_534_47 + var_534_48 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R8501a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.71666666666667,
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play1108504128 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 1108504128
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play1108504129(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0
			local var_540_1 = 0.5

			if var_540_0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_2 = arg_537_1:FormatText(StoryNameCfg[7].name)

				arg_537_1.leftNameTxt_.text = var_540_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, true)
				arg_537_1.iconController_:SetSelectedState("hero")

				arg_537_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_537_1.callingController_:SetSelectedState("normal")

				arg_537_1.keyicon_.color = Color.New(1, 1, 1)
				arg_537_1.icon_.color = Color.New(1, 1, 1)

				local var_540_3 = arg_537_1:GetWordFromCfg(1108504128)
				local var_540_4 = arg_537_1:FormatText(var_540_3.content)

				arg_537_1.text_.text = var_540_4

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_5 = 20
				local var_540_6 = utf8.len(var_540_4)
				local var_540_7 = var_540_5 <= 0 and var_540_1 or var_540_1 * (var_540_6 / var_540_5)

				if var_540_7 > 0 and var_540_1 < var_540_7 then
					arg_537_1.talkMaxDuration = var_540_7

					if var_540_7 + var_540_0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_7 + var_540_0
					end
				end

				arg_537_1.text_.text = var_540_4
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_8 = math.max(var_540_1, arg_537_1.talkMaxDuration)

			if var_540_0 <= arg_537_1.time_ and arg_537_1.time_ < var_540_0 + var_540_8 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_0) / var_540_8

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_0 + var_540_8 and arg_537_1.time_ < var_540_0 + var_540_8 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play1108504129 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 1108504129
		arg_541_1.duration_ = 4.73

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play1108504130(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = 0
			local var_544_1 = 0.325

			if var_544_0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_0 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_2 = arg_541_1:FormatText(StoryNameCfg[328].name)

				arg_541_1.leftNameTxt_.text = var_544_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_3 = arg_541_1:GetWordFromCfg(1108504129)
				local var_544_4 = arg_541_1:FormatText(var_544_3.content)

				arg_541_1.text_.text = var_544_4

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_5 = 13
				local var_544_6 = utf8.len(var_544_4)
				local var_544_7 = var_544_5 <= 0 and var_544_1 or var_544_1 * (var_544_6 / var_544_5)

				if var_544_7 > 0 and var_544_1 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_0
					end
				end

				arg_541_1.text_.text = var_544_4
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504129", "story_v_side_new_1108504.awb") ~= 0 then
					local var_544_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504129", "story_v_side_new_1108504.awb") / 1000

					if var_544_8 + var_544_0 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_8 + var_544_0
					end

					if var_544_3.prefab_name ~= "" and arg_541_1.actors_[var_544_3.prefab_name] ~= nil then
						local var_544_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_3.prefab_name].transform, "story_v_side_new_1108504", "1108504129", "story_v_side_new_1108504.awb")

						arg_541_1:RecordAudio("1108504129", var_544_9)
						arg_541_1:RecordAudio("1108504129", var_544_9)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504129", "story_v_side_new_1108504.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504129", "story_v_side_new_1108504.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_10 = math.max(var_544_1, arg_541_1.talkMaxDuration)

			if var_544_0 <= arg_541_1.time_ and arg_541_1.time_ < var_544_0 + var_544_10 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_0) / var_544_10

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_0 + var_544_10 and arg_541_1.time_ < var_544_0 + var_544_10 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play1108504130 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 1108504130
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play1108504131(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0
			local var_548_1 = 0.85

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, false)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_2 = arg_545_1:GetWordFromCfg(1108504130)
				local var_548_3 = arg_545_1:FormatText(var_548_2.content)

				arg_545_1.text_.text = var_548_3

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_4 = 34
				local var_548_5 = utf8.len(var_548_3)
				local var_548_6 = var_548_4 <= 0 and var_548_1 or var_548_1 * (var_548_5 / var_548_4)

				if var_548_6 > 0 and var_548_1 < var_548_6 then
					arg_545_1.talkMaxDuration = var_548_6

					if var_548_6 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_6 + var_548_0
					end
				end

				arg_545_1.text_.text = var_548_3
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_7 = math.max(var_548_1, arg_545_1.talkMaxDuration)

			if var_548_0 <= arg_545_1.time_ and arg_545_1.time_ < var_548_0 + var_548_7 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_0) / var_548_7

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_0 + var_548_7 and arg_545_1.time_ < var_548_0 + var_548_7 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play1108504131 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 1108504131
		arg_549_1.duration_ = 5.13

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play1108504132(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0
			local var_552_1 = 0.325

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_2 = arg_549_1:FormatText(StoryNameCfg[328].name)

				arg_549_1.leftNameTxt_.text = var_552_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_3 = arg_549_1:GetWordFromCfg(1108504131)
				local var_552_4 = arg_549_1:FormatText(var_552_3.content)

				arg_549_1.text_.text = var_552_4

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 13
				local var_552_6 = utf8.len(var_552_4)
				local var_552_7 = var_552_5 <= 0 and var_552_1 or var_552_1 * (var_552_6 / var_552_5)

				if var_552_7 > 0 and var_552_1 < var_552_7 then
					arg_549_1.talkMaxDuration = var_552_7

					if var_552_7 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_7 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_4
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504131", "story_v_side_new_1108504.awb") ~= 0 then
					local var_552_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504131", "story_v_side_new_1108504.awb") / 1000

					if var_552_8 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_8 + var_552_0
					end

					if var_552_3.prefab_name ~= "" and arg_549_1.actors_[var_552_3.prefab_name] ~= nil then
						local var_552_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_3.prefab_name].transform, "story_v_side_new_1108504", "1108504131", "story_v_side_new_1108504.awb")

						arg_549_1:RecordAudio("1108504131", var_552_9)
						arg_549_1:RecordAudio("1108504131", var_552_9)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504131", "story_v_side_new_1108504.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504131", "story_v_side_new_1108504.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_10 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_10 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_10

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_10 and arg_549_1.time_ < var_552_0 + var_552_10 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play1108504132 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 1108504132
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play1108504133(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = 0
			local var_556_1 = 0.225

			if var_556_0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_0 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				local var_556_2 = arg_553_1:FormatText(StoryNameCfg[7].name)

				arg_553_1.leftNameTxt_.text = var_556_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, true)
				arg_553_1.iconController_:SetSelectedState("hero")

				arg_553_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_553_1.callingController_:SetSelectedState("normal")

				arg_553_1.keyicon_.color = Color.New(1, 1, 1)
				arg_553_1.icon_.color = Color.New(1, 1, 1)

				local var_556_3 = arg_553_1:GetWordFromCfg(1108504132)
				local var_556_4 = arg_553_1:FormatText(var_556_3.content)

				arg_553_1.text_.text = var_556_4

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_5 = 9
				local var_556_6 = utf8.len(var_556_4)
				local var_556_7 = var_556_5 <= 0 and var_556_1 or var_556_1 * (var_556_6 / var_556_5)

				if var_556_7 > 0 and var_556_1 < var_556_7 then
					arg_553_1.talkMaxDuration = var_556_7

					if var_556_7 + var_556_0 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_7 + var_556_0
					end
				end

				arg_553_1.text_.text = var_556_4
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_8 = math.max(var_556_1, arg_553_1.talkMaxDuration)

			if var_556_0 <= arg_553_1.time_ and arg_553_1.time_ < var_556_0 + var_556_8 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_0) / var_556_8

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_0 + var_556_8 and arg_553_1.time_ < var_556_0 + var_556_8 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play1108504133 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 1108504133
		arg_557_1.duration_ = 10.57

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play1108504134(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = 0
			local var_560_1 = 0.675

			if var_560_0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_0 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_2 = arg_557_1:FormatText(StoryNameCfg[328].name)

				arg_557_1.leftNameTxt_.text = var_560_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_3 = arg_557_1:GetWordFromCfg(1108504133)
				local var_560_4 = arg_557_1:FormatText(var_560_3.content)

				arg_557_1.text_.text = var_560_4

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_5 = 27
				local var_560_6 = utf8.len(var_560_4)
				local var_560_7 = var_560_5 <= 0 and var_560_1 or var_560_1 * (var_560_6 / var_560_5)

				if var_560_7 > 0 and var_560_1 < var_560_7 then
					arg_557_1.talkMaxDuration = var_560_7

					if var_560_7 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_7 + var_560_0
					end
				end

				arg_557_1.text_.text = var_560_4
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504133", "story_v_side_new_1108504.awb") ~= 0 then
					local var_560_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504133", "story_v_side_new_1108504.awb") / 1000

					if var_560_8 + var_560_0 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_8 + var_560_0
					end

					if var_560_3.prefab_name ~= "" and arg_557_1.actors_[var_560_3.prefab_name] ~= nil then
						local var_560_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_3.prefab_name].transform, "story_v_side_new_1108504", "1108504133", "story_v_side_new_1108504.awb")

						arg_557_1:RecordAudio("1108504133", var_560_9)
						arg_557_1:RecordAudio("1108504133", var_560_9)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504133", "story_v_side_new_1108504.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504133", "story_v_side_new_1108504.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_10 = math.max(var_560_1, arg_557_1.talkMaxDuration)

			if var_560_0 <= arg_557_1.time_ and arg_557_1.time_ < var_560_0 + var_560_10 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_0) / var_560_10

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_0 + var_560_10 and arg_557_1.time_ < var_560_0 + var_560_10 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play1108504134 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 1108504134
		arg_561_1.duration_ = 3.97

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play1108504135(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = 0
			local var_564_1 = 0.3

			if var_564_0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_0 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_2 = arg_561_1:FormatText(StoryNameCfg[328].name)

				arg_561_1.leftNameTxt_.text = var_564_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_3 = arg_561_1:GetWordFromCfg(1108504134)
				local var_564_4 = arg_561_1:FormatText(var_564_3.content)

				arg_561_1.text_.text = var_564_4

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_5 = 12
				local var_564_6 = utf8.len(var_564_4)
				local var_564_7 = var_564_5 <= 0 and var_564_1 or var_564_1 * (var_564_6 / var_564_5)

				if var_564_7 > 0 and var_564_1 < var_564_7 then
					arg_561_1.talkMaxDuration = var_564_7

					if var_564_7 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_7 + var_564_0
					end
				end

				arg_561_1.text_.text = var_564_4
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504134", "story_v_side_new_1108504.awb") ~= 0 then
					local var_564_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504134", "story_v_side_new_1108504.awb") / 1000

					if var_564_8 + var_564_0 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_8 + var_564_0
					end

					if var_564_3.prefab_name ~= "" and arg_561_1.actors_[var_564_3.prefab_name] ~= nil then
						local var_564_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_3.prefab_name].transform, "story_v_side_new_1108504", "1108504134", "story_v_side_new_1108504.awb")

						arg_561_1:RecordAudio("1108504134", var_564_9)
						arg_561_1:RecordAudio("1108504134", var_564_9)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504134", "story_v_side_new_1108504.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504134", "story_v_side_new_1108504.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_10 = math.max(var_564_1, arg_561_1.talkMaxDuration)

			if var_564_0 <= arg_561_1.time_ and arg_561_1.time_ < var_564_0 + var_564_10 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_0) / var_564_10

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_0 + var_564_10 and arg_561_1.time_ < var_564_0 + var_564_10 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play1108504135 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1108504135
		arg_565_1.duration_ = 1

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"

			SetActive(arg_565_1.choicesGo_, true)

			for iter_566_0, iter_566_1 in ipairs(arg_565_1.choices_) do
				local var_566_0 = iter_566_0 <= 2

				SetActive(iter_566_1.go, var_566_0)
			end

			arg_565_1.choices_[1].txt.text = arg_565_1:FormatText(StoryChoiceCfg[1638].name)
			arg_565_1.choices_[2].txt.text = arg_565_1:FormatText(StoryChoiceCfg[1639].name)
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1108504136(arg_565_1)
			end

			if arg_567_0 == 2 then
				arg_565_0:Play1108504138(arg_565_1)
			end

			arg_565_1:RecordChoiceLog(1108504135, 1638, 1639)
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = 0

			if var_568_0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_0 + arg_568_0 then
				arg_565_1.allBtn_.enabled = false
			end

			local var_568_1 = 0.6

			if arg_565_1.time_ >= var_568_0 + var_568_1 and arg_565_1.time_ < var_568_0 + var_568_1 + arg_568_0 then
				arg_565_1.allBtn_.enabled = true
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play1108504136 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1108504136
		arg_569_1.duration_ = 4.23

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1108504137(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0
			local var_572_1 = 0.3

			if var_572_0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_2 = arg_569_1:FormatText(StoryNameCfg[328].name)

				arg_569_1.leftNameTxt_.text = var_572_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_3 = arg_569_1:GetWordFromCfg(1108504136)
				local var_572_4 = arg_569_1:FormatText(var_572_3.content)

				arg_569_1.text_.text = var_572_4

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_5 = 12
				local var_572_6 = utf8.len(var_572_4)
				local var_572_7 = var_572_5 <= 0 and var_572_1 or var_572_1 * (var_572_6 / var_572_5)

				if var_572_7 > 0 and var_572_1 < var_572_7 then
					arg_569_1.talkMaxDuration = var_572_7

					if var_572_7 + var_572_0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_7 + var_572_0
					end
				end

				arg_569_1.text_.text = var_572_4
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504136", "story_v_side_new_1108504.awb") ~= 0 then
					local var_572_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504136", "story_v_side_new_1108504.awb") / 1000

					if var_572_8 + var_572_0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_8 + var_572_0
					end

					if var_572_3.prefab_name ~= "" and arg_569_1.actors_[var_572_3.prefab_name] ~= nil then
						local var_572_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_3.prefab_name].transform, "story_v_side_new_1108504", "1108504136", "story_v_side_new_1108504.awb")

						arg_569_1:RecordAudio("1108504136", var_572_9)
						arg_569_1:RecordAudio("1108504136", var_572_9)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504136", "story_v_side_new_1108504.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504136", "story_v_side_new_1108504.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_10 = math.max(var_572_1, arg_569_1.talkMaxDuration)

			if var_572_0 <= arg_569_1.time_ and arg_569_1.time_ < var_572_0 + var_572_10 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_0) / var_572_10

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_0 + var_572_10 and arg_569_1.time_ < var_572_0 + var_572_10 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play1108504137 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1108504137
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1108504140(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0
			local var_576_1 = 0.25

			if var_576_0 < arg_573_1.time_ and arg_573_1.time_ <= var_576_0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_2 = arg_573_1:FormatText(StoryNameCfg[7].name)

				arg_573_1.leftNameTxt_.text = var_576_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, true)
				arg_573_1.iconController_:SetSelectedState("hero")

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_3 = arg_573_1:GetWordFromCfg(1108504137)
				local var_576_4 = arg_573_1:FormatText(var_576_3.content)

				arg_573_1.text_.text = var_576_4

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_5 = 10
				local var_576_6 = utf8.len(var_576_4)
				local var_576_7 = var_576_5 <= 0 and var_576_1 or var_576_1 * (var_576_6 / var_576_5)

				if var_576_7 > 0 and var_576_1 < var_576_7 then
					arg_573_1.talkMaxDuration = var_576_7

					if var_576_7 + var_576_0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_7 + var_576_0
					end
				end

				arg_573_1.text_.text = var_576_4
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_8 = math.max(var_576_1, arg_573_1.talkMaxDuration)

			if var_576_0 <= arg_573_1.time_ and arg_573_1.time_ < var_576_0 + var_576_8 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_0) / var_576_8

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_0 + var_576_8 and arg_573_1.time_ < var_576_0 + var_576_8 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play1108504140 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1108504140
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1108504141(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = 0
			local var_580_1 = 0.45

			if var_580_0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_0 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_2 = arg_577_1:GetWordFromCfg(1108504140)
				local var_580_3 = arg_577_1:FormatText(var_580_2.content)

				arg_577_1.text_.text = var_580_3

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_4 = 18
				local var_580_5 = utf8.len(var_580_3)
				local var_580_6 = var_580_4 <= 0 and var_580_1 or var_580_1 * (var_580_5 / var_580_4)

				if var_580_6 > 0 and var_580_1 < var_580_6 then
					arg_577_1.talkMaxDuration = var_580_6

					if var_580_6 + var_580_0 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_6 + var_580_0
					end
				end

				arg_577_1.text_.text = var_580_3
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_7 = math.max(var_580_1, arg_577_1.talkMaxDuration)

			if var_580_0 <= arg_577_1.time_ and arg_577_1.time_ < var_580_0 + var_580_7 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_0) / var_580_7

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_0 + var_580_7 and arg_577_1.time_ < var_580_0 + var_580_7 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play1108504141 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1108504141
		arg_581_1.duration_ = 2.73

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1108504142(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = 0
			local var_584_1 = 0.2

			if var_584_0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_0 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_2 = arg_581_1:FormatText(StoryNameCfg[328].name)

				arg_581_1.leftNameTxt_.text = var_584_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_3 = arg_581_1:GetWordFromCfg(1108504141)
				local var_584_4 = arg_581_1:FormatText(var_584_3.content)

				arg_581_1.text_.text = var_584_4

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_5 = 8
				local var_584_6 = utf8.len(var_584_4)
				local var_584_7 = var_584_5 <= 0 and var_584_1 or var_584_1 * (var_584_6 / var_584_5)

				if var_584_7 > 0 and var_584_1 < var_584_7 then
					arg_581_1.talkMaxDuration = var_584_7

					if var_584_7 + var_584_0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_7 + var_584_0
					end
				end

				arg_581_1.text_.text = var_584_4
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504141", "story_v_side_new_1108504.awb") ~= 0 then
					local var_584_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504141", "story_v_side_new_1108504.awb") / 1000

					if var_584_8 + var_584_0 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_8 + var_584_0
					end

					if var_584_3.prefab_name ~= "" and arg_581_1.actors_[var_584_3.prefab_name] ~= nil then
						local var_584_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_3.prefab_name].transform, "story_v_side_new_1108504", "1108504141", "story_v_side_new_1108504.awb")

						arg_581_1:RecordAudio("1108504141", var_584_9)
						arg_581_1:RecordAudio("1108504141", var_584_9)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504141", "story_v_side_new_1108504.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504141", "story_v_side_new_1108504.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_10 = math.max(var_584_1, arg_581_1.talkMaxDuration)

			if var_584_0 <= arg_581_1.time_ and arg_581_1.time_ < var_584_0 + var_584_10 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_0) / var_584_10

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_0 + var_584_10 and arg_581_1.time_ < var_584_0 + var_584_10 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play1108504142 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1108504142
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1108504143(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0
			local var_588_1 = 0.45

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				local var_588_2 = arg_585_1:FormatText(StoryNameCfg[7].name)

				arg_585_1.leftNameTxt_.text = var_588_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, true)
				arg_585_1.iconController_:SetSelectedState("hero")

				arg_585_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_585_1.callingController_:SetSelectedState("normal")

				arg_585_1.keyicon_.color = Color.New(1, 1, 1)
				arg_585_1.icon_.color = Color.New(1, 1, 1)

				local var_588_3 = arg_585_1:GetWordFromCfg(1108504142)
				local var_588_4 = arg_585_1:FormatText(var_588_3.content)

				arg_585_1.text_.text = var_588_4

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_5 = 18
				local var_588_6 = utf8.len(var_588_4)
				local var_588_7 = var_588_5 <= 0 and var_588_1 or var_588_1 * (var_588_6 / var_588_5)

				if var_588_7 > 0 and var_588_1 < var_588_7 then
					arg_585_1.talkMaxDuration = var_588_7

					if var_588_7 + var_588_0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_7 + var_588_0
					end
				end

				arg_585_1.text_.text = var_588_4
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_8 = math.max(var_588_1, arg_585_1.talkMaxDuration)

			if var_588_0 <= arg_585_1.time_ and arg_585_1.time_ < var_588_0 + var_588_8 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_0) / var_588_8

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_0 + var_588_8 and arg_585_1.time_ < var_588_0 + var_588_8 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play1108504143 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1108504143
		arg_589_1.duration_ = 7.87

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1108504144(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0
			local var_592_1 = 0.475

			if var_592_0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				local var_592_2 = arg_589_1:FormatText(StoryNameCfg[328].name)

				arg_589_1.leftNameTxt_.text = var_592_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_3 = arg_589_1:GetWordFromCfg(1108504143)
				local var_592_4 = arg_589_1:FormatText(var_592_3.content)

				arg_589_1.text_.text = var_592_4

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_5 = 19
				local var_592_6 = utf8.len(var_592_4)
				local var_592_7 = var_592_5 <= 0 and var_592_1 or var_592_1 * (var_592_6 / var_592_5)

				if var_592_7 > 0 and var_592_1 < var_592_7 then
					arg_589_1.talkMaxDuration = var_592_7

					if var_592_7 + var_592_0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_7 + var_592_0
					end
				end

				arg_589_1.text_.text = var_592_4
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504143", "story_v_side_new_1108504.awb") ~= 0 then
					local var_592_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504143", "story_v_side_new_1108504.awb") / 1000

					if var_592_8 + var_592_0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_8 + var_592_0
					end

					if var_592_3.prefab_name ~= "" and arg_589_1.actors_[var_592_3.prefab_name] ~= nil then
						local var_592_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_3.prefab_name].transform, "story_v_side_new_1108504", "1108504143", "story_v_side_new_1108504.awb")

						arg_589_1:RecordAudio("1108504143", var_592_9)
						arg_589_1:RecordAudio("1108504143", var_592_9)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504143", "story_v_side_new_1108504.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504143", "story_v_side_new_1108504.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_10 = math.max(var_592_1, arg_589_1.talkMaxDuration)

			if var_592_0 <= arg_589_1.time_ and arg_589_1.time_ < var_592_0 + var_592_10 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_0) / var_592_10

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_0 + var_592_10 and arg_589_1.time_ < var_592_0 + var_592_10 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play1108504144 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1108504144
		arg_593_1.duration_ = 5

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1108504145(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0
			local var_596_1 = 0.625

			if var_596_0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, false)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_2 = arg_593_1:GetWordFromCfg(1108504144)
				local var_596_3 = arg_593_1:FormatText(var_596_2.content)

				arg_593_1.text_.text = var_596_3

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_4 = 25
				local var_596_5 = utf8.len(var_596_3)
				local var_596_6 = var_596_4 <= 0 and var_596_1 or var_596_1 * (var_596_5 / var_596_4)

				if var_596_6 > 0 and var_596_1 < var_596_6 then
					arg_593_1.talkMaxDuration = var_596_6

					if var_596_6 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_6 + var_596_0
					end
				end

				arg_593_1.text_.text = var_596_3
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)
				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_7 = math.max(var_596_1, arg_593_1.talkMaxDuration)

			if var_596_0 <= arg_593_1.time_ and arg_593_1.time_ < var_596_0 + var_596_7 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_0) / var_596_7

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_0 + var_596_7 and arg_593_1.time_ < var_596_0 + var_596_7 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play1108504145 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1108504145
		arg_597_1.duration_ = 9

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1108504146(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 2

			if var_600_0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				local var_600_1 = manager.ui.mainCamera.transform.localPosition
				local var_600_2 = Vector3.New(0, 0, 10) + Vector3.New(var_600_1.x, var_600_1.y, 0)
				local var_600_3 = arg_597_1.bgs_.ST12a

				var_600_3.transform.localPosition = var_600_2
				var_600_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_600_4 = var_600_3:GetComponent("SpriteRenderer")

				if var_600_4 and var_600_4.sprite then
					local var_600_5 = (var_600_3.transform.localPosition - var_600_1).z
					local var_600_6 = manager.ui.mainCameraCom_
					local var_600_7 = 2 * var_600_5 * Mathf.Tan(var_600_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_600_8 = var_600_7 * var_600_6.aspect
					local var_600_9 = var_600_4.sprite.bounds.size.x
					local var_600_10 = var_600_4.sprite.bounds.size.y
					local var_600_11 = var_600_8 / var_600_9
					local var_600_12 = var_600_7 / var_600_10
					local var_600_13 = var_600_12 < var_600_11 and var_600_11 or var_600_12

					var_600_3.transform.localScale = Vector3.New(var_600_13, var_600_13, 0)
				end

				for iter_600_0, iter_600_1 in pairs(arg_597_1.bgs_) do
					if iter_600_0 ~= "ST12a" then
						iter_600_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_600_14 = 4

			if var_600_14 < arg_597_1.time_ and arg_597_1.time_ <= var_600_14 + arg_600_0 then
				arg_597_1.allBtn_.enabled = false
			end

			local var_600_15 = 0.3

			if arg_597_1.time_ >= var_600_14 + var_600_15 and arg_597_1.time_ < var_600_14 + var_600_15 + arg_600_0 then
				arg_597_1.allBtn_.enabled = true
			end

			local var_600_16 = 0

			if var_600_16 < arg_597_1.time_ and arg_597_1.time_ <= var_600_16 + arg_600_0 then
				arg_597_1.mask_.enabled = true
				arg_597_1.mask_.raycastTarget = true

				arg_597_1:SetGaussion(false)
			end

			local var_600_17 = 2

			if var_600_16 <= arg_597_1.time_ and arg_597_1.time_ < var_600_16 + var_600_17 then
				local var_600_18 = (arg_597_1.time_ - var_600_16) / var_600_17
				local var_600_19 = Color.New(0, 0, 0)

				var_600_19.a = Mathf.Lerp(0, 1, var_600_18)
				arg_597_1.mask_.color = var_600_19
			end

			if arg_597_1.time_ >= var_600_16 + var_600_17 and arg_597_1.time_ < var_600_16 + var_600_17 + arg_600_0 then
				local var_600_20 = Color.New(0, 0, 0)

				var_600_20.a = 1
				arg_597_1.mask_.color = var_600_20
			end

			local var_600_21 = 2

			if var_600_21 < arg_597_1.time_ and arg_597_1.time_ <= var_600_21 + arg_600_0 then
				arg_597_1.mask_.enabled = true
				arg_597_1.mask_.raycastTarget = true

				arg_597_1:SetGaussion(false)
			end

			local var_600_22 = 2

			if var_600_21 <= arg_597_1.time_ and arg_597_1.time_ < var_600_21 + var_600_22 then
				local var_600_23 = (arg_597_1.time_ - var_600_21) / var_600_22
				local var_600_24 = Color.New(0, 0, 0)

				var_600_24.a = Mathf.Lerp(1, 0, var_600_23)
				arg_597_1.mask_.color = var_600_24
			end

			if arg_597_1.time_ >= var_600_21 + var_600_22 and arg_597_1.time_ < var_600_21 + var_600_22 + arg_600_0 then
				local var_600_25 = Color.New(0, 0, 0)
				local var_600_26 = 0

				arg_597_1.mask_.enabled = false
				var_600_25.a = var_600_26
				arg_597_1.mask_.color = var_600_25
			end

			if arg_597_1.frameCnt_ <= 1 then
				arg_597_1.dialog_:SetActive(false)
			end

			local var_600_27 = 4
			local var_600_28 = 0.325

			if var_600_27 < arg_597_1.time_ and arg_597_1.time_ <= var_600_27 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0

				arg_597_1.dialog_:SetActive(true)

				arg_597_1.dialogCg_.alpha = 0

				local var_600_29 = LeanTween.value(arg_597_1.dialog_, 0, 1, 0.3)

				var_600_29:setOnUpdate(LuaHelper.FloatAction(function(arg_601_0)
					arg_597_1.dialogCg_.alpha = arg_601_0
				end))
				var_600_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_597_1.dialog_)
					var_600_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_597_1.duration_ = arg_597_1.duration_ + 0.3

				SetActive(arg_597_1.leftNameGo_, true)

				local var_600_30 = arg_597_1:FormatText(StoryNameCfg[7].name)

				arg_597_1.leftNameTxt_.text = var_600_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, true)
				arg_597_1.iconController_:SetSelectedState("hero")

				arg_597_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_597_1.callingController_:SetSelectedState("normal")

				arg_597_1.keyicon_.color = Color.New(1, 1, 1)
				arg_597_1.icon_.color = Color.New(1, 1, 1)

				local var_600_31 = arg_597_1:GetWordFromCfg(1108504145)
				local var_600_32 = arg_597_1:FormatText(var_600_31.content)

				arg_597_1.text_.text = var_600_32

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_33 = 13
				local var_600_34 = utf8.len(var_600_32)
				local var_600_35 = var_600_33 <= 0 and var_600_28 or var_600_28 * (var_600_34 / var_600_33)

				if var_600_35 > 0 and var_600_28 < var_600_35 then
					arg_597_1.talkMaxDuration = var_600_35
					var_600_27 = var_600_27 + 0.3

					if var_600_35 + var_600_27 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_35 + var_600_27
					end
				end

				arg_597_1.text_.text = var_600_32
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_36 = var_600_27 + 0.3
			local var_600_37 = math.max(var_600_28, arg_597_1.talkMaxDuration)

			if var_600_36 <= arg_597_1.time_ and arg_597_1.time_ < var_600_36 + var_600_37 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_36) / var_600_37

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_36 + var_600_37 and arg_597_1.time_ < var_600_36 + var_600_37 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play1108504146 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 1108504146
		arg_603_1.duration_ = 5

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play1108504147(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			local var_606_0 = 0.266666666666667
			local var_606_1 = 1

			if var_606_0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_0 + arg_606_0 then
				local var_606_2 = "play"
				local var_606_3 = "effect"

				arg_603_1:AudioAction(var_606_2, var_606_3, "se_story_140", "se_story_140_footstep_run05", "")
			end

			local var_606_4 = 0
			local var_606_5 = 0.775

			if var_606_4 < arg_603_1.time_ and arg_603_1.time_ <= var_606_4 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, false)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_6 = arg_603_1:GetWordFromCfg(1108504146)
				local var_606_7 = arg_603_1:FormatText(var_606_6.content)

				arg_603_1.text_.text = var_606_7

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_8 = 31
				local var_606_9 = utf8.len(var_606_7)
				local var_606_10 = var_606_8 <= 0 and var_606_5 or var_606_5 * (var_606_9 / var_606_8)

				if var_606_10 > 0 and var_606_5 < var_606_10 then
					arg_603_1.talkMaxDuration = var_606_10

					if var_606_10 + var_606_4 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_10 + var_606_4
					end
				end

				arg_603_1.text_.text = var_606_7
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)
				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_11 = math.max(var_606_5, arg_603_1.talkMaxDuration)

			if var_606_4 <= arg_603_1.time_ and arg_603_1.time_ < var_606_4 + var_606_11 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_4) / var_606_11

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_4 + var_606_11 and arg_603_1.time_ < var_606_4 + var_606_11 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {}

		arg_603_1:InitPlayNodeList()
	end,
	Play1108504147 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 1108504147
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play1108504148(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = 0
			local var_610_1 = 0.1

			if var_610_0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_0 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_2 = arg_607_1:FormatText(StoryNameCfg[7].name)

				arg_607_1.leftNameTxt_.text = var_610_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_3 = arg_607_1:GetWordFromCfg(1108504147)
				local var_610_4 = arg_607_1:FormatText(var_610_3.content)

				arg_607_1.text_.text = var_610_4

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_5 = 4
				local var_610_6 = utf8.len(var_610_4)
				local var_610_7 = var_610_5 <= 0 and var_610_1 or var_610_1 * (var_610_6 / var_610_5)

				if var_610_7 > 0 and var_610_1 < var_610_7 then
					arg_607_1.talkMaxDuration = var_610_7

					if var_610_7 + var_610_0 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_7 + var_610_0
					end
				end

				arg_607_1.text_.text = var_610_4
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_8 = math.max(var_610_1, arg_607_1.talkMaxDuration)

			if var_610_0 <= arg_607_1.time_ and arg_607_1.time_ < var_610_0 + var_610_8 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_0) / var_610_8

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_0 + var_610_8 and arg_607_1.time_ < var_610_0 + var_610_8 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play1108504148 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 1108504148
		arg_611_1.duration_ = 3.43

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play1108504149(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["1085ui_story"].transform
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 then
				arg_611_1.var_.moveOldPos1085ui_story = var_614_0.localPosition
			end

			local var_614_2 = 0.001

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_2 then
				local var_614_3 = (arg_611_1.time_ - var_614_1) / var_614_2
				local var_614_4 = Vector3.New(0, -1.01, -5.83)

				var_614_0.localPosition = Vector3.Lerp(arg_611_1.var_.moveOldPos1085ui_story, var_614_4, var_614_3)

				local var_614_5 = manager.ui.mainCamera.transform.position - var_614_0.position

				var_614_0.forward = Vector3.New(var_614_5.x, var_614_5.y, var_614_5.z)

				local var_614_6 = var_614_0.localEulerAngles

				var_614_6.z = 0
				var_614_6.x = 0
				var_614_0.localEulerAngles = var_614_6
			end

			if arg_611_1.time_ >= var_614_1 + var_614_2 and arg_611_1.time_ < var_614_1 + var_614_2 + arg_614_0 then
				var_614_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_614_7 = manager.ui.mainCamera.transform.position - var_614_0.position

				var_614_0.forward = Vector3.New(var_614_7.x, var_614_7.y, var_614_7.z)

				local var_614_8 = var_614_0.localEulerAngles

				var_614_8.z = 0
				var_614_8.x = 0
				var_614_0.localEulerAngles = var_614_8
			end

			local var_614_9 = arg_611_1.actors_["1085ui_story"]
			local var_614_10 = 0

			if var_614_10 < arg_611_1.time_ and arg_611_1.time_ <= var_614_10 + arg_614_0 and not isNil(var_614_9) and arg_611_1.var_.characterEffect1085ui_story == nil then
				arg_611_1.var_.characterEffect1085ui_story = var_614_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_11 = 0.200000002980232

			if var_614_10 <= arg_611_1.time_ and arg_611_1.time_ < var_614_10 + var_614_11 and not isNil(var_614_9) then
				local var_614_12 = (arg_611_1.time_ - var_614_10) / var_614_11

				if arg_611_1.var_.characterEffect1085ui_story and not isNil(var_614_9) then
					arg_611_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_611_1.time_ >= var_614_10 + var_614_11 and arg_611_1.time_ < var_614_10 + var_614_11 + arg_614_0 and not isNil(var_614_9) and arg_611_1.var_.characterEffect1085ui_story then
				arg_611_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_614_13 = 0

			if var_614_13 < arg_611_1.time_ and arg_611_1.time_ <= var_614_13 + arg_614_0 then
				arg_611_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_614_14 = 0

			if var_614_14 < arg_611_1.time_ and arg_611_1.time_ <= var_614_14 + arg_614_0 then
				arg_611_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_614_15 = 0
			local var_614_16 = 0.25

			if var_614_15 < arg_611_1.time_ and arg_611_1.time_ <= var_614_15 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_17 = arg_611_1:FormatText(StoryNameCfg[328].name)

				arg_611_1.leftNameTxt_.text = var_614_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_18 = arg_611_1:GetWordFromCfg(1108504148)
				local var_614_19 = arg_611_1:FormatText(var_614_18.content)

				arg_611_1.text_.text = var_614_19

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_20 = 10
				local var_614_21 = utf8.len(var_614_19)
				local var_614_22 = var_614_20 <= 0 and var_614_16 or var_614_16 * (var_614_21 / var_614_20)

				if var_614_22 > 0 and var_614_16 < var_614_22 then
					arg_611_1.talkMaxDuration = var_614_22

					if var_614_22 + var_614_15 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_22 + var_614_15
					end
				end

				arg_611_1.text_.text = var_614_19
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504148", "story_v_side_new_1108504.awb") ~= 0 then
					local var_614_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504148", "story_v_side_new_1108504.awb") / 1000

					if var_614_23 + var_614_15 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_23 + var_614_15
					end

					if var_614_18.prefab_name ~= "" and arg_611_1.actors_[var_614_18.prefab_name] ~= nil then
						local var_614_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_611_1.actors_[var_614_18.prefab_name].transform, "story_v_side_new_1108504", "1108504148", "story_v_side_new_1108504.awb")

						arg_611_1:RecordAudio("1108504148", var_614_24)
						arg_611_1:RecordAudio("1108504148", var_614_24)
					else
						arg_611_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504148", "story_v_side_new_1108504.awb")
					end

					arg_611_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504148", "story_v_side_new_1108504.awb")
				end

				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_25 = math.max(var_614_16, arg_611_1.talkMaxDuration)

			if var_614_15 <= arg_611_1.time_ and arg_611_1.time_ < var_614_15 + var_614_25 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_15) / var_614_25

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_15 + var_614_25 and arg_611_1.time_ < var_614_15 + var_614_25 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_611_1:InitPlayNodeList()
	end,
	Play1108504149 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 1108504149
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play1108504150(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = arg_615_1.actors_["1085ui_story"]
			local var_618_1 = 0

			if var_618_1 < arg_615_1.time_ and arg_615_1.time_ <= var_618_1 + arg_618_0 and not isNil(var_618_0) and arg_615_1.var_.characterEffect1085ui_story == nil then
				arg_615_1.var_.characterEffect1085ui_story = var_618_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_618_2 = 0.200000002980232

			if var_618_1 <= arg_615_1.time_ and arg_615_1.time_ < var_618_1 + var_618_2 and not isNil(var_618_0) then
				local var_618_3 = (arg_615_1.time_ - var_618_1) / var_618_2

				if arg_615_1.var_.characterEffect1085ui_story and not isNil(var_618_0) then
					local var_618_4 = Mathf.Lerp(0, 0.5, var_618_3)

					arg_615_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_615_1.var_.characterEffect1085ui_story.fillRatio = var_618_4
				end
			end

			if arg_615_1.time_ >= var_618_1 + var_618_2 and arg_615_1.time_ < var_618_1 + var_618_2 + arg_618_0 and not isNil(var_618_0) and arg_615_1.var_.characterEffect1085ui_story then
				local var_618_5 = 0.5

				arg_615_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_615_1.var_.characterEffect1085ui_story.fillRatio = var_618_5
			end

			local var_618_6 = 0
			local var_618_7 = 0.325

			if var_618_6 < arg_615_1.time_ and arg_615_1.time_ <= var_618_6 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				local var_618_8 = arg_615_1:FormatText(StoryNameCfg[7].name)

				arg_615_1.leftNameTxt_.text = var_618_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_9 = arg_615_1:GetWordFromCfg(1108504149)
				local var_618_10 = arg_615_1:FormatText(var_618_9.content)

				arg_615_1.text_.text = var_618_10

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_11 = 13
				local var_618_12 = utf8.len(var_618_10)
				local var_618_13 = var_618_11 <= 0 and var_618_7 or var_618_7 * (var_618_12 / var_618_11)

				if var_618_13 > 0 and var_618_7 < var_618_13 then
					arg_615_1.talkMaxDuration = var_618_13

					if var_618_13 + var_618_6 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_13 + var_618_6
					end
				end

				arg_615_1.text_.text = var_618_10
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_14 = math.max(var_618_7, arg_615_1.talkMaxDuration)

			if var_618_6 <= arg_615_1.time_ and arg_615_1.time_ < var_618_6 + var_618_14 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_6) / var_618_14

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_6 + var_618_14 and arg_615_1.time_ < var_618_6 + var_618_14 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play1108504150 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 1108504150
		arg_619_1.duration_ = 7.27

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play1108504151(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = arg_619_1.actors_["1085ui_story"].transform
			local var_622_1 = 0

			if var_622_1 < arg_619_1.time_ and arg_619_1.time_ <= var_622_1 + arg_622_0 then
				arg_619_1.var_.moveOldPos1085ui_story = var_622_0.localPosition
			end

			local var_622_2 = 0.001

			if var_622_1 <= arg_619_1.time_ and arg_619_1.time_ < var_622_1 + var_622_2 then
				local var_622_3 = (arg_619_1.time_ - var_622_1) / var_622_2
				local var_622_4 = Vector3.New(0, -1.01, -5.83)

				var_622_0.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos1085ui_story, var_622_4, var_622_3)

				local var_622_5 = manager.ui.mainCamera.transform.position - var_622_0.position

				var_622_0.forward = Vector3.New(var_622_5.x, var_622_5.y, var_622_5.z)

				local var_622_6 = var_622_0.localEulerAngles

				var_622_6.z = 0
				var_622_6.x = 0
				var_622_0.localEulerAngles = var_622_6
			end

			if arg_619_1.time_ >= var_622_1 + var_622_2 and arg_619_1.time_ < var_622_1 + var_622_2 + arg_622_0 then
				var_622_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_622_7 = manager.ui.mainCamera.transform.position - var_622_0.position

				var_622_0.forward = Vector3.New(var_622_7.x, var_622_7.y, var_622_7.z)

				local var_622_8 = var_622_0.localEulerAngles

				var_622_8.z = 0
				var_622_8.x = 0
				var_622_0.localEulerAngles = var_622_8
			end

			local var_622_9 = arg_619_1.actors_["1085ui_story"]
			local var_622_10 = 0

			if var_622_10 < arg_619_1.time_ and arg_619_1.time_ <= var_622_10 + arg_622_0 and not isNil(var_622_9) and arg_619_1.var_.characterEffect1085ui_story == nil then
				arg_619_1.var_.characterEffect1085ui_story = var_622_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_622_11 = 0.200000002980232

			if var_622_10 <= arg_619_1.time_ and arg_619_1.time_ < var_622_10 + var_622_11 and not isNil(var_622_9) then
				local var_622_12 = (arg_619_1.time_ - var_622_10) / var_622_11

				if arg_619_1.var_.characterEffect1085ui_story and not isNil(var_622_9) then
					arg_619_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_619_1.time_ >= var_622_10 + var_622_11 and arg_619_1.time_ < var_622_10 + var_622_11 + arg_622_0 and not isNil(var_622_9) and arg_619_1.var_.characterEffect1085ui_story then
				arg_619_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_622_13 = 0

			if var_622_13 < arg_619_1.time_ and arg_619_1.time_ <= var_622_13 + arg_622_0 then
				arg_619_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_622_14 = 0

			if var_622_14 < arg_619_1.time_ and arg_619_1.time_ <= var_622_14 + arg_622_0 then
				arg_619_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_622_15 = 0
			local var_622_16 = 0.625

			if var_622_15 < arg_619_1.time_ and arg_619_1.time_ <= var_622_15 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				local var_622_17 = arg_619_1:FormatText(StoryNameCfg[328].name)

				arg_619_1.leftNameTxt_.text = var_622_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_18 = arg_619_1:GetWordFromCfg(1108504150)
				local var_622_19 = arg_619_1:FormatText(var_622_18.content)

				arg_619_1.text_.text = var_622_19

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_20 = 25
				local var_622_21 = utf8.len(var_622_19)
				local var_622_22 = var_622_20 <= 0 and var_622_16 or var_622_16 * (var_622_21 / var_622_20)

				if var_622_22 > 0 and var_622_16 < var_622_22 then
					arg_619_1.talkMaxDuration = var_622_22

					if var_622_22 + var_622_15 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_22 + var_622_15
					end
				end

				arg_619_1.text_.text = var_622_19
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504150", "story_v_side_new_1108504.awb") ~= 0 then
					local var_622_23 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504150", "story_v_side_new_1108504.awb") / 1000

					if var_622_23 + var_622_15 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_23 + var_622_15
					end

					if var_622_18.prefab_name ~= "" and arg_619_1.actors_[var_622_18.prefab_name] ~= nil then
						local var_622_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_18.prefab_name].transform, "story_v_side_new_1108504", "1108504150", "story_v_side_new_1108504.awb")

						arg_619_1:RecordAudio("1108504150", var_622_24)
						arg_619_1:RecordAudio("1108504150", var_622_24)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504150", "story_v_side_new_1108504.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504150", "story_v_side_new_1108504.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_25 = math.max(var_622_16, arg_619_1.talkMaxDuration)

			if var_622_15 <= arg_619_1.time_ and arg_619_1.time_ < var_622_15 + var_622_25 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_15) / var_622_25

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_15 + var_622_25 and arg_619_1.time_ < var_622_15 + var_622_25 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play1108504151 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 1108504151
		arg_623_1.duration_ = 4.87

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play1108504152(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			local var_626_0 = 0

			if var_626_0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_0 + arg_626_0 then
				arg_623_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_626_1 = 0
			local var_626_2 = 0.45

			if var_626_1 < arg_623_1.time_ and arg_623_1.time_ <= var_626_1 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				local var_626_3 = arg_623_1:FormatText(StoryNameCfg[328].name)

				arg_623_1.leftNameTxt_.text = var_626_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_4 = arg_623_1:GetWordFromCfg(1108504151)
				local var_626_5 = arg_623_1:FormatText(var_626_4.content)

				arg_623_1.text_.text = var_626_5

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_6 = 18
				local var_626_7 = utf8.len(var_626_5)
				local var_626_8 = var_626_6 <= 0 and var_626_2 or var_626_2 * (var_626_7 / var_626_6)

				if var_626_8 > 0 and var_626_2 < var_626_8 then
					arg_623_1.talkMaxDuration = var_626_8

					if var_626_8 + var_626_1 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_8 + var_626_1
					end
				end

				arg_623_1.text_.text = var_626_5
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504151", "story_v_side_new_1108504.awb") ~= 0 then
					local var_626_9 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504151", "story_v_side_new_1108504.awb") / 1000

					if var_626_9 + var_626_1 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_9 + var_626_1
					end

					if var_626_4.prefab_name ~= "" and arg_623_1.actors_[var_626_4.prefab_name] ~= nil then
						local var_626_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_4.prefab_name].transform, "story_v_side_new_1108504", "1108504151", "story_v_side_new_1108504.awb")

						arg_623_1:RecordAudio("1108504151", var_626_10)
						arg_623_1:RecordAudio("1108504151", var_626_10)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504151", "story_v_side_new_1108504.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504151", "story_v_side_new_1108504.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_11 = math.max(var_626_2, arg_623_1.talkMaxDuration)

			if var_626_1 <= arg_623_1.time_ and arg_623_1.time_ < var_626_1 + var_626_11 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_1) / var_626_11

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_1 + var_626_11 and arg_623_1.time_ < var_626_1 + var_626_11 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play1108504152 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 1108504152
		arg_627_1.duration_ = 5

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play1108504153(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			local var_630_0 = arg_627_1.actors_["1085ui_story"]
			local var_630_1 = 0

			if var_630_1 < arg_627_1.time_ and arg_627_1.time_ <= var_630_1 + arg_630_0 and not isNil(var_630_0) and arg_627_1.var_.characterEffect1085ui_story == nil then
				arg_627_1.var_.characterEffect1085ui_story = var_630_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_2 = 0.200000002980232

			if var_630_1 <= arg_627_1.time_ and arg_627_1.time_ < var_630_1 + var_630_2 and not isNil(var_630_0) then
				local var_630_3 = (arg_627_1.time_ - var_630_1) / var_630_2

				if arg_627_1.var_.characterEffect1085ui_story and not isNil(var_630_0) then
					local var_630_4 = Mathf.Lerp(0, 0.5, var_630_3)

					arg_627_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_627_1.var_.characterEffect1085ui_story.fillRatio = var_630_4
				end
			end

			if arg_627_1.time_ >= var_630_1 + var_630_2 and arg_627_1.time_ < var_630_1 + var_630_2 + arg_630_0 and not isNil(var_630_0) and arg_627_1.var_.characterEffect1085ui_story then
				local var_630_5 = 0.5

				arg_627_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_627_1.var_.characterEffect1085ui_story.fillRatio = var_630_5
			end

			local var_630_6 = 0
			local var_630_7 = 0.525

			if var_630_6 < arg_627_1.time_ and arg_627_1.time_ <= var_630_6 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				local var_630_8 = arg_627_1:FormatText(StoryNameCfg[7].name)

				arg_627_1.leftNameTxt_.text = var_630_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, true)
				arg_627_1.iconController_:SetSelectedState("hero")

				arg_627_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_627_1.callingController_:SetSelectedState("normal")

				arg_627_1.keyicon_.color = Color.New(1, 1, 1)
				arg_627_1.icon_.color = Color.New(1, 1, 1)

				local var_630_9 = arg_627_1:GetWordFromCfg(1108504152)
				local var_630_10 = arg_627_1:FormatText(var_630_9.content)

				arg_627_1.text_.text = var_630_10

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_11 = 21
				local var_630_12 = utf8.len(var_630_10)
				local var_630_13 = var_630_11 <= 0 and var_630_7 or var_630_7 * (var_630_12 / var_630_11)

				if var_630_13 > 0 and var_630_7 < var_630_13 then
					arg_627_1.talkMaxDuration = var_630_13

					if var_630_13 + var_630_6 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_13 + var_630_6
					end
				end

				arg_627_1.text_.text = var_630_10
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)
				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_14 = math.max(var_630_7, arg_627_1.talkMaxDuration)

			if var_630_6 <= arg_627_1.time_ and arg_627_1.time_ < var_630_6 + var_630_14 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_6) / var_630_14

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_6 + var_630_14 and arg_627_1.time_ < var_630_6 + var_630_14 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play1108504153 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 1108504153
		arg_631_1.duration_ = 2.67

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play1108504154(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			local var_634_0 = arg_631_1.actors_["1085ui_story"]
			local var_634_1 = 0

			if var_634_1 < arg_631_1.time_ and arg_631_1.time_ <= var_634_1 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1085ui_story == nil then
				arg_631_1.var_.characterEffect1085ui_story = var_634_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_2 = 0.200000002980232

			if var_634_1 <= arg_631_1.time_ and arg_631_1.time_ < var_634_1 + var_634_2 and not isNil(var_634_0) then
				local var_634_3 = (arg_631_1.time_ - var_634_1) / var_634_2

				if arg_631_1.var_.characterEffect1085ui_story and not isNil(var_634_0) then
					arg_631_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= var_634_1 + var_634_2 and arg_631_1.time_ < var_634_1 + var_634_2 + arg_634_0 and not isNil(var_634_0) and arg_631_1.var_.characterEffect1085ui_story then
				arg_631_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_634_4 = 0

			if var_634_4 < arg_631_1.time_ and arg_631_1.time_ <= var_634_4 + arg_634_0 then
				arg_631_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			local var_634_5 = 0
			local var_634_6 = 0.125

			if var_634_5 < arg_631_1.time_ and arg_631_1.time_ <= var_634_5 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				local var_634_7 = arg_631_1:FormatText(StoryNameCfg[328].name)

				arg_631_1.leftNameTxt_.text = var_634_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_8 = arg_631_1:GetWordFromCfg(1108504153)
				local var_634_9 = arg_631_1:FormatText(var_634_8.content)

				arg_631_1.text_.text = var_634_9

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_10 = 5
				local var_634_11 = utf8.len(var_634_9)
				local var_634_12 = var_634_10 <= 0 and var_634_6 or var_634_6 * (var_634_11 / var_634_10)

				if var_634_12 > 0 and var_634_6 < var_634_12 then
					arg_631_1.talkMaxDuration = var_634_12

					if var_634_12 + var_634_5 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_12 + var_634_5
					end
				end

				arg_631_1.text_.text = var_634_9
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504153", "story_v_side_new_1108504.awb") ~= 0 then
					local var_634_13 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504153", "story_v_side_new_1108504.awb") / 1000

					if var_634_13 + var_634_5 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_13 + var_634_5
					end

					if var_634_8.prefab_name ~= "" and arg_631_1.actors_[var_634_8.prefab_name] ~= nil then
						local var_634_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_8.prefab_name].transform, "story_v_side_new_1108504", "1108504153", "story_v_side_new_1108504.awb")

						arg_631_1:RecordAudio("1108504153", var_634_14)
						arg_631_1:RecordAudio("1108504153", var_634_14)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504153", "story_v_side_new_1108504.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504153", "story_v_side_new_1108504.awb")
				end

				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_15 = math.max(var_634_6, arg_631_1.talkMaxDuration)

			if var_634_5 <= arg_631_1.time_ and arg_631_1.time_ < var_634_5 + var_634_15 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_5) / var_634_15

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_5 + var_634_15 and arg_631_1.time_ < var_634_5 + var_634_15 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play1108504154 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 1108504154
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play1108504155(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = arg_635_1.actors_["1085ui_story"].transform
			local var_638_1 = 0

			if var_638_1 < arg_635_1.time_ and arg_635_1.time_ <= var_638_1 + arg_638_0 then
				arg_635_1.var_.moveOldPos1085ui_story = var_638_0.localPosition
			end

			local var_638_2 = 0.001

			if var_638_1 <= arg_635_1.time_ and arg_635_1.time_ < var_638_1 + var_638_2 then
				local var_638_3 = (arg_635_1.time_ - var_638_1) / var_638_2
				local var_638_4 = Vector3.New(0, 100, 0)

				var_638_0.localPosition = Vector3.Lerp(arg_635_1.var_.moveOldPos1085ui_story, var_638_4, var_638_3)

				local var_638_5 = manager.ui.mainCamera.transform.position - var_638_0.position

				var_638_0.forward = Vector3.New(var_638_5.x, var_638_5.y, var_638_5.z)

				local var_638_6 = var_638_0.localEulerAngles

				var_638_6.z = 0
				var_638_6.x = 0
				var_638_0.localEulerAngles = var_638_6
			end

			if arg_635_1.time_ >= var_638_1 + var_638_2 and arg_635_1.time_ < var_638_1 + var_638_2 + arg_638_0 then
				var_638_0.localPosition = Vector3.New(0, 100, 0)

				local var_638_7 = manager.ui.mainCamera.transform.position - var_638_0.position

				var_638_0.forward = Vector3.New(var_638_7.x, var_638_7.y, var_638_7.z)

				local var_638_8 = var_638_0.localEulerAngles

				var_638_8.z = 0
				var_638_8.x = 0
				var_638_0.localEulerAngles = var_638_8
			end

			local var_638_9 = arg_635_1.actors_["1085ui_story"]
			local var_638_10 = 0

			if var_638_10 < arg_635_1.time_ and arg_635_1.time_ <= var_638_10 + arg_638_0 and not isNil(var_638_9) and arg_635_1.var_.characterEffect1085ui_story == nil then
				arg_635_1.var_.characterEffect1085ui_story = var_638_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_638_11 = 0.200000002980232

			if var_638_10 <= arg_635_1.time_ and arg_635_1.time_ < var_638_10 + var_638_11 and not isNil(var_638_9) then
				local var_638_12 = (arg_635_1.time_ - var_638_10) / var_638_11

				if arg_635_1.var_.characterEffect1085ui_story and not isNil(var_638_9) then
					local var_638_13 = Mathf.Lerp(0, 0.5, var_638_12)

					arg_635_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_635_1.var_.characterEffect1085ui_story.fillRatio = var_638_13
				end
			end

			if arg_635_1.time_ >= var_638_10 + var_638_11 and arg_635_1.time_ < var_638_10 + var_638_11 + arg_638_0 and not isNil(var_638_9) and arg_635_1.var_.characterEffect1085ui_story then
				local var_638_14 = 0.5

				arg_635_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_635_1.var_.characterEffect1085ui_story.fillRatio = var_638_14
			end

			local var_638_15 = 0
			local var_638_16 = 0.7

			if var_638_15 < arg_635_1.time_ and arg_635_1.time_ <= var_638_15 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_17 = arg_635_1:GetWordFromCfg(1108504154)
				local var_638_18 = arg_635_1:FormatText(var_638_17.content)

				arg_635_1.text_.text = var_638_18

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_19 = 28
				local var_638_20 = utf8.len(var_638_18)
				local var_638_21 = var_638_19 <= 0 and var_638_16 or var_638_16 * (var_638_20 / var_638_19)

				if var_638_21 > 0 and var_638_16 < var_638_21 then
					arg_635_1.talkMaxDuration = var_638_21

					if var_638_21 + var_638_15 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_21 + var_638_15
					end
				end

				arg_635_1.text_.text = var_638_18
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_22 = math.max(var_638_16, arg_635_1.talkMaxDuration)

			if var_638_15 <= arg_635_1.time_ and arg_635_1.time_ < var_638_15 + var_638_22 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - var_638_15) / var_638_22

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= var_638_15 + var_638_22 and arg_635_1.time_ < var_638_15 + var_638_22 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_635_1:InitPlayNodeList()
	end,
	Play1108504155 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 1108504155
		arg_639_1.duration_ = 5

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play1108504156(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			local var_642_0 = 0
			local var_642_1 = 1.4

			if var_642_0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_0 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, false)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_2 = arg_639_1:GetWordFromCfg(1108504155)
				local var_642_3 = arg_639_1:FormatText(var_642_2.content)

				arg_639_1.text_.text = var_642_3

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_4 = 56
				local var_642_5 = utf8.len(var_642_3)
				local var_642_6 = var_642_4 <= 0 and var_642_1 or var_642_1 * (var_642_5 / var_642_4)

				if var_642_6 > 0 and var_642_1 < var_642_6 then
					arg_639_1.talkMaxDuration = var_642_6

					if var_642_6 + var_642_0 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_6 + var_642_0
					end
				end

				arg_639_1.text_.text = var_642_3
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_7 = math.max(var_642_1, arg_639_1.talkMaxDuration)

			if var_642_0 <= arg_639_1.time_ and arg_639_1.time_ < var_642_0 + var_642_7 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_0) / var_642_7

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_0 + var_642_7 and arg_639_1.time_ < var_642_0 + var_642_7 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play1108504156 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 1108504156
		arg_643_1.duration_ = 5.5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play1108504157(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			local var_646_0 = arg_643_1.actors_["1085ui_story"].transform
			local var_646_1 = 0

			if var_646_1 < arg_643_1.time_ and arg_643_1.time_ <= var_646_1 + arg_646_0 then
				arg_643_1.var_.moveOldPos1085ui_story = var_646_0.localPosition
			end

			local var_646_2 = 0.001

			if var_646_1 <= arg_643_1.time_ and arg_643_1.time_ < var_646_1 + var_646_2 then
				local var_646_3 = (arg_643_1.time_ - var_646_1) / var_646_2
				local var_646_4 = Vector3.New(0, -1.01, -5.83)

				var_646_0.localPosition = Vector3.Lerp(arg_643_1.var_.moveOldPos1085ui_story, var_646_4, var_646_3)

				local var_646_5 = manager.ui.mainCamera.transform.position - var_646_0.position

				var_646_0.forward = Vector3.New(var_646_5.x, var_646_5.y, var_646_5.z)

				local var_646_6 = var_646_0.localEulerAngles

				var_646_6.z = 0
				var_646_6.x = 0
				var_646_0.localEulerAngles = var_646_6
			end

			if arg_643_1.time_ >= var_646_1 + var_646_2 and arg_643_1.time_ < var_646_1 + var_646_2 + arg_646_0 then
				var_646_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_646_7 = manager.ui.mainCamera.transform.position - var_646_0.position

				var_646_0.forward = Vector3.New(var_646_7.x, var_646_7.y, var_646_7.z)

				local var_646_8 = var_646_0.localEulerAngles

				var_646_8.z = 0
				var_646_8.x = 0
				var_646_0.localEulerAngles = var_646_8
			end

			local var_646_9 = arg_643_1.actors_["1085ui_story"]
			local var_646_10 = 0

			if var_646_10 < arg_643_1.time_ and arg_643_1.time_ <= var_646_10 + arg_646_0 and not isNil(var_646_9) and arg_643_1.var_.characterEffect1085ui_story == nil then
				arg_643_1.var_.characterEffect1085ui_story = var_646_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_11 = 0.200000002980232

			if var_646_10 <= arg_643_1.time_ and arg_643_1.time_ < var_646_10 + var_646_11 and not isNil(var_646_9) then
				local var_646_12 = (arg_643_1.time_ - var_646_10) / var_646_11

				if arg_643_1.var_.characterEffect1085ui_story and not isNil(var_646_9) then
					arg_643_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_643_1.time_ >= var_646_10 + var_646_11 and arg_643_1.time_ < var_646_10 + var_646_11 + arg_646_0 and not isNil(var_646_9) and arg_643_1.var_.characterEffect1085ui_story then
				arg_643_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_646_13 = 0

			if var_646_13 < arg_643_1.time_ and arg_643_1.time_ <= var_646_13 + arg_646_0 then
				arg_643_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_2")
			end

			local var_646_14 = 0
			local var_646_15 = 0.425

			if var_646_14 < arg_643_1.time_ and arg_643_1.time_ <= var_646_14 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				local var_646_16 = arg_643_1:FormatText(StoryNameCfg[328].name)

				arg_643_1.leftNameTxt_.text = var_646_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_17 = arg_643_1:GetWordFromCfg(1108504156)
				local var_646_18 = arg_643_1:FormatText(var_646_17.content)

				arg_643_1.text_.text = var_646_18

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_19 = 17
				local var_646_20 = utf8.len(var_646_18)
				local var_646_21 = var_646_19 <= 0 and var_646_15 or var_646_15 * (var_646_20 / var_646_19)

				if var_646_21 > 0 and var_646_15 < var_646_21 then
					arg_643_1.talkMaxDuration = var_646_21

					if var_646_21 + var_646_14 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_21 + var_646_14
					end
				end

				arg_643_1.text_.text = var_646_18
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504156", "story_v_side_new_1108504.awb") ~= 0 then
					local var_646_22 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504156", "story_v_side_new_1108504.awb") / 1000

					if var_646_22 + var_646_14 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_22 + var_646_14
					end

					if var_646_17.prefab_name ~= "" and arg_643_1.actors_[var_646_17.prefab_name] ~= nil then
						local var_646_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_17.prefab_name].transform, "story_v_side_new_1108504", "1108504156", "story_v_side_new_1108504.awb")

						arg_643_1:RecordAudio("1108504156", var_646_23)
						arg_643_1:RecordAudio("1108504156", var_646_23)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504156", "story_v_side_new_1108504.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504156", "story_v_side_new_1108504.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_24 = math.max(var_646_15, arg_643_1.talkMaxDuration)

			if var_646_14 <= arg_643_1.time_ and arg_643_1.time_ < var_646_14 + var_646_24 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_14) / var_646_24

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_14 + var_646_24 and arg_643_1.time_ < var_646_14 + var_646_24 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_643_1:InitPlayNodeList()
	end,
	Play1108504157 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 1108504157
		arg_647_1.duration_ = 3.6

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
			arg_647_1.auto_ = false
		end

		function arg_647_1.playNext_(arg_649_0)
			arg_647_1.onStoryFinished_()
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = arg_647_1.actors_["1085ui_story"].transform
			local var_650_1 = 0

			if var_650_1 < arg_647_1.time_ and arg_647_1.time_ <= var_650_1 + arg_650_0 then
				arg_647_1.var_.moveOldPos1085ui_story = var_650_0.localPosition
			end

			local var_650_2 = 0.001

			if var_650_1 <= arg_647_1.time_ and arg_647_1.time_ < var_650_1 + var_650_2 then
				local var_650_3 = (arg_647_1.time_ - var_650_1) / var_650_2
				local var_650_4 = Vector3.New(0, -1.01, -5.83)

				var_650_0.localPosition = Vector3.Lerp(arg_647_1.var_.moveOldPos1085ui_story, var_650_4, var_650_3)

				local var_650_5 = manager.ui.mainCamera.transform.position - var_650_0.position

				var_650_0.forward = Vector3.New(var_650_5.x, var_650_5.y, var_650_5.z)

				local var_650_6 = var_650_0.localEulerAngles

				var_650_6.z = 0
				var_650_6.x = 0
				var_650_0.localEulerAngles = var_650_6
			end

			if arg_647_1.time_ >= var_650_1 + var_650_2 and arg_647_1.time_ < var_650_1 + var_650_2 + arg_650_0 then
				var_650_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_650_7 = manager.ui.mainCamera.transform.position - var_650_0.position

				var_650_0.forward = Vector3.New(var_650_7.x, var_650_7.y, var_650_7.z)

				local var_650_8 = var_650_0.localEulerAngles

				var_650_8.z = 0
				var_650_8.x = 0
				var_650_0.localEulerAngles = var_650_8
			end

			local var_650_9 = 0

			if var_650_9 < arg_647_1.time_ and arg_647_1.time_ <= var_650_9 + arg_650_0 then
				arg_647_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_650_10 = 0

			if var_650_10 < arg_647_1.time_ and arg_647_1.time_ <= var_650_10 + arg_650_0 then
				arg_647_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_650_11 = 0
			local var_650_12 = 0.25

			if var_650_11 < arg_647_1.time_ and arg_647_1.time_ <= var_650_11 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				local var_650_13 = arg_647_1:FormatText(StoryNameCfg[328].name)

				arg_647_1.leftNameTxt_.text = var_650_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_14 = arg_647_1:GetWordFromCfg(1108504157)
				local var_650_15 = arg_647_1:FormatText(var_650_14.content)

				arg_647_1.text_.text = var_650_15

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_16 = 10
				local var_650_17 = utf8.len(var_650_15)
				local var_650_18 = var_650_16 <= 0 and var_650_12 or var_650_12 * (var_650_17 / var_650_16)

				if var_650_18 > 0 and var_650_12 < var_650_18 then
					arg_647_1.talkMaxDuration = var_650_18

					if var_650_18 + var_650_11 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_18 + var_650_11
					end
				end

				arg_647_1.text_.text = var_650_15
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504157", "story_v_side_new_1108504.awb") ~= 0 then
					local var_650_19 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504157", "story_v_side_new_1108504.awb") / 1000

					if var_650_19 + var_650_11 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_19 + var_650_11
					end

					if var_650_14.prefab_name ~= "" and arg_647_1.actors_[var_650_14.prefab_name] ~= nil then
						local var_650_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_14.prefab_name].transform, "story_v_side_new_1108504", "1108504157", "story_v_side_new_1108504.awb")

						arg_647_1:RecordAudio("1108504157", var_650_20)
						arg_647_1:RecordAudio("1108504157", var_650_20)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504157", "story_v_side_new_1108504.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504157", "story_v_side_new_1108504.awb")
				end

				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_21 = math.max(var_650_12, arg_647_1.talkMaxDuration)

			if var_650_11 <= arg_647_1.time_ and arg_647_1.time_ < var_650_11 + var_650_21 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - var_650_11) / var_650_21

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= var_650_11 + var_650_21 and arg_647_1.time_ < var_650_11 + var_650_21 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_647_1:InitPlayNodeList()
	end,
	Play1108504138 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 1108504138
		arg_651_1.duration_ = 2.8

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play1108504139(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = 0
			local var_654_1 = 0.2

			if var_654_0 < arg_651_1.time_ and arg_651_1.time_ <= var_654_0 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				local var_654_2 = arg_651_1:FormatText(StoryNameCfg[328].name)

				arg_651_1.leftNameTxt_.text = var_654_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, false)
				arg_651_1.callingController_:SetSelectedState("normal")

				local var_654_3 = arg_651_1:GetWordFromCfg(1108504138)
				local var_654_4 = arg_651_1:FormatText(var_654_3.content)

				arg_651_1.text_.text = var_654_4

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_5 = 8
				local var_654_6 = utf8.len(var_654_4)
				local var_654_7 = var_654_5 <= 0 and var_654_1 or var_654_1 * (var_654_6 / var_654_5)

				if var_654_7 > 0 and var_654_1 < var_654_7 then
					arg_651_1.talkMaxDuration = var_654_7

					if var_654_7 + var_654_0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_7 + var_654_0
					end
				end

				arg_651_1.text_.text = var_654_4
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504138", "story_v_side_new_1108504.awb") ~= 0 then
					local var_654_8 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504138", "story_v_side_new_1108504.awb") / 1000

					if var_654_8 + var_654_0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_8 + var_654_0
					end

					if var_654_3.prefab_name ~= "" and arg_651_1.actors_[var_654_3.prefab_name] ~= nil then
						local var_654_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_651_1.actors_[var_654_3.prefab_name].transform, "story_v_side_new_1108504", "1108504138", "story_v_side_new_1108504.awb")

						arg_651_1:RecordAudio("1108504138", var_654_9)
						arg_651_1:RecordAudio("1108504138", var_654_9)
					else
						arg_651_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504138", "story_v_side_new_1108504.awb")
					end

					arg_651_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504138", "story_v_side_new_1108504.awb")
				end

				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_10 = math.max(var_654_1, arg_651_1.talkMaxDuration)

			if var_654_0 <= arg_651_1.time_ and arg_651_1.time_ < var_654_0 + var_654_10 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - var_654_0) / var_654_10

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= var_654_0 + var_654_10 and arg_651_1.time_ < var_654_0 + var_654_10 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play1108504139 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 1108504139
		arg_655_1.duration_ = 5

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play1108504140(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			local var_658_0 = 0
			local var_658_1 = 0.2

			if var_658_0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_0 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				local var_658_2 = arg_655_1:FormatText(StoryNameCfg[7].name)

				arg_655_1.leftNameTxt_.text = var_658_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, true)
				arg_655_1.iconController_:SetSelectedState("hero")

				arg_655_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_655_1.callingController_:SetSelectedState("normal")

				arg_655_1.keyicon_.color = Color.New(1, 1, 1)
				arg_655_1.icon_.color = Color.New(1, 1, 1)

				local var_658_3 = arg_655_1:GetWordFromCfg(1108504139)
				local var_658_4 = arg_655_1:FormatText(var_658_3.content)

				arg_655_1.text_.text = var_658_4

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_5 = 8
				local var_658_6 = utf8.len(var_658_4)
				local var_658_7 = var_658_5 <= 0 and var_658_1 or var_658_1 * (var_658_6 / var_658_5)

				if var_658_7 > 0 and var_658_1 < var_658_7 then
					arg_655_1.talkMaxDuration = var_658_7

					if var_658_7 + var_658_0 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_7 + var_658_0
					end
				end

				arg_655_1.text_.text = var_658_4
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)
				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_8 = math.max(var_658_1, arg_655_1.talkMaxDuration)

			if var_658_0 <= arg_655_1.time_ and arg_655_1.time_ < var_658_0 + var_658_8 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_0) / var_658_8

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_0 + var_658_8 and arg_655_1.time_ < var_658_0 + var_658_8 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {}

		arg_655_1:InitPlayNodeList()
	end,
	Play1108504046 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 1108504046
		arg_659_1.duration_ = 7.67

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play1108504047(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			local var_662_0 = arg_659_1.actors_["1085ui_story"].transform
			local var_662_1 = 0

			if var_662_1 < arg_659_1.time_ and arg_659_1.time_ <= var_662_1 + arg_662_0 then
				arg_659_1.var_.moveOldPos1085ui_story = var_662_0.localPosition
			end

			local var_662_2 = 0.001

			if var_662_1 <= arg_659_1.time_ and arg_659_1.time_ < var_662_1 + var_662_2 then
				local var_662_3 = (arg_659_1.time_ - var_662_1) / var_662_2
				local var_662_4 = Vector3.New(0, -1.01, -5.83)

				var_662_0.localPosition = Vector3.Lerp(arg_659_1.var_.moveOldPos1085ui_story, var_662_4, var_662_3)

				local var_662_5 = manager.ui.mainCamera.transform.position - var_662_0.position

				var_662_0.forward = Vector3.New(var_662_5.x, var_662_5.y, var_662_5.z)

				local var_662_6 = var_662_0.localEulerAngles

				var_662_6.z = 0
				var_662_6.x = 0
				var_662_0.localEulerAngles = var_662_6
			end

			if arg_659_1.time_ >= var_662_1 + var_662_2 and arg_659_1.time_ < var_662_1 + var_662_2 + arg_662_0 then
				var_662_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_662_7 = manager.ui.mainCamera.transform.position - var_662_0.position

				var_662_0.forward = Vector3.New(var_662_7.x, var_662_7.y, var_662_7.z)

				local var_662_8 = var_662_0.localEulerAngles

				var_662_8.z = 0
				var_662_8.x = 0
				var_662_0.localEulerAngles = var_662_8
			end

			local var_662_9 = arg_659_1.actors_["1085ui_story"]
			local var_662_10 = 0

			if var_662_10 < arg_659_1.time_ and arg_659_1.time_ <= var_662_10 + arg_662_0 and not isNil(var_662_9) and arg_659_1.var_.characterEffect1085ui_story == nil then
				arg_659_1.var_.characterEffect1085ui_story = var_662_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_662_11 = 0.200000002980232

			if var_662_10 <= arg_659_1.time_ and arg_659_1.time_ < var_662_10 + var_662_11 and not isNil(var_662_9) then
				local var_662_12 = (arg_659_1.time_ - var_662_10) / var_662_11

				if arg_659_1.var_.characterEffect1085ui_story and not isNil(var_662_9) then
					arg_659_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_659_1.time_ >= var_662_10 + var_662_11 and arg_659_1.time_ < var_662_10 + var_662_11 + arg_662_0 and not isNil(var_662_9) and arg_659_1.var_.characterEffect1085ui_story then
				arg_659_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_662_13 = "1085ui_story"

			if arg_659_1.actors_[var_662_13] == nil then
				local var_662_14 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_662_14) then
					local var_662_15 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_659_1.stage_.transform)

					var_662_15.name = var_662_13
					var_662_15.transform.localPosition = Vector3.New(0, 100, 0)
					arg_659_1.actors_[var_662_13] = var_662_15

					local var_662_16 = var_662_15:GetComponentInChildren(typeof(CharacterEffect))

					var_662_16.enabled = true

					local var_662_17 = GameObjectTools.GetOrAddComponent(var_662_15, typeof(DynamicBoneHelper))

					if var_662_17 then
						var_662_17:EnableDynamicBone(false)
					end

					arg_659_1:ShowWeapon(var_662_16.transform, false)

					arg_659_1.var_[var_662_13 .. "Animator"] = var_662_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_659_1.var_[var_662_13 .. "Animator"].applyRootMotion = true
					arg_659_1.var_[var_662_13 .. "LipSync"] = var_662_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_662_18 = 0

			if var_662_18 < arg_659_1.time_ and arg_659_1.time_ <= var_662_18 + arg_662_0 then
				arg_659_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_662_19 = "1085ui_story"

			if arg_659_1.actors_[var_662_19] == nil then
				local var_662_20 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_662_20) then
					local var_662_21 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_659_1.stage_.transform)

					var_662_21.name = var_662_19
					var_662_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_659_1.actors_[var_662_19] = var_662_21

					local var_662_22 = var_662_21:GetComponentInChildren(typeof(CharacterEffect))

					var_662_22.enabled = true

					local var_662_23 = GameObjectTools.GetOrAddComponent(var_662_21, typeof(DynamicBoneHelper))

					if var_662_23 then
						var_662_23:EnableDynamicBone(false)
					end

					arg_659_1:ShowWeapon(var_662_22.transform, false)

					arg_659_1.var_[var_662_19 .. "Animator"] = var_662_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_659_1.var_[var_662_19 .. "Animator"].applyRootMotion = true
					arg_659_1.var_[var_662_19 .. "LipSync"] = var_662_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_662_24 = 0

			if var_662_24 < arg_659_1.time_ and arg_659_1.time_ <= var_662_24 + arg_662_0 then
				arg_659_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_662_25 = 0
			local var_662_26 = 0.65

			if var_662_25 < arg_659_1.time_ and arg_659_1.time_ <= var_662_25 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				local var_662_27 = arg_659_1:FormatText(StoryNameCfg[328].name)

				arg_659_1.leftNameTxt_.text = var_662_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, false)
				arg_659_1.callingController_:SetSelectedState("normal")

				local var_662_28 = arg_659_1:GetWordFromCfg(1108504046)
				local var_662_29 = arg_659_1:FormatText(var_662_28.content)

				arg_659_1.text_.text = var_662_29

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_30 = 26
				local var_662_31 = utf8.len(var_662_29)
				local var_662_32 = var_662_30 <= 0 and var_662_26 or var_662_26 * (var_662_31 / var_662_30)

				if var_662_32 > 0 and var_662_26 < var_662_32 then
					arg_659_1.talkMaxDuration = var_662_32

					if var_662_32 + var_662_25 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_32 + var_662_25
					end
				end

				arg_659_1.text_.text = var_662_29
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504046", "story_v_side_new_1108504.awb") ~= 0 then
					local var_662_33 = manager.audio:GetVoiceLength("story_v_side_new_1108504", "1108504046", "story_v_side_new_1108504.awb") / 1000

					if var_662_33 + var_662_25 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_33 + var_662_25
					end

					if var_662_28.prefab_name ~= "" and arg_659_1.actors_[var_662_28.prefab_name] ~= nil then
						local var_662_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_659_1.actors_[var_662_28.prefab_name].transform, "story_v_side_new_1108504", "1108504046", "story_v_side_new_1108504.awb")

						arg_659_1:RecordAudio("1108504046", var_662_34)
						arg_659_1:RecordAudio("1108504046", var_662_34)
					else
						arg_659_1:AudioAction("play", "voice", "story_v_side_new_1108504", "1108504046", "story_v_side_new_1108504.awb")
					end

					arg_659_1:RecordHistoryTalkVoice("story_v_side_new_1108504", "1108504046", "story_v_side_new_1108504.awb")
				end

				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_35 = math.max(var_662_26, arg_659_1.talkMaxDuration)

			if var_662_25 <= arg_659_1.time_ and arg_659_1.time_ < var_662_25 + var_662_35 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_25) / var_662_35

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_25 + var_662_35 and arg_659_1.time_ < var_662_25 + var_662_35 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_659_1:InitPlayNodeList()
	end,
	Play1108504047 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 1108504047
		arg_663_1.duration_ = 5

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play1108504048(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			local var_666_0 = arg_663_1.actors_["1085ui_story"]
			local var_666_1 = 0

			if var_666_1 < arg_663_1.time_ and arg_663_1.time_ <= var_666_1 + arg_666_0 and not isNil(var_666_0) and arg_663_1.var_.characterEffect1085ui_story == nil then
				arg_663_1.var_.characterEffect1085ui_story = var_666_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_666_2 = 0.200000002980232

			if var_666_1 <= arg_663_1.time_ and arg_663_1.time_ < var_666_1 + var_666_2 and not isNil(var_666_0) then
				local var_666_3 = (arg_663_1.time_ - var_666_1) / var_666_2

				if arg_663_1.var_.characterEffect1085ui_story and not isNil(var_666_0) then
					local var_666_4 = Mathf.Lerp(0, 0.5, var_666_3)

					arg_663_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_663_1.var_.characterEffect1085ui_story.fillRatio = var_666_4
				end
			end

			if arg_663_1.time_ >= var_666_1 + var_666_2 and arg_663_1.time_ < var_666_1 + var_666_2 + arg_666_0 and not isNil(var_666_0) and arg_663_1.var_.characterEffect1085ui_story then
				local var_666_5 = 0.5

				arg_663_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_663_1.var_.characterEffect1085ui_story.fillRatio = var_666_5
			end

			local var_666_6 = 0
			local var_666_7 = 0.65

			if var_666_6 < arg_663_1.time_ and arg_663_1.time_ <= var_666_6 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				local var_666_8 = arg_663_1:FormatText(StoryNameCfg[7].name)

				arg_663_1.leftNameTxt_.text = var_666_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, true)
				arg_663_1.iconController_:SetSelectedState("hero")

				arg_663_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_663_1.callingController_:SetSelectedState("normal")

				arg_663_1.keyicon_.color = Color.New(1, 1, 1)
				arg_663_1.icon_.color = Color.New(1, 1, 1)

				local var_666_9 = arg_663_1:GetWordFromCfg(1108504047)
				local var_666_10 = arg_663_1:FormatText(var_666_9.content)

				arg_663_1.text_.text = var_666_10

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_11 = 27
				local var_666_12 = utf8.len(var_666_10)
				local var_666_13 = var_666_11 <= 0 and var_666_7 or var_666_7 * (var_666_12 / var_666_11)

				if var_666_13 > 0 and var_666_7 < var_666_13 then
					arg_663_1.talkMaxDuration = var_666_13

					if var_666_13 + var_666_6 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_13 + var_666_6
					end
				end

				arg_663_1.text_.text = var_666_10
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)
				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_14 = math.max(var_666_7, arg_663_1.talkMaxDuration)

			if var_666_6 <= arg_663_1.time_ and arg_663_1.time_ < var_666_6 + var_666_14 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_6) / var_666_14

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_6 + var_666_14 and arg_663_1.time_ < var_666_6 + var_666_14 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {}

		arg_663_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST15",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST20",
		"TextureConfig/Background/ST07a",
		"TextureConfig/Background/ST07b",
		"TextureConfig/Background/ST12a",
		"TextureConfig/Background/R8501",
		"TextureConfig/Background/R8501a"
	},
	voices = {
		"story_v_side_new_1108504.awb"
	}
}
