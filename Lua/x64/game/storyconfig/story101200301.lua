return {
	Play120031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120031001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play120031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_1 = 2

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				local var_4_2 = (arg_1_1.time_ - var_4_0) / var_4_1
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = Mathf.Lerp(1, 0, var_4_2)
				arg_1_1.mask_.color = var_4_3
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				local var_4_4 = Color.New(0, 0, 0)
				local var_4_5 = 0

				arg_1_1.mask_.enabled = false
				var_4_4.a = var_4_5
				arg_1_1.mask_.color = var_4_4
			end

			local var_4_6 = "STblack"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = 0

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				local var_4_9 = manager.ui.mainCamera.transform.localPosition
				local var_4_10 = Vector3.New(0, 0, 10) + Vector3.New(var_4_9.x, var_4_9.y, 0)
				local var_4_11 = arg_1_1.bgs_.STblack

				var_4_11.transform.localPosition = var_4_10
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = (var_4_11.transform.localPosition - var_4_9).z
					local var_4_14 = manager.ui.mainCameraCom_
					local var_4_15 = 2 * var_4_13 * Mathf.Tan(var_4_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_16 = var_4_15 * var_4_14.aspect
					local var_4_17 = var_4_12.sprite.bounds.size.x
					local var_4_18 = var_4_12.sprite.bounds.size.y
					local var_4_19 = var_4_16 / var_4_17
					local var_4_20 = var_4_15 / var_4_18
					local var_4_21 = var_4_20 < var_4_19 and var_4_19 or var_4_20

					var_4_11.transform.localScale = Vector3.New(var_4_21, var_4_21, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_22 = 0
			local var_4_23 = 1

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 1.999999999999
			local var_4_29 = 0.75

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_30 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_30:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_31 = arg_1_1:GetWordFromCfg(120031001)
				local var_4_32 = arg_1_1:FormatText(var_4_31.content)

				arg_1_1.text_.text = var_4_32

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 30
				local var_4_34 = utf8.len(var_4_32)
				local var_4_35 = var_4_33 <= 0 and var_4_29 or var_4_29 * (var_4_34 / var_4_33)

				if var_4_35 > 0 and var_4_29 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_28 = var_4_28 + 0.3

					if var_4_35 + var_4_28 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_28
					end
				end

				arg_1_1.text_.text = var_4_32
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_28 + 0.3
			local var_4_37 = math.max(var_4_29, arg_1_1.talkMaxDuration)

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play120031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 120031002
		arg_8_1.duration_ = 7

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play120031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_120_00", "se_story_120_00_door", "")
			end

			local var_11_4 = 0

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_5 = 2

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_5 then
				local var_11_6 = (arg_8_1.time_ - var_11_4) / var_11_5
				local var_11_7 = Color.New(0, 0, 0)

				var_11_7.a = Mathf.Lerp(1, 0, var_11_6)
				arg_8_1.mask_.color = var_11_7
			end

			if arg_8_1.time_ >= var_11_4 + var_11_5 and arg_8_1.time_ < var_11_4 + var_11_5 + arg_11_0 then
				local var_11_8 = Color.New(0, 0, 0)
				local var_11_9 = 0

				arg_8_1.mask_.enabled = false
				var_11_8.a = var_11_9
				arg_8_1.mask_.color = var_11_8
			end

			local var_11_10 = "J02f"

			if arg_8_1.bgs_[var_11_10] == nil then
				local var_11_11 = Object.Instantiate(arg_8_1.paintGo_)

				var_11_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_11_10)
				var_11_11.name = var_11_10
				var_11_11.transform.parent = arg_8_1.stage_.transform
				var_11_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_[var_11_10] = var_11_11
			end

			local var_11_12 = 0

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 then
				local var_11_13 = manager.ui.mainCamera.transform.localPosition
				local var_11_14 = Vector3.New(0, 0, 10) + Vector3.New(var_11_13.x, var_11_13.y, 0)
				local var_11_15 = arg_8_1.bgs_.J02f

				var_11_15.transform.localPosition = var_11_14
				var_11_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_11_16 = var_11_15:GetComponent("SpriteRenderer")

				if var_11_16 and var_11_16.sprite then
					local var_11_17 = (var_11_15.transform.localPosition - var_11_13).z
					local var_11_18 = manager.ui.mainCameraCom_
					local var_11_19 = 2 * var_11_17 * Mathf.Tan(var_11_18.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_11_20 = var_11_19 * var_11_18.aspect
					local var_11_21 = var_11_16.sprite.bounds.size.x
					local var_11_22 = var_11_16.sprite.bounds.size.y
					local var_11_23 = var_11_20 / var_11_21
					local var_11_24 = var_11_19 / var_11_22
					local var_11_25 = var_11_24 < var_11_23 and var_11_23 or var_11_24

					var_11_15.transform.localScale = Vector3.New(var_11_25, var_11_25, 0)
				end

				for iter_11_0, iter_11_1 in pairs(arg_8_1.bgs_) do
					if iter_11_0 ~= "J02f" then
						iter_11_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_8_1.frameCnt_ <= 1 then
				arg_8_1.dialog_:SetActive(false)
			end

			local var_11_26 = 2
			local var_11_27 = 0.8

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				arg_8_1.dialog_:SetActive(true)

				arg_8_1.dialogCg_.alpha = 0

				local var_11_28 = LeanTween.value(arg_8_1.dialog_, 0, 1, 0.3)

				var_11_28:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
					arg_8_1.dialogCg_.alpha = arg_12_0
				end))
				var_11_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_8_1.dialog_)
					var_11_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_8_1.duration_ = arg_8_1.duration_ + 0.3

				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_29 = arg_8_1:GetWordFromCfg(120031002)
				local var_11_30 = arg_8_1:FormatText(var_11_29.content)

				arg_8_1.text_.text = var_11_30

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_31 = 32
				local var_11_32 = utf8.len(var_11_30)
				local var_11_33 = var_11_31 <= 0 and var_11_27 or var_11_27 * (var_11_32 / var_11_31)

				if var_11_33 > 0 and var_11_27 < var_11_33 then
					arg_8_1.talkMaxDuration = var_11_33
					var_11_26 = var_11_26 + 0.3

					if var_11_33 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_33 + var_11_26
					end
				end

				arg_8_1.text_.text = var_11_30
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_34 = var_11_26 + 0.3
			local var_11_35 = math.max(var_11_27, arg_8_1.talkMaxDuration)

			if var_11_34 <= arg_8_1.time_ and arg_8_1.time_ < var_11_34 + var_11_35 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_34) / var_11_35

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_34 + var_11_35 and arg_8_1.time_ < var_11_34 + var_11_35 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play120031003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 120031003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play120031004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 0.1

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_2 = arg_14_1:FormatText(StoryNameCfg[7].name)

				arg_14_1.leftNameTxt_.text = var_17_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, true)
				arg_14_1.iconController_:SetSelectedState("hero")

				arg_14_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_14_1.callingController_:SetSelectedState("normal")

				arg_14_1.keyicon_.color = Color.New(1, 1, 1)
				arg_14_1.icon_.color = Color.New(1, 1, 1)

				local var_17_3 = arg_14_1:GetWordFromCfg(120031003)
				local var_17_4 = arg_14_1:FormatText(var_17_3.content)

				arg_14_1.text_.text = var_17_4

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_5 = 4
				local var_17_6 = utf8.len(var_17_4)
				local var_17_7 = var_17_5 <= 0 and var_17_1 or var_17_1 * (var_17_6 / var_17_5)

				if var_17_7 > 0 and var_17_1 < var_17_7 then
					arg_14_1.talkMaxDuration = var_17_7

					if var_17_7 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_7 + var_17_0
					end
				end

				arg_14_1.text_.text = var_17_4
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_8 = math.max(var_17_1, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_8 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_0) / var_17_8

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_8 and arg_14_1.time_ < var_17_0 + var_17_8 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play120031004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 120031004
		arg_18_1.duration_ = 11.57

		local var_18_0 = {
			zh = 9.233,
			ja = 11.566
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play120031005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = "1075ui_story"

			if arg_18_1.actors_[var_21_0] == nil then
				local var_21_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_21_1) then
					local var_21_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_18_1.stage_.transform)

					var_21_2.name = var_21_0
					var_21_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_18_1.actors_[var_21_0] = var_21_2

					local var_21_3 = var_21_2:GetComponentInChildren(typeof(CharacterEffect))

					var_21_3.enabled = true

					local var_21_4 = GameObjectTools.GetOrAddComponent(var_21_2, typeof(DynamicBoneHelper))

					if var_21_4 then
						var_21_4:EnableDynamicBone(false)
					end

					arg_18_1:ShowWeapon(var_21_3.transform, false)

					arg_18_1.var_[var_21_0 .. "Animator"] = var_21_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_18_1.var_[var_21_0 .. "Animator"].applyRootMotion = true
					arg_18_1.var_[var_21_0 .. "LipSync"] = var_21_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_21_5 = arg_18_1.actors_["1075ui_story"].transform
			local var_21_6 = 0

			if var_21_6 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.var_.moveOldPos1075ui_story = var_21_5.localPosition
			end

			local var_21_7 = 0.001

			if var_21_6 <= arg_18_1.time_ and arg_18_1.time_ < var_21_6 + var_21_7 then
				local var_21_8 = (arg_18_1.time_ - var_21_6) / var_21_7
				local var_21_9 = Vector3.New(0, -1.055, -6.16)

				var_21_5.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1075ui_story, var_21_9, var_21_8)

				local var_21_10 = manager.ui.mainCamera.transform.position - var_21_5.position

				var_21_5.forward = Vector3.New(var_21_10.x, var_21_10.y, var_21_10.z)

				local var_21_11 = var_21_5.localEulerAngles

				var_21_11.z = 0
				var_21_11.x = 0
				var_21_5.localEulerAngles = var_21_11
			end

			if arg_18_1.time_ >= var_21_6 + var_21_7 and arg_18_1.time_ < var_21_6 + var_21_7 + arg_21_0 then
				var_21_5.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_21_12 = manager.ui.mainCamera.transform.position - var_21_5.position

				var_21_5.forward = Vector3.New(var_21_12.x, var_21_12.y, var_21_12.z)

				local var_21_13 = var_21_5.localEulerAngles

				var_21_13.z = 0
				var_21_13.x = 0
				var_21_5.localEulerAngles = var_21_13
			end

			local var_21_14 = arg_18_1.actors_["1075ui_story"]
			local var_21_15 = 0

			if var_21_15 < arg_18_1.time_ and arg_18_1.time_ <= var_21_15 + arg_21_0 and not isNil(var_21_14) and arg_18_1.var_.characterEffect1075ui_story == nil then
				arg_18_1.var_.characterEffect1075ui_story = var_21_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_16 = 0.2

			if var_21_15 <= arg_18_1.time_ and arg_18_1.time_ < var_21_15 + var_21_16 and not isNil(var_21_14) then
				local var_21_17 = (arg_18_1.time_ - var_21_15) / var_21_16

				if arg_18_1.var_.characterEffect1075ui_story and not isNil(var_21_14) then
					arg_18_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_15 + var_21_16 and arg_18_1.time_ < var_21_15 + var_21_16 + arg_21_0 and not isNil(var_21_14) and arg_18_1.var_.characterEffect1075ui_story then
				arg_18_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_21_18 = 0

			if var_21_18 < arg_18_1.time_ and arg_18_1.time_ <= var_21_18 + arg_21_0 then
				arg_18_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_21_19 = 0

			if var_21_19 < arg_18_1.time_ and arg_18_1.time_ <= var_21_19 + arg_21_0 then
				arg_18_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			local var_21_20 = 0
			local var_21_21 = 0.2

			if var_21_20 < arg_18_1.time_ and arg_18_1.time_ <= var_21_20 + arg_21_0 then
				local var_21_22 = "play"
				local var_21_23 = "music"

				arg_18_1:AudioAction(var_21_22, var_21_23, "ui_battle", "ui_battle_stopbgm", "")

				local var_21_24 = ""
				local var_21_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_21_25 ~= "" then
					if arg_18_1.bgmTxt_.text ~= var_21_25 and arg_18_1.bgmTxt_.text ~= "" then
						if arg_18_1.bgmTxt2_.text ~= "" then
							arg_18_1.bgmTxt_.text = arg_18_1.bgmTxt2_.text
						end

						arg_18_1.bgmTxt2_.text = var_21_25

						arg_18_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_18_1.bgmTxt_.text = var_21_25
						arg_18_1.bgmTxt2_.text = var_21_25
					end

					if arg_18_1.bgmTimer then
						arg_18_1.bgmTimer:Stop()

						arg_18_1.bgmTimer = nil
					end

					if arg_18_1.settingData.show_music_name == 1 then
						arg_18_1.musicController:SetSelectedState("show")
						arg_18_1.musicAnimator_:Play("open", 0, 0)

						if arg_18_1.settingData.music_time ~= 0 then
							arg_18_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_18_1.settingData.music_time), function()
								if arg_18_1 == nil or isNil(arg_18_1.bgmTxt_) then
									return
								end

								arg_18_1.musicController:SetSelectedState("hide")
								arg_18_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_21_26 = 0.3
			local var_21_27 = 1

			if var_21_26 < arg_18_1.time_ and arg_18_1.time_ <= var_21_26 + arg_21_0 then
				local var_21_28 = "play"
				local var_21_29 = "music"

				arg_18_1:AudioAction(var_21_28, var_21_29, "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_21_30 = ""
				local var_21_31 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

				if var_21_31 ~= "" then
					if arg_18_1.bgmTxt_.text ~= var_21_31 and arg_18_1.bgmTxt_.text ~= "" then
						if arg_18_1.bgmTxt2_.text ~= "" then
							arg_18_1.bgmTxt_.text = arg_18_1.bgmTxt2_.text
						end

						arg_18_1.bgmTxt2_.text = var_21_31

						arg_18_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_18_1.bgmTxt_.text = var_21_31
						arg_18_1.bgmTxt2_.text = var_21_31
					end

					if arg_18_1.bgmTimer then
						arg_18_1.bgmTimer:Stop()

						arg_18_1.bgmTimer = nil
					end

					if arg_18_1.settingData.show_music_name == 1 then
						arg_18_1.musicController:SetSelectedState("show")
						arg_18_1.musicAnimator_:Play("open", 0, 0)

						if arg_18_1.settingData.music_time ~= 0 then
							arg_18_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_18_1.settingData.music_time), function()
								if arg_18_1 == nil or isNil(arg_18_1.bgmTxt_) then
									return
								end

								arg_18_1.musicController:SetSelectedState("hide")
								arg_18_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_21_32 = 0
			local var_21_33 = 0.85

			if var_21_32 < arg_18_1.time_ and arg_18_1.time_ <= var_21_32 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_34 = arg_18_1:FormatText(StoryNameCfg[381].name)

				arg_18_1.leftNameTxt_.text = var_21_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_35 = arg_18_1:GetWordFromCfg(120031004)
				local var_21_36 = arg_18_1:FormatText(var_21_35.content)

				arg_18_1.text_.text = var_21_36

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_37 = 34
				local var_21_38 = utf8.len(var_21_36)
				local var_21_39 = var_21_37 <= 0 and var_21_33 or var_21_33 * (var_21_38 / var_21_37)

				if var_21_39 > 0 and var_21_33 < var_21_39 then
					arg_18_1.talkMaxDuration = var_21_39

					if var_21_39 + var_21_32 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_39 + var_21_32
					end
				end

				arg_18_1.text_.text = var_21_36
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031004", "story_v_out_120031.awb") ~= 0 then
					local var_21_40 = manager.audio:GetVoiceLength("story_v_out_120031", "120031004", "story_v_out_120031.awb") / 1000

					if var_21_40 + var_21_32 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_40 + var_21_32
					end

					if var_21_35.prefab_name ~= "" and arg_18_1.actors_[var_21_35.prefab_name] ~= nil then
						local var_21_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_35.prefab_name].transform, "story_v_out_120031", "120031004", "story_v_out_120031.awb")

						arg_18_1:RecordAudio("120031004", var_21_41)
						arg_18_1:RecordAudio("120031004", var_21_41)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_120031", "120031004", "story_v_out_120031.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_120031", "120031004", "story_v_out_120031.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_42 = math.max(var_21_33, arg_18_1.talkMaxDuration)

			if var_21_32 <= arg_18_1.time_ and arg_18_1.time_ < var_21_32 + var_21_42 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_32) / var_21_42

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_32 + var_21_42 and arg_18_1.time_ < var_21_32 + var_21_42 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play120031005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 120031005
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play120031006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1075ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1075ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1075ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = 0
			local var_27_10 = 0.75

			if var_27_9 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_11 = arg_24_1:GetWordFromCfg(120031005)
				local var_27_12 = arg_24_1:FormatText(var_27_11.content)

				arg_24_1.text_.text = var_27_12

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 30
				local var_27_14 = utf8.len(var_27_12)
				local var_27_15 = var_27_13 <= 0 and var_27_10 or var_27_10 * (var_27_14 / var_27_13)

				if var_27_15 > 0 and var_27_10 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_9 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_9
					end
				end

				arg_24_1.text_.text = var_27_12
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_10, arg_24_1.talkMaxDuration)

			if var_27_9 <= arg_24_1.time_ and arg_24_1.time_ < var_27_9 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_9) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_9 + var_27_16 and arg_24_1.time_ < var_27_9 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play120031006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 120031006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play120031007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1.375

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

				local var_31_2 = arg_28_1:GetWordFromCfg(120031006)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 55
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
	Play120031007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 120031007
		arg_32_1.duration_ = 4.03

		local var_32_0 = {
			zh = 1.999999999999,
			ja = 4.033
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
				arg_32_0:Play120031008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = "1084ui_story"

			if arg_32_1.actors_[var_35_0] == nil then
				local var_35_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_35_1) then
					local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_32_1.stage_.transform)

					var_35_2.name = var_35_0
					var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_32_1.actors_[var_35_0] = var_35_2

					local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

					var_35_3.enabled = true

					local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

					if var_35_4 then
						var_35_4:EnableDynamicBone(false)
					end

					arg_32_1:ShowWeapon(var_35_3.transform, false)

					arg_32_1.var_[var_35_0 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_32_1.var_[var_35_0 .. "Animator"].applyRootMotion = true
					arg_32_1.var_[var_35_0 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_35_5 = arg_32_1.actors_["1084ui_story"].transform
			local var_35_6 = 0

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = var_35_5.localPosition
			end

			local var_35_7 = 0.001

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_7 then
				local var_35_8 = (arg_32_1.time_ - var_35_6) / var_35_7
				local var_35_9 = Vector3.New(-0.7, -0.97, -6)

				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, var_35_9, var_35_8)

				local var_35_10 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_10.x, var_35_10.y, var_35_10.z)

				local var_35_11 = var_35_5.localEulerAngles

				var_35_11.z = 0
				var_35_11.x = 0
				var_35_5.localEulerAngles = var_35_11
			end

			if arg_32_1.time_ >= var_35_6 + var_35_7 and arg_32_1.time_ < var_35_6 + var_35_7 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_5.position

				var_35_5.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_5.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_5.localEulerAngles = var_35_13
			end

			local var_35_14 = arg_32_1.actors_["1084ui_story"]
			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect1084ui_story == nil then
				arg_32_1.var_.characterEffect1084ui_story = var_35_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_16 = 0.2

			if var_35_15 <= arg_32_1.time_ and arg_32_1.time_ < var_35_15 + var_35_16 and not isNil(var_35_14) then
				local var_35_17 = (arg_32_1.time_ - var_35_15) / var_35_16

				if arg_32_1.var_.characterEffect1084ui_story and not isNil(var_35_14) then
					arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_15 + var_35_16 and arg_32_1.time_ < var_35_15 + var_35_16 + arg_35_0 and not isNil(var_35_14) and arg_32_1.var_.characterEffect1084ui_story then
				arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_35_18 = arg_32_1.actors_["1075ui_story"].transform
			local var_35_19 = 0

			if var_35_19 < arg_32_1.time_ and arg_32_1.time_ <= var_35_19 + arg_35_0 then
				arg_32_1.var_.moveOldPos1075ui_story = var_35_18.localPosition
			end

			local var_35_20 = 0.001

			if var_35_19 <= arg_32_1.time_ and arg_32_1.time_ < var_35_19 + var_35_20 then
				local var_35_21 = (arg_32_1.time_ - var_35_19) / var_35_20
				local var_35_22 = Vector3.New(0.7, -1.055, -6.16)

				var_35_18.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1075ui_story, var_35_22, var_35_21)

				local var_35_23 = manager.ui.mainCamera.transform.position - var_35_18.position

				var_35_18.forward = Vector3.New(var_35_23.x, var_35_23.y, var_35_23.z)

				local var_35_24 = var_35_18.localEulerAngles

				var_35_24.z = 0
				var_35_24.x = 0
				var_35_18.localEulerAngles = var_35_24
			end

			if arg_32_1.time_ >= var_35_19 + var_35_20 and arg_32_1.time_ < var_35_19 + var_35_20 + arg_35_0 then
				var_35_18.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_35_25 = manager.ui.mainCamera.transform.position - var_35_18.position

				var_35_18.forward = Vector3.New(var_35_25.x, var_35_25.y, var_35_25.z)

				local var_35_26 = var_35_18.localEulerAngles

				var_35_26.z = 0
				var_35_26.x = 0
				var_35_18.localEulerAngles = var_35_26
			end

			local var_35_27 = arg_32_1.actors_["1075ui_story"]
			local var_35_28 = 0

			if var_35_28 < arg_32_1.time_ and arg_32_1.time_ <= var_35_28 + arg_35_0 and not isNil(var_35_27) and arg_32_1.var_.characterEffect1075ui_story == nil then
				arg_32_1.var_.characterEffect1075ui_story = var_35_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_29 = 0.0166666666666667

			if var_35_28 <= arg_32_1.time_ and arg_32_1.time_ < var_35_28 + var_35_29 and not isNil(var_35_27) then
				local var_35_30 = (arg_32_1.time_ - var_35_28) / var_35_29

				if arg_32_1.var_.characterEffect1075ui_story and not isNil(var_35_27) then
					local var_35_31 = Mathf.Lerp(0, 0.5, var_35_30)

					arg_32_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1075ui_story.fillRatio = var_35_31
				end
			end

			if arg_32_1.time_ >= var_35_28 + var_35_29 and arg_32_1.time_ < var_35_28 + var_35_29 + arg_35_0 and not isNil(var_35_27) and arg_32_1.var_.characterEffect1075ui_story then
				local var_35_32 = 0.5

				arg_32_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1075ui_story.fillRatio = var_35_32
			end

			local var_35_33 = 0

			if var_35_33 < arg_32_1.time_ and arg_32_1.time_ <= var_35_33 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_35_34 = 0

			if var_35_34 < arg_32_1.time_ and arg_32_1.time_ <= var_35_34 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_35 = 0
			local var_35_36 = 0.15

			if var_35_35 < arg_32_1.time_ and arg_32_1.time_ <= var_35_35 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_37 = arg_32_1:FormatText(StoryNameCfg[6].name)

				arg_32_1.leftNameTxt_.text = var_35_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_38 = arg_32_1:GetWordFromCfg(120031007)
				local var_35_39 = arg_32_1:FormatText(var_35_38.content)

				arg_32_1.text_.text = var_35_39

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_40 = 6
				local var_35_41 = utf8.len(var_35_39)
				local var_35_42 = var_35_40 <= 0 and var_35_36 or var_35_36 * (var_35_41 / var_35_40)

				if var_35_42 > 0 and var_35_36 < var_35_42 then
					arg_32_1.talkMaxDuration = var_35_42

					if var_35_42 + var_35_35 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_42 + var_35_35
					end
				end

				arg_32_1.text_.text = var_35_39
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031007", "story_v_out_120031.awb") ~= 0 then
					local var_35_43 = manager.audio:GetVoiceLength("story_v_out_120031", "120031007", "story_v_out_120031.awb") / 1000

					if var_35_43 + var_35_35 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_43 + var_35_35
					end

					if var_35_38.prefab_name ~= "" and arg_32_1.actors_[var_35_38.prefab_name] ~= nil then
						local var_35_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_38.prefab_name].transform, "story_v_out_120031", "120031007", "story_v_out_120031.awb")

						arg_32_1:RecordAudio("120031007", var_35_44)
						arg_32_1:RecordAudio("120031007", var_35_44)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_120031", "120031007", "story_v_out_120031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_120031", "120031007", "story_v_out_120031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_45 = math.max(var_35_36, arg_32_1.talkMaxDuration)

			if var_35_35 <= arg_32_1.time_ and arg_32_1.time_ < var_35_35 + var_35_45 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_35) / var_35_45

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_35 + var_35_45 and arg_32_1.time_ < var_35_35 + var_35_45 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play120031008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 120031008
		arg_36_1.duration_ = 10.1

		local var_36_0 = {
			zh = 10.1,
			ja = 9.933
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play120031009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1075ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1075ui_story == nil then
				arg_36_1.var_.characterEffect1075ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1075ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1075ui_story then
				arg_36_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1084ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.2

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1084ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1084ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1084ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_2")
			end

			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_39_12 = 0
			local var_39_13 = 1.1

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_14 = arg_36_1:FormatText(StoryNameCfg[381].name)

				arg_36_1.leftNameTxt_.text = var_39_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_15 = arg_36_1:GetWordFromCfg(120031008)
				local var_39_16 = arg_36_1:FormatText(var_39_15.content)

				arg_36_1.text_.text = var_39_16

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 44
				local var_39_18 = utf8.len(var_39_16)
				local var_39_19 = var_39_17 <= 0 and var_39_13 or var_39_13 * (var_39_18 / var_39_17)

				if var_39_19 > 0 and var_39_13 < var_39_19 then
					arg_36_1.talkMaxDuration = var_39_19

					if var_39_19 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_19 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_16
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031008", "story_v_out_120031.awb") ~= 0 then
					local var_39_20 = manager.audio:GetVoiceLength("story_v_out_120031", "120031008", "story_v_out_120031.awb") / 1000

					if var_39_20 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_20 + var_39_12
					end

					if var_39_15.prefab_name ~= "" and arg_36_1.actors_[var_39_15.prefab_name] ~= nil then
						local var_39_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_15.prefab_name].transform, "story_v_out_120031", "120031008", "story_v_out_120031.awb")

						arg_36_1:RecordAudio("120031008", var_39_21)
						arg_36_1:RecordAudio("120031008", var_39_21)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_120031", "120031008", "story_v_out_120031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_120031", "120031008", "story_v_out_120031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_22 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_22 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_22

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_22 and arg_36_1.time_ < var_39_12 + var_39_22 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play120031009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 120031009
		arg_40_1.duration_ = 3.5

		local var_40_0 = {
			zh = 1.999999999999,
			ja = 3.5
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play120031010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1084ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1075ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1075ui_story == nil then
				arg_40_1.var_.characterEffect1075ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.2

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1075ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1075ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1075ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1075ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_43_12 = 0
			local var_43_13 = 0.2

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_14 = arg_40_1:FormatText(StoryNameCfg[6].name)

				arg_40_1.leftNameTxt_.text = var_43_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:GetWordFromCfg(120031009)
				local var_43_16 = arg_40_1:FormatText(var_43_15.content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 8
				local var_43_18 = utf8.len(var_43_16)
				local var_43_19 = var_43_17 <= 0 and var_43_13 or var_43_13 * (var_43_18 / var_43_17)

				if var_43_19 > 0 and var_43_13 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031009", "story_v_out_120031.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_120031", "120031009", "story_v_out_120031.awb") / 1000

					if var_43_20 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_12
					end

					if var_43_15.prefab_name ~= "" and arg_40_1.actors_[var_43_15.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_15.prefab_name].transform, "story_v_out_120031", "120031009", "story_v_out_120031.awb")

						arg_40_1:RecordAudio("120031009", var_43_21)
						arg_40_1:RecordAudio("120031009", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_120031", "120031009", "story_v_out_120031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_120031", "120031009", "story_v_out_120031.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_22 and arg_40_1.time_ < var_43_12 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play120031010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 120031010
		arg_44_1.duration_ = 9.7

		local var_44_0 = {
			zh = 9.7,
			ja = 6.466
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play120031011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1075ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1075ui_story == nil then
				arg_44_1.var_.characterEffect1075ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1075ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1075ui_story then
				arg_44_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1084ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.2

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1084ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1084ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1084ui_story.fillRatio = var_47_9
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_47_11 = 0
			local var_47_12 = 0.975

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_13 = arg_44_1:FormatText(StoryNameCfg[381].name)

				arg_44_1.leftNameTxt_.text = var_47_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_14 = arg_44_1:GetWordFromCfg(120031010)
				local var_47_15 = arg_44_1:FormatText(var_47_14.content)

				arg_44_1.text_.text = var_47_15

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_16 = 39
				local var_47_17 = utf8.len(var_47_15)
				local var_47_18 = var_47_16 <= 0 and var_47_12 or var_47_12 * (var_47_17 / var_47_16)

				if var_47_18 > 0 and var_47_12 < var_47_18 then
					arg_44_1.talkMaxDuration = var_47_18

					if var_47_18 + var_47_11 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_11
					end
				end

				arg_44_1.text_.text = var_47_15
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031010", "story_v_out_120031.awb") ~= 0 then
					local var_47_19 = manager.audio:GetVoiceLength("story_v_out_120031", "120031010", "story_v_out_120031.awb") / 1000

					if var_47_19 + var_47_11 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_11
					end

					if var_47_14.prefab_name ~= "" and arg_44_1.actors_[var_47_14.prefab_name] ~= nil then
						local var_47_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_14.prefab_name].transform, "story_v_out_120031", "120031010", "story_v_out_120031.awb")

						arg_44_1:RecordAudio("120031010", var_47_20)
						arg_44_1:RecordAudio("120031010", var_47_20)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_120031", "120031010", "story_v_out_120031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_120031", "120031010", "story_v_out_120031.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_21 = math.max(var_47_12, arg_44_1.talkMaxDuration)

			if var_47_11 <= arg_44_1.time_ and arg_44_1.time_ < var_47_11 + var_47_21 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_11) / var_47_21

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_11 + var_47_21 and arg_44_1.time_ < var_47_11 + var_47_21 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play120031011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 120031011
		arg_48_1.duration_ = 8.13

		local var_48_0 = {
			zh = 7.266,
			ja = 8.133
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
				arg_48_0:Play120031012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1084ui_story"].transform
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_0.localPosition
			end

			local var_51_2 = 0.001

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2
				local var_51_4 = Vector3.New(0, 100, 0)

				var_51_0.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, var_51_4, var_51_3)

				local var_51_5 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_5.x, var_51_5.y, var_51_5.z)

				local var_51_6 = var_51_0.localEulerAngles

				var_51_6.z = 0
				var_51_6.x = 0
				var_51_0.localEulerAngles = var_51_6
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 then
				var_51_0.localPosition = Vector3.New(0, 100, 0)

				local var_51_7 = manager.ui.mainCamera.transform.position - var_51_0.position

				var_51_0.forward = Vector3.New(var_51_7.x, var_51_7.y, var_51_7.z)

				local var_51_8 = var_51_0.localEulerAngles

				var_51_8.z = 0
				var_51_8.x = 0
				var_51_0.localEulerAngles = var_51_8
			end

			local var_51_9 = "1069ui_story"

			if arg_48_1.actors_[var_51_9] == nil then
				local var_51_10 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_51_10) then
					local var_51_11 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_48_1.stage_.transform)

					var_51_11.name = var_51_9
					var_51_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_48_1.actors_[var_51_9] = var_51_11

					local var_51_12 = var_51_11:GetComponentInChildren(typeof(CharacterEffect))

					var_51_12.enabled = true

					local var_51_13 = GameObjectTools.GetOrAddComponent(var_51_11, typeof(DynamicBoneHelper))

					if var_51_13 then
						var_51_13:EnableDynamicBone(false)
					end

					arg_48_1:ShowWeapon(var_51_12.transform, false)

					arg_48_1.var_[var_51_9 .. "Animator"] = var_51_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_48_1.var_[var_51_9 .. "Animator"].applyRootMotion = true
					arg_48_1.var_[var_51_9 .. "LipSync"] = var_51_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_51_14 = arg_48_1.actors_["1069ui_story"].transform
			local var_51_15 = 0

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.var_.moveOldPos1069ui_story = var_51_14.localPosition
			end

			local var_51_16 = 0.001

			if var_51_15 <= arg_48_1.time_ and arg_48_1.time_ < var_51_15 + var_51_16 then
				local var_51_17 = (arg_48_1.time_ - var_51_15) / var_51_16
				local var_51_18 = Vector3.New(-0.7, -1, -6)

				var_51_14.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1069ui_story, var_51_18, var_51_17)

				local var_51_19 = manager.ui.mainCamera.transform.position - var_51_14.position

				var_51_14.forward = Vector3.New(var_51_19.x, var_51_19.y, var_51_19.z)

				local var_51_20 = var_51_14.localEulerAngles

				var_51_20.z = 0
				var_51_20.x = 0
				var_51_14.localEulerAngles = var_51_20
			end

			if arg_48_1.time_ >= var_51_15 + var_51_16 and arg_48_1.time_ < var_51_15 + var_51_16 + arg_51_0 then
				var_51_14.localPosition = Vector3.New(-0.7, -1, -6)

				local var_51_21 = manager.ui.mainCamera.transform.position - var_51_14.position

				var_51_14.forward = Vector3.New(var_51_21.x, var_51_21.y, var_51_21.z)

				local var_51_22 = var_51_14.localEulerAngles

				var_51_22.z = 0
				var_51_22.x = 0
				var_51_14.localEulerAngles = var_51_22
			end

			local var_51_23 = arg_48_1.actors_["1069ui_story"]
			local var_51_24 = 0

			if var_51_24 < arg_48_1.time_ and arg_48_1.time_ <= var_51_24 + arg_51_0 and not isNil(var_51_23) and arg_48_1.var_.characterEffect1069ui_story == nil then
				arg_48_1.var_.characterEffect1069ui_story = var_51_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_25 = 0.2

			if var_51_24 <= arg_48_1.time_ and arg_48_1.time_ < var_51_24 + var_51_25 and not isNil(var_51_23) then
				local var_51_26 = (arg_48_1.time_ - var_51_24) / var_51_25

				if arg_48_1.var_.characterEffect1069ui_story and not isNil(var_51_23) then
					arg_48_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_24 + var_51_25 and arg_48_1.time_ < var_51_24 + var_51_25 + arg_51_0 and not isNil(var_51_23) and arg_48_1.var_.characterEffect1069ui_story then
				arg_48_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_51_27 = arg_48_1.actors_["1075ui_story"]
			local var_51_28 = 0

			if var_51_28 < arg_48_1.time_ and arg_48_1.time_ <= var_51_28 + arg_51_0 and not isNil(var_51_27) and arg_48_1.var_.characterEffect1075ui_story == nil then
				arg_48_1.var_.characterEffect1075ui_story = var_51_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_29 = 0.2

			if var_51_28 <= arg_48_1.time_ and arg_48_1.time_ < var_51_28 + var_51_29 and not isNil(var_51_27) then
				local var_51_30 = (arg_48_1.time_ - var_51_28) / var_51_29

				if arg_48_1.var_.characterEffect1075ui_story and not isNil(var_51_27) then
					local var_51_31 = Mathf.Lerp(0, 0.5, var_51_30)

					arg_48_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1075ui_story.fillRatio = var_51_31
				end
			end

			if arg_48_1.time_ >= var_51_28 + var_51_29 and arg_48_1.time_ < var_51_28 + var_51_29 + arg_51_0 and not isNil(var_51_27) and arg_48_1.var_.characterEffect1075ui_story then
				local var_51_32 = 0.5

				arg_48_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1075ui_story.fillRatio = var_51_32
			end

			local var_51_33 = 0

			if var_51_33 < arg_48_1.time_ and arg_48_1.time_ <= var_51_33 + arg_51_0 then
				arg_48_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			local var_51_34 = 0

			if var_51_34 < arg_48_1.time_ and arg_48_1.time_ <= var_51_34 + arg_51_0 then
				arg_48_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_51_35 = 0
			local var_51_36 = 0.725

			if var_51_35 < arg_48_1.time_ and arg_48_1.time_ <= var_51_35 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_37 = arg_48_1:FormatText(StoryNameCfg[378].name)

				arg_48_1.leftNameTxt_.text = var_51_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_38 = arg_48_1:GetWordFromCfg(120031011)
				local var_51_39 = arg_48_1:FormatText(var_51_38.content)

				arg_48_1.text_.text = var_51_39

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_40 = 29
				local var_51_41 = utf8.len(var_51_39)
				local var_51_42 = var_51_40 <= 0 and var_51_36 or var_51_36 * (var_51_41 / var_51_40)

				if var_51_42 > 0 and var_51_36 < var_51_42 then
					arg_48_1.talkMaxDuration = var_51_42

					if var_51_42 + var_51_35 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_42 + var_51_35
					end
				end

				arg_48_1.text_.text = var_51_39
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031011", "story_v_out_120031.awb") ~= 0 then
					local var_51_43 = manager.audio:GetVoiceLength("story_v_out_120031", "120031011", "story_v_out_120031.awb") / 1000

					if var_51_43 + var_51_35 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_43 + var_51_35
					end

					if var_51_38.prefab_name ~= "" and arg_48_1.actors_[var_51_38.prefab_name] ~= nil then
						local var_51_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_38.prefab_name].transform, "story_v_out_120031", "120031011", "story_v_out_120031.awb")

						arg_48_1:RecordAudio("120031011", var_51_44)
						arg_48_1:RecordAudio("120031011", var_51_44)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_120031", "120031011", "story_v_out_120031.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_120031", "120031011", "story_v_out_120031.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_45 = math.max(var_51_36, arg_48_1.talkMaxDuration)

			if var_51_35 <= arg_48_1.time_ and arg_48_1.time_ < var_51_35 + var_51_45 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_35) / var_51_45

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_35 + var_51_45 and arg_48_1.time_ < var_51_35 + var_51_45 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play120031012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 120031012
		arg_52_1.duration_ = 3.6

		local var_52_0 = {
			zh = 1.999999999999,
			ja = 3.6
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play120031013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1075ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1075ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, 100, 0)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1075ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, 100, 0)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = "10044ui_story"

			if arg_52_1.actors_[var_55_9] == nil then
				local var_55_10 = Asset.Load("Char/" .. "10044ui_story")

				if not isNil(var_55_10) then
					local var_55_11 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_52_1.stage_.transform)

					var_55_11.name = var_55_9
					var_55_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_52_1.actors_[var_55_9] = var_55_11

					local var_55_12 = var_55_11:GetComponentInChildren(typeof(CharacterEffect))

					var_55_12.enabled = true

					local var_55_13 = GameObjectTools.GetOrAddComponent(var_55_11, typeof(DynamicBoneHelper))

					if var_55_13 then
						var_55_13:EnableDynamicBone(false)
					end

					arg_52_1:ShowWeapon(var_55_12.transform, false)

					arg_52_1.var_[var_55_9 .. "Animator"] = var_55_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_52_1.var_[var_55_9 .. "Animator"].applyRootMotion = true
					arg_52_1.var_[var_55_9 .. "LipSync"] = var_55_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_55_14 = arg_52_1.actors_["10044ui_story"].transform
			local var_55_15 = 0

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.var_.moveOldPos10044ui_story = var_55_14.localPosition
			end

			local var_55_16 = 0.001

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_16 then
				local var_55_17 = (arg_52_1.time_ - var_55_15) / var_55_16
				local var_55_18 = Vector3.New(0.7, -0.72, -6.3)

				var_55_14.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10044ui_story, var_55_18, var_55_17)

				local var_55_19 = manager.ui.mainCamera.transform.position - var_55_14.position

				var_55_14.forward = Vector3.New(var_55_19.x, var_55_19.y, var_55_19.z)

				local var_55_20 = var_55_14.localEulerAngles

				var_55_20.z = 0
				var_55_20.x = 0
				var_55_14.localEulerAngles = var_55_20
			end

			if arg_52_1.time_ >= var_55_15 + var_55_16 and arg_52_1.time_ < var_55_15 + var_55_16 + arg_55_0 then
				var_55_14.localPosition = Vector3.New(0.7, -0.72, -6.3)

				local var_55_21 = manager.ui.mainCamera.transform.position - var_55_14.position

				var_55_14.forward = Vector3.New(var_55_21.x, var_55_21.y, var_55_21.z)

				local var_55_22 = var_55_14.localEulerAngles

				var_55_22.z = 0
				var_55_22.x = 0
				var_55_14.localEulerAngles = var_55_22
			end

			local var_55_23 = arg_52_1.actors_["10044ui_story"]
			local var_55_24 = 0

			if var_55_24 < arg_52_1.time_ and arg_52_1.time_ <= var_55_24 + arg_55_0 and not isNil(var_55_23) and arg_52_1.var_.characterEffect10044ui_story == nil then
				arg_52_1.var_.characterEffect10044ui_story = var_55_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_25 = 0.2

			if var_55_24 <= arg_52_1.time_ and arg_52_1.time_ < var_55_24 + var_55_25 and not isNil(var_55_23) then
				local var_55_26 = (arg_52_1.time_ - var_55_24) / var_55_25

				if arg_52_1.var_.characterEffect10044ui_story and not isNil(var_55_23) then
					arg_52_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_24 + var_55_25 and arg_52_1.time_ < var_55_24 + var_55_25 + arg_55_0 and not isNil(var_55_23) and arg_52_1.var_.characterEffect10044ui_story then
				arg_52_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_55_27 = arg_52_1.actors_["1069ui_story"]
			local var_55_28 = 0

			if var_55_28 < arg_52_1.time_ and arg_52_1.time_ <= var_55_28 + arg_55_0 and not isNil(var_55_27) and arg_52_1.var_.characterEffect1069ui_story == nil then
				arg_52_1.var_.characterEffect1069ui_story = var_55_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_29 = 0.2

			if var_55_28 <= arg_52_1.time_ and arg_52_1.time_ < var_55_28 + var_55_29 and not isNil(var_55_27) then
				local var_55_30 = (arg_52_1.time_ - var_55_28) / var_55_29

				if arg_52_1.var_.characterEffect1069ui_story and not isNil(var_55_27) then
					local var_55_31 = Mathf.Lerp(0, 0.5, var_55_30)

					arg_52_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1069ui_story.fillRatio = var_55_31
				end
			end

			if arg_52_1.time_ >= var_55_28 + var_55_29 and arg_52_1.time_ < var_55_28 + var_55_29 + arg_55_0 and not isNil(var_55_27) and arg_52_1.var_.characterEffect1069ui_story then
				local var_55_32 = 0.5

				arg_52_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1069ui_story.fillRatio = var_55_32
			end

			local var_55_33 = 0

			if var_55_33 < arg_52_1.time_ and arg_52_1.time_ <= var_55_33 + arg_55_0 then
				arg_52_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_1")
			end

			local var_55_34 = 0

			if var_55_34 < arg_52_1.time_ and arg_52_1.time_ <= var_55_34 + arg_55_0 then
				arg_52_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_55_35 = 0
			local var_55_36 = 0.125

			if var_55_35 < arg_52_1.time_ and arg_52_1.time_ <= var_55_35 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_37 = arg_52_1:FormatText(StoryNameCfg[380].name)

				arg_52_1.leftNameTxt_.text = var_55_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_38 = arg_52_1:GetWordFromCfg(120031012)
				local var_55_39 = arg_52_1:FormatText(var_55_38.content)

				arg_52_1.text_.text = var_55_39

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_40 = 5
				local var_55_41 = utf8.len(var_55_39)
				local var_55_42 = var_55_40 <= 0 and var_55_36 or var_55_36 * (var_55_41 / var_55_40)

				if var_55_42 > 0 and var_55_36 < var_55_42 then
					arg_52_1.talkMaxDuration = var_55_42

					if var_55_42 + var_55_35 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_42 + var_55_35
					end
				end

				arg_52_1.text_.text = var_55_39
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031012", "story_v_out_120031.awb") ~= 0 then
					local var_55_43 = manager.audio:GetVoiceLength("story_v_out_120031", "120031012", "story_v_out_120031.awb") / 1000

					if var_55_43 + var_55_35 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_43 + var_55_35
					end

					if var_55_38.prefab_name ~= "" and arg_52_1.actors_[var_55_38.prefab_name] ~= nil then
						local var_55_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_38.prefab_name].transform, "story_v_out_120031", "120031012", "story_v_out_120031.awb")

						arg_52_1:RecordAudio("120031012", var_55_44)
						arg_52_1:RecordAudio("120031012", var_55_44)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_120031", "120031012", "story_v_out_120031.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_120031", "120031012", "story_v_out_120031.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_45 = math.max(var_55_36, arg_52_1.talkMaxDuration)

			if var_55_35 <= arg_52_1.time_ and arg_52_1.time_ < var_55_35 + var_55_45 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_35) / var_55_45

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_35 + var_55_45 and arg_52_1.time_ < var_55_35 + var_55_45 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play120031013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 120031013
		arg_56_1.duration_ = 4

		local var_56_0 = {
			zh = 4,
			ja = 3.266
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play120031014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1069ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1069ui_story == nil then
				arg_56_1.var_.characterEffect1069ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1069ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1069ui_story then
				arg_56_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["10044ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect10044ui_story == nil then
				arg_56_1.var_.characterEffect10044ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.2

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect10044ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10044ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect10044ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10044ui_story.fillRatio = var_59_9
			end

			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action445")
			end

			local var_59_11 = 0

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_59_12 = 0
			local var_59_13 = 0.375

			if var_59_12 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_14 = arg_56_1:FormatText(StoryNameCfg[378].name)

				arg_56_1.leftNameTxt_.text = var_59_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_15 = arg_56_1:GetWordFromCfg(120031013)
				local var_59_16 = arg_56_1:FormatText(var_59_15.content)

				arg_56_1.text_.text = var_59_16

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_17 = 15
				local var_59_18 = utf8.len(var_59_16)
				local var_59_19 = var_59_17 <= 0 and var_59_13 or var_59_13 * (var_59_18 / var_59_17)

				if var_59_19 > 0 and var_59_13 < var_59_19 then
					arg_56_1.talkMaxDuration = var_59_19

					if var_59_19 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_19 + var_59_12
					end
				end

				arg_56_1.text_.text = var_59_16
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031013", "story_v_out_120031.awb") ~= 0 then
					local var_59_20 = manager.audio:GetVoiceLength("story_v_out_120031", "120031013", "story_v_out_120031.awb") / 1000

					if var_59_20 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_20 + var_59_12
					end

					if var_59_15.prefab_name ~= "" and arg_56_1.actors_[var_59_15.prefab_name] ~= nil then
						local var_59_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_15.prefab_name].transform, "story_v_out_120031", "120031013", "story_v_out_120031.awb")

						arg_56_1:RecordAudio("120031013", var_59_21)
						arg_56_1:RecordAudio("120031013", var_59_21)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_120031", "120031013", "story_v_out_120031.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_120031", "120031013", "story_v_out_120031.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_22 = math.max(var_59_13, arg_56_1.talkMaxDuration)

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_22 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_12) / var_59_22

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_12 + var_59_22 and arg_56_1.time_ < var_59_12 + var_59_22 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play120031014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 120031014
		arg_60_1.duration_ = 3.57

		local var_60_0 = {
			zh = 1.999999999999,
			ja = 3.566
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play120031015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10044ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10044ui_story == nil then
				arg_60_1.var_.characterEffect10044ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect10044ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10044ui_story then
				arg_60_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1069ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1069ui_story == nil then
				arg_60_1.var_.characterEffect1069ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.2

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1069ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1069ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1069ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1069ui_story.fillRatio = var_63_9
			end

			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action452")
			end

			local var_63_11 = 0
			local var_63_12 = 0.225

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_13 = arg_60_1:FormatText(StoryNameCfg[380].name)

				arg_60_1.leftNameTxt_.text = var_63_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_14 = arg_60_1:GetWordFromCfg(120031014)
				local var_63_15 = arg_60_1:FormatText(var_63_14.content)

				arg_60_1.text_.text = var_63_15

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_16 = 9
				local var_63_17 = utf8.len(var_63_15)
				local var_63_18 = var_63_16 <= 0 and var_63_12 or var_63_12 * (var_63_17 / var_63_16)

				if var_63_18 > 0 and var_63_12 < var_63_18 then
					arg_60_1.talkMaxDuration = var_63_18

					if var_63_18 + var_63_11 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_18 + var_63_11
					end
				end

				arg_60_1.text_.text = var_63_15
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031014", "story_v_out_120031.awb") ~= 0 then
					local var_63_19 = manager.audio:GetVoiceLength("story_v_out_120031", "120031014", "story_v_out_120031.awb") / 1000

					if var_63_19 + var_63_11 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_19 + var_63_11
					end

					if var_63_14.prefab_name ~= "" and arg_60_1.actors_[var_63_14.prefab_name] ~= nil then
						local var_63_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_14.prefab_name].transform, "story_v_out_120031", "120031014", "story_v_out_120031.awb")

						arg_60_1:RecordAudio("120031014", var_63_20)
						arg_60_1:RecordAudio("120031014", var_63_20)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_120031", "120031014", "story_v_out_120031.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_120031", "120031014", "story_v_out_120031.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_21 = math.max(var_63_12, arg_60_1.talkMaxDuration)

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_21 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_11) / var_63_21

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_11 + var_63_21 and arg_60_1.time_ < var_63_11 + var_63_21 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play120031015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 120031015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play120031016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1069ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos1069ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1069ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = arg_64_1.actors_["10044ui_story"].transform
			local var_67_10 = 0

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.var_.moveOldPos10044ui_story = var_67_9.localPosition
			end

			local var_67_11 = 0.001

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_11 then
				local var_67_12 = (arg_64_1.time_ - var_67_10) / var_67_11
				local var_67_13 = Vector3.New(0, 100, 0)

				var_67_9.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10044ui_story, var_67_13, var_67_12)

				local var_67_14 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_14.x, var_67_14.y, var_67_14.z)

				local var_67_15 = var_67_9.localEulerAngles

				var_67_15.z = 0
				var_67_15.x = 0
				var_67_9.localEulerAngles = var_67_15
			end

			if arg_64_1.time_ >= var_67_10 + var_67_11 and arg_64_1.time_ < var_67_10 + var_67_11 + arg_67_0 then
				var_67_9.localPosition = Vector3.New(0, 100, 0)

				local var_67_16 = manager.ui.mainCamera.transform.position - var_67_9.position

				var_67_9.forward = Vector3.New(var_67_16.x, var_67_16.y, var_67_16.z)

				local var_67_17 = var_67_9.localEulerAngles

				var_67_17.z = 0
				var_67_17.x = 0
				var_67_9.localEulerAngles = var_67_17
			end

			local var_67_18 = 0
			local var_67_19 = 0.95

			if var_67_18 < arg_64_1.time_ and arg_64_1.time_ <= var_67_18 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_20 = arg_64_1:GetWordFromCfg(120031015)
				local var_67_21 = arg_64_1:FormatText(var_67_20.content)

				arg_64_1.text_.text = var_67_21

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_22 = 38
				local var_67_23 = utf8.len(var_67_21)
				local var_67_24 = var_67_22 <= 0 and var_67_19 or var_67_19 * (var_67_23 / var_67_22)

				if var_67_24 > 0 and var_67_19 < var_67_24 then
					arg_64_1.talkMaxDuration = var_67_24

					if var_67_24 + var_67_18 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_24 + var_67_18
					end
				end

				arg_64_1.text_.text = var_67_21
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_25 = math.max(var_67_19, arg_64_1.talkMaxDuration)

			if var_67_18 <= arg_64_1.time_ and arg_64_1.time_ < var_67_18 + var_67_25 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_18) / var_67_25

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_18 + var_67_25 and arg_64_1.time_ < var_67_18 + var_67_25 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play120031016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 120031016
		arg_68_1.duration_ = 2.57

		local var_68_0 = {
			zh = 2.566,
			ja = 2
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play120031017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1084ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1084ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, -0.97, -6)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1084ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = arg_68_1.actors_["1084ui_story"]
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_11 = 0.2

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 and not isNil(var_71_9) then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11

				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_9) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_71_13 = 0

			if var_71_13 < arg_68_1.time_ and arg_68_1.time_ <= var_71_13 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_71_14 = 0

			if var_71_14 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_71_15 = 0
			local var_71_16 = 0.275

			if var_71_15 < arg_68_1.time_ and arg_68_1.time_ <= var_71_15 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_17 = arg_68_1:FormatText(StoryNameCfg[6].name)

				arg_68_1.leftNameTxt_.text = var_71_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_18 = arg_68_1:GetWordFromCfg(120031016)
				local var_71_19 = arg_68_1:FormatText(var_71_18.content)

				arg_68_1.text_.text = var_71_19

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_20 = 11
				local var_71_21 = utf8.len(var_71_19)
				local var_71_22 = var_71_20 <= 0 and var_71_16 or var_71_16 * (var_71_21 / var_71_20)

				if var_71_22 > 0 and var_71_16 < var_71_22 then
					arg_68_1.talkMaxDuration = var_71_22

					if var_71_22 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_22 + var_71_15
					end
				end

				arg_68_1.text_.text = var_71_19
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031016", "story_v_out_120031.awb") ~= 0 then
					local var_71_23 = manager.audio:GetVoiceLength("story_v_out_120031", "120031016", "story_v_out_120031.awb") / 1000

					if var_71_23 + var_71_15 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_23 + var_71_15
					end

					if var_71_18.prefab_name ~= "" and arg_68_1.actors_[var_71_18.prefab_name] ~= nil then
						local var_71_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_18.prefab_name].transform, "story_v_out_120031", "120031016", "story_v_out_120031.awb")

						arg_68_1:RecordAudio("120031016", var_71_24)
						arg_68_1:RecordAudio("120031016", var_71_24)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_120031", "120031016", "story_v_out_120031.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_120031", "120031016", "story_v_out_120031.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_25 = math.max(var_71_16, arg_68_1.talkMaxDuration)

			if var_71_15 <= arg_68_1.time_ and arg_68_1.time_ < var_71_15 + var_71_25 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_15) / var_71_25

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_15 + var_71_25 and arg_68_1.time_ < var_71_15 + var_71_25 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play120031017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 120031017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play120031018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1084ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1084ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1084ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0
			local var_75_7 = 0.4

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_8 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_9 = arg_72_1:GetWordFromCfg(120031017)
				local var_75_10 = arg_72_1:FormatText(var_75_9.content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 16
				local var_75_12 = utf8.len(var_75_10)
				local var_75_13 = var_75_11 <= 0 and var_75_7 or var_75_7 * (var_75_12 / var_75_11)

				if var_75_13 > 0 and var_75_7 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play120031018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 120031018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play120031019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 1.125

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

				local var_79_3 = arg_76_1:GetWordFromCfg(120031018)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 45
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
	Play120031019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 120031019
		arg_80_1.duration_ = 4.7

		local var_80_0 = {
			zh = 3.633,
			ja = 4.7
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
				arg_80_0:Play120031020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1069ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1069ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0.7, -1, -6)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1069ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0.7, -1, -6)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["1069ui_story"]
			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1069ui_story == nil then
				arg_80_1.var_.characterEffect1069ui_story = var_83_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_11 = 0.2

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 and not isNil(var_83_9) then
				local var_83_12 = (arg_80_1.time_ - var_83_10) / var_83_11

				if arg_80_1.var_.characterEffect1069ui_story and not isNil(var_83_9) then
					arg_80_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_10 + var_83_11 and arg_80_1.time_ < var_83_10 + var_83_11 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1069ui_story then
				arg_80_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_83_13 = arg_80_1.actors_["1084ui_story"].transform
			local var_83_14 = 0

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1.var_.moveOldPos1084ui_story = var_83_13.localPosition
			end

			local var_83_15 = 0.001

			if var_83_14 <= arg_80_1.time_ and arg_80_1.time_ < var_83_14 + var_83_15 then
				local var_83_16 = (arg_80_1.time_ - var_83_14) / var_83_15
				local var_83_17 = Vector3.New(-0.7, -0.97, -6)

				var_83_13.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1084ui_story, var_83_17, var_83_16)

				local var_83_18 = manager.ui.mainCamera.transform.position - var_83_13.position

				var_83_13.forward = Vector3.New(var_83_18.x, var_83_18.y, var_83_18.z)

				local var_83_19 = var_83_13.localEulerAngles

				var_83_19.z = 0
				var_83_19.x = 0
				var_83_13.localEulerAngles = var_83_19
			end

			if arg_80_1.time_ >= var_83_14 + var_83_15 and arg_80_1.time_ < var_83_14 + var_83_15 + arg_83_0 then
				var_83_13.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_83_20 = manager.ui.mainCamera.transform.position - var_83_13.position

				var_83_13.forward = Vector3.New(var_83_20.x, var_83_20.y, var_83_20.z)

				local var_83_21 = var_83_13.localEulerAngles

				var_83_21.z = 0
				var_83_21.x = 0
				var_83_13.localEulerAngles = var_83_21
			end

			local var_83_22 = arg_80_1.actors_["1084ui_story"]
			local var_83_23 = 0

			if var_83_23 < arg_80_1.time_ and arg_80_1.time_ <= var_83_23 + arg_83_0 and not isNil(var_83_22) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = var_83_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_24 = 0.2

			if var_83_23 <= arg_80_1.time_ and arg_80_1.time_ < var_83_23 + var_83_24 and not isNil(var_83_22) then
				local var_83_25 = (arg_80_1.time_ - var_83_23) / var_83_24

				if arg_80_1.var_.characterEffect1084ui_story and not isNil(var_83_22) then
					local var_83_26 = Mathf.Lerp(0, 0.5, var_83_25)

					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = var_83_26
				end
			end

			if arg_80_1.time_ >= var_83_23 + var_83_24 and arg_80_1.time_ < var_83_23 + var_83_24 + arg_83_0 and not isNil(var_83_22) and arg_80_1.var_.characterEffect1084ui_story then
				local var_83_27 = 0.5

				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = var_83_27
			end

			local var_83_28 = 0

			if var_83_28 < arg_80_1.time_ and arg_80_1.time_ <= var_83_28 + arg_83_0 then
				arg_80_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_83_29 = 0
			local var_83_30 = 0.45

			if var_83_29 < arg_80_1.time_ and arg_80_1.time_ <= var_83_29 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_31 = arg_80_1:FormatText(StoryNameCfg[378].name)

				arg_80_1.leftNameTxt_.text = var_83_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_32 = arg_80_1:GetWordFromCfg(120031019)
				local var_83_33 = arg_80_1:FormatText(var_83_32.content)

				arg_80_1.text_.text = var_83_33

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_34 = 18
				local var_83_35 = utf8.len(var_83_33)
				local var_83_36 = var_83_34 <= 0 and var_83_30 or var_83_30 * (var_83_35 / var_83_34)

				if var_83_36 > 0 and var_83_30 < var_83_36 then
					arg_80_1.talkMaxDuration = var_83_36

					if var_83_36 + var_83_29 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_36 + var_83_29
					end
				end

				arg_80_1.text_.text = var_83_33
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031019", "story_v_out_120031.awb") ~= 0 then
					local var_83_37 = manager.audio:GetVoiceLength("story_v_out_120031", "120031019", "story_v_out_120031.awb") / 1000

					if var_83_37 + var_83_29 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_37 + var_83_29
					end

					if var_83_32.prefab_name ~= "" and arg_80_1.actors_[var_83_32.prefab_name] ~= nil then
						local var_83_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_32.prefab_name].transform, "story_v_out_120031", "120031019", "story_v_out_120031.awb")

						arg_80_1:RecordAudio("120031019", var_83_38)
						arg_80_1:RecordAudio("120031019", var_83_38)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_120031", "120031019", "story_v_out_120031.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_120031", "120031019", "story_v_out_120031.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_39 = math.max(var_83_30, arg_80_1.talkMaxDuration)

			if var_83_29 <= arg_80_1.time_ and arg_80_1.time_ < var_83_29 + var_83_39 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_29) / var_83_39

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_29 + var_83_39 and arg_80_1.time_ < var_83_29 + var_83_39 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play120031020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 120031020
		arg_84_1.duration_ = 6.1

		local var_84_0 = {
			zh = 4.8,
			ja = 6.1
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
				arg_84_0:Play120031021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1069ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1069ui_story == nil then
				arg_84_1.var_.characterEffect1069ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1069ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1069ui_story then
				arg_84_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_87_4 = 0

			if var_87_4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_87_6 = 0
			local var_87_7 = 0.7

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[378].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_9 = arg_84_1:GetWordFromCfg(120031020)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031020", "story_v_out_120031.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_120031", "120031020", "story_v_out_120031.awb") / 1000

					if var_87_14 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_6
					end

					if var_87_9.prefab_name ~= "" and arg_84_1.actors_[var_87_9.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_9.prefab_name].transform, "story_v_out_120031", "120031020", "story_v_out_120031.awb")

						arg_84_1:RecordAudio("120031020", var_87_15)
						arg_84_1:RecordAudio("120031020", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_120031", "120031020", "story_v_out_120031.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_120031", "120031020", "story_v_out_120031.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_16 and arg_84_1.time_ < var_87_6 + var_87_16 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play120031021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 120031021
		arg_88_1.duration_ = 9

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play120031022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = "J02h"

			if arg_88_1.bgs_[var_91_0] == nil then
				local var_91_1 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_91_0)
				var_91_1.name = var_91_0
				var_91_1.transform.parent = arg_88_1.stage_.transform
				var_91_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_[var_91_0] = var_91_1
			end

			local var_91_2 = 2

			if var_91_2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				local var_91_3 = manager.ui.mainCamera.transform.localPosition
				local var_91_4 = Vector3.New(0, 0, 10) + Vector3.New(var_91_3.x, var_91_3.y, 0)
				local var_91_5 = arg_88_1.bgs_.J02h

				var_91_5.transform.localPosition = var_91_4
				var_91_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_6 = var_91_5:GetComponent("SpriteRenderer")

				if var_91_6 and var_91_6.sprite then
					local var_91_7 = (var_91_5.transform.localPosition - var_91_3).z
					local var_91_8 = manager.ui.mainCameraCom_
					local var_91_9 = 2 * var_91_7 * Mathf.Tan(var_91_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_91_10 = var_91_9 * var_91_8.aspect
					local var_91_11 = var_91_6.sprite.bounds.size.x
					local var_91_12 = var_91_6.sprite.bounds.size.y
					local var_91_13 = var_91_10 / var_91_11
					local var_91_14 = var_91_9 / var_91_12
					local var_91_15 = var_91_14 < var_91_13 and var_91_13 or var_91_14

					var_91_5.transform.localScale = Vector3.New(var_91_15, var_91_15, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "J02h" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_16 = 0

			if var_91_16 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_17 = 2

			if var_91_16 <= arg_88_1.time_ and arg_88_1.time_ < var_91_16 + var_91_17 then
				local var_91_18 = (arg_88_1.time_ - var_91_16) / var_91_17
				local var_91_19 = Color.New(0, 0, 0)

				var_91_19.a = Mathf.Lerp(0, 1, var_91_18)
				arg_88_1.mask_.color = var_91_19
			end

			if arg_88_1.time_ >= var_91_16 + var_91_17 and arg_88_1.time_ < var_91_16 + var_91_17 + arg_91_0 then
				local var_91_20 = Color.New(0, 0, 0)

				var_91_20.a = 1
				arg_88_1.mask_.color = var_91_20
			end

			local var_91_21 = 2

			if var_91_21 < arg_88_1.time_ and arg_88_1.time_ <= var_91_21 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_22 = 2

			if var_91_21 <= arg_88_1.time_ and arg_88_1.time_ < var_91_21 + var_91_22 then
				local var_91_23 = (arg_88_1.time_ - var_91_21) / var_91_22
				local var_91_24 = Color.New(0, 0, 0)

				var_91_24.a = Mathf.Lerp(1, 0, var_91_23)
				arg_88_1.mask_.color = var_91_24
			end

			if arg_88_1.time_ >= var_91_21 + var_91_22 and arg_88_1.time_ < var_91_21 + var_91_22 + arg_91_0 then
				local var_91_25 = Color.New(0, 0, 0)
				local var_91_26 = 0

				arg_88_1.mask_.enabled = false
				var_91_25.a = var_91_26
				arg_88_1.mask_.color = var_91_25
			end

			local var_91_27 = arg_88_1.actors_["1084ui_story"].transform
			local var_91_28 = 2

			if var_91_28 < arg_88_1.time_ and arg_88_1.time_ <= var_91_28 + arg_91_0 then
				arg_88_1.var_.moveOldPos1084ui_story = var_91_27.localPosition
			end

			local var_91_29 = 0.001

			if var_91_28 <= arg_88_1.time_ and arg_88_1.time_ < var_91_28 + var_91_29 then
				local var_91_30 = (arg_88_1.time_ - var_91_28) / var_91_29
				local var_91_31 = Vector3.New(0, 100, 0)

				var_91_27.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1084ui_story, var_91_31, var_91_30)

				local var_91_32 = manager.ui.mainCamera.transform.position - var_91_27.position

				var_91_27.forward = Vector3.New(var_91_32.x, var_91_32.y, var_91_32.z)

				local var_91_33 = var_91_27.localEulerAngles

				var_91_33.z = 0
				var_91_33.x = 0
				var_91_27.localEulerAngles = var_91_33
			end

			if arg_88_1.time_ >= var_91_28 + var_91_29 and arg_88_1.time_ < var_91_28 + var_91_29 + arg_91_0 then
				var_91_27.localPosition = Vector3.New(0, 100, 0)

				local var_91_34 = manager.ui.mainCamera.transform.position - var_91_27.position

				var_91_27.forward = Vector3.New(var_91_34.x, var_91_34.y, var_91_34.z)

				local var_91_35 = var_91_27.localEulerAngles

				var_91_35.z = 0
				var_91_35.x = 0
				var_91_27.localEulerAngles = var_91_35
			end

			local var_91_36 = arg_88_1.actors_["1069ui_story"].transform
			local var_91_37 = 2

			if var_91_37 < arg_88_1.time_ and arg_88_1.time_ <= var_91_37 + arg_91_0 then
				arg_88_1.var_.moveOldPos1069ui_story = var_91_36.localPosition
			end

			local var_91_38 = 0.001

			if var_91_37 <= arg_88_1.time_ and arg_88_1.time_ < var_91_37 + var_91_38 then
				local var_91_39 = (arg_88_1.time_ - var_91_37) / var_91_38
				local var_91_40 = Vector3.New(0, 100, 0)

				var_91_36.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1069ui_story, var_91_40, var_91_39)

				local var_91_41 = manager.ui.mainCamera.transform.position - var_91_36.position

				var_91_36.forward = Vector3.New(var_91_41.x, var_91_41.y, var_91_41.z)

				local var_91_42 = var_91_36.localEulerAngles

				var_91_42.z = 0
				var_91_42.x = 0
				var_91_36.localEulerAngles = var_91_42
			end

			if arg_88_1.time_ >= var_91_37 + var_91_38 and arg_88_1.time_ < var_91_37 + var_91_38 + arg_91_0 then
				var_91_36.localPosition = Vector3.New(0, 100, 0)

				local var_91_43 = manager.ui.mainCamera.transform.position - var_91_36.position

				var_91_36.forward = Vector3.New(var_91_43.x, var_91_43.y, var_91_43.z)

				local var_91_44 = var_91_36.localEulerAngles

				var_91_44.z = 0
				var_91_44.x = 0
				var_91_36.localEulerAngles = var_91_44
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_45 = 4
			local var_91_46 = 0.8

			if var_91_45 < arg_88_1.time_ and arg_88_1.time_ <= var_91_45 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_47 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_47:setOnUpdate(LuaHelper.FloatAction(function(arg_92_0)
					arg_88_1.dialogCg_.alpha = arg_92_0
				end))
				var_91_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_48 = arg_88_1:GetWordFromCfg(120031021)
				local var_91_49 = arg_88_1:FormatText(var_91_48.content)

				arg_88_1.text_.text = var_91_49

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_50 = 32
				local var_91_51 = utf8.len(var_91_49)
				local var_91_52 = var_91_50 <= 0 and var_91_46 or var_91_46 * (var_91_51 / var_91_50)

				if var_91_52 > 0 and var_91_46 < var_91_52 then
					arg_88_1.talkMaxDuration = var_91_52
					var_91_45 = var_91_45 + 0.3

					if var_91_52 + var_91_45 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_52 + var_91_45
					end
				end

				arg_88_1.text_.text = var_91_49
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_53 = var_91_45 + 0.3
			local var_91_54 = math.max(var_91_46, arg_88_1.talkMaxDuration)

			if var_91_53 <= arg_88_1.time_ and arg_88_1.time_ < var_91_53 + var_91_54 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_53) / var_91_54

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_53 + var_91_54 and arg_88_1.time_ < var_91_53 + var_91_54 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play120031022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 120031022
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play120031023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 0.925

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_2 = arg_94_1:GetWordFromCfg(120031022)
				local var_97_3 = arg_94_1:FormatText(var_97_2.content)

				arg_94_1.text_.text = var_97_3

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 37
				local var_97_5 = utf8.len(var_97_3)
				local var_97_6 = var_97_4 <= 0 and var_97_1 or var_97_1 * (var_97_5 / var_97_4)

				if var_97_6 > 0 and var_97_1 < var_97_6 then
					arg_94_1.talkMaxDuration = var_97_6

					if var_97_6 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_6 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_3
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_7 and arg_94_1.time_ < var_97_0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play120031023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 120031023
		arg_98_1.duration_ = 11.73

		local var_98_0 = {
			zh = 7.766,
			ja = 11.733
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
				arg_98_0:Play120031024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1069ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos1069ui_story = var_101_0.localPosition
			end

			local var_101_2 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2
				local var_101_4 = Vector3.New(-0.7, -1, -6)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1069ui_story, var_101_4, var_101_3)

				local var_101_5 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_5.x, var_101_5.y, var_101_5.z)

				local var_101_6 = var_101_0.localEulerAngles

				var_101_6.z = 0
				var_101_6.x = 0
				var_101_0.localEulerAngles = var_101_6
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(-0.7, -1, -6)

				local var_101_7 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_7.x, var_101_7.y, var_101_7.z)

				local var_101_8 = var_101_0.localEulerAngles

				var_101_8.z = 0
				var_101_8.x = 0
				var_101_0.localEulerAngles = var_101_8
			end

			local var_101_9 = arg_98_1.actors_["1069ui_story"]
			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect1069ui_story == nil then
				arg_98_1.var_.characterEffect1069ui_story = var_101_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_11 = 0.2

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_11 and not isNil(var_101_9) then
				local var_101_12 = (arg_98_1.time_ - var_101_10) / var_101_11

				if arg_98_1.var_.characterEffect1069ui_story and not isNil(var_101_9) then
					arg_98_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_10 + var_101_11 and arg_98_1.time_ < var_101_10 + var_101_11 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect1069ui_story then
				arg_98_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_101_13 = arg_98_1.actors_["1084ui_story"].transform
			local var_101_14 = 0

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1.var_.moveOldPos1084ui_story = var_101_13.localPosition
			end

			local var_101_15 = 0.001

			if var_101_14 <= arg_98_1.time_ and arg_98_1.time_ < var_101_14 + var_101_15 then
				local var_101_16 = (arg_98_1.time_ - var_101_14) / var_101_15
				local var_101_17 = Vector3.New(0.7, -0.97, -6)

				var_101_13.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1084ui_story, var_101_17, var_101_16)

				local var_101_18 = manager.ui.mainCamera.transform.position - var_101_13.position

				var_101_13.forward = Vector3.New(var_101_18.x, var_101_18.y, var_101_18.z)

				local var_101_19 = var_101_13.localEulerAngles

				var_101_19.z = 0
				var_101_19.x = 0
				var_101_13.localEulerAngles = var_101_19
			end

			if arg_98_1.time_ >= var_101_14 + var_101_15 and arg_98_1.time_ < var_101_14 + var_101_15 + arg_101_0 then
				var_101_13.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_101_20 = manager.ui.mainCamera.transform.position - var_101_13.position

				var_101_13.forward = Vector3.New(var_101_20.x, var_101_20.y, var_101_20.z)

				local var_101_21 = var_101_13.localEulerAngles

				var_101_21.z = 0
				var_101_21.x = 0
				var_101_13.localEulerAngles = var_101_21
			end

			local var_101_22 = arg_98_1.actors_["1084ui_story"]
			local var_101_23 = 0

			if var_101_23 < arg_98_1.time_ and arg_98_1.time_ <= var_101_23 + arg_101_0 and not isNil(var_101_22) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_24 = 0.0166666666666667

			if var_101_23 <= arg_98_1.time_ and arg_98_1.time_ < var_101_23 + var_101_24 and not isNil(var_101_22) then
				local var_101_25 = (arg_98_1.time_ - var_101_23) / var_101_24

				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_22) then
					local var_101_26 = Mathf.Lerp(0, 0.5, var_101_25)

					arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1084ui_story.fillRatio = var_101_26
				end
			end

			if arg_98_1.time_ >= var_101_23 + var_101_24 and arg_98_1.time_ < var_101_23 + var_101_24 + arg_101_0 and not isNil(var_101_22) and arg_98_1.var_.characterEffect1084ui_story then
				local var_101_27 = 0.5

				arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1084ui_story.fillRatio = var_101_27
			end

			local var_101_28 = 0

			if var_101_28 < arg_98_1.time_ and arg_98_1.time_ <= var_101_28 + arg_101_0 then
				arg_98_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_101_29 = 0
			local var_101_30 = 1.025

			if var_101_29 < arg_98_1.time_ and arg_98_1.time_ <= var_101_29 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_31 = arg_98_1:FormatText(StoryNameCfg[378].name)

				arg_98_1.leftNameTxt_.text = var_101_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_32 = arg_98_1:GetWordFromCfg(120031023)
				local var_101_33 = arg_98_1:FormatText(var_101_32.content)

				arg_98_1.text_.text = var_101_33

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_34 = 41
				local var_101_35 = utf8.len(var_101_33)
				local var_101_36 = var_101_34 <= 0 and var_101_30 or var_101_30 * (var_101_35 / var_101_34)

				if var_101_36 > 0 and var_101_30 < var_101_36 then
					arg_98_1.talkMaxDuration = var_101_36

					if var_101_36 + var_101_29 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_36 + var_101_29
					end
				end

				arg_98_1.text_.text = var_101_33
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031023", "story_v_out_120031.awb") ~= 0 then
					local var_101_37 = manager.audio:GetVoiceLength("story_v_out_120031", "120031023", "story_v_out_120031.awb") / 1000

					if var_101_37 + var_101_29 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_37 + var_101_29
					end

					if var_101_32.prefab_name ~= "" and arg_98_1.actors_[var_101_32.prefab_name] ~= nil then
						local var_101_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_32.prefab_name].transform, "story_v_out_120031", "120031023", "story_v_out_120031.awb")

						arg_98_1:RecordAudio("120031023", var_101_38)
						arg_98_1:RecordAudio("120031023", var_101_38)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_120031", "120031023", "story_v_out_120031.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_120031", "120031023", "story_v_out_120031.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_39 = math.max(var_101_30, arg_98_1.talkMaxDuration)

			if var_101_29 <= arg_98_1.time_ and arg_98_1.time_ < var_101_29 + var_101_39 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_29) / var_101_39

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_29 + var_101_39 and arg_98_1.time_ < var_101_29 + var_101_39 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play120031024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 120031024
		arg_102_1.duration_ = 10.5

		local var_102_0 = {
			zh = 8.2,
			ja = 10.5
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
				arg_102_0:Play120031025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_105_2 = 0
			local var_105_3 = 1.075

			if var_105_2 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_4 = arg_102_1:FormatText(StoryNameCfg[378].name)

				arg_102_1.leftNameTxt_.text = var_105_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_5 = arg_102_1:GetWordFromCfg(120031024)
				local var_105_6 = arg_102_1:FormatText(var_105_5.content)

				arg_102_1.text_.text = var_105_6

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 43
				local var_105_8 = utf8.len(var_105_6)
				local var_105_9 = var_105_7 <= 0 and var_105_3 or var_105_3 * (var_105_8 / var_105_7)

				if var_105_9 > 0 and var_105_3 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_2
					end
				end

				arg_102_1.text_.text = var_105_6
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031024", "story_v_out_120031.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_120031", "120031024", "story_v_out_120031.awb") / 1000

					if var_105_10 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_2
					end

					if var_105_5.prefab_name ~= "" and arg_102_1.actors_[var_105_5.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_5.prefab_name].transform, "story_v_out_120031", "120031024", "story_v_out_120031.awb")

						arg_102_1:RecordAudio("120031024", var_105_11)
						arg_102_1:RecordAudio("120031024", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_120031", "120031024", "story_v_out_120031.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_120031", "120031024", "story_v_out_120031.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_3, arg_102_1.talkMaxDuration)

			if var_105_2 <= arg_102_1.time_ and arg_102_1.time_ < var_105_2 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_2) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_2 + var_105_12 and arg_102_1.time_ < var_105_2 + var_105_12 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play120031025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 120031025
		arg_106_1.duration_ = 6.1

		local var_106_0 = {
			zh = 3.9,
			ja = 6.1
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
				arg_106_0:Play120031026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.575

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[378].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_3 = arg_106_1:GetWordFromCfg(120031025)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 23
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031025", "story_v_out_120031.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_120031", "120031025", "story_v_out_120031.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_120031", "120031025", "story_v_out_120031.awb")

						arg_106_1:RecordAudio("120031025", var_109_9)
						arg_106_1:RecordAudio("120031025", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_120031", "120031025", "story_v_out_120031.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_120031", "120031025", "story_v_out_120031.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play120031026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 120031026
		arg_110_1.duration_ = 3.4

		local var_110_0 = {
			zh = 3.4,
			ja = 2.3
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
				arg_110_0:Play120031027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1069ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1069ui_story == nil then
				arg_110_1.var_.characterEffect1069ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.2

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1069ui_story and not isNil(var_113_0) then
					local var_113_4 = Mathf.Lerp(0, 0.5, var_113_3)

					arg_110_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1069ui_story.fillRatio = var_113_4
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1069ui_story then
				local var_113_5 = 0.5

				arg_110_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1069ui_story.fillRatio = var_113_5
			end

			local var_113_6 = arg_110_1.actors_["1084ui_story"]
			local var_113_7 = 0

			if var_113_7 < arg_110_1.time_ and arg_110_1.time_ <= var_113_7 + arg_113_0 and not isNil(var_113_6) and arg_110_1.var_.characterEffect1084ui_story == nil then
				arg_110_1.var_.characterEffect1084ui_story = var_113_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_8 = 0.2

			if var_113_7 <= arg_110_1.time_ and arg_110_1.time_ < var_113_7 + var_113_8 and not isNil(var_113_6) then
				local var_113_9 = (arg_110_1.time_ - var_113_7) / var_113_8

				if arg_110_1.var_.characterEffect1084ui_story and not isNil(var_113_6) then
					arg_110_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_7 + var_113_8 and arg_110_1.time_ < var_113_7 + var_113_8 + arg_113_0 and not isNil(var_113_6) and arg_110_1.var_.characterEffect1084ui_story then
				arg_110_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_113_11 = 0

			if var_113_11 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
				arg_110_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_113_12 = 0
			local var_113_13 = 0.35

			if var_113_12 < arg_110_1.time_ and arg_110_1.time_ <= var_113_12 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_14 = arg_110_1:FormatText(StoryNameCfg[6].name)

				arg_110_1.leftNameTxt_.text = var_113_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_15 = arg_110_1:GetWordFromCfg(120031026)
				local var_113_16 = arg_110_1:FormatText(var_113_15.content)

				arg_110_1.text_.text = var_113_16

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_17 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031026", "story_v_out_120031.awb") ~= 0 then
					local var_113_20 = manager.audio:GetVoiceLength("story_v_out_120031", "120031026", "story_v_out_120031.awb") / 1000

					if var_113_20 + var_113_12 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_20 + var_113_12
					end

					if var_113_15.prefab_name ~= "" and arg_110_1.actors_[var_113_15.prefab_name] ~= nil then
						local var_113_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_15.prefab_name].transform, "story_v_out_120031", "120031026", "story_v_out_120031.awb")

						arg_110_1:RecordAudio("120031026", var_113_21)
						arg_110_1:RecordAudio("120031026", var_113_21)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_120031", "120031026", "story_v_out_120031.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_120031", "120031026", "story_v_out_120031.awb")
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
	Play120031027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 120031027
		arg_114_1.duration_ = 7.27

		local var_114_0 = {
			zh = 7.266,
			ja = 5.4
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play120031028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1069ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1069ui_story == nil then
				arg_114_1.var_.characterEffect1069ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.2

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1069ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1069ui_story then
				arg_114_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_117_4 = arg_114_1.actors_["1084ui_story"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1084ui_story == nil then
				arg_114_1.var_.characterEffect1084ui_story = var_117_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.2

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.characterEffect1084ui_story and not isNil(var_117_4) then
					local var_117_8 = Mathf.Lerp(0, 0.5, var_117_7)

					arg_114_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1084ui_story.fillRatio = var_117_8
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1084ui_story then
				local var_117_9 = 0.5

				arg_114_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1084ui_story.fillRatio = var_117_9
			end

			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_117_11 = 0

			if var_117_11 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 then
				arg_114_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069actionlink/1069action424")
			end

			local var_117_12 = 0
			local var_117_13 = 0.85

			if var_117_12 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_14 = arg_114_1:FormatText(StoryNameCfg[378].name)

				arg_114_1.leftNameTxt_.text = var_117_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_15 = arg_114_1:GetWordFromCfg(120031027)
				local var_117_16 = arg_114_1:FormatText(var_117_15.content)

				arg_114_1.text_.text = var_117_16

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_17 = 34
				local var_117_18 = utf8.len(var_117_16)
				local var_117_19 = var_117_17 <= 0 and var_117_13 or var_117_13 * (var_117_18 / var_117_17)

				if var_117_19 > 0 and var_117_13 < var_117_19 then
					arg_114_1.talkMaxDuration = var_117_19

					if var_117_19 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_19 + var_117_12
					end
				end

				arg_114_1.text_.text = var_117_16
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031027", "story_v_out_120031.awb") ~= 0 then
					local var_117_20 = manager.audio:GetVoiceLength("story_v_out_120031", "120031027", "story_v_out_120031.awb") / 1000

					if var_117_20 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_20 + var_117_12
					end

					if var_117_15.prefab_name ~= "" and arg_114_1.actors_[var_117_15.prefab_name] ~= nil then
						local var_117_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_15.prefab_name].transform, "story_v_out_120031", "120031027", "story_v_out_120031.awb")

						arg_114_1:RecordAudio("120031027", var_117_21)
						arg_114_1:RecordAudio("120031027", var_117_21)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_120031", "120031027", "story_v_out_120031.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_120031", "120031027", "story_v_out_120031.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_22 = math.max(var_117_13, arg_114_1.talkMaxDuration)

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_22 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_12) / var_117_22

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_12 + var_117_22 and arg_114_1.time_ < var_117_12 + var_117_22 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play120031028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 120031028
		arg_118_1.duration_ = 6.3

		local var_118_0 = {
			zh = 5.366,
			ja = 6.3
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
				arg_118_0:Play120031029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1084ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.2

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["1069ui_story"]
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect1069ui_story == nil then
				arg_118_1.var_.characterEffect1069ui_story = var_121_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.2

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 and not isNil(var_121_4) then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6

				if arg_118_1.var_.characterEffect1069ui_story and not isNil(var_121_4) then
					local var_121_8 = Mathf.Lerp(0, 0.5, var_121_7)

					arg_118_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1069ui_story.fillRatio = var_121_8
				end
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect1069ui_story then
				local var_121_9 = 0.5

				arg_118_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1069ui_story.fillRatio = var_121_9
			end

			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_121_11 = 0
			local var_121_12 = 0.6

			if var_121_11 < arg_118_1.time_ and arg_118_1.time_ <= var_121_11 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_13 = arg_118_1:FormatText(StoryNameCfg[6].name)

				arg_118_1.leftNameTxt_.text = var_121_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_14 = arg_118_1:GetWordFromCfg(120031028)
				local var_121_15 = arg_118_1:FormatText(var_121_14.content)

				arg_118_1.text_.text = var_121_15

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_16 = 24
				local var_121_17 = utf8.len(var_121_15)
				local var_121_18 = var_121_16 <= 0 and var_121_12 or var_121_12 * (var_121_17 / var_121_16)

				if var_121_18 > 0 and var_121_12 < var_121_18 then
					arg_118_1.talkMaxDuration = var_121_18

					if var_121_18 + var_121_11 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_18 + var_121_11
					end
				end

				arg_118_1.text_.text = var_121_15
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031028", "story_v_out_120031.awb") ~= 0 then
					local var_121_19 = manager.audio:GetVoiceLength("story_v_out_120031", "120031028", "story_v_out_120031.awb") / 1000

					if var_121_19 + var_121_11 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_19 + var_121_11
					end

					if var_121_14.prefab_name ~= "" and arg_118_1.actors_[var_121_14.prefab_name] ~= nil then
						local var_121_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_14.prefab_name].transform, "story_v_out_120031", "120031028", "story_v_out_120031.awb")

						arg_118_1:RecordAudio("120031028", var_121_20)
						arg_118_1:RecordAudio("120031028", var_121_20)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_120031", "120031028", "story_v_out_120031.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_120031", "120031028", "story_v_out_120031.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_21 = math.max(var_121_12, arg_118_1.talkMaxDuration)

			if var_121_11 <= arg_118_1.time_ and arg_118_1.time_ < var_121_11 + var_121_21 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_11) / var_121_21

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_11 + var_121_21 and arg_118_1.time_ < var_121_11 + var_121_21 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play120031029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 120031029
		arg_122_1.duration_ = 4.2

		local var_122_0 = {
			zh = 1.933,
			ja = 4.2
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
				arg_122_0:Play120031030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1069ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1069ui_story == nil then
				arg_122_1.var_.characterEffect1069ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1069ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1069ui_story then
				arg_122_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_125_4 = arg_122_1.actors_["1084ui_story"]
			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_6 = 0.2

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_6 and not isNil(var_125_4) then
				local var_125_7 = (arg_122_1.time_ - var_125_5) / var_125_6

				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_4) then
					local var_125_8 = Mathf.Lerp(0, 0.5, var_125_7)

					arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_8
				end
			end

			if arg_122_1.time_ >= var_125_5 + var_125_6 and arg_122_1.time_ < var_125_5 + var_125_6 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect1084ui_story then
				local var_125_9 = 0.5

				arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_9
			end

			local var_125_10 = 0
			local var_125_11 = 0.225

			if var_125_10 < arg_122_1.time_ and arg_122_1.time_ <= var_125_10 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_12 = arg_122_1:FormatText(StoryNameCfg[378].name)

				arg_122_1.leftNameTxt_.text = var_125_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_13 = arg_122_1:GetWordFromCfg(120031029)
				local var_125_14 = arg_122_1:FormatText(var_125_13.content)

				arg_122_1.text_.text = var_125_14

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_15 = 9
				local var_125_16 = utf8.len(var_125_14)
				local var_125_17 = var_125_15 <= 0 and var_125_11 or var_125_11 * (var_125_16 / var_125_15)

				if var_125_17 > 0 and var_125_11 < var_125_17 then
					arg_122_1.talkMaxDuration = var_125_17

					if var_125_17 + var_125_10 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_17 + var_125_10
					end
				end

				arg_122_1.text_.text = var_125_14
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031029", "story_v_out_120031.awb") ~= 0 then
					local var_125_18 = manager.audio:GetVoiceLength("story_v_out_120031", "120031029", "story_v_out_120031.awb") / 1000

					if var_125_18 + var_125_10 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_18 + var_125_10
					end

					if var_125_13.prefab_name ~= "" and arg_122_1.actors_[var_125_13.prefab_name] ~= nil then
						local var_125_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_13.prefab_name].transform, "story_v_out_120031", "120031029", "story_v_out_120031.awb")

						arg_122_1:RecordAudio("120031029", var_125_19)
						arg_122_1:RecordAudio("120031029", var_125_19)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_120031", "120031029", "story_v_out_120031.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_120031", "120031029", "story_v_out_120031.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_20 = math.max(var_125_11, arg_122_1.talkMaxDuration)

			if var_125_10 <= arg_122_1.time_ and arg_122_1.time_ < var_125_10 + var_125_20 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_10) / var_125_20

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_10 + var_125_20 and arg_122_1.time_ < var_125_10 + var_125_20 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play120031030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 120031030
		arg_126_1.duration_ = 10.87

		local var_126_0 = {
			zh = 10.866,
			ja = 9.8
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
				arg_126_0:Play120031031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0
			local var_129_1 = 1.15

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_2 = arg_126_1:FormatText(StoryNameCfg[378].name)

				arg_126_1.leftNameTxt_.text = var_129_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_3 = arg_126_1:GetWordFromCfg(120031030)
				local var_129_4 = arg_126_1:FormatText(var_129_3.content)

				arg_126_1.text_.text = var_129_4

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 46
				local var_129_6 = utf8.len(var_129_4)
				local var_129_7 = var_129_5 <= 0 and var_129_1 or var_129_1 * (var_129_6 / var_129_5)

				if var_129_7 > 0 and var_129_1 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_4
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031030", "story_v_out_120031.awb") ~= 0 then
					local var_129_8 = manager.audio:GetVoiceLength("story_v_out_120031", "120031030", "story_v_out_120031.awb") / 1000

					if var_129_8 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_0
					end

					if var_129_3.prefab_name ~= "" and arg_126_1.actors_[var_129_3.prefab_name] ~= nil then
						local var_129_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_3.prefab_name].transform, "story_v_out_120031", "120031030", "story_v_out_120031.awb")

						arg_126_1:RecordAudio("120031030", var_129_9)
						arg_126_1:RecordAudio("120031030", var_129_9)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_120031", "120031030", "story_v_out_120031.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_120031", "120031030", "story_v_out_120031.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_10 and arg_126_1.time_ < var_129_0 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play120031031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 120031031
		arg_130_1.duration_ = 3.5

		local var_130_0 = {
			zh = 3.5,
			ja = 2.866
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play120031032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1084ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1084ui_story == nil then
				arg_130_1.var_.characterEffect1084ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.2

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect1084ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1084ui_story then
				arg_130_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_133_4 = arg_130_1.actors_["1069ui_story"]
			local var_133_5 = 0

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1069ui_story == nil then
				arg_130_1.var_.characterEffect1069ui_story = var_133_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_6 = 0.2

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_6 and not isNil(var_133_4) then
				local var_133_7 = (arg_130_1.time_ - var_133_5) / var_133_6

				if arg_130_1.var_.characterEffect1069ui_story and not isNil(var_133_4) then
					local var_133_8 = Mathf.Lerp(0, 0.5, var_133_7)

					arg_130_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1069ui_story.fillRatio = var_133_8
				end
			end

			if arg_130_1.time_ >= var_133_5 + var_133_6 and arg_130_1.time_ < var_133_5 + var_133_6 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1069ui_story then
				local var_133_9 = 0.5

				arg_130_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1069ui_story.fillRatio = var_133_9
			end

			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 then
				arg_130_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4713")
			end

			local var_133_11 = 0

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 then
				arg_130_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_133_12 = 0
			local var_133_13 = 0.25

			if var_133_12 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_14 = arg_130_1:FormatText(StoryNameCfg[6].name)

				arg_130_1.leftNameTxt_.text = var_133_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_15 = arg_130_1:GetWordFromCfg(120031031)
				local var_133_16 = arg_130_1:FormatText(var_133_15.content)

				arg_130_1.text_.text = var_133_16

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_17 = 10
				local var_133_18 = utf8.len(var_133_16)
				local var_133_19 = var_133_17 <= 0 and var_133_13 or var_133_13 * (var_133_18 / var_133_17)

				if var_133_19 > 0 and var_133_13 < var_133_19 then
					arg_130_1.talkMaxDuration = var_133_19

					if var_133_19 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_19 + var_133_12
					end
				end

				arg_130_1.text_.text = var_133_16
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031031", "story_v_out_120031.awb") ~= 0 then
					local var_133_20 = manager.audio:GetVoiceLength("story_v_out_120031", "120031031", "story_v_out_120031.awb") / 1000

					if var_133_20 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_20 + var_133_12
					end

					if var_133_15.prefab_name ~= "" and arg_130_1.actors_[var_133_15.prefab_name] ~= nil then
						local var_133_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_15.prefab_name].transform, "story_v_out_120031", "120031031", "story_v_out_120031.awb")

						arg_130_1:RecordAudio("120031031", var_133_21)
						arg_130_1:RecordAudio("120031031", var_133_21)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_120031", "120031031", "story_v_out_120031.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_120031", "120031031", "story_v_out_120031.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_22 = math.max(var_133_13, arg_130_1.talkMaxDuration)

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_22 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_12) / var_133_22

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_12 + var_133_22 and arg_130_1.time_ < var_133_12 + var_133_22 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play120031032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 120031032
		arg_134_1.duration_ = 1.87

		local var_134_0 = {
			zh = 1.3,
			ja = 1.866
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play120031033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1069ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1069ui_story == nil then
				arg_134_1.var_.characterEffect1069ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.2

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1069ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1069ui_story then
				arg_134_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_137_4 = arg_134_1.actors_["1084ui_story"]
			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1084ui_story == nil then
				arg_134_1.var_.characterEffect1084ui_story = var_137_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_6 = 0.2

			if var_137_5 <= arg_134_1.time_ and arg_134_1.time_ < var_137_5 + var_137_6 and not isNil(var_137_4) then
				local var_137_7 = (arg_134_1.time_ - var_137_5) / var_137_6

				if arg_134_1.var_.characterEffect1084ui_story and not isNil(var_137_4) then
					local var_137_8 = Mathf.Lerp(0, 0.5, var_137_7)

					arg_134_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1084ui_story.fillRatio = var_137_8
				end
			end

			if arg_134_1.time_ >= var_137_5 + var_137_6 and arg_134_1.time_ < var_137_5 + var_137_6 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1084ui_story then
				local var_137_9 = 0.5

				arg_134_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1084ui_story.fillRatio = var_137_9
			end

			local var_137_10 = 0
			local var_137_11 = 0.125

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_12 = arg_134_1:FormatText(StoryNameCfg[378].name)

				arg_134_1.leftNameTxt_.text = var_137_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_13 = arg_134_1:GetWordFromCfg(120031032)
				local var_137_14 = arg_134_1:FormatText(var_137_13.content)

				arg_134_1.text_.text = var_137_14

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_15 = 5
				local var_137_16 = utf8.len(var_137_14)
				local var_137_17 = var_137_15 <= 0 and var_137_11 or var_137_11 * (var_137_16 / var_137_15)

				if var_137_17 > 0 and var_137_11 < var_137_17 then
					arg_134_1.talkMaxDuration = var_137_17

					if var_137_17 + var_137_10 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_17 + var_137_10
					end
				end

				arg_134_1.text_.text = var_137_14
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031032", "story_v_out_120031.awb") ~= 0 then
					local var_137_18 = manager.audio:GetVoiceLength("story_v_out_120031", "120031032", "story_v_out_120031.awb") / 1000

					if var_137_18 + var_137_10 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_18 + var_137_10
					end

					if var_137_13.prefab_name ~= "" and arg_134_1.actors_[var_137_13.prefab_name] ~= nil then
						local var_137_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_13.prefab_name].transform, "story_v_out_120031", "120031032", "story_v_out_120031.awb")

						arg_134_1:RecordAudio("120031032", var_137_19)
						arg_134_1:RecordAudio("120031032", var_137_19)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_120031", "120031032", "story_v_out_120031.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_120031", "120031032", "story_v_out_120031.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_20 = math.max(var_137_11, arg_134_1.talkMaxDuration)

			if var_137_10 <= arg_134_1.time_ and arg_134_1.time_ < var_137_10 + var_137_20 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_10) / var_137_20

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_10 + var_137_20 and arg_134_1.time_ < var_137_10 + var_137_20 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play120031033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 120031033
		arg_138_1.duration_ = 10.13

		local var_138_0 = {
			zh = 10.1,
			ja = 10.133
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play120031034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1075ui_story"].transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.var_.moveOldPos1075ui_story = var_141_0.localPosition
			end

			local var_141_2 = 0.001

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2
				local var_141_4 = Vector3.New(-0.7, -1.055, -6.16)

				var_141_0.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1075ui_story, var_141_4, var_141_3)

				local var_141_5 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_5.x, var_141_5.y, var_141_5.z)

				local var_141_6 = var_141_0.localEulerAngles

				var_141_6.z = 0
				var_141_6.x = 0
				var_141_0.localEulerAngles = var_141_6
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 then
				var_141_0.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_141_7 = manager.ui.mainCamera.transform.position - var_141_0.position

				var_141_0.forward = Vector3.New(var_141_7.x, var_141_7.y, var_141_7.z)

				local var_141_8 = var_141_0.localEulerAngles

				var_141_8.z = 0
				var_141_8.x = 0
				var_141_0.localEulerAngles = var_141_8
			end

			local var_141_9 = arg_138_1.actors_["1075ui_story"]
			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 and not isNil(var_141_9) and arg_138_1.var_.characterEffect1075ui_story == nil then
				arg_138_1.var_.characterEffect1075ui_story = var_141_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_11 = 0.2

			if var_141_10 <= arg_138_1.time_ and arg_138_1.time_ < var_141_10 + var_141_11 and not isNil(var_141_9) then
				local var_141_12 = (arg_138_1.time_ - var_141_10) / var_141_11

				if arg_138_1.var_.characterEffect1075ui_story and not isNil(var_141_9) then
					arg_138_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_10 + var_141_11 and arg_138_1.time_ < var_141_10 + var_141_11 + arg_141_0 and not isNil(var_141_9) and arg_138_1.var_.characterEffect1075ui_story then
				arg_138_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_141_13 = arg_138_1.actors_["1069ui_story"].transform
			local var_141_14 = 0

			if var_141_14 < arg_138_1.time_ and arg_138_1.time_ <= var_141_14 + arg_141_0 then
				arg_138_1.var_.moveOldPos1069ui_story = var_141_13.localPosition
			end

			local var_141_15 = 0.001

			if var_141_14 <= arg_138_1.time_ and arg_138_1.time_ < var_141_14 + var_141_15 then
				local var_141_16 = (arg_138_1.time_ - var_141_14) / var_141_15
				local var_141_17 = Vector3.New(0, 100, 0)

				var_141_13.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1069ui_story, var_141_17, var_141_16)

				local var_141_18 = manager.ui.mainCamera.transform.position - var_141_13.position

				var_141_13.forward = Vector3.New(var_141_18.x, var_141_18.y, var_141_18.z)

				local var_141_19 = var_141_13.localEulerAngles

				var_141_19.z = 0
				var_141_19.x = 0
				var_141_13.localEulerAngles = var_141_19
			end

			if arg_138_1.time_ >= var_141_14 + var_141_15 and arg_138_1.time_ < var_141_14 + var_141_15 + arg_141_0 then
				var_141_13.localPosition = Vector3.New(0, 100, 0)

				local var_141_20 = manager.ui.mainCamera.transform.position - var_141_13.position

				var_141_13.forward = Vector3.New(var_141_20.x, var_141_20.y, var_141_20.z)

				local var_141_21 = var_141_13.localEulerAngles

				var_141_21.z = 0
				var_141_21.x = 0
				var_141_13.localEulerAngles = var_141_21
			end

			local var_141_22 = 0

			if var_141_22 < arg_138_1.time_ and arg_138_1.time_ <= var_141_22 + arg_141_0 then
				arg_138_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_141_23 = 0

			if var_141_23 < arg_138_1.time_ and arg_138_1.time_ <= var_141_23 + arg_141_0 then
				arg_138_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_141_24 = 0
			local var_141_25 = 1.15

			if var_141_24 < arg_138_1.time_ and arg_138_1.time_ <= var_141_24 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_26 = arg_138_1:FormatText(StoryNameCfg[381].name)

				arg_138_1.leftNameTxt_.text = var_141_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_27 = arg_138_1:GetWordFromCfg(120031033)
				local var_141_28 = arg_138_1:FormatText(var_141_27.content)

				arg_138_1.text_.text = var_141_28

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_29 = 46
				local var_141_30 = utf8.len(var_141_28)
				local var_141_31 = var_141_29 <= 0 and var_141_25 or var_141_25 * (var_141_30 / var_141_29)

				if var_141_31 > 0 and var_141_25 < var_141_31 then
					arg_138_1.talkMaxDuration = var_141_31

					if var_141_31 + var_141_24 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_31 + var_141_24
					end
				end

				arg_138_1.text_.text = var_141_28
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031033", "story_v_out_120031.awb") ~= 0 then
					local var_141_32 = manager.audio:GetVoiceLength("story_v_out_120031", "120031033", "story_v_out_120031.awb") / 1000

					if var_141_32 + var_141_24 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_32 + var_141_24
					end

					if var_141_27.prefab_name ~= "" and arg_138_1.actors_[var_141_27.prefab_name] ~= nil then
						local var_141_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_27.prefab_name].transform, "story_v_out_120031", "120031033", "story_v_out_120031.awb")

						arg_138_1:RecordAudio("120031033", var_141_33)
						arg_138_1:RecordAudio("120031033", var_141_33)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_120031", "120031033", "story_v_out_120031.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_120031", "120031033", "story_v_out_120031.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_34 = math.max(var_141_25, arg_138_1.talkMaxDuration)

			if var_141_24 <= arg_138_1.time_ and arg_138_1.time_ < var_141_24 + var_141_34 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_24) / var_141_34

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_24 + var_141_34 and arg_138_1.time_ < var_141_24 + var_141_34 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play120031034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 120031034
		arg_142_1.duration_ = 4.3

		local var_142_0 = {
			zh = 4,
			ja = 4.3
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play120031035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1084ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1084ui_story == nil then
				arg_142_1.var_.characterEffect1084ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.2

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1084ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1084ui_story then
				arg_142_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_145_4 = arg_142_1.actors_["1075ui_story"]
			local var_145_5 = 0

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 and not isNil(var_145_4) and arg_142_1.var_.characterEffect1075ui_story == nil then
				arg_142_1.var_.characterEffect1075ui_story = var_145_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_6 = 0.2

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_6 and not isNil(var_145_4) then
				local var_145_7 = (arg_142_1.time_ - var_145_5) / var_145_6

				if arg_142_1.var_.characterEffect1075ui_story and not isNil(var_145_4) then
					local var_145_8 = Mathf.Lerp(0, 0.5, var_145_7)

					arg_142_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1075ui_story.fillRatio = var_145_8
				end
			end

			if arg_142_1.time_ >= var_145_5 + var_145_6 and arg_142_1.time_ < var_145_5 + var_145_6 + arg_145_0 and not isNil(var_145_4) and arg_142_1.var_.characterEffect1075ui_story then
				local var_145_9 = 0.5

				arg_142_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1075ui_story.fillRatio = var_145_9
			end

			local var_145_10 = 0
			local var_145_11 = 0.425

			if var_145_10 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_12 = arg_142_1:FormatText(StoryNameCfg[6].name)

				arg_142_1.leftNameTxt_.text = var_145_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_13 = arg_142_1:GetWordFromCfg(120031034)
				local var_145_14 = arg_142_1:FormatText(var_145_13.content)

				arg_142_1.text_.text = var_145_14

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_15 = 17
				local var_145_16 = utf8.len(var_145_14)
				local var_145_17 = var_145_15 <= 0 and var_145_11 or var_145_11 * (var_145_16 / var_145_15)

				if var_145_17 > 0 and var_145_11 < var_145_17 then
					arg_142_1.talkMaxDuration = var_145_17

					if var_145_17 + var_145_10 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_17 + var_145_10
					end
				end

				arg_142_1.text_.text = var_145_14
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031034", "story_v_out_120031.awb") ~= 0 then
					local var_145_18 = manager.audio:GetVoiceLength("story_v_out_120031", "120031034", "story_v_out_120031.awb") / 1000

					if var_145_18 + var_145_10 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_18 + var_145_10
					end

					if var_145_13.prefab_name ~= "" and arg_142_1.actors_[var_145_13.prefab_name] ~= nil then
						local var_145_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_13.prefab_name].transform, "story_v_out_120031", "120031034", "story_v_out_120031.awb")

						arg_142_1:RecordAudio("120031034", var_145_19)
						arg_142_1:RecordAudio("120031034", var_145_19)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_120031", "120031034", "story_v_out_120031.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_120031", "120031034", "story_v_out_120031.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_20 = math.max(var_145_11, arg_142_1.talkMaxDuration)

			if var_145_10 <= arg_142_1.time_ and arg_142_1.time_ < var_145_10 + var_145_20 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_10) / var_145_20

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_10 + var_145_20 and arg_142_1.time_ < var_145_10 + var_145_20 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play120031035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 120031035
		arg_146_1.duration_ = 7.77

		local var_146_0 = {
			zh = 5.9,
			ja = 7.766
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
				arg_146_0:Play120031036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1075ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos1075ui_story = var_149_0.localPosition
			end

			local var_149_2 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2
				local var_149_4 = Vector3.New(0, 100, 0)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1075ui_story, var_149_4, var_149_3)

				local var_149_5 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_5.x, var_149_5.y, var_149_5.z)

				local var_149_6 = var_149_0.localEulerAngles

				var_149_6.z = 0
				var_149_6.x = 0
				var_149_0.localEulerAngles = var_149_6
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, 100, 0)

				local var_149_7 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_7.x, var_149_7.y, var_149_7.z)

				local var_149_8 = var_149_0.localEulerAngles

				var_149_8.z = 0
				var_149_8.x = 0
				var_149_0.localEulerAngles = var_149_8
			end

			local var_149_9 = arg_146_1.actors_["1069ui_story"].transform
			local var_149_10 = 0

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 then
				arg_146_1.var_.moveOldPos1069ui_story = var_149_9.localPosition
			end

			local var_149_11 = 0.001

			if var_149_10 <= arg_146_1.time_ and arg_146_1.time_ < var_149_10 + var_149_11 then
				local var_149_12 = (arg_146_1.time_ - var_149_10) / var_149_11
				local var_149_13 = Vector3.New(-0.7, -1, -6)

				var_149_9.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1069ui_story, var_149_13, var_149_12)

				local var_149_14 = manager.ui.mainCamera.transform.position - var_149_9.position

				var_149_9.forward = Vector3.New(var_149_14.x, var_149_14.y, var_149_14.z)

				local var_149_15 = var_149_9.localEulerAngles

				var_149_15.z = 0
				var_149_15.x = 0
				var_149_9.localEulerAngles = var_149_15
			end

			if arg_146_1.time_ >= var_149_10 + var_149_11 and arg_146_1.time_ < var_149_10 + var_149_11 + arg_149_0 then
				var_149_9.localPosition = Vector3.New(-0.7, -1, -6)

				local var_149_16 = manager.ui.mainCamera.transform.position - var_149_9.position

				var_149_9.forward = Vector3.New(var_149_16.x, var_149_16.y, var_149_16.z)

				local var_149_17 = var_149_9.localEulerAngles

				var_149_17.z = 0
				var_149_17.x = 0
				var_149_9.localEulerAngles = var_149_17
			end

			local var_149_18 = arg_146_1.actors_["1069ui_story"]
			local var_149_19 = 0

			if var_149_19 < arg_146_1.time_ and arg_146_1.time_ <= var_149_19 + arg_149_0 and not isNil(var_149_18) and arg_146_1.var_.characterEffect1069ui_story == nil then
				arg_146_1.var_.characterEffect1069ui_story = var_149_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_20 = 0.2

			if var_149_19 <= arg_146_1.time_ and arg_146_1.time_ < var_149_19 + var_149_20 and not isNil(var_149_18) then
				local var_149_21 = (arg_146_1.time_ - var_149_19) / var_149_20

				if arg_146_1.var_.characterEffect1069ui_story and not isNil(var_149_18) then
					arg_146_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_19 + var_149_20 and arg_146_1.time_ < var_149_19 + var_149_20 + arg_149_0 and not isNil(var_149_18) and arg_146_1.var_.characterEffect1069ui_story then
				arg_146_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_149_22 = arg_146_1.actors_["1084ui_story"]
			local var_149_23 = 0

			if var_149_23 < arg_146_1.time_ and arg_146_1.time_ <= var_149_23 + arg_149_0 and not isNil(var_149_22) and arg_146_1.var_.characterEffect1084ui_story == nil then
				arg_146_1.var_.characterEffect1084ui_story = var_149_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_24 = 0.2

			if var_149_23 <= arg_146_1.time_ and arg_146_1.time_ < var_149_23 + var_149_24 and not isNil(var_149_22) then
				local var_149_25 = (arg_146_1.time_ - var_149_23) / var_149_24

				if arg_146_1.var_.characterEffect1084ui_story and not isNil(var_149_22) then
					local var_149_26 = Mathf.Lerp(0, 0.5, var_149_25)

					arg_146_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1084ui_story.fillRatio = var_149_26
				end
			end

			if arg_146_1.time_ >= var_149_23 + var_149_24 and arg_146_1.time_ < var_149_23 + var_149_24 + arg_149_0 and not isNil(var_149_22) and arg_146_1.var_.characterEffect1084ui_story then
				local var_149_27 = 0.5

				arg_146_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1084ui_story.fillRatio = var_149_27
			end

			local var_149_28 = 0

			if var_149_28 < arg_146_1.time_ and arg_146_1.time_ <= var_149_28 + arg_149_0 then
				arg_146_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action2_1")
			end

			local var_149_29 = 0
			local var_149_30 = 0.825

			if var_149_29 < arg_146_1.time_ and arg_146_1.time_ <= var_149_29 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_31 = arg_146_1:FormatText(StoryNameCfg[378].name)

				arg_146_1.leftNameTxt_.text = var_149_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_32 = arg_146_1:GetWordFromCfg(120031035)
				local var_149_33 = arg_146_1:FormatText(var_149_32.content)

				arg_146_1.text_.text = var_149_33

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_34 = 33
				local var_149_35 = utf8.len(var_149_33)
				local var_149_36 = var_149_34 <= 0 and var_149_30 or var_149_30 * (var_149_35 / var_149_34)

				if var_149_36 > 0 and var_149_30 < var_149_36 then
					arg_146_1.talkMaxDuration = var_149_36

					if var_149_36 + var_149_29 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_36 + var_149_29
					end
				end

				arg_146_1.text_.text = var_149_33
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031035", "story_v_out_120031.awb") ~= 0 then
					local var_149_37 = manager.audio:GetVoiceLength("story_v_out_120031", "120031035", "story_v_out_120031.awb") / 1000

					if var_149_37 + var_149_29 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_37 + var_149_29
					end

					if var_149_32.prefab_name ~= "" and arg_146_1.actors_[var_149_32.prefab_name] ~= nil then
						local var_149_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_32.prefab_name].transform, "story_v_out_120031", "120031035", "story_v_out_120031.awb")

						arg_146_1:RecordAudio("120031035", var_149_38)
						arg_146_1:RecordAudio("120031035", var_149_38)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_120031", "120031035", "story_v_out_120031.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_120031", "120031035", "story_v_out_120031.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_39 = math.max(var_149_30, arg_146_1.talkMaxDuration)

			if var_149_29 <= arg_146_1.time_ and arg_146_1.time_ < var_149_29 + var_149_39 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_29) / var_149_39

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_29 + var_149_39 and arg_146_1.time_ < var_149_29 + var_149_39 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play120031036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 120031036
		arg_150_1.duration_ = 10

		local var_150_0 = {
			zh = 7.2,
			ja = 10
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play120031037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.975

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[378].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_3 = arg_150_1:GetWordFromCfg(120031036)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 39
				local var_153_6 = utf8.len(var_153_4)
				local var_153_7 = var_153_5 <= 0 and var_153_1 or var_153_1 * (var_153_6 / var_153_5)

				if var_153_7 > 0 and var_153_1 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031036", "story_v_out_120031.awb") ~= 0 then
					local var_153_8 = manager.audio:GetVoiceLength("story_v_out_120031", "120031036", "story_v_out_120031.awb") / 1000

					if var_153_8 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_0
					end

					if var_153_3.prefab_name ~= "" and arg_150_1.actors_[var_153_3.prefab_name] ~= nil then
						local var_153_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_3.prefab_name].transform, "story_v_out_120031", "120031036", "story_v_out_120031.awb")

						arg_150_1:RecordAudio("120031036", var_153_9)
						arg_150_1:RecordAudio("120031036", var_153_9)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_120031", "120031036", "story_v_out_120031.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_120031", "120031036", "story_v_out_120031.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_10 and arg_150_1.time_ < var_153_0 + var_153_10 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play120031037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 120031037
		arg_154_1.duration_ = 12.03

		local var_154_0 = {
			zh = 7.533,
			ja = 12.033
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play120031038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1084ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1084ui_story == nil then
				arg_154_1.var_.characterEffect1084ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.2

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1084ui_story and not isNil(var_157_0) then
					arg_154_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1084ui_story then
				arg_154_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_157_4 = arg_154_1.actors_["1069ui_story"]
			local var_157_5 = 0

			if var_157_5 < arg_154_1.time_ and arg_154_1.time_ <= var_157_5 + arg_157_0 and not isNil(var_157_4) and arg_154_1.var_.characterEffect1069ui_story == nil then
				arg_154_1.var_.characterEffect1069ui_story = var_157_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_6 = 0.2

			if var_157_5 <= arg_154_1.time_ and arg_154_1.time_ < var_157_5 + var_157_6 and not isNil(var_157_4) then
				local var_157_7 = (arg_154_1.time_ - var_157_5) / var_157_6

				if arg_154_1.var_.characterEffect1069ui_story and not isNil(var_157_4) then
					local var_157_8 = Mathf.Lerp(0, 0.5, var_157_7)

					arg_154_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1069ui_story.fillRatio = var_157_8
				end
			end

			if arg_154_1.time_ >= var_157_5 + var_157_6 and arg_154_1.time_ < var_157_5 + var_157_6 + arg_157_0 and not isNil(var_157_4) and arg_154_1.var_.characterEffect1069ui_story then
				local var_157_9 = 0.5

				arg_154_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1069ui_story.fillRatio = var_157_9
			end

			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 then
				arg_154_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_157_11 = 0

			if var_157_11 < arg_154_1.time_ and arg_154_1.time_ <= var_157_11 + arg_157_0 then
				arg_154_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_157_12 = 0
			local var_157_13 = 0.725

			if var_157_12 < arg_154_1.time_ and arg_154_1.time_ <= var_157_12 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_14 = arg_154_1:FormatText(StoryNameCfg[6].name)

				arg_154_1.leftNameTxt_.text = var_157_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_15 = arg_154_1:GetWordFromCfg(120031037)
				local var_157_16 = arg_154_1:FormatText(var_157_15.content)

				arg_154_1.text_.text = var_157_16

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_17 = 29
				local var_157_18 = utf8.len(var_157_16)
				local var_157_19 = var_157_17 <= 0 and var_157_13 or var_157_13 * (var_157_18 / var_157_17)

				if var_157_19 > 0 and var_157_13 < var_157_19 then
					arg_154_1.talkMaxDuration = var_157_19

					if var_157_19 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_19 + var_157_12
					end
				end

				arg_154_1.text_.text = var_157_16
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031037", "story_v_out_120031.awb") ~= 0 then
					local var_157_20 = manager.audio:GetVoiceLength("story_v_out_120031", "120031037", "story_v_out_120031.awb") / 1000

					if var_157_20 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_20 + var_157_12
					end

					if var_157_15.prefab_name ~= "" and arg_154_1.actors_[var_157_15.prefab_name] ~= nil then
						local var_157_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_15.prefab_name].transform, "story_v_out_120031", "120031037", "story_v_out_120031.awb")

						arg_154_1:RecordAudio("120031037", var_157_21)
						arg_154_1:RecordAudio("120031037", var_157_21)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_120031", "120031037", "story_v_out_120031.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_120031", "120031037", "story_v_out_120031.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_22 = math.max(var_157_13, arg_154_1.talkMaxDuration)

			if var_157_12 <= arg_154_1.time_ and arg_154_1.time_ < var_157_12 + var_157_22 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_12) / var_157_22

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_12 + var_157_22 and arg_154_1.time_ < var_157_12 + var_157_22 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play120031038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 120031038
		arg_158_1.duration_ = 12.63

		local var_158_0 = {
			zh = 12.633,
			ja = 11.433
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play120031039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = arg_158_1.actors_["1069ui_story"].transform
			local var_161_1 = 0

			if var_161_1 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.var_.moveOldPos1069ui_story = var_161_0.localPosition
			end

			local var_161_2 = 0.001

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_2 then
				local var_161_3 = (arg_158_1.time_ - var_161_1) / var_161_2
				local var_161_4 = Vector3.New(0, 100, 0)

				var_161_0.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1069ui_story, var_161_4, var_161_3)

				local var_161_5 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_5.x, var_161_5.y, var_161_5.z)

				local var_161_6 = var_161_0.localEulerAngles

				var_161_6.z = 0
				var_161_6.x = 0
				var_161_0.localEulerAngles = var_161_6
			end

			if arg_158_1.time_ >= var_161_1 + var_161_2 and arg_158_1.time_ < var_161_1 + var_161_2 + arg_161_0 then
				var_161_0.localPosition = Vector3.New(0, 100, 0)

				local var_161_7 = manager.ui.mainCamera.transform.position - var_161_0.position

				var_161_0.forward = Vector3.New(var_161_7.x, var_161_7.y, var_161_7.z)

				local var_161_8 = var_161_0.localEulerAngles

				var_161_8.z = 0
				var_161_8.x = 0
				var_161_0.localEulerAngles = var_161_8
			end

			local var_161_9 = arg_158_1.actors_["1075ui_story"].transform
			local var_161_10 = 0

			if var_161_10 < arg_158_1.time_ and arg_158_1.time_ <= var_161_10 + arg_161_0 then
				arg_158_1.var_.moveOldPos1075ui_story = var_161_9.localPosition
			end

			local var_161_11 = 0.001

			if var_161_10 <= arg_158_1.time_ and arg_158_1.time_ < var_161_10 + var_161_11 then
				local var_161_12 = (arg_158_1.time_ - var_161_10) / var_161_11
				local var_161_13 = Vector3.New(-0.7, -1.055, -6.16)

				var_161_9.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1075ui_story, var_161_13, var_161_12)

				local var_161_14 = manager.ui.mainCamera.transform.position - var_161_9.position

				var_161_9.forward = Vector3.New(var_161_14.x, var_161_14.y, var_161_14.z)

				local var_161_15 = var_161_9.localEulerAngles

				var_161_15.z = 0
				var_161_15.x = 0
				var_161_9.localEulerAngles = var_161_15
			end

			if arg_158_1.time_ >= var_161_10 + var_161_11 and arg_158_1.time_ < var_161_10 + var_161_11 + arg_161_0 then
				var_161_9.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_161_16 = manager.ui.mainCamera.transform.position - var_161_9.position

				var_161_9.forward = Vector3.New(var_161_16.x, var_161_16.y, var_161_16.z)

				local var_161_17 = var_161_9.localEulerAngles

				var_161_17.z = 0
				var_161_17.x = 0
				var_161_9.localEulerAngles = var_161_17
			end

			local var_161_18 = arg_158_1.actors_["1075ui_story"]
			local var_161_19 = 0

			if var_161_19 < arg_158_1.time_ and arg_158_1.time_ <= var_161_19 + arg_161_0 and not isNil(var_161_18) and arg_158_1.var_.characterEffect1075ui_story == nil then
				arg_158_1.var_.characterEffect1075ui_story = var_161_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_20 = 0.2

			if var_161_19 <= arg_158_1.time_ and arg_158_1.time_ < var_161_19 + var_161_20 and not isNil(var_161_18) then
				local var_161_21 = (arg_158_1.time_ - var_161_19) / var_161_20

				if arg_158_1.var_.characterEffect1075ui_story and not isNil(var_161_18) then
					arg_158_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= var_161_19 + var_161_20 and arg_158_1.time_ < var_161_19 + var_161_20 + arg_161_0 and not isNil(var_161_18) and arg_158_1.var_.characterEffect1075ui_story then
				arg_158_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_161_22 = arg_158_1.actors_["1084ui_story"]
			local var_161_23 = 0

			if var_161_23 < arg_158_1.time_ and arg_158_1.time_ <= var_161_23 + arg_161_0 and not isNil(var_161_22) and arg_158_1.var_.characterEffect1084ui_story == nil then
				arg_158_1.var_.characterEffect1084ui_story = var_161_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_24 = 0.2

			if var_161_23 <= arg_158_1.time_ and arg_158_1.time_ < var_161_23 + var_161_24 and not isNil(var_161_22) then
				local var_161_25 = (arg_158_1.time_ - var_161_23) / var_161_24

				if arg_158_1.var_.characterEffect1084ui_story and not isNil(var_161_22) then
					local var_161_26 = Mathf.Lerp(0, 0.5, var_161_25)

					arg_158_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1084ui_story.fillRatio = var_161_26
				end
			end

			if arg_158_1.time_ >= var_161_23 + var_161_24 and arg_158_1.time_ < var_161_23 + var_161_24 + arg_161_0 and not isNil(var_161_22) and arg_158_1.var_.characterEffect1084ui_story then
				local var_161_27 = 0.5

				arg_158_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1084ui_story.fillRatio = var_161_27
			end

			local var_161_28 = 0

			if var_161_28 < arg_158_1.time_ and arg_158_1.time_ <= var_161_28 + arg_161_0 then
				arg_158_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_161_29 = 0

			if var_161_29 < arg_158_1.time_ and arg_158_1.time_ <= var_161_29 + arg_161_0 then
				arg_158_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_161_30 = 0
			local var_161_31 = 1.375

			if var_161_30 < arg_158_1.time_ and arg_158_1.time_ <= var_161_30 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_32 = arg_158_1:FormatText(StoryNameCfg[381].name)

				arg_158_1.leftNameTxt_.text = var_161_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_33 = arg_158_1:GetWordFromCfg(120031038)
				local var_161_34 = arg_158_1:FormatText(var_161_33.content)

				arg_158_1.text_.text = var_161_34

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_35 = 55
				local var_161_36 = utf8.len(var_161_34)
				local var_161_37 = var_161_35 <= 0 and var_161_31 or var_161_31 * (var_161_36 / var_161_35)

				if var_161_37 > 0 and var_161_31 < var_161_37 then
					arg_158_1.talkMaxDuration = var_161_37

					if var_161_37 + var_161_30 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_37 + var_161_30
					end
				end

				arg_158_1.text_.text = var_161_34
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031038", "story_v_out_120031.awb") ~= 0 then
					local var_161_38 = manager.audio:GetVoiceLength("story_v_out_120031", "120031038", "story_v_out_120031.awb") / 1000

					if var_161_38 + var_161_30 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_38 + var_161_30
					end

					if var_161_33.prefab_name ~= "" and arg_158_1.actors_[var_161_33.prefab_name] ~= nil then
						local var_161_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_33.prefab_name].transform, "story_v_out_120031", "120031038", "story_v_out_120031.awb")

						arg_158_1:RecordAudio("120031038", var_161_39)
						arg_158_1:RecordAudio("120031038", var_161_39)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_120031", "120031038", "story_v_out_120031.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_120031", "120031038", "story_v_out_120031.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_40 = math.max(var_161_31, arg_158_1.talkMaxDuration)

			if var_161_30 <= arg_158_1.time_ and arg_158_1.time_ < var_161_30 + var_161_40 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_30) / var_161_40

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_30 + var_161_40 and arg_158_1.time_ < var_161_30 + var_161_40 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play120031039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 120031039
		arg_162_1.duration_ = 13.8

		local var_162_0 = {
			zh = 13.8,
			ja = 9.6
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play120031040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0
			local var_165_1 = 1.2

			if var_165_0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_2 = arg_162_1:FormatText(StoryNameCfg[381].name)

				arg_162_1.leftNameTxt_.text = var_165_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_3 = arg_162_1:GetWordFromCfg(120031039)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 48
				local var_165_6 = utf8.len(var_165_4)
				local var_165_7 = var_165_5 <= 0 and var_165_1 or var_165_1 * (var_165_6 / var_165_5)

				if var_165_7 > 0 and var_165_1 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_0
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031039", "story_v_out_120031.awb") ~= 0 then
					local var_165_8 = manager.audio:GetVoiceLength("story_v_out_120031", "120031039", "story_v_out_120031.awb") / 1000

					if var_165_8 + var_165_0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_0
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_120031", "120031039", "story_v_out_120031.awb")

						arg_162_1:RecordAudio("120031039", var_165_9)
						arg_162_1:RecordAudio("120031039", var_165_9)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_120031", "120031039", "story_v_out_120031.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_120031", "120031039", "story_v_out_120031.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_10 = math.max(var_165_1, arg_162_1.talkMaxDuration)

			if var_165_0 <= arg_162_1.time_ and arg_162_1.time_ < var_165_0 + var_165_10 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_0) / var_165_10

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_0 + var_165_10 and arg_162_1.time_ < var_165_0 + var_165_10 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play120031040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 120031040
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play120031041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1084ui_story"].transform
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.var_.moveOldPos1084ui_story = var_169_0.localPosition
			end

			local var_169_2 = 0.001

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2
				local var_169_4 = Vector3.New(0, 100, 0)

				var_169_0.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1084ui_story, var_169_4, var_169_3)

				local var_169_5 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_5.x, var_169_5.y, var_169_5.z)

				local var_169_6 = var_169_0.localEulerAngles

				var_169_6.z = 0
				var_169_6.x = 0
				var_169_0.localEulerAngles = var_169_6
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 then
				var_169_0.localPosition = Vector3.New(0, 100, 0)

				local var_169_7 = manager.ui.mainCamera.transform.position - var_169_0.position

				var_169_0.forward = Vector3.New(var_169_7.x, var_169_7.y, var_169_7.z)

				local var_169_8 = var_169_0.localEulerAngles

				var_169_8.z = 0
				var_169_8.x = 0
				var_169_0.localEulerAngles = var_169_8
			end

			local var_169_9 = arg_166_1.actors_["1075ui_story"].transform
			local var_169_10 = 0

			if var_169_10 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1.var_.moveOldPos1075ui_story = var_169_9.localPosition
			end

			local var_169_11 = 0.001

			if var_169_10 <= arg_166_1.time_ and arg_166_1.time_ < var_169_10 + var_169_11 then
				local var_169_12 = (arg_166_1.time_ - var_169_10) / var_169_11
				local var_169_13 = Vector3.New(0, 100, 0)

				var_169_9.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1075ui_story, var_169_13, var_169_12)

				local var_169_14 = manager.ui.mainCamera.transform.position - var_169_9.position

				var_169_9.forward = Vector3.New(var_169_14.x, var_169_14.y, var_169_14.z)

				local var_169_15 = var_169_9.localEulerAngles

				var_169_15.z = 0
				var_169_15.x = 0
				var_169_9.localEulerAngles = var_169_15
			end

			if arg_166_1.time_ >= var_169_10 + var_169_11 and arg_166_1.time_ < var_169_10 + var_169_11 + arg_169_0 then
				var_169_9.localPosition = Vector3.New(0, 100, 0)

				local var_169_16 = manager.ui.mainCamera.transform.position - var_169_9.position

				var_169_9.forward = Vector3.New(var_169_16.x, var_169_16.y, var_169_16.z)

				local var_169_17 = var_169_9.localEulerAngles

				var_169_17.z = 0
				var_169_17.x = 0
				var_169_9.localEulerAngles = var_169_17
			end

			local var_169_18 = 0
			local var_169_19 = 0.975

			if var_169_18 < arg_166_1.time_ and arg_166_1.time_ <= var_169_18 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_20 = arg_166_1:GetWordFromCfg(120031040)
				local var_169_21 = arg_166_1:FormatText(var_169_20.content)

				arg_166_1.text_.text = var_169_21

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_22 = 39
				local var_169_23 = utf8.len(var_169_21)
				local var_169_24 = var_169_22 <= 0 and var_169_19 or var_169_19 * (var_169_23 / var_169_22)

				if var_169_24 > 0 and var_169_19 < var_169_24 then
					arg_166_1.talkMaxDuration = var_169_24

					if var_169_24 + var_169_18 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_24 + var_169_18
					end
				end

				arg_166_1.text_.text = var_169_21
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_25 = math.max(var_169_19, arg_166_1.talkMaxDuration)

			if var_169_18 <= arg_166_1.time_ and arg_166_1.time_ < var_169_18 + var_169_25 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_18) / var_169_25

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_18 + var_169_25 and arg_166_1.time_ < var_169_18 + var_169_25 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play120031041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 120031041
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play120031042(arg_170_1)
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

				local var_173_2 = arg_170_1:GetWordFromCfg(120031041)
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
	Play120031042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 120031042
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play120031043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0
			local var_177_1 = 0.575

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_2 = arg_174_1:FormatText(StoryNameCfg[7].name)

				arg_174_1.leftNameTxt_.text = var_177_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_3 = arg_174_1:GetWordFromCfg(120031042)
				local var_177_4 = arg_174_1:FormatText(var_177_3.content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 23
				local var_177_6 = utf8.len(var_177_4)
				local var_177_7 = var_177_5 <= 0 and var_177_1 or var_177_1 * (var_177_6 / var_177_5)

				if var_177_7 > 0 and var_177_1 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_4
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_8 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_8 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_8

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_8 and arg_174_1.time_ < var_177_0 + var_177_8 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play120031043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 120031043
		arg_178_1.duration_ = 9

		local var_178_0 = {
			zh = 9,
			ja = 6.833
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play120031044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = arg_178_1.actors_["1075ui_story"].transform
			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1.var_.moveOldPos1075ui_story = var_181_0.localPosition
			end

			local var_181_2 = 0.001

			if var_181_1 <= arg_178_1.time_ and arg_178_1.time_ < var_181_1 + var_181_2 then
				local var_181_3 = (arg_178_1.time_ - var_181_1) / var_181_2
				local var_181_4 = Vector3.New(0, -1.055, -6.16)

				var_181_0.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1075ui_story, var_181_4, var_181_3)

				local var_181_5 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_5.x, var_181_5.y, var_181_5.z)

				local var_181_6 = var_181_0.localEulerAngles

				var_181_6.z = 0
				var_181_6.x = 0
				var_181_0.localEulerAngles = var_181_6
			end

			if arg_178_1.time_ >= var_181_1 + var_181_2 and arg_178_1.time_ < var_181_1 + var_181_2 + arg_181_0 then
				var_181_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_181_7 = manager.ui.mainCamera.transform.position - var_181_0.position

				var_181_0.forward = Vector3.New(var_181_7.x, var_181_7.y, var_181_7.z)

				local var_181_8 = var_181_0.localEulerAngles

				var_181_8.z = 0
				var_181_8.x = 0
				var_181_0.localEulerAngles = var_181_8
			end

			local var_181_9 = arg_178_1.actors_["1075ui_story"]
			local var_181_10 = 0

			if var_181_10 < arg_178_1.time_ and arg_178_1.time_ <= var_181_10 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1075ui_story == nil then
				arg_178_1.var_.characterEffect1075ui_story = var_181_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_11 = 0.2

			if var_181_10 <= arg_178_1.time_ and arg_178_1.time_ < var_181_10 + var_181_11 and not isNil(var_181_9) then
				local var_181_12 = (arg_178_1.time_ - var_181_10) / var_181_11

				if arg_178_1.var_.characterEffect1075ui_story and not isNil(var_181_9) then
					arg_178_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= var_181_10 + var_181_11 and arg_178_1.time_ < var_181_10 + var_181_11 + arg_181_0 and not isNil(var_181_9) and arg_178_1.var_.characterEffect1075ui_story then
				arg_178_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_181_13 = 0

			if var_181_13 < arg_178_1.time_ and arg_178_1.time_ <= var_181_13 + arg_181_0 then
				arg_178_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_181_14 = 0

			if var_181_14 < arg_178_1.time_ and arg_178_1.time_ <= var_181_14 + arg_181_0 then
				arg_178_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_181_15 = 0
			local var_181_16 = 0.875

			if var_181_15 < arg_178_1.time_ and arg_178_1.time_ <= var_181_15 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_17 = arg_178_1:FormatText(StoryNameCfg[381].name)

				arg_178_1.leftNameTxt_.text = var_181_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_18 = arg_178_1:GetWordFromCfg(120031043)
				local var_181_19 = arg_178_1:FormatText(var_181_18.content)

				arg_178_1.text_.text = var_181_19

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_20 = 35
				local var_181_21 = utf8.len(var_181_19)
				local var_181_22 = var_181_20 <= 0 and var_181_16 or var_181_16 * (var_181_21 / var_181_20)

				if var_181_22 > 0 and var_181_16 < var_181_22 then
					arg_178_1.talkMaxDuration = var_181_22

					if var_181_22 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_22 + var_181_15
					end
				end

				arg_178_1.text_.text = var_181_19
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031043", "story_v_out_120031.awb") ~= 0 then
					local var_181_23 = manager.audio:GetVoiceLength("story_v_out_120031", "120031043", "story_v_out_120031.awb") / 1000

					if var_181_23 + var_181_15 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_23 + var_181_15
					end

					if var_181_18.prefab_name ~= "" and arg_178_1.actors_[var_181_18.prefab_name] ~= nil then
						local var_181_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_18.prefab_name].transform, "story_v_out_120031", "120031043", "story_v_out_120031.awb")

						arg_178_1:RecordAudio("120031043", var_181_24)
						arg_178_1:RecordAudio("120031043", var_181_24)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_120031", "120031043", "story_v_out_120031.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_120031", "120031043", "story_v_out_120031.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_25 = math.max(var_181_16, arg_178_1.talkMaxDuration)

			if var_181_15 <= arg_178_1.time_ and arg_178_1.time_ < var_181_15 + var_181_25 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_15) / var_181_25

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_15 + var_181_25 and arg_178_1.time_ < var_181_15 + var_181_25 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_178_1:InitPlayNodeList()
	end,
	Play120031044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 120031044
		arg_182_1.duration_ = 13

		local var_182_0 = {
			zh = 11.4,
			ja = 13
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play120031045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_185_1 = 0
			local var_185_2 = 1.175

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_3 = arg_182_1:FormatText(StoryNameCfg[381].name)

				arg_182_1.leftNameTxt_.text = var_185_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_4 = arg_182_1:GetWordFromCfg(120031044)
				local var_185_5 = arg_182_1:FormatText(var_185_4.content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_6 = 47
				local var_185_7 = utf8.len(var_185_5)
				local var_185_8 = var_185_6 <= 0 and var_185_2 or var_185_2 * (var_185_7 / var_185_6)

				if var_185_8 > 0 and var_185_2 < var_185_8 then
					arg_182_1.talkMaxDuration = var_185_8

					if var_185_8 + var_185_1 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_8 + var_185_1
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031044", "story_v_out_120031.awb") ~= 0 then
					local var_185_9 = manager.audio:GetVoiceLength("story_v_out_120031", "120031044", "story_v_out_120031.awb") / 1000

					if var_185_9 + var_185_1 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_1
					end

					if var_185_4.prefab_name ~= "" and arg_182_1.actors_[var_185_4.prefab_name] ~= nil then
						local var_185_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_4.prefab_name].transform, "story_v_out_120031", "120031044", "story_v_out_120031.awb")

						arg_182_1:RecordAudio("120031044", var_185_10)
						arg_182_1:RecordAudio("120031044", var_185_10)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_120031", "120031044", "story_v_out_120031.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_120031", "120031044", "story_v_out_120031.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_11 = math.max(var_185_2, arg_182_1.talkMaxDuration)

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_11 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_1) / var_185_11

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_1 + var_185_11 and arg_182_1.time_ < var_185_1 + var_185_11 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play120031045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 120031045
		arg_186_1.duration_ = 6.5

		local var_186_0 = {
			zh = 4.966,
			ja = 6.5
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play120031046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["10044ui_story"].transform
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 then
				arg_186_1.var_.moveOldPos10044ui_story = var_189_0.localPosition
			end

			local var_189_2 = 0.001

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2
				local var_189_4 = Vector3.New(0.7, -0.72, -6.3)

				var_189_0.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10044ui_story, var_189_4, var_189_3)

				local var_189_5 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_5.x, var_189_5.y, var_189_5.z)

				local var_189_6 = var_189_0.localEulerAngles

				var_189_6.z = 0
				var_189_6.x = 0
				var_189_0.localEulerAngles = var_189_6
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 then
				var_189_0.localPosition = Vector3.New(0.7, -0.72, -6.3)

				local var_189_7 = manager.ui.mainCamera.transform.position - var_189_0.position

				var_189_0.forward = Vector3.New(var_189_7.x, var_189_7.y, var_189_7.z)

				local var_189_8 = var_189_0.localEulerAngles

				var_189_8.z = 0
				var_189_8.x = 0
				var_189_0.localEulerAngles = var_189_8
			end

			local var_189_9 = arg_186_1.actors_["1075ui_story"].transform
			local var_189_10 = 0

			if var_189_10 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 then
				arg_186_1.var_.moveOldPos1075ui_story = var_189_9.localPosition
			end

			local var_189_11 = 0.001

			if var_189_10 <= arg_186_1.time_ and arg_186_1.time_ < var_189_10 + var_189_11 then
				local var_189_12 = (arg_186_1.time_ - var_189_10) / var_189_11
				local var_189_13 = Vector3.New(-0.7, -1.055, -6.16)

				var_189_9.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1075ui_story, var_189_13, var_189_12)

				local var_189_14 = manager.ui.mainCamera.transform.position - var_189_9.position

				var_189_9.forward = Vector3.New(var_189_14.x, var_189_14.y, var_189_14.z)

				local var_189_15 = var_189_9.localEulerAngles

				var_189_15.z = 0
				var_189_15.x = 0
				var_189_9.localEulerAngles = var_189_15
			end

			if arg_186_1.time_ >= var_189_10 + var_189_11 and arg_186_1.time_ < var_189_10 + var_189_11 + arg_189_0 then
				var_189_9.localPosition = Vector3.New(-0.7, -1.055, -6.16)

				local var_189_16 = manager.ui.mainCamera.transform.position - var_189_9.position

				var_189_9.forward = Vector3.New(var_189_16.x, var_189_16.y, var_189_16.z)

				local var_189_17 = var_189_9.localEulerAngles

				var_189_17.z = 0
				var_189_17.x = 0
				var_189_9.localEulerAngles = var_189_17
			end

			local var_189_18 = arg_186_1.actors_["10044ui_story"]
			local var_189_19 = 0

			if var_189_19 < arg_186_1.time_ and arg_186_1.time_ <= var_189_19 + arg_189_0 and not isNil(var_189_18) and arg_186_1.var_.characterEffect10044ui_story == nil then
				arg_186_1.var_.characterEffect10044ui_story = var_189_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_20 = 0.2

			if var_189_19 <= arg_186_1.time_ and arg_186_1.time_ < var_189_19 + var_189_20 and not isNil(var_189_18) then
				local var_189_21 = (arg_186_1.time_ - var_189_19) / var_189_20

				if arg_186_1.var_.characterEffect10044ui_story and not isNil(var_189_18) then
					arg_186_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_19 + var_189_20 and arg_186_1.time_ < var_189_19 + var_189_20 + arg_189_0 and not isNil(var_189_18) and arg_186_1.var_.characterEffect10044ui_story then
				arg_186_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_189_22 = arg_186_1.actors_["1075ui_story"]
			local var_189_23 = 0

			if var_189_23 < arg_186_1.time_ and arg_186_1.time_ <= var_189_23 + arg_189_0 and not isNil(var_189_22) and arg_186_1.var_.characterEffect1075ui_story == nil then
				arg_186_1.var_.characterEffect1075ui_story = var_189_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_24 = 0.2

			if var_189_23 <= arg_186_1.time_ and arg_186_1.time_ < var_189_23 + var_189_24 and not isNil(var_189_22) then
				local var_189_25 = (arg_186_1.time_ - var_189_23) / var_189_24

				if arg_186_1.var_.characterEffect1075ui_story and not isNil(var_189_22) then
					local var_189_26 = Mathf.Lerp(0, 0.5, var_189_25)

					arg_186_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1075ui_story.fillRatio = var_189_26
				end
			end

			if arg_186_1.time_ >= var_189_23 + var_189_24 and arg_186_1.time_ < var_189_23 + var_189_24 + arg_189_0 and not isNil(var_189_22) and arg_186_1.var_.characterEffect1075ui_story then
				local var_189_27 = 0.5

				arg_186_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1075ui_story.fillRatio = var_189_27
			end

			local var_189_28 = 0

			if var_189_28 < arg_186_1.time_ and arg_186_1.time_ <= var_189_28 + arg_189_0 then
				arg_186_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_189_29 = 0

			if var_189_29 < arg_186_1.time_ and arg_186_1.time_ <= var_189_29 + arg_189_0 then
				arg_186_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_189_30 = 0
			local var_189_31 = 0.525

			if var_189_30 < arg_186_1.time_ and arg_186_1.time_ <= var_189_30 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_32 = arg_186_1:FormatText(StoryNameCfg[380].name)

				arg_186_1.leftNameTxt_.text = var_189_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_33 = arg_186_1:GetWordFromCfg(120031045)
				local var_189_34 = arg_186_1:FormatText(var_189_33.content)

				arg_186_1.text_.text = var_189_34

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_35 = 21
				local var_189_36 = utf8.len(var_189_34)
				local var_189_37 = var_189_35 <= 0 and var_189_31 or var_189_31 * (var_189_36 / var_189_35)

				if var_189_37 > 0 and var_189_31 < var_189_37 then
					arg_186_1.talkMaxDuration = var_189_37

					if var_189_37 + var_189_30 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_37 + var_189_30
					end
				end

				arg_186_1.text_.text = var_189_34
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031045", "story_v_out_120031.awb") ~= 0 then
					local var_189_38 = manager.audio:GetVoiceLength("story_v_out_120031", "120031045", "story_v_out_120031.awb") / 1000

					if var_189_38 + var_189_30 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_38 + var_189_30
					end

					if var_189_33.prefab_name ~= "" and arg_186_1.actors_[var_189_33.prefab_name] ~= nil then
						local var_189_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_33.prefab_name].transform, "story_v_out_120031", "120031045", "story_v_out_120031.awb")

						arg_186_1:RecordAudio("120031045", var_189_39)
						arg_186_1:RecordAudio("120031045", var_189_39)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_120031", "120031045", "story_v_out_120031.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_120031", "120031045", "story_v_out_120031.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_40 = math.max(var_189_31, arg_186_1.talkMaxDuration)

			if var_189_30 <= arg_186_1.time_ and arg_186_1.time_ < var_189_30 + var_189_40 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_30) / var_189_40

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_30 + var_189_40 and arg_186_1.time_ < var_189_30 + var_189_40 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play120031046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 120031046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play120031047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["10044ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect10044ui_story == nil then
				arg_190_1.var_.characterEffect10044ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.2

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect10044ui_story and not isNil(var_193_0) then
					local var_193_4 = Mathf.Lerp(0, 0.5, var_193_3)

					arg_190_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_190_1.var_.characterEffect10044ui_story.fillRatio = var_193_4
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect10044ui_story then
				local var_193_5 = 0.5

				arg_190_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_190_1.var_.characterEffect10044ui_story.fillRatio = var_193_5
			end

			local var_193_6 = 0
			local var_193_7 = 0.15

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

				local var_193_9 = arg_190_1:GetWordFromCfg(120031046)
				local var_193_10 = arg_190_1:FormatText(var_193_9.content)

				arg_190_1.text_.text = var_193_10

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_11 = 6
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
	Play120031047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 120031047
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play120031048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0
			local var_197_1 = 0.4

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_2 = arg_194_1:FormatText(StoryNameCfg[7].name)

				arg_194_1.leftNameTxt_.text = var_197_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_3 = arg_194_1:GetWordFromCfg(120031047)
				local var_197_4 = arg_194_1:FormatText(var_197_3.content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 16
				local var_197_6 = utf8.len(var_197_4)
				local var_197_7 = var_197_5 <= 0 and var_197_1 or var_197_1 * (var_197_6 / var_197_5)

				if var_197_7 > 0 and var_197_1 < var_197_7 then
					arg_194_1.talkMaxDuration = var_197_7

					if var_197_7 + var_197_0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_7 + var_197_0
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_8 = math.max(var_197_1, arg_194_1.talkMaxDuration)

			if var_197_0 <= arg_194_1.time_ and arg_194_1.time_ < var_197_0 + var_197_8 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_0) / var_197_8

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_0 + var_197_8 and arg_194_1.time_ < var_197_0 + var_197_8 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play120031048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 120031048
		arg_198_1.duration_ = 6.37

		local var_198_0 = {
			zh = 2.9,
			ja = 6.366
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play120031049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1075ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1075ui_story == nil then
				arg_198_1.var_.characterEffect1075ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 1

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1075ui_story and not isNil(var_201_0) then
					arg_198_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1075ui_story then
				arg_198_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_201_4 = 0

			if var_201_4 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_201_5 = 0

			if var_201_5 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_201_6 = 0
			local var_201_7 = 0.375

			if var_201_6 < arg_198_1.time_ and arg_198_1.time_ <= var_201_6 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_8 = arg_198_1:FormatText(StoryNameCfg[381].name)

				arg_198_1.leftNameTxt_.text = var_201_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_9 = arg_198_1:GetWordFromCfg(120031048)
				local var_201_10 = arg_198_1:FormatText(var_201_9.content)

				arg_198_1.text_.text = var_201_10

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_11 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031048", "story_v_out_120031.awb") ~= 0 then
					local var_201_14 = manager.audio:GetVoiceLength("story_v_out_120031", "120031048", "story_v_out_120031.awb") / 1000

					if var_201_14 + var_201_6 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_14 + var_201_6
					end

					if var_201_9.prefab_name ~= "" and arg_198_1.actors_[var_201_9.prefab_name] ~= nil then
						local var_201_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_9.prefab_name].transform, "story_v_out_120031", "120031048", "story_v_out_120031.awb")

						arg_198_1:RecordAudio("120031048", var_201_15)
						arg_198_1:RecordAudio("120031048", var_201_15)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_120031", "120031048", "story_v_out_120031.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_120031", "120031048", "story_v_out_120031.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_16 = math.max(var_201_7, arg_198_1.talkMaxDuration)

			if var_201_6 <= arg_198_1.time_ and arg_198_1.time_ < var_201_6 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_6) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_6 + var_201_16 and arg_198_1.time_ < var_201_6 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play120031049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 120031049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play120031050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1075ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1075ui_story == nil then
				arg_202_1.var_.characterEffect1075ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.2

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect1075ui_story and not isNil(var_205_0) then
					local var_205_4 = Mathf.Lerp(0, 0.5, var_205_3)

					arg_202_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1075ui_story.fillRatio = var_205_4
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1075ui_story then
				local var_205_5 = 0.5

				arg_202_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1075ui_story.fillRatio = var_205_5
			end

			local var_205_6 = 0
			local var_205_7 = 0.75

			if var_205_6 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_8 = arg_202_1:FormatText(StoryNameCfg[7].name)

				arg_202_1.leftNameTxt_.text = var_205_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_9 = arg_202_1:GetWordFromCfg(120031049)
				local var_205_10 = arg_202_1:FormatText(var_205_9.content)

				arg_202_1.text_.text = var_205_10

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_11 = 30
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
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_14 = math.max(var_205_7, arg_202_1.talkMaxDuration)

			if var_205_6 <= arg_202_1.time_ and arg_202_1.time_ < var_205_6 + var_205_14 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_6) / var_205_14

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_6 + var_205_14 and arg_202_1.time_ < var_205_6 + var_205_14 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play120031050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 120031050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play120031051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0
			local var_209_1 = 0.9

			if var_209_0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_2 = arg_206_1:GetWordFromCfg(120031050)
				local var_209_3 = arg_206_1:FormatText(var_209_2.content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_4 = 36
				local var_209_5 = utf8.len(var_209_3)
				local var_209_6 = var_209_4 <= 0 and var_209_1 or var_209_1 * (var_209_5 / var_209_4)

				if var_209_6 > 0 and var_209_1 < var_209_6 then
					arg_206_1.talkMaxDuration = var_209_6

					if var_209_6 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_6 + var_209_0
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_7 = math.max(var_209_1, arg_206_1.talkMaxDuration)

			if var_209_0 <= arg_206_1.time_ and arg_206_1.time_ < var_209_0 + var_209_7 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_0) / var_209_7

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_0 + var_209_7 and arg_206_1.time_ < var_209_0 + var_209_7 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play120031051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 120031051
		arg_210_1.duration_ = 14.77

		local var_210_0 = {
			zh = 8.2,
			ja = 14.766
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play120031052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1075ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1075ui_story == nil then
				arg_210_1.var_.characterEffect1075ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.2

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect1075ui_story and not isNil(var_213_0) then
					arg_210_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1075ui_story then
				arg_210_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_213_4 = 0

			if var_213_4 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_213_5 = 0

			if var_213_5 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_213_6 = 0
			local var_213_7 = 0.9

			if var_213_6 < arg_210_1.time_ and arg_210_1.time_ <= var_213_6 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_8 = arg_210_1:FormatText(StoryNameCfg[381].name)

				arg_210_1.leftNameTxt_.text = var_213_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_9 = arg_210_1:GetWordFromCfg(120031051)
				local var_213_10 = arg_210_1:FormatText(var_213_9.content)

				arg_210_1.text_.text = var_213_10

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_11 = 36
				local var_213_12 = utf8.len(var_213_10)
				local var_213_13 = var_213_11 <= 0 and var_213_7 or var_213_7 * (var_213_12 / var_213_11)

				if var_213_13 > 0 and var_213_7 < var_213_13 then
					arg_210_1.talkMaxDuration = var_213_13

					if var_213_13 + var_213_6 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_13 + var_213_6
					end
				end

				arg_210_1.text_.text = var_213_10
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031051", "story_v_out_120031.awb") ~= 0 then
					local var_213_14 = manager.audio:GetVoiceLength("story_v_out_120031", "120031051", "story_v_out_120031.awb") / 1000

					if var_213_14 + var_213_6 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_14 + var_213_6
					end

					if var_213_9.prefab_name ~= "" and arg_210_1.actors_[var_213_9.prefab_name] ~= nil then
						local var_213_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_9.prefab_name].transform, "story_v_out_120031", "120031051", "story_v_out_120031.awb")

						arg_210_1:RecordAudio("120031051", var_213_15)
						arg_210_1:RecordAudio("120031051", var_213_15)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_120031", "120031051", "story_v_out_120031.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_120031", "120031051", "story_v_out_120031.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_16 = math.max(var_213_7, arg_210_1.talkMaxDuration)

			if var_213_6 <= arg_210_1.time_ and arg_210_1.time_ < var_213_6 + var_213_16 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_6) / var_213_16

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_6 + var_213_16 and arg_210_1.time_ < var_213_6 + var_213_16 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play120031052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 120031052
		arg_214_1.duration_ = 11.5

		local var_214_0 = {
			zh = 11.5,
			ja = 9.066
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play120031053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.975

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[381].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_3 = arg_214_1:GetWordFromCfg(120031052)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 39
				local var_217_6 = utf8.len(var_217_4)
				local var_217_7 = var_217_5 <= 0 and var_217_1 or var_217_1 * (var_217_6 / var_217_5)

				if var_217_7 > 0 and var_217_1 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031052", "story_v_out_120031.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_120031", "120031052", "story_v_out_120031.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_120031", "120031052", "story_v_out_120031.awb")

						arg_214_1:RecordAudio("120031052", var_217_9)
						arg_214_1:RecordAudio("120031052", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_120031", "120031052", "story_v_out_120031.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_120031", "120031052", "story_v_out_120031.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_10 and arg_214_1.time_ < var_217_0 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play120031053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 120031053
		arg_218_1.duration_ = 2

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play120031054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["10044ui_story"]
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect10044ui_story == nil then
				arg_218_1.var_.characterEffect10044ui_story = var_221_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_2 = 0.2

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_2 and not isNil(var_221_0) then
				local var_221_3 = (arg_218_1.time_ - var_221_1) / var_221_2

				if arg_218_1.var_.characterEffect10044ui_story and not isNil(var_221_0) then
					arg_218_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_1 + var_221_2 and arg_218_1.time_ < var_221_1 + var_221_2 + arg_221_0 and not isNil(var_221_0) and arg_218_1.var_.characterEffect10044ui_story then
				arg_218_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_221_4 = arg_218_1.actors_["1075ui_story"]
			local var_221_5 = 0

			if var_221_5 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 and not isNil(var_221_4) and arg_218_1.var_.characterEffect1075ui_story == nil then
				arg_218_1.var_.characterEffect1075ui_story = var_221_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_6 = 0.2

			if var_221_5 <= arg_218_1.time_ and arg_218_1.time_ < var_221_5 + var_221_6 and not isNil(var_221_4) then
				local var_221_7 = (arg_218_1.time_ - var_221_5) / var_221_6

				if arg_218_1.var_.characterEffect1075ui_story and not isNil(var_221_4) then
					local var_221_8 = Mathf.Lerp(0, 0.5, var_221_7)

					arg_218_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1075ui_story.fillRatio = var_221_8
				end
			end

			if arg_218_1.time_ >= var_221_5 + var_221_6 and arg_218_1.time_ < var_221_5 + var_221_6 + arg_221_0 and not isNil(var_221_4) and arg_218_1.var_.characterEffect1075ui_story then
				local var_221_9 = 0.5

				arg_218_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1075ui_story.fillRatio = var_221_9
			end

			local var_221_10 = 0

			if var_221_10 < arg_218_1.time_ and arg_218_1.time_ <= var_221_10 + arg_221_0 then
				arg_218_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_221_11 = 0

			if var_221_11 < arg_218_1.time_ and arg_218_1.time_ <= var_221_11 + arg_221_0 then
				arg_218_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_221_12 = 0
			local var_221_13 = 0.15

			if var_221_12 < arg_218_1.time_ and arg_218_1.time_ <= var_221_12 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_14 = arg_218_1:FormatText(StoryNameCfg[380].name)

				arg_218_1.leftNameTxt_.text = var_221_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_15 = arg_218_1:GetWordFromCfg(120031053)
				local var_221_16 = arg_218_1:FormatText(var_221_15.content)

				arg_218_1.text_.text = var_221_16

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_17 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031053", "story_v_out_120031.awb") ~= 0 then
					local var_221_20 = manager.audio:GetVoiceLength("story_v_out_120031", "120031053", "story_v_out_120031.awb") / 1000

					if var_221_20 + var_221_12 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_20 + var_221_12
					end

					if var_221_15.prefab_name ~= "" and arg_218_1.actors_[var_221_15.prefab_name] ~= nil then
						local var_221_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_15.prefab_name].transform, "story_v_out_120031", "120031053", "story_v_out_120031.awb")

						arg_218_1:RecordAudio("120031053", var_221_21)
						arg_218_1:RecordAudio("120031053", var_221_21)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_120031", "120031053", "story_v_out_120031.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_120031", "120031053", "story_v_out_120031.awb")
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
	Play120031054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 120031054
		arg_222_1.duration_ = 10.5

		local var_222_0 = {
			zh = 10.5,
			ja = 9.366
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play120031055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["1075ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1075ui_story == nil then
				arg_222_1.var_.characterEffect1075ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect1075ui_story and not isNil(var_225_0) then
					arg_222_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect1075ui_story then
				arg_222_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_225_4 = arg_222_1.actors_["10044ui_story"]
			local var_225_5 = 0

			if var_225_5 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 and not isNil(var_225_4) and arg_222_1.var_.characterEffect10044ui_story == nil then
				arg_222_1.var_.characterEffect10044ui_story = var_225_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_6 = 0.2

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_6 and not isNil(var_225_4) then
				local var_225_7 = (arg_222_1.time_ - var_225_5) / var_225_6

				if arg_222_1.var_.characterEffect10044ui_story and not isNil(var_225_4) then
					local var_225_8 = Mathf.Lerp(0, 0.5, var_225_7)

					arg_222_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_222_1.var_.characterEffect10044ui_story.fillRatio = var_225_8
				end
			end

			if arg_222_1.time_ >= var_225_5 + var_225_6 and arg_222_1.time_ < var_225_5 + var_225_6 + arg_225_0 and not isNil(var_225_4) and arg_222_1.var_.characterEffect10044ui_story then
				local var_225_9 = 0.5

				arg_222_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_222_1.var_.characterEffect10044ui_story.fillRatio = var_225_9
			end

			local var_225_10 = 0
			local var_225_11 = 0.925

			if var_225_10 < arg_222_1.time_ and arg_222_1.time_ <= var_225_10 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_12 = arg_222_1:FormatText(StoryNameCfg[381].name)

				arg_222_1.leftNameTxt_.text = var_225_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_13 = arg_222_1:GetWordFromCfg(120031054)
				local var_225_14 = arg_222_1:FormatText(var_225_13.content)

				arg_222_1.text_.text = var_225_14

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_15 = 37
				local var_225_16 = utf8.len(var_225_14)
				local var_225_17 = var_225_15 <= 0 and var_225_11 or var_225_11 * (var_225_16 / var_225_15)

				if var_225_17 > 0 and var_225_11 < var_225_17 then
					arg_222_1.talkMaxDuration = var_225_17

					if var_225_17 + var_225_10 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_17 + var_225_10
					end
				end

				arg_222_1.text_.text = var_225_14
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031054", "story_v_out_120031.awb") ~= 0 then
					local var_225_18 = manager.audio:GetVoiceLength("story_v_out_120031", "120031054", "story_v_out_120031.awb") / 1000

					if var_225_18 + var_225_10 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_18 + var_225_10
					end

					if var_225_13.prefab_name ~= "" and arg_222_1.actors_[var_225_13.prefab_name] ~= nil then
						local var_225_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_13.prefab_name].transform, "story_v_out_120031", "120031054", "story_v_out_120031.awb")

						arg_222_1:RecordAudio("120031054", var_225_19)
						arg_222_1:RecordAudio("120031054", var_225_19)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_120031", "120031054", "story_v_out_120031.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_120031", "120031054", "story_v_out_120031.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_20 = math.max(var_225_11, arg_222_1.talkMaxDuration)

			if var_225_10 <= arg_222_1.time_ and arg_222_1.time_ < var_225_10 + var_225_20 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_10) / var_225_20

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_10 + var_225_20 and arg_222_1.time_ < var_225_10 + var_225_20 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play120031055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 120031055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play120031056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1075ui_story"]
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1075ui_story == nil then
				arg_226_1.var_.characterEffect1075ui_story = var_229_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_2 = 0.2

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_2 and not isNil(var_229_0) then
				local var_229_3 = (arg_226_1.time_ - var_229_1) / var_229_2

				if arg_226_1.var_.characterEffect1075ui_story and not isNil(var_229_0) then
					local var_229_4 = Mathf.Lerp(0, 0.5, var_229_3)

					arg_226_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1075ui_story.fillRatio = var_229_4
				end
			end

			if arg_226_1.time_ >= var_229_1 + var_229_2 and arg_226_1.time_ < var_229_1 + var_229_2 + arg_229_0 and not isNil(var_229_0) and arg_226_1.var_.characterEffect1075ui_story then
				local var_229_5 = 0.5

				arg_226_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1075ui_story.fillRatio = var_229_5
			end

			local var_229_6 = 0
			local var_229_7 = 0.225

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_8 = arg_226_1:FormatText(StoryNameCfg[7].name)

				arg_226_1.leftNameTxt_.text = var_229_8

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

				local var_229_9 = arg_226_1:GetWordFromCfg(120031055)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 9
				local var_229_12 = utf8.len(var_229_10)
				local var_229_13 = var_229_11 <= 0 and var_229_7 or var_229_7 * (var_229_12 / var_229_11)

				if var_229_13 > 0 and var_229_7 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_14 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_14 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_14

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_14 and arg_226_1.time_ < var_229_6 + var_229_14 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play120031056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 120031056
		arg_230_1.duration_ = 9.1

		local var_230_0 = {
			zh = 9.1,
			ja = 7.733
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play120031057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1075ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos1075ui_story = var_233_0.localPosition
			end

			local var_233_2 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2
				local var_233_4 = Vector3.New(0, 100, 0)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1075ui_story, var_233_4, var_233_3)

				local var_233_5 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_5.x, var_233_5.y, var_233_5.z)

				local var_233_6 = var_233_0.localEulerAngles

				var_233_6.z = 0
				var_233_6.x = 0
				var_233_0.localEulerAngles = var_233_6
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(0, 100, 0)

				local var_233_7 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_7.x, var_233_7.y, var_233_7.z)

				local var_233_8 = var_233_0.localEulerAngles

				var_233_8.z = 0
				var_233_8.x = 0
				var_233_0.localEulerAngles = var_233_8
			end

			local var_233_9 = arg_230_1.actors_["10044ui_story"].transform
			local var_233_10 = 0

			if var_233_10 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 then
				arg_230_1.var_.moveOldPos10044ui_story = var_233_9.localPosition
			end

			local var_233_11 = 0.001

			if var_233_10 <= arg_230_1.time_ and arg_230_1.time_ < var_233_10 + var_233_11 then
				local var_233_12 = (arg_230_1.time_ - var_233_10) / var_233_11
				local var_233_13 = Vector3.New(0, 100, 0)

				var_233_9.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10044ui_story, var_233_13, var_233_12)

				local var_233_14 = manager.ui.mainCamera.transform.position - var_233_9.position

				var_233_9.forward = Vector3.New(var_233_14.x, var_233_14.y, var_233_14.z)

				local var_233_15 = var_233_9.localEulerAngles

				var_233_15.z = 0
				var_233_15.x = 0
				var_233_9.localEulerAngles = var_233_15
			end

			if arg_230_1.time_ >= var_233_10 + var_233_11 and arg_230_1.time_ < var_233_10 + var_233_11 + arg_233_0 then
				var_233_9.localPosition = Vector3.New(0, 100, 0)

				local var_233_16 = manager.ui.mainCamera.transform.position - var_233_9.position

				var_233_9.forward = Vector3.New(var_233_16.x, var_233_16.y, var_233_16.z)

				local var_233_17 = var_233_9.localEulerAngles

				var_233_17.z = 0
				var_233_17.x = 0
				var_233_9.localEulerAngles = var_233_17
			end

			local var_233_18 = 0
			local var_233_19 = 0.825

			if var_233_18 < arg_230_1.time_ and arg_230_1.time_ <= var_233_18 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_20 = arg_230_1:FormatText(StoryNameCfg[10].name)

				arg_230_1.leftNameTxt_.text = var_233_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_21 = arg_230_1:GetWordFromCfg(120031056)
				local var_233_22 = arg_230_1:FormatText(var_233_21.content)

				arg_230_1.text_.text = var_233_22

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_23 = 33
				local var_233_24 = utf8.len(var_233_22)
				local var_233_25 = var_233_23 <= 0 and var_233_19 or var_233_19 * (var_233_24 / var_233_23)

				if var_233_25 > 0 and var_233_19 < var_233_25 then
					arg_230_1.talkMaxDuration = var_233_25

					if var_233_25 + var_233_18 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_25 + var_233_18
					end
				end

				arg_230_1.text_.text = var_233_22
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031056", "story_v_out_120031.awb") ~= 0 then
					local var_233_26 = manager.audio:GetVoiceLength("story_v_out_120031", "120031056", "story_v_out_120031.awb") / 1000

					if var_233_26 + var_233_18 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_26 + var_233_18
					end

					if var_233_21.prefab_name ~= "" and arg_230_1.actors_[var_233_21.prefab_name] ~= nil then
						local var_233_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_21.prefab_name].transform, "story_v_out_120031", "120031056", "story_v_out_120031.awb")

						arg_230_1:RecordAudio("120031056", var_233_27)
						arg_230_1:RecordAudio("120031056", var_233_27)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_120031", "120031056", "story_v_out_120031.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_120031", "120031056", "story_v_out_120031.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_28 = math.max(var_233_19, arg_230_1.talkMaxDuration)

			if var_233_18 <= arg_230_1.time_ and arg_230_1.time_ < var_233_18 + var_233_28 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_18) / var_233_28

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_18 + var_233_28 and arg_230_1.time_ < var_233_18 + var_233_28 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play120031057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 120031057
		arg_234_1.duration_ = 2.23

		local var_234_0 = {
			zh = 2.233,
			ja = 2
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play120031058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["10044ui_story"].transform
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.var_.moveOldPos10044ui_story = var_237_0.localPosition
			end

			local var_237_2 = 0.001

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2
				local var_237_4 = Vector3.New(0, -0.72, -6.3)

				var_237_0.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10044ui_story, var_237_4, var_237_3)

				local var_237_5 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_5.x, var_237_5.y, var_237_5.z)

				local var_237_6 = var_237_0.localEulerAngles

				var_237_6.z = 0
				var_237_6.x = 0
				var_237_0.localEulerAngles = var_237_6
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 then
				var_237_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_237_7 = manager.ui.mainCamera.transform.position - var_237_0.position

				var_237_0.forward = Vector3.New(var_237_7.x, var_237_7.y, var_237_7.z)

				local var_237_8 = var_237_0.localEulerAngles

				var_237_8.z = 0
				var_237_8.x = 0
				var_237_0.localEulerAngles = var_237_8
			end

			local var_237_9 = arg_234_1.actors_["10044ui_story"]
			local var_237_10 = 0

			if var_237_10 < arg_234_1.time_ and arg_234_1.time_ <= var_237_10 + arg_237_0 and not isNil(var_237_9) and arg_234_1.var_.characterEffect10044ui_story == nil then
				arg_234_1.var_.characterEffect10044ui_story = var_237_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_11 = 0.2

			if var_237_10 <= arg_234_1.time_ and arg_234_1.time_ < var_237_10 + var_237_11 and not isNil(var_237_9) then
				local var_237_12 = (arg_234_1.time_ - var_237_10) / var_237_11

				if arg_234_1.var_.characterEffect10044ui_story and not isNil(var_237_9) then
					arg_234_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_10 + var_237_11 and arg_234_1.time_ < var_237_10 + var_237_11 + arg_237_0 and not isNil(var_237_9) and arg_234_1.var_.characterEffect10044ui_story then
				arg_234_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_237_13 = 0

			if var_237_13 < arg_234_1.time_ and arg_234_1.time_ <= var_237_13 + arg_237_0 then
				arg_234_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_237_14 = 0

			if var_237_14 < arg_234_1.time_ and arg_234_1.time_ <= var_237_14 + arg_237_0 then
				arg_234_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_237_15 = 0
			local var_237_16 = 0.2

			if var_237_15 < arg_234_1.time_ and arg_234_1.time_ <= var_237_15 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_17 = arg_234_1:FormatText(StoryNameCfg[380].name)

				arg_234_1.leftNameTxt_.text = var_237_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_18 = arg_234_1:GetWordFromCfg(120031057)
				local var_237_19 = arg_234_1:FormatText(var_237_18.content)

				arg_234_1.text_.text = var_237_19

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_20 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031057", "story_v_out_120031.awb") ~= 0 then
					local var_237_23 = manager.audio:GetVoiceLength("story_v_out_120031", "120031057", "story_v_out_120031.awb") / 1000

					if var_237_23 + var_237_15 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_23 + var_237_15
					end

					if var_237_18.prefab_name ~= "" and arg_234_1.actors_[var_237_18.prefab_name] ~= nil then
						local var_237_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_18.prefab_name].transform, "story_v_out_120031", "120031057", "story_v_out_120031.awb")

						arg_234_1:RecordAudio("120031057", var_237_24)
						arg_234_1:RecordAudio("120031057", var_237_24)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_120031", "120031057", "story_v_out_120031.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_120031", "120031057", "story_v_out_120031.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_25 = math.max(var_237_16, arg_234_1.talkMaxDuration)

			if var_237_15 <= arg_234_1.time_ and arg_234_1.time_ < var_237_15 + var_237_25 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_15) / var_237_25

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_15 + var_237_25 and arg_234_1.time_ < var_237_15 + var_237_25 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play120031058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 120031058
		arg_238_1.duration_ = 7.53

		local var_238_0 = {
			zh = 4.966,
			ja = 7.533
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
				arg_238_0:Play120031059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["10044ui_story"]
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect10044ui_story == nil then
				arg_238_1.var_.characterEffect10044ui_story = var_241_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.2

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 and not isNil(var_241_0) then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2

				if arg_238_1.var_.characterEffect10044ui_story and not isNil(var_241_0) then
					local var_241_4 = Mathf.Lerp(0, 0.5, var_241_3)

					arg_238_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_238_1.var_.characterEffect10044ui_story.fillRatio = var_241_4
				end
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 and not isNil(var_241_0) and arg_238_1.var_.characterEffect10044ui_story then
				local var_241_5 = 0.5

				arg_238_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_238_1.var_.characterEffect10044ui_story.fillRatio = var_241_5
			end

			local var_241_6 = 0
			local var_241_7 = 0.45

			if var_241_6 < arg_238_1.time_ and arg_238_1.time_ <= var_241_6 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_8 = arg_238_1:FormatText(StoryNameCfg[10].name)

				arg_238_1.leftNameTxt_.text = var_241_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_9 = arg_238_1:GetWordFromCfg(120031058)
				local var_241_10 = arg_238_1:FormatText(var_241_9.content)

				arg_238_1.text_.text = var_241_10

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_11 = 18
				local var_241_12 = utf8.len(var_241_10)
				local var_241_13 = var_241_11 <= 0 and var_241_7 or var_241_7 * (var_241_12 / var_241_11)

				if var_241_13 > 0 and var_241_7 < var_241_13 then
					arg_238_1.talkMaxDuration = var_241_13

					if var_241_13 + var_241_6 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_13 + var_241_6
					end
				end

				arg_238_1.text_.text = var_241_10
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031058", "story_v_out_120031.awb") ~= 0 then
					local var_241_14 = manager.audio:GetVoiceLength("story_v_out_120031", "120031058", "story_v_out_120031.awb") / 1000

					if var_241_14 + var_241_6 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_14 + var_241_6
					end

					if var_241_9.prefab_name ~= "" and arg_238_1.actors_[var_241_9.prefab_name] ~= nil then
						local var_241_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_9.prefab_name].transform, "story_v_out_120031", "120031058", "story_v_out_120031.awb")

						arg_238_1:RecordAudio("120031058", var_241_15)
						arg_238_1:RecordAudio("120031058", var_241_15)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_120031", "120031058", "story_v_out_120031.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_120031", "120031058", "story_v_out_120031.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_16 = math.max(var_241_7, arg_238_1.talkMaxDuration)

			if var_241_6 <= arg_238_1.time_ and arg_238_1.time_ < var_241_6 + var_241_16 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_6) / var_241_16

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_6 + var_241_16 and arg_238_1.time_ < var_241_6 + var_241_16 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play120031059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 120031059
		arg_242_1.duration_ = 2.93

		local var_242_0 = {
			zh = 2.6,
			ja = 2.933
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play120031060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["10044ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect10044ui_story == nil then
				arg_242_1.var_.characterEffect10044ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.2

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect10044ui_story and not isNil(var_245_0) then
					arg_242_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect10044ui_story then
				arg_242_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_245_4 = 0

			if var_245_4 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_245_5 = 0

			if var_245_5 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_245_6 = 0
			local var_245_7 = 0.225

			if var_245_6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				local var_245_8 = arg_242_1:FormatText(StoryNameCfg[380].name)

				arg_242_1.leftNameTxt_.text = var_245_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_9 = arg_242_1:GetWordFromCfg(120031059)
				local var_245_10 = arg_242_1:FormatText(var_245_9.content)

				arg_242_1.text_.text = var_245_10

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_11 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031059", "story_v_out_120031.awb") ~= 0 then
					local var_245_14 = manager.audio:GetVoiceLength("story_v_out_120031", "120031059", "story_v_out_120031.awb") / 1000

					if var_245_14 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_14 + var_245_6
					end

					if var_245_9.prefab_name ~= "" and arg_242_1.actors_[var_245_9.prefab_name] ~= nil then
						local var_245_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_9.prefab_name].transform, "story_v_out_120031", "120031059", "story_v_out_120031.awb")

						arg_242_1:RecordAudio("120031059", var_245_15)
						arg_242_1:RecordAudio("120031059", var_245_15)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_120031", "120031059", "story_v_out_120031.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_120031", "120031059", "story_v_out_120031.awb")
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
	Play120031060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 120031060
		arg_246_1.duration_ = 3.9

		local var_246_0 = {
			zh = 2.266,
			ja = 3.9
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
				arg_246_0:Play120031061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = arg_246_1.actors_["10044ui_story"].transform
			local var_249_1 = 0

			if var_249_1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.var_.moveOldPos10044ui_story = var_249_0.localPosition
			end

			local var_249_2 = 0.001

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_2 then
				local var_249_3 = (arg_246_1.time_ - var_249_1) / var_249_2
				local var_249_4 = Vector3.New(0, 100, 0)

				var_249_0.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos10044ui_story, var_249_4, var_249_3)

				local var_249_5 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_5.x, var_249_5.y, var_249_5.z)

				local var_249_6 = var_249_0.localEulerAngles

				var_249_6.z = 0
				var_249_6.x = 0
				var_249_0.localEulerAngles = var_249_6
			end

			if arg_246_1.time_ >= var_249_1 + var_249_2 and arg_246_1.time_ < var_249_1 + var_249_2 + arg_249_0 then
				var_249_0.localPosition = Vector3.New(0, 100, 0)

				local var_249_7 = manager.ui.mainCamera.transform.position - var_249_0.position

				var_249_0.forward = Vector3.New(var_249_7.x, var_249_7.y, var_249_7.z)

				local var_249_8 = var_249_0.localEulerAngles

				var_249_8.z = 0
				var_249_8.x = 0
				var_249_0.localEulerAngles = var_249_8
			end

			local var_249_9 = arg_246_1.actors_["1069ui_story"].transform
			local var_249_10 = 0

			if var_249_10 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 then
				arg_246_1.var_.moveOldPos1069ui_story = var_249_9.localPosition
			end

			local var_249_11 = 0.001

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_11 then
				local var_249_12 = (arg_246_1.time_ - var_249_10) / var_249_11
				local var_249_13 = Vector3.New(-0.7, -1, -6)

				var_249_9.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1069ui_story, var_249_13, var_249_12)

				local var_249_14 = manager.ui.mainCamera.transform.position - var_249_9.position

				var_249_9.forward = Vector3.New(var_249_14.x, var_249_14.y, var_249_14.z)

				local var_249_15 = var_249_9.localEulerAngles

				var_249_15.z = 0
				var_249_15.x = 0
				var_249_9.localEulerAngles = var_249_15
			end

			if arg_246_1.time_ >= var_249_10 + var_249_11 and arg_246_1.time_ < var_249_10 + var_249_11 + arg_249_0 then
				var_249_9.localPosition = Vector3.New(-0.7, -1, -6)

				local var_249_16 = manager.ui.mainCamera.transform.position - var_249_9.position

				var_249_9.forward = Vector3.New(var_249_16.x, var_249_16.y, var_249_16.z)

				local var_249_17 = var_249_9.localEulerAngles

				var_249_17.z = 0
				var_249_17.x = 0
				var_249_9.localEulerAngles = var_249_17
			end

			local var_249_18 = arg_246_1.actors_["1069ui_story"]
			local var_249_19 = 0

			if var_249_19 < arg_246_1.time_ and arg_246_1.time_ <= var_249_19 + arg_249_0 and not isNil(var_249_18) and arg_246_1.var_.characterEffect1069ui_story == nil then
				arg_246_1.var_.characterEffect1069ui_story = var_249_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_20 = 0.2

			if var_249_19 <= arg_246_1.time_ and arg_246_1.time_ < var_249_19 + var_249_20 and not isNil(var_249_18) then
				local var_249_21 = (arg_246_1.time_ - var_249_19) / var_249_20

				if arg_246_1.var_.characterEffect1069ui_story and not isNil(var_249_18) then
					arg_246_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= var_249_19 + var_249_20 and arg_246_1.time_ < var_249_19 + var_249_20 + arg_249_0 and not isNil(var_249_18) and arg_246_1.var_.characterEffect1069ui_story then
				arg_246_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_249_22 = arg_246_1.actors_["1084ui_story"].transform
			local var_249_23 = 0

			if var_249_23 < arg_246_1.time_ and arg_246_1.time_ <= var_249_23 + arg_249_0 then
				arg_246_1.var_.moveOldPos1084ui_story = var_249_22.localPosition
			end

			local var_249_24 = 0.001

			if var_249_23 <= arg_246_1.time_ and arg_246_1.time_ < var_249_23 + var_249_24 then
				local var_249_25 = (arg_246_1.time_ - var_249_23) / var_249_24
				local var_249_26 = Vector3.New(0.7, -0.97, -6)

				var_249_22.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1084ui_story, var_249_26, var_249_25)

				local var_249_27 = manager.ui.mainCamera.transform.position - var_249_22.position

				var_249_22.forward = Vector3.New(var_249_27.x, var_249_27.y, var_249_27.z)

				local var_249_28 = var_249_22.localEulerAngles

				var_249_28.z = 0
				var_249_28.x = 0
				var_249_22.localEulerAngles = var_249_28
			end

			if arg_246_1.time_ >= var_249_23 + var_249_24 and arg_246_1.time_ < var_249_23 + var_249_24 + arg_249_0 then
				var_249_22.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_249_29 = manager.ui.mainCamera.transform.position - var_249_22.position

				var_249_22.forward = Vector3.New(var_249_29.x, var_249_29.y, var_249_29.z)

				local var_249_30 = var_249_22.localEulerAngles

				var_249_30.z = 0
				var_249_30.x = 0
				var_249_22.localEulerAngles = var_249_30
			end

			local var_249_31 = arg_246_1.actors_["1084ui_story"]
			local var_249_32 = 0

			if var_249_32 < arg_246_1.time_ and arg_246_1.time_ <= var_249_32 + arg_249_0 and not isNil(var_249_31) and arg_246_1.var_.characterEffect1084ui_story == nil then
				arg_246_1.var_.characterEffect1084ui_story = var_249_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_33 = 0.2

			if var_249_32 <= arg_246_1.time_ and arg_246_1.time_ < var_249_32 + var_249_33 and not isNil(var_249_31) then
				local var_249_34 = (arg_246_1.time_ - var_249_32) / var_249_33

				if arg_246_1.var_.characterEffect1084ui_story and not isNil(var_249_31) then
					local var_249_35 = Mathf.Lerp(0, 0.5, var_249_34)

					arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1084ui_story.fillRatio = var_249_35
				end
			end

			if arg_246_1.time_ >= var_249_32 + var_249_33 and arg_246_1.time_ < var_249_32 + var_249_33 + arg_249_0 and not isNil(var_249_31) and arg_246_1.var_.characterEffect1084ui_story then
				local var_249_36 = 0.5

				arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1084ui_story.fillRatio = var_249_36
			end

			local var_249_37 = 0

			if var_249_37 < arg_246_1.time_ and arg_246_1.time_ <= var_249_37 + arg_249_0 then
				arg_246_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action1_1")
			end

			local var_249_38 = 0

			if var_249_38 < arg_246_1.time_ and arg_246_1.time_ <= var_249_38 + arg_249_0 then
				arg_246_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_249_39 = 0
			local var_249_40 = 0.25

			if var_249_39 < arg_246_1.time_ and arg_246_1.time_ <= var_249_39 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_41 = arg_246_1:FormatText(StoryNameCfg[378].name)

				arg_246_1.leftNameTxt_.text = var_249_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_42 = arg_246_1:GetWordFromCfg(120031060)
				local var_249_43 = arg_246_1:FormatText(var_249_42.content)

				arg_246_1.text_.text = var_249_43

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_44 = 10
				local var_249_45 = utf8.len(var_249_43)
				local var_249_46 = var_249_44 <= 0 and var_249_40 or var_249_40 * (var_249_45 / var_249_44)

				if var_249_46 > 0 and var_249_40 < var_249_46 then
					arg_246_1.talkMaxDuration = var_249_46

					if var_249_46 + var_249_39 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_46 + var_249_39
					end
				end

				arg_246_1.text_.text = var_249_43
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031060", "story_v_out_120031.awb") ~= 0 then
					local var_249_47 = manager.audio:GetVoiceLength("story_v_out_120031", "120031060", "story_v_out_120031.awb") / 1000

					if var_249_47 + var_249_39 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_47 + var_249_39
					end

					if var_249_42.prefab_name ~= "" and arg_246_1.actors_[var_249_42.prefab_name] ~= nil then
						local var_249_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_42.prefab_name].transform, "story_v_out_120031", "120031060", "story_v_out_120031.awb")

						arg_246_1:RecordAudio("120031060", var_249_48)
						arg_246_1:RecordAudio("120031060", var_249_48)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_120031", "120031060", "story_v_out_120031.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_120031", "120031060", "story_v_out_120031.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_49 = math.max(var_249_40, arg_246_1.talkMaxDuration)

			if var_249_39 <= arg_246_1.time_ and arg_246_1.time_ < var_249_39 + var_249_49 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_39) / var_249_49

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_39 + var_249_49 and arg_246_1.time_ < var_249_39 + var_249_49 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play120031061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 120031061
		arg_250_1.duration_ = 4.07

		local var_250_0 = {
			zh = 2.966,
			ja = 4.066
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play120031062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = arg_250_1.actors_["1069ui_story"]
			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1069ui_story == nil then
				arg_250_1.var_.characterEffect1069ui_story = var_253_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.2

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_2 and not isNil(var_253_0) then
				local var_253_3 = (arg_250_1.time_ - var_253_1) / var_253_2

				if arg_250_1.var_.characterEffect1069ui_story and not isNil(var_253_0) then
					local var_253_4 = Mathf.Lerp(0, 0.5, var_253_3)

					arg_250_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_250_1.var_.characterEffect1069ui_story.fillRatio = var_253_4
				end
			end

			if arg_250_1.time_ >= var_253_1 + var_253_2 and arg_250_1.time_ < var_253_1 + var_253_2 + arg_253_0 and not isNil(var_253_0) and arg_250_1.var_.characterEffect1069ui_story then
				local var_253_5 = 0.5

				arg_250_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_250_1.var_.characterEffect1069ui_story.fillRatio = var_253_5
			end

			local var_253_6 = arg_250_1.actors_["1084ui_story"]
			local var_253_7 = 0

			if var_253_7 < arg_250_1.time_ and arg_250_1.time_ <= var_253_7 + arg_253_0 and not isNil(var_253_6) and arg_250_1.var_.characterEffect1084ui_story == nil then
				arg_250_1.var_.characterEffect1084ui_story = var_253_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_8 = 0.2

			if var_253_7 <= arg_250_1.time_ and arg_250_1.time_ < var_253_7 + var_253_8 and not isNil(var_253_6) then
				local var_253_9 = (arg_250_1.time_ - var_253_7) / var_253_8

				if arg_250_1.var_.characterEffect1084ui_story and not isNil(var_253_6) then
					arg_250_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_7 + var_253_8 and arg_250_1.time_ < var_253_7 + var_253_8 + arg_253_0 and not isNil(var_253_6) and arg_250_1.var_.characterEffect1084ui_story then
				arg_250_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_253_10 = 0

			if var_253_10 < arg_250_1.time_ and arg_250_1.time_ <= var_253_10 + arg_253_0 then
				arg_250_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_253_11 = 0

			if var_253_11 < arg_250_1.time_ and arg_250_1.time_ <= var_253_11 + arg_253_0 then
				arg_250_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_253_12 = 0
			local var_253_13 = 0.425

			if var_253_12 < arg_250_1.time_ and arg_250_1.time_ <= var_253_12 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_14 = arg_250_1:FormatText(StoryNameCfg[6].name)

				arg_250_1.leftNameTxt_.text = var_253_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_15 = arg_250_1:GetWordFromCfg(120031061)
				local var_253_16 = arg_250_1:FormatText(var_253_15.content)

				arg_250_1.text_.text = var_253_16

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_17 = 17
				local var_253_18 = utf8.len(var_253_16)
				local var_253_19 = var_253_17 <= 0 and var_253_13 or var_253_13 * (var_253_18 / var_253_17)

				if var_253_19 > 0 and var_253_13 < var_253_19 then
					arg_250_1.talkMaxDuration = var_253_19

					if var_253_19 + var_253_12 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_19 + var_253_12
					end
				end

				arg_250_1.text_.text = var_253_16
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031061", "story_v_out_120031.awb") ~= 0 then
					local var_253_20 = manager.audio:GetVoiceLength("story_v_out_120031", "120031061", "story_v_out_120031.awb") / 1000

					if var_253_20 + var_253_12 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_20 + var_253_12
					end

					if var_253_15.prefab_name ~= "" and arg_250_1.actors_[var_253_15.prefab_name] ~= nil then
						local var_253_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_15.prefab_name].transform, "story_v_out_120031", "120031061", "story_v_out_120031.awb")

						arg_250_1:RecordAudio("120031061", var_253_21)
						arg_250_1:RecordAudio("120031061", var_253_21)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_120031", "120031061", "story_v_out_120031.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_120031", "120031061", "story_v_out_120031.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_22 = math.max(var_253_13, arg_250_1.talkMaxDuration)

			if var_253_12 <= arg_250_1.time_ and arg_250_1.time_ < var_253_12 + var_253_22 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_12) / var_253_22

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_12 + var_253_22 and arg_250_1.time_ < var_253_12 + var_253_22 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play120031062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 120031062
		arg_254_1.duration_ = 7.07

		local var_254_0 = {
			zh = 5.266,
			ja = 7.066
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
				arg_254_0:Play120031063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["1069ui_story"]
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1069ui_story == nil then
				arg_254_1.var_.characterEffect1069ui_story = var_257_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.2

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 and not isNil(var_257_0) then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2

				if arg_254_1.var_.characterEffect1069ui_story and not isNil(var_257_0) then
					arg_254_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 and not isNil(var_257_0) and arg_254_1.var_.characterEffect1069ui_story then
				arg_254_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_257_4 = arg_254_1.actors_["1084ui_story"]
			local var_257_5 = 0

			if var_257_5 < arg_254_1.time_ and arg_254_1.time_ <= var_257_5 + arg_257_0 and not isNil(var_257_4) and arg_254_1.var_.characterEffect1084ui_story == nil then
				arg_254_1.var_.characterEffect1084ui_story = var_257_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_6 = 0.2

			if var_257_5 <= arg_254_1.time_ and arg_254_1.time_ < var_257_5 + var_257_6 and not isNil(var_257_4) then
				local var_257_7 = (arg_254_1.time_ - var_257_5) / var_257_6

				if arg_254_1.var_.characterEffect1084ui_story and not isNil(var_257_4) then
					local var_257_8 = Mathf.Lerp(0, 0.5, var_257_7)

					arg_254_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_254_1.var_.characterEffect1084ui_story.fillRatio = var_257_8
				end
			end

			if arg_254_1.time_ >= var_257_5 + var_257_6 and arg_254_1.time_ < var_257_5 + var_257_6 + arg_257_0 and not isNil(var_257_4) and arg_254_1.var_.characterEffect1084ui_story then
				local var_257_9 = 0.5

				arg_254_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_254_1.var_.characterEffect1084ui_story.fillRatio = var_257_9
			end

			local var_257_10 = 0

			if var_257_10 < arg_254_1.time_ and arg_254_1.time_ <= var_257_10 + arg_257_0 then
				arg_254_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/story1069/story1069action/1069action4_1")
			end

			local var_257_11 = 0

			if var_257_11 < arg_254_1.time_ and arg_254_1.time_ <= var_257_11 + arg_257_0 then
				arg_254_1:PlayTimeline("1069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_257_12 = 0
			local var_257_13 = 0.6

			if var_257_12 < arg_254_1.time_ and arg_254_1.time_ <= var_257_12 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				local var_257_14 = arg_254_1:FormatText(StoryNameCfg[378].name)

				arg_254_1.leftNameTxt_.text = var_257_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_15 = arg_254_1:GetWordFromCfg(120031062)
				local var_257_16 = arg_254_1:FormatText(var_257_15.content)

				arg_254_1.text_.text = var_257_16

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_17 = 24
				local var_257_18 = utf8.len(var_257_16)
				local var_257_19 = var_257_17 <= 0 and var_257_13 or var_257_13 * (var_257_18 / var_257_17)

				if var_257_19 > 0 and var_257_13 < var_257_19 then
					arg_254_1.talkMaxDuration = var_257_19

					if var_257_19 + var_257_12 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_19 + var_257_12
					end
				end

				arg_254_1.text_.text = var_257_16
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031062", "story_v_out_120031.awb") ~= 0 then
					local var_257_20 = manager.audio:GetVoiceLength("story_v_out_120031", "120031062", "story_v_out_120031.awb") / 1000

					if var_257_20 + var_257_12 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_20 + var_257_12
					end

					if var_257_15.prefab_name ~= "" and arg_254_1.actors_[var_257_15.prefab_name] ~= nil then
						local var_257_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_15.prefab_name].transform, "story_v_out_120031", "120031062", "story_v_out_120031.awb")

						arg_254_1:RecordAudio("120031062", var_257_21)
						arg_254_1:RecordAudio("120031062", var_257_21)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_120031", "120031062", "story_v_out_120031.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_120031", "120031062", "story_v_out_120031.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_22 = math.max(var_257_13, arg_254_1.talkMaxDuration)

			if var_257_12 <= arg_254_1.time_ and arg_254_1.time_ < var_257_12 + var_257_22 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_12) / var_257_22

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_12 + var_257_22 and arg_254_1.time_ < var_257_12 + var_257_22 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play120031063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 120031063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play120031064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = arg_258_1.actors_["1069ui_story"].transform
			local var_261_1 = 0

			if var_261_1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_1 + arg_261_0 then
				arg_258_1.var_.moveOldPos1069ui_story = var_261_0.localPosition
			end

			local var_261_2 = 0.001

			if var_261_1 <= arg_258_1.time_ and arg_258_1.time_ < var_261_1 + var_261_2 then
				local var_261_3 = (arg_258_1.time_ - var_261_1) / var_261_2
				local var_261_4 = Vector3.New(0, 100, 0)

				var_261_0.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1069ui_story, var_261_4, var_261_3)

				local var_261_5 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_5.x, var_261_5.y, var_261_5.z)

				local var_261_6 = var_261_0.localEulerAngles

				var_261_6.z = 0
				var_261_6.x = 0
				var_261_0.localEulerAngles = var_261_6
			end

			if arg_258_1.time_ >= var_261_1 + var_261_2 and arg_258_1.time_ < var_261_1 + var_261_2 + arg_261_0 then
				var_261_0.localPosition = Vector3.New(0, 100, 0)

				local var_261_7 = manager.ui.mainCamera.transform.position - var_261_0.position

				var_261_0.forward = Vector3.New(var_261_7.x, var_261_7.y, var_261_7.z)

				local var_261_8 = var_261_0.localEulerAngles

				var_261_8.z = 0
				var_261_8.x = 0
				var_261_0.localEulerAngles = var_261_8
			end

			local var_261_9 = arg_258_1.actors_["1084ui_story"].transform
			local var_261_10 = 0

			if var_261_10 < arg_258_1.time_ and arg_258_1.time_ <= var_261_10 + arg_261_0 then
				arg_258_1.var_.moveOldPos1084ui_story = var_261_9.localPosition
			end

			local var_261_11 = 0.001

			if var_261_10 <= arg_258_1.time_ and arg_258_1.time_ < var_261_10 + var_261_11 then
				local var_261_12 = (arg_258_1.time_ - var_261_10) / var_261_11
				local var_261_13 = Vector3.New(0, 100, 0)

				var_261_9.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1084ui_story, var_261_13, var_261_12)

				local var_261_14 = manager.ui.mainCamera.transform.position - var_261_9.position

				var_261_9.forward = Vector3.New(var_261_14.x, var_261_14.y, var_261_14.z)

				local var_261_15 = var_261_9.localEulerAngles

				var_261_15.z = 0
				var_261_15.x = 0
				var_261_9.localEulerAngles = var_261_15
			end

			if arg_258_1.time_ >= var_261_10 + var_261_11 and arg_258_1.time_ < var_261_10 + var_261_11 + arg_261_0 then
				var_261_9.localPosition = Vector3.New(0, 100, 0)

				local var_261_16 = manager.ui.mainCamera.transform.position - var_261_9.position

				var_261_9.forward = Vector3.New(var_261_16.x, var_261_16.y, var_261_16.z)

				local var_261_17 = var_261_9.localEulerAngles

				var_261_17.z = 0
				var_261_17.x = 0
				var_261_9.localEulerAngles = var_261_17
			end

			local var_261_18 = 0
			local var_261_19 = 0.8

			if var_261_18 < arg_258_1.time_ and arg_258_1.time_ <= var_261_18 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_20 = arg_258_1:GetWordFromCfg(120031063)
				local var_261_21 = arg_258_1:FormatText(var_261_20.content)

				arg_258_1.text_.text = var_261_21

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_22 = 32
				local var_261_23 = utf8.len(var_261_21)
				local var_261_24 = var_261_22 <= 0 and var_261_19 or var_261_19 * (var_261_23 / var_261_22)

				if var_261_24 > 0 and var_261_19 < var_261_24 then
					arg_258_1.talkMaxDuration = var_261_24

					if var_261_24 + var_261_18 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_24 + var_261_18
					end
				end

				arg_258_1.text_.text = var_261_21
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_25 = math.max(var_261_19, arg_258_1.talkMaxDuration)

			if var_261_18 <= arg_258_1.time_ and arg_258_1.time_ < var_261_18 + var_261_25 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_18) / var_261_25

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_18 + var_261_25 and arg_258_1.time_ < var_261_18 + var_261_25 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play120031064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 120031064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play120031065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 0.375

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[7].name)

				arg_262_1.leftNameTxt_.text = var_265_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_3 = arg_262_1:GetWordFromCfg(120031064)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 15
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
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_8 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_8 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_8

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_8 and arg_262_1.time_ < var_265_0 + var_265_8 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play120031065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 120031065
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play120031066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 1

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				local var_269_2 = "play"
				local var_269_3 = "effect"

				arg_266_1:AudioAction(var_269_2, var_269_3, "se_story_120_00", "se_story_120_machinehitch", "")
			end

			local var_269_4 = 0
			local var_269_5 = 0.175

			if var_269_4 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_6 = arg_266_1:FormatText(StoryNameCfg[29].name)

				arg_266_1.leftNameTxt_.text = var_269_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2088")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_7 = arg_266_1:GetWordFromCfg(120031065)
				local var_269_8 = arg_266_1:FormatText(var_269_7.content)

				arg_266_1.text_.text = var_269_8

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 7
				local var_269_10 = utf8.len(var_269_8)
				local var_269_11 = var_269_9 <= 0 and var_269_5 or var_269_5 * (var_269_10 / var_269_9)

				if var_269_11 > 0 and var_269_5 < var_269_11 then
					arg_266_1.talkMaxDuration = var_269_11

					if var_269_11 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_11 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_8
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_12 and arg_266_1.time_ < var_269_4 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play120031066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 120031066
		arg_270_1.duration_ = 12.07

		local var_270_0 = {
			zh = 10.266,
			ja = 12.066
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play120031067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = arg_270_1.actors_["10044ui_story"].transform
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.var_.moveOldPos10044ui_story = var_273_0.localPosition
			end

			local var_273_2 = 0.001

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_2 then
				local var_273_3 = (arg_270_1.time_ - var_273_1) / var_273_2
				local var_273_4 = Vector3.New(0, -0.72, -6.3)

				var_273_0.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10044ui_story, var_273_4, var_273_3)

				local var_273_5 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_5.x, var_273_5.y, var_273_5.z)

				local var_273_6 = var_273_0.localEulerAngles

				var_273_6.z = 0
				var_273_6.x = 0
				var_273_0.localEulerAngles = var_273_6
			end

			if arg_270_1.time_ >= var_273_1 + var_273_2 and arg_270_1.time_ < var_273_1 + var_273_2 + arg_273_0 then
				var_273_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_273_7 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_7.x, var_273_7.y, var_273_7.z)

				local var_273_8 = var_273_0.localEulerAngles

				var_273_8.z = 0
				var_273_8.x = 0
				var_273_0.localEulerAngles = var_273_8
			end

			local var_273_9 = arg_270_1.actors_["10044ui_story"]
			local var_273_10 = 0

			if var_273_10 < arg_270_1.time_ and arg_270_1.time_ <= var_273_10 + arg_273_0 and not isNil(var_273_9) and arg_270_1.var_.characterEffect10044ui_story == nil then
				arg_270_1.var_.characterEffect10044ui_story = var_273_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_11 = 0.2

			if var_273_10 <= arg_270_1.time_ and arg_270_1.time_ < var_273_10 + var_273_11 and not isNil(var_273_9) then
				local var_273_12 = (arg_270_1.time_ - var_273_10) / var_273_11

				if arg_270_1.var_.characterEffect10044ui_story and not isNil(var_273_9) then
					arg_270_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_10 + var_273_11 and arg_270_1.time_ < var_273_10 + var_273_11 + arg_273_0 and not isNil(var_273_9) and arg_270_1.var_.characterEffect10044ui_story then
				arg_270_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_273_13 = 0

			if var_273_13 < arg_270_1.time_ and arg_270_1.time_ <= var_273_13 + arg_273_0 then
				arg_270_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_273_14 = 0

			if var_273_14 < arg_270_1.time_ and arg_270_1.time_ <= var_273_14 + arg_273_0 then
				arg_270_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_273_15 = 0
			local var_273_16 = 1.35

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_17 = arg_270_1:FormatText(StoryNameCfg[380].name)

				arg_270_1.leftNameTxt_.text = var_273_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_18 = arg_270_1:GetWordFromCfg(120031066)
				local var_273_19 = arg_270_1:FormatText(var_273_18.content)

				arg_270_1.text_.text = var_273_19

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_20 = 53
				local var_273_21 = utf8.len(var_273_19)
				local var_273_22 = var_273_20 <= 0 and var_273_16 or var_273_16 * (var_273_21 / var_273_20)

				if var_273_22 > 0 and var_273_16 < var_273_22 then
					arg_270_1.talkMaxDuration = var_273_22

					if var_273_22 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_22 + var_273_15
					end
				end

				arg_270_1.text_.text = var_273_19
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031066", "story_v_out_120031.awb") ~= 0 then
					local var_273_23 = manager.audio:GetVoiceLength("story_v_out_120031", "120031066", "story_v_out_120031.awb") / 1000

					if var_273_23 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_23 + var_273_15
					end

					if var_273_18.prefab_name ~= "" and arg_270_1.actors_[var_273_18.prefab_name] ~= nil then
						local var_273_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_18.prefab_name].transform, "story_v_out_120031", "120031066", "story_v_out_120031.awb")

						arg_270_1:RecordAudio("120031066", var_273_24)
						arg_270_1:RecordAudio("120031066", var_273_24)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_120031", "120031066", "story_v_out_120031.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_120031", "120031066", "story_v_out_120031.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_25 = math.max(var_273_16, arg_270_1.talkMaxDuration)

			if var_273_15 <= arg_270_1.time_ and arg_270_1.time_ < var_273_15 + var_273_25 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_15) / var_273_25

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_15 + var_273_25 and arg_270_1.time_ < var_273_15 + var_273_25 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play120031067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 120031067
		arg_274_1.duration_ = 8.03

		local var_274_0 = {
			zh = 8.033,
			ja = 6
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play120031068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["10044ui_story"]
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect10044ui_story == nil then
				arg_274_1.var_.characterEffect10044ui_story = var_277_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_2 = 0.2

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 and not isNil(var_277_0) then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2

				if arg_274_1.var_.characterEffect10044ui_story and not isNil(var_277_0) then
					arg_274_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 and not isNil(var_277_0) and arg_274_1.var_.characterEffect10044ui_story then
				arg_274_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_277_4 = 0

			if var_277_4 < arg_274_1.time_ and arg_274_1.time_ <= var_277_4 + arg_277_0 then
				arg_274_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action5_1")
			end

			local var_277_5 = 0

			if var_277_5 < arg_274_1.time_ and arg_274_1.time_ <= var_277_5 + arg_277_0 then
				arg_274_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_277_6 = 0
			local var_277_7 = 0.8

			if var_277_6 < arg_274_1.time_ and arg_274_1.time_ <= var_277_6 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_8 = arg_274_1:FormatText(StoryNameCfg[380].name)

				arg_274_1.leftNameTxt_.text = var_277_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_9 = arg_274_1:GetWordFromCfg(120031067)
				local var_277_10 = arg_274_1:FormatText(var_277_9.content)

				arg_274_1.text_.text = var_277_10

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_11 = 32
				local var_277_12 = utf8.len(var_277_10)
				local var_277_13 = var_277_11 <= 0 and var_277_7 or var_277_7 * (var_277_12 / var_277_11)

				if var_277_13 > 0 and var_277_7 < var_277_13 then
					arg_274_1.talkMaxDuration = var_277_13

					if var_277_13 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_13 + var_277_6
					end
				end

				arg_274_1.text_.text = var_277_10
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120031", "120031067", "story_v_out_120031.awb") ~= 0 then
					local var_277_14 = manager.audio:GetVoiceLength("story_v_out_120031", "120031067", "story_v_out_120031.awb") / 1000

					if var_277_14 + var_277_6 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_14 + var_277_6
					end

					if var_277_9.prefab_name ~= "" and arg_274_1.actors_[var_277_9.prefab_name] ~= nil then
						local var_277_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_9.prefab_name].transform, "story_v_out_120031", "120031067", "story_v_out_120031.awb")

						arg_274_1:RecordAudio("120031067", var_277_15)
						arg_274_1:RecordAudio("120031067", var_277_15)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_120031", "120031067", "story_v_out_120031.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_120031", "120031067", "story_v_out_120031.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_16 = math.max(var_277_7, arg_274_1.talkMaxDuration)

			if var_277_6 <= arg_274_1.time_ and arg_274_1.time_ < var_277_6 + var_277_16 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_6) / var_277_16

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_6 + var_277_16 and arg_274_1.time_ < var_277_6 + var_277_16 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play120031068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 120031068
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play120031069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = arg_278_1.actors_["10044ui_story"].transform
			local var_281_1 = 0

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.var_.moveOldPos10044ui_story = var_281_0.localPosition
			end

			local var_281_2 = 0.001

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_2 then
				local var_281_3 = (arg_278_1.time_ - var_281_1) / var_281_2
				local var_281_4 = Vector3.New(0, 100, 0)

				var_281_0.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10044ui_story, var_281_4, var_281_3)

				local var_281_5 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_5.x, var_281_5.y, var_281_5.z)

				local var_281_6 = var_281_0.localEulerAngles

				var_281_6.z = 0
				var_281_6.x = 0
				var_281_0.localEulerAngles = var_281_6
			end

			if arg_278_1.time_ >= var_281_1 + var_281_2 and arg_278_1.time_ < var_281_1 + var_281_2 + arg_281_0 then
				var_281_0.localPosition = Vector3.New(0, 100, 0)

				local var_281_7 = manager.ui.mainCamera.transform.position - var_281_0.position

				var_281_0.forward = Vector3.New(var_281_7.x, var_281_7.y, var_281_7.z)

				local var_281_8 = var_281_0.localEulerAngles

				var_281_8.z = 0
				var_281_8.x = 0
				var_281_0.localEulerAngles = var_281_8
			end

			local var_281_9 = 0
			local var_281_10 = 0.25

			if var_281_9 < arg_278_1.time_ and arg_278_1.time_ <= var_281_9 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_11 = arg_278_1:FormatText(StoryNameCfg[7].name)

				arg_278_1.leftNameTxt_.text = var_281_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_12 = arg_278_1:GetWordFromCfg(120031068)
				local var_281_13 = arg_278_1:FormatText(var_281_12.content)

				arg_278_1.text_.text = var_281_13

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_14 = 10
				local var_281_15 = utf8.len(var_281_13)
				local var_281_16 = var_281_14 <= 0 and var_281_10 or var_281_10 * (var_281_15 / var_281_14)

				if var_281_16 > 0 and var_281_10 < var_281_16 then
					arg_278_1.talkMaxDuration = var_281_16

					if var_281_16 + var_281_9 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_16 + var_281_9
					end
				end

				arg_278_1.text_.text = var_281_13
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_17 = math.max(var_281_10, arg_278_1.talkMaxDuration)

			if var_281_9 <= arg_278_1.time_ and arg_278_1.time_ < var_281_9 + var_281_17 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_9) / var_281_17

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_9 + var_281_17 and arg_278_1.time_ < var_281_9 + var_281_17 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_278_1:InitPlayNodeList()
	end,
	Play120031069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 120031069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play120031070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 1

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				local var_285_2 = "play"
				local var_285_3 = "effect"

				arg_282_1:AudioAction(var_285_2, var_285_3, "se_story_side_1037", "se_story_1037_electric", "")
			end

			local var_285_4 = 0
			local var_285_5 = 0.2

			if var_285_4 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_6 = arg_282_1:FormatText(StoryNameCfg[29].name)

				arg_282_1.leftNameTxt_.text = var_285_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2088")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_7 = arg_282_1:GetWordFromCfg(120031069)
				local var_285_8 = arg_282_1:FormatText(var_285_7.content)

				arg_282_1.text_.text = var_285_8

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_9 = 8
				local var_285_10 = utf8.len(var_285_8)
				local var_285_11 = var_285_9 <= 0 and var_285_5 or var_285_5 * (var_285_10 / var_285_9)

				if var_285_11 > 0 and var_285_5 < var_285_11 then
					arg_282_1.talkMaxDuration = var_285_11

					if var_285_11 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_11 + var_285_4
					end
				end

				arg_282_1.text_.text = var_285_8
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_12 = math.max(var_285_5, arg_282_1.talkMaxDuration)

			if var_285_4 <= arg_282_1.time_ and arg_282_1.time_ < var_285_4 + var_285_12 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_4) / var_285_12

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_4 + var_285_12 and arg_282_1.time_ < var_285_4 + var_285_12 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play120031070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 120031070
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
			arg_286_1.auto_ = false
		end

		function arg_286_1.playNext_(arg_288_0)
			arg_286_1.onStoryFinished_()
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = manager.ui.mainCamera.transform
			local var_289_1 = 0

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.var_.shakeOldPos = var_289_0.localPosition
			end

			local var_289_2 = 0.6

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_2 then
				local var_289_3 = (arg_286_1.time_ - var_289_1) / 0.066
				local var_289_4, var_289_5 = math.modf(var_289_3)

				var_289_0.localPosition = Vector3.New(var_289_5 * 0.13, var_289_5 * 0.13, var_289_5 * 0.13) + arg_286_1.var_.shakeOldPos
			end

			if arg_286_1.time_ >= var_289_1 + var_289_2 and arg_286_1.time_ < var_289_1 + var_289_2 + arg_289_0 then
				var_289_0.localPosition = arg_286_1.var_.shakeOldPos
			end

			local var_289_6 = 0

			if var_289_6 < arg_286_1.time_ and arg_286_1.time_ <= var_289_6 + arg_289_0 then
				arg_286_1.allBtn_.enabled = false
			end

			local var_289_7 = 0.6

			if arg_286_1.time_ >= var_289_6 + var_289_7 and arg_286_1.time_ < var_289_6 + var_289_7 + arg_289_0 then
				arg_286_1.allBtn_.enabled = true
			end

			local var_289_8 = 0
			local var_289_9 = 0.275

			if var_289_8 < arg_286_1.time_ and arg_286_1.time_ <= var_289_8 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_10 = arg_286_1:FormatText(StoryNameCfg[7].name)

				arg_286_1.leftNameTxt_.text = var_289_10

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

				local var_289_11 = arg_286_1:GetWordFromCfg(120031070)
				local var_289_12 = arg_286_1:FormatText(var_289_11.content)

				arg_286_1.text_.text = var_289_12

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_13 = 11
				local var_289_14 = utf8.len(var_289_12)
				local var_289_15 = var_289_13 <= 0 and var_289_9 or var_289_9 * (var_289_14 / var_289_13)

				if var_289_15 > 0 and var_289_9 < var_289_15 then
					arg_286_1.talkMaxDuration = var_289_15

					if var_289_15 + var_289_8 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_15 + var_289_8
					end
				end

				arg_286_1.text_.text = var_289_12
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_16 = math.max(var_289_9, arg_286_1.talkMaxDuration)

			if var_289_8 <= arg_286_1.time_ and arg_286_1.time_ < var_289_8 + var_289_16 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_8) / var_289_16

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_8 + var_289_16 and arg_286_1.time_ < var_289_8 + var_289_16 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J02f",
		"TextureConfig/Background/J02h"
	},
	voices = {
		"story_v_out_120031.awb"
	}
}
