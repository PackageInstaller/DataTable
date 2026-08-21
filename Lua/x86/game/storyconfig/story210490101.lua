return {
	Play1104901001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104901001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104901002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "K11g"

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
				local var_4_5 = arg_1_1.bgs_.K11g

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
					if iter_4_0 ~= "K11g" then
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

			local var_4_24 = 0.9
			local var_4_25 = 1.775

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_side_1058", "se_story_side_1058_rain_loop", "")
			end

			local var_4_28 = 0
			local var_4_29 = 0.4

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

			local var_4_34 = manager.ui.mainCamera.transform
			local var_4_35 = 0

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				local var_4_36 = arg_1_1.var_.effectxiayu1
				local var_4_37
				local var_4_38 = var_4_34

				if not var_4_36 then
					var_4_36 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), var_4_38)
					var_4_36.name = "xiayu1"
					arg_1_1.var_.effectxiayu1 = var_4_36
				else
					var_4_36.transform:SetParent(var_4_38)
				end

				var_4_36.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_36.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_39 = 2
			local var_4_40 = 0.675

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_41 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_41:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_42 = arg_1_1:GetWordFromCfg(1104901001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 27
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_40 or var_4_40 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_40 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_39 = var_4_39 + 0.3

					if var_4_46 + var_4_39 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_39
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_39 + 0.3
			local var_4_48 = math.max(var_4_40, arg_1_1.talkMaxDuration)

			if var_4_47 <= arg_1_1.time_ and arg_1_1.time_ < var_4_47 + var_4_48 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_47) / var_4_48

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_47 + var_4_48 and arg_1_1.time_ < var_4_47 + var_4_48 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play1104901002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1104901002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1104901003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.075

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

				local var_11_2 = arg_8_1:GetWordFromCfg(1104901002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 43
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
	Play1104901003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1104901003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1104901004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1.175

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

				local var_15_2 = arg_12_1:GetWordFromCfg(1104901003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 47
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
	Play1104901004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1104901004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1104901005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.275

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

				local var_19_3 = arg_16_1:GetWordFromCfg(1104901004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 11
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
	Play1104901005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1104901005
		arg_20_1.duration_ = 8.5

		local var_20_0 = {
			zh = 8.5,
			ja = 6.733
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1104901006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = "10053ui_story"

			if arg_20_1.actors_[var_23_0] == nil then
				local var_23_1 = Asset.Load("Char/" .. "10053ui_story")

				if not isNil(var_23_1) then
					local var_23_2 = Object.Instantiate(Asset.Load("Char/" .. "10053ui_story"), arg_20_1.stage_.transform)

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

			local var_23_5 = arg_20_1.actors_["10053ui_story"].transform
			local var_23_6 = 0

			if var_23_6 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.var_.moveOldPos10053ui_story = var_23_5.localPosition
			end

			local var_23_7 = 0.001

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_7 then
				local var_23_8 = (arg_20_1.time_ - var_23_6) / var_23_7
				local var_23_9 = Vector3.New(0, -1.12, -5.99)

				var_23_5.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10053ui_story, var_23_9, var_23_8)

				local var_23_10 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_10.x, var_23_10.y, var_23_10.z)

				local var_23_11 = var_23_5.localEulerAngles

				var_23_11.z = 0
				var_23_11.x = 0
				var_23_5.localEulerAngles = var_23_11
			end

			if arg_20_1.time_ >= var_23_6 + var_23_7 and arg_20_1.time_ < var_23_6 + var_23_7 + arg_23_0 then
				var_23_5.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_23_12 = manager.ui.mainCamera.transform.position - var_23_5.position

				var_23_5.forward = Vector3.New(var_23_12.x, var_23_12.y, var_23_12.z)

				local var_23_13 = var_23_5.localEulerAngles

				var_23_13.z = 0
				var_23_13.x = 0
				var_23_5.localEulerAngles = var_23_13
			end

			local var_23_14 = arg_20_1.actors_["10053ui_story"]
			local var_23_15 = 0

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect10053ui_story == nil then
				arg_20_1.var_.characterEffect10053ui_story = var_23_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_16 = 0.200000002980232

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_16 and not isNil(var_23_14) then
				local var_23_17 = (arg_20_1.time_ - var_23_15) / var_23_16

				if arg_20_1.var_.characterEffect10053ui_story and not isNil(var_23_14) then
					arg_20_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_15 + var_23_16 and arg_20_1.time_ < var_23_15 + var_23_16 + arg_23_0 and not isNil(var_23_14) and arg_20_1.var_.characterEffect10053ui_story then
				arg_20_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_23_18 = 0

			if var_23_18 < arg_20_1.time_ and arg_20_1.time_ <= var_23_18 + arg_23_0 then
				arg_20_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_23_19 = 0

			if var_23_19 < arg_20_1.time_ and arg_20_1.time_ <= var_23_19 + arg_23_0 then
				arg_20_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_23_20 = 0
			local var_23_21 = 1.075

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_22 = arg_20_1:FormatText(StoryNameCfg[477].name)

				arg_20_1.leftNameTxt_.text = var_23_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_23 = arg_20_1:GetWordFromCfg(1104901005)
				local var_23_24 = arg_20_1:FormatText(var_23_23.content)

				arg_20_1.text_.text = var_23_24

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_25 = 43
				local var_23_26 = utf8.len(var_23_24)
				local var_23_27 = var_23_25 <= 0 and var_23_21 or var_23_21 * (var_23_26 / var_23_25)

				if var_23_27 > 0 and var_23_21 < var_23_27 then
					arg_20_1.talkMaxDuration = var_23_27

					if var_23_27 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_27 + var_23_20
					end
				end

				arg_20_1.text_.text = var_23_24
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901005", "story_v_side_new_1104901.awb") ~= 0 then
					local var_23_28 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901005", "story_v_side_new_1104901.awb") / 1000

					if var_23_28 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_28 + var_23_20
					end

					if var_23_23.prefab_name ~= "" and arg_20_1.actors_[var_23_23.prefab_name] ~= nil then
						local var_23_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_23.prefab_name].transform, "story_v_side_new_1104901", "1104901005", "story_v_side_new_1104901.awb")

						arg_20_1:RecordAudio("1104901005", var_23_29)
						arg_20_1:RecordAudio("1104901005", var_23_29)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901005", "story_v_side_new_1104901.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901005", "story_v_side_new_1104901.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_30 = math.max(var_23_21, arg_20_1.talkMaxDuration)

			if var_23_20 <= arg_20_1.time_ and arg_20_1.time_ < var_23_20 + var_23_30 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_20) / var_23_30

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_20 + var_23_30 and arg_20_1.time_ < var_23_20 + var_23_30 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play1104901006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1104901006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1104901007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10053ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10053ui_story == nil then
				arg_24_1.var_.characterEffect10053ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect10053ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10053ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10053ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10053ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 0.9

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_8 = arg_24_1:GetWordFromCfg(1104901006)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_10 = 36
				local var_27_11 = utf8.len(var_27_9)
				local var_27_12 = var_27_10 <= 0 and var_27_7 or var_27_7 * (var_27_11 / var_27_10)

				if var_27_12 > 0 and var_27_7 < var_27_12 then
					arg_24_1.talkMaxDuration = var_27_12

					if var_27_12 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_9
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_13 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_13 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_13

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_13 and arg_24_1.time_ < var_27_6 + var_27_13 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play1104901007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1104901007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1104901008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1.375

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

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(1104901007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 55
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
	Play1104901008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1104901008
		arg_32_1.duration_ = 6.5

		local var_32_0 = {
			zh = 5.966,
			ja = 6.5
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1104901009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10053ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos10053ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0, -1.12, -5.99)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10053ui_story, var_35_4, var_35_3)

				local var_35_5 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_5.x, var_35_5.y, var_35_5.z)

				local var_35_6 = var_35_0.localEulerAngles

				var_35_6.z = 0
				var_35_6.x = 0
				var_35_0.localEulerAngles = var_35_6
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_35_7 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_7.x, var_35_7.y, var_35_7.z)

				local var_35_8 = var_35_0.localEulerAngles

				var_35_8.z = 0
				var_35_8.x = 0
				var_35_0.localEulerAngles = var_35_8
			end

			local var_35_9 = arg_32_1.actors_["10053ui_story"]
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect10053ui_story == nil then
				arg_32_1.var_.characterEffect10053ui_story = var_35_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.200000002980232

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_11 and not isNil(var_35_9) then
				local var_35_12 = (arg_32_1.time_ - var_35_10) / var_35_11

				if arg_32_1.var_.characterEffect10053ui_story and not isNil(var_35_9) then
					arg_32_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect10053ui_story then
				arg_32_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_35_13 = 0

			if var_35_13 < arg_32_1.time_ and arg_32_1.time_ <= var_35_13 + arg_35_0 then
				arg_32_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			local var_35_14 = 0

			if var_35_14 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_15 = 0
			local var_35_16 = 0.85

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_17 = arg_32_1:FormatText(StoryNameCfg[477].name)

				arg_32_1.leftNameTxt_.text = var_35_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_18 = arg_32_1:GetWordFromCfg(1104901008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_20 = 34
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901008", "story_v_side_new_1104901.awb") ~= 0 then
					local var_35_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901008", "story_v_side_new_1104901.awb") / 1000

					if var_35_23 + var_35_15 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_15
					end

					if var_35_18.prefab_name ~= "" and arg_32_1.actors_[var_35_18.prefab_name] ~= nil then
						local var_35_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_18.prefab_name].transform, "story_v_side_new_1104901", "1104901008", "story_v_side_new_1104901.awb")

						arg_32_1:RecordAudio("1104901008", var_35_24)
						arg_32_1:RecordAudio("1104901008", var_35_24)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901008", "story_v_side_new_1104901.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901008", "story_v_side_new_1104901.awb")
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
				actorName = "10053ui_story",
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
	Play1104901009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1104901009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1104901010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10053ui_story"].transform
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.var_.moveOldPos10053ui_story = var_39_0.localPosition
			end

			local var_39_2 = 0.001

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2
				local var_39_4 = Vector3.New(0, 100, 0)

				var_39_0.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10053ui_story, var_39_4, var_39_3)

				local var_39_5 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_5.x, var_39_5.y, var_39_5.z)

				local var_39_6 = var_39_0.localEulerAngles

				var_39_6.z = 0
				var_39_6.x = 0
				var_39_0.localEulerAngles = var_39_6
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				var_39_0.localPosition = Vector3.New(0, 100, 0)

				local var_39_7 = manager.ui.mainCamera.transform.position - var_39_0.position

				var_39_0.forward = Vector3.New(var_39_7.x, var_39_7.y, var_39_7.z)

				local var_39_8 = var_39_0.localEulerAngles

				var_39_8.z = 0
				var_39_8.x = 0
				var_39_0.localEulerAngles = var_39_8
			end

			local var_39_9 = arg_36_1.actors_["10053ui_story"]
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect10053ui_story == nil then
				arg_36_1.var_.characterEffect10053ui_story = var_39_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_11 = 0.200000002980232

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 and not isNil(var_39_9) then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11

				if arg_36_1.var_.characterEffect10053ui_story and not isNil(var_39_9) then
					local var_39_13 = Mathf.Lerp(0, 0.5, var_39_12)

					arg_36_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10053ui_story.fillRatio = var_39_13
				end
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 and not isNil(var_39_9) and arg_36_1.var_.characterEffect10053ui_story then
				local var_39_14 = 0.5

				arg_36_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10053ui_story.fillRatio = var_39_14
			end

			local var_39_15 = 0
			local var_39_16 = 1.175

			if var_39_15 < arg_36_1.time_ and arg_36_1.time_ <= var_39_15 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_17 = arg_36_1:GetWordFromCfg(1104901009)
				local var_39_18 = arg_36_1:FormatText(var_39_17.content)

				arg_36_1.text_.text = var_39_18

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_19 = 47
				local var_39_20 = utf8.len(var_39_18)
				local var_39_21 = var_39_19 <= 0 and var_39_16 or var_39_16 * (var_39_20 / var_39_19)

				if var_39_21 > 0 and var_39_16 < var_39_21 then
					arg_36_1.talkMaxDuration = var_39_21

					if var_39_21 + var_39_15 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_21 + var_39_15
					end
				end

				arg_36_1.text_.text = var_39_18
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_22 = math.max(var_39_16, arg_36_1.talkMaxDuration)

			if var_39_15 <= arg_36_1.time_ and arg_36_1.time_ < var_39_15 + var_39_22 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_15) / var_39_22

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_15 + var_39_22 and arg_36_1.time_ < var_39_15 + var_39_22 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play1104901010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1104901010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1104901011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.725

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(1104901010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 29
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1104901011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1104901011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1104901012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1.275

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(1104901011)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 51
				local var_47_5 = utf8.len(var_47_3)
				local var_47_6 = var_47_4 <= 0 and var_47_1 or var_47_1 * (var_47_5 / var_47_4)

				if var_47_6 > 0 and var_47_1 < var_47_6 then
					arg_44_1.talkMaxDuration = var_47_6

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_7 and arg_44_1.time_ < var_47_0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play1104901012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1104901012
		arg_48_1.duration_ = 4.27

		local var_48_0 = {
			zh = 2.966,
			ja = 4.266
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1104901013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.325

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[1006].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(1104901012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 13
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901012", "story_v_side_new_1104901.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901012", "story_v_side_new_1104901.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_side_new_1104901", "1104901012", "story_v_side_new_1104901.awb")

						arg_48_1:RecordAudio("1104901012", var_51_9)
						arg_48_1:RecordAudio("1104901012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901012", "story_v_side_new_1104901.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901012", "story_v_side_new_1104901.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play1104901013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 1104901013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play1104901014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 0.05

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_2 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(1104901013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 2
				local var_55_6 = utf8.len(var_55_4)
				local var_55_7 = var_55_5 <= 0 and var_55_1 or var_55_1 * (var_55_6 / var_55_5)

				if var_55_7 > 0 and var_55_1 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play1104901014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 1104901014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play1104901015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.925

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(1104901014)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 37
				local var_59_5 = utf8.len(var_59_3)
				local var_59_6 = var_59_4 <= 0 and var_59_1 or var_59_1 * (var_59_5 / var_59_4)

				if var_59_6 > 0 and var_59_1 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_7 and arg_56_1.time_ < var_59_0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play1104901015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 1104901015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play1104901016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 1.3

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:GetWordFromCfg(1104901015)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 52
				local var_63_5 = utf8.len(var_63_3)
				local var_63_6 = var_63_4 <= 0 and var_63_1 or var_63_1 * (var_63_5 / var_63_4)

				if var_63_6 > 0 and var_63_1 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_7 and arg_60_1.time_ < var_63_0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play1104901016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 1104901016
		arg_64_1.duration_ = 2.83

		local var_64_0 = {
			zh = 1.666,
			ja = 2.833
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play1104901017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.2

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[1006].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(1104901016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 8
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901016", "story_v_side_new_1104901.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901016", "story_v_side_new_1104901.awb") / 1000

					if var_67_8 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_0
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_side_new_1104901", "1104901016", "story_v_side_new_1104901.awb")

						arg_64_1:RecordAudio("1104901016", var_67_9)
						arg_64_1:RecordAudio("1104901016", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901016", "story_v_side_new_1104901.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901016", "story_v_side_new_1104901.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_10 and arg_64_1.time_ < var_67_0 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play1104901017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 1104901017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play1104901018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.15

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[7].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:GetWordFromCfg(1104901017)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 6
				local var_71_6 = utf8.len(var_71_4)
				local var_71_7 = var_71_5 <= 0 and var_71_1 or var_71_1 * (var_71_6 / var_71_5)

				if var_71_7 > 0 and var_71_1 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_8 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_8 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_8

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_8 and arg_68_1.time_ < var_71_0 + var_71_8 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play1104901018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1104901018
		arg_72_1.duration_ = 11.53

		local var_72_0 = {
			zh = 6.5,
			ja = 11.533
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1104901019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = manager.ui.mainCamera.transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.shakeOldPos = var_75_0.localPosition
			end

			local var_75_2 = 0.6

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / 0.066
				local var_75_4, var_75_5 = math.modf(var_75_3)

				var_75_0.localPosition = Vector3.New(var_75_5 * 0.13, var_75_5 * 0.13, var_75_5 * 0.13) + arg_72_1.var_.shakeOldPos
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = arg_72_1.var_.shakeOldPos
			end

			local var_75_6 = 0

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			local var_75_7 = 0.6

			if arg_72_1.time_ >= var_75_6 + var_75_7 and arg_72_1.time_ < var_75_6 + var_75_7 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_8 = 0
			local var_75_9 = 0.85

			if var_75_8 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_10 = arg_72_1:FormatText(StoryNameCfg[1006].name)

				arg_72_1.leftNameTxt_.text = var_75_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_11 = arg_72_1:GetWordFromCfg(1104901018)
				local var_75_12 = arg_72_1:FormatText(var_75_11.content)

				arg_72_1.text_.text = var_75_12

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_13 = 34
				local var_75_14 = utf8.len(var_75_12)
				local var_75_15 = var_75_13 <= 0 and var_75_9 or var_75_9 * (var_75_14 / var_75_13)

				if var_75_15 > 0 and var_75_9 < var_75_15 then
					arg_72_1.talkMaxDuration = var_75_15

					if var_75_15 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_15 + var_75_8
					end
				end

				arg_72_1.text_.text = var_75_12
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901018", "story_v_side_new_1104901.awb") ~= 0 then
					local var_75_16 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901018", "story_v_side_new_1104901.awb") / 1000

					if var_75_16 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_16 + var_75_8
					end

					if var_75_11.prefab_name ~= "" and arg_72_1.actors_[var_75_11.prefab_name] ~= nil then
						local var_75_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_11.prefab_name].transform, "story_v_side_new_1104901", "1104901018", "story_v_side_new_1104901.awb")

						arg_72_1:RecordAudio("1104901018", var_75_17)
						arg_72_1:RecordAudio("1104901018", var_75_17)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901018", "story_v_side_new_1104901.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901018", "story_v_side_new_1104901.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_18 = math.max(var_75_9, arg_72_1.talkMaxDuration)

			if var_75_8 <= arg_72_1.time_ and arg_72_1.time_ < var_75_8 + var_75_18 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_8) / var_75_18

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_8 + var_75_18 and arg_72_1.time_ < var_75_8 + var_75_18 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1104901019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1104901019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1104901020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.375

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

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(1104901019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 15
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
	Play1104901020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1104901020
		arg_80_1.duration_ = 6.8

		local var_80_0 = {
			zh = 6.8,
			ja = 1.7
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1104901021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0
			local var_83_1 = 0.575

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_2 = arg_80_1:FormatText(StoryNameCfg[1006].name)

				arg_80_1.leftNameTxt_.text = var_83_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(1104901020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 23
				local var_83_6 = utf8.len(var_83_4)
				local var_83_7 = var_83_5 <= 0 and var_83_1 or var_83_1 * (var_83_6 / var_83_5)

				if var_83_7 > 0 and var_83_1 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_0
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901020", "story_v_side_new_1104901.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901020", "story_v_side_new_1104901.awb") / 1000

					if var_83_8 + var_83_0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_0
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_side_new_1104901", "1104901020", "story_v_side_new_1104901.awb")

						arg_80_1:RecordAudio("1104901020", var_83_9)
						arg_80_1:RecordAudio("1104901020", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901020", "story_v_side_new_1104901.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901020", "story_v_side_new_1104901.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_1, arg_80_1.talkMaxDuration)

			if var_83_0 <= arg_80_1.time_ and arg_80_1.time_ < var_83_0 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_0) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_0 + var_83_10 and arg_80_1.time_ < var_83_0 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play1104901021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 1104901021
		arg_84_1.duration_ = 7.87

		local var_84_0 = {
			zh = 7.866,
			ja = 4.8
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
				arg_84_0:Play1104901022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0
			local var_87_1 = 0.925

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_2 = arg_84_1:FormatText(StoryNameCfg[1006].name)

				arg_84_1.leftNameTxt_.text = var_87_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:GetWordFromCfg(1104901021)
				local var_87_4 = arg_84_1:FormatText(var_87_3.content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 37
				local var_87_6 = utf8.len(var_87_4)
				local var_87_7 = var_87_5 <= 0 and var_87_1 or var_87_1 * (var_87_6 / var_87_5)

				if var_87_7 > 0 and var_87_1 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901021", "story_v_side_new_1104901.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901021", "story_v_side_new_1104901.awb") / 1000

					if var_87_8 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_0
					end

					if var_87_3.prefab_name ~= "" and arg_84_1.actors_[var_87_3.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_3.prefab_name].transform, "story_v_side_new_1104901", "1104901021", "story_v_side_new_1104901.awb")

						arg_84_1:RecordAudio("1104901021", var_87_9)
						arg_84_1:RecordAudio("1104901021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901021", "story_v_side_new_1104901.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901021", "story_v_side_new_1104901.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_10 and arg_84_1.time_ < var_87_0 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play1104901022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 1104901022
		arg_88_1.duration_ = 5.83

		local var_88_0 = {
			zh = 2.266,
			ja = 5.833
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play1104901023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10053ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos10053ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(0, -1.12, -5.99)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10053ui_story, var_91_4, var_91_3)

				local var_91_5 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_5.x, var_91_5.y, var_91_5.z)

				local var_91_6 = var_91_0.localEulerAngles

				var_91_6.z = 0
				var_91_6.x = 0
				var_91_0.localEulerAngles = var_91_6
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_91_7 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_7.x, var_91_7.y, var_91_7.z)

				local var_91_8 = var_91_0.localEulerAngles

				var_91_8.z = 0
				var_91_8.x = 0
				var_91_0.localEulerAngles = var_91_8
			end

			local var_91_9 = arg_88_1.actors_["10053ui_story"]
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect10053ui_story == nil then
				arg_88_1.var_.characterEffect10053ui_story = var_91_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_11 = 0.200000002980232

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 and not isNil(var_91_9) then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11

				if arg_88_1.var_.characterEffect10053ui_story and not isNil(var_91_9) then
					arg_88_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect10053ui_story then
				arg_88_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_91_13 = 0

			if var_91_13 < arg_88_1.time_ and arg_88_1.time_ <= var_91_13 + arg_91_0 then
				arg_88_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_2")
			end

			local var_91_14 = 0

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_91_15 = 0
			local var_91_16 = 0.325

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_17 = arg_88_1:FormatText(StoryNameCfg[477].name)

				arg_88_1.leftNameTxt_.text = var_91_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_18 = arg_88_1:GetWordFromCfg(1104901022)
				local var_91_19 = arg_88_1:FormatText(var_91_18.content)

				arg_88_1.text_.text = var_91_19

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_20 = 13
				local var_91_21 = utf8.len(var_91_19)
				local var_91_22 = var_91_20 <= 0 and var_91_16 or var_91_16 * (var_91_21 / var_91_20)

				if var_91_22 > 0 and var_91_16 < var_91_22 then
					arg_88_1.talkMaxDuration = var_91_22

					if var_91_22 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_22 + var_91_15
					end
				end

				arg_88_1.text_.text = var_91_19
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901022", "story_v_side_new_1104901.awb") ~= 0 then
					local var_91_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901022", "story_v_side_new_1104901.awb") / 1000

					if var_91_23 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_15
					end

					if var_91_18.prefab_name ~= "" and arg_88_1.actors_[var_91_18.prefab_name] ~= nil then
						local var_91_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_18.prefab_name].transform, "story_v_side_new_1104901", "1104901022", "story_v_side_new_1104901.awb")

						arg_88_1:RecordAudio("1104901022", var_91_24)
						arg_88_1:RecordAudio("1104901022", var_91_24)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901022", "story_v_side_new_1104901.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901022", "story_v_side_new_1104901.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_25 = math.max(var_91_16, arg_88_1.talkMaxDuration)

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_25 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_15) / var_91_25

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_15 + var_91_25 and arg_88_1.time_ < var_91_15 + var_91_25 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play1104901023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 1104901023
		arg_92_1.duration_ = 2.93

		local var_92_0 = {
			zh = 2.033,
			ja = 2.933
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play1104901024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10053ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10053ui_story == nil then
				arg_92_1.var_.characterEffect10053ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect10053ui_story and not isNil(var_95_0) then
					local var_95_4 = Mathf.Lerp(0, 0.5, var_95_3)

					arg_92_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10053ui_story.fillRatio = var_95_4
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10053ui_story then
				local var_95_5 = 0.5

				arg_92_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10053ui_story.fillRatio = var_95_5
			end

			local var_95_6 = 0
			local var_95_7 = 0.175

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_8 = arg_92_1:FormatText(StoryNameCfg[1006].name)

				arg_92_1.leftNameTxt_.text = var_95_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_9 = arg_92_1:GetWordFromCfg(1104901023)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 7
				local var_95_12 = utf8.len(var_95_10)
				local var_95_13 = var_95_11 <= 0 and var_95_7 or var_95_7 * (var_95_12 / var_95_11)

				if var_95_13 > 0 and var_95_7 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_10
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901023", "story_v_side_new_1104901.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901023", "story_v_side_new_1104901.awb") / 1000

					if var_95_14 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_6
					end

					if var_95_9.prefab_name ~= "" and arg_92_1.actors_[var_95_9.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_9.prefab_name].transform, "story_v_side_new_1104901", "1104901023", "story_v_side_new_1104901.awb")

						arg_92_1:RecordAudio("1104901023", var_95_15)
						arg_92_1:RecordAudio("1104901023", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901023", "story_v_side_new_1104901.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901023", "story_v_side_new_1104901.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_16 and arg_92_1.time_ < var_95_6 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play1104901024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 1104901024
		arg_96_1.duration_ = 8.3

		local var_96_0 = {
			zh = 8.3,
			ja = 5.366
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play1104901025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10053ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos10053ui_story = var_99_0.localPosition
			end

			local var_99_2 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2
				local var_99_4 = Vector3.New(0, -1.12, -5.99)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10053ui_story, var_99_4, var_99_3)

				local var_99_5 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_5.x, var_99_5.y, var_99_5.z)

				local var_99_6 = var_99_0.localEulerAngles

				var_99_6.z = 0
				var_99_6.x = 0
				var_99_0.localEulerAngles = var_99_6
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_99_7 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_7.x, var_99_7.y, var_99_7.z)

				local var_99_8 = var_99_0.localEulerAngles

				var_99_8.z = 0
				var_99_8.x = 0
				var_99_0.localEulerAngles = var_99_8
			end

			local var_99_9 = arg_96_1.actors_["10053ui_story"]
			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect10053ui_story == nil then
				arg_96_1.var_.characterEffect10053ui_story = var_99_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_11 = 0.200000002980232

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_11 and not isNil(var_99_9) then
				local var_99_12 = (arg_96_1.time_ - var_99_10) / var_99_11

				if arg_96_1.var_.characterEffect10053ui_story and not isNil(var_99_9) then
					arg_96_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_10 + var_99_11 and arg_96_1.time_ < var_99_10 + var_99_11 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect10053ui_story then
				arg_96_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_99_13 = 0

			if var_99_13 < arg_96_1.time_ and arg_96_1.time_ <= var_99_13 + arg_99_0 then
				arg_96_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action6_1")
			end

			local var_99_14 = 0

			if var_99_14 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_99_15 = 0
			local var_99_16 = 1.1

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_17 = arg_96_1:FormatText(StoryNameCfg[477].name)

				arg_96_1.leftNameTxt_.text = var_99_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(1104901024)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 44
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901024", "story_v_side_new_1104901.awb") ~= 0 then
					local var_99_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901024", "story_v_side_new_1104901.awb") / 1000

					if var_99_23 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_15
					end

					if var_99_18.prefab_name ~= "" and arg_96_1.actors_[var_99_18.prefab_name] ~= nil then
						local var_99_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_18.prefab_name].transform, "story_v_side_new_1104901", "1104901024", "story_v_side_new_1104901.awb")

						arg_96_1:RecordAudio("1104901024", var_99_24)
						arg_96_1:RecordAudio("1104901024", var_99_24)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901024", "story_v_side_new_1104901.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901024", "story_v_side_new_1104901.awb")
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
				actorName = "10053ui_story",
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
	Play1104901025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 1104901025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play1104901026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["10053ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect10053ui_story == nil then
				arg_100_1.var_.characterEffect10053ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect10053ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10053ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect10053ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10053ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_103_7 = 0

			if var_103_7 < arg_100_1.time_ and arg_100_1.time_ <= var_103_7 + arg_103_0 then
				arg_100_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action6_2")
			end

			local var_103_8 = 0
			local var_103_9 = 0.425

			if var_103_8 < arg_100_1.time_ and arg_100_1.time_ <= var_103_8 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_10 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_11 = arg_100_1:GetWordFromCfg(1104901025)
				local var_103_12 = arg_100_1:FormatText(var_103_11.content)

				arg_100_1.text_.text = var_103_12

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_13 = 17
				local var_103_14 = utf8.len(var_103_12)
				local var_103_15 = var_103_13 <= 0 and var_103_9 or var_103_9 * (var_103_14 / var_103_13)

				if var_103_15 > 0 and var_103_9 < var_103_15 then
					arg_100_1.talkMaxDuration = var_103_15

					if var_103_15 + var_103_8 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_15 + var_103_8
					end
				end

				arg_100_1.text_.text = var_103_12
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_9, arg_100_1.talkMaxDuration)

			if var_103_8 <= arg_100_1.time_ and arg_100_1.time_ < var_103_8 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_8) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_8 + var_103_16 and arg_100_1.time_ < var_103_8 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play1104901026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 1104901026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play1104901027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.95

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

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(1104901026)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 38
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
	Play1104901027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 1104901027
		arg_108_1.duration_ = 7.9

		local var_108_0 = {
			zh = 6.466,
			ja = 7.9
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
				arg_108_0:Play1104901028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["10053ui_story"].transform
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.var_.moveOldPos10053ui_story = var_111_0.localPosition
			end

			local var_111_2 = 0.001

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2
				local var_111_4 = Vector3.New(0, -1.12, -5.99)

				var_111_0.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10053ui_story, var_111_4, var_111_3)

				local var_111_5 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_5.x, var_111_5.y, var_111_5.z)

				local var_111_6 = var_111_0.localEulerAngles

				var_111_6.z = 0
				var_111_6.x = 0
				var_111_0.localEulerAngles = var_111_6
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 then
				var_111_0.localPosition = Vector3.New(0, -1.12, -5.99)

				local var_111_7 = manager.ui.mainCamera.transform.position - var_111_0.position

				var_111_0.forward = Vector3.New(var_111_7.x, var_111_7.y, var_111_7.z)

				local var_111_8 = var_111_0.localEulerAngles

				var_111_8.z = 0
				var_111_8.x = 0
				var_111_0.localEulerAngles = var_111_8
			end

			local var_111_9 = arg_108_1.actors_["10053ui_story"]
			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect10053ui_story == nil then
				arg_108_1.var_.characterEffect10053ui_story = var_111_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_11 = 0.200000002980232

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_11 and not isNil(var_111_9) then
				local var_111_12 = (arg_108_1.time_ - var_111_10) / var_111_11

				if arg_108_1.var_.characterEffect10053ui_story and not isNil(var_111_9) then
					arg_108_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_10 + var_111_11 and arg_108_1.time_ < var_111_10 + var_111_11 + arg_111_0 and not isNil(var_111_9) and arg_108_1.var_.characterEffect10053ui_story then
				arg_108_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_111_13 = 0

			if var_111_13 < arg_108_1.time_ and arg_108_1.time_ <= var_111_13 + arg_111_0 then
				arg_108_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action1_1")
			end

			local var_111_14 = 0

			if var_111_14 < arg_108_1.time_ and arg_108_1.time_ <= var_111_14 + arg_111_0 then
				arg_108_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_111_15 = 0
			local var_111_16 = 0.775

			if var_111_15 < arg_108_1.time_ and arg_108_1.time_ <= var_111_15 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_17 = arg_108_1:FormatText(StoryNameCfg[477].name)

				arg_108_1.leftNameTxt_.text = var_111_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_18 = arg_108_1:GetWordFromCfg(1104901027)
				local var_111_19 = arg_108_1:FormatText(var_111_18.content)

				arg_108_1.text_.text = var_111_19

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_20 = 31
				local var_111_21 = utf8.len(var_111_19)
				local var_111_22 = var_111_20 <= 0 and var_111_16 or var_111_16 * (var_111_21 / var_111_20)

				if var_111_22 > 0 and var_111_16 < var_111_22 then
					arg_108_1.talkMaxDuration = var_111_22

					if var_111_22 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_22 + var_111_15
					end
				end

				arg_108_1.text_.text = var_111_19
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901027", "story_v_side_new_1104901.awb") ~= 0 then
					local var_111_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901027", "story_v_side_new_1104901.awb") / 1000

					if var_111_23 + var_111_15 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_23 + var_111_15
					end

					if var_111_18.prefab_name ~= "" and arg_108_1.actors_[var_111_18.prefab_name] ~= nil then
						local var_111_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_18.prefab_name].transform, "story_v_side_new_1104901", "1104901027", "story_v_side_new_1104901.awb")

						arg_108_1:RecordAudio("1104901027", var_111_24)
						arg_108_1:RecordAudio("1104901027", var_111_24)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901027", "story_v_side_new_1104901.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901027", "story_v_side_new_1104901.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_25 = math.max(var_111_16, arg_108_1.talkMaxDuration)

			if var_111_15 <= arg_108_1.time_ and arg_108_1.time_ < var_111_15 + var_111_25 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_15) / var_111_25

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_15 + var_111_25 and arg_108_1.time_ < var_111_15 + var_111_25 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play1104901028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 1104901028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play1104901029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10053ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10053ui_story == nil then
				arg_112_1.var_.characterEffect10053ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect10053ui_story and not isNil(var_115_0) then
					local var_115_4 = Mathf.Lerp(0, 0.5, var_115_3)

					arg_112_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_112_1.var_.characterEffect10053ui_story.fillRatio = var_115_4
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect10053ui_story then
				local var_115_5 = 0.5

				arg_112_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_112_1.var_.characterEffect10053ui_story.fillRatio = var_115_5
			end

			local var_115_6 = 0
			local var_115_7 = 0.775

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_8 = arg_112_1:GetWordFromCfg(1104901028)
				local var_115_9 = arg_112_1:FormatText(var_115_8.content)

				arg_112_1.text_.text = var_115_9

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_10 = 31
				local var_115_11 = utf8.len(var_115_9)
				local var_115_12 = var_115_10 <= 0 and var_115_7 or var_115_7 * (var_115_11 / var_115_10)

				if var_115_12 > 0 and var_115_7 < var_115_12 then
					arg_112_1.talkMaxDuration = var_115_12

					if var_115_12 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_9
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_13 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_13 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_13

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_13 and arg_112_1.time_ < var_115_6 + var_115_13 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play1104901029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 1104901029
		arg_116_1.duration_ = 8.8

		local var_116_0 = {
			zh = 4.4,
			ja = 8.8
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play1104901030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action8_1")
			end

			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1:PlayTimeline("10053ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_119_2 = arg_116_1.actors_["10053ui_story"]
			local var_119_3 = 0

			if var_119_3 < arg_116_1.time_ and arg_116_1.time_ <= var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect10053ui_story == nil then
				arg_116_1.var_.characterEffect10053ui_story = var_119_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_4 = 0.2

			if var_119_3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_3 + var_119_4 and not isNil(var_119_2) then
				local var_119_5 = (arg_116_1.time_ - var_119_3) / var_119_4

				if arg_116_1.var_.characterEffect10053ui_story and not isNil(var_119_2) then
					arg_116_1.var_.characterEffect10053ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_3 + var_119_4 and arg_116_1.time_ < var_119_3 + var_119_4 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect10053ui_story then
				arg_116_1.var_.characterEffect10053ui_story.fillFlat = false
			end

			local var_119_6 = 0
			local var_119_7 = 0.575

			if var_119_6 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_8 = arg_116_1:FormatText(StoryNameCfg[477].name)

				arg_116_1.leftNameTxt_.text = var_119_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_9 = arg_116_1:GetWordFromCfg(1104901029)
				local var_119_10 = arg_116_1:FormatText(var_119_9.content)

				arg_116_1.text_.text = var_119_10

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_11 = 23
				local var_119_12 = utf8.len(var_119_10)
				local var_119_13 = var_119_11 <= 0 and var_119_7 or var_119_7 * (var_119_12 / var_119_11)

				if var_119_13 > 0 and var_119_7 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_6
					end
				end

				arg_116_1.text_.text = var_119_10
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901029", "story_v_side_new_1104901.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901029", "story_v_side_new_1104901.awb") / 1000

					if var_119_14 + var_119_6 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_6
					end

					if var_119_9.prefab_name ~= "" and arg_116_1.actors_[var_119_9.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_9.prefab_name].transform, "story_v_side_new_1104901", "1104901029", "story_v_side_new_1104901.awb")

						arg_116_1:RecordAudio("1104901029", var_119_15)
						arg_116_1:RecordAudio("1104901029", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901029", "story_v_side_new_1104901.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901029", "story_v_side_new_1104901.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_7, arg_116_1.talkMaxDuration)

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_6) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_6 + var_119_16 and arg_116_1.time_ < var_119_6 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play1104901030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 1104901030
		arg_120_1.duration_ = 1.6

		local var_120_0 = {
			zh = 1.566,
			ja = 1.6
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play1104901031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["10053ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect10053ui_story == nil then
				arg_120_1.var_.characterEffect10053ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect10053ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_120_1.var_.characterEffect10053ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect10053ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_120_1.var_.characterEffect10053ui_story.fillRatio = var_123_5
			end

			local var_123_6 = 0
			local var_123_7 = 0.15

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[1006].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_9 = arg_120_1:GetWordFromCfg(1104901030)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 6
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901030", "story_v_side_new_1104901.awb") ~= 0 then
					local var_123_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901030", "story_v_side_new_1104901.awb") / 1000

					if var_123_14 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_6
					end

					if var_123_9.prefab_name ~= "" and arg_120_1.actors_[var_123_9.prefab_name] ~= nil then
						local var_123_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_9.prefab_name].transform, "story_v_side_new_1104901", "1104901030", "story_v_side_new_1104901.awb")

						arg_120_1:RecordAudio("1104901030", var_123_15)
						arg_120_1:RecordAudio("1104901030", var_123_15)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901030", "story_v_side_new_1104901.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901030", "story_v_side_new_1104901.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_16 and arg_120_1.time_ < var_123_6 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play1104901031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 1104901031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play1104901032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10053ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos10053ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0, 100, 0)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10053ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, 100, 0)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = arg_124_1.actors_["10053ui_story"]
			local var_127_10 = 0

			if var_127_10 < arg_124_1.time_ and arg_124_1.time_ <= var_127_10 + arg_127_0 and not isNil(var_127_9) and arg_124_1.var_.characterEffect10053ui_story == nil then
				arg_124_1.var_.characterEffect10053ui_story = var_127_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_11 = 0.200000002980232

			if var_127_10 <= arg_124_1.time_ and arg_124_1.time_ < var_127_10 + var_127_11 and not isNil(var_127_9) then
				local var_127_12 = (arg_124_1.time_ - var_127_10) / var_127_11

				if arg_124_1.var_.characterEffect10053ui_story and not isNil(var_127_9) then
					local var_127_13 = Mathf.Lerp(0, 0.5, var_127_12)

					arg_124_1.var_.characterEffect10053ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10053ui_story.fillRatio = var_127_13
				end
			end

			if arg_124_1.time_ >= var_127_10 + var_127_11 and arg_124_1.time_ < var_127_10 + var_127_11 + arg_127_0 and not isNil(var_127_9) and arg_124_1.var_.characterEffect10053ui_story then
				local var_127_14 = 0.5

				arg_124_1.var_.characterEffect10053ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10053ui_story.fillRatio = var_127_14
			end

			local var_127_15 = 0
			local var_127_16 = 1.175

			if var_127_15 < arg_124_1.time_ and arg_124_1.time_ <= var_127_15 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_17 = arg_124_1:GetWordFromCfg(1104901031)
				local var_127_18 = arg_124_1:FormatText(var_127_17.content)

				arg_124_1.text_.text = var_127_18

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_19 = 47
				local var_127_20 = utf8.len(var_127_18)
				local var_127_21 = var_127_19 <= 0 and var_127_16 or var_127_16 * (var_127_20 / var_127_19)

				if var_127_21 > 0 and var_127_16 < var_127_21 then
					arg_124_1.talkMaxDuration = var_127_21

					if var_127_21 + var_127_15 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_21 + var_127_15
					end
				end

				arg_124_1.text_.text = var_127_18
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_22 = math.max(var_127_16, arg_124_1.talkMaxDuration)

			if var_127_15 <= arg_124_1.time_ and arg_124_1.time_ < var_127_15 + var_127_22 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_15) / var_127_22

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_15 + var_127_22 and arg_124_1.time_ < var_127_15 + var_127_22 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10053ui_story",
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
	Play1104901032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 1104901032
		arg_128_1.duration_ = 9

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play1104901033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = "K01h"

			if arg_128_1.bgs_[var_131_0] == nil then
				local var_131_1 = Object.Instantiate(arg_128_1.paintGo_)

				var_131_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_131_0)
				var_131_1.name = var_131_0
				var_131_1.transform.parent = arg_128_1.stage_.transform
				var_131_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.bgs_[var_131_0] = var_131_1
			end

			local var_131_2 = 2

			if var_131_2 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				local var_131_3 = manager.ui.mainCamera.transform.localPosition
				local var_131_4 = Vector3.New(0, 0, 10) + Vector3.New(var_131_3.x, var_131_3.y, 0)
				local var_131_5 = arg_128_1.bgs_.K01h

				var_131_5.transform.localPosition = var_131_4
				var_131_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_131_6 = var_131_5:GetComponent("SpriteRenderer")

				if var_131_6 and var_131_6.sprite then
					local var_131_7 = (var_131_5.transform.localPosition - var_131_3).z
					local var_131_8 = manager.ui.mainCameraCom_
					local var_131_9 = 2 * var_131_7 * Mathf.Tan(var_131_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_131_10 = var_131_9 * var_131_8.aspect
					local var_131_11 = var_131_6.sprite.bounds.size.x
					local var_131_12 = var_131_6.sprite.bounds.size.y
					local var_131_13 = var_131_10 / var_131_11
					local var_131_14 = var_131_9 / var_131_12
					local var_131_15 = var_131_14 < var_131_13 and var_131_13 or var_131_14

					var_131_5.transform.localScale = Vector3.New(var_131_15, var_131_15, 0)
				end

				for iter_131_0, iter_131_1 in pairs(arg_128_1.bgs_) do
					if iter_131_0 ~= "K01h" then
						iter_131_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_131_16 = 4

			if var_131_16 < arg_128_1.time_ and arg_128_1.time_ <= var_131_16 + arg_131_0 then
				arg_128_1.allBtn_.enabled = false
			end

			local var_131_17 = 0.3

			if arg_128_1.time_ >= var_131_16 + var_131_17 and arg_128_1.time_ < var_131_16 + var_131_17 + arg_131_0 then
				arg_128_1.allBtn_.enabled = true
			end

			local var_131_18 = 0

			if var_131_18 < arg_128_1.time_ and arg_128_1.time_ <= var_131_18 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_19 = 2

			if var_131_18 <= arg_128_1.time_ and arg_128_1.time_ < var_131_18 + var_131_19 then
				local var_131_20 = (arg_128_1.time_ - var_131_18) / var_131_19
				local var_131_21 = Color.New(0, 0, 0)

				var_131_21.a = Mathf.Lerp(0, 1, var_131_20)
				arg_128_1.mask_.color = var_131_21
			end

			if arg_128_1.time_ >= var_131_18 + var_131_19 and arg_128_1.time_ < var_131_18 + var_131_19 + arg_131_0 then
				local var_131_22 = Color.New(0, 0, 0)

				var_131_22.a = 1
				arg_128_1.mask_.color = var_131_22
			end

			local var_131_23 = 2

			if var_131_23 < arg_128_1.time_ and arg_128_1.time_ <= var_131_23 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_24 = 2

			if var_131_23 <= arg_128_1.time_ and arg_128_1.time_ < var_131_23 + var_131_24 then
				local var_131_25 = (arg_128_1.time_ - var_131_23) / var_131_24
				local var_131_26 = Color.New(0, 0, 0)

				var_131_26.a = Mathf.Lerp(1, 0, var_131_25)
				arg_128_1.mask_.color = var_131_26
			end

			if arg_128_1.time_ >= var_131_23 + var_131_24 and arg_128_1.time_ < var_131_23 + var_131_24 + arg_131_0 then
				local var_131_27 = Color.New(0, 0, 0)
				local var_131_28 = 0

				arg_128_1.mask_.enabled = false
				var_131_27.a = var_131_28
				arg_128_1.mask_.color = var_131_27
			end

			local var_131_29 = manager.ui.mainCamera.transform
			local var_131_30 = 1.9

			if var_131_30 < arg_128_1.time_ and arg_128_1.time_ <= var_131_30 + arg_131_0 then
				local var_131_31 = arg_128_1.var_.effectxiayu1

				if var_131_31 then
					Object.Destroy(var_131_31)

					arg_128_1.var_.effectxiayu1 = nil
				end
			end

			if arg_128_1.frameCnt_ <= 1 then
				arg_128_1.dialog_:SetActive(false)
			end

			local var_131_32 = 4
			local var_131_33 = 0.975

			if var_131_32 < arg_128_1.time_ and arg_128_1.time_ <= var_131_32 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0

				arg_128_1.dialog_:SetActive(true)

				arg_128_1.dialogCg_.alpha = 0

				local var_131_34 = LeanTween.value(arg_128_1.dialog_, 0, 1, 0.3)

				var_131_34:setOnUpdate(LuaHelper.FloatAction(function(arg_132_0)
					arg_128_1.dialogCg_.alpha = arg_132_0
				end))
				var_131_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_128_1.dialog_)
					var_131_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_128_1.duration_ = arg_128_1.duration_ + 0.3

				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_35 = arg_128_1:GetWordFromCfg(1104901032)
				local var_131_36 = arg_128_1:FormatText(var_131_35.content)

				arg_128_1.text_.text = var_131_36

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_37 = 39
				local var_131_38 = utf8.len(var_131_36)
				local var_131_39 = var_131_37 <= 0 and var_131_33 or var_131_33 * (var_131_38 / var_131_37)

				if var_131_39 > 0 and var_131_33 < var_131_39 then
					arg_128_1.talkMaxDuration = var_131_39
					var_131_32 = var_131_32 + 0.3

					if var_131_39 + var_131_32 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_39 + var_131_32
					end
				end

				arg_128_1.text_.text = var_131_36
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_40 = var_131_32 + 0.3
			local var_131_41 = math.max(var_131_33, arg_128_1.talkMaxDuration)

			if var_131_40 <= arg_128_1.time_ and arg_128_1.time_ < var_131_40 + var_131_41 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_40) / var_131_41

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_40 + var_131_41 and arg_128_1.time_ < var_131_40 + var_131_41 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play1104901033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1104901033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1104901034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 1.475

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_2 = arg_134_1:GetWordFromCfg(1104901033)
				local var_137_3 = arg_134_1:FormatText(var_137_2.content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 59
				local var_137_5 = utf8.len(var_137_3)
				local var_137_6 = var_137_4 <= 0 and var_137_1 or var_137_1 * (var_137_5 / var_137_4)

				if var_137_6 > 0 and var_137_1 < var_137_6 then
					arg_134_1.talkMaxDuration = var_137_6

					if var_137_6 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_7 and arg_134_1.time_ < var_137_0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1104901034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1104901034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1104901035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0
			local var_141_1 = 1.125

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_2 = arg_138_1:GetWordFromCfg(1104901034)
				local var_141_3 = arg_138_1:FormatText(var_141_2.content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 45
				local var_141_5 = utf8.len(var_141_3)
				local var_141_6 = var_141_4 <= 0 and var_141_1 or var_141_1 * (var_141_5 / var_141_4)

				if var_141_6 > 0 and var_141_1 < var_141_6 then
					arg_138_1.talkMaxDuration = var_141_6

					if var_141_6 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_7 and arg_138_1.time_ < var_141_0 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play1104901035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1104901035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1104901036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.375

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_2 = arg_142_1:GetWordFromCfg(1104901035)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 15
				local var_145_5 = utf8.len(var_145_3)
				local var_145_6 = var_145_4 <= 0 and var_145_1 or var_145_1 * (var_145_5 / var_145_4)

				if var_145_6 > 0 and var_145_1 < var_145_6 then
					arg_142_1.talkMaxDuration = var_145_6

					if var_145_6 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_7 and arg_142_1.time_ < var_145_0 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play1104901036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1104901036
		arg_146_1.duration_ = 1.2

		local var_146_0 = {
			zh = 1.066,
			ja = 1.2
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1104901037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = manager.ui.mainCamera.transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.shakeOldPos = var_149_0.localPosition
			end

			local var_149_2 = 0.6

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / 0.066
				local var_149_4, var_149_5 = math.modf(var_149_3)

				var_149_0.localPosition = Vector3.New(var_149_5 * 0.13, var_149_5 * 0.13, var_149_5 * 0.13) + arg_146_1.var_.shakeOldPos
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 then
				var_149_0.localPosition = arg_146_1.var_.shakeOldPos
			end

			local var_149_6 = 0

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.allBtn_.enabled = false
			end

			local var_149_7 = 0.6

			if arg_146_1.time_ >= var_149_6 + var_149_7 and arg_146_1.time_ < var_149_6 + var_149_7 + arg_149_0 then
				arg_146_1.allBtn_.enabled = true
			end

			local var_149_8 = 0
			local var_149_9 = 0.075

			if var_149_8 < arg_146_1.time_ and arg_146_1.time_ <= var_149_8 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0

				arg_146_1.dialog_:SetActive(true)

				arg_146_1.dialogCg_.alpha = 0

				local var_149_10 = LeanTween.value(arg_146_1.dialog_, 0, 1, 0.3)

				var_149_10:setOnUpdate(LuaHelper.FloatAction(function(arg_150_0)
					arg_146_1.dialogCg_.alpha = arg_150_0
				end))
				var_149_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_146_1.dialog_)
					var_149_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_146_1.duration_ = arg_146_1.duration_ + 0.3

				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_11 = arg_146_1:FormatText(StoryNameCfg[551].name)

				arg_146_1.leftNameTxt_.text = var_149_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_12 = arg_146_1:GetWordFromCfg(1104901036)
				local var_149_13 = arg_146_1:FormatText(var_149_12.content)

				arg_146_1.text_.text = var_149_13

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_14 = 3
				local var_149_15 = utf8.len(var_149_13)
				local var_149_16 = var_149_14 <= 0 and var_149_9 or var_149_9 * (var_149_15 / var_149_14)

				if var_149_16 > 0 and var_149_9 < var_149_16 then
					arg_146_1.talkMaxDuration = var_149_16
					var_149_8 = var_149_8 + 0.3

					if var_149_16 + var_149_8 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_16 + var_149_8
					end
				end

				arg_146_1.text_.text = var_149_13
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901036", "story_v_side_new_1104901.awb") ~= 0 then
					local var_149_17 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901036", "story_v_side_new_1104901.awb") / 1000

					if var_149_17 + var_149_8 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_17 + var_149_8
					end

					if var_149_12.prefab_name ~= "" and arg_146_1.actors_[var_149_12.prefab_name] ~= nil then
						local var_149_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_12.prefab_name].transform, "story_v_side_new_1104901", "1104901036", "story_v_side_new_1104901.awb")

						arg_146_1:RecordAudio("1104901036", var_149_18)
						arg_146_1:RecordAudio("1104901036", var_149_18)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901036", "story_v_side_new_1104901.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901036", "story_v_side_new_1104901.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_19 = var_149_8 + 0.3
			local var_149_20 = math.max(var_149_9, arg_146_1.talkMaxDuration)

			if var_149_19 <= arg_146_1.time_ and arg_146_1.time_ < var_149_19 + var_149_20 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_19) / var_149_20

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_19 + var_149_20 and arg_146_1.time_ < var_149_19 + var_149_20 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play1104901037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 1104901037
		arg_152_1.duration_ = 3.53

		local var_152_0 = {
			zh = 3,
			ja = 3.533
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
				arg_152_0:Play1104901038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 0.5

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[551].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:GetWordFromCfg(1104901037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901037", "story_v_side_new_1104901.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901037", "story_v_side_new_1104901.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_side_new_1104901", "1104901037", "story_v_side_new_1104901.awb")

						arg_152_1:RecordAudio("1104901037", var_155_9)
						arg_152_1:RecordAudio("1104901037", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901037", "story_v_side_new_1104901.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901037", "story_v_side_new_1104901.awb")
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
	Play1104901038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 1104901038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play1104901039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 0.775

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_2 = arg_156_1:GetWordFromCfg(1104901038)
				local var_159_3 = arg_156_1:FormatText(var_159_2.content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 31
				local var_159_5 = utf8.len(var_159_3)
				local var_159_6 = var_159_4 <= 0 and var_159_1 or var_159_1 * (var_159_5 / var_159_4)

				if var_159_6 > 0 and var_159_1 < var_159_6 then
					arg_156_1.talkMaxDuration = var_159_6

					if var_159_6 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_7 and arg_156_1.time_ < var_159_0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play1104901039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 1104901039
		arg_160_1.duration_ = 5.73

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play1104901040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.133333333333333

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_1 = 0.6

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_1 then
				local var_163_2 = (arg_160_1.time_ - var_163_0) / var_163_1
				local var_163_3 = Color.New(1, 1, 1)

				var_163_3.a = Mathf.Lerp(1, 0, var_163_2)
				arg_160_1.mask_.color = var_163_3
			end

			if arg_160_1.time_ >= var_163_0 + var_163_1 and arg_160_1.time_ < var_163_0 + var_163_1 + arg_163_0 then
				local var_163_4 = Color.New(1, 1, 1)
				local var_163_5 = 0

				arg_160_1.mask_.enabled = false
				var_163_4.a = var_163_5
				arg_160_1.mask_.color = var_163_4
			end

			local var_163_6 = manager.ui.mainCamera.transform
			local var_163_7 = 0.133333333333333

			if var_163_7 < arg_160_1.time_ and arg_160_1.time_ <= var_163_7 + arg_163_0 then
				local var_163_8 = arg_160_1.var_.effectlushui1
				local var_163_9
				local var_163_10 = var_163_6

				if not var_163_8 then
					var_163_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), var_163_10)
					var_163_8.name = "lushui1"
					arg_160_1.var_.effectlushui1 = var_163_8
				else
					var_163_8.transform:SetParent(var_163_10)
				end

				var_163_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_163_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_163_11 = 0

			if var_163_11 < arg_160_1.time_ and arg_160_1.time_ <= var_163_11 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			local var_163_12 = 0.733333333333333

			if arg_160_1.time_ >= var_163_11 + var_163_12 and arg_160_1.time_ < var_163_11 + var_163_12 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_13 = 0
			local var_163_14 = 1

			if var_163_13 < arg_160_1.time_ and arg_160_1.time_ <= var_163_13 + arg_163_0 then
				local var_163_15 = "play"
				local var_163_16 = "effect"

				arg_160_1:AudioAction(var_163_15, var_163_16, "se_story_side_1049", "se_story_side_1049_rain", "")
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_17 = 0.733333333333333
			local var_163_18 = 0.75

			if var_163_17 < arg_160_1.time_ and arg_160_1.time_ <= var_163_17 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_19 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_19:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_20 = arg_160_1:GetWordFromCfg(1104901039)
				local var_163_21 = arg_160_1:FormatText(var_163_20.content)

				arg_160_1.text_.text = var_163_21

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_22 = 30
				local var_163_23 = utf8.len(var_163_21)
				local var_163_24 = var_163_22 <= 0 and var_163_18 or var_163_18 * (var_163_23 / var_163_22)

				if var_163_24 > 0 and var_163_18 < var_163_24 then
					arg_160_1.talkMaxDuration = var_163_24
					var_163_17 = var_163_17 + 0.3

					if var_163_24 + var_163_17 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_24 + var_163_17
					end
				end

				arg_160_1.text_.text = var_163_21
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_25 = var_163_17 + 0.3
			local var_163_26 = math.max(var_163_18, arg_160_1.talkMaxDuration)

			if var_163_25 <= arg_160_1.time_ and arg_160_1.time_ < var_163_25 + var_163_26 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_25) / var_163_26

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_25 + var_163_26 and arg_160_1.time_ < var_163_25 + var_163_26 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play1104901040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1104901040
		arg_166_1.duration_ = 2.53

		local var_166_0 = {
			zh = 2.533,
			ja = 2.366
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1104901041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0
			local var_169_1 = 0.1

			if var_169_0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_2 = arg_166_1:FormatText(StoryNameCfg[551].name)

				arg_166_1.leftNameTxt_.text = var_169_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1049")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:GetWordFromCfg(1104901040)
				local var_169_4 = arg_166_1:FormatText(var_169_3.content)

				arg_166_1.text_.text = var_169_4

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 4
				local var_169_6 = utf8.len(var_169_4)
				local var_169_7 = var_169_5 <= 0 and var_169_1 or var_169_1 * (var_169_6 / var_169_5)

				if var_169_7 > 0 and var_169_1 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_0
					end
				end

				arg_166_1.text_.text = var_169_4
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901040", "story_v_side_new_1104901.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901040", "story_v_side_new_1104901.awb") / 1000

					if var_169_8 + var_169_0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_0
					end

					if var_169_3.prefab_name ~= "" and arg_166_1.actors_[var_169_3.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_3.prefab_name].transform, "story_v_side_new_1104901", "1104901040", "story_v_side_new_1104901.awb")

						arg_166_1:RecordAudio("1104901040", var_169_9)
						arg_166_1:RecordAudio("1104901040", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901040", "story_v_side_new_1104901.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901040", "story_v_side_new_1104901.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_1, arg_166_1.talkMaxDuration)

			if var_169_0 <= arg_166_1.time_ and arg_166_1.time_ < var_169_0 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_0) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_0 + var_169_10 and arg_166_1.time_ < var_169_0 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play1104901041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1104901041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1104901042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0
			local var_173_1 = 0.9

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_2 = arg_170_1:GetWordFromCfg(1104901041)
				local var_173_3 = arg_170_1:FormatText(var_173_2.content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 36
				local var_173_5 = utf8.len(var_173_3)
				local var_173_6 = var_173_4 <= 0 and var_173_1 or var_173_1 * (var_173_5 / var_173_4)

				if var_173_6 > 0 and var_173_1 < var_173_6 then
					arg_170_1.talkMaxDuration = var_173_6

					if var_173_6 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_7 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_7 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_7

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_7 and arg_170_1.time_ < var_173_0 + var_173_7 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play1104901042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1104901042
		arg_174_1.duration_ = 6.5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1104901043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.mask_.enabled = true
				arg_174_1.mask_.raycastTarget = true

				arg_174_1:SetGaussion(false)
			end

			local var_177_1 = 1

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_1 then
				local var_177_2 = (arg_174_1.time_ - var_177_0) / var_177_1
				local var_177_3 = Color.New(0, 0, 0)

				var_177_3.a = Mathf.Lerp(0, 1, var_177_2)
				arg_174_1.mask_.color = var_177_3
			end

			if arg_174_1.time_ >= var_177_0 + var_177_1 and arg_174_1.time_ < var_177_0 + var_177_1 + arg_177_0 then
				local var_177_4 = Color.New(0, 0, 0)

				var_177_4.a = 1
				arg_174_1.mask_.color = var_177_4
			end

			local var_177_5 = 1

			if var_177_5 < arg_174_1.time_ and arg_174_1.time_ <= var_177_5 + arg_177_0 then
				arg_174_1.mask_.enabled = true
				arg_174_1.mask_.raycastTarget = true

				arg_174_1:SetGaussion(false)
			end

			local var_177_6 = 1

			if var_177_5 <= arg_174_1.time_ and arg_174_1.time_ < var_177_5 + var_177_6 then
				local var_177_7 = (arg_174_1.time_ - var_177_5) / var_177_6
				local var_177_8 = Color.New(0, 0, 0)

				var_177_8.a = Mathf.Lerp(1, 0, var_177_7)
				arg_174_1.mask_.color = var_177_8
			end

			if arg_174_1.time_ >= var_177_5 + var_177_6 and arg_174_1.time_ < var_177_5 + var_177_6 + arg_177_0 then
				local var_177_9 = Color.New(0, 0, 0)
				local var_177_10 = 0

				arg_174_1.mask_.enabled = false
				var_177_9.a = var_177_10
				arg_174_1.mask_.color = var_177_9
			end

			local var_177_11 = manager.ui.mainCamera.transform
			local var_177_12 = 1

			if var_177_12 < arg_174_1.time_ and arg_174_1.time_ <= var_177_12 + arg_177_0 then
				local var_177_13 = arg_174_1.var_.effectlushui1

				if var_177_13 then
					Object.Destroy(var_177_13)

					arg_174_1.var_.effectlushui1 = nil
				end
			end

			if arg_174_1.frameCnt_ <= 1 then
				arg_174_1.dialog_:SetActive(false)
			end

			local var_177_14 = 1.5
			local var_177_15 = 1.425

			if var_177_14 < arg_174_1.time_ and arg_174_1.time_ <= var_177_14 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0

				arg_174_1.dialog_:SetActive(true)

				arg_174_1.dialogCg_.alpha = 0

				local var_177_16 = LeanTween.value(arg_174_1.dialog_, 0, 1, 0.3)

				var_177_16:setOnUpdate(LuaHelper.FloatAction(function(arg_178_0)
					arg_174_1.dialogCg_.alpha = arg_178_0
				end))
				var_177_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_174_1.dialog_)
					var_177_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_174_1.duration_ = arg_174_1.duration_ + 0.3

				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_17 = arg_174_1:GetWordFromCfg(1104901042)
				local var_177_18 = arg_174_1:FormatText(var_177_17.content)

				arg_174_1.text_.text = var_177_18

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_19 = 57
				local var_177_20 = utf8.len(var_177_18)
				local var_177_21 = var_177_19 <= 0 and var_177_15 or var_177_15 * (var_177_20 / var_177_19)

				if var_177_21 > 0 and var_177_15 < var_177_21 then
					arg_174_1.talkMaxDuration = var_177_21
					var_177_14 = var_177_14 + 0.3

					if var_177_21 + var_177_14 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_21 + var_177_14
					end
				end

				arg_174_1.text_.text = var_177_18
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_22 = var_177_14 + 0.3
			local var_177_23 = math.max(var_177_15, arg_174_1.talkMaxDuration)

			if var_177_22 <= arg_174_1.time_ and arg_174_1.time_ < var_177_22 + var_177_23 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_22) / var_177_23

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_22 + var_177_23 and arg_174_1.time_ < var_177_22 + var_177_23 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play1104901043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 1104901043
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play1104901044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0
			local var_183_1 = 0.425

			if var_183_0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_2 = arg_180_1:FormatText(StoryNameCfg[7].name)

				arg_180_1.leftNameTxt_.text = var_183_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_3 = arg_180_1:GetWordFromCfg(1104901043)
				local var_183_4 = arg_180_1:FormatText(var_183_3.content)

				arg_180_1.text_.text = var_183_4

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_5 = 17
				local var_183_6 = utf8.len(var_183_4)
				local var_183_7 = var_183_5 <= 0 and var_183_1 or var_183_1 * (var_183_6 / var_183_5)

				if var_183_7 > 0 and var_183_1 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_0
					end
				end

				arg_180_1.text_.text = var_183_4
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_8 = math.max(var_183_1, arg_180_1.talkMaxDuration)

			if var_183_0 <= arg_180_1.time_ and arg_180_1.time_ < var_183_0 + var_183_8 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_0) / var_183_8

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_0 + var_183_8 and arg_180_1.time_ < var_183_0 + var_183_8 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play1104901044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 1104901044
		arg_184_1.duration_ = 2.6

		local var_184_0 = {
			zh = 2.6,
			ja = 2.466
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
				arg_184_0:Play1104901045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = "1049ui_story"

			if arg_184_1.actors_[var_187_0] == nil then
				local var_187_1 = Asset.Load("Char/" .. "1049ui_story")

				if not isNil(var_187_1) then
					local var_187_2 = Object.Instantiate(Asset.Load("Char/" .. "1049ui_story"), arg_184_1.stage_.transform)

					var_187_2.name = var_187_0
					var_187_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_184_1.actors_[var_187_0] = var_187_2

					local var_187_3 = var_187_2:GetComponentInChildren(typeof(CharacterEffect))

					var_187_3.enabled = true

					local var_187_4 = GameObjectTools.GetOrAddComponent(var_187_2, typeof(DynamicBoneHelper))

					if var_187_4 then
						var_187_4:EnableDynamicBone(false)
					end

					arg_184_1:ShowWeapon(var_187_3.transform, false)

					arg_184_1.var_[var_187_0 .. "Animator"] = var_187_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_184_1.var_[var_187_0 .. "Animator"].applyRootMotion = true
					arg_184_1.var_[var_187_0 .. "LipSync"] = var_187_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_187_5 = arg_184_1.actors_["1049ui_story"].transform
			local var_187_6 = 0

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.var_.moveOldPos1049ui_story = var_187_5.localPosition
			end

			local var_187_7 = 0.001

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_7 then
				local var_187_8 = (arg_184_1.time_ - var_187_6) / var_187_7
				local var_187_9 = Vector3.New(0, -1.2, -6)

				var_187_5.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos1049ui_story, var_187_9, var_187_8)

				local var_187_10 = manager.ui.mainCamera.transform.position - var_187_5.position

				var_187_5.forward = Vector3.New(var_187_10.x, var_187_10.y, var_187_10.z)

				local var_187_11 = var_187_5.localEulerAngles

				var_187_11.z = 0
				var_187_11.x = 0
				var_187_5.localEulerAngles = var_187_11
			end

			if arg_184_1.time_ >= var_187_6 + var_187_7 and arg_184_1.time_ < var_187_6 + var_187_7 + arg_187_0 then
				var_187_5.localPosition = Vector3.New(0, -1.2, -6)

				local var_187_12 = manager.ui.mainCamera.transform.position - var_187_5.position

				var_187_5.forward = Vector3.New(var_187_12.x, var_187_12.y, var_187_12.z)

				local var_187_13 = var_187_5.localEulerAngles

				var_187_13.z = 0
				var_187_13.x = 0
				var_187_5.localEulerAngles = var_187_13
			end

			local var_187_14 = arg_184_1.actors_["1049ui_story"]
			local var_187_15 = 0

			if var_187_15 < arg_184_1.time_ and arg_184_1.time_ <= var_187_15 + arg_187_0 and not isNil(var_187_14) and arg_184_1.var_.characterEffect1049ui_story == nil then
				arg_184_1.var_.characterEffect1049ui_story = var_187_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_16 = 0.200000002980232

			if var_187_15 <= arg_184_1.time_ and arg_184_1.time_ < var_187_15 + var_187_16 and not isNil(var_187_14) then
				local var_187_17 = (arg_184_1.time_ - var_187_15) / var_187_16

				if arg_184_1.var_.characterEffect1049ui_story and not isNil(var_187_14) then
					arg_184_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_15 + var_187_16 and arg_184_1.time_ < var_187_15 + var_187_16 + arg_187_0 and not isNil(var_187_14) and arg_184_1.var_.characterEffect1049ui_story then
				arg_184_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_187_18 = 0

			if var_187_18 < arg_184_1.time_ and arg_184_1.time_ <= var_187_18 + arg_187_0 then
				arg_184_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_187_19 = 0

			if var_187_19 < arg_184_1.time_ and arg_184_1.time_ <= var_187_19 + arg_187_0 then
				arg_184_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_187_20 = 0
			local var_187_21 = 0.225

			if var_187_20 < arg_184_1.time_ and arg_184_1.time_ <= var_187_20 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_22 = arg_184_1:FormatText(StoryNameCfg[551].name)

				arg_184_1.leftNameTxt_.text = var_187_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_23 = arg_184_1:GetWordFromCfg(1104901044)
				local var_187_24 = arg_184_1:FormatText(var_187_23.content)

				arg_184_1.text_.text = var_187_24

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_25 = 9
				local var_187_26 = utf8.len(var_187_24)
				local var_187_27 = var_187_25 <= 0 and var_187_21 or var_187_21 * (var_187_26 / var_187_25)

				if var_187_27 > 0 and var_187_21 < var_187_27 then
					arg_184_1.talkMaxDuration = var_187_27

					if var_187_27 + var_187_20 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_27 + var_187_20
					end
				end

				arg_184_1.text_.text = var_187_24
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901044", "story_v_side_new_1104901.awb") ~= 0 then
					local var_187_28 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901044", "story_v_side_new_1104901.awb") / 1000

					if var_187_28 + var_187_20 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_28 + var_187_20
					end

					if var_187_23.prefab_name ~= "" and arg_184_1.actors_[var_187_23.prefab_name] ~= nil then
						local var_187_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_23.prefab_name].transform, "story_v_side_new_1104901", "1104901044", "story_v_side_new_1104901.awb")

						arg_184_1:RecordAudio("1104901044", var_187_29)
						arg_184_1:RecordAudio("1104901044", var_187_29)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901044", "story_v_side_new_1104901.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901044", "story_v_side_new_1104901.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_30 = math.max(var_187_21, arg_184_1.talkMaxDuration)

			if var_187_20 <= arg_184_1.time_ and arg_184_1.time_ < var_187_20 + var_187_30 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_20) / var_187_30

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_20 + var_187_30 and arg_184_1.time_ < var_187_20 + var_187_30 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play1104901045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 1104901045
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play1104901046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1049ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1049ui_story == nil then
				arg_188_1.var_.characterEffect1049ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect1049ui_story and not isNil(var_191_0) then
					local var_191_4 = Mathf.Lerp(0, 0.5, var_191_3)

					arg_188_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1049ui_story.fillRatio = var_191_4
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect1049ui_story then
				local var_191_5 = 0.5

				arg_188_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1049ui_story.fillRatio = var_191_5
			end

			local var_191_6 = 0
			local var_191_7 = 0.775

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_8 = arg_188_1:GetWordFromCfg(1104901045)
				local var_191_9 = arg_188_1:FormatText(var_191_8.content)

				arg_188_1.text_.text = var_191_9

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_10 = 31
				local var_191_11 = utf8.len(var_191_9)
				local var_191_12 = var_191_10 <= 0 and var_191_7 or var_191_7 * (var_191_11 / var_191_10)

				if var_191_12 > 0 and var_191_7 < var_191_12 then
					arg_188_1.talkMaxDuration = var_191_12

					if var_191_12 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_12 + var_191_6
					end
				end

				arg_188_1.text_.text = var_191_9
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_13 = math.max(var_191_7, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_13 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_6) / var_191_13

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_13 and arg_188_1.time_ < var_191_6 + var_191_13 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play1104901046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 1104901046
		arg_192_1.duration_ = 5.17

		local var_192_0 = {
			zh = 4.1,
			ja = 5.166
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play1104901047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1049ui_story"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos1049ui_story = var_195_0.localPosition
			end

			local var_195_2 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2
				local var_195_4 = Vector3.New(0, -1.2, -6)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1049ui_story, var_195_4, var_195_3)

				local var_195_5 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_5.x, var_195_5.y, var_195_5.z)

				local var_195_6 = var_195_0.localEulerAngles

				var_195_6.z = 0
				var_195_6.x = 0
				var_195_0.localEulerAngles = var_195_6
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_195_7 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_7.x, var_195_7.y, var_195_7.z)

				local var_195_8 = var_195_0.localEulerAngles

				var_195_8.z = 0
				var_195_8.x = 0
				var_195_0.localEulerAngles = var_195_8
			end

			local var_195_9 = arg_192_1.actors_["1049ui_story"]
			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 and not isNil(var_195_9) and arg_192_1.var_.characterEffect1049ui_story == nil then
				arg_192_1.var_.characterEffect1049ui_story = var_195_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_11 = 0.200000002980232

			if var_195_10 <= arg_192_1.time_ and arg_192_1.time_ < var_195_10 + var_195_11 and not isNil(var_195_9) then
				local var_195_12 = (arg_192_1.time_ - var_195_10) / var_195_11

				if arg_192_1.var_.characterEffect1049ui_story and not isNil(var_195_9) then
					arg_192_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_10 + var_195_11 and arg_192_1.time_ < var_195_10 + var_195_11 + arg_195_0 and not isNil(var_195_9) and arg_192_1.var_.characterEffect1049ui_story then
				arg_192_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_195_13 = 0

			if var_195_13 < arg_192_1.time_ and arg_192_1.time_ <= var_195_13 + arg_195_0 then
				arg_192_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_195_14 = 0

			if var_195_14 < arg_192_1.time_ and arg_192_1.time_ <= var_195_14 + arg_195_0 then
				arg_192_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_195_15 = 0
			local var_195_16 = 0.175

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_17 = arg_192_1:FormatText(StoryNameCfg[551].name)

				arg_192_1.leftNameTxt_.text = var_195_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_18 = arg_192_1:GetWordFromCfg(1104901046)
				local var_195_19 = arg_192_1:FormatText(var_195_18.content)

				arg_192_1.text_.text = var_195_19

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_20 = 7
				local var_195_21 = utf8.len(var_195_19)
				local var_195_22 = var_195_20 <= 0 and var_195_16 or var_195_16 * (var_195_21 / var_195_20)

				if var_195_22 > 0 and var_195_16 < var_195_22 then
					arg_192_1.talkMaxDuration = var_195_22

					if var_195_22 + var_195_15 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_22 + var_195_15
					end
				end

				arg_192_1.text_.text = var_195_19
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901046", "story_v_side_new_1104901.awb") ~= 0 then
					local var_195_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901046", "story_v_side_new_1104901.awb") / 1000

					if var_195_23 + var_195_15 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_23 + var_195_15
					end

					if var_195_18.prefab_name ~= "" and arg_192_1.actors_[var_195_18.prefab_name] ~= nil then
						local var_195_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_18.prefab_name].transform, "story_v_side_new_1104901", "1104901046", "story_v_side_new_1104901.awb")

						arg_192_1:RecordAudio("1104901046", var_195_24)
						arg_192_1:RecordAudio("1104901046", var_195_24)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901046", "story_v_side_new_1104901.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901046", "story_v_side_new_1104901.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_25 = math.max(var_195_16, arg_192_1.talkMaxDuration)

			if var_195_15 <= arg_192_1.time_ and arg_192_1.time_ < var_195_15 + var_195_25 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_15) / var_195_25

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_15 + var_195_25 and arg_192_1.time_ < var_195_15 + var_195_25 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104901047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 1104901047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play1104901048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["1049ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos1049ui_story = var_199_0.localPosition
			end

			local var_199_2 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2
				local var_199_4 = Vector3.New(0, 100, 0)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1049ui_story, var_199_4, var_199_3)

				local var_199_5 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_5.x, var_199_5.y, var_199_5.z)

				local var_199_6 = var_199_0.localEulerAngles

				var_199_6.z = 0
				var_199_6.x = 0
				var_199_0.localEulerAngles = var_199_6
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, 100, 0)

				local var_199_7 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_7.x, var_199_7.y, var_199_7.z)

				local var_199_8 = var_199_0.localEulerAngles

				var_199_8.z = 0
				var_199_8.x = 0
				var_199_0.localEulerAngles = var_199_8
			end

			local var_199_9 = arg_196_1.actors_["1049ui_story"]
			local var_199_10 = 0

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 and not isNil(var_199_9) and arg_196_1.var_.characterEffect1049ui_story == nil then
				arg_196_1.var_.characterEffect1049ui_story = var_199_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_11 = 0.200000002980232

			if var_199_10 <= arg_196_1.time_ and arg_196_1.time_ < var_199_10 + var_199_11 and not isNil(var_199_9) then
				local var_199_12 = (arg_196_1.time_ - var_199_10) / var_199_11

				if arg_196_1.var_.characterEffect1049ui_story and not isNil(var_199_9) then
					local var_199_13 = Mathf.Lerp(0, 0.5, var_199_12)

					arg_196_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1049ui_story.fillRatio = var_199_13
				end
			end

			if arg_196_1.time_ >= var_199_10 + var_199_11 and arg_196_1.time_ < var_199_10 + var_199_11 + arg_199_0 and not isNil(var_199_9) and arg_196_1.var_.characterEffect1049ui_story then
				local var_199_14 = 0.5

				arg_196_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1049ui_story.fillRatio = var_199_14
			end

			local var_199_15 = 0
			local var_199_16 = 1.375

			if var_199_15 < arg_196_1.time_ and arg_196_1.time_ <= var_199_15 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_17 = arg_196_1:GetWordFromCfg(1104901047)
				local var_199_18 = arg_196_1:FormatText(var_199_17.content)

				arg_196_1.text_.text = var_199_18

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_19 = 55
				local var_199_20 = utf8.len(var_199_18)
				local var_199_21 = var_199_19 <= 0 and var_199_16 or var_199_16 * (var_199_20 / var_199_19)

				if var_199_21 > 0 and var_199_16 < var_199_21 then
					arg_196_1.talkMaxDuration = var_199_21

					if var_199_21 + var_199_15 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_21 + var_199_15
					end
				end

				arg_196_1.text_.text = var_199_18
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_22 = math.max(var_199_16, arg_196_1.talkMaxDuration)

			if var_199_15 <= arg_196_1.time_ and arg_196_1.time_ < var_199_15 + var_199_22 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_15) / var_199_22

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_15 + var_199_22 and arg_196_1.time_ < var_199_15 + var_199_22 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104901048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 1104901048
		arg_200_1.duration_ = 2.77

		local var_200_0 = {
			zh = 2.766,
			ja = 1.533
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
				arg_200_0:Play1104901049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 0.075

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_2 = arg_200_1:FormatText(StoryNameCfg[36].name)

				arg_200_1.leftNameTxt_.text = var_203_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_3 = arg_200_1:GetWordFromCfg(1104901048)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 3
				local var_203_6 = utf8.len(var_203_4)
				local var_203_7 = var_203_5 <= 0 and var_203_1 or var_203_1 * (var_203_6 / var_203_5)

				if var_203_7 > 0 and var_203_1 < var_203_7 then
					arg_200_1.talkMaxDuration = var_203_7

					if var_203_7 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_7 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901048", "story_v_side_new_1104901.awb") ~= 0 then
					local var_203_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901048", "story_v_side_new_1104901.awb") / 1000

					if var_203_8 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_8 + var_203_0
					end

					if var_203_3.prefab_name ~= "" and arg_200_1.actors_[var_203_3.prefab_name] ~= nil then
						local var_203_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_3.prefab_name].transform, "story_v_side_new_1104901", "1104901048", "story_v_side_new_1104901.awb")

						arg_200_1:RecordAudio("1104901048", var_203_9)
						arg_200_1:RecordAudio("1104901048", var_203_9)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901048", "story_v_side_new_1104901.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901048", "story_v_side_new_1104901.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_10 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_10 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_10

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_10 and arg_200_1.time_ < var_203_0 + var_203_10 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play1104901049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1104901049
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1104901050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0
			local var_207_1 = 0.4

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

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_3 = arg_204_1:GetWordFromCfg(1104901049)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 16
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
	Play1104901050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1104901050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1104901051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0
			local var_211_1 = 1.525

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_2 = arg_208_1:GetWordFromCfg(1104901050)
				local var_211_3 = arg_208_1:FormatText(var_211_2.content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 61
				local var_211_5 = utf8.len(var_211_3)
				local var_211_6 = var_211_4 <= 0 and var_211_1 or var_211_1 * (var_211_5 / var_211_4)

				if var_211_6 > 0 and var_211_1 < var_211_6 then
					arg_208_1.talkMaxDuration = var_211_6

					if var_211_6 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_6 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_7 and arg_208_1.time_ < var_211_0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play1104901051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1104901051
		arg_212_1.duration_ = 10.67

		local var_212_0 = {
			zh = 7.133,
			ja = 10.666
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
				arg_212_0:Play1104901052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["1049ui_story"].transform
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.var_.moveOldPos1049ui_story = var_215_0.localPosition
			end

			local var_215_2 = 0.001

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2
				local var_215_4 = Vector3.New(0, -1.2, -6)

				var_215_0.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1049ui_story, var_215_4, var_215_3)

				local var_215_5 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_5.x, var_215_5.y, var_215_5.z)

				local var_215_6 = var_215_0.localEulerAngles

				var_215_6.z = 0
				var_215_6.x = 0
				var_215_0.localEulerAngles = var_215_6
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 then
				var_215_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_215_7 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_7.x, var_215_7.y, var_215_7.z)

				local var_215_8 = var_215_0.localEulerAngles

				var_215_8.z = 0
				var_215_8.x = 0
				var_215_0.localEulerAngles = var_215_8
			end

			local var_215_9 = arg_212_1.actors_["1049ui_story"]
			local var_215_10 = 0

			if var_215_10 < arg_212_1.time_ and arg_212_1.time_ <= var_215_10 + arg_215_0 and not isNil(var_215_9) and arg_212_1.var_.characterEffect1049ui_story == nil then
				arg_212_1.var_.characterEffect1049ui_story = var_215_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_11 = 0.200000002980232

			if var_215_10 <= arg_212_1.time_ and arg_212_1.time_ < var_215_10 + var_215_11 and not isNil(var_215_9) then
				local var_215_12 = (arg_212_1.time_ - var_215_10) / var_215_11

				if arg_212_1.var_.characterEffect1049ui_story and not isNil(var_215_9) then
					arg_212_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_10 + var_215_11 and arg_212_1.time_ < var_215_10 + var_215_11 + arg_215_0 and not isNil(var_215_9) and arg_212_1.var_.characterEffect1049ui_story then
				arg_212_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_215_13 = 0

			if var_215_13 < arg_212_1.time_ and arg_212_1.time_ <= var_215_13 + arg_215_0 then
				arg_212_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_215_14 = 0

			if var_215_14 < arg_212_1.time_ and arg_212_1.time_ <= var_215_14 + arg_215_0 then
				arg_212_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_215_15 = 0
			local var_215_16 = 0.8

			if var_215_15 < arg_212_1.time_ and arg_212_1.time_ <= var_215_15 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_17 = arg_212_1:FormatText(StoryNameCfg[551].name)

				arg_212_1.leftNameTxt_.text = var_215_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_18 = arg_212_1:GetWordFromCfg(1104901051)
				local var_215_19 = arg_212_1:FormatText(var_215_18.content)

				arg_212_1.text_.text = var_215_19

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_20 = 32
				local var_215_21 = utf8.len(var_215_19)
				local var_215_22 = var_215_20 <= 0 and var_215_16 or var_215_16 * (var_215_21 / var_215_20)

				if var_215_22 > 0 and var_215_16 < var_215_22 then
					arg_212_1.talkMaxDuration = var_215_22

					if var_215_22 + var_215_15 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_22 + var_215_15
					end
				end

				arg_212_1.text_.text = var_215_19
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901051", "story_v_side_new_1104901.awb") ~= 0 then
					local var_215_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901051", "story_v_side_new_1104901.awb") / 1000

					if var_215_23 + var_215_15 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_23 + var_215_15
					end

					if var_215_18.prefab_name ~= "" and arg_212_1.actors_[var_215_18.prefab_name] ~= nil then
						local var_215_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_18.prefab_name].transform, "story_v_side_new_1104901", "1104901051", "story_v_side_new_1104901.awb")

						arg_212_1:RecordAudio("1104901051", var_215_24)
						arg_212_1:RecordAudio("1104901051", var_215_24)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901051", "story_v_side_new_1104901.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901051", "story_v_side_new_1104901.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_25 = math.max(var_215_16, arg_212_1.talkMaxDuration)

			if var_215_15 <= arg_212_1.time_ and arg_212_1.time_ < var_215_15 + var_215_25 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_15) / var_215_25

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_15 + var_215_25 and arg_212_1.time_ < var_215_15 + var_215_25 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104901052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 1104901052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play1104901053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1049ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1049ui_story == nil then
				arg_216_1.var_.characterEffect1049ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1049ui_story and not isNil(var_219_0) then
					local var_219_4 = Mathf.Lerp(0, 0.5, var_219_3)

					arg_216_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1049ui_story.fillRatio = var_219_4
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1049ui_story then
				local var_219_5 = 0.5

				arg_216_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1049ui_story.fillRatio = var_219_5
			end

			local var_219_6 = 0
			local var_219_7 = 1.425

			if var_219_6 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_8 = arg_216_1:FormatText(StoryNameCfg[7].name)

				arg_216_1.leftNameTxt_.text = var_219_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_9 = arg_216_1:GetWordFromCfg(1104901052)
				local var_219_10 = arg_216_1:FormatText(var_219_9.content)

				arg_216_1.text_.text = var_219_10

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_11 = 57
				local var_219_12 = utf8.len(var_219_10)
				local var_219_13 = var_219_11 <= 0 and var_219_7 or var_219_7 * (var_219_12 / var_219_11)

				if var_219_13 > 0 and var_219_7 < var_219_13 then
					arg_216_1.talkMaxDuration = var_219_13

					if var_219_13 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_13 + var_219_6
					end
				end

				arg_216_1.text_.text = var_219_10
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_14 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_14 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_14

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_14 and arg_216_1.time_ < var_219_6 + var_219_14 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play1104901053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 1104901053
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play1104901054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0
			local var_223_1 = 0.825

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_2 = arg_220_1:GetWordFromCfg(1104901053)
				local var_223_3 = arg_220_1:FormatText(var_223_2.content)

				arg_220_1.text_.text = var_223_3

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 33
				local var_223_5 = utf8.len(var_223_3)
				local var_223_6 = var_223_4 <= 0 and var_223_1 or var_223_1 * (var_223_5 / var_223_4)

				if var_223_6 > 0 and var_223_1 < var_223_6 then
					arg_220_1.talkMaxDuration = var_223_6

					if var_223_6 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_6 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_3
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_1, arg_220_1.talkMaxDuration)

			if var_223_0 <= arg_220_1.time_ and arg_220_1.time_ < var_223_0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_0 + var_223_7 and arg_220_1.time_ < var_223_0 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play1104901054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 1104901054
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play1104901055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0
			local var_227_1 = 0.075

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_2 = arg_224_1:FormatText(StoryNameCfg[7].name)

				arg_224_1.leftNameTxt_.text = var_227_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_3 = arg_224_1:GetWordFromCfg(1104901054)
				local var_227_4 = arg_224_1:FormatText(var_227_3.content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 3
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
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_8 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_8 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_8

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_8 and arg_224_1.time_ < var_227_0 + var_227_8 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play1104901055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1104901055
		arg_228_1.duration_ = 13.7

		local var_228_0 = {
			zh = 13.7,
			ja = 13
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
				arg_228_0:Play1104901056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = "I02"

			if arg_228_1.bgs_[var_231_0] == nil then
				local var_231_1 = Object.Instantiate(arg_228_1.paintGo_)

				var_231_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_231_0)
				var_231_1.name = var_231_0
				var_231_1.transform.parent = arg_228_1.stage_.transform
				var_231_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_228_1.bgs_[var_231_0] = var_231_1
			end

			local var_231_2 = 2

			if var_231_2 < arg_228_1.time_ and arg_228_1.time_ <= var_231_2 + arg_231_0 then
				local var_231_3 = manager.ui.mainCamera.transform.localPosition
				local var_231_4 = Vector3.New(0, 0, 10) + Vector3.New(var_231_3.x, var_231_3.y, 0)
				local var_231_5 = arg_228_1.bgs_.I02

				var_231_5.transform.localPosition = var_231_4
				var_231_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_231_6 = var_231_5:GetComponent("SpriteRenderer")

				if var_231_6 and var_231_6.sprite then
					local var_231_7 = (var_231_5.transform.localPosition - var_231_3).z
					local var_231_8 = manager.ui.mainCameraCom_
					local var_231_9 = 2 * var_231_7 * Mathf.Tan(var_231_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_231_10 = var_231_9 * var_231_8.aspect
					local var_231_11 = var_231_6.sprite.bounds.size.x
					local var_231_12 = var_231_6.sprite.bounds.size.y
					local var_231_13 = var_231_10 / var_231_11
					local var_231_14 = var_231_9 / var_231_12
					local var_231_15 = var_231_14 < var_231_13 and var_231_13 or var_231_14

					var_231_5.transform.localScale = Vector3.New(var_231_15, var_231_15, 0)
				end

				for iter_231_0, iter_231_1 in pairs(arg_228_1.bgs_) do
					if iter_231_0 ~= "I02" then
						iter_231_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_231_16 = 4

			if var_231_16 < arg_228_1.time_ and arg_228_1.time_ <= var_231_16 + arg_231_0 then
				arg_228_1.allBtn_.enabled = false
			end

			local var_231_17 = 0.3

			if arg_228_1.time_ >= var_231_16 + var_231_17 and arg_228_1.time_ < var_231_16 + var_231_17 + arg_231_0 then
				arg_228_1.allBtn_.enabled = true
			end

			local var_231_18 = 0

			if var_231_18 < arg_228_1.time_ and arg_228_1.time_ <= var_231_18 + arg_231_0 then
				arg_228_1.mask_.enabled = true
				arg_228_1.mask_.raycastTarget = true

				arg_228_1:SetGaussion(false)
			end

			local var_231_19 = 2

			if var_231_18 <= arg_228_1.time_ and arg_228_1.time_ < var_231_18 + var_231_19 then
				local var_231_20 = (arg_228_1.time_ - var_231_18) / var_231_19
				local var_231_21 = Color.New(0, 0, 0)

				var_231_21.a = Mathf.Lerp(0, 1, var_231_20)
				arg_228_1.mask_.color = var_231_21
			end

			if arg_228_1.time_ >= var_231_18 + var_231_19 and arg_228_1.time_ < var_231_18 + var_231_19 + arg_231_0 then
				local var_231_22 = Color.New(0, 0, 0)

				var_231_22.a = 1
				arg_228_1.mask_.color = var_231_22
			end

			local var_231_23 = 2

			if var_231_23 < arg_228_1.time_ and arg_228_1.time_ <= var_231_23 + arg_231_0 then
				arg_228_1.mask_.enabled = true
				arg_228_1.mask_.raycastTarget = true

				arg_228_1:SetGaussion(false)
			end

			local var_231_24 = 2

			if var_231_23 <= arg_228_1.time_ and arg_228_1.time_ < var_231_23 + var_231_24 then
				local var_231_25 = (arg_228_1.time_ - var_231_23) / var_231_24
				local var_231_26 = Color.New(0, 0, 0)

				var_231_26.a = Mathf.Lerp(1, 0, var_231_25)
				arg_228_1.mask_.color = var_231_26
			end

			if arg_228_1.time_ >= var_231_23 + var_231_24 and arg_228_1.time_ < var_231_23 + var_231_24 + arg_231_0 then
				local var_231_27 = Color.New(0, 0, 0)
				local var_231_28 = 0

				arg_228_1.mask_.enabled = false
				var_231_27.a = var_231_28
				arg_228_1.mask_.color = var_231_27
			end

			local var_231_29 = arg_228_1.actors_["1049ui_story"].transform
			local var_231_30 = 1.96599999815226

			if var_231_30 < arg_228_1.time_ and arg_228_1.time_ <= var_231_30 + arg_231_0 then
				arg_228_1.var_.moveOldPos1049ui_story = var_231_29.localPosition
			end

			local var_231_31 = 0.001

			if var_231_30 <= arg_228_1.time_ and arg_228_1.time_ < var_231_30 + var_231_31 then
				local var_231_32 = (arg_228_1.time_ - var_231_30) / var_231_31
				local var_231_33 = Vector3.New(0, 100, 0)

				var_231_29.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1049ui_story, var_231_33, var_231_32)

				local var_231_34 = manager.ui.mainCamera.transform.position - var_231_29.position

				var_231_29.forward = Vector3.New(var_231_34.x, var_231_34.y, var_231_34.z)

				local var_231_35 = var_231_29.localEulerAngles

				var_231_35.z = 0
				var_231_35.x = 0
				var_231_29.localEulerAngles = var_231_35
			end

			if arg_228_1.time_ >= var_231_30 + var_231_31 and arg_228_1.time_ < var_231_30 + var_231_31 + arg_231_0 then
				var_231_29.localPosition = Vector3.New(0, 100, 0)

				local var_231_36 = manager.ui.mainCamera.transform.position - var_231_29.position

				var_231_29.forward = Vector3.New(var_231_36.x, var_231_36.y, var_231_36.z)

				local var_231_37 = var_231_29.localEulerAngles

				var_231_37.z = 0
				var_231_37.x = 0
				var_231_29.localEulerAngles = var_231_37
			end

			local var_231_38 = arg_228_1.actors_["1049ui_story"]
			local var_231_39 = 1.96599999815226

			if var_231_39 < arg_228_1.time_ and arg_228_1.time_ <= var_231_39 + arg_231_0 and not isNil(var_231_38) and arg_228_1.var_.characterEffect1049ui_story == nil then
				arg_228_1.var_.characterEffect1049ui_story = var_231_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_40 = 0.034000001847744

			if var_231_39 <= arg_228_1.time_ and arg_228_1.time_ < var_231_39 + var_231_40 and not isNil(var_231_38) then
				local var_231_41 = (arg_228_1.time_ - var_231_39) / var_231_40

				if arg_228_1.var_.characterEffect1049ui_story and not isNil(var_231_38) then
					local var_231_42 = Mathf.Lerp(0, 0.5, var_231_41)

					arg_228_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1049ui_story.fillRatio = var_231_42
				end
			end

			if arg_228_1.time_ >= var_231_39 + var_231_40 and arg_228_1.time_ < var_231_39 + var_231_40 + arg_231_0 and not isNil(var_231_38) and arg_228_1.var_.characterEffect1049ui_story then
				local var_231_43 = 0.5

				arg_228_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1049ui_story.fillRatio = var_231_43
			end

			local var_231_44 = 0
			local var_231_45 = 1

			if var_231_44 < arg_228_1.time_ and arg_228_1.time_ <= var_231_44 + arg_231_0 then
				local var_231_46 = "play"
				local var_231_47 = "music"

				arg_228_1:AudioAction(var_231_46, var_231_47, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_231_48 = ""
				local var_231_49 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_231_49 ~= "" then
					if arg_228_1.bgmTxt_.text ~= var_231_49 and arg_228_1.bgmTxt_.text ~= "" then
						if arg_228_1.bgmTxt2_.text ~= "" then
							arg_228_1.bgmTxt_.text = arg_228_1.bgmTxt2_.text
						end

						arg_228_1.bgmTxt2_.text = var_231_49

						arg_228_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_228_1.bgmTxt_.text = var_231_49
						arg_228_1.bgmTxt2_.text = var_231_49
					end

					if arg_228_1.bgmTimer then
						arg_228_1.bgmTimer:Stop()

						arg_228_1.bgmTimer = nil
					end

					if arg_228_1.settingData.show_music_name == 1 then
						arg_228_1.musicController:SetSelectedState("show")
						arg_228_1.musicAnimator_:Play("open", 0, 0)

						if arg_228_1.settingData.music_time ~= 0 then
							arg_228_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_228_1.settingData.music_time), function()
								if arg_228_1 == nil or isNil(arg_228_1.bgmTxt_) then
									return
								end

								arg_228_1.musicController:SetSelectedState("hide")
								arg_228_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_231_50 = 0
			local var_231_51 = 0.366666666666667

			if var_231_50 < arg_228_1.time_ and arg_228_1.time_ <= var_231_50 + arg_231_0 then
				local var_231_52 = "stop"
				local var_231_53 = "effect"

				arg_228_1:AudioAction(var_231_52, var_231_53, "se_story_side_1058", "se_story_side_1058_rain_loop", "")
			end

			if arg_228_1.frameCnt_ <= 1 then
				arg_228_1.dialog_:SetActive(false)
			end

			local var_231_54 = 4
			local var_231_55 = 1.1

			if var_231_54 < arg_228_1.time_ and arg_228_1.time_ <= var_231_54 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0

				arg_228_1.dialog_:SetActive(true)

				arg_228_1.dialogCg_.alpha = 0

				local var_231_56 = LeanTween.value(arg_228_1.dialog_, 0, 1, 0.3)

				var_231_56:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_228_1.dialogCg_.alpha = arg_233_0
				end))
				var_231_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_228_1.dialog_)
					var_231_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_228_1.duration_ = arg_228_1.duration_ + 0.3

				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_57 = arg_228_1:FormatText(StoryNameCfg[1007].name)

				arg_228_1.leftNameTxt_.text = var_231_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_58 = arg_228_1:GetWordFromCfg(1104901055)
				local var_231_59 = arg_228_1:FormatText(var_231_58.content)

				arg_228_1.text_.text = var_231_59

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_60 = 44
				local var_231_61 = utf8.len(var_231_59)
				local var_231_62 = var_231_60 <= 0 and var_231_55 or var_231_55 * (var_231_61 / var_231_60)

				if var_231_62 > 0 and var_231_55 < var_231_62 then
					arg_228_1.talkMaxDuration = var_231_62
					var_231_54 = var_231_54 + 0.3

					if var_231_62 + var_231_54 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_62 + var_231_54
					end
				end

				arg_228_1.text_.text = var_231_59
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901055", "story_v_side_new_1104901.awb") ~= 0 then
					local var_231_63 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901055", "story_v_side_new_1104901.awb") / 1000

					if var_231_63 + var_231_54 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_63 + var_231_54
					end

					if var_231_58.prefab_name ~= "" and arg_228_1.actors_[var_231_58.prefab_name] ~= nil then
						local var_231_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_58.prefab_name].transform, "story_v_side_new_1104901", "1104901055", "story_v_side_new_1104901.awb")

						arg_228_1:RecordAudio("1104901055", var_231_64)
						arg_228_1:RecordAudio("1104901055", var_231_64)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901055", "story_v_side_new_1104901.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901055", "story_v_side_new_1104901.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_65 = var_231_54 + 0.3
			local var_231_66 = math.max(var_231_55, arg_228_1.talkMaxDuration)

			if var_231_65 <= arg_228_1.time_ and arg_228_1.time_ < var_231_65 + var_231_66 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_65) / var_231_66

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_65 + var_231_66 and arg_228_1.time_ < var_231_65 + var_231_66 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play1104901056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1104901056
		arg_235_1.duration_ = 3.4

		local var_235_0 = {
			zh = 3.4,
			ja = 3
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1104901057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1049ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos1049ui_story = var_238_0.localPosition
			end

			local var_238_2 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2
				local var_238_4 = Vector3.New(0, -1.2, -6)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1049ui_story, var_238_4, var_238_3)

				local var_238_5 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_5.x, var_238_5.y, var_238_5.z)

				local var_238_6 = var_238_0.localEulerAngles

				var_238_6.z = 0
				var_238_6.x = 0
				var_238_0.localEulerAngles = var_238_6
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_238_7 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_7.x, var_238_7.y, var_238_7.z)

				local var_238_8 = var_238_0.localEulerAngles

				var_238_8.z = 0
				var_238_8.x = 0
				var_238_0.localEulerAngles = var_238_8
			end

			local var_238_9 = arg_235_1.actors_["1049ui_story"]
			local var_238_10 = 0

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect1049ui_story == nil then
				arg_235_1.var_.characterEffect1049ui_story = var_238_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_11 = 0.200000002980232

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_11 and not isNil(var_238_9) then
				local var_238_12 = (arg_235_1.time_ - var_238_10) / var_238_11

				if arg_235_1.var_.characterEffect1049ui_story and not isNil(var_238_9) then
					arg_235_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_10 + var_238_11 and arg_235_1.time_ < var_238_10 + var_238_11 + arg_238_0 and not isNil(var_238_9) and arg_235_1.var_.characterEffect1049ui_story then
				arg_235_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_238_13 = 0

			if var_238_13 < arg_235_1.time_ and arg_235_1.time_ <= var_238_13 + arg_238_0 then
				arg_235_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_238_14 = 0

			if var_238_14 < arg_235_1.time_ and arg_235_1.time_ <= var_238_14 + arg_238_0 then
				arg_235_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_238_15 = 0
			local var_238_16 = 0.175

			if var_238_15 < arg_235_1.time_ and arg_235_1.time_ <= var_238_15 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_17 = arg_235_1:FormatText(StoryNameCfg[551].name)

				arg_235_1.leftNameTxt_.text = var_238_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_18 = arg_235_1:GetWordFromCfg(1104901056)
				local var_238_19 = arg_235_1:FormatText(var_238_18.content)

				arg_235_1.text_.text = var_238_19

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_20 = 7
				local var_238_21 = utf8.len(var_238_19)
				local var_238_22 = var_238_20 <= 0 and var_238_16 or var_238_16 * (var_238_21 / var_238_20)

				if var_238_22 > 0 and var_238_16 < var_238_22 then
					arg_235_1.talkMaxDuration = var_238_22

					if var_238_22 + var_238_15 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_22 + var_238_15
					end
				end

				arg_235_1.text_.text = var_238_19
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901056", "story_v_side_new_1104901.awb") ~= 0 then
					local var_238_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901056", "story_v_side_new_1104901.awb") / 1000

					if var_238_23 + var_238_15 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_23 + var_238_15
					end

					if var_238_18.prefab_name ~= "" and arg_235_1.actors_[var_238_18.prefab_name] ~= nil then
						local var_238_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_18.prefab_name].transform, "story_v_side_new_1104901", "1104901056", "story_v_side_new_1104901.awb")

						arg_235_1:RecordAudio("1104901056", var_238_24)
						arg_235_1:RecordAudio("1104901056", var_238_24)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901056", "story_v_side_new_1104901.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901056", "story_v_side_new_1104901.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_25 = math.max(var_238_16, arg_235_1.talkMaxDuration)

			if var_238_15 <= arg_235_1.time_ and arg_235_1.time_ < var_238_15 + var_238_25 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_15) / var_238_25

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_15 + var_238_25 and arg_235_1.time_ < var_238_15 + var_238_25 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play1104901057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1104901057
		arg_239_1.duration_ = 15.2

		local var_239_0 = {
			zh = 9.866,
			ja = 15.2
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1104901058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1049ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1049ui_story == nil then
				arg_239_1.var_.characterEffect1049ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect1049ui_story and not isNil(var_242_0) then
					local var_242_4 = Mathf.Lerp(0, 0.5, var_242_3)

					arg_239_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1049ui_story.fillRatio = var_242_4
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect1049ui_story then
				local var_242_5 = 0.5

				arg_239_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1049ui_story.fillRatio = var_242_5
			end

			local var_242_6 = 0
			local var_242_7 = 0.9

			if var_242_6 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_8 = arg_239_1:FormatText(StoryNameCfg[1007].name)

				arg_239_1.leftNameTxt_.text = var_242_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_9 = arg_239_1:GetWordFromCfg(1104901057)
				local var_242_10 = arg_239_1:FormatText(var_242_9.content)

				arg_239_1.text_.text = var_242_10

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_11 = 36
				local var_242_12 = utf8.len(var_242_10)
				local var_242_13 = var_242_11 <= 0 and var_242_7 or var_242_7 * (var_242_12 / var_242_11)

				if var_242_13 > 0 and var_242_7 < var_242_13 then
					arg_239_1.talkMaxDuration = var_242_13

					if var_242_13 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_13 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_10
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901057", "story_v_side_new_1104901.awb") ~= 0 then
					local var_242_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901057", "story_v_side_new_1104901.awb") / 1000

					if var_242_14 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_14 + var_242_6
					end

					if var_242_9.prefab_name ~= "" and arg_239_1.actors_[var_242_9.prefab_name] ~= nil then
						local var_242_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_9.prefab_name].transform, "story_v_side_new_1104901", "1104901057", "story_v_side_new_1104901.awb")

						arg_239_1:RecordAudio("1104901057", var_242_15)
						arg_239_1:RecordAudio("1104901057", var_242_15)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901057", "story_v_side_new_1104901.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901057", "story_v_side_new_1104901.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_16 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_16 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_16

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_16 and arg_239_1.time_ < var_242_6 + var_242_16 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1104901058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1104901058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1104901059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1049ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1049ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(0, 100, 0)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1049ui_story, var_246_4, var_246_3)

				local var_246_5 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_5.x, var_246_5.y, var_246_5.z)

				local var_246_6 = var_246_0.localEulerAngles

				var_246_6.z = 0
				var_246_6.x = 0
				var_246_0.localEulerAngles = var_246_6
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(0, 100, 0)

				local var_246_7 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_7.x, var_246_7.y, var_246_7.z)

				local var_246_8 = var_246_0.localEulerAngles

				var_246_8.z = 0
				var_246_8.x = 0
				var_246_0.localEulerAngles = var_246_8
			end

			local var_246_9 = arg_243_1.actors_["1049ui_story"]
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1049ui_story == nil then
				arg_243_1.var_.characterEffect1049ui_story = var_246_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_11 = 0.200000002980232

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_11 and not isNil(var_246_9) then
				local var_246_12 = (arg_243_1.time_ - var_246_10) / var_246_11

				if arg_243_1.var_.characterEffect1049ui_story and not isNil(var_246_9) then
					local var_246_13 = Mathf.Lerp(0, 0.5, var_246_12)

					arg_243_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1049ui_story.fillRatio = var_246_13
				end
			end

			if arg_243_1.time_ >= var_246_10 + var_246_11 and arg_243_1.time_ < var_246_10 + var_246_11 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1049ui_story then
				local var_246_14 = 0.5

				arg_243_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1049ui_story.fillRatio = var_246_14
			end

			local var_246_15 = 0
			local var_246_16 = 0.775

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_17 = arg_243_1:GetWordFromCfg(1104901058)
				local var_246_18 = arg_243_1:FormatText(var_246_17.content)

				arg_243_1.text_.text = var_246_18

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_19 = 31
				local var_246_20 = utf8.len(var_246_18)
				local var_246_21 = var_246_19 <= 0 and var_246_16 or var_246_16 * (var_246_20 / var_246_19)

				if var_246_21 > 0 and var_246_16 < var_246_21 then
					arg_243_1.talkMaxDuration = var_246_21

					if var_246_21 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_21 + var_246_15
					end
				end

				arg_243_1.text_.text = var_246_18
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_22 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_22 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_22

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_22 and arg_243_1.time_ < var_246_15 + var_246_22 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play1104901059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1104901059
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1104901060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0
			local var_250_1 = 1.075

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_2 = arg_247_1:FormatText(StoryNameCfg[7].name)

				arg_247_1.leftNameTxt_.text = var_250_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_3 = arg_247_1:GetWordFromCfg(1104901059)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 43
				local var_250_6 = utf8.len(var_250_4)
				local var_250_7 = var_250_5 <= 0 and var_250_1 or var_250_1 * (var_250_6 / var_250_5)

				if var_250_7 > 0 and var_250_1 < var_250_7 then
					arg_247_1.talkMaxDuration = var_250_7

					if var_250_7 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_8 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_8 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_8

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_8 and arg_247_1.time_ < var_250_0 + var_250_8 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1104901060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1104901060
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1104901061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 1.2

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:GetWordFromCfg(1104901060)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 48
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_8 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_8 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_8

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_8 and arg_251_1.time_ < var_254_0 + var_254_8 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1104901061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1104901061
		arg_255_1.duration_ = 3.1

		local var_255_0 = {
			zh = 2.7,
			ja = 3.1
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1104901062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0
			local var_258_1 = 0.25

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_2 = arg_255_1:FormatText(StoryNameCfg[1007].name)

				arg_255_1.leftNameTxt_.text = var_258_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_3 = arg_255_1:GetWordFromCfg(1104901061)
				local var_258_4 = arg_255_1:FormatText(var_258_3.content)

				arg_255_1.text_.text = var_258_4

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 10
				local var_258_6 = utf8.len(var_258_4)
				local var_258_7 = var_258_5 <= 0 and var_258_1 or var_258_1 * (var_258_6 / var_258_5)

				if var_258_7 > 0 and var_258_1 < var_258_7 then
					arg_255_1.talkMaxDuration = var_258_7

					if var_258_7 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_7 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_4
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901061", "story_v_side_new_1104901.awb") ~= 0 then
					local var_258_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901061", "story_v_side_new_1104901.awb") / 1000

					if var_258_8 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_0
					end

					if var_258_3.prefab_name ~= "" and arg_255_1.actors_[var_258_3.prefab_name] ~= nil then
						local var_258_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_3.prefab_name].transform, "story_v_side_new_1104901", "1104901061", "story_v_side_new_1104901.awb")

						arg_255_1:RecordAudio("1104901061", var_258_9)
						arg_255_1:RecordAudio("1104901061", var_258_9)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901061", "story_v_side_new_1104901.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901061", "story_v_side_new_1104901.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_10 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_10 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_10

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_10 and arg_255_1.time_ < var_258_0 + var_258_10 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1104901062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 1104901062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play1104901063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 0.425

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_2 = arg_259_1:FormatText(StoryNameCfg[7].name)

				arg_259_1.leftNameTxt_.text = var_262_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_3 = arg_259_1:GetWordFromCfg(1104901062)
				local var_262_4 = arg_259_1:FormatText(var_262_3.content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_5 = 17
				local var_262_6 = utf8.len(var_262_4)
				local var_262_7 = var_262_5 <= 0 and var_262_1 or var_262_1 * (var_262_6 / var_262_5)

				if var_262_7 > 0 and var_262_1 < var_262_7 then
					arg_259_1.talkMaxDuration = var_262_7

					if var_262_7 + var_262_0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_7 + var_262_0
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_8 = math.max(var_262_1, arg_259_1.talkMaxDuration)

			if var_262_0 <= arg_259_1.time_ and arg_259_1.time_ < var_262_0 + var_262_8 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_0) / var_262_8

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_0 + var_262_8 and arg_259_1.time_ < var_262_0 + var_262_8 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play1104901063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 1104901063
		arg_263_1.duration_ = 4.23

		local var_263_0 = {
			zh = 3.066,
			ja = 4.233
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play1104901064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1049ui_story"].transform
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 then
				arg_263_1.var_.moveOldPos1049ui_story = var_266_0.localPosition
			end

			local var_266_2 = 0.001

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2
				local var_266_4 = Vector3.New(0, -1.2, -6)

				var_266_0.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1049ui_story, var_266_4, var_266_3)

				local var_266_5 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_5.x, var_266_5.y, var_266_5.z)

				local var_266_6 = var_266_0.localEulerAngles

				var_266_6.z = 0
				var_266_6.x = 0
				var_266_0.localEulerAngles = var_266_6
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 then
				var_266_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_266_7 = manager.ui.mainCamera.transform.position - var_266_0.position

				var_266_0.forward = Vector3.New(var_266_7.x, var_266_7.y, var_266_7.z)

				local var_266_8 = var_266_0.localEulerAngles

				var_266_8.z = 0
				var_266_8.x = 0
				var_266_0.localEulerAngles = var_266_8
			end

			local var_266_9 = arg_263_1.actors_["1049ui_story"]
			local var_266_10 = 0

			if var_266_10 < arg_263_1.time_ and arg_263_1.time_ <= var_266_10 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1049ui_story == nil then
				arg_263_1.var_.characterEffect1049ui_story = var_266_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_11 = 0.200000002980232

			if var_266_10 <= arg_263_1.time_ and arg_263_1.time_ < var_266_10 + var_266_11 and not isNil(var_266_9) then
				local var_266_12 = (arg_263_1.time_ - var_266_10) / var_266_11

				if arg_263_1.var_.characterEffect1049ui_story and not isNil(var_266_9) then
					arg_263_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_10 + var_266_11 and arg_263_1.time_ < var_266_10 + var_266_11 + arg_266_0 and not isNil(var_266_9) and arg_263_1.var_.characterEffect1049ui_story then
				arg_263_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_266_13 = 0

			if var_266_13 < arg_263_1.time_ and arg_263_1.time_ <= var_266_13 + arg_266_0 then
				arg_263_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_266_14 = 0

			if var_266_14 < arg_263_1.time_ and arg_263_1.time_ <= var_266_14 + arg_266_0 then
				arg_263_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_266_15 = 0
			local var_266_16 = 0.3

			if var_266_15 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_17 = arg_263_1:FormatText(StoryNameCfg[551].name)

				arg_263_1.leftNameTxt_.text = var_266_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:GetWordFromCfg(1104901063)
				local var_266_19 = arg_263_1:FormatText(var_266_18.content)

				arg_263_1.text_.text = var_266_19

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_20 = 12
				local var_266_21 = utf8.len(var_266_19)
				local var_266_22 = var_266_20 <= 0 and var_266_16 or var_266_16 * (var_266_21 / var_266_20)

				if var_266_22 > 0 and var_266_16 < var_266_22 then
					arg_263_1.talkMaxDuration = var_266_22

					if var_266_22 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_22 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_19
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901063", "story_v_side_new_1104901.awb") ~= 0 then
					local var_266_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901063", "story_v_side_new_1104901.awb") / 1000

					if var_266_23 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_23 + var_266_15
					end

					if var_266_18.prefab_name ~= "" and arg_263_1.actors_[var_266_18.prefab_name] ~= nil then
						local var_266_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_18.prefab_name].transform, "story_v_side_new_1104901", "1104901063", "story_v_side_new_1104901.awb")

						arg_263_1:RecordAudio("1104901063", var_266_24)
						arg_263_1:RecordAudio("1104901063", var_266_24)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901063", "story_v_side_new_1104901.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901063", "story_v_side_new_1104901.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_25 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 <= arg_263_1.time_ and arg_263_1.time_ < var_266_15 + var_266_25 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_15) / var_266_25

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_15 + var_266_25 and arg_263_1.time_ < var_266_15 + var_266_25 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104901064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 1104901064
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play1104901065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["1049ui_story"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos1049ui_story = var_270_0.localPosition
			end

			local var_270_2 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2
				local var_270_4 = Vector3.New(0, 100, 0)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1049ui_story, var_270_4, var_270_3)

				local var_270_5 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_5.x, var_270_5.y, var_270_5.z)

				local var_270_6 = var_270_0.localEulerAngles

				var_270_6.z = 0
				var_270_6.x = 0
				var_270_0.localEulerAngles = var_270_6
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0, 100, 0)

				local var_270_7 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_7.x, var_270_7.y, var_270_7.z)

				local var_270_8 = var_270_0.localEulerAngles

				var_270_8.z = 0
				var_270_8.x = 0
				var_270_0.localEulerAngles = var_270_8
			end

			local var_270_9 = arg_267_1.actors_["1049ui_story"]
			local var_270_10 = 0

			if var_270_10 < arg_267_1.time_ and arg_267_1.time_ <= var_270_10 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect1049ui_story == nil then
				arg_267_1.var_.characterEffect1049ui_story = var_270_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_11 = 0.200000002980232

			if var_270_10 <= arg_267_1.time_ and arg_267_1.time_ < var_270_10 + var_270_11 and not isNil(var_270_9) then
				local var_270_12 = (arg_267_1.time_ - var_270_10) / var_270_11

				if arg_267_1.var_.characterEffect1049ui_story and not isNil(var_270_9) then
					local var_270_13 = Mathf.Lerp(0, 0.5, var_270_12)

					arg_267_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1049ui_story.fillRatio = var_270_13
				end
			end

			if arg_267_1.time_ >= var_270_10 + var_270_11 and arg_267_1.time_ < var_270_10 + var_270_11 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect1049ui_story then
				local var_270_14 = 0.5

				arg_267_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1049ui_story.fillRatio = var_270_14
			end

			local var_270_15 = 0
			local var_270_16 = 0.675

			if var_270_15 < arg_267_1.time_ and arg_267_1.time_ <= var_270_15 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_17 = arg_267_1:GetWordFromCfg(1104901064)
				local var_270_18 = arg_267_1:FormatText(var_270_17.content)

				arg_267_1.text_.text = var_270_18

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_19 = 27
				local var_270_20 = utf8.len(var_270_18)
				local var_270_21 = var_270_19 <= 0 and var_270_16 or var_270_16 * (var_270_20 / var_270_19)

				if var_270_21 > 0 and var_270_16 < var_270_21 then
					arg_267_1.talkMaxDuration = var_270_21

					if var_270_21 + var_270_15 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_21 + var_270_15
					end
				end

				arg_267_1.text_.text = var_270_18
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_22 = math.max(var_270_16, arg_267_1.talkMaxDuration)

			if var_270_15 <= arg_267_1.time_ and arg_267_1.time_ < var_270_15 + var_270_22 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_15) / var_270_22

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_15 + var_270_22 and arg_267_1.time_ < var_270_15 + var_270_22 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104901065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 1104901065
		arg_271_1.duration_ = 7.03

		local var_271_0 = {
			zh = 3.166,
			ja = 7.033
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play1104901066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0
			local var_274_1 = 0.4

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_2 = arg_271_1:FormatText(StoryNameCfg[1007].name)

				arg_271_1.leftNameTxt_.text = var_274_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_3 = arg_271_1:GetWordFromCfg(1104901065)
				local var_274_4 = arg_271_1:FormatText(var_274_3.content)

				arg_271_1.text_.text = var_274_4

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 16
				local var_274_6 = utf8.len(var_274_4)
				local var_274_7 = var_274_5 <= 0 and var_274_1 or var_274_1 * (var_274_6 / var_274_5)

				if var_274_7 > 0 and var_274_1 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_4
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901065", "story_v_side_new_1104901.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901065", "story_v_side_new_1104901.awb") / 1000

					if var_274_8 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_0
					end

					if var_274_3.prefab_name ~= "" and arg_271_1.actors_[var_274_3.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_3.prefab_name].transform, "story_v_side_new_1104901", "1104901065", "story_v_side_new_1104901.awb")

						arg_271_1:RecordAudio("1104901065", var_274_9)
						arg_271_1:RecordAudio("1104901065", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901065", "story_v_side_new_1104901.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901065", "story_v_side_new_1104901.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_10 and arg_271_1.time_ < var_274_0 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play1104901066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 1104901066
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play1104901067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0
			local var_278_1 = 0.5

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_2 = arg_275_1:FormatText(StoryNameCfg[7].name)

				arg_275_1.leftNameTxt_.text = var_278_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_3 = arg_275_1:GetWordFromCfg(1104901066)
				local var_278_4 = arg_275_1:FormatText(var_278_3.content)

				arg_275_1.text_.text = var_278_4

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_5 = 20
				local var_278_6 = utf8.len(var_278_4)
				local var_278_7 = var_278_5 <= 0 and var_278_1 or var_278_1 * (var_278_6 / var_278_5)

				if var_278_7 > 0 and var_278_1 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_0
					end
				end

				arg_275_1.text_.text = var_278_4
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_8 = math.max(var_278_1, arg_275_1.talkMaxDuration)

			if var_278_0 <= arg_275_1.time_ and arg_275_1.time_ < var_278_0 + var_278_8 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_0) / var_278_8

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_0 + var_278_8 and arg_275_1.time_ < var_278_0 + var_278_8 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play1104901067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 1104901067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play1104901068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0
			local var_282_1 = 0.625

			if var_282_0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_2 = arg_279_1:FormatText(StoryNameCfg[7].name)

				arg_279_1.leftNameTxt_.text = var_282_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_3 = arg_279_1:GetWordFromCfg(1104901067)
				local var_282_4 = arg_279_1:FormatText(var_282_3.content)

				arg_279_1.text_.text = var_282_4

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 25
				local var_282_6 = utf8.len(var_282_4)
				local var_282_7 = var_282_5 <= 0 and var_282_1 or var_282_1 * (var_282_6 / var_282_5)

				if var_282_7 > 0 and var_282_1 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_0
					end
				end

				arg_279_1.text_.text = var_282_4
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_8 = math.max(var_282_1, arg_279_1.talkMaxDuration)

			if var_282_0 <= arg_279_1.time_ and arg_279_1.time_ < var_282_0 + var_282_8 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_0) / var_282_8

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_0 + var_282_8 and arg_279_1.time_ < var_282_0 + var_282_8 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play1104901068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 1104901068
		arg_283_1.duration_ = 6.67

		local var_283_0 = {
			zh = 5.066,
			ja = 6.666
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play1104901069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 0.75

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_2 = arg_283_1:FormatText(StoryNameCfg[1007].name)

				arg_283_1.leftNameTxt_.text = var_286_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, true)
				arg_283_1.iconController_:SetSelectedState("hero")

				arg_283_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_283_1.callingController_:SetSelectedState("normal")

				arg_283_1.keyicon_.color = Color.New(1, 1, 1)
				arg_283_1.icon_.color = Color.New(1, 1, 1)

				local var_286_3 = arg_283_1:GetWordFromCfg(1104901068)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 30
				local var_286_6 = utf8.len(var_286_4)
				local var_286_7 = var_286_5 <= 0 and var_286_1 or var_286_1 * (var_286_6 / var_286_5)

				if var_286_7 > 0 and var_286_1 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_0
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901068", "story_v_side_new_1104901.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901068", "story_v_side_new_1104901.awb") / 1000

					if var_286_8 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_0
					end

					if var_286_3.prefab_name ~= "" and arg_283_1.actors_[var_286_3.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_3.prefab_name].transform, "story_v_side_new_1104901", "1104901068", "story_v_side_new_1104901.awb")

						arg_283_1:RecordAudio("1104901068", var_286_9)
						arg_283_1:RecordAudio("1104901068", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901068", "story_v_side_new_1104901.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901068", "story_v_side_new_1104901.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_10 = math.max(var_286_1, arg_283_1.talkMaxDuration)

			if var_286_0 <= arg_283_1.time_ and arg_283_1.time_ < var_286_0 + var_286_10 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_0) / var_286_10

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_0 + var_286_10 and arg_283_1.time_ < var_286_0 + var_286_10 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play1104901069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 1104901069
		arg_287_1.duration_ = 9

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play1104901070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = "ST11"

			if arg_287_1.bgs_[var_290_0] == nil then
				local var_290_1 = Object.Instantiate(arg_287_1.paintGo_)

				var_290_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_290_0)
				var_290_1.name = var_290_0
				var_290_1.transform.parent = arg_287_1.stage_.transform
				var_290_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_287_1.bgs_[var_290_0] = var_290_1
			end

			local var_290_2 = 2

			if var_290_2 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				local var_290_3 = manager.ui.mainCamera.transform.localPosition
				local var_290_4 = Vector3.New(0, 0, 10) + Vector3.New(var_290_3.x, var_290_3.y, 0)
				local var_290_5 = arg_287_1.bgs_.ST11

				var_290_5.transform.localPosition = var_290_4
				var_290_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_290_6 = var_290_5:GetComponent("SpriteRenderer")

				if var_290_6 and var_290_6.sprite then
					local var_290_7 = (var_290_5.transform.localPosition - var_290_3).z
					local var_290_8 = manager.ui.mainCameraCom_
					local var_290_9 = 2 * var_290_7 * Mathf.Tan(var_290_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_290_10 = var_290_9 * var_290_8.aspect
					local var_290_11 = var_290_6.sprite.bounds.size.x
					local var_290_12 = var_290_6.sprite.bounds.size.y
					local var_290_13 = var_290_10 / var_290_11
					local var_290_14 = var_290_9 / var_290_12
					local var_290_15 = var_290_14 < var_290_13 and var_290_13 or var_290_14

					var_290_5.transform.localScale = Vector3.New(var_290_15, var_290_15, 0)
				end

				for iter_290_0, iter_290_1 in pairs(arg_287_1.bgs_) do
					if iter_290_0 ~= "ST11" then
						iter_290_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_290_16 = 4

			if var_290_16 < arg_287_1.time_ and arg_287_1.time_ <= var_290_16 + arg_290_0 then
				arg_287_1.allBtn_.enabled = false
			end

			local var_290_17 = 0.3

			if arg_287_1.time_ >= var_290_16 + var_290_17 and arg_287_1.time_ < var_290_16 + var_290_17 + arg_290_0 then
				arg_287_1.allBtn_.enabled = true
			end

			local var_290_18 = 0

			if var_290_18 < arg_287_1.time_ and arg_287_1.time_ <= var_290_18 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_19 = 2

			if var_290_18 <= arg_287_1.time_ and arg_287_1.time_ < var_290_18 + var_290_19 then
				local var_290_20 = (arg_287_1.time_ - var_290_18) / var_290_19
				local var_290_21 = Color.New(0, 0, 0)

				var_290_21.a = Mathf.Lerp(0, 1, var_290_20)
				arg_287_1.mask_.color = var_290_21
			end

			if arg_287_1.time_ >= var_290_18 + var_290_19 and arg_287_1.time_ < var_290_18 + var_290_19 + arg_290_0 then
				local var_290_22 = Color.New(0, 0, 0)

				var_290_22.a = 1
				arg_287_1.mask_.color = var_290_22
			end

			local var_290_23 = 2

			if var_290_23 < arg_287_1.time_ and arg_287_1.time_ <= var_290_23 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_24 = 2

			if var_290_23 <= arg_287_1.time_ and arg_287_1.time_ < var_290_23 + var_290_24 then
				local var_290_25 = (arg_287_1.time_ - var_290_23) / var_290_24
				local var_290_26 = Color.New(0, 0, 0)

				var_290_26.a = Mathf.Lerp(1, 0, var_290_25)
				arg_287_1.mask_.color = var_290_26
			end

			if arg_287_1.time_ >= var_290_23 + var_290_24 and arg_287_1.time_ < var_290_23 + var_290_24 + arg_290_0 then
				local var_290_27 = Color.New(0, 0, 0)
				local var_290_28 = 0

				arg_287_1.mask_.enabled = false
				var_290_27.a = var_290_28
				arg_287_1.mask_.color = var_290_27
			end

			if arg_287_1.frameCnt_ <= 1 then
				arg_287_1.dialog_:SetActive(false)
			end

			local var_290_29 = 4
			local var_290_30 = 0.6

			if var_290_29 < arg_287_1.time_ and arg_287_1.time_ <= var_290_29 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_31 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_31:setOnUpdate(LuaHelper.FloatAction(function(arg_291_0)
					arg_287_1.dialogCg_.alpha = arg_291_0
				end))
				var_290_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, false)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_32 = arg_287_1:GetWordFromCfg(1104901069)
				local var_290_33 = arg_287_1:FormatText(var_290_32.content)

				arg_287_1.text_.text = var_290_33

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_34 = 24
				local var_290_35 = utf8.len(var_290_33)
				local var_290_36 = var_290_34 <= 0 and var_290_30 or var_290_30 * (var_290_35 / var_290_34)

				if var_290_36 > 0 and var_290_30 < var_290_36 then
					arg_287_1.talkMaxDuration = var_290_36
					var_290_29 = var_290_29 + 0.3

					if var_290_36 + var_290_29 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_36 + var_290_29
					end
				end

				arg_287_1.text_.text = var_290_33
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_37 = var_290_29 + 0.3
			local var_290_38 = math.max(var_290_30, arg_287_1.talkMaxDuration)

			if var_290_37 <= arg_287_1.time_ and arg_287_1.time_ < var_290_37 + var_290_38 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_37) / var_290_38

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_37 + var_290_38 and arg_287_1.time_ < var_290_37 + var_290_38 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play1104901070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1104901070
		arg_293_1.duration_ = 1.33

		local var_293_0 = {
			zh = 1.333,
			ja = 1.1
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1104901071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1049ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos1049ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(0, -1.2, -6)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1049ui_story, var_296_4, var_296_3)

				local var_296_5 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_5.x, var_296_5.y, var_296_5.z)

				local var_296_6 = var_296_0.localEulerAngles

				var_296_6.z = 0
				var_296_6.x = 0
				var_296_0.localEulerAngles = var_296_6
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_296_7 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_7.x, var_296_7.y, var_296_7.z)

				local var_296_8 = var_296_0.localEulerAngles

				var_296_8.z = 0
				var_296_8.x = 0
				var_296_0.localEulerAngles = var_296_8
			end

			local var_296_9 = arg_293_1.actors_["1049ui_story"]
			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect1049ui_story == nil then
				arg_293_1.var_.characterEffect1049ui_story = var_296_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_11 = 0.200000002980232

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_11 and not isNil(var_296_9) then
				local var_296_12 = (arg_293_1.time_ - var_296_10) / var_296_11

				if arg_293_1.var_.characterEffect1049ui_story and not isNil(var_296_9) then
					arg_293_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_10 + var_296_11 and arg_293_1.time_ < var_296_10 + var_296_11 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect1049ui_story then
				arg_293_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_296_13 = 0

			if var_296_13 < arg_293_1.time_ and arg_293_1.time_ <= var_296_13 + arg_296_0 then
				arg_293_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_296_14 = 0

			if var_296_14 < arg_293_1.time_ and arg_293_1.time_ <= var_296_14 + arg_296_0 then
				arg_293_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_296_15 = 0
			local var_296_16 = 0.075

			if var_296_15 < arg_293_1.time_ and arg_293_1.time_ <= var_296_15 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_17 = arg_293_1:FormatText(StoryNameCfg[551].name)

				arg_293_1.leftNameTxt_.text = var_296_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_18 = arg_293_1:GetWordFromCfg(1104901070)
				local var_296_19 = arg_293_1:FormatText(var_296_18.content)

				arg_293_1.text_.text = var_296_19

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_20 = 3
				local var_296_21 = utf8.len(var_296_19)
				local var_296_22 = var_296_20 <= 0 and var_296_16 or var_296_16 * (var_296_21 / var_296_20)

				if var_296_22 > 0 and var_296_16 < var_296_22 then
					arg_293_1.talkMaxDuration = var_296_22

					if var_296_22 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_22 + var_296_15
					end
				end

				arg_293_1.text_.text = var_296_19
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901070", "story_v_side_new_1104901.awb") ~= 0 then
					local var_296_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901070", "story_v_side_new_1104901.awb") / 1000

					if var_296_23 + var_296_15 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_23 + var_296_15
					end

					if var_296_18.prefab_name ~= "" and arg_293_1.actors_[var_296_18.prefab_name] ~= nil then
						local var_296_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_18.prefab_name].transform, "story_v_side_new_1104901", "1104901070", "story_v_side_new_1104901.awb")

						arg_293_1:RecordAudio("1104901070", var_296_24)
						arg_293_1:RecordAudio("1104901070", var_296_24)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901070", "story_v_side_new_1104901.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901070", "story_v_side_new_1104901.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_25 = math.max(var_296_16, arg_293_1.talkMaxDuration)

			if var_296_15 <= arg_293_1.time_ and arg_293_1.time_ < var_296_15 + var_296_25 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_15) / var_296_25

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_15 + var_296_25 and arg_293_1.time_ < var_296_15 + var_296_25 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play1104901071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1104901071
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1104901072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["1049ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1049ui_story == nil then
				arg_297_1.var_.characterEffect1049ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect1049ui_story and not isNil(var_300_0) then
					local var_300_4 = Mathf.Lerp(0, 0.5, var_300_3)

					arg_297_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1049ui_story.fillRatio = var_300_4
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect1049ui_story then
				local var_300_5 = 0.5

				arg_297_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1049ui_story.fillRatio = var_300_5
			end

			local var_300_6 = 0
			local var_300_7 = 0.0329999998211861

			if var_300_6 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_8 = arg_297_1:FormatText(StoryNameCfg[7].name)

				arg_297_1.leftNameTxt_.text = var_300_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_9 = arg_297_1:GetWordFromCfg(1104901071)
				local var_300_10 = arg_297_1:FormatText(var_300_9.content)

				arg_297_1.text_.text = var_300_10

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_11 = 1
				local var_300_12 = utf8.len(var_300_10)
				local var_300_13 = var_300_11 <= 0 and var_300_7 or var_300_7 * (var_300_12 / var_300_11)

				if var_300_13 > 0 and var_300_7 < var_300_13 then
					arg_297_1.talkMaxDuration = var_300_13

					if var_300_13 + var_300_6 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_13 + var_300_6
					end
				end

				arg_297_1.text_.text = var_300_10
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_14 = math.max(var_300_7, arg_297_1.talkMaxDuration)

			if var_300_6 <= arg_297_1.time_ and arg_297_1.time_ < var_300_6 + var_300_14 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_6) / var_300_14

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_6 + var_300_14 and arg_297_1.time_ < var_300_6 + var_300_14 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1104901072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1104901072
		arg_301_1.duration_ = 4.6

		local var_301_0 = {
			zh = 1.999999999999,
			ja = 4.6
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1104901073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1049ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1049ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0, -1.2, -6)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1049ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = arg_301_1.actors_["1049ui_story"]
			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1049ui_story == nil then
				arg_301_1.var_.characterEffect1049ui_story = var_304_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_11 = 0.200000002980232

			if var_304_10 <= arg_301_1.time_ and arg_301_1.time_ < var_304_10 + var_304_11 and not isNil(var_304_9) then
				local var_304_12 = (arg_301_1.time_ - var_304_10) / var_304_11

				if arg_301_1.var_.characterEffect1049ui_story and not isNil(var_304_9) then
					arg_301_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_10 + var_304_11 and arg_301_1.time_ < var_304_10 + var_304_11 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1049ui_story then
				arg_301_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_304_13 = 0

			if var_304_13 < arg_301_1.time_ and arg_301_1.time_ <= var_304_13 + arg_304_0 then
				arg_301_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action6_1")
			end

			local var_304_14 = 0

			if var_304_14 < arg_301_1.time_ and arg_301_1.time_ <= var_304_14 + arg_304_0 then
				arg_301_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_304_15 = 0
			local var_304_16 = 0.175

			if var_304_15 < arg_301_1.time_ and arg_301_1.time_ <= var_304_15 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_17 = arg_301_1:FormatText(StoryNameCfg[551].name)

				arg_301_1.leftNameTxt_.text = var_304_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_18 = arg_301_1:GetWordFromCfg(1104901072)
				local var_304_19 = arg_301_1:FormatText(var_304_18.content)

				arg_301_1.text_.text = var_304_19

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_20 = 7
				local var_304_21 = utf8.len(var_304_19)
				local var_304_22 = var_304_20 <= 0 and var_304_16 or var_304_16 * (var_304_21 / var_304_20)

				if var_304_22 > 0 and var_304_16 < var_304_22 then
					arg_301_1.talkMaxDuration = var_304_22

					if var_304_22 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_22 + var_304_15
					end
				end

				arg_301_1.text_.text = var_304_19
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901072", "story_v_side_new_1104901.awb") ~= 0 then
					local var_304_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901072", "story_v_side_new_1104901.awb") / 1000

					if var_304_23 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_23 + var_304_15
					end

					if var_304_18.prefab_name ~= "" and arg_301_1.actors_[var_304_18.prefab_name] ~= nil then
						local var_304_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_18.prefab_name].transform, "story_v_side_new_1104901", "1104901072", "story_v_side_new_1104901.awb")

						arg_301_1:RecordAudio("1104901072", var_304_24)
						arg_301_1:RecordAudio("1104901072", var_304_24)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901072", "story_v_side_new_1104901.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901072", "story_v_side_new_1104901.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_25 = math.max(var_304_16, arg_301_1.talkMaxDuration)

			if var_304_15 <= arg_301_1.time_ and arg_301_1.time_ < var_304_15 + var_304_25 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_15) / var_304_25

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_15 + var_304_25 and arg_301_1.time_ < var_304_15 + var_304_25 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play1104901073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1104901073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1104901074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1049ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1049ui_story == nil then
				arg_305_1.var_.characterEffect1049ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1049ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1049ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1049ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1049ui_story.fillRatio = var_308_5
			end

			local var_308_6 = 0
			local var_308_7 = 0.075

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_9 = arg_305_1:GetWordFromCfg(1104901073)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 3
				local var_308_12 = utf8.len(var_308_10)
				local var_308_13 = var_308_11 <= 0 and var_308_7 or var_308_7 * (var_308_12 / var_308_11)

				if var_308_13 > 0 and var_308_7 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_10
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_14 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_14 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_14

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_14 and arg_305_1.time_ < var_308_6 + var_308_14 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1104901074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1104901074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1104901075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 1.325

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_2 = arg_309_1:GetWordFromCfg(1104901074)
				local var_312_3 = arg_309_1:FormatText(var_312_2.content)

				arg_309_1.text_.text = var_312_3

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 53
				local var_312_5 = utf8.len(var_312_3)
				local var_312_6 = var_312_4 <= 0 and var_312_1 or var_312_1 * (var_312_5 / var_312_4)

				if var_312_6 > 0 and var_312_1 < var_312_6 then
					arg_309_1.talkMaxDuration = var_312_6

					if var_312_6 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_6 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_3
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_7 and arg_309_1.time_ < var_312_0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1104901075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1104901075
		arg_313_1.duration_ = 6.87

		local var_313_0 = {
			zh = 6.866,
			ja = 3.6
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1104901076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1049ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1049ui_story == nil then
				arg_313_1.var_.characterEffect1049ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect1049ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect1049ui_story then
				arg_313_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_316_4 = 0

			if var_316_4 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action6_2")
			end

			local var_316_5 = 0

			if var_316_5 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_316_6 = 0
			local var_316_7 = 0.725

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_8 = arg_313_1:FormatText(StoryNameCfg[551].name)

				arg_313_1.leftNameTxt_.text = var_316_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_9 = arg_313_1:GetWordFromCfg(1104901075)
				local var_316_10 = arg_313_1:FormatText(var_316_9.content)

				arg_313_1.text_.text = var_316_10

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 29
				local var_316_12 = utf8.len(var_316_10)
				local var_316_13 = var_316_11 <= 0 and var_316_7 or var_316_7 * (var_316_12 / var_316_11)

				if var_316_13 > 0 and var_316_7 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_10
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901075", "story_v_side_new_1104901.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901075", "story_v_side_new_1104901.awb") / 1000

					if var_316_14 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_6
					end

					if var_316_9.prefab_name ~= "" and arg_313_1.actors_[var_316_9.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_9.prefab_name].transform, "story_v_side_new_1104901", "1104901075", "story_v_side_new_1104901.awb")

						arg_313_1:RecordAudio("1104901075", var_316_15)
						arg_313_1:RecordAudio("1104901075", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901075", "story_v_side_new_1104901.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901075", "story_v_side_new_1104901.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_16 and arg_313_1.time_ < var_316_6 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1104901076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1104901076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1104901077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1049ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1049ui_story == nil then
				arg_317_1.var_.characterEffect1049ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect1049ui_story and not isNil(var_320_0) then
					local var_320_4 = Mathf.Lerp(0, 0.5, var_320_3)

					arg_317_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1049ui_story.fillRatio = var_320_4
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1049ui_story then
				local var_320_5 = 0.5

				arg_317_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1049ui_story.fillRatio = var_320_5
			end

			local var_320_6 = 0
			local var_320_7 = 0.875

			if var_320_6 < arg_317_1.time_ and arg_317_1.time_ <= var_320_6 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_8 = arg_317_1:FormatText(StoryNameCfg[7].name)

				arg_317_1.leftNameTxt_.text = var_320_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_9 = arg_317_1:GetWordFromCfg(1104901076)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 35
				local var_320_12 = utf8.len(var_320_10)
				local var_320_13 = var_320_11 <= 0 and var_320_7 or var_320_7 * (var_320_12 / var_320_11)

				if var_320_13 > 0 and var_320_7 < var_320_13 then
					arg_317_1.talkMaxDuration = var_320_13

					if var_320_13 + var_320_6 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_13 + var_320_6
					end
				end

				arg_317_1.text_.text = var_320_10
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_14 = math.max(var_320_7, arg_317_1.talkMaxDuration)

			if var_320_6 <= arg_317_1.time_ and arg_317_1.time_ < var_320_6 + var_320_14 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_6) / var_320_14

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_6 + var_320_14 and arg_317_1.time_ < var_320_6 + var_320_14 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1104901077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1104901077
		arg_321_1.duration_ = 8.2

		local var_321_0 = {
			zh = 5.1,
			ja = 8.2
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1104901078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1049ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1049ui_story = var_324_0.localPosition
			end

			local var_324_2 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2
				local var_324_4 = Vector3.New(0, -1.2, -6)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1049ui_story, var_324_4, var_324_3)

				local var_324_5 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_5.x, var_324_5.y, var_324_5.z)

				local var_324_6 = var_324_0.localEulerAngles

				var_324_6.z = 0
				var_324_6.x = 0
				var_324_0.localEulerAngles = var_324_6
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_324_7 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_7.x, var_324_7.y, var_324_7.z)

				local var_324_8 = var_324_0.localEulerAngles

				var_324_8.z = 0
				var_324_8.x = 0
				var_324_0.localEulerAngles = var_324_8
			end

			local var_324_9 = arg_321_1.actors_["1049ui_story"]
			local var_324_10 = 0

			if var_324_10 < arg_321_1.time_ and arg_321_1.time_ <= var_324_10 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1049ui_story == nil then
				arg_321_1.var_.characterEffect1049ui_story = var_324_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_11 = 0.200000002980232

			if var_324_10 <= arg_321_1.time_ and arg_321_1.time_ < var_324_10 + var_324_11 and not isNil(var_324_9) then
				local var_324_12 = (arg_321_1.time_ - var_324_10) / var_324_11

				if arg_321_1.var_.characterEffect1049ui_story and not isNil(var_324_9) then
					arg_321_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_10 + var_324_11 and arg_321_1.time_ < var_324_10 + var_324_11 + arg_324_0 and not isNil(var_324_9) and arg_321_1.var_.characterEffect1049ui_story then
				arg_321_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_324_13 = 0

			if var_324_13 < arg_321_1.time_ and arg_321_1.time_ <= var_324_13 + arg_324_0 then
				arg_321_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_324_14 = 0

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_324_15 = 0
			local var_324_16 = 0.575

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_17 = arg_321_1:FormatText(StoryNameCfg[551].name)

				arg_321_1.leftNameTxt_.text = var_324_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_18 = arg_321_1:GetWordFromCfg(1104901077)
				local var_324_19 = arg_321_1:FormatText(var_324_18.content)

				arg_321_1.text_.text = var_324_19

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_20 = 23
				local var_324_21 = utf8.len(var_324_19)
				local var_324_22 = var_324_20 <= 0 and var_324_16 or var_324_16 * (var_324_21 / var_324_20)

				if var_324_22 > 0 and var_324_16 < var_324_22 then
					arg_321_1.talkMaxDuration = var_324_22

					if var_324_22 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_22 + var_324_15
					end
				end

				arg_321_1.text_.text = var_324_19
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901077", "story_v_side_new_1104901.awb") ~= 0 then
					local var_324_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901077", "story_v_side_new_1104901.awb") / 1000

					if var_324_23 + var_324_15 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_23 + var_324_15
					end

					if var_324_18.prefab_name ~= "" and arg_321_1.actors_[var_324_18.prefab_name] ~= nil then
						local var_324_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_18.prefab_name].transform, "story_v_side_new_1104901", "1104901077", "story_v_side_new_1104901.awb")

						arg_321_1:RecordAudio("1104901077", var_324_24)
						arg_321_1:RecordAudio("1104901077", var_324_24)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901077", "story_v_side_new_1104901.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901077", "story_v_side_new_1104901.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_25 = math.max(var_324_16, arg_321_1.talkMaxDuration)

			if var_324_15 <= arg_321_1.time_ and arg_321_1.time_ < var_324_15 + var_324_25 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_15) / var_324_25

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_15 + var_324_25 and arg_321_1.time_ < var_324_15 + var_324_25 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play1104901078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1104901078
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1104901079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1049ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1049ui_story == nil then
				arg_325_1.var_.characterEffect1049ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect1049ui_story and not isNil(var_328_0) then
					local var_328_4 = Mathf.Lerp(0, 0.5, var_328_3)

					arg_325_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1049ui_story.fillRatio = var_328_4
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1049ui_story then
				local var_328_5 = 0.5

				arg_325_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1049ui_story.fillRatio = var_328_5
			end

			local var_328_6 = 0
			local var_328_7 = 0.925

			if var_328_6 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_8 = arg_325_1:FormatText(StoryNameCfg[7].name)

				arg_325_1.leftNameTxt_.text = var_328_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_9 = arg_325_1:GetWordFromCfg(1104901078)
				local var_328_10 = arg_325_1:FormatText(var_328_9.content)

				arg_325_1.text_.text = var_328_10

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 37
				local var_328_12 = utf8.len(var_328_10)
				local var_328_13 = var_328_11 <= 0 and var_328_7 or var_328_7 * (var_328_12 / var_328_11)

				if var_328_13 > 0 and var_328_7 < var_328_13 then
					arg_325_1.talkMaxDuration = var_328_13

					if var_328_13 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_13 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_10
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_14 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_14 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_14

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_14 and arg_325_1.time_ < var_328_6 + var_328_14 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1104901079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1104901079
		arg_329_1.duration_ = 1.3

		local var_329_0 = {
			zh = 0.999999999999,
			ja = 1.3
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1104901080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 0.05

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_2 = arg_329_1:FormatText(StoryNameCfg[1008].name)

				arg_329_1.leftNameTxt_.text = var_332_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:GetWordFromCfg(1104901079)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 2
				local var_332_6 = utf8.len(var_332_4)
				local var_332_7 = var_332_5 <= 0 and var_332_1 or var_332_1 * (var_332_6 / var_332_5)

				if var_332_7 > 0 and var_332_1 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_4
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901079", "story_v_side_new_1104901.awb") ~= 0 then
					local var_332_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901079", "story_v_side_new_1104901.awb") / 1000

					if var_332_8 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_0
					end

					if var_332_3.prefab_name ~= "" and arg_329_1.actors_[var_332_3.prefab_name] ~= nil then
						local var_332_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_3.prefab_name].transform, "story_v_side_new_1104901", "1104901079", "story_v_side_new_1104901.awb")

						arg_329_1:RecordAudio("1104901079", var_332_9)
						arg_329_1:RecordAudio("1104901079", var_332_9)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901079", "story_v_side_new_1104901.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901079", "story_v_side_new_1104901.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_10 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_10 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_10

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_10 and arg_329_1.time_ < var_332_0 + var_332_10 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1104901080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1104901080
		arg_333_1.duration_ = 3.77

		local var_333_0 = {
			zh = 1.7,
			ja = 3.766
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1104901081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1049ui_story"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos1049ui_story = var_336_0.localPosition
			end

			local var_336_2 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2
				local var_336_4 = Vector3.New(0, -1.2, -6)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1049ui_story, var_336_4, var_336_3)

				local var_336_5 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_5.x, var_336_5.y, var_336_5.z)

				local var_336_6 = var_336_0.localEulerAngles

				var_336_6.z = 0
				var_336_6.x = 0
				var_336_0.localEulerAngles = var_336_6
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_336_7 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_7.x, var_336_7.y, var_336_7.z)

				local var_336_8 = var_336_0.localEulerAngles

				var_336_8.z = 0
				var_336_8.x = 0
				var_336_0.localEulerAngles = var_336_8
			end

			local var_336_9 = arg_333_1.actors_["1049ui_story"]
			local var_336_10 = 0

			if var_336_10 < arg_333_1.time_ and arg_333_1.time_ <= var_336_10 + arg_336_0 and not isNil(var_336_9) and arg_333_1.var_.characterEffect1049ui_story == nil then
				arg_333_1.var_.characterEffect1049ui_story = var_336_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_11 = 0.200000002980232

			if var_336_10 <= arg_333_1.time_ and arg_333_1.time_ < var_336_10 + var_336_11 and not isNil(var_336_9) then
				local var_336_12 = (arg_333_1.time_ - var_336_10) / var_336_11

				if arg_333_1.var_.characterEffect1049ui_story and not isNil(var_336_9) then
					arg_333_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_10 + var_336_11 and arg_333_1.time_ < var_336_10 + var_336_11 + arg_336_0 and not isNil(var_336_9) and arg_333_1.var_.characterEffect1049ui_story then
				arg_333_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_336_13 = 0

			if var_336_13 < arg_333_1.time_ and arg_333_1.time_ <= var_336_13 + arg_336_0 then
				arg_333_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_336_14 = 0

			if var_336_14 < arg_333_1.time_ and arg_333_1.time_ <= var_336_14 + arg_336_0 then
				arg_333_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_336_15 = 0
			local var_336_16 = 0.2

			if var_336_15 < arg_333_1.time_ and arg_333_1.time_ <= var_336_15 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_17 = arg_333_1:FormatText(StoryNameCfg[551].name)

				arg_333_1.leftNameTxt_.text = var_336_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_18 = arg_333_1:GetWordFromCfg(1104901080)
				local var_336_19 = arg_333_1:FormatText(var_336_18.content)

				arg_333_1.text_.text = var_336_19

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_20 = 8
				local var_336_21 = utf8.len(var_336_19)
				local var_336_22 = var_336_20 <= 0 and var_336_16 or var_336_16 * (var_336_21 / var_336_20)

				if var_336_22 > 0 and var_336_16 < var_336_22 then
					arg_333_1.talkMaxDuration = var_336_22

					if var_336_22 + var_336_15 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_22 + var_336_15
					end
				end

				arg_333_1.text_.text = var_336_19
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901080", "story_v_side_new_1104901.awb") ~= 0 then
					local var_336_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901080", "story_v_side_new_1104901.awb") / 1000

					if var_336_23 + var_336_15 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_23 + var_336_15
					end

					if var_336_18.prefab_name ~= "" and arg_333_1.actors_[var_336_18.prefab_name] ~= nil then
						local var_336_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_18.prefab_name].transform, "story_v_side_new_1104901", "1104901080", "story_v_side_new_1104901.awb")

						arg_333_1:RecordAudio("1104901080", var_336_24)
						arg_333_1:RecordAudio("1104901080", var_336_24)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901080", "story_v_side_new_1104901.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901080", "story_v_side_new_1104901.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_25 = math.max(var_336_16, arg_333_1.talkMaxDuration)

			if var_336_15 <= arg_333_1.time_ and arg_333_1.time_ < var_336_15 + var_336_25 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_15) / var_336_25

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_15 + var_336_25 and arg_333_1.time_ < var_336_15 + var_336_25 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104901081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1104901081
		arg_337_1.duration_ = 1.53

		local var_337_0 = {
			zh = 1.066,
			ja = 1.533
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1104901082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1049ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1049ui_story == nil then
				arg_337_1.var_.characterEffect1049ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1049ui_story and not isNil(var_340_0) then
					local var_340_4 = Mathf.Lerp(0, 0.5, var_340_3)

					arg_337_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1049ui_story.fillRatio = var_340_4
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1049ui_story then
				local var_340_5 = 0.5

				arg_337_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1049ui_story.fillRatio = var_340_5
			end

			local var_340_6 = 0
			local var_340_7 = 0.05

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_8 = arg_337_1:FormatText(StoryNameCfg[1008].name)

				arg_337_1.leftNameTxt_.text = var_340_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10119")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_9 = arg_337_1:GetWordFromCfg(1104901081)
				local var_340_10 = arg_337_1:FormatText(var_340_9.content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 2
				local var_340_12 = utf8.len(var_340_10)
				local var_340_13 = var_340_11 <= 0 and var_340_7 or var_340_7 * (var_340_12 / var_340_11)

				if var_340_13 > 0 and var_340_7 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_10
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901081", "story_v_side_new_1104901.awb") ~= 0 then
					local var_340_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901081", "story_v_side_new_1104901.awb") / 1000

					if var_340_14 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_14 + var_340_6
					end

					if var_340_9.prefab_name ~= "" and arg_337_1.actors_[var_340_9.prefab_name] ~= nil then
						local var_340_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_9.prefab_name].transform, "story_v_side_new_1104901", "1104901081", "story_v_side_new_1104901.awb")

						arg_337_1:RecordAudio("1104901081", var_340_15)
						arg_337_1:RecordAudio("1104901081", var_340_15)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901081", "story_v_side_new_1104901.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901081", "story_v_side_new_1104901.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_16 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_16 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_16

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_16 and arg_337_1.time_ < var_340_6 + var_340_16 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1104901082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1104901082
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1104901083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.275

			if var_344_0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_2 = arg_341_1:FormatText(StoryNameCfg[7].name)

				arg_341_1.leftNameTxt_.text = var_344_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, true)
				arg_341_1.iconController_:SetSelectedState("hero")

				arg_341_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_341_1.callingController_:SetSelectedState("normal")

				arg_341_1.keyicon_.color = Color.New(1, 1, 1)
				arg_341_1.icon_.color = Color.New(1, 1, 1)

				local var_344_3 = arg_341_1:GetWordFromCfg(1104901082)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 11
				local var_344_6 = utf8.len(var_344_4)
				local var_344_7 = var_344_5 <= 0 and var_344_1 or var_344_1 * (var_344_6 / var_344_5)

				if var_344_7 > 0 and var_344_1 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_0
					end
				end

				arg_341_1.text_.text = var_344_4
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_8 = math.max(var_344_1, arg_341_1.talkMaxDuration)

			if var_344_0 <= arg_341_1.time_ and arg_341_1.time_ < var_344_0 + var_344_8 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_0) / var_344_8

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_0 + var_344_8 and arg_341_1.time_ < var_344_0 + var_344_8 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play1104901083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1104901083
		arg_345_1.duration_ = 3.93

		local var_345_0 = {
			zh = 2.8,
			ja = 3.933
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1104901084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1049ui_story"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos1049ui_story = var_348_0.localPosition
			end

			local var_348_2 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2
				local var_348_4 = Vector3.New(0, -1.2, -6)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1049ui_story, var_348_4, var_348_3)

				local var_348_5 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_5.x, var_348_5.y, var_348_5.z)

				local var_348_6 = var_348_0.localEulerAngles

				var_348_6.z = 0
				var_348_6.x = 0
				var_348_0.localEulerAngles = var_348_6
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_348_7 = manager.ui.mainCamera.transform.position - var_348_0.position

				var_348_0.forward = Vector3.New(var_348_7.x, var_348_7.y, var_348_7.z)

				local var_348_8 = var_348_0.localEulerAngles

				var_348_8.z = 0
				var_348_8.x = 0
				var_348_0.localEulerAngles = var_348_8
			end

			local var_348_9 = arg_345_1.actors_["1049ui_story"]
			local var_348_10 = 0

			if var_348_10 < arg_345_1.time_ and arg_345_1.time_ <= var_348_10 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect1049ui_story == nil then
				arg_345_1.var_.characterEffect1049ui_story = var_348_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_11 = 0.200000002980232

			if var_348_10 <= arg_345_1.time_ and arg_345_1.time_ < var_348_10 + var_348_11 and not isNil(var_348_9) then
				local var_348_12 = (arg_345_1.time_ - var_348_10) / var_348_11

				if arg_345_1.var_.characterEffect1049ui_story and not isNil(var_348_9) then
					arg_345_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_10 + var_348_11 and arg_345_1.time_ < var_348_10 + var_348_11 + arg_348_0 and not isNil(var_348_9) and arg_345_1.var_.characterEffect1049ui_story then
				arg_345_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_348_13 = 0

			if var_348_13 < arg_345_1.time_ and arg_345_1.time_ <= var_348_13 + arg_348_0 then
				arg_345_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_348_14 = 0

			if var_348_14 < arg_345_1.time_ and arg_345_1.time_ <= var_348_14 + arg_348_0 then
				arg_345_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_348_15 = 0
			local var_348_16 = 0.2

			if var_348_15 < arg_345_1.time_ and arg_345_1.time_ <= var_348_15 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_17 = arg_345_1:FormatText(StoryNameCfg[551].name)

				arg_345_1.leftNameTxt_.text = var_348_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_18 = arg_345_1:GetWordFromCfg(1104901083)
				local var_348_19 = arg_345_1:FormatText(var_348_18.content)

				arg_345_1.text_.text = var_348_19

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_20 = 8
				local var_348_21 = utf8.len(var_348_19)
				local var_348_22 = var_348_20 <= 0 and var_348_16 or var_348_16 * (var_348_21 / var_348_20)

				if var_348_22 > 0 and var_348_16 < var_348_22 then
					arg_345_1.talkMaxDuration = var_348_22

					if var_348_22 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_22 + var_348_15
					end
				end

				arg_345_1.text_.text = var_348_19
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901083", "story_v_side_new_1104901.awb") ~= 0 then
					local var_348_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901083", "story_v_side_new_1104901.awb") / 1000

					if var_348_23 + var_348_15 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_23 + var_348_15
					end

					if var_348_18.prefab_name ~= "" and arg_345_1.actors_[var_348_18.prefab_name] ~= nil then
						local var_348_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_18.prefab_name].transform, "story_v_side_new_1104901", "1104901083", "story_v_side_new_1104901.awb")

						arg_345_1:RecordAudio("1104901083", var_348_24)
						arg_345_1:RecordAudio("1104901083", var_348_24)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901083", "story_v_side_new_1104901.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901083", "story_v_side_new_1104901.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_25 = math.max(var_348_16, arg_345_1.talkMaxDuration)

			if var_348_15 <= arg_345_1.time_ and arg_345_1.time_ < var_348_15 + var_348_25 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_15) / var_348_25

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_15 + var_348_25 and arg_345_1.time_ < var_348_15 + var_348_25 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104901084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1104901084
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1104901085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1049ui_story"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos1049ui_story = var_352_0.localPosition
			end

			local var_352_2 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2
				local var_352_4 = Vector3.New(0, 100, 0)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1049ui_story, var_352_4, var_352_3)

				local var_352_5 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_5.x, var_352_5.y, var_352_5.z)

				local var_352_6 = var_352_0.localEulerAngles

				var_352_6.z = 0
				var_352_6.x = 0
				var_352_0.localEulerAngles = var_352_6
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(0, 100, 0)

				local var_352_7 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_7.x, var_352_7.y, var_352_7.z)

				local var_352_8 = var_352_0.localEulerAngles

				var_352_8.z = 0
				var_352_8.x = 0
				var_352_0.localEulerAngles = var_352_8
			end

			local var_352_9 = arg_349_1.actors_["1049ui_story"]
			local var_352_10 = 0

			if var_352_10 < arg_349_1.time_ and arg_349_1.time_ <= var_352_10 + arg_352_0 and not isNil(var_352_9) and arg_349_1.var_.characterEffect1049ui_story == nil then
				arg_349_1.var_.characterEffect1049ui_story = var_352_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_11 = 0.200000002980232

			if var_352_10 <= arg_349_1.time_ and arg_349_1.time_ < var_352_10 + var_352_11 and not isNil(var_352_9) then
				local var_352_12 = (arg_349_1.time_ - var_352_10) / var_352_11

				if arg_349_1.var_.characterEffect1049ui_story and not isNil(var_352_9) then
					local var_352_13 = Mathf.Lerp(0, 0.5, var_352_12)

					arg_349_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1049ui_story.fillRatio = var_352_13
				end
			end

			if arg_349_1.time_ >= var_352_10 + var_352_11 and arg_349_1.time_ < var_352_10 + var_352_11 + arg_352_0 and not isNil(var_352_9) and arg_349_1.var_.characterEffect1049ui_story then
				local var_352_14 = 0.5

				arg_349_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1049ui_story.fillRatio = var_352_14
			end

			local var_352_15 = 0
			local var_352_16 = 0.7

			if var_352_15 < arg_349_1.time_ and arg_349_1.time_ <= var_352_15 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_17 = arg_349_1:GetWordFromCfg(1104901084)
				local var_352_18 = arg_349_1:FormatText(var_352_17.content)

				arg_349_1.text_.text = var_352_18

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_19 = 28
				local var_352_20 = utf8.len(var_352_18)
				local var_352_21 = var_352_19 <= 0 and var_352_16 or var_352_16 * (var_352_20 / var_352_19)

				if var_352_21 > 0 and var_352_16 < var_352_21 then
					arg_349_1.talkMaxDuration = var_352_21

					if var_352_21 + var_352_15 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_21 + var_352_15
					end
				end

				arg_349_1.text_.text = var_352_18
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_22 = math.max(var_352_16, arg_349_1.talkMaxDuration)

			if var_352_15 <= arg_349_1.time_ and arg_349_1.time_ < var_352_15 + var_352_22 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_15) / var_352_22

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_15 + var_352_22 and arg_349_1.time_ < var_352_15 + var_352_22 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104901085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1104901085
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1104901086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 1.125

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_2 = arg_353_1:GetWordFromCfg(1104901085)
				local var_356_3 = arg_353_1:FormatText(var_356_2.content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 45
				local var_356_5 = utf8.len(var_356_3)
				local var_356_6 = var_356_4 <= 0 and var_356_1 or var_356_1 * (var_356_5 / var_356_4)

				if var_356_6 > 0 and var_356_1 < var_356_6 then
					arg_353_1.talkMaxDuration = var_356_6

					if var_356_6 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_6 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_3
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_7 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_7 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_7

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_7 and arg_353_1.time_ < var_356_0 + var_356_7 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1104901086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1104901086
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1104901087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 0.6

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_2 = arg_357_1:GetWordFromCfg(1104901086)
				local var_360_3 = arg_357_1:FormatText(var_360_2.content)

				arg_357_1.text_.text = var_360_3

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 24
				local var_360_5 = utf8.len(var_360_3)
				local var_360_6 = var_360_4 <= 0 and var_360_1 or var_360_1 * (var_360_5 / var_360_4)

				if var_360_6 > 0 and var_360_1 < var_360_6 then
					arg_357_1.talkMaxDuration = var_360_6

					if var_360_6 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_6 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_3
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_7 and arg_357_1.time_ < var_360_0 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play1104901087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1104901087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1104901088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.375

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[7].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(1104901087)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 15
				local var_364_6 = utf8.len(var_364_4)
				local var_364_7 = var_364_5 <= 0 and var_364_1 or var_364_1 * (var_364_6 / var_364_5)

				if var_364_7 > 0 and var_364_1 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_8 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_8 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_8

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_8 and arg_361_1.time_ < var_364_0 + var_364_8 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1104901088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1104901088
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1104901089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.575

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_2 = arg_365_1:GetWordFromCfg(1104901088)
				local var_368_3 = arg_365_1:FormatText(var_368_2.content)

				arg_365_1.text_.text = var_368_3

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 23
				local var_368_5 = utf8.len(var_368_3)
				local var_368_6 = var_368_4 <= 0 and var_368_1 or var_368_1 * (var_368_5 / var_368_4)

				if var_368_6 > 0 and var_368_1 < var_368_6 then
					arg_365_1.talkMaxDuration = var_368_6

					if var_368_6 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_6 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_3
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_7 and arg_365_1.time_ < var_368_0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1104901089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1104901089
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1104901090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0
			local var_372_1 = 0.725

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_2 = arg_369_1:GetWordFromCfg(1104901089)
				local var_372_3 = arg_369_1:FormatText(var_372_2.content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_4 = 29
				local var_372_5 = utf8.len(var_372_3)
				local var_372_6 = var_372_4 <= 0 and var_372_1 or var_372_1 * (var_372_5 / var_372_4)

				if var_372_6 > 0 and var_372_1 < var_372_6 then
					arg_369_1.talkMaxDuration = var_372_6

					if var_372_6 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_6 + var_372_0
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_7 = math.max(var_372_1, arg_369_1.talkMaxDuration)

			if var_372_0 <= arg_369_1.time_ and arg_369_1.time_ < var_372_0 + var_372_7 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_0) / var_372_7

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_0 + var_372_7 and arg_369_1.time_ < var_372_0 + var_372_7 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1104901090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1104901090
		arg_373_1.duration_ = 1

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"

			SetActive(arg_373_1.choicesGo_, true)

			for iter_374_0, iter_374_1 in ipairs(arg_373_1.choices_) do
				local var_374_0 = iter_374_0 <= 2

				SetActive(iter_374_1.go, var_374_0)
			end

			arg_373_1.choices_[1].txt.text = arg_373_1:FormatText(StoryChoiceCfg[870].name)
			arg_373_1.choices_[2].txt.text = arg_373_1:FormatText(StoryChoiceCfg[871].name)
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1104901091(arg_373_1)
			end

			if arg_375_0 == 2 then
				arg_373_0:Play1104901091(arg_373_1)
			end

			arg_373_1:RecordChoiceLog(1104901090, 870, 871)
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.allBtn_.enabled = false
			end

			local var_376_1 = 0.6

			if arg_373_1.time_ >= var_376_0 + var_376_1 and arg_373_1.time_ < var_376_0 + var_376_1 + arg_376_0 then
				arg_373_1.allBtn_.enabled = true
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play1104901091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1104901091
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1104901092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0
			local var_380_1 = 0.9

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_2 = arg_377_1:FormatText(StoryNameCfg[7].name)

				arg_377_1.leftNameTxt_.text = var_380_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, true)
				arg_377_1.iconController_:SetSelectedState("hero")

				arg_377_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_377_1.callingController_:SetSelectedState("normal")

				arg_377_1.keyicon_.color = Color.New(1, 1, 1)
				arg_377_1.icon_.color = Color.New(1, 1, 1)

				local var_380_3 = arg_377_1:GetWordFromCfg(1104901091)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 36
				local var_380_6 = utf8.len(var_380_4)
				local var_380_7 = var_380_5 <= 0 and var_380_1 or var_380_1 * (var_380_6 / var_380_5)

				if var_380_7 > 0 and var_380_1 < var_380_7 then
					arg_377_1.talkMaxDuration = var_380_7

					if var_380_7 + var_380_0 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_7 + var_380_0
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_8 = math.max(var_380_1, arg_377_1.talkMaxDuration)

			if var_380_0 <= arg_377_1.time_ and arg_377_1.time_ < var_380_0 + var_380_8 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_0) / var_380_8

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_0 + var_380_8 and arg_377_1.time_ < var_380_0 + var_380_8 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play1104901092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 1104901092
		arg_381_1.duration_ = 5.8

		local var_381_0 = {
			zh = 3.8,
			ja = 5.8
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play1104901093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1049ui_story"].transform
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.var_.moveOldPos1049ui_story = var_384_0.localPosition
			end

			local var_384_2 = 0.001

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2
				local var_384_4 = Vector3.New(0, -1.2, -6)

				var_384_0.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1049ui_story, var_384_4, var_384_3)

				local var_384_5 = manager.ui.mainCamera.transform.position - var_384_0.position

				var_384_0.forward = Vector3.New(var_384_5.x, var_384_5.y, var_384_5.z)

				local var_384_6 = var_384_0.localEulerAngles

				var_384_6.z = 0
				var_384_6.x = 0
				var_384_0.localEulerAngles = var_384_6
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 then
				var_384_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_384_7 = manager.ui.mainCamera.transform.position - var_384_0.position

				var_384_0.forward = Vector3.New(var_384_7.x, var_384_7.y, var_384_7.z)

				local var_384_8 = var_384_0.localEulerAngles

				var_384_8.z = 0
				var_384_8.x = 0
				var_384_0.localEulerAngles = var_384_8
			end

			local var_384_9 = arg_381_1.actors_["1049ui_story"]
			local var_384_10 = 0

			if var_384_10 < arg_381_1.time_ and arg_381_1.time_ <= var_384_10 + arg_384_0 and not isNil(var_384_9) and arg_381_1.var_.characterEffect1049ui_story == nil then
				arg_381_1.var_.characterEffect1049ui_story = var_384_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_11 = 0.200000002980232

			if var_384_10 <= arg_381_1.time_ and arg_381_1.time_ < var_384_10 + var_384_11 and not isNil(var_384_9) then
				local var_384_12 = (arg_381_1.time_ - var_384_10) / var_384_11

				if arg_381_1.var_.characterEffect1049ui_story and not isNil(var_384_9) then
					arg_381_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= var_384_10 + var_384_11 and arg_381_1.time_ < var_384_10 + var_384_11 + arg_384_0 and not isNil(var_384_9) and arg_381_1.var_.characterEffect1049ui_story then
				arg_381_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_384_13 = 0

			if var_384_13 < arg_381_1.time_ and arg_381_1.time_ <= var_384_13 + arg_384_0 then
				arg_381_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			local var_384_14 = 0

			if var_384_14 < arg_381_1.time_ and arg_381_1.time_ <= var_384_14 + arg_384_0 then
				arg_381_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_384_15 = 0
			local var_384_16 = 0.275

			if var_384_15 < arg_381_1.time_ and arg_381_1.time_ <= var_384_15 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_17 = arg_381_1:FormatText(StoryNameCfg[551].name)

				arg_381_1.leftNameTxt_.text = var_384_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_18 = arg_381_1:GetWordFromCfg(1104901092)
				local var_384_19 = arg_381_1:FormatText(var_384_18.content)

				arg_381_1.text_.text = var_384_19

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_20 = 11
				local var_384_21 = utf8.len(var_384_19)
				local var_384_22 = var_384_20 <= 0 and var_384_16 or var_384_16 * (var_384_21 / var_384_20)

				if var_384_22 > 0 and var_384_16 < var_384_22 then
					arg_381_1.talkMaxDuration = var_384_22

					if var_384_22 + var_384_15 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_22 + var_384_15
					end
				end

				arg_381_1.text_.text = var_384_19
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901092", "story_v_side_new_1104901.awb") ~= 0 then
					local var_384_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901092", "story_v_side_new_1104901.awb") / 1000

					if var_384_23 + var_384_15 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_23 + var_384_15
					end

					if var_384_18.prefab_name ~= "" and arg_381_1.actors_[var_384_18.prefab_name] ~= nil then
						local var_384_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_18.prefab_name].transform, "story_v_side_new_1104901", "1104901092", "story_v_side_new_1104901.awb")

						arg_381_1:RecordAudio("1104901092", var_384_24)
						arg_381_1:RecordAudio("1104901092", var_384_24)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901092", "story_v_side_new_1104901.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901092", "story_v_side_new_1104901.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_25 = math.max(var_384_16, arg_381_1.talkMaxDuration)

			if var_384_15 <= arg_381_1.time_ and arg_381_1.time_ < var_384_15 + var_384_25 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_15) / var_384_25

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_15 + var_384_25 and arg_381_1.time_ < var_384_15 + var_384_25 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104901093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 1104901093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play1104901094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1049ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1049ui_story == nil then
				arg_385_1.var_.characterEffect1049ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect1049ui_story and not isNil(var_388_0) then
					local var_388_4 = Mathf.Lerp(0, 0.5, var_388_3)

					arg_385_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1049ui_story.fillRatio = var_388_4
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect1049ui_story then
				local var_388_5 = 0.5

				arg_385_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1049ui_story.fillRatio = var_388_5
			end

			local var_388_6 = 0
			local var_388_7 = 0.5

			if var_388_6 < arg_385_1.time_ and arg_385_1.time_ <= var_388_6 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_8 = arg_385_1:FormatText(StoryNameCfg[7].name)

				arg_385_1.leftNameTxt_.text = var_388_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_9 = arg_385_1:GetWordFromCfg(1104901093)
				local var_388_10 = arg_385_1:FormatText(var_388_9.content)

				arg_385_1.text_.text = var_388_10

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_11 = 20
				local var_388_12 = utf8.len(var_388_10)
				local var_388_13 = var_388_11 <= 0 and var_388_7 or var_388_7 * (var_388_12 / var_388_11)

				if var_388_13 > 0 and var_388_7 < var_388_13 then
					arg_385_1.talkMaxDuration = var_388_13

					if var_388_13 + var_388_6 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_13 + var_388_6
					end
				end

				arg_385_1.text_.text = var_388_10
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_14 = math.max(var_388_7, arg_385_1.talkMaxDuration)

			if var_388_6 <= arg_385_1.time_ and arg_385_1.time_ < var_388_6 + var_388_14 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_6) / var_388_14

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_6 + var_388_14 and arg_385_1.time_ < var_388_6 + var_388_14 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play1104901094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1104901094
		arg_389_1.duration_ = 4.1

		local var_389_0 = {
			zh = 4.1,
			ja = 3.8
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1104901095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1049ui_story"].transform
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.var_.moveOldPos1049ui_story = var_392_0.localPosition
			end

			local var_392_2 = 0.001

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2
				local var_392_4 = Vector3.New(0, -1.2, -6)

				var_392_0.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1049ui_story, var_392_4, var_392_3)

				local var_392_5 = manager.ui.mainCamera.transform.position - var_392_0.position

				var_392_0.forward = Vector3.New(var_392_5.x, var_392_5.y, var_392_5.z)

				local var_392_6 = var_392_0.localEulerAngles

				var_392_6.z = 0
				var_392_6.x = 0
				var_392_0.localEulerAngles = var_392_6
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 then
				var_392_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_392_7 = manager.ui.mainCamera.transform.position - var_392_0.position

				var_392_0.forward = Vector3.New(var_392_7.x, var_392_7.y, var_392_7.z)

				local var_392_8 = var_392_0.localEulerAngles

				var_392_8.z = 0
				var_392_8.x = 0
				var_392_0.localEulerAngles = var_392_8
			end

			local var_392_9 = arg_389_1.actors_["1049ui_story"]
			local var_392_10 = 0

			if var_392_10 < arg_389_1.time_ and arg_389_1.time_ <= var_392_10 + arg_392_0 and not isNil(var_392_9) and arg_389_1.var_.characterEffect1049ui_story == nil then
				arg_389_1.var_.characterEffect1049ui_story = var_392_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_11 = 0.200000002980232

			if var_392_10 <= arg_389_1.time_ and arg_389_1.time_ < var_392_10 + var_392_11 and not isNil(var_392_9) then
				local var_392_12 = (arg_389_1.time_ - var_392_10) / var_392_11

				if arg_389_1.var_.characterEffect1049ui_story and not isNil(var_392_9) then
					arg_389_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= var_392_10 + var_392_11 and arg_389_1.time_ < var_392_10 + var_392_11 + arg_392_0 and not isNil(var_392_9) and arg_389_1.var_.characterEffect1049ui_story then
				arg_389_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_392_13 = 0

			if var_392_13 < arg_389_1.time_ and arg_389_1.time_ <= var_392_13 + arg_392_0 then
				arg_389_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action4_1")
			end

			local var_392_14 = 0

			if var_392_14 < arg_389_1.time_ and arg_389_1.time_ <= var_392_14 + arg_392_0 then
				arg_389_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_392_15 = 0
			local var_392_16 = 0.325

			if var_392_15 < arg_389_1.time_ and arg_389_1.time_ <= var_392_15 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_17 = arg_389_1:FormatText(StoryNameCfg[551].name)

				arg_389_1.leftNameTxt_.text = var_392_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_18 = arg_389_1:GetWordFromCfg(1104901094)
				local var_392_19 = arg_389_1:FormatText(var_392_18.content)

				arg_389_1.text_.text = var_392_19

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_20 = 13
				local var_392_21 = utf8.len(var_392_19)
				local var_392_22 = var_392_20 <= 0 and var_392_16 or var_392_16 * (var_392_21 / var_392_20)

				if var_392_22 > 0 and var_392_16 < var_392_22 then
					arg_389_1.talkMaxDuration = var_392_22

					if var_392_22 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_22 + var_392_15
					end
				end

				arg_389_1.text_.text = var_392_19
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901094", "story_v_side_new_1104901.awb") ~= 0 then
					local var_392_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901094", "story_v_side_new_1104901.awb") / 1000

					if var_392_23 + var_392_15 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_23 + var_392_15
					end

					if var_392_18.prefab_name ~= "" and arg_389_1.actors_[var_392_18.prefab_name] ~= nil then
						local var_392_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_18.prefab_name].transform, "story_v_side_new_1104901", "1104901094", "story_v_side_new_1104901.awb")

						arg_389_1:RecordAudio("1104901094", var_392_24)
						arg_389_1:RecordAudio("1104901094", var_392_24)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901094", "story_v_side_new_1104901.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901094", "story_v_side_new_1104901.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_25 = math.max(var_392_16, arg_389_1.talkMaxDuration)

			if var_392_15 <= arg_389_1.time_ and arg_389_1.time_ < var_392_15 + var_392_25 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_15) / var_392_25

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_15 + var_392_25 and arg_389_1.time_ < var_392_15 + var_392_25 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104901095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1104901095
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1104901096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1049ui_story"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos1049ui_story = var_396_0.localPosition
			end

			local var_396_2 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2
				local var_396_4 = Vector3.New(0, 100, 0)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1049ui_story, var_396_4, var_396_3)

				local var_396_5 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_5.x, var_396_5.y, var_396_5.z)

				local var_396_6 = var_396_0.localEulerAngles

				var_396_6.z = 0
				var_396_6.x = 0
				var_396_0.localEulerAngles = var_396_6
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(0, 100, 0)

				local var_396_7 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_7.x, var_396_7.y, var_396_7.z)

				local var_396_8 = var_396_0.localEulerAngles

				var_396_8.z = 0
				var_396_8.x = 0
				var_396_0.localEulerAngles = var_396_8
			end

			local var_396_9 = arg_393_1.actors_["1049ui_story"]
			local var_396_10 = 0

			if var_396_10 < arg_393_1.time_ and arg_393_1.time_ <= var_396_10 + arg_396_0 and not isNil(var_396_9) and arg_393_1.var_.characterEffect1049ui_story == nil then
				arg_393_1.var_.characterEffect1049ui_story = var_396_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_11 = 0.200000002980232

			if var_396_10 <= arg_393_1.time_ and arg_393_1.time_ < var_396_10 + var_396_11 and not isNil(var_396_9) then
				local var_396_12 = (arg_393_1.time_ - var_396_10) / var_396_11

				if arg_393_1.var_.characterEffect1049ui_story and not isNil(var_396_9) then
					local var_396_13 = Mathf.Lerp(0, 0.5, var_396_12)

					arg_393_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1049ui_story.fillRatio = var_396_13
				end
			end

			if arg_393_1.time_ >= var_396_10 + var_396_11 and arg_393_1.time_ < var_396_10 + var_396_11 + arg_396_0 and not isNil(var_396_9) and arg_393_1.var_.characterEffect1049ui_story then
				local var_396_14 = 0.5

				arg_393_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1049ui_story.fillRatio = var_396_14
			end

			local var_396_15 = 0
			local var_396_16 = 0.7

			if var_396_15 < arg_393_1.time_ and arg_393_1.time_ <= var_396_15 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_17 = arg_393_1:GetWordFromCfg(1104901095)
				local var_396_18 = arg_393_1:FormatText(var_396_17.content)

				arg_393_1.text_.text = var_396_18

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_19 = 28
				local var_396_20 = utf8.len(var_396_18)
				local var_396_21 = var_396_19 <= 0 and var_396_16 or var_396_16 * (var_396_20 / var_396_19)

				if var_396_21 > 0 and var_396_16 < var_396_21 then
					arg_393_1.talkMaxDuration = var_396_21

					if var_396_21 + var_396_15 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_21 + var_396_15
					end
				end

				arg_393_1.text_.text = var_396_18
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_22 = math.max(var_396_16, arg_393_1.talkMaxDuration)

			if var_396_15 <= arg_393_1.time_ and arg_393_1.time_ < var_396_15 + var_396_22 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_15) / var_396_22

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_15 + var_396_22 and arg_393_1.time_ < var_396_15 + var_396_22 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play1104901096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1104901096
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1104901097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 0.6

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_2 = arg_397_1:GetWordFromCfg(1104901096)
				local var_400_3 = arg_397_1:FormatText(var_400_2.content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 24
				local var_400_5 = utf8.len(var_400_3)
				local var_400_6 = var_400_4 <= 0 and var_400_1 or var_400_1 * (var_400_5 / var_400_4)

				if var_400_6 > 0 and var_400_1 < var_400_6 then
					arg_397_1.talkMaxDuration = var_400_6

					if var_400_6 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_6 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_7 and arg_397_1.time_ < var_400_0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play1104901097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1104901097
		arg_401_1.duration_ = 2

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1104901098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1049ui_story"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos1049ui_story = var_404_0.localPosition
			end

			local var_404_2 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2
				local var_404_4 = Vector3.New(0, -1.2, -6)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1049ui_story, var_404_4, var_404_3)

				local var_404_5 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_5.x, var_404_5.y, var_404_5.z)

				local var_404_6 = var_404_0.localEulerAngles

				var_404_6.z = 0
				var_404_6.x = 0
				var_404_0.localEulerAngles = var_404_6
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_404_7 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_7.x, var_404_7.y, var_404_7.z)

				local var_404_8 = var_404_0.localEulerAngles

				var_404_8.z = 0
				var_404_8.x = 0
				var_404_0.localEulerAngles = var_404_8
			end

			local var_404_9 = arg_401_1.actors_["1049ui_story"]
			local var_404_10 = 0

			if var_404_10 < arg_401_1.time_ and arg_401_1.time_ <= var_404_10 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect1049ui_story == nil then
				arg_401_1.var_.characterEffect1049ui_story = var_404_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_11 = 0.200000002980232

			if var_404_10 <= arg_401_1.time_ and arg_401_1.time_ < var_404_10 + var_404_11 and not isNil(var_404_9) then
				local var_404_12 = (arg_401_1.time_ - var_404_10) / var_404_11

				if arg_401_1.var_.characterEffect1049ui_story and not isNil(var_404_9) then
					arg_401_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= var_404_10 + var_404_11 and arg_401_1.time_ < var_404_10 + var_404_11 + arg_404_0 and not isNil(var_404_9) and arg_401_1.var_.characterEffect1049ui_story then
				arg_401_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_404_13 = 0

			if var_404_13 < arg_401_1.time_ and arg_401_1.time_ <= var_404_13 + arg_404_0 then
				arg_401_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action4_2")
			end

			local var_404_14 = 0

			if var_404_14 < arg_401_1.time_ and arg_401_1.time_ <= var_404_14 + arg_404_0 then
				arg_401_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_404_15 = 0
			local var_404_16 = 0.05

			if var_404_15 < arg_401_1.time_ and arg_401_1.time_ <= var_404_15 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_17 = arg_401_1:FormatText(StoryNameCfg[551].name)

				arg_401_1.leftNameTxt_.text = var_404_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_18 = arg_401_1:GetWordFromCfg(1104901097)
				local var_404_19 = arg_401_1:FormatText(var_404_18.content)

				arg_401_1.text_.text = var_404_19

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_20 = 2
				local var_404_21 = utf8.len(var_404_19)
				local var_404_22 = var_404_20 <= 0 and var_404_16 or var_404_16 * (var_404_21 / var_404_20)

				if var_404_22 > 0 and var_404_16 < var_404_22 then
					arg_401_1.talkMaxDuration = var_404_22

					if var_404_22 + var_404_15 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_22 + var_404_15
					end
				end

				arg_401_1.text_.text = var_404_19
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901097", "story_v_side_new_1104901.awb") ~= 0 then
					local var_404_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901097", "story_v_side_new_1104901.awb") / 1000

					if var_404_23 + var_404_15 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_23 + var_404_15
					end

					if var_404_18.prefab_name ~= "" and arg_401_1.actors_[var_404_18.prefab_name] ~= nil then
						local var_404_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_18.prefab_name].transform, "story_v_side_new_1104901", "1104901097", "story_v_side_new_1104901.awb")

						arg_401_1:RecordAudio("1104901097", var_404_24)
						arg_401_1:RecordAudio("1104901097", var_404_24)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901097", "story_v_side_new_1104901.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901097", "story_v_side_new_1104901.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_25 = math.max(var_404_16, arg_401_1.talkMaxDuration)

			if var_404_15 <= arg_401_1.time_ and arg_401_1.time_ < var_404_15 + var_404_25 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_15) / var_404_25

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_15 + var_404_25 and arg_401_1.time_ < var_404_15 + var_404_25 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play1104901098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1104901098
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1104901099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1049ui_story"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1049ui_story == nil then
				arg_405_1.var_.characterEffect1049ui_story = var_408_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.characterEffect1049ui_story and not isNil(var_408_0) then
					local var_408_4 = Mathf.Lerp(0, 0.5, var_408_3)

					arg_405_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1049ui_story.fillRatio = var_408_4
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1049ui_story then
				local var_408_5 = 0.5

				arg_405_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1049ui_story.fillRatio = var_408_5
			end

			local var_408_6 = 0
			local var_408_7 = 0.175

			if var_408_6 < arg_405_1.time_ and arg_405_1.time_ <= var_408_6 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_8 = arg_405_1:FormatText(StoryNameCfg[7].name)

				arg_405_1.leftNameTxt_.text = var_408_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, true)
				arg_405_1.iconController_:SetSelectedState("hero")

				arg_405_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_405_1.callingController_:SetSelectedState("normal")

				arg_405_1.keyicon_.color = Color.New(1, 1, 1)
				arg_405_1.icon_.color = Color.New(1, 1, 1)

				local var_408_9 = arg_405_1:GetWordFromCfg(1104901098)
				local var_408_10 = arg_405_1:FormatText(var_408_9.content)

				arg_405_1.text_.text = var_408_10

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_11 = 7
				local var_408_12 = utf8.len(var_408_10)
				local var_408_13 = var_408_11 <= 0 and var_408_7 or var_408_7 * (var_408_12 / var_408_11)

				if var_408_13 > 0 and var_408_7 < var_408_13 then
					arg_405_1.talkMaxDuration = var_408_13

					if var_408_13 + var_408_6 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_13 + var_408_6
					end
				end

				arg_405_1.text_.text = var_408_10
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_14 = math.max(var_408_7, arg_405_1.talkMaxDuration)

			if var_408_6 <= arg_405_1.time_ and arg_405_1.time_ < var_408_6 + var_408_14 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_6) / var_408_14

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_6 + var_408_14 and arg_405_1.time_ < var_408_6 + var_408_14 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play1104901099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1104901099
		arg_409_1.duration_ = 5.6

		local var_409_0 = {
			zh = 5.6,
			ja = 3.033
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1104901100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1049ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos1049ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0, -1.2, -6)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1049ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = arg_409_1.actors_["1049ui_story"]
			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1049ui_story == nil then
				arg_409_1.var_.characterEffect1049ui_story = var_412_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_11 = 0.200000002980232

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_11 and not isNil(var_412_9) then
				local var_412_12 = (arg_409_1.time_ - var_412_10) / var_412_11

				if arg_409_1.var_.characterEffect1049ui_story and not isNil(var_412_9) then
					arg_409_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_10 + var_412_11 and arg_409_1.time_ < var_412_10 + var_412_11 + arg_412_0 and not isNil(var_412_9) and arg_409_1.var_.characterEffect1049ui_story then
				arg_409_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_412_13 = 0

			if var_412_13 < arg_409_1.time_ and arg_409_1.time_ <= var_412_13 + arg_412_0 then
				arg_409_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_412_14 = 0

			if var_412_14 < arg_409_1.time_ and arg_409_1.time_ <= var_412_14 + arg_412_0 then
				arg_409_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_412_15 = 0
			local var_412_16 = 0.625

			if var_412_15 < arg_409_1.time_ and arg_409_1.time_ <= var_412_15 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_17 = arg_409_1:FormatText(StoryNameCfg[551].name)

				arg_409_1.leftNameTxt_.text = var_412_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_18 = arg_409_1:GetWordFromCfg(1104901099)
				local var_412_19 = arg_409_1:FormatText(var_412_18.content)

				arg_409_1.text_.text = var_412_19

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_20 = 25
				local var_412_21 = utf8.len(var_412_19)
				local var_412_22 = var_412_20 <= 0 and var_412_16 or var_412_16 * (var_412_21 / var_412_20)

				if var_412_22 > 0 and var_412_16 < var_412_22 then
					arg_409_1.talkMaxDuration = var_412_22

					if var_412_22 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_22 + var_412_15
					end
				end

				arg_409_1.text_.text = var_412_19
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901099", "story_v_side_new_1104901.awb") ~= 0 then
					local var_412_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901099", "story_v_side_new_1104901.awb") / 1000

					if var_412_23 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_23 + var_412_15
					end

					if var_412_18.prefab_name ~= "" and arg_409_1.actors_[var_412_18.prefab_name] ~= nil then
						local var_412_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_18.prefab_name].transform, "story_v_side_new_1104901", "1104901099", "story_v_side_new_1104901.awb")

						arg_409_1:RecordAudio("1104901099", var_412_24)
						arg_409_1:RecordAudio("1104901099", var_412_24)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901099", "story_v_side_new_1104901.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901099", "story_v_side_new_1104901.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_25 = math.max(var_412_16, arg_409_1.talkMaxDuration)

			if var_412_15 <= arg_409_1.time_ and arg_409_1.time_ < var_412_15 + var_412_25 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_15) / var_412_25

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_15 + var_412_25 and arg_409_1.time_ < var_412_15 + var_412_25 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
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
	Play1104901100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1104901100
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1104901101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1049ui_story"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1049ui_story == nil then
				arg_413_1.var_.characterEffect1049ui_story = var_416_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.characterEffect1049ui_story and not isNil(var_416_0) then
					local var_416_4 = Mathf.Lerp(0, 0.5, var_416_3)

					arg_413_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1049ui_story.fillRatio = var_416_4
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1049ui_story then
				local var_416_5 = 0.5

				arg_413_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1049ui_story.fillRatio = var_416_5
			end

			local var_416_6 = 0
			local var_416_7 = 0.95

			if var_416_6 < arg_413_1.time_ and arg_413_1.time_ <= var_416_6 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_8 = arg_413_1:GetWordFromCfg(1104901100)
				local var_416_9 = arg_413_1:FormatText(var_416_8.content)

				arg_413_1.text_.text = var_416_9

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_10 = 38
				local var_416_11 = utf8.len(var_416_9)
				local var_416_12 = var_416_10 <= 0 and var_416_7 or var_416_7 * (var_416_11 / var_416_10)

				if var_416_12 > 0 and var_416_7 < var_416_12 then
					arg_413_1.talkMaxDuration = var_416_12

					if var_416_12 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_12 + var_416_6
					end
				end

				arg_413_1.text_.text = var_416_9
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_13 = math.max(var_416_7, arg_413_1.talkMaxDuration)

			if var_416_6 <= arg_413_1.time_ and arg_413_1.time_ < var_416_6 + var_416_13 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_6) / var_416_13

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_6 + var_416_13 and arg_413_1.time_ < var_416_6 + var_416_13 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1104901101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1104901101
		arg_417_1.duration_ = 14.5

		local var_417_0 = {
			zh = 7.633,
			ja = 14.5
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1104901102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1049ui_story"].transform
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.var_.moveOldPos1049ui_story = var_420_0.localPosition
			end

			local var_420_2 = 0.001

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2
				local var_420_4 = Vector3.New(0, -1.2, -6)

				var_420_0.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1049ui_story, var_420_4, var_420_3)

				local var_420_5 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_5.x, var_420_5.y, var_420_5.z)

				local var_420_6 = var_420_0.localEulerAngles

				var_420_6.z = 0
				var_420_6.x = 0
				var_420_0.localEulerAngles = var_420_6
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 then
				var_420_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_420_7 = manager.ui.mainCamera.transform.position - var_420_0.position

				var_420_0.forward = Vector3.New(var_420_7.x, var_420_7.y, var_420_7.z)

				local var_420_8 = var_420_0.localEulerAngles

				var_420_8.z = 0
				var_420_8.x = 0
				var_420_0.localEulerAngles = var_420_8
			end

			local var_420_9 = arg_417_1.actors_["1049ui_story"]
			local var_420_10 = 0

			if var_420_10 < arg_417_1.time_ and arg_417_1.time_ <= var_420_10 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect1049ui_story == nil then
				arg_417_1.var_.characterEffect1049ui_story = var_420_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_11 = 0.200000002980232

			if var_420_10 <= arg_417_1.time_ and arg_417_1.time_ < var_420_10 + var_420_11 and not isNil(var_420_9) then
				local var_420_12 = (arg_417_1.time_ - var_420_10) / var_420_11

				if arg_417_1.var_.characterEffect1049ui_story and not isNil(var_420_9) then
					arg_417_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= var_420_10 + var_420_11 and arg_417_1.time_ < var_420_10 + var_420_11 + arg_420_0 and not isNil(var_420_9) and arg_417_1.var_.characterEffect1049ui_story then
				arg_417_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_420_13 = 0

			if var_420_13 < arg_417_1.time_ and arg_417_1.time_ <= var_420_13 + arg_420_0 then
				arg_417_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_420_14 = 0

			if var_420_14 < arg_417_1.time_ and arg_417_1.time_ <= var_420_14 + arg_420_0 then
				arg_417_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_420_15 = 0
			local var_420_16 = 0.55

			if var_420_15 < arg_417_1.time_ and arg_417_1.time_ <= var_420_15 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_17 = arg_417_1:FormatText(StoryNameCfg[551].name)

				arg_417_1.leftNameTxt_.text = var_420_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_18 = arg_417_1:GetWordFromCfg(1104901101)
				local var_420_19 = arg_417_1:FormatText(var_420_18.content)

				arg_417_1.text_.text = var_420_19

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_20 = 22
				local var_420_21 = utf8.len(var_420_19)
				local var_420_22 = var_420_20 <= 0 and var_420_16 or var_420_16 * (var_420_21 / var_420_20)

				if var_420_22 > 0 and var_420_16 < var_420_22 then
					arg_417_1.talkMaxDuration = var_420_22

					if var_420_22 + var_420_15 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_22 + var_420_15
					end
				end

				arg_417_1.text_.text = var_420_19
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901101", "story_v_side_new_1104901.awb") ~= 0 then
					local var_420_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901101", "story_v_side_new_1104901.awb") / 1000

					if var_420_23 + var_420_15 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_23 + var_420_15
					end

					if var_420_18.prefab_name ~= "" and arg_417_1.actors_[var_420_18.prefab_name] ~= nil then
						local var_420_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_18.prefab_name].transform, "story_v_side_new_1104901", "1104901101", "story_v_side_new_1104901.awb")

						arg_417_1:RecordAudio("1104901101", var_420_24)
						arg_417_1:RecordAudio("1104901101", var_420_24)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901101", "story_v_side_new_1104901.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901101", "story_v_side_new_1104901.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_25 = math.max(var_420_16, arg_417_1.talkMaxDuration)

			if var_420_15 <= arg_417_1.time_ and arg_417_1.time_ < var_420_15 + var_420_25 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_15) / var_420_25

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_15 + var_420_25 and arg_417_1.time_ < var_420_15 + var_420_25 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play1104901102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1104901102
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1104901103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1049ui_story"]
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect1049ui_story == nil then
				arg_421_1.var_.characterEffect1049ui_story = var_424_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.200000002980232

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 and not isNil(var_424_0) then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2

				if arg_421_1.var_.characterEffect1049ui_story and not isNil(var_424_0) then
					local var_424_4 = Mathf.Lerp(0, 0.5, var_424_3)

					arg_421_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1049ui_story.fillRatio = var_424_4
				end
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect1049ui_story then
				local var_424_5 = 0.5

				arg_421_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1049ui_story.fillRatio = var_424_5
			end

			local var_424_6 = 0
			local var_424_7 = 0.925

			if var_424_6 < arg_421_1.time_ and arg_421_1.time_ <= var_424_6 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				local var_424_8 = arg_421_1:FormatText(StoryNameCfg[7].name)

				arg_421_1.leftNameTxt_.text = var_424_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_9 = arg_421_1:GetWordFromCfg(1104901102)
				local var_424_10 = arg_421_1:FormatText(var_424_9.content)

				arg_421_1.text_.text = var_424_10

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_11 = 37
				local var_424_12 = utf8.len(var_424_10)
				local var_424_13 = var_424_11 <= 0 and var_424_7 or var_424_7 * (var_424_12 / var_424_11)

				if var_424_13 > 0 and var_424_7 < var_424_13 then
					arg_421_1.talkMaxDuration = var_424_13

					if var_424_13 + var_424_6 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_13 + var_424_6
					end
				end

				arg_421_1.text_.text = var_424_10
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_14 = math.max(var_424_7, arg_421_1.talkMaxDuration)

			if var_424_6 <= arg_421_1.time_ and arg_421_1.time_ < var_424_6 + var_424_14 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_6) / var_424_14

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_6 + var_424_14 and arg_421_1.time_ < var_424_6 + var_424_14 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1104901103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1104901103
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1104901104(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0
			local var_428_1 = 0.725

			if var_428_0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_2 = arg_425_1:FormatText(StoryNameCfg[7].name)

				arg_425_1.leftNameTxt_.text = var_428_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_3 = arg_425_1:GetWordFromCfg(1104901103)
				local var_428_4 = arg_425_1:FormatText(var_428_3.content)

				arg_425_1.text_.text = var_428_4

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_5 = 29
				local var_428_6 = utf8.len(var_428_4)
				local var_428_7 = var_428_5 <= 0 and var_428_1 or var_428_1 * (var_428_6 / var_428_5)

				if var_428_7 > 0 and var_428_1 < var_428_7 then
					arg_425_1.talkMaxDuration = var_428_7

					if var_428_7 + var_428_0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_7 + var_428_0
					end
				end

				arg_425_1.text_.text = var_428_4
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_8 = math.max(var_428_1, arg_425_1.talkMaxDuration)

			if var_428_0 <= arg_425_1.time_ and arg_425_1.time_ < var_428_0 + var_428_8 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_0) / var_428_8

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_0 + var_428_8 and arg_425_1.time_ < var_428_0 + var_428_8 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1104901104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1104901104
		arg_429_1.duration_ = 13.2

		local var_429_0 = {
			zh = 13.2,
			ja = 9.3
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1104901105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["1049ui_story"].transform
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 then
				arg_429_1.var_.moveOldPos1049ui_story = var_432_0.localPosition
			end

			local var_432_2 = 0.001

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2
				local var_432_4 = Vector3.New(0, -1.2, -6)

				var_432_0.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos1049ui_story, var_432_4, var_432_3)

				local var_432_5 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_5.x, var_432_5.y, var_432_5.z)

				local var_432_6 = var_432_0.localEulerAngles

				var_432_6.z = 0
				var_432_6.x = 0
				var_432_0.localEulerAngles = var_432_6
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 then
				var_432_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_432_7 = manager.ui.mainCamera.transform.position - var_432_0.position

				var_432_0.forward = Vector3.New(var_432_7.x, var_432_7.y, var_432_7.z)

				local var_432_8 = var_432_0.localEulerAngles

				var_432_8.z = 0
				var_432_8.x = 0
				var_432_0.localEulerAngles = var_432_8
			end

			local var_432_9 = arg_429_1.actors_["1049ui_story"]
			local var_432_10 = 0

			if var_432_10 < arg_429_1.time_ and arg_429_1.time_ <= var_432_10 + arg_432_0 and not isNil(var_432_9) and arg_429_1.var_.characterEffect1049ui_story == nil then
				arg_429_1.var_.characterEffect1049ui_story = var_432_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_11 = 0.200000002980232

			if var_432_10 <= arg_429_1.time_ and arg_429_1.time_ < var_432_10 + var_432_11 and not isNil(var_432_9) then
				local var_432_12 = (arg_429_1.time_ - var_432_10) / var_432_11

				if arg_429_1.var_.characterEffect1049ui_story and not isNil(var_432_9) then
					arg_429_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= var_432_10 + var_432_11 and arg_429_1.time_ < var_432_10 + var_432_11 + arg_432_0 and not isNil(var_432_9) and arg_429_1.var_.characterEffect1049ui_story then
				arg_429_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_432_13 = 0

			if var_432_13 < arg_429_1.time_ and arg_429_1.time_ <= var_432_13 + arg_432_0 then
				arg_429_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			local var_432_14 = 0

			if var_432_14 < arg_429_1.time_ and arg_429_1.time_ <= var_432_14 + arg_432_0 then
				arg_429_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_432_15 = 0
			local var_432_16 = 1.425

			if var_432_15 < arg_429_1.time_ and arg_429_1.time_ <= var_432_15 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_17 = arg_429_1:FormatText(StoryNameCfg[551].name)

				arg_429_1.leftNameTxt_.text = var_432_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_18 = arg_429_1:GetWordFromCfg(1104901104)
				local var_432_19 = arg_429_1:FormatText(var_432_18.content)

				arg_429_1.text_.text = var_432_19

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_20 = 57
				local var_432_21 = utf8.len(var_432_19)
				local var_432_22 = var_432_20 <= 0 and var_432_16 or var_432_16 * (var_432_21 / var_432_20)

				if var_432_22 > 0 and var_432_16 < var_432_22 then
					arg_429_1.talkMaxDuration = var_432_22

					if var_432_22 + var_432_15 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_22 + var_432_15
					end
				end

				arg_429_1.text_.text = var_432_19
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901104", "story_v_side_new_1104901.awb") ~= 0 then
					local var_432_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901104", "story_v_side_new_1104901.awb") / 1000

					if var_432_23 + var_432_15 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_23 + var_432_15
					end

					if var_432_18.prefab_name ~= "" and arg_429_1.actors_[var_432_18.prefab_name] ~= nil then
						local var_432_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_18.prefab_name].transform, "story_v_side_new_1104901", "1104901104", "story_v_side_new_1104901.awb")

						arg_429_1:RecordAudio("1104901104", var_432_24)
						arg_429_1:RecordAudio("1104901104", var_432_24)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901104", "story_v_side_new_1104901.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901104", "story_v_side_new_1104901.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_25 = math.max(var_432_16, arg_429_1.talkMaxDuration)

			if var_432_15 <= arg_429_1.time_ and arg_429_1.time_ < var_432_15 + var_432_25 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_15) / var_432_25

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_15 + var_432_25 and arg_429_1.time_ < var_432_15 + var_432_25 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play1104901105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1104901105
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1104901106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1049ui_story"]
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1049ui_story == nil then
				arg_433_1.var_.characterEffect1049ui_story = var_436_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 and not isNil(var_436_0) then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2

				if arg_433_1.var_.characterEffect1049ui_story and not isNil(var_436_0) then
					local var_436_4 = Mathf.Lerp(0, 0.5, var_436_3)

					arg_433_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1049ui_story.fillRatio = var_436_4
				end
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1049ui_story then
				local var_436_5 = 0.5

				arg_433_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1049ui_story.fillRatio = var_436_5
			end

			local var_436_6 = 0
			local var_436_7 = 0.7

			if var_436_6 < arg_433_1.time_ and arg_433_1.time_ <= var_436_6 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_8 = arg_433_1:FormatText(StoryNameCfg[7].name)

				arg_433_1.leftNameTxt_.text = var_436_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, true)
				arg_433_1.iconController_:SetSelectedState("hero")

				arg_433_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_433_1.callingController_:SetSelectedState("normal")

				arg_433_1.keyicon_.color = Color.New(1, 1, 1)
				arg_433_1.icon_.color = Color.New(1, 1, 1)

				local var_436_9 = arg_433_1:GetWordFromCfg(1104901105)
				local var_436_10 = arg_433_1:FormatText(var_436_9.content)

				arg_433_1.text_.text = var_436_10

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_11 = 28
				local var_436_12 = utf8.len(var_436_10)
				local var_436_13 = var_436_11 <= 0 and var_436_7 or var_436_7 * (var_436_12 / var_436_11)

				if var_436_13 > 0 and var_436_7 < var_436_13 then
					arg_433_1.talkMaxDuration = var_436_13

					if var_436_13 + var_436_6 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_13 + var_436_6
					end
				end

				arg_433_1.text_.text = var_436_10
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_14 = math.max(var_436_7, arg_433_1.talkMaxDuration)

			if var_436_6 <= arg_433_1.time_ and arg_433_1.time_ < var_436_6 + var_436_14 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_6) / var_436_14

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_6 + var_436_14 and arg_433_1.time_ < var_436_6 + var_436_14 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play1104901106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1104901106
		arg_437_1.duration_ = 2.33

		local var_437_0 = {
			zh = 1.999999999999,
			ja = 2.333
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1104901107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["1049ui_story"].transform
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.var_.moveOldPos1049ui_story = var_440_0.localPosition
			end

			local var_440_2 = 0.001

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2
				local var_440_4 = Vector3.New(0, -1.2, -6)

				var_440_0.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1049ui_story, var_440_4, var_440_3)

				local var_440_5 = manager.ui.mainCamera.transform.position - var_440_0.position

				var_440_0.forward = Vector3.New(var_440_5.x, var_440_5.y, var_440_5.z)

				local var_440_6 = var_440_0.localEulerAngles

				var_440_6.z = 0
				var_440_6.x = 0
				var_440_0.localEulerAngles = var_440_6
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 then
				var_440_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_440_7 = manager.ui.mainCamera.transform.position - var_440_0.position

				var_440_0.forward = Vector3.New(var_440_7.x, var_440_7.y, var_440_7.z)

				local var_440_8 = var_440_0.localEulerAngles

				var_440_8.z = 0
				var_440_8.x = 0
				var_440_0.localEulerAngles = var_440_8
			end

			local var_440_9 = arg_437_1.actors_["1049ui_story"]
			local var_440_10 = 0

			if var_440_10 < arg_437_1.time_ and arg_437_1.time_ <= var_440_10 + arg_440_0 and not isNil(var_440_9) and arg_437_1.var_.characterEffect1049ui_story == nil then
				arg_437_1.var_.characterEffect1049ui_story = var_440_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_11 = 0.200000002980232

			if var_440_10 <= arg_437_1.time_ and arg_437_1.time_ < var_440_10 + var_440_11 and not isNil(var_440_9) then
				local var_440_12 = (arg_437_1.time_ - var_440_10) / var_440_11

				if arg_437_1.var_.characterEffect1049ui_story and not isNil(var_440_9) then
					arg_437_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= var_440_10 + var_440_11 and arg_437_1.time_ < var_440_10 + var_440_11 + arg_440_0 and not isNil(var_440_9) and arg_437_1.var_.characterEffect1049ui_story then
				arg_437_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_440_13 = 0

			if var_440_13 < arg_437_1.time_ and arg_437_1.time_ <= var_440_13 + arg_440_0 then
				arg_437_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_440_14 = 0

			if var_440_14 < arg_437_1.time_ and arg_437_1.time_ <= var_440_14 + arg_440_0 then
				arg_437_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_440_15 = 0
			local var_440_16 = 0.15

			if var_440_15 < arg_437_1.time_ and arg_437_1.time_ <= var_440_15 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_17 = arg_437_1:FormatText(StoryNameCfg[551].name)

				arg_437_1.leftNameTxt_.text = var_440_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_18 = arg_437_1:GetWordFromCfg(1104901106)
				local var_440_19 = arg_437_1:FormatText(var_440_18.content)

				arg_437_1.text_.text = var_440_19

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_20 = 6
				local var_440_21 = utf8.len(var_440_19)
				local var_440_22 = var_440_20 <= 0 and var_440_16 or var_440_16 * (var_440_21 / var_440_20)

				if var_440_22 > 0 and var_440_16 < var_440_22 then
					arg_437_1.talkMaxDuration = var_440_22

					if var_440_22 + var_440_15 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_22 + var_440_15
					end
				end

				arg_437_1.text_.text = var_440_19
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901106", "story_v_side_new_1104901.awb") ~= 0 then
					local var_440_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901106", "story_v_side_new_1104901.awb") / 1000

					if var_440_23 + var_440_15 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_23 + var_440_15
					end

					if var_440_18.prefab_name ~= "" and arg_437_1.actors_[var_440_18.prefab_name] ~= nil then
						local var_440_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_18.prefab_name].transform, "story_v_side_new_1104901", "1104901106", "story_v_side_new_1104901.awb")

						arg_437_1:RecordAudio("1104901106", var_440_24)
						arg_437_1:RecordAudio("1104901106", var_440_24)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901106", "story_v_side_new_1104901.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901106", "story_v_side_new_1104901.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_25 = math.max(var_440_16, arg_437_1.talkMaxDuration)

			if var_440_15 <= arg_437_1.time_ and arg_437_1.time_ < var_440_15 + var_440_25 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_15) / var_440_25

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_15 + var_440_25 and arg_437_1.time_ < var_440_15 + var_440_25 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play1104901107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1104901107
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1104901108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["1049ui_story"]
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1049ui_story == nil then
				arg_441_1.var_.characterEffect1049ui_story = var_444_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.200000002980232

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 and not isNil(var_444_0) then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2

				if arg_441_1.var_.characterEffect1049ui_story and not isNil(var_444_0) then
					local var_444_4 = Mathf.Lerp(0, 0.5, var_444_3)

					arg_441_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_441_1.var_.characterEffect1049ui_story.fillRatio = var_444_4
				end
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1049ui_story then
				local var_444_5 = 0.5

				arg_441_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_441_1.var_.characterEffect1049ui_story.fillRatio = var_444_5
			end

			local var_444_6 = 0
			local var_444_7 = 0.65

			if var_444_6 < arg_441_1.time_ and arg_441_1.time_ <= var_444_6 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_8 = arg_441_1:FormatText(StoryNameCfg[7].name)

				arg_441_1.leftNameTxt_.text = var_444_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_9 = arg_441_1:GetWordFromCfg(1104901107)
				local var_444_10 = arg_441_1:FormatText(var_444_9.content)

				arg_441_1.text_.text = var_444_10

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_11 = 26
				local var_444_12 = utf8.len(var_444_10)
				local var_444_13 = var_444_11 <= 0 and var_444_7 or var_444_7 * (var_444_12 / var_444_11)

				if var_444_13 > 0 and var_444_7 < var_444_13 then
					arg_441_1.talkMaxDuration = var_444_13

					if var_444_13 + var_444_6 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_13 + var_444_6
					end
				end

				arg_441_1.text_.text = var_444_10
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_14 = math.max(var_444_7, arg_441_1.talkMaxDuration)

			if var_444_6 <= arg_441_1.time_ and arg_441_1.time_ < var_444_6 + var_444_14 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_6) / var_444_14

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_6 + var_444_14 and arg_441_1.time_ < var_444_6 + var_444_14 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1104901108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1104901108
		arg_445_1.duration_ = 3.57

		local var_445_0 = {
			zh = 2.366,
			ja = 3.566
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1104901109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = arg_445_1.actors_["1049ui_story"].transform
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.var_.moveOldPos1049ui_story = var_448_0.localPosition
			end

			local var_448_2 = 0.001

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_2 then
				local var_448_3 = (arg_445_1.time_ - var_448_1) / var_448_2
				local var_448_4 = Vector3.New(0, -1.2, -6)

				var_448_0.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos1049ui_story, var_448_4, var_448_3)

				local var_448_5 = manager.ui.mainCamera.transform.position - var_448_0.position

				var_448_0.forward = Vector3.New(var_448_5.x, var_448_5.y, var_448_5.z)

				local var_448_6 = var_448_0.localEulerAngles

				var_448_6.z = 0
				var_448_6.x = 0
				var_448_0.localEulerAngles = var_448_6
			end

			if arg_445_1.time_ >= var_448_1 + var_448_2 and arg_445_1.time_ < var_448_1 + var_448_2 + arg_448_0 then
				var_448_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_448_7 = manager.ui.mainCamera.transform.position - var_448_0.position

				var_448_0.forward = Vector3.New(var_448_7.x, var_448_7.y, var_448_7.z)

				local var_448_8 = var_448_0.localEulerAngles

				var_448_8.z = 0
				var_448_8.x = 0
				var_448_0.localEulerAngles = var_448_8
			end

			local var_448_9 = arg_445_1.actors_["1049ui_story"]
			local var_448_10 = 0

			if var_448_10 < arg_445_1.time_ and arg_445_1.time_ <= var_448_10 + arg_448_0 and not isNil(var_448_9) and arg_445_1.var_.characterEffect1049ui_story == nil then
				arg_445_1.var_.characterEffect1049ui_story = var_448_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_11 = 0.200000002980232

			if var_448_10 <= arg_445_1.time_ and arg_445_1.time_ < var_448_10 + var_448_11 and not isNil(var_448_9) then
				local var_448_12 = (arg_445_1.time_ - var_448_10) / var_448_11

				if arg_445_1.var_.characterEffect1049ui_story and not isNil(var_448_9) then
					arg_445_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= var_448_10 + var_448_11 and arg_445_1.time_ < var_448_10 + var_448_11 + arg_448_0 and not isNil(var_448_9) and arg_445_1.var_.characterEffect1049ui_story then
				arg_445_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_448_13 = 0

			if var_448_13 < arg_445_1.time_ and arg_445_1.time_ <= var_448_13 + arg_448_0 then
				arg_445_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_448_14 = 0

			if var_448_14 < arg_445_1.time_ and arg_445_1.time_ <= var_448_14 + arg_448_0 then
				arg_445_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_448_15 = 0
			local var_448_16 = 0.3

			if var_448_15 < arg_445_1.time_ and arg_445_1.time_ <= var_448_15 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				local var_448_17 = arg_445_1:FormatText(StoryNameCfg[551].name)

				arg_445_1.leftNameTxt_.text = var_448_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_18 = arg_445_1:GetWordFromCfg(1104901108)
				local var_448_19 = arg_445_1:FormatText(var_448_18.content)

				arg_445_1.text_.text = var_448_19

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_20 = 12
				local var_448_21 = utf8.len(var_448_19)
				local var_448_22 = var_448_20 <= 0 and var_448_16 or var_448_16 * (var_448_21 / var_448_20)

				if var_448_22 > 0 and var_448_16 < var_448_22 then
					arg_445_1.talkMaxDuration = var_448_22

					if var_448_22 + var_448_15 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_22 + var_448_15
					end
				end

				arg_445_1.text_.text = var_448_19
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901108", "story_v_side_new_1104901.awb") ~= 0 then
					local var_448_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901108", "story_v_side_new_1104901.awb") / 1000

					if var_448_23 + var_448_15 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_23 + var_448_15
					end

					if var_448_18.prefab_name ~= "" and arg_445_1.actors_[var_448_18.prefab_name] ~= nil then
						local var_448_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_18.prefab_name].transform, "story_v_side_new_1104901", "1104901108", "story_v_side_new_1104901.awb")

						arg_445_1:RecordAudio("1104901108", var_448_24)
						arg_445_1:RecordAudio("1104901108", var_448_24)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901108", "story_v_side_new_1104901.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901108", "story_v_side_new_1104901.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_25 = math.max(var_448_16, arg_445_1.talkMaxDuration)

			if var_448_15 <= arg_445_1.time_ and arg_445_1.time_ < var_448_15 + var_448_25 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_15) / var_448_25

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_15 + var_448_25 and arg_445_1.time_ < var_448_15 + var_448_25 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play1104901109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1104901109
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1104901110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["1049ui_story"]
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.characterEffect1049ui_story == nil then
				arg_449_1.var_.characterEffect1049ui_story = var_452_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.200000002980232

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 and not isNil(var_452_0) then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2

				if arg_449_1.var_.characterEffect1049ui_story and not isNil(var_452_0) then
					local var_452_4 = Mathf.Lerp(0, 0.5, var_452_3)

					arg_449_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1049ui_story.fillRatio = var_452_4
				end
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 and not isNil(var_452_0) and arg_449_1.var_.characterEffect1049ui_story then
				local var_452_5 = 0.5

				arg_449_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1049ui_story.fillRatio = var_452_5
			end

			local var_452_6 = 0
			local var_452_7 = 0.9

			if var_452_6 < arg_449_1.time_ and arg_449_1.time_ <= var_452_6 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_8 = arg_449_1:GetWordFromCfg(1104901109)
				local var_452_9 = arg_449_1:FormatText(var_452_8.content)

				arg_449_1.text_.text = var_452_9

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_10 = 36
				local var_452_11 = utf8.len(var_452_9)
				local var_452_12 = var_452_10 <= 0 and var_452_7 or var_452_7 * (var_452_11 / var_452_10)

				if var_452_12 > 0 and var_452_7 < var_452_12 then
					arg_449_1.talkMaxDuration = var_452_12

					if var_452_12 + var_452_6 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_12 + var_452_6
					end
				end

				arg_449_1.text_.text = var_452_9
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_13 = math.max(var_452_7, arg_449_1.talkMaxDuration)

			if var_452_6 <= arg_449_1.time_ and arg_449_1.time_ < var_452_6 + var_452_13 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_6) / var_452_13

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_6 + var_452_13 and arg_449_1.time_ < var_452_6 + var_452_13 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play1104901110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1104901110
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1104901111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 0.8

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_2 = arg_453_1:FormatText(StoryNameCfg[7].name)

				arg_453_1.leftNameTxt_.text = var_456_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_3 = arg_453_1:GetWordFromCfg(1104901110)
				local var_456_4 = arg_453_1:FormatText(var_456_3.content)

				arg_453_1.text_.text = var_456_4

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_5 = 32
				local var_456_6 = utf8.len(var_456_4)
				local var_456_7 = var_456_5 <= 0 and var_456_1 or var_456_1 * (var_456_6 / var_456_5)

				if var_456_7 > 0 and var_456_1 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_0
					end
				end

				arg_453_1.text_.text = var_456_4
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_8 = math.max(var_456_1, arg_453_1.talkMaxDuration)

			if var_456_0 <= arg_453_1.time_ and arg_453_1.time_ < var_456_0 + var_456_8 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_0) / var_456_8

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_0 + var_456_8 and arg_453_1.time_ < var_456_0 + var_456_8 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1104901111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1104901111
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1104901112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 0.5

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

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:GetWordFromCfg(1104901111)
				local var_460_4 = arg_457_1:FormatText(var_460_3.content)

				arg_457_1.text_.text = var_460_4

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 20
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
	Play1104901112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1104901112
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1104901113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = arg_461_1.actors_["1049ui_story"].transform
			local var_464_1 = 0

			if var_464_1 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.var_.moveOldPos1049ui_story = var_464_0.localPosition
			end

			local var_464_2 = 0.001

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_2 then
				local var_464_3 = (arg_461_1.time_ - var_464_1) / var_464_2
				local var_464_4 = Vector3.New(0, -1.2, -6)

				var_464_0.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1049ui_story, var_464_4, var_464_3)

				local var_464_5 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_5.x, var_464_5.y, var_464_5.z)

				local var_464_6 = var_464_0.localEulerAngles

				var_464_6.z = 0
				var_464_6.x = 0
				var_464_0.localEulerAngles = var_464_6
			end

			if arg_461_1.time_ >= var_464_1 + var_464_2 and arg_461_1.time_ < var_464_1 + var_464_2 + arg_464_0 then
				var_464_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_464_7 = manager.ui.mainCamera.transform.position - var_464_0.position

				var_464_0.forward = Vector3.New(var_464_7.x, var_464_7.y, var_464_7.z)

				local var_464_8 = var_464_0.localEulerAngles

				var_464_8.z = 0
				var_464_8.x = 0
				var_464_0.localEulerAngles = var_464_8
			end

			local var_464_9 = arg_461_1.actors_["1049ui_story"]
			local var_464_10 = 0

			if var_464_10 < arg_461_1.time_ and arg_461_1.time_ <= var_464_10 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect1049ui_story == nil then
				arg_461_1.var_.characterEffect1049ui_story = var_464_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_11 = 0.200000002980232

			if var_464_10 <= arg_461_1.time_ and arg_461_1.time_ < var_464_10 + var_464_11 and not isNil(var_464_9) then
				local var_464_12 = (arg_461_1.time_ - var_464_10) / var_464_11

				if arg_461_1.var_.characterEffect1049ui_story and not isNil(var_464_9) then
					local var_464_13 = Mathf.Lerp(0, 0.5, var_464_12)

					arg_461_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1049ui_story.fillRatio = var_464_13
				end
			end

			if arg_461_1.time_ >= var_464_10 + var_464_11 and arg_461_1.time_ < var_464_10 + var_464_11 + arg_464_0 and not isNil(var_464_9) and arg_461_1.var_.characterEffect1049ui_story then
				local var_464_14 = 0.5

				arg_461_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1049ui_story.fillRatio = var_464_14
			end

			local var_464_15 = 0
			local var_464_16 = 0.7

			if var_464_15 < arg_461_1.time_ and arg_461_1.time_ <= var_464_15 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_17 = arg_461_1:GetWordFromCfg(1104901112)
				local var_464_18 = arg_461_1:FormatText(var_464_17.content)

				arg_461_1.text_.text = var_464_18

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_19 = 28
				local var_464_20 = utf8.len(var_464_18)
				local var_464_21 = var_464_19 <= 0 and var_464_16 or var_464_16 * (var_464_20 / var_464_19)

				if var_464_21 > 0 and var_464_16 < var_464_21 then
					arg_461_1.talkMaxDuration = var_464_21

					if var_464_21 + var_464_15 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_21 + var_464_15
					end
				end

				arg_461_1.text_.text = var_464_18
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_22 = math.max(var_464_16, arg_461_1.talkMaxDuration)

			if var_464_15 <= arg_461_1.time_ and arg_461_1.time_ < var_464_15 + var_464_22 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_15) / var_464_22

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_15 + var_464_22 and arg_461_1.time_ < var_464_15 + var_464_22 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play1104901113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1104901113
		arg_465_1.duration_ = 5.33

		local var_465_0 = {
			zh = 5.333,
			ja = 2.433
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1104901114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = arg_465_1.actors_["1049ui_story"].transform
			local var_468_1 = 0

			if var_468_1 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.var_.moveOldPos1049ui_story = var_468_0.localPosition
			end

			local var_468_2 = 0.001

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_2 then
				local var_468_3 = (arg_465_1.time_ - var_468_1) / var_468_2
				local var_468_4 = Vector3.New(0, -1.2, -6)

				var_468_0.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1049ui_story, var_468_4, var_468_3)

				local var_468_5 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_5.x, var_468_5.y, var_468_5.z)

				local var_468_6 = var_468_0.localEulerAngles

				var_468_6.z = 0
				var_468_6.x = 0
				var_468_0.localEulerAngles = var_468_6
			end

			if arg_465_1.time_ >= var_468_1 + var_468_2 and arg_465_1.time_ < var_468_1 + var_468_2 + arg_468_0 then
				var_468_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_468_7 = manager.ui.mainCamera.transform.position - var_468_0.position

				var_468_0.forward = Vector3.New(var_468_7.x, var_468_7.y, var_468_7.z)

				local var_468_8 = var_468_0.localEulerAngles

				var_468_8.z = 0
				var_468_8.x = 0
				var_468_0.localEulerAngles = var_468_8
			end

			local var_468_9 = arg_465_1.actors_["1049ui_story"]
			local var_468_10 = 0

			if var_468_10 < arg_465_1.time_ and arg_465_1.time_ <= var_468_10 + arg_468_0 and not isNil(var_468_9) and arg_465_1.var_.characterEffect1049ui_story == nil then
				arg_465_1.var_.characterEffect1049ui_story = var_468_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_11 = 0.200000002980232

			if var_468_10 <= arg_465_1.time_ and arg_465_1.time_ < var_468_10 + var_468_11 and not isNil(var_468_9) then
				local var_468_12 = (arg_465_1.time_ - var_468_10) / var_468_11

				if arg_465_1.var_.characterEffect1049ui_story and not isNil(var_468_9) then
					arg_465_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= var_468_10 + var_468_11 and arg_465_1.time_ < var_468_10 + var_468_11 + arg_468_0 and not isNil(var_468_9) and arg_465_1.var_.characterEffect1049ui_story then
				arg_465_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_468_13 = 0

			if var_468_13 < arg_465_1.time_ and arg_465_1.time_ <= var_468_13 + arg_468_0 then
				arg_465_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_468_14 = 0

			if var_468_14 < arg_465_1.time_ and arg_465_1.time_ <= var_468_14 + arg_468_0 then
				arg_465_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_468_15 = 0
			local var_468_16 = 0.25

			if var_468_15 < arg_465_1.time_ and arg_465_1.time_ <= var_468_15 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_17 = arg_465_1:FormatText(StoryNameCfg[551].name)

				arg_465_1.leftNameTxt_.text = var_468_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_18 = arg_465_1:GetWordFromCfg(1104901113)
				local var_468_19 = arg_465_1:FormatText(var_468_18.content)

				arg_465_1.text_.text = var_468_19

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_20 = 10
				local var_468_21 = utf8.len(var_468_19)
				local var_468_22 = var_468_20 <= 0 and var_468_16 or var_468_16 * (var_468_21 / var_468_20)

				if var_468_22 > 0 and var_468_16 < var_468_22 then
					arg_465_1.talkMaxDuration = var_468_22

					if var_468_22 + var_468_15 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_22 + var_468_15
					end
				end

				arg_465_1.text_.text = var_468_19
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901113", "story_v_side_new_1104901.awb") ~= 0 then
					local var_468_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901113", "story_v_side_new_1104901.awb") / 1000

					if var_468_23 + var_468_15 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_23 + var_468_15
					end

					if var_468_18.prefab_name ~= "" and arg_465_1.actors_[var_468_18.prefab_name] ~= nil then
						local var_468_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_18.prefab_name].transform, "story_v_side_new_1104901", "1104901113", "story_v_side_new_1104901.awb")

						arg_465_1:RecordAudio("1104901113", var_468_24)
						arg_465_1:RecordAudio("1104901113", var_468_24)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901113", "story_v_side_new_1104901.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901113", "story_v_side_new_1104901.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_25 = math.max(var_468_16, arg_465_1.talkMaxDuration)

			if var_468_15 <= arg_465_1.time_ and arg_465_1.time_ < var_468_15 + var_468_25 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_15) / var_468_25

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_15 + var_468_25 and arg_465_1.time_ < var_468_15 + var_468_25 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play1104901114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1104901114
		arg_469_1.duration_ = 4.2

		local var_469_0 = {
			zh = 1.999999999999,
			ja = 4.2
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1104901115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["1049ui_story"].transform
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 then
				arg_469_1.var_.moveOldPos1049ui_story = var_472_0.localPosition
			end

			local var_472_2 = 0.001

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2
				local var_472_4 = Vector3.New(0, -1.2, -6)

				var_472_0.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1049ui_story, var_472_4, var_472_3)

				local var_472_5 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_5.x, var_472_5.y, var_472_5.z)

				local var_472_6 = var_472_0.localEulerAngles

				var_472_6.z = 0
				var_472_6.x = 0
				var_472_0.localEulerAngles = var_472_6
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 then
				var_472_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_472_7 = manager.ui.mainCamera.transform.position - var_472_0.position

				var_472_0.forward = Vector3.New(var_472_7.x, var_472_7.y, var_472_7.z)

				local var_472_8 = var_472_0.localEulerAngles

				var_472_8.z = 0
				var_472_8.x = 0
				var_472_0.localEulerAngles = var_472_8
			end

			local var_472_9 = arg_469_1.actors_["1049ui_story"]
			local var_472_10 = 0

			if var_472_10 < arg_469_1.time_ and arg_469_1.time_ <= var_472_10 + arg_472_0 and not isNil(var_472_9) and arg_469_1.var_.characterEffect1049ui_story == nil then
				arg_469_1.var_.characterEffect1049ui_story = var_472_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_11 = 0.200000002980232

			if var_472_10 <= arg_469_1.time_ and arg_469_1.time_ < var_472_10 + var_472_11 and not isNil(var_472_9) then
				local var_472_12 = (arg_469_1.time_ - var_472_10) / var_472_11

				if arg_469_1.var_.characterEffect1049ui_story and not isNil(var_472_9) then
					arg_469_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= var_472_10 + var_472_11 and arg_469_1.time_ < var_472_10 + var_472_11 + arg_472_0 and not isNil(var_472_9) and arg_469_1.var_.characterEffect1049ui_story then
				arg_469_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_472_13 = 0

			if var_472_13 < arg_469_1.time_ and arg_469_1.time_ <= var_472_13 + arg_472_0 then
				arg_469_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049actionlink/1049action425")
			end

			local var_472_14 = 0

			if var_472_14 < arg_469_1.time_ and arg_469_1.time_ <= var_472_14 + arg_472_0 then
				arg_469_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_472_15 = 0
			local var_472_16 = 0.25

			if var_472_15 < arg_469_1.time_ and arg_469_1.time_ <= var_472_15 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_17 = arg_469_1:FormatText(StoryNameCfg[551].name)

				arg_469_1.leftNameTxt_.text = var_472_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_18 = arg_469_1:GetWordFromCfg(1104901114)
				local var_472_19 = arg_469_1:FormatText(var_472_18.content)

				arg_469_1.text_.text = var_472_19

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_20 = 10
				local var_472_21 = utf8.len(var_472_19)
				local var_472_22 = var_472_20 <= 0 and var_472_16 or var_472_16 * (var_472_21 / var_472_20)

				if var_472_22 > 0 and var_472_16 < var_472_22 then
					arg_469_1.talkMaxDuration = var_472_22

					if var_472_22 + var_472_15 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_22 + var_472_15
					end
				end

				arg_469_1.text_.text = var_472_19
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901114", "story_v_side_new_1104901.awb") ~= 0 then
					local var_472_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901114", "story_v_side_new_1104901.awb") / 1000

					if var_472_23 + var_472_15 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_23 + var_472_15
					end

					if var_472_18.prefab_name ~= "" and arg_469_1.actors_[var_472_18.prefab_name] ~= nil then
						local var_472_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_18.prefab_name].transform, "story_v_side_new_1104901", "1104901114", "story_v_side_new_1104901.awb")

						arg_469_1:RecordAudio("1104901114", var_472_24)
						arg_469_1:RecordAudio("1104901114", var_472_24)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901114", "story_v_side_new_1104901.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901114", "story_v_side_new_1104901.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_25 = math.max(var_472_16, arg_469_1.talkMaxDuration)

			if var_472_15 <= arg_469_1.time_ and arg_469_1.time_ < var_472_15 + var_472_25 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_15) / var_472_25

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_15 + var_472_25 and arg_469_1.time_ < var_472_15 + var_472_25 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play1104901115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1104901115
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1104901116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["1049ui_story"]
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect1049ui_story == nil then
				arg_473_1.var_.characterEffect1049ui_story = var_476_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 and not isNil(var_476_0) then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2

				if arg_473_1.var_.characterEffect1049ui_story and not isNil(var_476_0) then
					local var_476_4 = Mathf.Lerp(0, 0.5, var_476_3)

					arg_473_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1049ui_story.fillRatio = var_476_4
				end
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect1049ui_story then
				local var_476_5 = 0.5

				arg_473_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1049ui_story.fillRatio = var_476_5
			end

			local var_476_6 = 0
			local var_476_7 = 1.025

			if var_476_6 < arg_473_1.time_ and arg_473_1.time_ <= var_476_6 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_8 = arg_473_1:FormatText(StoryNameCfg[7].name)

				arg_473_1.leftNameTxt_.text = var_476_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_9 = arg_473_1:GetWordFromCfg(1104901115)
				local var_476_10 = arg_473_1:FormatText(var_476_9.content)

				arg_473_1.text_.text = var_476_10

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_11 = 41
				local var_476_12 = utf8.len(var_476_10)
				local var_476_13 = var_476_11 <= 0 and var_476_7 or var_476_7 * (var_476_12 / var_476_11)

				if var_476_13 > 0 and var_476_7 < var_476_13 then
					arg_473_1.talkMaxDuration = var_476_13

					if var_476_13 + var_476_6 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_13 + var_476_6
					end
				end

				arg_473_1.text_.text = var_476_10
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_14 = math.max(var_476_7, arg_473_1.talkMaxDuration)

			if var_476_6 <= arg_473_1.time_ and arg_473_1.time_ < var_476_6 + var_476_14 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_6) / var_476_14

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_6 + var_476_14 and arg_473_1.time_ < var_476_6 + var_476_14 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play1104901116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1104901116
		arg_477_1.duration_ = 8.97

		local var_477_0 = {
			zh = 5.766,
			ja = 8.966
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1104901117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["1049ui_story"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect1049ui_story == nil then
				arg_477_1.var_.characterEffect1049ui_story = var_480_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.200000002980232

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.characterEffect1049ui_story and not isNil(var_480_0) then
					arg_477_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect1049ui_story then
				arg_477_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_480_4 = 0

			if var_480_4 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action5_2")
			end

			local var_480_5 = 0

			if var_480_5 < arg_477_1.time_ and arg_477_1.time_ <= var_480_5 + arg_480_0 then
				arg_477_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_480_6 = 0
			local var_480_7 = 0.625

			if var_480_6 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_8 = arg_477_1:FormatText(StoryNameCfg[551].name)

				arg_477_1.leftNameTxt_.text = var_480_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_9 = arg_477_1:GetWordFromCfg(1104901116)
				local var_480_10 = arg_477_1:FormatText(var_480_9.content)

				arg_477_1.text_.text = var_480_10

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_11 = 25
				local var_480_12 = utf8.len(var_480_10)
				local var_480_13 = var_480_11 <= 0 and var_480_7 or var_480_7 * (var_480_12 / var_480_11)

				if var_480_13 > 0 and var_480_7 < var_480_13 then
					arg_477_1.talkMaxDuration = var_480_13

					if var_480_13 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_13 + var_480_6
					end
				end

				arg_477_1.text_.text = var_480_10
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901116", "story_v_side_new_1104901.awb") ~= 0 then
					local var_480_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901116", "story_v_side_new_1104901.awb") / 1000

					if var_480_14 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_14 + var_480_6
					end

					if var_480_9.prefab_name ~= "" and arg_477_1.actors_[var_480_9.prefab_name] ~= nil then
						local var_480_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_9.prefab_name].transform, "story_v_side_new_1104901", "1104901116", "story_v_side_new_1104901.awb")

						arg_477_1:RecordAudio("1104901116", var_480_15)
						arg_477_1:RecordAudio("1104901116", var_480_15)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901116", "story_v_side_new_1104901.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901116", "story_v_side_new_1104901.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_16 = math.max(var_480_7, arg_477_1.talkMaxDuration)

			if var_480_6 <= arg_477_1.time_ and arg_477_1.time_ < var_480_6 + var_480_16 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_6) / var_480_16

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_6 + var_480_16 and arg_477_1.time_ < var_480_6 + var_480_16 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play1104901117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1104901117
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1104901118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["1049ui_story"]
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect1049ui_story == nil then
				arg_481_1.var_.characterEffect1049ui_story = var_484_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_2 and not isNil(var_484_0) then
				local var_484_3 = (arg_481_1.time_ - var_484_1) / var_484_2

				if arg_481_1.var_.characterEffect1049ui_story and not isNil(var_484_0) then
					local var_484_4 = Mathf.Lerp(0, 0.5, var_484_3)

					arg_481_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_481_1.var_.characterEffect1049ui_story.fillRatio = var_484_4
				end
			end

			if arg_481_1.time_ >= var_484_1 + var_484_2 and arg_481_1.time_ < var_484_1 + var_484_2 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect1049ui_story then
				local var_484_5 = 0.5

				arg_481_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_481_1.var_.characterEffect1049ui_story.fillRatio = var_484_5
			end

			local var_484_6 = 0
			local var_484_7 = 0.625

			if var_484_6 < arg_481_1.time_ and arg_481_1.time_ <= var_484_6 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_8 = arg_481_1:FormatText(StoryNameCfg[7].name)

				arg_481_1.leftNameTxt_.text = var_484_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, true)
				arg_481_1.iconController_:SetSelectedState("hero")

				arg_481_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_481_1.callingController_:SetSelectedState("normal")

				arg_481_1.keyicon_.color = Color.New(1, 1, 1)
				arg_481_1.icon_.color = Color.New(1, 1, 1)

				local var_484_9 = arg_481_1:GetWordFromCfg(1104901117)
				local var_484_10 = arg_481_1:FormatText(var_484_9.content)

				arg_481_1.text_.text = var_484_10

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_11 = 25
				local var_484_12 = utf8.len(var_484_10)
				local var_484_13 = var_484_11 <= 0 and var_484_7 or var_484_7 * (var_484_12 / var_484_11)

				if var_484_13 > 0 and var_484_7 < var_484_13 then
					arg_481_1.talkMaxDuration = var_484_13

					if var_484_13 + var_484_6 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_13 + var_484_6
					end
				end

				arg_481_1.text_.text = var_484_10
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_14 = math.max(var_484_7, arg_481_1.talkMaxDuration)

			if var_484_6 <= arg_481_1.time_ and arg_481_1.time_ < var_484_6 + var_484_14 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_6) / var_484_14

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_6 + var_484_14 and arg_481_1.time_ < var_484_6 + var_484_14 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play1104901118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1104901118
		arg_485_1.duration_ = 7.8

		local var_485_0 = {
			zh = 7.7,
			ja = 7.8
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1104901119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["1049ui_story"].transform
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.var_.moveOldPos1049ui_story = var_488_0.localPosition
			end

			local var_488_2 = 0.001

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2
				local var_488_4 = Vector3.New(0, -1.2, -6)

				var_488_0.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1049ui_story, var_488_4, var_488_3)

				local var_488_5 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_5.x, var_488_5.y, var_488_5.z)

				local var_488_6 = var_488_0.localEulerAngles

				var_488_6.z = 0
				var_488_6.x = 0
				var_488_0.localEulerAngles = var_488_6
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 then
				var_488_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_488_7 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_7.x, var_488_7.y, var_488_7.z)

				local var_488_8 = var_488_0.localEulerAngles

				var_488_8.z = 0
				var_488_8.x = 0
				var_488_0.localEulerAngles = var_488_8
			end

			local var_488_9 = arg_485_1.actors_["1049ui_story"]
			local var_488_10 = 0

			if var_488_10 < arg_485_1.time_ and arg_485_1.time_ <= var_488_10 + arg_488_0 and not isNil(var_488_9) and arg_485_1.var_.characterEffect1049ui_story == nil then
				arg_485_1.var_.characterEffect1049ui_story = var_488_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_11 = 0.200000002980232

			if var_488_10 <= arg_485_1.time_ and arg_485_1.time_ < var_488_10 + var_488_11 and not isNil(var_488_9) then
				local var_488_12 = (arg_485_1.time_ - var_488_10) / var_488_11

				if arg_485_1.var_.characterEffect1049ui_story and not isNil(var_488_9) then
					arg_485_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= var_488_10 + var_488_11 and arg_485_1.time_ < var_488_10 + var_488_11 + arg_488_0 and not isNil(var_488_9) and arg_485_1.var_.characterEffect1049ui_story then
				arg_485_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_488_13 = 0

			if var_488_13 < arg_485_1.time_ and arg_485_1.time_ <= var_488_13 + arg_488_0 then
				arg_485_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_488_14 = 0

			if var_488_14 < arg_485_1.time_ and arg_485_1.time_ <= var_488_14 + arg_488_0 then
				arg_485_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_488_15 = 0
			local var_488_16 = 0.7

			if var_488_15 < arg_485_1.time_ and arg_485_1.time_ <= var_488_15 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_17 = arg_485_1:FormatText(StoryNameCfg[551].name)

				arg_485_1.leftNameTxt_.text = var_488_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_18 = arg_485_1:GetWordFromCfg(1104901118)
				local var_488_19 = arg_485_1:FormatText(var_488_18.content)

				arg_485_1.text_.text = var_488_19

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_20 = 28
				local var_488_21 = utf8.len(var_488_19)
				local var_488_22 = var_488_20 <= 0 and var_488_16 or var_488_16 * (var_488_21 / var_488_20)

				if var_488_22 > 0 and var_488_16 < var_488_22 then
					arg_485_1.talkMaxDuration = var_488_22

					if var_488_22 + var_488_15 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_22 + var_488_15
					end
				end

				arg_485_1.text_.text = var_488_19
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901118", "story_v_side_new_1104901.awb") ~= 0 then
					local var_488_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901118", "story_v_side_new_1104901.awb") / 1000

					if var_488_23 + var_488_15 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_23 + var_488_15
					end

					if var_488_18.prefab_name ~= "" and arg_485_1.actors_[var_488_18.prefab_name] ~= nil then
						local var_488_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_18.prefab_name].transform, "story_v_side_new_1104901", "1104901118", "story_v_side_new_1104901.awb")

						arg_485_1:RecordAudio("1104901118", var_488_24)
						arg_485_1:RecordAudio("1104901118", var_488_24)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901118", "story_v_side_new_1104901.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901118", "story_v_side_new_1104901.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_25 = math.max(var_488_16, arg_485_1.talkMaxDuration)

			if var_488_15 <= arg_485_1.time_ and arg_485_1.time_ < var_488_15 + var_488_25 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_15) / var_488_25

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_15 + var_488_25 and arg_485_1.time_ < var_488_15 + var_488_25 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play1104901119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1104901119
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1104901120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.actors_["1049ui_story"]
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect1049ui_story == nil then
				arg_489_1.var_.characterEffect1049ui_story = var_492_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_2 = 0.200000002980232

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 and not isNil(var_492_0) then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2

				if arg_489_1.var_.characterEffect1049ui_story and not isNil(var_492_0) then
					local var_492_4 = Mathf.Lerp(0, 0.5, var_492_3)

					arg_489_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1049ui_story.fillRatio = var_492_4
				end
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect1049ui_story then
				local var_492_5 = 0.5

				arg_489_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1049ui_story.fillRatio = var_492_5
			end

			local var_492_6 = 0
			local var_492_7 = 0.175

			if var_492_6 < arg_489_1.time_ and arg_489_1.time_ <= var_492_6 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_8 = arg_489_1:FormatText(StoryNameCfg[7].name)

				arg_489_1.leftNameTxt_.text = var_492_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_9 = arg_489_1:GetWordFromCfg(1104901119)
				local var_492_10 = arg_489_1:FormatText(var_492_9.content)

				arg_489_1.text_.text = var_492_10

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_11 = 7
				local var_492_12 = utf8.len(var_492_10)
				local var_492_13 = var_492_11 <= 0 and var_492_7 or var_492_7 * (var_492_12 / var_492_11)

				if var_492_13 > 0 and var_492_7 < var_492_13 then
					arg_489_1.talkMaxDuration = var_492_13

					if var_492_13 + var_492_6 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_13 + var_492_6
					end
				end

				arg_489_1.text_.text = var_492_10
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_14 = math.max(var_492_7, arg_489_1.talkMaxDuration)

			if var_492_6 <= arg_489_1.time_ and arg_489_1.time_ < var_492_6 + var_492_14 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_6) / var_492_14

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_6 + var_492_14 and arg_489_1.time_ < var_492_6 + var_492_14 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1104901120 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 1104901120
		arg_493_1.duration_ = 9

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play1104901121(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = "ST06"

			if arg_493_1.bgs_[var_496_0] == nil then
				local var_496_1 = Object.Instantiate(arg_493_1.paintGo_)

				var_496_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_496_0)
				var_496_1.name = var_496_0
				var_496_1.transform.parent = arg_493_1.stage_.transform
				var_496_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_493_1.bgs_[var_496_0] = var_496_1
			end

			local var_496_2 = 2

			if var_496_2 < arg_493_1.time_ and arg_493_1.time_ <= var_496_2 + arg_496_0 then
				local var_496_3 = manager.ui.mainCamera.transform.localPosition
				local var_496_4 = Vector3.New(0, 0, 10) + Vector3.New(var_496_3.x, var_496_3.y, 0)
				local var_496_5 = arg_493_1.bgs_.ST06

				var_496_5.transform.localPosition = var_496_4
				var_496_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_496_6 = var_496_5:GetComponent("SpriteRenderer")

				if var_496_6 and var_496_6.sprite then
					local var_496_7 = (var_496_5.transform.localPosition - var_496_3).z
					local var_496_8 = manager.ui.mainCameraCom_
					local var_496_9 = 2 * var_496_7 * Mathf.Tan(var_496_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_496_10 = var_496_9 * var_496_8.aspect
					local var_496_11 = var_496_6.sprite.bounds.size.x
					local var_496_12 = var_496_6.sprite.bounds.size.y
					local var_496_13 = var_496_10 / var_496_11
					local var_496_14 = var_496_9 / var_496_12
					local var_496_15 = var_496_14 < var_496_13 and var_496_13 or var_496_14

					var_496_5.transform.localScale = Vector3.New(var_496_15, var_496_15, 0)
				end

				for iter_496_0, iter_496_1 in pairs(arg_493_1.bgs_) do
					if iter_496_0 ~= "ST06" then
						iter_496_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_496_16 = 4

			if var_496_16 < arg_493_1.time_ and arg_493_1.time_ <= var_496_16 + arg_496_0 then
				arg_493_1.allBtn_.enabled = false
			end

			local var_496_17 = 0.3

			if arg_493_1.time_ >= var_496_16 + var_496_17 and arg_493_1.time_ < var_496_16 + var_496_17 + arg_496_0 then
				arg_493_1.allBtn_.enabled = true
			end

			local var_496_18 = 0

			if var_496_18 < arg_493_1.time_ and arg_493_1.time_ <= var_496_18 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_19 = 2

			if var_496_18 <= arg_493_1.time_ and arg_493_1.time_ < var_496_18 + var_496_19 then
				local var_496_20 = (arg_493_1.time_ - var_496_18) / var_496_19
				local var_496_21 = Color.New(0, 0, 0)

				var_496_21.a = Mathf.Lerp(0, 1, var_496_20)
				arg_493_1.mask_.color = var_496_21
			end

			if arg_493_1.time_ >= var_496_18 + var_496_19 and arg_493_1.time_ < var_496_18 + var_496_19 + arg_496_0 then
				local var_496_22 = Color.New(0, 0, 0)

				var_496_22.a = 1
				arg_493_1.mask_.color = var_496_22
			end

			local var_496_23 = 2

			if var_496_23 < arg_493_1.time_ and arg_493_1.time_ <= var_496_23 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_24 = 2

			if var_496_23 <= arg_493_1.time_ and arg_493_1.time_ < var_496_23 + var_496_24 then
				local var_496_25 = (arg_493_1.time_ - var_496_23) / var_496_24
				local var_496_26 = Color.New(0, 0, 0)

				var_496_26.a = Mathf.Lerp(1, 0, var_496_25)
				arg_493_1.mask_.color = var_496_26
			end

			if arg_493_1.time_ >= var_496_23 + var_496_24 and arg_493_1.time_ < var_496_23 + var_496_24 + arg_496_0 then
				local var_496_27 = Color.New(0, 0, 0)
				local var_496_28 = 0

				arg_493_1.mask_.enabled = false
				var_496_27.a = var_496_28
				arg_493_1.mask_.color = var_496_27
			end

			local var_496_29 = arg_493_1.actors_["1049ui_story"].transform
			local var_496_30 = 1.96599999815226

			if var_496_30 < arg_493_1.time_ and arg_493_1.time_ <= var_496_30 + arg_496_0 then
				arg_493_1.var_.moveOldPos1049ui_story = var_496_29.localPosition
			end

			local var_496_31 = 0.001

			if var_496_30 <= arg_493_1.time_ and arg_493_1.time_ < var_496_30 + var_496_31 then
				local var_496_32 = (arg_493_1.time_ - var_496_30) / var_496_31
				local var_496_33 = Vector3.New(0, 100, 0)

				var_496_29.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1049ui_story, var_496_33, var_496_32)

				local var_496_34 = manager.ui.mainCamera.transform.position - var_496_29.position

				var_496_29.forward = Vector3.New(var_496_34.x, var_496_34.y, var_496_34.z)

				local var_496_35 = var_496_29.localEulerAngles

				var_496_35.z = 0
				var_496_35.x = 0
				var_496_29.localEulerAngles = var_496_35
			end

			if arg_493_1.time_ >= var_496_30 + var_496_31 and arg_493_1.time_ < var_496_30 + var_496_31 + arg_496_0 then
				var_496_29.localPosition = Vector3.New(0, 100, 0)

				local var_496_36 = manager.ui.mainCamera.transform.position - var_496_29.position

				var_496_29.forward = Vector3.New(var_496_36.x, var_496_36.y, var_496_36.z)

				local var_496_37 = var_496_29.localEulerAngles

				var_496_37.z = 0
				var_496_37.x = 0
				var_496_29.localEulerAngles = var_496_37
			end

			local var_496_38 = arg_493_1.actors_["1049ui_story"]
			local var_496_39 = 1.96599999815226

			if var_496_39 < arg_493_1.time_ and arg_493_1.time_ <= var_496_39 + arg_496_0 and not isNil(var_496_38) and arg_493_1.var_.characterEffect1049ui_story == nil then
				arg_493_1.var_.characterEffect1049ui_story = var_496_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_40 = 0.034000001847744

			if var_496_39 <= arg_493_1.time_ and arg_493_1.time_ < var_496_39 + var_496_40 and not isNil(var_496_38) then
				local var_496_41 = (arg_493_1.time_ - var_496_39) / var_496_40

				if arg_493_1.var_.characterEffect1049ui_story and not isNil(var_496_38) then
					local var_496_42 = Mathf.Lerp(0, 0.5, var_496_41)

					arg_493_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_493_1.var_.characterEffect1049ui_story.fillRatio = var_496_42
				end
			end

			if arg_493_1.time_ >= var_496_39 + var_496_40 and arg_493_1.time_ < var_496_39 + var_496_40 + arg_496_0 and not isNil(var_496_38) and arg_493_1.var_.characterEffect1049ui_story then
				local var_496_43 = 0.5

				arg_493_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_493_1.var_.characterEffect1049ui_story.fillRatio = var_496_43
			end

			if arg_493_1.frameCnt_ <= 1 then
				arg_493_1.dialog_:SetActive(false)
			end

			local var_496_44 = 4
			local var_496_45 = 0.825

			if var_496_44 < arg_493_1.time_ and arg_493_1.time_ <= var_496_44 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0

				arg_493_1.dialog_:SetActive(true)

				arg_493_1.dialogCg_.alpha = 0

				local var_496_46 = LeanTween.value(arg_493_1.dialog_, 0, 1, 0.3)

				var_496_46:setOnUpdate(LuaHelper.FloatAction(function(arg_497_0)
					arg_493_1.dialogCg_.alpha = arg_497_0
				end))
				var_496_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_493_1.dialog_)
					var_496_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_493_1.duration_ = arg_493_1.duration_ + 0.3

				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_47 = arg_493_1:GetWordFromCfg(1104901120)
				local var_496_48 = arg_493_1:FormatText(var_496_47.content)

				arg_493_1.text_.text = var_496_48

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_49 = 33
				local var_496_50 = utf8.len(var_496_48)
				local var_496_51 = var_496_49 <= 0 and var_496_45 or var_496_45 * (var_496_50 / var_496_49)

				if var_496_51 > 0 and var_496_45 < var_496_51 then
					arg_493_1.talkMaxDuration = var_496_51
					var_496_44 = var_496_44 + 0.3

					if var_496_51 + var_496_44 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_51 + var_496_44
					end
				end

				arg_493_1.text_.text = var_496_48
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_52 = var_496_44 + 0.3
			local var_496_53 = math.max(var_496_45, arg_493_1.talkMaxDuration)

			if var_496_52 <= arg_493_1.time_ and arg_493_1.time_ < var_496_52 + var_496_53 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_52) / var_496_53

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_52 + var_496_53 and arg_493_1.time_ < var_496_52 + var_496_53 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play1104901121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1104901121
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1104901122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0
			local var_502_1 = 1.525

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_2 = arg_499_1:GetWordFromCfg(1104901121)
				local var_502_3 = arg_499_1:FormatText(var_502_2.content)

				arg_499_1.text_.text = var_502_3

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 61
				local var_502_5 = utf8.len(var_502_3)
				local var_502_6 = var_502_4 <= 0 and var_502_1 or var_502_1 * (var_502_5 / var_502_4)

				if var_502_6 > 0 and var_502_1 < var_502_6 then
					arg_499_1.talkMaxDuration = var_502_6

					if var_502_6 + var_502_0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_6 + var_502_0
					end
				end

				arg_499_1.text_.text = var_502_3
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_1, arg_499_1.talkMaxDuration)

			if var_502_0 <= arg_499_1.time_ and arg_499_1.time_ < var_502_0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_0 + var_502_7 and arg_499_1.time_ < var_502_0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play1104901122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1104901122
		arg_503_1.duration_ = 4.03

		local var_503_0 = {
			zh = 4.033,
			ja = 3.8
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1104901123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["1049ui_story"].transform
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 then
				arg_503_1.var_.moveOldPos1049ui_story = var_506_0.localPosition
			end

			local var_506_2 = 0.001

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2
				local var_506_4 = Vector3.New(0, -1.2, -6)

				var_506_0.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos1049ui_story, var_506_4, var_506_3)

				local var_506_5 = manager.ui.mainCamera.transform.position - var_506_0.position

				var_506_0.forward = Vector3.New(var_506_5.x, var_506_5.y, var_506_5.z)

				local var_506_6 = var_506_0.localEulerAngles

				var_506_6.z = 0
				var_506_6.x = 0
				var_506_0.localEulerAngles = var_506_6
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 then
				var_506_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_506_7 = manager.ui.mainCamera.transform.position - var_506_0.position

				var_506_0.forward = Vector3.New(var_506_7.x, var_506_7.y, var_506_7.z)

				local var_506_8 = var_506_0.localEulerAngles

				var_506_8.z = 0
				var_506_8.x = 0
				var_506_0.localEulerAngles = var_506_8
			end

			local var_506_9 = arg_503_1.actors_["1049ui_story"]
			local var_506_10 = 0

			if var_506_10 < arg_503_1.time_ and arg_503_1.time_ <= var_506_10 + arg_506_0 and not isNil(var_506_9) and arg_503_1.var_.characterEffect1049ui_story == nil then
				arg_503_1.var_.characterEffect1049ui_story = var_506_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_11 = 0.200000002980232

			if var_506_10 <= arg_503_1.time_ and arg_503_1.time_ < var_506_10 + var_506_11 and not isNil(var_506_9) then
				local var_506_12 = (arg_503_1.time_ - var_506_10) / var_506_11

				if arg_503_1.var_.characterEffect1049ui_story and not isNil(var_506_9) then
					arg_503_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= var_506_10 + var_506_11 and arg_503_1.time_ < var_506_10 + var_506_11 + arg_506_0 and not isNil(var_506_9) and arg_503_1.var_.characterEffect1049ui_story then
				arg_503_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_506_13 = 0

			if var_506_13 < arg_503_1.time_ and arg_503_1.time_ <= var_506_13 + arg_506_0 then
				arg_503_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_506_14 = 0

			if var_506_14 < arg_503_1.time_ and arg_503_1.time_ <= var_506_14 + arg_506_0 then
				arg_503_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_506_15 = 0
			local var_506_16 = 0.475

			if var_506_15 < arg_503_1.time_ and arg_503_1.time_ <= var_506_15 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_17 = arg_503_1:FormatText(StoryNameCfg[551].name)

				arg_503_1.leftNameTxt_.text = var_506_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_18 = arg_503_1:GetWordFromCfg(1104901122)
				local var_506_19 = arg_503_1:FormatText(var_506_18.content)

				arg_503_1.text_.text = var_506_19

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_20 = 19
				local var_506_21 = utf8.len(var_506_19)
				local var_506_22 = var_506_20 <= 0 and var_506_16 or var_506_16 * (var_506_21 / var_506_20)

				if var_506_22 > 0 and var_506_16 < var_506_22 then
					arg_503_1.talkMaxDuration = var_506_22

					if var_506_22 + var_506_15 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_22 + var_506_15
					end
				end

				arg_503_1.text_.text = var_506_19
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901122", "story_v_side_new_1104901.awb") ~= 0 then
					local var_506_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901122", "story_v_side_new_1104901.awb") / 1000

					if var_506_23 + var_506_15 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_23 + var_506_15
					end

					if var_506_18.prefab_name ~= "" and arg_503_1.actors_[var_506_18.prefab_name] ~= nil then
						local var_506_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_18.prefab_name].transform, "story_v_side_new_1104901", "1104901122", "story_v_side_new_1104901.awb")

						arg_503_1:RecordAudio("1104901122", var_506_24)
						arg_503_1:RecordAudio("1104901122", var_506_24)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901122", "story_v_side_new_1104901.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901122", "story_v_side_new_1104901.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_25 = math.max(var_506_16, arg_503_1.talkMaxDuration)

			if var_506_15 <= arg_503_1.time_ and arg_503_1.time_ < var_506_15 + var_506_25 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_15) / var_506_25

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_15 + var_506_25 and arg_503_1.time_ < var_506_15 + var_506_25 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play1104901123 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1104901123
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1104901124(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["1049ui_story"]
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.characterEffect1049ui_story == nil then
				arg_507_1.var_.characterEffect1049ui_story = var_510_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.200000002980232

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 and not isNil(var_510_0) then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2

				if arg_507_1.var_.characterEffect1049ui_story and not isNil(var_510_0) then
					local var_510_4 = Mathf.Lerp(0, 0.5, var_510_3)

					arg_507_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_507_1.var_.characterEffect1049ui_story.fillRatio = var_510_4
				end
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 and not isNil(var_510_0) and arg_507_1.var_.characterEffect1049ui_story then
				local var_510_5 = 0.5

				arg_507_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_507_1.var_.characterEffect1049ui_story.fillRatio = var_510_5
			end

			local var_510_6 = 0
			local var_510_7 = 0.05

			if var_510_6 < arg_507_1.time_ and arg_507_1.time_ <= var_510_6 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_8 = arg_507_1:FormatText(StoryNameCfg[7].name)

				arg_507_1.leftNameTxt_.text = var_510_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_9 = arg_507_1:GetWordFromCfg(1104901123)
				local var_510_10 = arg_507_1:FormatText(var_510_9.content)

				arg_507_1.text_.text = var_510_10

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_11 = 2
				local var_510_12 = utf8.len(var_510_10)
				local var_510_13 = var_510_11 <= 0 and var_510_7 or var_510_7 * (var_510_12 / var_510_11)

				if var_510_13 > 0 and var_510_7 < var_510_13 then
					arg_507_1.talkMaxDuration = var_510_13

					if var_510_13 + var_510_6 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_13 + var_510_6
					end
				end

				arg_507_1.text_.text = var_510_10
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_14 = math.max(var_510_7, arg_507_1.talkMaxDuration)

			if var_510_6 <= arg_507_1.time_ and arg_507_1.time_ < var_510_6 + var_510_14 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_6) / var_510_14

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_6 + var_510_14 and arg_507_1.time_ < var_510_6 + var_510_14 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play1104901124 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1104901124
		arg_511_1.duration_ = 4.77

		local var_511_0 = {
			zh = 4.733,
			ja = 4.766
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1104901125(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1049ui_story"]
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.characterEffect1049ui_story == nil then
				arg_511_1.var_.characterEffect1049ui_story = var_514_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_514_2 = 0.200000002980232

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 and not isNil(var_514_0) then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2

				if arg_511_1.var_.characterEffect1049ui_story and not isNil(var_514_0) then
					arg_511_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 and not isNil(var_514_0) and arg_511_1.var_.characterEffect1049ui_story then
				arg_511_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_514_4 = 0

			if var_514_4 < arg_511_1.time_ and arg_511_1.time_ <= var_514_4 + arg_514_0 then
				arg_511_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_514_5 = 0

			if var_514_5 < arg_511_1.time_ and arg_511_1.time_ <= var_514_5 + arg_514_0 then
				arg_511_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_514_6 = 0
			local var_514_7 = 0.55

			if var_514_6 < arg_511_1.time_ and arg_511_1.time_ <= var_514_6 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_8 = arg_511_1:FormatText(StoryNameCfg[551].name)

				arg_511_1.leftNameTxt_.text = var_514_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_9 = arg_511_1:GetWordFromCfg(1104901124)
				local var_514_10 = arg_511_1:FormatText(var_514_9.content)

				arg_511_1.text_.text = var_514_10

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_11 = 22
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901124", "story_v_side_new_1104901.awb") ~= 0 then
					local var_514_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901124", "story_v_side_new_1104901.awb") / 1000

					if var_514_14 + var_514_6 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_14 + var_514_6
					end

					if var_514_9.prefab_name ~= "" and arg_511_1.actors_[var_514_9.prefab_name] ~= nil then
						local var_514_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_9.prefab_name].transform, "story_v_side_new_1104901", "1104901124", "story_v_side_new_1104901.awb")

						arg_511_1:RecordAudio("1104901124", var_514_15)
						arg_511_1:RecordAudio("1104901124", var_514_15)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901124", "story_v_side_new_1104901.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901124", "story_v_side_new_1104901.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_16 = math.max(var_514_7, arg_511_1.talkMaxDuration)

			if var_514_6 <= arg_511_1.time_ and arg_511_1.time_ < var_514_6 + var_514_16 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_6) / var_514_16

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_6 + var_514_16 and arg_511_1.time_ < var_514_6 + var_514_16 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1104901125 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1104901125
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1104901126(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1049ui_story"]
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.characterEffect1049ui_story == nil then
				arg_515_1.var_.characterEffect1049ui_story = var_518_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.200000002980232

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 and not isNil(var_518_0) then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2

				if arg_515_1.var_.characterEffect1049ui_story and not isNil(var_518_0) then
					local var_518_4 = Mathf.Lerp(0, 0.5, var_518_3)

					arg_515_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1049ui_story.fillRatio = var_518_4
				end
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 and not isNil(var_518_0) and arg_515_1.var_.characterEffect1049ui_story then
				local var_518_5 = 0.5

				arg_515_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1049ui_story.fillRatio = var_518_5
			end

			local var_518_6 = 0
			local var_518_7 = 0.325

			if var_518_6 < arg_515_1.time_ and arg_515_1.time_ <= var_518_6 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_8 = arg_515_1:FormatText(StoryNameCfg[7].name)

				arg_515_1.leftNameTxt_.text = var_518_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_9 = arg_515_1:GetWordFromCfg(1104901125)
				local var_518_10 = arg_515_1:FormatText(var_518_9.content)

				arg_515_1.text_.text = var_518_10

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_11 = 13
				local var_518_12 = utf8.len(var_518_10)
				local var_518_13 = var_518_11 <= 0 and var_518_7 or var_518_7 * (var_518_12 / var_518_11)

				if var_518_13 > 0 and var_518_7 < var_518_13 then
					arg_515_1.talkMaxDuration = var_518_13

					if var_518_13 + var_518_6 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_13 + var_518_6
					end
				end

				arg_515_1.text_.text = var_518_10
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_14 = math.max(var_518_7, arg_515_1.talkMaxDuration)

			if var_518_6 <= arg_515_1.time_ and arg_515_1.time_ < var_518_6 + var_518_14 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_6) / var_518_14

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_6 + var_518_14 and arg_515_1.time_ < var_518_6 + var_518_14 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play1104901126 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1104901126
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1104901127(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0
			local var_522_1 = 0.5

			if var_522_0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, false)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_2 = arg_519_1:GetWordFromCfg(1104901126)
				local var_522_3 = arg_519_1:FormatText(var_522_2.content)

				arg_519_1.text_.text = var_522_3

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_4 = 20
				local var_522_5 = utf8.len(var_522_3)
				local var_522_6 = var_522_4 <= 0 and var_522_1 or var_522_1 * (var_522_5 / var_522_4)

				if var_522_6 > 0 and var_522_1 < var_522_6 then
					arg_519_1.talkMaxDuration = var_522_6

					if var_522_6 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_6 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_3
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_7 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_7 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_7

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_7 and arg_519_1.time_ < var_522_0 + var_522_7 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1104901127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1104901127
		arg_523_1.duration_ = 2

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1104901128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["1049ui_story"].transform
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 then
				arg_523_1.var_.moveOldPos1049ui_story = var_526_0.localPosition
			end

			local var_526_2 = 0.001

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2
				local var_526_4 = Vector3.New(0, -1.2, -6)

				var_526_0.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1049ui_story, var_526_4, var_526_3)

				local var_526_5 = manager.ui.mainCamera.transform.position - var_526_0.position

				var_526_0.forward = Vector3.New(var_526_5.x, var_526_5.y, var_526_5.z)

				local var_526_6 = var_526_0.localEulerAngles

				var_526_6.z = 0
				var_526_6.x = 0
				var_526_0.localEulerAngles = var_526_6
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 then
				var_526_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_526_7 = manager.ui.mainCamera.transform.position - var_526_0.position

				var_526_0.forward = Vector3.New(var_526_7.x, var_526_7.y, var_526_7.z)

				local var_526_8 = var_526_0.localEulerAngles

				var_526_8.z = 0
				var_526_8.x = 0
				var_526_0.localEulerAngles = var_526_8
			end

			local var_526_9 = arg_523_1.actors_["1049ui_story"]
			local var_526_10 = 0

			if var_526_10 < arg_523_1.time_ and arg_523_1.time_ <= var_526_10 + arg_526_0 and not isNil(var_526_9) and arg_523_1.var_.characterEffect1049ui_story == nil then
				arg_523_1.var_.characterEffect1049ui_story = var_526_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_11 = 0.200000002980232

			if var_526_10 <= arg_523_1.time_ and arg_523_1.time_ < var_526_10 + var_526_11 and not isNil(var_526_9) then
				local var_526_12 = (arg_523_1.time_ - var_526_10) / var_526_11

				if arg_523_1.var_.characterEffect1049ui_story and not isNil(var_526_9) then
					arg_523_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_523_1.time_ >= var_526_10 + var_526_11 and arg_523_1.time_ < var_526_10 + var_526_11 + arg_526_0 and not isNil(var_526_9) and arg_523_1.var_.characterEffect1049ui_story then
				arg_523_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_526_13 = 0

			if var_526_13 < arg_523_1.time_ and arg_523_1.time_ <= var_526_13 + arg_526_0 then
				arg_523_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_526_14 = 0

			if var_526_14 < arg_523_1.time_ and arg_523_1.time_ <= var_526_14 + arg_526_0 then
				arg_523_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_526_15 = 0
			local var_526_16 = 0.075

			if var_526_15 < arg_523_1.time_ and arg_523_1.time_ <= var_526_15 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_17 = arg_523_1:FormatText(StoryNameCfg[551].name)

				arg_523_1.leftNameTxt_.text = var_526_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_18 = arg_523_1:GetWordFromCfg(1104901127)
				local var_526_19 = arg_523_1:FormatText(var_526_18.content)

				arg_523_1.text_.text = var_526_19

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_20 = 3
				local var_526_21 = utf8.len(var_526_19)
				local var_526_22 = var_526_20 <= 0 and var_526_16 or var_526_16 * (var_526_21 / var_526_20)

				if var_526_22 > 0 and var_526_16 < var_526_22 then
					arg_523_1.talkMaxDuration = var_526_22

					if var_526_22 + var_526_15 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_22 + var_526_15
					end
				end

				arg_523_1.text_.text = var_526_19
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901127", "story_v_side_new_1104901.awb") ~= 0 then
					local var_526_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901127", "story_v_side_new_1104901.awb") / 1000

					if var_526_23 + var_526_15 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_23 + var_526_15
					end

					if var_526_18.prefab_name ~= "" and arg_523_1.actors_[var_526_18.prefab_name] ~= nil then
						local var_526_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_18.prefab_name].transform, "story_v_side_new_1104901", "1104901127", "story_v_side_new_1104901.awb")

						arg_523_1:RecordAudio("1104901127", var_526_24)
						arg_523_1:RecordAudio("1104901127", var_526_24)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901127", "story_v_side_new_1104901.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901127", "story_v_side_new_1104901.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_25 = math.max(var_526_16, arg_523_1.talkMaxDuration)

			if var_526_15 <= arg_523_1.time_ and arg_523_1.time_ < var_526_15 + var_526_25 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_15) / var_526_25

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_15 + var_526_25 and arg_523_1.time_ < var_526_15 + var_526_25 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play1104901128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1104901128
		arg_527_1.duration_ = 5.03

		local var_527_0 = {
			zh = 3.166,
			ja = 5.033
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1104901129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = arg_527_1.actors_["1049ui_story"]
			local var_530_1 = 0

			if var_530_1 < arg_527_1.time_ and arg_527_1.time_ <= var_530_1 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.characterEffect1049ui_story == nil then
				arg_527_1.var_.characterEffect1049ui_story = var_530_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_530_2 = 0.200000002980232

			if var_530_1 <= arg_527_1.time_ and arg_527_1.time_ < var_530_1 + var_530_2 and not isNil(var_530_0) then
				local var_530_3 = (arg_527_1.time_ - var_530_1) / var_530_2

				if arg_527_1.var_.characterEffect1049ui_story and not isNil(var_530_0) then
					local var_530_4 = Mathf.Lerp(0, 0.5, var_530_3)

					arg_527_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_527_1.var_.characterEffect1049ui_story.fillRatio = var_530_4
				end
			end

			if arg_527_1.time_ >= var_530_1 + var_530_2 and arg_527_1.time_ < var_530_1 + var_530_2 + arg_530_0 and not isNil(var_530_0) and arg_527_1.var_.characterEffect1049ui_story then
				local var_530_5 = 0.5

				arg_527_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_527_1.var_.characterEffect1049ui_story.fillRatio = var_530_5
			end

			local var_530_6 = 0
			local var_530_7 = 0.325

			if var_530_6 < arg_527_1.time_ and arg_527_1.time_ <= var_530_6 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				local var_530_8 = arg_527_1:FormatText(StoryNameCfg[1006].name)

				arg_527_1.leftNameTxt_.text = var_530_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_9 = arg_527_1:GetWordFromCfg(1104901128)
				local var_530_10 = arg_527_1:FormatText(var_530_9.content)

				arg_527_1.text_.text = var_530_10

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_11 = 13
				local var_530_12 = utf8.len(var_530_10)
				local var_530_13 = var_530_11 <= 0 and var_530_7 or var_530_7 * (var_530_12 / var_530_11)

				if var_530_13 > 0 and var_530_7 < var_530_13 then
					arg_527_1.talkMaxDuration = var_530_13

					if var_530_13 + var_530_6 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_13 + var_530_6
					end
				end

				arg_527_1.text_.text = var_530_10
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901128", "story_v_side_new_1104901.awb") ~= 0 then
					local var_530_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901128", "story_v_side_new_1104901.awb") / 1000

					if var_530_14 + var_530_6 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_14 + var_530_6
					end

					if var_530_9.prefab_name ~= "" and arg_527_1.actors_[var_530_9.prefab_name] ~= nil then
						local var_530_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_9.prefab_name].transform, "story_v_side_new_1104901", "1104901128", "story_v_side_new_1104901.awb")

						arg_527_1:RecordAudio("1104901128", var_530_15)
						arg_527_1:RecordAudio("1104901128", var_530_15)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901128", "story_v_side_new_1104901.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901128", "story_v_side_new_1104901.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_16 = math.max(var_530_7, arg_527_1.talkMaxDuration)

			if var_530_6 <= arg_527_1.time_ and arg_527_1.time_ < var_530_6 + var_530_16 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_6) / var_530_16

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_6 + var_530_16 and arg_527_1.time_ < var_530_6 + var_530_16 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1104901129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1104901129
		arg_531_1.duration_ = 5.27

		local var_531_0 = {
			zh = 3.966,
			ja = 5.266
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1104901130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = arg_531_1.actors_["1049ui_story"].transform
			local var_534_1 = 0

			if var_534_1 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.var_.moveOldPos1049ui_story = var_534_0.localPosition
			end

			local var_534_2 = 0.001

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_2 then
				local var_534_3 = (arg_531_1.time_ - var_534_1) / var_534_2
				local var_534_4 = Vector3.New(0, -1.2, -6)

				var_534_0.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1049ui_story, var_534_4, var_534_3)

				local var_534_5 = manager.ui.mainCamera.transform.position - var_534_0.position

				var_534_0.forward = Vector3.New(var_534_5.x, var_534_5.y, var_534_5.z)

				local var_534_6 = var_534_0.localEulerAngles

				var_534_6.z = 0
				var_534_6.x = 0
				var_534_0.localEulerAngles = var_534_6
			end

			if arg_531_1.time_ >= var_534_1 + var_534_2 and arg_531_1.time_ < var_534_1 + var_534_2 + arg_534_0 then
				var_534_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_534_7 = manager.ui.mainCamera.transform.position - var_534_0.position

				var_534_0.forward = Vector3.New(var_534_7.x, var_534_7.y, var_534_7.z)

				local var_534_8 = var_534_0.localEulerAngles

				var_534_8.z = 0
				var_534_8.x = 0
				var_534_0.localEulerAngles = var_534_8
			end

			local var_534_9 = arg_531_1.actors_["1049ui_story"]
			local var_534_10 = 0

			if var_534_10 < arg_531_1.time_ and arg_531_1.time_ <= var_534_10 + arg_534_0 and not isNil(var_534_9) and arg_531_1.var_.characterEffect1049ui_story == nil then
				arg_531_1.var_.characterEffect1049ui_story = var_534_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_534_11 = 0.200000002980232

			if var_534_10 <= arg_531_1.time_ and arg_531_1.time_ < var_534_10 + var_534_11 and not isNil(var_534_9) then
				local var_534_12 = (arg_531_1.time_ - var_534_10) / var_534_11

				if arg_531_1.var_.characterEffect1049ui_story and not isNil(var_534_9) then
					arg_531_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_531_1.time_ >= var_534_10 + var_534_11 and arg_531_1.time_ < var_534_10 + var_534_11 + arg_534_0 and not isNil(var_534_9) and arg_531_1.var_.characterEffect1049ui_story then
				arg_531_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_534_13 = 0

			if var_534_13 < arg_531_1.time_ and arg_531_1.time_ <= var_534_13 + arg_534_0 then
				arg_531_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_2")
			end

			local var_534_14 = 0

			if var_534_14 < arg_531_1.time_ and arg_531_1.time_ <= var_534_14 + arg_534_0 then
				arg_531_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_534_15 = 0
			local var_534_16 = 0.25

			if var_534_15 < arg_531_1.time_ and arg_531_1.time_ <= var_534_15 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_17 = arg_531_1:FormatText(StoryNameCfg[551].name)

				arg_531_1.leftNameTxt_.text = var_534_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_18 = arg_531_1:GetWordFromCfg(1104901129)
				local var_534_19 = arg_531_1:FormatText(var_534_18.content)

				arg_531_1.text_.text = var_534_19

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_20 = 10
				local var_534_21 = utf8.len(var_534_19)
				local var_534_22 = var_534_20 <= 0 and var_534_16 or var_534_16 * (var_534_21 / var_534_20)

				if var_534_22 > 0 and var_534_16 < var_534_22 then
					arg_531_1.talkMaxDuration = var_534_22

					if var_534_22 + var_534_15 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_22 + var_534_15
					end
				end

				arg_531_1.text_.text = var_534_19
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901129", "story_v_side_new_1104901.awb") ~= 0 then
					local var_534_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901129", "story_v_side_new_1104901.awb") / 1000

					if var_534_23 + var_534_15 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_23 + var_534_15
					end

					if var_534_18.prefab_name ~= "" and arg_531_1.actors_[var_534_18.prefab_name] ~= nil then
						local var_534_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_18.prefab_name].transform, "story_v_side_new_1104901", "1104901129", "story_v_side_new_1104901.awb")

						arg_531_1:RecordAudio("1104901129", var_534_24)
						arg_531_1:RecordAudio("1104901129", var_534_24)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901129", "story_v_side_new_1104901.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901129", "story_v_side_new_1104901.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_25 = math.max(var_534_16, arg_531_1.talkMaxDuration)

			if var_534_15 <= arg_531_1.time_ and arg_531_1.time_ < var_534_15 + var_534_25 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_15) / var_534_25

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_15 + var_534_25 and arg_531_1.time_ < var_534_15 + var_534_25 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play1104901130 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1104901130
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1104901131(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = arg_535_1.actors_["1049ui_story"].transform
			local var_538_1 = 0

			if var_538_1 < arg_535_1.time_ and arg_535_1.time_ <= var_538_1 + arg_538_0 then
				arg_535_1.var_.moveOldPos1049ui_story = var_538_0.localPosition
			end

			local var_538_2 = 0.001

			if var_538_1 <= arg_535_1.time_ and arg_535_1.time_ < var_538_1 + var_538_2 then
				local var_538_3 = (arg_535_1.time_ - var_538_1) / var_538_2
				local var_538_4 = Vector3.New(0, 100, 0)

				var_538_0.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1049ui_story, var_538_4, var_538_3)

				local var_538_5 = manager.ui.mainCamera.transform.position - var_538_0.position

				var_538_0.forward = Vector3.New(var_538_5.x, var_538_5.y, var_538_5.z)

				local var_538_6 = var_538_0.localEulerAngles

				var_538_6.z = 0
				var_538_6.x = 0
				var_538_0.localEulerAngles = var_538_6
			end

			if arg_535_1.time_ >= var_538_1 + var_538_2 and arg_535_1.time_ < var_538_1 + var_538_2 + arg_538_0 then
				var_538_0.localPosition = Vector3.New(0, 100, 0)

				local var_538_7 = manager.ui.mainCamera.transform.position - var_538_0.position

				var_538_0.forward = Vector3.New(var_538_7.x, var_538_7.y, var_538_7.z)

				local var_538_8 = var_538_0.localEulerAngles

				var_538_8.z = 0
				var_538_8.x = 0
				var_538_0.localEulerAngles = var_538_8
			end

			local var_538_9 = arg_535_1.actors_["1049ui_story"]
			local var_538_10 = 0

			if var_538_10 < arg_535_1.time_ and arg_535_1.time_ <= var_538_10 + arg_538_0 and not isNil(var_538_9) and arg_535_1.var_.characterEffect1049ui_story == nil then
				arg_535_1.var_.characterEffect1049ui_story = var_538_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_11 = 0.200000002980232

			if var_538_10 <= arg_535_1.time_ and arg_535_1.time_ < var_538_10 + var_538_11 and not isNil(var_538_9) then
				local var_538_12 = (arg_535_1.time_ - var_538_10) / var_538_11

				if arg_535_1.var_.characterEffect1049ui_story and not isNil(var_538_9) then
					local var_538_13 = Mathf.Lerp(0, 0.5, var_538_12)

					arg_535_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_535_1.var_.characterEffect1049ui_story.fillRatio = var_538_13
				end
			end

			if arg_535_1.time_ >= var_538_10 + var_538_11 and arg_535_1.time_ < var_538_10 + var_538_11 + arg_538_0 and not isNil(var_538_9) and arg_535_1.var_.characterEffect1049ui_story then
				local var_538_14 = 0.5

				arg_535_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_535_1.var_.characterEffect1049ui_story.fillRatio = var_538_14
			end

			local var_538_15 = 0
			local var_538_16 = 0.7

			if var_538_15 < arg_535_1.time_ and arg_535_1.time_ <= var_538_15 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, false)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_17 = arg_535_1:GetWordFromCfg(1104901130)
				local var_538_18 = arg_535_1:FormatText(var_538_17.content)

				arg_535_1.text_.text = var_538_18

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_19 = 29
				local var_538_20 = utf8.len(var_538_18)
				local var_538_21 = var_538_19 <= 0 and var_538_16 or var_538_16 * (var_538_20 / var_538_19)

				if var_538_21 > 0 and var_538_16 < var_538_21 then
					arg_535_1.talkMaxDuration = var_538_21

					if var_538_21 + var_538_15 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_21 + var_538_15
					end
				end

				arg_535_1.text_.text = var_538_18
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_22 = math.max(var_538_16, arg_535_1.talkMaxDuration)

			if var_538_15 <= arg_535_1.time_ and arg_535_1.time_ < var_538_15 + var_538_22 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_15) / var_538_22

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_15 + var_538_22 and arg_535_1.time_ < var_538_15 + var_538_22 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play1104901131 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1104901131
		arg_539_1.duration_ = 3.77

		local var_539_0 = {
			zh = 3.766,
			ja = 3.1
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1104901132(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0
			local var_542_1 = 0.225

			if var_542_0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_2 = arg_539_1:FormatText(StoryNameCfg[1006].name)

				arg_539_1.leftNameTxt_.text = var_542_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_3 = arg_539_1:GetWordFromCfg(1104901131)
				local var_542_4 = arg_539_1:FormatText(var_542_3.content)

				arg_539_1.text_.text = var_542_4

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 9
				local var_542_6 = utf8.len(var_542_4)
				local var_542_7 = var_542_5 <= 0 and var_542_1 or var_542_1 * (var_542_6 / var_542_5)

				if var_542_7 > 0 and var_542_1 < var_542_7 then
					arg_539_1.talkMaxDuration = var_542_7

					if var_542_7 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_7 + var_542_0
					end
				end

				arg_539_1.text_.text = var_542_4
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901131", "story_v_side_new_1104901.awb") ~= 0 then
					local var_542_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901131", "story_v_side_new_1104901.awb") / 1000

					if var_542_8 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_8 + var_542_0
					end

					if var_542_3.prefab_name ~= "" and arg_539_1.actors_[var_542_3.prefab_name] ~= nil then
						local var_542_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_3.prefab_name].transform, "story_v_side_new_1104901", "1104901131", "story_v_side_new_1104901.awb")

						arg_539_1:RecordAudio("1104901131", var_542_9)
						arg_539_1:RecordAudio("1104901131", var_542_9)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901131", "story_v_side_new_1104901.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901131", "story_v_side_new_1104901.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_10 = math.max(var_542_1, arg_539_1.talkMaxDuration)

			if var_542_0 <= arg_539_1.time_ and arg_539_1.time_ < var_542_0 + var_542_10 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_0) / var_542_10

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_0 + var_542_10 and arg_539_1.time_ < var_542_0 + var_542_10 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1104901132 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1104901132
		arg_543_1.duration_ = 2.87

		local var_543_0 = {
			zh = 2.866,
			ja = 1.366
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1104901133(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = arg_543_1.actors_["1049ui_story"].transform
			local var_546_1 = 0

			if var_546_1 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 then
				arg_543_1.var_.moveOldPos1049ui_story = var_546_0.localPosition
			end

			local var_546_2 = 0.001

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_2 then
				local var_546_3 = (arg_543_1.time_ - var_546_1) / var_546_2
				local var_546_4 = Vector3.New(0, -1.2, -6)

				var_546_0.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1049ui_story, var_546_4, var_546_3)

				local var_546_5 = manager.ui.mainCamera.transform.position - var_546_0.position

				var_546_0.forward = Vector3.New(var_546_5.x, var_546_5.y, var_546_5.z)

				local var_546_6 = var_546_0.localEulerAngles

				var_546_6.z = 0
				var_546_6.x = 0
				var_546_0.localEulerAngles = var_546_6
			end

			if arg_543_1.time_ >= var_546_1 + var_546_2 and arg_543_1.time_ < var_546_1 + var_546_2 + arg_546_0 then
				var_546_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_546_7 = manager.ui.mainCamera.transform.position - var_546_0.position

				var_546_0.forward = Vector3.New(var_546_7.x, var_546_7.y, var_546_7.z)

				local var_546_8 = var_546_0.localEulerAngles

				var_546_8.z = 0
				var_546_8.x = 0
				var_546_0.localEulerAngles = var_546_8
			end

			local var_546_9 = arg_543_1.actors_["1049ui_story"]
			local var_546_10 = 0

			if var_546_10 < arg_543_1.time_ and arg_543_1.time_ <= var_546_10 + arg_546_0 and not isNil(var_546_9) and arg_543_1.var_.characterEffect1049ui_story == nil then
				arg_543_1.var_.characterEffect1049ui_story = var_546_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_11 = 0.200000002980232

			if var_546_10 <= arg_543_1.time_ and arg_543_1.time_ < var_546_10 + var_546_11 and not isNil(var_546_9) then
				local var_546_12 = (arg_543_1.time_ - var_546_10) / var_546_11

				if arg_543_1.var_.characterEffect1049ui_story and not isNil(var_546_9) then
					arg_543_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= var_546_10 + var_546_11 and arg_543_1.time_ < var_546_10 + var_546_11 + arg_546_0 and not isNil(var_546_9) and arg_543_1.var_.characterEffect1049ui_story then
				arg_543_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_546_13 = 0

			if var_546_13 < arg_543_1.time_ and arg_543_1.time_ <= var_546_13 + arg_546_0 then
				arg_543_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_546_14 = 0

			if var_546_14 < arg_543_1.time_ and arg_543_1.time_ <= var_546_14 + arg_546_0 then
				arg_543_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_546_15 = 0
			local var_546_16 = 0.25

			if var_546_15 < arg_543_1.time_ and arg_543_1.time_ <= var_546_15 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_17 = arg_543_1:FormatText(StoryNameCfg[551].name)

				arg_543_1.leftNameTxt_.text = var_546_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_18 = arg_543_1:GetWordFromCfg(1104901132)
				local var_546_19 = arg_543_1:FormatText(var_546_18.content)

				arg_543_1.text_.text = var_546_19

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_20 = 10
				local var_546_21 = utf8.len(var_546_19)
				local var_546_22 = var_546_20 <= 0 and var_546_16 or var_546_16 * (var_546_21 / var_546_20)

				if var_546_22 > 0 and var_546_16 < var_546_22 then
					arg_543_1.talkMaxDuration = var_546_22

					if var_546_22 + var_546_15 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_22 + var_546_15
					end
				end

				arg_543_1.text_.text = var_546_19
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901132", "story_v_side_new_1104901.awb") ~= 0 then
					local var_546_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901132", "story_v_side_new_1104901.awb") / 1000

					if var_546_23 + var_546_15 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_23 + var_546_15
					end

					if var_546_18.prefab_name ~= "" and arg_543_1.actors_[var_546_18.prefab_name] ~= nil then
						local var_546_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_18.prefab_name].transform, "story_v_side_new_1104901", "1104901132", "story_v_side_new_1104901.awb")

						arg_543_1:RecordAudio("1104901132", var_546_24)
						arg_543_1:RecordAudio("1104901132", var_546_24)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901132", "story_v_side_new_1104901.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901132", "story_v_side_new_1104901.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_25 = math.max(var_546_16, arg_543_1.talkMaxDuration)

			if var_546_15 <= arg_543_1.time_ and arg_543_1.time_ < var_546_15 + var_546_25 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_15) / var_546_25

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_15 + var_546_25 and arg_543_1.time_ < var_546_15 + var_546_25 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play1104901133 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1104901133
		arg_547_1.duration_ = 6.4

		local var_547_0 = {
			zh = 5.333,
			ja = 6.4
		}
		local var_547_1 = manager.audio:GetLocalizationFlag()

		if var_547_0[var_547_1] ~= nil then
			arg_547_1.duration_ = var_547_0[var_547_1]
		end

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1104901134(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["1049ui_story"]
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.characterEffect1049ui_story == nil then
				arg_547_1.var_.characterEffect1049ui_story = var_550_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_2 = 0.200000002980232

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 and not isNil(var_550_0) then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2

				if arg_547_1.var_.characterEffect1049ui_story and not isNil(var_550_0) then
					local var_550_4 = Mathf.Lerp(0, 0.5, var_550_3)

					arg_547_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_547_1.var_.characterEffect1049ui_story.fillRatio = var_550_4
				end
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.characterEffect1049ui_story then
				local var_550_5 = 0.5

				arg_547_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_547_1.var_.characterEffect1049ui_story.fillRatio = var_550_5
			end

			local var_550_6 = 0
			local var_550_7 = 0.55

			if var_550_6 < arg_547_1.time_ and arg_547_1.time_ <= var_550_6 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_8 = arg_547_1:FormatText(StoryNameCfg[1006].name)

				arg_547_1.leftNameTxt_.text = var_550_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_9 = arg_547_1:GetWordFromCfg(1104901133)
				local var_550_10 = arg_547_1:FormatText(var_550_9.content)

				arg_547_1.text_.text = var_550_10

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_11 = 22
				local var_550_12 = utf8.len(var_550_10)
				local var_550_13 = var_550_11 <= 0 and var_550_7 or var_550_7 * (var_550_12 / var_550_11)

				if var_550_13 > 0 and var_550_7 < var_550_13 then
					arg_547_1.talkMaxDuration = var_550_13

					if var_550_13 + var_550_6 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_13 + var_550_6
					end
				end

				arg_547_1.text_.text = var_550_10
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901133", "story_v_side_new_1104901.awb") ~= 0 then
					local var_550_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901133", "story_v_side_new_1104901.awb") / 1000

					if var_550_14 + var_550_6 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_14 + var_550_6
					end

					if var_550_9.prefab_name ~= "" and arg_547_1.actors_[var_550_9.prefab_name] ~= nil then
						local var_550_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_9.prefab_name].transform, "story_v_side_new_1104901", "1104901133", "story_v_side_new_1104901.awb")

						arg_547_1:RecordAudio("1104901133", var_550_15)
						arg_547_1:RecordAudio("1104901133", var_550_15)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901133", "story_v_side_new_1104901.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901133", "story_v_side_new_1104901.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_16 = math.max(var_550_7, arg_547_1.talkMaxDuration)

			if var_550_6 <= arg_547_1.time_ and arg_547_1.time_ < var_550_6 + var_550_16 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_6) / var_550_16

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_6 + var_550_16 and arg_547_1.time_ < var_550_6 + var_550_16 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1104901134 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1104901134
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1104901135(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = arg_551_1.actors_["1049ui_story"].transform
			local var_554_1 = 0

			if var_554_1 < arg_551_1.time_ and arg_551_1.time_ <= var_554_1 + arg_554_0 then
				arg_551_1.var_.moveOldPos1049ui_story = var_554_0.localPosition
			end

			local var_554_2 = 0.001

			if var_554_1 <= arg_551_1.time_ and arg_551_1.time_ < var_554_1 + var_554_2 then
				local var_554_3 = (arg_551_1.time_ - var_554_1) / var_554_2
				local var_554_4 = Vector3.New(0, 100, 0)

				var_554_0.localPosition = Vector3.Lerp(arg_551_1.var_.moveOldPos1049ui_story, var_554_4, var_554_3)

				local var_554_5 = manager.ui.mainCamera.transform.position - var_554_0.position

				var_554_0.forward = Vector3.New(var_554_5.x, var_554_5.y, var_554_5.z)

				local var_554_6 = var_554_0.localEulerAngles

				var_554_6.z = 0
				var_554_6.x = 0
				var_554_0.localEulerAngles = var_554_6
			end

			if arg_551_1.time_ >= var_554_1 + var_554_2 and arg_551_1.time_ < var_554_1 + var_554_2 + arg_554_0 then
				var_554_0.localPosition = Vector3.New(0, 100, 0)

				local var_554_7 = manager.ui.mainCamera.transform.position - var_554_0.position

				var_554_0.forward = Vector3.New(var_554_7.x, var_554_7.y, var_554_7.z)

				local var_554_8 = var_554_0.localEulerAngles

				var_554_8.z = 0
				var_554_8.x = 0
				var_554_0.localEulerAngles = var_554_8
			end

			local var_554_9 = arg_551_1.actors_["1049ui_story"]
			local var_554_10 = 0

			if var_554_10 < arg_551_1.time_ and arg_551_1.time_ <= var_554_10 + arg_554_0 and not isNil(var_554_9) and arg_551_1.var_.characterEffect1049ui_story == nil then
				arg_551_1.var_.characterEffect1049ui_story = var_554_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_554_11 = 0.200000002980232

			if var_554_10 <= arg_551_1.time_ and arg_551_1.time_ < var_554_10 + var_554_11 and not isNil(var_554_9) then
				local var_554_12 = (arg_551_1.time_ - var_554_10) / var_554_11

				if arg_551_1.var_.characterEffect1049ui_story and not isNil(var_554_9) then
					local var_554_13 = Mathf.Lerp(0, 0.5, var_554_12)

					arg_551_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_551_1.var_.characterEffect1049ui_story.fillRatio = var_554_13
				end
			end

			if arg_551_1.time_ >= var_554_10 + var_554_11 and arg_551_1.time_ < var_554_10 + var_554_11 + arg_554_0 and not isNil(var_554_9) and arg_551_1.var_.characterEffect1049ui_story then
				local var_554_14 = 0.5

				arg_551_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_551_1.var_.characterEffect1049ui_story.fillRatio = var_554_14
			end

			local var_554_15 = 0
			local var_554_16 = 1.125

			if var_554_15 < arg_551_1.time_ and arg_551_1.time_ <= var_554_15 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_17 = arg_551_1:GetWordFromCfg(1104901134)
				local var_554_18 = arg_551_1:FormatText(var_554_17.content)

				arg_551_1.text_.text = var_554_18

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_19 = 57
				local var_554_20 = utf8.len(var_554_18)
				local var_554_21 = var_554_19 <= 0 and var_554_16 or var_554_16 * (var_554_20 / var_554_19)

				if var_554_21 > 0 and var_554_16 < var_554_21 then
					arg_551_1.talkMaxDuration = var_554_21

					if var_554_21 + var_554_15 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_21 + var_554_15
					end
				end

				arg_551_1.text_.text = var_554_18
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_22 = math.max(var_554_16, arg_551_1.talkMaxDuration)

			if var_554_15 <= arg_551_1.time_ and arg_551_1.time_ < var_554_15 + var_554_22 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_15) / var_554_22

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_15 + var_554_22 and arg_551_1.time_ < var_554_15 + var_554_22 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_551_1:InitPlayNodeList()
	end,
	Play1104901135 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1104901135
		arg_555_1.duration_ = 3.23

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1104901136(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 1.23333333333333

			if var_558_0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_0 + arg_558_0 then
				arg_555_1.fswbg_:SetActive(true)
				arg_555_1.dialog_:SetActive(false)

				arg_555_1.fswtw_.percent = 0

				local var_558_1 = arg_555_1:GetWordFromCfg(1104901135)
				local var_558_2 = arg_555_1:FormatText(var_558_1.content)

				arg_555_1.fswt_.text = var_558_2

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.fswt_)

				arg_555_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_555_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_555_1.fswtw_:SetDirty()

				arg_555_1.typewritterCharCountI18N = 0

				SetActive(arg_555_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_555_1:ShowNextGo(false)
			end

			local var_558_3 = 2

			if var_558_3 < arg_555_1.time_ and arg_555_1.time_ <= var_558_3 + arg_558_0 then
				arg_555_1.var_.oldValueTypewriter = arg_555_1.fswtw_.percent

				SetActive(arg_555_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_555_1:ShowNextGo(false)
			end

			local var_558_4 = 9
			local var_558_5 = 0.9
			local var_558_6 = arg_555_1:GetWordFromCfg(1104901135)
			local var_558_7 = arg_555_1:FormatText(var_558_6.content)
			local var_558_8, var_558_9 = arg_555_1:GetPercentByPara(var_558_7, 1)

			if var_558_3 < arg_555_1.time_ and arg_555_1.time_ <= var_558_3 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0

				local var_558_10 = var_558_4 <= 0 and var_558_5 or var_558_5 * ((var_558_9 - arg_555_1.typewritterCharCountI18N) / var_558_4)

				if var_558_10 > 0 and var_558_5 < var_558_10 then
					arg_555_1.talkMaxDuration = var_558_10

					if var_558_10 + var_558_3 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_10 + var_558_3
					end
				end
			end

			local var_558_11 = 0.9
			local var_558_12 = math.max(var_558_11, arg_555_1.talkMaxDuration)

			if var_558_3 <= arg_555_1.time_ and arg_555_1.time_ < var_558_3 + var_558_12 then
				local var_558_13 = (arg_555_1.time_ - var_558_3) / var_558_12

				arg_555_1.fswtw_.percent = Mathf.Lerp(arg_555_1.var_.oldValueTypewriter, var_558_8, var_558_13)
				arg_555_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_555_1.fswtw_:SetDirty()
			end

			if arg_555_1.time_ >= var_558_3 + var_558_12 and arg_555_1.time_ < var_558_3 + var_558_12 + arg_558_0 then
				arg_555_1.fswtw_.percent = var_558_8

				arg_555_1.fswtw_:SetDirty()
				arg_555_1:ShowNextGo(true)

				arg_555_1.typewritterCharCountI18N = var_558_9
			end

			local var_558_14 = "STblack"

			if arg_555_1.bgs_[var_558_14] == nil then
				local var_558_15 = Object.Instantiate(arg_555_1.paintGo_)

				var_558_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_558_14)
				var_558_15.name = var_558_14
				var_558_15.transform.parent = arg_555_1.stage_.transform
				var_558_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_555_1.bgs_[var_558_14] = var_558_15
			end

			local var_558_16 = 1.23333333333333

			if var_558_16 < arg_555_1.time_ and arg_555_1.time_ <= var_558_16 + arg_558_0 then
				local var_558_17 = manager.ui.mainCamera.transform.localPosition
				local var_558_18 = Vector3.New(0, 0, 10) + Vector3.New(var_558_17.x, var_558_17.y, 0)
				local var_558_19 = arg_555_1.bgs_.STblack

				var_558_19.transform.localPosition = var_558_18
				var_558_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_558_20 = var_558_19:GetComponent("SpriteRenderer")

				if var_558_20 and var_558_20.sprite then
					local var_558_21 = (var_558_19.transform.localPosition - var_558_17).z
					local var_558_22 = manager.ui.mainCameraCom_
					local var_558_23 = 2 * var_558_21 * Mathf.Tan(var_558_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_558_24 = var_558_23 * var_558_22.aspect
					local var_558_25 = var_558_20.sprite.bounds.size.x
					local var_558_26 = var_558_20.sprite.bounds.size.y
					local var_558_27 = var_558_24 / var_558_25
					local var_558_28 = var_558_23 / var_558_26
					local var_558_29 = var_558_28 < var_558_27 and var_558_27 or var_558_28

					var_558_19.transform.localScale = Vector3.New(var_558_29, var_558_29, 0)
				end

				for iter_558_0, iter_558_1 in pairs(arg_555_1.bgs_) do
					if iter_558_0 ~= "STblack" then
						iter_558_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_558_30 = 1.25

			if var_558_30 < arg_555_1.time_ and arg_555_1.time_ <= var_558_30 + arg_558_0 then
				local var_558_31 = arg_555_1.fswbg_.transform:Find("textbox/adapt/content") or arg_555_1.fswbg_.transform:Find("textbox/content")
				local var_558_32 = arg_555_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_558_33 = var_558_31:GetComponent("Text")
				local var_558_34 = var_558_31:GetComponent("RectTransform")

				var_558_33.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_558_34.offsetMin = Vector2.New(0, -80)
				var_558_34.offsetMax = Vector2.New(0, 0)
			end

			local var_558_35 = 0

			if var_558_35 < arg_555_1.time_ and arg_555_1.time_ <= var_558_35 + arg_558_0 then
				arg_555_1.mask_.enabled = true
				arg_555_1.mask_.raycastTarget = true

				arg_555_1:SetGaussion(false)
			end

			local var_558_36 = 1.23333333333333

			if var_558_35 <= arg_555_1.time_ and arg_555_1.time_ < var_558_35 + var_558_36 then
				local var_558_37 = (arg_555_1.time_ - var_558_35) / var_558_36
				local var_558_38 = Color.New(0.009433985, 0.009433985, 0.009433985)

				var_558_38.a = Mathf.Lerp(0, 1, var_558_37)
				arg_555_1.mask_.color = var_558_38
			end

			if arg_555_1.time_ >= var_558_35 + var_558_36 and arg_555_1.time_ < var_558_35 + var_558_36 + arg_558_0 then
				local var_558_39 = Color.New(0.009433985, 0.009433985, 0.009433985)

				var_558_39.a = 1
				arg_555_1.mask_.color = var_558_39
			end

			local var_558_40 = 1.23333333333333

			if var_558_40 < arg_555_1.time_ and arg_555_1.time_ <= var_558_40 + arg_558_0 then
				arg_555_1.mask_.enabled = true
				arg_555_1.mask_.raycastTarget = true

				arg_555_1:SetGaussion(false)
			end

			local var_558_41 = 1.23333333333333

			if var_558_40 <= arg_555_1.time_ and arg_555_1.time_ < var_558_40 + var_558_41 then
				local var_558_42 = (arg_555_1.time_ - var_558_40) / var_558_41
				local var_558_43 = Color.New(0.009433985, 0.009433985, 0.009433985)

				var_558_43.a = Mathf.Lerp(1, 0, var_558_42)
				arg_555_1.mask_.color = var_558_43
			end

			if arg_555_1.time_ >= var_558_40 + var_558_41 and arg_555_1.time_ < var_558_40 + var_558_41 + arg_558_0 then
				local var_558_44 = Color.New(0.009433985, 0.009433985, 0.009433985)
				local var_558_45 = 0

				arg_555_1.mask_.enabled = false
				var_558_44.a = var_558_45
				arg_555_1.mask_.color = var_558_44
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1104901136 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1104901136
		arg_559_1.duration_ = 7.2

		local var_559_0 = {
			zh = 7.19966667262713,
			ja = 5.83266667262713
		}
		local var_559_1 = manager.audio:GetLocalizationFlag()

		if var_559_0[var_559_1] ~= nil then
			arg_559_1.duration_ = var_559_0[var_559_1]
		end

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1104901137(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 2.8666666696469

			if var_562_0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_0 + arg_562_0 then
				arg_559_1.allBtn_.enabled = false
			end

			local var_562_1 = 0.3

			if arg_559_1.time_ >= var_562_0 + var_562_1 and arg_559_1.time_ < var_562_0 + var_562_1 + arg_562_0 then
				arg_559_1.allBtn_.enabled = true
			end

			local var_562_2 = "ST05a"

			if arg_559_1.bgs_[var_562_2] == nil then
				local var_562_3 = Object.Instantiate(arg_559_1.paintGo_)

				var_562_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_562_2)
				var_562_3.name = var_562_2
				var_562_3.transform.parent = arg_559_1.stage_.transform
				var_562_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_559_1.bgs_[var_562_2] = var_562_3
			end

			local var_562_4 = 1.43266666481892

			if var_562_4 < arg_559_1.time_ and arg_559_1.time_ <= var_562_4 + arg_562_0 then
				local var_562_5 = manager.ui.mainCamera.transform.localPosition
				local var_562_6 = Vector3.New(0, 0, 10) + Vector3.New(var_562_5.x, var_562_5.y, 0)
				local var_562_7 = arg_559_1.bgs_.ST05a

				var_562_7.transform.localPosition = var_562_6
				var_562_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_562_8 = var_562_7:GetComponent("SpriteRenderer")

				if var_562_8 and var_562_8.sprite then
					local var_562_9 = (var_562_7.transform.localPosition - var_562_5).z
					local var_562_10 = manager.ui.mainCameraCom_
					local var_562_11 = 2 * var_562_9 * Mathf.Tan(var_562_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_562_12 = var_562_11 * var_562_10.aspect
					local var_562_13 = var_562_8.sprite.bounds.size.x
					local var_562_14 = var_562_8.sprite.bounds.size.y
					local var_562_15 = var_562_12 / var_562_13
					local var_562_16 = var_562_11 / var_562_14
					local var_562_17 = var_562_16 < var_562_15 and var_562_15 or var_562_16

					var_562_7.transform.localScale = Vector3.New(var_562_17, var_562_17, 0)
				end

				for iter_562_0, iter_562_1 in pairs(arg_559_1.bgs_) do
					if iter_562_0 ~= "ST05a" then
						iter_562_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_562_18 = 0

			if var_562_18 < arg_559_1.time_ and arg_559_1.time_ <= var_562_18 + arg_562_0 then
				arg_559_1.mask_.enabled = true
				arg_559_1.mask_.raycastTarget = true

				arg_559_1:SetGaussion(false)
			end

			local var_562_19 = 1.43266666481892

			if var_562_18 <= arg_559_1.time_ and arg_559_1.time_ < var_562_18 + var_562_19 then
				local var_562_20 = (arg_559_1.time_ - var_562_18) / var_562_19
				local var_562_21 = Color.New(0, 0, 0)

				var_562_21.a = Mathf.Lerp(0, 1, var_562_20)
				arg_559_1.mask_.color = var_562_21
			end

			if arg_559_1.time_ >= var_562_18 + var_562_19 and arg_559_1.time_ < var_562_18 + var_562_19 + arg_562_0 then
				local var_562_22 = Color.New(0, 0, 0)

				var_562_22.a = 1
				arg_559_1.mask_.color = var_562_22
			end

			local var_562_23 = 1.43266666481892

			if var_562_23 < arg_559_1.time_ and arg_559_1.time_ <= var_562_23 + arg_562_0 then
				arg_559_1.mask_.enabled = true
				arg_559_1.mask_.raycastTarget = true

				arg_559_1:SetGaussion(false)
			end

			local var_562_24 = 2.56733333518108

			if var_562_23 <= arg_559_1.time_ and arg_559_1.time_ < var_562_23 + var_562_24 then
				local var_562_25 = (arg_559_1.time_ - var_562_23) / var_562_24
				local var_562_26 = Color.New(0, 0, 0)

				var_562_26.a = Mathf.Lerp(1, 0, var_562_25)
				arg_559_1.mask_.color = var_562_26
			end

			if arg_559_1.time_ >= var_562_23 + var_562_24 and arg_559_1.time_ < var_562_23 + var_562_24 + arg_562_0 then
				local var_562_27 = Color.New(0, 0, 0)
				local var_562_28 = 0

				arg_559_1.mask_.enabled = false
				var_562_27.a = var_562_28
				arg_559_1.mask_.color = var_562_27
			end

			local var_562_29 = arg_559_1.actors_["1049ui_story"].transform
			local var_562_30 = 2.66666666666667

			if var_562_30 < arg_559_1.time_ and arg_559_1.time_ <= var_562_30 + arg_562_0 then
				arg_559_1.var_.moveOldPos1049ui_story = var_562_29.localPosition
			end

			local var_562_31 = 0.001

			if var_562_30 <= arg_559_1.time_ and arg_559_1.time_ < var_562_30 + var_562_31 then
				local var_562_32 = (arg_559_1.time_ - var_562_30) / var_562_31
				local var_562_33 = Vector3.New(0, -1.2, -6)

				var_562_29.localPosition = Vector3.Lerp(arg_559_1.var_.moveOldPos1049ui_story, var_562_33, var_562_32)

				local var_562_34 = manager.ui.mainCamera.transform.position - var_562_29.position

				var_562_29.forward = Vector3.New(var_562_34.x, var_562_34.y, var_562_34.z)

				local var_562_35 = var_562_29.localEulerAngles

				var_562_35.z = 0
				var_562_35.x = 0
				var_562_29.localEulerAngles = var_562_35
			end

			if arg_559_1.time_ >= var_562_30 + var_562_31 and arg_559_1.time_ < var_562_30 + var_562_31 + arg_562_0 then
				var_562_29.localPosition = Vector3.New(0, -1.2, -6)

				local var_562_36 = manager.ui.mainCamera.transform.position - var_562_29.position

				var_562_29.forward = Vector3.New(var_562_36.x, var_562_36.y, var_562_36.z)

				local var_562_37 = var_562_29.localEulerAngles

				var_562_37.z = 0
				var_562_37.x = 0
				var_562_29.localEulerAngles = var_562_37
			end

			local var_562_38 = arg_559_1.actors_["1049ui_story"]
			local var_562_39 = 2.66666666666667

			if var_562_39 < arg_559_1.time_ and arg_559_1.time_ <= var_562_39 + arg_562_0 and not isNil(var_562_38) and arg_559_1.var_.characterEffect1049ui_story == nil then
				arg_559_1.var_.characterEffect1049ui_story = var_562_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_562_40 = 0.200000002980232

			if var_562_39 <= arg_559_1.time_ and arg_559_1.time_ < var_562_39 + var_562_40 and not isNil(var_562_38) then
				local var_562_41 = (arg_559_1.time_ - var_562_39) / var_562_40

				if arg_559_1.var_.characterEffect1049ui_story and not isNil(var_562_38) then
					arg_559_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_559_1.time_ >= var_562_39 + var_562_40 and arg_559_1.time_ < var_562_39 + var_562_40 + arg_562_0 and not isNil(var_562_38) and arg_559_1.var_.characterEffect1049ui_story then
				arg_559_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_562_42 = 2.66666666666667

			if var_562_42 < arg_559_1.time_ and arg_559_1.time_ <= var_562_42 + arg_562_0 then
				arg_559_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_562_43 = arg_559_1.actors_["1049ui_story"].transform
			local var_562_44 = 1.39866666297118

			if var_562_44 < arg_559_1.time_ and arg_559_1.time_ <= var_562_44 + arg_562_0 then
				arg_559_1.var_.moveOldPos1049ui_story = var_562_43.localPosition
			end

			local var_562_45 = 0.001

			if var_562_44 <= arg_559_1.time_ and arg_559_1.time_ < var_562_44 + var_562_45 then
				local var_562_46 = (arg_559_1.time_ - var_562_44) / var_562_45
				local var_562_47 = Vector3.New(0, 100, 0)

				var_562_43.localPosition = Vector3.Lerp(arg_559_1.var_.moveOldPos1049ui_story, var_562_47, var_562_46)

				local var_562_48 = manager.ui.mainCamera.transform.position - var_562_43.position

				var_562_43.forward = Vector3.New(var_562_48.x, var_562_48.y, var_562_48.z)

				local var_562_49 = var_562_43.localEulerAngles

				var_562_49.z = 0
				var_562_49.x = 0
				var_562_43.localEulerAngles = var_562_49
			end

			if arg_559_1.time_ >= var_562_44 + var_562_45 and arg_559_1.time_ < var_562_44 + var_562_45 + arg_562_0 then
				var_562_43.localPosition = Vector3.New(0, 100, 0)

				local var_562_50 = manager.ui.mainCamera.transform.position - var_562_43.position

				var_562_43.forward = Vector3.New(var_562_50.x, var_562_50.y, var_562_50.z)

				local var_562_51 = var_562_43.localEulerAngles

				var_562_51.z = 0
				var_562_51.x = 0
				var_562_43.localEulerAngles = var_562_51
			end

			local var_562_52 = 2.66666666666667

			if var_562_52 < arg_559_1.time_ and arg_559_1.time_ <= var_562_52 + arg_562_0 then
				arg_559_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_562_53 = 1.43266666481892

			if var_562_53 < arg_559_1.time_ and arg_559_1.time_ <= var_562_53 + arg_562_0 then
				arg_559_1.fswbg_:SetActive(false)
				arg_559_1.dialog_:SetActive(false)
				SetActive(arg_559_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_559_1:ShowNextGo(false)
			end

			local var_562_54 = 1.43266666481892

			if var_562_54 < arg_559_1.time_ and arg_559_1.time_ <= var_562_54 + arg_562_0 then
				arg_559_1.fswbg_:SetActive(false)
				arg_559_1.dialog_:SetActive(false)
				SetActive(arg_559_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_559_1:ShowNextGo(false)
			end

			if arg_559_1.frameCnt_ <= 1 then
				arg_559_1.dialog_:SetActive(false)
			end

			local var_562_55 = 2.86666667262713
			local var_562_56 = 0.325

			if var_562_55 < arg_559_1.time_ and arg_559_1.time_ <= var_562_55 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0

				arg_559_1.dialog_:SetActive(true)

				arg_559_1.dialogCg_.alpha = 0

				local var_562_57 = LeanTween.value(arg_559_1.dialog_, 0, 1, 0.3)

				var_562_57:setOnUpdate(LuaHelper.FloatAction(function(arg_563_0)
					arg_559_1.dialogCg_.alpha = arg_563_0
				end))
				var_562_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_559_1.dialog_)
					var_562_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_559_1.duration_ = arg_559_1.duration_ + 0.3

				SetActive(arg_559_1.leftNameGo_, true)

				local var_562_58 = arg_559_1:FormatText(StoryNameCfg[551].name)

				arg_559_1.leftNameTxt_.text = var_562_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_59 = arg_559_1:GetWordFromCfg(1104901136)
				local var_562_60 = arg_559_1:FormatText(var_562_59.content)

				arg_559_1.text_.text = var_562_60

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_61 = 13
				local var_562_62 = utf8.len(var_562_60)
				local var_562_63 = var_562_61 <= 0 and var_562_56 or var_562_56 * (var_562_62 / var_562_61)

				if var_562_63 > 0 and var_562_56 < var_562_63 then
					arg_559_1.talkMaxDuration = var_562_63
					var_562_55 = var_562_55 + 0.3

					if var_562_63 + var_562_55 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_63 + var_562_55
					end
				end

				arg_559_1.text_.text = var_562_60
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901136", "story_v_side_new_1104901.awb") ~= 0 then
					local var_562_64 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901136", "story_v_side_new_1104901.awb") / 1000

					if var_562_64 + var_562_55 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_64 + var_562_55
					end

					if var_562_59.prefab_name ~= "" and arg_559_1.actors_[var_562_59.prefab_name] ~= nil then
						local var_562_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_559_1.actors_[var_562_59.prefab_name].transform, "story_v_side_new_1104901", "1104901136", "story_v_side_new_1104901.awb")

						arg_559_1:RecordAudio("1104901136", var_562_65)
						arg_559_1:RecordAudio("1104901136", var_562_65)
					else
						arg_559_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901136", "story_v_side_new_1104901.awb")
					end

					arg_559_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901136", "story_v_side_new_1104901.awb")
				end

				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_66 = var_562_55 + 0.3
			local var_562_67 = math.max(var_562_56, arg_559_1.talkMaxDuration)

			if var_562_66 <= arg_559_1.time_ and arg_559_1.time_ < var_562_66 + var_562_67 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_66) / var_562_67

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_66 + var_562_67 and arg_559_1.time_ < var_562_66 + var_562_67 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.39866666297118,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_559_1:InitPlayNodeList()
	end,
	Play1104901137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 1104901137
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play1104901138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = arg_565_1.actors_["1049ui_story"].transform
			local var_568_1 = 0

			if var_568_1 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 then
				arg_565_1.var_.moveOldPos1049ui_story = var_568_0.localPosition
			end

			local var_568_2 = 0.001

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_2 then
				local var_568_3 = (arg_565_1.time_ - var_568_1) / var_568_2
				local var_568_4 = Vector3.New(0, 100, 0)

				var_568_0.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1049ui_story, var_568_4, var_568_3)

				local var_568_5 = manager.ui.mainCamera.transform.position - var_568_0.position

				var_568_0.forward = Vector3.New(var_568_5.x, var_568_5.y, var_568_5.z)

				local var_568_6 = var_568_0.localEulerAngles

				var_568_6.z = 0
				var_568_6.x = 0
				var_568_0.localEulerAngles = var_568_6
			end

			if arg_565_1.time_ >= var_568_1 + var_568_2 and arg_565_1.time_ < var_568_1 + var_568_2 + arg_568_0 then
				var_568_0.localPosition = Vector3.New(0, 100, 0)

				local var_568_7 = manager.ui.mainCamera.transform.position - var_568_0.position

				var_568_0.forward = Vector3.New(var_568_7.x, var_568_7.y, var_568_7.z)

				local var_568_8 = var_568_0.localEulerAngles

				var_568_8.z = 0
				var_568_8.x = 0
				var_568_0.localEulerAngles = var_568_8
			end

			local var_568_9 = arg_565_1.actors_["1049ui_story"]
			local var_568_10 = 0

			if var_568_10 < arg_565_1.time_ and arg_565_1.time_ <= var_568_10 + arg_568_0 and not isNil(var_568_9) and arg_565_1.var_.characterEffect1049ui_story == nil then
				arg_565_1.var_.characterEffect1049ui_story = var_568_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_11 = 0.200000002980232

			if var_568_10 <= arg_565_1.time_ and arg_565_1.time_ < var_568_10 + var_568_11 and not isNil(var_568_9) then
				local var_568_12 = (arg_565_1.time_ - var_568_10) / var_568_11

				if arg_565_1.var_.characterEffect1049ui_story and not isNil(var_568_9) then
					local var_568_13 = Mathf.Lerp(0, 0.5, var_568_12)

					arg_565_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1049ui_story.fillRatio = var_568_13
				end
			end

			if arg_565_1.time_ >= var_568_10 + var_568_11 and arg_565_1.time_ < var_568_10 + var_568_11 + arg_568_0 and not isNil(var_568_9) and arg_565_1.var_.characterEffect1049ui_story then
				local var_568_14 = 0.5

				arg_565_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1049ui_story.fillRatio = var_568_14
			end

			local var_568_15 = 0
			local var_568_16 = 0.625

			if var_568_15 < arg_565_1.time_ and arg_565_1.time_ <= var_568_15 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, false)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_17 = arg_565_1:GetWordFromCfg(1104901137)
				local var_568_18 = arg_565_1:FormatText(var_568_17.content)

				arg_565_1.text_.text = var_568_18

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_19 = 25
				local var_568_20 = utf8.len(var_568_18)
				local var_568_21 = var_568_19 <= 0 and var_568_16 or var_568_16 * (var_568_20 / var_568_19)

				if var_568_21 > 0 and var_568_16 < var_568_21 then
					arg_565_1.talkMaxDuration = var_568_21

					if var_568_21 + var_568_15 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_21 + var_568_15
					end
				end

				arg_565_1.text_.text = var_568_18
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_22 = math.max(var_568_16, arg_565_1.talkMaxDuration)

			if var_568_15 <= arg_565_1.time_ and arg_565_1.time_ < var_568_15 + var_568_22 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_15) / var_568_22

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_15 + var_568_22 and arg_565_1.time_ < var_568_15 + var_568_22 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_565_1:InitPlayNodeList()
	end,
	Play1104901138 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 1104901138
		arg_569_1.duration_ = 7.1

		local var_569_0 = {
			zh = 5.2,
			ja = 7.1
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play1104901139(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = 0
			local var_572_1 = 0.725

			if var_572_0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_0 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_2 = arg_569_1:FormatText(StoryNameCfg[394].name)

				arg_569_1.leftNameTxt_.text = var_572_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, true)
				arg_569_1.iconController_:SetSelectedState("hero")

				arg_569_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_569_1.callingController_:SetSelectedState("normal")

				arg_569_1.keyicon_.color = Color.New(1, 1, 1)
				arg_569_1.icon_.color = Color.New(1, 1, 1)

				local var_572_3 = arg_569_1:GetWordFromCfg(1104901138)
				local var_572_4 = arg_569_1:FormatText(var_572_3.content)

				arg_569_1.text_.text = var_572_4

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_5 = 29
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901138", "story_v_side_new_1104901.awb") ~= 0 then
					local var_572_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901138", "story_v_side_new_1104901.awb") / 1000

					if var_572_8 + var_572_0 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_8 + var_572_0
					end

					if var_572_3.prefab_name ~= "" and arg_569_1.actors_[var_572_3.prefab_name] ~= nil then
						local var_572_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_3.prefab_name].transform, "story_v_side_new_1104901", "1104901138", "story_v_side_new_1104901.awb")

						arg_569_1:RecordAudio("1104901138", var_572_9)
						arg_569_1:RecordAudio("1104901138", var_572_9)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901138", "story_v_side_new_1104901.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901138", "story_v_side_new_1104901.awb")
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
	Play1104901139 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 1104901139
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play1104901140(arg_573_1)
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

				arg_573_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_573_1.callingController_:SetSelectedState("normal")

				arg_573_1.keyicon_.color = Color.New(1, 1, 1)
				arg_573_1.icon_.color = Color.New(1, 1, 1)

				local var_576_3 = arg_573_1:GetWordFromCfg(1104901139)
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
	Play1104901140 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 1104901140
		arg_577_1.duration_ = 4.1

		local var_577_0 = {
			zh = 2.066,
			ja = 4.1
		}
		local var_577_1 = manager.audio:GetLocalizationFlag()

		if var_577_0[var_577_1] ~= nil then
			arg_577_1.duration_ = var_577_0[var_577_1]
		end

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play1104901141(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = arg_577_1.actors_["1049ui_story"].transform
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 then
				arg_577_1.var_.moveOldPos1049ui_story = var_580_0.localPosition
			end

			local var_580_2 = 0.001

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_2 then
				local var_580_3 = (arg_577_1.time_ - var_580_1) / var_580_2
				local var_580_4 = Vector3.New(0, -1.2, -6)

				var_580_0.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos1049ui_story, var_580_4, var_580_3)

				local var_580_5 = manager.ui.mainCamera.transform.position - var_580_0.position

				var_580_0.forward = Vector3.New(var_580_5.x, var_580_5.y, var_580_5.z)

				local var_580_6 = var_580_0.localEulerAngles

				var_580_6.z = 0
				var_580_6.x = 0
				var_580_0.localEulerAngles = var_580_6
			end

			if arg_577_1.time_ >= var_580_1 + var_580_2 and arg_577_1.time_ < var_580_1 + var_580_2 + arg_580_0 then
				var_580_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_580_7 = manager.ui.mainCamera.transform.position - var_580_0.position

				var_580_0.forward = Vector3.New(var_580_7.x, var_580_7.y, var_580_7.z)

				local var_580_8 = var_580_0.localEulerAngles

				var_580_8.z = 0
				var_580_8.x = 0
				var_580_0.localEulerAngles = var_580_8
			end

			local var_580_9 = arg_577_1.actors_["1049ui_story"]
			local var_580_10 = 0

			if var_580_10 < arg_577_1.time_ and arg_577_1.time_ <= var_580_10 + arg_580_0 and not isNil(var_580_9) and arg_577_1.var_.characterEffect1049ui_story == nil then
				arg_577_1.var_.characterEffect1049ui_story = var_580_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_11 = 0.200000002980232

			if var_580_10 <= arg_577_1.time_ and arg_577_1.time_ < var_580_10 + var_580_11 and not isNil(var_580_9) then
				local var_580_12 = (arg_577_1.time_ - var_580_10) / var_580_11

				if arg_577_1.var_.characterEffect1049ui_story and not isNil(var_580_9) then
					arg_577_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_577_1.time_ >= var_580_10 + var_580_11 and arg_577_1.time_ < var_580_10 + var_580_11 + arg_580_0 and not isNil(var_580_9) and arg_577_1.var_.characterEffect1049ui_story then
				arg_577_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_580_13 = 0

			if var_580_13 < arg_577_1.time_ and arg_577_1.time_ <= var_580_13 + arg_580_0 then
				arg_577_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_580_14 = 0

			if var_580_14 < arg_577_1.time_ and arg_577_1.time_ <= var_580_14 + arg_580_0 then
				arg_577_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_580_15 = 0
			local var_580_16 = 0.225

			if var_580_15 < arg_577_1.time_ and arg_577_1.time_ <= var_580_15 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				local var_580_17 = arg_577_1:FormatText(StoryNameCfg[551].name)

				arg_577_1.leftNameTxt_.text = var_580_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_18 = arg_577_1:GetWordFromCfg(1104901140)
				local var_580_19 = arg_577_1:FormatText(var_580_18.content)

				arg_577_1.text_.text = var_580_19

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_20 = 9
				local var_580_21 = utf8.len(var_580_19)
				local var_580_22 = var_580_20 <= 0 and var_580_16 or var_580_16 * (var_580_21 / var_580_20)

				if var_580_22 > 0 and var_580_16 < var_580_22 then
					arg_577_1.talkMaxDuration = var_580_22

					if var_580_22 + var_580_15 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_22 + var_580_15
					end
				end

				arg_577_1.text_.text = var_580_19
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901140", "story_v_side_new_1104901.awb") ~= 0 then
					local var_580_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901140", "story_v_side_new_1104901.awb") / 1000

					if var_580_23 + var_580_15 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_23 + var_580_15
					end

					if var_580_18.prefab_name ~= "" and arg_577_1.actors_[var_580_18.prefab_name] ~= nil then
						local var_580_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_577_1.actors_[var_580_18.prefab_name].transform, "story_v_side_new_1104901", "1104901140", "story_v_side_new_1104901.awb")

						arg_577_1:RecordAudio("1104901140", var_580_24)
						arg_577_1:RecordAudio("1104901140", var_580_24)
					else
						arg_577_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901140", "story_v_side_new_1104901.awb")
					end

					arg_577_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901140", "story_v_side_new_1104901.awb")
				end

				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_25 = math.max(var_580_16, arg_577_1.talkMaxDuration)

			if var_580_15 <= arg_577_1.time_ and arg_577_1.time_ < var_580_15 + var_580_25 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_15) / var_580_25

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_15 + var_580_25 and arg_577_1.time_ < var_580_15 + var_580_25 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_577_1:InitPlayNodeList()
	end,
	Play1104901141 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 1104901141
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play1104901142(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = arg_581_1.actors_["1049ui_story"]
			local var_584_1 = 0

			if var_584_1 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 and not isNil(var_584_0) and arg_581_1.var_.characterEffect1049ui_story == nil then
				arg_581_1.var_.characterEffect1049ui_story = var_584_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_2 = 0.200000002980232

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_2 and not isNil(var_584_0) then
				local var_584_3 = (arg_581_1.time_ - var_584_1) / var_584_2

				if arg_581_1.var_.characterEffect1049ui_story and not isNil(var_584_0) then
					local var_584_4 = Mathf.Lerp(0, 0.5, var_584_3)

					arg_581_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_581_1.var_.characterEffect1049ui_story.fillRatio = var_584_4
				end
			end

			if arg_581_1.time_ >= var_584_1 + var_584_2 and arg_581_1.time_ < var_584_1 + var_584_2 + arg_584_0 and not isNil(var_584_0) and arg_581_1.var_.characterEffect1049ui_story then
				local var_584_5 = 0.5

				arg_581_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_581_1.var_.characterEffect1049ui_story.fillRatio = var_584_5
			end

			local var_584_6 = 0
			local var_584_7 = 0.15

			if var_584_6 < arg_581_1.time_ and arg_581_1.time_ <= var_584_6 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_8 = arg_581_1:FormatText(StoryNameCfg[7].name)

				arg_581_1.leftNameTxt_.text = var_584_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, true)
				arg_581_1.iconController_:SetSelectedState("hero")

				arg_581_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_581_1.callingController_:SetSelectedState("normal")

				arg_581_1.keyicon_.color = Color.New(1, 1, 1)
				arg_581_1.icon_.color = Color.New(1, 1, 1)

				local var_584_9 = arg_581_1:GetWordFromCfg(1104901141)
				local var_584_10 = arg_581_1:FormatText(var_584_9.content)

				arg_581_1.text_.text = var_584_10

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_11 = 6
				local var_584_12 = utf8.len(var_584_10)
				local var_584_13 = var_584_11 <= 0 and var_584_7 or var_584_7 * (var_584_12 / var_584_11)

				if var_584_13 > 0 and var_584_7 < var_584_13 then
					arg_581_1.talkMaxDuration = var_584_13

					if var_584_13 + var_584_6 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_13 + var_584_6
					end
				end

				arg_581_1.text_.text = var_584_10
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_14 = math.max(var_584_7, arg_581_1.talkMaxDuration)

			if var_584_6 <= arg_581_1.time_ and arg_581_1.time_ < var_584_6 + var_584_14 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_6) / var_584_14

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_6 + var_584_14 and arg_581_1.time_ < var_584_6 + var_584_14 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play1104901142 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 1104901142
		arg_585_1.duration_ = 3.7

		local var_585_0 = {
			zh = 1.999999999999,
			ja = 3.7
		}
		local var_585_1 = manager.audio:GetLocalizationFlag()

		if var_585_0[var_585_1] ~= nil then
			arg_585_1.duration_ = var_585_0[var_585_1]
		end

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play1104901143(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = arg_585_1.actors_["1049ui_story"].transform
			local var_588_1 = 0

			if var_588_1 < arg_585_1.time_ and arg_585_1.time_ <= var_588_1 + arg_588_0 then
				arg_585_1.var_.moveOldPos1049ui_story = var_588_0.localPosition
			end

			local var_588_2 = 0.001

			if var_588_1 <= arg_585_1.time_ and arg_585_1.time_ < var_588_1 + var_588_2 then
				local var_588_3 = (arg_585_1.time_ - var_588_1) / var_588_2
				local var_588_4 = Vector3.New(0, -1.2, -6)

				var_588_0.localPosition = Vector3.Lerp(arg_585_1.var_.moveOldPos1049ui_story, var_588_4, var_588_3)

				local var_588_5 = manager.ui.mainCamera.transform.position - var_588_0.position

				var_588_0.forward = Vector3.New(var_588_5.x, var_588_5.y, var_588_5.z)

				local var_588_6 = var_588_0.localEulerAngles

				var_588_6.z = 0
				var_588_6.x = 0
				var_588_0.localEulerAngles = var_588_6
			end

			if arg_585_1.time_ >= var_588_1 + var_588_2 and arg_585_1.time_ < var_588_1 + var_588_2 + arg_588_0 then
				var_588_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_588_7 = manager.ui.mainCamera.transform.position - var_588_0.position

				var_588_0.forward = Vector3.New(var_588_7.x, var_588_7.y, var_588_7.z)

				local var_588_8 = var_588_0.localEulerAngles

				var_588_8.z = 0
				var_588_8.x = 0
				var_588_0.localEulerAngles = var_588_8
			end

			local var_588_9 = arg_585_1.actors_["1049ui_story"]
			local var_588_10 = 0

			if var_588_10 < arg_585_1.time_ and arg_585_1.time_ <= var_588_10 + arg_588_0 and not isNil(var_588_9) and arg_585_1.var_.characterEffect1049ui_story == nil then
				arg_585_1.var_.characterEffect1049ui_story = var_588_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_11 = 0.200000002980232

			if var_588_10 <= arg_585_1.time_ and arg_585_1.time_ < var_588_10 + var_588_11 and not isNil(var_588_9) then
				local var_588_12 = (arg_585_1.time_ - var_588_10) / var_588_11

				if arg_585_1.var_.characterEffect1049ui_story and not isNil(var_588_9) then
					arg_585_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_585_1.time_ >= var_588_10 + var_588_11 and arg_585_1.time_ < var_588_10 + var_588_11 + arg_588_0 and not isNil(var_588_9) and arg_585_1.var_.characterEffect1049ui_story then
				arg_585_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_588_13 = 0

			if var_588_13 < arg_585_1.time_ and arg_585_1.time_ <= var_588_13 + arg_588_0 then
				arg_585_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_588_14 = 0
			local var_588_15 = 0.05

			if var_588_14 < arg_585_1.time_ and arg_585_1.time_ <= var_588_14 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				local var_588_16 = arg_585_1:FormatText(StoryNameCfg[551].name)

				arg_585_1.leftNameTxt_.text = var_588_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_17 = arg_585_1:GetWordFromCfg(1104901142)
				local var_588_18 = arg_585_1:FormatText(var_588_17.content)

				arg_585_1.text_.text = var_588_18

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_19 = 2
				local var_588_20 = utf8.len(var_588_18)
				local var_588_21 = var_588_19 <= 0 and var_588_15 or var_588_15 * (var_588_20 / var_588_19)

				if var_588_21 > 0 and var_588_15 < var_588_21 then
					arg_585_1.talkMaxDuration = var_588_21

					if var_588_21 + var_588_14 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_21 + var_588_14
					end
				end

				arg_585_1.text_.text = var_588_18
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901142", "story_v_side_new_1104901.awb") ~= 0 then
					local var_588_22 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901142", "story_v_side_new_1104901.awb") / 1000

					if var_588_22 + var_588_14 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_22 + var_588_14
					end

					if var_588_17.prefab_name ~= "" and arg_585_1.actors_[var_588_17.prefab_name] ~= nil then
						local var_588_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_17.prefab_name].transform, "story_v_side_new_1104901", "1104901142", "story_v_side_new_1104901.awb")

						arg_585_1:RecordAudio("1104901142", var_588_23)
						arg_585_1:RecordAudio("1104901142", var_588_23)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901142", "story_v_side_new_1104901.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901142", "story_v_side_new_1104901.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_24 = math.max(var_588_15, arg_585_1.talkMaxDuration)

			if var_588_14 <= arg_585_1.time_ and arg_585_1.time_ < var_588_14 + var_588_24 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_14) / var_588_24

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_14 + var_588_24 and arg_585_1.time_ < var_588_14 + var_588_24 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_585_1:InitPlayNodeList()
	end,
	Play1104901143 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 1104901143
		arg_589_1.duration_ = 5

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play1104901144(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = arg_589_1.actors_["1049ui_story"].transform
			local var_592_1 = 0

			if var_592_1 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 then
				arg_589_1.var_.moveOldPos1049ui_story = var_592_0.localPosition
			end

			local var_592_2 = 0.001

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_2 then
				local var_592_3 = (arg_589_1.time_ - var_592_1) / var_592_2
				local var_592_4 = Vector3.New(0, 100, 0)

				var_592_0.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1049ui_story, var_592_4, var_592_3)

				local var_592_5 = manager.ui.mainCamera.transform.position - var_592_0.position

				var_592_0.forward = Vector3.New(var_592_5.x, var_592_5.y, var_592_5.z)

				local var_592_6 = var_592_0.localEulerAngles

				var_592_6.z = 0
				var_592_6.x = 0
				var_592_0.localEulerAngles = var_592_6
			end

			if arg_589_1.time_ >= var_592_1 + var_592_2 and arg_589_1.time_ < var_592_1 + var_592_2 + arg_592_0 then
				var_592_0.localPosition = Vector3.New(0, 100, 0)

				local var_592_7 = manager.ui.mainCamera.transform.position - var_592_0.position

				var_592_0.forward = Vector3.New(var_592_7.x, var_592_7.y, var_592_7.z)

				local var_592_8 = var_592_0.localEulerAngles

				var_592_8.z = 0
				var_592_8.x = 0
				var_592_0.localEulerAngles = var_592_8
			end

			local var_592_9 = arg_589_1.actors_["1049ui_story"]
			local var_592_10 = 0

			if var_592_10 < arg_589_1.time_ and arg_589_1.time_ <= var_592_10 + arg_592_0 and not isNil(var_592_9) and arg_589_1.var_.characterEffect1049ui_story == nil then
				arg_589_1.var_.characterEffect1049ui_story = var_592_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_11 = 0.200000002980232

			if var_592_10 <= arg_589_1.time_ and arg_589_1.time_ < var_592_10 + var_592_11 and not isNil(var_592_9) then
				local var_592_12 = (arg_589_1.time_ - var_592_10) / var_592_11

				if arg_589_1.var_.characterEffect1049ui_story and not isNil(var_592_9) then
					local var_592_13 = Mathf.Lerp(0, 0.5, var_592_12)

					arg_589_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_589_1.var_.characterEffect1049ui_story.fillRatio = var_592_13
				end
			end

			if arg_589_1.time_ >= var_592_10 + var_592_11 and arg_589_1.time_ < var_592_10 + var_592_11 + arg_592_0 and not isNil(var_592_9) and arg_589_1.var_.characterEffect1049ui_story then
				local var_592_14 = 0.5

				arg_589_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_589_1.var_.characterEffect1049ui_story.fillRatio = var_592_14
			end

			local var_592_15 = 0
			local var_592_16 = 0.625

			if var_592_15 < arg_589_1.time_ and arg_589_1.time_ <= var_592_15 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, false)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_17 = arg_589_1:GetWordFromCfg(1104901143)
				local var_592_18 = arg_589_1:FormatText(var_592_17.content)

				arg_589_1.text_.text = var_592_18

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_19 = 25
				local var_592_20 = utf8.len(var_592_18)
				local var_592_21 = var_592_19 <= 0 and var_592_16 or var_592_16 * (var_592_20 / var_592_19)

				if var_592_21 > 0 and var_592_16 < var_592_21 then
					arg_589_1.talkMaxDuration = var_592_21

					if var_592_21 + var_592_15 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_21 + var_592_15
					end
				end

				arg_589_1.text_.text = var_592_18
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)
				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_22 = math.max(var_592_16, arg_589_1.talkMaxDuration)

			if var_592_15 <= arg_589_1.time_ and arg_589_1.time_ < var_592_15 + var_592_22 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_15) / var_592_22

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_15 + var_592_22 and arg_589_1.time_ < var_592_15 + var_592_22 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_589_1:InitPlayNodeList()
	end,
	Play1104901144 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 1104901144
		arg_593_1.duration_ = 6.17

		local var_593_0 = {
			zh = 3.933,
			ja = 6.166
		}
		local var_593_1 = manager.audio:GetLocalizationFlag()

		if var_593_0[var_593_1] ~= nil then
			arg_593_1.duration_ = var_593_0[var_593_1]
		end

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play1104901145(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0
			local var_596_1 = 0.525

			if var_596_0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				local var_596_2 = arg_593_1:FormatText(StoryNameCfg[394].name)

				arg_593_1.leftNameTxt_.text = var_596_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, true)
				arg_593_1.iconController_:SetSelectedState("hero")

				arg_593_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_593_1.callingController_:SetSelectedState("normal")

				arg_593_1.keyicon_.color = Color.New(1, 1, 1)
				arg_593_1.icon_.color = Color.New(1, 1, 1)

				local var_596_3 = arg_593_1:GetWordFromCfg(1104901144)
				local var_596_4 = arg_593_1:FormatText(var_596_3.content)

				arg_593_1.text_.text = var_596_4

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_5 = 21
				local var_596_6 = utf8.len(var_596_4)
				local var_596_7 = var_596_5 <= 0 and var_596_1 or var_596_1 * (var_596_6 / var_596_5)

				if var_596_7 > 0 and var_596_1 < var_596_7 then
					arg_593_1.talkMaxDuration = var_596_7

					if var_596_7 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_7 + var_596_0
					end
				end

				arg_593_1.text_.text = var_596_4
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901144", "story_v_side_new_1104901.awb") ~= 0 then
					local var_596_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901144", "story_v_side_new_1104901.awb") / 1000

					if var_596_8 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_8 + var_596_0
					end

					if var_596_3.prefab_name ~= "" and arg_593_1.actors_[var_596_3.prefab_name] ~= nil then
						local var_596_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_3.prefab_name].transform, "story_v_side_new_1104901", "1104901144", "story_v_side_new_1104901.awb")

						arg_593_1:RecordAudio("1104901144", var_596_9)
						arg_593_1:RecordAudio("1104901144", var_596_9)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901144", "story_v_side_new_1104901.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901144", "story_v_side_new_1104901.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_10 = math.max(var_596_1, arg_593_1.talkMaxDuration)

			if var_596_0 <= arg_593_1.time_ and arg_593_1.time_ < var_596_0 + var_596_10 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - var_596_0) / var_596_10

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= var_596_0 + var_596_10 and arg_593_1.time_ < var_596_0 + var_596_10 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play1104901145 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 1104901145
		arg_597_1.duration_ = 1.73

		local var_597_0 = {
			zh = 1.6,
			ja = 1.733
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play1104901146(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = arg_597_1.actors_["1049ui_story"].transform
			local var_600_1 = 0

			if var_600_1 < arg_597_1.time_ and arg_597_1.time_ <= var_600_1 + arg_600_0 then
				arg_597_1.var_.moveOldPos1049ui_story = var_600_0.localPosition
			end

			local var_600_2 = 0.001

			if var_600_1 <= arg_597_1.time_ and arg_597_1.time_ < var_600_1 + var_600_2 then
				local var_600_3 = (arg_597_1.time_ - var_600_1) / var_600_2
				local var_600_4 = Vector3.New(0, -1.2, -6)

				var_600_0.localPosition = Vector3.Lerp(arg_597_1.var_.moveOldPos1049ui_story, var_600_4, var_600_3)

				local var_600_5 = manager.ui.mainCamera.transform.position - var_600_0.position

				var_600_0.forward = Vector3.New(var_600_5.x, var_600_5.y, var_600_5.z)

				local var_600_6 = var_600_0.localEulerAngles

				var_600_6.z = 0
				var_600_6.x = 0
				var_600_0.localEulerAngles = var_600_6
			end

			if arg_597_1.time_ >= var_600_1 + var_600_2 and arg_597_1.time_ < var_600_1 + var_600_2 + arg_600_0 then
				var_600_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_600_7 = manager.ui.mainCamera.transform.position - var_600_0.position

				var_600_0.forward = Vector3.New(var_600_7.x, var_600_7.y, var_600_7.z)

				local var_600_8 = var_600_0.localEulerAngles

				var_600_8.z = 0
				var_600_8.x = 0
				var_600_0.localEulerAngles = var_600_8
			end

			local var_600_9 = arg_597_1.actors_["1049ui_story"]
			local var_600_10 = 0

			if var_600_10 < arg_597_1.time_ and arg_597_1.time_ <= var_600_10 + arg_600_0 and not isNil(var_600_9) and arg_597_1.var_.characterEffect1049ui_story == nil then
				arg_597_1.var_.characterEffect1049ui_story = var_600_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_600_11 = 0.200000002980232

			if var_600_10 <= arg_597_1.time_ and arg_597_1.time_ < var_600_10 + var_600_11 and not isNil(var_600_9) then
				local var_600_12 = (arg_597_1.time_ - var_600_10) / var_600_11

				if arg_597_1.var_.characterEffect1049ui_story and not isNil(var_600_9) then
					arg_597_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_597_1.time_ >= var_600_10 + var_600_11 and arg_597_1.time_ < var_600_10 + var_600_11 + arg_600_0 and not isNil(var_600_9) and arg_597_1.var_.characterEffect1049ui_story then
				arg_597_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_600_13 = 0

			if var_600_13 < arg_597_1.time_ and arg_597_1.time_ <= var_600_13 + arg_600_0 then
				arg_597_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_600_14 = 0

			if var_600_14 < arg_597_1.time_ and arg_597_1.time_ <= var_600_14 + arg_600_0 then
				arg_597_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_600_15 = 0
			local var_600_16 = 0.125

			if var_600_15 < arg_597_1.time_ and arg_597_1.time_ <= var_600_15 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				local var_600_17 = arg_597_1:FormatText(StoryNameCfg[551].name)

				arg_597_1.leftNameTxt_.text = var_600_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_18 = arg_597_1:GetWordFromCfg(1104901145)
				local var_600_19 = arg_597_1:FormatText(var_600_18.content)

				arg_597_1.text_.text = var_600_19

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_20 = 5
				local var_600_21 = utf8.len(var_600_19)
				local var_600_22 = var_600_20 <= 0 and var_600_16 or var_600_16 * (var_600_21 / var_600_20)

				if var_600_22 > 0 and var_600_16 < var_600_22 then
					arg_597_1.talkMaxDuration = var_600_22

					if var_600_22 + var_600_15 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_22 + var_600_15
					end
				end

				arg_597_1.text_.text = var_600_19
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901145", "story_v_side_new_1104901.awb") ~= 0 then
					local var_600_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901145", "story_v_side_new_1104901.awb") / 1000

					if var_600_23 + var_600_15 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_23 + var_600_15
					end

					if var_600_18.prefab_name ~= "" and arg_597_1.actors_[var_600_18.prefab_name] ~= nil then
						local var_600_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_18.prefab_name].transform, "story_v_side_new_1104901", "1104901145", "story_v_side_new_1104901.awb")

						arg_597_1:RecordAudio("1104901145", var_600_24)
						arg_597_1:RecordAudio("1104901145", var_600_24)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901145", "story_v_side_new_1104901.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901145", "story_v_side_new_1104901.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_25 = math.max(var_600_16, arg_597_1.talkMaxDuration)

			if var_600_15 <= arg_597_1.time_ and arg_597_1.time_ < var_600_15 + var_600_25 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - var_600_15) / var_600_25

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= var_600_15 + var_600_25 and arg_597_1.time_ < var_600_15 + var_600_25 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_597_1:InitPlayNodeList()
	end,
	Play1104901146 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 1104901146
		arg_601_1.duration_ = 8.57

		local var_601_0 = {
			zh = 8.3,
			ja = 8.566
		}
		local var_601_1 = manager.audio:GetLocalizationFlag()

		if var_601_0[var_601_1] ~= nil then
			arg_601_1.duration_ = var_601_0[var_601_1]
		end

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play1104901147(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = arg_601_1.actors_["1049ui_story"]
			local var_604_1 = 0

			if var_604_1 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect1049ui_story == nil then
				arg_601_1.var_.characterEffect1049ui_story = var_604_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_2 = 0.200000002980232

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_2 and not isNil(var_604_0) then
				local var_604_3 = (arg_601_1.time_ - var_604_1) / var_604_2

				if arg_601_1.var_.characterEffect1049ui_story and not isNil(var_604_0) then
					local var_604_4 = Mathf.Lerp(0, 0.5, var_604_3)

					arg_601_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_601_1.var_.characterEffect1049ui_story.fillRatio = var_604_4
				end
			end

			if arg_601_1.time_ >= var_604_1 + var_604_2 and arg_601_1.time_ < var_604_1 + var_604_2 + arg_604_0 and not isNil(var_604_0) and arg_601_1.var_.characterEffect1049ui_story then
				local var_604_5 = 0.5

				arg_601_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_601_1.var_.characterEffect1049ui_story.fillRatio = var_604_5
			end

			local var_604_6 = 0
			local var_604_7 = 1.05

			if var_604_6 < arg_601_1.time_ and arg_601_1.time_ <= var_604_6 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				local var_604_8 = arg_601_1:FormatText(StoryNameCfg[394].name)

				arg_601_1.leftNameTxt_.text = var_604_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, true)
				arg_601_1.iconController_:SetSelectedState("hero")

				arg_601_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_601_1.callingController_:SetSelectedState("normal")

				arg_601_1.keyicon_.color = Color.New(1, 1, 1)
				arg_601_1.icon_.color = Color.New(1, 1, 1)

				local var_604_9 = arg_601_1:GetWordFromCfg(1104901146)
				local var_604_10 = arg_601_1:FormatText(var_604_9.content)

				arg_601_1.text_.text = var_604_10

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_11 = 42
				local var_604_12 = utf8.len(var_604_10)
				local var_604_13 = var_604_11 <= 0 and var_604_7 or var_604_7 * (var_604_12 / var_604_11)

				if var_604_13 > 0 and var_604_7 < var_604_13 then
					arg_601_1.talkMaxDuration = var_604_13

					if var_604_13 + var_604_6 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_13 + var_604_6
					end
				end

				arg_601_1.text_.text = var_604_10
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901146", "story_v_side_new_1104901.awb") ~= 0 then
					local var_604_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901146", "story_v_side_new_1104901.awb") / 1000

					if var_604_14 + var_604_6 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_14 + var_604_6
					end

					if var_604_9.prefab_name ~= "" and arg_601_1.actors_[var_604_9.prefab_name] ~= nil then
						local var_604_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_9.prefab_name].transform, "story_v_side_new_1104901", "1104901146", "story_v_side_new_1104901.awb")

						arg_601_1:RecordAudio("1104901146", var_604_15)
						arg_601_1:RecordAudio("1104901146", var_604_15)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901146", "story_v_side_new_1104901.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901146", "story_v_side_new_1104901.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_16 = math.max(var_604_7, arg_601_1.talkMaxDuration)

			if var_604_6 <= arg_601_1.time_ and arg_601_1.time_ < var_604_6 + var_604_16 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_6) / var_604_16

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_6 + var_604_16 and arg_601_1.time_ < var_604_6 + var_604_16 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play1104901147 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 1104901147
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play1104901148(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0
			local var_608_1 = 0.825

			if var_608_0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				local var_608_2 = arg_605_1:FormatText(StoryNameCfg[7].name)

				arg_605_1.leftNameTxt_.text = var_608_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, true)
				arg_605_1.iconController_:SetSelectedState("hero")

				arg_605_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_605_1.callingController_:SetSelectedState("normal")

				arg_605_1.keyicon_.color = Color.New(1, 1, 1)
				arg_605_1.icon_.color = Color.New(1, 1, 1)

				local var_608_3 = arg_605_1:GetWordFromCfg(1104901147)
				local var_608_4 = arg_605_1:FormatText(var_608_3.content)

				arg_605_1.text_.text = var_608_4

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_5 = 33
				local var_608_6 = utf8.len(var_608_4)
				local var_608_7 = var_608_5 <= 0 and var_608_1 or var_608_1 * (var_608_6 / var_608_5)

				if var_608_7 > 0 and var_608_1 < var_608_7 then
					arg_605_1.talkMaxDuration = var_608_7

					if var_608_7 + var_608_0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_7 + var_608_0
					end
				end

				arg_605_1.text_.text = var_608_4
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_8 = math.max(var_608_1, arg_605_1.talkMaxDuration)

			if var_608_0 <= arg_605_1.time_ and arg_605_1.time_ < var_608_0 + var_608_8 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_0) / var_608_8

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_0 + var_608_8 and arg_605_1.time_ < var_608_0 + var_608_8 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play1104901148 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 1104901148
		arg_609_1.duration_ = 10.07

		local var_609_0 = {
			zh = 7.7,
			ja = 10.066
		}
		local var_609_1 = manager.audio:GetLocalizationFlag()

		if var_609_0[var_609_1] ~= nil then
			arg_609_1.duration_ = var_609_0[var_609_1]
		end

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play1104901149(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 0
			local var_612_1 = 1

			if var_612_0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				local var_612_2 = arg_609_1:FormatText(StoryNameCfg[394].name)

				arg_609_1.leftNameTxt_.text = var_612_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, true)
				arg_609_1.iconController_:SetSelectedState("hero")

				arg_609_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_609_1.callingController_:SetSelectedState("normal")

				arg_609_1.keyicon_.color = Color.New(1, 1, 1)
				arg_609_1.icon_.color = Color.New(1, 1, 1)

				local var_612_3 = arg_609_1:GetWordFromCfg(1104901148)
				local var_612_4 = arg_609_1:FormatText(var_612_3.content)

				arg_609_1.text_.text = var_612_4

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_5 = 40
				local var_612_6 = utf8.len(var_612_4)
				local var_612_7 = var_612_5 <= 0 and var_612_1 or var_612_1 * (var_612_6 / var_612_5)

				if var_612_7 > 0 and var_612_1 < var_612_7 then
					arg_609_1.talkMaxDuration = var_612_7

					if var_612_7 + var_612_0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_7 + var_612_0
					end
				end

				arg_609_1.text_.text = var_612_4
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901148", "story_v_side_new_1104901.awb") ~= 0 then
					local var_612_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901148", "story_v_side_new_1104901.awb") / 1000

					if var_612_8 + var_612_0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_8 + var_612_0
					end

					if var_612_3.prefab_name ~= "" and arg_609_1.actors_[var_612_3.prefab_name] ~= nil then
						local var_612_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_609_1.actors_[var_612_3.prefab_name].transform, "story_v_side_new_1104901", "1104901148", "story_v_side_new_1104901.awb")

						arg_609_1:RecordAudio("1104901148", var_612_9)
						arg_609_1:RecordAudio("1104901148", var_612_9)
					else
						arg_609_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901148", "story_v_side_new_1104901.awb")
					end

					arg_609_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901148", "story_v_side_new_1104901.awb")
				end

				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_10 = math.max(var_612_1, arg_609_1.talkMaxDuration)

			if var_612_0 <= arg_609_1.time_ and arg_609_1.time_ < var_612_0 + var_612_10 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_0) / var_612_10

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_0 + var_612_10 and arg_609_1.time_ < var_612_0 + var_612_10 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play1104901149 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 1104901149
		arg_613_1.duration_ = 2.93

		local var_613_0 = {
			zh = 1.666,
			ja = 2.933
		}
		local var_613_1 = manager.audio:GetLocalizationFlag()

		if var_613_0[var_613_1] ~= nil then
			arg_613_1.duration_ = var_613_0[var_613_1]
		end

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play1104901150(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = arg_613_1.actors_["1049ui_story"].transform
			local var_616_1 = 0

			if var_616_1 < arg_613_1.time_ and arg_613_1.time_ <= var_616_1 + arg_616_0 then
				arg_613_1.var_.moveOldPos1049ui_story = var_616_0.localPosition
			end

			local var_616_2 = 0.001

			if var_616_1 <= arg_613_1.time_ and arg_613_1.time_ < var_616_1 + var_616_2 then
				local var_616_3 = (arg_613_1.time_ - var_616_1) / var_616_2
				local var_616_4 = Vector3.New(0, -1.2, -6)

				var_616_0.localPosition = Vector3.Lerp(arg_613_1.var_.moveOldPos1049ui_story, var_616_4, var_616_3)

				local var_616_5 = manager.ui.mainCamera.transform.position - var_616_0.position

				var_616_0.forward = Vector3.New(var_616_5.x, var_616_5.y, var_616_5.z)

				local var_616_6 = var_616_0.localEulerAngles

				var_616_6.z = 0
				var_616_6.x = 0
				var_616_0.localEulerAngles = var_616_6
			end

			if arg_613_1.time_ >= var_616_1 + var_616_2 and arg_613_1.time_ < var_616_1 + var_616_2 + arg_616_0 then
				var_616_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_616_7 = manager.ui.mainCamera.transform.position - var_616_0.position

				var_616_0.forward = Vector3.New(var_616_7.x, var_616_7.y, var_616_7.z)

				local var_616_8 = var_616_0.localEulerAngles

				var_616_8.z = 0
				var_616_8.x = 0
				var_616_0.localEulerAngles = var_616_8
			end

			local var_616_9 = arg_613_1.actors_["1049ui_story"]
			local var_616_10 = 0

			if var_616_10 < arg_613_1.time_ and arg_613_1.time_ <= var_616_10 + arg_616_0 and not isNil(var_616_9) and arg_613_1.var_.characterEffect1049ui_story == nil then
				arg_613_1.var_.characterEffect1049ui_story = var_616_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_616_11 = 0.200000002980232

			if var_616_10 <= arg_613_1.time_ and arg_613_1.time_ < var_616_10 + var_616_11 and not isNil(var_616_9) then
				local var_616_12 = (arg_613_1.time_ - var_616_10) / var_616_11

				if arg_613_1.var_.characterEffect1049ui_story and not isNil(var_616_9) then
					arg_613_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_613_1.time_ >= var_616_10 + var_616_11 and arg_613_1.time_ < var_616_10 + var_616_11 + arg_616_0 and not isNil(var_616_9) and arg_613_1.var_.characterEffect1049ui_story then
				arg_613_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_616_13 = 0

			if var_616_13 < arg_613_1.time_ and arg_613_1.time_ <= var_616_13 + arg_616_0 then
				arg_613_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action1_1")
			end

			local var_616_14 = 0

			if var_616_14 < arg_613_1.time_ and arg_613_1.time_ <= var_616_14 + arg_616_0 then
				arg_613_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_616_15 = 0
			local var_616_16 = 0.2

			if var_616_15 < arg_613_1.time_ and arg_613_1.time_ <= var_616_15 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				local var_616_17 = arg_613_1:FormatText(StoryNameCfg[551].name)

				arg_613_1.leftNameTxt_.text = var_616_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_18 = arg_613_1:GetWordFromCfg(1104901149)
				local var_616_19 = arg_613_1:FormatText(var_616_18.content)

				arg_613_1.text_.text = var_616_19

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_20 = 8
				local var_616_21 = utf8.len(var_616_19)
				local var_616_22 = var_616_20 <= 0 and var_616_16 or var_616_16 * (var_616_21 / var_616_20)

				if var_616_22 > 0 and var_616_16 < var_616_22 then
					arg_613_1.talkMaxDuration = var_616_22

					if var_616_22 + var_616_15 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_22 + var_616_15
					end
				end

				arg_613_1.text_.text = var_616_19
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901149", "story_v_side_new_1104901.awb") ~= 0 then
					local var_616_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901149", "story_v_side_new_1104901.awb") / 1000

					if var_616_23 + var_616_15 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_23 + var_616_15
					end

					if var_616_18.prefab_name ~= "" and arg_613_1.actors_[var_616_18.prefab_name] ~= nil then
						local var_616_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_18.prefab_name].transform, "story_v_side_new_1104901", "1104901149", "story_v_side_new_1104901.awb")

						arg_613_1:RecordAudio("1104901149", var_616_24)
						arg_613_1:RecordAudio("1104901149", var_616_24)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901149", "story_v_side_new_1104901.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901149", "story_v_side_new_1104901.awb")
				end

				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_25 = math.max(var_616_16, arg_613_1.talkMaxDuration)

			if var_616_15 <= arg_613_1.time_ and arg_613_1.time_ < var_616_15 + var_616_25 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - var_616_15) / var_616_25

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= var_616_15 + var_616_25 and arg_613_1.time_ < var_616_15 + var_616_25 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_613_1:InitPlayNodeList()
	end,
	Play1104901150 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 1104901150
		arg_617_1.duration_ = 11.57

		local var_617_0 = {
			zh = 7.033,
			ja = 11.566
		}
		local var_617_1 = manager.audio:GetLocalizationFlag()

		if var_617_0[var_617_1] ~= nil then
			arg_617_1.duration_ = var_617_0[var_617_1]
		end

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play1104901151(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = arg_617_1.actors_["1049ui_story"]
			local var_620_1 = 0

			if var_620_1 < arg_617_1.time_ and arg_617_1.time_ <= var_620_1 + arg_620_0 and not isNil(var_620_0) and arg_617_1.var_.characterEffect1049ui_story == nil then
				arg_617_1.var_.characterEffect1049ui_story = var_620_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_620_2 = 0.200000002980232

			if var_620_1 <= arg_617_1.time_ and arg_617_1.time_ < var_620_1 + var_620_2 and not isNil(var_620_0) then
				local var_620_3 = (arg_617_1.time_ - var_620_1) / var_620_2

				if arg_617_1.var_.characterEffect1049ui_story and not isNil(var_620_0) then
					local var_620_4 = Mathf.Lerp(0, 0.5, var_620_3)

					arg_617_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_617_1.var_.characterEffect1049ui_story.fillRatio = var_620_4
				end
			end

			if arg_617_1.time_ >= var_620_1 + var_620_2 and arg_617_1.time_ < var_620_1 + var_620_2 + arg_620_0 and not isNil(var_620_0) and arg_617_1.var_.characterEffect1049ui_story then
				local var_620_5 = 0.5

				arg_617_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_617_1.var_.characterEffect1049ui_story.fillRatio = var_620_5
			end

			local var_620_6 = 0
			local var_620_7 = 0.9

			if var_620_6 < arg_617_1.time_ and arg_617_1.time_ <= var_620_6 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				local var_620_8 = arg_617_1:FormatText(StoryNameCfg[394].name)

				arg_617_1.leftNameTxt_.text = var_620_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, true)
				arg_617_1.iconController_:SetSelectedState("hero")

				arg_617_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_617_1.callingController_:SetSelectedState("normal")

				arg_617_1.keyicon_.color = Color.New(1, 1, 1)
				arg_617_1.icon_.color = Color.New(1, 1, 1)

				local var_620_9 = arg_617_1:GetWordFromCfg(1104901150)
				local var_620_10 = arg_617_1:FormatText(var_620_9.content)

				arg_617_1.text_.text = var_620_10

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_11 = 36
				local var_620_12 = utf8.len(var_620_10)
				local var_620_13 = var_620_11 <= 0 and var_620_7 or var_620_7 * (var_620_12 / var_620_11)

				if var_620_13 > 0 and var_620_7 < var_620_13 then
					arg_617_1.talkMaxDuration = var_620_13

					if var_620_13 + var_620_6 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_13 + var_620_6
					end
				end

				arg_617_1.text_.text = var_620_10
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901150", "story_v_side_new_1104901.awb") ~= 0 then
					local var_620_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901150", "story_v_side_new_1104901.awb") / 1000

					if var_620_14 + var_620_6 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_14 + var_620_6
					end

					if var_620_9.prefab_name ~= "" and arg_617_1.actors_[var_620_9.prefab_name] ~= nil then
						local var_620_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_617_1.actors_[var_620_9.prefab_name].transform, "story_v_side_new_1104901", "1104901150", "story_v_side_new_1104901.awb")

						arg_617_1:RecordAudio("1104901150", var_620_15)
						arg_617_1:RecordAudio("1104901150", var_620_15)
					else
						arg_617_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901150", "story_v_side_new_1104901.awb")
					end

					arg_617_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901150", "story_v_side_new_1104901.awb")
				end

				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_16 = math.max(var_620_7, arg_617_1.talkMaxDuration)

			if var_620_6 <= arg_617_1.time_ and arg_617_1.time_ < var_620_6 + var_620_16 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - var_620_6) / var_620_16

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= var_620_6 + var_620_16 and arg_617_1.time_ < var_620_6 + var_620_16 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play1104901151 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 1104901151
		arg_621_1.duration_ = 5.27

		local var_621_0 = {
			zh = 5.266,
			ja = 2.766
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play1104901152(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0
			local var_624_1 = 0.575

			if var_624_0 < arg_621_1.time_ and arg_621_1.time_ <= var_624_0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				local var_624_2 = arg_621_1:FormatText(StoryNameCfg[394].name)

				arg_621_1.leftNameTxt_.text = var_624_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, true)
				arg_621_1.iconController_:SetSelectedState("hero")

				arg_621_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_621_1.callingController_:SetSelectedState("normal")

				arg_621_1.keyicon_.color = Color.New(1, 1, 1)
				arg_621_1.icon_.color = Color.New(1, 1, 1)

				local var_624_3 = arg_621_1:GetWordFromCfg(1104901151)
				local var_624_4 = arg_621_1:FormatText(var_624_3.content)

				arg_621_1.text_.text = var_624_4

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_5 = 23
				local var_624_6 = utf8.len(var_624_4)
				local var_624_7 = var_624_5 <= 0 and var_624_1 or var_624_1 * (var_624_6 / var_624_5)

				if var_624_7 > 0 and var_624_1 < var_624_7 then
					arg_621_1.talkMaxDuration = var_624_7

					if var_624_7 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_7 + var_624_0
					end
				end

				arg_621_1.text_.text = var_624_4
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901151", "story_v_side_new_1104901.awb") ~= 0 then
					local var_624_8 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901151", "story_v_side_new_1104901.awb") / 1000

					if var_624_8 + var_624_0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_8 + var_624_0
					end

					if var_624_3.prefab_name ~= "" and arg_621_1.actors_[var_624_3.prefab_name] ~= nil then
						local var_624_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_3.prefab_name].transform, "story_v_side_new_1104901", "1104901151", "story_v_side_new_1104901.awb")

						arg_621_1:RecordAudio("1104901151", var_624_9)
						arg_621_1:RecordAudio("1104901151", var_624_9)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901151", "story_v_side_new_1104901.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901151", "story_v_side_new_1104901.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_10 = math.max(var_624_1, arg_621_1.talkMaxDuration)

			if var_624_0 <= arg_621_1.time_ and arg_621_1.time_ < var_624_0 + var_624_10 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - var_624_0) / var_624_10

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= var_624_0 + var_624_10 and arg_621_1.time_ < var_624_0 + var_624_10 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play1104901152 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 1104901152
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play1104901153(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = arg_625_1.actors_["1049ui_story"].transform
			local var_628_1 = 0

			if var_628_1 < arg_625_1.time_ and arg_625_1.time_ <= var_628_1 + arg_628_0 then
				arg_625_1.var_.moveOldPos1049ui_story = var_628_0.localPosition
			end

			local var_628_2 = 0.001

			if var_628_1 <= arg_625_1.time_ and arg_625_1.time_ < var_628_1 + var_628_2 then
				local var_628_3 = (arg_625_1.time_ - var_628_1) / var_628_2
				local var_628_4 = Vector3.New(0, 100, 0)

				var_628_0.localPosition = Vector3.Lerp(arg_625_1.var_.moveOldPos1049ui_story, var_628_4, var_628_3)

				local var_628_5 = manager.ui.mainCamera.transform.position - var_628_0.position

				var_628_0.forward = Vector3.New(var_628_5.x, var_628_5.y, var_628_5.z)

				local var_628_6 = var_628_0.localEulerAngles

				var_628_6.z = 0
				var_628_6.x = 0
				var_628_0.localEulerAngles = var_628_6
			end

			if arg_625_1.time_ >= var_628_1 + var_628_2 and arg_625_1.time_ < var_628_1 + var_628_2 + arg_628_0 then
				var_628_0.localPosition = Vector3.New(0, 100, 0)

				local var_628_7 = manager.ui.mainCamera.transform.position - var_628_0.position

				var_628_0.forward = Vector3.New(var_628_7.x, var_628_7.y, var_628_7.z)

				local var_628_8 = var_628_0.localEulerAngles

				var_628_8.z = 0
				var_628_8.x = 0
				var_628_0.localEulerAngles = var_628_8
			end

			local var_628_9 = arg_625_1.actors_["1049ui_story"]
			local var_628_10 = 0

			if var_628_10 < arg_625_1.time_ and arg_625_1.time_ <= var_628_10 + arg_628_0 and not isNil(var_628_9) and arg_625_1.var_.characterEffect1049ui_story == nil then
				arg_625_1.var_.characterEffect1049ui_story = var_628_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_628_11 = 0.200000002980232

			if var_628_10 <= arg_625_1.time_ and arg_625_1.time_ < var_628_10 + var_628_11 and not isNil(var_628_9) then
				local var_628_12 = (arg_625_1.time_ - var_628_10) / var_628_11

				if arg_625_1.var_.characterEffect1049ui_story and not isNil(var_628_9) then
					local var_628_13 = Mathf.Lerp(0, 0.5, var_628_12)

					arg_625_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_625_1.var_.characterEffect1049ui_story.fillRatio = var_628_13
				end
			end

			if arg_625_1.time_ >= var_628_10 + var_628_11 and arg_625_1.time_ < var_628_10 + var_628_11 + arg_628_0 and not isNil(var_628_9) and arg_625_1.var_.characterEffect1049ui_story then
				local var_628_14 = 0.5

				arg_625_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_625_1.var_.characterEffect1049ui_story.fillRatio = var_628_14
			end

			local var_628_15 = 0
			local var_628_16 = 0.8

			if var_628_15 < arg_625_1.time_ and arg_625_1.time_ <= var_628_15 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, false)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_17 = arg_625_1:GetWordFromCfg(1104901152)
				local var_628_18 = arg_625_1:FormatText(var_628_17.content)

				arg_625_1.text_.text = var_628_18

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_19 = 32
				local var_628_20 = utf8.len(var_628_18)
				local var_628_21 = var_628_19 <= 0 and var_628_16 or var_628_16 * (var_628_20 / var_628_19)

				if var_628_21 > 0 and var_628_16 < var_628_21 then
					arg_625_1.talkMaxDuration = var_628_21

					if var_628_21 + var_628_15 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_21 + var_628_15
					end
				end

				arg_625_1.text_.text = var_628_18
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_22 = math.max(var_628_16, arg_625_1.talkMaxDuration)

			if var_628_15 <= arg_625_1.time_ and arg_625_1.time_ < var_628_15 + var_628_22 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - var_628_15) / var_628_22

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= var_628_15 + var_628_22 and arg_625_1.time_ < var_628_15 + var_628_22 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_625_1:InitPlayNodeList()
	end,
	Play1104901153 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 1104901153
		arg_629_1.duration_ = 5

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play1104901154(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_0 = 0
			local var_632_1 = 1

			if var_632_0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_0 + arg_632_0 then
				local var_632_2 = "play"
				local var_632_3 = "effect"

				arg_629_1:AudioAction(var_632_2, var_632_3, "se_story_side_1049", "se_story_side_1049_crow", "")
			end

			local var_632_4 = 0
			local var_632_5 = 0.7

			if var_632_4 < arg_629_1.time_ and arg_629_1.time_ <= var_632_4 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0
				arg_629_1.dialogCg_.alpha = 1

				arg_629_1.dialog_:SetActive(true)
				SetActive(arg_629_1.leftNameGo_, false)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_6 = arg_629_1:GetWordFromCfg(1104901153)
				local var_632_7 = arg_629_1:FormatText(var_632_6.content)

				arg_629_1.text_.text = var_632_7

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_8 = 28
				local var_632_9 = utf8.len(var_632_7)
				local var_632_10 = var_632_8 <= 0 and var_632_5 or var_632_5 * (var_632_9 / var_632_8)

				if var_632_10 > 0 and var_632_5 < var_632_10 then
					arg_629_1.talkMaxDuration = var_632_10

					if var_632_10 + var_632_4 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_10 + var_632_4
					end
				end

				arg_629_1.text_.text = var_632_7
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_11 = math.max(var_632_5, arg_629_1.talkMaxDuration)

			if var_632_4 <= arg_629_1.time_ and arg_629_1.time_ < var_632_4 + var_632_11 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_4) / var_632_11

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_4 + var_632_11 and arg_629_1.time_ < var_632_4 + var_632_11 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play1104901154 = function(arg_633_0, arg_633_1)
		arg_633_1.time_ = 0
		arg_633_1.frameCnt_ = 0
		arg_633_1.state_ = "playing"
		arg_633_1.curTalkId_ = 1104901154
		arg_633_1.duration_ = 2.3

		local var_633_0 = {
			zh = 2.3,
			ja = 1.999999999999
		}
		local var_633_1 = manager.audio:GetLocalizationFlag()

		if var_633_0[var_633_1] ~= nil then
			arg_633_1.duration_ = var_633_0[var_633_1]
		end

		SetActive(arg_633_1.tipsGo_, false)

		function arg_633_1.onSingleLineFinish_()
			arg_633_1.onSingleLineUpdate_ = nil
			arg_633_1.onSingleLineFinish_ = nil
			arg_633_1.state_ = "waiting"
		end

		function arg_633_1.playNext_(arg_635_0)
			if arg_635_0 == 1 then
				arg_633_0:Play1104901155(arg_633_1)
			end
		end

		function arg_633_1.onSingleLineUpdate_(arg_636_0)
			local var_636_0 = arg_633_1.actors_["1049ui_story"].transform
			local var_636_1 = 0

			if var_636_1 < arg_633_1.time_ and arg_633_1.time_ <= var_636_1 + arg_636_0 then
				arg_633_1.var_.moveOldPos1049ui_story = var_636_0.localPosition
			end

			local var_636_2 = 0.001

			if var_636_1 <= arg_633_1.time_ and arg_633_1.time_ < var_636_1 + var_636_2 then
				local var_636_3 = (arg_633_1.time_ - var_636_1) / var_636_2
				local var_636_4 = Vector3.New(0, -1.2, -6)

				var_636_0.localPosition = Vector3.Lerp(arg_633_1.var_.moveOldPos1049ui_story, var_636_4, var_636_3)

				local var_636_5 = manager.ui.mainCamera.transform.position - var_636_0.position

				var_636_0.forward = Vector3.New(var_636_5.x, var_636_5.y, var_636_5.z)

				local var_636_6 = var_636_0.localEulerAngles

				var_636_6.z = 0
				var_636_6.x = 0
				var_636_0.localEulerAngles = var_636_6
			end

			if arg_633_1.time_ >= var_636_1 + var_636_2 and arg_633_1.time_ < var_636_1 + var_636_2 + arg_636_0 then
				var_636_0.localPosition = Vector3.New(0, -1.2, -6)

				local var_636_7 = manager.ui.mainCamera.transform.position - var_636_0.position

				var_636_0.forward = Vector3.New(var_636_7.x, var_636_7.y, var_636_7.z)

				local var_636_8 = var_636_0.localEulerAngles

				var_636_8.z = 0
				var_636_8.x = 0
				var_636_0.localEulerAngles = var_636_8
			end

			local var_636_9 = arg_633_1.actors_["1049ui_story"]
			local var_636_10 = 0

			if var_636_10 < arg_633_1.time_ and arg_633_1.time_ <= var_636_10 + arg_636_0 and not isNil(var_636_9) and arg_633_1.var_.characterEffect1049ui_story == nil then
				arg_633_1.var_.characterEffect1049ui_story = var_636_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_636_11 = 0.200000002980232

			if var_636_10 <= arg_633_1.time_ and arg_633_1.time_ < var_636_10 + var_636_11 and not isNil(var_636_9) then
				local var_636_12 = (arg_633_1.time_ - var_636_10) / var_636_11

				if arg_633_1.var_.characterEffect1049ui_story and not isNil(var_636_9) then
					arg_633_1.var_.characterEffect1049ui_story.fillFlat = false
				end
			end

			if arg_633_1.time_ >= var_636_10 + var_636_11 and arg_633_1.time_ < var_636_10 + var_636_11 + arg_636_0 and not isNil(var_636_9) and arg_633_1.var_.characterEffect1049ui_story then
				arg_633_1.var_.characterEffect1049ui_story.fillFlat = false
			end

			local var_636_13 = 0

			if var_636_13 < arg_633_1.time_ and arg_633_1.time_ <= var_636_13 + arg_636_0 then
				arg_633_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/story1049/story1049action/1049action2_1")
			end

			local var_636_14 = 0

			if var_636_14 < arg_633_1.time_ and arg_633_1.time_ <= var_636_14 + arg_636_0 then
				arg_633_1:PlayTimeline("1049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_636_15 = 0
			local var_636_16 = 0.275

			if var_636_15 < arg_633_1.time_ and arg_633_1.time_ <= var_636_15 + arg_636_0 then
				arg_633_1.talkMaxDuration = 0
				arg_633_1.dialogCg_.alpha = 1

				arg_633_1.dialog_:SetActive(true)
				SetActive(arg_633_1.leftNameGo_, true)

				local var_636_17 = arg_633_1:FormatText(StoryNameCfg[551].name)

				arg_633_1.leftNameTxt_.text = var_636_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_633_1.leftNameTxt_.transform)

				arg_633_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_633_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_633_1:RecordName(arg_633_1.leftNameTxt_.text)
				SetActive(arg_633_1.iconTrs_.gameObject, false)
				arg_633_1.callingController_:SetSelectedState("normal")

				local var_636_18 = arg_633_1:GetWordFromCfg(1104901154)
				local var_636_19 = arg_633_1:FormatText(var_636_18.content)

				arg_633_1.text_.text = var_636_19

				LuaForUtil.ClearLinePrefixSymbol(arg_633_1.text_)

				local var_636_20 = 11
				local var_636_21 = utf8.len(var_636_19)
				local var_636_22 = var_636_20 <= 0 and var_636_16 or var_636_16 * (var_636_21 / var_636_20)

				if var_636_22 > 0 and var_636_16 < var_636_22 then
					arg_633_1.talkMaxDuration = var_636_22

					if var_636_22 + var_636_15 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_22 + var_636_15
					end
				end

				arg_633_1.text_.text = var_636_19
				arg_633_1.typewritter.percent = 0

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901154", "story_v_side_new_1104901.awb") ~= 0 then
					local var_636_23 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901154", "story_v_side_new_1104901.awb") / 1000

					if var_636_23 + var_636_15 > arg_633_1.duration_ then
						arg_633_1.duration_ = var_636_23 + var_636_15
					end

					if var_636_18.prefab_name ~= "" and arg_633_1.actors_[var_636_18.prefab_name] ~= nil then
						local var_636_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_633_1.actors_[var_636_18.prefab_name].transform, "story_v_side_new_1104901", "1104901154", "story_v_side_new_1104901.awb")

						arg_633_1:RecordAudio("1104901154", var_636_24)
						arg_633_1:RecordAudio("1104901154", var_636_24)
					else
						arg_633_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901154", "story_v_side_new_1104901.awb")
					end

					arg_633_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901154", "story_v_side_new_1104901.awb")
				end

				arg_633_1:RecordContent(arg_633_1.text_.text)
			end

			local var_636_25 = math.max(var_636_16, arg_633_1.talkMaxDuration)

			if var_636_15 <= arg_633_1.time_ and arg_633_1.time_ < var_636_15 + var_636_25 then
				arg_633_1.typewritter.percent = (arg_633_1.time_ - var_636_15) / var_636_25

				arg_633_1.typewritter:SetDirty()
			end

			if arg_633_1.time_ >= var_636_15 + var_636_25 and arg_633_1.time_ < var_636_15 + var_636_25 + arg_636_0 then
				arg_633_1.typewritter.percent = 1

				arg_633_1.typewritter:SetDirty()
				arg_633_1:ShowNextGo(true)
			end
		end

		arg_633_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_633_1:InitPlayNodeList()
	end,
	Play1104901155 = function(arg_637_0, arg_637_1)
		arg_637_1.time_ = 0
		arg_637_1.frameCnt_ = 0
		arg_637_1.state_ = "playing"
		arg_637_1.curTalkId_ = 1104901155
		arg_637_1.duration_ = 3.9

		local var_637_0 = {
			zh = 3.9,
			ja = 2.266
		}
		local var_637_1 = manager.audio:GetLocalizationFlag()

		if var_637_0[var_637_1] ~= nil then
			arg_637_1.duration_ = var_637_0[var_637_1]
		end

		SetActive(arg_637_1.tipsGo_, false)

		function arg_637_1.onSingleLineFinish_()
			arg_637_1.onSingleLineUpdate_ = nil
			arg_637_1.onSingleLineFinish_ = nil
			arg_637_1.state_ = "waiting"
		end

		function arg_637_1.playNext_(arg_639_0)
			if arg_639_0 == 1 then
				arg_637_0:Play1104901156(arg_637_1)
			end
		end

		function arg_637_1.onSingleLineUpdate_(arg_640_0)
			local var_640_0 = arg_637_1.actors_["1049ui_story"]
			local var_640_1 = 0

			if var_640_1 < arg_637_1.time_ and arg_637_1.time_ <= var_640_1 + arg_640_0 and not isNil(var_640_0) and arg_637_1.var_.characterEffect1049ui_story == nil then
				arg_637_1.var_.characterEffect1049ui_story = var_640_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_640_2 = 0.200000002980232

			if var_640_1 <= arg_637_1.time_ and arg_637_1.time_ < var_640_1 + var_640_2 and not isNil(var_640_0) then
				local var_640_3 = (arg_637_1.time_ - var_640_1) / var_640_2

				if arg_637_1.var_.characterEffect1049ui_story and not isNil(var_640_0) then
					local var_640_4 = Mathf.Lerp(0, 0.5, var_640_3)

					arg_637_1.var_.characterEffect1049ui_story.fillFlat = true
					arg_637_1.var_.characterEffect1049ui_story.fillRatio = var_640_4
				end
			end

			if arg_637_1.time_ >= var_640_1 + var_640_2 and arg_637_1.time_ < var_640_1 + var_640_2 + arg_640_0 and not isNil(var_640_0) and arg_637_1.var_.characterEffect1049ui_story then
				local var_640_5 = 0.5

				arg_637_1.var_.characterEffect1049ui_story.fillFlat = true
				arg_637_1.var_.characterEffect1049ui_story.fillRatio = var_640_5
			end

			local var_640_6 = 0
			local var_640_7 = 0.5

			if var_640_6 < arg_637_1.time_ and arg_637_1.time_ <= var_640_6 + arg_640_0 then
				arg_637_1.talkMaxDuration = 0
				arg_637_1.dialogCg_.alpha = 1

				arg_637_1.dialog_:SetActive(true)
				SetActive(arg_637_1.leftNameGo_, true)

				local var_640_8 = arg_637_1:FormatText(StoryNameCfg[394].name)

				arg_637_1.leftNameTxt_.text = var_640_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_637_1.leftNameTxt_.transform)

				arg_637_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_637_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_637_1:RecordName(arg_637_1.leftNameTxt_.text)
				SetActive(arg_637_1.iconTrs_.gameObject, true)
				arg_637_1.iconController_:SetSelectedState("hero")

				arg_637_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_637_1.callingController_:SetSelectedState("normal")

				arg_637_1.keyicon_.color = Color.New(1, 1, 1)
				arg_637_1.icon_.color = Color.New(1, 1, 1)

				local var_640_9 = arg_637_1:GetWordFromCfg(1104901155)
				local var_640_10 = arg_637_1:FormatText(var_640_9.content)

				arg_637_1.text_.text = var_640_10

				LuaForUtil.ClearLinePrefixSymbol(arg_637_1.text_)

				local var_640_11 = 20
				local var_640_12 = utf8.len(var_640_10)
				local var_640_13 = var_640_11 <= 0 and var_640_7 or var_640_7 * (var_640_12 / var_640_11)

				if var_640_13 > 0 and var_640_7 < var_640_13 then
					arg_637_1.talkMaxDuration = var_640_13

					if var_640_13 + var_640_6 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_13 + var_640_6
					end
				end

				arg_637_1.text_.text = var_640_10
				arg_637_1.typewritter.percent = 0

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901155", "story_v_side_new_1104901.awb") ~= 0 then
					local var_640_14 = manager.audio:GetVoiceLength("story_v_side_new_1104901", "1104901155", "story_v_side_new_1104901.awb") / 1000

					if var_640_14 + var_640_6 > arg_637_1.duration_ then
						arg_637_1.duration_ = var_640_14 + var_640_6
					end

					if var_640_9.prefab_name ~= "" and arg_637_1.actors_[var_640_9.prefab_name] ~= nil then
						local var_640_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_637_1.actors_[var_640_9.prefab_name].transform, "story_v_side_new_1104901", "1104901155", "story_v_side_new_1104901.awb")

						arg_637_1:RecordAudio("1104901155", var_640_15)
						arg_637_1:RecordAudio("1104901155", var_640_15)
					else
						arg_637_1:AudioAction("play", "voice", "story_v_side_new_1104901", "1104901155", "story_v_side_new_1104901.awb")
					end

					arg_637_1:RecordHistoryTalkVoice("story_v_side_new_1104901", "1104901155", "story_v_side_new_1104901.awb")
				end

				arg_637_1:RecordContent(arg_637_1.text_.text)
			end

			local var_640_16 = math.max(var_640_7, arg_637_1.talkMaxDuration)

			if var_640_6 <= arg_637_1.time_ and arg_637_1.time_ < var_640_6 + var_640_16 then
				arg_637_1.typewritter.percent = (arg_637_1.time_ - var_640_6) / var_640_16

				arg_637_1.typewritter:SetDirty()
			end

			if arg_637_1.time_ >= var_640_6 + var_640_16 and arg_637_1.time_ < var_640_6 + var_640_16 + arg_640_0 then
				arg_637_1.typewritter.percent = 1

				arg_637_1.typewritter:SetDirty()
				arg_637_1:ShowNextGo(true)
			end
		end

		arg_637_1.nodeConfigList_ = {}

		arg_637_1:InitPlayNodeList()
	end,
	Play1104901156 = function(arg_641_0, arg_641_1)
		arg_641_1.time_ = 0
		arg_641_1.frameCnt_ = 0
		arg_641_1.state_ = "playing"
		arg_641_1.curTalkId_ = 1104901156
		arg_641_1.duration_ = 5

		SetActive(arg_641_1.tipsGo_, false)

		function arg_641_1.onSingleLineFinish_()
			arg_641_1.onSingleLineUpdate_ = nil
			arg_641_1.onSingleLineFinish_ = nil
			arg_641_1.state_ = "waiting"
		end

		function arg_641_1.playNext_(arg_643_0)
			if arg_643_0 == 1 then
				arg_641_0:Play1104901157(arg_641_1)
			end
		end

		function arg_641_1.onSingleLineUpdate_(arg_644_0)
			local var_644_0 = 0
			local var_644_1 = 0.1

			if var_644_0 < arg_641_1.time_ and arg_641_1.time_ <= var_644_0 + arg_644_0 then
				arg_641_1.talkMaxDuration = 0
				arg_641_1.dialogCg_.alpha = 1

				arg_641_1.dialog_:SetActive(true)
				SetActive(arg_641_1.leftNameGo_, true)

				local var_644_2 = arg_641_1:FormatText(StoryNameCfg[7].name)

				arg_641_1.leftNameTxt_.text = var_644_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_641_1.leftNameTxt_.transform)

				arg_641_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_641_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_641_1:RecordName(arg_641_1.leftNameTxt_.text)
				SetActive(arg_641_1.iconTrs_.gameObject, true)
				arg_641_1.iconController_:SetSelectedState("hero")

				arg_641_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_641_1.callingController_:SetSelectedState("normal")

				arg_641_1.keyicon_.color = Color.New(1, 1, 1)
				arg_641_1.icon_.color = Color.New(1, 1, 1)

				local var_644_3 = arg_641_1:GetWordFromCfg(1104901156)
				local var_644_4 = arg_641_1:FormatText(var_644_3.content)

				arg_641_1.text_.text = var_644_4

				LuaForUtil.ClearLinePrefixSymbol(arg_641_1.text_)

				local var_644_5 = 4
				local var_644_6 = utf8.len(var_644_4)
				local var_644_7 = var_644_5 <= 0 and var_644_1 or var_644_1 * (var_644_6 / var_644_5)

				if var_644_7 > 0 and var_644_1 < var_644_7 then
					arg_641_1.talkMaxDuration = var_644_7

					if var_644_7 + var_644_0 > arg_641_1.duration_ then
						arg_641_1.duration_ = var_644_7 + var_644_0
					end
				end

				arg_641_1.text_.text = var_644_4
				arg_641_1.typewritter.percent = 0

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(false)
				arg_641_1:RecordContent(arg_641_1.text_.text)
			end

			local var_644_8 = math.max(var_644_1, arg_641_1.talkMaxDuration)

			if var_644_0 <= arg_641_1.time_ and arg_641_1.time_ < var_644_0 + var_644_8 then
				arg_641_1.typewritter.percent = (arg_641_1.time_ - var_644_0) / var_644_8

				arg_641_1.typewritter:SetDirty()
			end

			if arg_641_1.time_ >= var_644_0 + var_644_8 and arg_641_1.time_ < var_644_0 + var_644_8 + arg_644_0 then
				arg_641_1.typewritter.percent = 1

				arg_641_1.typewritter:SetDirty()
				arg_641_1:ShowNextGo(true)
			end
		end

		arg_641_1.nodeConfigList_ = {}

		arg_641_1:InitPlayNodeList()
	end,
	Play1104901157 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 1104901157
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play1104901158(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0
			local var_648_1 = 0.35

			if var_648_0 < arg_645_1.time_ and arg_645_1.time_ <= var_648_0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, false)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_2 = arg_645_1:GetWordFromCfg(1104901157)
				local var_648_3 = arg_645_1:FormatText(var_648_2.content)

				arg_645_1.text_.text = var_648_3

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_4 = 14
				local var_648_5 = utf8.len(var_648_3)
				local var_648_6 = var_648_4 <= 0 and var_648_1 or var_648_1 * (var_648_5 / var_648_4)

				if var_648_6 > 0 and var_648_1 < var_648_6 then
					arg_645_1.talkMaxDuration = var_648_6

					if var_648_6 + var_648_0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_6 + var_648_0
					end
				end

				arg_645_1.text_.text = var_648_3
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_7 = math.max(var_648_1, arg_645_1.talkMaxDuration)

			if var_648_0 <= arg_645_1.time_ and arg_645_1.time_ < var_648_0 + var_648_7 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - var_648_0) / var_648_7

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= var_648_0 + var_648_7 and arg_645_1.time_ < var_648_0 + var_648_7 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play1104901158 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 1104901158
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
			arg_649_1.auto_ = false
		end

		function arg_649_1.playNext_(arg_651_0)
			arg_649_1.onStoryFinished_()
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 0
			local var_652_1 = 0.4

			if var_652_0 < arg_649_1.time_ and arg_649_1.time_ <= var_652_0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, true)

				local var_652_2 = arg_649_1:FormatText(StoryNameCfg[7].name)

				arg_649_1.leftNameTxt_.text = var_652_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_649_1.leftNameTxt_.transform)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1.leftNameTxt_.text)
				SetActive(arg_649_1.iconTrs_.gameObject, true)
				arg_649_1.iconController_:SetSelectedState("hero")

				arg_649_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_649_1.callingController_:SetSelectedState("normal")

				arg_649_1.keyicon_.color = Color.New(1, 1, 1)
				arg_649_1.icon_.color = Color.New(1, 1, 1)

				local var_652_3 = arg_649_1:GetWordFromCfg(1104901158)
				local var_652_4 = arg_649_1:FormatText(var_652_3.content)

				arg_649_1.text_.text = var_652_4

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_5 = 16
				local var_652_6 = utf8.len(var_652_4)
				local var_652_7 = var_652_5 <= 0 and var_652_1 or var_652_1 * (var_652_6 / var_652_5)

				if var_652_7 > 0 and var_652_1 < var_652_7 then
					arg_649_1.talkMaxDuration = var_652_7

					if var_652_7 + var_652_0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_7 + var_652_0
					end
				end

				arg_649_1.text_.text = var_652_4
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_8 = math.max(var_652_1, arg_649_1.talkMaxDuration)

			if var_652_0 <= arg_649_1.time_ and arg_649_1.time_ < var_652_0 + var_652_8 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - var_652_0) / var_652_8

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= var_652_0 + var_652_8 and arg_649_1.time_ < var_652_0 + var_652_8 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K11g",
		"TextureConfig/Background/K01h",
		"TextureConfig/Background/I02",
		"TextureConfig/Background/ST11",
		"TextureConfig/Background/ST06",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST05a"
	},
	voices = {
		"story_v_side_new_1104901.awb"
	}
}
